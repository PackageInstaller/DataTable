-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\StarUpFastCell.lua

local strClassName = "StarUpFastCell"
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local StarUpFastCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function StarUpFastCell:ctor()
	self:initUI()
end

function StarUpFastCell:initUI()
	self.btnToggle = UIControls.Button(self, "BtnToggle")

	self.btnToggle:addEventClick(self.onBtnToggleClick)

	self.imgSelCheck = UIControls.Image(self, "BtnToggle/ImgCheckSel")
	self.materialGrids = {}
end

function StarUpFastCell:setData(data, newIdx)
	self.data = data
	self.hero = data.hero
	self.materials = data.materials
	self.idx = newIdx

	if not self.beforeHeroGrid then
		self.beforeHeroGrid = GridHeroStarUp(self, "BeforePanel", "System/StarUp/GridHeroStarUp")
	end

	if not self.afterHeroGrid then
		self.afterHeroGrid = GridHeroStarUp(self, "AfterPanel", "System/StarUp/GridHeroStarUp")
	end

	local oriHero = BaseObject.CopyObject(self.hero)

	oriHero:initCrystalData()

	local tarHero = BaseObject.CopyObject(self.hero)

	tarHero:initCrystalData()

	tarHero.star = tarHero.star + 1

	self.beforeHeroGrid:setHero(oriHero)
	self.afterHeroGrid:setHero(tarHero)
	self.beforeHeroGrid:setVisible(true)
	self.afterHeroGrid:setVisible(true)

	for i, materialHero in ipairs(self.materials) do
		if not self.materialGrids[i] then
			self.materialGrids[i] = GridHeroStarUp(self, "MaterialPanel" .. i, "System/StarUp/GridHeroStarUp")
		end

		self.materialGrids[i]:setHero(materialHero)
		self.materialGrids[i]:setVisible(true)

		local materialPanel = UIControls.Panel(self, "MaterialPanel" .. i)

		materialPanel:setVisible(true)
	end

	for i = #self.materials + 1, 3 do
		local materialPanel = UIControls.Panel(self, "MaterialPanel" .. i)

		materialPanel:setVisible(false)
	end

	self.imgSelCheck:setVisible(self.mWindow.heroSelect[self.hero.gid] ~= nil)
end

function StarUpFastCell:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function StarUpFastCell:onBtnToggleClick()
	if self.hero and self.selectCallback then
		self.selectCallback(self.data)
	end
end

return StarUpFastCell
