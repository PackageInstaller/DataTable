-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/RelationInfoTipMediator.lua

RelationInfoTipMediator = class("RelationInfoTipMediator", DmPopupViewMediator, _M)

RelationInfoTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function RelationInfoTipMediator:initialize()
	super.initialize(self)
end

function RelationInfoTipMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function RelationInfoTipMediator:onRemove()
	super.onRemove(self)
end

function RelationInfoTipMediator:onRegister()
	super.onRegister(self)
end

function RelationInfoTipMediator:enterWithData(data)
	self:initNodes()
	self:refreshView(data)
end

function RelationInfoTipMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._relationPanel = self._mainPanel:getChildByFullName("relationPanel")
	self._clonePanel = self._mainPanel:getChildByFullName("clonepanel")

	self._clonePanel:setVisible(false)
end

function RelationInfoTipMediator:refreshView(data)
	self:refreshData(data)
	self:refreshRelationPanel()
end

function RelationInfoTipMediator:refreshData(data)
	local developSystem = self:getInjector():getInstance("DevelopSystem")

	self._player = developSystem:getPlayer()
	self._bagSystem = developSystem:getBagSystem()
	self._heroSystem = developSystem:getHeroSystem()
	self._heroId = data.heroId
	self._relationIndex = data.index
	self._heroPro = PrototypeFactory:getInstance():getHeroPrototype(self._heroId)
	self._heroConfig = self._heroPro:getConfig()
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._relation = self._heroData:getRelationList():getRelationByIndex(self._relationIndex)
end

function RelationInfoTipMediator:refreshRelationPanel()
	local config = self._relation:getConfig()
	local offsetY = self._clonePanel:getContentSize().height

	for i = 1, config.EffectLevel do
		local panel = self._clonePanel:clone()

		panel:setVisible(true)
		panel:addTo(self._relationPanel, 99)
		panel:setPosition(cc.p(0, offsetY * (i - 1)))
		self:refreshClonePanel(panel, i)
	end

	local height = config.EffectLevel * self._clonePanel:getContentSize().height

	self._relationPanel:setContentSize(cc.size(600, height))
end

function RelationInfoTipMediator:refreshClonePanel(panel, level)
	local config = self._relation:getConfig()
	local relationLevel = self._relation:getLevel()
	local imageBg = panel:getChildByFullName("imageBg")

	imageBg:setContentSize(cc.size(341, 30))

	local nameLabel = panel:getChildByFullName("namelabel")

	nameLabel:setString(Relation:getName(level, config))
	GameStyle:setQualityText(nameLabel, level + 1)

	local icon = panel:getChildByFullName("relationType")

	icon:loadTexture(GameStyle:getRelationPic(level)[1], 1)

	local descPanel = panel:getChildByFullName("descPanel")
	local color = Relation:getFontColorByLevel(level <= relationLevel and 1 or 0, 2)
	local var_10_0 = level
	local var_10_1 = config
	local var_10_2 = {
		fontColor = color
	}

	var_10_2.developSystem = self:getInjector():getInstance("DevelopSystem")

	local desc = Relation:getLongDesc(var_10_0, var_10_1, var_10_2, 2)
	local nameControl = ccui.RichText:createWithXML(desc, {})

	nameControl:renderContent(descPanel:getContentSize().width, 0)
	nameControl:setAnchorPoint(cc.p(0, 0))
	nameControl:addTo(descPanel)
	nameControl:offset(6, 5)

	if nameControl:getContentSize().height > 30 then
		imageBg:setContentSize(cc.size(341, 47))
	end

	local curNum, targetNum = self._heroSystem:getRelationRateByLevel(self._heroId, config.Id, level)
	local numPanel = panel:getChildByFullName("numPanel")
	local text = numPanel:getChildByFullName("text")
	local text1 = numPanel:getChildByFullName("text1")

	text:setString(tostring(math.modf(curNum / targetNum * 100)))
	text1:setPositionX(text:getContentSize().width)
	numPanel:setContentSize(cc.size(text:getContentSize().width + text1:getContentSize().width, 54))

	local loadingBar = panel:getChildByFullName("loadingbar")

	loadingBar:setPercent(100 - curNum / targetNum * 100)

	local dateLabel = panel:getChildByFullName("datelabel")

	dateLabel:setString("")

	local history = self._relation:getHistory()

	if history and history[tostring(level)] then
		local timeStr = TimeUtil:localDate(Strings:get("RelationText2"), history[level])

		dateLabel:setString(timeStr)
	end
end

function RelationInfoTipMediator:onBackClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
