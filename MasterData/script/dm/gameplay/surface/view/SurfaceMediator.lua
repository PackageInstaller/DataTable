-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/surface/view/SurfaceMediator.lua

SurfaceMediator = class("SurfaceMediator", DmAreaViewMediator, _M)

SurfaceMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
SurfaceMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")
SurfaceMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
SurfaceMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
SurfaceMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["main.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	}
}

function SurfaceMediator:initialize()
	super.initialize(self)
end

function SurfaceMediator:dispose()
	super.dispose(self)
end

function SurfaceMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._sureBtnWidget = self:bindWidget("main.sureBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickSure, self)
		}
	})

	self.mapEventListener(self, self:getEventDispatcher(), EVT_SURFACE_SELECT_SUCC, self, self.refreshWithSelect)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SURFACE_BUY_SUCC, self, self.refreshWithBuy)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SURFACE_REFRESH_REDPOINT, self, self.refreshRedPoint)
end

function SurfaceMediator:enterWithData(data)
	self:initData(data)
	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:updateRoleName()
	self:createSurfaceNode()
	self:updateSurfaceInfo()
	self:updateBtnState()
end

function SurfaceMediator:resumeWithData()
	self._surfaces = self._surfaceSystem:getSurfaceByTargetRole(self._roleId, self._surfaceType)

	self:updateData()
	self:updateSurfaceNode()
	self:updateBtnState()
end

function SurfaceMediator:initData(data)
	self._canChange = true
	self._curIndex = 1
	self._shopItemData = nil
	self._surfaceType = data.surfaceType
	self._roleId = data.id
	self._surfaces = self._surfaceSystem:getSurfaceByTargetRole(self._roleId, self._surfaceType)
	self._surfaceId = data.surfaceId or self._surfaces[1]:getId()
	self._curSurface = self._surfaceSystem:getSurfaceById(self._surfaceId)
	self._ids = {}

	if self._surfaceType == SurfaceViewType.kHero and self._heroSystem:getHeroById(self._roleId) then
		self._ids = self._heroSystem:getOwnHeroIds()
	elseif self._surfaceType == SurfaceViewType.kMaster and self._masterSystem:getMasterById(self._roleId) then
		self._ids = self._masterSystem:getShowMasterListUnLock()
	end

	for i = 1, #self._surfaces do
		local surface = self._surfaces[i]

		if surface:getId() == self._surfaceId then
			self._curIndex = i

			break
		end
	end

	self._cellNode = {}

	self:refreshCurIndex()
end

function SurfaceMediator:refreshWithSelect()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("SURFACE_UI8")
	}))
	self:updateSurfaceNode()
	self:updateBtnState()
end

function SurfaceMediator:refreshWithBuy(event)
	local data = event:getData()

	if data.surfaceId then
		local view = self:getInjector():getInstance("GetSurfaceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			surfaceId = data.surfaceId
		}))
	end

	self:updateSurfaceNode()
	self:updateBtnState()
end

function SurfaceMediator:refreshRedPoint()
	self:updateSurfaceNode()
end

function SurfaceMediator:updateData()
	self._surfaceId = self._surfaces[self._curIndex]:getId()
	self._curSurface = self._surfaceSystem:getSurfaceById(self._surfaceId)
end

function SurfaceMediator:updateDataByTab()
	self._curIndex = 1
	self._surfaceId = self._surfaces[self._curIndex]:getId()
	self._curSurface = self._surfaceSystem:getSurfaceById(self._surfaceId)
end

function SurfaceMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._bg = self._main:getChildByFullName("bg")
	self._roleNode = self._main:getChildByFullName("roleNode")
	self._infoPanel = self._main:getChildByFullName("infoPanel")
	self._scrollView = self._main:getChildByFullName("surfacePanel")

	self._scrollView:setScrollBarEnabled(false)
	self._scrollView:setInertiaScrollEnabled(false)

	self._cellClone = self._main:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)
	self._cellClone:setAnchorPoint(cc.p(0.5, 0.5))

	self._surfaceNameBg = self._infoPanel:getChildByFullName("nameBg")
	self._surfaceName = self._infoPanel:getChildByFullName("surfaceName")
	self._surfaceDesc = self._infoPanel:getChildByFullName("surfaceDesc")
	self._nameBg = self._main:getChildByFullName("nameBg")
	self._name = self._main:getChildByFullName("name")
	self._rarity = self._main:getChildByFullName("rarity")

	self._rarity:ignoreContentAdaptWithSize(true)

	self._sureBtn = self._main:getChildByFullName("sureBtn")

	self._sureBtn:setVisible(false)

	self._unlockPanel = self._main:getChildByFullName("unlockPanel")

	self._unlockPanel:setVisible(false)

	self._cellWidth = self._cellClone:getContentSize().width
	self._scrollHeight = self._cellClone:getContentSize().height
	self._winSize = cc.size(self._scrollView:getContentSize().width, self._scrollHeight)
	self._centerPos = self._winSize.width / 2

	if #self._ids <= 1 then
		self._main:getChildByFullName("left"):setVisible(false)
		self._main:getChildByFullName("right"):setVisible(false)
	end

	if self._surfaceType == SurfaceViewType.kShop then
		-- block empty
	end

	self._scrollView:onScroll(function(event)
		self:onScroll(event)
	end)
	self._scrollView:onTouch(function(event)
		self:onTouch(event)
	end)

	local leftBtn = self._main:getChildByFullName("left.leftBtn")
	local rightBtn = self._main:getChildByFullName("right.rightBtn")

	CommonUtils.runActionEffect(leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true)
	CommonUtils.runActionEffect(rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true)
end

function SurfaceMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Unlock_Shop_Surface")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("SURFACE_UI_TITLE")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function SurfaceMediator:updateRoleName()
	self._rarity:setVisible(true)

	local config = ConfigReader:getRecordById("HeroBase", self._roleId)

	if not config then
		config = ConfigReader:getRecordById("MasterBase", self._roleId)

		self._rarity:setVisible(false)
	end

	self._name:setString(Strings:get(config.Name))
	self._nameBg:setContentSize(cc.size(self._name:getContentSize().width + 27, 75))

	if self._rarity:isVisible() then
		local hero = self._heroSystem:getHeroById(self._roleId)

		self._rarity:loadTexture(GameStyle:getHeroRarityImage((hero or nil) and hero:getRarity()), 1)
	end
end

function SurfaceMediator:createSurfaceNode()
	local surfaceId = ""
	local roleData = self._heroSystem:getHeroById(self._roleId)

	roleData = roleData or self._masterSystem:getMasterById(self._roleId)

	if roleData then
		surfaceId = roleData:getSurfaceId()
	end

	self._scrollView:removeAllChildren()

	local length = #self._surfaces

	for i = 1, length do
		local surface = self._surfaces[i]
		local surfaceNode = self._cellClone:clone()

		surfaceNode:setVisible(true)
		self._scrollView:addChild(surfaceNode)
		surfaceNode:setSwallowTouches(false)
		surfaceNode:addClickEventListener(function()
			self:onClickPointNode(i)
		end)
		surfaceNode:setTag(i)

		local posX = self._winSize.width / 2 + self._cellWidth * (i - 1)

		surfaceNode:setPosition(cc.p(posX, 147))

		local heroPanel = surfaceNode:getChildByFullName("hero")

		heroPanel:removeAllChildren()

		local roleModel = surface:getModel()
		local img, jsonPath = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe7_1",
			id = roleModel
		})

		img:addTo(heroPanel):center(heroPanel:getContentSize())
		img:setScale(0.78)

		local limitActivity = surfaceNode:getChildByFullName("limitActivity")

		limitActivity:setVisible(surface:getType() == SurfaceType.kActivity)

		local unlockDesc = surfaceNode:getChildByFullName("unlockDesc")

		unlockDesc:setVisible(not surface:getUnlock())
		unlockDesc:getChildByFullName("text"):setString(surface:getUnlockShortDesc())

		local inShop = self:checkIsInShopById(surface:getId())
		local canBuy = surface:getType() == SurfaceType.kShop and not surface:getUnlock() and inShop
		local buyPanel = surfaceNode:getChildByFullName("buyPanel")

		buyPanel:setVisible(canBuy)

		local usingPanel = surfaceNode:getChildByFullName("usingPanel")

		usingPanel:setVisible(surfaceId == surface:getId())

		if getCurrentLanguage() ~= GameLanguageType.CN then
			local text1 = usingPanel:getChildByFullName("text1")

			text1:setFontSize(20)
			text1:setPositionX(86)
		end

		local awakeAnim = surfaceNode:getChildByFullName("awakeAnim")

		if surface:getType() == SurfaceType.kAwake then
			local anim = cc.MovieClip:create("juexingkapai_juexingkapai")

			anim:addTo(awakeAnim, 1):setPosition(-300, 50)
		end

		local redPoint = surfaceNode:getChildByFullName("RedPoint")

		if not redPoint then
			redPoint = ccui.ImageView:create(IconFactory.redPointPath1, 1)

			redPoint:addTo(surfaceNode):posite(175, 280)
			redPoint:setName("RedPoint")
			redPoint:setVisible(false)
		end

		local isRed = self._surfaceSystem:getRedPointByHeroIdAndSur(self._roleId, surface:getId())

		redPoint:setVisible(isRed)

		self._cellNode[i] = surfaceNode
		self._cellNode[i].position = {
			surfaceNode:getPositionX(),
			surfaceNode:getPositionY()
		}
	end

	local offset = self._winSize.width / 2 - self._cellWidth / 2
	local width = math.max(length * self._cellWidth + 2 * offset, self._winSize.width + 5)

	self._scrollView:setInnerContainerSize(cc.size(width, self._scrollHeight))

	local scrollInnerWidth = self._scrollView:getInnerContainerSize().width - self._winSize.width
	local percent = (self._curIndex - 1) * self._cellWidth / scrollInnerWidth

	if percent == 0 then
		percent = 0.0001
	end

	self._scrollView:scrollToPercentHorizontal(percent * 100, 0.1, false)
end

function SurfaceMediator:updateSurfaceNode()
	local roleData = self._heroSystem:getHeroById(self._roleId)

	roleData = roleData or self._masterSystem:getMasterById(self._roleId)

	local length = #self._cellNode

	for i = 1, length do
		local surface = self._surfaces[i]
		local surfaceNode = self._cellNode[i]
		local limitActivity = surfaceNode:getChildByFullName("limitActivity")

		limitActivity:setVisible(surface:getType() == SurfaceType.kActivity)

		local unlockDesc = surfaceNode:getChildByFullName("unlockDesc")

		unlockDesc:setVisible(not surface:getUnlock())
		unlockDesc:getChildByFullName("text"):setString(surface:getUnlockShortDesc())

		local inShop = self:checkIsInShopById(surface:getId())
		local canBuy = surface:getType() == SurfaceType.kShop and not surface:getUnlock() and inShop
		local buyPanel = surfaceNode:getChildByFullName("buyPanel")

		buyPanel:setVisible(canBuy)

		local usingPanel = surfaceNode:getChildByFullName("usingPanel")

		usingPanel:setVisible(((roleData or nil) and roleData:getSurfaceId()) == surface:getId())

		local redPoint = surfaceNode:getChildByFullName("RedPoint")
		local isRed = self._surfaceSystem:getRedPointByHeroIdAndSur(self._roleId, surface:getId())

		redPoint:setVisible(isRed)
	end
end

function SurfaceMediator:updateSurfaceInfo()
	self._roleNode:removeAllChildren()

	local roleModel = self._curSurface:getModel()
	local img, jsonPath = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = roleModel
	})

	self._roleNode:addChild(img)
	img:setPosition(cc.p(70, -100))

	local roleNode = self._infoPanel:getChildByFullName("roleNode")

	roleNode:removeAllChildren()

	local model = ConfigReader:getDataByNameIdAndKey("RoleModel", roleModel, "Model")
	local role = RoleFactory:createRoleAnimation(model, (self._curSurface:getType() == SurfaceType.kAwake or nil) and "stand1")

	role:addTo(roleNode):posite(0, 10)
	role:setScale(-0.45, 0.45)
	self._surfaceName:setString(self._curSurface:getName())
	self._surfaceDesc:setString(self._curSurface:getDesc())
	self._surfaceNameBg:setContentSize(cc.size(self._surfaceName:getContentSize().width + 35, 72))
end

function SurfaceMediator:updateBtnState()
	local inShop = self:checkIsInShop()
	local unlock = self._curSurface:getUnlock()

	self._unlockPanel:setVisible(not unlock and not inShop)
	self._unlockPanel:getChildByFullName("unlock1"):setString(self._curSurface:getUnlockDesc())
	self._sureBtn:setVisible(false)

	local costNode = self._sureBtn:getChildByFullName("costNode")

	costNode:setVisible(false)
	costNode:removeChildByName("CostIcon")

	if unlock then
		local roleData = self._heroSystem:getHeroById(self._roleId)

		roleData = roleData or self._masterSystem:getMasterById(self._roleId)

		local showChange = self._surfaceType ~= SurfaceViewType.kShop and ((roleData or nil) and roleData:getSurfaceId()) ~= self._curSurface:getId()

		self._sureBtn:setVisible(showChange)
		self._sureBtnWidget:setButtonName(Strings:get("SURFACE_UI7"), Strings:get("SURFACE_UI7_EN"))
	elseif self._curSurface:getType() == SurfaceType.kShop then
		self:createShopCost()
		self._sureBtnWidget:setButtonName("", "")
		self._sureBtn:setVisible(inShop)
	elseif self._curSurface:getType() == SurfaceType.kActivity then
		self._sureBtnWidget:setButtonName(Strings:get("SURFACE_UI6"), Strings:get("SURFACE_UI6_EN"))

		local activityId = self._curSurface:getActivityId()
		local hasActivity = not not self._activitySystem:getActivityById(activityId)
		local showGoto = hasActivity

		if hasActivity then
			local url = self._curSurface:getLink()

			if url ~= "" then
				local unlock, tip = UrlEntryManage.checkEnabledWithUserData(url)

				showGoto = unlock
			else
				showGoto = false
			end
		end

		self._sureBtn:setVisible(showGoto)
		self._unlockPanel:setVisible(not self._sureBtn:isVisible())
	elseif self._curSurface:getType() == SurfaceType.kOther then
		-- block empty
	else
		self._sureBtn:setVisible(false)
	end
end

function SurfaceMediator:createShopCost()
	if self._shopItemData then
		local costNode = self._sureBtn:getChildByFullName("costNode")

		costNode:setVisible(true)

		local costType = self._shopItemData:getCostType()
		local costNum = self._shopItemData:getPrice()
		local text1 = costNode:getChildByFullName("text1")
		local text = costNode:getChildByFullName("text")

		text:setString(costNum)

		local costIcon = IconFactory:createResourcePic({
			id = costType
		})

		costIcon:addTo(costNode):setScale(0.85)
		costIcon:setName("CostIcon")

		local width1 = text1:getContentSize().width
		local width2 = text:getContentSize().width

		text1:setPositionX(0)
		costIcon:setPosition(cc.p(width1 + 15, text1:getPositionY()))
		text:setPositionX(width1 + 30)
		costNode:setContentSize(cc.size(width1 + width2 + 30, 50))
	end
end

function SurfaceMediator:checkIsInShopById(surfaceId)
	local shopSurface = self._shopSystem:getShopSurfaceById(surfaceId)

	if shopSurface then
		return true
	end

	return false
end

function SurfaceMediator:checkIsInShop()
	self._shopItemData = nil

	local surfaceId = self._curSurface:getId()
	local shopSurface = self._shopSystem:getShopSurfaceById(surfaceId)

	if shopSurface then
		self._shopItemData = shopSurface

		return true
	end

	return false
end

function SurfaceMediator:refreshCurIndex()
	for i = 1, #self._ids do
		if self._ids[i].id == self._roleId then
			self._curIdIndex = i

			break
		end
	end
end

function SurfaceMediator:onClickLeft()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIdIndex = self._curIdIndex - 1

	if self._curIdIndex < 1 then
		self._curIdIndex = #self._ids
	end

	local heroId = self._ids[self._curIdIndex].id

	self._roleId = heroId

	if self._surfaceType == SurfaceViewType.kHero then
		self._heroSystem:setUiSelectHeroId(heroId)
		self:dispatch(Event:new(EVT_SURFACE_CHANGE_HERO))
	end

	self._surfaces = self._surfaceSystem:getSurfaceByTargetRole(self._roleId, self._surfaceType)

	if #self._surfaces < 1 then
		self:onClickBack()

		return
	end

	self._cellNode = {}

	self:updateDataByTab()
	self:updateRoleName()
	self:createSurfaceNode()
	self:updateSurfaceInfo()
	self:updateBtnState()
end

function SurfaceMediator:onClickRight()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)

	self._curIdIndex = self._curIdIndex + 1

	if self._curIdIndex > #self._ids then
		self._curIdIndex = 1
	end

	local heroId = self._ids[self._curIdIndex].id

	self._roleId = heroId

	if self._surfaceType == SurfaceViewType.kHero then
		self._heroSystem:setUiSelectHeroId(heroId)
		self:dispatch(Event:new(EVT_SURFACE_CHANGE_HERO))
	end

	self._surfaces = self._surfaceSystem:getSurfaceByTargetRole(self._roleId, self._surfaceType)

	if #self._surfaces < 1 then
		self:onClickBack()

		return
	end

	self._cellNode = {}

	self:updateDataByTab()
	self:updateRoleName()
	self:createSurfaceNode()
	self:updateSurfaceInfo()
	self:updateBtnState()
end

function SurfaceMediator:onClickBack()
	self:dismiss()
end

function SurfaceMediator:onClickSure()
	if self._curSurface:getUnlock() then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local params = {
			surfaceId = self._curSurface:getId()
		}

		self._surfaceSystem:requestSelectSurface(params)
	elseif self._curSurface:getType() == SurfaceType.kActivity then
		local url = self._curSurface:getLink()
		local context = self:getInjector():instantiate(URLContext)
		local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

		if not entry then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Function_Not_Open")
			}))
		else
			entry:response(context, params)
		end
	elseif self._curSurface:getType() == SurfaceType.kShop then
		if not self._shopItemData then
			return
		end

		local costType = self._shopItemData:getCostType()
		local costNum = self._shopItemData:getPrice()

		if not self._bagSystem:checkCostEnough(costType, costNum, {
			type = "tip"
		}) then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local param = {
			surfaceId = self._curSurface:getId()
		}

		self._surfaceSystem:requestBuySurface(param)
	end
end

function SurfaceMediator:onScroll(event)
	if event.name == "CONTAINER_MOVED" then
		local middlePoint = cc.p(self._scrollView:getPositionX(), 0)
		local targetWidth = self._cellWidth / 2
		local width = self._winSize.width / 2

		for i = 1, #self._surfaces do
			local v = self._scrollView:getChildByTag(i)
			local position = self._cellNode[i].position

			self._cellNode[i]:setPosition(cc.p(position[1], position[2]))
			v:setVisible(true)

			local pos = cc.p(position[1], position[2])
			local targetPos = v:getParent():convertToWorldSpace(pos)

			targetPos = self._scrollView:getParent():convertToNodeSpace(targetPos)

			local des = math.abs(targetPos.x - middlePoint.x)
			local order = 9999
			local offsetX = 0
			local scale = 1

			if des > targetWidth + 5 then
				order = order - des
				scale = (width + targetWidth - des + (des - targetWidth) / targetWidth * 40) / (width + targetWidth) * 0.45 + 0.55

				if targetPos.x - middlePoint.x > 0 then
					offsetX = -((self._cellWidth + des / targetWidth * 80) * (1 - scale))
				elseif targetPos.x - middlePoint.x < 0 then
					offsetX = (self._cellWidth + des / targetWidth * 80) * (1 - scale)
				end
			end

			local color = cc.c3b(255, 255, 255)

			if scale < 1 and scale >= 0.68 then
				color = cc.c3b(204, 204, 204)
			elseif scale < 0.68 then
				color = cc.c3b(153, 153, 153)
			end

			v:setColor(color)
			v:setLocalZOrder(order)
			v:setScale(scale)
			v:offset(offsetX, 0)
		end
	end
end

function SurfaceMediator:onTouch(event)
	if event.name == "ended" or event.name == "cancelled" then
		if self._isClickPoint then
			return
		end

		dump(event, "onTouch : ")

		local scrollPosX = self._scrollView:getInnerContainerPosition().x
		local curIndex = math.floor(math.abs(scrollPosX) / self._cellWidth + 0.5) + 1

		self:scrollToCurIndex(curIndex)
	end
end

function SurfaceMediator:scrollToCurIndex(curIndex)
	if self._isClickPoint and self._curIndex == curIndex then
		return
	end

	local scrollInnerWidth = self._scrollView:getInnerContainerSize().width - self._winSize.width
	local percent = (curIndex - 1) * self._cellWidth / scrollInnerWidth

	if self._curIndex ~= curIndex then
		self._curIndex = math.min(#self._surfaces, curIndex)

		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end

	self._scrollView:scrollToPercentHorizontal(percent * 100, 0.1, false)
	self:updateData()
	self:updateSurfaceInfo()
	self:updateBtnState()
end

function SurfaceMediator:onClickPointNode(tag)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	self._isClickPoint = true

	self:scrollToCurIndex(tag)
	delayCallByTime(100, function()
		self._isClickPoint = false
	end)
end

function SurfaceMediator:onTouchMaskLayer()
	return
end
