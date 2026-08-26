-- chunkname: @modules/logic/gm/view/GMFightSimulateView.lua

module("modules.logic.gm.view.GMFightSimulateView", package.seeall)

local GMFightSimulateView = class("GMFightSimulateView", BaseView)

function GMFightSimulateView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
end

function GMFightSimulateView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
end

function GMFightSimulateView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function GMFightSimulateView:onOpen()
	GMFightSimulateLeftModel.instance:onOpen()
end

function GMFightSimulateView:onClose()
	ViewMgr.instance:openView(ViewName.GMToolView)
end

return GMFightSimulateView
