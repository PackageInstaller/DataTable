-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\CardMonsterMixin.lua

local CardMonsterMixin = {}

function CardMonsterMixin:ctorMixin()
	self.mEnableTips = true

	self:initUI()
end

function CardMonsterMixin:initUI()
	self.imgMonster = UIControls.Image(self, "IconMoster")
	self.txtMonsterLevel = UIControls.Label(self, "Textlv")
	self.panelLevelDesc = UIControls.Panel(self, "Textlv/Text")
	self.imgQuality = UIControls.Image(self, "ImgQuality")
	self.imgBgStar = UIControls.Image(self, "BgStar")
	self.imgStar = UIControls.Image(self, "ImgStar")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onClickSensor)
end

function CardMonsterMixin:setObj(monster)
	self.monster = monster

	self.imgQuality:setVisible(false)
	self.imgStar:setVisible(false)
	self.imgBgStar:setVisible(false)

	if RegionUtils.isCN() then
		self.txtMonsterLevel:setText(self.monster.level or "")
	else
		self.panelLevelDesc:setVisible(false)

		if Const.REVIEW_VERSION then
			self.txtMonsterLevel:setText(Lang.get(1203) .. (self.monster.level or ""))
		else
			self.txtMonsterLevel:setText("Lv." .. (self.monster.level or ""))
		end
	end

	local iconPath = monster:getIconPath()

	if iconPath then
		self.imgMonster:setImage(iconPath[1], iconPath[2])
	end
end

function CardMonsterMixin:setHero(hero)
	self.hero = hero

	if RegionUtils.isCN() then
		self.txtMonsterLevel:setText(self.monster.level or "")
	else
		self.panelLevelDesc:setVisible(false)

		if Const.REVIEW_VERSION then
			self.txtMonsterLevel:setText(Lang.get(1203) .. (self.monster.level or ""))
		else
			self.txtMonsterLevel:setText("Lv." .. (self.monster.level or ""))
		end
	end

	local iconPath = hero:getIconPath()

	if iconPath then
		self.imgMonster:setImage(iconPath[1], iconPath[2])
	end

	self.imgQuality:setVisible(true)

	local qualityPath = UIConst.COMMON_QUALITY_CONFIG[self.quality]

	if qualityPath then
		self.imgQuality:setImage(qualityPath[1], qualityPath[2])
	end

	self.imgStar:setVisible(true)

	local starPath = self.hero:getStarPath()

	if starPath then
		self.imgStar:setImage(starPath[1], starPath[2])
	end

	self.imgBgStar:setVisible(true)
end

function CardMonsterMixin:onClickSensor(sender)
	if self.mEventClick then
		self.mEventClick(self)
	end

	self:openTipsPanel()

	if self._onGridClick ~= nil then
		self:_onGridClick()
	end
end

function CardMonsterMixin:openTipsPanel()
	if self.mEnableTips then
		UIManager.getUI("heroTips"):show(self)
	end
end

return CardMonsterMixin
