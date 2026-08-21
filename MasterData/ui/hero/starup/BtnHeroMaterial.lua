-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\BtnHeroMaterial.lua

local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local strClassName = "BtnHeroMaterial"
local BtnHeroMaterial = Class(strClassName, UIControls.Child)

function BtnHeroMaterial:ctor()
	self:initUI()
end

function BtnHeroMaterial:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.gridPanel = UIControls.Panel(self, "GridHeroStarUpPanel")
	self.imgHeroAdd = UIControls.Panel(self, "HeroAdd")
end

function BtnHeroMaterial:setRealHero(hero)
	self.realHero = hero

	self:refreshHeroGrid()
	self.gridHero:setHero(self.realHero)
	self.gridPanel:setCanvasGroupAlpha(1)
	self.imgHeroAdd:setCanvasGroupAlpha(0)
end

function BtnHeroMaterial:initFakeHero(hero)
	self.fakeHero = hero

	self:refreshHeroGrid()
	self.gridHero:setStarUpFakeHero(self.fakeHero)
	self.gridPanel:setCanvasGroupAlpha(0.8)
	self.imgHeroAdd:setCanvasGroupAlpha(1)
end

function BtnHeroMaterial:refreshHeroGrid()
	if not self.gridHero then
		self.gridHero = GridHeroStarUp(self, "GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")

		self.gridHero:setClickCallback(Slot(self.onBtnSelfClick, self))
		self.gridHero:setVisible(true)
	end
end

function BtnHeroMaterial:onBtnSelfClick()
	if self.realHero then
		self.mParent:removeMaterial(self.realHero)
	else
		local prepareMaterialList = {}

		if self.fakeHero.id then
			for _, hero in pairs(CurAvatar.heroDic) do
				if hero.gid ~= self.mParent.hero.gid and hero.lock == 0 and CurAvatar:isStarUpNeed(self.fakeHero, hero) then
					table.insert(prepareMaterialList, {
						hero,
						hero.starUpPriority
					})
				end
			end

			local realUseMaterialList = self.mParent:isCanFullMaterial(prepareMaterialList)

			if realUseMaterialList then
				MsgManager.notice(string.format(Lang.get(30392), self.fakeHero.name))
			else
				self.mParent:jumpToDrawCard(utils.format(Lang.get(30393), UIConst.HERO_STAR_EMOJI_DIC[self.fakeHero.star], self.fakeHero.name))
			end
		elseif self.fakeHero.camp then
			for _, hero in pairs(CurAvatar.heroDic) do
				if hero.gid ~= self.mParent.hero.gid and hero.lock == 0 and hero.quality < 4 and CurAvatar:isStarUpNeed(self.fakeHero, hero) then
					table.insert(prepareMaterialList, {
						hero,
						hero.starUpPriority
					})
				end
			end

			local realUseMaterialList = self.mParent:isCanFullMaterial(prepareMaterialList)

			if realUseMaterialList then
				MsgManager.notice(string.format(Lang.get(30394), Const.CAMP_CONFIG[self.fakeHero.camp].name))
			else
				self.mParent:jumpToDrawCard(utils.format(Lang.get(30395), UIConst.HERO_STAR_EMOJI_DIC[self.fakeHero.star], Const.CAMP_CONFIG[self.fakeHero.camp].name))
			end
		else
			MsgManager.clientNotice(251)
		end
	end
end

function BtnHeroMaterial:removeMaterial()
	self.realHero = nil

	self.gridHero:setStarUpFakeHero(self.fakeHero)
	self.gridPanel:setCanvasGroupAlpha(0.8)
	self.imgHeroAdd:setCanvasGroupAlpha(1)
end

return BtnHeroMaterial
