#
# Part of RedELK
# Script to have logstash insert an extra field pointing to the full TXT file of a Cobalt Strike keystrokes file
#
# Author: Outflank B.V. / Marc Smeets / @mramsmeets
#
# License : BSD3
#



def register(params)
#        @timestamp = params["timestamp"]
#        @source = param["source"]
#	@beacon_id = param["beacon_id"]
end

def filter(event)
    host = event.get("[agent][name]")
    scenario = event.get("attackscenario")
    logpath = event.get("[log][file][path]")
	beacon_id = event.get("beacon_id")
	temppath = logpath.split('/cobaltstrike')
	temppath2 = temppath[1].split(/\/([^\/]*)$/)
	keystrokespath = "/cslogs/" +  "#{scenario}" + "/" + "#{host}" + "#{temppath2[0]}" + "/keystrokes_" + "#{beacon_id}" + ".txt"
	event.tag("_rubyparseok")
    	event.set("keystrokesfull", keystrokespath)
	return [event]
end
