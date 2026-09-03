-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/PopupBgWidget.lua

TitleWidget = class("TitleWidget", BaseWidget, _M)

function TitleWidget.class:createWidgetNode()
	local resFile = "asset/ui/title.csb"

	return cc.CSLoader:createNode(resFile)
end

function TitleWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function TitleWidget:dispose()
	super.dispose(self)
end

function TitleWidget:initSubviews(view)
	self._titleText1 = view:getChildByFullName("Text_1")
end

function TitleWidget:updateView(config)
	if config.title then
		self._titleText1:setString(config.title)
	end
end

PopupMiddleBgWidget = class("PopupMiddleBgWidget", BaseWidget, _M)

function PopupMiddleBgWidget.class:createWidgetNode(resFile)
	resFile = resFile or "asset/ui/bg3.csb"

	return cc.CSLoader:createNode(resFile)
end

function PopupMiddleBgWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function PopupMiddleBgWidget:dispose()
	super.dispose(self)
end

function PopupMiddleBgWidget:initSubviews(view)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	self._closeBtn = view:getChildByFullName("btn_close")
	self._titleNode = view:getChildByFullName("title_node")
	self._bgImg = view:getChildByFullName("Image_bg")

	self._closeBtn:setLocalZOrder(3)

	if self._titleNode then
		self._titleNode:setVisible(false)
	end

	self._image2 = view:getChildByName("Image_2")

	if self._image2 then
		self._image2:setLocalZOrder(3)
	end
end

function PopupMiddleBgWidget:updateView(config)
	local view = self:getView()

	self._config = config

	if config.btnHandler then
		self._closeBtn:setVisible(true)

		local function onClickBack(sender, eventType)
			config.btnHandler(sender, eventType)
		end

		mapButtonHandlerClick(self, "btn_close", onClickBack)
	else
		self._closeBtn:setVisible(false)
	end

	if config.title then
		self._titleNode:setVisible(true)
		self._titleNode:setLocalZOrder(3)

		local injector = self:getInjector()
		local titleWidget = injector:injectInto(TitleWidget:new(self._titleNode))

		titleWidget:updateView(config)
		self:autoManageObject(titleWidget)

		self._titleWidget = titleWidget
	end

	if config.bgNew then
		if type(config.bgNew) == "string" then
			self._bgImg:loadTexture(config.bgNew)
		else
			self._bgImg:loadTexture("asset/ui/popup/bg_popup_light_middle.png")
			self._bgImg:setContentSize(cc.size(752, 568))
			self._bgImg:setScale9Enabled(true)
			self._bgImg:setCapInsets(cc.rect(200, 100, 352, 65))
		end
	else
		self._bgImg:loadTexture("asset/scene/bg_common_dib05.png")
	end
end

function PopupMiddleBgWidget:playAnim()
	do return end

	local view = self:getView()

	if not self._config.showAnim then
		if self._config.title then
			self._titleWidget:showStaticDi()
		end

		if self._config.bgNew then
			local tiaoAnim = cc.MovieClip:create("tiaowen_zhongtanchuang")

			tiaoAnim:addTo(view, 2):posite(570, 330):offset(201.8, 180.85)
			tiaoAnim:gotoAndStop(tiaoAnim:getTotalFrames())
		end

		return
	end

	local mainAnim = cc.MovieClip:create("main_zhongtanchuang")

	mainAnim:addTo(view, 2):posite(570, 330)
	mainAnim:addEndCallback(function()
		mainAnim:stop()
	end)

	local bgNode = mainAnim:getChildByName("bg")

	self._bgImg:removeFromParent(false)
	self._bgImg:addTo(bgNode):center(bgNode:getContentSize()):offset(-2, 7)

	local tiaoAnim = mainAnim:getChildByName("tiao")

	tiaoAnim:addEndCallback(function()
		tiaoAnim:stop()
	end)

	if self._config.btnHandler then
		local btnNode = mainAnim:getChildByName("btn")

		self._closeBtn:setVisible(true)
		self._closeBtn:removeFromParent(false)
		self._closeBtn:addTo(btnNode):center(btnNode:getContentSize())
	else
		self._closeBtn:setVisible(false)
	end

	if self._config.title then
		local titleAnim = cc.MovieClip:create("title_jiaobiao")

		titleAnim:addTo(view, 5):posite(self._titleNode:getPosition()):offset(10, -20)
		titleAnim:setVisible(false)
		titleAnim:addEndCallback(function()
			titleAnim:stop()
		end)

		local titleNode = titleAnim:getChildByName("title")

		self._titleNode:setVisible(true)
		self._titleNode:removeFromParent(false)
		self._titleNode:addTo(titleNode):center(titleNode:getContentSize())
		titleAnim:addCallbackAtFrame(5, function()
			self._titleWidget:playDiAnim()
		end)
		mainAnim:addCallbackAtFrame(2, function()
			titleAnim:setVisible(true)
			titleAnim:gotoAndPlay(1)
		end)
	end
end

function PopupMiddleBgWidget:setBgContentSize(height)
	self._bgImg:setContentSize(cc.size(752, height))

	if self._image2 then
		self._image2:offset(0, 568 - height)
	end
end

PopupSmallBgWidget = class("PopupSmallBgWidget", BaseWidget, _M)

function PopupSmallBgWidget.class:createWidgetNode(resFile)
	resFile = resFile or "asset/ui/bg2.csb"

	return cc.CSLoader:createNode(resFile)
end

function PopupSmallBgWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function PopupSmallBgWidget:dispose()
	super.dispose(self)
end

function PopupSmallBgWidget:initSubviews(view)
	AudioEngine:getInstance():playEffect("se_pop_common", false)

	self._closeBtn = view:getChildByFullName("btn_close")
	self._titleNode = view:getChildByFullName("title_node")
	self._titleText = view:getChildByFullName("Text_title")
	self._bgImg = view:getChildByFullName("Image_bg")

	self._bgImg:loadTexture("asset/scene/bg_common_dib04.png")
	self._bgImg:setLocalZOrder(1)
	self._closeBtn:setLocalZOrder(3)

	if self._titleNode then
		self._titleNode:setVisible(false)
	end

	local image2 = view:getChildByName("Image_2")

	if image2 then
		image2:setLocalZOrder(3)
	end
end

function PopupSmallBgWidget:updateView(config)
	self._config = config

	local view = self:getView()
	local closeBtn = view:getChildByFullName("btn_close")

	if config.btnHandler then
		closeBtn:setVisible(true)

		local function onClickBack(sender, eventType)
			config.btnHandler(sender, eventType)
		end

		mapButtonHandlerClick(self, "btn_close", onClickBack)
	else
		closeBtn:setVisible(false)
	end

	if config.title then
		if self._titleText then
			self._titleText:setLocalZOrder(3)
			self._titleText:setString(config.title or "")

			local lineGradiantVec2 = {
				{
					ratio = 0.2,
					color = cc.c4b(250, 169, 169, 255)
				},
				{
					ratio = 0.8,
					color = cc.c4b(255, 255, 255, 255)
				}
			}

			self._titleText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
				x = 0,
				y = 1
			}))
			setTextShadowOpacity(self._titleText, 0.75)
		end

		if self._titleNode then
			self._titleNode:setVisible(true)
			self._titleNode:setLocalZOrder(3)

			local injector = self:getInjector()
			local titleWidget = injector:injectInto(TitleWidget:new(self._titleNode))

			titleWidget:updateView(config)
			self:autoManageObject(titleWidget)

			self._titleWidget = titleWidget
		end
	end

	if config.bgNew then
		self._bgImg:loadTexture("asset/scene/s.png")
	end
end

function PopupSmallBgWidget:setBgContentSize(height)
	self._bgImg:setContentSize(cc.size(572, height))
end

function PopupSmallBgWidget:playAnim()
	do return end

	if not self._config.showAnim then
		return
	end

	local view = self:getView()
	local mainAnim = cc.MovieClip:create("main_xiaotanchuang")

	mainAnim:addTo(view, 2):posite(570, 325)
	mainAnim:addEndCallback(function()
		mainAnim:stop()
	end)

	local bgNode = mainAnim:getChildByName("bg")

	self._bgImg:removeFromParent(false)
	self._bgImg:addTo(bgNode):center(bgNode:getContentSize()):offset(-5, 0)

	local tiaoAnim = mainAnim:getChildByName("tiao")

	tiaoAnim:addEndCallback(function()
		tiaoAnim:stop()
	end)

	if self._config.btnHandler then
		local btnNode = mainAnim:getChildByName("btn")

		self._closeBtn:setVisible(true)
		self._closeBtn:removeFromParent(false)
		self._closeBtn:addTo(btnNode):center(btnNode:getContentSize())
	end

	if self._config.title and self._titleWidget then
		local titleAnim = cc.MovieClip:create("title_jiaobiao")

		titleAnim:addTo(view, 5):posite(self._titleNode:getPosition())
		titleAnim:addEndCallback(function()
			titleAnim:stop()
		end)

		local titleNode = titleAnim:getChildByName("title")

		self._titleNode:setVisible(true)
		self._titleNode:removeFromParent(false)
		self._titleNode:addTo(titleNode):center(titleNode:getContentSize())
		titleAnim:addCallbackAtFrame(5, function()
			self._titleWidget:playDiAnim()
		end)
		mainAnim:addCallbackAtFrame(2, function()
			titleAnim:setVisible(true)
			titleAnim:gotoAndPlay(1)
		end)
	end
end
