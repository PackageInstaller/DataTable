-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/commonStageMap/ChapterFiveCell.lua

ChapterFiveCell = class("ChapterFiveCell", ChapterBase)

local kBtnHandlers = {}

function ChapterFiveCell:initialize(data)
	super.initialize(self, data)

	self._stageType = data.stageType
	self._mediator = data.mediator

	self:initView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ChapterFiveCell:update(stageType, redPointTab)
	self._stageType = stageType

	local function callFunc()
		local contentData = {}

		contentData.stageType = self._stageType
		contentData.tabOffX = self._mediator._tableView:getContentOffset().x

		self._mediator:getStageSystem():setContentData(contentData)
	end

	self:initChapterPanel(self._chapter1, "M08", callFunc)
	self._chapter1:setPosition(cc.p(self._chapter1RowX, self._chapter1RowY))
	self._chapter1.redPoint:setVisible(self:checkRedPoint(redPointTab, 8))
	self:initChapterPanel(self._chapter2, "M09", callFunc)
	self._chapter2:setPosition(cc.p(self._chapter2RowX, self._chapter2RowY))
	self._chapter2.redPoint:setVisible(self:checkRedPoint(redPointTab, 9))
	AudioEngine:getInstance():playAction("Action_1", false)
end

function ChapterFiveCell:initView()
	self:initWidget()
	self:initAnim()
	self:adjustUI()
end

function ChapterFiveCell:onScroll(offX)
	return
end

function ChapterFiveCell:initWidget()
	self._main = self:getView():getChildByName("main")
	self._chapter1 = self._main:getChildByName("chapterCell1")
	self._chapter1.redPoint = self._chapter1:getChildByName("redPoint")
	self._chapter1RowX = self._chapter1:getPositionX()
	self._chapter1RowY = self._chapter1:getPositionY()
	self._chapter2 = self._main:getChildByName("chapterCell2")
	self._chapter2.redPoint = self._chapter2:getChildByName("redPoint")
	self._chapter2RowX = self._chapter2:getPositionX()
	self._chapter2RowY = self._chapter2:getPositionY()
	self._textPanel = self._main:getChildByName("textPanel")
	self._textPanelRowX = self._textPanel:getPositionX()
	self._textPanelRowY = self._textPanel:getPositionY()
end

function ChapterFiveCell:adjustUI()
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

		text = Node_vertical:getChildByFullName("text4")

		text:getVirtualRenderer():setDimensions(20, 0)

		text = Node_vertical:getChildByFullName("text5")

		text:getVirtualRenderer():setDimensions(20, 0)
	else
		Node_vertical:setVisible(false)
		Node_horizontal:setVisible(true)

		local text5 = Node_horizontal:getChildByFullName("text5")
		local Text_16 = Node_horizontal:getChildByFullName("Text_16")

		Text_16:setPositionX(text5:getPositionX() + text5:getContentSize().width + 5)
	end
end

function ChapterFiveCell:initAnim()
	local animPanel = self._main:getChildByName("flashPanel")

	AdjustUtils.adjustLayoutByType(animPanel, AdjustUtils.kAdjustType.Bottom)

	local midImage = animPanel:getChildByName("Image_19")

	midImage:setLocalZOrder(100)

	local anim = cc.MovieClip:create("huoxingdh_zhuxianhuo")

	anim:setPosition(cc.p(530, 180))
	anim:addTo(animPanel)
	anim:setLocalZOrder(101)

	local flash = cc.MovieClip:create("xunhuanyanwu_jiaxunhuanyanwu")

	flash:setPosition(cc.p(1110, 432))
	flash:addTo(animPanel)
	flash:setLocalZOrder(99)
end
