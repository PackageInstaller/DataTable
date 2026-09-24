-- chunkname: @modules/logic/activity/view/v4a0_stonegift/VersionActivity4_0StoneGiftFullView.lua

module("modules.logic.activity.view.v4a0_stonegift.VersionActivity4_0StoneGiftFullView", package.seeall)

local VersionActivity4_0StoneGiftFullView = class("VersionActivity4_0StoneGiftFullView", BaseView)

function VersionActivity4_0StoneGiftFullView:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "Root/skin/#btn_click")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/title/#simage_Title")
	self._simageTxt = gohelper.findChildSingleImage(self.viewGO, "Root/title/#simage_Txt")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "Root/title/image_TimeBG/#txt_remainTime")
	self._goreward1 = gohelper.findChild(self.viewGO, "Root/reward/#go_reward1")
	self._goreward2 = gohelper.findChild(self.viewGO, "Root/reward/#go_reward2")
	self._btncliam = gohelper.findChildButtonWithAudio(self.viewGO, "Root/btn/#btn_cliam")
	self._btnuse = gohelper.findChildButtonWithAudio(self.viewGO, "Root/btn/#btn_use")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/btn/#go_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity4_0StoneGiftFullView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btncliam:AddClickListener(self._btncliamOnClick, self)
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
end

function VersionActivity4_0StoneGiftFullView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btncliam:RemoveClickListener()
	self._btnuse:RemoveClickListener()
end

function VersionActivity4_0StoneGiftFullView:_btnuseOnClick()
	local itemcount = ItemModel.instance:getItemCount(self._itemId)

	if itemcount <= 0 then
		return
	end

	DestinyStoneGiftPickChoiceController.instance:openHeroChoiceView(self._itemId)
end

function VersionActivity4_0StoneGiftFullView:_btnclickOnClick()
	local itemco = ItemConfig.instance:getItemCo(self._itemId)

	if string.nilorempty(itemco.effect) then
		return
	end

	DestinyStoneGiftPickChoiceController.instance:openHeroChoicePreview(nil, self._itemId)
end

function VersionActivity4_0StoneGiftFullView:_btncliamOnClick()
	local hasGet = ActivityType101Model.instance:isType101RewardGet(self._actId, 1)

	if hasGet then
		return
	end

	local canGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1)

	if not canGet then
		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1)
end

function VersionActivity4_0StoneGiftFullView:_addSelfEvents()
	self.addEventCb(self, BackpackController.instance, BackpackEvent.onUseItemFinished, self._refresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity4_0StoneGiftFullView:_removeSelfEvents()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.onUseItemFinished, self._refresh, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function VersionActivity4_0StoneGiftFullView:_onCloseView(viewName)
	if viewName ~= ViewName.CharacterGetView then
		return
	end

	self:_refresh()
end

function VersionActivity4_0StoneGiftFullView:_editableInitView()
	self:_addSelfEvents()
end

function VersionActivity4_0StoneGiftFullView:_initRewards()
	self._rewardItems = {}

	local actCo = ActivityConfig.instance:getNorSignActivityCo(self._actId, 1)
	local rewards = string.split(actCo.bonus, "|")

	for i = 1, #rewards do
		self._rewardItems[i] = {}
		self._rewardItems[i].go = self["_goreward" .. i]
		self._rewardItems[i].reward = rewards[i]
		self._rewardItems[i].simageicon = gohelper.findChildSingleImage(self._rewardItems[i].go, "simage_icon")
		self._rewardItems[i].gohasget = gohelper.findChild(self._rewardItems[i].go, "go_hasget")
		self._rewardItems[i].btncheck = gohelper.findChildButtonWithAudio(self._rewardItems[i].go, "btn_check")

		self._rewardItems[i].btncheck:AddClickListener(self._btncheckOnClick, self, i)

		local rewardCos = string.splitToNumber(rewards[i], "#")
		local _, itemIcon = ItemModel.instance:getItemConfigAndIcon(rewardCos[1], rewardCos[2])

		self._rewardItems[i].simageicon:LoadImage(itemIcon)
	end
end

function VersionActivity4_0StoneGiftFullView:_btncheckOnClick(index)
	local rewardCos = string.splitToNumber(self._rewardItems[index].reward, "#")

	MaterialTipController.instance:showMaterialInfo(rewardCos[1], rewardCos[2])
end

function VersionActivity4_0StoneGiftFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId
	self._itemId = DestinyStoneGiftPickChoiceEnum.V4a0ItemId

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
	self:_initRewards()
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
	self:_refresh()
end

function VersionActivity4_0StoneGiftFullView:_refreshTime()
	self._txtremainTime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function VersionActivity4_0StoneGiftFullView:_refresh()
	local hasGet = ActivityType101Model.instance:isType101RewardGet(self._actId, 1)
	local itemcount = ItemModel.instance:getItemCount(self._itemId)
	local canUse = itemcount > 0

	gohelper.setActive(self._btncliam.gameObject, not hasGet)
	gohelper.setActive(self._btnuse.gameObject, hasGet and canUse)
	gohelper.setActive(self._gohasget, hasGet and not canUse)

	if self._rewardItems then
		for i = 1, #self._rewardItems do
			gohelper.setActive(self._rewardItems[i].gohasget, hasGet)
		end
	end
end

function VersionActivity4_0StoneGiftFullView:onClose()
	return
end

function VersionActivity4_0StoneGiftFullView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTime, self)

	if self._rewardItems then
		for i = 1, #self._rewardItems do
			self._rewardItems[i].simageicon:UnLoadImage()
			self._rewardItems[i].btncheck:RemoveClickListener()
		end

		self._rewardItems = nil
	end

	self:_removeSelfEvents()
end

return VersionActivity4_0StoneGiftFullView
