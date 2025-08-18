-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityEquipReformLvUpDlg.lua

local strClassName = "ActivityEquipReformLvUpDlg"
local ActivityEquipReformLvUpDlg = Class(strClassName, UIControls.Window)

function ActivityEquipReformLvUpDlg:ctor()
	self:initUI()
end

function ActivityEquipReformLvUpDlg:initUI()
	self.textNum = UIControls.Label(self, "Bg/LockNumChange/TextNum")
	self.textLVNew = UIControls.Label(self, "Bg/LvChange/TextLVNew")
	self.textNumNew = UIControls.Label(self, "Bg/LockNumChange/TextNumNew")
	self.textLV = UIControls.Label(self, "Bg/LvChange/TextLV")
end

function ActivityEquipReformLvUpDlg:setData(oldLv, newLv)
	self.textNum:setText(oldLv)
	self.textNumNew:setText(newLv)

	if Const.REVIEW_VERSION then
		self.textLVNew:setText(string.format(Lang.get(111361), newLv))
		self.textLV:setText(string.format(Lang.get(111361), oldLv))
	else
		self.textLVNew:setText(string.format("Lv.%d", newLv))
		self.textLV:setText(string.format("Lv.%d", oldLv))
	end
end

return ActivityEquipReformLvUpDlg
