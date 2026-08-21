-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\Grid\\GridHeroStarMaterialCell.lua

local strClassName = "GridHeroStarMaterialCell"
local GridHeroStarMaterialCell = Class(strClassName, UIControls.HeroCardLoop)

function GridHeroStarMaterialCell:ctor()
	self:_initUI()
end

function GridHeroStarMaterialCell:_initUI()
	self.textName = UIControls.Label(self, "TextDes1")
	self.textNum = UIControls.Label(self, "TextDes2")

	self.textName:setVisible(false)
	self.textNum:setVisible(false)

	self.imgState = UIControls.Image(self, "ImgState")

	self.imgState:setVisible(false)

	self.imgState2 = UIControls.Image(self, "ImgState2")
end

function GridHeroStarMaterialCell:setData(hero, idx)
	self.idx = idx

	self:setHero(hero)
	self:setSelected(self.mWindow:isSelected(self.hero.gid))
end

function GridHeroStarMaterialCell:setSelected(isSelected)
	local success = self.mWindow:setSelectHero(self.hero, isSelected)

	if success then
		self.beSelected = isSelected

		self.imgState2:setVisible(self.beSelected)
	end
end

function GridHeroStarMaterialCell:onBtnSelect(sender)
	self:setSelected(not self.beSelected)
end

return GridHeroStarMaterialCell
