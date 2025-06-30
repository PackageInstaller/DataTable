-- chunkname: @IQIGame\\Net\\NetGhostGameResponse.lua

function net_activity.startGhostGameResult()
	GhostGameModule.StartGhostGameResult()
end

function net_activity.endGhostGameResult(code, shows)
	GhostGameModule.EndGhostGameResult(shows)
end
