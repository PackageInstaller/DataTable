-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\StarUpRevertGuideInfoPanel.lua

local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local BtnHeroMaterial = require("UI/Hero/StarUp/BtnHeroMaterial")
local strClassName = "StarUpRevertGuideInfoPanel"
local StarUpRevertGuideInfoPanel = Class(strClassName, UIControls.Panel)

function StarUpRevertGuideInfoPanel:ctor()
	self:initUI()
end

function StarUpRevertGuideInfoPanel:initUI()
	self.imgAdd1 = UIControls.Panel(self, self.mPath .. "/ImgAdd")

	if UIControls.checkControlFunc(self, self.mPath .. "/ImgAdd2") then
		self.imgAdd2 = UIControls.Panel(self, self.mPath .. "/ImgAdd2")
	end

	self.panelGridList = {}

	for i = 1, 5 do
		if UIControls.checkControlFunc(self, self.mPath .. "/GridPanel" .. i) then
			local panelGrid = UIControls.Panel(self, self.mPath .. "/GridPanel" .. i)

			self.panelGridList[i] = panelGrid
		else
			break
		end
	end
end

function StarUpRevertGuideInfoPanel:setHeroGrid(gridPanelIdx, hero)
	self.gridHero = GridHeroStarUp(self, self.mPath .. "/GridPanel" .. gridPanelIdx, "System/StarUp/GridHeroStarUp", 0, 0, true)

	self.gridHero:setHero(hero)
end

function StarUpRevertGuideInfoPanel:setMaterialGrid(gridPanelIdx, item)
	local gridMaterial = UIControls.ItemGridChild(self, self.mPath .. "/GridPanel" .. gridPanelIdx, "System/Common/Grid/GridMaterialItem", 0, 0, true)

	gridMaterial:setObj(item)
end

function StarUpRevertGuideInfoPanel:setBtnHeroMaterial(gridPanelIdx, fakeHero)
	local btnMaterial = BtnHeroMaterial(self, self.mPath .. "/GridPanel" .. gridPanelIdx, "System/StarUp/BtnHeroMaterial", 0, 0, true)

	btnMaterial.btnSelf:setEnable(false)
	btnMaterial.imgHeroAdd:setVisible(false)
	btnMaterial:initFakeHero(fakeHero)

	btnMaterial.gridHero.clickCallback = nil
end

return StarUpRevertGuideInfoPanel
