-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreTinyMapMediator.lua

ExploreTinyMapMediator = class("ExploreTinyMapMediator", DmPopupViewMediator, _M)

ExploreTinyMapMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreTinyMapMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function ExploreTinyMapMediator:initialize()
	super.initialize(self)
end

function ExploreTinyMapMediator:dispose()
	super.dispose(self)
end

function ExploreTinyMapMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TINY_MAP_REFRESH, self, self.updateView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_MOVE_SUCC, self, self.updateViewByEvent)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ExploreTinyMapMediator:enterWithData(data)
	self:initData(data)
	self:setupView()
	self:initView()
end

function ExploreTinyMapMediator:initData(data)
	self._pointId = data.id
	self._pointData = self._exploreSystem:getMapPointObjById(self._pointId)
	self._exploreData = self._developSystem:getPlayer():getExplore()
	self._currentMapInfo = self._exploreData:getPointMap()[self._exploreData:getCurPointId()]
	self._exploreObjects = self._currentMapInfo:getMapObjects()

	self:updateData()
end

function ExploreTinyMapMediator:setupView()
	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = self._pointData:getName(),
		title1 = Strings:get("UITitle_EN_MAPNAME"),
		bgSize = {
			width = 837,
			height = 503
		}
	})
	self._mainPanel = self:getView():getChildByName("main")
	self._scrollView = self._mainPanel:getChildByName("scrollView")

	self._scrollView:setScrollBarEnabled(false)

	self._mapPanel = self._scrollView:getChildByName("mapPanel")

	self._mapPanel:setLocalZOrder(1)
end

function ExploreTinyMapMediator:updateData()
	self._exploreObjects = self._currentMapInfo:getMapObjects()

	local posX, posY = self._currentMapInfo:getX(), self._currentMapInfo:getY()

	self._mapPic = self._pointData:getMapPic()
	self._offset = {
		maxY = 0,
		maxX = 0,
		minY = 0,
		minX = 0
	}
	self._mapPicAction = self._pointData:getMapPicAction()

	local curPos = {
		x = posX,
		y = posY
	}

	for mapPic, value in pairs(self._mapPicAction) do
		local triggerRect = self._exploreSystem:getRectByGrid({
			x = 0,
			y = 0
		}, value)
		local inRect = self._exploreSystem:checkPointInTargetRectByGrid(curPos, triggerRect)

		if inRect then
			self._mapPic = mapPic
			self._offset = {
				minX = triggerRect.minX * 2,
				minY = triggerRect.minY * 2,
				maxX = triggerRect.maxX * 2,
				maxY = triggerRect.maxY * 2
			}

			break
		end
	end
end

function ExploreTinyMapMediator:updateView()
	self:updateData()
	self:initView()
end

function ExploreTinyMapMediator:updateViewByEvent(event)
	local pos = event:getData().pos

	self:updateData()
	self:initView(pos)
end

function ExploreTinyMapMediator:initView(pos)
	self._mapPanel:removeAllChildren()

	local bg = ccui.ImageView:create("asset/scene/" .. self._mapPic .. ".jpg")

	bg:addTo(self._mapPanel)
	bg:setAnchorPoint(cc.p(0, 0))

	local size = bg:getContentSize()

	self._scrollView:setInnerContainerSize(cc.size(size.width, size.height))

	local playerImg = ccui.ImageView:create("ts_bg_ditu_ziji.png", 1)

	playerImg:addTo(self._mapPanel)

	local posX, posY = self._currentMapInfo:getX() * 2, 1920 - self._currentMapInfo:getY() * 2

	if pos then
		posY = 1920 - pos.y * 2
		posX = pos.x * 2
	end

	playerImg:setPosition(cc.p(posX, posY))
	playerImg:setLocalZOrder(9999)

	for i, v in pairs(self._exploreObjects) do
		local imgPath = v:getConfigByKey("MapTipsPic")

		if imgPath and imgPath ~= "" then
			local icon = ccui.ImageView:create(imgPath .. ".png", 1)

			icon:addTo(self._mapPanel)
			icon:setAnchorPoint(cc.p(0.5, 0))

			local x = v:getX() * 2
			local y = v:getY() * 2

			icon:setPosition(cc.p(x, 1920 - y))
		end
	end

	bg:setPosition(cc.p(self._offset.minX, 1920 - (self._offset.minY + size.height)))

	local positionY = 1920 - (self._offset.minY + size.height)

	self._mapPanel:setPosition(cc.p(-self._offset.minX, -positionY))

	local scrollViewSize = self._scrollView:getContentSize()
	local showMidPoint = cc.p(scrollViewSize.width / 2, size.height - scrollViewSize.height / 2)

	self._scrollView:setInnerContainerPosition(cc.p(-((posX - self._offset.minX - showMidPoint.x > 0 or nil) and math.min(posX - self._offset.minX - showMidPoint.x, size.width - scrollViewSize.width)), (posY - positionY - showMidPoint.y < 0 or nil) and scrollViewSize.height - size.height + math.min(showMidPoint.y - posY + positionY, size.height - scrollViewSize.height)))
end

function ExploreTinyMapMediator:onClickBack()
	self:close()
end
