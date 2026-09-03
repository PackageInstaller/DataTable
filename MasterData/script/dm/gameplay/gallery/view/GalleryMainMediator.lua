-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryMainMediator.lua

GalleryMainMediator = class("GalleryMainMediator", DmAreaViewMediator, _M)

GalleryMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryMainMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")
GalleryMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kTabBtnsViews = {
	"GalleryPartnerView",
	"BagURMapView",
	"GalleryMemoryView",
	"GalleryLegendView",
	"GalleryAlbumView"
}
local kTabBtnsLock = {
	nil,
	"URMap_Unlock",
	"Memory",
	"HerosLegend",
	"Photo"
}
local kTabSwitch = {
	nil,
	"fn_gallery_URMap",
	"fn_gallery_legend",
	"fn_gallery_huiyi",
	"fn_gallery_zhaopian"
}
local TitleString = {
	{
		Strings:get("GALLERY_UI1"),
		Strings:get("UITitle_EN_Huoban")
	},
	{
		Strings:get("URMaps_Name"),
		Strings:get("URMaps_Name_EN")
	},
	{
		Strings:get("GALLERY_UI2"),
		Strings:get("UITitle_EN_Huiyi")
	},
	{
		Strings:get("Gallery_Legend_UI1"),
		Strings:get("Gallery_Legend_UI1_En")
	},
	{
		Strings:get("GALLERY_UI3"),
		Strings:get("UITitle_EN_Zhaopian")
	}
}
local kBtnHandlers = {}

function GalleryMainMediator:initialize()
	super.initialize(self)
end

function GalleryMainMediator:dispose()
	super.dispose(self)
end

function GalleryMainMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROCOMPOSE_SUCC, self, self.refreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GALLERY_BOX_GET_SUCC, self, self.refreshRedPoint)

	self._bagSystem = self._developSystem:getBagSystem()
end

function GalleryMainMediator:enterWithData(data)
	self:initData(data)
	self:initWidgetInfo()
	self:createTabView()
	self:initViews()
	self:resetViews()
	self:setupTopInfoWidget()
end

function GalleryMainMediator:resumeWithData()
	self:refreshRedPoint()

	for i, view in pairs(self._cacheViews) do
		if i == self._tabType and view and view.mediator then
			view.mediator:resumeWithData()
		end
	end
end

function GalleryMainMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._tabpanel = self._main:getChildByName("tabpanel")

	self:ignoreSafeArea()
end

function GalleryMainMediator:ignoreSafeArea()
	local titleImage = self._main:getChildByFullName("titleImage")

	AdjustUtils.ignorSafeAreaRectForNode(titleImage, AdjustUtils.kAdjustType.Left)
end

function GalleryMainMediator:initData(data)
	if data and data.tabType then
		self._tabType = data.tabType or 1
	end

	self._cacheViews = {}
	self._cacheViewsName = {}
end

function GalleryMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function GalleryMainMediator:checkTabIsLock(tab)
	local result, tip = true, ""

	if kTabBtnsLock[tab] then
		result, tip = self._systemKeeper:isUnlock(kTabBtnsLock[tab])
	end

	return result, tip
end

function GalleryMainMediator:createTabView()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local redPointData = {
		function()
			return self._gallerySystem:checkcanReceive() or self._gallerySystem:checkCanGetHeroReward()
		end,
		function()
			return self._bagSystem:getURMapRedPoint()
		end,
		function()
			return self._gallerySystem:checkNewMemory(GalleryMemoryType.ACTIVI) or self._gallerySystem:checkNewMemory(GalleryMemoryType.HERO) or self._gallerySystem:checkNewMemory(GalleryMemoryType.STORY)
		end,
		function()
			return false
		end,
		function()
			return false
		end
	}
	local data = {}

	for i = 1, #TitleString do
		if not kTabSwitch[i] or CommonUtils.GetSwitch(kTabSwitch[i]) then
			local unlock, tip = self:checkTabIsLock(i)

			data[#data + 1] = {
				tabText = TitleString[i][1],
				tabTextTranslate = TitleString[i][2],
				redPointFunc = redPointData[i],
				lock = not unlock
			}
			self._cacheViewsName[#self._cacheViewsName + 1] = kTabBtnsViews[i]
		end
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	local winSize = cc.Director:getInstance():getWinSize()

	self._tabBtnWidget:adjustScrollViewSize(0, winSize.height)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._tabType)
	self._tabBtnWidget:removeTabBg()

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, 0)
	view:setLocalZOrder(1100)
end

function GalleryMainMediator:initViews()
	local viewName = self._cacheViewsName[self._tabType]

	if not self._cacheViews[self._tabType] and viewName then
		local view = self:getInjector():getInstance(viewName)

		if view then
			view:addTo(self._main)
			AdjustUtils.adjustLayoutUIByRootNode(view)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator

				mediator:setupView({})
			end

			self._cacheViews[self._tabType] = view
		end
	end
end

function GalleryMainMediator:resetViews()
	self:initViews()

	for i, view in pairs(self._cacheViews) do
		view:setVisible(self._tabType == i)

		if view:isVisible() then
			view.mediator:runStartAnim()
		end
	end
end

function GalleryMainMediator:onClickBack()
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function GalleryMainMediator:onClickTab(name, tag)
	local unlock, tip = self:checkTabIsLock(tag)

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = tip
		}))

		return
	end

	self._tabType = tag

	self:resetViews()
end

function GalleryMainMediator:refreshRedPoint(event)
	self._tabBtnWidget:refreshAllRedPoint()
end
