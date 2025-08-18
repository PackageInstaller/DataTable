-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfareSecondRecharge.lua

local ResAchieve = require("ClientData/ResAchieve")
local strClassName = "WelfareSecondRecharge"
local WelfareSecondRecharge = Class(strClassName, UIControls.Window)

function WelfareSecondRecharge:ctor()
	self:initUI()
end

function WelfareSecondRecharge:initUI()
	self.textRule = UIControls.Label(self, "Bg/AwardPanel/TextRule")
	self.sliderProgress = UIControls.Slider(self, "Bg/AwardPanel/Slider")
	self.textProgress = UIControls.Label(self, "Bg/AwardPanel/TextExp")
	self.gridBonus = {}
	self.btnGo = UIControls.Button(self, "Bg/BtnGo")

	self.btnGo:addEventClick(self.onGoClick)

	self.btnGet = UIControls.Button(self, "Bg/BtnGet")

	self.btnGet:addEventClick(self.onGetClick)
end

function WelfareSecondRecharge:onOpen()
	WelfareSecondRecharge.super.onOpen(self)
	self:refreshData()
end

function WelfareSecondRecharge:refreshData()
	local firstRechargeConfig = CurAvatar:getFirstRechargeConfig(1)

	self.achieveId = firstRechargeConfig.append_achieve_id
	self.achData = ResAchieve[self.achieveId]

	if self.achData then
		self.textRule:setText(self.achData.action_desc or "")

		local nowProgress, maxProgress = CurAvatar:getAchieveProcess(self.achieveId)

		if nowProgress and maxProgress and maxProgress > 0 then
			if RegionUtils.isSEA() then
				nowProgress = nowProgress / 100
			else
				nowProgress = math.floor(nowProgress / 100)
			end

			maxProgress = maxProgress / 100

			self.sliderProgress:setValue(nowProgress / maxProgress)
			self.textProgress:setText(nowProgress .. "/" .. maxProgress)
		end

		ClientUtils.CreateBonusGrid(self, self.gridBonus, "Bg/AwardPanel/GridPanel", self.achData.award_randid, nil, nil, true)
	end

	local achState = CurAvatar:getAchieveStatus(self.achieveId)

	self.btnGo:setVisible(achState == Const.ACHIEVE_STATUS.IN_PROCESS)
	self.btnGet:setVisible(achState == Const.ACHIEVE_STATUS.COMPLETE)
end

function WelfareSecondRecharge:onGoClick()
	if ClientUtils.JumpToFirstRecharge() then
		self:setVisible(false)
	end
end

function WelfareSecondRecharge:onGetClick()
	RPC.achieveGetAward(self.achieveId)
	self:setVisible(false)
end

return WelfareSecondRecharge
