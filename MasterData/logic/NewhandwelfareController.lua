-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/controller/NewhandwelfareController.lua

module("logic.extensions.newhandwelfare.controller.NewhandwelfareController", package.seeall)

local NewhandwelfareController = class("NewhandwelfareController", BaseController)

NewhandwelfareController.NewHandWelfareGainZdlPrizeRes = "NewhandwelfareController.NewHandWelfareGainZdlPrizeRes"
NewhandwelfareController.NewHandWelfareGainOnlinePrizeRes = "NewhandwelfareController.NewHandWelfareGainOnlinePrizeRes"
NewhandwelfareController.NewHandWelfareGainSignInPrizeRes = "NewhandwelfareController.NewHandWelfareGainSignInPrizeRes"
NewhandwelfareController.NewHandWelfareGetInfoRes = "NewhandwelfareController.NewHandWelfareGetInfoRes"
NewhandwelfareController.NewHandWelfareOneKeyGainOnlinePrizeRes = "NewhandwelfareController.NewHandWelfareOneKeyGainOnlinePrizeRes"
NewhandwelfareController.NewHandWelfareOneKeyGainZdlPrizeRes = "NewhandwelfareController.NewHandWelfareOneKeyGainZdlPrizeRes"
NewhandwelfareController.PM_NotifyNewHandWelfarePaySucRes = "NewhandwelfareController.PM_NotifyNewHandWelfarePaySucRes"

function NewhandwelfareController:ctor()
	return
end

function NewhandwelfareController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(NewHandWelfareAgent.NewHandWelfareGainZdlPrizeRes, self._NewHandWelfareGainZdlPrizeRes, self)
	GlobalDispatcher:addListener(NewHandWelfareAgent.NewHandWelfareGainOnlinePrizeRes, self._NewHandWelfareGainOnlinePrizeRes, self)
	GlobalDispatcher:addListener(NewHandWelfareAgent.NewHandWelfareGainSignInPrizeRes, self._NewHandWelfareGainSignInPrizeRes, self)
	GlobalDispatcher:addListener(NewHandWelfareAgent.NewHandWelfareGetInfoRes, self._NewHandWelfareGetInfoRes, self)
	GlobalDispatcher:addListener(NewHandWelfareAgent.NewHandWelfareOneKeyGainOnlinePrizeRes, self._NewHandWelfareOneKeyGainOnlinePrizeRes, self)
	GlobalDispatcher:addListener(NewHandWelfareAgent.NewHandWelfareOneKeyGainZdlPrizeRes, self._NewHandWelfareOneKeyGainZdlPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	GlobalDispatcher:addListener(NewHandWelfareAgent.PM_NotifyNewHandWelfarePaySucRes, self._PM_NotifyNewHandWelfarePaySucRes, self)
end

function NewhandwelfareController:onReset()
	self._lastPlayerLv = -1
	self._needFireRefreshMainUI = false
	self._gainZdlPrizeIsNormal = false
end

function NewhandwelfareController:_onStartEnterGame()
	self._lastPlayerLv = MofangModel.instance:getCurLv()

	local needLv = NewhandwelfareConfig.instance:getCommonValue("UNDER_LEVEL", true)

	if needLv > self._lastPlayerLv then
		GlobalDispatcher:addListener(GlobalNotify.OnMofangLvUp, self._OnMofangLvUp, self)
	else
		NewHandWelfareAgent.instance:sendNewHandWelfareGetInfoReq()
	end
end

function NewhandwelfareController:_OnMofangLvUp(newLv)
	local needLv = NewhandwelfareConfig.instance:getCommonValue("UNDER_LEVEL", true)

	if needLv <= newLv then
		NewHandWelfareAgent.instance:sendNewHandWelfareGetInfoReq()

		self._needFireRefreshMainUI = true

		GlobalDispatcher:removeListener(GlobalNotify.OnMofangLvUp, self._OnMofangLvUp, self)
	end
end

function NewhandwelfareController:_NewHandWelfareGainZdlPrizeRes(status, msg)
	if status == 0 then
		NewhandwelfareModel.instance:gainZdlPrizeRes(msg.prizeId, self._gainZdlPrizeIsNormal)
	end

	GlobalDispatcher:dispatch(NewhandwelfareController.NewHandWelfareGainZdlPrizeRes, status, msg)
end

function NewhandwelfareController:_NewHandWelfareGainOnlinePrizeRes(status, msg)
	if status == 0 then
		NewhandwelfareModel.instance:gainOnlinePrizeRes(msg.prizeId)
	end

	GlobalDispatcher:dispatch(NewhandwelfareController.NewHandWelfareGainOnlinePrizeRes, status, msg)
end

function NewhandwelfareController:_NewHandWelfareGainSignInPrizeRes(status, msg)
	if status == 0 then
		NewhandwelfareModel.instance:gainSignInPrizeRes(msg.day)
	end

	GlobalDispatcher:dispatch(NewhandwelfareController.NewHandWelfareGainSignInPrizeRes, status, msg)
end

function NewhandwelfareController:_NewHandWelfareGetInfoRes(status, msg)
	if status == 0 then
		NewhandwelfareModel.instance:setInfo(msg)
		self:_updateNewHandOlinePrizeRedPoint()
		GlobalDispatcher:dispatch(GlobalNotify.RedPointUpdate, 458)

		if self._needFireRefreshMainUI then
			GlobalDispatcher:dispatch(GlobalNotify.UpdateMainUIFuncs)

			self._needFireRefreshMainUI = false
		end
	end

	GlobalDispatcher:dispatch(NewhandwelfareController.NewHandWelfareGetInfoRes, status, msg)
end

function NewhandwelfareController:_updateNewHandOlinePrizeRedPoint()
	local isNeedRed = true
	local showTime = 0

	if isNeedRed then
		local periodId = NewhandwelfareModel.instance:getPeriodId()

		if periodId <= 0 then
			isNeedRed = false
		end
	end

	if isNeedRed then
		local olineTimeEnd = NewhandwelfareModel.instance:getOnlineTimeActEndTime()

		if olineTimeEnd <= ServerTime.now() then
			isNeedRed = false
		end
	end

	if isNeedRed then
		local periodId = NewhandwelfareModel.instance:getPeriodId()
		local day = NewhandwelfareModel.instance:getNewHandActiveDays()
		local cfg = NewhandwelfareConfig.instance:getOnlineRewardCfg(periodId, day)

		if cfg then
			for i, data in ipairs(cfg) do
				local isHasGain = NewhandwelfareModel.instance:isGainOnlinePrize(data.prizeId)

				if not isHasGain then
					local cur = NewhandwelfareModel.instance:getOnlineTime()
					local need = data.onlineTime * 60
					local left = Mathf.Max(need - cur, 0)

					showTime = ServerTime.now() + left

					break
				end
			end
		end
	end

	if isNeedRed then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_NEWHAND_ONLINE_PRIZE, true, true, showTime, nil, nil)
	else
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_NEWHAND_ONLINE_PRIZE, false)
	end
end

function NewhandwelfareController:_NewHandWelfareOneKeyGainOnlinePrizeRes(status, msg)
	if status == 0 then
		NewhandwelfareModel.instance:oneKeyGainOnlinePrizeRes(msg.prizeId)
		self:_updateNewHandOlinePrizeRedPoint()
	end

	GlobalDispatcher:dispatch(NewhandwelfareController.NewHandWelfareOneKeyGainOnlinePrizeRes, status, msg)
end

function NewhandwelfareController:_NewHandWelfareOneKeyGainZdlPrizeRes(status, msg)
	if status == 0 then
		NewhandwelfareModel.instance:oneKeyGainZdlPrizeRes(msg)
	end

	GlobalDispatcher:dispatch(NewhandwelfareController.NewHandWelfareOneKeyGainZdlPrizeRes, status, msg)
end

function NewhandwelfareController:_PM_NotifyNewHandWelfarePaySucRes(status, msg)
	if status == 0 then
		NewhandwelfareModel.instance:welfarePaySucRes()
	end

	GlobalDispatcher:dispatch(NewhandwelfareController.PM_NotifyNewHandWelfarePaySucRes, status, msg)
end

function NewhandwelfareController:sendNewHandWelfareGetBoundInfoReq()
	NewHandWelfareAgent.instance:sendNewHandWelfareGetBoundInfoReq()
end

function NewhandwelfareController:handleNewHandWelfareGetBoundInfoRes(msg)
	NewhandwelfareModel.instance:handleNewHandWelfareGetBoundInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandleNewHandWelfareGetBoundInfoRes)
end

function NewhandwelfareController:sendNewHandWelfareSubmitFormZdlReq(teamId, form)
	NewHandWelfareAgent.instance:sendNewHandWelfareSubmitFormZdlReq(teamId, form)
end

function NewhandwelfareController:handleNewHandWelfareSubmitFormZdlRes(msg)
	NewhandwelfareModel.instance:handleNewHandWelfareSubmitFormZdlRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandleNewHandWelfareSubmitFormZdlRes)
end

function NewhandwelfareController:sendNewHandWelfareGainBoundPrizeReq(prizeId)
	NewHandWelfareAgent.instance:sendNewHandWelfareGainBoundPrizeReq(prizeId)
end

function NewhandwelfareController:handleNewHandWelfareGainBoundPrizeRes(msg)
	NewhandwelfareModel.instance:handleNewHandWelfareGainBoundPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandleNewHandWelfareGainBoundPrizeRes)
end

function NewhandwelfareController:recordGainZdlPrizeIsNormal(isNormal)
	self._gainZdlPrizeIsNormal = isNormal
end

function NewhandwelfareController:enterFormationAsNewHand(bondTeamId)
	local customFmtMo = NewhandwelfareModel.instance:getNewhandwelfareFmtCustomFmtMo()

	customFmtMo:updateCfg(bondTeamId)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function NewhandwelfareController:tryPopNewHandSelectPassView()
	if self:isNeedPopNewHandSelectPassView() then
		UIStateManager.instance:push(ViewName.NewHandSelectPassView)
	end
end

function NewhandwelfareController:isNeedPopNewHandSelectPassView()
	local guideMode = RoleModel.instance:getGuideMode()

	return guideMode == -1
end

function NewhandwelfareController:getNewhandDoubleValue()
	if self:isInNewPrivilegeTime() then
		return 1
	else
		return 0
	end
end

function NewhandwelfareController:isInNewPrivilegeTime()
	return NewhandwelfareModel.instance:isInNewPrivilegeTime()
end

NewhandwelfareController.instance = NewhandwelfareController.New()

return NewhandwelfareController
