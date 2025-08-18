-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\HeroGridSneakBattleCard.lua

local HeroGridSneakBattleCard = Class("HeroGridSneakBattleCard", UIControls.HeroCardLoop)

function HeroGridSneakBattleCard:ctor(...)
	self.bgStandby = UIControls.Image(self, "InfoPanel/SneakBattlePanel/BgStandby")
	self.bgInBattle = UIControls.Image(self, "InfoPanel/SneakBattlePanel/BgInBattle")
	self.txtInBattle = UIControls.Label(self, "InfoPanel/SneakBattlePanel/BgInBattle/TextInBattle")
	self.sensor = UIControls.Panel(self, "")

	self.sensor:addEventDragOnClick(self.onDragClick)

	self.showTips = false
	self.isDragTip = true
	self.showSelPic = false
end

function HeroGridSneakBattleCard:onDragClick(sender)
	if self.showTips then
		if self.isDragTip then
			local tips = UIManager.getUI("battleDragHeroTips")

			tips:show(self)
			tips:correctPos(true)
		else
			local tips = UIManager.getUI("heroTips")

			tips:show(self)
		end
	end
end

function HeroGridSneakBattleCard:setSelected(isSelected)
	self.beSelected = isSelected

	self.btnSelf:setEnable(not isSelected)
end

function HeroGridSneakBattleCard:setChooseState(v)
	if v then
		if self.imgBgDie:getVisible() then
			self.imgDieSel:setVisible(v)
			self.imgSel:setVisible(not v)
		else
			self.imgDieSel:setVisible(not v)
			self.imgSel:setVisible(v)
		end
	else
		self.imgDieSel:setVisible(v)
		self.imgSel:setVisible(v)
	end
end

function HeroGridSneakBattleCard:setHero(hero)
	HeroGridSneakBattleCard.super.setHero(self, hero)
	self.sensor:setObjGray(false)

	if hero.sneakState then
		if hero.sneakState == 1 then
			self.bgStandby:setVisible(false)
			self.bgInBattle:setVisible(true)

			local stage = -hero.sneakStage

			self.txtInBattle:setText(utils.format(Lang.get(93812), stage))
		else
			self.bgStandby:setVisible(true)
			self.bgInBattle:setVisible(false)
		end
	else
		self.bgStandby:setVisible(true)
		self.bgInBattle:setVisible(false)
	end

	local actData = CurAvatar:getSneakBattleActivityData()

	if actData then
		if actData.canRelicHeroIdMap and actData.canRelicHeroIdMap[hero.id] then
			self.imgCanUpgrade:setVisible(true)
		else
			self.imgCanUpgrade:setVisible(false)
		end
	end
end

return HeroGridSneakBattleCard
