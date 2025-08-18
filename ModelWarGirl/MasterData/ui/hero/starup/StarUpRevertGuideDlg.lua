-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\StarUpRevertGuideDlg.lua

local StarUpRevertGuideInfoPanel = require("UI/Hero/StarUp/StarUpRevertGuideInfoPanel")
local ResStarUpRevert = require("ClientData/ResStarUpRevert")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local ResHeroMisc = require("ClientData/ResHeroMisc")
local strClassName = "StarUpRevertGuideDlg"
local StarUpRevertGuideDlg = Class(strClassName, UIControls.Window)

function StarUpRevertGuideDlg:ctor()
	self:initUI()
end

function StarUpRevertGuideDlg:initUI()
	self.txtBeforeLv = UIControls.Label(self, "BgPanel/GuidePanel3/TextBefore")

	self.txtBeforeLv:setText("1")

	self.txtCryLv = UIControls.Label(self, "BgPanel/GuidePanel3/TextAfter")
	self.revertInfoPanel1 = StarUpRevertGuideInfoPanel(self, "BgPanel/GuidePanel1/InfoPanel1")
	self.revertInfoPanel2 = StarUpRevertGuideInfoPanel(self, "BgPanel/GuidePanel1/InfoPanel2")
	self.revertInfoPanel3 = StarUpRevertGuideInfoPanel(self, "BgPanel/GuidePanel1/InfoPanel3")
	self.revertInfoPanel4 = StarUpRevertGuideInfoPanel(self, "BgPanel/GuidePanel1/InfoPanel4")
	self.starUpInfoPanel1 = StarUpRevertGuideInfoPanel(self, "BgPanel/GuidePanel2/InfoPanel1")
	self.starUpInfoPanel2 = StarUpRevertGuideInfoPanel(self, "BgPanel/GuidePanel2/InfoPanel2")
end

function StarUpRevertGuideDlg:initByGuideData(guideData)
	self.guideData = guideData

	if self.guideData.reason == Const.STAR_REVERT_HELP_REASON_EIGHT then
		self.revertInfoPanel1:setVisible(true)
		self.revertInfoPanel2:setVisible(false)
		self.revertInfoPanel3:setVisible(false)
		self.revertInfoPanel4:setVisible(false)

		local sixStarhero = BaseObject.GetObject(self.guideData.needRevertHero.id, 6)

		self.revertInfoPanel1:setHeroGrid(1, self.guideData.needRevertHero)
		self.revertInfoPanel1:setHeroGrid(2, sixStarhero)

		local materialItem = CurAvatar:getRevertedOnlyMaterial(self.guideData.needRevertHero)

		self.revertInfoPanel1:setMaterialGrid(3, materialItem)
		self.starUpInfoPanel1:setVisible(true)
		self.starUpInfoPanel2:setVisible(false)
		self.starUpInfoPanel1:setHeroGrid(1, self.guideData.starUpHeroList[1])
		self.starUpInfoPanel1:setHeroGrid(4, self.guideData.starUpHeroList[2])

		local upHero = BaseObject.CopyObject(self.guideData.starUpHeroList[1])

		upHero.star = 8

		upHero:initCrystalData()
		self.starUpInfoPanel1:setHeroGrid(5, upHero)

		local fakeHero = BaseObject.GetObject(self.guideData.starUpHeroList[1].id, 6)

		fakeHero.id = nil

		self.starUpInfoPanel1:setBtnHeroMaterial(2, fakeHero)
		self.starUpInfoPanel1:setBtnHeroMaterial(3, fakeHero)

		local cryGrid = GridHeroStarUp(self, "BgPanel/GuidePanel3/GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp", 0, 0, true)

		cryGrid:setHero(sixStarhero)
		self.txtCryLv:setText(math.min(CurAvatar.crystalData.level, self.guideData.needRevertHero:getMaxLv()))
	else
		self.revertInfoPanel1:setVisible(false)
		self.revertInfoPanel2:setVisible(false)
		self.revertInfoPanel3:setVisible(false)
		self.revertInfoPanel4:setVisible(false)

		local needRevertHero1 = self.guideData.needRevertHeroList[1]

		self:setNeedRevertForReasonNine(needRevertHero1, 1)

		local needRevertHero2 = self.guideData.needRevertHeroList[2]

		self:setNeedRevertForReasonNine(needRevertHero2, 2)
		self.starUpInfoPanel1:setVisible(false)
		self.starUpInfoPanel2:setVisible(true)
		self.starUpInfoPanel2:setHeroGrid(1, self.guideData.starUpHero)

		local fakeHero = BaseObject.GetObject(self.guideData.starUpHero.id, 8)

		fakeHero.id = nil

		self.starUpInfoPanel2:setBtnHeroMaterial(2, fakeHero)

		local upHero = BaseObject.CopyObject(self.guideData.starUpHero)

		upHero.star = 9

		upHero:initCrystalData()
		self.starUpInfoPanel2:setHeroGrid(3, upHero)

		local cryGrid = GridHeroStarUp(self, "BgPanel/GuidePanel3/GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp", 0, 0, true)
		local sixStarhero = BaseObject.GetObject(needRevertHero1.id, 6)

		cryGrid:setHero(sixStarhero)
		self.txtCryLv:setText(math.min(CurAvatar.crystalData.level, needRevertHero1:getMaxLv()))
	end
end

function StarUpRevertGuideDlg:setNeedRevertForReasonNine(needRevertHero, idx)
	if needRevertHero.star == 7 then
		local useRvertInfoPanel = idx == 1 and self.revertInfoPanel1 or self.revertInfoPanel2

		useRvertInfoPanel:setVisible(true)

		local sixStarhero = BaseObject.GetObject(needRevertHero.id, 6)

		useRvertInfoPanel:setHeroGrid(1, needRevertHero)
		useRvertInfoPanel:setHeroGrid(2, sixStarhero)

		local materialItem = CurAvatar:getRevertedOnlyMaterial(needRevertHero)

		useRvertInfoPanel:setMaterialGrid(3, materialItem)
	elseif needRevertHero.star == 8 then
		local useRvertInfoPanel = idx == 1 and self.revertInfoPanel3 or self.revertInfoPanel4

		useRvertInfoPanel:setVisible(true)

		local sixStarhero = BaseObject.GetObject(needRevertHero.id, 6)

		useRvertInfoPanel:setHeroGrid(1, needRevertHero)
		useRvertInfoPanel:setHeroGrid(2, sixStarhero)
		useRvertInfoPanel:setHeroGrid(3, sixStarhero)

		local materialItem = CurAvatar:getRevertedOnlyMaterial(needRevertHero)

		useRvertInfoPanel:setMaterialGrid(4, materialItem)
	end
end

return StarUpRevertGuideDlg
