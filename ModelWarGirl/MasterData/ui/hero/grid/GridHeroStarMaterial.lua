-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\Grid\\GridHeroStarMaterial.lua

local HERO_ATLAS = "Atlas/HeroAtlas/HeroAtlas"
local HERO_COMMON_ATLAS = "Atlas/HeroAtlas/HeroCardCommonAtlas"
local GridHeroStarMaterial = Class("GridHeroStarMaterial", UIControls.HeroCardChild)

function GridHeroStarMaterial:ctor()
	self:_initUI()
end

function GridHeroStarMaterial:_initUI()
	self.textName = UIControls.Label(self, "TextDes1")
	self.textNum = UIControls.Label(self, "TextDes2")
	self.imgState = UIControls.Image(self, "ImgState")
	self.imgBg3 = UIControls.Image(self, "Bg3")

	self.imgBgLv:setVisible(false)
end

function GridHeroStarMaterial:setData(data)
	self.data = data
	self.materialType = self.data.type

	if #self.data.selectedHero == 0 then
		self.fakeHero = self.data.resId ~= 0 and BaseObject.GetObject(self.data.resId) or nil

		if self.fakeHero then
			self.imgGroupIcon:setVisible(true)
			self.imgGroupIcon:setImage("Atlas/HeroAtlas/HeroCardCommonAtlas", "IconGroup0" .. self.fakeHero.camp)

			self.fakeHero.star = self.data.needStar

			self:setHero(self.fakeHero)
			self.textName:setText(utils.format(Lang.get(30388), self.fakeHero.star, self.hero.name))
		end
	else
		self.realHero = self.data.selectedHero[1]

		self:setHero(self.realHero)
		self.imgBgLv:setVisible(true)
		self.textName:setText(self.hero.name)
	end

	if self.materialType == Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID then
		self:setAnyHero()
	elseif self.materialType == Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP then
		self:setSameCampHero()
	end

	self:setFake(#self.data.selectedHero == 0)

	local spriteName = #self.data.selectedHero ~= self.data.needNum and "ImgCardMaterialAdd" or "ImgCardMaterialChange"

	self.imgState:setImage(HERO_ATLAS, spriteName)
	self.textNum:setText(#self.data.selectedHero .. "/" .. self.data.needNum)

	local enough = #self.data.selectedHero == self.data.needNum

	self.mParent:setIsEnough(self.materialType, enough, self.data.selectedHero)
end

function GridHeroStarMaterial:setAnyHero()
	local isFake = #self.data.selectedHero == 0

	if isFake then
		self.imgGroupIcon:setVisible(false)
		self.imgStar:setImage(HERO_COMMON_ATLAS, "IconStar0" .. self.data.needStar)
		self.textName:setText(string.format(Lang.get(30389), self.data.needStar))
		self.imgHeroIcon:setImage(HERO_COMMON_ATLAS, "IconHeroCommon")
	else
		self.imgGroupIcon:setVisible(true)
		self:setHero(self.data.selectedHero[1])
		self.imgBgLv:setVisible(true)
		self.textName:setText(self.hero.name)
	end

	self.imgBg3:setVisible(isFake)
	self.imgHeroIcon:setVisible(not isFake)
end

function GridHeroStarMaterial:setSameCampHero()
	self.imgGroupIcon:setVisible(true)

	local isFake = #self.data.selectedHero == 0

	if isFake then
		self.imgStar:setImage(HERO_COMMON_ATLAS, "IconStar0" .. self.data.needStar)
		self.textName:setText(string.format(Lang.get(30390), self.data.needStar))
		self.imgHeroIcon:setImage(HERO_COMMON_ATLAS, "IconHeroCommon")
		self.imgGroupIcon:setImage("Atlas/HeroAtlas/HeroCardCommonAtlas", "IconGroup0" .. self.data.needCamp)
	else
		self:setHero(self.data.selectedHero[1])
		self.imgBgLv:setVisible(true)
		self.textName:setText(self.hero.name)
	end

	self.imgBg3:setVisible(isFake)
	self.imgHeroIcon:setVisible(not isFake)
end

function GridHeroStarMaterial:refreshGridByNewSelectList(selectList)
	self.data.selectedHero = selectList

	self:setData(self.data, self.materialType)
end

function GridHeroStarMaterial:setFake(isFake)
	self.txtHeroLv:setVisible(not isFake)
	self.txtStage:setVisible(not isFake)
	self:setGridGray(isFake)
	self.bgStage:setVisible(not isFake)

	if not isFake then
		local step = self.data.selectedHero[1].step

		self.bgStage:setVisible(step ~= 0)
	end
end

function GridHeroStarMaterial:setGridGray(isGray)
	self.imgBar1:setObjGray(isGray)
	self.imgHeroIcon:setObjGray(isGray)
end

return GridHeroStarMaterial
