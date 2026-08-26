-- chunkname: @modules/logic/partygame/view/findlove/item/FindLoveQuestionItem.lua

module("modules.logic.partygame.view.findlove.item.FindLoveQuestionItem", package.seeall)

local FindLoveQuestionItem = class("FindLoveQuestionItem", SimpleListItem)

function FindLoveQuestionItem:onInit()
	self.imgQuestion = gohelper.findChildImage(self.viewGO, "imgQuestion")
	self.imgMask = gohelper.findChildImage(self.viewGO, "imgMask")
	self.heads = gohelper.findChild(self.viewGO, "heads")
	self.btnbg = gohelper.findChild(self.viewGO, "btnbg")
	self.normal = gohelper.findChild(self.btnbg, "normal")
	self.canclick = gohelper.findChild(self.btnbg, "canclick")
	self.select = gohelper.findChild(self.btnbg, "select")
	self.wrong = gohelper.findChild(self.btnbg, "wrong")
	self.animator = self.viewGO:GetComponent("Animator")
	self.FindLoveGameInterface = PartyGameCSDefine.FindLoveGameInterface
end

function FindLoveQuestionItem:onItemShow(data)
	self.answerIndex = data.answerIndex
	self.onClickQuestionFunc = data.onClickQuestionFunc
	self.context = data.context
	self.FindLoveHeadItem = data.FindLoveHeadItem

	self:refreshState()
	self:refreshQuestion()
	self:refreshPlayerSelect()
end

function FindLoveQuestionItem:refreshState()
	local isAnswering = self.FindLoveGameInterface.IsAnswering()
	local isEndDisplay = self.FindLoveGameInterface.IsEndDisplay()
	local haveAnswer = (isAnswering or isEndDisplay) and self.FindLoveGameInterface.GetAnswerId(self.answerIndex) > 0
	local isSelectAnswer = (isAnswering or isEndDisplay) and self.FindLoveGameInterface.IsSelectAnswer()

	gohelper.setActive(self.canclick, haveAnswer and not isSelectAnswer)
	gohelper.setActive(self.select, isAnswering and self.answerIndex == self.FindLoveGameInterface.GetSelectAnswerId())

	local correctIndex = self.FindLoveGameInterface.GetCorrectAnswerPosIndex()

	gohelper.setActive(self.wrong, isEndDisplay and (not haveAnswer or self.answerIndex ~= correctIndex))

	if haveAnswer then
		local answerId = self.FindLoveGameInterface.GetAnswerId(self.answerIndex)

		UISpriteSetMgr.instance:setFindLoveGameSprite(self.imgQuestion, answerId)
		UISpriteSetMgr.instance:setFindLoveGameSprite(self.imgMask, answerId)
		gohelper.setActive(self.imgMask.gameObject, isEndDisplay and self.answerIndex ~= correctIndex)
	end
end

function FindLoveQuestionItem:refreshQuestion()
	local isShowQuestion = self.FindLoveGameInterface.IsShowQuestion()

	if isShowQuestion then
		local answerId = self.FindLoveGameInterface.GetAnswerId(self.answerIndex)

		if answerId <= 0 then
			self.animator:Play("out")

			return
		end

		self.animator:Play("in")
	else
		self.animator:Play("out")
	end
end

function FindLoveQuestionItem:refreshPlayerSelect()
	if self.headList == nil then
		local scrollParam = SimpleListParam.New()

		scrollParam.cellClass = FindLoveHeadItem
		self.headList = GameFacade.createSimpleListComp(self.heads, scrollParam, self.FindLoveHeadItem, self.viewContainer)
	end

	local datas = {}

	if self.FindLoveGameInterface.IsShowQuestion() then
		local array = self.FindLoveGameInterface.GetQuestionSelectPlayers(self.answerIndex)

		for i = 0, array.Length - 1 do
			local playerIndex = array[i]

			if playerIndex > 0 then
				local mo = PartyGameModel.instance:getPlayerMoByIndex(playerIndex)

				table.insert(datas, {
					isAutoShowArrow = true,
					uid = mo.uid
				})
			end
		end
	end

	self.headList:setData(datas)
end

return FindLoveQuestionItem
