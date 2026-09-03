-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/commonStageMap/ChapterSixCell.lua

ChapterSixCell = class("ChapterSixCell", ChapterBase)

local kBtnHandlers = {}

function ChapterSixCell:initialize(data)
	super.initialize(self, data)

	self._stageType = data.stageType
	self._mediator = data.mediator

	self:initView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ChapterSixCell:update(stageType, redPointTab)
	self._stageType = stageType

	local function callFunc()
		local contentData = {}

		contentData.stageType = self._stageType
		contentData.tabOffX = self._mediator._tableView:getContentOffset().x

		self._mediator:getStageSystem():setContentData(contentData)
	end

	self:initChapterPanel(self._chapter1, "M10", callFunc)
	self._chapter1:setPosition(cc.p(self._chapter1RowX, self._chapter1RowY))
	self._chapter1.redPoint:setVisible(self:checkRedPoint(redPointTab, 10))
	self:initChapterPanel(self._chapter2, "M11", callFunc)
	self._chapter2:setPosition(cc.p(self._chapter2RowX, self._chapter2RowY))
	self._chapter2.redPoint:setVisible(self:checkRedPoint(redPointTab, 11))
end

function ChapterSixCell:initView()
	self:initWidget()
	self:initAnim()
end

function ChapterSixCell:onScroll(offX)
	self:initMobileObj(offX, self._chapter1, 380, cc.p(self._chapter1RowX, self._chapter1RowY), 9098, 476)
	self:initMobileObj(offX, self._chapter2, 380, cc.p(self._chapter2RowX, self._chapter2RowY), 9300, 234)
	self:initMobileObj(offX, self._textPanel, 190, cc.p(self._textPanelRowX, self._textPanelRowY), 9680, 100)
end

function ChapterSixCell:initWidget()
	self._main = self:getView():getChildByName("main")
	self._chapter1 = self._main:getChildByName("chapterCell1")
	self._chapter1.redPoint = self._chapter1:getChildByName("redPoint")
	self._chapter1RowX = self._chapter1:getPositionX()
	self._chapter1RowY = self._chapter1:getPositionY()
	self._chapter2 = self._main:getChildByName("chapterCell2")
	self._chapter2.redPoint = self._chapter2:getChildByName("redPoint")

	AdjustUtils.adjustLayoutByType(self._chapter2, AdjustUtils.kAdjustType.Top)

	self._chapter2RowX = self._chapter2:getPositionX()
	self._chapter2RowY = self._chapter2:getPositionY()
	self._textPanel = self._main:getChildByName("textPanel")
	self._textPanelRowX = self._textPanel:getPositionX()
	self._textPanelRowY = self._textPanel:getPositionY()

	local localLanguage = getCurrentLanguage()
	local Node_vertical = self._textPanel:getChildByFullName("hideText.Node_vertical")
	local Node_horizontal = self._textPanel:getChildByFullName("hideText.Node_horizontal")

	if localLanguage == "" then
		Node_vertical:setVisible(true)
		Node_horizontal:setVisible(false)

		local text = Node_vertical:getChildByFullName("text1")

		text:getVirtualRenderer():setDimensions(20, 0)

		text = Node_vertical:getChildByFullName("text2")

		text:getVirtualRenderer():setDimensions(20, 0)

		text = Node_vertical:getChildByFullName("text3")

		text:getVirtualRenderer():setDimensions(20, 0)
	else
		Node_vertical:setVisible(false)
		Node_horizontal:setVisible(true)

		local text1 = Node_horizontal:getChildByFullName("text1")
		local text2 = Node_horizontal:getChildByFullName("text2")

		text1:getVirtualRenderer():setLineSpacing(0)
		text1:getVirtualRenderer():setDimensions(text1:getContentSize().width, 0)
		text2:getVirtualRenderer():setLineSpacing(0)
		text2:getVirtualRenderer():setDimensions(text2:getContentSize().width, 0)
		text2:setPositionY(text1:getPositionY() - text1:getVirtualRenderer():getContentSize().height)
	end

	self._textPanel:setSwallowTouches(false)

	local function callFunc(sender, eventType)
		local hideText = sender:getChildByName("hideText")

		if eventType == ccui.TouchEventType.began then
			hideText:stopAllActions()

			local fadeAct = cc.FadeIn:create(0.1)

			hideText:runAction(cc.Sequence:create(fadeAct, cc.CallFunc:create(function()
				AudioEngine:getInstance():playEffect("Se_Effect_Display", false)
			end)))
		elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
			hideText:stopAllActions()

			local fadeAct = cc.FadeOut:create(0.5)

			hideText:runAction(fadeAct)
		end
	end

	mapButtonHandlerClick(nil, self._textPanel, {
		ignoreClickAudio = true,
		eventType = 4,
		func = callFunc
	})
end

function ChapterSixCell:initAnim()
	local anim = cc.MovieClip:create("shengliz_zhuxianyun")

	anim:setPosition(cc.p(340, 158))
	anim:addEndCallback(function()
		anim:gotoAndPlay(20)
	end)

	local animPanel = self._chapter1:getChildByName("animPanel")

	animPanel:addChild(anim)

	self._anim = anim

	local mc = cc.MovieClip:create("huanwen_zhuxianyun")

	mc:setPosition(cc.p(58, 94))

	local mcPanel = self._chapter2:getChildByName("animPanel")

	mcPanel:addChild(mc)
end
