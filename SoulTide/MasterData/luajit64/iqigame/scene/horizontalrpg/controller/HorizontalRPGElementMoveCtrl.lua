-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Controller\\HorizontalRPGElementMoveCtrl.lua

local m = {
	speed = 10,
	currentIndexPath = 0,
	lastChangeDirTimer = 0,
	moveType = 0,
	startMove = false,
	lineDir = 1,
	paths = {}
}

function m.New(elementCell, callback)
	local obj = Clone(m)

	obj:Init(elementCell, callback)

	return obj
end

function m:Init(elementCell, callback)
	self.elementCell = elementCell
	self.moveStateCallBack = callback
end

function m:RefreshPath(moveType, pathNode, changeDirNode, speed)
	self.moveType = moveType
	self.paths = {}

	if pathNode then
		for i = 0, pathNode.transform.childCount - 1 do
			local posTrans = pathNode.transform:GetChild(i)
			local v2 = Vector2.New(posTrans.position.x, posTrans.position.y)

			table.insert(self.paths, v2)
		end
	end

	self.changeDirNode = changeDirNode

	if speed then
		self.speed = speed
	end
end

function m:FrameUpdate()
	if not self.startMove then
		return
	end

	if self.elementCell then
		local isObstacles = self:CheckObstacles()

		if isObstacles then
			if self.elementCell.ElementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Annular_Move_Element then
				return
			end

			self.lineDir = -self.lineDir

			self:RefreshNextPos()
		end

		if self.nextPos then
			local nowV2 = Vector2.New(self.elementCell.View.transform.position.x, self.elementCell.View.transform.position.y)
			local direction = self.nextPos - nowV2

			if self.changeDirNode then
				local localScale = self.changeDirNode.transform.localScale

				if direction.x > 0 then
					localScale.x = -math.abs(localScale.x)
				elseif direction.x < 0 then
					localScale.x = math.abs(localScale.x)
				end

				local now = PlayerModule.GetServerTime()

				if now - self.lastChangeDirTimer > 0.1 then
					self.changeDirNode.transform.localScale = localScale
					self.lastChangeDirTimer = now
				end
			end

			if direction.magnitude > 0.1 then
				self.elementCell.View.transform:Translate(direction.normalized * self.speed * UnityEngine.Time.deltaTime)
			else
				self:StopMovie()
				self:StartMovie()
			end
		else
			self:StopMovie()
		end
	end
end

function m:FixedUpdate()
	return
end

function m:CheckObstacles()
	local res = self.elementCell.ElementBodyCollider2D.bounds:Intersects(HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler.collider2D.bounds)

	if res then
		return true
	end

	for areaID, areaElements in pairs(HorizontalRPGModule.horizontalRPGScene.HorizontalSceneObjManager.HorizontalRPGElementPool) do
		for pos, v in pairs(areaElements) do
			if v.Active and v.ElementData and v.ElementData.cid ~= self.elementCell.ElementData.cid then
				res = self.elementCell.ElementBodyCollider2D.bounds:Intersects(v.ElementBodyCollider2D.bounds)

				if res then
					return true
				end
			end
		end
	end

	return false
end

function m:RefreshNextPos()
	if self.moveType == HorizontalRPGConstant.ElementType.HorizontalRPG_Line_Move_Element then
		if self.currentIndexPath <= 1 then
			self.lineDir = 1
		elseif self.currentIndexPath >= #self.paths then
			self.lineDir = -1
		end

		self.currentIndexPath = self.currentIndexPath + self.lineDir
	elseif self.moveType == HorizontalRPGConstant.ElementType.HorizontalRPG_Annular_Move_Element then
		self.currentIndexPath = self.currentIndexPath + 1

		if self.currentIndexPath > #self.paths then
			self.currentIndexPath = 1
		end
	end

	self.nextPos = self.paths[self.currentIndexPath]
end

function m:StartMovie()
	self:RefreshNextPos()

	self.startMove = true

	if self.moveStateCallBack then
		self.moveStateCallBack(self.startMove)
	end
end

function m:StopMovie()
	self.startMove = false

	if self.moveStateCallBack then
		self.moveStateCallBack(self.startMove)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	self.moveStateCallBack = nil
end

return m
