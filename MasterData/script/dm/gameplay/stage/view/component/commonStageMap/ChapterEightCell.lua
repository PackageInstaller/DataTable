-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/commonStageMap/ChapterEightCell.lua

ChapterEightCell = class("ChapterEightCell", ChapterBase)

local kBtnHandlers = {}

function ChapterEightCell:initialize(data)
	super.initialize(self, data)

	self._stageType = data.stageType
	self._mediator = data.mediator

	self:initView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ChapterEightCell:update(stageType, redPointTab)
	self._stageType = stageType

	local function callFunc()
		local contentData = {}

		contentData.stageType = self._stageType
		contentData.tabOffX = self._mediator._tableView:getContentOffset().x

		self._mediator:getStageSystem():setContentData(contentData)
	end

	self:initChapterPanel(self._chapter1, "M14", callFunc)
	self._chapter1.redPoint:setVisible(self:checkRedPoint(redPointTab, 14))
	self._chapter1:setPosition(cc.p(self._chapter1RowX, self._chapter1RowY))
	self:initChapterPanel(self._chapter2, "M15", callFunc)
	self._chapter2:setPosition(cc.p(self._chapter2RowX, self._chapter2RowY))
	self._chapter2.redPoint:setVisible(self:checkRedPoint(redPointTab, 15))
	AudioEngine:getInstance():playAction("Action_7", false)
end

function ChapterEightCell:initView()
	self:initWidget()
	self:initAnim()
end

function ChapterEightCell:onScroll(offX)
	return
end

function ChapterEightCell:initWidget()
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

	local text = self._chapter2:getChildByName("Text_36")

	text:getVirtualRenderer():setLineSpacing(10)
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

function ChapterEightCell:initAnim()
	local mc = cc.MovieClip:create("zdh_zhuxian145")
	local mcNode = self._main:getChildByName("mcNode")

	mc:setAnchorPoint(0, 0)
	mc:setPosition(0, -100)
	mc:addTo(mcNode)

	if self._winSize.height < 641 then
		mcNode:setScale(self._winSize.width / 1386)
	end
end
