-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/model/MusicGameModel.lua

module("logic.extensions.musicgame.model.MusicGameModel", package.seeall)

local MusicGameModel = class("MusicGameModel", BaseModel)

function MusicGameModel:ctor()
	return
end

function MusicGameModel:onInit()
	self:onReset()
end

function MusicGameModel:onReset()
	self._moPool = {}
	self._gameMgrPool = {}
end

function MusicGameModel:getMusicGameMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = MusicGameMo.New(activityId)
	end

	return self._moPool[activityId]
end

function MusicGameModel:getGameMgr(stageId)
	if self._gameMgrPool[stageId] == nil then
		self._gameMgrPool[stageId] = MusicGameMgr.New(stageId)
	end

	return self._gameMgrPool[stageId]
end

MusicGameModel.instance = MusicGameModel.New()

return MusicGameModel
