-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/GroupRegressInvitePopView.lua

module("logic.extensions.groupregress.view.GroupRegressInvitePopView", package.seeall)

local GroupRegressInvitePopView = class("GroupRegressInvitePopView", ViewComponent)
local InviteTemplateId = 96
local ChannelInviteCd = 10
local NextChannelInviteTime = 0

function GroupRegressInvitePopView:buildUI()
	GroupRegressInvitePopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnCopy = self:getGo("btnCopy")
	self._btnShare = self:getGo("btnShare")
	self._btnSend = self:getGo("btnSend")
	self._txtMyCode = self:getTxt("myCode/txtMyCode")
	self._txtNewCount = self:getTxt("myCode/txtNewCount")
	self._txtRegressCount = self:getTxt("myCode/txtRegressCount")
	self._newPlayerPrizeItem = self:getGo("prizeCol/newPlayerPrize/item")
	self._btnGetNewPlayerPrize = self:getGo("prizeCol/newPlayerPrize/btnGet")
	self._tagHasGainNewPlayerPrize = self:getGo("prizeCol/newPlayerPrize/tagHasGain")
	self._effRootNewPlayerPrize = self:getGo("prizeCol/newPlayerPrize/effRoot")
	self._regressPlayerPrizeItem = self:getGo("prizeCol/regressPlayerPrize/item")
	self._btnGetRegressPlayerPrize = self:getGo("prizeCol/regressPlayerPrize/btnGet")
	self._tagHasGainRegressPlayerPrize = self:getGo("prizeCol/regressPlayerPrize/tagHasGain")
	self._effRootRegressPlayerPrize = self:getGo("prizeCol/regressPlayerPrize/effRoot")
end

function GroupRegressInvitePopView:bindEvents()
	GroupRegressInvitePopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCopy, self._onClickBtnCopy, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickBtnShare, self)
	GameUtil.addClickHandler(self._btnSend, self._onClickBtnSend, self)
	GameUtil.addClickHandler(self._btnGetNewPlayerPrize, GameUtil.handler(self._onClickOncePrize, self, GroupRegressEnum.PlayerType.New))
	GameUtil.addClickHandler(self._btnGetRegressPlayerPrize, GameUtil.handler(self._onClickOncePrize, self, GroupRegressEnum.PlayerType.Regress))
end

function GroupRegressInvitePopView:unbindEvents()
	GroupRegressInvitePopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCopy)
	GameUtil.rmClickHandler(self._btnShare)
	GameUtil.rmClickHandler(self._btnSend)
	GameUtil.rmClickHandler(self._btnGetNewPlayerPrize)
	GameUtil.rmClickHandler(self._btnGetRegressPlayerPrize)
end

function GroupRegressInvitePopView:onEnter()
	GroupRegressInvitePopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._teamType = GroupRegressEnum.TeamType.InviteOwner
	self._subMo = GroupRegressController.instance:getSubMo(self._activityId)
	self._actData = GroupRegressConfig.instance:getActivityData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self:_updateBtnShareCd()
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressGetTeamInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressGainOncePrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressNotifyNewMemberRes, self._onUpdate, self)
	GroupRegressController.instance:sendPM_GroupRegressGetTeamInfoReq(self._activityId, self._teamType)
end

function GroupRegressInvitePopView:onExit()
	GroupRegressInvitePopView.super.onExit(self)
	removetimer(self._onBtnShareCdTimer, self)
	GameUtil.SetGray(self._btnShare, false)
	MaterialMgr.resetAll(self._newPlayerPrizeItem)
	MaterialMgr.resetAll(self._regressPlayerPrizeItem)
	self:stopViewEffectUniGo(self._effRootNewPlayerPrize)
	self:stopViewEffectUniGo(self._effRootRegressPlayerPrize)
end

function GroupRegressInvitePopView:_onSetUI()
	MaterialMgr.setCellByCfg(self._actData.inviteNewPlayerPrize, self._newPlayerPrizeItem)
	MaterialMgr.setCellByCfg(self._actData.inviteRegressPlayerPrize, self._regressPlayerPrizeItem)
end

function GroupRegressInvitePopView:_onUpdate()
	self._txtMyCode.text = self._subMo:getMyCode()

	self:_updateInviteCount()
	self:_updateOncePrizeCol()
end

function GroupRegressInvitePopView:_updateInviteCount()
	local newPlayerCount = self._subMo:getInvitePlayerTypeCount(self._teamType, GroupRegressEnum.PlayerType.New)
	local regressPlayerCount = self._subMo:getInvitePlayerTypeCount(self._teamType, GroupRegressEnum.PlayerType.Regress)
	local maxNewPlayerCount = checknumber(self._actData.maxInviteNewPlayerCnt)
	local maxRegressPlayerCount = checknumber(self._actData.maxInviteRegressPlayerCnt)

	self._txtNewCount.text = string.format("%s/%s", newPlayerCount, maxNewPlayerCount)
	self._txtRegressCount.text = string.format("%s/%s", regressPlayerCount, maxRegressPlayerCount)
end

function GroupRegressInvitePopView:_updateOncePrizeCol()
	self:_updateOncePrize(GroupRegressEnum.PlayerType.New, self._btnGetNewPlayerPrize, self._tagHasGainNewPlayerPrize, self._effRootNewPlayerPrize)
	self:_updateOncePrize(GroupRegressEnum.PlayerType.Regress, self._btnGetRegressPlayerPrize, self._tagHasGainRegressPlayerPrize, self._effRootRegressPlayerPrize)
end

function GroupRegressInvitePopView:_updateOncePrize(playerType, btnGet, tagHasGain, effRoot)
	local isGain = self._subMo:isGainInviteOncePrize(self._teamType, playerType)
	local isCanGet = self._subMo:isCanGetInviteOncePrize(self._teamType, playerType)

	GameUtil.SetActive(btnGet, isCanGet)
	GameUtil.SetActive(tagHasGain, isGain)

	if isCanGet then
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effRoot, nil, true, nil)
	else
		self:stopViewEffectUniGo(effRoot)
	end
end

function GroupRegressInvitePopView:_onClickOncePrize(playerType)
	if self._subMo:isGainInviteOncePrize(self._teamType, playerType) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self._subMo:isCanGetInviteOncePrize(self._teamType, playerType) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	GroupRegressController.instance:sendPM_GroupRegressGainOncePrizeReq(self._activityId, playerType == GroupRegressEnum.PlayerType.New, self._teamType)
end

function GroupRegressInvitePopView:_onClickBtnCopy()
	local code = self._subMo:getMyCode()

	if string.nilorempty(code) then
		FloatWordMgr.instance:show("邀请码为空")

		return
	end

	Clipboard.copy(string.format("我的队伍：【%s】，长按即可复制，参与任务轻松拿大奖！", code))
	FloatWordMgr.instance:show("邀请码已复制")
end

function GroupRegressInvitePopView:_getBtnShareLeftCd()
	return math.max(0, NextChannelInviteTime - ServerTime.now())
end

function GroupRegressInvitePopView:_updateBtnShareCd()
	local isCding = self:_getBtnShareLeftCd() > 0

	GameUtil.SetGray(self._btnShare, isCding)
	removetimer(self._onBtnShareCdTimer, self)

	if isCding then
		settimer(1, self._onBtnShareCdTimer, self, true)
	end
end

function GroupRegressInvitePopView:_onBtnShareCdTimer()
	local isCding = self:_getBtnShareLeftCd() > 0

	GameUtil.SetGray(self._btnShare, isCding)

	if not isCding then
		removetimer(self._onBtnShareCdTimer, self)
	end
end

function GroupRegressInvitePopView:_onClickBtnShare()
	local dataT = self:_getInviteDataT()

	if dataT == nil then
		FloatWordMgr.instance:show("邀请码为空")

		return
	end

	local leftCd = self:_getBtnShareLeftCd()

	if leftCd > 0 then
		FloatWordMgr.instance:show(string.format("%s秒后可再次发送", math.ceil(leftCd)))

		return
	end

	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Share, GameEnum.ChatType.System, GameUtil.jsonToString(dataT))

	NextChannelInviteTime = ServerTime.now() + ChannelInviteCd

	self:_updateBtnShareCd()
	FloatWordMgr.instance:show("已发送至分享频道")
end

function GroupRegressInvitePopView:_onClickBtnSend()
	local dataT = self:_getInviteDataT()

	if dataT == nil then
		FloatWordMgr.instance:show("邀请码为空")

		return
	end

	ShareController.instance:tryOpenFriendView(dataT)
end

function GroupRegressInvitePopView:_getInviteDataT()
	local code = self._subMo:getMyCode()

	if string.nilorempty(code) then
		return nil
	end

	return {
		tpId = InviteTemplateId,
		params = {
			activityId = self._activityId,
			inviteCode = code
		}
	}
end

return GroupRegressInvitePopView
