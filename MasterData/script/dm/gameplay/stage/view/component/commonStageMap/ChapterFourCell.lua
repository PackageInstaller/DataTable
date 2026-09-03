-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/commonStageMap/ChapterFourCell.lua

ChapterFourCell = class("ChapterFourCell", ChapterBase)

local kBtnHandlers = {}
local onPlayAnim

function ChapterFourCell:initialize(data)
	super.initialize(self, data)

	onPlayAnim = false
	self._stageType = data.stageType
	self._mediator = data.mediator

	self:initView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ChapterFourCell:update(stageType, redPointTab)
	self._stageType = stageType

	local function callFunc()
		local contentData = {}

		contentData.stageType = self._stageType
		contentData.tabOffX = self._mediator._tableView:getContentOffset().x

		self._mediator:getStageSystem():setContentData(contentData)
	end

	self:initChapterPanel(self._chapter1, "M06", callFunc)
	self._chapter1:setPosition(cc.p(self._chapter1RowX, self._chapter1RowY))
	self._chapter1.redPoint:setVisible(self:checkRedPoint(redPointTab, 6))
	self:initChapterPanel(self._chapter2, "M07", callFunc)
	self._chapter2:setPosition(cc.p(self._chapter2RowX, self._chapter2RowY))
	self._chapter2.redPoint:setVisible(self:checkRedPoint(redPointTab, 7))
	AudioEngine:getInstance():playAction("Action_2", false)
end

function ChapterFourCell:initView()
	self:initWidget()
	self:initAnim()
end

function ChapterFourCell:initWidget()
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

	local imageBg = self._main:getChildByName("Image_15")

	imageBg:setScaleY(self._winSize.height / 640)

	local Image5 = self._main:getChildByName("Image5")

	AdjustUtils.adjustLayoutByType(Image5, AdjustUtils.kAdjustType.Bottom)
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

function ChapterFourCell:onScroll(offX)
	self:initMobileObj(offX, self._chapter1, 380, cc.p(self._chapter1RowX, self._chapter1RowY), 5140, 630)
	self:initMobileObj(offX, self._chapter2, 450, cc.p(self._chapter2RowX, self._chapter2RowY), 5300, 266)

	if onPlayAnim then
		if offX > -5780 and offX < -5111 then
			onPlayAnim = true
		else
			self:refreshAnim(onPlayAnim)
		end
	elseif offX < -5780 or offX > -5111 then
		onPlayAnim = false
	else
		self:refreshAnim(onPlayAnim)
	end
end

function ChapterFourCell:refreshAnim(isPlaying)
	if isPlaying then
		self._mc:gotoAndPlay(69)
		AudioEngine:getInstance():playEffect("Se_Effect_Candle_Off", false)
	else
		self._mc:gotoAndPlay(1)
		AudioEngine:getInstance():playEffect("Se_Effect_Candle_On", false)
	end

	onPlayAnim = not isPlaying
end

function ChapterFourCell:initAnim()
	local mc = cc.MovieClip:create("zongdh_lazhu")

	mc:setPosition(cc.p(209, 250))
	mc:setScale(0.6)
	self._chapter2:addChild(mc)
	self._chapter2:getChildByName("redPoint"):setLocalZOrder(10)
	mc:addCallbackAtFrame(15, function()
		mc:gotoAndPlay(7)
	end)
	mc:addEndCallback(function()
		mc:stop()
	end)
	mc:stop()

	self._mc = mc
end
