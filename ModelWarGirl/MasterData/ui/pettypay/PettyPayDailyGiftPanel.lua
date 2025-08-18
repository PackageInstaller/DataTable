-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PettyPay\\PettyPayDailyGiftPanel.lua

local strClassName = "PettyPayDailyGiftPanel"
local PettyPayDailyGiftPanel = Class(strClassName, UIControls.Panel)

function PettyPayDailyGiftPanel:ctor(...)
	self:initUI()
end

function PettyPayDailyGiftPanel:initUI()
	self.btnEnter = UIControls.Button(self, self.mPath)

	self.btnEnter:addEventClick(self.onBtnEnterClick)
	self:refreshUI()
end

function PettyPayDailyGiftPanel:setResData(resData)
	self.resData = resData
end

function PettyPayDailyGiftPanel:setSvrData(svrData)
	self.svrData = svrData
end

function PettyPayDailyGiftPanel:refreshUI()
	self:checkRedDot()
end

function PettyPayDailyGiftPanel:checkRedDot()
	return
end

function PettyPayDailyGiftPanel:onBtnEnterClick(...)
	local ui = UIManager.getUI("activityDailyGiftDlg", true)

	if ui then
		ui:initData()
	end
end

return PettyPayDailyGiftPanel
