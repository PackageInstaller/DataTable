-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/view/GalleryMemoryInfoMediator.lua

GalleryMemoryInfoMediator = class("GalleryMemoryInfoMediator", DmAreaViewMediator, _M)

GalleryMemoryInfoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
GalleryMemoryInfoMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")

local kBtnHandlers = {
	shareBtn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickShare"
	},
	["btnPanel.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["btnPanel.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	}
}

function GalleryMemoryInfoMediator:initialize()
	super.initialize(self)
end

function GalleryMemoryInfoMediator:dispose()
	super.dispose(self)
end

function GalleryMemoryInfoMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function GalleryMemoryInfoMediator:enterWithData(data)
	self:initData(data)
	self:initWidgetInfo()
	self:initView()
	self:runStartAnim()
	self:setupTopInfoWidget()
end

function GalleryMemoryInfoMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._photoImg = self._main:getChildByName("photoImg")

	self._photoImg:ignoreContentAdaptWithSize(true)

	self._titleNode = self._main:getChildByName("titleNode")
	self._photoNum = self._titleNode:getChildByName("photoNum")
	self._photoTitle = self._titleNode:getChildByName("photoTitle")
	self._photoEnTitle = self._titleNode:getChildByName("enTitle")
	self._titleBg1 = self._titleNode:getChildByName("bg1")
	self._titleBg2 = self._titleNode:getChildByName("bg2")
	self._photoDesc = self._main:getChildByFullName("bottomImg.photoDesc")
	self._photoDate = self._main:getChildByFullName("bottomImg.photoDate")
	self._btnPanel = self:getView():getChildByFullName("btnPanel")
	self._leftBtn = self._btnPanel:getChildByFullName("left.leftBtn")
	self._rightBtn = self._btnPanel:getChildByFullName("right.rightBtn")
	self._topInfoNode = self:getView():getChildByFullName("topinfo_node")

	self:ignoreSafeArea()
	self:setEffect()
	self:runBtnAnim()
end

function GalleryMemoryInfoMediator:ignoreSafeArea()
	local shareBtn = self:getView():getChildByFullName("shareBtn")

	AdjustUtils.ignorSafeAreaRectForNode(self._photoNum, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._photoTitle, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._photoDesc, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(shareBtn, AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(self._photoDate, AdjustUtils.kAdjustType.Right)
end

function GalleryMemoryInfoMediator:setEffect()
	self._photoNum:enableOutline(cc.c4b(0, 0, 0, 153), 2)
	self._photoDate:enableOutline(cc.c4b(0, 0, 0, 153), 2)
	self._photoEnTitle:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 2)

	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}

	self._photoEnTitle:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function GalleryMemoryInfoMediator:initData(data)
	self._memoryData = data.data
	self._canChange = true

	local list = data.listData

	self._listData = {}

	for i = 1, #list do
		if list[i]:getUnlock() then
			self._listData[#self._listData + 1] = list[i]

			if self._memoryData:getId() == list[i]:getId() then
				self._index = #self._listData
			end
		end
	end
end

function GalleryMemoryInfoMediator:initView()
	self._photoImg:loadTexture(self._memoryData:getPicture())

	local num = self._memoryData:getNumber()

	if num < 10 then
		num = "00" .. num
	elseif num < 100 then
		num = "0" .. num
	end

	self._photoNum:setString(num)
	self._photoTitle:setString(self._memoryData:getTitle())
	self._photoEnTitle:setString(self._memoryData:getENTitle())
	self._photoDesc:setString(self._memoryData:getDesc())
	self._photoDate:setFontName(TTF_FONT_FZYH_R)
	self._photoDate:setFontSize(self._photoDesc:getFontSize())
	self._photoDate:enableOutline(cc.c4b(0, 0, 0, 255), 1)

	local date = TimeUtil:localDate("%Y/%m/%d", self._memoryData:getDate())

	self._photoDate:setString(date)
	self._photoEnTitle:setPositionX(self._photoTitle:getPositionX() + self._photoTitle:getContentSize().width + 2)
	self._titleBg2:setPositionX(self._photoEnTitle:getPositionX() - 38)
	self._titleBg2:setContentSize(cc.size(self._photoEnTitle:getContentSize().width + 76, 36))
	self._titleBg1:setContentSize(cc.size(161 + self._photoTitle:getContentSize().width, 41))
	self._leftBtn:setVisible(self._index ~= 1)
	self._rightBtn:setVisible(self._index ~= #self._listData)
	self:setTouchPanel()
end

function GalleryMemoryInfoMediator:addShare()
	local data = {
		enterType = ShareEnterType.KGallery,
		node = self:getView(),
		preConfig = function()
			self._topInfoNode:setVisible(false)
			self._btnPanel:setVisible(false)
		end,
		endConfig = function()
			self._topInfoNode:setVisible(true)
			self._btnPanel:setVisible(true)
		end
	}

	DmGame:getInstance()._injector:getInstance(ShareSystem):addShare(data)
end

function GalleryMemoryInfoMediator:addShareTest()
	local data = {
		enterType = ShareEnterType.KGalleryTest,
		node = self:getView(),
		preConfig = function()
			self._topInfoNode:setVisible(false)
			self._btnPanel:setVisible(false)
		end,
		endConfig = function()
			self._topInfoNode:setVisible(true)
			self._btnPanel:setVisible(true)
		end
	}

	DmGame:getInstance()._injector:getInstance(ShareSystem):addShare(data)
end

function GalleryMemoryInfoMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function GalleryMemoryInfoMediator:onClickShare(sender, eventType)
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:get("Source_General_Unknown")
	}))
end

function GalleryMemoryInfoMediator:setTouchPanel()
	local touchPanel = self:getView():getChildByFullName("touchPanel")
	local clickTouchPanelStatus = false

	local function clickTouchPanelFunc()
		for key, value in pairs(touchPanel:getChildren()) do
			value:setVisible(clickTouchPanelStatus)
		end

		touchPanel:getChildByFullName("logo"):setVisible(false)
		self._topInfoNode:setVisible(not clickTouchPanelStatus)
		self._btnPanel:setVisible(not clickTouchPanelStatus)
		touchPanel:getChildByFullName("photoImg"):loadTexture(self._memoryData:getPicture())
		DmGame:getInstance()._injector:getInstance(ShareSystem):setShareVisible({
			enterType = ShareEnterType.KGallery,
			node = self:getView(),
			status = not clickTouchPanelStatus
		})
	end

	clickTouchPanelFunc()

	local function callFunc(sender, eventType)
		clickTouchPanelStatus = not clickTouchPanelStatus

		clickTouchPanelFunc()
	end

	mapButtonHandlerClick(nil, touchPanel, {
		func = callFunc
	})
end

function GalleryMemoryInfoMediator:runStartAnim()
	local maskImage = self:getView():getChildByName("maskImage")

	maskImage:setOpacity(255)

	local fade = cc.FadeOut:create(0.4)

	local function endFunc()
		self:addShare()
	end

	local callFuncAct1 = cc.CallFunc:create(endFunc)
	local action = cc.Sequence:create(fade, callFuncAct1)

	maskImage:runAction(action)
end

function GalleryMemoryInfoMediator:setupTopInfoWidget()
	self._topInfoNode = self:getView():getChildByFullName("topinfo_node")

	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(self._topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function GalleryMemoryInfoMediator:runBtnAnim()
	CommonUtils.runActionEffect(self._leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
	CommonUtils.runActionEffect(self._rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
end

function GalleryMemoryInfoMediator:onClickLeft()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.1)

	self._index = self._index - 1

	if self._index < 1 then
		self._index = 1

		return
	end

	self._memoryData = self._listData[self._index]

	self:initView()
end

function GalleryMemoryInfoMediator:onClickRight()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.5)

	self._index = self._index + 1

	if self._index > #self._listData then
		self._index = #self._listData

		return
	end

	self._memoryData = self._listData[self._index]

	self:initView()
end
