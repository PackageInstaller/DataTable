-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryBookMediator.lua

GalleryBookMediator = class("GalleryBookMediator", DmAreaViewMediator, _M)

GalleryBookMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryBookMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
GalleryBookMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")
GalleryBookMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")

local kBtnHandlers = {}
local animNames = {
	{
		animName = "JQHG_XZ_tujianzhurukouxuanzhong",
		kTabSwitch = "fn_gallery_huiyi",
		kTabBtnsLock = "Memory",
		viewName = "GalleryMemoryView",
		mc_title = "mc_name1",
		pos = cc.p(-680, -204),
		title = Strings:get("GALLERY_UI2"),
		titleOffset = {
			20,
			0
		}
	},
	{
		animName = "GWTJ_XZ_tujianzhurukouxuanzhong",
		kTabSwitch = "fn_gallery_zhaopian",
		kTabBtnsLock = "Info_Unlock",
		viewName = "GalleryMessageView",
		mc_title = "mc_name2",
		pos = cc.p(-565, 122),
		title = Strings:get("Info_UI01"),
		titleOffset = {
			20,
			0
		}
	},
	{
		animName = "SMG_XZ_tujianzhurukouxuanzhong",
		kTabSwitch = "fn_gallery_URMap",
		kTabBtnsLock = "URMap_Unlock",
		viewName = "BagURMapView",
		mc_title = "mc_name5",
		pos = cc.p(-343, -98),
		title = Strings:get("URMaps_Name"),
		titleOffset = {
			0,
			0
		}
	},
	{
		animName = "HBDA_XZ_tujianzhurukouxuanzhong",
		viewName = "GalleryPartnerNewView",
		mc_title = "mc_name4",
		pos = cc.p(100, -268),
		title = Strings:get("GALLERY_UI1"),
		titleOffset = {
			0,
			0
		}
	},
	{
		animName = "JQQD_XZ_tujianzhurukouxuanzhong",
		kTabSwitch = "fn_gallery_legend",
		kTabBtnsLock = "HerosLegend",
		viewName = "GalleryLegendView",
		mc_title = "mc_name3",
		pos = cc.p(300, -108),
		title = Strings:get("Gallery_Legend_UI1"),
		titleOffset = {
			0,
			0
		}
	}
}

function GalleryBookMediator:initialize()
	super.initialize(self)
end

function GalleryBookMediator:dispose()
	super.dispose(self)
end

function GalleryBookMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	self._bagSystem = self._developSystem:getBagSystem()
end

function GalleryBookMediator:mapEventListeners()
	return
end

function GalleryBookMediator:enterWithData(data)
	self._data = data

	self:initWidgetInfo()
	self:initData()
	self:setupView()
	self:setupTopInfoWidget()
	self:refreshRedPoint()
end

function GalleryBookMediator:resumeWithData()
	self._canclick = true

	for i, anim in ipairs(self._anims) do
		anim:gotoAndStop(11)
	end

	self:refreshRedPoint()
end

function GalleryBookMediator:refreshRedPoint()
	self._redPointFuc = self._redPointFuc or {
		function()
			return self._gallerySystem:checkNewMemory(GalleryMemoryType.ACTIVI) or self._gallerySystem:checkNewMemory(GalleryMemoryType.HERO) or self._gallerySystem:checkNewMemory(GalleryMemoryType.STORY)
		end,
		function()
			return self._taskSystem:hasMessageTaskRedPoint() or self._gallerySystem:getUnlockStatus()
		end,
		function()
			return self._bagSystem:getURMapRedPoint()
		end,
		function()
			return self._gallerySystem:checkcanReceive() or self._gallerySystem:checkCanGetHeroReward()
		end,
		function()
			return false
		end
	}

	for i, v in ipairs(animNames) do
		local touchPanel = self._scrollView:getChildByFullName("touchPanel" .. i)
		local redpoint = touchPanel:getChildByFullName("redPoint")

		redpoint:setVisible(self._redPointFuc[i]())
	end
end

function GalleryBookMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		title = Strings:get("Home_Photo"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function GalleryBookMediator:initData()
	self._canclick = true
end

function GalleryBookMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._scrollView = self._main:getChildByFullName("ScrollView")
	self._textName = self._main:getChildByFullName("Text_128")

	AdjustUtils.adjustLayoutByType(self._scrollView, AdjustUtils.kAdjustType.StretchWidth + AdjustUtils.kAdjustType.StretchHeight)
	self._scrollView:setSwallowTouches(true)
	self._scrollView:setTouchEnabled(false)
	self._scrollView:setInnerContainerSize(cc.size(2568, 852))
	self._scrollView:setScrollBarEnabled(true)
	self._scrollView:setScrollBarAutoHideTime(9999)
	self._scrollView:setScrollBarColor(cc.c3b(255, 255, 255))
	self._scrollView:setScrollBarAutoHideEnabled(true)
	self._scrollView:setScrollBarWidth(5)
	self._scrollView:setScrollBarOpacity(125)
	self._scrollView:setScrollBarPositionFromCorner(cc.p(10, 15))

	self._nodeAnim = self._scrollView:getChildByFullName("Node_anim")
end

function GalleryBookMediator:setupView()
	self._nodeAnim:removeAllChildren()

	local bgAnim = cc.MovieClip:create("rchang_tujianzhurukouxuanzhong")

	bgAnim:setPosition(cc.p(1025, 494))
	bgAnim:addTo(self._nodeAnim)
	bgAnim:addEndCallback(function()
		bgAnim:stop()
		self:setupClickEnvs()
	end)

	local mc_bg = bgAnim:getChildByFullName("mc_bg")
	local background = ccui.ImageView:create("asset/scene/scene_main_exhibition.jpg")

	background:addTo(mc_bg)

	local isDrawLine = false

	self._anims = {}

	for i, v in ipairs(animNames) do
		local anim = cc.MovieClip:create(v.animName)

		anim:setPosition(v.pos)
		anim:addTo(mc_bg)
		anim:setLocalZOrder(20 - i)
		anim:addCallbackAtFrame(31, function(cid, mc)
			mc:stop()
		end)

		local tmc = bgAnim:getChildByFullName(v.mc_title)

		tmc:addCallbackAtFrame(20, function(cid, mc)
			mc:stop()
		end)
		anim:gotoAndStop(11)
		table.insert(self._anims, anim)

		local mc_title = tmc:getChildByFullName("mc_zi")
		local title1 = self._textName:clone()

		title1:setString(v.title)
		title1:addTo(mc_title):offset(-5 + v.titleOffset[1], 94 + v.titleOffset[2])

		local touchPanel = self._scrollView:getChildByFullName("touchPanel" .. i)

		if i == 1 then
			-- block empty
		elseif i == 2 then
			local vertices = {
				cc.p(-8, 30),
				cc.p(13, 101),
				cc.p(-32, 200),
				cc.p(51, 141),
				cc.p(89, 200),
				cc.p(196, 198),
				cc.p(236, 114),
				cc.p(244, 30),
				cc.p(176, 60)
			}
			local shape = ccui.HittingPolygon:create(vertices)

			touchPanel:setHittingShape(shape)

			if isDrawLine then
				local drawNode = cc.DrawNode:create()

				drawNode:drawPoly(vertices, #vertices, true, cc.c4f(0, 0, 1, 1))
				touchPanel:addChild(drawNode)
			end
		elseif i == 3 then
			-- block empty
		elseif i == 4 then
			local vertices = {
				cc.p(0, -46),
				cc.p(0, 287),
				cc.p(95, 355),
				cc.p(168, 246),
				cc.p(190, 125),
				cc.p(182, -46)
			}
			local shape = ccui.HittingPolygon:create(vertices)

			touchPanel:setHittingShape(shape)

			if isDrawLine then
				local drawNode = cc.DrawNode:create()

				drawNode:drawPoly(vertices, #vertices, true, cc.c4f(0, 0, 1, 1))
				touchPanel:addChild(drawNode)
			end
		elseif i == 5 then
			local vertices = {
				cc.p(0, 0),
				cc.p(0, 300),
				cc.p(261, 300),
				cc.p(261, 0)
			}
			local shape = ccui.HittingPolygon:create(vertices)

			touchPanel:setHittingShape(shape)

			if isDrawLine then
				local drawNode = cc.DrawNode:create()

				drawNode:drawPoly(vertices, #vertices, true, cc.c4f(0, 0, 1, 1))
				touchPanel:addChild(drawNode)
			end
		end

		touchPanel:addTouchEventListener(function(sender, eventType)
			self:onClickCell(sender, eventType, i)
		end)

		local touchTab = self._scrollView:getChildByFullName("touchPanel" .. i .. "_1")

		if touchTab then
			touchTab:addTouchEventListener(function(sender, eventType)
				self:onClickCell(sender, eventType, i)
			end)
		end
	end

	self._scrollView:setInnerContainerPosition(cc.p(-420, -70))
end

function GalleryBookMediator:onClickBack(sender, eventType)
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function GalleryBookMediator:onClickCell(sender, eventType, tag)
	if eventType == ccui.TouchEventType.began then
		-- block empty
	end

	if eventType == ccui.TouchEventType.ended then
		if animNames[tag].kTabSwitch and not CommonUtils.GetSwitch(animNames[tag].kTabSwitch) then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				tip = Strings:get("HEROS_UI14")
			}))

			return
		end

		local unlock, tip = self:checkTabIsLock(tag)

		if not unlock then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				tip = tip
			}))

			return
		end

		if not self._canclick then
			return
		end

		self._canclick = false

		local anim = self._anims[tag]

		anim:gotoAndPlay(12)
		anim:addCallbackAtFrame(25, function(cid, mc)
			local view = self:getInjector():getInstance(animNames[tag].viewName)
			local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {})

			self:dispatch(event)
		end)
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end
end

function GalleryBookMediator:checkTabIsLock(tab)
	local result, tip = true, ""

	if animNames[tab].kTabBtnsLock then
		result, tip = self._systemKeeper:isUnlock(animNames[tab].kTabBtnsLock)
	end

	return result, tip
end

function GalleryBookMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local panel = self._scrollView:getChildByFullName("touchPanel4")

	storyDirector:setClickEnv("GalleryBookMediator.touchPanel4", panel, function(sender, eventType)
		self:onClickCell(panel, ccui.TouchEventType.ended, 4)
	end)
	storyDirector:notifyWaiting("enter_GalleryBookMediator")
end
