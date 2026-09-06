-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelchatView.lua

module("logic.extensions.goodfeel.view.GoodfeelchatView", package.seeall)

local GoodfeelchatView = class("GoodfeelchatView", ViewComponent)

function GoodfeelchatView:ctor()
	GoodfeelchatView.super.ctor(self)

	self._answerItemList = {}
end

function GoodfeelchatView:buildUI()
	GoodfeelchatView.super.buildUI(self)

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
end

function GoodfeelchatView:bindEvents()
	GoodfeelchatView.super.bindEvents(self)
	self._sendBtn:AddClickListener(self._onClickSend, self)
	self._closeSendBgBtn:AddClickListener(self._changeItemParentState, self)
end

function GoodfeelchatView:unbindEvents()
	GoodfeelchatView.super.unbindEvents(self)
	self._sendBtn:RemoveClickListener()
	self._closeSendBgBtn:RemoveClickListener()
end

function GoodfeelchatView:destroyUI()
	GoodfeelchatView.super.destroyUI(self)

	self._answerItemList = {}
end

function GoodfeelchatView:onEnter()
	GoodfeelchatView.super.onEnter(self)

	self._isFirstEnter = true

	GlobalDispatcher:addListener(GoodFeelModel.OnAddNewMsg, self._onAddNewMsg, self)
	GlobalDispatcher:addListener(GoodFeelController.PM_GFGetChatInfoRes, self._reloadData, self)
	GlobalDispatcher:addListener(GoodFeelController.PM_GFSelfChatRes, self._selfChatRes, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
	goutil.setActive(self._answerGrop, false)
	GoodFeelingAgent.instance:sendPM_GFGetChatInfoReq()
	self:_changeItemParentState(true)
	self:_updateAnswer()
end

function GoodfeelchatView:onEnterFinished()
	GoodfeelchatView.super.onEnterFinished(self)
end

function GoodfeelchatView:onExit()
	GoodfeelchatView.super.onExit(self)
	GlobalDispatcher:removeListener(GoodFeelModel.OnAddNewMsg, self._onAddNewMsg, self)
	GlobalDispatcher:removeListener(GoodFeelController.PM_GFGetChatInfoRes, self._reloadData, self)
	GlobalDispatcher:removeListener(GoodFeelController.PM_GFSelfChatRes, self._selfChatRes, self)
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()
	GoodFeelModel.instance:clearSlowAddMsgList()

	self._curViewDatas = nil
end

function GoodfeelchatView:onExitFinished()
	GoodfeelchatView.super.onExitFinished(self)
end

function GoodfeelchatView:_onClickSend()
	local forceClose = false

	if not self._isHideItemParent and self._answerDataList and self._answerDataList[self._currAnswerIndex] then
		local chatId = self._answerDataList[self._currAnswerIndex]

		forceClose = true

		GoodFeelingAgent.instance:sendPM_GFSelfChatReq(chatId)
	end

	self:_changeItemParentState(forceClose)
end

function GoodfeelchatView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function GoodfeelchatView:_cellSize(view, index)
	return 474, self:_getCellHeight(index + 1)
end

function GoodfeelchatView:_cellAtIndex(view, idx)
	local data = self._curViewDatas[idx + 1]
	local tag = self:_getCellTag(data)
	local cell = view:DequeueCellByTag(tag)

	cell = cell or view:AddChild(self._tableCells[tag], tag)

	local item = GameUtil.AddLuaOnce(cell.gameObject, GoodFeelChatItem)

	item:onEnter(data)

	return cell
end

function GoodfeelchatView:_onReloadFinish()
	self._tableview:SetOffset(self._tableview:GetMaxOffset(), not self._isFirstEnter)

	if self._isFirstEnter and GoodFeelModel.instance:hasSlowChatDatas() then
		GoodFeelModel.instance:startPlaySlowMsg()
	end

	self._isFirstEnter = false
end

function GoodfeelchatView:_clearTableview(cell)
	local item = GameUtil.AddLuaOnce(cell.gameObject, GoodFeelChatItem)

	item:onExit()
end

function GoodfeelchatView:_reloadData()
	self._curViewDatas = {}

	local list = GoodFeelModel.instance:getHistoryChatDatas()

	for i, v in ipairs(list) do
		table.insert(self._curViewDatas, v)
	end

	self._tableview:ReloadData()
	self:_updateSelfChatTime()
end

function GoodfeelchatView:_getCellHeight(index)
	local data = self._curViewDatas[index]

	self._TxtC_Test.text = data.chatTxt

	local baseH = 21

	return 100 + math.max(0, self._TxtC_Test.preferredHeight - baseH)
end

function GoodfeelchatView:_getCellTag(data)
	if data.isMe then
		if not GameEnum.GFChatGroupType.SELF then
			return GameEnum.GFChatGroupType.INTRODUCE
		end
	end
end

function GoodfeelchatView:_updateAnswer()
	local list = GoodFeelModel.instance:getSelfchatids()

	if not list or #list <= 0 then
		goutil.setActive(self._answerGrop, false)

		return
	end

	table.sort(list, function(a, b)
		return a < b
	end)

	self._answerDataList = list

	local len = #self._answerDataList

	goutil.setActive(self._answerGrop, len > 0)

	for _, v in pairs(self._answerItemList) do
		goutil.setActive(v.mainGO, false)
	end

	for i, id in ipairs(self._answerDataList) do
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

		local cfg = GoodFeelConfig.instance:getSelfChatCfg(id)

		item.descText.text = cfg.chatText

		local x, y = GameUtil.getPosWihtRowAndCol(0, 55, i, 0, 1, 20, 32)

		GameUtil.setLocalPos(item.mainGO, x, y, 0)
		item.btn:RemoveClickListener()
		item.btn:AddClickListener(function()
			self:_onClickAnswer(i, true)
		end)
	end

	self._currAnswerIndex = self._currAnswerIndex or 1

	self:_onClickAnswer(self._currAnswerIndex)

	self._answerItemBgTr.sizeDelta = Vector2.New(844, len * 55 + 35)

	self:_updateSelfChatTime()
end

function GoodfeelchatView:_updateSelfChatTime()
	local left = GoodFeelConfig.instance:getDaylySelfChatCount() - GoodFeelModel.instance:getTodaySelfChatCount()

	self._sendBtnText.text = string.format("点击进行主动对话（本日剩余%s次）", left)
end

function GoodfeelchatView:_onClickAnswer(index, send)
	self._currAnswerIndex = index

	for i, v in ipairs(self._answerItemList) do
		goutil.setActive(v.selectGo, i == index)
	end

	if send then
		local left = GoodFeelConfig.instance:getDaylySelfChatCount() - GoodFeelModel.instance:getTodaySelfChatCount()

		if left <= 0 then
			FloatWordMgr.instance:show("今天次数已用完，请明天再来哦")

			return
		end

		self:_onClickSend()
	end
end

function GoodfeelchatView:_onAddNewMsg()
	self:_reloadData()
end

function GoodfeelchatView:_changeItemParentState(forceHide)
	self._isHideItemParent = not self._isHideItemParent

	if forceHide then
		self._isHideItemParent = true
	end

	goutil.setActive(self._answerItemParent, not self._isHideItemParent)
end

function GoodfeelchatView:_selfChatRes()
	self:_updateSelfChatTime()
end

return GoodfeelchatView
