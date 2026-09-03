-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/eliteStageMap/EliteThreeCell.lua

EliteThreeCell = class("EliteThreeCell", ChapterBase)

local kBtnHandlers = {}
local onPlayAnim

function EliteThreeCell:initialize(data)
	super.initialize(self, data)

	onPlayAnim = false
	self._stageType = data.stageType
	self._mediator = data.mediator

	self:initView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function EliteThreeCell:update(stageType, redPointTab)
	self._stageType = stageType

	local function callFunc()
		local contentData = {}

		contentData.stageType = self._stageType
		contentData.tabOffX = self._mediator._tableView:getContentOffset().x

		self._mediator:getStageSystem():setContentData(contentData)
		self._actionNode:setVisible(false)
	end

	self:initChapterPanel(self._chapter1, "E04", callFunc)
	self._chapter1:setPosition(cc.p(self._chapter1RowX, self._chapter1RowY))
	self._chapter1.redPoint:setVisible(self:checkRedPoint(redPointTab, 4))
	self:initChapterPanel(self._chapter2, "E05", callFunc)
	self._chapter2:setPosition(cc.p(self._chapter2RowX, self._chapter2RowY))
	self._chapter2.redPoint:setVisible(self:checkRedPoint(redPointTab, 5))
end

function EliteThreeCell:onScroll(offX)
	self:initMobileObj(offX, self._chapter1, 380, cc.p(self._chapter1RowX, self._chapter1RowY), 3697, 277)
	self:initMobileObj(offX, self._chapter2, 500, cc.p(self._chapter2RowX, self._chapter2RowY), 3897, 520)
	self:initMobileObj(offX, self._textPanel, 190, cc.p(self._textPanelRowX, self._textPanelRowY), 3697, 690)
	self:refreshAnim(offX)
end

function EliteThreeCell:refreshAnim(offX)
	if onPlayAnim then
		if offX < -4500 or offX > -2400 then
			self._actionNode:stopAllActions()
			self._actionNode:setVisible(false)

			onPlayAnim = false
		end

		return
	end

	if offX > -2800 and offX < -2633 then
		self:doAnim()

		onPlayAnim = true
	end
end

function EliteThreeCell:initView()
	self:initWidget()
	self:initAnim()
end

function EliteThreeCell:initWidget()
	self._main = self:getView():getChildByName("main")
	self._chapter1 = self._main:getChildByName("chapterCell_1")
	self._chapter1.redPoint = self._chapter1:getChildByName("redPoint")

	AdjustUtils.adjustLayoutByType(self._chapter1, AdjustUtils.kAdjustType.Top)

	self._chapter1RowX = self._chapter1:getPositionX()
	self._chapter1RowY = self._chapter1:getPositionY()
	self._chapter2 = self._main:getChildByName("chapterCell_2")
	self._chapter2.redPoint = self._chapter2:getChildByName("redPoint")
	self._chapter2RowX = self._chapter2:getPositionX()
	self._chapter2RowY = self._chapter2:getPositionY()
	self._textPanel = self._main:getChildByName("textPanel")
	self._textPanelRowX = self._textPanel:getPositionX()
	self._textPanelRowY = self._textPanel:getPositionY()
	self._actionNode = self._main:getChildByName("Image2")

	local imageBg1 = self._main:getChildByName("Imagebg1")

	imageBg1:setScaleY(self._winSize.height / 640)

	local imageBg2 = self._main:getChildByName("Imagebg2")

	imageBg2:setScaleY(self._winSize.height / 640)
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

function EliteThreeCell:doAnim()
	self._actionNode:setVisible(true)

	local action = cc.CSLoader:createTimeline("asset/ui/BlockMapCell3.csb")

	action:setTimeSpeed(0.2)

	self._action = action

	self._actionNode:runAction(self._action)
	self._action:gotoFrameAndPlay(0, 120, false)
end

function EliteThreeCell:initAnim()
	local mc = cc.MovieClip:create("sbw_shuibowen")

	mc:setPosition(cc.p(270, 150))
	mc:setScale(0.7)
	mc:setPlaySpeed(0.6)

	local animPanel = self._main:getChildByName("animPanel")

	animPanel:addChild(mc)

	self._mc = mc

	local anim = cc.MovieClip:create("dh_qipao")

	anim:setPosition(cc.p(270, 150))
	animPanel:addChild(anim)
end
