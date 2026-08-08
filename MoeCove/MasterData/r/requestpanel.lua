---@class RequestPanel : RequestPanel_Generate
---##################### 【RequestPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RequestPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RequestPanel = require "RequestPanel_Generate"

local WorkOrderMgr = require "WorkOrderMgr"

local _userStateTextColor = {
    [GE.WorkOrderState.NotDealed] = Color.NewFromStr("D4D4D4"), -- 白
    [GE.WorkOrderState.NotSolved] = Color.NewFromStr("D4D4D4"), -- 白
    [GE.WorkOrderState.Dealing] = Color.NewFromStr("71B979"),   -- 绿
    [GE.WorkOrderState.WaitUser] = Color.NewFromStr("D62C4A"),  -- 红
    [GE.WorkOrderState.Finished] = Color.NewFromStr("878787"),  -- 灰
}

local _gmStateTextColor = {
    [GE.WorkOrderState.NotDealed] = Color.NewFromStr("D62C4A"), -- 红
    [GE.WorkOrderState.NotSolved] = Color.NewFromStr("D26427"), -- 橙
    [GE.WorkOrderState.Dealing] = Color.NewFromStr("71B979"),   -- 绿
    [GE.WorkOrderState.WaitUser] = Color.NewFromStr("D4D4D4"),  -- 白
    [GE.WorkOrderState.Finished] = Color.NewFromStr("878787"),  -- 灰
}

function RequestPanel:InitLogic(data)
    self.orderDetail:SetActive(false)
    self.messageInput:SetActive(false)

    self.msgEventHandler = {
        { GameMsgType.WorkOrderStateChange, self.OnWorkOrderStateChange},
        { GameMsgType.WorkOrderOperation, self.OnWorkOrderStateChange},
    }
    
    self.typeOption = nil
    self.typeOptions = {
        self.messageInput.option1, self.messageInput.option2, 
        self.messageInput.option3, self.messageInput.option4, 
    }
    
    self.detailWorkOrder = nil

    if not Me:isUser() then
        if not Me:canReplyWorkOrder() then
            self.orderDetail.replyBtn.button.interactable = false
            self.orderDetail.finishBtn.button.interactable = false
        end
    end
end

--function RequestPanel:StartCreating(time)
--
--end

--function RequestPanel:StartEnter(time)
--
--end

--function RequestPanel:StartRemoving(time)
--
--end

--function RequestPanel:StartExit(time)
--
--end

function RequestPanel:OnOpen(data, initiative)
    if not initiative then
        return
    end

    self.orderItemTemplate:SetActive(false)
    self.orderReceiveMoreBtn:SetActive(false)
    if Me:hasFetchWorkOrder() then
        self:Refresh()
    else
        Me:fetchWorkOrders()
    end
end

--function RequestPanel:OnClose(initiative)
--
--end

--function RequestPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

function RequestPanel:OnRefresh(data)
    self.orderReceiveMoreBtn:SetActive(Me:hasMoreWorkOrder())
    self.noContentText:SetActive(not Me:hasWorkOrder())
    self.addWorkOrderBtn.button.interactable = not Me:canReplyWorkOrder()

    local typeStrs = {LocalStrEnum.WorkOrderType1Str, LocalStrEnum.WorkOrderType2Str, LocalStrEnum.WorkOrderType3Str, LocalStrEnum.WorkOrderType4Str}
    local workOrders = shallowclone(Me:getWorkOrders())
    tablex.bbsort(workOrders, Me:isUser() and WorkOrderMgr.UserWorkOrderSort or WorkOrderMgr.GmWorkOrderSort)
    self:FillTemplateContent(self.orderItemTemplate, self.orderList, #workOrders, function (idx, go)
        local workOrder = workOrders[idx]
        if not Me:isUser() and workOrder.state == GE.WorkOrderState.WaitUser then
            go.state.text.text = LocalStrEnum.WaitForUserToReply
        else
            go.state.text.text = Config.GetWorkOrderStateStr(workOrder.state)
        end

        go.state.text.color = Me:isUser() and _userStateTextColor[workOrder.state] or _gmStateTextColor[workOrder.state]
        go.date.text.text = luautil.getCommonDatetime(workOrder.stamp, true)
        go.orderTitle.text.text = workOrder.title
        go.serial.text.text = string.format("#%d %s", workOrder.order_id, Config.GetWorkOrderTypeStr(workOrder.type))
        
        UICommonUtils.ResetButtonListener(self, go.button, function ()
            self:showWorkOrderDetail(workOrder)
        end)
    end)

    if self.detailWorkOrder then
        self:refreshOrderDetail(self.detailWorkOrder)
    end
end

--[[
/OrderDetail/GameObject/finishBtn onClick 
--]]
function RequestPanel:finishBtn_Button_onClick(finishBtn)
    local order = {order_id = self.detailWorkOrder.order_id, user_uid = self.detailWorkOrder.user_uid}
    if Me:canReplyWorkOrder() then
        local action
        if self.detailWorkOrder.state == GE.WorkOrderState.Dealing then
            action = GE.WorkOrderAction.CancelDeal
        else
            action = GE.WorkOrderAction.Deal
        end

        Me:dealOrder(order, action)
    elseif Me:isUser() then
        Me:finishOrder(order, function ()
            --self:refreshOrderDetail(self.detailWorkOrder)
            self:closeWorkOrderDetail()
        end)
    end
end

--[[
/OrderDetail/closeOrderDetailBtn onClick 
--]]
function RequestPanel:closeOrderDetailBtn_Button_onClick(closeOrderDetailBtn)

end

--[[
/MessageInput/toggleGroup/option1 onValueChanged 
--]]
function RequestPanel:option1_Toggle_onValueChanged(option1,isOn)
    if isOn then
        self.typeOption = 1
    end
end

--[[
/MessageInput/toggleGroup/option2 onValueChanged 
--]]
function RequestPanel:option2_Toggle_onValueChanged(option2,isOn)
    if isOn then
        self.typeOption = 2
    end
end

--[[
/MessageInput/toggleGroup/option3 onValueChanged 
--]]
function RequestPanel:option3_Toggle_onValueChanged(option3,isOn)
    if isOn then
        self.typeOption = 3
    end
end

--[[
/MessageInput/toggleGroup/option4 onValueChanged 
--]]
function RequestPanel:option4_Toggle_onValueChanged(option4,isOn)
    if isOn then
        self.typeOption = 4
    end
end

--[[
/MessageInput/confirmInputBtn onClick 
--]]
function RequestPanel:confirmInputBtn_Button_onClick(confirmInputBtn)
    local order = {
        content = self.messageInput.messageInputField.inputField.text,
    }

    if not Me:isUser() and self.detailWorkOrder then
        order.user_uid = self.detailWorkOrder.user_uid
    end
    
    if UICommonUtils.ToastLogicError(Me:isWorkOrderContentValid(order.content)) then
        return
    end
    
    if #order.content < 6 then
        UICommonUtils.PopToast(LocalStrEnum.WorkOrderContentTooShort)
        return
    end
    
    if self.detailWorkOrder then
        order.order_id = self.detailWorkOrder.order_id
        Me:replyMessage(order, function ()
            UICommonUtils.PopToast(LocalStrEnum.SubmitSuccess)
            self:closeMessageInput()
        end)
    else
        if not self.typeOption then
            UICommonUtils.PopToast(LocalStrEnum.WorkOrderShouldChooseType)
            return 
        end
        
        order.title = self.messageInput.titleInputField.inputField.text
        order.type = self.typeOption

        if UICommonUtils.ToastLogicError(Me:isWorkOrderTitleValid(order.title)) then
            return
        end
        
        Me:commitNewWorkOrder(order, function ()
            self:closeMessageInput()
        end)
    end
end

--[[
/MessageInput/closeInputBtn onClick 
--]]
function RequestPanel:closeInputBtn_Button_onClick(closeInputBtn)
    self:closeMessageInput()
end

--[[
/OrderDetail/GameObject/replyBtn onClick 
--]]
function RequestPanel:replyBtn_Button_onClick(replyBtn)
    self:showMessageInput(self.detailWorkOrder)
end

--[[
/addWorkOrderBtn onClick 
--]]
function RequestPanel:addWorkOrderBtn_Button_onClick(addWorkOrderBtn)
    self:showMessageInput()
end

local _charNameColor = Color.NewFromStr("FFC469")
local _systemNameColor = Color.NewFromStr("DB7A00")
local _serveNameColor = Color.NewFromStr("00A9DB")

function RequestPanel:refreshOrderDetail(order)
    self.detailWorkOrder = order
    self.orderDetail:SetActive(true)
    self.messageReceiveMoreBtn:SetActive(Me:workOrderHasMoreMessage(order))

    if Me:canReplyWorkOrder() then
        self.orderDetail.replyBtn.button.interactable = order.state ~= GE.WorkOrderState.Finished

        if order.state == GE.WorkOrderState.NotDealed or order.state == GE.WorkOrderState.NotSolved
                or order.state == GE.WorkOrderState.WaitUser or order.state == GE.WorkOrderState.Dealing then
            self.orderDetail.finishBtn.button.interactable = true
            if order.state == GE.WorkOrderState.Dealing then
                self.orderDetail.finishText.text.text = LocalStrEnum.WorkOrderDetailCancelDeal
            else
                self.orderDetail.finishText.text.text = LocalStrEnum.WorkOrderDetailStartDeal
            end
        else
            self.orderDetail.finishBtn.button.interactable = false
            if order.state == GE.WorkOrderState.Finished then
                self.orderDetail.finishText.text.text = LocalStrEnum.WorkOrderIsClosed
            end
        end
    else
        self.orderDetail.finishBtn.button.interactable = order.state ~= GE.WorkOrderState.Finished
    end

    local hasAllMsg = not Me:workOrderHasMoreMessage(order)
    local msgCnt = #order.messages
    if hasAllMsg then
        msgCnt = msgCnt + 1
    end
    
    self:FillTemplateContent(self.orderDetail.replyItem, self.orderDetail.replyList, msgCnt, function (idx, go)
        local message
        if hasAllMsg and idx == msgCnt then
            message = order
        else
            message = order.messages[idx]
        end

        if not message.action then
            go.charname.text.color = _charNameColor
            local firstMsg = string.format("%s(%s)", order.title, Config.GetWorkOrderTypeStr(order.type))
            if not Me:isUser() then
                firstMsg = firstMsg .. string.format("(%s-%s)", order.userName or "", tostring(order.user_uid))
            end
            go.charname.text.text = firstMsg
        elseif message.action == GE.WorkOrderMessageAction.UserReply or message.action == GE.WorkOrderMessageAction.UserFinish then
            go.charname.text.color = _charNameColor
            if Me:isUser() then
                go.charname.text.text = Me.name
            else
                go.charname.text.text = string.format("%s-%s", order.userName or "", tostring(message.user_uid))
            end
        elseif message.action == GE.WorkOrderMessageAction.SystemFinish then
            go.charname.text.color = _systemNameColor
            go.charname.text.text = LocalStrEnum.WorkOrderSystemAuto
        else
            go.charname.text.color = _serveNameColor
            if Me:isUser() then
                go.charname.text.text = LocalStrEnum.BaiXiaoSheng
            else
                go.charname.text.text = string.format("%s(%s)", LocalStrEnum.BaiXiaoSheng, tostring(message.with_uid))
            end
        end

        go.date.text.text = luautil.getCommonDatetime(message.stamp, true)
        if message.action == GE.WorkOrderMessageAction.UserFinish or message.action == GE.WorkOrderMessageAction.SystemFinish then
            go.message.text.text = "结束会话"
        else
            go.message.text.text = message.content
        end
    end)
end

function RequestPanel:showWorkOrderDetail(order)
    self.detailWorkOrder = order
    if Me:hasFetchWorkOrderMessage(order) then
        self:refreshOrderDetail(order)
    else
        Me:fetchWorkOrderDetail(order)
    end
end

function RequestPanel:closeWorkOrderDetail()
    self.detailWorkOrder = nil
    self.orderDetail:SetActive(false)
    self:Refresh()
end

function RequestPanel:closeMessageInput()
    self.messageInput:SetActive(false)
    self.messageInput.titleInputField.inputField.text = ""
    self.messageInput.messageInputField.inputField.text = ""
    self.messageInput.orderTypeEmptyOption.toggle.isOn = true
    self.typeOption = nil
end

function RequestPanel:showMessageInput(order)
    self.messageInput:SetActive(true)
    
    local canChangeTitle = order == nil
    
    self.messageInput.titleInputField.inputField.interactable = canChangeTitle
    if not Me:isUser() then
        self.messageInput.messageInputField.inputField.characterLimit = 1000
    end
    
    for i, v in ipairs(self.typeOptions) do
        v.toggle.interactable = canChangeTitle
    end
    
    if order then
        self.messageInput.titleInputField.inputField.text = order.title
        self.typeOptions[order.type].toggle.isOn = true
    else
    end
end

--[[
/CommonHeadTitle/backBtn onClick 
--]]
function RequestPanel:backBtn_Button_onClick(backBtn)
    if self.detailWorkOrder then
        self:closeWorkOrderDetail()
    else
        self:Close(true)
    end
end

--[[
/OrderPart/orderReceiveMoreBtn onClick 
--]]
function RequestPanel:orderReceiveMoreBtn_Button_onClick(orderReceiveMoreBtn)
    Me:fetchWorkOrders()
end

--[[
/OrderDetail/messageReceiveMoreBtn onClick 
--]]
function RequestPanel:messageReceiveMoreBtn_Button_onClick(messageReceiveMoreBtn)
    Me:fetchWorkOrderDetail(self.detailWorkOrder)
end

function RequestPanel:OnWorkOrderStateChange(data)
    self:Refresh()
end

return RequestPanel
