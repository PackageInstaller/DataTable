-- chunkname: @IQIGame\\Module\\Home\\HomeActorMoveData.lua

local HomeActorMoveData = {
	curMoveIndex = 0,
	nextMoveIndex = 0,
	tmp_last_distance = 999,
	moveStep = 1,
	movePoints = {}
}

function HomeActorMoveData.New(transform)
	local obj = Clone(HomeActorMoveData)

	obj:__Init(transform)

	return obj
end

function HomeActorMoveData:__Init(transform)
	self.speed = Vector3.New(0.01, 0.01, 0.01)

	for i = 0, transform.childCount - 1 do
		local childTrans = transform:GetChild(i)

		table.insert(self.movePoints, childTrans)
	end

	if #self.movePoints < 2 then
		logError("初始化移动节点 {0} 数据失败，路径点数量小于 2", transform.name)
	end

	self.nextMoveIndex = math.random(1, #self.movePoints)

	self:UpdateNextPoint()
end

function HomeActorMoveData:Dispose()
	self.movePoints = nil
end

function HomeActorMoveData:UpdateNextPoint()
	self.curMoveIndex = self.nextMoveIndex

	if self.curMoveIndex == #self.movePoints then
		self.moveStep = -1
	elseif self.curMoveIndex == 1 then
		self.moveStep = 1
	end

	self.nextMoveIndex = self.curMoveIndex + self.moveStep
	self.beginPos = self.movePoints[self.curMoveIndex].localPosition
	self.endPos = self.movePoints[self.nextMoveIndex].localPosition
	self.tmp_last_distance = 999
end

function HomeActorMoveData:IsMoveEnd(curPos)
	local distance = Vector3.Distance(curPos, self.endPos)
	local value = GetPreciseDecimal(distance, 2)

	if value > self.tmp_last_distance then
		value = 0
	else
		self.tmp_last_distance = value
	end

	return value <= 0.03
end

function HomeActorMoveData:GetDistance(pos, targetPos, precisesNumber, magnification)
	local pos_x = GetPreciseDecimal(pos.x, precisesNumber) * magnification
	local pos_y = GetPreciseDecimal(pos.y, precisesNumber) * magnification
	local pos_z = GetPreciseDecimal(pos.z, precisesNumber) * magnification
	local targetPos_x = GetPreciseDecimal(targetPos.x, precisesNumber) * magnification
	local targetPos_y = GetPreciseDecimal(targetPos.y, precisesNumber) * magnification
	local targetPos_z = GetPreciseDecimal(targetPos.z, precisesNumber) * magnification
	local distance = math.sqrt((pos_x - targetPos_x)^2 + (pos_y - targetPos_y)^2 + (pos_z - targetPos_z)^2)

	return GetPreciseDecimal(distance, precisesNumber)
end

return HomeActorMoveData
