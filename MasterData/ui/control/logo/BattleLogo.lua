-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Logo\\BattleLogo.lua

local UserData = require("Helper/UserData")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleLogoStateCell = require("UI/Control/Logo/BattleLogoStateCell")
local strClassName = "BattleLogo"
local BattleLogo = Class(strClassName, UIControls.Logo)
local TIME_BUBBLE_HIDE = 5

function BattleLogo:ctor(entity, prefabPath, x, y)
	self.entity = entity
	self.name = ""

	self:initUI()

	self.hpRate = nil
	self.preShield = 0
	self.maxShield = 0
end

function BattleLogo:destroy()
	BattleLogo.super.destroy(self)
end

function BattleLogo:initUI()
	self.imgBg = UIControls.Image(self, "BloodPanel/Bg/BgBlood")
	self.imgShield = UIControls.Image(self, "BloodPanel/Bg/BgShield")
	self.sliderShield = UIControls.Slider(self, "BloodPanel/Bg/BgShield/SliderShield")
	self.sliderHp = UIControls.Slider(self, "BloodPanel/Bg/SliderBlood")
	self.imgSliderHp = UIControls.Image(self, "BloodPanel/Bg/SliderBlood/Fill")
	self.sliderHpPre = UIControls.Slider(self, "BloodPanel/Bg/SliderBloodB")
	self.imgSliderHpPre = UIControls.Image(self, "BloodPanel/Bg/SliderBloodB/Fill")
	self.uiPower = UIControls.Slider(self, "BloodPanel/Bg/SliderEnergy")

	self.uiPower:setValue(0)

	self.panelInfo = UIControls.Panel(self, "BloodPanel/Bg/InfoPanel")
	self.textHp = UIControls.Label(self, "BloodPanel/Bg/InfoPanel/TextBlood")
	self.textHpPer = UIControls.Label(self, "BloodPanel/Bg/InfoPanel/TextBloodPer")

	self:refreshInfoLevel(UserData.loadCommonData(BattleConst.INFO_LEVEL_KEY) or BattleConst.INFO_LEVEL_DEFAULT)

	self.iconStates = {}
	self.imgElite = UIControls.Image(self, "BloodPanel/IconBoss")
end

function BattleLogo:setElite(eliteType)
	if eliteType and eliteType > 0 then
		self.imgElite:setVisible(true)
	end
end

function BattleLogo:setCamp(friend)
	if friend then
		self.imgBg:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BarSelfBloodBack")
		self.imgSliderHpPre:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BarSelfBlood1")
		self.imgSliderHp:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BarSelfBlood2")
	else
		self.imgBg:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BarEnemyBloodBack")
		self.imgSliderHpPre:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BarEnemyBlood1")
		self.imgSliderHp:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BarEnemyBlood2")
	end
end

function BattleLogo:setHp(hp, mhp, isDamage)
	local nowRate = hp / mhp

	if self.hpRate == nil then
		self.sliderHp:setValue(nowRate)
		self.sliderHpPre:setValue(nowRate)
	elseif nowRate < self.hpRate then
		self.sliderHpPre:setValue(nowRate, 1)
		self.sliderHp:setValue(nowRate)
	else
		self.sliderHpPre:setValue(nowRate)
		self.sliderHp:setValue(nowRate, 1)
	end

	self.hp = hp
	self.mhp = mhp
	self.hpRate = nowRate

	if self.panelInfo:getVisible() then
		self.textHp:setText(ClientUtils.getNumShortStr(math.ceil(self.hp)))

		local perValue = math.floor(self.hpRate * 100 + 0.5)

		if self.hpRate > 0 and perValue == 0 then
			perValue = 1
		elseif perValue == 100 and self.hpRate < 1 then
			perValue = 99
		end

		self.textHpPer:setText(math.min(100, perValue) .. "%")
	end
end

function BattleLogo:refreshInfoLevel(infoLevel)
	if infoLevel ~= BattleConst.INFO_LEVEL_MIDDLE then
		self.panelInfo:setVisible(false)
	else
		self.panelInfo:setVisible(true)

		if self.hp then
			self.textHp:setText(ClientUtils.getNumShortStr(math.ceil(self.hp)))

			local perValue = math.floor(self.hpRate * 100 + 0.5)

			if self.hpRate > 0 and perValue == 0 then
				perValue = 1
			elseif perValue == 100 and self.hpRate < 1 then
				perValue = 99
			end

			self.textHpPer:setText(math.min(100, perValue) .. "%")
		end
	end
end

function BattleLogo:setMana(mana, maxMana, manaSpeed)
	if maxMana <= mana or manaSpeed == 0 then
		self.uiPower:setValue(mana / maxMana)
	elseif manaSpeed < 0 then
		self.uiPower:setValue(mana / maxMana)
		self.uiPower:setValue(0, mana / -manaSpeed)
	else
		self.uiPower:setValue(mana / maxMana)
		self.uiPower:setValue(1, (maxMana - mana) / manaSpeed)
	end
end

function BattleLogo:setShield(shield)
	if shield > self.preShield then
		if self.preShield == 0 then
			self.imgShield:setVisible(true)
		end

		self.sliderShield:setValue(1)

		self.preShield = shield
		self.maxShield = shield
	elseif shield < self.preShield then
		self.sliderShield:setValue(shield / self.maxShield, 0.3)

		self.preShield = shield

		if shield == 0 then
			self.imgShield:setVisible(false)
		end
	end
end

function BattleLogo:onAddState(userId, stateId, stateLevel, stateData)
	self:onDelState(userId, stateId)

	local newIcon = BattleLogoStateCell(self, "StatePanel", "System/Battle/BattleField/BattleStateCell", 0, 0, true)

	newIcon:setData(userId, stateId, stateLevel, stateData)
	table.insert(self.iconStates, newIcon)
end

function BattleLogo:onDelState(userId, stateId)
	for index, cell in ipairs(self.iconStates) do
		if cell.userId == userId and cell.stateId == stateId then
			cell:setVisible(false)
			cell:destroy()
			table.remove(self.iconStates, index)
		end
	end
end

return BattleLogo
