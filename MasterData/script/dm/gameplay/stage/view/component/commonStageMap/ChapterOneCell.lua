-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/commonStageMap/ChapterOneCell.lua

ChapterOneCell = class("ChapterOneCell", ChapterBase)

local kBtnHandlers = {}

function ChapterOneCell:initialize(data)
	super.initialize(self, data)

	self._stageType = data.stageType
	self._mediator = data.mediator

	self:initView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ChapterOneCell:update(stageType, redPointTab)
	self._stageType = stageType

	self:initChapterPanel(self._chapter, "M01")
	self._chapter.redPoint:setVisible(self:checkRedPoint(redPointTab, 1))
	self._chapter:setPosition(cc.p(self._chapterRawX, self._chapterRawY))
end

function ChapterOneCell:initChapterPanel(chapterPanel, chapterId)
	local mapInfo = self._stageSystem:getMapById(chapterId)
	local chapterIndex = mapInfo:getIndex()
	local mapName = Strings:get(mapInfo:getConfig().MapName)
	local chapterTitleText = chapterPanel:getChildByFullName("chapterTitle.titleText")

	chapterTitleText:setString(mapName)

	local unlock, tipStr = mapInfo:isUnlock()
	local curStars = chapterPanel:getChildByName("curStars")
	local maxStars = chapterPanel:getChildByName("maxStars")

	curStars:setString(mapInfo:getCurrentStarCount())
	maxStars:setString("/" .. mapInfo:getTotalStarCount())

	local chapterNum = chapterPanel:getChildByName("chapterNum")

	chapterNum:setString(chapterIndex)
	chapterPanel:setSwallowTouches(false)

	local function callFunc(sender, eventType)
		local beganPos = sender:getTouchBeganPosition()
		local endPos = sender:getTouchEndPosition()

		if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
			self._mediator._data.stageType = self._stageType

			if unlock == true then
				local contentData = {}

				contentData.stageType = self._stageType
				contentData.tabOffX = self._mediator._tableView:getContentOffset().x

				self._mediator:getStageSystem():setContentData(contentData)
				AudioEngine:getInstance():playEffect("Se_Click_Charpter", false)
				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, self:getInjector():getInstance("CommonStageChapterView"), {}, {
					chapterIndex = chapterIndex,
					stageType = self._stageType
				}))
			else
				AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = tipStr
				}))
			end
		end
	end

	mapButtonHandlerClick(nil, chapterPanel, {
		ignoreClickAudio = true,
		func = callFunc
	})
end

function ChapterOneCell:onScroll(offX)
	local percentOfChapter

	self._chapter:setPosition(cc.p(self._chapterRawX + (offX < -1050 and 1 or -(offX / 1050)) * 380, self._chapterRawY))
end

function ChapterOneCell:initView()
	self:initWidget()
	self:initAnim()
end

function ChapterOneCell:initWidget()
	self._main = self:getView():getChildByName("main")
	self._chapter = self._main:getChildByName("chapterCell")
	self._chapter.redPoint = self._chapter:getChildByName("redPoint")
	self._chapterRawX = self._chapter:getPositionX()
	self._chapterRawY = self._chapter:getPositionY()
	self._textPanel = self._main:getChildByName("textPanel")
	self._textPanelRawX = self._textPanel:getPositionX()
	self._textPanelRawY = self._textPanel:getPositionY()
	self._curStars = self._chapter:getChildByName("curStars")
	self._maxStars = self._chapter:getChildByName("maxStars")

	local Image51 = self._main:getChildByName("Image_51")

	AdjustUtils.adjustLayoutByType(Image51, AdjustUtils.kAdjustType.Bottom)
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

function ChapterOneCell:initAnim()
	local mc = cc.MovieClip:create("yun_zhuxianyun")
	local imageBgPanel = self._main:getChildByName("imageBgPanel")

	mc:addTo(imageBgPanel)
	mc:setPosition(cc.p(560, 80))
	AdjustUtils.adjustLayoutByType(mc, AdjustUtils.kAdjustType.Top)
end
