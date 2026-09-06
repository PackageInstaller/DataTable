-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderChatEventView.lua

module("logic.extensions.exploreunder.view.ExploreUnderChatEventView", package.seeall)

local ExploreUnderChatEventView = class("ExploreUnderChatEventView", ViewComponent)
local TickingDelta = 0.1
local ChatDuration = 1
local _recordChatId = 0

function ExploreUnderChatEventView:buildUI()
	ExploreUnderChatEventView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._petInfo = self:getGo("petInfo")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("mask/con")
	self._roleGo = self:getGo("roleGo")
	self._fetter = self:getGo("fetter")
	self._txtFetter = self:getTxt("fetter/txt")
	self._strTxtFetter = self._txtFetter.text
	self._wealth = self:getGo("wealth")
	self._txtWealth = self:getTxt("wealth/txt")
	self._strTxtWealth = self._txtWealth.text
	self._posMoney = self:getGo("posMoney")
	self._posFetter = self:getGo("posFetter")
	self._btnSure = self:getGo("btnSure")
	self._btnClg = self:getGo("btnClg")
	self._empty = self:getGo("empty")
	self._chatScrView = self:getGo("chatCol/scrView")
	self._chatScrCell = self:getGo("chatCol/scrCell")
	self._bubbleScrCell1 = self:getGo("chatCol/scrCell1/bubble")
	self._txtDescChatScrCell1 = self:getTxt("chatCol/scrCell1/bubble/txtDesc")
	self._bubbleScrCell2 = self:getGo("chatCol/scrCell1/bubble")
	self._txtDescChatScrCell2 = self:getTxt("chatCol/scrCell2/bubble/txtDesc")
	self._scrCell1 = self:getGo("chatCol/scrCell1")
	self._scrCell2 = self:getGo("chatCol/scrCell2")

	local scrCellList = {
		self._scrCell1,
		self._scrCell2
	}

	self._bubbleByTags = {
		self._bubbleScrCell1,
		self._bubbleScrCell2
	}
	self._txtDescByTags = {
		self._txtDescChatScrCell1,
		self._txtDescChatScrCell2
	}
	self._defaultSizes = {}

	for tag, _ in ipairs(scrCellList) do
		local scrCell = scrCellList[tag]

		self._defaultSizes[tag] = {
			GameUtil.getWidth(scrCell),
			GameUtil.getHeight(scrCell)
		}
	end

	self._chatScrollerList = ScrollerList.create(self._chatScrView, scrCellList, GameUtil.handler(self._updateChatCell, self), GameUtil.handler(self._clearChatCell, self))

	self._chatScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
	self._chatScrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))
	self._chatScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))

	self._replyColA = self:getGo("replyColA")
	self._replyColAScrView = self:getGo("replyColA/scrView")
	self._replyColAScrCell = self:getGo("replyColA/scrCell")
	self._replyColAScrollerList = ScrollerList.create(self._replyColAScrView, self._replyColAScrCell, GameUtil.handler(self._updateReplyACell, self), GameUtil.handler(self._clearReplyACell, self))
	self._replyColB = self:getGo("replyColB")
	self._replyColBScrCell = self:getGo("replyColB/scrCell")
	self._replyColBScrView = self:getGo("replyColB/scrView")
	self._replyColBScrollerList = ScrollerList.create(self._replyColBScrView, self._replyColBScrCell, GameUtil.handler(self._updateReplyBCell, self), GameUtil.handler(self._clearReplyBCell, self))
	self._floatRoot = self:getGo("floatRoot")
	self._addGo = self:getGo("floatRoot/addGo")
	self._txtAddGo = self:getTxt("floatRoot/addGo/txt")

	GameUtil.SetActive(self._addGo, false)
end

function ExploreUnderChatEventView:bindEvents()
	ExploreUnderChatEventView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function ExploreUnderChatEventView:unbindEvents()
	ExploreUnderChatEventView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClg)
end

function ExploreUnderChatEventView:onEnter()
	ExploreUnderChatEventView.super.onEnter(self)

	self._activityId = ExploreUnderModel.instance:getActId()

	local curActCfg = ExploreUnderConfig.instance:getActfg(self._activityId)

	if curActCfg == nil then
		self:close()

		return
	end

	local curLevel = ExploreUnderModel.instance:getCurLevel()
	local curLevelCfg = ExploreUnderConfig.instance:getLevelCfg(curActCfg.levelPlanId, curLevel)
	local params = self:getOpenParam() or {}

	self._dialogueId = checkint(params[1])
	self._eventState = ExploreUnderModel.instance:getCurEventState()
	self._dialoguePlanId = curLevelCfg.event_plan_6
	self._dialogueCfg = ExploreUnderConfig.instance:getDialogueCfg(self._dialoguePlanId, self._dialogueId)
	self._chatMgr = self._chatMgr or ExploreUnderChatMgr.New(self._dialoguePlanId, self._dialogueId)

	self._chatMgr:onEnter(self._dialoguePlanId, self._dialogueId)

	self._branchChatIds = {}
	self._curFetter = 0
	self._curMoney = 0
	self._curDeltaTime = 0
	self._isPlaying = false
	self._petName = ""
	self._skinId = 0
	self._maxFetter = 0
	self._isShowMoney = false
	self._isShowFetter = false

	self.addGEvent(self, GlobalNotify.HandleDealEvent, self._handleDealEvent, self)
	self.addGEvent(self, GlobalNotify.ExploreUnderEventInfoChange, self._exploreUnderEventInfoChange, self)

	local curEventInfo = ExploreUnderModel.instance:getCurEventData()

	if not string.nilorempty(curEventInfo) then
		local arr = string.split(curEventInfo, "#")

		for i, v in ipairs(arr) do
			self._branchChatIds[checknumber(v)] = true
		end
	end

	if self._eventState == ExploreUnderEnum.EventState_Finish then
		self._eventAction = ExploreUnderModel.EventAction.viewDialogue

		ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.viewDialogue)
	else
		_recordChatId = 0
		self._eventAction = ExploreUnderModel.EventAction.startDialogue

		ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.startDialogue)
	end

	settimer(TickingDelta, self._onTicking, self, true)
end

function ExploreUnderChatEventView:onExit()
	ExploreUnderChatEventView.super.onExit(self)
	removetimer(self._onTicking, self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	table.clear(self._chatInfoList)
	MaterialMgr.resetAll(self._pointRare)
	uGuiUtil.clearImage(self._con)
	self:_clearFeelFloatAnim()
	self:_onClearReplyCol()

	if self._chatMgr then
		self._chatMgr:onExit()
	end
end

function ExploreUnderChatEventView:destroyUI()
	ExploreUnderChatEventView.super.destroyUI(self)

	if self._chatMgr then
		self._chatMgr:dispose()

		self._chatMgr = nil
	end
end

function ExploreUnderChatEventView:_handleDealEvent(status, msg)
	return
end

function ExploreUnderChatEventView:_exploreUnderEventInfoChange(msg)
	if self._eventAction == nil then
		printError("请检查为什么这里是nil")

		return
	end

	local eventAction = self._eventAction

	self._eventAction = nil

	local eventInfo = msg.eventInfo

	for i, v in ipairs(eventInfo.extInfo) do
		if v.key == ExploreUnderEnum.PM_ExploreUnderReqParam_Key_Money then
			self._curMoney = checknumber(v.value)
		elseif v.key == ExploreUnderEnum.PM_ExploreUnderReqParam_Key_Fetter then
			self._curFetter = checknumber(v.value)
		end
	end

	local curEventInfo = eventInfo.gridInfo.curEventInfo

	if not string.nilorempty(curEventInfo) then
		local arr = string.split(curEventInfo, "#")

		for i, v in ipairs(arr) do
			self._branchChatIds[checknumber(v)] = true
		end
	end

	if eventAction == ExploreUnderModel.EventAction.startDialogue or eventAction == ExploreUnderModel.EventAction.viewDialogue then
		self:_onRestartPlayChat()
	elseif eventAction == ExploreUnderModel.EventAction.selectAnswer then
		self:_onTryNextChat()
	end
end

function ExploreUnderChatEventView:_onRestartPlayChat()
	self._curDeltaTime = 0
	self._isPlaying = true
	self._petName = ""
	self._skinId = 0
	self._maxFetter = 0
	self._isShowMoney = false
	self._isShowFetter = false

	self._chatMgr:resetChatIdList()

	local rootChatId = 1
	local queue = {
		rootChatId
	}

	self._chatMgr:nextChat(rootChatId)

	local processedNodes = {}

	while #queue > 0 do
		local chatId = table.remove(queue, #queue)

		if not processedNodes[chatId] then
			processedNodes[chatId] = true

			if chatId <= 0 then
				printError(string.format("错误！配置缺失，%s-%s-%s ", self._dialoguePlanId, self._dialogueId, chatId))
			else
				local nextChatId = self:_getNextChatId(chatId)

				if nextChatId then
					_recordChatId = nextChatId

					if self._eventState ~= ExploreUnderEnum.EventState_Finish and (_recordChatId == nextChatId or _recordChatId == 0) then
						break
					end

					table.insert(queue, nextChatId)
					self._chatMgr:nextChat(nextChatId)
				end
			end
		else
			printError(string.format("错误！检测到循环引用，%s-%s-%s ", self._dialoguePlanId, self._dialogueId, chatId))
		end
	end

	GameUtil.SetActive(self._fetter, false)
	GameUtil.SetActive(self._petInfo, false)
	GameUtil.SetActive(self._wealth, false)
	self:_onUpdatePlayChat()
end

function ExploreUnderChatEventView:_onTryNextChat()
	self._curDeltaTime = 0

	local curChatId = self._chatMgr:getCurChatId()
	local nextChatId = self:_getNextChatId(curChatId)

	if nextChatId then
		self._chatMgr:nextChat(nextChatId)
		self:_doChatValueChangeUIEff(nextChatId)
		self:_onUpdatePlayChat()
	end
end

function ExploreUnderChatEventView:_getNextChatId(chatId)
	local nextChatId

	if chatId > 0 then
		local chatCell = self._chatMgr:getChatCell(chatId)

		if #chatCell:getWaitAnswer() > 0 then
			for _, v in ipairs(chatCell:getWaitAnswer()) do
				if self._branchChatIds[v] then
					nextChatId = v

					break
				end
			end
		elseif chatCell:getContinueHandler() then
			local handler = chatCell:getContinueHandler()
			local type = handler.type

			if type == ExploreUnderEnum.ContinueHandler_SurroundByGirl_ChangeMoney then
				for _, v in ipairs(handler.ifelse) do
					if self._branchChatIds[v] then
						nextChatId = v

						break
					end
				end
			elseif type == ExploreUnderEnum.ContinueHandler_Auto then
				nextChatId = handler.next
			elseif type == ExploreUnderEnum.ContinueHandler_Random then
				for _, v in ipairs(handler.answers) do
					if self._branchChatIds[v] then
						nextChatId = v

						break
					end
				end
			elseif type == ExploreUnderEnum.ContinueHandler_Fight then
				for _, v in ipairs(handler.ifelse) do
					if self._branchChatIds[v] then
						nextChatId = v

						break
					end
				end
			end
		end
	end

	return nextChatId
end

function ExploreUnderChatEventView:_onTicking()
	if self._isPlaying == false then
		return
	end

	self._curDeltaTime = self._curDeltaTime + TickingDelta

	if self._curDeltaTime > ChatDuration and self._chatScrollerList.reloadFinish then
		self._curDeltaTime = 0

		self:_onTryNextChat()
	end
end

function ExploreUnderChatEventView:_doChatValueChangeUIEff(chatId)
	if chatId <= 0 then
		return
	end

	local chatCell = self._chatMgr:getChatCell(chatId)

	if chatCell:getContinueHandler() then
		local handler = chatCell:getContinueHandler()

		if handler.type == ExploreUnderEnum.ContinueHandler_SurroundByGirl_ChangeMoney then
			local yesId = checknumber(handler.ifelse[1])
			local money = checknumber(handler.money)

			if self._branchChatIds[yesId] then
				self:_changeMoneyValue(money)
			end
		end
	end

	if chatCell:getAnswerHandler() then
		local handler = chatCell:getAnswerHandler()

		if handler.type == ExploreUnderEnum.AnswerHandler_SurroundByGirl_ChangeFetter then
			self:_changeFetterValue(handler.fetter)
		elseif handler.type == ExploreUnderEnum.AnswerHandler_SurroundByGirl_ChangeMoney then
			self:_changeMoneyValue(handler.money)
		end
	end
end

function ExploreUnderChatEventView:_onUpdateFetterUI()
	self._txtFetter.text = string.format(self._strTxtFetter, self._curFetter, self._maxFetter)
end

function ExploreUnderChatEventView:_onUpdateMoneyUI()
	self._txtWealth.text = string.format(self._strTxtWealth, self._curMoney)
end

function ExploreUnderChatEventView:_changeFetterValue(delta)
	if delta ~= 0 then
		local rootPos = GameUtil.getPos(self._posFetter)

		self:_playFloatAnim(rootPos, delta)
	end

	self:_onUpdateFetterUI()
end

function ExploreUnderChatEventView:_changeMoneyValue(delta)
	if delta ~= 0 then
		local rootPos = GameUtil.getPos(self._posMoney)

		self:_playFloatAnim(rootPos, delta)
	end

	self:_onUpdateMoneyUI()
end

function ExploreUnderChatEventView:_playFloatAnim(rootPos, value)
	self._txtAddGo.text = value < 0 and string.format("%s", value) or string.format("+%s", value)

	self:_clearFeelFloatAnim()

	local sequence = DG.Tweening.DOTween.Sequence()

	self._sequence = sequence

	local targeGo = self._addGo

	GameUtil.setPos(self._floatRoot, rootPos.x, rootPos.y, rootPos.z)
	GameUtil.setLocalPos(targeGo, 0, 0, 0)
	GameUtil.SetActive(targeGo, true)

	local toPos = GameUtil.getLocalPos(targeGo)

	toPos.y = toPos.y + 34

	local tweenerMove = targeGo.transform:DOLocalMove(toPos, 0.2)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)
	sequence:Join(tweenerMove)
	sequence:AppendInterval(1)
	sequence:OnComplete(function()
		GameUtil.SetActive(targeGo, false)
	end)
end

function ExploreUnderChatEventView:_clearFeelFloatAnim()
	if self._sequence then
		self._sequence:Kill(true)

		self._sequence = nil
	end
end

function ExploreUnderChatEventView:_onUpdateReplyCol()
	if self._isPlaying == false then
		GameUtil.SetActive(self._replyColA, false)
		GameUtil.SetActive(self._replyColB, false)
		self:_onClearReplyCol()

		return
	end

	local replyType = 1
	local chatIdList = {}
	local curChatId = self._chatMgr:getCurChatId()

	if curChatId > 0 then
		local chatCell = self._chatMgr:getChatCell(curChatId)

		if #chatCell:getWaitAnswer() > 0 then
			table.insertto(chatIdList, chatCell:getWaitAnswer())

			local icons = chatCell:getAnswerIcon()

			if #icons > 0 then
				replyType = 2
			end
		end
	end

	for _, chatId in ipairs(chatIdList) do
		if self._branchChatIds[chatId] == true then
			table.clear(chatIdList)
		end
	end

	if replyType == 1 then
		self._replyColAScrollerList:reloadData(chatIdList)
	elseif replyType == 2 then
		self._replyColBScrollerList:reloadData(chatIdList)
	end

	GameUtil.SetActive(self._replyColA, replyType == 1 and #chatIdList > 0)
	GameUtil.SetActive(self._replyColB, replyType == 2 and #chatIdList > 0)
end

function ExploreUnderChatEventView:_onClearReplyCol()
	self._replyColAScrollerList:dispose()
	self._replyColBScrollerList:dispose()
end

function ExploreUnderChatEventView:_updateReplyACell(view, cell, chatId, tag)
	local chatCell = self._chatMgr:getChatCell(chatId)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = chatCell:getContent()

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickBtnReplyCell, self, chatId))
end

function ExploreUnderChatEventView:_clearReplyACell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function ExploreUnderChatEventView:_updateReplyBCell(view, cell, chatId, tag)
	local index = cell.data
	local mainGo = cell.gameObject
	local chatCell = self._chatMgr:getChatCell(chatId)
	local iconPath
	local curChatId = self._chatMgr:getCurChatId()

	if curChatId > 0 then
		local curChatCell = self._chatMgr:getChatCell(curChatId)
		local icons = curChatCell:getAnswerIcon()

		iconPath = icons[index]
	end

	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, string.format("ui/%s.png", iconPath))
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickBtnReplyCell, self, chatId))
end

function ExploreUnderChatEventView:_clearReplyBCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(mainGo)
end

function ExploreUnderChatEventView:_onClickBtnReplyCell(chatId)
	local actionParam = {
		{
			key = "asr",
			value = tostring(chatId)
		}
	}

	self._branchChatIds[chatId] = true
	self._eventAction = ExploreUnderModel.EventAction.selectAnswer

	ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.selectAnswer, actionParam)
end

function ExploreUnderChatEventView:_onUpdatePlayChat()
	self._isPlaying = true
	self._isEnd = false

	local chatIdList = self._chatMgr:getChatIdList()

	for _, chatId in ipairs(chatIdList) do
		local chatCell = self._chatMgr:getChatCell(chatId)

		if chatCell:getExtInfoHandler() then
			local handler = chatCell:getExtInfoHandler()

			if handler.type == ExploreUnderEnum.extInfoHandler_SurroundByGirl_ExtInfo then
				local activityId = handler.activityId
				local girlId = handler.girlFetter

				if handler.showMoney then
					self._isShowMoney = checkbool(handler.showMoney)
				end

				if girlId and girlId > 0 then
					self._isShowFetter = true

					local girlData = GoddessShopConfig.instance:getGirlData(activityId, girlId)

					self._maxFetter = girlData.maxFetter
					self._skinId = girlData.skinId
					self._petName = PetSkinConfig.instance:getPetSkinName(girlData.skinId)
				end
			end
		end
	end

	local isFight = false
	local curChatId = self._chatMgr:getCurChatId()

	if curChatId > 0 then
		_recordChatId = curChatId

		local chatCell = self._chatMgr:getChatCell(curChatId)

		if chatCell:getContinueHandler() then
			local handler = chatCell:getContinueHandler()

			if handler.type == ExploreUnderEnum.ContinueHandler_Fight then
				isFight = true
			end
		end

		if chatCell:isEnd() then
			self._isPlaying = false
			self._isEnd = true
		end
	end

	GameUtil.SetActive(self._btnSure, self._isEnd)
	GameUtil.SetActive(self._btnClg, not self._isEnd and isFight)
	GameUtil.SetActive(self._empty, #chatIdList == 0)
	GameUtil.SetActive(self._wealth, self._isShowMoney)
	GameUtil.SetActive(self._petInfo, self._isShowFetter)
	GameUtil.SetActive(self._fetter, self._isShowFetter)

	if self._skinId > 0 then
		MaterialMgr.setCell(MatType.PetSkin_Rare, self._skinId, self._pointRare)

		local modelCo = CharacterConfig.instance:getModelCo(self._skinId)

		uGuiUtil.setSpriteToImage(self._con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
		GameUtil.SetActive(self._roleGo, false)

		self._loader = RoleObjectPool.instance:removeRole(self._loader)
	else
		MaterialMgr.resetAll(self._pointRare)
		uGuiUtil.clearImage(self._con)

		local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(10275)

		if not modelCfg[1] then
			local x = 0

			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, 10275, self._roleGo, scale, nil, true, x, y)

					GameUtil.SetActive(self._roleGo, true)
				end
			end
		end
	end

	self._txtPetName.text = self._petName

	self:_onUpdateReplyCol()
	self:_onUpdateFetterUI()
	self:_onUpdateMoneyUI()
	self._chatScrollerList:reloadData(chatIdList)
end

function ExploreUnderChatEventView:_onClearChatCol()
	self._chatScrollerList:dispose()
end

function ExploreUnderChatEventView:_onReloadFinish()
	local chatIdList = self._chatMgr:getChatIdList()
	local index = Mathf.Max(#chatIdList - 1, 0)

	self._chatScrollerList:MoveCellInView(index, false)
end

function ExploreUnderChatEventView:_updateChatCell(view, cell, chatId, tag)
	local chatCell = self._chatMgr:getChatCell(chatId)
	local mainGo = cell.gameObject
	local bubble = goutil.findChild(mainGo, "bubble")
	local txtDesc = goutil.findChildTextComponent(mainGo, "bubble/txtDesc")

	self:_setTxtContentAndValue(bubble, txtDesc, chatCell)
end

function ExploreUnderChatEventView:_clearChatCell(cell)
	return
end

function ExploreUnderChatEventView:_getTagByIdx(chatId, idx)
	local chatCell = self._chatMgr:getChatCell(chatId)

	return chatCell:getTag()
end

function ExploreUnderChatEventView:_getCellSize(view, idx)
	local chatIdList = self._chatMgr:getChatIdList()
	local chatId = chatIdList[idx + 1]
	local chatCell = self._chatMgr:getChatCell(chatId)
	local tag = chatCell:getTag()
	local defaultSize = self._defaultSizes[tag]
	local bubble = self._bubbleByTags[tag]
	local txtDesc = self._txtDescByTags[tag]

	self:_setTxtContentAndValue(bubble, txtDesc, chatCell)

	return defaultSize[1], txtDesc.preferredHeight + 50
end

function ExploreUnderChatEventView:_setTxtContentAndValue(bubble, txt, chatCell)
	txt.text = chatCell:getContent()

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(bubble:GetComponent(goutil.Type_RectTransform))
end

function ExploreUnderChatEventView:_onClickBtnSure()
	self:close()
end

function ExploreUnderChatEventView:_onClickBtnClg()
	local chatCell = self._chatMgr:getChatCell(self._chatMgr:getCurChatId())
	local handler = chatCell:getContinueHandler()

	if handler and handler.type == ExploreUnderEnum.ContinueHandler_Fight then
		self:close()
		ExploreUnderController.instance:enterBattleInDialogue(self._activityId, handler.creepsMasterId, self._dialogueId)
	end
end

return ExploreUnderChatEventView
