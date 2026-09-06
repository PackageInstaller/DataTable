-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/controller/ScratchController.lua

module("logic.extensions.scratch.controller.ScratchController", package.seeall)

local ScratchController = class("ScratchController", BaseController)

function ScratchController:ctor()
	return
end

function ScratchController:onInit()
	ScratchAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
	GlobalDispatcher:addListener(ScratchAgent.PM_GetScratchUserInfoRes, self._onGetScratchUserInfoRes, self)
	GlobalDispatcher:addListener(ScratchAgent.PM_ScratchExchangeRes, self._onScratchExchangeRes, self)
	GlobalDispatcher:addListener(ScratchAgent.PM_ScratchSelectBigPrizeRes, self._onScratchSelectPrizeRes, self)
	GlobalDispatcher:addListener(ScratchAgent.PM_ScratchDigRes, self._onScratchDigRes, self)
	GlobalDispatcher:addListener(ScratchAgent.PM_ScratchResetRes, self._onScratchResetRes, self)
	GlobalDispatcher:addListener(ScratchAgent.PM_ScratchSwitchPrizeRes, self._onSwitchPrizeRes, self)
end

function ScratchController:onReset()
	return
end

function ScratchController:showChangeSet(changeSetId, msgName)
	if msgName == "handlePM_ScratchDigRes" then
		ScratchModel.instance:setChangeSetId(changeSetId)
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function ScratchController:sendGetScratchUserInfoReq()
	ScratchAgent.instance:sendPM_GetScratchUserInfoReq()
end

function ScratchController:sendScratchExchangeReq(exchangeNum)
	ScratchAgent.instance:sendPM_ScratchExchangeReq(exchangeNum)
end

function ScratchController:sendPM_ScratchSelectBigPrizeReq(prizeId)
	ScratchAgent.instance:sendPM_ScratchSelectBigPrizeReq(prizeId)
end

function ScratchController:sendPM_ScratchSwitchPrizeReq(prizeId)
	self._switchPrizeId = prizeId

	ScratchAgent.instance:sendPM_ScratchSwitchPrizeReq(prizeId)
end

function ScratchController:sendScratchDigReq(x, y)
	ScratchAgent.instance:sendPM_ScratchDigReq(x, y)
end

function ScratchController:sendScratchResetReq()
	ScratchAgent.instance:sendPM_ScratchResetReq()
end

function ScratchController:_onGetScratchUserInfoRes(status, msg)
	if status == 0 then
		ScratchModel.instance:onGetScratchUserInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GetScratchUserInfo, msg, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GetScratchUserInfo, msg, false)
	end
end

function ScratchController:_onScratchExchangeRes(status, msg)
	if status == 0 then
		ScratchModel.instance:setScore()
		GlobalDispatcher:dispatch(GlobalNotify.ScratchExchange, msg)
	end
end

function ScratchController:_onScratchSelectPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ScratchSelectPrize, msg)
	end
end

function ScratchController:_onScratchDigRes(status, msg)
	if status == 0 then
		ScratchModel.instance:onScratchDigRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ScratchDig, msg)
	end
end

function ScratchController:_onScratchResetRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ScratchReset, msg)
	end
end

function ScratchController:_onSwitchPrizeRes(status, msg)
	if status then
		ScratchModel.instance:setBigPrizeId(self._switchPrizeId)
		GlobalDispatcher:dispatch(GlobalNotify.ScratchSwitchReward)

		self._switchPrizeId = nil
	end
end

function ScratchController:getCurExchangeItemNum()
	local activityId = ScratchModel.instance:getActivityId()
	local cfg = ScratchConfig.instance:getScratchActivityCfgById(activityId)

	if not cfg then
		return 0
	end

	local str = string.split(cfg.activityItem, ":")
	local matType = str[1]
	local id = str[2]

	return MaterialModel.instance:getMaterialsNumber(matType, id)
end

function ScratchController:getItemCfg()
	local activityId = ScratchModel.instance:getActivityId()
	local cfg = ScratchConfig.instance:getScratchActivityCfgById(activityId)

	if not cfg then
		return nil
	end

	local str = string.split(cfg.activityItem, ":")
	local id = checknumber(str[2])

	return (ItemConfig.instance:getActItemCfgById(id))
end

function ScratchController:isScratchRedPointActive()
	local isInTime = ScratchModel.instance:isInActivityTime()

	if not isInTime then
		return false
	end

	local isShowedToday = GameUtil.getUserDayData(ScratchModel.instance:getRedPointConst())

	return not isShowedToday
end

function ScratchController:closeFirstRedPoint()
	GameUtil.saveUserDayData(ScratchModel.instance:getRedPointConst(), true)
end

function ScratchController:getIndexByPos(x, y)
	return x * 7 + y
end

ScratchController.instance = ScratchController.New()

return ScratchController
