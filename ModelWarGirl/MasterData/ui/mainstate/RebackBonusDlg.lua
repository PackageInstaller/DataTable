-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\RebackBonusDlg.lua

local ResRefluxOnceAward = require("ClientData/ResRefluxOnceAward")
local ResRefluxFlag = require("ClientData/ResRefluxFlag")
local ResActivityRebackConfig = require("ClientData/ResActivityRebackConfig")
local RebackBonusOncePanel = Class("RebackBonusOncePanel", UIControls.Child)

function RebackBonusOncePanel:ctor()
	self.btnGet = UIControls.Button(self, "BtnGot")

	self.btnGet:addEventClick(self.onGetClick)

	self.gridsAward = {}
	self.labelGet = UIControls.Label(self, "BtnGot/Text")
	self.labelGetDis = UIControls.Label(self, "BtnGot/TextDis")
end

function RebackBonusOncePanel:setData(rData, got)
	self.waiting = false
	self.rData = rData
	self.got = got

	ClientUtils.CreateBonusGrid(self, self.gridsAward, "AwardPanel", rData.award_id, true, nil, true)

	if got then
		self.labelGet:setVisible(false)
		self.labelGetDis:setVisible(true)
	else
		self.labelGet:setVisible(true)
		self.labelGetDis:setVisible(false)
	end
end

function RebackBonusOncePanel:onGetClick()
	if self.got then
		self:onNextPage(self)
	elseif not self.waiting then
		RPC.refluxGetOnceAward(self.rData.index)

		self.waiting = true
	end
end

function RebackBonusOncePanel:onOpenPanel()
	self:setVisible(true)

	if self.rData.enter_anim then
		self:playAni(self.rData.enter_anim, nil, true)
	end
end

function RebackBonusOncePanel:onNextPage()
	if self.rData.close_anim then
		self:playAni(self.rData.close_anim, Slot(self.onCloseAnimOver, self), true)
	else
		self:onCloseAnimOver()
	end
end

function RebackBonusOncePanel:onGetResp()
	for _, grid in ipairs(self.gridsAward) do
		if grid and grid.flyToCommonFuncEntryPanel then
			grid:flyToCommonFuncEntryPanel()
		end
	end

	self:setData(self.rData, true)
	self:onNextPage()
end

function RebackBonusOncePanel:onCloseAnimOver()
	self:setVisible(false)
	self.mParent:onNextPage(self)
end

local BTN_CONFIG = {
	btnSignIn = {
		1,
		"BtnPanel/BtnReturnAwardSignIn"
	},
	btnGift = {
		2,
		"BtnPanel/BtnReturnAwardGiftPack"
	},
	btnDayUp = {
		3,
		"BtnPanel/BtnReturnAwardPrivilege"
	},
	btnBP = {
		4,
		"BtnPanel/BtnReturnAwardBP"
	}
}
local RebackBonusInfoPanel = Class("RebackBonusInfoPanel", UIControls.Child)

function RebackBonusInfoPanel:ctor()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnOnceBonus = UIControls.Button(self, "BtnPanel/BtnReturnAwardAgain")

	self.btnOnceBonus:addEventClick(self.onOnceBonusClick)

	self.configBtns = {}
	self.configRedDot = {}
end

function RebackBonusInfoPanel:onCloseClick()
	self.mParent:setVisible(false)
end

function RebackBonusInfoPanel:onOpenPanel()
	if not self.inited then
		self.inited = true
		self.rebackFlag = self.mParent.rebackFlag

		local config = ResActivityRebackConfig[self.rebackFlag] or {}

		for btnName, btnConfig in pairs(BTN_CONFIG) do
			if config[btnConfig[1]] then
				local newBtn = UIControls.Button(self, btnConfig[2])
				local newRD = UIControls.RedDot(self, btnConfig[2] .. "/IconNew")

				newBtn.configData = config[btnConfig[1]]

				newBtn:addEventClick(self.onRebackConfigClick)
				table.insert(self.configBtns, newBtn)

				if newBtn.configData.act_id and UIConst.ACTIVITY_RED_DOT_CONFIG[newBtn.configData.act_id] then
					newRD:addHint({
						UIConst.ACTIVITY_RED_DOT_CONFIG[newBtn.configData.act_id]
					})
				end

				table.insert(self.configRedDot, newRD)
			end
		end
	end

	self:setVisible(true)
	self:playAni("ShowChildReturnAwardOther", nil, true)
end

function RebackBonusInfoPanel:onRebackConfigClick(sender)
	local configData = sender.configData

	if configData.jump_id then
		JumpGuideManager.jump(configData.jump_id)
	elseif configData.act_id then
		CurAvatar:jumpToShowActivity(configData.act_id)
	end
end

function RebackBonusInfoPanel:onOnceBonusClick()
	self:setVisible(false)
	self.mParent:onOpenPage(1)
end

local strClassName = "RebackBonusDlg"
local RebackBonusDlg = Class(strClassName, UIControls.Window)

function RebackBonusDlg:ctor()
	self:initUI()
end

function RebackBonusDlg:initUI()
	self.oncePanels = {}
	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventAnimateCue(self.onAnimateCue)

	self.bgTitle = UIControls.Image(self, "BgPanel/ImgText")
end

function RebackBonusDlg:onAnimateCue(cueName)
	local startIndex

	for index, cell in ipairs(self.oncePanels) do
		local rData = cell.rData

		if not self.rebackBonusDict[rData.index] then
			startIndex = index

			break
		end
	end

	self:onOpenPage(startIndex)
end

function RebackBonusDlg:onShow(rebackFlag, rebackBonusDict, fromOnceBonus)
	self.rebackFlag = rebackFlag
	self.rebackGroup = CurAvatar.rebackGroup
	self.rebackBonusDict = rebackBonusDict
	self.rebackData = ResRefluxOnceAward[self.rebackFlag]

	local flagData = ResRefluxFlag[self.rebackFlag]
	local prefabPath = "System/Return/ChildReturnAwardOther"

	if flagData and flagData.info_prefab then
		prefabPath = "System/Return/" .. ResRefluxFlag[self.rebackFlag].info_prefab
	end

	if flagData and flagData.title_icon then
		self.bgTitle:setImage(flagData.title_icon_path, flagData.title_icon)
	end

	self.curInfoPage = RebackBonusInfoPanel(self, "BgPanel/ReturnAwardInfoPanel", prefabPath)

	if self.rebackData then
		local showNum = 1

		for index, rData in ipairs(self.rebackData) do
			local dataGroup = rData.group_id

			if not self.oncePanels[showNum] and (dataGroup == nil or dataGroup == 0 or dataGroup == self.rebackGroup) then
				local newPanel = RebackBonusOncePanel(self, "BgPanel/ReturnAwardInfoPanel", "System/Return/" .. rData.prefab_path)

				newPanel:setData(rData, self.rebackBonusDict[index])

				newPanel.index = showNum

				table.insert(self.oncePanels, newPanel)

				showNum = showNum + 1
			end
		end
	end

	if fromOnceBonus then
		self.aniSelf:startAni("ShowReturnAwardWin", true)
	else
		self.aniSelf:startAni("ShowReturnAwardWin2", true)
	end
end

function RebackBonusDlg:onNextPage(page)
	local nowIndex = page.index

	self:onOpenPage(nowIndex + 1)
end

function RebackBonusDlg:onOpenPage(openIndex)
	self.nowPage = self.oncePanels[openIndex]

	if self.nowPage then
		self.nowPage:onOpenPanel()
	elseif not CurAvatar:rebackEntryEnable() then
		self:setVisible(false)
	else
		self.curInfoPage:onOpenPanel()
	end
end

function RebackBonusDlg:onGetResp(index)
	if self.nowPage and self.nowPage.rData.index == index then
		self.nowPage:onGetResp()
	end
end

return RebackBonusDlg
