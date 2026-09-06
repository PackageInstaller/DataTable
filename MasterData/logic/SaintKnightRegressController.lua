-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/controller/SaintKnightRegressController.lua

module("logic.extensions.saintknightregress.controller.SaintKnightRegressController", package.seeall)

local SaintKnightRegressController = class("SaintKnightRegressController", BaseController)

function SaintKnightRegressController:ctor()
	return
end

function SaintKnightRegressController:onInit()
	self:onReset()
end

function SaintKnightRegressController:onReset()
	return
end

function SaintKnightRegressController:handlePM_SaintKnightRegressGetInfoRes(msg)
	SaintKnightRegressModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightRegressGetInfo)
end

function SaintKnightRegressController:handlePM_SaintKnightRegressGainPrizeRes(msg)
	SaintKnightRegressModel.instance:saveGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightRegressGetInfo)
end

function SaintKnightRegressController:handlePM_SaintKnightRegressOneKeyGainPrizeRes(msg)
	SaintKnightRegressModel.instance:saveGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightRegressGetInfo)
end

function SaintKnightRegressController:handlePM_SaintKnightRegressLotteryRes(msg)
	SaintKnightRegressModel.instance:saveLotteryInfo(msg)

	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_SaintKnightRegressLotteryRes)
end

function SaintKnightRegressController:sendPM_SaintKnightRegressFillMsgReq(activityId, phoneNumber, receiver, receiverAddr)
	local msg = SaintKnightRegressExtension_pb.PM_SaintKnightRegressLotteryMsg()

	msg.phoneNumber = phoneNumber
	msg.receiver = receiver
	msg.receiverAddr = receiverAddr

	SaintKnightRegressAgent.instance:sendPM_SaintKnightRegressFillMsgReq(activityId, msg)
end

function SaintKnightRegressController:handlePM_SaintKnightRegressFillMsgRes(msg)
	FloatWordMgr.instance:show(lang("收货信息保存成功！"))
	SaintKnightRegressModel.instance:saveLotteryMsg(msg)
end

function SaintKnightRegressController:handlePM_SaintKnightRegressBindCodeRes(msg)
	SaintKnightRegressModel.instance:saveBindCode(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SaintKnightRegressBindCodeRes)
end

function SaintKnightRegressController:handlePM_SaintKnightRegressGetTaskInfoRes(msg)
	SaintKnightRegressModel.instance:saveRegressTaskInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightRegressGetInfo)
end

function SaintKnightRegressController:startHelp(activityId)
	self._tempActId = activityId

	GlobalDispatcher:addListener(GlobalNotify.FriendSelected, self._onSelectFriend, self)
end

function SaintKnightRegressController:endHelp()
	self._tempActId = nil

	GlobalDispatcher:removeListener(GlobalNotify.FriendSelected, self._onSelectFriend, self)
end

function SaintKnightRegressController:_onSelectFriend(ids)
	if self._tempActId and #ids > 0 then
		self:_friendSelected(self._tempActId, ids)
	end
end

function SaintKnightRegressController:_friendSelected(activityId, buddyIds)
	local activityCfg = SaintKnightRegressConfig.instance:getActivityCfg(activityId)

	self._buddyIds = buddyIds

	local tpId = activityCfg.templateId

	self._msgType = GameEnum.ChatType.System

	local cfg = ChatConfig.instance:getSystemMsgT(tpId)
	local params = {}

	params.activityId = activityId
	params.inviteCode = SaintKnightRegressModel.instance:getInviteCode(activityId)

	local dataT = {
		tpId = tpId,
		params = params
	}

	self._content = GameUtil.jsonToString(dataT)

	local buddyCount = #self._buddyIds

	self.msgId = 0

	if buddyCount > 0 then
		self:setSendCd()
		settimer(1, self._sendInviteMsg, self, true)
	end
end

function SaintKnightRegressController:_sendInviteMsg()
	self.msgId = self.msgId + 1

	local receiveId = self._buddyIds[self.msgId]

	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Private, self._msgType, self._content, receiveId, nil, nil)

	if self.msgId >= #self._buddyIds then
		FloatWordMgr.instance:show("已成功发送邀请")

		self.msgId = 0

		removetimer(self._sendInviteMsg, self)
	end
end

function SaintKnightRegressController:setSendCd()
	self._sendTime = ServerTime.now()
end

function SaintKnightRegressController:getSendTime()
	return self._sendTime
end

function SaintKnightRegressController:openInviteView(activityId, inviteCode)
	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.SaintKnightRegress, activityId) == true then
		UIStateManager.instance:push(ViewName.SaintKnightRegressMainView, activityId)

		local actCfg = SaintKnightRegressConfig.instance:getActivityCfg(activityId)
		local cfg = ChatConfig.instance:getSystemMsgT(actCfg.templateId)
		local content = ""

		if cfg then
			local t = {
				inviteCode = inviteCode
			}

			content = StringUtil.parseJsonParams(cfg.template, t)
			content = string.match(content, "(.-)<color.+</color>")
		end

		UIStateManager.instance:push(ViewName.SaintKnightRegressBindView, activityId, content)
	else
		FloatWordMgr.instance:show(lang("活动已过期"))
	end
end

function SaintKnightRegressController:openAddressView(activityId)
	local platformSettingCfg = SaintKnightRegressConfig.instance:getPlatformSetting(activityId)
	local btplatformId = BootstrapUtil.getPlatformId()

	if btplatformId and platformSettingCfg[btplatformId] then
		local cfg = platformSettingCfg[btplatformId]

		if cfg.junpType == 1 then
			UIStateManager.instance:push(ViewName.SaintKnightRegressAddressView, activityId)
		elseif cfg.junpType == 2 then
			UnityEngine.Application.OpenURL(cfg.params)
		elseif cfg.junpType == 3 then
			local superPrizeId = SaintKnightRegressModel.instance:getSuperPrizeId(activityId)
			local superPrizeCfg = SaintKnightRegressConfig.instance:getSuperLotteryPrizeCfg(activityId, superPrizeId)
			local content = langPara(cfg.params, MaterialMgr.getMaterialsNameByCfg(superPrizeCfg.prize))

			TipsFacade.instance:openTipWindow(lang("提示"), content)
		else
			UIStateManager.instance:push(ViewName.SaintKnightRegressAddressView, activityId)
		end
	else
		UIStateManager.instance:push(ViewName.SaintKnightRegressAddressView, activityId)
	end
end

SaintKnightRegressController.instance = SaintKnightRegressController.New()

return SaintKnightRegressController
