-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddessGloryStageInfoMO.lua

module("logic.extensions.goddessglory.model.GoddessGloryStageInfoMO", package.seeall)

local GoddessGloryStageInfoMO = class("GoddessGloryStageInfoMO")

function GoddessGloryStageInfoMO:ctor()
	self.energy = 0
	self.petIds = nil
	self.eventList = nil
end

return GoddessGloryStageInfoMO
