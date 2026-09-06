-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddessGloryRankMO.lua

module("logic.extensions.goddessglory.model.GoddessGloryRankMO", package.seeall)

local GoddessGloryRankMO = class("GoddessGloryRankMO")

function GoddessGloryRankMO:ctor()
	self.lastGetDataTime = 0
	self.myRank = 0
	self.rankSize = 0
	self.rankList = nil
end

return GoddessGloryRankMO
