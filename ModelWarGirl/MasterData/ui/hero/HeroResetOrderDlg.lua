-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroResetOrderDlg.lua

local ResetPositionPanel = require("UI/Hero/ResetPositionPanel")
local HeroResetDlg = require("UI/Hero/HeroResetDlg")
local strClassName = "HeroResetOrderDlg"
local HeroResetOrderDlg = Class(strClassName, HeroResetDlg)
local ConsumeTips = require("System/ConsumeTips")

function HeroResetOrderDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/ResetPanel/BtnConfirm", "Num")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgCost = UIControls.Image(self, "BgPanel/ResetPanel/BtnConfirm/Icon")
	self.panelEquip = UIControls.Panel(self, "BgPanel/ResetPanel/EquipRewardPanel")
	self.txtTitle = UIControls.Label(self, "BgPanel/ResetPanel/ItemRewardPanel/TextTitle")
	self.txtRule = UIControls.Label(self, "BgPanel/ResetPanel/TextRule")
	self.txtDlgTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.imgNothing = UIControls.Image(self, "BgPanel/ResetPanel/EquipRewardPanel/ImgNothing")
	self.panelResetPosition = ResetPositionPanel(self, "BgPanel/ResetPositionPanel")
end

function HeroResetOrderDlg:setHero(hero, resetType)
	HeroResetOrderDlg.super.setHero(self, hero, resetType)

	if self.hero:getResetStepCD() > 0 then
		self.panelResetPosition:setVisible(true)
		self.panelResetPosition:setHero(self.hero)
	else
		self.panelResetPosition:setVisible(false)
	end
end

function HeroResetOrderDlg:resetHero()
	if self.resetType == Const.HERO_RESET_STEP and self.hero:getResetStepCD() > 0 then
		local usablePos = self.panelResetPosition:getUsablePos()
		local nearUnlockedLimitId = self.panelResetPosition:getNearUnlockedPosLimitId()

		if usablePos then
			local function yesFunc()
				self:showTips()
			end

			local stepName = self.hero:getStepDes()

			if stepName then
				local msgContent = utils.format(Lang.get(30353), stepName.step_name, usablePos, ClientUtils.getTimeStrBySecond(self.hero:getResetStepCD()))

				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
			end
		elseif nearUnlockedLimitId then
			local limitDesc = ConditionLimitManager.getLimitUnlockDesc(nearUnlockedLimitId)
			local msgContent = string.format(Lang.get(30354), limitDesc)

			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(5), msgContent)
		else
			MsgManager.clientNotice(272)
		end
	else
		self:showTips()
	end
end

function HeroResetOrderDlg:showTips()
	ConsumeTips.showTipsDiamond(self.cosumeInfo.num, Const.CONSUME_DIAMOND_RESET_STEP, 1, Slot(self.realConfirmReset, self), Slot(self.onBtnCloseClick, self))
end

function HeroResetOrderDlg:realConfirmReset()
	if not self.btnLock and self.resetType == Const.HERO_RESET_STEP then
		if self.hero:getResetStepCD() > 0 then
			local usablePos = self.panelResetPosition:getUsablePos()
			local nearUnlockedLimitId = self.panelResetPosition:getNearUnlockedPosLimitId()

			if usablePos then
				self.btnLock = true

				RPC.heroStepReset(self.hero.gid, usablePos - 1)
			elseif nearUnlockedLimitId then
				local limitDesc = ConditionLimitManager.getLimitUnlockDesc(nearUnlockedLimitId)
				local msgContent = string.format(Lang.get(30354), limitDesc)

				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(5), msgContent)
			else
				MsgManager.clientNotice(272)
			end
		else
			self.btnLock = true

			RPC.heroStepReset(self.hero.gid)
		end
	end
end

return HeroResetOrderDlg
