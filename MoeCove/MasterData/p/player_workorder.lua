-- Desc: 玩家工单相关
---@class Player
local Player = require "Player"

------------------WorkOrder------------------
---@class WordOrderStruct
---@field orders WorkOrderItem[]
---@field orderMap table<integer, WorkOrderItem>
---@field left integer
---@field stamp integer

local WordOrderTitleMinBytes = Config.WorkOrderTitleMinBytes
local WorkOrderTitleMaxBytes = Config.WorkOrderTitleMaxBytes
local WorkOrderContentMinBytes = Config.WorkOrderContentMinBytes
local WorkOrderContentMaxBytes = Config.WorkOrderContentMaxBytes

local _maxUserDealingOrder = 5

--判断当前登录用户是否可以回复工单
---@return boolean
function Player:canReplyWorkOrder()
	return self.gmLevel > 5
end

--判断是否是普通用户
---@return boolean
function Player:isUser()
	return self.gmLevel == 0
end

--可否进入GM命令模式
---@return boolean
function Player:canEnterGmCmd()
	return self.gmLevel >= 10
end

--获取工单数据
function Player:getWorkOrderData()
	if not self.workOrder then
		self.workOrder = {
			orders = {},
			orderMap = {},
			left = nil,  --剩余工单数
			stamp = 0,   --用户工单的索引位置
		}
	end
	return self.workOrder
end

--获取所有的工单
---@return WorkOrderItem[]
function Player:getWorkOrders()
	local workOrder = self:getWorkOrderData()
	if not workOrder.orders then
		workOrder.orders = {}
	end
	return workOrder.orders
end

-- 获取工单的Map
function Player:getWorkOrderMap()
	local workOrder = self:getWorkOrderData()
	if not workOrder.orderMap then
		workOrder.orderMap = {}
	end
	return workOrder.orderMap
end

--判断是否存在客服工单
---@return boolean
function Player:hasWorkOrder()
	local orders = self:getWorkOrders()
	return not tablex.empty(orders)
end

--判断是否还有更多的工单
---@return boolean
function Player:hasMoreWorkOrder()
	local workOrder = self:getWorkOrderData()
	return workOrder.left ~= 0 -- nil or >0
end

--判断是否已经获取了工单
---@return boolean
function Player:hasFetchWorkOrder()
	local workOrder = self:getWorkOrderData()
	return workOrder.left ~= nil
end

--判断是否获取了工单的回复消息
---@param order WorkOrderItem
---@return boolean
function Player:hasFetchWorkOrderMessage(order)
	return order.left ~= nil
end

--判断工单的Title是否合法
---@param title string
---@return boolean|string  如果是布尔返回类型，则第二个返回值会被激活，如果返回string，第二个返回值失效
---@return ActionFailReason? 失败的原因
function Player:isWorkOrderTitleValid(title)
	if stringx.isNilOrEmpty(title) then
		return false, ActionFailReason.WorkOrderNoTitle
	end

	title = title:trim()
	
	if #title < WordOrderTitleMinBytes then
		return false, ActionFailReason.WorkOrderTitleTooShort
	end

	if #title > WorkOrderTitleMaxBytes then
		return false, ActionFailReason.WorkOrderTitleTooLong
	end

	return title
end

--判断工单的内容是否有效
---@param content string
---@return boolean|string 如果是布尔返回类型，则第二个返回值会被激活，如果返回string，第二个返回值失效
---@return ActionFailReason? 失败的原因
function Player:isWorkOrderContentValid(content)
	if stringx.isNilOrEmpty(content) then
		return false, ActionFailReason.WorkOrderNoContent
	end

	content = content:trim()

	if not content or #content < WorkOrderContentMinBytes then
		return false, ActionFailReason.WorkOrderContentTooShort
	end

	if #content > WorkOrderContentMaxBytes then
		if self:isUser() then
			return false, ActionFailReason.WorkOrderContentTooLong
		end
	end

	return content
end

--针对某个工单，是否有回复的消息
---@param order WorkOrderItem
---@return boolean
function Player:workOrderHasMoreMessage(order)
	return order.left ~= 0 -- nil or >0
end

--添加一个工单
---@param order WorkOrderItem
---@param first boolean
function Player:addNewWorkOrder(order, first)
	local workOrder = self:getWorkOrderData()

	local exist = workOrder.orderMap[order.order_id]
	if exist then
		tablex.clear(exist)
		tablex.copyTo(order, exist)
	end

	--如果是普通用户的情况下，则考虑是插到前面还是后面
	if self:isUser() then
		if first then
			table.insert(workOrder.orders, 1, order)
			workOrder.stamp = workOrder.stamp + 1 -- user中的stamp是索引位置
		else
			table.insert(workOrder.orders, order)
		end
	else
		--GM角色，直接插入即可
		table.insert(workOrder.orders, order)
	end

	--在map中也进行添加
	workOrder.orderMap[order.order_id] = order
end

--根据orderId来获取一个工单
---@param orderId integer
---@return WorkOrderItem
function Player:getWorkOrder(orderId)
	local orderMap = self:getWorkOrderMap()
	LuaLogger.ds("orderMap", tablex.dump(orderMap))
	return orderMap and orderMap[orderId]
end

-- messages从最新到旧(1~n)
-- todo:从下面的内容看，上面的定义还是不完全的
---@param data WorkOrderItem
---@return boolean
function Player:addWorkOrderMessages(data)
	local workOrder = self:updateWorkOrder(data)

	if not workOrder then
		return false
	end

	if not workOrder.messages then
		workOrder.messages = {}
	end

	local newMessages = data.messages
	if not tablex.empty(newMessages) then
		if data.isNew then
			tablex.insertrange(workOrder.messages, 1, newMessages)
		else
			tablex.insertrange(workOrder.messages, newMessages)
		end
	end

	return true
end

-- 更新工单信息
-- todo:从下面的内容看，上面的定义还是不完全的
---@param order WorkOrderItem
---@return boolean|WorkOrderItem
function Player:updateWorkOrder(order)
	local workOrder = self:getWorkOrder(order.order_id)
	if not workOrder then
		LuaLogger.ws("no workOrder", tablex.dump(order))
		return false
	end

	if order.content then
		workOrder.content = order.content
	end

	if order.state then
		workOrder.state = order.state
	end

	if order.stamp then
		workOrder.msgStamp = order.stamp
	end

	if order.left then
		workOrder.left = order.left
	end

	return workOrder
end

-- WorkOrderOperationNtf
--工单处理
---@param data table
---@return boolean
function Player:workOrderOperation(data)
	if not self:hasFetchWorkOrder() then
		return true
	end

	data = clone(data)
	if data.operation == GE.WorkOrderAction.Deal or data.operation == GE.WorkOrderAction.CancelDeal then
		self:updateWorkOrder(data.orderOrMessage)
	elseif data.operation == GE.WorkOrderAction.Reply or data.operation == GE.WorkOrderAction.CloseOrder then
		local order = data.orderOrMessage
		local workOrder = self:getWorkOrder(order.order_id)
		if not workOrder then
			LuaLogger.ws("no workOrder", tablex.dump(data))
			return false
		end

		workOrder.state = order.state
		order.state = nil
		data.order_id = order.order_id

		local newMessage = data.orderOrMessage
		if newMessage then
			data.messages = {newMessage}
			data.orderOrMessage = nil
			data.isNew = true
		end

		self:addWorkOrderMessages(data)
	elseif data.operation == GE.WorkOrderAction.AddOrder then
		self:addNewWorkOrder(data.orderOrMessage, true)
	end

	return true
end

--todo:本地可能没获取全，只算了一部分
--是否可以发起工单
---@return boolean
function Player:canAddMoreWorkOrder()
	local orders = self:getWorkOrders()
	if tablex.empty(orders) then
		return true
	end

	local cnt = 0
	for i, v in ipairs(orders) do
		if v.state ~= GE.WorkOrderState.Finished then
			cnt = cnt + 1
		end
	end

	return cnt < _maxUserDealingOrder
end


------------------WorkOrder有一部分在客户端的函数使用，但是，在服务器未实现，先定义出来，然后，再进行实现------------------
function Player:fetchWorkOrders()
end

function Player:fetchWorkOrderDetail(order)
end

function Player:dealOrder( order, action)
	
end

function Player:finishOrder(order, callback)
end

function Player:replyMessage(order, callback)
end

function Player:commitNewWorkOrder(order, callback)
end

return Player