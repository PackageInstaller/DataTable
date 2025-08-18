-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetLevelUpDlg.lua

local ResPetDegreeLevel = require("ClientData/ResPetDegreeLevel")
local strClassName = "PetLevelUpDlg"
local PetLevelUpDlg = Class(strClassName, UIControls.Window)

function PetLevelUpDlg:ctor()
	self:initUI()
end

function PetLevelUpDlg:initUI()
	self.txtOldNum = UIControls.Label(self, "BgPanel/FasionLvUp/LevelPanel01/TxtNum")
	self.txtNewNum = UIControls.Label(self, "BgPanel/FasionLvUp/LevelPanel02/TxtNum")
	self.items = {}
	self.txtTitle02 = UIControls.Label(self, "BgPanel/TxtTitle02")
	self.txtUnlock2 = UIControls.Label(self, "BgPanel/PetLvUp/text02")
end

function PetLevelUpDlg:setData(oldLevel, level)
	self.level = level
	self.oldLevel = oldLevel

	if Const.REVIEW_VERSION then
		self.txtOldNum:setText(string.format(Lang.get(111361), self.oldLevel))
		self.txtNewNum:setText(string.format(Lang.get(111361), self.level))
	else
		self.txtOldNum:setText(string.format("LV.%d", self.oldLevel))
		self.txtNewNum:setText(string.format("LV.%d", self.level))
	end

	local awards = {}

	for i = self.oldLevel + 1, self.level do
		if ResPetDegreeLevel[i] and ResPetDegreeLevel[i].award_id then
			table.insert(awards, ResPetDegreeLevel[i].award_id)
		end
	end

	if #awards > 0 then
		self.txtTitle02:setVisible(true)
		ClientUtils.CreatePreviewBonusSumGrid(self, self.items, "BgPanel/GridPanel", awards, true, nil, true)
	else
		self.txtTitle02:setVisible(false)
	end

	self.txtUnlock2:setVisible(self:isPossessLimitChange(oldLevel, level))
end

function PetLevelUpDlg:isPossessLimitChange(oldLevel, newLevel)
	if not CurAvatar:checkPetPossessEnterOpen() then
		return false
	end

	local oldNum = ResPetDegreeLevel[oldLevel] and ResPetDegreeLevel[oldLevel].possess_num or 0
	local newNum = ResPetDegreeLevel[newLevel] and ResPetDegreeLevel[newLevel].possess_num or 0

	return oldNum < newNum
end

return PetLevelUpDlg
