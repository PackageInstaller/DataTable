-- chunkname: @modules/logic/fight/system/work/FightWorkPlayShow.lua

module("modules.logic.fight.system.work.FightWorkPlayShow", package.seeall)

local FightWorkPlayShow = class("FightWorkPlayShow", FightWorkItem)

FightRoundSequence.roundTempData = {}

function FightWorkPlayShow:onStart()
	FightRoundSequence.roundTempData = {}
	self.roundData = FightDataHelper.roundMgr:getRoundData()

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkSendEvent, FightEvent.OnRoundSequenceStart)
	flow:addWork(WorkWaitSeconds.New(0.01))
	flow:addWork(FightWork2Work.New(FightWorkDialogueBeforeRoundStart))
	flow:addWork(FightWorkRoundStart.New())

	local stepWorkList, skillFlowList = FightStepBuilder.buildStepWorkList(self.roundData and self.roundData.fightStep)

	if stepWorkList then
		local i = 1

		while i <= #stepWorkList do
			local work = stepWorkList[i]

			i = i + 1

			flow:addWork(work)
		end
	end

	flow:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
	flow:addWork(FightWorkRoundEnd.New())
	flow:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))

	if not FightModel.instance:isFinish() then
		local version = FightModel.instance:getVersion()

		if version < 4 then
			flow:addWork(FightWork2Work.New(FightWorkDistributeCard))
		end

		local nextRoundStepWorkList, _ = FightStepBuilder.buildStepWorkList(self.roundData and self.roundData.nextRoundBeginStep)

		if nextRoundStepWorkList and #nextRoundStepWorkList > 0 then
			for _, work in ipairs(nextRoundStepWorkList) do
				flow:addWork(work)
			end
		end

		flow:addWork(FightWorkShowRoundView.New())
		flow:addWork(FunctionWork.New(function()
			GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)
			GameSceneMgr.instance:getCurScene().camera:resetParam()
		end))
		flow:addWork(FightWorkShowBuffDialog.New())
		flow:addWork(FightWorkCorrectData.New())
	end

	flow:addWork(FightWorkClearAfterRound.New())
	flow:addWork(FunctionWork.New(function()
		local roundData = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(roundData)
	end))
	flow:addWork(FightWorkCompareDataAfterPlay.New())
	flow:addWork(FunctionWork.New(self._refreshPosition, self))
	flow:registFinishCallback(self.onShowFinish, self)
	self:playWorkAndDone(flow, {})
end

function FightWorkPlayShow:onShowFinish()
	FightModel.instance:onEndRound()
	FightController.instance:dispatchEvent(FightEvent.OnRoundSequenceFinish)
end

function FightWorkPlayShow:_refreshPosition()
	local entityList = FightHelper.getAllEntitys()

	for _, entity in ipairs(entityList) do
		entity:resetStandPos()

		if entity.nameUI then
			entity.nameUI._nameUIVisible = true

			entity.nameUI:setActive(true)
		end
	end
end

return FightWorkPlayShow
