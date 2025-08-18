-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\EffectManager.lua

local strClassName = "EffectManager"
local EffectManager = Class(strClassName)
local logerror = logerror
local Vector3 = Vector3
local tolua = tolua
local EffectLifeMode = Const.EFFECT_LIFE_MODE
local GameFsm = GameFsm
local EffectFactory = Framework.EffectSystem.EffectFactory
local BattleConst = require("Common/FrameBattle/BattleConst")
local GameSettings = require("Helper/GameSettings")

function EffectManager:ctor()
	assert(EffectManager._instance == nil, "[ERROR] The EffectManager instance is created already!")
	self:_init()
end

function EffectManager:_init()
	EffectFactory.Init()

	self.effectInstancesDict = {}
	self.needTurnonDict = {}
end

function EffectManager:destroy()
	EffectFactory.Destroy()

	self.effectInstancesDict = nil
end

function EffectManager:loadOnceEffect(prefabPath, logicTag)
	return self:_syncLoadEffect(prefabPath, false, logicTag)
end

function EffectManager:loadLogicEffect(prefabPath, logicTag)
	return self:_syncLoadEffect(prefabPath, true, logicTag)
end

function EffectManager:_syncLoadEffect(prefabPath, needHold, logicTag)
	if not prefabPath or prefabPath == "" then
		return
	end

	local controller = EffectFactory.CreateEffectSync(prefabPath, logicTag or -1)

	if controller then
		local insId = controller.Eid

		if needHold then
			self.effectInstancesDict[insId] = controller
		end

		return insId, controller
	end
end

local function _asyncLoadCallback(effMgr, needHold, userCallback, controller)
	if not controller then
		return
	end

	local insId = controller.Eid

	if needHold then
		effMgr.effectInstancesDict[insId] = controller
	end

	if userCallback then
		userCallback(controller)
	end

	if effMgr.needTurnonDict[insId] then
		controller:TurnOn()

		effMgr.needTurnonDict[insId] = nil
	end
end

function EffectManager:loadOnceEffectAsync(prefabPath, loadedCallback, logicTag)
	if not prefabPath or prefabPath == "" then
		return
	end

	local insId = EffectFactory.CreateEffectAsync(prefabPath, Functor(_asyncLoadCallback, self, false, loadedCallback), logicTag or -1)

	return insId
end

function EffectManager:loadLogicEffectAsync(prefabPath, loadedCallback, logicTag)
	if not prefabPath or prefabPath == "" then
		return
	end

	local insId = EffectFactory.CreateEffectAsync(prefabPath, Functor(_asyncLoadCallback, self, true, loadedCallback), logicTag or -1)

	return insId
end

function EffectManager:releaseEffect(insId)
	if not insId then
		return
	end

	EffectFactory.ReleaseEffect(insId)

	if self.effectInstancesDict[insId] then
		self.effectInstancesDict[insId] = nil
	end

	self.needTurnonDict[insId] = nil
end

function EffectManager:despawnUnuseEffect()
	EffectFactory.CleanDespawnedEffect()
end

function EffectManager:getController(insId)
	if self.effectInstancesDict[insId] then
		return self.effectInstancesDict[insId]
	end
end

function EffectManager:pauseEffectGroup(logicTag)
	EffectFactory.BatchProcessPause(logicTag, true)
end

function EffectManager:resumeEffectGroup(logicTag)
	EffectFactory.BatchProcessPause(logicTag, false)
end

function EffectManager:hideEffectGroup(logicTag)
	EffectFactory.BatchProcessHide(logicTag, true)
end

function EffectManager:reshowEffectGroup(logicTag)
	EffectFactory.BatchProcessHide(logicTag, false)
end

function EffectManager:playNormalEffectAsync(actorTransform, effectData, lifeMode, logicGroup, logicMirror, fashionTag)
	local effectPath = utils.fixFashionPath(effectData.SourcePath, fashionTag)
	local insId
	local playMode = effectData.howToPlay

	local function _normalEffectLoadedCallback(controller)
		if not controller then
			return
		end

		self:_setPlayMode(controller, playMode, effectData)

		local mount = effectData.mount
		local mountType = effectData.mountType
		local offset = Vector3(effectData.offset.x, effectData.offset.y, effectData.offset.z)
		local rotate = Vector3.zero
		local skipActor = false

		if mountType == 2 or mountType == 3 or mountType == 4 or mountType == 9 or mountType == 10 then
			local battleState = GameFsm.getCurState()

			if battleState and battleState.gridAngle then
				rotate = Vector3(0, battleState.gridAngle, 0)
			end

			rotate.y = rotate.y + 90

			if mountType == 3 then
				if not battleState or not GameFsm.isBattleState(battleState.stateName) then
					controller:TurnOffAndDespawn()

					return
				end

				skipActor = true

				if battleState and battleState:getCenterPointPos() then
					local worldCenter = battleState:getCenterPointPos()

					controller:SetWorldCenter(worldCenter)
				end
			end
		end

		local needLogicMirror = 1

		if mountType == 2 or mountType == 4 then
			if not logicMirror then
				needLogicMirror = -1
			end
		elseif (mountType == 9 or mountType == 10) and logicMirror then
			needLogicMirror = -1
		end

		if not skipActor and (not actorTransform or tolua.isnull(actorTransform)) then
			controller:TurnOffAndDespawn()

			return
		end

		self:checkForceQuality(controller)
		controller:SetNormalEffect(actorTransform, mount, offset, rotate, mountType)

		local scale = effectData.scale

		if scale ~= 0 then
			controller:ScaleTheEffect(scale, scale, scale * needLogicMirror)
		elseif needLogicMirror == -1 then
			controller:ScaleTheEffect(1, 1, -1)
		end

		controller:TurnOn()
	end

	local logicTag = self:_getLogicGroupByMode(lifeMode, logicGroup)

	if playMode == BattleConst.CUE_PLAY_MODE.LogicControl or playMode == BattleConst.CUE_PLAY_MODE.Always then
		insId = self:loadLogicEffectAsync(effectPath, _normalEffectLoadedCallback, logicTag)
	else
		insId = self:loadOnceEffectAsync(effectPath, _normalEffectLoadedCallback, logicTag)
	end

	return insId
end

function EffectManager:playThrowEffectAsync(actorTransform, targetTransform, effectData, delayTime, lifeMode, logicGroup, fashionTag)
	local effectPath = utils.fixFashionPath(effectData.SourcePath, fashionTag)
	local playMode = effectData.howToPlay

	local function _throwEffectLoadedCallback(controller)
		if not controller then
			return
		end

		self:_setPlayMode(controller, playMode, effectData)

		if not targetTransform or not actorTransform or tolua.isnull(targetTransform) or tolua.isnull(actorTransform) then
			controller:TurnOffAndDespawn()

			return
		end

		self:checkForceQuality(controller)

		local startMount = effectData.startPos
		local endMount = effectData.endPos
		local height = effectData.height
		local curve = effectData.curve
		local opposite = effectData.oppositeDirection

		if opposite then
			controller:SetFlyEffect(targetTransform, actorTransform, startMount, endMount, height, curve, delayTime)
		else
			controller:SetFlyEffect(actorTransform, targetTransform, startMount, endMount, height, curve, delayTime)
		end

		local scale = effectData.scale

		if scale ~= 0 then
			controller:ScaleTheEffect(scale, scale, scale)
		end

		controller:TurnOn()
	end

	local logicTag = self:_getLogicGroupByMode(lifeMode, logicGroup)
	local insId = self:loadOnceEffectAsync(effectPath, _throwEffectLoadedCallback, logicTag)

	return insId
end

function EffectManager:playLinkEffectAsync(startTransform, endTransform, effectData, lifeMode, logicGroup, fashionTag)
	local effectPath = utils.fixFashionPath(effectData.SourcePath, fashionTag)
	local playMode = effectData.howToPlay

	local function _linkEffectLoadedCallback(controller)
		if not controller then
			return
		end

		self:_setPlayMode(controller, playMode, effectData)

		local startMount = effectData.startPos
		local endMount = effectData.endPos
		local opposite = effectData.oppositeDirection

		if not startTransform or not endTransform or tolua.isnull(startTransform) or tolua.isnull(endTransform) then
			controller:TurnOffAndDespawn()

			return
		end

		self:checkForceQuality(controller)

		if not opposite then
			controller:SetLinkEffect(startTransform, endTransform, startMount, endMount)
		else
			controller:SetLinkEffect(endTransform, startTransform, endMount, startMount)
		end

		controller:TurnOn()
	end

	local logicTag = self:_getLogicGroupByMode(lifeMode, logicGroup)
	local insId = self:loadLogicEffectAsync(effectPath, _linkEffectLoadedCallback, logicTag)

	return insId
end

function EffectManager:playUIEffectAsync(effectData, mountUIObject, lifeMode, needMirror, fashionTag)
	local effectPath = utils.fixFashionPath(effectData.SourcePath, fashionTag)
	local playMode = effectData.howToPlay
	local length = 0

	if playMode == BattleConst.CUE_PLAY_MODE.PlayLength then
		length = effectData.playLength
	end

	local player = UIManager.getUI("uiEffectPlayer", true)
	local insId = player:playUIEfx(effectPath, length, needMirror)

	return insId
end

function EffectManager:stopUIEffect()
	local player = UIManager.getUI("uiEffectPlayer", nil, false)

	if player then
		player:setVisible(false)
	end
end

function EffectManager:playStaticEffectAsync(actorId, actorTransform, effectPath, mountBone, offset, rotate, scale, showOnLoad, forceLevel, scriptMount, callback, lifeMode)
	local function _staticEffectLoadedCallback(controller)
		if not controller then
			return
		end

		controller:SetParam("length", -1)

		if scriptMount then
			controller:SetNormalEffect(actorTransform, mountBone, offset, rotate, 0)
		else
			controller:SetNormalEffect(actorTransform)
		end

		if scale and scale ~= 1 then
			controller:ScaleTheEffect(scale, scale, scale)
		end

		local objectLayer = actorTransform.gameObject.layer

		if objectLayer and objectLayer >= 0 then
			controller:SetLayer(objectLayer)
		end

		if forceLevel then
			controller:SetForceQualityLevel(forceLevel)
		end

		if showOnLoad then
			controller:TurnOn()
		end

		if callback then
			callback(controller)
		end
	end

	lifeMode = lifeMode or EffectLifeMode.LogicControl

	local logicGroup = self:_getLogicGroupByMode(lifeMode, actorId)
	local insId = self:loadLogicEffectAsync(effectPath, _staticEffectLoadedCallback, logicGroup)

	return insId
end

function EffectManager:clearStaticEffect(actorId)
	self:batchReleaseEffects(actorId)
end

function EffectManager:loadSceneEffect(prefabPath)
	local logicTag = self:_getLogicGroupByMode(EffectLifeMode.StateControl)
	local insId, controller = self:loadLogicEffect(prefabPath, logicTag)

	if insId and controller then
		controller:TurnOff()

		controller.despawnWhenEnd = false

		return insId, controller
	end
end

function EffectManager:getFreedomEffectAsync(path, pos, rotation, playOnLoaded, lifeMode, logicGroup, needShadow)
	local function _freedomLoadedCallback(controller)
		if not controller then
			return
		end

		self:checkForceQuality(controller)
		controller:SetFreedomEffect(pos, rotation or Vector3.zero)

		if needShadow then
			controller:SetCustomShadow(true)
		end

		if playOnLoaded then
			controller:TurnOn()
		end
	end

	local insId
	local autoRelease = not lifeMode or lifeMode == EffectLifeMode.JustPlay
	local logicTag = self:_getLogicGroupByMode(lifeMode, logicGroup)

	if autoRelease then
		insId = self:loadOnceEffectAsync(path, _freedomLoadedCallback, logicTag)
	else
		insId = self:loadLogicEffectAsync(path, _freedomLoadedCallback, logicTag)
	end

	return insId
end

function EffectManager:getFreedomEffect(path, pos, rotation, playOnLoaded, lifeMode, logicGroup)
	local insId, controller
	local autoRelease = not lifeMode or lifeMode == EffectLifeMode.JustPlay
	local logicTag = self:_getLogicGroupByMode(lifeMode, logicGroup)

	insId, controller = self:_syncLoadEffect(path, not autoRelease, logicTag)

	if not controller then
		return
	end

	controller:SetFreedomEffect(pos, rotation or Vector3.zero)

	if playOnLoaded then
		controller:TurnOn()
	end

	return insId, controller
end

EffectManager.TARGET_SELECTED_EFFECT = {
	[Const.WORLD_ENTITY_UNKNOWN] = "Effects/common/efx_UI_target_01.prefab"
}

function EffectManager:getSelectedEffect(targetType)
	if not targetType or not EffectManager.TARGET_SELECTED_EFFECT[targetType] then
		return
	end

	if not self.selectedEffects then
		self.selectedEffects = {}
	end

	local insId, controller

	if not self.selectedEffects[targetType] then
		insId, controller = self:loadLogicEffect(EffectManager.TARGET_SELECTED_EFFECT[targetType])
		self.selectedEffects[targetType] = controller
	else
		controller = self.selectedEffects[targetType]
		insId = controller.Eid
	end

	if controller then
		controller.despawnWhenEnd = false
		controller.length = -1

		controller:TurnOff()
	end

	return insId, controller
end

function EffectManager:playTransformEffect(targetTransform, prefabPath, lifeMode, logicGroup)
	local function _mountEffectLoadedCallback(controller)
		if not controller then
			return
		end

		if targetTransform and not tolua.isnull(targetTransform) then
			controller:SetAnimationEffect(targetTransform)
			controller:TurnOn()
		else
			controller:TurnOffAndDespawn()
		end
	end

	local insId
	local autoRelease = not lifeMode or lifeMode == EffectLifeMode.JustPlay
	local logicTag = self:_getLogicGroupByMode(lifeMode, logicGroup)

	if autoRelease then
		insId = self:loadOnceEffectAsync(prefabPath, _mountEffectLoadedCallback, logicTag)
	else
		insId = self:loadLogicEffectAsync(prefabPath, _mountEffectLoadedCallback, logicTag)
	end

	return insId
end

function EffectManager:_setPlayMode(controller, playMode, effectData)
	if playMode == BattleConst.CUE_PLAY_MODE.PlayLength then
		local length = effectData.playLength

		controller:SetParam("Length", length)
	elseif playMode == BattleConst.CUE_PLAY_MODE.LoopTimes then
		local times = effectData.loopTimes

		controller:SetParam("LoopTimes", times)
	else
		controller:SetParam("Length", -1)
	end
end

function EffectManager:_getLogicGroupByMode(mode, extraParam)
	if not mode or mode == EffectLifeMode.JustPlay then
		return -1
	elseif mode == EffectLifeMode.StateControl then
		return 0
	else
		return extraParam
	end
end

function EffectManager:setEffectPool(settingDict)
	for k, v in pairs(settingDict) do
		EffectFactory[k] = v
	end
end

function EffectManager:batchReleaseEffects(logicGroup)
	EffectFactory.BatchProcessRelease(logicGroup)
end

function EffectManager:batchScaleEffectSpeed(logicGroup, speed)
	EffectFactory.BatchProcessScaleSpeed(logicGroup, speed)
end

local PreloadWhiteList = {}

function EffectManager:preloadEffect(pathList)
	EffectFactory.Preload(pathList)
end

function EffectManager:preloadEffectOneByOne(pathList, callback)
	for i, effectPath in ipairs(pathList) do
		EffectFactory.CreateEffectAsync(effectPath, callback)
	end
end

function EffectManager:changePoolCleanCount(cleanCount)
	EffectFactory.ChangePrefabPoolCleanCount(cleanCount)
end

function EffectManager:changePoolLifeTime()
	return
end

function EffectManager:setForceQuality(quality)
	if quality < GameSettings.getCurGameQuality() then
		self.forceQualityLevel = quality
	end
end

function EffectManager:clearForceQuality()
	self.forceQualityLevel = nil
end

function EffectManager:checkForceQuality(controller)
	if self.forceQualityLevel then
		controller:SetForceQualityLevel(self.forceQualityLevel)
	end
end

return EffectManager
