-- chunkname: @modules/logic/main/view/MainTempView.lua

module("modules.logic.main.view.MainTempView", package.seeall)

local MainTempView = class("MainTempView", BaseView)

function MainTempView:onInitView()
	self._btnrouge = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rouge")
end

function MainTempView:addEvents()
	self._btnrouge:AddClickListener(self._btnRougeOnClick, self)
end

function MainTempView:removeEvents()
	self._btnrouge:RemoveClickListener()
end

function MainTempView:_btnRougeOnClick()
	RougeController.instance:enterRouge()
end

function MainTempView:onOpen()
	return
end

function MainTempView:_onCloseView()
	return
end

return MainTempView
