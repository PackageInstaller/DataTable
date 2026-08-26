-- chunkname: @modules/logic/dialogue/view/DialogueChessView.lua

module("modules.logic.dialogue.view.DialogueChessView", package.seeall)

local DialogueChessView = class("DialogueChessView", BaseView)

function DialogueChessView:onInitView()
	self._gochesscontainer = gohelper.findChild(self.viewGO, "#go_chesscontainer")
	self._gochessitem = gohelper.findChild(self.viewGO, "#go_chesscontainer/#go_chessitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DialogueChessView:addEvents()
	return
end

function DialogueChessView:removeEvents()
	return
end

function DialogueChessView:_editableInitView()
	gohelper.setActive(self._gochessitem, false)

	self.chessItemList = {}

	self.addEventCb(self, DialogueController.instance, DialogueEvent.BeforePlayStep, self.onBeforePlayStep, self)
end

function DialogueChessView:onOpenFinish()
	self.openFinishDone = true

	self:onBeforePlayStep(self.tempStepCo)

	self.tempStepCo = nil
end

function DialogueChessView:initChessItem()
	if self.dialogueId then
		return
	end

	self.dialogueId = self.viewContainer.viewParam.dialogueId

	local chessCoList = DialogueConfig.instance:getChessCoList(self.dialogueId)

	if not chessCoList then
		return
	end

	for _, chessCo in ipairs(chessCoList) do
		self:createChessItem(chessCo)
	end
end

function DialogueChessView:onBeforePlayStep(stepCo)
	self:initChessItem()

	if not self.openFinishDone then
		self.tempStepCo = stepCo

		return
	end

	local talkingChessId = stepCo.chessId

	for _, chessItem in ipairs(self.chessItemList) do
		local talking = chessItem.chessCo.id == talkingChessId

		gohelper.setActive(chessItem.goTalking, talking)
		gohelper.setActive(chessItem.goFootShadow, talking)

		if talking then
			chessItem.animator:Play("jump", 0, 0)
		end
	end
end

function DialogueChessView:createChessItem(chessCo)
	local chessItem = self:getUserDataTb_()

	chessItem.go = gohelper.cloneInPlace(self._gochessitem, chessCo.id)

	gohelper.setActive(chessItem.go, true)

	chessItem.animator = chessItem.go:GetComponent(gohelper.Type_Animator)
	chessItem.imageChess = gohelper.findChildSingleImage(chessItem.go, "#chess")

	chessItem.imageChess:LoadImage(ResUrl.getChessDialogueSingleBg(chessCo.res))

	chessItem.goTalking = gohelper.findChild(chessItem.go, "#go_talking")
	chessItem.goFootShadow = gohelper.findChild(chessItem.go, "light2")

	gohelper.setActive(chessItem.goTalking, false)
	gohelper.setActive(chessItem.goFootShadow, false)

	chessItem.chessCo = chessCo

	table.insert(self.chessItemList, chessItem)

	local anchor = string.splitToNumber(chessCo.pos, "#")

	recthelper.setAnchor(chessItem.go.transform, anchor[1], anchor[2])

	return chessItem
end

function DialogueChessView:onClose()
	return
end

function DialogueChessView:onDestroyView()
	for _, chessItem in ipairs(self.chessItemList) do
		chessItem.imageChess:UnLoadImage()
	end
end

return DialogueChessView
