-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/testtab1/view/Testtab1View.lua

module("logic.extensions.testtab1.view.Testtab1View", package.seeall)

local Testtab1View = class("Testtab1View", ViewComponent)

function Testtab1View:ctor()
	Testtab1View.super.ctor(self)
end

function Testtab1View:buildUI()
	Testtab1View.super.buildUI(self)

	self._image = self:getGo("overall/image")
end

function Testtab1View:bindEvents()
	Testtab1View.super.bindEvents(self)
end

function Testtab1View:unbindEvents()
	Testtab1View.super.unbindEvents(self)
end

function Testtab1View:destroyUI()
	Testtab1View.super.destroyUI(self)
end

function Testtab1View:onEnter()
	Testtab1View.super.onEnter(self)
end

function Testtab1View:onEnterFinished()
	Testtab1View.super.onEnterFinished(self)
end

function Testtab1View:onExit()
	Testtab1View.super.onExit(self)
end

function Testtab1View:onExitFinished()
	Testtab1View.super.onExitFinished(self)
end

function Testtab1View:setImageActive(show)
	if self._image then
		self._image.gameObject:SetActive(show)
	end
end

return Testtab1View
