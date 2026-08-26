-- chunkname: @modules/logic/survival/view/leavemessage/SurvivalLeaveMsgView.lua

module("modules.logic.survival.view.leavemessage.SurvivalLeaveMsgView", package.seeall)

local SurvivalLeaveMsgView = class("SurvivalLeaveMsgView", BaseView)

function SurvivalLeaveMsgView:onInitView()
	self.root = gohelper.findChild(self.viewGO, "root")
	self.btn_close = gohelper.findChildButtonWithAudio(self.root, "title/icon")
	self.LeaveMsg = gohelper.findChild(self.root, "LeaveMsg")
	self.go_msgScroll = gohelper.findChild(self.LeaveMsg, "go_msgScroll")
	self.SurvivalLeaveMsgItem = gohelper.findChild(self.go_msgScroll, "Viewport/Content/SurvivalLeaveMsgItem")
	self.btnLeaveMsg = gohelper.findChildButtonWithAudio(self.LeaveMsg, "#btn_LeaveMsg")
	self.textLeaveMsg = gohelper.findChildTextMesh(self.btnLeaveMsg.gameObject, "textLeaveMsg")
	self.goEmpty = gohelper.findChild(self.LeaveMsg, "goEmpty")
	self.WriteMsg = gohelper.findChild(self.root, "WriteMsg")
	self.selectNode = gohelper.findChild(self.WriteMsg, "selectNode")
	self.SurvivalLeaveSelectItem = gohelper.findChild(self.selectNode, "Viewport/Content/SurvivalLeaveSelectItem")
	self.go_writeList = gohelper.findChild(self.WriteMsg, "scroll/viewport/go_writeList")
	self.SurvivalLeaveWriteItem = gohelper.findChild(self.go_writeList, "SurvivalLeaveWriteItem")
	self.textPreview = gohelper.findChildTextMesh(self.WriteMsg, "preview/#txt_Preview")
	self.btnConfirmWrite = gohelper.findChildButtonWithAudio(self.WriteMsg, "#btn_ConfirmWrite")
	self.btn_back = gohelper.findChildButtonWithAudio(self.WriteMsg, "#btn_back")

	local param = SimpleListParam.New()

	param.cellClass = SurvivalLeaveMsgItem
	param.lineCount = 1
	param.startSpace = 10
	param.cellSpaceV = 22
	self.msgScroll = GameFacade.createSimpleListComp(self.go_msgScroll, param, self.SurvivalLeaveMsgItem, self.viewContainer)
	param = SimpleListParam.New()
	param.cellClass = SurvivalLeaveWriteItem
	self.writeList = GameFacade.createSimpleListComp(self.go_writeList, param, self.SurvivalLeaveWriteItem, self.viewContainer)

	self.writeList:setOnClickItem(self.onClickWriteItem, self)

	self.selectIds = {
		-1,
		-1,
		-1,
		-1,
		-1
	}

	local LeaveMsgType = SurvivalEnum.LeaveMsgType

	self.leaveMsgTypeList = {
		LeaveMsgType.Sentence,
		LeaveMsgType.Word,
		SurvivalEnum.LeaveMsgType.Connect,
		SurvivalEnum.LeaveMsgType.Sentence,
		SurvivalEnum.LeaveMsgType.Word
	}
end

function SurvivalLeaveMsgView:addEvents()
	self.addClickCb(self, self.btn_close, self.closeThis, self)
	self.addClickCb(self, self.btnLeaveMsg, self.onClickBtnLeaveMsg, self)
	self.addClickCb(self, self.btnConfirmWrite, self.onClickBtnConfirmWrite, self)
	self.addClickCb(self, self.btn_back, self.onClickBtnGoBack, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalMessageOperationReply, self.onReceiveSurvivalMessageOperationReply, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalAddMessageReply, self.onReceiveSurvivalAddMessageReply, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalEditMessageReply, self.onReceiveSurvivalEditMessageReply, self)
end

function SurvivalLeaveMsgView:onOpen()
	self.unitId = self.viewParam.unitId
	self.survivalMessageBoardViewReply = self.viewParam
	self.messages = self.survivalMessageBoardViewReply.message
	self.uiType = 1

	self:refresh()
end

function SurvivalLeaveMsgView:onClose()
	return
end

function SurvivalLeaveMsgView:onDestroyView()
	return
end

function SurvivalLeaveMsgView:onClickModalMask()
	self:closeThis()
end

function SurvivalLeaveMsgView:onClickBtnLeaveMsg()
	self.uiType = 2

	if self.selfMessage then
		self.selectIds = SurvivalConfig.instance:switchServerMessage(self.selfMessage.configId)
	end

	self:refresh(true)
end

function SurvivalLeaveMsgView:onClickBtnGoBack()
	self.uiType = 1

	self:refresh(true)
end

function SurvivalLeaveMsgView:onReceiveSurvivalMessageOperationReply(msg)
	local id = msg.message.id

	for i, v in ipairs(self.messages) do
		if v.id == id then
			if msg.operationType == SurvivalEnum.LeaveMsgOptType.Delete then
				table.remove(self.messages, i)

				break
			end

			self.messages[i] = msg.message

			break
		end
	end

	local itemIndex

	for i, v in ipairs(self.leaveMsgData) do
		if v.survivalMessage.id == id then
			itemIndex = i

			break
		end
	end

	local item = self.msgScroll:getItemByIndex(itemIndex)

	if msg.operationType == SurvivalEnum.LeaveMsgOptType.Delete then
		self:refreshLeaveMsgData()
		self.msgScroll:removeItemWithAnim(itemIndex)
	elseif msg.operationType == SurvivalEnum.LeaveMsgOptType.Like then
		self:refreshLeaveMsg()

		if item then
			item:playLikeAnim()
		end
	elseif msg.operationType == SurvivalEnum.LeaveMsgOptType.UnLike then
		self:refreshLeaveMsg()

		if item then
			item:playUnLikeAnim()
		end
	else
		self:refreshLeaveMsg()
	end
end

function SurvivalLeaveMsgView:onReceiveSurvivalAddMessageReply(msg)
	self.messages = msg.message
	self.uiType = 1

	self:refresh()
end

function SurvivalLeaveMsgView:onReceiveSurvivalEditMessageReply(msg)
	if self.selfMessage then
		rawset(self.selfMessage, "configId", msg.configId)

		self.uiType = 1

		self:refresh()
	end
end

function SurvivalLeaveMsgView:onClickBtnConfirmWrite()
	local final = self:getFinalSelectIds()
	local ids = self:GetSelectIds()

	if #ids <= 0 then
		GameFacade.showToastString(luaLang("SurvivalLeaveMsgView_4"))

		return
	elseif final[1] ~= -1 and final[2] == -1 or final[4] ~= -1 and final[5] == -1 then
		GameFacade.showToastString(luaLang("SurvivalLeaveMsgView_5"))

		return
	end

	if self.selfMessage then
		SurvivalInteriorRpc.instance:sendSurvivalEditMessageRequest(self.unitId, ids)
		SurvivalStatHelper.instance:statEditMsg("EditMessage", ids)
	else
		SurvivalInteriorRpc.instance:sendSurvivalAddMessageRequest(self.unitId, ids)
		SurvivalStatHelper.instance:statEditMsg("AddMessage", ids)
	end
end

function SurvivalLeaveMsgView:refresh(isAnim)
	gohelper.setActive(self.LeaveMsg, self.uiType == 1)
	gohelper.setActive(self.WriteMsg, self.uiType == 2)

	self.textPreview.text = ""

	self:refreshLeaveMsgData()
	self:refreshLeaveMsg(isAnim)
	self:refreshWriteList()
	self:refreshPreview()
end

function SurvivalLeaveMsgView:refreshLeaveMsgData()
	self.selfMsgIndex = nil
	self.selfMessage = nil

	for i, v in ipairs(self.messages) do
		if v.isSelf then
			self.selfMsgIndex = i
			self.selfMessage = v

			break
		end
	end

	if self.selfMsgIndex then
		self.messages[1] = self.messages[self.selfMsgIndex]
		self.messages[self.selfMsgIndex] = self.messages[1]
	end
end

function SurvivalLeaveMsgView:refreshLeaveMsg(isAnim)
	if self.uiType == 1 then
		self.leaveMsgData = {}

		for i, v in ipairs(self.messages) do
			table.insert(self.leaveMsgData, {
				survivalMessage = v,
				unitId = self.unitId
			})
		end

		self.msgScroll:setRefreshAnimation(isAnim, 0)
		self.msgScroll:setData(self.leaveMsgData)

		self.textLeaveMsg.text = self.selfMessage and luaLang("SurvivalLeaveMsgView_3") or luaLang("SurvivalLeaveMsgView_2")

		gohelper.setActive(self.goEmpty, #self.leaveMsgData <= 0)
	end
end

function SurvivalLeaveMsgView:refreshWriteList()
	if self.uiType == 2 then
		local data = {}
		local num = self:getCanWriteNum()

		for i = 1, num do
			local leaveMsgType = self.leaveMsgTypeList[i]
			local selectWriteItem = self.selectWriteItemIndex == i

			table.insert(data, {
				leaveMsgType = leaveMsgType,
				selectId = self.selectIds[i],
				selectWriteItem = selectWriteItem,
				onClickSelectItem = self.onClickSelectItem,
				context = self,
				goDropListParent = self.WriteMsg
			})
		end

		self.writeList:setData(data)
	end
end

function SurvivalLeaveMsgView:onClickWriteItem(SurvivalLeaveWriteItem)
	self.selectWriteItemIndex = SurvivalLeaveWriteItem.itemIndex
end

function SurvivalLeaveMsgView:onClickSelectItem(SurvivalLeaveWriteItem, index)
	local ids = SurvivalConfig.instance:getLeaveMsgByType(SurvivalLeaveWriteItem.leaveMsgType)

	self.selectIds[self.selectWriteItemIndex] = index == 0 and -1 or ids[index].id

	self:refreshWriteList()
	self:refreshPreview()
end

function SurvivalLeaveMsgView:getCanWriteNum()
	if self.selectIds[1] == -1 or self.selectIds[2] == -1 then
		return 2
	else
		return 5
	end
end

function SurvivalLeaveMsgView:refreshPreview()
	if self.uiType == 2 then
		local final = self:getFinalSelectIds()

		self.textPreview.text = SurvivalConfig.instance:getMessageByIds(final)
	end
end

function SurvivalLeaveMsgView:getFinalSelectIds()
	local t = GameUtil.copyArray(self.selectIds)
	local num = self:getCanWriteNum()

	if num <= 2 then
		for i = 3, 5 do
			t[i] = -1
		end
	end

	return t
end

function SurvivalLeaveMsgView:GetSelectIds()
	local t = {}
	local final = self:getFinalSelectIds()

	for i, id in ipairs(final) do
		if id ~= -1 then
			table.insert(t, id)
		end
	end

	return t
end

return SurvivalLeaveMsgView
