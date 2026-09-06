-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyscene/view/FamilySceneMainView.lua

module("logic.extensions.familyscene.view.FamilySceneMainView", package.seeall)

local FamilySceneMainView = class("FamilySceneMainView", ViewComponent)

function FamilySceneMainView:buildUI()
	FamilySceneMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnChat = self:getBtn("Nego_Chat")
	self._btnShop = self:getBtn("btnShop")
	self._btnInfo = self:getBtn("btnInfo")
	self._btnChannels = self:getBtn("channels/btn")
	self._goldBarCon = self:getGo("goldBarCon")
	self._channelsGo = self:getGo("channels")
	self._txtChannel = self:getTxt("channels/txt")
	self._txtFamilyName = self:getTxt("family/txtName")
	self._txtFamilyLv = self:getTxt("family/txtLv")
	self._container = self:getGo("container")
	self._infoRedPoint = self:getGo("btnInfo/redPoint")
end

function FamilySceneMainView:bindEvents()
	FamilySceneMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChat, self._onClickChat, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnChannels, self._onClickChannels, self)
end

function FamilySceneMainView:unbindEvents()
	FamilySceneMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChat)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnChannels)
end

function FamilySceneMainView:onEnter()
	FamilySceneMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FamilySceneGetAllChannelInfosRes, self._onGetAllChannelInfosRes, self)
	self.addGEvent(self, GlobalNotify.FamilySceneNotifySwitchChannel, self._onNotifySwitchChannel, self)
	self.addGEvent(self, GlobalNotify.FamilyScenePlayerEnterScene, self._onPlayerEnterScene, self)
	self.addGEvent(self, GlobalNotify.FamilyScenePlayerLeaveScene, self._onPlayerLeaveScene, self)
	self.addGEvent(self, GlobalNotify.FamilyPartyNotifyPartyBeginRes, self._onFamilyPartyNotifyPartyBeginRes, self)
	self.addGEvent(self, GlobalNotify.FamilyPartyNotifyPartyEndRes, self._onFamilyPartyNotifyPartyEndRes, self)
	self.addGEvent(self, FamilyController.OnGetMyFamilyInfoRes, self._onGetMyFamilyInfoRes, self)
	self.addGEvent(self, GlobalNotify.FamilyUpdateTabRedpoints, self._updateRedPoints, self)
	self:_setTopGoldBar(self._goldBarCon, "8:27#8:5")
	self:_initChannels()
	self:_updateGosByParty()
	self:_updatePartyView()
	self:_updateFamilyInfo()
	self:_updateRedPoints()
	FamilyController.instance:getMyFamilyInfoReq()
	FamilySceneAgent.instance:sendPM_Cube_GetAllChannelInfosReq()

	local params = FamilySceneController.instance:getOpenViewParam()

	if params and params[1] then
		FamilyController.instance:openFamilyView(unpack(params))
	end
end

function FamilySceneMainView:onExit()
	FamilySceneMainView.super.onExit(self)
end

function FamilySceneMainView:_onClickClose()
	FamilySceneController.instance:leaveScene()
end

function FamilySceneMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "familyscenemainview_rule")
end

function FamilySceneMainView:_onClickChat()
	FuncOpenController.instance:openFunc(55)
end

function FamilySceneMainView:_onClickShop()
	GotoMgr.gotoByString("func#470#ExchangeFamily")
end

function FamilySceneMainView:_onClickInfo()
	FamilySceneController.instance:openInfoView()
end

function FamilySceneMainView:_onClickChannels()
	FamilySceneController.instance:openChannelsView()
end

function FamilySceneMainView:_onGetAllChannelInfosRes()
	self:_updateChannels()
end

function FamilySceneMainView:_onNotifySwitchChannel()
	FamilySceneAgent.instance:sendPM_Cube_GetAllChannelInfosReq()

	local channelId = FamilySceneModel.instance:getCurChannelId()
	local name = FamilySceneModel.instance:getCurChannelName(channelId)

	FloatWordMgr.instance:show("已成功切换频道至 " .. name)
end

function FamilySceneMainView:_onPlayerEnterScene()
	self:_updateChannels()
end

function FamilySceneMainView:_onPlayerLeaveScene()
	self:_updateChannels()
end

function FamilySceneMainView:_onFamilyPartyNotifyPartyBeginRes()
	self:_updateGosByParty()
	self:_updatePartyView()
end

function FamilySceneMainView:_onFamilyPartyNotifyPartyEndRes()
	self:_updateGosByParty()
	self:_updatePartyView()
end

function FamilySceneMainView:_onGetMyFamilyInfoRes()
	self:_updateFamilyInfo()
	self:_updateRedPoints()
end

function FamilySceneMainView:_initChannels()
	goutil.setActive(self._channelsGo, false)
end

function FamilySceneMainView:_updateChannels()
	goutil.setActive(self._channelsGo, true)

	local channelId = FamilySceneModel.instance:getCurChannelId()
	local name = FamilySceneModel.instance:getCurChannelName(channelId)
	local curEntityCount, maxEntityCount = FamilySceneModel.instance:getCurChannelEntityCount(channelId)

	self._txtChannel.text = string.format("%s(%d/%d)", name, curEntityCount, maxEntityCount)
end

function FamilySceneMainView:_updateGosByParty()
	if FamilyPartyModel.instance:isPartyOpening() then
		GameUtil.SetActive(self._goldBarCon, false)
	else
		GameUtil.SetActive(self._goldBarCon, true)
	end
end

function FamilySceneMainView:_updatePartyView()
	if FamilyPartyModel.instance:isPartyOpening() then
		if not ViewMgr.instance:isOpen(ViewName.FamilyPartyMainView) then
			self:showTabAt(self._container, ViewName.FamilyPartyMainView)
		end
	else
		self:showTabAt(self._container, nil)
	end
end

function FamilySceneMainView:_updateFamilyInfo()
	self._txtFamilyName.text = FamilyModel.instance:getFamilyName()
	self._txtFamilyLv.text = langPara("Lv.%d", FamilyController.instance:getFamilyLv())
end

function FamilySceneMainView:_isShowRedPoint()
	if self._cfgTabs then
		self._cfgTabs = self._cfgTabs or FamilyConfig.instance:getFamilyActivityTabCfgs()
	end

	for _, cfg in ipairs(self._cfgTabs) do
		local ids = string.split(cfg.redIds, "#")

		for _, v in pairs(ids or {}) do
			if RedPointModel.instance:isActive(v) then
				return true
			end
		end
	end

	return false
end

function FamilySceneMainView:_updateRedPoints()
	GameUtil.SetActive(self._infoRedPoint, self:_isShowRedPoint())
end

return FamilySceneMainView
