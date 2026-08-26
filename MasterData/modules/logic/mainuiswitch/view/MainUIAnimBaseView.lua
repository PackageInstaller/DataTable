-- chunkname: @modules/logic/mainuiswitch/view/MainUIAnimBaseView.lua

module("modules.logic.mainuiswitch.view.MainUIAnimBaseView", package.seeall)

local MainUIAnimBaseView = class("MainUIAnimBaseView", BaseView)

function MainUIAnimBaseView:ctor(skinId, viewGo)
	self._skinId = skinId
	self.viewGO = viewGo

	self:onInitView()
	self:addEvents()
end

function MainUIAnimBaseView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainUIAnimBaseView:addEvents()
	return
end

function MainUIAnimBaseView:removeEvents()
	return
end

function MainUIAnimBaseView:_editableInitView()
	return
end

function MainUIAnimBaseView:onShow()
	return
end

function MainUIAnimBaseView:onDestroyView()
	self:removeEvents()
end

return MainUIAnimBaseView
