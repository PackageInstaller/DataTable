-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\HeroGridSneakBattlePFCard.lua

local HeroGridSneakBattleCard = require("UI/SneakBattle/HeroGridSneakBattleCard")
local HeroGridSneakBattlePFCard = Class("HeroGridSneakBattlePFCard", HeroGridSneakBattleCard)

function HeroGridSneakBattlePFCard:ctor(...)
	self.bgPreSel = UIControls.Image(self, "InfoPanel/SneakBattlePanel/BgPreSel")
	self.imgNowSelect = UIControls.Image(self, "InfoPanel/SneakBattlePanel/ImgSel1")
	self.imgUnLocked = UIControls.Image(self, "InfoPanel/SneakBattlePanel/ImgSel2")
	self.imgLocked = UIControls.Image(self, "InfoPanel/SneakBattlePanel/ImgSel3")
	self.txtUnLocked = UIControls.Label(self, "InfoPanel/SneakBattlePanel/ImgSel2/Text")
	self.txtLocked = UIControls.Label(self, "InfoPanel/SneakBattlePanel/ImgSel3/Text")
	self.txtNowSelect = UIControls.Label(self, "InfoPanel/SneakBattlePanel/ImgSel1/Text")

	self.bgPreSel:setVisible(false)
end

function HeroGridSneakBattlePFCard:setHero(hero)
	HeroGridSneakBattlePFCard.super.setHero(self, hero)
	self.imgCanUpgrade:setVisible(false)
	self.bgStandby:setVisible(false)
	self.bgInBattle:setVisible(false)
	self:refreState()
end

function HeroGridSneakBattlePFCard:refreState(...)
	if self.hero and self.hero.canUse then
		local stage = -self.hero.sneakStage

		if self.hero.canUse == 1 then
			self.imgLocked:setVisible(false)
			self.imgUnLocked:setVisible(true)
		else
			self.imgLocked:setVisible(true)
			self.imgUnLocked:setVisible(false)
		end

		if stage ~= 0 then
			self.txtUnLocked:setText(utils.format(Lang.get(93812), stage))
			self.txtLocked:setText(utils.format(Lang.get(93812), stage))
			self.txtNowSelect:setText(utils.format(Lang.get(93812), stage))
		else
			self.imgLocked:setVisible(false)
			self.imgUnLocked:setVisible(false)
			self.imgNowSelect:setVisible(false)
		end

		if self.mWindow and self.mWindow.nowSelectStage then
			if stage == self.mWindow.nowSelectStage then
				self.imgNowSelect:setVisible(true)
				self.imgLocked:setVisible(false)
				self.imgUnLocked:setVisible(false)
			else
				self.imgNowSelect:setVisible(false)
			end
		else
			self.imgNowSelect:setVisible(false)
		end
	end
end

return HeroGridSneakBattlePFCard
