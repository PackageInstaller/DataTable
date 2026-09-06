-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationChatView.lua

module("logic.extensions.islandstation.view.IslandStationChatView", package.seeall)

local IslandStationChatView = class("IslandStationChatView", ViewComponent)

function IslandStationChatView:buildUI()
	IslandStationChatView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("mask/con")
	self._txtFeel = self:getTxt("txtFeel")
	self._strTxtFeel = self._txtFeel.text
	self._txtTime = self:getTxt("txtTime")
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
	self._addGo = self:getGo("floatRoot/addGo")
	self._txtAddGo = self:getTxt("floatRoot/addGo/txt")

	GameUtil.SetActive(self._addGo, false)

	self._cellGoSwitch = self:getGo("tableview/tablecell")
	self._tableGoSwitch = self:getGo("tableview")
	self._tableviewSwitch = ScrollerList.create(self._tableGoSwitch, self._cellGoSwitch, GameUtil.handler(self._updatCellSwitch, self), GameUtil.handler(self._clearCellSwitch, self))
	self._btnReset = self:getGo("btnReset")
	self._item = self:getGo("reward/item")
	self._reward = self:getGo("reward")
	self._txtUnlock = self:getTxt("reward/txtUnlock")
end

function IslandStationChatView:bindEvents()
	IslandStationChatView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnNextChat, self._onClickBtnNextChat, self)

	self._beginDragHandler = BeginDragHandler.Get(self._chatScrView):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragHandler(_go, eventData)
	end)
	self._endDragHandler = EndDragHandler.Get(self._chatScrView):AddLuaHandler(function(_go, eventData)
		self:_onEndDragHandler(_go, eventData)
	end)
end

function IslandStationChatView:unbindEvents()
	IslandStationChatView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnNextChat)
	BeginDragHandler.Get(self._chatScrView):RemoveLuaHandler(self._beginDragHandler)
	EndDragHandler.Get(self._chatScrView):RemoveLuaHandler(self._endDragHandler)
end

function IslandStationChatView:onExit()
	IslandStationChatView.super.onExit(self)
	self._replyColScrollerList:dispose()
	self._chatScrollerList:dispose()
	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._item)
	uGuiUtil.clearImage(self._con)
end

function IslandStationChatView:onEnter()
	IslandStationChatView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationInfoRes, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationSelectAnswerRes, self._handleAnswer, self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationResetChatRes, self._handleReset, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._girlId = checknumber(params[2])

	if self._activityId <= 0 or self._girlId <= 0 then
		self._activityId = 487001
		self._girlId = 1
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	IslandStationController.instance:sendPM_IslandStationInfoReq(self._activityId)
end

function IslandStationChatView:_updateUIByCfg()
	self._actCfg = IslandStationConfig.instance:getActCfg(self._activityId)
	self._girlData = IslandStationConfig.instance:getGirlCfgByGirlId(self._activityId, self._girlId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._girlData.collectSkinId, self._pointRare)

	self._txtPetName.text = PetSkinConfig.instance:getPetSkinName(self._girlData.collectSkinId)

	local modelCo = CharacterConfig.instance:getModelCo(self._girlData.collectSkinId)

	uGuiUtil.setSpriteToImage(self._con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	self._curDialoguePlanId = self._girlData.dialoguePlanId
	self._dialogueCfgs = IslandStationConfig.instance:getDialogueCfgs(self._curDialoguePlanId)
	self._dialogueInfoList = {}

	for i, cfgs in ipairs(self._dialogueCfgs) do
		table.insert(self._dialogueInfoList, {
			id = i,
			dialogueCfgs = cfgs
		})
	end
end

function IslandStationChatView:_updateUIByInfo()
	self._curMaxDialogueId = self._curMaxDialogueId or 1
	self._curDialogueId = self._curDialogueId or 0
	self._curFinishedDialogueId = self._curFinishedDialogueId or 0
	self._curMyAnswers = self._curMyAnswers or {}
	self._curFetter = self._curFetter or 0
	self._todayChatTimes = self._todayChatTimes or 0
	self._txtFeel.text = string.format("%s/%s", self._curFetter, self._girlData.maxFetter)
	self._txtTime.text = string.format("今日对话次数：%s/%s", self._actCfg.dailyChatTimes - self._todayChatTimes, self._actCfg.dailyChatTimes)

	local foodCfg = IslandStationController.instance:getNextUnLockFoodCfg(self._activityId, self._girlId)

	if foodCfg then
		local materialStr = foodCfg.materialStr

		self._txtUnlock.text = string.format("达到%d\n可解锁", foodCfg.fetterUnlock)

		MaterialMgr.setCellByCfg(materialStr, self._item)
	end

	GameUtil.SetActive(self._reward, foodCfg ~= nil)
end

function IslandStationChatView:_handleGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	if not info.girlInfo then
		self._curDialogueId = -1
		self._curFinishedDialogueId = 0
		self._curMyAnswers = {}
		self._curMaxDialogueId = 1
		self._todayChatTimes = checknumber(info.todayChatTimes)
		self._curFetter = 0

		for _, girlInfo in ipairs(info.girlInfo) do
			if girlInfo.girlId == self._girlId then
				self._curFinishedDialogueId = girlInfo.finishedDialogueId or 0
				self._curMyAnswers = girlInfo.curDialogueAnswers or {}
				self._curMaxDialogueId = self._curFinishedDialogueId + 1
				self._curFetter = girlInfo.fetter
			end
		end

		self:_updateUIByInfo()

		if self._curMaxDialogueId > #self._dialogueCfgs then
			self:_switchDialogue(#self._dialogueCfgs)
		else
			self:_switchDialogue(self._curMaxDialogueId)
		end
	end
end

function IslandStationChatView:_handleAnswer(msg)
	local info = GameUtil.pbToTable(msg)

	self._curMyAnswers = self._curMyAnswers or {}

	table.insert(self._curMyAnswers, info.answer)

	if checknumber(info.todayChatTimes) > 0 then
		self._todayChatTimes = checknumber(info.todayChatTimes)
		self._curMaxDialogueId = self._curMaxDialogueId + 1

		table.clear(self._curMyAnswers)
		IslandStationController.instance:tryPlayFetter(self._activityId, self._girlId, self._curFetter)
	end

	if checknumber(info.curFetter) > 0 then
		self._curFetter = checknumber(info.curFetter)
	end

	self._curDialogueId = -1

	self:_switchDialogue(info.dialogueId)
end

function IslandStationChatView:_handleReset(msg)
	local info = GameUtil.pbToTable(msg)

	self._curMyAnswers = {}
	self._curDialogueId = -1

	self:_switchDialogue(info.dialogueId)
end

function IslandStationChatView:_onUpdateChatCol()
	self._chatInfoList = self._chatInfoList or {}

	self._chatScrollerList:reloadData(self._chatInfoList)
	GameUtil.SetActive(self._emptyChatCol, #self._chatInfoList <= 0)
end

function IslandStationChatView:_onReloadFinish()
	GameUtil.SetActive(self._btnReset, false)
	GameUtil.SetActive(self._btnNextChat, false)

	self._chatInfoList = self._chatInfoList or {}

	local lastInfo = self._chatInfoList[#self._chatInfoList]

	if lastInfo then
		if not lastInfo.waitAnswer then
			if #lastInfo.waitAnswer > 0 then
				if not self._dialogueInfoList[self._curDialogueId] then
					if not self._dialogueInfoList[self._curDialogueId].dialogueCfgs then
						local cfgs = {}
						local answerCfgs = {}

						for _, id in ipairs(lastInfo.waitAnswer) do
							table.insert(answerCfgs, cfgs[id])
						end

						self._replyColScrollerList:reloadData(answerCfgs)
						GameUtil.SetActive(self._replyColScrView, true)
					end
				end
			else
				GameUtil.SetActive(self._replyColScrView, false)
			end

			if self._curDialogueId == self._curMaxDialogueId and lastInfo.isEnd and lastInfo.fetterAdd <= 0 then
				GameUtil.SetActive(self._btnReset, true)
			else
				GameUtil.SetActive(self._btnReset, false)
			end

			GameUtil.SetActive(self._btnNextChat, self._curDialogueId == self._curMaxDialogueId - 1)

			if self._curFetter == self._girlData.maxFetter then
				GameUtil.SetActive(self._btnNextChat, false)
			end
		end
	end
end

function IslandStationChatView:_onBeginDragHandler(go, eventData)
	self._isDraging = true
end

function IslandStationChatView:_onEndDragHandler(go, eventData)
	self._isDraging = false
end

function IslandStationChatView:_updateChatCell(view, cell, cfg, tag)
	if tag == 1 then
		self:_updateChatCellNpc(view, cell, cfg, tag)
	elseif tag == 2 then
		self:_updateChatCellMe(view, cell, cfg, tag)
	end
end

function IslandStationChatView:_updateChatCellNpc(view, cell, cfg, tag)
	self:_updateChatCellDesc(view, cell, cfg, tag)
end

function IslandStationChatView:_updateChatCellMe(view, cell, cfg, tag)
	self:_updateChatCellDesc(view, cell, cfg, tag)
end

function IslandStationChatView:_setTxtContentAndValue(bubble, txt1, txt2, content1, content2)
	local isNilContent = string.nilorempty(content1)

	txt1.text = isNilContent and "" or content1

	GameUtil.SetActive(txt1.gameObject, not isNilContent)

	local isNilValue = string.nilorempty(content2)

	txt2.text = isNilValue and "" or content2

	GameUtil.SetActive(txt2.gameObject, not isNilValue)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(bubble:GetComponent(goutil.Type_RectTransform))
end

function IslandStationChatView:_updateChatCellDesc(view, cell, cfg, tag)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")
	local bubble = goutil.findChild(mainGo, "bubble")
	local txtDesc = goutil.findChildTextComponent(mainGo, "bubble/txtDesc")
	local txtValue = goutil.findChildTextComponent(mainGo, "bubble/txtValue")
	local content1 = cfg.content
	local content2 = cfg.fetterAdd > 0 and string.format("<color=#eb4624>(好感度%s)</color>", cfg.fetterAdd) or ""

	self:_setTxtContentAndValue(bubble, txtDesc, txtValue, content1, content2)

	local npcData = IslandStationConfig.instance:getGirlNpcCfg(cfg.npcId)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(npcData.iconPath))
end

function IslandStationChatView:_clearChatCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")

	uGuiUtil.clearImage(icon)
end

function IslandStationChatView:_getTagByIdx(cfg, idx)
	return cfg.tag
end

function IslandStationChatView:_getCellSize(view, idx)
	local cfg = self._chatInfoList[idx + 1]
	local tag = cfg.tag
	local defaultSize = self._defaultSizes[tag]
	local txtDesc = self._txtDescByTags[tag]
	local txtValue = self._txtValueByTags[tag]

	return defaultSize[1], txtDesc.preferredHeight + txtValue.preferredHeight + 50
end

function IslandStationChatView:_updateReplyCell(view, cell, cfg, tag)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = cfg.desc

	GameUtil.addClickHandler(mainGo, function()
		if self._todayChatTimes >= checknumber(self._actCfg.dailyChatTimes) then
			TipsFacade.instance:openCommonTips("今日对话次数已达上限")

			return
		end

		IslandStationController.instance:sendPM_IslandStationSelectAnswerReq(self._activityId, self._girlId, cfg.dialogueId, cfg.id)
	end)
end

function IslandStationChatView:_clearReplyCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function IslandStationChatView:_switchDialogue(dialogueId)
	if self._curDialogueId == dialogueId then
		return
	end

	if dialogueId > self._curMaxDialogueId then
		TipsFacade.instance:openCommonTips("请先完成前置对话")

		return
	end

	self._curDialogueId = dialogueId

	self._tableviewSwitch:reloadData(self._dialogueInfoList)

	local cfgs = self._dialogueCfgs[self._curDialogueId]

	self._chatInfoList = {}

	if self._curMaxDialogueId == self._curDialogueId then
		local newChatCfg = cfgs and cfgs[1]

		while newChatCfg do
			table.insert(self._chatInfoList, newChatCfg)

			if newChatCfg.isEnd then
				newChatCfg = nil
			elseif newChatCfg.autoNext > 0 then
				newChatCfg = cfgs[newChatCfg.autoNext]
			elseif table.nums(newChatCfg.waitAnswer) > 0 then
				local newChatId = -1

				for _, id in ipairs(newChatCfg.waitAnswer) do
					for i, answerId in ipairs(self._curMyAnswers) do
						if id == answerId then
							newChatId = id

							break
						end
					end
				end

				newChatCfg = newChatId > 0 and cfgs[newChatId] or nil
			else
				newChatCfg = nil
			end
		end
	else
		local newChatCfg = cfgs and cfgs[1]

		if newChatCfg then
			if not newChatCfg.prefectAnswer then
				local prefectAnswer = {}

				while newChatCfg do
					table.insert(self._chatInfoList, newChatCfg)

					if newChatCfg.isEnd then
						newChatCfg = nil
					elseif newChatCfg.autoNext > 0 then
						newChatCfg = cfgs[newChatCfg.autoNext]
					elseif table.nums(newChatCfg.waitAnswer) > 0 then
						local newChatId = -1

						for _, id in ipairs(newChatCfg.waitAnswer) do
							for i, answerId in ipairs(prefectAnswer) do
								if id == answerId then
									newChatId = id

									break
								end
							end
						end

						newChatCfg = newChatId > 0 and cfgs[newChatId] or nil
					else
						newChatCfg = nil
					end
				end
			end
		end
	end

	self._chatScrollerList:reloadData(self._chatInfoList)
	self:_updateUIByInfo()
end

function IslandStationChatView:_updatCellSwitch(view, cell, data)
	local btnClick = goutil.findChild(cell.gameObject, "btnClick")
	local txtName = goutil.findChildTextComponent(btnClick.gameObject, "txt")
	local imgLock = goutil.findChild(cell.gameObject, "imgLock")
	local changeGroup = btnClick:GetComponent(typeof(UIChangeGroup))

	txtName.text = string.format("对话%s", data.id)

	goutil.setActive(imgLock, data.id > self._curMaxDialogueId)
	changeGroup:SetState(data.id == self._curDialogueId and 1 or 0)
	GameUtil.addClickHandler(btnClick, function()
		self:_switchDialogue(data.id)
	end)
end

function IslandStationChatView:_clearCellSwitch(cell)
	local btnClick = goutil.findChild(cell.gameObject, "btnClick")

	GameUtil.rmClickHandler(btnClick)
end

function IslandStationChatView:_onClickReset()
	IslandStationController.instance:sendPM_IslandStationResetChatReq(self._activityId, self._girlId, self._curMaxDialogueId)
end

function IslandStationChatView:_onClickBtnClose()
	GlobalDispatcher:dispatch(GlobalNotify.IslandStationGirlChatViewClose)
	self:close()
end

function IslandStationChatView:_onClickBtnNextChat()
	self:_switchDialogue(self._curMaxDialogueId)
end

return IslandStationChatView
