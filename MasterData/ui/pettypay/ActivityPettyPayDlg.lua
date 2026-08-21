-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PettyPay\\ActivityPettyPayDlg.lua

local PettyPayDailyGiftPanel = require("UI/PettyPay/PettyPayDailyGiftPanel")
local PettyPay30DaysSignInPanel = require("UI/PettyPay/PettyPay30DaysSignInPanel")
local PettyPayDailyPayPanel = require("UI/PettyPay/PettyPayDailyPayPanel")
local ResPettyPayTab = require("ClientData/ResPettyPayTab")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityAchieveDetail = require("ClientData/ResOpActivityAchieveDetail")
local ResPettyPayTextContent = require("ClientData/ResPettyPayTextContent")
local ResInfoNotice = require("ClientData/ResInfoNotice")
local DragTwoPages = require("UI/Control/DragTwoPages")
local strClassName = "ActivityPettyPayDlg"
local ActivityPettyPayDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityPettyPayDlg, ActivityPanelMixin)

function ActivityPettyPayDlg:ctor(...)
	self:initUI()
end

local constTabType = {
	signIn = 2,
	mianCanvas = 1,
	dailyGift = 3
}

local function stringSplitTonumber(longString)
	local splittedData = utils.splitString(tostring(longString), ",")

	for index = 1, #splittedData do
		splittedData[index] = tonumber(splittedData[index])
	end

	return splittedData
end

function ActivityPettyPayDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.dailyGiftPanel = PettyPayDailyGiftPanel(self, "MainInfoPanel/DailyGiftPanel")
	self.daysSignInPanel = PettyPay30DaysSignInPanel(self, "MainInfoPanel/SignInPanel")
	self.dailyPayPanel = PettyPayDailyPayPanel(self, "MainInfoPanel/DailyPayPanel")
	self.dragPages = DragTwoPages(self, "MainInfoPanel/TipsPanel/ContentPanel1", "MainInfoPanel/TipsPanel/ContentPanel2", nil, nil, 5, nil, true)
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)
	self.txtDragPage1 = UIControls.Label(self, "MainInfoPanel/TipsPanel/ContentPanel1/Text")
	self.txtDragPage2 = UIControls.Label(self, "MainInfoPanel/TipsPanel/ContentPanel2/Text")
end

function ActivityPettyPayDlg:setData(...)
	if self.actObj then
		local templateData = self.actObj.templateData

		if templateData then
			self.detailID = templateData.detail_id
		end
	end

	if ResPettyPayTab and ResPettyPayTab[constTabType.mianCanvas] then
		self.resData = ResPettyPayTab[constTabType.mianCanvas]

		self:setUIData()
		self.dailyPayPanel:setResData(self.resData)

		if self.resData.arg1 then
			local data = stringSplitTonumber(self.resData.arg1)

			if data then
				self.carouselText = {}

				for _, value in pairs(data) do
					if ResPettyPayTextContent and ResPettyPayTextContent[value] then
						table.insert(self.carouselText, ResPettyPayTextContent[value].text_content)
					end
				end

				self:setCarousel()
			end
		end
	end

	if ResPettyPayTab and ResPettyPayTab[constTabType.dailyGift] then
		self.dailyGiftPanel:setResData(ResPettyPayTab[constTabType.dailyGift])
	end

	if ResPettyPayTab and ResPettyPayTab[constTabType.signIn] then
		self.daysSignInPanel:setResData(ResPettyPayTab[constTabType.signIn])
	end

	if self.actObj and self.actObj.actData then
		self.serverData = self.actObj.actData.serverData
	end

	local constAchiveType = {
		signIn = 113,
		rechargeAmount = 111,
		rechargeTen = 112
	}

	if self.serverData and self.serverData[constAchiveType.signIn] then
		self.daysSignInPanel:setSvrData(self.serverData[constAchiveType.signIn])
	end
end

function ActivityPettyPayDlg:setUIData(...)
	if self.resData then
		local templID = self.resData.templ_id

		if templID then
			local actObj

			for opActId, activityObj in pairs(CurAvatar.opActivityObjs) do
				if activityObj and activityObj:isValid() and activityObj.templateData and activityObj.templateData.template_id == templID then
					actObj = activityObj
				end

				if actObj then
					-- block empty
				end
			end
		end
	end
end

function ActivityPettyPayDlg:updateActivityData(...)
	self:setData()

	local ui = UIManager.tryGetUI("activity30DaysSignInDlg")

	if ui then
		ui:updateActivityData()
	end
end

function ActivityPettyPayDlg:setCarousel()
	if self.carouselText and #self.carouselText ~= 0 then
		self.dragPages:initPage(#self.carouselText, 1)
	end
end

function ActivityPettyPayDlg:onDragEvent(sender, pageIndex, controlIndex)
	if pageIndex == 1 and self.carouselText and self.carouselText[controlIndex] then
		self.txtDragPage1:setText(self.carouselText[controlIndex])
	end

	if pageIndex == 2 and self.carouselText and self.carouselText[controlIndex] then
		self.txtDragPage2:setText(self.carouselText[controlIndex])
	end
end

function ActivityPettyPayDlg:onBtnCloseClick()
	self:setVisible(false)
end

function ActivityPettyPayDlg:onBtnTipsClick()
	if self.resData and self.resData.tips_id and ResInfoNotice[self.resData.tips_id] then
		UIManager.getUI("infoNotice", true):showSystemInfo(self.resData.tips_id)
	end
end

function ActivityPettyPayDlg:onDestroy(...)
	ActivityPettyPayDlg.super.onDestroy(self)
end

function ActivityPettyPayDlg:destroy(...)
	self.dragPages:onPause()
	ActivityPettyPayDlg.super.destroy(self)
end

return ActivityPettyPayDlg
