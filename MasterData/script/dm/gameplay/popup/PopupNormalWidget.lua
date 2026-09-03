-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/PopupNormalWidget.lua

PopupBgSize = {}
PopupNormalTitle = class("PopupNormalTitle", BaseWidget)

function PopupNormalTitle:initialize(view, data)
	super.initialize(self, view)
	self:setupView(data)
end

function PopupNormalTitle:dispose()
	super.dispose(self)
end

function PopupNormalTitle:setupView(data)
	self._adjustTitleSize = data.adjustTitleSize or false

	local view = self:getView()

	self._titleText1 = view:getChildByFullName("Text_1")
	self._titleText2 = view:getChildByFullName("Text_2")
	self._titleText1PosY = self._titleText1:getPositionY()

	self:updateTitle(data)
end

function PopupNormalTitle:updateTitle(data)
	self._titleText1:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)

	if data.titleDimensions then
		self._titleText1:getVirtualRenderer():setDimensions(377, 88)

		if getCurrentLanguage() ~= GameLanguageType.CN then
			self._titleText1:getVirtualRenderer():setDimensions(data.titleDimensions[1], data.titleDimensions[2])
		end
	else
		self._titleText1:getVirtualRenderer():setDimensions(377, 88)
	end

	if data.title then
		self._titleText1:setString(data.title)
	end

	if data.fontSize then
		self._titleText1:setFontSize(data.fontSize)
	elseif getCurrentLanguage() ~= GameLanguageType.CN then
		self._titleText1:setFontSize(40)
	end

	if data.title1 then
		self._titleText2:setString(data.title1)

		local posX = self._titleText1:getPositionX()
		local width = self._titleText1:getAutoRenderSize().width

		self._titleText2:setAnchorPoint(cc.p(0.5, 0.5))
		self._titleText2:setPositionX(posX + width / 2)
	end
end

PopupNewTitle = class("PopupNewTitle", BaseWidget)

function PopupNewTitle:initialize(view, data)
	super.initialize(self, view)
	self:setupView(data)
end

function PopupNewTitle:dispose()
	super.dispose(self)
end

function PopupNewTitle:setupView(data)
	local view = self:getView()

	self._titleText1 = view:getChildByFullName("text1")
	self._titleText2 = view:getChildByFullName("text2")
	self._titleText3 = view:getChildByFullName("text3")

	self._titleText1:setString("")
	self._titleText2:setString("")
	self._titleText3:setString("")
	self:updateTitle(data)
end

function PopupNewTitle:updateTitle(data)
	if data.title then
		local length = utf8.len(data.title)
		local title1 = utf8.sub(data.title, 1, 1)
		local title2 = utf8.sub(data.title, 2, length)

		self._titleText1:setString(title1)
		self._titleText2:setString(title2)
	end

	if data.title1 then
		self._titleText3:setString(data.title1)

		local posX = self._titleText2:getPositionX()
		local width = self._titleText2:getContentSize().width

		self._titleText3:setPositionX(posX + width)
	end
end

PopupNormalWidget = class("PopupNormalWidget", BaseWidget)

function PopupNormalWidget:initialize(view, data)
	super.initialize(self, view)
	self:setupView(data)
end

function PopupNormalWidget:dispose()
	super.dispose(self)
end

function PopupNormalWidget:setupView(data)
	local view = self:getView()

	if data.bgSize then
		self:setContentSize(data.bgSize.width, data.bgSize.height)
	end

	local closeBtn = view:getChildByFullName("btn_close")

	closeBtn:setLocalZOrder(10)

	if data.btnHandler then
		closeBtn:setVisible(true)
		mapButtonHandlerClick(self, "btn_close", data.btnHandler)
	else
		closeBtn:setVisible(false)
	end

	if data.title then
		bindWidget(self, "title_node", PopupNormalTitle, data)
	end

	if data.ignoreBtnBg then
		local bg1 = view:getChildByFullName("Image_bg3")
		local bg2 = view:getChildByFullName("Image_bg4")

		bg1:setVisible(false)
		bg2:setVisible(false)
	end

	if data.ignoreWhiteBg then
		local bg1 = view:getChildByFullName("Image_bg2")

		bg1:setVisible(false)
	end

	if data.ignoreBg1 then
		local bg1 = view:getChildByFullName("Image_bg1")

		bg1:setVisible(false)
	end

	if data.ignoreTitleNodeBg then
		view:getChildByFullName("title_node.bg_hw"):setVisible(false)
	end

	if data.ignoreBg1 then
		view:getChildByFullName("Image_bg1"):setVisible(false)
	end

	if data.targetImg then
		local winSize = cc.Director:getInstance():getWinSize()

		view:getChildByFullName("Image_bg"):setVisible(false)

		local Image_bg1 = view:getChildByFullName("Image_bg1")
		local iconBg = ccui.ImageView:create(data.targetImg.Res)

		iconBg:setAnchorPoint(cc.p(0.5, 0.5))

		local nodePos = Image_bg1:getParent():convertToNodeSpace(cc.p(winSize.width / 2, winSize.height / 2))

		iconBg:addTo(Image_bg1:getParent()):posite(nodePos.x, nodePos.y)

		local titleNode = view:getChildByFullName("title_node")

		titleNode:setLocalZOrder(10)
	end

	if data.offsetForImage_bg3 then
		local bg1 = view:getChildByFullName("Image_bg3")

		bg1:setPositionX(bg1:getPositionX() + data.offsetForImage_bg3.diffX)
		bg1:setPositionY(bg1:getPositionY() + data.offsetForImage_bg3.diffY)
	end
end

function PopupNormalWidget:setContentSize(width, height)
	local view = self:getView()
	local closeBtn = view:getChildByFullName("btn_close")
	local titleNode = view:getChildByFullName("title_node")
	local bg = view:getChildByFullName("Image_bg")
	local bg1 = view:getChildByFullName("Image_bg1")
	local bg2 = view:getChildByFullName("Image_bg2")
	local bg3 = view:getChildByFullName("Image_bg3")
	local bg4 = view:getChildByFullName("Image_bg4")
	local bgSize = bg:getContentSize()

	width = width or bgSize.width
	height = height or bgSize.height

	local bg1Width = bgSize.width - bg1:getContentSize().width
	local bg1Height = bgSize.height - bg1:getContentSize().height

	bg1:setContentSize(cc.size(width - bg1Width, height - bg1Height))

	if bg2 then
		local bg2Width = bgSize.width - bg2:getContentSize().width
		local bg2Height = bg2:getContentSize().height

		bg2:setContentSize(cc.size(width - bg2Width, bg2Height))
	end

	if bg3 then
		local bg3PosY = bg3:getPositionY()

		bg3:setPosition(width / 2, bg3PosY)
	end

	if bg4 then
		local bg4Width = bgSize.width - bg4:getContentSize().width
		local bg4Height = bg4:getContentSize().height

		bg4:setContentSize(cc.size(width - bg4Width, bg4Height))
	end

	bg:setContentSize(cc.size(width, height))

	local btnOffsetX = bgSize.width - closeBtn:getPositionX()
	local btnOffsetY = bgSize.height - closeBtn:getPositionY()

	closeBtn:setPosition(width - btnOffsetX, height - btnOffsetY)

	local titleOffsetX = titleNode:getPositionX()
	local titleOffsetY = bgSize.height - titleNode:getPositionY()

	titleNode:setPosition(titleOffsetX, height - titleOffsetY)
end

function PopupNormalWidget:updateTitle(data)
	if self._titleWidget then
		self._titleWidget:updateTitle(data)
	end
end

PopupNewWidget = class("PopupNewWidget", BaseWidget)

function PopupNewWidget:initialize(view, data)
	super.initialize(self, view)
	self:setupView(data)
end

function PopupNewWidget:dispose()
	super.dispose(self)
end

function PopupNewWidget:setupView(data)
	local view = self:getView()

	if data.bgSize then
		self:setContentSize(data.bgSize.width, data.bgSize.height)
	end

	local closeBtn = view:getChildByFullName("btn_close")

	closeBtn:setLocalZOrder(10)

	if data.btnHandler then
		closeBtn:setVisible(true)
		mapButtonHandlerClick(self, "btn_close", data.btnHandler)
	else
		closeBtn:setVisible(false)
	end

	if data.title then
		bindWidget(self, "title_node", PopupNewTitle, data)
	end

	if data.ignoreBtnBg then
		local bg1 = view:getChildByFullName("Image_bg3")
		local bg2 = view:getChildByFullName("Image_bg4")

		bg1:setVisible(false)
		bg2:setVisible(false)
	end
end

function PopupNewWidget:setContentSize(width, height)
	local view = self:getView()
	local closeBtn = view:getChildByFullName("btn_close")
	local titleNode = view:getChildByFullName("title_node")
	local bg = view:getChildByFullName("Image_bg")
	local bg1 = view:getChildByFullName("Image_bg1")
	local bgSize = bg:getContentSize()

	width = width or bgSize.width
	height = height or bgSize.height

	local bg1Width = bgSize.width - bg1:getContentSize().width
	local bg1Height = bgSize.height - bg1:getContentSize().height

	bg1:setContentSize(cc.size(width - bg1Width, height - bg1Height))
	bg:setContentSize(cc.size(width, height))

	local btnOffsetX = bgSize.width - closeBtn:getPositionX()
	local btnOffsetY = bgSize.height - closeBtn:getPositionY()

	closeBtn:setPosition(width - btnOffsetX, height - btnOffsetY)

	local titleOffsetX = titleNode:getPositionX()
	local titleOffsetY = bgSize.height - titleNode:getPositionY()

	titleNode:setPosition(titleOffsetX, height - titleOffsetY)
end

function PopupNewWidget:updateTitle(data)
	if self._titleWidget then
		self._titleWidget:updateTitle(data)
	end
end

PopupNormalTabWidget = class("PopupNormalTabWidget", BaseWidget)

function PopupNormalTabWidget:initialize(view, data)
	super.initialize(self, view)
	self:setupView(data)
end

function PopupNormalTabWidget:dispose()
	super.dispose(self)
end

function PopupNormalTabWidget:setupView(data)
	data.adjustTitleSize = true

	local view = self:getView()

	if data.bgSize then
		self:setContentSize(data.bgSize.width, data.bgSize.height)
	end

	local closeBtn = view:getChildByFullName("btn_close")

	closeBtn:setLocalZOrder(10)

	if data.btnHandler then
		closeBtn:setVisible(true)
		mapButtonHandlerClick(self, "btn_close", data.btnHandler)
	else
		closeBtn:setVisible(false)
	end

	if data.title then
		self._titleWidget = bindWidget(self, "title_node", PopupNormalTitle, data)
	end
end

function PopupNormalTabWidget:setContentSize(width, height)
	local view = self:getView()
	local closeBtn = view:getChildByFullName("btn_close")
	local titleNode = view:getChildByFullName("title_node")
	local bg = view:getChildByFullName("Image_bg")
	local bg1 = view:getChildByFullName("Image_bg1")
	local bg2 = view:getChildByFullName("Image_bg2")
	local bg3 = view:getChildByFullName("Image_bg3")
	local bgSize = bg:getContentSize()

	width = width or bgSize.width
	height = height or bgSize.height

	local bg1Width = bg1:getContentSize().width
	local bg1Height = bgSize.height - bg1:getContentSize().height

	bg1:setContentSize(cc.size(bg1Width, height - bg1Height))

	local bg2Width = bgSize.width - bg2:getContentSize().width
	local bg2Height = bgSize.height - bg2:getContentSize().height

	bg2:setContentSize(cc.size(width - bg2Width, height - bg2Height))

	local bg3Width = bg3:getContentSize().width
	local bg3Height = bgSize.height - bg3:getContentSize().height

	bg3:setContentSize(cc.size(bg3Width, height - bg3Height))
	bg:setContentSize(cc.size(width, height))

	local btnOffsetX = bgSize.width - closeBtn:getPositionX()
	local btnOffsetY = bgSize.height - closeBtn:getPositionY()

	closeBtn:setPosition(width - btnOffsetX, height - btnOffsetY)

	local titleOffsetX = titleNode:getPositionX()
	local titleOffsetY = bgSize.height - titleNode:getPositionY()

	titleNode:setPosition(titleOffsetX, height - titleOffsetY)
end

function PopupNormalTabWidget:updateTitle(data)
	if self._titleWidget then
		self._titleWidget:updateTitle(data)
	end
end
