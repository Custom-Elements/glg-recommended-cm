#glg-nectar
This element provides access to GLG's nectar search service, listening for the specified 
event and retrieving data from the configured indexes. Use it to wrap a particular element 
that you'd like to trigger data retrieval.



##Attributes and Change Handlers
####trigger
The name of the event that the element will listen for to trigger data retrieval. 
This event currently needs to expose a `value` property on the event details that's sent along as the query
####entities
The nectar entities/indexes to load data from.  Can either be an array or a string.
####urls
The urls to the server, can be either a single or array of urls if client-side load balancing is needed.








##Methods
####loadResults
This method should only ever really be called by event handling specified by the `trigger` attribute. 






















