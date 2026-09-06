-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/model/ClearStarGameModel.lua

module("logic.extensions.clearstargame.model.ClearStarGameModel", package.seeall)

local ClearStarGameModel = class("ClearStarGameModel", BaseModel)

function ClearStarGameModel:onInit()
	self:onReset()
end

function ClearStarGameModel:onReset()
	self._baseInfoList = {}
	self._lastServerKey = 0
	self._lastClientKey = 0
	self._islandLevelMaps = {}
end

function ClearStarGameModel:saveServeKey(key)
	self._lastServerKey = key
end

function ClearStarGameModel:saveClientKey(key)
	self._lastClientKey = key
end

function ClearStarGameModel:getServeKey()
	return self._lastServerKey
end

function ClearStarGameModel:getClientKey()
	return self._lastClientKey
end

function ClearStarGameModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoList[info.activityId] = info
end

function ClearStarGameModel:onEndGame(msg)
	return
end

function ClearStarGameModel:getInfo(activityId)
	return self._baseInfoList[activityId]
end

ClearStarGameModel.instance = ClearStarGameModel.New()

return ClearStarGameModel
