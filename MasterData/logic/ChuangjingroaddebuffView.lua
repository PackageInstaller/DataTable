-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroaddebuffView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroaddebuffView", package.seeall)

local ChuangjingroaddebuffView = class("ChuangjingroaddebuffView", ViewComponent)

function ChuangjingroaddebuffView:ctor()
	ChuangjingroaddebuffView.super.ctor(self)
end

function ChuangjingroaddebuffView:unbindEvents()
	ChuangjingroaddebuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ChuangjingroaddebuffView:bindEvents()
	ChuangjingroaddebuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ChuangjingroaddebuffView:buildUI()
	ChuangjingroaddebuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ChuangjingroaddebuffView:onExit()
	ChuangjingroaddebuffView.super.onExit(self)
	self._scrollList:dispose()
end

function ChuangjingroaddebuffView:onEnter()
	ChuangjingroaddebuffView.super.onEnter(self)

	self._activityId = 396001

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])

	if actId > 0 then
		self._activityId = actId
	end

	local list = ChuangJingRoadConfig.instance:getDebuffListById(self._activityId) or {}

	self._scrollList:reloadData(list)
end

function ChuangjingroaddebuffView:_updateCell(view, cell, data, tag)
	local nameText = goutil.findChildTextComponent(cell, "nameText")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	nameText.text = "通关区域数量:" .. data.zoneNum
	txtDesc.text = data.buffDesc
end

function ChuangjingroaddebuffView:_clearCell(cell)
	return
end

return ChuangjingroaddebuffView
