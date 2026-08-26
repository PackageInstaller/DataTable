-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterSceneDirector.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterSceneDirector", package.seeall)

local SurvivalShelterSceneDirector = class("SurvivalShelterSceneDirector", SurvivalSceneDirector)

function SurvivalShelterSceneDirector:startEnterProgress()
	self._beginDt = ServerTime.now()

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local have = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):haveReputationItem()

	if have and not weekInfo:isAllReputationShopMaxLevel() then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalReputationSelectView)
	end

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	SurvivalMapHelper.instance:tryShowServerPanel(weekMo.panel)
	SurvivalModel.instance:checkBossFightItem()
	SurvivalMapHelper.instance:checkRoleLevelUpCache(true)

	if SurvivalShelterModel.instance:getNeedShowBossInvade() then
		SurvivalShelterModel.instance:setNeedShowBossInvade()
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalBossInvadeView)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalMonsterEventView, {
			showType = SurvivalEnum.SurvivalMonsterEventViewShowType.Watch
		})
	end

	self.directorFlow = FlowSequence.New()

	if SurvivalController.instance.isOldSettle then
		local parallelWork1 = FlowParallel.New()
		local survivalOpenViewWork = SurvivalOpenViewWork.New({
			viewName = ViewName.SurvivalMainView
		})

		survivalOpenViewWork:registerDoneListener(self.onOpenView, self)
		parallelWork1:addWork(survivalOpenViewWork)

		if PopupController.instance:getPopupCount() > 0 then
			parallelWork1:addWork(PopupViewFinishWork.New())
		end

		self.directorFlow:addWork(parallelWork1)
		self.directorFlow:registerDoneListener(self.onSceneViewPopupFinish, self)
		self.directorFlow:start()
	else
		local parallelWork1 = FlowParallel.New()
		local survivalOpenViewWork = SurvivalOpenViewWork.New({
			viewName = ViewName.SurvivalMainView
		})

		survivalOpenViewWork:registerDoneListener(self.onOpenView, self)
		parallelWork1:addWork(survivalOpenViewWork)

		local flow = FlowSequence.New()
		local info = SurvivalModel.instance:getSurvivalSettleInfo()

		if info then
			flow:addWork(SurvivalSettlePerformanceWork.New())
		else
			local needShowDestroy, fightId = SurvivalShelterModel.instance:getNeedShowFightSuccess()

			if needShowDestroy then
				flow:addWork(FunctionWork.New(function()
					UIBlockMgrExtend.setNeedCircleMv(false)
					UIBlockHelper.instance:startBlock("SurvivalSettlePerformanceWork", 3)
					PopupController.instance:setPause("SurvivalShelterSceneDirector", true)

					local curScene = GameSceneMgr.instance:getCurScene()
					local unit = curScene.unit
					local entity = unit:getShelterMonster()

					if entity then
						entity:playFightEffect()
					end

					SurvivalShelterModel.instance:setNeedShowFightSuccess(nil, nil)
				end))
				flow:addWork(TimerWork.New(3))
				flow:addWork(FunctionWork.New(function()
					UIBlockHelper.instance:endBlock("SurvivalSettlePerformanceWork")
					UIBlockMgrExtend.setNeedCircleMv(true)
					PopupController.instance:setPause("SurvivalShelterSceneDirector", false)
					SurvivalController.instance:dispatchEvent(SurvivalEvent.BossFightSuccessShowFinish)
					SurvivalMapHelper.instance:refreshPlayerEntity()
				end))
			end
		end

		if PopupController.instance:getPopupCount() > 0 then
			flow:addWork(PopupViewFinishWork.New())
		end

		parallelWork1:addWork(flow)
		self.directorFlow:addWork(parallelWork1)
		self.directorFlow:registerDoneListener(self.onSceneViewPopupFinish, self)
		self.directorFlow:start()
	end
end

function SurvivalShelterSceneDirector:onSceneViewPopupFinish()
	if SurvivalController.instance.isOldSettle then
		-- block empty
	else
		local info = SurvivalModel.instance:getSurvivalSettleInfo()

		if info then
			SurvivalController.instance:showResultPanel()

			return
		end
	end

	SurvivalController.instance:onScenePopupFinish()
	self:processGuideEvent()
end

function SurvivalShelterSceneDirector:processGuideEvent()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	if weekMo.day > 1 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitWeekDay)
	end

	if weekMo.difficulty == 3 or weekMo.difficulty == 4 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideShelterHard)
	end
end

function SurvivalShelterSceneDirector:disposeEnterProgress()
	if self.directorFlow then
		self.directorFlow:destroy()

		self.directorFlow = nil
	end

	ViewMgr.instance:closeView(ViewName.SurvivalMainView)
	ViewMgr.instance:closeAllPopupViews()

	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	SurvivalStatHelper.instance:statWeekClose(ServerTime.now() - self._beginDt, (outSideMo and outSideMo.inWeek or nil) and "topleft")
end

return SurvivalShelterSceneDirector
