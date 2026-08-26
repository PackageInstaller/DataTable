-- chunkname: @modules/logic/scene/fight/FightScene.lua

module("modules.logic.scene.fight.FightScene", package.seeall)

local FightScene = class("FightScene", BaseScene)

function FightScene:_createAllComps()
	self:_addComp("director", FightSceneDirector)
	self:_addComp("camera", FightSceneCameraComp)
	self:_addComp("view", FightSceneViewComp)
	self:_addComp("preloader", FightScenePreloader)
	self:_addComp("cardCamera", FightSceneCardCameraComp)
	self:addLowPhoneMemoryComp()
end

function FightScene:addLowPhoneMemoryComp()
	local memo_G = UnityEngine.SystemInfo.systemMemorySize / 1024

	if memo_G > 3.6 then
		return
	end

	FightScene.isLowMemory = true

	if not SLFramework.FrameworkSettings.IsIOSPlayer() then
		return
	end

	FightScene.ios3GBMemory = true

	logNormal(string.format("add FightSceneLowPhoneMemoryComp, memory : %G", memo_G))
	self:_addComp("lowPhoneMemoryMgr", FightSceneLowPhoneMemoryComp)
end

function FightScene:getCurLevelId()
	local key = FightParamData.ParamKey.SceneId
	local param = FightDataHelper.fieldMgr.param
	local value = param and param:getKey(key)

	if value then
		return value
	end

	return FightScene.super.getCurLevelId(self)
end

function FightScene:onClose()
	FightGameHelper.disposeGameMgr()
	FightScene.super.onClose(self)
	FightTLEventPool.dispose()
	FightSkillBehaviorMgr.instance:dispose()
	FightRenderOrderMgr.instance:dispose()
	FightNameMgr.instance:dispose()
	FightFloatMgr.instance:dispose()
	FightAudioMgr.instance:dispose()
	FightVideoMgr.instance:dispose()
	FightSkillMgr.instance:dispose()
	FightResultModel.instance:clear()
	FightCardDissolveEffect.clear()
	ZProj.GameHelper.ClearFloorReflect()
	FightStrUtil.instance:dispose()
	FightTLHelper.clearCache()
end

return FightScene
