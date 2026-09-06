-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveStoryView.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveStoryView", package.seeall)

local ImmortalMoveStoryView = class("ImmortalMoveStoryView", ViewComponent)

function ImmortalMoveStoryView:ctor()
	ImmortalMoveStoryView.super.ctor(self)
end

function ImmortalMoveStoryView:unbindEvents()
	ImmortalMoveStoryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ImmortalMoveStoryView:bindEvents()
	ImmortalMoveStoryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ImmortalMoveStoryView:buildUI()
	ImmortalMoveStoryView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local tableviewGo = self:getGo("storys/tableview")
	local cellGo = self:getGo("storys/cell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updatCell, self), GameUtil.handler(self._clearCell, self))
end

function ImmortalMoveStoryView:onExit()
	ImmortalMoveStoryView.super.onExit(self)
	self._tableview:dispose()
end

function ImmortalMoveStoryView:onEnter()
	ImmortalMoveStoryView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 494001
	end

	local info = ImmortalMovementModel.instance:getBaseInfo(self._activityId)

	if info then
		self._hasUnlockScore = info.hasUnlockScore or {}
	end

	self._storyCfgs = ImmortalMovementConfig.instance:getStoryCfgs(self._activityId) or {}

	self._tableview:reloadData(self._storyCfgs)
end

function ImmortalMoveStoryView:_updatCell(view, cell, data)
	local btnPlay = goutil.findChild(cell.gameObject, "btnPlay")
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")

	txtTitle.text = data.title

	GameUtil.addClickHandler(btnPlay, GameUtil.handler(self._onClickPlay, self, data))
end

function ImmortalMoveStoryView:_clearCell(cell)
	local btnPlay = goutil.findChild(cell.gameObject, "btnPlay")

	GameUtil.rmClickHandler(btnPlay)
end

function ImmortalMoveStoryView:_onClickPlay(data)
	local sortId = checknumber(data.sortId)
	local isUnlock = sortId <= #self._hasUnlockScore

	if isUnlock then
		local storyId = checknumber(data.storyId)

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
	else
		FloatWordMgr.instance:show("此章节未开启，不可观看剧情回放")
	end
end

return ImmortalMoveStoryView
