-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookHeroCard.lua

local strClassName = "HandBookHeroCard"
local HandBookHeroCard = Class(strClassName, UIControls.HeroCardLoop)

function HandBookHeroCard:ctor()
	self:_initUI()
end

function HandBookHeroCard:_initUI()
	return
end

function HandBookHeroCard:_setHero(hero)
	self:setHero(hero)

	local geted = CurAvatar.handBookHeroDic and CurAvatar.handBookHeroDic[self.hero.id] ~= nil
	local bagHad = self.mWindow.idGrowthestHeroDic and self.mWindow.idGrowthestHeroDic[self.hero.id] ~= nil

	if not geted then
		self.imgStateIcon2:setImage("Atlas/HandBookAtlas/HandBookAtlas", "TxtNotObtained")
	elseif self.mWindow.isShowGrowth and not bagHad then
		self.imgStateIcon2:setImage("Atlas/HandBookAtlas/HandBookAtlas", "TxtOnceOwned01")
	end

	self.imgStateIcon2:setVisible(not geted or self.mWindow.isShowGrowth and not bagHad)
	self.imgHeroIcon:setImageGray(not geted or self.mWindow.isShowGrowth and not bagHad)

	if not self.mWindow.isShowGrowth then
		self.imgPaint:setVisible(false)
	end
end

return HandBookHeroCard
