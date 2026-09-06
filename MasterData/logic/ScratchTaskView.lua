-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchTaskView.lua

module("logic.extensions.scratch.view.ScratchTaskView", package.seeall)

local ScratchTaskView = class("ScratchTaskView", ViewComponent)

function ScratchTaskView:ctor()
	return
end

function ScratchTaskView:buildUI()
	ScratchTaskView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtCount = self:getTxt("main/txtCount")
	self._txtDesc = self:getTxt("main/txtDesc")
	self._btnExchange = self:getBtn("main/btnExchange")
	self._redPoint = self:getGo("main/btnExchange/redPoint")
	self._tableview = self:getGo("main/taskList"):GetComponent("UITableview")
	self._tableCell = self:getGo("main/taskList/item")

	self._tableCell:SetActive(false)
end

function ScratchTaskView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnExchange:AddClickListener(self._onBtnExchangeClick, self)
end

function ScratchTaskView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
end

function ScratchTaskView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.ScratchExchange, self._onScratchExchange, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self:_onScratchExchange()

	local cfg1 = ScratchConfig.instance:getScratchParamsCfg("SCORE_EXCHANGE_ITEM")
	local cfg2 = ScratchConfig.instance:getScratchParamsCfg("PAY_PRIZE_SCORE")
	local strNum1 = 0

	if cfg1 then
		strNum1 = cfg1.value
	end

	self._txtDesc.text = string.format("每%s点积分可兑换成一个十字镐\n每充值%s元可获得1积分", strNum1, (cfg2 or nil) and cfg2.value)
	self._curViewDatas = ScratchModel.instance:getTaskList()

	self._tableview:ReloadData()
end

function ScratchTaskView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.ScratchExchange, self._onScratchExchange, self)
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()
end

function ScratchTaskView:_onClickClose()
	self:close()
end

function ScratchTaskView:_onBtnExchangeClick()
	UIStateManager.instance:open(ViewName.ScratchExchangeView)
end

function ScratchTaskView:_numInView()
	return #self._curViewDatas
end

function ScratchTaskView:_cellSize()
	return 476, 130
end

function ScratchTaskView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	cell.index = index

	self:_updateCell(view, cell, data)

	return cell
end

function ScratchTaskView:_updateCell(view, cell, data)
	local idx = cell.index + 1
	local component = GameUtil.AddLuaOnce(cell.gameObject, ScratchTaskItem)

	component:init(idx, data, self)
end

function ScratchTaskView:_clearTableview(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, ScratchTaskItem)

	component:reset()
end

function ScratchTaskView:_onScratchExchange()
	self._txtCount.text = "当前积分：" .. ScratchModel.instance:getScore()

	self:_setRedPoint()
end

function ScratchTaskView:_setRedPoint()
	goutil.setActive(self._redPoint, ScratchModel.instance:isCanExchange())
end

return ScratchTaskView
