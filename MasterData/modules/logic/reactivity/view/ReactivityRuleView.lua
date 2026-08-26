-- chunkname: @modules/logic/reactivity/view/ReactivityRuleView.lua

module("modules.logic.reactivity.view.ReactivityRuleView", package.seeall)

local ReactivityRuleView = class("ReactivityRuleView", BaseView)

function ReactivityRuleView:onInitView()
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_go")
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "Mask")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ReactivityRuleView:addEvents()
	self._btnjump:AddClickListener(self._onClickJump, self)
	self._btnclose1:AddClickListener(self._onClickClose, self)
	self._btnclose2:AddClickListener(self._onClickClose, self)
end

function ReactivityRuleView:removeEvents()
	self._btnjump:RemoveClickListener()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

function ReactivityRuleView:_editableInitView()
	return
end

function ReactivityRuleView:onOpen()
	ReactivityRuleModel.instance:refreshList()
end

function ReactivityRuleView:onClose()
	return
end

function ReactivityRuleView:onUpdateParam()
	return
end

function ReactivityRuleView:onDestroyView()
	return
end

function ReactivityRuleView:_onClickJump()
	JumpController.instance:jumpByParam("1#180")
end

function ReactivityRuleView:_onClickClose()
	self:closeThis()
end

return ReactivityRuleView
