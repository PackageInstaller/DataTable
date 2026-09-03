-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamHouse/view/DreamHouseMainMediator.lua

DreamHouseMainMediator = class("DreamHouseMainMediator", DmAreaViewMediator, _M)

DreamHouseMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
DreamHouseMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
DreamHouseMainMediator:has("_houseSystem", {
	is = "r"
}):injectWith("DreamHouseSystem")

local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}
local kBtnHandlers = {
	["main.infoBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickInfoBtn"
	},
	["main.leftBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["main.rightBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	}
}

function DreamHouseMainMediator:initialize()
	super.initialize(self)
end

function DreamHouseMainMediator:dispose()
	super.dispose(self)
end

function DreamHouseMainMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_POINT_REWARD_REFRESH, self, self.refreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HOUSE_MAIN_REFRESH, self, self.refreshHouseMain)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function DreamHouseMainMediator:enterWithData(data)
	self:initWigetInfo()
	self:initData(data)
	self:setupTopView()
	self:setupUI()
	self:setupListPoint()
	self:initAnim()
end

function DreamHouseMainMediator:resumeWithData()
	self:setupUI()
	self:setupListPoint()
	self:initAnim()
end

function DreamHouseMainMediator:initWigetInfo()
	self._view = self:getView()
	self._main = self._view:getChildByName("main")
	self._animNode = self._main:getChildByName("animNode")
	self._bg = self._main:getChildByName("bg")
	self._infoCell = self._view:getChildByName("mapCell")

	self._infoCell:setVisible(false)

	self._mapPointCell = self._view:getChildByName("mapPointCell")

	self._mapPointCell:setVisible(false)

	self._itemCell = self._view:getChildByName("itemCell")

	self._itemCell:setVisible(false)

	self._roleCell = self._view:getChildByName("roleCell")

	self._roleCell:setVisible(false)

	self._scrollView = self._main:getChildByFullName("mapList")
	self._leftBtn = self._main:getChildByFullName("leftBtn")
	self._rightBtn = self._main:getChildByFullName("rightBtn")

	self._main:getChildByFullName("enterBtn"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onPointClick()
		end
	end)

	self._pointNode = self._main:getChildByFullName("Node_1")
end

function DreamHouseMainMediator:initData(data)
	self._cellOffsetX = 0
	self._cellWidth = self._infoCell:getContentSize().width
	self._cellHeight = self._infoCell:getContentSize().height
	self._scrollWidth = self._scrollView:getContentSize().width
	self._scrollHeight = self._scrollView:getContentSize().height
	self._house = self._houseSystem:getHouse()
	self._houseMaps = self._houseSystem:getHouseMaps()
	self._infoListNum = #self._houseMaps

	assert(self._infoListNum ~= 0, "Error: MAP UNACAILABLE, CHECK CONFIG!!!!")

	self._pointPageNum = math.ceil(self._infoListNum / 5)
	self._curIndex = self._house:getDefaultMapIdx()
	self._curPage = math.ceil(self._curIndex / 5)
end

function DreamHouseMainMediator:setupTopView()
	local topInfoNode = self:getView():getChildByFullName("main.topinfo")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("DreamHouseUnlockParm")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		stopAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("DreamHouse_Main_UI04")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self._main:getChildByName("infoBtn"):setPositionX(self._topInfoWidget:getTitleWidth() + 25)
end

function DreamHouseMainMediator:setupUI()
	self._scrollView:setScrollBarEnabled(false)
	self._scrollView:setInertiaScrollEnabled(false)
	self._scrollView:onScroll(function(event)
		self:onScroll(event)
	end)
	self._scrollView:removeAllChildren()

	for i = 1, self._infoListNum do
		local infoCell = self._infoCell:clone()

		infoCell:setVisible(true)
		infoCell:setTag(i)

		local posX = self._cellWidth / 2 + (self._cellWidth + self._cellOffsetX) * (i - 1) - self._cellOffsetX / 2

		infoCell:setPosition(cc.p(posX, 188))
		self:setInfoUI(infoCell, i)
		self._scrollView:addChild(infoCell)
	end

	local offset = 0
	local width = math.max(offset + self._infoListNum * self._cellWidth + (self._infoListNum - 1) * self._cellOffsetX, self._scrollWidth)

	self._scrollView:setInnerContainerSize(cc.size(width, self._scrollHeight))

	local scrollInnerWidth = self._scrollView:getInnerContainerSize().width - self._scrollView:getContentSize().width

	self._scrollView:scrollToPercentHorizontal(((scrollInnerWidth > 0 or nil) and (self._curIndex - 1) * self._cellWidth / scrollInnerWidth) * 100, 0.1, false)
	self:refreshView()
end

function DreamHouseMainMediator:setupListPoint()
	self._pointNode:removeAllChildren()

	local cellWidth = self._mapPointCell:getContentSize().width

	for i = 1, self._pointPageNum do
		local point = self._mapPointCell:clone()

		point:setVisible(true)
		point:setTag(i)
		self._pointNode:addChild(point)

		local posx = (i - 1) * cellWidth - cellWidth * self._pointPageNum / 2

		point:setPosition(cc.p(posx, 0))
		point:getChildByName("touch"):addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self:scrollToCurIndex(i)
			end
		end)
		point:getChildByName("on"):setVisible(i == self._curPage)
	end
end

function DreamHouseMainMediator:setInfoUI(cell, idx)
	cell:setSwallowTouches(false)
	cell:addClickEventListener(function()
		self:onPointChoose(idx)
	end)

	local mapId = self._houseMaps[idx]
	local mapData = self._houseSystem:getMapById(mapId)
	local mapView = cell:getChildByFullName("mapView")
	local mapNameLab = cell:getChildByFullName("name")

	mapNameLab:getVirtualRenderer():setLineSpacing(-10)
	mapNameLab:setString(Strings:get(mapData:getMapConfig().Name))

	local pointNameLab = cell:getChildByFullName("mapName")

	if not mapData:isLock() and not self._house:isMapRewardGet(mapId) then
		pointNameLab:setString(Strings:get("DreamHouse_Main_UI32"))
	else
		pointNameLab:setString(mapData:getLastPointName2())
	end

	local rewards = RewardSystem:getRewardsById(mapData:getMapConfig().RewardShow)

	if not rewards[1] then
		local rewardData = {}
		local rewardPanel = cell:getChildByFullName("mapView.icon")
		local icon = IconFactory:createRewardIcon(rewardData, {
			showAmount = false,
			notShowQulity = true,
			isWidget = true
		})

		icon:addTo(rewardPanel):center(rewardPanel:getContentSize()):offset(0, 0)

		local lockImg = cell:getChildByFullName("mapView.lock")
		local lockAnim = cell:getChildByFullName("mapView.lockAnim")

		lockImg:setVisible(mapData:isLock())

		local lockDiImg = cell:getChildByFullName("mapView.lockDi")

		lockDiImg:setVisible(mapData:isLock())
		lockAnim:removeAllChildren()

		if mapData:isLock() then
			lockAnim:setVisible(false)
		else
			local rewardSta = self._house:isMapRewardGet(mapId)

			lockAnim:setVisible(not rewardSta)
		end

		local anim = cc.MovieClip:create("kaisuo_tishi_bumengguanzhujiemian")

		anim:setPosition(cc.p(0, 0))
		anim:addTo(lockAnim):offset(24, 21.5)

		local anim2 = cc.MovieClip:create("jiesuo_tishi_bumengguanzhujiemian")

		anim2:setPosition(cc.p(0, 0))
		anim2:addTo(lockAnim):offset(24, 21.5)
		anim2:setScale(1.15)

		local passImg = cell:getChildByFullName("mapView.pass")

		passImg:setVisible(mapData:isPass())
		passImg:loadTexture((mapData:isFullStarPass() or nil) and "dreamHouse_txt_fb_wm.png", ccui.TextureResType.plistType)

		local roldPanels = {}

		roldPanels[1] = cell:getChildByFullName("roleView.role_1")
		roldPanels[2] = cell:getChildByFullName("roleView.role_2")
		roldPanels[3] = cell:getChildByFullName("roleView.role_3")

		for i = 1, #roldPanels do
			local roldBase = roldPanels[i]:getChildByName("role")

			roldBase:removeAllChildren()

			local roldId = mapData:getMapConfig().HeroId[i]

			if roldId then
				local model = IconFactory:getRoleModelByKey("HeroBase", roldId)
				local heroImg = IconFactory:createRoleIconSpriteNew({
					id = model
				})

				heroImg:setScale(0.23)
				heroImg:addTo(roldBase):center(roldBase:getContentSize()):offset(0, 0)

				local has = self._heroSystem:hasHero(roldId)

				roldPanels[i]:setGray(not has)

				local roleKuang = roldPanels[i]:getChildByName("Image_16")
				local rareity = ConfigReader:getDataByNameIdAndKey("HeroBase", roldId, "Rareity")

				if rareity <= 12 then
					roleKuang:loadTexture("asset/commonRaw/common_bd_r03.png")
				else
					roleKuang:loadTexture(GameStyle:getHeroRarityBg(rareity)[2])
				end
			end
		end

		local redPoint = cell:getChildByFullName("mapView.redPoint")

		redPoint:setVisible(self._houseSystem:checkIsShowRedPointByMap(mapId))

		local showAnimPanel = cell:getChildByFullName("anim")

		showAnimPanel:removeAllChildren()

		local showAnim = cc.MovieClip:create("yinghua01_bumengguanzhujiemian")

		showAnim:setPosition(cc.p(112, 113))
		showAnim:addTo(showAnimPanel):offset(0, 17)
		showAnim:stop()
		showAnim:addEndCallback(function(cid, mc)
			self._main:getChildByFullName("mask"):setVisible(false)
			self._main:getChildByFullName("mask2"):setVisible(false)
			mc:stop()
		end)
		mapNameLab:setVisible(false)
		mapNameLab:setOpacity(20)
		mapNameLab:setScale(0.5)
		showAnim:addCallbackAtFrame(5, function(cid, mc)
			mapNameLab:setVisible(true)

			local fadeIn = cc.FadeIn:create(0.1)
			local scaleTo = cc.ScaleTo:create(0.1, 1.05)
			local spawn = cc.Spawn:create(fadeIn, scaleTo)
			local easeInOut = cc.EaseInOut:create(spawn, 1)
			local scaleTo2 = cc.ScaleTo:create(0.1, 1)
			local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

			mapNameLab:runAction(cc.Sequence:create(easeInOut, easeInOut1))
		end)
		mapView:setVisible(false)
		mapView:setOpacity(0)
		mapView:setScale(0.3)
		showAnim:addCallbackAtFrame(11, function(cid, mc)
			mapView:setVisible(true)

			local fadeIn = cc.FadeIn:create(0.2)
			local scaleTo = cc.ScaleTo:create(0.2, 1.05)
			local spawn = cc.Spawn:create(fadeIn, scaleTo)
			local easeInOut = cc.EaseInOut:create(spawn, 1)
			local scaleTo2 = cc.ScaleTo:create(0.2, 1)
			local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

			mapView:runAction(cc.Sequence:create(easeInOut, easeInOut1))
		end)
		pointNameLab:setOpacity(0)
		pointNameLab:setScale(0.3)
		showAnim:addCallbackAtFrame(21, function(cid, mc)
			local fadeIn = cc.FadeIn:create(0.15)
			local scaleTo = cc.ScaleTo:create(0.15, 1.05)
			local spawn = cc.Spawn:create(fadeIn, scaleTo)
			local easeInOut = cc.EaseInOut:create(spawn, 1)
			local scaleTo2 = cc.ScaleTo:create(0.15, 1)
			local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

			pointNameLab:runAction(cc.Sequence:create(easeInOut, easeInOut1))
		end)
		roldPanels[1]:setOpacity(0)
		roldPanels[1]:setScale(0.3)
		showAnim:addCallbackAtFrame(15, function(cid, mc)
			local fadeIn = cc.FadeIn:create(0.1)
			local scaleTo = cc.ScaleTo:create(0.1, 1.05)
			local spawn = cc.Spawn:create(fadeIn, scaleTo)
			local easeInOut = cc.EaseInOut:create(spawn, 1)
			local scaleTo2 = cc.ScaleTo:create(0.1, 1)
			local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

			roldPanels[1]:runAction(cc.Sequence:create(easeInOut, easeInOut1))
		end)
		roldPanels[2]:setOpacity(0)
		roldPanels[2]:setScale(0.3)
		showAnim:addCallbackAtFrame(13, function(cid, mc)
			local fadeIn = cc.FadeIn:create(0.1)
			local scaleTo = cc.ScaleTo:create(0.1, 1.05)
			local spawn = cc.Spawn:create(fadeIn, scaleTo)
			local easeInOut = cc.EaseInOut:create(spawn, 1)
			local scaleTo2 = cc.ScaleTo:create(0.1, 1)
			local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

			roldPanels[2]:runAction(cc.Sequence:create(easeInOut, easeInOut1))
		end)
		roldPanels[3]:setVisible(false)
		roldPanels[3]:setOpacity(0)
		roldPanels[3]:setScale(0.3)
		showAnim:addCallbackAtFrame(17, function(cid, mc)
			roldPanels[3]:setVisible(true)

			local fadeIn = cc.FadeIn:create(0.1)
			local scaleTo = cc.ScaleTo:create(0.1, 1.05)
			local spawn = cc.Spawn:create(fadeIn, scaleTo)
			local easeInOut = cc.EaseInOut:create(spawn, 1)
			local scaleTo2 = cc.ScaleTo:create(0.1, 1)
			local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

			roldPanels[3]:runAction(cc.Sequence:create(easeInOut, easeInOut1))
		end)

		local chooseAnimPanel = cell:getChildByFullName("anim2")

		chooseAnimPanel:removeAllChildren()

		local chooseAnim = cc.MovieClip:create("yinghua01_xuanzhong_bumengguanzhujiemian")

		chooseAnim:setPosition(cc.p(112, 113))
		chooseAnim:addTo(chooseAnimPanel):offset(0, 17)
		chooseAnim:stop()
		chooseAnimPanel:setVisible(false)
		chooseAnim:addEndCallback(function(cid, mc)
			self._main:getChildByFullName("mask"):setVisible(false)
			mc:stop()
		end)
		chooseAnim:addCallbackAtFrame(2, function(cid, mc)
			local mapView = cell:getChildByName("mapView")
			local roleView = cell:getChildByName("roleView")
			local fadeOutAct = cc.FadeOut:create(0.1)
			local scaleTo2 = cc.ScaleTo:create(0.1, 1)
			local scaleTo4 = cc.ScaleTo:create(0.1, 1)
			local scaleTo6 = cc.ScaleTo:create(0.2, 1)
			local move2 = cc.MoveTo:create(0.1, cc.p(117, 248))
			local move4 = cc.MoveTo:create(0.1, cc.p(117, 84))
			local move6 = cc.MoveTo:create(0.2, cc.p(114, 193))
			local move7 = cc.MoveTo:create(0.1, cc.p(114, 178))

			mapNameLab:stopAllActions()
			mapView:stopAllActions()
			roleView:stopAllActions()
			mapNameLab:runAction(fadeOutAct)
			pointNameLab:runAction(cc.Sequence:create(cc.EaseInOut:create(cc.Spawn:create(move6, scaleTo6), 1), move7))
			mapView:runAction(cc.EaseInOut:create(cc.Spawn:create(move2, scaleTo2), 1))
			roleView:runAction(cc.EaseInOut:create(cc.Spawn:create(move4, scaleTo4), 1))
		end)

		local cancleAnimPanel = cell:getChildByFullName("anim3")

		cancleAnimPanel:removeAllChildren()

		local cancleAnim = cc.MovieClip:create("yinghua_quxiaoxuanzhong_bumengguanzhujiemian")

		cancleAnim:setPosition(cc.p(112, 113))
		cancleAnim:addTo(cancleAnimPanel):offset(0, 17)
		cancleAnim:stop()
		cancleAnimPanel:setVisible(false)
		cancleAnim:addEndCallback(function(cid, mc)
			self._main:getChildByFullName("mask"):setVisible(false)
			mc:stop()
		end)
		cancleAnim:addCallbackAtFrame(3, function(cid, mc)
			local mapView = cell:getChildByName("mapView")
			local roleView = cell:getChildByName("roleView")

			mapNameLab:stopAllActions()

			local fadeInAct = cc.FadeIn:create(0.1)

			mapNameLab:runAction(fadeInAct)
			mapView:stopAllActions()

			local scaleTo1 = cc.ScaleTo:create(0.15, 1.1)
			local move1 = cc.MoveTo:create(0.15, cc.p(117, 255))
			local spawn1 = cc.Spawn:create(move1, scaleTo1)
			local scaleTo2 = cc.ScaleTo:create(0.16, 0.75)
			local move2 = cc.MoveTo:create(0.16, cc.p(117, 178))
			local spawn2 = cc.Spawn:create(move2, scaleTo2)
			local scaleTo3 = cc.ScaleTo:create(0.08, 0.85)

			mapView:runAction(cc.Sequence:create(spawn1, spawn2, scaleTo3))
			roleView:stopAllActions()

			local scaleTo1 = cc.ScaleTo:create(0.15, 1.1)
			local move1 = cc.MoveTo:create(0.15, cc.p(117, 98))
			local spawn1 = cc.Spawn:create(move1, scaleTo1)
			local scaleTo2 = cc.ScaleTo:create(0.16, 0.75)
			local move2 = cc.MoveTo:create(0.16, cc.p(117, 37))
			local spawn2 = cc.Spawn:create(move2, scaleTo2)
			local scaleTo3 = cc.ScaleTo:create(0.08, 0.9)

			roleView:runAction(cc.Sequence:create(spawn1, spawn2, scaleTo3))
			pointNameLab:stopAllActions()

			local scaleTo1 = cc.ScaleTo:create(0.1, 1.1)
			local move1 = cc.MoveBy:create(0.1, cc.p(0, 28))
			local spawn1 = cc.Spawn:create(move1, scaleTo1)
			local scaleTo2 = cc.ScaleTo:create(0.2, 0.75)
			local move2 = cc.MoveBy:create(0.2, cc.p(0, -88))
			local spawn2 = cc.Spawn:create(move2, scaleTo2)
			local scaleTo3 = cc.ScaleTo:create(0.08, 0.9)

			pointNameLab:runAction(cc.Sequence:create(spawn1, spawn2, scaleTo3))
		end)

		function cell.playShow()
			chooseAnimPanel:setVisible(false)
			showAnim:setVisible(true)
			cancleAnimPanel:setVisible(false)
			showAnim:gotoAndPlay(0)
		end

		function cell.playChoose()
			chooseAnimPanel:setVisible(true)
			showAnim:setVisible(false)
			cancleAnimPanel:setVisible(false)
			chooseAnim:gotoAndPlay(0)
		end

		function cell.playCancle()
			cancleAnimPanel:setVisible(true)
			showAnim:setVisible(false)
			chooseAnimPanel:setVisible(false)
			cancleAnim:gotoAndPlay(0)
		end
	end
end

function DreamHouseMainMediator:refreshInfoUI(cell, idx)
	local mapId = self._houseMaps[idx]
	local mapData = self._houseSystem:getMapById(mapId)
	local mapView = cell:getChildByFullName("mapView")
	local mapNameLab = cell:getChildByFullName("name")

	mapNameLab:setString(Strings:get(mapData:getMapConfig().Name))

	local pointNameLab = cell:getChildByFullName("mapName")

	if not mapData:isLock() and not self._house:isMapRewardGet(mapId) then
		pointNameLab:setString(Strings:get("DreamHouse_Main_UI32"))
	else
		pointNameLab:setString(mapData:getLastPointName2())
	end

	local lockImg = cell:getChildByFullName("mapView.lock")
	local lockAnim = cell:getChildByFullName("mapView.lockAnim")

	lockImg:setVisible(mapData:isLock())

	local lockDiImg = cell:getChildByFullName("mapView.lockDi")

	lockDiImg:setVisible(mapData:isLock())
	lockAnim:removeAllChildren()

	if mapData:isLock() then
		lockAnim:setVisible(false)
	else
		local rewardSta = self._house:isMapRewardGet(mapId)

		lockAnim:setVisible(not rewardSta)
	end

	local passImg = cell:getChildByFullName("mapView.pass")

	passImg:setVisible(mapData:isPass())
	passImg:loadTexture((mapData:isFullStarPass() or nil) and "dreamHouse_txt_fb_wm.png", ccui.TextureResType.plistType)

	local roldPanels = {}

	roldPanels[1] = cell:getChildByFullName("roleView.role_1")
	roldPanels[2] = cell:getChildByFullName("roleView.role_2")
	roldPanels[3] = cell:getChildByFullName("roleView.role_3")

	for i = 1, #roldPanels do
		local roldBase = roldPanels[i]:getChildByName("role")
		local roldId = mapData:getMapConfig().HeroId[i]

		if roldId then
			local has = self._heroSystem:hasHero(roldId)

			roldPanels[i]:setGray(not has)

			local roleKuang = roldPanels[i]:getChildByName("Image_16")
			local rareity = ConfigReader:getDataByNameIdAndKey("HeroBase", roldId, "Rareity")

			if rareity <= 12 then
				roleKuang:loadTexture("asset/commonRaw/common_bd_r03.png")
			else
				roleKuang:loadTexture(GameStyle:getHeroRarityBg(rareity)[2])
			end
		end
	end

	local redPoint = cell:getChildByFullName("mapView.redPoint")

	redPoint:setVisible(self._houseSystem:checkIsShowRedPointByMap(mapId))
end

function DreamHouseMainMediator:onScroll(event)
	if event.name == "CONTAINER_MOVED" then
		self:setInfoCellStates()
	end
end

function DreamHouseMainMediator:scrollToCurIndex(curIndex)
	local scrollInnerWidth = self._scrollView:getInnerContainerSize().width - self._scrollView:getContentSize().width
	local percent = 0

	if scrollInnerWidth > 0 then
		percent = (curIndex - 1) * self._cellWidth / scrollInnerWidth
	end

	if self._curPage ~= curIndex then
		self._curPage = math.min(self._pointPageNum, curIndex)

		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end

	self._scrollView:scrollToPercentHorizontal(percent * 100, 0.1, false)
	self:refreshView()

	for i = 1, self._pointPageNum do
		local point = self._pointNode:getChildByTag(i)

		point:getChildByName("on"):setVisible(i == self._curPage)
	end
end

function DreamHouseMainMediator:setInfoCellStates()
	local middlePoint = cc.p(self._scrollView:getContentSize().width / 2, 0)

	for i = 1, self._pointPageNum do
		local v = self._pointNode:getChildByTag(i)
		local scrollPosX = self._scrollView:getInnerContainerPosition().x
		local scrollInnerWidth = self._scrollView:getInnerContainerSize().width - self._scrollView:getContentSize().width
		local percent = math.abs(scrollPosX / scrollInnerWidth)

		self._curPage = math.min(math.max(math.ceil(percent * self._pointPageNum), 1), self._pointPageNum)

		if v then
			v:getChildByName("on"):setVisible(i == self._curPage)
		end

		self._leftBtn:setVisible(self._curPage > 1)
		self._rightBtn:setVisible(self._curPage < self._pointPageNum)
	end
end

function DreamHouseMainMediator:refreshView()
	self._main:getChildByFullName("mask"):setVisible(false)
	self._main:getChildByFullName("mask2"):setVisible(false)

	local mapId = self._houseMaps[self._curIndex]
	local mapData = self._houseSystem:getMapById(mapId)

	self._leftBtn:setVisible(self._curPage > 1)
	self._rightBtn:setVisible(self._curPage < self._pointPageNum)

	local mapNameLab = self._main:getChildByFullName("detailPanel.mapName")

	mapNameLab:setString(Strings:get(mapData:getMapConfig().Name))

	local pointNameLab = self._main:getChildByFullName("detailPanel.pointName")

	if not mapData:isLock() and not self._house:isMapRewardGet(mapId) then
		pointNameLab:setString(Strings:get("DreamHouse_Main_UI32"))
	else
		pointNameLab:setString(mapData:getLastPointName())
	end

	local rewardList = self._main:getChildByFullName("detailPanel.rewardList")

	rewardList:setScrollBarEnabled(false)
	rewardList:removeAllChildren()

	local rewards = RewardSystem:getRewardsById(mapData:getMapConfig().RewardShow)

	for i = 1, #rewards do
		local rewardData = rewards[i]
		local item = self._itemCell:clone()

		item:setVisible(true)

		local icon = IconFactory:createRewardIcon(rewardData, {
			showAmount = true,
			notShowQulity = false,
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			needDelay = true
		})
		icon:setScaleNotCascade(0.52)
		icon:addTo(item):center(item:getContentSize()):offset(0, -5)
		rewardList:pushBackCustomItem(item)
	end

	local roleList = self._main:getChildByFullName("detailPanel.roleList")

	roleList:removeAllChildren()
	roleList:setScrollBarEnabled(false)

	local roles = mapData:getMapConfig().HeroId

	for i = 1, #roles do
		local roleId = roles[i]
		local roleItem = self._roleCell:clone()

		roleItem:setVisible(true)

		local model = IconFactory:getRoleModelByKey("HeroBase", roleId)
		local heroImg = IconFactory:createRoleIconSpriteNew({
			id = model
		})

		heroImg:setScale(0.68)

		local heroPanel = roleItem:getChildByName("hero")

		heroPanel:removeAllChildren()
		heroPanel:addChild(heroImg)
		heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2)

		local bg1 = roleItem:getChildByName("bg1")
		local bg2 = roleItem:getChildByName("bg2")
		local rareity = ConfigReader:getDataByNameIdAndKey("HeroBase", roleId, "Rareity")

		bg1:loadTexture(GameStyle:getHeroRarityBg(rareity)[1])

		if rareity <= 12 then
			bg2:loadTexture("asset/commonRaw/common_bd_r03.png")
		else
			bg2:loadTexture(GameStyle:getHeroRarityBg(rareity)[2])
		end

		if kHeroRarityBgAnim[rareity] then
			local anim = cc.MovieClip:create(kHeroRarityBgAnim[rareity])

			anim:addTo(bg1):center(bg1:getContentSize())

			if rareity <= 14 then
				anim:offset(-1, -29)
			else
				anim:offset(-3, 0)
			end

			if rareity >= 14 then
				local anim = cc.MovieClip:create("ssrlizichai_yingxiongxuanze")

				anim:addTo(bg2):center(bg2:getContentSize()):offset(5, -20)
			end
		else
			local sprite = ccui.ImageView:create(GameStyle:getHeroRarityBg(rareity)[1])

			sprite:addTo(bg1):center(bg1:getContentSize())
		end

		bg1:setScale(0.42)
		bg2:setScale(0.42)
		heroPanel:setScale(0.4)
		roleList:pushBackCustomItem(roleItem)
		roleItem:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

				local view = self:getInjector():getInstance("HeroInfoView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
					heroId = roleId
				}))
			end
		end)
	end

	local enterBtn = self._main:getChildByFullName("enterBtn")

	enterBtn:removeAllChildren()

	local mc = cc.MovieClip:create("jinru_zhuxianguanka_UIjiaohudongxiao")

	mc:addCallbackAtFrame(30, function()
		mc:stop()
	end)
	mc:stop()
	mc:addTo(enterBtn):center(enterBtn:getContentSize())
	mc:setScale(0.8)
	mc:setLocalZOrder(100)
	enterBtn:setGray(mapData:isLock())
end

function DreamHouseMainMediator:initAnim()
	self._rightBtn:stopAllActions()
	self._leftBtn:stopAllActions()

	local fadeIn = cc.FadeIn:create(0.4)
	local scaleTo1 = cc.ScaleTo:create(0.4, 1.2)
	local spawn = cc.Spawn:create(fadeIn, scaleTo1)
	local easeInOut = cc.EaseInOut:create(spawn, 1)
	local scaleTo2 = cc.ScaleTo:create(0.4, 1)
	local fadeout = cc.FadeOut:create(0.4)
	local spawn1 = cc.Spawn:create(fadeout, scaleTo2)
	local easeInOut1 = cc.EaseInOut:create(spawn1, 1)
	local action = cc.Sequence:create(easeInOut, easeInOut1)
	local action2 = action:clone()

	self._rightBtn:runAction(cc.RepeatForever:create(action))
	self._leftBtn:runAction(cc.RepeatForever:create(action2))
	self._bg:removeAllChildren()

	local bgAnim = cc.MovieClip:create("BG_an_bumengguanzhujiemian")

	bgAnim:setPosition(cc.p(568, 320))
	bgAnim:addTo(self._bg):offset(0, 0)
	self._animNode:removeAllChildren()

	local animName = "ruchang_bumengguanzhujiemian"
	local anim = cc.MovieClip:create(animName)

	anim:setPosition(cc.p(0, 0))
	anim:addTo(self._animNode):offset(0, 0)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
	end)

	local topInfoNode = self:getView():getChildByFullName("main.topinfo")
	local initX, initY = topInfoNode:getPosition()

	topInfoNode:setOpacity(0)
	topInfoNode:setPositionY(initY + 50)
	anim:addCallbackAtFrame(1, function(cid, mc)
		local fadeIn = cc.FadeIn:create(0.15)
		local moveTo = cc.MoveTo:create(0.15, cc.p(initX, initY))
		local spawn = cc.Spawn:create(fadeIn, moveTo)

		topInfoNode:runAction(spawn)
	end)
	self._bg:setScale(1.1)
	self._bg:setOpacity(20)
	anim:addCallbackAtFrame(1, function(cid, mc)
		local fadeIn = cc.FadeIn:create(0.15)
		local scaleTo = cc.ScaleTo:create(2, 1)
		local spawn = cc.Spawn:create(fadeIn, scaleTo)

		self._bg:runAction(cc.EaseInOut:create(spawn, 1))
	end)

	local detailBg = self:getView():getChildByFullName("main.detailBg")

	detailBg:setVisible(false)
	detailBg:setScaleX(0.6)
	detailBg:setScaleY(0.4)
	anim:addCallbackAtFrame(30, function(cid, mc)
		detailBg:setVisible(true)

		local scaleTo1 = cc.ScaleTo:create(0.1, 1.05)
		local easeInOut = cc.EaseInOut:create(scaleTo1, 1)
		local scaleTo2 = cc.ScaleTo:create(0.1, 1)
		local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

		detailBg:runAction(cc.Sequence:create(easeInOut, easeInOut1))
	end)

	local winSize = cc.Director:getInstance():getWinSize()
	local offsetY = math.max(0, (winSize.height - 640) * 0.5)
	local diImg = anim:getChildByName("bottomdi")

	for i = 33, 38 do
		anim:addCallbackAtFrame(i, function()
			diImg:offset(0, -offsetY)
		end)
	end

	local detailPanel = self:getView():getChildByFullName("main.detailPanel")

	detailPanel:setVisible(false)
	detailPanel:setScaleX(0.6)
	detailPanel:setScaleY(0.4)
	anim:addCallbackAtFrame(35, function(cid, mc)
		detailPanel:setVisible(true)

		local scaleTo1 = cc.ScaleTo:create(0.1, 1.05)
		local easeInOut = cc.EaseInOut:create(scaleTo1, 1)
		local scaleTo2 = cc.ScaleTo:create(0.1, 1)
		local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

		detailPanel:runAction(cc.Sequence:create(easeInOut, easeInOut1))
	end)

	local enterBtn = self._main:getChildByFullName("enterBtn")

	enterBtn:setVisible(false)
	enterBtn:setScale(0.5)
	anim:addCallbackAtFrame(36, function(cid, mc)
		enterBtn:setVisible(true)

		local scaleTo1 = cc.ScaleTo:create(0.1, 1.1)
		local easeInOut = cc.EaseInOut:create(scaleTo1, 1)
		local scaleTo2 = cc.ScaleTo:create(0.1, 1)
		local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

		enterBtn:runAction(cc.Sequence:create(easeInOut, easeInOut1))
	end)
	self._pointNode:setScale(0.5)
	self._pointNode:setOpacity(20)
	anim:addCallbackAtFrame(30, function(cid, mc)
		local fadeIn = cc.FadeIn:create(0.15)
		local scaleTo = cc.ScaleTo:create(0.15, 1.1)
		local spawn = cc.Spawn:create(fadeIn, scaleTo)
		local easeInOut = cc.EaseInOut:create(spawn, 1)
		local scaleTo2 = cc.ScaleTo:create(0.1, 1)
		local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

		self._pointNode:runAction(cc.Sequence:create(easeInOut, easeInOut1))
	end)

	for i = 1, self._infoListNum do
		local cell = self._scrollView:getChildByTag(tostring(i))

		anim:addCallbackAtFrame(4 + (i - 1) * 3, function(cid, mc)
			if cell and cell.playShow then
				cell.playShow()
			end
		end)
	end

	anim:addCallbackAtFrame(28, function(cid, mc)
		self:pointChoose(function()
			local cell = self._scrollView:getChildByTag(tostring(self._curIndex))

			if cell and cell.playChoose then
				cell.playChoose()
			end
		end)
	end)
end

function DreamHouseMainMediator:onClickLeft()
	if self._curPage <= 1 then
		return
	end

	self:scrollToCurIndex(self._curPage - 1)
end

function DreamHouseMainMediator:onClickRight()
	if self._curPage >= self._pointPageNum then
		return
	end

	self:scrollToCurIndex(self._curPage + 1)
end

function DreamHouseMainMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function DreamHouseMainMediator:onClickInfoBtn()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "DreamHouse_Rule", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end

function DreamHouseMainMediator:onPointChoose(idx)
	if self._curIndex == idx then
		return
	end

	self._main:getChildByFullName("mask"):setVisible(true)

	local cell = self._scrollView:getChildByTag(tostring(self._curIndex))

	if cell and cell.playCancle then
		cell.playCancle()
	end

	self._curIndex = idx

	local cell = self._scrollView:getChildByTag(tostring(self._curIndex))

	if cell and cell.playChoose then
		cell.playChoose()
	end

	local mapId = self._houseMaps[self._curIndex]
	local mapData = self._houseSystem:getMapById(mapId)

	if mapData and not mapData:isLock() and not self._house:isMapRewardGet(mapId) then
		self._main:getChildByFullName("mask2"):setVisible(true)
		self._houseSystem:requestMapReward(mapId, function(response)
			if response.resCode == GS_SUCCESS then
				if DisposableObject:isDisposed(self) then
					return
				end

				local rewards = response.data.rewards
				local cell = self._scrollView:getChildByTag(self._curIndex)
				local lockAnim = cell:getChildByFullName("mapView.lockAnim")

				lockAnim:removeAllChildren()

				local anim = cc.MovieClip:create("kaisuo_TX_bumengguanzhujiemian")

				anim:setPosition(cc.p(24, 21.5))
				anim:addTo(lockAnim):offset(0, 0)
				anim:addEndCallback(function(cid, mc)
					mc:stop()

					if rewards then
						local view = self:getInjector():getInstance("getRewardView")

						self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
							maskOpacity = 0
						}, {
							title = Strings:get("DreamHouse_Main_UI27"),
							title1 = Strings:get("DreamHouse_Main_EN"),
							rewards = rewards
						}))
					end

					self._main:getChildByFullName("mask2"):setVisible(false)
					self:refreshInfoUI(self._scrollView:getChildByTag(self._curIndex), self._curIndex)
					self:refreshView()
				end)
			end
		end)
	else
		self:refreshView()
	end
end

function DreamHouseMainMediator:pointChoose(callback)
	local mapId = self._houseMaps[self._curIndex]
	local mapData = self._houseSystem:getMapById(mapId)

	if mapData and not mapData:isLock() and not self._house:isMapRewardGet(mapId) then
		self._houseSystem:requestMapReward(mapId, function(response)
			if response.resCode == GS_SUCCESS then
				if DisposableObject:isDisposed(self) then
					return
				end

				local rewards = response.data.rewards

				if rewards then
					local view = self:getInjector():getInstance("getRewardView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						maskOpacity = 0
					}, {
						title = Strings:get("DreamHouse_Main_UI27"),
						title1 = Strings:get("DreamHouse_Main_EN"),
						rewards = rewards
					}))
				end

				self:refreshInfoUI(self._scrollView:getChildByTag(self._curIndex), self._curIndex)
				self:refreshView()
				callback()
			end
		end)
	else
		self:refreshView()
		callback()
	end
end

function DreamHouseMainMediator:onPointClick()
	local mapId = self._houseMaps[self._curIndex]
	local mapData = self._houseSystem:getMapById(mapId)

	if mapData and not mapData:isLock() and not self._house:isMapRewardGet(mapId) then
		self._houseSystem:requestMapReward(mapId, function(response)
			if response.resCode == GS_SUCCESS then
				if DisposableObject:isDisposed(self) then
					return
				end

				local rewards = response.data.rewards

				if rewards then
					local view = self:getInjector():getInstance("getRewardView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						maskOpacity = 0
					}, {
						title = Strings:get("DreamHouse_Main_UI27"),
						title1 = Strings:get("DreamHouse_Main_EN"),
						rewards = rewards
					}))
				end

				self:refreshInfoUI(self._scrollView:getChildByTag(self._curIndex), self._curIndex)
				self:refreshView()
			end
		end)
	elseif mapData:isLock() then
		local heroIds = mapData:getMapConfig().HeroId
		local heroStr = ""

		for i = 1, #heroIds do
			local heroId = heroIds[i]

			if not self._heroSystem:hasHero(heroId) then
				heroStr = heroStr .. Strings:get(ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Name")) .. " "
			end
		end

		if heroStr and heroStr ~= "" then
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("DreamHouse_Main_UI22", {
					hero = heroStr
				})
			}))

			return
		end
	else
		self._houseSystem:enterDreamHouseDetail(self._houseMaps[self._curIndex])
	end
end

function DreamHouseMainMediator:refreshRedPoint()
	self:refreshInfoUI(self._scrollView:getChildByTag(self._curIndex), self._curIndex)
end

function DreamHouseMainMediator:refreshHouseMain()
	self:setupUI()
	self:setupListPoint()
	self:initAnim()
end
