-- chunkname: @modules/logic/rouge2/map/view/piecechoice/Rouge2_MapPieceChoiceViewExtend.lua

module("modules.logic.rouge2.map.view.piecechoice.Rouge2_MapPieceChoiceViewExtend", package.seeall)

local Rouge2_MapPieceChoiceViewExtend = class("Rouge2_MapPieceChoiceViewExtend", BaseView)

function Rouge2_MapPieceChoiceViewExtend:onInitView()
	self._btnContinue = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_DialogueList/#btn_Continue")
	self._txtContinue = gohelper.findChildText(self.viewGO, "Right/#go_DialogueList/#btn_Continue/#txt_Continue")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapPieceChoiceViewExtend:addEvents()
	self._btnContinue:AddClickListener(self._btnContinueOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onPlayDialogueDone, self._onPlayDialogueDone, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeChoiceViewState, self._onChangeState, self)
end

function Rouge2_MapPieceChoiceViewExtend:removeEvents()
	self._btnContinue:RemoveClickListener()
end

function Rouge2_MapPieceChoiceViewExtend:_editableInitView()
	gohelper.setActive(self._btnSkip.gameObject, false)
end

function Rouge2_MapPieceChoiceViewExtend:onOpen()
	self.pieceMo = self.viewParam
end

function Rouge2_MapPieceChoiceViewExtend:_btnContinueOnClick()
	if not self.pieceMo or self.pieceMo:isFinish() or #self.pieceMo:getCanselectIds() <= 0 then
		self.viewContainer._views[1]:triggerHandle()

		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSwitch2SelectChoice)
end

function Rouge2_MapPieceChoiceViewExtend:_onPlayDialogueDone()
	self:refreshContinueTitle()
	gohelper.setActive(self._btnContinue.gameObject, true)
end

function Rouge2_MapPieceChoiceViewExtend:_onChangeState(state)
	if state == self._state then
		return
	end

	self._state = state

	self:refreshContinueTitle()
	gohelper.setActive(self._btnContinue.gameObject, state == Rouge2_MapEnum.ChoiceViewState.DialogueDone or state == Rouge2_MapEnum.ChoiceViewState.Finished)
end

function Rouge2_MapPieceChoiceViewExtend:refreshContinueTitle()
	if self.pieceMo then
		local isFinish = self.pieceMo:isFinish()

		self._txtContinue.text = self.pieceMo and luaLang("rouge2_mapchoiceview_end") or luaLang("rouge2_mapchoiceview_continue")
	end
end

return Rouge2_MapPieceChoiceViewExtend
