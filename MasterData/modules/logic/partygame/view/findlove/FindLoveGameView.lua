-- chunkname: @modules/logic/partygame/view/findlove/FindLoveGameView.lua

module("modules.logic.partygame.view.findlove.FindLoveGameView", package.seeall)

local FindLoveGameView = class("FindLoveGameView", PartyGameCommonView)

function FindLoveGameView:onInitView()
	FindLoveGameView.super.onInitView(self)

	self.root = gohelper.findChild(self.viewGO, "root")
	self.animator = self.viewGO:GetComponent("Animator")
	self.line = gohelper.findChild(self.root, "players/lines/FindLoveLineItem/line")
	self.textRound = gohelper.findChildText(self.root, "textRound")
	self.gameTask = gohelper.findChild(self.root, "gameTask")
	self.gameTaskAnimator = self.gameTask:GetComponent("Animator")
	self.textQuestion = gohelper.findChildText(self.gameTask, "textQuestion")
	self.question = gohelper.findChild(self.root, "question")
	self.question1 = gohelper.findChild(self.root, "question/question1")
	self.question2 = gohelper.findChild(self.root, "question/question2")
	self.question3 = gohelper.findChild(self.root, "question/question3")
	self.question4 = gohelper.findChild(self.root, "question/question4")
	self.items = gohelper.findChild(self.root, "players/items")
	self.lines = gohelper.findChild(self.root, "players/lines")
	self.roundbg_light = gohelper.findChild(self.root, "roundbg/roundbg_light")
	self.roundLightAnim = self.roundbg_light:GetComponent(typeof(UnityEngine.Animation))
	self.FindLovePlayerItem = gohelper.findChild(self.items, "FindLovePlayerItem")
	self.FindLoveLineItem = gohelper.findChild(self.lines, "FindLoveLineItem")
	self.FindLoveHeadItem = gohelper.findChild(self.root, "FindLoveHeadItem")

	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = FindLoveQuestionItem
	self.questionList = GameFacade.createSimpleListComp(self.question, scrollParam, nil, self.viewContainer)

	self.questionList:setOnClickItem(self.onClickQuestionFunc, self)
	self.questionList:addCustomItem(self.question1)
	self.questionList:addCustomItem(self.question2)
	self.questionList:addCustomItem(self.question3)
	self.questionList:addCustomItem(self.question4)

	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = FindLovePlayerItem
	self.playerList = GameFacade.createSimpleListComp(self.items, scrollParam, self.FindLovePlayerItem, self.viewContainer)

	gohelper.setActive(self.gameTask, false)

	self.FindLoveGameInterface = PartyGameCSDefine.FindLoveGameInterface
end

function FindLoveGameView:onCreate()
	self.playerMoList = PartyGameModel.instance:getCurGamePlayerList()

	local ownMo = PartyGameModel.instance:getMainPlayerMo()
	local playerDatas = {}
	local num = #self.playerMoList

	gohelper.setActive(self.line, num > 2)

	if num == 2 then
		for i, gamePartyPlayerMo in ipairs(self.playerMoList) do
			if not gamePartyPlayerMo:isMainPlayer() then
				table.insert(playerDatas, {
					gamePartyPlayerMo = gamePartyPlayerMo,
					num = num
				})
			end
		end

		table.insert(playerDatas, 1, {
			gamePartyPlayerMo = ownMo,
			num = num
		})
	elseif num == 4 then
		if not PartyGameModel.instance:getCurGameIsTeamType() then
			for i, gamePartyPlayerMo in ipairs(self.playerMoList) do
				if not gamePartyPlayerMo:isMainPlayer() then
					table.insert(playerDatas, {
						gamePartyPlayerMo = gamePartyPlayerMo,
						num = num
					})
				end
			end

			table.insert(playerDatas, 2, {
				gamePartyPlayerMo = ownMo,
				num = num
			})
		else
			local index = 3

			for i, gamePartyPlayerMo in ipairs(self.playerMoList) do
				if gamePartyPlayerMo.tempType == ownMo.tempType then
					if gamePartyPlayerMo:isMainPlayer() then
						playerDatas[2] = {
							gamePartyPlayerMo = gamePartyPlayerMo,
							num = num
						}
					else
						playerDatas[1] = {
							gamePartyPlayerMo = gamePartyPlayerMo,
							num = num
						}
					end
				else
					playerDatas[index] = {
						gamePartyPlayerMo = gamePartyPlayerMo,
						num = num
					}
					index = index + 1
				end
			end
		end
	else
		for i, gamePartyPlayerMo in ipairs(self.playerMoList) do
			table.insert(playerDatas, {
				gamePartyPlayerMo = gamePartyPlayerMo,
				num = num
			})
		end
	end

	self.playerList:setData(playerDatas)

	if num == 2 then
		self.animator:Play("open2", 0, 0)
	else
		self.animator:Play("open1", 0, 0)
	end

	local datas = {}

	for i = 1, 4 do
		table.insert(datas, {
			answerIndex = i,
			context = self,
			FindLoveHeadItem = self.FindLoveHeadItem
		})
	end

	self.questionList:setData(datas)
end

function FindLoveGameView:onViewUpdate()
	local round = self.FindLoveGameInterface.GetRound()
	local maxRound = self.FindLoveGameInterface.GetMaxRound()

	if self.round ~= round then
		self.round = round
		self.textRound.text = GameUtil.getSubPlaceholderLuaLang(luaLang("PartyGameRoundTip_2"), {
			round,
			maxRound
		})

		self.roundLightAnim:Play()
	end

	local isShowGameTask = self.FindLoveGameInterface.IsShowGameTask()

	if self.isShowGameTask ~= isShowGameTask then
		self.isShowGameTask = isShowGameTask

		if isShowGameTask then
			gohelper.setActive(self.gameTask, true)
			self.gameTaskAnimator:Play("in")

			local questionId = self.FindLoveGameInterface.GetQuestionId()
			local cfg = lua_partygame_findheart_question.configDict[questionId]

			self.textQuestion.text = cfg.question
		else
			self.gameTaskAnimator:Play("out")
		end
	end

	local quesItems = self.questionList:getItems()
	local isShowQuestion = self.FindLoveGameInterface.IsShowQuestion()
	local isShowQueStateChange = self.isShowQuestion ~= isShowQuestion

	self.isShowQuestion = isShowQuestion

	if isShowQueStateChange then
		for i, item in ipairs(quesItems) do
			item:refreshQuestion()
		end
	end

	if isShowQueStateChange and isShowQuestion then
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame14.play_ui_bulaochun_title_appear)
	end

	if isShowQuestion then
		for i, item in ipairs(quesItems) do
			item:refreshState()
			item:refreshPlayerSelect()
		end
	elseif isShowQueStateChange and not isShowQuestion then
		for i, item in ipairs(quesItems) do
			item:refreshState()
			item:refreshPlayerSelect()
		end
	end

	self.isAnswering = self.FindLoveGameInterface.IsAnswering()

	local isEndDisplay = self.FindLoveGameInterface.IsEndDisplay()

	if self.isEndDisplay ~= isEndDisplay then
		self.isEndDisplay = isEndDisplay

		local items = self.playerList:getItems()

		for i, item in ipairs(items) do
			item:refreshScoreAdd()

			if isEndDisplay then
				item:playScoreAnim()
			end
		end
	end
end

function FindLoveGameView:onClickQuestionFunc(findLoveQuestionItem)
	if self.isAnswering and self.FindLoveGameInterface.GetAnswerId(findLoveQuestionItem.answerIndex) > 0 and not self.FindLoveGameInterface.IsSelectAnswer() then
		logNormal("找爱心打印 选择答案，位置：" .. findLoveQuestionItem.itemIndex)
		self.FindLoveGameInterface.SelectAnswer(findLoveQuestionItem.itemIndex)
	end
end

return FindLoveGameView
