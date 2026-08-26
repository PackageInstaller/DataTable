-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/entity/TeamChessSoldierUnit.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessSoldierUnit", package.seeall)

local TeamChessSoldierUnit = class("TeamChessSoldierUnit", TeamChessUnitEntityBase)
local UnityEngine_Input = UnityEngine.Input

function TeamChessSoldierUnit:refreshTransform(tr, unitParentPosition, needPlayOutAndIn)
	self._lastTr = self._tr
	self._tr = tr
	self._unitParentPosition = unitParentPosition

	self:updatePosByTr()
	self:refreshShowModeState()
end

function TeamChessSoldierUnit:getPosByTr()
	if self._tr == nil then
		return 0, 0, 0
	end

	local uiCanvas = EliminateTeamChessModel.instance:getViewCanvas()
	local screenX, screenY = recthelper.uiPosToScreenPos2(self._tr, uiCanvas)
	local posX, posY, posZ = recthelper.screenPosToWorldPos3(Vector2(screenX, screenY), nil, self._unitParentPosition)

	return posX, posY, posZ
end

function TeamChessSoldierUnit:updatePosByTr()
	local posX, posY, posZ = self:getPosByTr()

	self:updatePos(posX, posY, posZ)

	if self._lastTr == nil or self._lastTr ~= self._tr then
		self:playAnimator("in")
	end
end

function TeamChessSoldierUnit:movePosByTr()
	local posX, posY, posZ = self:getPosByTr()

	self:moveToPos(posX, posY, posZ)
end

function TeamChessSoldierUnit:moveToPosByTargetTr(targetTr, rectWidth, rectHeight)
	if targetTr == nil then
		return
	end

	local x, y, z = self:getPosXYZ()

	if self._unitMo.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		x = x + EliminateTeamChessEnum.chessMoveOffsetX
		y = y + EliminateTeamChessEnum.chessMoveOffsetY
	end

	if self._unitMo.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		x = x - EliminateTeamChessEnum.chessMoveOffsetX
		y = y - EliminateTeamChessEnum.chessMoveOffsetY
	end

	self:moveToPos(x, y, z)
end

function TeamChessSoldierUnit:_onResLoaded()
	TeamChessSoldierUnit.super._onResLoaded(self)

	if self._resGo.transform.childCount ~= 6 then
		logError("TeamChessSoldierUnit:_onResLoaded() childCount ~= 6, resName: " .. self._resGo.name)
	end

	local count = self._resGo.transform.childCount

	for i = 1, count do
		local child = self._resGo.transform:GetChild(i - 1).gameObject

		if not gohelper.isNil(child) then
			local childName = child.name

			if GameUtil.endsWith(childName, "1") then
				self._frontGo = child
			end

			if GameUtil.endsWith(childName, "2") then
				self._backGo = child
			end

			if GameUtil.endsWith(childName, "1_outline") then
				self._frontOutLineGo = child
			end

			if GameUtil.endsWith(childName, "2_outline") then
				self._backOutLineGo = child
			end

			if GameUtil.endsWith(childName, "1_grayscale") then
				self._frontGrayGo = child
			end

			if GameUtil.endsWith(childName, "2_grayscale") then
				self._backGrayGo = child
			end
		end
	end

	if not gohelper.isNil(self._frontGo) and not gohelper.isNil(self._backGo) then
		gohelper.setActive(self._frontGo, false)
		gohelper.setActive(self._backGo, false)
	end

	if not gohelper.isNil(self._frontOutLineGo) and not gohelper.isNil(self._backOutLineGo) then
		gohelper.setActive(self._frontOutLineGo, false)
		gohelper.setActive(self._backOutLineGo, false)
	end

	if not gohelper.isNil(self._frontGrayGo) and not gohelper.isNil(self._backGrayGo) then
		gohelper.setActive(self._frontGrayGo, false)
		gohelper.setActive(self._backGrayGo, false)
	end

	self.ani = self._resGo:GetComponent(typeof(UnityEngine.Animator))
	self._goClick = ZProj.BoxColliderClickListener.Get(self._resGo)

	self._goClick:SetIgnoreUI(true)
	self._goClick:AddMouseUpListener(self._onMouseUp, self)
	self._goClick:AddDragListener(self._onDrag, self)

	self._isDrag = false

	transformhelper.setLocalPos(self._resGo.transform, 0, 0.4, 0)
	self:setShowModeType(EliminateTeamChessEnum.ModeType.Normal)
end

function TeamChessSoldierUnit:setOutlineActive(active)
	self:playAnimator(active and "select" or "idle")
end

function TeamChessSoldierUnit:setGrayActive(active)
	self:playAnimator(active and "gray" or "idle")
end

function TeamChessSoldierUnit:setActive(active)
	gohelper.setActive(self._resGo, active)
end

function TeamChessSoldierUnit:setNormalActive(active)
	self:playAnimator("idle")
end

function TeamChessSoldierUnit:setShowModeType(modelType)
	if gohelper.isNil(self._resGo) then
		return
	end

	if self._lastModelType ~= nil and self._lastModelType == modelType then
		return
	end

	self._lastModelType = modelType

	local isShowOutLine = false
	local isShowGray = false
	local isShowNormal = false
	local name = "idle"

	if modelType ~= nil then
		if modelType == EliminateTeamChessEnum.ModeType.Gray then
			isShowGray = true
			name = "gray"
		end

		if modelType == EliminateTeamChessEnum.ModeType.Normal then
			isShowNormal = true
			name = "idle"
		end

		if modelType == EliminateTeamChessEnum.ModeType.Outline then
			isShowOutLine = true
			name = "select"
		end

		self._modeType = modelType
	end

	self:setNormalActive(isShowNormal)
	self:setOutlineActive(isShowOutLine)
	self:setGrayActive(isShowGray)
	self:playAnimator(name)
end

function TeamChessSoldierUnit:getShowModeType()
	return self._modeType
end

function TeamChessSoldierUnit:cacheModel()
	self.cacheModelType = self:getShowModeType()
end

function TeamChessSoldierUnit:restoreModel()
	if self.cacheModelType == nil then
		return
	end

	self:setShowModeType(self.cacheModelType)
end

function TeamChessSoldierUnit:setActiveAndPlayAni(active)
	self:setActive(active)

	if active then
		self:playAnimator("fadein")
	else
		self:playAnimator("fadeout")
	end
end

function TeamChessSoldierUnit:playAnimator(name)
	if self.ani then
		self.ani:Play(name, 0, 0)
	end
end

function TeamChessSoldierUnit:_onMouseUp()
	local pos = UnityEngine.Input.mousePosition

	if not self:_needResponseClick(pos) then
		return
	end

	if self._isDrag then
		self:_dragEnd()

		return
	end

	self:_onClick()
end

function TeamChessSoldierUnit:_onDrag()
	if EliminateTeamChessModel.instance:getTeamChessSkillState() then
		return
	end

	local pos = UnityEngine.Input.mousePosition

	if not self:_needResponseClick(pos) then
		return
	end

	if not self._canDrag or self._unitMo == nil then
		return
	end

	if not self._isDrag and (UnityEngine_Input.GetAxis("Mouse X") ~= 0 or UnityEngine_Input.GetAxis("Mouse Y") ~= 0) then
		self._isDrag = true
	end

	if not self._isDrag then
		return
	end

	local pos = UnityEngine.Input.mousePosition

	self:onDrag(pos.x, pos.y)
end

function TeamChessSoldierUnit:_onClick()
	local pos = UnityEngine.Input.mousePosition

	if not self:_needResponseClick(pos) then
		return
	end

	if not self._canClick or self._unitMo == nil then
		return
	end

	self:onClick()
end

function TeamChessSoldierUnit:_needResponseClick(position)
	if self._pointerEventData == nil then
		self._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		self._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
		self._uiRootGO = EliminateTeamChessModel.instance:getTipViewParent()
	end

	self._pointerEventData.position = position

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(self._pointerEventData, self._raycastResults)

	local iter = self._raycastResults:GetEnumerator()

	while iter:MoveNext() do
		local raycastResult = iter.Current
		local raycaster = raycastResult.module

		if self:_isRaycaster2d(raycaster, raycastResult.gameObject) then
			return false
		end
	end

	return true
end

local Ray2dList = {
	"#btn_click_2",
	"#btn_click",
	"#btn_mask"
}

function TeamChessSoldierUnit:_isRaycaster2d(raycaster, go)
	for i = 1, #Ray2dList do
		local ray2d = Ray2dList[i]

		if go.name == ray2d then
			return true
		end
	end

	local raycasterGO = raycaster.gameObject

	return (raycasterGO.transform:IsChildOf(self._uiRootGO.transform))
end

function TeamChessSoldierUnit:_dragEnd()
	if self._unitMo == nil then
		return
	end

	self._isDrag = false

	local pos = UnityEngine.Input.mousePosition

	self:onDragEnd(pos.x, pos.y)
end

function TeamChessSoldierUnit:onDrag(x, y)
	return
end

function TeamChessSoldierUnit:onDragEnd(x, y)
	return
end

function TeamChessSoldierUnit:onClick()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)

	local strongholdId = self._unitMo.stronghold
	local uid = self._unitMo.uid
	local soldierId = self._unitMo.soldierId
	local type = EliminateTeamChessEnum.ChessTipType.showDesc
	local offsetData

	if self._unitMo.teamType ~= EliminateTeamChessEnum.TeamChessTeamType.enemy then
		type = EliminateTeamChessEnum.ChessTipType.showSell
	else
		offsetData = {
			soliderTipOffsetX = EliminateTeamChessEnum.soliderSellTipOffsetX,
			soliderTipOffsetY = -EliminateTeamChessEnum.soliderSellTipOffsetY
		}
	end

	if not EliminateLevelModel.instance:sellChessIsUnLock() or EliminateLevelModel.instance:getIsWatchTeamChess() then
		type = EliminateTeamChessEnum.ChessTipType.showDesc

		if self._unitMo.teamType ~= EliminateTeamChessEnum.TeamChessTeamType.enemy then
			offsetData = {
				soliderTipOffsetX = EliminateTeamChessEnum.playerSoliderWatchTipOffsetX,
				soliderTipOffsetY = EliminateTeamChessEnum.playerSoliderWatchTipOffsetY
			}
		end
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.SoliderChessModelClick, soldierId, uid, strongholdId, type, self, offsetData)
end

function TeamChessSoldierUnit:setAllMeshRenderOrderInLayer(order)
	if not gohelper.isNil(self._frontGo) then
		self._frontGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = order
	end

	if not gohelper.isNil(self._backGo) then
		self._backGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = order
	end

	if not gohelper.isNil(self._frontOutLineGo) then
		self._frontOutLineGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = order
	end

	if not gohelper.isNil(self._backOutLineGo) then
		self._backOutLineGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = order
	end

	if not gohelper.isNil(self._frontGrayGo) then
		self._frontGrayGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = order
	end

	if not gohelper.isNil(self._backGrayGo) then
		self._backGrayGo.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = order
	end
end

function TeamChessSoldierUnit:dispose()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_enemy_move)

	if self._unitMo ~= nil and self._unitMo.uid == EliminateTeamChessEnum.tempPieceUid then
		self:onDestroy()
	else
		self:playAnimator("out")
		TaskDispatcher.runDelay(self.onDestroy, self, 0.33)
	end
end

function TeamChessSoldierUnit:refreshShowModeState()
	self:setShowModeType((self._unitMo ~= nil and self._unitMo:canActiveMove() or nil) and EliminateTeamChessEnum.ModeType.Outline)
end

function TeamChessSoldierUnit:refreshMeshOrder()
	if self._unitMo ~= nil then
		self:setAllMeshRenderOrderInLayer(self._unitMo:getOrder())
	end
end

function TeamChessSoldierUnit:onDestroy()
	if self._goClick then
		self._goClick:RemoveMouseUpListener()
		self._goClick:RemoveDragListener()

		self._goClick = nil
	end

	self._pointerEventData = nil
	self._raycastResults = nil
	self._uiRootGO = nil
	self._frontGo = nil
	self._backGo = nil
	self._frontOutLineGo = nil
	self._backOutLineGo = nil
	self._frontGrayGo = nil
	self._backGrayGo = nil
	self._tr = nil
	self._unitParentPosition = nil

	TaskDispatcher.cancelTask(self.onDestroy, self)
	TaskDispatcher.cancelTask(self.setActiveByCache, self)
	TeamChessSoldierUnit.super.onDestroy(self)
end

return TeamChessSoldierUnit
