-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petmanual/view/PetmanualView.lua

module("logic.extensions.petmanual.view.PetmanualView", package.seeall)

local PetmanualView = class("PetmanualView", ViewComponent)

function PetmanualView:ctor()
	PetmanualView.super.ctor(self)
end

function PetmanualView:buildUI()
	PetmanualView.super.buildUI(self)

	self._btnInfo = {}

	for i = 1, 5 do
		self._btnInfo[i] = {}
		self._btnInfo[i].btn = self:getBtn("btns/btn_" .. i)
		self._btnInfo[i].icon = self:getGo("icon_" .. i)
	end

	self._closeBtn = self:getBtn("close")
end

function PetmanualView:bindEvents()
	PetmanualView.super.bindEvents(self)

	for index, value in ipairs(self._btnInfo) do
		value.btn:AddClickListener(function()
			self:_onClickBtn(index)
		end, self)
	end

	self._closeBtn:AddClickListener(self.close, self)
end

function PetmanualView:unbindEvents()
	PetmanualView.super.unbindEvents(self)

	for index, value in ipairs(self._btnInfo) do
		value.btn:RemoveClickListener()
	end

	self._closeBtn:RemoveClickListener()
end

function PetmanualView:destroyUI()
	PetmanualView.super.destroyUI(self)
end

function PetmanualView:onEnter()
	PetmanualView.super.onEnter(self)
end

function PetmanualView:onEnterFinished()
	PetmanualView.super.onEnterFinished(self)
end

function PetmanualView:onExit()
	PetmanualView.super.onExit(self)
end

function PetmanualView:onExitFinished()
	PetmanualView.super.onExitFinished(self)
end

function PetmanualView:_onClickBtn(index)
	for i, value in ipairs(self._btnInfo) do
		goutil.setActive(value.icon, i == index)
	end
end

return PetmanualView
