local eventStart = false
local endTime = nil

function Refresh(_cRoleID)
	cRoleID = _cRoleID
	cRoleData = CRoleMgr:GetData(cRoleID)
	endTime = nil
	eventStart = false
	
	InitEvent()
	EventStart()
end	

function Update()
	if(endTime and Time.time - endTime) then
		endTime = nil
		eventStart = true
		EventStart()
	end
end

function InitEvent()
	e_id, e_story, e_start = cRoleData:GetEvent()
	e_start = e_start ~= nil and e_start or 0
	if(e_id ~= nil) then
		if(TimeUtil:GetTime() >= e_start) then
			eventStart = true
			return
		else
			endTime = Time.time +(e_start - TimeUtil:GetTime())	
		end
	end
end

function EventStart()
	if(eventStart) then
		CSAPI.SetGOActive()
	end
end 