-- chunkname: @modules/logic/store/view/StoreSupplementMonthCardTipView.lua

module("modules.logic.store.view.StoreSupplementMonthCardTipView", package.seeall)

local StoreSupplementMonthCardTipView = class("StoreSupplementMonthCardTipView", BaseView)

function StoreSupplementMonthCardTipView:onInitView()
	self._btnClose = gohelper.findChildButton(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSupplementMonthCardTipView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
end

function StoreSupplementMonthCardTipView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function StoreSupplementMonthCardTipView:_editableInitView()
	return
end

function StoreSupplementMonthCardTipView:onUpdateParam()
	return
end

function StoreSupplementMonthCardTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_diqiu_yure_success)
end

function StoreSupplementMonthCardTipView:onClose()
	return
end

function StoreSupplementMonthCardTipView:onDestroyView()
	return
end

return StoreSupplementMonthCardTipView
