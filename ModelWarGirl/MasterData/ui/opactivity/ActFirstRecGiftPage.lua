-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActFirstRecGiftPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResRandClient = require("ClientData/ResRandClient")
local EventConst = require("EventConst")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local strClassName = "ActFirstRecGiftPage"
local ActFirstRecGiftPage = Class(strClassName, UIControls.Child)

MixinClass(ActFirstRecGiftPage, ActivityPanelMixin)

function ActFirstRecGiftPage:ctor()
	self.items = {}
	self.state = 0
end

function ActFirstRecGiftPage:initUI()
	self.btnFunc = UIControls.Button(self, "BtnFunc", "Text")

	self.btnFunc:addEventClick(self.onBtnClick)

	self.txtTip = UIControls.Label(self, "TextDes")

	self.txtTip:setText(ResClientNotice[188].notice)

	self.imgState = UIControls.Image(self, "ImgState")
	self.imgNew = UIControls.Image(self, "BtnFunc/IconNew")
end

function ActFirstRecGiftPage:_setData()
	self.data = CurAvatar:getFirstRechargeData()

	for _, item in ipairs(self.items) do
		item:setVisible(false)
	end

	local awardData = ResRandClient[self.data.first_recharge_award]

	for idx, id in ipairs(awardData.show_ids) do
		local item = BaseObject.GetObject(id, awardData.show_nums[idx])

		if not self.items[idx] then
			self.items[idx] = UIControls.getGridChild(item, self, "AwardPanel")
		end

		self.items[idx]:setVisible(true)

		self.items[idx].mDisableWays = true
		self.items[idx].isShowPreviewTips = true

		self.items[idx]:setObj(item)
	end

	self:refreshUI()
end

function ActFirstRecGiftPage:_onShow(isOnPageShow)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_FIRST_REC, UIMiscConfig.FIRST_RECHARGE_UI_ID)

	local voiceId = UIMiscConfig.VOCAL_ID_FIRST_RECHARGE

	if isOnPageShow == true then
		CueManager.playGroupVocal(voiceId)
	end
end

function ActFirstRecGiftPage:refreshUI()
	self.imgNew:setVisible(false)

	if self.data.hasGet == 1 then
		self.imgState:setVisible(true)
		self.btnFunc:setVisible(false)
	elseif self.data.first_recharge_money_limit < self.data.maxRecharge then
		self.state = 1

		self.btnFunc:setText(Lang.get(38))
		self.imgState:setVisible(false)
		self.imgNew:setVisible(true)
	else
		self.state = 0

		self.btnFunc:setText(Lang.get(73))
		self.imgState:setVisible(false)
	end
end

function ActFirstRecGiftPage:onRefreshBanner()
	self.data = CurAvatar:getFirstRechargeData()

	self:refreshUI()
end

function ActFirstRecGiftPage:onBtnClick()
	if self.state == 0 then
		if ClientUtils.JumpToFirstRecharge() then
			self:hidePanel()
		end
	else
		CueManager.stopVocal()

		local vioceId = UIMiscConfig.VOCAL_ID_FIRST_REC_JUMP

		CueManager.playVocal(vioceId)
		RPC.rechargeGetFirstAward()
	end
end

function ActFirstRecGiftPage:hidePanel()
	return
end

function ActFirstRecGiftPage:onClose()
	ActFirstRecGiftPage.super.onClose(self)
end

return ActFirstRecGiftPage
