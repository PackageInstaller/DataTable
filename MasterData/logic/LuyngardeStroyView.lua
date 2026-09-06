-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeStroyView.lua

module("logic.extensions.luyngarde.view.LuyngardeStroyView", package.seeall)

local LuyngardeStroyView = class("LuyngardeStroyView", ViewComponent)

function LuyngardeStroyView:ctor()
	LuyngardeStroyView.super.ctor(self)
end

function LuyngardeStroyView:unbindEvents()
	LuyngardeStroyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LuyngardeStroyView:bindEvents()
	LuyngardeStroyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function LuyngardeStroyView:buildUI()
	LuyngardeStroyView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local cellGo = self:getGo("com/cell")
	local tableviewGo = self:getGo("com/tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function LuyngardeStroyView:onExit()
	LuyngardeStroyView.super.onExit(self)
	self._tableview:dispose()
end

function LuyngardeStroyView:onEnter()
	LuyngardeStroyView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._storyCfgs = LuyngardeConfig.instance:getStoryCfgs(self._activityId)

	self._tableview:reloadData(self._storyCfgs)
end

function LuyngardeStroyView:_onClickStroy(chapterId)
	local isUnlock = LuyngardeController.instance:getChapterStoryIsUnlock(self._activityId, chapterId)

	if isUnlock then
		local cfg = self._storyCfgs[chapterId]

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, cfg.storyId, StoryModel.StoryType.SCCopy)
	else
		FloatWordMgr.instance:show("此章节未开启，不可观看剧情回放")
	end
end

function LuyngardeStroyView:_updateCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")
	local btn = goutil.findChild(cell.gameObject, "btn")

	txtTitle.text = data.title

	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickStroy, self, data.chapterId))
end

function LuyngardeStroyView:_clearCell(cell)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)
end

return LuyngardeStroyView
