-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleStratageDlg.lua

local BtnCircleBattleOrder = require("UI/Circle/BtnCircleBattleOrder")
local BtnCircleBattleGoal = require("UI/Circle/BtnCircleBattleGoal")
local ResClanBattleOrder = require("ClientData/ResClanBattleOrder")
local strClassName = "CircleBattleStratageDlg"
local CircleBattleStratageDlg = Class(strClassName, UIControls.Window)

function CircleBattleStratageDlg:ctor()
	self:initUI()
end

function CircleBattleStratageDlg:initUI()
	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.targetAchieveCells = {}
	self.orderCells = {}
	self.scrollGoal = UIControls.ScrollViewLoopV(self, "Bg/GoalPanel/GoalList")

	self.scrollGoal:addEventCellChanged(self.onGoalChanged)
	self:initStratageData()
end

function CircleBattleStratageDlg:initStratageData()
	if CurAvatar.myCircle then
		local battleData = CurAvatar.myCircle:getBattleData()

		if battleData then
			self.selectedOrder = battleData.order

			for idx, orderResData in ipairs(ResClanBattleOrder) do
				if not self.orderCells[idx] then
					self.orderCells[idx] = BtnCircleBattleOrder(self, "Bg/OrderPanel", "System/CircleBattle/BtnCircleBattleOrder", 0, 0, true)
				end

				self.orderCells[idx]:setOrderData(orderResData)
				self.orderCells[idx]:setSelectCallback(Slot(self.selectOrder, self))
			end

			if self.orderCells[self.selectedOrder] then
				self.orderCells[self.selectedOrder]:onBtnSelfClick()
			elseif #self.orderCells > 0 then
				self.orderCells[1]:onBtnSelfClick()
			end

			self.selectedAchieve = battleData.target
			self.targetAchieveList = CurAvatar.myCircle:getTargetAchieveDataList()

			if self.targetAchieveList and #self.targetAchieveList > 0 then
				self.scrollGoal:setTotalCount(#self.targetAchieveList)
			end
		end
	end
end

function CircleBattleStratageDlg:selectOrder(btnOrder)
	for _, orderCell in ipairs(self.orderCells) do
		if orderCell.orderData.id == btnOrder.orderData.id then
			orderCell:setSelected(true)

			self.selectedOrder = orderCell.orderData.id
		else
			orderCell:setSelected(false)
		end
	end
end

function CircleBattleStratageDlg:onGoalChanged(sender, targetCell, newIdx)
	targetCell = targetCell or BtnCircleBattleGoal(sender, "System/CircleBattle/BtnCircleBattleGoal", newIdx)

	if not self.targetAchieveList or #self.targetAchieveList == 0 then
		return
	end

	if self.targetAchieveList[newIdx] ~= nil then
		targetCell:setGoalData(self.targetAchieveList[newIdx], newIdx)
		targetCell:setSelectCallback(Slot(self.selectAchieve, self))
	end

	self.targetAchieveCells[newIdx] = targetCell
end

function CircleBattleStratageDlg:selectAchieve(btnAchieve)
	self.selectedAchieve = btnAchieve.goalData.resData.action_type

	self.scrollGoal:setTotalCount(#self.targetAchieveList)
end

function CircleBattleStratageDlg:onBtnCloseClick()
	self:setVisible(false)
end

function CircleBattleStratageDlg:onBtnConfirmClick()
	if CurAvatar.myCircle then
		local battleData = CurAvatar.myCircle:getBattleData()

		if battleData and (self.selectedOrder ~= battleData.order or self.selectedAchieve ~= battleData.target) then
			CurAvatar:tryCallCircleBattleRpc("clanBattleGiveOrder", CurAvatar.myCircle:getCurBattleLayer(), self.selectedOrder, self.selectedAchieve)
		end
	end

	self:setVisible(false)
end

return CircleBattleStratageDlg
