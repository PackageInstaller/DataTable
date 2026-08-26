-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/puzzle/FairyLandPuzzle4.lua

module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle4", package.seeall)

local FairyLandPuzzle4 = class("FairyLandPuzzle4", FairyLandPuzzleBase)
local allowedCharacters = "0123456789%+%-%*%/%."

function FairyLandPuzzle4:onInitView()
	self._shapeGO = gohelper.findChild(self.viewGO, "main/#go_Shape/4")
	self.goPuzzle = gohelper.findChild(self._shapeGO, "#go_NumPuzzleBG")
	self.txtQuestion = gohelper.findChildTextMesh(self.goPuzzle, "#txt_Equation")
	self.goInput = gohelper.findChild(self._shapeGO, "#go_Input")
	self.btnConfirm = gohelper.findChildButtonWithAudio(self.goInput, "#go_SelectFrame/#go_Confirm")
	self.goInputNum = gohelper.findChild(self.goInput, "#inputNum")
	self.inputNum = gohelper.findChildTextMeshInputField(self.goInput, "#inputNum")

	self.inputNum:AddOnValueChanged(self.onAddOnValueChanged, self)

	self.inputTxtGO = gohelper.findChild(self.goInput, "#inputNum/Text Area/Text")
	self.animInput = SLFramework.AnimatorPlayer.Get(self.inputTxtGO)
	self.numComp = FairyLandFullScreenNumber.New()

	local param = {}

	param.viewGO = self.viewGO

	self.numComp:init(param)
	self.addClickCb(self, self.btnConfirm, self.onClickBtnConfirm, self)
	gohelper.setActive(self.btnConfirm, false)

	local s = string.gsub(allowedCharacters, "[%-%[%]%^]", "%%%1")

	self.pattern = string.format("^[%s]*$", s)
	self.clearPattern = string.format("[^%s]", s)
end

function FairyLandPuzzle4:onAddOnValueChanged(newText)
	if not string.match(newText, self.pattern) then
		local str = string.gsub(newText, self.clearPattern, "")

		self.inputNum:SetText(str)

		return
	end

	local text = self.inputNum:GetText()

	gohelper.setActive(self.btnConfirm, not string.nilorempty(text))
end

function FairyLandPuzzle4:onClickBtnConfirm()
	local inpText = self.inputNum:GetText()

	if inpText == self.config.answer then
		gohelper.setActive(self.btnConfirm, false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_input_right)
		self.animInput:Play("correct", self.onCorrectAnimEnd, self)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_input_mistake)
		self.animInput:Play("error", self.onErrorAnimEnd, self)
	end
end

function FairyLandPuzzle4:onCorrectAnimEnd()
	self.inputNum:SetText("")
	self.animInput:Play("idle", self.onAnimEnd, self)
	self:finished()
end

function FairyLandPuzzle4:onErrorAnimEnd()
	self.inputNum:SetText("")
	self.animInput:Play("idle", self.onAnimEnd, self)
	self:playErrorTalk()
	self:startCheckTips()
end

function FairyLandPuzzle4:onAnimEnd()
	return
end

function FairyLandPuzzle4:onStart()
	self.txtQuestion.text = self:getQuestion()

	self.inputNum:SetText("")

	local isEnd = self:isEndPuzzle()

	gohelper.setActive(self.goPuzzle, not isEnd)

	if isEnd then
		recthelper.setAnchor(self.goInput.transform, 0, 180)
	else
		self:layoutContent()
	end

	local isPass = FairyLandModel.instance:isPassPuzzle(self.config.id)

	gohelper.setActive(self._shapeGO, false)
	gohelper.setActive(self._shapeGO, not isPass or not isEnd)
	gohelper.setActive(self.goInputNum, not isPass)

	if isEnd and not isPass then
		self:showNumberText()
	end

	self:startCheckTips()
end

function FairyLandPuzzle4:onRefreshView()
	self.txtQuestion.text = self:getQuestion()

	local isEnd = self:isEndPuzzle()
	local isPass = FairyLandModel.instance:isPassPuzzle(self.config.id)

	gohelper.setActive(self._shapeGO, false)
	gohelper.setActive(self._shapeGO, not isPass or not isEnd)
	gohelper.setActive(self.goInputNum, not isPass)

	if not isPass then
		gohelper.setActive(self.goPuzzle, not isEnd)

		if isEnd then
			self.tweenId = ZProj.TweenHelper.DOAnchorPos(self.goInput.transform, 0, 180, 1)

			self:showNumberText()
		else
			self:layoutContent()
		end
	end

	self:startCheckTips()
end

function FairyLandPuzzle4:layoutContent()
	local width = self.txtQuestion.preferredWidth
	local inputWidth = 346
	local txtPos = -inputWidth * 0.5
	local inputPos = width * 0.5

	recthelper.setAnchor(self.txtQuestion.transform, txtPos, 0)
	recthelper.setAnchor(self.goInput.transform, inputPos, 350)
end

function FairyLandPuzzle4:isEndPuzzle()
	return self.config.id == 10
end

function FairyLandPuzzle4:getQuestion()
	local id = self.config.id

	if id == 4 then
		return "1+2+3=1*2*3="
	end

	if id == 5 then
		return "1+2+3=1+2+3=6"
	end

	if id == 6 then
		return "111÷3="
	end

	if id == 7 then
		return "111÷3=37"
	end

	if id == 8 then
		return "2*3*5*7="
	end

	if id == 9 then
		return "2*3*5*7=210"
	end

	return ""
end

function FairyLandPuzzle4:finished()
	self:stopCheckTips()
	gohelper.setActive(self.goInputNum, false)
	FairyLandController.instance:closeDialogView()

	if self:isEndPuzzle() then
		self:showZeroText()
	else
		self:playSuccessTalk()
	end
end

function FairyLandPuzzle4:playSuccessTalk()
	TaskDispatcher.cancelTask(self.playTipsTalk, self)

	if not FairyLandModel.instance:isPassPuzzle(self.config.id) then
		FairyLandRpc.instance:sendResolvePuzzleRequest(self.config.id, self.config.answer)
	end

	self.playTalk(self, self.config.successTalkId, self.onSuccessTalkCallback, self)
end

function FairyLandPuzzle4:onSuccessTalkCallback()
	if self:isEndPuzzle() then
		gohelper.setActive(self._shapeGO, false)
		self:clearNumTween()
		self:openCompleteView()
	end
end

function FairyLandPuzzle4:showNumberText()
	if self.numComp then
		self.numComp:playShowTween()
	end
end

function FairyLandPuzzle4:showZeroText()
	if self.numComp then
		self.numComp:playZeroTween(self.playSuccessTalk, self)
	end
end

function FairyLandPuzzle4:clearNumTween()
	if self.numComp then
		self.numComp:clear()
	end
end

function FairyLandPuzzle4:onDestroyView()
	self.inputNum:RemoveOnValueChanged()
	gohelper.setActive(self._shapeGO, false)

	if self.numComp then
		self.numComp:destory()
	end
end

return FairyLandPuzzle4
