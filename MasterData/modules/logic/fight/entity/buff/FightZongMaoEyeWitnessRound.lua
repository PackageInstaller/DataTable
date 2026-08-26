-- chunkname: @modules/logic/fight/entity/buff/FightZongMaoEyeWitnessRound.lua

module("modules.logic.fight.entity.buff.FightZongMaoEyeWitnessRound", package.seeall)

local FightZongMaoEyeWitnessRound = class("FightZongMaoEyeWitnessRound", FightBaseClass)

function FightZongMaoEyeWitnessRound:onConstructor(buffData)
	self.buffData = buffData
	self.uid = buffData.uid
	self.entityId = buffData.entityId
	self.buffId = buffData.buffId
	self.entityData = FightDataHelper.entityMgr:getById(self.entityId)
	self.tweenComp = self:addComponent(FightTweenComponent)

	self:com_registMsg(FightMsgId.GetAddBuffShowWork, self.onGetAddBuffShowWork)

	self.flow = self:buildFlow()

	self.flow:start()
end

function FightZongMaoEyeWitnessRound:onGetAddBuffShowWork(entityId, buffUid)
	if entityId ~= self.entityId or buffUid ~= self.uid then
		return
	end

	FightMsgMgr.replyMsg(FightMsgId.GetAddBuffShowWork, self.flow)
end

function FightZongMaoEyeWitnessRound:buildFlow()
	local flow = self:com_registFlowSequence()
	local parallelFlow = flow:registWork(FightWorkFlowParallel)
	local url = "effects/prefabs/buff/scene_witness_invisibility.prefab"

	parallelFlow:registWork(FightWorkLoadAsset, url, self.onSceneEffectLoaded, self)

	return flow
end

function FightZongMaoEyeWitnessRound:onSceneEffectLoaded(success, loader)
	if not success then
		return
	end

	local sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()
	local obj = loader:GetResource()

	self.sceneEffect = gohelper.clone(obj, sceneObj)
	self.sceneEffectMat = self.sceneEffect:GetComponent(typeof(UnityEngine.MeshRenderer)).material
	self.matKeyId = UnityEngine.Shader.PropertyToID("_SourceColLerp")

	self.tweenComp:DOTweenFloat(1, 0.3, 1, self.onTweenFloat, nil, self)
end

function FightZongMaoEyeWitnessRound:onTweenFloat(value)
	MaterialUtil.setPropValue(self.sceneEffectMat, self.matKeyId, "float", value)
end

function FightZongMaoEyeWitnessRound:onEntityEffectLoaded(success, loader, entity)
	if not success then
		return
	end

	local obj = loader:GetResource()
	local entityObj = gohelper.clone(obj, entity.spine:getSpineGO())

	table.insert(self.entityEffectList, entityObj)
end

function FightZongMaoEyeWitnessRound:onDestructor()
	if self.sceneEffect then
		if FightGameMgr.playMgr:__isActive() then
			FightGameMgr.playMgr:newClass(FightHideZongMaoSceneEffect, self.sceneEffect)
		else
			gohelper.destroy(self.sceneEffect)
		end
	end

	if self.entityEffectList then
		for i, v in ipairs(self.entityEffectList) do
			gohelper.destroy(v)
		end
	end
end

return FightZongMaoEyeWitnessRound
