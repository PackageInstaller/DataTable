-- chunkname: @modules/logic/partygame/view/whichmore/WhichMoreGameView.lua

module("modules.logic.partygame.view.whichmore.WhichMoreGameView", package.seeall)

local WhichMoreGameView = class("WhichMoreGameView", PartyGameCommonView)

function WhichMoreGameView:onInitView()
	WhichMoreGameView.super.onInitView(self)

	self.root = gohelper.findChild(self.viewGO, "root")
	self.cards = gohelper.findChild(self.root, "cards")
	self.answerCards = gohelper.findChild(self.root, "answerCards")
	self.WhichMoreCardItem = gohelper.findChild(self.cards, "WhichMoreCardItem")
	self.WhichMoreAnswerCardItem = gohelper.findChild(self.answerCards, "WhichMoreAnswerCardItem")
	self.WhichMorePlayerHead = gohelper.findChild(self.root, "WhichMorePlayerHead")
	self.goSpine = gohelper.findChild(self.root, "goSpine")
	self.goScoreAdd = gohelper.findChild(self.root, "textPlayerScoreAdd")
	self.textPlayerScoreAdd = gohelper.findChildText(self.root, "textPlayerScoreAdd/#txt_addscore")
	self.cardsGridLayout = self.cards:GetComponent(gohelper.Type_GridLayoutGroup)
	self.WhichMoreGameInterface = PartyGameCSDefine.WhichMoreGameInterface

	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = WhichMoreCardItem
	self.cardList = GameFacade.createSimpleListComp(self.cards, scrollParam, self.WhichMoreCardItem, self.viewContainer)

	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = WhichMoreAnswerCardItem
	self.answerCardList = GameFacade.createSimpleListComp(self.answerCards, scrollParam, self.WhichMoreAnswerCardItem, self.viewContainer)

	self.answerCardList:setOnClickItem(self.onClickAnswerFunc, self)
end

function WhichMoreGameView:onCreateCompData()
	self.partyGameCountDownData = {
		getCountDownFunc = self.getCountDownFunc,
		context = self
	}
end

function WhichMoreGameView:onCreate()
	self.playerIndex = self.WhichMoreGameInterface.GetMainPlayerIndex()

	self:refreshGridLayout()

	local datas = {}

	self.answerOptionArray = self.WhichMoreGameInterface.GetAnswerOptionArray()

	for i = 0, self.answerOptionArray.Length - 1 do
		local resId = self.answerOptionArray[i]

		table.insert(datas, {
			id = i + 1,
			resId = resId,
			context = self,
			WhichMorePlayerHead = self.WhichMorePlayerHead
		})
	end

	self.answerCardList:setData(datas)
	self:refreshCards()
	self:refreshSpine()
end

function WhichMoreGameView:onDestroy()
	return
end

function WhichMoreGameView:onViewUpdate()
	local isShowRoundTip = self.WhichMoreGameInterface.IsShowRoundTip()
	local cardProcessRound = self.WhichMoreGameInterface.GetCardProcessRound()
	local isAnswering = self.WhichMoreGameInterface.IsAnswering()
	local isRoundSettle = self.WhichMoreGameInterface.IsRoundSettle()
	local isShowAnswer = isRoundSettle or isAnswering

	if self.isShowRoundTip ~= isShowRoundTip then
		self.isShowRoundTip = isShowRoundTip

		if isShowRoundTip then
			local maxRound = self.WhichMoreGameInterface.GetMaxRound()

			self.partyGameRoundTip:setRoundData(cardProcessRound, maxRound)
		end
	end

	if self.cardProcessRound ~= cardProcessRound then
		self.cardProcessRound = cardProcessRound

		self:refreshGridLayout()
		self:refreshCards()
	else
		local cards = self.cardList:getItems()

		for i, v in ipairs(cards) do
			v:frameTick()
		end
	end

	if self.isAnswering ~= isAnswering then
		self.isAnswering = isAnswering
	end

	if self.isShowAnswer ~= isShowAnswer then
		self.isShowAnswer = isShowAnswer

		gohelper.setActive(self.answerCards, isShowAnswer)
		self.answerCardList:setSelect(nil)
	end

	local cards = self.answerCardList:getItems()

	for i, v in ipairs(cards) do
		v:frameTick(self.isShowAnswer)
	end

	if self.isRoundSettle ~= isRoundSettle then
		self.isRoundSettle = isRoundSettle

		gohelper.setActive(self.goScoreAdd, isRoundSettle)

		if isRoundSettle then
			local add = self.WhichMoreGameInterface.GetPlayerScoreAdd(self.playerIndex)

			self.textPlayerScoreAdd.text = add > 0 and "+" .. add or ""

			local rank = self.WhichMoreGameInterface.GetPlayerRoundRank(self.playerIndex)
			local playerCount = self.WhichMoreGameInterface.GetPlayerCount()

			if add > 0 and rank <= playerCount / 2 then
				self.spine:playAnim("happyLoop", false, true)
			else
				self.spine:playAnim("sad", false, true)
			end

			local items = self._playerInfoComp:getPlayerItems()

			for i, v in ipairs(items) do
				local value = self.WhichMoreGameInterface.GetPlayerScoreAdd(v._mo.index)

				if value > 0 then
					v:playScoreAdd(value)
				end
			end
		end
	end
end

function WhichMoreGameView:getCountDownFunc()
	local t = self.WhichMoreGameInterface.GetAnswerRemainTimeS()

	if t > 0 then
		return t
	end
end

function WhichMoreGameView:refreshGridLayout()
	local cardProcessRound = self.WhichMoreGameInterface.GetCardProcessRound()

	if cardProcessRound == 0 then
		cardProcessRound = 1
	end

	local cfg = lua_partygame_whichmore.configDict[cardProcessRound]
	local rc = string.splitToNumber(cfg.picture, "#")
	local xNum = rc[1]
	local yNum = rc[2]
	local scale = 1

	if xNum == 6 then
		scale = 0.95
	elseif xNum == 7 then
		scale = 0.9
	end

	local cellSizeX = 244 * scale
	local cellSizeY = 292 * scale
	local xSpace = 40
	local ySpace = 10

	if xNum == 6 then
		xSpace = 7
	elseif xNum == 7 then
		xSpace = -7
	end

	self.cardsGridLayout.cellSize = Vector2(cellSizeX, cellSizeY)
	self.cardsGridLayout.spacing = Vector2(xSpace, ySpace)

	local width = xNum * cellSizeX + (xNum - 1) * xSpace
	local height = yNum * cellSizeY + (yNum - 1) * ySpace

	recthelper.setSize(self.cards.transform, width, height)
end

function WhichMoreGameView:refreshCards()
	local array = self.WhichMoreGameInterface.GetCards()
	local datas = {}

	for i = 0, array.Length - 1 do
		local id = array[i]

		table.insert(datas, {
			id = id,
			resId = self.answerOptionArray[id - 1]
		})
	end

	self.cardList:setData(datas)
end

function WhichMoreGameView:onClickAnswerFunc(whichMoreAnswerCardItem)
	if self.isAnswering then
		self.WhichMoreGameInterface.AnswerQuestion(whichMoreAnswerCardItem.itemIndex)
	end
end

function WhichMoreGameView:refreshSpine()
	local mo = PartyGameModel.instance:getMainPlayerMo()

	self.spine = self.spine or MonoHelper.addNoUpdateLuaComOnceToGo(self.goSpine, CommonPartyGamePlayerSpineComp)

	self.spine:initSpine(mo.uid)
end

return WhichMoreGameView
