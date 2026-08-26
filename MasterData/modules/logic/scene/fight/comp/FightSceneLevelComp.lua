-- chunkname: @modules/logic/scene/fight/comp/FightSceneLevelComp.lua

module("modules.logic.scene.fight.comp.FightSceneLevelComp", package.seeall)

local FightSceneLevelComp = class("FightSceneLevelComp", CommonSceneLevelComp)
local SwitchAnimPrefabPath = "scenes/common/vx_prefabs/vx_sceneswitch.prefab"
local SwitchTime = 2.5

function FightSceneLevelComp:onSceneStart(sceneId, levelId)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)
	FightController.instance:registerCallback(FightEvent.OnRestartFightDisposeDone, self._onRestartFightDisposeDone, self)
	FightController.instance:registerCallback(FightEvent.OnSwitchPlaneClearAssetDone, self._onSwitchPlaneClearAssetDone, self)
	FightSceneLevelComp.super.onSceneStart(self, sceneId, levelId, self._onLoadFailed)
end

function FightSceneLevelComp:_onLoadFailed()
	logError(string.format("战斗场景加载失败,sceneId:%s, levelId:%s, 加载策划指定的场景10801", self._sceneId, self._levelId))
	FightSceneLevelComp.super.onSceneStart(self, 10801, 10801)
end

function FightSceneLevelComp:getLevelId(levelId)
	local key = FightParamData.ParamKey.SceneId
	local param = FightDataHelper.fieldMgr.param
	local value = param and param:getKey(key)

	if not value then
		return levelId
	end

	return value
end

function FightSceneLevelComp:onSceneClose()
	FightSceneLevelComp.super.onSceneClose(self)
	TaskDispatcher.cancelTask(self._tick, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.OnRestartFightDisposeDone, self._onRestartFightDisposeDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnSwitchPlaneClearAssetDone, self._onSwitchPlaneClearAssetDone, self)

	self._frontRendererList = nil
	self._sceneFrontGO = nil

	self:_releaseTween()
	TaskDispatcher.cancelTask(self._onSwitchSceneFinish, self)

	if self._switchAssetItem then
		self._switchAssetItem:Release()

		self._switchAssetItem = nil

		gohelper.destroy(self._switchGO)

		self._switchGO = nil
	end

	if self._oldAssetItem then
		self._oldAssetItem:Release()

		self._oldAssetItem = nil
	end

	if self._oldInstGO then
		gohelper.destroy(self._oldInstGO)

		self._oldInstGO = nil
	end

	self:_disposeLoader()
end

function FightSceneLevelComp:_disposeLoader()
	if self._multiLoader then
		self._multiLoader:dispose()

		self._multiLoader = nil
	end
end

function FightSceneLevelComp:loadLevelNoEffect(levelId)
	if self._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (self._levelId or "nil") .. ", try to load id = " .. (levelId or "nil"))

		return
	end

	if FightDataHelper.stateMgr.isReplay then
		TaskDispatcher.runRepeat(self._tick, self, 1, 10)
	end

	if self._assetItem then
		self._assetItem:Release()

		self._assetItem = nil
	end

	self._oldInstGO = self._instGO
	self._isLoadingRes = true
	self._levelId = levelId

	self:getCurScene():setCurLevelId(self._levelId)

	self._resPath = ResUrl.getSceneLevelUrl(levelId)

	self:_disposeLoader()

	self._multiLoader = MultiAbLoader.New()

	self._multiLoader:addPath(self._resPath)
	self._multiLoader:startLoad(self._onLoadNoEffectFinish, self)
end

function FightSceneLevelComp:_onLoadNoEffectFinish(loader)
	local assetItem = self._multiLoader:getAssetItem(self._resPath)

	self:_onLoadCallback(assetItem)
	gohelper.destroy(self._oldInstGO)

	self._oldInstGO = nil
end

function FightSceneLevelComp:loadLevelWithSwitchEffect(levelId)
	if self._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (self._levelId or "nil") .. ", try to load id = " .. (levelId or "nil"))

		return
	end

	if FightDataHelper.stateMgr.isReplay then
		TaskDispatcher.runRepeat(self._tick, self, 1, 10)
	end

	self._oldInstGO = self._instGO
	self._oldAssetItem = self._assetItem
	self._isLoadingRes = true
	self._levelId = levelId

	self:getCurScene():setCurLevelId(self._levelId)

	self._resPath = ResUrl.getSceneLevelUrl(levelId)

	self:_disposeLoader()

	self._multiLoader = MultiAbLoader.New()

	self._multiLoader:addPath(SwitchAnimPrefabPath)
	self._multiLoader:addPath(self._resPath)
	self._multiLoader:startLoad(self._onSwitchResLoadCallback, self)
end

function FightSceneLevelComp:_tick()
	FightController.instance:dispatchEvent(FightEvent.ReplayTick)
end

function FightSceneLevelComp:_onSwitchResLoadCallback(loader)
	local sceneGO = self:getCurScene():getSceneContainerGO()
	local oldAsstet = self._switchAssetItem

	self._switchAssetItem = self._multiLoader:getAssetItem(SwitchAnimPrefabPath)

	self._switchAssetItem:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end

	self._switchGO = gohelper.clone(self._switchAssetItem:GetResource(SwitchAnimPrefabPath), sceneGO)

	local newSceneNode = gohelper.findChild(self._switchGO, "scene_former")
	local oldSceneNode = gohelper.findChild(self._switchGO, "scene_latter")

	oldAsstet = self._assetItem
	self._assetItem = self._multiLoader:getAssetItem(self._resPath)

	self._assetItem:Retain()

	if oldAsstet then
		oldAsstet:Release()
	end

	self._instGO = gohelper.clone(self._assetItem:GetResource(self._resPath), newSceneNode)

	gohelper.addChild(oldSceneNode, self._oldInstGO)
	TaskDispatcher.runDelay(self._onSwitchSceneFinish, self, SwitchTime)
	self._multiLoader:dispose()

	self._multiLoader = nil
	self._isLoadingRes = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_scene_switching)
end

function FightSceneLevelComp:_onSwitchSceneFinish()
	TaskDispatcher.cancelTask(self._tick, self)

	local sceneGO = self:getCurScene():getSceneContainerGO()

	gohelper.addChild(sceneGO, self._instGO)

	if self._switchAssetItem then
		self._switchAssetItem:Release()

		self._switchAssetItem = nil

		gohelper.destroy(self._switchGO)

		self._switchGO = nil
	end

	if self._oldAssetItem then
		self._oldAssetItem:Release()

		self._oldAssetItem = nil

		gohelper.destroy(self._oldInstGO)

		self._oldInstGO = nil
	end

	self:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, self._levelId)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, self._levelId)

	local typeName = SceneType.NameDict[GameSceneMgr.instance:getCurSceneType()]

	if not self._sceneId then
		if not self._levelId then
			local levelId = -1

			logNormal(string.format("load scene level finish: %s %d level_%d", typeName, self._sceneId, levelId))
			self:getCurScene().camera:setSceneCameraOffset()
		end
	end
end

function FightSceneLevelComp:_onLevelLoaded(levelId)
	self._frontRendererList = nil
	self._sceneFrontGO = nil

	self:_releaseTween()

	local sceneRootGO = CameraMgr.instance:getSceneRoot()
	local fightScenePrefabRoot = gohelper.findChild(self:getCurScene():getSceneContainerGO(), "Scene")

	gohelper.addChild(fightScenePrefabRoot, self:getSceneGo())
end

function FightSceneLevelComp:setFrontVisible(visible)
	do return end

	if self._frontRendererList and self._visible == visible then
		return
	end

	self:_releaseTween()

	self._visible = visible

	if not self._frontRendererList then
		self._frontRendererList = {}

		self:_gatherFrontRenderers()
	end

	if self._frontRendererList then
		local from = visible and 1 or 0
		local to = visible and 0 or 1
		local duration = visible and 0.4 or 0.25

		if self._visible then
			gohelper.setActive(self._sceneFrontGO, self._visible)
		end

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(from, to, duration, self._frameCallback, self._finishCallback, self)
	end
end

function FightSceneLevelComp:_frameCallback(value)
	if not self._frontRendererList then
		return
	end

	for _, renderer in ipairs(self._frontRendererList) do
		if renderer then
			local mat = renderer.material

			if not gohelper.isNil(mat) then
				mat:SetFloat(ShaderPropertyId.FrontSceneAlpha, value)
			end
		end
	end
end

function FightSceneLevelComp:_finishCallback()
	if not self._visible then
		gohelper.setActive(self._sceneFrontGO, self._visible)
	end

	self:_releaseTween()
end

function FightSceneLevelComp:_releaseTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function FightSceneLevelComp:_gatherFrontRenderers()
	local sceneGO = self:getSceneGo()

	self._sceneFrontGO = gohelper.findChild(sceneGO, "StandStill/Obj-Plant/front")

	if self._sceneFrontGO and self._sceneFrontGO.activeSelf then
		local rendererList = self._sceneFrontGO:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

		if rendererList then
			local iter = rendererList:GetEnumerator()

			while iter:MoveNext() do
				local one = iter.Current

				table.insert(self._frontRendererList, one)
			end
		end
	end
end

function FightSceneLevelComp:_onRestartFightDisposeDone()
	self:resetAnim()
end

function FightSceneLevelComp:_onSwitchPlaneClearAssetDone()
	self:resetAnim()
end

function FightSceneLevelComp:resetAnim()
	if self._sceneId == 17501 then
		local sceneObj = self:getSceneGo()

		if sceneObj then
			local ani = gohelper.findChildComponent(sceneObj, "StandStill/Obj-Plant/near/v1a3_scene_kme_blue01/scene_kme_blue01_1", typeof(UnityEngine.Animator))

			if ani then
				ani.speed = FightModel.instance:getSpeed()

				ani:Play("v1a3_scene_kme_blue01_chuxian", 0, 0)
			end

			ani = gohelper.findChildComponent(sceneObj, "StandStill/Obj-Plant/near/v1a3_scene_kme_green_04/scene_kme_green_04_1", typeof(UnityEngine.Animator))

			if ani then
				ani.speed = FightModel.instance:getSpeed()

				ani:Play("v1a3_scene_kme_green_04_chuxian", 0, 0)
			end

			ani = gohelper.findChildComponent(sceneObj, "StandStill/Obj-Plant/near/v1a3_scene_kme_orange_02/scene_kme_orange_02", typeof(UnityEngine.Animator))

			if ani then
				ani.speed = FightModel.instance:getSpeed()

				ani:Play("v1a3_scene_kme_orange_02_chuxian", 0, 0)
			end

			ani = gohelper.findChildComponent(sceneObj, "StandStill/Obj-Plant/near/v1a3_scene_kme_red_03/scene_kme_red_03_1", typeof(UnityEngine.Animator))

			if ani then
				ani.speed = FightModel.instance:getSpeed()

				ani:Play("v1a3_scene_kme_red_03_chuxian", 0, 0)
			end

			ani = gohelper.findChildComponent(sceneObj, "StandStill/Obj-Plant/near/v1a3_scene_kme_yellow_05/scene_kme_yellow_05_1", typeof(UnityEngine.Animator))

			if ani then
				ani.speed = FightModel.instance:getSpeed()

				ani:Play("v1a3_scene_kme_yellow_05_chuxian", 0, 0)
			end

			ani = gohelper.findChildComponent(sceneObj, "SceneEffect/ScreenBroken", typeof(UnityEngine.Animator))

			if ani then
				ani.speed = FightModel.instance:getSpeed()

				ani:Play("New State", 0, 0)
			end
		end
	end
end

function FightSceneLevelComp:_onSkillPlayStart(entity, skillId)
	if skillId == 0 then
		return
	end

	self._skillCounter = self._skillCounter or 0
	self._skillCounter = self._skillCounter + 1

	if self._sceneEffectsObj then
		for i, v in ipairs(self._sceneEffectsObj) do
			gohelper.setActive(v, false)
		end
	end
end

function FightSceneLevelComp:_onSkillPlayFinish(entity, skillId)
	if skillId == 0 then
		return
	end

	self._skillCounter = (self._skillCounter or 1) - 1

	if self._skillCounter < 0 then
		self._skillCounter = 0
	end

	if self._skillCounter > 0 then
		return
	end

	if self._sceneEffectsObj then
		for i, v in ipairs(self._sceneEffectsObj) do
			gohelper.setActive(v, true)
		end
	end
end

function FightSceneLevelComp:_onRestartStageBefore()
	self._skillCounter = 0
end

return FightSceneLevelComp
