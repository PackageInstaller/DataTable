-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseCleanAwardDlg.lua

local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local strClassName = "RearHouseCleanAwardDlg"
local RearHouseCleanAwardDlg = Class(strClassName, UIControls.Window)

function RearHouseCleanAwardDlg:ctor(...)
	self:initUI()
end

function RearHouseCleanAwardDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.award = UIControls.getGridAwardContainer(self, "BgPanel/GridMaterialItemPanel")
	self.imgHero = UIControls.Image(self, "BgPanel/MaskHero/ImgHero")
	self.txtRule = UIControls.Label(self, "BgPanel/TextRule")
end

function RearHouseCleanAwardDlg:setData(hero, isQuickClean)
	self.isQuickClean = isQuickClean or false
	self.hero = hero

	CueManager.playHeroVocal(self.hero.id, Const.HERO_VOCAL_CLEAN)

	local rule = RearHouseCommon.getCleanDesc(self.hero:getShowModelId())

	self.txtRule:setText(rule)

	local awardItem = RearHouseCommon.getCleanAward(self.isQuickClean)

	if awardItem then
		self.award:setObj(awardItem)

		self.award.grid.mDisableWays = true

		self.award:setVisible(true)
	end

	local iconData = hero:getIconPath()

	self.imgHero:setImage(iconData[1], iconData[2])
end

function RearHouseCleanAwardDlg:onBtnCloseClick(...)
	self:setVisible(false)

	if self.isQuickClean == true then
		RPC.houseSweep(1)
	else
		RPC.houseSweep()

		ClientUtils.record.cleanRecord = ClientUtils.record.cleanRecord or {}
		ClientUtils.record.cleanRecord[self.hero.gid] = true
	end

	self.award.grid:flyToCommonFuncEntryPanel()
end

return RearHouseCleanAwardDlg
