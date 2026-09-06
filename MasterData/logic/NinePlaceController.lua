-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/controller/NinePlaceController.lua

module("logic.extensions.nineplace.controller.NinePlaceController", package.seeall)

local NinePlaceController = class("NinePlaceController", BaseController)

NinePlaceController.PM_GetNinePlaceProcessInfoRes = "NinePlaceController.PM_GetNinePlaceProcessInfoRes"

function NinePlaceController:ctor()
	return
end

function NinePlaceController:onInit()
	self.agent = NinePlaceAgent.instance
	self.model = NinePlaceModel.instance

	GlobalDispatcher:addListener(NinePlaceAgent.PM_NinePlaceChallengeEndRes, self.handlePM_NinePlaceChallengeEndRes, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateMainUIFuncs, self.updateMainUIFuncs, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMofangDoLvUp, self.onMofangDoLvUp, self)
end

function NinePlaceController:onReset()
	removetimer(self.sendPM_GetNinePlaceProcessInfoReq, self)

	self.is_get_infos = false
	self.processInfoIsReady = false
	self.mainUIFuncIsReady = false
end

function NinePlaceController:updateMainUIFuncs()
	self.mainUIFuncIsReady = true

	self:checkBattleFuncRed()
end

function NinePlaceController:checkBattleFuncRed()
	if self.mainUIFuncIsReady and self.processInfoIsReady then
		RedPointModel.instance:updateAllRedPoint()
	end
end

function NinePlaceController:onMofangDoLvUp()
	RedPointModel.instance:updateAllRedPoint()
end

function NinePlaceController:sendPM_GetNinePlaceProcessInfoReq()
	if self.is_get_infos then
		return
	end

	removetimer(self.sendPM_GetNinePlaceProcessInfoReq, self)

	self.is_get_infos = true

	local function handler(msg)
		forcePrint("=====RoleDataRequestor:_loadNinePlaceInfo===back")
		self.model:setNinePlaceProcessInfo(msg.processInfo)

		self.processInfoIsReady = true

		self:checkBattleFuncRed()
		GlobalDispatcher:dispatch(NinePlaceController.PM_GetNinePlaceProcessInfoRes)
	end

	self.agent:sendPM_GetNinePlaceProcessInfoReq(handler)
end

local currChallengeStageId = false

function NinePlaceController:sendPM_NinePlaceChallengeReq(stageId, masterIdx)
	currChallengeStageId = stageId

	local index = NinePlaceModel.instance:creepsMasterId2Index(stageId, masterIdx)

	local function handler(msg)
		UIJumper.instance:pushOneStack(ViewName.NineplacechallengeView, nil, currChallengeStageId)

		local info = FormationNewModel.instance:getFormStrengthInfo(stageId)

		if not info then
			self._isOpenUnlockView = true

			UIJumper.instance:pushOneStack(ViewName.FormationunlockView, nil, stageId)
		end
	end

	local function errHandler(msg, status)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	self.agent:sendPM_NinePlaceChallengeReq(stageId, index, handler, nil, errHandler)
end

function NinePlaceController:handlePM_NinePlaceChallengeEndRes(status, msg)
	if status == 0 then
		self.model:setChallengeEnd(msg)

		if self._isOpenUnlockView and not msg.isWin then
			UIJumper.instance:removeTopState(ViewName.FormationunlockView)
		end

		self._isOpenUnlockView = false
	end
end

NinePlaceController.instance = NinePlaceController.New()

return NinePlaceController
