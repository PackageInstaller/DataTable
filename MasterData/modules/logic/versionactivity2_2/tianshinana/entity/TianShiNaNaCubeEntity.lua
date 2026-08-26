-- chunkname: @modules/logic/versionactivity2_2/tianshinana/entity/TianShiNaNaCubeEntity.lua

module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaCubeEntity", package.seeall)

local TianShiNaNaCubeEntity = class("TianShiNaNaCubeEntity", LuaCompBase)
local Dir = TianShiNaNaEnum.Dir
local OperDir = TianShiNaNaEnum.OperDir
local OperEffect = TianShiNaNaEnum.OperEffect
local DirToQuaternion = TianShiNaNaEnum.DirToQuaternion
local backDir = {
	[Dir.Forward] = true,
	[Dir.Left] = true,
	[Dir.Down] = true
}

function TianShiNaNaCubeEntity.Create(x, y, parent)
	local go = UnityEngine.GameObject.New("Cube")

	if parent then
		go.transform:SetParent(parent.transform, false)
	end

	return (MonoHelper.addNoUpdateLuaComOnceToGo(go, TianShiNaNaCubeEntity, {
		x = x,
		y = y
	}))
end

function TianShiNaNaCubeEntity:ctor(param)
	self.planDirs = {
		Dir.Up,
		Dir.Back,
		Dir.Right,
		Dir.Left,
		Dir.Forward,
		Dir.Down
	}
	self.l = 1
	self.w = 1
	self.h = 2
	self.x = param.x + self.l / 2 - 0.5
	self.y = self.h / 2 - 1
	self.z = param.y + self.w / 2 - 0.5
	self.finalV3 = Vector3(self.x, self.y, self.z)
	self.curOper = nil
	self.nowTweenValue = 0
end

function TianShiNaNaCubeEntity:init(go)
	self.go = go
	self.loader = PrefabInstantiate.Create(self.go)

	self.loader:startLoad("scenes/v2a2_m_s12_tsnn_jshd/prefab/v2a2_m_s12_tsnn_box_p.prefab", self.onLoadResEnd, self)

	self.trans = self.instGo.transform:GetChild(0)

	transformhelper.setLocalPos(self.trans, self.x, self.y, self.z)

	TianShiNaNaModel.instance.curPointList = {}
end

function TianShiNaNaCubeEntity:onLoadResEnd()
	self.plans = self:getUserDataTb_()
	self.renderers = self:getUserDataTb_()
	self.hideRenderers = self:getUserDataTb_()
	self.instGo = self.loader:getInstGO()
	self.rootGo = self.instGo.transform:GetChild(0):GetChild(0).gameObject
	self.anim = self.instGo:GetComponent(typeof(UnityEngine.Animator))

	self.anim:Play("open1", 0, 1)

	for i = 1, 6 do
		self.plans[i] = gohelper.findChild(self.rootGo, i)
		self.renderers[i] = self.plans[i]:GetComponent(typeof(UnityEngine.Renderer))
	end

	self:updateSortOrder()
end

function TianShiNaNaCubeEntity:playOpenAnim(cubeType)
	if cubeType == TianShiNaNaEnum.CubeType.Type1 then
		self.anim:Play("open1", 0, 0)
	else
		self.anim:Play("open2", 0, 0)
	end
end

function TianShiNaNaCubeEntity:updateSortOrder()
	if not self.renderers then
		return
	end

	for index, renderer in pairs(self.renderers) do
		local dir = self.planDirs[index]

		renderer.sortingOrder = backDir[dir] and TianShiNaNaHelper.getSortIndex(self.x, self.z) - 1 or TianShiNaNaHelper.getSortIndex(self.x, self.z) + 1
	end
end

function TianShiNaNaCubeEntity:doCubeTween(operDir, value)
	if operDir == OperDir.Left or operDir == OperDir.Right then
		if not self.l then
			local b = self.w
			local dis = (b / 2)^2 + (self.h / 2)^2
			local beforeOffset = b * Mathf.Clamp(value, 0, 0.5)
			local afterOffset = self.h * Mathf.Clamp(value - 0.5, 0, 0.5)
			local totalOffset = beforeOffset + afterOffset

			self.finalV3.y = math.sqrt(dis - (totalOffset - b / 2)^2)

			if operDir == OperDir.Left then
				self.finalV3.x = self.x - totalOffset
			elseif operDir == OperDir.Right then
				self.finalV3.x = self.x + totalOffset
			elseif operDir == OperDir.Forward then
				self.finalV3.z = self.z + totalOffset
			elseif operDir == OperDir.Back then
				self.finalV3.z = self.z - totalOffset
			end

			local q1 = DirToQuaternion[self.planDirs[1]][self.planDirs[2]]
			local q2 = DirToQuaternion[self:getNextDir(operDir, self.planDirs[1])][self:getNextDir(operDir, self.planDirs[2])]
			local beginAngle = math.atan2(self.h, b)

			if value > 0.5 then
				local nowAngle = math.atan2(self.finalV3.y, -afterOffset or b / 2 - beforeOffset)
				local q = TianShiNaNaHelper.lerpQ(q1, q2, (nowAngle - beginAngle) / math.pi * 2)

				transformhelper.setLocalRotation2(self.trans, q.x, q.y, q.z, q.w)
				transformhelper.setLocalPos(self.trans, self.finalV3.x, self.finalV3.y - 1, self.finalV3.z)

				if value > 0.5 then
					self:doRotate(operDir, true)
					self:updateSortOrder()
					self:doRotate(-operDir, true)
				else
					self:updateSortOrder()
				end
			end
		end
	end
end

function TianShiNaNaCubeEntity:getPlaneByIndex(index)
	return self.plans[index]
end

function TianShiNaNaCubeEntity:setPlaneParent(index, parent)
	self.renderers[index].sortingOrder = 1
	self.hideRenderers[index] = self.renderers[index]
	self.renderers[index] = nil

	local plane = self:getPlaneByIndex(index)

	plane.transform:SetParent(parent, true)
	tabletool.addValues(TianShiNaNaModel.instance.curPointList, self:getCurGrids())
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CubePointUpdate)
end

function TianShiNaNaCubeEntity:revertPlane(index)
	local _, renderer = next(self.renderers)

	if not renderer or not self.hideRenderers[index] then
		return
	end

	self.renderers[index] = self.hideRenderers[index]
	self.renderers[index].sortingOrder = renderer.sortingOrder
	self.hideRenderers[index] = nil

	local plane = self:getPlaneByIndex(index)

	plane.transform:SetParent(self.rootGo.transform, true)

	local points = self:getCurGrids()

	for i = #TianShiNaNaModel.instance.curPointList, 1, -1 do
		local point = TianShiNaNaModel.instance.curPointList[i]

		for _, curPoint in pairs(points) do
			if TianShiNaNaHelper.isPosSame(curPoint, point) then
				table.remove(TianShiNaNaModel.instance.curPointList, i)

				break
			end
		end
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CubePointUpdate)
end

function TianShiNaNaCubeEntity:hideOtherPlane()
	for index in pairs(self.renderers) do
		gohelper.setActive(self:getPlaneByIndex(index), false)
	end
end

function TianShiNaNaCubeEntity:doRotate(operDir, onlyCalc)
	if operDir == OperDir.Left then
		self.x = self.x - self.l / 2 - self.h / 2
		self.l, self.h = self.h, self.l
	elseif operDir == OperDir.Right then
		self.x = self.x + self.l / 2 + self.h / 2
		self.l, self.h = self.h, self.l
	elseif operDir == OperDir.Forward then
		self.z = self.z + self.w / 2 + self.h / 2
		self.w, self.h = self.h, self.w
	elseif operDir == OperDir.Back then
		self.z = self.z - self.w / 2 - self.h / 2
		self.w, self.h = self.h, self.w
	end

	self.y = self.h / 2 - 1
	self.allPoint = nil

	if not onlyCalc then
		for index, dir in pairs(self.planDirs) do
			self.planDirs[index] = self:getNextDir(operDir, dir)
		end

		self.finalV3:Set(self.x, self.y, self.z)
		transformhelper.setLocalPos(self.trans, self.finalV3.x, self.finalV3.y, self.finalV3.z)

		local q = DirToQuaternion[self.planDirs[1]][self.planDirs[2]]

		transformhelper.setLocalRotation2(self.trans, q.x, q.y, q.z, q.w)
		self:updateSortOrder()
	end
end

function TianShiNaNaCubeEntity:resetPos()
	self.finalV3:Set(self.x, self.y, self.z)
	transformhelper.setLocalPos(self.trans, self.finalV3.x, self.finalV3.y, self.finalV3.z)

	local q = DirToQuaternion[self.planDirs[1]][self.planDirs[2]]

	transformhelper.setLocalRotation2(self.trans, q.x, q.y, q.z, q.w)
end

function TianShiNaNaCubeEntity:getCurDownIndex()
	for index, dir in pairs(self.planDirs) do
		if dir == Dir.Down then
			return index
		end
	end

	return 1
end

function TianShiNaNaCubeEntity:getDirByIndex(index)
	return self.planDirs[index] or Dir.Up
end

function TianShiNaNaCubeEntity:getCurGrids()
	if self.allPoint then
		return self.allPoint
	end

	local minX = Mathf.Round(self.x - self.l / 2)
	local maxX = Mathf.Round(self.x + self.l / 2)
	local minY = Mathf.Round(self.z - self.w / 2)
	local maxY = Mathf.Round(self.z + self.w / 2)
	local allPoint = {}

	for x = minX, maxX - 1 do
		for y = minY, maxY - 1 do
			table.insert(allPoint, {
				x = x,
				y = y
			})
		end
	end

	self.allPoint = allPoint

	return allPoint
end

function TianShiNaNaCubeEntity:getOperGrids(operDir)
	self:doRotate(operDir, true)

	local allPoints = self:getCurGrids()

	self:doRotate(-operDir, true)

	return allPoints
end

function TianShiNaNaCubeEntity:getOperDownIndex(operDir)
	for index, dir in pairs(self.planDirs) do
		local nextDir = self:getNextDir(operDir, dir)

		if nextDir == Dir.Down then
			return index
		end
	end

	return 1
end

function TianShiNaNaCubeEntity:getNextDir(oper, dir)
	local nextDirs = OperEffect[oper]

	if not oper then
		return dir
	end

	return nextDirs[dir] or dir
end

function TianShiNaNaCubeEntity:onDestroy()
	for i = 1, 6 do
		gohelper.destroy(self.plans[i])
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

return TianShiNaNaCubeEntity
