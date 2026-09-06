-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summarytabstory/view/SummaryTabStoryView.lua

module("logic.extensions.summarytabstory.view.SummaryTabStoryView", package.seeall)

local SummaryTabStoryView = class("SummaryTabStoryView", ViewComponent)

function SummaryTabStoryView:buildUI()
	SummaryTabStoryView.super.buildUI(self)

	self._btnClose = self:getGo("window/closeBtn")
	self._tableview = self:getGo("window/storys/tableview")
	self._cell = self:getGo("window/storys/cell")
	self._scrollRewardList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._storys = self:getGo("window/storys")
end

function SummaryTabStoryView:bindEvents()
	SummaryTabStoryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SummaryTabStoryView:unbindEvents()
	SummaryTabStoryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SummaryTabStoryView:onEnter()
	SummaryTabStoryView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])
	local storyCfgs = OperationSummaryConfig.instance:getStoryCfgByActId(activityId)

	self._cellWidth = GameUtil.getWidth(self._cell)
	self._storyWidth = GameUtil.getWidth(self._storys)

	local canContentCellNum = math.floor(self._storyWidth / self._cellWidth)

	self._storyId = 0

	self._scrollRewardList:reloadData(storyCfgs)

	if canContentCellNum >= #storyCfgs then
		self._scrollRewardList:setCenterMode(true)
	end
end

function SummaryTabStoryView:onExit()
	SummaryTabStoryView.super.onExit(self)
	self._scrollRewardList:dispose()
end

function SummaryTabStoryView:_updateCell(view, cell, data)
	local btnPlay = goutil.findChild(cell, "btnPlay")
	local timeLock = goutil.findChild(cell, "timeLock")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local opentime = data.startTime
	local canPlayStory = true

	if opentime then
		local openTimeStamp = GameUtil.string2time(opentime)

		canPlayStory = openTimeStamp < ServerTime.now()
	end

	txtTitle.text = data.title

	GameUtil.addClickHandler(btnPlay, function()
		local hasGetedTotalInfo = StoryPrizeController.instance:hasGetedTotalInfo()

		if not hasGetedTotalInfo then
			FloatWordMgr.instance:show("数据同步中，请稍后再观看剧情")

			return
		end

		if opentime and not canPlayStory then
			local openTimeStamp = GameUtil.string2time(opentime)
			local timeStr = GameUtil.formatTimeStamp("剧情尚未开启，开启时间为%Y-%m-%d %H:%M:%S", openTimeStamp)

			FloatWordMgr.instance:show(timeStr)

			return
		end

		local storyId = data.id

		StoryPrizeController.instance:playStroyAndGetPrize(storyId)
	end, self)
	GameUtil.SetActive(timeLock, not canPlayStory)
end

function SummaryTabStoryView:_clearCell(cell)
	local btnPlay = goutil.findChild(cell, "btnPlay")

	GameUtil.rmClickHandler(btnPlay)
end

return SummaryTabStoryView
