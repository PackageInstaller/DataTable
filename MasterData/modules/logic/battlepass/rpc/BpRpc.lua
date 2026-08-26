-- chunkname: @modules/logic/battlepass/rpc/BpRpc.lua

module("modules.logic.battlepass.rpc.BpRpc", package.seeall)

local BpRpc = class("BpRpc", BaseRpc)

function BpRpc:onInit()
	self:reInit()
end

function BpRpc:reInit()
	self._tmpIsSp_sendGetBpBonusRequest = nil
end

function BpRpc:sendGetBpInfoRequest(getTask)
	local req = BpModule_pb.GetBpInfoRequest()

	req.getTask = getTask

	return self:sendMsg(req)
end

function BpRpc:onReceiveGetBpInfoReply(resultCode, msg)
	if resultCode == 0 then
		BpModel.instance:onGetInfo(msg)

		if msg.endTime > 0 then
			BpBonusModel.instance:onGetInfo(msg.scoreBonusInfo)
			BpBonusModel.instance:initGetSelectBonus(msg.hasGetSelfSelectBonus)
			BpTaskModel.instance:onGetInfo(msg.taskInfo)
			BpController.instance:onCheckBpEndTime()
			BpController.instance:dispatchEvent(BpEvent.OnGetInfo)
			BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
		else
			ViewMgr.instance:closeView(ViewName.BpView)
		end
	end
end

function BpRpc:onReceiveBpOpenPush(resultCode, msg)
	if resultCode == 0 then
		self:sendGetBpInfoRequest(true)
	end
end

function BpRpc:sendGetBpBonusRequest(level, payBonus, isSp, callback, callbackobj)
	local req = BpModule_pb.GetBpBonusRequest()

	req.id = BpModel.instance.id
	req.level = level

	if payBonus then
		req.payBonus = payBonus
	end

	if isSp then
		req.isSp = true
	else
		BpModel.instance.lockAlertBonus = true
	end

	self._tmpIsSp_sendGetBpBonusRequest = isSp

	self:sendMsg(req, callback, callbackobj)
end

function BpRpc:onReceiveGetBpBonusReply(resultCode, msg)
	local isSp = self._tmpIsSp_sendGetBpBonusRequest

	if resultCode == 0 then
		local isAlertChargeTips = false

		if not isSp then
			isAlertChargeTips = BpModel.instance:checkShowPayBonusTip(msg.scoreBonusInfo)
		end

		BpBonusModel.instance:updateInfo(msg.scoreBonusInfo)
		BpController.instance:dispatchEvent(BpEvent.OnGetBonus)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if BpModel.instance.cacheBonus then
			if isAlertChargeTips then
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpPropView2, BpModel.instance.cacheBonus)
			else
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpPropView, BpModel.instance.cacheBonus)
			end

			BpModel.instance.cacheBonus = nil
		end
	end

	BpModel.instance.lockAlertBonus = false
	self._tmpIsSp_sendGetBpBonusRequest = nil
end

function BpRpc:onReceiveBpScoreUpdatePush(resultCode, msg)
	if resultCode == 0 then
		if BpModel.instance:isEnd() then
			return
		end

		local preScore = BpModel.instance.score
		local levelUp = BpModel.instance:checkLevelUp(msg.score)

		BpModel.instance:updateScore(msg.score, msg.weeklyScore)
		BpController.instance:dispatchEvent(BpEvent.OnUpdateScore)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if levelUp and not BpModel.instance.lockLevelUpShow then
			BpModel.instance.preStatus = {
				score = preScore,
				payStatus = BpModel.instance.payStatus
			}

			BpController.instance:onBpLevelUp()
		end
	end
end

function BpRpc:onReceiveBpPayPush(resultCode, msg)
	if resultCode == 0 then
		if BpModel.instance:isEnd() then
			return
		end

		local prePayStatus = BpModel.instance.payStatus

		BpModel.instance:updatePayStatus(msg.payStatus)
		BpController.instance:dispatchEvent(BpEvent.OnUpdatePayStatus)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if not BpController.instance:needShowLevelUp() then
			BpModel.instance.preStatus = BpModel.instance.preStatus or {
				score = BpModel.instance.score
			}
			BpModel.instance.preStatus.payStatus = prePayStatus
		end

		BpModel.instance:buildChargeFlow()
	end
end

function BpRpc:sendBpBuyLevelRequset(num)
	local req = BpModule_pb.BpBuyLevelRequset()

	req.id = BpModel.instance.id
	req.num = num

	self:sendMsg(req)
end

function BpRpc:onReceiveBpBuyLevelReply(resultCode, msg)
	if resultCode == 0 then
		local preScore = BpModel.instance.score
		local levelUp = BpModel.instance:checkLevelUp(msg.score)

		BpModel.instance:onBuyLevel(msg.score)
		BpController.instance:dispatchEvent(BpEvent.OnBuyLevel)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if levelUp then
			BpModel.instance.preStatus = {
				score = preScore,
				payStatus = BpModel.instance.payStatus
			}

			BpController.instance:onBpLevelUp()
		end
	end
end

function BpRpc:sendBpMarkFirstShowRequest(isSp)
	local req = BpModule_pb.BpMarkFirstShowRequest()

	req.id = BpModel.instance.id

	if isSp then
		req.isSp = true
	end

	self:sendMsg(req)
end

function BpRpc:onReceiveBpMarkFirstShowReply(resultCode, msg)
	if resultCode == 0 then
		if msg.isSp then
			BpModel.instance.firstShowSp = false
		else
			BpModel.instance.firstShow = false
		end
	end
end

function BpRpc:sendGetSelfSelectBonusRequest(level, index)
	local req = BpModule_pb.GetSelfSelectBonusRequest()

	req.id = BpModel.instance.id
	req.level = level
	req.index = index

	self:sendMsg(req)
end

function BpRpc:onReceiveGetSelfSelectBonusReply(resultCode, msg)
	if resultCode == 0 then
		BpBonusModel.instance:markSelectBonus(msg.level, msg.index)
		BpController.instance:dispatchEvent(BpEvent.onSelectBonusGet, msg.level)
	end
end

BpRpc.instance = BpRpc.New()

return BpRpc
