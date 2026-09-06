-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LionculturetipView.lua

module("logic.extensions.lionculture.view.LionculturetipView", package.seeall)

local LionculturetipView = class("LionculturetipView", ViewComponent)

function LionculturetipView:ctor()
	LionculturetipView.super.ctor(self)
end

function LionculturetipView:unbindEvents()
	LionculturetipView.super.unbindEvents(self)
	self._btnBg:RemoveClickListener()
end

function LionculturetipView:bindEvents()
	LionculturetipView.super.bindEvents(self)
	self._btnBg:AddClickListener(function()
		self:close()
	end, self)
end

function LionculturetipView:buildUI()
	LionculturetipView.super.buildUI(self)

	self._btnBg = self:getBtn("bg")
	self._descText = self:getTxt("bubble/txtDesc")
end

function LionculturetipView:onExit()
	LionculturetipView.super.onExit(self)
end

function LionculturetipView:onEnter()
	LionculturetipView.super.onEnter(self)

	self._descText.text = self:getFirstParam()
end

return LionculturetipView
