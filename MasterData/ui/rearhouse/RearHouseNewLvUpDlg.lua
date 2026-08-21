-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseNewLvUpDlg.lua

local strClassName = "RearHouseNewLvUpDlg"
local RearHouseNewLvUpDlg = Class(strClassName, UIControls.Window)

function RearHouseNewLvUpDlg:ctor()
	self.textOldLv = UIControls.Label(self, "Bg/LvUpPanel/ImgBeforeLv/TextLvNum")
	self.textNewLv = UIControls.Label(self, "Bg/LvUpPanel/ImgAfterLv/TextLvNum")
	self.textOldCapacity = UIControls.Label(self, "Bg/CombatEffectPanel/ImgNow/TextNum")
	self.textNewCapacity = UIControls.Label(self, "Bg/CombatEffectPanel/ImgAfter/TextNum")
	self.textNewLv = UIControls.Label(self, "Bg/LvUpPanel/ImgAfterLv/TextLvNum")
	self.textLvBonus = UIControls.Panel(self, "Bg/CombatEffectPanel/TextLevelAward")
	self.btnLvBonus = UIControls.Button(self, "Bg/CombatEffectPanel/BtnMore")

	self.btnLvBonus:addEventClick(self.onLvBonusClick)
	self.textLvBonus:setVisible(Const.ENABLE_CRYSTAL_LEVEL_ACHIEVE)
	self.btnLvBonus:setVisible(Const.ENABLE_CRYSTAL_LEVEL_ACHIEVE)
end

function RearHouseNewLvUpDlg:onLvBonusClick()
	self:setVisible(false)
	UIManager.getUI("heroCrystalAchieveDlg", true)
end

function RearHouseNewLvUpDlg:onShow(preLv, newLv, oldCapacity, newCapacity)
	self.textOldLv:setText(preLv)
	self.textNewLv:setText(newLv)
	self.textOldCapacity:setText(oldCapacity)
	self.textNewCapacity:setText(newCapacity)
end

return RearHouseNewLvUpDlg
