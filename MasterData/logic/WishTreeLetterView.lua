-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/view/WishTreeLetterView.lua

module("logic.extensions.wishtree.view.WishTreeLetterView", package.seeall)

local WishTreeLetterView = class("WishTreeLetterView", ViewComponent)

function WishTreeLetterView:ctor()
	WishTreeLetterView.super.ctor(self)
end

function WishTreeLetterView:unbindEvents()
	WishTreeLetterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function WishTreeLetterView:bindEvents()
	WishTreeLetterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function WishTreeLetterView:buildUI()
	WishTreeLetterView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txt = self:getTxt("tableView/Viewport/Content/txtContent")
end

function WishTreeLetterView:onExit()
	WishTreeLetterView.super.onExit(self)
end

function WishTreeLetterView:onEnter()
	WishTreeLetterView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._cfgs = WishTreeConfig.instance:getWishTreeCfgsByActId(self._activityId)
	self._txt.text = self._cfgs.content
end

function WishTreeLetterView:_onClickClose()
	self:close()
end

return WishTreeLetterView
