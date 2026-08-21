-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityEquipReformLvDlg.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "ReformLvCell"
local ReformLvCell = Class(strClassName, UIControls.Child)

function ReformLvCell:ctor()
	self.textNum = UIControls.Label(self, "TextNum")
	self.textLV = UIControls.Label(self, "TextLV")
end

function ReformLvCell:setData(lv)
	if lv == self.mParent.maxLockLevel then
		if Const.REVIEW_VERSION then
			self.textLV:setText(Lang.get(1699))
		else
			self.textLV:setText("Lv.MAX")
		end
	elseif Const.REVIEW_VERSION then
		self.textLV:setText(string.format(Lang.get(111361), lv))
	else
		self.textLV:setText(string.format("Lv.%d", lv))
	end

	self.textNum:setText(string.format(Lang.get(89840), lv))
	self.textLV:setFontColor(lv == self.mParent.curLockLevel and ResColor.GREEN or ResColor.WHITE)
	self.textNum:setFontColor(lv == self.mParent.curLockLevel and ResColor.GREEN or ResColor.WHITE)
end

local strClassName = "ActivityEquipReformLvDlg"
local ActivityEquipReformLvDlg = Class(strClassName, UIControls.Window)

function ActivityEquipReformLvDlg:ctor()
	self:initUI()
end

function ActivityEquipReformLvDlg:initUI()
	self.textRule = UIControls.Label(self, "Bg/TextRule")
	self.cells = {}
end

function ActivityEquipReformLvDlg:setData(maxLockLevel, curLockLevel)
	self.textRule:setText(ClientUtils.getClientNotice(739))

	self.maxLockLevel = maxLockLevel
	self.curLockLevel = curLockLevel

	for i = 1, maxLockLevel do
		local cell = self.cells[i]

		if cell == nil then
			cell = ReformLvCell(self, "Bg/LvPanel", "System/Activity/ActivityEquipWash/ActivityEquipWashingLvCell", 0, 0, true)
		end

		cell:setData(i)

		self.cells[i] = cell
	end
end

return ActivityEquipReformLvDlg
