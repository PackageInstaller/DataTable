-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/model/WTowerLevelInfo.lua

module("logic.extensions.warriortower.model.WTowerLevelInfo", package.seeall)

local WTowerLevelInfo = class("WTowerLevelInfo")

function WTowerLevelInfo:ctor()
	self._id = 1
	self._faceId = 1
	self._state = 1
	self._power = 1
end

return WTowerLevelInfo
