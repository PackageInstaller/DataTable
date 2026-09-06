-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillchatView.lua

module("logic.extensions.scriptkill.view.ScriptkillchatView", package.seeall)

local ScriptkillchatView = class("ScriptkillchatView", ViewComponent)

function ScriptkillchatView:unbindEvents()
	ScriptkillchatView.super.unbindEvents(self)
	self._sendBtn:RemoveClickListener()
	self._closeSendBgBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnClose)
	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
end

function ScriptkillchatView:bindEvents()
	ScriptkillchatView.super.bindEvents(self)
	self._sendBtn:AddClickListener(self._onClickSend, self)
	self._closeSendBgBtn:AddClickListener(function()
		self:_changeItemParentState(true)
	end)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)

	self._drag = Framework.UIDragTrigger.Get(self:getGo("tableview"))

	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)
end

function ScriptkillchatView:buildUI()
	ScriptkillchatView.super.buildUI(self)

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

function ScriptkillchatView:onExit()
	ScriptkillchatView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil

	removetimer(self._reloadData, self)
end

function ScriptkillchatView:onEnter()
	ScriptkillchatView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._dialogueId = checknumber(params[2])
	self._scrollRect.enabled = true
	self._isDraging = false
	self._isSendSuccess = false

	GameUtil.SetActive(self._btnClose, false)
	GameUtil.SetActive(self._answerGrop, true)

	local firstId = 1

	self._curViewDatas = {}

	table.insert(self._curViewDatas, firstId)

	self._hasQuestion = false

	self:_changeItemParentState(true)
	self:_reloadData()
end

function ScriptkillchatView:_reloadData()
	self._tableview:ReloadData()
	self:_updateAnswer()
end

function ScriptkillchatView:_onClickSend()
	if self._hasQuestion then
		self:_changeItemParentState()
	end
end

function ScriptkillchatView:_cellAtIndex(view, idx)
	local data = self._curViewDatas[idx + 1]
	local tag = self:_getCellTag(data)
	local cell = view:DequeueCellByTag(tag)

	cell = cell or view:AddChild(self._tableCells[tag], tag)

	local contentText = goutil.findChildTextComponent(cell.gameObject, "ImgC_ContentBg/TxtC_Content")
	local headIcon = goutil.findChild(cell.gameObject, "Nego_Icon/ImgC_Icon")
	local cfg = ScriptKillConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, data) or {}

	contentText.text = cfg.content

	local npcCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, cfg.npcId) or {}

	uGuiUtil.setSpriteToImage(headIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(npcCfg.icon))

	return cell
end

function ScriptkillchatView:_onBeginDrag(eventData)
	self._isDraging = true
end

function ScriptkillchatView:_onEndDrag(eventData)
	self._isDraging = false
end

function ScriptkillchatView:_onReloadFinish()
	if #self._curViewDatas == 0 then
		return
	end

	if self._isDraging == false then
		self._tableview:MoveCellInView(#self._curViewDatas - 1, false)
	end

	local id = self._curViewDatas[#self._curViewDatas]
	local cfg = ScriptKillConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, id) or {}
	local clueId = checknumber(cfg.clueId)

	if clueId > 0 then
		self._isSendSuccess = true

		ScriptKillController.instance:sendGetTalkClue(self._activityId, clueId, true)
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

	if isEnd == 1 then
		GameUtil.SetActive(self._btnClose, true)
		GameUtil.SetActive(self._answerGrop, false)
	end
end

function ScriptkillchatView:_clearTableview(cell)
	return
end

function ScriptkillchatView:_getCellTag(data)
	local cfg = ScriptKillConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, data) or {}
	local npcCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, cfg.npcId) or {}

	if checknumber(npcCfg.isMe) == 1 then
		if not GameEnum.GFChatGroupType.SELF then
			return GameEnum.GFChatGroupType.INTRODUCE
		end
	end
end

function ScriptkillchatView:_updateAnswer()
	goutil.clearChildren(self._container)

	self._hasQuestion = false

	if #self._curViewDatas == 0 then
		return
	end

	local id = self._curViewDatas[#self._curViewDatas]
	local cfg = ScriptKillConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, id) or {}

	if not cfg.waitAnswer then
		local waitAnswer = {}

		for i, aId in ipairs(waitAnswer) do
			local go = goutil.cloneAndSetParent(self._answerItem, self._container.transform)

			GameUtil.SetActive(go, true)

			local descText = goutil.findChildTextComponent(go, "text")
			local selectGo = goutil.findChild(go, "select")
			local tem = ScriptKillConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, aId) or {}

			descText.text = tem.desc

			GameUtil.addClickHandler(go, function()
				self:_onClickAnswer(aId)
			end)
		end

		self._hasQuestion = #waitAnswer > 0
	end
end

function ScriptkillchatView:_onClickClose()
	ScriptKillController.instance:sendClearTalk(self._activityId)

	if not self._isSendSuccess then
		ScriptKillController.instance:sendGetTalkClue(self._activityId, clueId, false)
	end

	self:close()
end

function ScriptkillchatView:_onClickAnswer(index)
	ScriptKillController.instance:sendUseActionPoint(self._activityId)
	self:_changeItemParentState(true)
	table.insert(self._curViewDatas, index)
	self:_reloadData()
end

function ScriptkillchatView:_onAddNewMsg()
	self:_reloadData()
end

function ScriptkillchatView:_changeItemParentState(forceHide)
	self._isHideItemParent = not self._isHideItemParent

	if forceHide then
		self._isHideItemParent = true
	end

	goutil.setActive(self._answerItemParent, not self._isHideItemParent)
end

function ScriptkillchatView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function ScriptkillchatView:_cellSize(view, index)
	return 474, self:_getCellHeight(index + 1)
end

function ScriptkillchatView:_getCellHeight(index)
	local data = self._curViewDatas[index]
	local cfg = ScriptKillConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, data) or {}

	self._TxtC_Test.text = cfg.content

	local baseH = 21

	return 100 + math.max(0, self._TxtC_Test.preferredHeight - baseH)
end

return ScriptkillchatView
