<style>
	/* Style the tab download icon */
	.tabbed-prod-cards .product-card .attachments-list i {
		font-size:130%;
	}

	.tabbed-prod-cards .product-card .attachments-list {
		max-height:320px;
		height:320px;
	}

	.tabbed-prod-cards .tab {
		width:fit-content;
		overflow: hidden;
	}

	/* Style the buttons inside the tab */
	.tabbed-prod-cards .tab button {
		background-color: var(--color-brand-secondary);
		color:white;
		float: left;
		cursor: pointer;
		border: none;
		outline: none;
		padding: 14px 16px;
		font-size: 17px;
		transition: 0.3s;
		border-top-right-radius:10px;
		border-top-left-radius:10px;
	}

	/* Change background color of buttons on hover */
	.tabbed-prod-cards .tab button:hover {
		background-color: #ddd;
	}

	/* Active tablink */
	.tabbed-prod-cards .tab button.active {
		background-color: white;
		color:inherit;
	}

	/* Style the tab content */
	.tabbed-prod-cards .tabcontent {
		display: none;
		padding: 6px 12px;
		border: 1px solid #ccc;
		border-top: none;
		min-height: 280px;
		border-top-left-radius: 0 !important;
    box-shadow: none;
    border: none;
	}
	
	.tabbed-prod-cards .tabcontent .row {
		min-height:280px;
	}
	
	.tabbed-prod-cards .prod-image img {
		display:block;
		margin:auto;
		object-fit:contain;
		width:100%;
		height:auto;
		max-height:320px;
	}

	.tabbed-prod-cards .prod-desc p {
		max-width:min(600px, 40vw);
	}
</style>

<script>
	function openTab(evt, tabName) {
		const targetCPDefId = evt.target.parentElement.getAttribute("productId");
		const productCard = document.getElementById('ProductCard' + targetCPDefId);
		
		if(!productCard) return false;
		
		var i, tabcontent, tablinks;
		tabcontent = productCard.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		tablinks = productCard.getElementsByClassName("tablinks");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className.replace(" active", "");
		}
		document.getElementById(tabName).style.display = "block";
		evt.currentTarget.className += " active";
	}	
</script>

<#if entries?has_content>
	<div class="tabbed-prod-cards">
	<#list entries as cpCatalogEntry>
		<#assign
			cpDefinitionId = cpCatalogEntry.getCPDefinitionId()
			productName = cpCatalogEntry.getName()
			productShortDescription = cpCatalogEntry.getShortDescription()
			productDescription = cpCatalogEntry.getDescription()
			friendlyURL = cpContentHelper.getFriendlyURL(cpCatalogEntry, themeDisplay)
			defaultImageURL = cpContentHelper.getDefaultImageFileURL(0, cpDefinitionId)			
			
			productTabId = "ProductTab${cpDefinitionId}"
			documentTabId = "DocumentTab${cpDefinitionId}"
		/>
		<div id="ProductCard${cpDefinitionId}" class="product-card" onload="testFunction()">
			<div class="tab" productId="${cpDefinitionId}">
				<button class="tablinks active" onclick="openTab(event, '${productTabId}')">Product Information</button>
				<button class="tablinks ml-1" onclick="openTab(event, '${documentTabId}')">Product Documents</button>
			</div>
			
			<div id="${productTabId}" class="tabcontent card" style="display:block">
				<div class="row">
					<div class="prod-image col-12 col-lg-4">
						<a href="${friendlyURL}"><img src="${defaultImageURL}" /></a>
					</div>
					<div class="prod-desc col-12 col-lg-8 d-flex flex-row align-items-center justify-content-start pr-4">
						<div>
							<a href="${friendlyURL}"><h3>${productName}</h3></a>
							<p>${productShortDescription}</p>
						</div>
					</div>
				</div>
			</div>

			<div id="${documentTabId}" class="tabcontent card">
				<#assign 
					mediasList = cpContentHelper.getCPMedias(cpDefinitionId, themeDisplay)	 
				/>
				
				<#assign sortedMediasList = [] />
				<#list mediasList as aMedia>
					<#assign sortedMediasList = sortedMediasList + [{"name":aMedia.getTitle(), "media": aMedia}] />
				</#list>
				
				<div class="attachments-list pl-4 d-flex flex-column align-items-start justify-content-center">					
					<#list sortedMediasList?sort_by("name") as aMedia>
						<div class="mb-2">
							${aMedia.name} <a href="${aMedia.media.getURL()}" target="_blank"><i class="fa-solid fa-cloud-arrow-down"></i></a>
						</div>
					</#list>
				</div>
			</div>
		</div>
	</#list>
	</div>
</#if>