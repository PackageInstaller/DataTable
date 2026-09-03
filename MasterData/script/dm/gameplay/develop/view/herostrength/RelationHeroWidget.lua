-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/RelationHeroWidget.lua

RelationHeroWidget = class("RelationHeroWidget", BaseWidget, _M)

function RelationHeroWidget.class:createWidgetNode()
	local resFile = "asset/ui/RelationHeroWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function RelationHeroWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function RelationHeroWidget:dispose()
	self._closeView = true

	super.dispose(self)
end

function RelationHeroWidget:initSubviews(view)
	self._view = view
	self._nameLabel = self._view:getChildByFullName("nameLabel")
	self._costLabel = self._view:getChildByFullName("costBg.costnumlabel")
	self._rarityIcon = self._view:getChildByFullName("rarityIcon")

	self._rarityIcon:ignoreContentAdaptWithSize(true)

	self._combatLabel = self._view:getChildByFullName("combatBg.combat_number")
	self._heroPanel = self._view:getChildByFullName("heroPanel")
	self._startBg = self._view:getChildByFullName("startBg")
end

function RelationHeroWidget:updateRoleInfo(info, style)
	local heroId = info.id

	if heroId == nil then
		return
	end

	local nameString = info.name
	local qualityLevel = info.qualityLevel == 0 and "" or "+" .. info.qualityLevel

	self._nameLabel:setString(nameString .. qualityLevel)
	GameStyle:setHeroNameByQuality(self._nameLabel, info.quality)
	self._costLabel:setString(info.cost)
	self._rarityIcon:loadTexture(GameStyle:getHeroRarityImage(info.rariety), 1)
	self._combatLabel:setString(info.combat)
	self._heroPanel:removeAllChildren()

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", info.id)
	local anim = RoleFactory:createHeroAnimation(roleModel)

	self._heroPanel:addChild(anim)
	anim:setScale(1.1)
	anim:setAnchorPoint(cc.p(0.5, 0.5))
	anim:setPosition(cc.p(self._heroPanel:getContentSize().width / 2 - 20, self._heroPanel:getContentSize().height / 2 - 140))

	for i = 1, 7 do
		self._startBg:getChildByFullName("star_" .. i):setVisible(i <= info.star)
	end

	if style and style.hideCombat then
		self._view:getChildByFullName("combatBg"):setVisible(false)
	end
end
