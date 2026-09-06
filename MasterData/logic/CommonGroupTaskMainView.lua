-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/CommonGroupTaskMainView.lua

module("logic.extensions.caiqingdraw.view.CommonGroupTaskMainView", package.seeall)

local CommonGroupTaskMainView = class("CommonGroupTaskMainView", EventTaskTabGroupFrameView)

function CommonGroupTaskMainView:buildUI()
	CommonGroupTaskMainView.super.buildUI(self)

	self._mask = self:getGo("mask")
end

function CommonGroupTaskMainView:onExit()
	CommonGroupTaskMainView.super.onExit(self)
	GameUtil.SetActive(self._mask, true)
end

function CommonGroupTaskMainView:onEnter()
	GameUtil.SetActive(self._mask, false)

	local params = self:getOpenParam() or {}

	self._groupId = checknumber(params[2])

	if self._groupId == 0 then
		self._groupId = 1
	end

	CommonGroupTaskMainView.super.super.onEnter(self)
end

function CommonGroupTaskMainView:_onClickTab(data, idx)
	self._curTabIdx = idx

	self:_onUpdateUI()
end

return CommonGroupTaskMainView
