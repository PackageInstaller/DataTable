-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillreplayView.lua

module("logic.extensions.scriptkill.view.ScriptkillreplayView", package.seeall)

local ScriptkillreplayView = class("ScriptkillreplayView", ViewComponent)

function ScriptkillreplayView:unbindEvents()
	ScriptkillreplayView.super.unbindEvents(self)
	self._sendBtn:RemoveClickListener()
	self._closeSendBgBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnClose)
end

function ScriptkillreplayView:bindEvents()
	ScriptkillreplayView.super.bindEvents(self)
	self._sendBtn:AddClickListener(self._onClickSend, self)
	self._closeSendBgBtn:AddClickListener(function()
		self:_changeItemParentState(true)
	end)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function ScriptkillreplayView:buildUI()
	ScriptkillreplayView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableviewTr = self._tableview.gameObject.transform

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)

	self._goEmpty = self:getGo("goEmpty")
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

function ScriptkillreplayView:onExit()
	ScriptkillreplayView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil
end

function ScriptkillreplayView:onEnter()
	ScriptkillreplayView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._chapterId = checknumber(params[2])

	goutil.setActive(self._answerGrop, false)

	self._curViewDatas = {}

	local ids = ScriptKillModel.instance:getClueIds(self._activityId) or {}

	for i, clueId in ipairs(ids) do
		local cfg = ScriptKillConfig.instance:getClueCfgById(self._activityId, clueId)

		if cfg and cfg.chapterId == self._chapterId and not string.nilorempty(cfg.content) then
			table.insert(self._curViewDatas, cfg)
		end
	end

	GameUtil.SetActive(self._goEmpty, #self._curViewDatas == 0)
	self:_reloadData()
end

function ScriptkillreplayView:_reloadData()
	self._tableview:ReloadData()
end

function ScriptkillreplayView:_onClickSend()
	if self._hasQuestion then
		self:_changeItemParentState()
	end
end

function ScriptkillreplayView:_cellAtIndex(view, idx)
	local data = self._curViewDatas[idx + 1]
	local tag = self:_getCellTag(data)
	local cell = view:DequeueCellByTag(tag)

	cell = cell or view:AddChild(self._tableCells[tag], tag)

	local contentText = goutil.findChildTextComponent(cell.gameObject, "ImgC_ContentBg/TxtC_Content")
	local headIcon = goutil.findChild(cell.gameObject, "Nego_Icon/ImgC_Icon")

	contentText.text = data.content

	local npcCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, data.npcId) or {}

	uGuiUtil.setSpriteToImage(headIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(npcCfg.icon))

	return cell
end

function ScriptkillreplayView:_onReloadFinish()
	return
end

function ScriptkillreplayView:_clearTableview(cell)
	return
end

function ScriptkillreplayView:_getCellTag(data)
	local npcCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, data.npcId) or {}

	if checknumber(npcCfg.isMe) == 1 then
		if not GameEnum.GFChatGroupType.SELF then
			return GameEnum.GFChatGroupType.INTRODUCE
		end
	end
end

function ScriptkillreplayView:_updateAnswer()
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

function ScriptkillreplayView:_onClickClose()
	self:close()
end

function ScriptkillreplayView:_onClickAnswer(index)
	ScriptKillController.instance:sendUseActionPoint(self._activityId)
	self:_changeItemParentState(true)
	table.insert(self._curViewDatas, index)
	self:_reloadData()
end

function ScriptkillreplayView:_onAddNewMsg()
	self:_reloadData()
end

function ScriptkillreplayView:_changeItemParentState(forceHide)
	self._isHideItemParent = not self._isHideItemParent

	if forceHide then
		self._isHideItemParent = true
	end

	goutil.setActive(self._answerItemParent, not self._isHideItemParent)
end

function ScriptkillreplayView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function ScriptkillreplayView:_cellSize(view, index)
	return 474, self:_getCellHeight(index + 1)
end

function ScriptkillreplayView:_getCellHeight(index)
	local data = self._curViewDatas[index]
	local cfg = ScriptKillConfig.instance:getDialogueCfgById(self._activityId, self._dialogueId, data) or {}

	self._TxtC_Test.text = cfg.content

	local baseH = 21

	return 100 + math.max(0, self._TxtC_Test.preferredHeight - baseH)
end

return ScriptkillreplayView
