-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleQuestionView.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleQuestionView", package.seeall)

local DungeonPuzzleQuestionView = class("DungeonPuzzleQuestionView", BaseView)

function DungeonPuzzleQuestionView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._txttitleen = gohelper.findChildText(self.viewGO, "#txt_titleen")
	self._goquestionlist = gohelper.findChild(self.viewGO, "#go_questionlist")
	self._goquestionitem = gohelper.findChild(self.viewGO, "#go_questionlist/#go_questionitem")
	self._btnsubmit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_questionlist/#btn_submit")
	self._simagepaper = gohelper.findChildSingleImage(self.viewGO, "#simage_paper")
	self._txttitle1 = gohelper.findChildText(self.viewGO, "info/#txt_title1")
	self._txtdesc1 = gohelper.findChildText(self.viewGO, "info/#txt_desc1")
	self._txttitleen1 = gohelper.findChildText(self.viewGO, "info/#txt_titleen1")
	self._txtdescen1 = gohelper.findChildText(self.viewGO, "info/#txt_descen1")
	self._txttitle2 = gohelper.findChildText(self.viewGO, "info/#txt_title2")
	self._txtdesc2 = gohelper.findChildText(self.viewGO, "info/#txt_desc2")
	self._txttitleen2 = gohelper.findChildText(self.viewGO, "info/#txt_titleen2")
	self._txtdescen2 = gohelper.findChildText(self.viewGO, "info/#txt_descen2")
	self._txttitle3 = gohelper.findChildText(self.viewGO, "info/#txt_title3")
	self._txtdesc3 = gohelper.findChildText(self.viewGO, "info/#txt_desc3")
	self._txttitleen3 = gohelper.findChildText(self.viewGO, "info/#txt_titleen3")
	self._txtdescen3 = gohelper.findChildText(self.viewGO, "info/#txt_descen3")
	self._gomasklist = gohelper.findChild(self.viewGO, "#go_masklist")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonPuzzleQuestionView:addEvents()
	self._btnsubmit:AddClickListener(self._btnsubmitOnClick, self)
end

function DungeonPuzzleQuestionView:removeEvents()
	self._btnsubmit:RemoveClickListener()
end

function DungeonPuzzleQuestionView:_btnsubmitOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if DungeonPuzzleQuestionModel.instance:getIsReady() and not self._isClear then
		local questionCount = DungeonPuzzleQuestionModel.instance:getQuestionCount()

		for i = 1, questionCount do
			local text = self._questionItems[i].input:GetText()
			local answerSet = DungeonPuzzleQuestionModel.instance:getAnswers(i)

			if not answerSet[text] then
				GameFacade.showToast(ToastEnum.DungeonMapInteractive)

				return
			end
		end

		self._isClear = true

		self:_disableInput()
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
		gohelper.setActive(self._gofinish, true)
		gohelper.setActive(self._btnsubmit.gameObject, false)
		GameFacade.showToast(ToastEnum.DungeonPuzzle2)

		local elementCo = DungeonPuzzleQuestionModel.instance:getElementCo()

		DungeonRpc.instance:sendPuzzleFinishRequest(elementCo.id)
	elseif self._isClear then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)
	end
end

function DungeonPuzzleQuestionView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("full/bg_jiemi_beijigntu"))
	self._simagepaper:LoadImage(ResUrl.getDungeonPuzzleBg("bg_jiemi_zhizhang_1"))

	self._questionItems = {}
	self._isClear = false
end

function DungeonPuzzleQuestionView:onUpdateParam()
	self:onOpen()
end

function DungeonPuzzleQuestionView:onOpen()
	self:_refreshUI()
end

function DungeonPuzzleQuestionView:_refreshUI()
	for index = 1, DungeonPuzzleEnum.hintCount do
		local strTitle, strTitleEn, strDesc, strDescEn = DungeonPuzzleQuestionModel.instance:getHint(index)

		self["_txttitle" .. tostring(index)].text = strTitle
		self["_txtdesc" .. tostring(index)].text = strDesc
		self["_txttitleen" .. tostring(index)].text = strTitleEn
		self["_txtdescen" .. tostring(index)].text = strDescEn
	end

	local title, titleEn = DungeonPuzzleQuestionModel.instance:getQuestionTitle()

	self._txttitle.text = title
	self._txttitleen.text = titleEn

	self:_refreshQuestionList()
end

function DungeonPuzzleQuestionView:_refreshQuestionList()
	local questionCount = DungeonPuzzleQuestionModel.instance:getQuestionCount()

	for i = 1, questionCount do
		local item = self._questionItems[i]

		item = item or self:_newQuestionItem(i)

		self:_refreshItemUI(item, i)
	end

	for i = questionCount + 1, #self._questionItems do
		local item = self._questionItems[i]

		item.go:SetActive(false)
	end
end

function DungeonPuzzleQuestionView:_newQuestionItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.clone(self._goquestionitem, self._goquestionlist, "question_" .. tostring(index))

	item.go = itemGo
	item.input = gohelper.findChildTextMeshInputField(itemGo, "answer")
	item.inputTMT = item.input.gameObject:GetComponent(gohelper.Type_TMPInputField)
	item.txtQuestion = gohelper.findChildText(itemGo, "question")
	self._questionItems[index] = item

	return item
end

function DungeonPuzzleQuestionView:_refreshItemUI(item, index)
	item.txtQuestion.text = DungeonPuzzleQuestionModel.instance:getQuestion(index)

	item.go:SetActive(true)
end

function DungeonPuzzleQuestionView:_disableInput()
	for _, item in pairs(self._questionItems) do
		item.inputTMT.readOnly = true
	end
end

function DungeonPuzzleQuestionView:_onPuzzleFinish()
	return
end

function DungeonPuzzleQuestionView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local elementCo = DungeonPuzzleQuestionModel.instance:getElementCo()

	if elementCo and DungeonMapModel.instance:hasMapPuzzleStatus(elementCo.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, elementCo.id)
	end

	DungeonPuzzleQuestionModel.instance:release()
end

function DungeonPuzzleQuestionView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagepaper:UnLoadImage()
end

return DungeonPuzzleQuestionView
