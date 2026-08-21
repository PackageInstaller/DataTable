-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\QQ\\QQPrivilegeDayPart.lua

local ResQQBlueAchieveDayGift = require("ClientData/ResQQBlueAchieveDayGift")
local QQPrivilegeDayCell = Class("QQPrivilegeDayCell", UIControls.Child)

function QQPrivilegeDayCell:ctor()
	self:initUI()
end

function QQPrivilegeDayCell:initUI()
	self.confirmBtn = UIControls.Button(self, "Bg/BtnConfirm", "Text")

	self.confirmBtn:addEventClick(self.onBtnClick)

	self.stateLable = UIControls.Label(self, "Bg/TextState")
	self.ruleLable = UIControls.Label(self, "Bg/TextRule")
	self.awardItems = {}
end

function QQPrivilegeDayCell:onBtnClick()
	RPC.qQBlueGetDayAward(0, self.achData.id)
end

function QQPrivilegeDayCell:setData(achData)
	ClientUtils.CreateBonusGrid(self, self.awardItems, "Bg/GridItemPanel", achData.award_id, true, 2, true)
	self.ruleLable:setText(achData.desc or "")

	self.achData = achData
end

function QQPrivilegeDayCell:refreshState()
	if CurAvatar.qqPrivilege.dayAward and CurAvatar.qqPrivilege.dayAward[self.achData.id] then
		self.confirmBtn:setVisible(false)
		self.stateLable:setVisible(true)
		self.stateLable:setText(Lang.get(74))

		for _, grid in ipairs(self.awardItems) do
			grid:setGet(true)
		end
	else
		for _, grid in ipairs(self.awardItems) do
			grid:setGet(false)
		end

		self.confirmBtn:setVisible(true)
		self.stateLable:setVisible(false)

		if CurAvatar:getQQBlueStep() >= (self.achData.blue_step or 0) then
			self.confirmBtn:setVisible(true)
			self.stateLable:setVisible(false)
		else
			self.confirmBtn:setVisible(false)
			self.stateLable:setVisible(true)
			self.stateLable:setText(Lang.get(99))
		end
	end
end

local strClassName = "QQPrivilegeDayPart"
local QQPrivilegeDayPart = Class(strClassName, UIControls.Child)

function QQPrivilegeDayPart:ctor()
	self:initUI()
end

function QQPrivilegeDayPart:initUI()
	self.cells = {}

	for index = 1, #ResQQBlueAchieveDayGift do
		local newCell = QQPrivilegeDayCell(self, "FundList/Content", "System/QQ/QQPrivilegeAchieveCell")

		newCell:setVisible(true)
		newCell:setData(ResQQBlueAchieveDayGift[index])
		table.insert(self.cells, newCell)
	end
end

function QQPrivilegeDayPart:onRefresh()
	for _, cell in ipairs(self.cells) do
		cell:refreshState()
	end
end

return QQPrivilegeDayPart
