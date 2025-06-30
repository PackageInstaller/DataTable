-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyMessage\\MessageView.lua

local m = {
	showMessageCD = 2,
	nowTime = 0,
	isStartCheckSend = false,
	isShowOption = false,
	lastShowMessageTime = 0,
	messagePlayerCells = {},
	messageGirlCells = {},
	messageTimeCellPool = {},
	messageTabCells = {},
	playerMessageTypeCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MessageCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyMessage.MessageCell")
local MessageTimeCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyMessage.MessageTimeCell")
local MessageTabCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyMessage.MessageTabCell")
local PlayerMessageTypeCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyMessage.PlayerMessageTypeCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextPlayerSendMsg, MonsterAcademyMessageUIApi:GetString("TextPlayerSendMsg"))
	self.MessageGirlMould:SetActive(false)
	self.MessagePlayerMould:SetActive(false)
	self.MessageTimeMould:SetActive(false)
	self.MessageTabMould:SetActive(false)
	self.MessagePlayerMould:SetActive(false)
	self.MessageGirlMould:SetActive(false)

	self.messageCellPlayerPool = UIObjectPool.New(15, function()
		return MessageCell.New(UnityEngine.Object.Instantiate(self.MessagePlayerMould))
	end, function(cell)
		cell:Dispose()
	end)
	self.messageCellGirlPool = UIObjectPool.New(15, function()
		return MessageCell.New(UnityEngine.Object.Instantiate(self.MessageGirlMould))
	end, function(cell)
		cell:Dispose()
	end)
	self.messageTabCellPool = UIObjectPool.New(4, function()
		return MessageTabCell.New(UnityEngine.Object.Instantiate(self.MessageTabMould))
	end, function(cell)
		cell:Dispose()
	end)

	self.PlayerMessageMould:SetActive(false)

	self.playerMessageTypeCellPool = UIObjectPool.New(6, function()
		return PlayerMessageTypeCell.New(UnityEngine.Object.Instantiate(self.PlayerMessageMould))
	end, function(cell)
		cell:Dispose()
	end)

	function self.DelegateSendMessageResult(messageID, girlID)
		self:SendMessageResult(messageID, girlID)
	end
end

function m:AddListener()
	EventDispatcher.AddEventListener(EventID.MonsterAcademySendMessageResultEvent, self.DelegateSendMessageResult)
end

function m:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademySendMessageResultEvent, self.DelegateSendMessageResult)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if MonsterAcademyModule.isSendingMessage then
		return
	end

	if not self.isStartCheckSend then
		return
	end

	self.nowTime = PlayerModule.GetServerTime()

	if self.nowTime - self.lastShowMessageTime < self.showMessageCD or self.isShowOption then
		return
	end

	self:CheckNextMessage()

	self.lastShowMessageTime = self.nowTime
end

function m:CheckNextMessage()
	if self.messageData == nil then
		return
	end

	if self.messageData.girlID == self.girlData.cfgID then
		self.messageData = self.girlData.girlMessagesRecord[#self.girlData.girlMessagesRecord]

		if self.messageData and not self.messageData:IsComplete() then
			local tab = self.messageData:GetNextMessageCid()
			local nextID = tab[1]

			if nextID > 0 then
				MonsterAcademyModule.SendMessage(nextID, self.girlData.cfgID)
			end
		else
			self:RefreshButtonState()
		end
	end
end

function m:SetDefault()
	self:ClearCells()
	self:ClearOption()
	self:RefreshButtonState()
end

function m:SendMessageResult(messageID, girlID)
	if self.girlData == nil then
		return
	end

	if self.girlData.cfgID ~= girlID then
		return
	end

	self.girlData = MonsterAcademyModule.girlDic[girlID]

	if self.haveOptionTempCid ~= nil then
		self:AddMessageRender(self.haveOptionTempCid)

		self.lastShowMessageTime = PlayerModule.GetServerTime()

		local timer = Timer.New(function()
			self:AddMessageRender(messageID)

			self.lastShowMessageTime = PlayerModule.GetServerTime()
		end, self.showMessageCD)

		timer:Start()
	else
		self:AddMessageRender(messageID)
	end
end

function m:UpdateView(girlData)
	self.isStartCheckSend = false
	self.girlData = girlData

	self:SetDefault()

	for i = 1, #self.girlData.girlMessagesRecord do
		local messageData = self.girlData.girlMessagesRecord[i]

		self:RefreshMessage(messageData)
	end

	self.isStartCheckSend = true
end

function m:RefreshMessage(messageData)
	self.messageData = messageData

	self:AddMessageTimeRender()

	for i = 1, #messageData.messageGroupPOD.messageIds do
		local messageID = messageData.messageGroupPOD.messageIds[i]

		self:AddMessageRender(messageID)
	end
end

function m:AddMessageTimeRender()
	local messageTimeCell = MessageTimeCell.New(UnityEngine.Object.Instantiate(self.MessageTimeMould))

	messageTimeCell.View:SetActive(true)
	messageTimeCell.View.transform:SetParent(self.MessageContent.transform, false)
	messageTimeCell:SetData(self.messageData.day, self.messageData.dayOfPhase)
	table.insert(self.messageTimeCellPool, messageTimeCell)
end

function m:AddMessageRender(messageID)
	self:ClearOption()

	local cfgMessageData = CfgGalgameMonsterMessageTable[messageID]
	local isCreateCell = true
	local selectOption

	if #cfgMessageData.NextID > 1 then
		selectOption = self.messageData:GetSelectOption(messageID)

		if selectOption == nil then
			isCreateCell = false

			self:ShowOption(cfgMessageData)
		end
	end

	if isCreateCell then
		local messageCell

		if cfgMessageData.Speaker == 0 then
			messageCell = self.messageCellPlayerPool:Obtain()

			table.insert(self.messagePlayerCells, messageCell)
		else
			messageCell = self.messageCellGirlPool:Obtain()

			table.insert(self.messageGirlCells, messageCell)
		end

		messageCell.View:SetActive(true)
		messageCell.View.transform:SetParent(self.MessageContent.transform, false)
		messageCell:SetData(cfgMessageData, selectOption)
	end

	if self.haveOptionTempCid ~= nil and self.haveOptionTempCid == messageID then
		self.haveOptionTempCid = nil
	end
end

function m:ClearOption()
	for i, v in pairs(self.messageTabCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.messageTabCellPool:Release(v)
	end

	self.messageTabCells = {}
	self.isShowOption = false
end

function m:ShowOption(cfgMessageData)
	self.isShowOption = true

	for i = 1, #cfgMessageData.NextID do
		local nextMessageID = cfgMessageData.NextID[i]

		if nextMessageID > 0 then
			local optionStr = cfgMessageData.OptionText[i]
			local cell = self.messageTabCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.MessageTabNode.transform, false)
			cell:SetData(cfgMessageData.Id, nextMessageID, optionStr)

			function cell.SelectCallBack(currentCid, nextCid)
				self:SelectOption(currentCid, nextCid)
			end

			table.insert(self.messageTabCells, cell)
		end
	end
end

function m:SelectOption(currentCid, nextCid)
	if GameEntry.Base.DevMode then
		log("当前短信息 " .. currentCid .. " 选项选择 = " .. nextCid)
	end

	self.lastShowMessageTime = PlayerModule.GetServerTime()
	self.haveOptionTempCid = currentCid

	MonsterAcademyModule.SendMessage(nextCid, self.girlData.cfgID)
end

function m:RefreshButtonState()
	local top = self.girlData:IsNextMessage()

	self.PlayerOperationNode:SetActive(not top)

	local isShowNum = false
	local messageFunctionTab = self.girlData:GetGirlFunctionBySubType({
		MonsterAcademyConstant.FunctionSubType.FunctionSubType_Player_SendMessage
	})

	for i, v in pairs(self.playerMessageTypeCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.playerMessageTypeCellPool:Release(v)
	end

	self.playerMessageTypeCells = {}

	for i, v in pairs(messageFunctionTab) do
		local cell = self.playerMessageTypeCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.PlayerOperationNode.transform, false)
		cell:SetData(v)

		function cell.SelectCallBack(functionData)
			self:OnSelectPlayerSendMessage(functionData)
		end

		table.insert(self.playerMessageTypeCells, cell)

		isShowNum = true
	end

	if self.ChangeState then
		self.ChangeState(not top and isShowNum)
	end
end

function m:OnSelectPlayerSendMessage(data)
	if GameEntry.Base.DevMode then
		log("开启新短信functionID = " .. data.functionID .. " 短信ID = " .. data.cfgFunction.Parameter[1])
	end

	local sendCount = MonsterAcademyModule.GetMessageCount(0, Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_WEEK)
	local maxCount = CfgDiscreteDataTable[6520093].Data[1]
	local count = maxCount - sendCount

	if count <= 0 then
		NoticeModule.ShowNotice(21045068)

		return
	end

	self.PlayerOperationNode:SetActive(false)
	MonsterAcademyModule.ExecutionAreaFunctionOption(data.cfgID, nil, self.girlData.cfgID)
end

function m:ClearCells()
	for i, v in pairs(self.messagePlayerCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.messageCellPlayerPool:Release(v)
	end

	self.messagePlayerCells = {}

	for i, v in pairs(self.messageGirlCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.messageCellGirlPool:Release(v)
	end

	self.messageGirlCells = {}

	for i, v in pairs(self.messageTimeCellPool) do
		v:Dispose()
	end

	self.messageTimeCellPool = {}
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()

	self.isStartCheckSend = false
end

function m:Dispose()
	self:Close()
	AssetUtil.UnloadAsset(self)

	self.ChangeState = nil

	for i, v in pairs(self.messageTimeCellPool) do
		v:Dispose()
	end

	self.messageTimeCellPool = {}

	for i, v in pairs(self.messagePlayerCells) do
		self.messageCellPlayerPool:Release(v)
	end

	self.messagePlayerCells = {}

	self.messageCellPlayerPool:Dispose()

	for i, v in pairs(self.messageGirlCells) do
		self.messageCellGirlPool:Release(v)
	end

	self.messageGirlCells = {}

	self.messageCellGirlPool:Dispose()

	for i, v in pairs(self.messageTabCells) do
		self.messageTabCellPool:Release(v)
	end

	self.messageTabCells = {}

	self.messageTabCellPool:Dispose()

	for i, v in pairs(self.playerMessageTypeCells) do
		self.playerMessageTypeCellPool:Release(v)
	end

	self.playerMessageTypeCells = {}

	self.playerMessageTypeCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
