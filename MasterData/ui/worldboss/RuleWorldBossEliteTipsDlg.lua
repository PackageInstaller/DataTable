-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\WorldBoss\\RuleWorldBossEliteTipsDlg.lua

local RuleWorldBossEliteCell = Class("RuleWorldBossEliteCell", UIControls.Child)
local ResInfoNotice = require("ClientData/ResInfoNotice")

function RuleWorldBossEliteCell:ctor(...)
	self:initUI()
end

function RuleWorldBossEliteCell:initUI(...)
	self.txtRule = UIControls.Label(self, "RuleCell/TextRule")
	self.txtTotalTimes = UIControls.Label(self, "RuleCell/SliderPanel/NumPanel/TextNum2")
	self.txtCurrentTimes = UIControls.Label(self, "RuleCell/SliderPanel/NumPanel/TextNum1")
end

function RuleWorldBossEliteCell:setData(data)
	self.txtRule:setText(data.rule)
	self.txtTotalTimes:setText(data.totalTimes)
	self.txtCurrentTimes:setText(data.curTimes)
end

local strClassName = "RuleWorldBossEliteTipsDlg"
local RuleWorldBossEliteTipsDlg = Class(strClassName, UIControls.Window)

function RuleWorldBossEliteTipsDlg:ctor(...)
	self:initUI()
end

function RuleWorldBossEliteTipsDlg:initUI(...)
	self.txtTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.txtRule = UIControls.Label(self, "BgPanel/ScrollView/Content/TextRule")
	self.txtNumElite = UIControls.Label(self, "BgPanel/ScrollView/Content/TextNumElite")
end

function RuleWorldBossEliteTipsDlg:onOpen(...)
	RuleWorldBossEliteTipsDlg.super.onOpen(self)
end

function RuleWorldBossEliteTipsDlg:show(data)
	local totalTimes, curTimes, achievesData
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		curTimes, achievesData = actData:getEliteAchieveInfo()
	end

	self.txtRule:setText(ResInfoNotice[522].content)
	self.txtNumElite:setText(utils.format(Lang.get(103612), tonumber(curTimes)))

	self.data = achievesData
	self.ruleWorldBossEliteCells = {}

	if achievesData then
		for i, info in ipairs(self.data) do
			local cell = RuleWorldBossEliteCell(self, "BgPanel/ScrollView/Content", "System/Common/Tips/RuleWorldBossEliteCell", 0, 0, true)

			table.insert(self.ruleWorldBossEliteCells, cell)
			cell:setData(info)
		end
	end
end

function RuleWorldBossEliteTipsDlg:destroy(...)
	RuleWorldBossEliteTipsDlg.super.destroy(self)
end

function RuleWorldBossEliteTipsDlg:_onClose()
	self:setVisible(false)
end

return RuleWorldBossEliteTipsDlg
