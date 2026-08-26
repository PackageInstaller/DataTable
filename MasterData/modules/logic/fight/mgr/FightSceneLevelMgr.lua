-- chunkname: @modules/logic/fight/mgr/FightSceneLevelMgr.lua

module("modules.logic.fight.mgr.FightSceneLevelMgr", package.seeall)

local FightSceneLevelMgr = class("FightSceneLevelMgr", FightBaseClass)
local SwitchAnimPrefabPath = "scenes/common/vx_prefabs/vx_sceneswitch.prefab"
local SwitchTime = 2.5

function FightSceneLevelMgr:onConstructor()
	self:com_registFightEvent(FightEvent.OnRestartFightDisposeDone, self._onRestartFightDisposeDone)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAssetDone, self._onSwitchPlaneClearAssetDone)
	self.newClass(self, FightSceneLevelSceneEffectMgr, self)
end

function FightSceneLevelMgr:loadScene(sceneId, levelId)
	local work = self:registWorkLoadScene(sceneId, levelId)

	work:start()
end

function FightSceneLevelMgr:registWorkLoadScene(sceneId, levelId)
	local var_3_0

	if not sceneId then
		::label_3_0::

		var_3_0 = self.sceneId or 10801
	end

	self.sceneId = var_3_0

	self:setLevelId(levelId)

	local flow = self:com_registFlowSequence()

	self.oldLoaderComp = self.loaderComp
	self.loaderComp = self:addComponent(FightLoaderComponent)

	flow:registWork(FightWorkLoadAssetByComp, self.sceneResPath, self.loaderComp, self.onSceneLoaded, self)

	return flow
end

function FightSceneLevelMgr:setLevelId(levelId)
	self.levelId = self:getLevelId(levelId)

	GameSceneMgr.instance:getCurScene():setCurLevelId(self.levelId)

	self.sceneResPath = ResUrl.getSceneLevelUrl(self.levelId)
end

function FightSceneLevelMgr:loadLevelWithSwitchEffect(levelId)
	local work = self:registWorkLoadLevelWithSwitchEffect(levelId)

	work:start()
end

function FightSceneLevelMgr:registWorkLoadLevelWithSwitchEffect(levelId)
	local oldPath = self.sceneResPath

	self:setLevelId(levelId)

	local flow = self:com_registFlowSequence()
	local parallel = flow:registWork(FightWorkFlowParallel)

	self.switchLoaderComp = self:addComponent(FightLoaderComponent)

	if not string.nilorempty(oldPath) then
		parallel:registWork(FightWorkLoadAssetByComp, oldPath, self.switchLoaderComp)
	end

	parallel:registWork(FightWorkLoadAssetByComp, self.sceneResPath, self.switchLoaderComp)
	parallel:registWork(FightWorkLoadAssetByComp, SwitchAnimPrefabPath, self.switchLoaderComp, self.onSwitchEffectLoaded, self)
	flow:addWork(self:registWorkLoadScene(self.sceneId, self.levelId))
	flow:registWork(FightWorkFunction, self.addNewScene2SwitchEffect, self)
	flow:registWork(FightWorkDelayTimer, SwitchTime)
	flow:registWork(FightWorkFunction, self.afterSwitchScene, self)

	return flow
end

function FightSceneLevelMgr:addNewScene2SwitchEffect()
	gohelper.addChild(gohelper.findChild(self._switchGO, "scene_former"), self.sceneObj)
end

function FightSceneLevelMgr:onSwitchEffectLoaded(success, assetItem)
	if not success then
		return
	end

	local parentRoot = GameSceneMgr.instance:getCurScene():getSceneContainerGO()

	self._switchGO = gohelper.clone(assetItem:GetResource(SwitchAnimPrefabPath), parentRoot)

	local newSceneNode = gohelper.findChild(self._switchGO, "scene_former")
	local oldSceneNode = gohelper.findChild(self._switchGO, "scene_latter")

	gohelper.addChild(oldSceneNode, self.sceneObj)

	self.sceneObj = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_scene_switching)
end

function FightSceneLevelMgr:afterSwitchScene()
	local parentRoot = GameSceneMgr.instance:getCurScene():getSceneContainerGO()

	gohelper.addChild(gohelper.findChild(parentRoot, "Scene"), self.sceneObj)
	gohelper.destroy(self._switchGO)
	self.switchLoaderComp:disposeSelf()
	GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
end

function FightSceneLevelMgr:getLevelId(levelId)
	local key = FightParamData.ParamKey.SceneId
	local param = FightDataHelper.fieldMgr.param
	local value = param and param:getKey(key)

	if not value then
		return levelId
	end

	return value
end

function FightSceneLevelMgr:getCurLevelId()
	return self.levelId
end

function FightSceneLevelMgr:onSceneLoaded(success, assetItem)
	if not success then
		logError(string.format("战斗场景加载失败,sceneId:%s, levelId:%s, 加载策划指定的场景10801", self.sceneId, self.levelId))
		self:loadScene(10801, 10801)

		return
	end

	local parentRoot = GameSceneMgr.instance:getCurScene():getSceneContainerGO()

	gohelper.destroy(self.sceneObj)

	if self.oldLoaderComp then
		self.oldLoaderComp:disposeSelf()
	end

	self._frontRendererList = nil
	self.sceneObj = gohelper.clone(assetItem:GetResource(), gohelper.findChild(parentRoot, "Scene"))

	FightController.instance:dispatchEvent(FightEvent.OnSceneLevelLoaded, self.levelId)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, self.levelId)
end

function FightSceneLevelMgr:getSceneGo()
	return self.sceneObj
end

function FightSceneLevelMgr:setFrontVisible(visible)
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

function FightSceneLevelMgr:_frameCallback(value)
	if not self._frontRendererList then
		return
	end

	for _, renderer in ipairs(self._frontRendererList) do
		local mat = renderer.material

		if not gohelper.isNil(mat) then
			mat:SetFloat(ShaderPropertyId.FrontSceneAlpha, value)
		end
	end
end

function FightSceneLevelMgr:_finishCallback()
	if not self._visible then
		gohelper.setActive(self._sceneFrontGO, self._visible)
	end

	self:_releaseTween()
end

function FightSceneLevelMgr:_releaseTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function FightSceneLevelMgr:_gatherFrontRenderers()
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

function FightSceneLevelMgr:_onRestartFightDisposeDone()
	self:resetAnim()
end

function FightSceneLevelMgr:_onSwitchPlaneClearAssetDone()
	self:resetAnim()
end

function FightSceneLevelMgr:resetAnim()
	if self.sceneId == 17501 then
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

function FightSceneLevelMgr:onDestructor()
	self:_releaseTween()
	gohelper.destroy(self._switchGO)
	gohelper.destroy(self.sceneObj)
end

return FightSceneLevelMgr
