-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneMapSpBlock.lua

module("modules.logic.scene.survival.comp.SurvivalSceneMapSpBlock", package.seeall)

local SurvivalSceneMapSpBlock = class("SurvivalSceneMapSpBlock", BaseSceneComp)

SurvivalSceneMapSpBlock.EdgeResPath = "survival/effects/prefab/v3a1_scene_bianyuan.prefab"

function SurvivalSceneMapSpBlock:init()
	self.blockComp = self:getCurScene().block

	self:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapSpBlockAdd, self.onSpBlockAdd, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapSpBlockDel, self.onSpBlockDelete, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapDestoryPosAdd, self.onMapDestoryPosAdd, self)
end

function SurvivalSceneMapSpBlock:_onPreloadFinish()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)

	self._sceneGo = self:getCurScene():getSceneContainerGO()
	self._blockRoot = gohelper.create3d(self._sceneGo, "SPBlockRoot")
	self._edgeRes = SurvivalMapHelper.instance:getBlockRes(SurvivalSceneMapSpBlock.EdgeResPath)

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	self._allBlocks = {}
	self._allBlockDict = {}
	self._destroyBlocks = {}
	self._spBlockEdge = {}
	self._edgePool = {}

	for q, v in pairs(sceneMo.allDestroyPos) do
		self._destroyBlocks[q] = {}

		for r, pos in pairs(v) do
			self._destroyBlocks[q][r] = SurvivalDestoryBlockEntity.Create({
				pos = pos
			}, self._blockRoot)
		end
	end

	for id, unitMo in pairs(sceneMo.blocksById) do
		local block = SurvivalSpBlockEntity.Create(unitMo, self._blockRoot)

		self._allBlocks[id] = block

		self:addBlock(unitMo.pos, block)
		self:showHideBlock(unitMo.pos, false, true)

		for i, v in ipairs(unitMo.exPoints) do
			self:showHideBlock(v, false, true)
		end

		if unitMo:getSubType() ~= SurvivalEnum.UnitSubType.Block then
			self:checkEdge(unitMo.pos)
		end
	end

	self:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function SurvivalSceneMapSpBlock:checkEdge(pos)
	if not self._edgeRes then
		return
	end

	local tempPos = SurvivalMapModel.instance:getCacheHexNode(1)

	tempPos:copyFrom(pos)
	self:checkEdge2(tempPos)
	tempPos:copyFrom(pos):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.Right])
	self:checkEdge2(tempPos)
	tempPos:copyFrom(pos):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.BottomLeft])
	self:checkEdge2(tempPos)
	tempPos:copyFrom(pos):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.BottomRight])
	self:checkEdge2(tempPos)
end

function SurvivalSceneMapSpBlock:checkEdge2(nowPos)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local tempPos = SurvivalMapModel.instance:getCacheHexNode(2)
	local left = tempPos:copyFrom(nowPos):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.Left])
	local isShowLeft = not self:isBlockSame(sceneMo:getBlockTypeByPos(nowPos), sceneMo:getBlockTypeByPos(left))

	self:showHideEdge(isShowLeft, nowPos, 1)

	local topLeft = tempPos:copyFrom(nowPos):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.TopLeft])
	local isShowTopLeft = not self:isBlockSame(sceneMo:getBlockTypeByPos(nowPos), sceneMo:getBlockTypeByPos(topLeft))

	self:showHideEdge(isShowTopLeft, nowPos, 2)

	local topRight = tempPos:copyFrom(nowPos):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.TopRight])
	local isShowTopRight = not self:isBlockSame(sceneMo:getBlockTypeByPos(nowPos), sceneMo:getBlockTypeByPos(topRight))

	self:showHideEdge(isShowTopRight, nowPos, 3)
end

function SurvivalSceneMapSpBlock:showHideEdge(isShow, pos, index)
	self._spBlockEdge[pos.q] = self._spBlockEdge[pos.q] or {}
	self._spBlockEdge[pos.q][pos.r] = self._spBlockEdge[pos.q][pos.r] or {}

	local edge = self._spBlockEdge[pos.q][pos.r][index]

	if isShow and not edge then
		edge = table.remove(self._edgePool)

		local edgeTrans

		if not edge then
			edge = gohelper.clone(self._edgeRes, self._blockRoot, "edge")
		else
			gohelper.setActive(edge, true)
		end

		edgeTrans = edge.transform

		if index == 1 then
			local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q - 0.5, pos.r)

			transformhelper.setLocalRotation(edgeTrans, 0, 180, 0)
			transformhelper.setLocalPos(edgeTrans, x, y, z)
		elseif index == 2 then
			local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r - 0.5)

			transformhelper.setLocalRotation(edgeTrans, 0, -120, 0)
			transformhelper.setLocalPos(edgeTrans, x, y, z)
		elseif index == 3 then
			local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q + 0.5, pos.r - 0.5)

			transformhelper.setLocalRotation(edgeTrans, 0, -60, 0)
			transformhelper.setLocalPos(edgeTrans, x, y, z)
		end

		self._spBlockEdge[pos.q][pos.r][index] = edge
	elseif not isShow and edge then
		if self._edgePool[20] then
			gohelper.destroy(edge)
		else
			gohelper.setActive(edge, false)
			table.insert(self._edgePool, edge)
		end

		self._spBlockEdge[pos.q][pos.r][index] = nil
	end
end

function SurvivalSceneMapSpBlock:isBlockSame(type1, type2)
	local flag1 = type1 ~= -1 and type1 ~= SurvivalEnum.UnitSubType.Block
	local flag2 = type2 ~= -1 and type2 ~= SurvivalEnum.UnitSubType.Block

	return flag1 == flag2
end

function SurvivalSceneMapSpBlock:onMapDestoryPosAdd(unitMo)
	self:showHideBlock(unitMo.pos, true, true)

	for i, v in ipairs(unitMo.exPoints) do
		self:showHideBlock(v, true, true)
	end
end

function SurvivalSceneMapSpBlock:showHideBlock(pos, isShow, onlyDestroy)
	local destroyBlock = SurvivalHelper.instance:getValueFromDict(self._destroyBlocks, pos)

	if destroyBlock then
		gohelper.setActive(destroyBlock.go, isShow)

		if isShow then
			self.blockComp:setBlockActive(pos, false)
		end
	elseif onlyDestroy then
		if isShow then
			self._destroyBlocks[pos.q] = self._destroyBlocks[pos.q] or {}
			self._destroyBlocks[pos.q][pos.r] = SurvivalDestoryBlockEntity.Create({
				pos = pos
			}, self._blockRoot)

			self.blockComp:setBlockActive(pos, false)
		end
	else
		self.blockComp:setBlockActive(pos, isShow)
	end
end

function SurvivalSceneMapSpBlock:onSpBlockAdd(unitMo)
	local block = SurvivalSpBlockEntity.Create(unitMo, self._blockRoot)

	self._allBlocks[unitMo.id] = block

	self:addBlock(unitMo.pos, block)
	self:showHideBlock(unitMo.pos, false, false)

	for i, v in ipairs(unitMo.exPoints) do
		self:showHideBlock(v, false, false)
	end

	if unitMo:getSubType() ~= SurvivalEnum.UnitSubType.Block then
		self:checkEdge(unitMo.pos)
	end

	self:checkPetrifaction(unitMo, true)
end

function SurvivalSceneMapSpBlock:onSpBlockDelete(unitMo)
	if self._allBlocks[unitMo.id] then
		self:showHideBlock(unitMo.pos, true, false)

		for i, v in ipairs(unitMo.exPoints) do
			self:showHideBlock(v, true, false)
		end

		self._allBlocks[unitMo.id]:tryDestory()

		self._allBlocks[unitMo.id] = nil

		self:removeBlock(unitMo.pos)
	end

	if unitMo:getSubType() ~= SurvivalEnum.UnitSubType.Block then
		self:checkEdge(unitMo.pos)
	end

	self:checkPetrifaction(unitMo, false)
end

function SurvivalSceneMapSpBlock:checkPetrifaction(survivalUnitMo, isAdd)
	if survivalUnitMo:getSubType() == SurvivalEnum.UnitSubType.Petrifaction then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local list = sceneMo:getUnitByPos(survivalUnitMo.pos, true, true)

		if list then
			for i, unitMo in ipairs(list) do
				if SurvivalMapHelper.instance:isPetrifactionTar(unitMo) then
					if isAdd then
						SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(unitMo.id)
						SurvivalController.instance:dispatchEvent(SurvivalEvent.ShowUnitBubble, unitMo.id, 1, 0)
					else
						local warmingRange = unitMo:getWarmingRange()

						if warmingRange then
							SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(unitMo.id)
							self:_showEffect(unitMo.id, unitMo.pos, warmingRange)
						end

						SurvivalController.instance:dispatchEvent(SurvivalEvent.HideUnitBubble, unitMo.id)
					end
				end
			end
		end
	end
end

function SurvivalSceneMapSpBlock:onSceneClose()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapSpBlockAdd, self.onSpBlockAdd, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapSpBlockDel, self.onSpBlockDelete, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapDestoryPosAdd, self.onMapDestoryPosAdd, self)
	gohelper.destroy(self._blockRoot)

	self._blockRoot = nil
	self._sceneGo = nil
	self._allBlocks = {}
	self._allBlockDict = {}
	self._destroyBlocks = {}
	self._edgeRes = nil
	self._spBlockEdge = {}
	self._edgePool = {}
end

function SurvivalSceneMapSpBlock:addBlock(pos, block)
	if not block or not pos then
		return
	end

	self._allBlockDict[pos.q] = self._allBlockDict[pos.q] or {}
	self._allBlockDict[pos.q][pos.r] = block
end

function SurvivalSceneMapSpBlock:removeBlock(pos)
	if not pos then
		return
	end

	if self._allBlockDict[pos.q] and self._allBlockDict[pos.q][pos.r] then
		self._allBlockDict[pos.q][pos.r] = nil
	end
end

function SurvivalSceneMapSpBlock:getBlock(hexPoint)
	if not hexPoint then
		return
	end

	if self._allBlockDict[hexPoint.q] then
		return self._allBlockDict[hexPoint.q][hexPoint.r]
	end
end

function SurvivalSceneMapSpBlock:_showEffect(id, pos, range)
	local walkablePos = SurvivalMapModel.instance:getCurMapCo().walkables

	for i, v in ipairs(SurvivalHelper.instance:getAllPointsByDis(pos, range)) do
		if SurvivalHelper.instance:getValueFromDict(walkablePos, v) then
			SurvivalMapHelper.instance:getScene().pointEffect:setPointEffectType(id, v.q, v.r, 1)
		end
	end
end

return SurvivalSceneMapSpBlock
