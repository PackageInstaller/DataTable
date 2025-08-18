-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/EliminateGame\\EliminateObject.lua

local UIUtils = require("Framework.UI.UIUtils")
local Model = require("Entity/Model")
local EntityFactory = Framework.Entity.EntityFactory
local Entity = require("Entity/Entity")
local BattleLogo = require("UI/Control/Logo/BattleLogo")
local ResColor = require("ClientData/ResColor")
local ResEliminateModel = require("ClientData/ResEliminateModel")
local ResEliminateItem = require("ClientData/ResEliminateItem")
local ResModelActionConfig = require("ClientData/ResModelActionConfig")
local ModelTool = require("Entity/ModelTool")
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
local EliminateObject = Class("EliminateObject", Entity)

EliminateObject._curID = START_ENTITY_ID

function EliminateObject:ctor(entityId, entityName, parent, putData, initData, camp)
	self.mParent = parent
	self.did = EliminateObject._curID
	EliminateObject._curID = self.did + 1
	self.initData = initData
	self.gridPos = 0
	self.putData = putData
	self.data = putData.data
	self.modelData = self.data.modelData
	self.modelId = self.data.modelId
	self.zoneName = self.modelData.baseInfo.zone_name
	self.layer = self.data.modelData.typeInfo.layer_id or 99
	self.type = self.data.modelData.typeInfo.type_id
	self.isDelete = false
	self.status = self.initData.status or 0
	self.statusArg = self.initData.statusArg or 0
	self.offsetY = self.initData.offsetY or 0
	self.scale = self.initData.scale or 1
	self.curShelfIndex = self.initData.shelfIndex
	self.curPosIndex = self.initData.posIndex
	self.resData = self.initData.resData
end

function EliminateObject:loadModel(isCompose, callBack)
	if isCompose then
		self:setComposeData()

		self.isCompose = isCompose
		self.callBack = callBack
	end

	self:put2Pos()
	self.dragController:InitBackPlanes(0)
	self:createModel(self.modelData)

	if self.status == Const.ELIMINATE_STATUS_TYPE_BOOM and self.type == Const.REARHOUSE_TYPE_PARTS then
		self:initLogo()
	end
end

function EliminateObject:setComposeData()
	local resData = ResEliminateModel[self.modelId]

	if not resData then
		return
	end

	self.scale = resData.compose_scale
	self.offsetY = resData.compose_offset
end

function EliminateObject:getHeroId()
	return ResEliminateModel[self.modelId].hero_id
end

function EliminateObject:destroy()
	self.isDelete = true

	if self.entityModel then
		self.entityModel:destroy()

		self.entityModel = nil
	end

	if self.entityModelHigh then
		self.entityModelHigh:destroy()

		self.entityModelHigh = nil
	end

	if self.chooseCueID then
		CueManager.releaseCue(self, self.chooseCueID, self.chooseInsId)

		self.chooseCueID = nil
	end

	if self.destoryCueID then
		CueManager.releaseCue(self, self.destoryCueID, self.destoryInsId)

		self.destoryCueID = nil
	end

	if self.finishCueID then
		CueManager.releaseCue(self, self.finishCueID, self.finishInsId)

		self.finishCueID = nil
	end

	if self.timer then
		self.timer:Stop()
	end

	if self.coAction then
		coroutine.stop(self.coAction)

		self.coAction = nil
	end

	if self.coDestoryAction then
		coroutine.stop(self.coDestoryAction)

		self.coDestoryAction = nil
	end

	if self.coPlayAction then
		coroutine.stop(self.coPlayAction)

		self.coPlayAction = nil
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
end

function EliminateObject:playShelfFinishEffect(cueId)
	if not cueId then
		-- block empty
	end

	if self.finishCueID then
		CueManager.releaseCue(self, self.finishCueID, self.finishInsId)

		self.finishCueID = nil
	end

	self.finishCueID = cueId
	self.finishInsId = CueManager.playCue(self, self.finishCueID)
end

function EliminateObject:playDestoryEffect()
	local resData = ResEliminateModel[self.modelId]

	if not resData then
		self:endDestoryEffect(0)

		return
	end

	if self.destoryCueID then
		CueManager.releaseCue(self, self.destoryCueID, self.destoryInsId)

		self.destoryCueID = nil
	end

	self.destoryCueID = resData.destroy_cue_id

	if self.destoryCueID then
		self.destoryInsId = CueManager.playCue(self, self.destoryCueID)
	end

	local time = resData.destroy_time or 0.5

	self.coDestory = coroutine.start(self.endDestoryEffect, self, time)
end

function EliminateObject:endDestoryEffect(time)
	coroutine.wait(time)

	if self.coDestory then
		coroutine.stop(self.coDestory)

		self.coDestory = nil
	end

	if self.callBack then
		self.callBack()
	end

	self:setVisible(false)
end

function EliminateObject:playChooseEffect()
	local resData = ResEliminateModel[self.modelId]

	if not resData then
		return
	end

	if self.chooseCueID then
		CueManager.releaseCue(self, self.chooseCueID, self.chooseInsId)

		self.chooseCueID = nil
	end

	self.chooseCueID = resData.choose_cue_id

	if self.chooseCueID then
		self.chooseInsId = CueManager.playCue(self, self.chooseCueID)
	end
end

function EliminateObject:playComposeAction()
	local resData = ResEliminateModel[self.modelId]

	if not resData then
		self:endAction(0)

		return
	end

	local actionId = resData.compose_action_id
	local actionTime = resData.show_time or 0

	self:playActionById(actionId)

	self.coAction = coroutine.start(self.endAction, self, actionTime)
end

function EliminateObject:endAction(time)
	coroutine.wait(time)

	if self.coAction then
		coroutine.stop(self.coAction)

		self.coAction = nil
	end

	if self.callBack then
		self.callBack()
	end

	self:destroy()
end

function EliminateObject:playItemDestoryAction(callBack)
	local resData = self.initData.resData

	if not resData then
		self:endDestoryAction(0, callBack)

		return
	end

	local actionId = resData.action_id
	local actionTime = resData.show_time

	self:playActionById(actionId)

	self.coDestoryAction = coroutine.start(self.endDestoryAction, self, actionTime, callBack)
end

function EliminateObject:endDestoryAction(time, callBack)
	coroutine.wait(time)

	if self.coDestoryAction then
		coroutine.stop(self.coDestoryAction)

		self.coDestoryAction = nil
	end

	self:destroy()

	if callBack then
		callBack()
	end
end

function EliminateObject:showModel(...)
	if self.entityModel then
		self.entityModel:setScale(self.scale)
		self.entityModel:showModel(true)

		if self.isCompose then
			self:playComposeAction()
		end
	end
end

function EliminateObject:initLogo()
	if self.logo == nil then
		self.logo = BattleLogo(self.controller, "System/MiniGame/BattleBloodMiniGamePanel", 0, 0, self)

		local text = 0
		local color = ResColor.QUALITYGREEN

		if self.status == Const.ELIMINATE_STATUS_TYPE_BOOM then
			text = self.statusArg
			color = ResColor.RED
		elseif self.status == Const.ELIMINATE_STATUS_TYPE_KEY then
			text = "key" .. self.statusArg
		elseif self.status == Const.ELIMINATE_STATUS_TYPE_LOCK then
			text = "LOCK" .. self.statusArg
		end

		self.logo.textHp:setText(text)
		self.logo.textHp:setFontColor(color)
		self.logo.textHp:setFontSize(30)

		local pos = self.logo.textHp:getPosition()

		self.logo.textHp:setPosition(pos.x + 75, pos.y - 50)
		self.logo.textHpPer:setVisible(false)
		self.logo.imgBg:setVisible(false)
		self.logo.sliderHp:setVisible(false)
		self.logo.sliderHpPre:setVisible(false)
		self.logo.uiPower:setVisible(false)
		self.logo:setHide(true)
		self.logo.panelInfo:setVisible(true)
	end
end

function EliminateObject:hideLogo()
	if self.logo then
		self.logo:setHide(true)
	end
end

function EliminateObject:setHideLogo(v)
	if self.logo then
		self.logo:setHide(v)
	end
end

function EliminateObject:refreshNumInfo(text)
	text = text or self.statuArg

	if self.logo then
		self.logo.textHp:setText(text)
	end
end

function EliminateObject:postInit(...)
	self:parsePosInfo()
	self:setLimitIndex()
end

function EliminateObject:onModelLoadedEnd()
	local go = self.entityModel.modelGameObject

	self.modelLoaded = true

	self.entityModel:setModelLayer(Const.LAYER_NPC)
	self.dragController:SetLodGroup(go, -1)
	self:setModelPos()
	self:showModel()
end

function EliminateObject:setClick()
	if self.dragController then
		self.dragController:SetClick()
	end
end

function EliminateObject:setModelPos(go)
	local go = go or self.entityModel.modelGameObject

	self:setRotation(self.initData.angleY or 0)

	if self.isCompose then
		local pos = self:getComposeConfigOffset()

		self._transform.parent = nil
		go.transform.localPosition = Vector3(0, 0, 0)
		self._transform.localPosition = pos
	else
		local offsetPos = self:getConfigOffset()

		go.transform.localPosition = offsetPos
	end
end

function EliminateObject:setRotation(angle)
	if self._modelsTransform then
		local originAngle = self._modelsTransform.localEulerAngles

		self.angle = angle
		self._modelsTransform.localEulerAngles = Vector3(originAngle.x, angle, originAngle.z)
	end
end

function EliminateObject:getConfigOffset(...)
	return Vector3(0, self.offsetY, 0)
end

function EliminateObject:getComposeConfigOffset(...)
	local resData = ResEliminateModel[self.modelId]

	if not resData then
		return Vector3(0, 0, 0)
	end

	local posData = resData.compose_offset

	return Vector3(posData[1] or 0, posData[2] or 0, posData[3] or 0)
end

function EliminateObject:parsePosInfo()
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

function EliminateObject:createBackPlane(gridBackOffset)
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

function EliminateObject:setLimitIndex(...)
	local minRow, maxRow, minCol, maxCol

	if self.dragController then
		maxRow = self.mParent.limitRows - self.range.y + 1
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

function EliminateObject:_getLimitBounds(...)
	if self.limitBounds == nil then
		self:setLimitIndex()
	end

	for k, v in pairs(self.limitBounds) do
		commonLimitBounds[k] = v
	end

	commonLimitBounds.minRow = self.limitBounds.minRow

	return commonLimitBounds
end

function EliminateObject:modelMoveToPos(newPos, newParent, time)
	local oldPos = self:getScenePos()

	self._transform.parent = nil

	local firstNewPos = Vector3((oldPos.x + newPos.x) / 2, 30, newPos.z)

	local function callBack()
		local function callback2()
			if newParent then
				self:setParentTra(newParent.transform)
			end
		end

		self:_moveTo(newPos, time / 2, callback2)
	end

	self:_moveTo(firstNewPos, time / 2, callBack)
end

function EliminateObject:moveToPos(newPos, newParent, time)
	self._transform.parent = nil

	local function callback()
		if newParent then
			self:setParentTra(newParent.transform)
		end
	end

	self:_moveTo(newPos, time, callback)
end

function EliminateObject:_moveTo(endPos, moveTime, callback)
	local startPos = self:getPosition()
	local speedDir = endPos - startPos
	local len = speedDir:Magnitude()

	if self.coMove then
		coroutine.stop(self.coMove)
	end

	self.coMove = coroutine.start(self.stopMove, self, moveTime, endPos, callback)
	speedDir = Vector3.Normalize(speedDir) * (len / moveTime)

	if speedDir then
		if self.movementAux == nil then
			self:addMovementAux()
		end

		self.movementAux:startMoving(speedDir.x, speedDir.y, 0, moveTime)
	end
end

function EliminateObject:stopMove(moveTime, endPos, callback)
	coroutine.wait(moveTime)

	if self.coMove then
		coroutine.stop(self.coMove)

		self.coMove = nil
	end

	if callback then
		callback()
	end
end

function EliminateObject:setBackSize(range, index)
	if self.dragController then
		local size = self.mParent.gridSize

		self.dragController:SetBackSize(size * range.x, size * range.y, index or 0)
		self.dragController:SetBackTexTureScale(range, index or 0)
	end
end

function EliminateObject:getPutParentTra()
	if self.type == Const.REARHOUSE_TYPE_SHELF then
		local shelfIndex = self.initData.shelfIndex
		local node = self.mParent:getShelfNode(shelfIndex)

		if node then
			return node.transform
		end
	else
		local shelfIndex = self.initData.shelfIndex
		local index = self.initData.posIndex
		local node = self.mParent:getShelfLayerNode(shelfIndex, index)

		if node then
			return node.transform
		end
	end

	return self.controller.transform
end

function EliminateObject:put2Pos()
	self.dragController = UIUtils.SetRearHouseDragTarget(self, self.did)
	self.dragController.layer = self.layer
	self.topNode = self.dragController:GetTopNodeTransform()
	self.controller = self.dragController:GetController()
	self._transform = self.controller.transform
	self._modelsTransform = self.dragController.models.transform

	self:setParentTra()

	self.dragController.zoneName = self.mParent.zoneName
end

function EliminateObject:setParentTra(tra)
	if self._transform then
		self.oriParentTra = tra or self:getPutParentTra()
		self._transform.parent = self.oriParentTra
		self._transform.localPosition = Vector3(0, 0, 0)
	end
end

function EliminateObject:showPlane(v)
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

	self.dragController:SetBackColor(COLOR_MODE.choose_green)
end

function EliminateObject:setModelMovePos(pos, isLocal)
	if self.dragController then
		pos = pos or self._transform.position

		if isLocal then
			self._modelsTransform.localPosition = pos
		else
			self._modelsTransform.position = pos
		end
	end
end

function EliminateObject:isInArea(gridIdx, pos)
	return false
end

function EliminateObject:getScenePos()
	local pos = self.mParent:getPutPos(self.curShelfIndex, self.curPosIndex)

	return pos
end

function EliminateObject:setChooseState(...)
	self.isClick = true

	self:playChooseEffect()
end

function EliminateObject:clearChooseState(...)
	self.isClick = false

	if self.chooseCueID then
		CueManager.releaseCue(self, self.chooseCueID, self.chooseInsId)

		self.chooseCueID = nil
	end
end

function EliminateObject:getParentTra(...)
	if self.oriParentTra then
		return self.oriParentTra
	end
end

function EliminateObject:OnClick(pos)
	if self.isClick ~= true then
		self.isClick = true
	end
end

function EliminateObject:onDragPut(isSure)
	self._modelsTransform.parent = self.dragController.TopModel.transform
	self.isDraging = false

	self:setModelMovePos(Vector3.zero, true)
end

function EliminateObject:setOldGridPos()
	self.oldGridPos = self.gridPos
end

function EliminateObject:onDel(time)
	self:destroy()
end

function EliminateObject:_createModel()
	if self.type == Const.REARHOUSE_TYPE_HERO or self.type == Const.REARHOUSE_TYPE_PARTS then
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

function EliminateObject:getHeroModelData(info, high)
	local modelData = {}

	modelData.model_type = Const.MODEL_TYPE.RearHouse
	modelData.model_id = self.modelId

	if high then
		modelData.use_lod = Const.MODEL_LOD_LV1
	else
		modelData.use_lod = Const.MODEL_LOD_LV2
	end

	local animator = ModelTool.getControllerPathByType(self.modelId, Const.MODEL_TYPE.RearHouse)

	if animator then
		modelData.animator = animator
	end

	return modelData
end

function EliminateObject:playActionById(actionId)
	self.actionData = ResModelActionConfig[actionId]

	if not self.modelLoaded then
		return
	end

	self:playActionData()
end

function EliminateObject:playActionData(fromInit)
	if self.coPlayAction then
		coroutine.stop(self.coPlayAction)

		self.coPlayAction = nil
	end

	if self.actionData then
		self.coPlayAction = coroutine.start(self.coPlayActionData, self, fromInit)
	end
end

function EliminateObject:coPlayActionData(fromInit)
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

return EliminateObject
