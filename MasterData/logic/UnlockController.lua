-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/unlock/controller/UnlockController.lua

module("logic.extensions.unlock.controller.UnlockController", package.seeall)

local UnlockController = class("UnlockController", BaseController)

function UnlockController:onInit()
	UnlockController.super.onInit(self)
	self.registerNotify(self, GlobalNotify.ChallengeDataUpdate, self._onChallengeDataUpdate, self)
	self.registerNotify(self, GlobalNotify.OnMofangLvUp, self._onMofangLvUp, self)
	self.registerNotify(self, GlobalNotify.OnMaterialInited, self._onMaterialInited, self)
	self.registerNotify(self, GlobalNotify.TaskDataReady, self._onTaskDataReady, self)
	self.registerNotify(self, GlobalNotify.TaskDataUpdate, self._onTaskDataUpdate, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._resetDailyTaskes, self)
	UnlockAgent.instance:addHandler(UnlockAgent.GetUnlockNeedInfoRes, self.SCGetUnlockNeedInfo, self)
end

function UnlockController:_onChallengeDataUpdate(cInfo)
	UnlockModel.instance:pushChallengeInfo(cInfo)
end

function UnlockController:_onMofangLvUp()
	UnlockModel.instance:handleMofangLevel()
end

function UnlockController:_onMaterialInited()
	UnlockModel.instance:checkAllScenesUnlock()
end

function UnlockController:_onTaskDataReady()
	UnlockModel.instance:checkAllScenesUnlock()
end

function UnlockController:_onTaskDataUpdate(taskId)
	UnlockModel.instance:handleTaskData(taskId)
end

function UnlockController:checkSceneUnlockByTime()
	UnlockModel.instance:checkSceneUnlockByTime()
end

function UnlockController:_resetDailyTaskes()
	UnlockModel.instance:checkAllScenesUnlock()
end

function UnlockController:CSGetUnlockNeedInfoRes()
	local challengeIds = UnlockConfig.instance:getAllKingRoadIds()

	UnlockAgent.instance:sendGetUnlockNeedInfoReq(challengeIds or {})
end

function UnlockController:SCGetUnlockNeedInfo(msg)
	forcePrint("=====RoleDataRequestor:_loadChallengeInfos===back")

	if msg then
		UnlockModel.instance:onChallengeInfos(msg.challengeInfos)
		ChallengeModel.instance:setSimpleInfosByUnlockMsg(msg.challengeInfos)
	end
end

UnlockController.instance = UnlockController.New()

return UnlockController
