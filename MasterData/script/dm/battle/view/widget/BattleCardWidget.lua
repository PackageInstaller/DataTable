-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleCardWidget.lua

BattleCardWidget = class("BattleCardWidget", BattleWidget, _M)

BattleCardWidget:has("_index", {
	is = "rw"
})
BattleCardWidget:has("_cardId", {
	is = "r"
})
BattleCardWidget:has("_cost", {
	is = "rw"
})
BattleCardWidget:has("_cardInfo", {
	is = "rw"
})
BattleCardWidget:has("_isEntering", {
	is = "rb"
})

function BattleCardWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function BattleCardWidget:dispose()
	super.dispose(self)
end

function BattleCardWidget:isExtraCard()
	return false
end

function BattleCardWidget:initSubviews(view)
	local cardNode = view:getChildByFullName("card_node")

	self._cardNode = cardNode
	self._animPlaySta = true
	self._costBg = cardNode:getChildByFullName("energy_bg")
	self._lblCost = cardNode:getChildByFullName("energy_lab")
	self._iconImageNode = cardNode:getChildByFullName("icon_rect.icon_region")
	self._viewSize = self._iconImageNode:getContentSize()

	self:createMaskNode()

	self._energyIsEnough = true

	self:addCardAnim()
end

function BattleCardWidget:createMaskNode()
	local barImgPath = "asset/common/pic_mengban_sms.png"
	local barImage = cc.Sprite:create(barImgPath)
	local cardMaskNode = cc.ProgressTimer:create(barImage)

	cardMaskNode:setType(0)
	cardMaskNode:setScaleX(-0.95)
	cardMaskNode:setScaleY(0.85)
	cardMaskNode:setAnchorPoint(cc.p(0.5, 0.5))
	cardMaskNode:setMidpoint(cc.p(0.5, 0.5))
	cardMaskNode:offset(0, 5)
	cardMaskNode:setVisible(false)
	self._cardNode:addChild(cardMaskNode, 100)

	self._cardMaskNode = cardMaskNode
end

function BattleCardWidget:hitTest(globalPoint)
	local localPoint = self._iconImageNode:convertToNodeSpace(globalPoint)
	local size = self._viewSize
	local cardRect = cc.rect(0, 0, size.width, size.height)

	return cc.rectContainsPoint(cardRect, localPoint)
end

function BattleCardWidget:setCost(cost)
	if self._cost ~= cost then
		self._cost = cost

		if self._lblCost then
			self._lblCost:setString(tostring(cost))
		end
	end
end

function BattleCardWidget:setCostColor(color)
	if self._lblCost then
		self._lblCost:setColor(color)
	end
end

function BattleCardWidget:adjustCost(detail)
	local cost, raw = detail.cost, detail.rawCost
	local costImg1 = self._lblCost:clone()

	self:setCost(cost)

	if raw then
		if raw < cost then
			self:setCostColor(cc.c3b(210, 70, 70))
		elseif cost < raw then
			self:setCostColor(cc.c3b(205, 250, 100))
		else
			self:setCostColor(cc.c3b(255, 255, 255))
		end
	else
		self:setCostColor(cc.c3b(255, 255, 255))
	end

	self._lblCost:setVisible(false)
	self._costBg:setVisible(false)

	local cardNode = self._lblCost:getParent()

	cardNode:removeChildByName("feiyongbianhua")
	costImg1:setVisible(true)
	costImg1:posite(0, -5)

	local sjImg1 = self._costBg:clone()

	sjImg1:setVisible(true)
	sjImg1:posite(0, -2)

	local sjImg2 = sjImg1:clone()
	local costImg2 = self._lblCost:clone()

	costImg2:setVisible(true)
	costImg2:posite(0, -5)

	local anim = cc.MovieClip:create("dh_feiyongbianhua")

	anim:addTo(cardNode):offset(-2, -32)
	costImg1:addTo(anim:getChildByFullName("nl1"))
	costImg2:addTo(anim:getChildByFullName("nl2"))
	sjImg1:addTo(anim:getChildByFullName("sj1"))
	sjImg2:addTo(anim:getChildByFullName("sj2"))
	anim:setName("feiyongbianhua")
	anim:addEndCallback(function(cid, mc)
		mc:stop()
	end)
	anim:play()

	self._costAnim = anim
end

function BattleCardWidget:playAddBuffAnim()
	if self._animBuffEffect then
		self._animBuffEffect:gotoAndPlay(1)
	end
end

function BattleCardWidget:updateCardWeight(weight)
	if not self._weightLabel then
		self._weightLabel = cc.Label:createWithTTF(weight, TTF_FONT_FZYH_M, 23)

		self._weightLabel:addTo(self:getView()):offset(0, 80)
		self._weightLabel:setColor(cc.c3b(0, 255, 0))
	end

	self._weightLabel:setString(string.format("%0.2f", weight))
end

function BattleCardWidget:maxCardWeight(isMax)
	if isMax > 0 then
		self._weightLabel:setScale(1.4)
	else
		self._weightLabel:setScale(1)
	end
end

function BattleCardWidget:isAvailable()
	if self._status == "in-use" then
		return false
	end

	return true
end

function BattleCardWidget:setStatus(status)
	self._status = status
end

function BattleCardWidget:reloadIconImage(imagePath)
	if self._iconImageNode then
		self._iconImageNode:loadTexture(imagePath)
	end

	self._iconRes = imagePath
end

function BattleCardWidget:updateCardInfo(info)
	self._cardInfo = info
	self._cardId = info.id

	self:adjustCost(info)
	self:refreshCardAnim()
end

function BattleCardWidget:freshEnergyStatus(energy, remain)
	if self._isEntering then
		self._prevEnergy = energy
		self._prevRemain = remain

		self._cardMaskNode:setVisible(false)
		self:getView():setGray(false)

		return
	end

	self._prevEnergy = nil
	self._prevRemain = nil

	local cost = self:getCost()
	local energyWasEnough = self._energyIsEnough

	self._energyIsEnough = cost <= energy

	if self._energyIsEnough then
		if self:getType() == "skill" then
			self._cardMaskNode:setVisible(false)

			local view = self:getView()

			view:setGray(false)
			view:stopAllActions()
			view:setScale(1)
		elseif self:getType() == "hero" and not energyWasEnough then
			self._cardMaskNode:setVisible(false)

			local view = self:getView()

			view:setGray(false)
			view:stopAllActions()
			view:setScale(1)
			view:runAction(cc.Sequence:create(cc.ScaleTo:create(0.08, 1.05), cc.DelayTime:create(0.1), cc.ScaleTo:create(0.08, 1)))
		end
	else
		local view = self:getView()

		view:setGray(true)

		if self:getType() == "hero" then
			self._cardMaskNode:setVisible(true)
			self._cardMaskNode:setPercentage(100 - 100 * (energy + remain or 0) / cost)
		elseif self:getType() == "skill" then
			self._cardMaskNode:setVisible(false)
		end
	end

	self:freshEnergyAnim(energy, remain)
	self:refreshCardAnim()
end

function BattleCardWidget:freshEnergyAnim(energy, remain, anim)
	remain = remain or 0
	energy = energy or 0
	animname = anim or "shoupaitishi"

	if energy <= 20 then
		if self._cardNode:getChildByFullName("huanraoAnim") then
			self._cardNode:removeChildByName("huanraoAnim")
		end
	else
		local anim = self._cardNode:getChildByFullName("huanraoAnim")

		if not anim then
			anim = cc.MovieClip:create("huanrao_" .. animname, "BattleMCGroup")

			anim:addTo(self._cardNode):setName("huanraoAnim")
			anim:setPosition(cc.p(0, -35))
			anim:addEndCallback(function(fid, mc)
				mc:stop()
				mc:gotoAndPlay(1)
			end)
		end

		if energy >= 30 then
			anim:gotoAndPlay(1)
		else
			local framePlay = anim:getCurrentFrame()
			local frameNow = remain * 30

			if frameNow - framePlay > 1 or framePlay - frameNow > 1 then
				anim:gotoAndPlay(frameNow)
			end
		end
	end
end

function BattleCardWidget:refreshCardAnim()
	if self:isEnergyEnough() then
		self:showCardAnim()
	else
		self:hideCardAnim()
	end
end

function BattleCardWidget:isEnergyEnough()
	return self._energyIsEnough
end

function BattleCardWidget:enterActiveState()
	local view = self:getView()

	view:stopAllActions()

	if view:getParent() then
		view:getParent():stopAllActions()
		view:getParent():runAction(cc.MoveBy:create(0.06, cc.p(0, 20)))
	end
end

function BattleCardWidget:restoreNormalState(originCardPosition)
	local view = self:getView()

	if view:getParent() then
		view:getParent():stopAllActions()
		view:getParent():posite(0, 0)
	end

	view:setScale(1)
	view:setLocalZOrder(1)

	if originCardPosition ~= nil then
		view:setPosition(originCardPosition)
	end
end

function BattleCardWidget:startEnterAnimation(action, endCallback)
	self._isEntering = true

	local view = self:getView()

	view:stopAllActions()

	local endCallbackAction = cc.CallFunc:create(function()
		self._isEntering = false

		if self._prevEnergy then
			self:freshEnergyStatus(self._prevEnergy, self._prevRemain)
		end

		if endCallback then
			endCallback(self)
		end
	end)

	view:runAction(cc.Sequence:create(action, endCallbackAction))
end

function BattleCardWidget:visitCard()
	return
end

function BattleCardWidget:addCardAnim(anim)
	local view = self:getView()
	local anim = anim or "shoupaitishi"
	local animEffect = cc.MovieClip:create("guang_" .. anim, "BattleMCGroup")

	animEffect:addTo(view, 1)
	animEffect:setPosition(cc.p(1, -24))
	animEffect:addEndCallback(function(fid, mc)
		mc:stop()
		mc:gotoAndPlay(1)
	end)
	animEffect:gotoAndStop(1)

	self._cardEffectAnim = animEffect

	local animCard = cc.MovieClip:create("kapaipai_" .. anim, "BattleMCGroup")

	animCard:addTo(view, 1):center(view:getContentSize())
	animCard:addEndCallback(function(fid, mc)
		mc:stop()
		mc:gotoAndPlay(1)
	end)
	animCard:gotoAndStop(1)

	self._cardAnim = animCard

	local animBuffEffect = cc.MovieClip:create("xunhuan_" .. anim, "BattleMCGroup")

	animBuffEffect:addTo(view, 1)
	animBuffEffect:setPosition(cc.p(0, -24))
	animBuffEffect:addEndCallback(function(fid, mc)
		mc:stop()
		mc:gotoAndPlay(18)
	end)
	animBuffEffect:gotoAndStop(1)

	self._animBuffEffect = animBuffEffect

	local node = animCard:getChildByFullName("node")

	animBuffEffect:changeParent(node)

	local cardNode = animBuffEffect:getChildByFullName("card")

	self._cardNode:changeParent(cardNode)
	self._cardNode:setPosition(cc.p(3, 35))

	self._animBuffEffect = animBuffEffect

	self:hideCardAnim()
end

function BattleCardWidget:showCardAnim()
	if self._animPlaySta then
		return
	end

	self._animPlaySta = true

	self._cardEffectAnim:gotoAndPlay(1)
	self._cardAnim:gotoAndPlay(1)
	self._cardEffectAnim:setVisible(true)
	self._animBuffEffect:setPosition(cc.p(0, -24))
end

function BattleCardWidget:hideCardAnim()
	if not self._animPlaySta then
		return
	end

	self._animPlaySta = false

	self._cardEffectAnim:gotoAndStop(1)
	self._cardAnim:gotoAndStop(1)
	self._cardEffectAnim:setVisible(false)
	self._animBuffEffect:setPosition(cc.p(0, -34))
end

function BattleCardWidget:playLockAnim(args)
	if args.lockAnim then
		if not self._lockAnim then
			local anim = cc.MovieClip:create(args.lockAnim, "BattleMCGroup")

			anim:addTo(self._cardNode, 1):center(self._cardNode:getContentSize()):setScale(0.62):offset(0, 6)
			anim:addEndCallback(function(fid, mc)
				mc:stop()

				if args.animLoop then
					mc:gotoAndPlay(1)
				end
			end)

			self._lockAnim = anim
		end

		self._lockAnim:setVisible(true)
		self._lockAnim:gotoAndPlay(1)
	end

	self._lockStatus = true
end

function BattleCardWidget:hideLockAnim()
	if self._lockAnim then
		self._lockAnim:stop()
		self._lockAnim:setVisible(false)
	end

	self._lockStatus = false
end

function BattleCardWidget:isLock()
	return self._lockStatus
end

HeroCardWidget = class("HeroCardWidget", BattleCardWidget, _M)

HeroCardWidget:has("_targetPreview", {
	is = "r"
})
HeroCardWidget:has("_skillId", {
	is = "r"
})
HeroCardWidget:has("_skillLevel", {
	is = "r"
})
HeroCardWidget:has("_heroId", {
	is = "r"
})
HeroCardWidget:has("_modelId", {
	is = "r"
})
HeroCardWidget:has("_heroInfo", {
	is = "r"
})

function HeroCardWidget.class:createWidgetNode()
	local resFile = "asset/ui/HeroCardBattleWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function HeroCardWidget:initSubviews(view)
	super.initSubviews(self, view)

	self._bgImageNode = self._cardNode:getChildByFullName("card_bg")
	self._frameImageNode = self._cardNode:getChildByFullName("card_frame")
	self._genrePic = self._cardNode:getChildByFullName("genre")
	self._rangePic = self._cardNode:getChildByFullName("range")

	self._rangePic:setVisible(false)

	self._tagNode = self._cardNode:getChildByFullName("tag_node")
	self._icon_hero = self._cardNode:getChildByFullName("icon_hero")
	self._damageAddLabel = self._cardNode:getChildByFullName("add_label")

	self._icon_hero:setVisible(true)
end

function HeroCardWidget:getType()
	return "hero"
end

function HeroCardWidget:setQuality(quality)
	if self._quality == quality then
		return
	end

	self._quality = quality

	local qualityIndex = math.floor(quality / 10)
end

function HeroCardWidget:setRarity(rarity)
	return
end

function HeroCardWidget:setHeroModel(heroInfo)
	local modelId = heroInfo.model

	if self._modelId == modelId then
		return
	end

	self._modelId = modelId

	local iconImagePath = IconFactory:getRoleIconPath(modelId)

	self:reloadIconImage(iconImagePath)

	local genre = heroInfo.genre
	local range = ConfigReader:getDataByNameIdAndKey("RoleModel", modelId, "SkillRange")

	if genre and genre ~= "" then
		local _, genrePic, imageType = GameStyle:getBatleHeroOccupation(genre)

		self._genrePic:loadTexture(genrePic, imageType or ccui.TextureResType.localType)
		self._genrePic:setVisible(true)
	else
		self._genrePic:setVisible(false)
	end

	if range and range ~= "" then
		local tag = self._rangePic:getChildByName("tag")

		tag:setString(Strings:get(range))
		self._rangePic:setVisible(true)
	else
		self._rangePic:setVisible(false)
	end

	if heroInfo.addHurtRate and self._damageAddLabel then
		self._damageAddLabel:setVisible(true)
		self._damageAddLabel:setString(heroInfo.addHurtRate)
	end

	local tagPicArray = ConfigReader:getDataByNameIdAndKey("RoleModel", modelId, "TagPic")

	if tagPicArray == nil or #tagPicArray <= 0 then
		self._tagNode:setVisible(false)
		self._tagNode:removeAllChildren()

		return
	else
		self._tagNode:setVisible(true)
		self._tagNode:removeAllChildren()
	end

	for i = 1, #tagPicArray do
		local pic = self._rangePic:clone()

		pic:setVisible(true)
		pic:getChildByName("tag"):setString(Strings:get(tagPicArray[i]))
		pic:addTo(self._tagNode):posite(0, (i - 1) * 22 - 3)
	end
end

function HeroCardWidget:setPreviewMod()
	return
end

function HeroCardWidget:setNormalMod()
	return
end

function HeroCardWidget:updateCardInfo(info)
	super.updateCardInfo(self, info)

	local heroInfo = info.hero

	self._heroInfo = heroInfo
	self._heroId = heroInfo.id

	local range

	if info.unique then
		local config = ConfigReader:getRecordById("Skill", info.unique)

		self._targetPreview = config.TargetPreview
		self._skillId = info.unique
		self._skillLevel = info.uniqueLevel
		range = config.SkillRange
	end

	heroInfo.skillId = self._skillId
	heroInfo.skillLevel = self._skillLevel
	heroInfo.range = range

	self:setHeroModel(heroInfo)
end

function HeroCardWidget:setDamageAdd(str)
	if self._damageAddLabel then
		self._damageAddLabel:setString(str or "")
	end
end

ExtraHeroCardWidget = class("ExtraHeroCardWidget", HeroCardWidget, _M)

function ExtraHeroCardWidget:addCardAnim()
	local view = self:getView()
	local animEffect = cc.MovieClip:create("guang_jinengpaitishi", "BattleMCGroup")

	animEffect:addTo(view, 1)
	animEffect:setPosition(cc.p(1, -24))
	animEffect:addEndCallback(function(fid, mc)
		mc:stop()
		mc:gotoAndPlay(1)
	end)
	animEffect:gotoAndStop(1)

	self._cardEffectAnim = animEffect

	local animCard = cc.MovieClip:create("kapaipai_jinengpaitishi", "BattleMCGroup")

	animCard:addTo(view, 1):center(view:getContentSize())
	animCard:addEndCallback(function(fid, mc)
		mc:stop()
		mc:gotoAndPlay(1)
	end)
	animCard:gotoAndStop(1)

	self._cardAnim = animCard

	local animBuffEffect = cc.MovieClip:create("xunhuan_jinengpaitishi", "BattleMCGroup")

	animBuffEffect:addTo(view, 1)
	animBuffEffect:addEndCallback(function(fid, mc)
		mc:stop()
		mc:gotoAndPlay(18)
	end)
	animBuffEffect:gotoAndStop(1)

	self._animBuffEffect = animBuffEffect

	local node = animCard:getChildByFullName("node")
	local root = cc.Node:create()

	node:addChild(root)
	root:offset(2, 39.6)
	animBuffEffect:changeParent(root)

	local cardNode = animBuffEffect:getChildByFullName("card")

	self._cardNode:changeParent(cardNode)
	self:hideCardAnim()
	self._cardNode:getChildByName("card_bg"):setVisible(false)

	local icon = animBuffEffect:getChildByFullName("card.icon.icon")

	self._iconImageNode:changeParent(icon)
	self._iconImageNode:center(icon:getContentSize())
end

function ExtraHeroCardWidget:freshEnergyAnim(energy, remain)
	super.freshEnergyAnim(self, energy, remain, "jinengpaitishi")
end

function ExtraHeroCardWidget:isExtraCard()
	return true
end

function ExtraHeroCardWidget:setHeroModel(heroInfo)
	super.setHeroModel(self, heroInfo)
	self._rangePic:setVisible(false)
end

function ExtraHeroCardWidget:getRes()
	return self._iconRes
end

function ExtraHeroCardWidget:createMaskNode()
	local barImgPath = "asset/common/pic_mengban_sms2.png"
	local barImage = cc.Sprite:create(barImgPath)
	local cardMaskNode = cc.ProgressTimer:create(barImage)

	cardMaskNode:setType(0)
	cardMaskNode:setScaleX(-0.95)
	cardMaskNode:setScaleY(0.95)
	cardMaskNode:setAnchorPoint(cc.p(0.5, 0.5))
	cardMaskNode:setMidpoint(cc.p(0.5, 0.5))
	cardMaskNode:setVisible(false)
	self._cardNode:addChild(cardMaskNode, 100)

	self._cardMaskNode = cardMaskNode
end

SkillCardWidget = class("SkillCardWidget", BattleCardWidget, _M)

SkillCardWidget:has("_skillId", {
	is = "r"
})
SkillCardWidget:has("_skillLevel", {
	is = "r"
})

function SkillCardWidget.class:createWidgetNode()
	local resFile = "asset/ui/SkillCardBattleWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function SkillCardWidget:initSubviews(view)
	super.initSubviews(self, view)

	self._genrePic = self._cardNode:getChildByFullName("genre")
	self._skillImage1 = self._cardNode:getChildByFullName("Image")
	self._bgImageNode = self._cardNode:getChildByFullName("card_bg")
	self._rangePic = self._cardNode:getChildByFullName("range")

	self._rangePic:setVisible(false)
end

function SkillCardWidget:getType()
	return "skill"
end

function SkillCardWidget:setPreviewMod()
	return
end

function SkillCardWidget:setNormalMod()
	return
end

function SkillCardWidget:updateCardInfo(info)
	super.updateCardInfo(self, info)

	self._skillLevel = info.skill.level
	self._skillId = info.skill.id

	local config = ConfigReader:getRecordById("TacticsCard", info.id)

	if config then
		local path = "asset/tacticsCard/"
		local iconImagePath = path .. config.SkillPic .. ".png"

		self:reloadIconImage(iconImagePath)
		self._genrePic:loadTexture("TacticsCard_Type_" .. config.Type .. ".png", ccui.TextureResType.plistType)
		self._bgImageNode:loadTexture("TacticsCard_Bg_" .. config.Type .. ".png", ccui.TextureResType.plistType)
		self._skillImage1:loadTexture("TacticsCard_Icon_" .. config.Type .. ".png", ccui.TextureResType.plistType)
		self:setCost(config.SkillCost)

		local tagPic = config.TagPic

		if tagPic then
			local tag = self._rangePic:getChildByName("tag")

			tag:setString(Strings:get(tagPic))
			self._rangePic:setVisible(true)
		else
			self._rangePic:setVisible(false)
		end
	end
end

ExtraSkillCardWidget = class("ExtraSkillCardWidget", BattleCardWidget, _M)

ExtraSkillCardWidget:has("_skillId", {
	is = "r"
})
ExtraSkillCardWidget:has("_skillLevel", {
	is = "r"
})

function ExtraSkillCardWidget.class:createWidgetNode()
	local resFile = "asset/ui/SkillCardBattleWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function ExtraSkillCardWidget:initSubviews(view)
	super.initSubviews(self, view)

	self._genrePic = self._cardNode:getChildByFullName("genre")
	self._skillImage1 = self._cardNode:getChildByFullName("Image")
	self._bgImageNode = self._cardNode:getChildByFullName("card_bg")
	self._rangePic = self._cardNode:getChildByFullName("range")

	self._rangePic:setVisible(false)
end

function ExtraSkillCardWidget:getType()
	return "skill"
end

function ExtraSkillCardWidget:isExtraCard()
	return true
end

function ExtraSkillCardWidget:setPreviewMod()
	return
end

function ExtraSkillCardWidget:setNormalMod()
	return
end

function ExtraSkillCardWidget:createMaskNode()
	local barImgPath = "asset/common/pic_mengban_sms2.png"
	local barImage = cc.Sprite:create(barImgPath)
	local cardMaskNode = cc.ProgressTimer:create(barImage)

	cardMaskNode:setType(0)
	cardMaskNode:setScaleX(-0.95)
	cardMaskNode:setScaleY(0.95)
	cardMaskNode:setAnchorPoint(cc.p(0.5, 0.5))
	cardMaskNode:setMidpoint(cc.p(0.5, 0.5))
	cardMaskNode:setVisible(false)
	self._cardNode:addChild(cardMaskNode, 100)

	self._cardMaskNode = cardMaskNode
end

function ExtraSkillCardWidget:addCardAnim()
	local view = self:getView()
	local animEffect = cc.MovieClip:create("guang_jinengpaitishi", "BattleMCGroup")

	animEffect:addTo(view, 1)
	animEffect:setPosition(cc.p(1, -24))
	animEffect:addEndCallback(function(fid, mc)
		mc:stop()
		mc:gotoAndPlay(1)
	end)
	animEffect:gotoAndStop(1)

	self._cardEffectAnim = animEffect

	local animCard = cc.MovieClip:create("kapaipai_jinengpaitishi", "BattleMCGroup")

	animCard:addTo(view, 1):center(view:getContentSize())
	animCard:addEndCallback(function(fid, mc)
		mc:stop()
		mc:gotoAndPlay(1)
	end)
	animCard:gotoAndStop(1)

	self._cardAnim = animCard

	local animBuffEffect = cc.MovieClip:create("xunhuan_jinengpaitishi", "BattleMCGroup")

	animBuffEffect:addTo(view, 1)
	animBuffEffect:addEndCallback(function(fid, mc)
		mc:stop()
		mc:gotoAndPlay(18)
	end)
	animBuffEffect:gotoAndStop(1)

	self._animBuffEffect = animBuffEffect

	local node = animCard:getChildByFullName("node")
	local root = cc.Node:create()

	node:addChild(root)
	root:offset(0, 40)
	animBuffEffect:changeParent(root)

	local cardNode = animBuffEffect:getChildByFullName("card")

	self._cardNode:changeParent(cardNode)
	self:hideCardAnim()
	self._cardNode:getChildByName("card_bg"):setVisible(false)
	self._cardNode:getChildByName("Image"):setVisible(false)

	local icon = animBuffEffect:getChildByFullName("card.icon.icon")

	self._iconImageNode:changeParent(icon)
	self._iconImageNode:center(icon:getContentSize())
end

function ExtraSkillCardWidget:simpleShow(isSimple)
	self._cardEffectAnim:setVisible(not isSimple)
	self._animBuffEffect:setVisible(not isSimple)
	self._cardAnim:setVisible(not isSimple)

	self:getView().isSimpleShow = isSimple

	if isSimple then
		self.disply = self._iconImageNode:clone()

		self.disply:setVisible(true)
		self.disply:setScale(1.4)
		self.disply:addTo(self:getView()):center(self:getView():getContentSize())
		self.disply:offset(20, 50)
	elseif self.disply then
		self.disply:removeFromParent()

		self.disply = nil
	end
end

function ExtraSkillCardWidget:restoreNormalState(originCardPosition)
	super.restoreNormalState(self, originCardPosition)

	if self:getView().isSimpleShow then
		self:simpleShow(false)
	end
end

function ExtraSkillCardWidget:freshEnergyAnim(energy, remain)
	super.freshEnergyAnim(self, energy, remain, "jinengpaitishi")
end

function ExtraSkillCardWidget:getRes()
	return self._iconRes
end

function ExtraSkillCardWidget:setCollesionRule(rule)
	self._collesionRule = rule
end

function ExtraSkillCardWidget:getCollesionRule()
	return self._collesionRule
end

function ExtraSkillCardWidget:updateCardInfo(info)
	super.updateCardInfo(self, info)

	self._skillLevel = info.skill.level
	self._skillId = info.skill.id

	local config = ConfigReader:getRecordById("TacticsCard", info.id)

	if config then
		local path = "asset/tacticsCard/"
		local iconImagePath = path .. config.SkillPic .. ".png"

		self:reloadIconImage(iconImagePath)
		self._genrePic:loadTexture("TacticsCard_Type_" .. config.Type .. ".png", ccui.TextureResType.plistType)
		self._bgImageNode:loadTexture("TacticsCard_Bg_" .. config.Type .. ".png", ccui.TextureResType.plistType)
		self._skillImage1:loadTexture("TacticsCard_Icon_" .. config.Type .. ".png", ccui.TextureResType.plistType)
		self:setCost(config.SkillCost)

		local tagPic = config.TagPic

		if tagPic then
			local tag = self._rangePic:getChildByName("tag")

			tag:setString(Strings:get(tagPic))
			self._rangePic:setVisible(true)
		else
			self._rangePic:setVisible(false)
		end

		local cardRange = config.CardRange

		self:setCollesionRule(cardRange)
	end
end
