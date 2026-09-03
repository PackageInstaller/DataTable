-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroBaseShowView.lua

local componentPath = "strengthen/StrengthenBaseShow.csd"

HeroBaseShowView = class("HeroBaseShowView", DisposableObject, _M)

HeroBaseShowView:has("_view", {
	is = "r"
})
HeroBaseShowView:has("_info", {
	is = "r"
})
HeroBaseShowView:has("_mediator", {
	is = "r"
})

function HeroBaseShowView:dispose()
	super.dispose(self)
end

function HeroBaseShowView:initialize(info)
	self._info = info
	self._mediator = info.mediator
	self._developSystem = self._mediator:getInjector():getInstance(DevelopSystem)
	self._heroSystem = self._developSystem:getHeroSystem()
	self._heroData = self._heroSystem:getHeroById(self._info.heroId)

	self:createView()
	super.initialize(self)
end

function HeroBaseShowView:createView()
	self._view = self._info.mainNode or cc.CSLoader:createNode(componentPath)
	self._bgAnim = cc.MovieClip:create("zongdh_sisheng")

	self._bgAnim:addCallbackAtFrame(15, function()
		self._bgAnim:stop()
	end)
	self._bgAnim:addTo(self._view:getChildByFullName("animNode"))
	self._bgAnim:setPosition(cc.p(0, 0))
	self._view:getChildByFullName("animNode.image"):setPosition(cc.p(0, -34.5))
	self._view:getChildByFullName("animNode.image"):changeParent(self._bgAnim:getChildByName("bgNode"))

	self._descNode = self._view:getChildByFullName("descNode")
	self._heroPanel = self._descNode:getChildByFullName("heroPanel")

	if not self._heroPanel:getChildByFullName("HeroAnim") then
		local anim = cc.MovieClip:create("renwu_yinghun")

		anim:addTo(self._heroPanel):center(self._heroPanel:getContentSize())
		anim:setName("HeroAnim")
		anim:addCallbackAtFrame(30, function()
			anim:stop()
		end)
		anim:setPlaySpeed(1.5)

		self._heroAnimPanel = anim:getChildByName("heroPanel")
	end

	self._nameLabel = self._descNode:getChildByFullName("nameLabel")
	self._costLabel = self._descNode:getChildByFullName("costBg.costnumlabel")
	self._rarityIcon = self._descNode:getChildByFullName("rarityIcon")

	self._rarityIcon:ignoreContentAdaptWithSize(true)

	self._combatLabel = self._descNode:getChildByFullName("combat_number")

	self._combatLabel:setString("")

	self._occupation = self._descNode:getChildByFullName("occupation")

	local changeBtn = self._descNode:getChildByFullName("changebtn")

	changeBtn:addClickEventListener(function()
		self:onClickChange()
	end)
	self:refreshView()
end

function HeroBaseShowView:hideBtn()
	self._descNode:getChildByFullName("changebtn"):setVisible(false)
end

function HeroBaseShowView:hideInfoBg(hide)
	self._descNode:getChildByFullName("starBg"):setVisible(hide)
end

function HeroBaseShowView:refreshView(heroId, stopChange, isEquipView)
	self._heroData = self._heroSystem:getHeroById(heroId or self._info.heroId)

	local nameString = self._heroData:getName()
	local qualityLevel = self._heroData:getQualityLevel() == 0 and "" or "+" .. self._heroData:getQualityLevel()

	self._nameLabel:setString(nameString .. qualityLevel)
	self._nameLabel:getVirtualRenderer():setAdditionalKerning(-2)

	local strlen = utf8.len(nameString .. qualityLevel)

	if strlen > 12 then
		self._nameLabel:setFontSize(26)
	else
		self._nameLabel:setFontSize(30)
	end

	GameStyle:setHeroNameByQuality(self._nameLabel, self._heroData:getQuality())
	self._costLabel:setString(self._heroData:getCost())
	self._rarityIcon:loadTexture(GameStyle:getHeroRarityImage(self._heroData:getRarity()), 1)
	self._descNode:getChildByFullName("combatBg.image"):removeAllChildren()
	self._combatLabel:removeAllChildren()

	local combat = self._heroData:getSceneCombatByType(SceneCombatsType.kAll)

	if isEquipView then
		self:showCombatChangeAnim(combat)
	else
		self._combatLabel:setString(combat)
	end

	local occupationName, occupationImg = GameStyle:getHeroOccupation(self._heroData:getType())

	self._occupation:loadTexture(occupationImg)
	self._occupation:ignoreContentAdaptWithSize(true)
	self._occupation:setPositionX(self._nameLabel:getPositionX() - self._nameLabel:getContentSize().width)
	self:refreshHeroType(stopChange)
end

function HeroBaseShowView:showCombatChangeAnim(combat)
	self._preCombat = self._combatLabel:getString()
	self._curCombat = tostring(combat)

	if self._preCombat ~= "" and self._preCombat ~= self._curCombat then
		local anim

		local function func()
			self._combatLabel:setString(combat)
			self._combatLabel:setScale(1.2)
			self._combatLabel:setOpacity(255)
			self._combatLabel:fadeIn({
				time = 0.16666666666666666
			})
			self._combatLabel:runAction(cc.ScaleTo:create(0.16666666666666666, 1))
		end

		if combat > tonumber(self._preCombat) then
			anim = cc.MovieClip:create("jtoua_zhanlishuzi")

			local shuzi = cc.MovieClip:create("shuzi_zhanlishuzi")

			shuzi:addTo(self._combatLabel):center(self._combatLabel:getContentSize()):offset(-15, 0)
			shuzi:gotoAndPlay(0)
			shuzi:addEndCallback(function()
				shuzi:removeFromParent()
			end)
			shuzi:addCallbackAtFrame(6, function()
				func()
			end)
			shuzi:setScale(1.3)
		else
			anim = cc.MovieClip:create("jtoub_zhanlishuzi")

			func()
		end

		anim:addTo(self._descNode:getChildByFullName("combatBg.image"))
		anim:setPosition(cc.p(199, 13))
		anim:gotoAndPlay(0)
		anim:setScale(1.5)
		anim:addEndCallback(function()
			anim:removeFromParent()
		end)
	else
		self._combatLabel:setString(combat)
	end
end

function HeroBaseShowView:refreshHeroType(stopChange)
	if stopChange then
		return
	end

	local panel = self._heroAnimPanel

	panel:removeAllChildren()

	local stencil = self._descNode:getChildByFullName("Image_stencil"):clone()

	stencil:setVisible(true)
	stencil:setAnchorPoint(cc.p(0, 0))
	stencil:setPosition(cc.p(0, 0))

	local img = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe3",
		id = self._heroData:getModel()
	})

	panel:addChild(img)
	img:setPosition(cc.p(-50, 2))
	img:setSaturation(-23)
	img:setOpacity(204)
	self._heroPanel:getChildByFullName("HeroAnim"):gotoAndPlay(0)
end

function HeroBaseShowView:onHeroShowClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local heroShowDetailsView = self._mediator:getInjector():getInstance("HeroShowDetailsView")

		self._mediator:dispatch(ViewEvent:new(EVT_SHOW_POPUP, heroShowDetailsView, {}, {
			heroId = self._heroData:getId()
		}))
	end
end

function HeroBaseShowView:onClickChange()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._heroSystem:setShowHeroType(self._heroSystem:getShowHeroType() == 1 and 2 or 1)
	self:refreshHeroType()
end

function HeroBaseShowView:runStartAnim()
	self._bgAnim:gotoAndPlay(0)
	self._heroPanel:stopAllActions()
	self._heroPanel:setPosition(cc.p(-277, 295))

	local moveto = cc.MoveTo:create(0.3, cc.p(147, 295))
	local moveto1 = cc.MoveTo:create(0.1, cc.p(153, 295))
	local seq = cc.Sequence:create(moveto, moveto1)

	self._heroPanel:runAction(seq)
	self._nameLabel:stopAllActions()
	self._nameLabel:setOpacity(0)

	local delaytime = cc.DelayTime:create(0.3)
	local fadeIn = cc.FadeIn:create(0.2)

	seq = cc.Sequence:create(delaytime, fadeIn)

	self._nameLabel:runAction(seq)

	local occupation = self._occupation

	occupation:stopAllActions()
	occupation:setOpacity(0)

	local delaytime = cc.DelayTime:create(0.3)
	local fadeIn = cc.FadeIn:create(0.2)

	seq = cc.Sequence:create(delaytime, fadeIn)

	occupation:runAction(seq)
	self._rarityIcon:stopAllActions()
	self._rarityIcon:setScale(0)

	delaytime = cc.DelayTime:create(0.2)

	local scale1 = cc.ScaleTo:create(0.3, 1)
	local scale2 = cc.ScaleTo:create(0.1, 0.8)

	seq = cc.Sequence:create(delaytime, scale1, scale2)

	self._rarityIcon:runAction(seq)

	local combat = self._descNode:getChildByFullName("combatBg")

	combat:stopAllActions()
	combat:fadeIn({
		time = 0.2
	})

	local combat_number = self._combatLabel

	combat_number:stopAllActions()
	combat_number:setScale(0)

	delaytime = cc.DelayTime:create(0.3)
	scale1 = cc.ScaleTo:create(0.3, 1.2)
	scale2 = cc.ScaleTo:create(0.1, 1)
	seq = cc.Sequence:create(delaytime, scale1, scale2)

	combat_number:runAction(seq)
end
