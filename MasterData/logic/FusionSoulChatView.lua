-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulChatView.lua

module("logic.extensions.fusionsoul.view.FusionSoulChatView", package.seeall)

local FusionSoulChatView = class("FusionSoulChatView", ViewComponent)

function FusionSoulChatView:unbindEvents()
	FusionSoulChatView.super.unbindEvents(self)
	self._sendBtn:RemoveClickListener()
	self._closeSendBgBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnClose)
	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
end

function FusionSoulChatView:bindEvents()
	FusionSoulChatView.super.bindEvents(self)
	self._sendBtn:AddClickListener(self._onClickSend, self)
	self._closeSendBgBtn:AddClickListener(function()
		self:_changeItemParentState(true)
	end)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)

	self._drag = Framework.UIDragTrigger.Get(self:getGo("tableview"))

	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)
end

function FusionSoulChatView:buildUI()
	FusionSoulChatView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableviewTr = self._tableview.gameObject.transform

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)

	self._scrollRect = self:getGo("tableview"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._answerGrop = self:getGo("answerGrop")
	self._answerItemParent = self:getGo("answerGrop/itemParent")
	self._answerItem = self:getGo("answerGrop/itemParent/cell")
	self._answerItemBgTr = self:getGo("answerGrop/itemParent/bg").transform

	GameUtil.SetActive(self._answerItem, false)

	self._container = self:getGo("answerGrop/itemParent/bg")
	self._sendBtn = self:getBtn("answerGrop/sendBtn")
	self._sendBtnText = goutil.findChildTextComponent(self.mainGO, "answerGrop/sendBtn/text")
	self._closeSendBgBtn = GameUtil.asBtn(self:getGo("answerGrop/itemParent/closeSendBgBtn"))
	self._TxtC_Test = goutil.findChildTextComponent(self.mainGO, "TxtC_Test")
	self._tableCells = {}
	self._tableCells[GameEnum.GFChatGroupType.SELF] = self:getGo("item_my")
	self._tableCells[GameEnum.GFChatGroupType.INTRODUCE] = self:getGo("item_other")
	self._tableCells[GameEnum.GFChatGroupType.SCHEDULE] = self:getGo("item_other")

	for _, v in pairs(self._tableCells) do
		goutil.setActive(v, true)
		GameUtil.setLocalPos(v, 0, 10000, 0)
	end

	self._effectGo = self:getGo("effect")
end

function FusionSoulChatView:onExit()
	FusionSoulChatView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil

	removetimer(self._reloadData, self)
	removetimer(self._onClickSend, self)
end

function FusionSoulChatView:onEnter()
	FusionSoulChatView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])

	local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, self._zoneId)

	self._eventId = zoneInfo.eventId

	local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, self._zoneId, self._eventId)

	self._dialogueId = checknumber(eventCfg.eventParam)
	self._scrollRect.enabled = true
	self._isDraging = false
	self._isSendSuccess = false
	self._isShowAnswer = false

	GameUtil.SetActive(self._btnClose, false)
	GameUtil.SetActive(self._answerGrop, true)

	local firstId = 1

	self._curViewDatas = {}

	table.insert(self._curViewDatas, firstId)

	self._activityCfg = FusionSoulConfig.instance:getActivityCfg(self._activityId)

	local matType, matId = MaterialMgr.getMatParams(self._activityCfg.energyKey)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	self._sendBtnText.text = langPara("点击选择对话（每次消耗%d%s）", eventCfg.energyCost, matName)
	self._hasQuestion = false

	self:_changeItemParentState(true)
	self:_reloadData()
	FusionSoulController.instance:setNewEvent(self._activityId, self._zoneId, zoneInfo.eventId)
end

function FusionSoulChatView:_reloadData()
	self:_updateAnswer()
	self._tableview:ReloadData()
end

function FusionSoulChatView:_onClickSend()
	if self._hasQuestion then
		if self._isShowAnswer == false then
			self:_changeItemParentState()

			self._sendBtnText.text = lang("点击关闭选项")
		else
			self:_changeItemParentState(true)

			local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, self._zoneId, self._eventId)
			local matType, matId = MaterialMgr.getMatParams(self._activityCfg.energyKey)
			local matName = MaterialMgr.getMaterialsName(matType, matId)

			self._sendBtnText.text = langPara("点击选择对话（每次消耗%d%s）", eventCfg.energyCost, matName)
		end

		self._isShowAnswer = not self._isShowAnswer
	end
end

function FusionSoulChatView:_cellAtIndex(view, idx)
	local data = self._curViewDatas[idx + 1]
	local tag = self:_getCellTag(data)
	local cell = view:DequeueCellByTag(tag)

	cell = cell or view:AddChild(self._tableCells[tag], tag)

	local contentText = goutil.findChildTextComponent(cell.gameObject, "ImgC_ContentBg/TxtC_Content")
	local headIcon = goutil.findChild(cell.gameObject, "Nego_Icon/ImgC_Icon")
	local cfg = FusionSoulConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, data) or {}

	contentText.text = cfg.content

	local npcCfg = FusionSoulConfig.instance:getNpcCfgById(self._activityId, cfg.npcId) or {}

	uGuiUtil.setSpriteToImage(headIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(npcCfg.icon))

	return cell
end

function FusionSoulChatView:_onBeginDrag(eventData)
	self._isDraging = true
end

function FusionSoulChatView:_onEndDrag(eventData)
	self._isDraging = false
end

function FusionSoulChatView:_onReloadFinish()
	if #self._curViewDatas == 0 then
		return
	end

	if self._isDraging == false then
		self._tableview:MoveCellInView(#self._curViewDatas - 1, false)
	end

	local id = self._curViewDatas[#self._curViewDatas]
	local cfg = FusionSoulConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, id) or {}
	local clueId = checknumber(cfg.clueId)

	if clueId > 0 then
		self._isSendSuccess = true
	end

	local autoNextId = checknumber(cfg.autoNext)

	if autoNextId > 0 then
		self._scrollRect.enabled = false

		table.insert(self._curViewDatas, autoNextId)
		settimer(0.8, self._reloadData, self, false)
	else
		self._scrollRect.enabled = true
	end

	local isEnd = checknumber(cfg.isEnd)

	GameUtil.SetActive(self._btnClose, false)

	if isEnd == 1 then
		GameUtil.SetActive(self._btnClose, true)
		GameUtil.SetActive(self._answerGrop, false)
		settimer(0.8, self.showBlockClue, self, false)
	end

	if self._hasQuestion == true then
		GameUtil.SetActive(self._btnClose, true)
		settimer(0.8, self.showBlockClue, self, false)
	end
end

function FusionSoulChatView:_clearTableview(cell)
	return
end

function FusionSoulChatView:_getCellTag(data)
	local cfg = FusionSoulConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, data) or {}
	local npcCfg = FusionSoulConfig.instance:getNpcCfgById(self._activityId, cfg.npcId) or {}

	if checknumber(npcCfg.isMe) == 1 then
		if not GameEnum.GFChatGroupType.SELF then
			return GameEnum.GFChatGroupType.INTRODUCE
		end
	end
end

function FusionSoulChatView:_updateAnswer()
	goutil.clearChildren(self._container)

	self._hasQuestion = false

	if #self._curViewDatas == 0 then
		return
	end

	local id = self._curViewDatas[#self._curViewDatas]
	local cfg = FusionSoulConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, id) or {}
	local waitAnswer = {}
	local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, self._zoneId)

	if zoneInfo.selectAnswer then
		for i, v in ipairs(cfg.waitAnswer or {}) do
			local isFind = false

			for j, id in ipairs(zoneInfo.selectAnswer) do
				if v == id then
					isFind = true
				end
			end

			if not isFind then
				table.insert(waitAnswer, v)
			end
		end
	elseif cfg.waitAnswer then
		waitAnswer = cfg.waitAnswer
	end

	for i, aId in ipairs(waitAnswer) do
		local go = goutil.cloneAndSetParent(self._answerItem, self._container.transform)

		GameUtil.SetActive(go, true)

		local descText = goutil.findChildTextComponent(go, "text")
		local selectGo = goutil.findChild(go, "select")
		local tem = FusionSoulConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, aId) or {}

		descText.text = tem.desc

		GameUtil.addClickHandler(go, function()
			self:_onClickAnswer(aId)
		end)
	end

	self._hasQuestion = #waitAnswer > 0

	GameUtil.SetActive(self._sendBtn, self._hasQuestion)
end

function FusionSoulChatView:_onClickClose()
	if not self._isSendSuccess then
		-- block empty
	end

	self:close()
end

function FusionSoulChatView:_onClickAnswer(index)
	local eventCfg = FusionSoulConfig.instance:getEventCfg(self._activityId, self._zoneId, self._eventId)
	local matType, matId = MaterialMgr.getMatParams(self._activityCfg.energyKey)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	if EnergyController.instance:getEnergyNum(matId) >= eventCfg.energyCost then
		local collectClue = {}
		local nextChat = index

		while nextChat ~= 0 do
			local dialogueCfg = FusionSoulConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, nextChat)

			if not dialogueCfg then
				break
			end

			if checknumber(dialogueCfg.clueId) > 0 then
				table.insert(collectClue, dialogueCfg.clueId)
			end

			nextChat = checknumber(dialogueCfg.autoNext) > 0 and dialogueCfg.autoNext or 0
		end

		FusionSoulController.instance:setBlockClue(collectClue)
		FusionSoulController.instance:sendPM_FusionSoulSelectAnswerReq(self._activityId, self._zoneId, self._eventId, index)
		self:_changeItemParentState(true)
		table.insert(self._curViewDatas, index)
		self:_reloadData()
	else
		FloatWordMgr.instance:show(langPara("%s不足，回复后再来吧~", matName))
	end
end

function FusionSoulChatView:_onAddNewMsg()
	self:_reloadData()
end

function FusionSoulChatView:_changeItemParentState(forceHide)
	self._isHideItemParent = not self._isHideItemParent

	if forceHide then
		self._isHideItemParent = true
	end

	goutil.setActive(self._answerItemParent, not self._isHideItemParent)
end

function FusionSoulChatView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function FusionSoulChatView:_cellSize(view, index)
	return 474, self:_getCellHeight(index + 1)
end

function FusionSoulChatView:_getCellHeight(index)
	local data = self._curViewDatas[index]
	local cfg = FusionSoulConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, data) or {}

	self._TxtC_Test.text = cfg.content

	local baseH = 21

	return 100 + math.max(0, self._TxtC_Test.preferredHeight - baseH)
end

function FusionSoulChatView:showBlockClue()
	local blockClue = FusionSoulController.instance:getBlockClue()
	local list = {}

	for k, v in pairs(blockClue) do
		table.insert(list, k)
	end

	if #list > 0 then
		local content = "获得线索"

		for i, v in ipairs(list) do
			local clueCfg = FusionSoulConfig.instance:getClueCfg(self._activityId, v)

			content = langPara("%s【%s】", content, clueCfg.name)
		end

		FloatWordMgr.instance:show(content)
		UIStateManager.instance:push(ViewName.FusionSoulClueTipView, self._activityId, list[1], true)
	end

	FusionSoulController.instance:setBlockClue()
end

return FusionSoulChatView
