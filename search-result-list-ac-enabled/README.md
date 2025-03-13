<p>Liferay Asset Widgets (such as Documents and Media) will send Analytics Cloud (AC) events for tracking when a user previews, downloads or performs other actions that are tracked by AC.</p> 
  
<p>However, events are not sent by OOTB ADTs for certain Widgets such as the Search Results ADTs. By adding AC specific attributes to HTML components within ADTs, we can add the event tracking behavior. For example to track documentDownloaded for a download button, these attributes were added to a wrapping 'span' element</p>

<i><p>&nbsp; data-analytics-asset-action="download"<br />
&nbsp; data-analytics-asset-id="${entry.getClassPK()}"<br />
&nbsp; data-analytics-asset-title="${entry.getHighlightedTitle()}"<br />
&nbsp; data-analytics-asset-type="document"</p></i>

<p>Using this ADT for (General, not Commerce) Search Results, when users downloads a document from the list, we'll be able to see that event in Analytics Cloud.&nbsp;</p>
