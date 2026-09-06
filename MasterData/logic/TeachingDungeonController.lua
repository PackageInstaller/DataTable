-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/controller/TeachingDungeonController.lua

module("logic.extensions.teachingdungeon.controller.TeachingDungeonController", package.seeall)

local TeachingDungeonController = class("TeachingDungeonController", BaseController)

function TeachingDungeonController:ctor()
	self.is_require = false
end

function TeachingDungeonController:onInit()
	self.model = TeachingDungeonModel.instance

	self.registerNotify(self, BattleCollegeAgent.BC_NotifyAfterChallengeRes, self.handleBC_NotifyAfterChallengeRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)
end

function TeachingDungeonController:onReset()
	self.failedStageId = false
end

function TeachingDungeonController:OpenView()
	return
end

function TeachingDungeonController:CloseView()
	return
end

function TeachingDungeonController:sendBC_ProcessInfoReq()
	local function resFun(msg)
		local stagePass = msg.stagePass

		self.model:setStagePassBit(stagePass)
		self.model:setPerfectInfos(msg.perfectPrize)

		self.model.is_require = true

		GlobalDispatcher:dispatch(TeachingDungeonModel.RefreshBitInfo)
	end

	BattleCollegeAgent.instance:sendBC_ProcessInfoReq(resFun)
end

function TeachingDungeonController:sendBC_ChallengeReq()
	local curFormation = self.model:getFormation()
	local form = curFormation:createFormPb()
	local stageId = self.model:getCurrStageId()

	BattleCollegeAgent.instance:sendBC_ChallengeReq(stageId, form)
end

function TeachingDungeonController:handleBC_NotifyAfterChallengeRes(status, msg)
	if status == 0 then
		local iswin = msg.isWin
		local changesetid = msg.changeSetId

		self.model:setChallengeResault(iswin, changesetid)
		UIJumper.instance:pushOneStack(ViewName.PlotCopyView)
		UIJumper.instance:pushOneStack(ViewName.TeachingDungeonMainView)

		if not iswin and BattleModel.instance.teachingStageId then
			self.failedStageId = BattleModel.instance.teachingStageId
			BattleModel.instance.teachingStageId = false
		end
	end
end

function TeachingDungeonController:_checkRefreshTime()
	TeachingDungeonModel.instance:refreshDailyDot()
end

TeachingDungeonController.instance = TeachingDungeonController.New()

return TeachingDungeonController
