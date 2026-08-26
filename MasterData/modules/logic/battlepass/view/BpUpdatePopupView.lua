-- chunkname: @modules/logic/battlepass/view/BpUpdatePopupView.lua

module("modules.logic.battlepass.view.BpUpdatePopupView", package.seeall)

local BpUpdatePopupView = class("BpUpdatePopupView", BaseView)

function BpUpdatePopupView:onInitView()
	return
end

function BpUpdatePopupView:onOpen()
	self.cfg = self.viewParam.cfg
end

function BpUpdatePopupView:onClose()
	return
end

function BpUpdatePopupView:onDestroyView()
	return
end

return BpUpdatePopupView
