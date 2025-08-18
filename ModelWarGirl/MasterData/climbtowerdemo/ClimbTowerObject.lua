-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClimbTowerDemo\\ClimbTowerObject.lua

local UIUtils = require("Framework.UI.UIUtils")
local Model = require("Entity/Model")
local EntityFactory = Framework.Entity.EntityFactory
local Entity = require("Entity/Entity")
local BattleLogo = require("UI/Control/Logo/BattleLogo")
local ResColor = require("ClientData/ResColor")
local ResClimbTowerAction = require("ClientData/ResClimbTowerAction")
local ResClimbTowerItem = require("ClientData/ResClimbTowerItem")
local AnimActor = require("Logic/battle/AnimActor")
local ResModelActionConfig = require("ClientData/ResModelActionConfig")
local COLOR_MODE = {
	choose_red = 2,
	choose_green = 1,
	green = 3,
	red = 4
}
local DEFAULT_PADDING = {
	0,
	0,
	0,
	0
}
local Z_OFFSET = 0
local START_ENTITY_ID = 990000
local ClimbTowerObject = Class("ClimbTowerObject", Entity)

ClimbTowerObject._curID = START_ENTITY_ID

function ClimbTowerObject:ctor(entityId, entityName, parent, putData, initData, camp)
	self.mParent = parent
	self.did = ClimbTowerObject._curID
	ClimbTowerObject._curID = self.did + 1
	self.initData = initData
	self.gridPos = 0
	self.putData = putData
	self.data = putData.data
	self.modelData = self.data.modelData
	self.modelId = self.data.modelId
	self.zoneName = self.modelData.baseInfo.zone_name
	self.layer = self.data.modelData.typeInfo.layer_id or 99
	self.type = self.data.modelData.typeInfo.type_id
	self.gridOffset = 0
	self.isDelete = false
	self.num = self.initData.num
	self.numType = self.initData.numType or Const.CLIMB_TOWER_NUM_TYPE_COMPARE
	self.enemyType = self.initData.enemyType
	self.changeModel = self.initData.changeModel

	if self.enemyType and self.enemyType == 1 then
		self.isBoss = true
	end

	self.isMySelf = self.initData.isMySelf
	self.skillData = {}

	if self.isMySelf then
		self.skillData = ResClimbTowerAction[self.modelId] or {}
	end

	self.scale = self.initData.scale or 1
end

function ClimbTowerObject:loadModel(...)
	self:put2Pos()
	self:postInit()
	self:setGridIndex(self.initData.pos, true)
	self:setChoosing()
	self:createModel(self.modelData)

	if self.type ~= Const.REARHOUSE_TYPE_SHELF then
		self:initLogo()
	end
end

function ClimbTowerObject:getHeroId()
	return ResClimbTowerAction[self.modelId][1].hero_id
end

function ClimbTowerObject:destroy()
	self.isDelete = true

	if self.entityModel then
		self.entityModel:destroy()

		self.entityModel = nil
	end

	if self.entityModelHigh then
		self.entityModelHigh:destroy()

		self.entityModelHigh = nil
	end

	if self.timer then
		self.timer:Stop()
	end

	if self.gainCueID then
		CueManager.releaseCue(self, self.gainCueID, self.gainInsId)

		self.gainCueID = nil
	end

	if self.towerCueID then
		CueManager.releaseCue(self, self.towerCueID, self.towerInsId)

		self.towerCueID = nil
	end

	self.topNode = nil
	self.topRootRight = nil
	self.topRootLeft = nil
	self.effectAnchor = nil
	self.dragController = nil
	self.controller = nil
	self._transform = nil
	self._modelsTransform = nil
	self.mParent = nil
	self.conflictObjs = nil
	self.shelf = nil
	self.halfShelfs = nil

	EntityFactory.ReleaseEntity(self.did)
	CueManager.clearCue(self.did, self)
end

function ClimbTowerObject:showModel(...)
	if self.entityModel then
		self.entityModel:setScale(self.scale)
		self.entityModel:showModel(true)
	end

	self:playGainObjEffect()
	self:playTowerObjEffect()
end

function ClimbTowerObject:playGainObjEffect()
	if self.gainCueID then
		CueManager.releaseCue(self, self.gainCueID, self.gainInsId)

		self.gainCueID = nil
	end

	if ResClimbTowerItem[self.modelId] then
		self.gainCueID = ResClimbTowerItem[self.modelId].cue_id

		if self.gainCueID then
			self.gainInsId = CueManager.playCue(self, self.gainCueID)
		end
	end
end

function ClimbTowerObject:playTowerObjEffect(curAttackTower)
	curAttackTower = curAttackTower or self.mParent.curAttackTower

	if self.towerCueID then
		CueManager.releaseCue(self, self.towerCueID, self.towerInsId)

		self.towerCueID = nil
	end

	if self.initData.resData and curAttackTower then
		if curAttackTower > self.initData.towerIndex then
			self.towerCueID = self.initData.resData.finish_cue_id
		elseif self.initData.towerIndex == curAttackTower then
			self.towerCueID = self.initData.resData.attack_cue_id
		elseif curAttackTower < self.initData.towerIndex then
			self.towerCueID = self.initData.resData.lock_cue_id
		end
	end

	if self.towerCueID then
		self.towerInsId = CueManager.playCue(self, self.towerCueID)
	end
end

function ClimbTowerObject:initLogo()
	if self.logo == nil then
		self.logo = BattleLogo(self.controller, "System/MiniGame/BattleBloodMiniGamePanel", 0, 0, self)

		local text = 0
		local color = ResColor.QUALITYGREEN

		if self.numType == -1 then
			text = self.num
			color = ResColor.RED
		elseif self.numType == 0 then
			if self.isMySelf then
				text = self.num
			else
				text = "+" .. self.num
			end
		elseif self.numType == 1 then
			text = "X" .. self.num
		end

		self.logo.textHp:setText(text)
		self.logo.textHp:setFontColor(color)
		self.logo.textHp:setFontSize(40)
		self.logo.textHp:setAlign(UIConst.TXTALIGN_MC)

		local pos = self.logo.textHp:getPosition()

		self.logo.textHp:setPosition(pos.x, pos.y - 100 / self.scale)
		self.logo.textHpPer:setVisible(false)
		self.logo.imgBg:setVisible(false)
		self.logo.sliderHp:setVisible(false)
		self.logo.sliderHpPre:setVisible(false)
		self.logo.uiPower:setVisible(false)
		self.logo:setHide(false)
		self.logo.panelInfo:setVisible(true)
	end
end

function ClimbTowerObject:refreshNumInfo()
	if self.logo then
		self.logo.textHp:setText(self.num)
	end
end

function ClimbTowerObject:setHideLogo(v)
	if self.logo then
		self.logo:setHide(v)
	end
end

function ClimbTowerObject:postInit(...)
	self:parsePosInfo()
	self:setLimitIndex()
end

function ClimbTowerObject:onModelLoadedEnd(modelInsId, modelResID)
	local go = self.entityModel.modelGameObject

	self.modelLoaded = true

	self.entityModel:setModelLayer(Const.LAYER_NPC)
	self.dragController:SetLodGroup(go, -1)
	self:setModelPos(go, false)
	self:showModel()
end

function ClimbTowerObject:setChoosing(...)
	if self.initData.isNewPut == true then
		self:setClick()

		self.initData.isNewPut = nil
	elseif self.initData.isNewDrag == true then
		self:setClick()
		self:setDragBegin()

		self.initData.isNewDrag = nil
	end
end

function ClimbTowerObject:setClick()
	if self.dragController then
		self.dragController:SetClick()
	end
end

function ClimbTowerObject:setDragBegin(...)
	if self.dragController then
		self.isClick = true

		self.dragController:SetDragBegin()
	end
end

function ClimbTowerObject:clearDragState(...)
	self:resetChoosingPos()

	self.isClick = false
end

function ClimbTowerObject:setModelPos(go)
	self:setRotation(self.initData.angleY or 0)

	local xOffset, yOffset = self:getConfigOffset()

	go.transform.localPosition = Vector3(xOffset, yOffset, 0)
end

function ClimbTowerObject:setRotation(angle)
	if self._modelsTransform then
		local originAngle = self._modelsTransform.localEulerAngles

		self.angle = angle
		self._modelsTransform.localEulerAngles = Vector3(originAngle.x, angle, originAngle.z)
	end
end

function ClimbTowerObject:getConfigOffset(...)
	local x = (self.boundsInfo.right * 0.5 - self.configPosOffset.x) * self.mParent.gridSize
	local y = (self.boundsInfo.down * 0.5 - self.configPosOffset.y) * self.mParent.gridSize

	return x, y
end

function ClimbTowerObject:parsePosInfo()
	self.range = Vector2(2, 2)
	self.rangeData = self.modelData.rangeData
	self.posData = self.modelData.posData
	self.configPosOffset = self.modelData.configPosOffset
	self.objAvalibleNum = self.modelData.avalibleNum

	self.dragController:InitBackPlanes(#self.posData)

	local gridBackOffset = -0.001

	if self.type == 2 then
		gridBackOffset = -0.009
	end

	local layer = self.modelData.typeInfo.offset

	self.boundsInfo = self.modelData.boundsInfo
	self.initZ = layer

	self:createBackPlane(gridBackOffset)
end

function ClimbTowerObject:createBackPlane(gridBackOffset)
	if #self.rangeData > 0 and #self.posData > 0 then
		local xOffset = self.boundsInfo.right * 0.5
		local yOffset = self.boundsInfo.down * 0.5
		local size = self.mParent.gridSize

		self.range = Vector2(self.boundsInfo.right, self.boundsInfo.down)

		local pos, leftUpPos

		for idx, vec in ipairs(self.rangeData) do
			leftUpPos = self.posData[idx]
			pos = leftUpPos + vec * 0.5

			self:setBackSize(vec, idx - 1)
			self.dragController:SetBackPlaneLocalPostion(Vector3((-pos.x + xOffset) * size, (-pos.y + yOffset) * size, -self.initZ + gridBackOffset), idx - 1)
		end
	end
end

function ClimbTowerObject:resetPos(initData)
	self:setGridIndex(initData.pos, true)
end

function ClimbTowerObject:setLimitIndex(...)
	local minRow, maxRow, minCol, maxCol

	if self.dragController then
		maxRow = self.mParent.rows - self.range.y + 1
		maxCol = self.mParent.columns - self.range.x + 1
		self.limitBounds = {
			minCol = 1,
			upOffset = 0,
			minRow = 1,
			maxRow = maxRow,
			maxCol = maxCol,
			rightOffset = self.range.x - 1,
			downOffset = self.range.y - 1
		}
	end
end

local commonLimitBounds = {}

function ClimbTowerObject:_getLimitBounds(...)
	if self.limitBounds == nil then
		self:setLimitIndex()
	end

	for k, v in pairs(self.limitBounds) do
		commonLimitBounds[k] = v
	end

	commonLimitBounds.minRow = self.limitBounds.minRow

	return commonLimitBounds
end

function ClimbTowerObject:setPos(pos)
	local _pos = -self.mParent.dragModelRoot.position + pos

	_pos.z = self.initZ
	self._transform.localPosition = _pos
end

function ClimbTowerObject:_moveTo(endPos, moveTime, callback)
	local startPos = self:getPosition()
	local speedDir = endPos - startPos
	local len = speedDir:Magnitude()

	if self.coMove then
		coroutine.stop(self.coMove)
	end

	self.coMove = coroutine.start(self.stopMove, self, moveTime, endPos)
	speedDir = Vector3.Normalize(speedDir) * (len / moveTime)

	if speedDir then
		if self.movementAux == nil then
			self:addMovementAux()
		end

		self.movementAux:startMoving(speedDir.x, speedDir.y, 0, moveTime)
	end
end

function ClimbTowerObject:stopMove(moveTime, endPos)
	coroutine.wait(moveTime)

	if self.coMove then
		coroutine.stop(self.coMove)

		self.coMove = nil
	end

	self:setPos(endPos)
end

function ClimbTowerObject:isInLimitBounds(rowIdx, colIdx)
	local preRowIdx, preColIdx = self.mParent:gridIdxToRowColumn(self.gridPos)

	if preRowIdx == rowIdx and colIdx == preColIdx then
		return -1
	end

	local row = rowIdx
	local col = colIdx
	local _limitBounds = self:_getLimitBounds()

	row = math.min(math.max(_limitBounds.minRow, row), _limitBounds.maxRow)
	col = math.min(math.max(_limitBounds.minCol, col), _limitBounds.maxCol)

	return self.mParent:rowColToGridIdx(row, col)
end

function ClimbTowerObject:setBackSize(range, index)
	if self.dragController then
		local size = self.mParent.gridSize

		self.dragController:SetBackSize(size * range.x, size * range.y, index or 0)
		self.dragController:SetBackTexTureScale(range, index or 0)
	end
end

function ClimbTowerObject:put2Pos()
	self.dragController = UIUtils.SetRearHouseDragTarget(self, self.did)
	self.dragController.layer = self.layer
	self.topNode = self.dragController:GetTopNodeTransform()
	self.controller = self.dragController:GetController()
	self._transform = self.controller.transform
	self._modelsTransform = self.dragController.models.transform

	if self.initData.initWall == true then
		self.oriParentTra = self.mParent.staticModelRoot
		self._transform.parent = self.mParent.staticModelRoot
	else
		self.oriParentTra = self.mParent.dragModelRoot
		self._transform.parent = self.mParent.dragModelRoot
	end

	self.dragController.zoneName = self.mParent.zoneName
end

function ClimbTowerObject:showPlane(v, color)
	if self.isDelete == true or not self.dragController then
		return
	end

	if self.planeVisible ~= v then
		self.planeVisible = v

		self.dragController:ShowPlane(v)
	end

	if not v then
		return
	end

	color = (self.isClick or self.isDraging) and "choose_" .. color or color

	if self.color == color then
		return
	end

	self.color = color

	self.dragController:SetBackColor(COLOR_MODE[color])
end

function ClimbTowerObject:setModelMovePos(pos, isLocal)
	if self.dragController then
		pos = pos or self._transform.position

		if isLocal then
			self._modelsTransform.localPosition = pos
		else
			self._modelsTransform.position = pos
		end
	end
end

function ClimbTowerObject:isInArea(gridIdx)
	local row, col = self.mParent:gridIdxToRowColumn(gridIdx)
	local myRow, myCol = self.mParent:gridIdxToRowColumn(self.gridPos)
	local isMatchCol = false
	local padding = self.modelData.baseInfo.padding or DEFAULT_PADDING

	if row >= myRow - padding[1] and row <= myRow + self.boundsInfo.down + padding[2] - 1 and col >= myCol - padding[3] and col <= myCol + self.boundsInfo.right + padding[4] - 1 then
		return true
	end

	return false
end

function ClimbTowerObject:setGridIndex(index, isPosition, isTeleport)
	if index == nil then
		return
	end

	if isPosition then
		local pos = self.mParent:gridIdxToPos(index, self.range)

		if isTeleport then
			self:_moveTo(pos, 0.5)
		else
			self:setPos(pos)
		end
	end

	self.gridPos = index
end

function ClimbTowerObject:setSelectState(...)
	if self.mParent:getCurDragObj() ~= self then
		self.mParent:setCurDragObj(self)
	end
end

function ClimbTowerObject:checkDragPos(pos)
	if self.initData.pos == nil then
		local r, c = self.mParent:posToRowCol(pos)

		r = r - math.floor(self.boundsInfo.down * 0.5)
		c = c - math.floor(self.boundsInfo.right * 0.5)

		local gridIndex

		if c <= 0 or r <= 0 then
			gridIndex = self:isInLimitBounds(r, c)
		else
			gridIndex = self.mParent:rowColToGridIdx(r, c)
		end

		self:setGridIndex(gridIndex, true)

		self.initData.pos = gridIndex
	end
end

function ClimbTowerObject:OnClick(pos)
	if self.isClick ~= true then
		self:checkDragPos(pos)

		self.isClick = true
		self.topNode.localPosition = Vector3(0, 0, Z_OFFSET)
	end

	local r, c = self.mParent:gridIdxToRowColumn(self.gridPos)
end

function ClimbTowerObject:onDragPut(isSure)
	self._modelsTransform.parent = self.dragController.TopModel.transform
	self.isDraging = false

	self:setModelMovePos(Vector3.zero, true)
	self.mParent:checkPosIsRight()

	if isSure == true then
		self:resetChoosingPos()
	end
end

function ClimbTowerObject:resetChoosingPos(...)
	if self.isClick == true then
		self.topNode.localPosition = Vector3.zero
	end
end

function ClimbTowerObject:OnDragBegin(hitPos)
	self._modelsTransform.parent = nil
	self.oldGridPos = self.gridPos

	self:setGridOffset(hitPos)
	self.mParent:setDraging()

	self.isDraging = true
end

function ClimbTowerObject:setGridOffset(hitPos)
	local row, col = self.mParent:gridIdxToRowColumn(self.gridPos)
	local hitRow, hitCol = self.mParent:gridIdxToRowColumn(self.mParent:posToGridIndex(hitPos))

	self.gridIndexOffset = {
		rowOffset = hitRow - row,
		colOffset = hitCol - col
	}
	self.posOffset = self._modelsTransform.position - hitPos
end

function ClimbTowerObject:onDel(...)
	self:destroy()
end

function ClimbTowerObject:_createModel()
	if self.type == 5 then
		local modelData = self:getHeroModelData(self.modelData, false)

		self.entityModel = Model(Slot(self.onModelLoadedEnd, self))

		self.entityModel:setModelData(modelData)
		self.entityModel:loadGameObject(false, self.initData.show)
	else
		self.entityModel = Model(Slot(self.onModelLoadedEnd, self))

		self.entityModel:setModelDataSimple(self.modelData.baseInfo.path)
		self.entityModel:loadGameObject(false, self.initData.show)
	end
end

function ClimbTowerObject:playActionById(actionId)
	self.actionData = ResModelActionConfig[actionId]

	if not self.modelLoaded then
		return
	end

	self:playActionData()
end

function ClimbTowerObject:playActionData(fromInit)
	if self.coPlayAction then
		coroutine.stop(self.coPlayAction)

		self.coPlayAction = nil
	end

	if self.actionData then
		self.coPlayAction = coroutine.start(self.coPlayActionData, self, fromInit)
	end
end

function ClimbTowerObject:coPlayActionData(fromInit)
	if fromInit then
		coroutine.wait(0)
	end

	self.entityModel:showModel(true)
	self:playAnimator(self.actionData.anim_name)

	local curFrame = 0

	if self.actionData.anim_event_list and #self.actionData.anim_event_list > 0 then
		for index = 1, #self.actionData.anim_event_list, 2 do
			local needFrame = tonumber(self.actionData.anim_event_list[index])
			local cueId = tonumber(self.actionData.anim_event_list[index + 1])

			if needFrame and cueId then
				if needFrame <= curFrame then
					CueManager.playCue(self, cueId)
				else
					coroutine.wait((needFrame - curFrame) / 30)

					curFrame = needFrame

					CueManager.playCue(self, cueId)
				end
			end
		end
	end
end

return ClimbTowerObject
