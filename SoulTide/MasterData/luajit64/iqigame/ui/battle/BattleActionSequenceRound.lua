-- chunkname: @IQIGame\\UI\\Battle\\BattleActionSequenceRound.lua

local m = {
	MoveElapsedTime = 0,
	MOVE_DURATION = 0.4,
	StepReorderCellFrame = 0,
	Cells = {}
}

function m.New(view, cellPool)
	local obj = Clone(m)

	obj:Init(view, cellPool)

	return obj
end

function m:Init(view, cellPool)
	self.View = view
	self.CellPool = cellPool

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnMoveOut(unitId, finalIndex)
		self:OnMoveOut(unitId, finalIndex)
	end

	function self.DelegateOnMoveStepComplete(moveDelta)
		self:OnMoveStepComplete(moveDelta)
	end

	self.Points = {}

	for i = 1, 10 do
		self.Points[i] = self.PointContainer.transform:Find("Point_" .. i).gameObject
	end
end

function m:Reset()
	self.TitleView:SetActive(true)
	self.View:SetActive(true)
	self:RefreshArrows()
end

function m:HideTitle()
	self.TitleView:SetActive(false)
end

function m:SetPosY(y)
	local position = self.View.transform.anchoredPosition

	position.y = y
	self.View.transform.anchoredPosition = position
	self.OriginalPosition = position
end

function m:Update(elapseSeconds, realElapseSeconds)
	if self.DesPosition ~= nil and UnityEngine.Time.realtimeSinceStartup > self.StartTime then
		self.MoveElapsedTime = self.MoveElapsedTime + elapseSeconds

		local lerpValue = self.MoveElapsedTime / m.MOVE_DURATION

		if lerpValue > 1 then
			lerpValue = 1
		end

		local deltaY = self.View.transform.anchoredPosition.y - self.OriginalPosition.y

		self.View.transform.anchoredPosition = Vector2.Lerp(self.OriginalPosition, self.DesPosition, lerpValue)

		for i = 1, #self.Cells do
			local cell = self.Cells[i]

			cell:ResistParentMove(i, #self.Cells, self.MoveElapsedTime, deltaY, elapseSeconds)
		end

		if lerpValue == 1 then
			self.OriginalPosition = self.DesPosition
			self.DesPosition = nil
			self.StartTime = nil
			self.MoveElapsedTime = 0

			if self.OnMoveCompleteCallback ~= nil then
				self.OnMoveCompleteCallback()

				self.OnMoveCompleteCallback = nil
			end
		end
	end

	for i = #self.Cells, 1, -1 do
		local cell = self.Cells[i]

		cell:Update(elapseSeconds, realElapseSeconds, self.DesPosition ~= nil)
	end
end

function m:StartMoveToY(desY, delay, onComplete)
	self.DesPosition = Vector2(0, desY)
	self.StartTime = UnityEngine.Time.realtimeSinceStartup + delay
	self.OnMoveCompleteCallback = onComplete
end

function m:Refresh(roundDelta)
	local unitTurnList = {}

	for i = 1, #BattleModule.TurnOrders do
		table.insert(unitTurnList, BattleModule.TurnOrders[i])
	end

	if roundDelta == 1 then
		unitTurnList = self:SortBySpeed(unitTurnList)
	end

	if #self.Cells ~= #unitTurnList then
		self:ClearCells()

		for i = 1, #unitTurnList do
			local cell = self:ObtainCell()

			cell.View.transform:SetParent(self.HeadNode.transform, false)
			cell:OnObtainFromPool(roundDelta, i, self.Points, self.DelegateOnMoveStepComplete)
			table.insert(self.Cells, cell)
		end
	end

	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		cell:Refresh(unitTurnList[i], roundDelta)
		cell:RefreshPosition(i)
	end

	self:RefreshArrows()
end

function m:ObtainCell()
	local cell = self.CellPool:Obtain()

	return cell
end

function m:ReorderCellLayers(moveDelta)
	for i = moveDelta == 1 and 1 or 2, #self.Cells, 2 do
		local cell = self.Cells[i]

		cell.View.transform:SetAsLastSibling()
	end
end

function m:SortBySpeed(t)
	table.sort(t, function(unitId1, unitId2)
		local weight1 = self:GetSortWeight(unitId1)
		local weight2 = self:GetSortWeight(unitId2)

		return weight2 < weight1
	end)

	return t
end

function m:GetSortWeight(unitId)
	local speed = BattleModule.UnitSpeeds[unitId]
	local standbyIndex = BattleModule.UnitStandbyIndexes[unitId]

	if standbyIndex ~= nil then
		speed = speed + standbyIndex * 10000
	end

	local battleUnitPOD = BattleModule.GetBattleUnitPOD(unitId)

	return speed * 1000 + battleUnitPOD.TroopType * 100 + battleUnitPOD.BattlePos
end

function m:RefreshArrows()
	for i = 1, #self.Points do
		self.Points[i]:SetActive(i <= #self.Cells)
	end
end

function m:NextTurn()
	self:ReorderCellLayers(-1)

	for i = #self.Cells, 1, -1 do
		local cell = self.Cells[i]
		local fromIndex = i

		if cell:IsMoving() then
			fromIndex = cell:GetFinalDesIndex()
		end

		cell:MoveTo(fromIndex, fromIndex - 1, self.DelegateOnMoveOut)
	end
end

function m:OnMoveOut(unitId, finalIndex)
	if finalIndex >= 1 then
		return
	end

	local index = -1

	for i = 1, #self.Cells do
		local lCell = self.Cells[i]

		if lCell.UnitId == unitId then
			index = i

			break
		end
	end

	if index == -1 then
		return
	end

	self:ReleaseCell(self.Cells[index])
	table.remove(self.Cells, index)
	self:RefreshArrows()
end

function m:OnMoveStepComplete(moveDelta)
	if math.abs(moveDelta) == -1 and self.StepReorderCellFrame ~= UnityEngine.Time.frameCount then
		self:ReorderCellLayers(moveDelta)

		self.StepReorderCellFrame = UnityEngine.Time.frameCount
	end
end

function m:UnitDead(unitId)
	local function onPlayDeadAnimComplete(pUnitId)
		local index = -1

		for i = 1, #self.Cells do
			local lCell = self.Cells[i]

			if lCell.UnitId == pUnitId and (not lCell:IsMoving() or lCell:GetFinalDesIndex() > 0) then
				index = i

				break
			end
		end

		if index == -1 then
			return
		end

		self:ReorderCellLayers(-1)

		for i = #self.Cells, index + 1, -1 do
			local lCell = self.Cells[i]
			local fromIndex = i

			if lCell:IsMoving() then
				fromIndex = lCell:GetFinalDesIndex()
			end

			lCell:MoveTo(fromIndex, fromIndex - 1)
		end

		self:ReleaseCell(self.Cells[index])
		table.remove(self.Cells, index)
		self:RefreshArrows()
	end

	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		if cell.UnitId == unitId and (not cell:IsMoving() or cell:GetFinalDesIndex() > 0) then
			cell:Dead(onPlayDeadAnimComplete)

			break
		end
	end
end

function m:ReOrderBySpeed(changedUnitId)
	local unitTurnList = {}

	for i = 1, #BattleModule.TurnOrders do
		table.insert(unitTurnList, BattleModule.TurnOrders[i])
	end

	unitTurnList = self:SortBySpeed(unitTurnList)

	local changed = false

	for i = 1, #unitTurnList do
		local cell = self.Cells[i]

		if cell == nil then
			changed = true

			break
		end

		if unitTurnList[i] ~= cell.UnitId then
			changed = true

			break
		end
	end

	if not changed then
		return
	end

	local oldOrders = {}
	local orderIndex = 1

	for i = 1, #self.Cells do
		local cell = self.Cells[i]
		local battleUnitData = BattleModule.GetBattleUnitData(cell.UnitId)

		if not battleUnitData.IsDead then
			oldOrders[cell.UnitId] = orderIndex
			orderIndex = orderIndex + 1
		else
			oldOrders[cell.UnitId] = -1
		end
	end

	local newCells = {}

	for i = 1, #unitTurnList do
		for j = 1, #self.Cells do
			local cell = self.Cells[j]

			if cell.UnitId == unitTurnList[i] then
				table.remove(self.Cells, j)
				table.insert(newCells, cell)

				break
			end
		end
	end

	if #self.Cells > 0 then
		local deadNum = 0

		for i = 1, #self.Cells do
			local cell = self.Cells[i]
			local battleUnitData = BattleModule.GetBattleUnitData(cell.UnitId)

			if battleUnitData.IsDead then
				deadNum = deadNum + 1
			end
		end

		local dollMonsterInfos = BattleModule.__TestGetDollInfoText()

		logError("Reorder error：有cell没有被统计到。没被统计到的死亡单位数量：" .. deadNum .. " 参战灵魂信息[name, Monster.Id, level, power]：" .. dollMonsterInfos .. ". Monster team cid：" .. BattleModule.GetMonsterTeamCid())
	end

	self.Cells = newCells

	local changedCell

	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		if cell.UnitId == changedUnitId then
			changedCell = cell

			break
		end
	end

	if changedCell == nil or oldOrders[changedCell.UnitId] == -1 then
		return
	end

	changedCell:StartMoveBySpeed(function(pChangedCell)
		local sampleMoveDelta

		for i = 1, #self.Cells do
			local cell = self.Cells[i]
			local oldOrder = oldOrders[cell.UnitId]

			if oldOrder ~= -1 then
				cell:MoveTo(oldOrder, i, cell == pChangedCell and function(unitId, finalIndex)
					local pCell

					for j = 1, #self.Cells do
						local lCell = self.Cells[j]

						if lCell.UnitId == unitId then
							pCell = lCell

							break
						end
					end

					pCell:PlayAnim("ATBarHead_ScaleSmall2")
				end or nil, cell == pChangedCell)

				if sampleMoveDelta == nil and cell ~= pChangedCell then
					sampleMoveDelta = i - oldOrders[cell.UnitId]
				end
			end
		end

		self:ReorderCellLayers(sampleMoveDelta)
		pChangedCell.View.transform:SetAsLastSibling()
	end)
end

function m:OnWeakNumChange(unitId, fromNum, toNum)
	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		if cell.UnitId == unitId then
			cell:OnWeakNumChange(fromNum, toNum)

			break
		end
	end
end

function m:CheckUnitUltimateSkillState(unitId, isAboutToCastUltimateSkill)
	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		if cell.UnitId == unitId then
			cell:CheckUltimateSkillState(isAboutToCastUltimateSkill)

			break
		end
	end
end

function m:ReleaseCell(cell, isDestroy)
	if not isDestroy then
		cell.View.transform:SetParent(self.View.transform, false)
	end

	cell:OnRelease()
	self.CellPool:Release(cell)
end

function m:ClearCells(isDestroy)
	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		self:ReleaseCell(cell, isDestroy)
	end

	self.Cells = {}
end

function m:Clear(resetCell)
	if resetCell then
		self:ClearCells(false)
	else
		for i = 1, #self.Cells do
			local cell = self.Cells[i]

			cell:ClearMove()
		end
	end
end

function m:Dispose()
	self:ClearCells(true)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil

	for i = 1, #self.Points do
		self.Points[i] = nil
	end

	self.Points = nil
end

return m
