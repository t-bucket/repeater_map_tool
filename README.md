# repeater_map_tool
Compare KML GPS track to a repeater database from repeater book and builds a cvs of repeaters along your route.  I am using this on OSX but I would expect it to work in linux.

This is a very rough script that takes a csv I downloaded form repeaterbook (full state).  Then takes a KML file track (I use mymaps.google.com) then filters out any repeaters within X miles of tha track.  I separated the wide area repeaters from normal repeaters.

I'm sure this can be far more efficient and not jump from language to language, but it is brute force.

requires gpsbabel

Currently I filter our digital modes but can change the grep command to include any of those you may want.

Please feel free to clean this up to improve usability and cross platform performance.

I currently have it set up to create chirp and RTSystems compatible csv files for import into those tool.

Also can output csv of repeater locations and lat/lon so you can overlay on your map to review.

For chirp it can add the Weather Stations for use in Baofeng radios

Additionally I include the national calling frequencies

To get the input csv files log into repeaterbook.com (must have a free account and login)
->select North American Repeaters -> select state -> select band -> select export and csv. 


