-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/DebugShowBustAni.lua

DebugShowBustAni = class("DebugShowBustAni", DebugViewTemplate, _M)

function DebugShowBustAni:initialize()
	self._viewConfig = {
		{
			default = "Model_Master_XueZhan",
			name = "modelId",
			title = "英魂id",
			type = "Input"
		},
		{
			default = "bustframe11",
			name = "frameId",
			title = "框id",
			type = "Input"
		},
		{
			default = "0",
			name = "useAnim",
			title = "0静态 1动态",
			type = "Input"
		}
	}
end

function DebugShowBustAni:onClick(data)
	self:createBustAnim(data)
end

function DebugShowBustAni:createBustAnim(data)
	local winSize = cc.Director:getInstance():getWinSize()

	self._parent = cc.Director:getInstance():getRunningScene()
	self._mainPanel = ccui.Layout:create()

	self._mainPanel:setContentSize(cc.size(winSize.width, winSize.height))
	self._mainPanel:setTouchEnabled(true)
	self._parent:addChild(self._mainPanel, 999999)

	if self._mainPanel then
		self._mainPanel:setBackGroundColorType(1)
		self._mainPanel:setBackGroundColor(cc.c3b(200, 0, 0))
		self._mainPanel:setBackGroundColorOpacity(180)
	end

	local closeBtn = ccui.Button:create(DebugBoxTool:getResPath("pic_dm_debug_ok_normal.png"), DebugBoxTool:getResPath("pic_dm_debug_ok_press.png"), "")

	closeBtn:setName("closeBtn")
	closeBtn:setScale(2)
	self._mainPanel:addChild(closeBtn, 0)
	closeBtn:setPosition(winSize.width - 100, winSize.height - 100)
	closeBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._mainPanel:removeFromParent(true)
		end
	end)

	local info = {
		id = data.modelId,
		frameId = data.frameId,
		useAnim = data.useAnim == "1" and true or false
	}
	local heroIcon = IconFactory:createRoleIconSpriteNew(info)

	if data.frameId == "bustframe9" then
		heroIcon:addTo(self._mainPanel)
		heroIcon:setPosition(cc.p(442, 191))
	elseif data.frameId == "bustframe17" then
		heroIcon:addTo(self._mainPanel)
		heroIcon:setPosition(cc.p(260, 80))
	else
		heroIcon:addTo(self._mainPanel)
		heroIcon:center(self._mainPanel:getContentSize())
	end

	heroIcon:setLocalZOrder(2)

	local layout = ccui.Layout:create()

	layout:setContentSize(cc.size(heroIcon:getContentSize().width, heroIcon:getContentSize().height))
	self._mainPanel:addChild(layout)
	layout:setAnchorPoint(cc.p(0.5, 0.5))
	layout:setPosition(heroIcon:getPosition())
	layout:setBackGroundColorType(1)
	layout:setBackGroundColor(cc.c3b(200, 200, 0))
	layout:setBackGroundColorOpacity(255)
	layout:setLocalZOrder(0)
end

DebugShowBustAniMaster = class("DebugShowBustAniMaster", DebugViewTemplate, _M)

function DebugShowBustAniMaster:initialize()
	self._opType = 402
	self._viewConfig = {
		{
			default = "Model_Master_XueZhan",
			name = "modelId",
			title = "英魂id",
			type = "Input"
		}
	}
end

function DebugShowBustAniMaster:onClick(data)
	local view = self:getInjector():getInstance("DebugBustShowView2")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		flag = 1,
		id = data.modelId
	}))
end

DebugShowBustAniHero = class("DebugShowBustAniHero", DebugViewTemplate, _M)

function DebugShowBustAniHero:initialize()
	self._opType = 402
	self._viewConfig = {
		{
			default = "Model_ZTXChang",
			name = "modelId",
			title = "英魂id",
			type = "Input"
		}
	}
end

function DebugShowBustAniHero:onClick(data)
	local view = self:getInjector():getInstance("DebugBustShowView2")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		flag = 2,
		id = data.modelId
	}))
end

DebugShowBustAniAll = class("DebugShowBustAniAll", DebugViewTemplate, _M)

function DebugShowBustAniAll:initialize()
	self._opType = 402
	self._viewConfig = {
		{
			default = "Model_Master_XueZhan",
			name = "modelId",
			title = "英魂id",
			type = "Input"
		}
	}
end

function DebugShowBustAniAll:onClick(data)
	local view = self:getInjector():getInstance("DebugBustShowView2")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		flag = 3,
		id = data.modelId
	}))
end

DebugShowBustAniSpe = class("DebugShowBustAniSpe", DebugViewTemplate, _M)

function DebugShowBustAniSpe:initialize()
	self._opType = 402
	self._viewConfig = {
		{
			default = "Model_ZTXChang",
			name = "modelId",
			title = "英魂id",
			type = "Input"
		}
	}
end

function DebugShowBustAniSpe:onClick(data)
	local view = self:getInjector():getInstance("DebugBustShowView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		id = data.modelId
	}))
end

DebugShowBustAniNoStencil = class("DebugShowBustAniNoStencil", DebugViewTemplate, _M)

function DebugShowBustAniNoStencil:initialize()
	self._opType = 402
	self._viewConfig = {
		{
			default = "Model_Master_XueZhan",
			name = "modelId",
			title = "英魂id",
			type = "Input"
		}
	}
end

function DebugShowBustAniNoStencil:onClick(data)
	local view = self:getInjector():getInstance("DebugBustShowView3")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		flag = 1,
		id = data.modelId
	}))
end

DebugShowBustAniNoStencil2 = class("DebugShowBustAniNoStencil2", DebugViewTemplate, _M)

function DebugShowBustAniNoStencil2:initialize()
	self._opType = 402
	self._viewConfig = {
		{
			default = "Model_ZTXChang",
			name = "modelId",
			title = "英魂id",
			type = "Input"
		}
	}
end

function DebugShowBustAniNoStencil2:onClick(data)
	local view = self:getInjector():getInstance("DebugBustShowView3")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		flag = 3,
		id = data.modelId
	}))
end

DebugShowBustAniNoStencil3 = class("DebugShowBustAniNoStencil3", DebugViewTemplate, _M)

function DebugShowBustAniNoStencil3:initialize()
	self._opType = 402
	self._viewConfig = {
		{
			default = "Model_BBLMa_UnAwake",
			name = "modelId",
			title = "英魂id",
			type = "Input"
		}
	}
end

function DebugShowBustAniNoStencil3:onClick(data)
	local view = self:getInjector():getInstance("DebugBustUnAwake")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		flag = 1,
		id = data.modelId
	}))
end
