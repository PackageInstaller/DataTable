-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/StrengthenSoulMediator.lua

StrengthenSoulMediator = class("StrengthenSoulMediator", DmAreaViewMediator, _M)

StrengthenSoulMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function StrengthenSoulMediator:initialize()
	super.initialize(self)
end

function StrengthenSoulMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function StrengthenSoulMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SOULUPBYITEM_SUCC, self, self.refreshViewBySoulChange)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SOULUPBYDIMOND_SUCC, self, self.refreshViewBySoulChange)

	self._soulUpBtn = self:bindWidget("main.node.upbtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickUp, self)
		}
	})
end

function StrengthenSoulMediator:setupView(parentMedi, data)
	self._parentMediator = parentMedi
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._player = self._developSystem:getPlayer()
	self._iconChace = {}

	self:refreshData(data.id)
	self:initNodes()
	self:refreshView()

	self._upIndex = 1
end

function StrengthenSoulMediator:refreshData(heroId)
	self._curIndex = self._upIndex or 1
	self._heroId = heroId or self._heroId
	self._heroData = self._heroSystem:getHeroById(heroId)
	self._heroPro = PrototypeFactory:getInstance():getHeroPrototype(heroId)
	self._soulList = self._heroData:getHeroSoulList():getSoulArray()
end

function StrengthenSoulMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main.node")
	self._maxImg = self._mainPanel:getChildByFullName("maximg")
	self._tipLabel = self._mainPanel:getChildByFullName("tiplabel")
	self._iconNode = self._mainPanel:getChildByFullName("iconnode")
	self._clonePanel = self._iconNode:getChildByFullName("clonePanel")

	self._clonePanel:setVisible(false)

	self._infoNode = self._mainPanel:getChildByFullName("infonode")
	self._upBtn = self._mainPanel:getChildByFullName("upbtn")

	local title = self._mainPanel:getChildByFullName("text")
end

function StrengthenSoulMediator:refreshViewBySoulChange()
	self._soulList = self._heroData:getHeroSoulList():getSoulArray()

	self:refreshSoulInfo()
	self:refreshSoulIcons()
	self:refreshAllIconState()
	self:refreshRedPoint()
end

function StrengthenSoulMediator:refreshView()
	self:refreshSoulIcons()
	self:refreshAllIconState(true, true)
	self:refreshSoulInfo()
	self:refreshRedPoint()
end

function StrengthenSoulMediator:refreshRedPoint()
	if not self._upBtn.redPoint then
		self._upBtn.redPoint = HeroSystem:createRedPointImg(self._upBtn)

		self._upBtn.redPoint:offset(104, 45)
	end

	local soulData = self._soulList[self._curIndex]

	self._upBtn.redPoint:setVisible(soulData:getLockState() == HeroSoulLockState.kCanUnLock)
end

function StrengthenSoulMediator:refreshAllIconState(showActive, ignoreAnim)
	for i = 1, #self._iconChace do
		self._iconChace[i]:getChildByFullName("selectImage"):setVisible(self._curIndex == i)
	end
end

function StrengthenSoulMediator:refreshSoulIcons()
	self._iconChace = {}

	for i = 1, #self._soulList do
		self:refreshSoulIcon(i)
	end
end

function StrengthenSoulMediator:refreshSoulIcon(index)
	index = index or self._curIndex

	local soul = self._soulList[index]
	local iconParent = self._iconNode:getChildByFullName("iconnode.node" .. index)

	iconParent:removeAllChildren()

	local soulIcon = self._clonePanel:clone()

	soulIcon:setVisible(true)
	soulIcon:addTo(iconParent)
	soulIcon:setTouchEnabled(true)
	soulIcon:addTouchEventListener(function(sender, eventType)
		self:selectIcon(sender, eventType, index)
	end)
	soulIcon:setPosition(cc.p(0, 0))

	local image = soulIcon:getChildByFullName("image.huaImage")

	image:removeFromParent()

	image = IconFactory:addStencilForIcon(image, 5, cc.size(138, 148))

	image:addTo(soulIcon:getChildByFullName("image"))
	image:setPosition(cc.p(soulIcon:getChildByFullName("image"):getContentSize().width / 2, soulIcon:getChildByFullName("image"):getContentSize().height / 2))
	image:setLocalZOrder(0)
	soulIcon:getChildByFullName("image.nameBg"):setLocalZOrder(1)
	soulIcon:getChildByFullName("image.nameBg.name"):setString(soul:getName())
	soulIcon:getChildByFullName("selectImage"):setVisible(index == self._curIndex)
	soulIcon:getChildByFullName("lockNode"):setVisible(soul:getLockState() == HeroSoulLockState.kLock)

	if soul:getLockState() == HeroSoulLockState.kLock then
		soulIcon:getChildByFullName("image"):setSaturation(-70)
	end

	local level1 = soulIcon:getChildByFullName("levelLabel_1")
	local level2 = soulIcon:getChildByFullName("levelLabel_2")

	level1:setVisible(soul:getLockState() ~= HeroSoulLockState.kLock)
	level2:setVisible(soul:getLockState() ~= HeroSoulLockState.kLock)
	level2:setString(soul:getLevel())
	level1:setPositionX(level2:getPositionX() - level2:getContentSize().width)
	soulIcon:getChildByFullName("image.icon"):loadTexture(soul:getIconId())
	soulIcon:getChildByFullName("image.icon"):setLocalZOrder(1)

	self._iconChace[index] = soulIcon

	return soulIcon
end

function StrengthenSoulMediator:refreshSoulInfo()
	local soulData = self._soulList[self._curIndex]
	local nameLabel = self._infoNode:getChildByFullName("namelabel")
	local descStr = soulData:getDesc(soulData:getLevel())
	local str = soulData:getLock() == true and Strings:get("Strenghten_SkillText4") or ""

	nameLabel:setString(str .. soulData:getName() .. "  " .. descStr)

	if self._infoNode:getChildByTag(123) then
		self._infoNode:removeChildByTag(123, true)
	end

	self._maxImg:setVisible(soulData:getLevel() == soulData:getLimitLevel())
	self._upBtn:setVisible(not self._maxImg:isVisible())

	if soulData:getLock() == true then
		local var_14_0 = Strings:get("HeroSoul_UI6")

		if not var_14_0 then
			var_14_0 = Strings:get("HeroSoul_UI5")

			local buttonText = var_14_0

			self._soulUpBtn:setButtonName(buttonText)
			self._tipLabel:setVisible(soulData:getLockState() == HeroSoulLockState.kLock)

			if self._tipLabel:isVisible() then
				local tip = self._heroSystem:getSoulUnlockNumById(self._heroId, soulData:getId())

				self._tipLabel:setString(tip)
			end
		end
	end
end

function StrengthenSoulMediator:refreshAllView()
	self:refreshView()
end

function StrengthenSoulMediator:onClickUp(sender, eventType)
	local soulData = self._soulList[self._curIndex]

	if soulData:getLockState() == HeroSoulLockState.kLock then
		local tip = self._heroSystem:getSoulUnlockNumById(self._heroId, soulData:getId())

		self:dispatch(ShowTipEvent({
			tip = tip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	elseif soulData:getLockState() == HeroSoulLockState.kCanUnLock then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._heroSystem:requestSoulUnlock(self._heroId, soulData:getId())

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("HeroSoulInfoTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		index = self._curIndex,
		heroId = self._heroId
	}))
end

function StrengthenSoulMediator:selectIcon(sender, eventType, index)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		self._curIndex = index
		self._upIndex = index

		self:refreshSoulInfo()
		self:refreshRedPoint()
		self:refreshAllIconState(false)
	end
end

function StrengthenSoulMediator:runStartAction()
	return
end
