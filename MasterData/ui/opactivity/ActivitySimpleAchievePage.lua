-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivitySimpleAchievePage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRechargeRebateMisc = require("ClientData/ResRechargeRebateMisc")
local UIControls = UIControls
local classNameStr = "ActivitySimpleAchievePage"
local ActivitySimpleAchievePage = Class(classNameStr, UIControls.Child)

MixinClass(ActivitySimpleAchievePage, ActivityPanelMixin)

function ActivitySimpleAchievePage:initUI()
	if UIControls.checkControlFunc(self, "BgDes/TextDes") then
		self.textRule = UIControls.Label(self, "BgDes/TextDes")
	end

	if UIControls.checkControlFunc(self, "BgTime/TextTime") then
		self.textTime = UIControls.Label(self, "BgTime/TextTime")
	end

	if UIControls.checkControlFunc(self, "AchiPanel/BtnGet") then
		self.btnGetAchieve = UIControls.Button(self, "AchiPanel/BtnGet")

		self.btnGetAchieve:addEventClick(self.onGetAchieveClick)
	end

	self.grids = {}
end

function ActivitySimpleAchievePage:_setData()
	self.opId = self.actObj.opId

	for achieveType, typeData in pairs(self.actObj.actData.clientData) do
		self.actType = achieveType

		local clientData = typeData[1]

		ClientUtils.CreateBonusGrid(self, self.grids, "AchiPanel/GridAward", clientData.award, true, 3, true)

		local achState = self.actObj.actData:getAchieveState(achieveType, 1)

		if achState == Const.ACT_ACHIEVE_STATE_GOT then
			self.btnGetAchieve:setVisible(false)

			for index, grid in ipairs(self.grids) do
				grid:setGet(true)
			end
		else
			if achState == Const.ACT_ACHIEVE_STATE_ENOUGH then
				self.btnGetAchieve:setVisible(true)
			else
				self.btnGetAchieve:setVisible(false)
			end

			for index, grid in ipairs(self.grids) do
				grid:setGet(false)
			end
		end
	end
end

function ActivitySimpleAchievePage:onGetAchieveClick()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, 1, self.actType), self.opId)
end

function ActivitySimpleAchievePage:onActivityDataRefresh(actObj)
	self:_setData()
end

return ActivitySimpleAchievePage
