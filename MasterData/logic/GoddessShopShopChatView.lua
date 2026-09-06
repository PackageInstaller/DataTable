-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopShopChatView.lua

module("logic.extensions.goddessshop.view.GoddessShopShopChatView", package.seeall)

local GoddessShopShopChatView = class("GoddessShopShopChatView", ViewComponent)
local TickingDelta = 0.1
local ChatDuration = 1

function GoddessShopShopChatView:buildUI()
	GoddessShopShopChatView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("mask/con")
	self._txtFeel = self:getTxt("txtFeel")
	self._strTxtFeel = self._txtFeel.text
	self._replyCol = self:getGo("replyCol")
	self._replyColScrView = self:getGo("replyCol/scrView")
	self._replyColScrCell = self:getGo("replyCol/scrCell")
	self._replyColScrollerList = ScrollerList.create(self._replyColScrView, self._replyColScrCell, GameUtil.handler(self._updateReplyCell, self), GameUtil.handler(self._clearReplyCell, self))
	self._chatScrView = self:getGo("chatCol/scrView")
	self._scrCell1 = self:getGo("chatCol/scrCell1")
	self._scrCell2 = self:getGo("chatCol/scrCell2")
	self._bubbleScrCell1 = self:getGo("chatCol/scrCell1/bubble")
	self._txtDescScrCell1 = self:getTxt("chatCol/scrCell1/bubble/txtDesc")
	self._txtValueScrCell1 = self:getTxt("chatCol/scrCell1/bubble/txtValue")
	self._bubbleScrCell2 = self:getGo("chatCol/scrCell2/bubble")
	self._txtDescScrCell2 = self:getTxt("chatCol/scrCell2/bubble/txtDesc")
	self._txtValueScrCell2 = self:getTxt("chatCol/scrCell1/bubble/txtValue")
	self._emptyChatCol = self:getGo("chatCol/empty")
	self._bubbleByTags = {
		self._bubbleScrCell1,
		self._bubbleScrCell2
	}
	self._txtDescByTags = {
		self._txtDescScrCell1,
		self._txtDescScrCell2
	}
	self._txtValueByTags = {
		self._txtValueScrCell1,
		self._txtValueScrCell2
	}

	local scrCellList = {
		self._scrCell1,
		self._scrCell2
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

	self._chatScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._chatScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
	self._chatScrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._btnNextChat = self:getGo("btnNextChat")
	self._txtBtnNextChat = self:getTxt("btnNextChat/txt")
	self._strTxtBtnNext = self._txtBtnNextChat.text
	self._addGo = self:getGo("floatRoot/addGo")
	self._txtAddGo = self:getTxt("floatRoot/addGo/txt")

	GameUtil.SetActive(self._addGo, false)
end

function GoddessShopShopChatView:bindEvents()
	GoddessShopShopChatView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnNextChat, self._onClickBtnNextChat, self)

	self._beginDragHandler = BeginDragHandler.Get(self._chatScrView):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragHandler(_go, eventData)
	end)
	self._endDragHandler = EndDragHandler.Get(self._chatScrView):AddLuaHandler(function(_go, eventData)
		self:_onEndDragHandler(_go, eventData)
	end)
end

function GoddessShopShopChatView:unbindEvents()
	GoddessShopShopChatView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnNextChat)
	BeginDragHandler.Get(self._chatScrView):RemoveLuaHandler(self._beginDragHandler)
	EndDragHandler.Get(self._chatScrView):RemoveLuaHandler(self._endDragHandler)
end

function GoddessShopShopChatView:onEnter()
	GoddessShopShopChatView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._girlId = checknumber(params[2])

	local isInTime = GoddessShopController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._activityType = GoddessShopController.instance:getActivityType()
	self._goddessShopMo = GoddessShopController.instance:getGoddessShopMo(self._activityId)
	self._actData = GoddessShopConfig.instance:getActData(self._activityId)
	self._girlData = GoddessShopConfig.instance:getGirlData(self._activityId, self._girlId)
	self._chatMgr = self._goddessShopMo:getChatMgr()
	self._isDraging = false
	self._isPlaying = false
	self._curDeltaTime = 0
	self._chatInfoList = {}
	self._curFetter = self._goddessShopMo:getFetterInShop(self._girlId)

	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlInfoRes, self._onUpdateData, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlPresentGiftRes, self._onUpdateData, self)
	self.addGEvent(self, GlobalNotify.SurroundByDreamGirlShopMoneyUpdate, self._onUpdateData, self)
	self.addGEvent(self, GlobalNotify.SurroundByDreamGirlShopFetterUpdate, self._onUpdateData, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlGetGirlTodayChatInfoRes, self._handlePM_SurroundByDreamGirlGetGirlTodayChatInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlChatRes, self._handlePM_SurroundByDreamGirlChatRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlSelectAnswerRes, self._handlePM_SurroundByDreamGirlSelectAnswerRes, self)
	MaterialMgr.setCell(MatType.PetSkin_Rare, self._girlData.skinId, self._pointRare)

	local modelCo = CharacterConfig.instance:getModelCo(self._girlData.skinId)

	uGuiUtil.setSpriteToImage(self._con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	self:_onUpdate()
	GoddessShopController.instance:sendPM_SurroundByDreamGirlGetGirlTodayChatInfoReq(self._activityId, self._girlId)
	settimer(TickingDelta, self._onTicking, self, true)
end

function GoddessShopShopChatView:onExit()
	GoddessShopShopChatView.super.onExit(self)
	removetimer(self._onTicking, self)
	MaterialMgr.resetAll(self._pointRare)
	self:_clearFeelFloatAnim()

	self._chatMgr = nil

	table.clear(self._chatInfoList)
	uGuiUtil.clearImage(self._con)
	self:_onClearReplyCol()
	GlobalDispatcher:dispatch(GlobalNotify.SurroundByDreamGirlShopToTryReqInfo)
end

function GoddessShopShopChatView:destroyUI()
	GoddessShopShopChatView.super.destroyUI(self)
end

function GoddessShopShopChatView:_onUpdateData()
	self._curFetter = self._goddessShopMo:getFetterInShop(self._girlId)

	self:_onUpdateFeelUI()
end

function GoddessShopShopChatView:_handlePM_SurroundByDreamGirlGetGirlTodayChatInfoRes(msg)
	local girlId = msg.girlId

	self._dialogueInfoList = {}

	for dialogueIndex, info in ipairs(msg.dialogueInfo) do
		local myAnswers = info.myAnswers
		local dialogueId = info.dialogueId

		for i, v in ipairs(info.idAndAddMoney) do
			local chatId = v.left
			local money = v.right
			local chatCell = self._chatMgr:getChatCell(girlId, dialogueId, chatId, dialogueIndex)

			chatCell:updateMoneyChange(money)
		end

		local dialogueInfo = {}

		dialogueInfo.dialogueIndex = dialogueIndex
		dialogueInfo.girlId = msg.girlId
		dialogueInfo.dialogueId = dialogueId
		dialogueInfo.myAnswers = {}

		table.insertto(dialogueInfo.myAnswers, myAnswers)
		table.insert(self._dialogueInfoList, dialogueInfo)
	end

	self:_onUpdateData()
	self:_onToPlayChat(#self._dialogueInfoList, nil)
end

function GoddessShopShopChatView:_handlePM_SurroundByDreamGirlChatRes(status, msg)
	if status ~= 0 then
		self._isPlaying = false

		return
	end

	local newDialogueInfo = msg.newDialogueInfo
	local dialogueInfo = {}

	dialogueInfo.dialogueIndex = #self._dialogueInfoList + 1
	dialogueInfo.girlId = msg.girlId
	dialogueInfo.dialogueId = newDialogueInfo.dialogueId
	dialogueInfo.myAnswers = {}

	table.insertto(dialogueInfo.myAnswers, newDialogueInfo.myAnswers)
	table.insert(self._dialogueInfoList, dialogueInfo)
	self:_onToPlayChat(#self._dialogueInfoList, 1)
end

function GoddessShopShopChatView:_handlePM_SurroundByDreamGirlSelectAnswerRes(msg)
	local dialogueInfo = self._dialogueInfoList[#self._dialogueInfoList]
	local girlId = dialogueInfo.girlId
	local dialogueId = dialogueInfo.dialogueId
	local dialogueIndex = dialogueInfo.dialogueIndex

	table.insert(dialogueInfo.myAnswers, msg.answer)

	for i, v in ipairs(msg.idAndAddMoney) do
		local chatId = v.left
		local chatCell = self._chatMgr:getChatCell(girlId, dialogueId, chatId, dialogueIndex)

		chatCell:updateMoneyChange(v.right)
	end

	local nextChatId = msg.answer
	local nextChatCell = self._chatMgr:getChatCell(girlId, dialogueId, nextChatId, dialogueIndex)

	self:_changeFetterValue(nextChatCell:getFetterChange())
	self:_onToPlayChat(dialogueIndex, nextChatId)
end

function GoddessShopShopChatView:_onToPlayChat(curDialogueIndex, curChatId)
	curDialogueIndex = checknumber(curDialogueIndex)
	curChatId = checknumber(curChatId)

	local chatInfoList = {}

	for dialogueIndex = 1, Mathf.Min(curDialogueIndex, #self._dialogueInfoList) do
		local dialogueInfo = self._dialogueInfoList[dialogueIndex]
		local dialogueId = dialogueInfo.dialogueId
		local girlId = dialogueInfo.girlId
		local chatIdList = self._chatMgr:getChatIdListFinish(girlId, dialogueId, dialogueInfo.myAnswers)

		for _, chatId in ipairs(chatIdList) do
			local chatInfo = {}

			chatInfo.chatId = chatId
			chatInfo.dialogueInfo = dialogueInfo
			chatInfo.chatCell = self._chatMgr:getChatCell(girlId, dialogueId, chatId, dialogueIndex)

			table.insert(chatInfoList, chatInfo)

			if curDialogueIndex == dialogueIndex and curChatId == chatId then
				break
			end
		end
	end

	self._chatInfoList = chatInfoList
	self._jumpChatInfoIndex = 0

	for chatInfoIndex, chatInfo in ipairs(self._chatInfoList) do
		local dialogueInfo = chatInfo.dialogueInfo

		if curDialogueIndex == dialogueInfo.dialogueIndex then
			self._jumpChatInfoIndex = chatInfoIndex

			if curChatId == chatInfo.chatId then
				break
			end
		elseif curDialogueIndex < dialogueInfo.dialogueIndex then
			break
		end
	end

	self._isPlaying = true
	self._chatScrollerList:GetScrollRect().enabled = false

	self:_onUpdateChatCol()
	self:_onUpdateReplyCol()
end

function GoddessShopShopChatView:_onTryNextChat()
	local chatInfo = self._chatInfoList[#self._chatInfoList]

	if chatInfo == nil then
		self._isPlaying = false
	end

	if chatInfo then
		local chatCell = chatInfo.chatCell

		if chatCell:isEnd() then
			self._isPlaying = false

			self:_onUpdateBtnNextChat()
		elseif chatCell:isWaitAnswer() then
			self:_onUpdateReplyCol()
		else
			local nextChatId = chatCell:getAutoNext()

			if nextChatId > 0 then
				local nextChatCell = self._chatMgr:getChatCell(chatInfo.dialogueInfo.girlId, chatInfo.dialogueInfo.dialogueId, nextChatId, chatInfo.dialogueInfo.dialogueIndex)

				self:_changeFetterValue(nextChatCell:getFetterChange())
				self:_onToPlayChat(chatInfo.dialogueInfo.dialogueIndex, nextChatId)
			end
		end
	end

	if self._isPlaying == false then
		self._chatScrollerList:GetScrollRect().enabled = true
	end
end

function GoddessShopShopChatView:_onTicking()
	if self._isPlaying == false then
		return
	end

	self._curDeltaTime = self._curDeltaTime + TickingDelta

	if self._curDeltaTime > ChatDuration and self._chatScrollerList.reloadFinish then
		self._curDeltaTime = 0

		self:_onTryNextChat()
	end
end

function GoddessShopShopChatView:_onUpdate()
	self._txtPetName.text = PetSkinConfig.instance:getPetSkinName(self._girlData.skinId)

	self:_onUpdateFeelUI()
	self:_onUpdateReplyCol()
	self:_onUpdateChatCol()
	self:_onUpdateBtnNextChat()
end

function GoddessShopShopChatView:_onUpdateFeelUI()
	self._txtFeel.text = string.format(self._strTxtFeel, self._curFetter, self._girlData.maxFetter)
end

function GoddessShopShopChatView:_changeFetterValue(delta)
	if delta ~= 0 then
		self._curFetter = Mathf.Clamp(self._curFetter + delta, 0, self._girlData.maxFetter)

		self:_playFeelFloatAnim(delta)
	end

	self:_onUpdateFeelUI()
end

function GoddessShopShopChatView:_playFeelFloatAnim(value)
	self._txtAddGo.text = value < 0 and string.format("%s", value) or string.format("+%s", value)

	self:_clearFeelFloatAnim()

	local sequence = DG.Tweening.DOTween.Sequence()

	self._sequence = sequence

	local targeGo = self._addGo

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

function GoddessShopShopChatView:_clearFeelFloatAnim()
	if self._sequence then
		self._sequence:Kill(true)

		self._sequence = nil
	end
end

function GoddessShopShopChatView:_onUpdateReplyCol()
	if self._isPlaying == false then
		self:_setReplyColShow(false)

		return
	end

	local list = {}
	local chatInfo = self._chatInfoList[#self._chatInfoList]

	if chatInfo then
		local dialogueInfo = chatInfo.dialogueInfo
		local chatCell = chatInfo.chatCell
		local chatIdList = chatCell:getWaitAnswer()

		for i, v in ipairs(chatIdList) do
			local cell = self._chatMgr:getChatCell(dialogueInfo.girlId, dialogueInfo.dialogueId, v, dialogueInfo.dialogueIndex)

			table.insert(list, cell)
		end
	end

	self._replyColScrollerList:reloadData(list)
	self:_setReplyColShow(#list > 0)
end

function GoddessShopShopChatView:_setReplyColShow(isShow)
	GameUtil.SetActive(self._replyCol, isShow)
end

function GoddessShopShopChatView:_onClearReplyCol()
	self._replyColScrollerList:dispose()
end

function GoddessShopShopChatView:_updateReplyCell(view, cell, chatCell, tag)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = chatCell:getProblemDesc()

	GameUtil.addClickHandler(mainGo, function()
		GoddessShopController.instance:sendPM_SurroundByDreamGirlSelectAnswerReq(self._activityId, self._girlId, chatCell:getChatId())
	end)
end

function GoddessShopShopChatView:_clearReplyCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function GoddessShopShopChatView:_onUpdateBtnNextChat()
	local leftTimes = self._goddessShopMo:getLeftChatTimesInShop(self._girlId)

	GameUtil.SetGray(self._btnNextChat, self._isPlaying or leftTimes <= 0)

	self._txtBtnNextChat.text = string.format(self._strTxtBtnNext, leftTimes)
end

function GoddessShopShopChatView:_onClickBtnNextChat()
	if self._isPlaying then
		FloatWordMgr.instance:show("正在对话中")

		return
	end

	local leftTimes = self._goddessShopMo:getLeftChatTimesInShop(self._girlId)

	if leftTimes <= 0 then
		FloatWordMgr.instance:show("剩余次数不足")

		return
	end

	self._isPlaying = true

	GoddessShopController.instance:sendPM_SurroundByDreamGirlChatReq(self._activityId, self._girlId)
end

function GoddessShopShopChatView:_onUpdateChatCol()
	self._chatScrollerList:reloadData(self._chatInfoList)
	GameUtil.SetActive(self._emptyChatCol, #self._chatInfoList <= 0)
end

function GoddessShopShopChatView:_onClearChatCol()
	self._chatScrollerList:dispose()
end

function GoddessShopShopChatView:_onReloadFinish()
	local isEnd = false
	local chatInfo = self._chatInfoList[#self._chatInfoList]

	if chatInfo then
		local chatCell = chatInfo.chatCell

		isEnd = chatCell:isEnd()
	else
		isEnd = true
	end

	if isEnd then
		self._isPlaying = false
		self._chatScrollerList:GetScrollRect().enabled = true
	end

	local index = self._jumpChatInfoIndex and Mathf.Max(self._jumpChatInfoIndex - 1) or 0

	self._jumpChatInfoIndex = nil

	self._chatScrollerList:MoveCellInView(index, false)
	self:_onUpdateFeelUI()
	self:_onUpdateBtnNextChat()
end

function GoddessShopShopChatView:_onBeginDragHandler(go, eventData)
	self._isDraging = true
end

function GoddessShopShopChatView:_onEndDragHandler(go, eventData)
	self._isDraging = false
end

function GoddessShopShopChatView:_updateChatCell(view, cell, chatInfo, tag)
	if tag == 1 then
		self:_updateChatCellNpc(view, cell, chatInfo, tag)
	elseif tag == 2 then
		self:_updateChatCellMe(view, cell, chatInfo, tag)
	end
end

function GoddessShopShopChatView:_updateChatCellNpc(view, cell, chatInfo, tag)
	self:_updateChatCellDesc(view, cell, chatInfo, tag)
end

function GoddessShopShopChatView:_updateChatCellMe(view, cell, chatInfo, tag)
	self:_updateChatCellDesc(view, cell, chatInfo, tag)
end

function GoddessShopShopChatView:_updateChatCellDesc(view, cell, chatInfo, tag)
	local chatCell = chatInfo.chatCell
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")
	local bubble = goutil.findChild(mainGo, "bubble")
	local txtDesc = goutil.findChildTextComponent(mainGo, "bubble/txtDesc")
	local txtValue = goutil.findChildTextComponent(mainGo, "bubble/txtValue")

	self:_setTxtContentAndValue(bubble, txtDesc, txtValue, chatCell)
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(chatCell:getIconPath()))
end

function GoddessShopShopChatView:_clearChatCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")

	uGuiUtil.clearImage(icon)
end

function GoddessShopShopChatView:_getTagByIdx(chatInfo, idx)
	return chatInfo.chatCell:getTag()
end

function GoddessShopShopChatView:_getCellSize(view, idx)
	local chatInfo = self._chatInfoList[idx + 1]
	local chatCell = chatInfo.chatCell
	local tag = chatCell:getTag()
	local defaultSize = self._defaultSizes[tag]
	local bubble = self._bubbleByTags[tag]
	local txtDesc = self._txtDescByTags[tag]
	local txtValue = self._txtValueByTags[tag]

	self:_setTxtContentAndValue(bubble, txtDesc, txtValue, chatCell)

	return defaultSize[1], txtDesc.preferredHeight + txtValue.preferredHeight + 50
end

function GoddessShopShopChatView:_setTxtContentAndValue(bubble, txt1, txt2, chatCell)
	local isNilContent = string.nilorempty(chatCell:getContent())

	txt1.text = isNilContent and "" or chatCell:getContent()

	GameUtil.SetActive(txt1.gameObject, not isNilContent)

	local isNilValue = string.nilorempty(chatCell:getContentValue())

	txt2.text = isNilValue and "" or chatCell:getContentValue()

	GameUtil.SetActive(txt2.gameObject, not isNilValue)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(bubble:GetComponent(goutil.Type_RectTransform))
end

return GoddessShopShopChatView
