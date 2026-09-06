-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckymoney/view/LuckyMoneyMainView.lua

module("logic.extensions.luckymoney.view.LuckyMoneyMainView", package.seeall)

local LuckyMoneyMainView = class("LuckyMoneyMainView", ViewComponent)

function LuckyMoneyMainView:ctor()
	LuckyMoneyMainView.super.ctor(self)
end

function LuckyMoneyMainView:buildUI()
	LuckyMoneyMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("leftTop/time/txt")
	self._txtPlayTime = self:getTxt("gameTime/gameTimes/txtPlayTime")
	self._cells = self:getGo("cells")
	self._cellList = {}

	for i = 1, 6 do
		local curCell = {}
		local cellGo = self:getGo("cells/cell" .. i)

		curCell.go = cellGo
		curCell.imgPet = goutil.findChild(cellGo, "imgPet")
		curCell.btnGoto = goutil.findChild(cellGo, "btnGoto")

		table.insert(self._cellList, curCell)
	end

	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._tableview = self:getGo("scorollReward/tableview")
	self._scrollRewardList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("total/txtProgress")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
	self._sequence = DG.Tweening.DOTween.Sequence()
	self._endPos = self:getGo("endPos")
end

function LuckyMoneyMainView:bindEvents()
	LuckyMoneyMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function LuckyMoneyMainView:unbindEvents()
	LuckyMoneyMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for idx, cell in ipairs(self._cellList) do
		GameUtil.rmClickHandler(cell.btnGoto)
	end
end

function LuckyMoneyMainView:onEnter()
	LuckyMoneyMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_LuckyMoneyGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_LuckyMoneyGainProgressPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = LuckyMoneyController.instance:getActivityId()
	end

	self._activityType = LuckyMoneyController.instance:getActivityType()
	self._actCfg = LuckyMoneyConfig.instance:getLuckyMoneyActData(self._activityId)
	self._petCfg = LuckyMoneyConfig.instance:getLuckyMoneyPetData(self._activityId)
	self._wordCfg = LuckyMoneyConfig.instance:getLuckyMoneyWordData(self._activityId)
	self._progressCfg = LuckyMoneyConfig.instance:getLuckyMoneProgressData(self._activityId)
	self._info = LuckyMoneyModel.instance:getInfo(self._activityId)

	local key = LuckyMoneyWordView.LUCKY_MONEY_KEY .. self._activityId
	local keySelectWord = LuckyMoneyWordView.LUCKY_MONEY_KEY_SELECT_WORD .. self._activityId
	local choosePetId = GameUtil.getUserData(key)
	local selectWordIdx = GameUtil.getUserData(keySelectWord)

	self._preChoosePetId = choosePetId

	if self._preChoosePetId == nil then
		self._preChoosePetId = self._petCfg[1].skinId
	end

	self._preSelectWordId = selectWordIdx or 1
	self._preChoosePetIndex = LuckyMoneyConfig.instance:getChoosePetIdx(self._activityId, self._preChoosePetId)
	self._tweenDic = {}
	self._posXList = {}
	self._floatWordList = {}

	for i = 1, 3 do
		local curFloatWordGo = self:getGo("floatWord" .. i)
		local curPos = GameUtil.getAnchoredPos(self:getGo("floatWord" .. i))

		table.insert(self._posXList, curPos.x)
		table.insert(self._floatWordList, curFloatWordGo)
	end

	self._isFirstEnter = true
	self._startAnimPos = GameUtil.getAnchoredPos(self:getGo("startPos1"))
	self._curFloatWordIdx = 1

	local storyId = self._actCfg.firstStoryId

	if checknumber(storyId) > 0 then
		local key = string.format("LuckyMoneyMainView%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end

	self:_onSetUI()
	LuckyMoneyController.instance:sendPM_LuckyMoneyGetInfoReq(self._activityId)
	CatchPropsController.instance:requestActivityInfo()
end

function LuckyMoneyMainView:onExit()
	LuckyMoneyMainView.super.onExit(self)
	self._scrollRewardList:dispose()

	for i = 1, 3 do
		local con = self:getGo("floatWord" .. i .. "/conMask/con")

		uGuiUtil.clearImage(con)
	end

	removetimer(self._danMuAnim, self)

	for k, tween in pairs(self._tweenDic) do
		tween:Kill(true)
	end

	self._sequence:Kill(true)
end

function LuckyMoneyMainView:_onSetUI()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	for idx, cell in ipairs(self._cellList) do
		local curPetCfg = self._petCfg[idx]
		local curPetId = curPetCfg and curPetCfg.skinId
		local modelCo = CharacterConfig.instance:getModelCo(curPetId)

		if modelCo then
			if not modelCo.cardName then
				GameUtil.addClickHandler(cell.btnGoto, GameUtil.handler(self._onClickCell, self, idx), self)
			end
		end
	end

	self._curRandomFloatWordIdxList = self:_getRandomList(#self._floatWordList, #self._floatWordList)
	self._curFloatWordIdx = 1

	self:_danMuAnim()
	self:_setDanMuAnim()
end

function LuckyMoneyMainView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function LuckyMoneyMainView:_updateData()
	self._info = LuckyMoneyModel.instance:getInfo(self._activityId)
end

function LuckyMoneyMainView:_updateUI()
	self._txtPlayTime.text = (self._info.todayHasActCount <= self._actCfg.dailyActLimit and self._info.todayHasActCount or self._actCfg.dailyActLimit) .. "/" .. self._actCfg.dailyActLimit

	self._scrollRewardList:reloadData(self._progressCfg)

	self._txtProgress.text = "已获红包\n" .. (self._info.scoreProgress or 0)

	local scoreList = {}

	for i, v in ipairs(self._progressCfg) do
		table.insert(scoreList, v.progress)
	end

	self._scrollRewardList:updateUnderSlider(self._progressSlider, self._info.scoreProgress, scoreList)
end

function LuckyMoneyMainView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local hasGet = false

	if not self._info.scoreProgress then
		local finishIds = 0
		local isCanGet = finishIds >= data.progress

		if not self._info.gainedDataBitId then
			local gainPrizeIds = {}

			hasGet = table.indexof(gainPrizeIds, data.dataBitId) ~= false
			txtScore.text = data.progress

			MaterialMgr.setCellByCfg(data.prize, item)
			GameUtil.SetActive(geted, hasGet)
			GameUtil.SetActive(btnGet, isCanGet and not hasGet)
			GameUtil.SetActive(btnGet, isCanGet and not hasGet)
			self:_clearCellEffect(effect)

			if isCanGet and not hasGet then
				self:_playCellEffect(effect)
			end

			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
		end
	end
end

function LuckyMoneyMainView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function LuckyMoneyMainView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("scorollReward/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function LuckyMoneyMainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function LuckyMoneyMainView:_setDanMuAnim()
	settimer(3, self._danMuAnim, self)
end

function LuckyMoneyMainView:_danMuAnim()
	local wordCfgLength = #self._wordCfg
	local petCfgLength = #self._petCfg

	self._randomRaceIdList = self:_getRandomList(petCfgLength, #self._petCfg - 1, {
		self._preChoosePetIndex
	})
	self._randomWordIdList = self:_getRandomList(wordCfgLength, #self._wordCfg - 1, {
		self._preSelectWordId
	})

	local floatWord = self:getGo("floatWord" .. self._curFloatWordIdx)
	local con = self:getGo("floatWord" .. self._curFloatWordIdx .. "/conMask/con")
	local txtWord = self:getTxt("floatWord" .. self._curFloatWordIdx .. "/bubble/txtWord")
	local yPos = math.random(self._actCfg.danMuYArea[1], self._actCfg.danMuYArea[2])

	GameUtil.setAnchoredPos(floatWord.gameObject, self._startAnimPos.x, yPos)
	GameUtil.SetActive(floatWord.gameObject, true)

	if self._tweenDic[self._curFloatWordIdx] then
		local tween = self._tweenDic[self._curFloatWordIdx]

		tween:Kill(true)
	end

	local modelCo = CharacterConfig.instance:getModelCo(self._preChoosePetId)

	if modelCo then
		if not modelCo.headName then
			local petIconName = ""
			local randomWordText = self._wordCfg[self._preSelectWordId].word

			uGuiUtil.clearImage(con)
			uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petIconName))

			txtWord.text = randomWordText

			if self._isFirstEnter and self._preChoosePetIndex ~= 0 and self._preSelectWordId ~= 0 then
				local modelCo = CharacterConfig.instance:getModelCo(self._preChoosePetId)

				if modelCo then
					if not modelCo.headName then
						local petIconName = ""
						local randomWordText = self._wordCfg[self._preSelectWordId].word

						uGuiUtil.clearImage(con)
						uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petIconName))

						txtWord.text = randomWordText
						self._isFirstEnter = false
					end
				end
			else
				local randomRaceId = self:_getRandomRaceId(self._randomRaceIdList, self._curFloatWordIdx)
				local modelCo = CharacterConfig.instance:getModelCo(randomRaceId)

				if modelCo then
					if not modelCo.headName then
						local petIconName = ""
						local randomWordId = self:_getRandomWordId(self._randomWordIdList, self._curFloatWordIdx)
						local randomWordText = self._wordCfg[randomWordId].word

						uGuiUtil.clearImage(con)
						uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petIconName))

						txtWord.text = randomWordText
					end
				end
			end

			local moveTween = floatWord.gameObject.transform:DOMoveX(self:getGo("endPos" .. 1).transform.position.x, 7):SetEase(DG.Tweening.Ease.Linear)

			self._tweenDic[self._curFloatWordIdx] = moveTween

			self._sequence:Join(moveTween)

			self._curFloatWordIdx = self._curFloatWordIdx + 1 >= #self._floatWordList + 1 and 1 or self._curFloatWordIdx + 1
		end
	end
end

function LuckyMoneyMainView:_getRandomList(maxNum, length, ignoreNumList)
	if ignoreNumList == nil then
		ignoreNumList = {}
	end

	if type(ignoreNumList) ~= "table" then
		ignoreNumList = {
			checknumber(ignoreNumList)
		}
	end

	local list = {}
	local finalList = {}

	for i = 1, maxNum do
		table.insert(list, i)
	end

	if maxNum - length < #ignoreNumList then
		printError("_getRandomList： maxNum - length <= #ignoreNumList, 是否参数传错了")

		return list
	end

	list = self:_shuffle(list)

	local cur = 1

	while cur <= length do
		local curNum = list[cur]

		while table.indexof(ignoreNumList, curNum) do
			cur = cur + 1
			curNum = list[cur]
		end

		table.insert(finalList, curNum)

		cur = cur + 1
	end

	return finalList
end

function LuckyMoneyMainView:_shuffle(list)
	for i = #list, 2, -1 do
		local curRandomIdx = math.random(1, i - 1)

		list[i] = list[curRandomIdx]
		list[curRandomIdx] = list[i]
	end

	return list
end

function LuckyMoneyMainView:_getRandomRaceId(randomRaceIdList, idx)
	local randomIdx = randomRaceIdList[idx]
	local randomCfg = self._petCfg[randomIdx]

	return randomCfg and randomCfg.skinId
end

function LuckyMoneyMainView:_getRandomWordId(randomWordIdList, idx)
	local randomIdx = randomWordIdList[idx]
	local randomCfg = self._wordCfg[randomIdx]

	return randomCfg and randomCfg.id
end

function LuckyMoneyMainView:_onClickGetPrize(data)
	if not self._info.gainedDataBitId then
		local gainPrizeIds = {}
		local hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false

		if not hasGet then
			if not self._info.scoreProgress then
				local finishIds = {}
				local isCanGet = finishIds >= data.progress

				if isCanGet then
					LuckyMoneyController:sendPM_LuckyMoneyGainProgressPrizeReq(self._activityId, data.dataBitId)
				else
					TipsFacade.instance:openCommonTips("还没达到条件哦~")
				end
			end
		end
	end
end

function LuckyMoneyMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function LuckyMoneyMainView:_onClickCell(idx)
	if checknumber(self._info.todayHasActCount) >= checknumber(self._actCfg.dailyActLimit) then
		FloatWordMgr.instance:show("今日游戏次数已达上限，请明日再来")

		return
	end

	self._curChoosePetId = self._petCfg[idx] and self._petCfg[idx].skinId

	LuckyMoneyModel.instance:setChoosePetId(self._activityId, self._curChoosePetId)
	UIStateManager.instance:push(ViewName.LuckyMoneyWordView, self._activityId)
end

return LuckyMoneyMainView
