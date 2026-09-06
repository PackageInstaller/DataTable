-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddesschatView.lua

module("logic.extensions.goddess.view.GoddesschatView", package.seeall)

local GoddesschatView = class("GoddesschatView", ViewComponent)

function GoddesschatView:ctor()
	GoddesschatView.super.ctor(self)

	self._answerItemList = {}
end

function GoddesschatView:buildUI()
	GoddesschatView.super.buildUI(self)

	self._tableview = self:getGo("tableview"):GetComponent(ComponentType.UITableview)
	self._tableviewTr = self._tableview.gameObject.transform
	self._answerGrop = self:getGo("answerGrop")
	self._answerItemParent = self:getGo("answerGrop/itemParent")
	self._answerItem = self:getGo("answerGrop/itemParent/cell")
	self._answerItemBgTr = self:getGo("answerGrop/itemParent/bg").transform

	GameUtil.setLocalPos(self._answerItem, 0, 10000, 0)

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
	self._closeBtn = self:getBtn("closeBtn")
end

function GoddesschatView:bindEvents()
	GoddesschatView.super.bindEvents(self)
	self._sendBtn:AddClickListener(self._onClickSend, self)
	self._closeSendBgBtn:AddClickListener(self._changeItemParentState, self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
end

function GoddesschatView:unbindEvents()
	GoddesschatView.super.unbindEvents(self)
	self._sendBtn:RemoveClickListener()
	self._closeSendBgBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
end

function GoddesschatView:destroyUI()
	GoddesschatView.super.destroyUI(self)

	self._answerItemList = {}
end

function GoddesschatView:onEnter()
	GoddesschatView.super.onEnter(self)

	self._isFirstEnter = true
	self._isFirstGetTextId = true
	self._needPlayBubble = false

	GlobalDispatcher:addListener(GlobalNotify.GoddessNewChatRes, self._selfChatRes, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
	goutil.setActive(self._answerGrop, false)

	self._raceId = self:getFirstParam()

	self:_initGoddessInfo()
	self:_changeItemParentState(true)
	self:_updateAnswer()
	self:_reloadData()
end

function GoddesschatView:onEnterFinished()
	GoddesschatView.super.onEnterFinished(self)
end

function GoddesschatView:onExit()
	GoddesschatView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessNewChatRes, self._selfChatRes, self)
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()

	self._curViewDatas = nil

	if self._needPlayBubble then
		local info = GoddessModel.instance:getGoddessInfo(self._raceId)

		if info then
			GlobalDispatcher:dispatch(GlobalNotify.GoddessPlayBubble, info.raceCfg.bubbleChat)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.GoddessRefresMainView)
end

function GoddesschatView:onExitFinished()
	GoddesschatView.super.onExitFinished(self)
end

function GoddesschatView:_onClickSend()
	local forceClose = false

	if not self._isHideItemParent and self._answerDataList and self._answerDataList[self._currAnswerIndex] then
		local chatTextCfg = self._answerDataList[self._currAnswerIndex]

		forceClose = true

		local activityId = GoddessModel.instance:getActId()

		GoddessAgent.instance:sendPM_GoddessChatReq(activityId, self._goddessInfo.raceId, chatTextCfg.id)
	end

	self:_changeItemParentState(forceClose)
end

function GoddesschatView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function GoddesschatView:_cellSize(view, index)
	return 474, self:_getCellHeight(index + 1)
end

function GoddesschatView:_cellAtIndex(view, idx)
	local data = self._curViewDatas[idx + 1]
	local tag = self:_getCellTag(data)
	local cell = view:DequeueCellByTag(tag)

	cell = cell or view:AddChild(self._tableCells[tag], tag)

	self:_updateCell(cell, data)

	return cell
end

function GoddesschatView:_updateCell(cell, data)
	local item = GameUtil.AddLuaOnce(cell.gameObject, GoddesschatItem)

	item:onEnter(data)
end

function GoddesschatView:_onReloadFinish()
	self._tableview:SetOffset(self._tableview:GetMaxOffset(), not self._isFirstEnter)

	self._isFirstEnter = false
end

function GoddesschatView:_clearTableview(cell)
	local item = GameUtil.AddLuaOnce(cell.gameObject, GoddesschatItem)

	item:onExit()
end

function GoddesschatView:_reloadData()
	self._curViewDatas = {}

	local ccfg = CharacterConfig.instance:getModelCo(self._raceId)
	local headName = ccfg.headName
	local chatTextIds = GoddessModel.instance:getChatTextIds(self._raceId, self._isFirstGetTextId)

	self._isFirstGetTextId = false

	for i, chatId in ipairs(chatTextIds) do
		local ccfg = GoddessConfig.instance:getChatTextCfgByChatId(chatId)
		local isMe = ccfg.type == "player"

		table.insert(self._curViewDatas, {
			cfg = ccfg,
			isMe = isMe,
			headName = headName
		})
	end

	self._tableview:ReloadData()
	self:_updateSelfChatTime()
end

function GoddesschatView:_getCellHeight(index)
	local data = self._curViewDatas[index]

	self._TxtC_Test.text = data.chatTxt

	local baseH = 21

	return 100 + math.max(0, self._TxtC_Test.preferredHeight - baseH)
end

function GoddesschatView:_getCellTag(data)
	if data.cfg.type == "player" then
		if not GameEnum.GFChatGroupType.SELF then
			return GameEnum.GFChatGroupType.INTRODUCE
		end
	end
end

function GoddesschatView:_updateAnswer()
	if not self._goddessInfo.chatTextId[#self._goddessInfo.chatTextId] then
		local chatId = 0

		if chatId <= 0 then
			goutil.setActive(self._answerGrop, false)

			return
		end

		local chatTextCfg = GoddessConfig.instance:getChatTextCfgByChatId(chatId)

		if chatTextCfg.type == "player" then
			goutil.setActive(self._answerGrop, false)

			return
		end

		local nextNum = chatTextCfg.num + 1
		local chatCfgs = GoddessConfig.instance:getChatTextCfgsByChatOrder(chatTextCfg.planId, nextNum)
		local new_chatCfgs = {}

		if #chatCfgs <= 0 then
			goutil.setActive(self._answerGrop, false)

			return
		end

		for k, v in pairs(chatCfgs) do
			if v.type ~= "spirit" then
				table.insert(new_chatCfgs, v)
			end
		end

		local left = GoddessConfig.instance:getTotalChatTime() - GoddessModel.instance:getDailyChatTime()

		if left <= 0 then
			goutil.setActive(self._answerGrop, false)

			return
		end

		self._answerDataList = new_chatCfgs

		local len = #self._answerDataList

		goutil.setActive(self._answerGrop, len > 0)

		for _, v in pairs(self._answerItemList) do
			goutil.setActive(v.mainGO, false)
		end

		for i, cfg in ipairs(self._answerDataList) do
			local item = self._answerItemList[i]

			if not item then
				local go = goutil.cloneAndSetParent(self._answerItem, self._answerItemParent.transform)
				local descText = goutil.findChildTextComponent(go, "text")
				local selectGo = goutil.findChild(go, "select")
				local btn = GameUtil.asBtn(go)

				item = {
					mainGO = go,
					descText = descText,
					selectGo = selectGo,
					btn = btn
				}
				self._answerItemList[i] = item
			end

			goutil.setActive(item.mainGO, true)
			goutil.setActive(item.selectGo, false)

			item.descText.text = cfg.text

			local x, y = GameUtil.getPosWihtRowAndCol(0, 55, i, 0, 1, 20, 32)

			GameUtil.setLocalPos(item.mainGO, x, y, 0)
			item.btn:RemoveClickListener()
			item.btn:AddClickListener(function()
				self:_onClickAnswer(i, true)
			end)
		end

		self._currAnswerIndex = self._currAnswerIndex or 1

		self:_onClickAnswer(self._currAnswerIndex)

		self._answerItemBgTr.sizeDelta = Vector2.New(844, len * 55 + 16)

		self:_updateSelfChatTime()
	end
end

function GoddesschatView:_updateSelfChatTime()
	local left = GoddessConfig.instance:getTotalChatTime() - GoddessModel.instance:getDailyChatTime()

	self._sendBtnText.text = string.format("点击进行主动对话（本日还可进行%s次通信）", left)
end

function GoddesschatView:_onClickAnswer(index, send)
	self._currAnswerIndex = index

	for i, v in ipairs(self._answerItemList) do
		goutil.setActive(v.selectGo, i == index)
	end

	if send then
		local left = GoddessConfig.instance:getTotalChatTime() - GoddessModel.instance:getDailyChatTime()

		if left <= 0 then
			FloatWordMgr.instance:show("今天次数已用完，请明天再来哦")

			return
		end

		self:_onClickSend()
	end
end

function GoddesschatView:_changeItemParentState(forceHide)
	self._isHideItemParent = not self._isHideItemParent

	if forceHide then
		self._isHideItemParent = true
	end

	goutil.setActive(self._answerItemParent, not self._isHideItemParent)
end

function GoddesschatView:_selfChatRes()
	self:_initGoddessInfo()
	self:_updateSelfChatTime()
	self:_updateAnswer()
	self:_reloadData()

	self._needPlayBubble = true
end

function GoddesschatView:_onClickcloseBtn()
	self:close()
end

function GoddesschatView:_initGoddessInfo()
	self._goddessInfo = GoddessModel.instance:getGoddessInfo(self._raceId)
end

return GoddesschatView
