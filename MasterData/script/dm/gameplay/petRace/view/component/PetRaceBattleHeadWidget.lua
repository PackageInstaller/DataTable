-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceBattleHeadWidget.lua

local HpTierMap = {
	"zhandou_bg_tx_xue01_2.png",
	"zhandou_bar_01.png",
	"zhandou_bar_02.png",
	"zhandou_bar_03.png",
	"zhandou_bar_04.png"
}

PetRaceBattleHeadWidget = class("PetRaceBattleHeadWidget", BattleWidget, _M)

function PetRaceBattleHeadWidget:initialize(view, isLeft)
	super.initialize(self, view)

	if isLeft then
		self:setIsLeft()
	end

	self:_setupUI()
end

function PetRaceBattleHeadWidget:setIsLeft()
	self._isLeft = true
end

function PetRaceBattleHeadWidget:_setupUI()
	self._barbg = self:getView():getChildByFullName("content.bar_bg")

	local hpbar = self:getView():getChildByFullName("content.hpbar.hpbar")
	local offsetHpX = self._isLeft and -1.5 or 1.5
	local offsetHpY = 3

	self._hpbar4 = cc.MovieClip:create("bxuetiaoc_xuetiao"):posite(hpbar:getPosition()):offset(offsetHpX, offsetHpY):addTo(hpbar:getParent())

	self._hpbar4:setScaleX(hpbar:getScaleX())
	self._hpbar4:gotoAndStop(1)

	self._hpbar3 = cc.MovieClip:create("bxuetiaob_xuetiao"):posite(hpbar:getPosition()):offset(offsetHpX, offsetHpY):addTo(hpbar:getParent())

	self._hpbar3:setScaleX(hpbar:getScaleX())
	self._hpbar3:gotoAndStop(1)

	self._barPic2 = ccui.ImageView:create()

	self._barPic2:loadTexture(HpTierMap[1], ccui.TextureResType.plistType)

	self._hpbar2 = cc.MovieClip:create("bxuetiaoa_xuetiao"):posite(hpbar:getPosition()):offset(offsetHpX, offsetHpY):addTo(hpbar:getParent())

	self._hpbar2:setScaleX(hpbar:getScaleX())
	self._barPic2:addTo(self._hpbar2:getChildByName("bar"))
	self._hpbar2:gotoAndStop(100)

	self._barPic1 = ccui.ImageView:create()

	self._barPic1:loadTexture(HpTierMap[1], ccui.TextureResType.plistType)

	self._hpbar1 = cc.MovieClip:create("bxuetiao_xuetiao"):posite(hpbar:getPosition()):offset(offsetHpX, offsetHpY):addTo(hpbar:getParent())

	self._hpbar1:setScaleX(hpbar:getScaleX())
	self._barPic1:addTo(self._hpbar1:getChildByName("bar"))
	self._hpbar1:gotoAndStop(100)

	self._hpbarShine4 = cc.MovieClip:create("guangtt_xuetiao"):posite(-166, 0):addTo(self._hpbar4)

	self._hpbarShine4:setName("shine")
	self._hpbarShine4:setVisible(false)
	self._hpbarShine4:addEndCallback(function(cid, mc)
		mc:stop()
		mc:setVisible(false)
	end)
	self._hpbar4:setUpdateFrameHook(function(mc, frame)
		local shine = mc:getChildByName("shine")

		shine:setPositionX(-165 + 326 * frame / 100)

		if frame <= 3 then
			shine:setVisible(false)
		end
	end)

	self._hpbarShine3 = cc.MovieClip:create("guangtt_xuetiao"):posite(-166, 0):addTo(self._hpbar3)

	self._hpbarShine3:setName("shine")
	self._hpbarShine3:setVisible(false)
	self._hpbarShine3:addEndCallback(function(cid, mc)
		mc:stop()
		mc:setVisible(false)
	end)
	self._hpbar3:setUpdateFrameHook(function(mc, frame)
		local shine = mc:getChildByName("shine")

		shine:setPositionX(165 - 331 * frame / 100)

		if frame > 97 then
			shine:setVisible(false)
		end
	end)

	self._hpbarShine2 = cc.MovieClip:create("guangtt_xuetiao"):posite(-166, 0):addTo(self._hpbar2)

	self._hpbarShine2:setName("shine")
	self._hpbarShine2:setVisible(false)
	self._hpbarShine2:addEndCallback(function(cid, mc)
		mc:stop()
		mc:setVisible(false)
	end)
	self._hpbar2:setUpdateFrameHook(function(mc, frame)
		local shine = mc:getChildByName("shine")

		shine:setPositionX(-165 + 326 * frame / 100)

		if frame <= 3 then
			shine:setVisible(false)
		end
	end)

	self._hpbarShine1 = cc.MovieClip:create("guangtt_xuetiao"):posite(-166, 0):addTo(self._hpbar1)

	self._hpbarShine1:setName("shine")
	self._hpbarShine1:setVisible(false)
	self._hpbarShine1:addEndCallback(function(cid, mc)
		mc:stop()
		mc:setVisible(false)
	end)
	self._hpbar1:setUpdateFrameHook(function(mc, frame)
		local shine = mc:getChildByName("shine")

		shine:setPositionX(165 - 331 * frame / 100)

		if frame > 97 then
			shine:setVisible(false)
		end
	end)
	hpbar:removeFromParent()

	self._hpText = self:getView():getChildByFullName("content.text_hp")
	self._hpPercentText = self:getView():getChildByFullName("content.text_hp_percent")

	local slot1 = self:getView():getChildByFullName("Slot1")
	local slot2 = self:getView():getChildByFullName("Slot2")
	local slot3 = self:getView():getChildByFullName("Slot3")

	self._slots = {
		slot1,
		slot2,
		slot3
	}
end

function PetRaceBattleHeadWidget:setMasterIcon(modelIds)
	if not modelIds then
		return
	end
end

function PetRaceBattleHeadWidget:setMasterDie(modelIds)
	if not modelIds then
		return
	end
end

function PetRaceBattleHeadWidget:setListener(listener)
	return
end

function PetRaceBattleHeadWidget:setHp(value, maxHp)
	if maxHp then
		self._maxHp = maxHp
	end

	self._hp = math.min(math.ceil(value), self._maxHp)
	self._hp = math.max(self._hp, 0)

	local percent = self._hp / self._maxHp
	local percentFix = math.min(math.max(math.floor(percent * 100), 1), 100)

	if self._prevHpPercent ~= percentFix then
		self._hpbar1:clearCallbacks()
		self._hpbar2:clearCallbacks()
		self._hpbar3:clearCallbacks()
		self._hpbar4:clearCallbacks()
	end

	if self._prevHpPercent == nil then
		self._hpbar1:setVisible(true)
		self._hpbar2:setVisible(false)
		self._hpbar3:setVisible(false)
		self._hpbar4:setVisible(false)
		self._hpbar1:gotoAndStop(101 - percentFix)
		self._hpbar2:gotoAndStop(percentFix)
		self._hpbar3:gotoAndStop(101 - percentFix)
		self._hpbar4:gotoAndStop(percentFix)
	elseif percentFix > self._prevHpPercent then
		self._hpbar1:setVisible(false)
		self._hpbar2:setVisible(true)
		self._hpbar3:setVisible(false)
		self._hpbar4:setVisible(true)

		if not self._curingEffect then
			self._curingEffect = cc.MovieClip:create("daxuetiaohuifu_xuetiao"):posite(self._hpbar1:getPosition()):addTo(self._hpbar1:getParent())

			self._curingEffect:setScaleX(self._barbg:isFlippedX() and -1 or 1)
		end

		if not self._curingEffect:isVisible() then
			self._curingEffect:setVisible(true)
			self._curingEffect:gotoAndPlay(1)
			self._curingEffect:addEndCallback(function(cid, mc)
				mc:stop()
				mc:setVisible(false)
			end)
		else
			self._curingEffect:clearCallbacks()
			self._curingEffect:addCallbackAtFrame((self._curingEffect:getCurrentFrame() - 2) % 15 + 1, function(cid, mc, frame)
				mc:stop()
				mc:setVisible(false)
			end)
		end

		local frame1 = 101 - self._hpbar1:getCurrentFrame()
		local frame2 = 101 - self._hpbar3:getCurrentFrame()
		local trgtFrame = percentFix
		local curFrame = self._prevHpPercent
		local bar = self._hpbar2
		local bar2 = self._hpbar4
		local speed = (trgtFrame - (curFrame == frame1 and bar:getCurrentFrame() or frame1)) / 24

		speed = speed > 50 and 0 or speed

		if speed > 0 then
			bar:setPlaySpeed(speed * 1)
			bar2:setPlaySpeed(speed * 1.5)
			bar:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
			end)
			bar2:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
			end)

			if curFrame == frame1 then
				bar:play()
			else
				bar:gotoAndPlay(frame1)
			end

			if curFrame == frame2 then
				bar2:play()
			else
				bar2:gotoAndPlay(frame2)
			end

			bar:getChildByName("shine"):setVisible(true)
			bar:getChildByName("shine"):gotoAndPlay(1)
			bar2:getChildByName("shine"):setVisible(true)
			bar2:getChildByName("shine"):gotoAndPlay(1)
		else
			bar:gotoAndStop(trgtFrame)
			bar2:gotoAndStop(trgtFrame)
		end

		self._hpbar1:gotoAndStop(101 - percentFix)
		self._hpbar3:gotoAndStop(101 - percentFix)
	elseif percentFix < self._prevHpPercent then
		self._hpbar1:setVisible(true)
		self._hpbar2:setVisible(false)
		self._hpbar3:setVisible(true)
		self._hpbar4:setVisible(false)

		local frame1 = 101 - self._hpbar2:getCurrentFrame()
		local frame2 = 101 - self._hpbar4:getCurrentFrame()
		local trgtFrame = 101 - percentFix
		local curFrame = 101 - self._prevHpPercent
		local bar = self._hpbar1
		local bar2 = self._hpbar3
		local speed = (trgtFrame - (curFrame == frame1 and bar:getCurrentFrame() or frame1)) / 24

		speed = speed > 50 and 0 or speed

		if speed > 0 then
			bar:setPlaySpeed(speed * 1.5)
			bar2:setPlaySpeed(speed * 1)
			bar:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
			end)
			bar2:addCallbackAtFrame(trgtFrame, function(cid, mc, frame)
				mc:stop()
			end)

			if curFrame == frame1 then
				bar:play()
			else
				bar:gotoAndPlay(frame1)
			end

			if curFrame == frame2 then
				bar2:play()
			else
				bar2:gotoAndPlay(frame2)
			end

			bar:getChildByName("shine"):setVisible(true)
			bar:getChildByName("shine"):gotoAndPlay(1)
			bar2:getChildByName("shine"):setVisible(true)
			bar2:getChildByName("shine"):gotoAndPlay(1)
		else
			bar:gotoAndStop(trgtFrame)
			bar2:gotoAndStop(trgtFrame)
		end

		self._hpbar2:gotoAndStop(percentFix)
		self._hpbar4:gotoAndStop(percentFix)
	end

	self._prevHpPercent = percentFix

	local function formatCount(count)
		if count <= 99999 then
			return tostring(math.floor(count)), false
		else
			count = count - count % 1000
			count = string.format("%.1f", count / 10000) .. "w"

			return count, true
		end
	end

	self._hpText:setString(formatCount(self._hp) .. "/" .. formatCount(self._maxHp))
	self._hpPercentText:setString(tostring(string.format("%.f%%", self._hp / self._maxHp * 100)))
end

function PetRaceBattleHeadWidget:setRp(value, maxRp)
	return
end

function PetRaceBattleHeadWidget:setCardNum(cardNum)
	return
end

function PetRaceBattleHeadWidget:reduceCard()
	return
end

function PetRaceBattleHeadWidget:updateHeadInfo(data)
	self._maxHp = data.maxHp

	self:setMasterIcon(data.modelIds)
	self:setHp(data.hp)
end

function PetRaceBattleHeadWidget:shake(...)
	return
end

function PetRaceBattleHeadWidget:updateHeros(heros)
	self._heros = heros
	self._heroInfos = {}

	for i = 1, 3 do
		self._slots[i]:removeAllChildren()
	end
end

function PetRaceBattleHeadWidget:spawnHero(dataModel)
	if self._heros and next(self._heros) ~= nil then
		local heroId = dataModel:getRoleId()

		for i = 1, 3 do
			if heroId == self._heros[i] then
				self._prevHpPercent = nil

				local data = {
					id = heroId,
					cost = dataModel:getCost(),
					hero = {
						id = heroId,
						model = dataModel:getModelId()
					}
				}
				local view = HeroCardWidget:createWidgetNode()
				local card = HeroCardWidget:new(view)

				card:updateCardInfo(data)
				self._slots[i]:removeAllChildren()
				self._slots[i]:addChild(view)
				view:setName("card")
				self:updateHeroHpInfo(heroId, dataModel:getHp(), dataModel:getMaxHp())

				return true
			end
		end
	end
end

function PetRaceBattleHeadWidget:updateHeroHpInfo(heroId, hp, maxHp)
	if self._heros and next(self._heros) ~= nil then
		local totalHp, totalMaxHp = 0, 0
		local changed = false

		for i = 1, #self._heros do
			self._heroInfos[i] = self._heroInfos[i] or {}

			if self._heros[i] == heroId then
				if hp then
					self._heroInfos[i].hp = hp
				end

				if maxHp then
					self._heroInfos[i].maxHp = maxHp
				end

				changed = true
			end

			totalHp = totalHp + (self._heroInfos[i].hp or 0)
			totalMaxHp = totalMaxHp + (self._heroInfos[i].maxHp or 0)
		end

		if changed then
			self:setHp(totalHp, totalMaxHp)
		end
	end
end

function PetRaceBattleHeadWidget:unitDie(heroId)
	if self._heros and next(self._heros) ~= nil then
		for i = 1, #self._heros do
			if self._heros[i] == heroId then
				local slot = self._slots[i]
				local card = slot:getChildByName("card")

				card:setGray(true)
				slot:removeChildByName("cha")

				local cha = cc.Sprite:createWithSpriteFrameName("smzb_bg_zdcha.png")

				cha:posite(2.64, 9.23):setScale(3.2)
				slot:addChild(cha, 1)
				self:updateHeroHpInfo(heroId, 0)

				return
			end
		end
	end
end
