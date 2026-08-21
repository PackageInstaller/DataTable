-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfareFirstRecharge.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local FirstRechargeCell = Class("FirstRechargeCell", UIControls.Panel)

function FirstRechargeCell:ctor()
	self.grids = {}
	self.textTime = UIControls.Label(self, self.mPath .. "/TextTime")
	self.btnGet = UIControls.Button(self, self.mPath .. "/BtnGet", "Text")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.imgGet = UIControls.Panel(self, self.mPath .. "/ImgGet")
	self.panelHasFinish = UIControls.Panel(self, self.mPath .. "/ImgHave")
	self.panelState = UIControls.Label(self, self.mPath .. "/TextState")
end

function FirstRechargeCell:setData(index, targetInfo)
	self.index = index
	self.targetInfo = targetInfo

	ClientUtils.CreateBonusGrid(self, self.grids, self.mPath .. "/GridPanel", targetInfo.reward, true, nil, true, {
		isShowPreviewTips = true
	})
end

function FirstRechargeCell:onBtnGetClick()
	if not self.clickDisable then
		RPC.rechargeGetFirstAward(self.index - 1)

		if self.index == 2 then
			CurAvatar:tryOpenGameEvaluateDlg("FirstRechargeCell_666")
		elseif self.index == 3 then
			CurAvatar:tryOpenGameEvaluateDlg("FirstRechargeCell_888")
		end
	else
		MsgManager.notice(Lang.get(30782))
	end
end

local DESC_CONFIG = {
	Lang.get(30783),
	Lang.get(30784),
	Lang.get(29695)
}

function FirstRechargeCell:refreshState(hasBuy, firstRechargeData)
	if hasBuy then
		ClientTimerManager.RemoveSecondTickUI(self.textTime)

		if firstRechargeData.gotState[self.index] then
			self.btnGet:setVisible(false)
			self.btnGet:setEnable(false)
			self.panelHasFinish:setVisible(true)
			self.imgGet:setVisible(false)

			for _, grid in ipairs(self.grids) do
				grid:setGet(true)
			end

			self.textTime:setText("")
			self.panelState:setVisible(false)
		else
			self.panelHasFinish:setVisible(false)

			for _, grid in ipairs(self.grids) do
				grid:setGet(false)
			end

			self.textTime:setText(DESC_CONFIG[self.index])

			if CurAvatar:firstRichargeEnable(self.targetInfo.target_type, self.targetInfo.target_args) then
				self.btnGet:setVisible(true)
				self.btnGet:setEnable(true)
				self.btnGet:setText(Lang.get(38))
				self.imgGet:setVisible(true)
			else
				if self.index == 3 then
					local second = ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime()

					ClientTimerManager.AddSecondTickUI(self.panelState, second, false, "", "")
				end

				self.btnGet:setVisible(false)
				self.imgGet:setVisible(false)
			end
		end
	else
		self.panelHasFinish:setVisible(false)
		self.btnGet:setVisible(false)
		self.imgGet:setVisible(false)
		self.textTime:setText(DESC_CONFIG[self.index])
	end
end

local strClassName = "WelfareFirstRecharge"
local WelfareFirstRecharge = Class(strClassName, UIControls.Window)

function WelfareFirstRecharge:ctor()
	self:initUI()
end

local MAX_CELL_NUM = 3

function WelfareFirstRecharge:initUI()
	self.btnFunc = UIControls.Button(self, "Bg/BtnFunc", "Text")

	self.btnFunc:addEventClick(self.onBtnClick)

	self.panelTitle = UIControls.Panel(self, "Bg/ImgTitle")

	local voiceId = UIMiscConfig.VOCAL_ID_FIRST_RECHARGE

	CueManager.playGroupVocal(voiceId)

	self.cells = {}

	for index = 1, MAX_CELL_NUM do
		local targetInfo = CurAvatar.firstRechargeConfig.first_recharge_detail[index]
		local newCell = FirstRechargeCell(self, "Bg/AwardPanel/Day" .. index)

		newCell:setData(index, targetInfo)
		table.insert(self.cells, newCell)
	end

	self.textExtraNum = UIControls.Label(self, "Bg/BgDec/TextNum")

	self.textExtraNum:setText(CurAvatar.firstRechargeConfig.first_recharge_extra_money)
end

function WelfareFirstRecharge:onShow()
	self.data = CurAvatar:getFirstRechargeData()

	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_FIRST_REC, UIMiscConfig.FIRST_RECHARGE_UI_ID)

	if self.data.maxRecharge >= CurAvatar.firstRechargeConfig.first_recharge_money_limit and self.data.newRecharge then
		self.btnFunc:setVisible(false)
		self.panelTitle:setVisible(false)

		for index, cell in ipairs(self.cells) do
			cell:refreshState(true, self.data)
		end
	else
		self.btnFunc:setVisible(true)
		self.panelTitle:setVisible(true)

		for index, cell in ipairs(self.cells) do
			cell:refreshState(false, self.data)
		end
	end
end

function WelfareFirstRecharge:onBtnClick()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_JUMP)

	if ClientUtils.JumpToFirstRecharge() then
		self:hidePanel()
	end
end

function WelfareFirstRecharge:hidePanel()
	self:setVisible(false)
end

function WelfareFirstRecharge:onClose()
	WelfareFirstRecharge.super.onClose(self)
end

return WelfareFirstRecharge
