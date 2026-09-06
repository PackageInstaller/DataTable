-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/config/InteractionDefinition.lua

module("logic.extensions.spineinterface.config.InteractionDefinition", package.seeall)

local InteractionDefinition = class("InteractionDefinition")

function InteractionDefinition:ctor()
	self._skinId = 0
end

function InteractionDefinition:onInit(skinId, raw)
	self._skinId = checknumber(skinId)
	self._raw = raw or {}
	self._baseData = self._raw.baseData
	self._skinPlanId = self._raw.skinPlanId
	self._publicParams = self._raw.publicParams
	self._spineParams = self._raw.spineParams
	self._spineParamDic = self._raw.spineParamDic
	self._behaviorDataLists = self._raw.behaviorDataLists
	self._spineEvents = self._raw.spineEvents
end

function InteractionDefinition:onClear()
	self._skinId = 0
	self._raw = nil
	self._baseData = nil
	self._skinPlanId = nil
	self._publicParams = nil
	self._spineParams = nil
	self._spineParamDic = nil
	self._behaviorDataLists = nil
	self._spineEvents = nil
end

function InteractionDefinition:getSkinId()
	return self._skinId
end

function InteractionDefinition:getSkinPlanId()
	return self._skinPlanId
end

function InteractionDefinition:getBaseData()
	return self._baseData
end

function InteractionDefinition:getBehaviorDataLists()
	return self._behaviorDataLists
end

function InteractionDefinition:getBehaviorDataList(behaviorLayerId)
	if self._behaviorDataLists then
		return self._behaviorDataLists[behaviorLayerId]
	end

	return nil
end

function InteractionDefinition:getBehaviorData(behaviorLayerId, behaviorId)
	local behaviorDataList = self:getBehaviorDataList(behaviorLayerId)

	if behaviorDataList then
		return behaviorDataList[behaviorId]
	end

	return nil
end

return InteractionDefinition
