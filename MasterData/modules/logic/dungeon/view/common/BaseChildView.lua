-- chunkname: @modules/logic/dungeon/view/common/BaseChildView.lua

module("modules.logic.dungeon.view.common.BaseChildView", package.seeall)

local BaseChildView = class("BaseChildView", UserDataDispose)

function BaseChildView:initView(go, viewParam)
	self:__onInit()

	self.viewParam = viewParam
	self.viewGO = go

	self:onInitView()
	self:addEvents()
	self:onOpen()
end

function BaseChildView:updateParam(viewParam)
	self.viewParam = viewParam

	self:onUpdateParam()
end

function BaseChildView:onOpenFinish()
	return
end

function BaseChildView:destroyView()
	self:onClose()
	self:removeEvents()
	self:onDestroyView()

	if self.viewGO then
		gohelper.destroy(self.viewGO)

		self.viewGO = nil
	end

	self:__onDispose()
end

return BaseChildView
