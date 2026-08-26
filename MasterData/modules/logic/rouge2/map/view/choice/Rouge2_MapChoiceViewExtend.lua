-- chunkname: @modules/logic/rouge2/map/view/choice/Rouge2_MapChoiceViewExtend.lua

module("modules.logic.rouge2.map.view.choice.Rouge2_MapChoiceViewExtend", package.seeall)

local Rouge2_MapChoiceViewExtend = class("Rouge2_MapChoiceViewExtend", BaseView)

function Rouge2_MapChoiceViewExtend:onInitView()
	self._btnContinue = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_DialogueList/#btn_Continue")
	self._txtContinue = gohelper.findChildText(self.viewGO, "Right/#go_DialogueList/#btn_Continue/#txt_Continue")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapChoiceViewExtend:addEvents()
	self._btnContinue:AddClickListener(self._btnContinueOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeChoiceViewState, self._onChangeState, self)
end

function Rouge2_MapChoiceViewExtend:removeEvents()
	self._btnContinue:RemoveClickListener()
end

function Rouge2_MapChoiceViewExtend:_editableInitView()
	return
end

function Rouge2_MapChoiceViewExtend:onOpen()
	self.nodeMo = self.viewParam
end

function Rouge2_MapChoiceViewExtend:_btnContinueOnClick()
	if self._state == Rouge2_MapEnum.ChoiceViewState.Finish then
		self:closeThis()

		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSwitch2SelectChoice)
end

function Rouge2_MapChoiceViewExtend:_onChangeState(state)
	if state == self._state then
		return
	end

	self._state = state
	self._isFinish = state == Rouge2_MapEnum.ChoiceViewState.Finish
	self._txtContinue.text = self._isFinish and luaLang("rouge2_mapchoiceview_end") or luaLang("rouge2_mapchoiceview_continue")

	gohelper.setActive(self._btnContinue.gameObject, state == Rouge2_MapEnum.ChoiceViewState.DialogueDone or state == Rouge2_MapEnum.ChoiceViewState.Finish)
end

return Rouge2_MapChoiceViewExtend
