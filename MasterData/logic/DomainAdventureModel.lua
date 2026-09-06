-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/model/DomainAdventureModel.lua

module("logic.extensions.domainadventure.model.DomainAdventureModel", package.seeall)

local DomainAdventureModel = class("DomainAdventureModel", BaseModel)

function DomainAdventureModel:ctor()
	return
end

function DomainAdventureModel:onInit()
	self:onReset()
end

function DomainAdventureModel:onReset()
	self._moPool = {}
	self._activityIdDic = {}
	self._customFmtMo = nil
	self._systemPetFmtMo = nil
	self._bossCustomFmtMo = nil
end

function DomainAdventureModel:getDomAdvMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = DomAdvMo.New(activityId)
	end

	return self._moPool[activityId]
end

function DomainAdventureModel:getDomAdvCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = DomAdvFightCustomFmtMo.New()
	end

	return self._customFmtMo
end

function DomainAdventureModel:getDomAdvSystemCustomFmtMo()
	if self._systemPetFmtMo == nil then
		self._systemPetFmtMo = DomAdvSystemCustomFmtMo.New()
	end

	return self._systemPetFmtMo
end

function DomainAdventureModel:getDomAdvBossCustomFmtMo()
	if self._bossCustomFmtMo == nil then
		self._bossCustomFmtMo = DomAdvBossCustomFmtMo.New()
	end

	return self._bossCustomFmtMo
end

function DomainAdventureModel:setActivityId(sceneId, activityId)
	self._activityIdDic[sceneId] = activityId
end

function DomainAdventureModel:getActivityIdBySceneId(sceneId)
	return self._activityIdDic[sceneId] or 0
end

DomainAdventureModel.instance = DomainAdventureModel.New()

return DomainAdventureModel
