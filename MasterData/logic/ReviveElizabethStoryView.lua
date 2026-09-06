-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/view/ReviveElizabethStoryView.lua

module("logic.extensions.reviveelizabeth.view.ReviveElizabethStoryView", package.seeall)

local ReviveElizabethStoryView = class("ReviveElizabethStoryView", ViewComponent)

function ReviveElizabethStoryView:ctor()
	ReviveElizabethStoryView.super.ctor(self)
end

function ReviveElizabethStoryView:unbindEvents()
	ReviveElizabethStoryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ReviveElizabethStoryView:bindEvents()
	ReviveElizabethStoryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ReviveElizabethStoryView:buildUI()
	ReviveElizabethStoryView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ReviveElizabethStoryView:onExit()
	ReviveElizabethStoryView.super.onExit(self)
	self._scrollerList:dispose()
end

function ReviveElizabethStoryView:onEnter()
	ReviveElizabethStoryView.super.onEnter(self)

	local params = self:getOpenParam()

	if not params then
		FloatWordMgr.instance:show("打开界面失败，请检查传递的参数是否正确")
		self:close()

		return
	end

	self._activityId = checknumber(params[1])
	self._worldProg = checknumber(params[2])
	self._info = ReviveElizabethModel.instance:getInfo(self._activityId)
	self._config = ReviveElizabethConfig.instance:getStoryConfig(self._activityId) or {}

	self._scrollerList:reloadData(self._config)
end

function ReviveElizabethStoryView:_updateCell(view, cell, data)
	local btn = goutil.findChild(cell, "btn")
	local content = goutil.findChildTextComponent(cell, "txt")
	local txtlock = goutil.findChildTextComponent(cell, "lock")
	local isUnlock = data.prizeId <= self._worldProg

	content.text = data.content
	txtlock.text = string.format("世界进度第%d档解锁", data.prizeId)

	goutil.setActive(btn, isUnlock)
	goutil.setActive(txtlock.gameObject, not isUnlock)
	GameUtil.rmClickHandler(btn)

	if isUnlock then
		GameUtil.addClickHandler(btn, GameUtil.handler(self.reviewStory, self, data.storyId), self)
	end
end

function ReviveElizabethStoryView:_clearCell(cell)
	local btn = goutil.findChild(cell, "btn")

	GameUtil.rmClickHandler(btn)
end

function ReviveElizabethStoryView:reviewStory(storyId)
	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

return ReviveElizabethStoryView
