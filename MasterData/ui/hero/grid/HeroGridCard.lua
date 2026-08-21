-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\Grid\\HeroGridCard.lua

local strClassName = "HeroGridCard"
local HeroGridCard = Class(strClassName, UIControls.HeroCardLoop)

function HeroGridCard:initUI()
	HeroGridCard.super.initUI(self)

	self.imgCanUpgrade = UIControls.Image(self, "InfoPanel/IconNew2")
	self.imgIconNew = UIControls.Image(self, "InfoPanel/IconNew")
end

local REDDOT_TABLE = {
	"canStepUpInTeamHerosDic",
	"canEquipInTeamHerosDic",
	"canSweepStepInTeamHerosDic",
	"canNewBaseUnlockDic",
	"canNewSkinUnlockDic",
	"canQuickSweepInTeamHerosDic"
}
local REDDOT_TABLE_HERO_ID = {
	"canUnLockPaintPlusMainPropDic",
	"canUpPaintPlusRelateLevelDic",
	"canUnLockSeasonRelicHeroDic",
	"canLvUpSeasonRelicHeroDic",
	"firstShowSeasonRelicHeroDic"
}
local REDDOT_TABLE_STICK = {
	"canLvUpStickHeroDic"
}

function HeroGridCard:setData(hero, idx)
	self.idx = idx

	self:setHero(hero)
	self:setSelected(self.mWindow.selectedHero ~= nil and self.hero.gid == self.mWindow.selectedHero.gid)

	for _, table in ipairs(REDDOT_TABLE) do
		if CurAvatar[table] and CurAvatar[table][self.hero.gid] then
			self.imgCanUpgrade:setVisible(true)

			return
		end
	end

	for _, table in ipairs(REDDOT_TABLE_HERO_ID) do
		if CurAvatar[table] and CurAvatar[table][self.hero.id] then
			self.imgCanUpgrade:setVisible(true)

			return
		end
	end

	if Const.HERO_STICK_LV_UP_OPEN then
		for _, table in ipairs(REDDOT_TABLE_STICK) do
			if CurAvatar[table] and CurAvatar[table][self.hero.id] then
				self.imgCanUpgrade:setVisible(true)

				return
			end
		end
	end

	self.imgCanUpgrade:setVisible(false)

	if CurAvatar.fiveUpStarNewHeroDic then
		self.imgIconNew:setVisible(CurAvatar.fiveUpStarNewHeroDic[hero.gid] ~= nil)
	end
end

function HeroGridCard:setSelected(isSelected)
	self.beSelected = isSelected

	self.btnSelf:setEnable(self.beSelected == false)

	if self.beSelected == true then
		self.mWindow:setSelectHero(self.hero, self.idx)
	end
end

return HeroGridCard
