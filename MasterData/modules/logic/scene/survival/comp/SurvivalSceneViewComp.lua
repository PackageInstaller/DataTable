-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneViewComp.lua

module("modules.logic.scene.survival.comp.SurvivalSceneViewComp", package.seeall)

local SurvivalSceneViewComp = class("SurvivalSceneViewComp", BaseSceneComp)

function SurvivalSceneViewComp:onScenePrepared(sceneId, levelId)
	if not SurvivalMapModel.instance.isFightEnter or not self._beginDt then
		self._beginDt = ServerTime.now()
	end

	SurvivalMapModel.instance.isFightEnter = false

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if sceneMo.battleInfo.status ~= SurvivalEnum.FightStatu.None then
		SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.FightBack, "")
	else
		SurvivalMapHelper.instance:tryShowServerPanel(sceneMo.panel)
	end

	TaskDispatcher.runDelay(self._processGuideEvent, self, 0.3)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onViewCloseWork, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.onFlowEnd, self.onViewCloseWork, self)
	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self.onViewCloseWork, self)
end

function SurvivalSceneViewComp:onViewCloseWork()
	if SurvivalMapModel.instance.result == SurvivalEnum.MapResult.None and self:_checkLevelUp() then
		return
	end

	self:_processGuideEvent()
end

function SurvivalSceneViewComp:_processGuideEvent()
	local isInTopView = ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMapMainView, {
		ViewName.SurvivalToastView,
		ViewName.SurvivalCommonTipsView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	})

	if isInTopView and not SurvivalMapHelper.instance:isInFlow() then
		if not self:isGuideLock() and self:isHaveEquip() then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitHaveEquip)
		end

		if not self:isGuideLock() and self:isInSpRain() then
			local sceneMo = SurvivalMapModel.instance:getSceneMo()

			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitSpRain, tostring(sceneMo._mapInfo.rainCo.type))
		end

		if not self:isGuideLock() then
			self:processSpBlockGuide()
		end
	end
end

function SurvivalSceneViewComp:_checkLevelUp()
	return SurvivalMapHelper.instance:checkRoleLevelUpCache()
end

function SurvivalSceneViewComp:isHaveEquip()
	local haveEquip = false
	local bagMo = SurvivalMapHelper.instance:getBagMo()

	for i, v in ipairs(bagMo.items) do
		if v.equipCo then
			haveEquip = true

			break
		end
	end

	return haveEquip
end

function SurvivalSceneViewComp:isInSpRain()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if not sceneMo._mapInfo.rainCo then
		return false
	end

	return sceneMo._mapInfo.rainCo.type ~= 1
end

function SurvivalSceneViewComp:processSpBlockGuide()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	for i, v in ipairs(SurvivalHelper.instance:getAllPointsByDis(sceneMo.player.pos, 2)) do
		local blockType = sceneMo:getBlockTypeByPos(v)

		if blockType and blockType ~= SurvivalEnum.UnitSubType.Block then
			SurvivalMapModel.instance.guideSpBlockPos = v:clone()

			SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitSpBlock, tostring(blockType))
		end

		if self:isGuideLock() then
			return
		end
	end
end

function SurvivalSceneViewComp:isGuideLock()
	return GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SurvivalGuideLock)
end

function SurvivalSceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onViewCloseWork, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.onFlowEnd, self.onViewCloseWork, self)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self.onViewCloseWork, self)
	TaskDispatcher.cancelTask(self._processGuideEvent, self)
	ViewMgr.instance:closeView(ViewName.SurvivalMapMainView)
	ViewMgr.instance:closeView(ViewName.SurvivalToastView)
	ViewMgr.instance:closeAllPopupViews()

	local nextSceneType = GameSceneMgr.instance:getNextSceneType()

	if nextSceneType ~= SceneType.Fight then
		local weekMo = SurvivalShelterModel.instance:getWeekInfo()

		SurvivalStatHelper.instance:statMapClose(ServerTime.now() - self._beginDt, (weekMo and weekMo.inSurvival or nil) and "topleft")
	end
end

return SurvivalSceneViewComp
