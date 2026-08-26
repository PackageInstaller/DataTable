-- chunkname: @modules/logic/summon/view/custompick/SummonCustomPickChoice.lua

module("modules.logic.summon.view.custompick.SummonCustomPickChoice", package.seeall)

local SummonCustomPickChoice = class("SummonCustomPickChoice", BaseView)

function SummonCustomPickChoice:onInitView()
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._txtnum = gohelper.findChildText(self.viewGO, "Tips2/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonCustomPickChoice:addEvents()
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
end

function SummonCustomPickChoice:removeEvents()
	self._btnok:RemoveClickListener()
	self._btncancel:RemoveClickListener()
end

function SummonCustomPickChoice:_editableInitView()
	return
end

function SummonCustomPickChoice:onDestroyView()
	SummonCustomPickChoiceController.instance:onCloseView()
end

function SummonCustomPickChoice:onOpen()
	logNormal("SummonCustomPickChoice onOpen")
	self.addEventCb(self, SummonController.instance, SummonEvent.onCustomPicked, self.handleCusomPickCompleted, self)
	self.addEventCb(self, SummonCustomPickChoiceController.instance, SummonEvent.onCustomPickListChanged, self.refreshUI, self)
	SummonCustomPickChoiceController.instance:onOpenView(self.viewParam.poolId)
end

function SummonCustomPickChoice:onClose()
	return
end

function SummonCustomPickChoice:_btnokOnClick()
	SummonCustomPickChoiceController.instance:trySendChoice()
end

function SummonCustomPickChoice:_btncancelOnClick()
	self:closeThis()
end

function SummonCustomPickChoice:_btnbgOnClick()
	self:closeThis()
end

function SummonCustomPickChoice:refreshUI()
	local selectCount = SummonCustomPickChoiceListModel.instance:getSelectCount()
	local maxCount = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		selectCount,
		maxCount
	})

	ZProj.UGUIHelper.SetGrayscale(self._btnok.gameObject, selectCount ~= maxCount)
end

function SummonCustomPickChoice:handleCusomPickCompleted()
	self:closeThis()
end

return SummonCustomPickChoice
