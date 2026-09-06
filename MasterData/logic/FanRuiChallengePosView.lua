-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengePosView.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengePosView", package.seeall)

local FanRuiChallengePosView = class("FanRuiChallengePosView", ViewComponent)

function FanRuiChallengePosView:ctor()
	FanRuiChallengePosView.super.ctor(self)

	self._yPos = 80
	self._xHide = 400
	self._xShow = -112
end

function FanRuiChallengePosView:buildUI()
	FanRuiChallengePosView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._btnBuff = self:getBtn("moveNode/btnBuff")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._fmtParent = self:getGo("moveNode/fmt")
	self._cellList = {}

	local path = "moveNode/fmt/cell_%d"

	for i = 1, 9 do
		local cell = {}

		cell.go = self:getGo(string.format(path, i))
		cell.backBg = self:getGo(string.format(path .. "/backBg", i))
		cell.frontBg = self:getGo(string.format(path .. "/frontBg", i))
		cell.con = self:getGo(string.format(path .. "/con", i))
		cell.img = self:getGo(string.format(path .. "/img", i))
		cell.img.name = i

		cell.img.transform:SetParent(self._fmtParent.transform, true)
		BeginDragHandler.Get(cell.img):AddLuaHandler(function(_go, eventData)
			self:_onBeginDragCell(_go, eventData)
		end)
		DragHandler.Get(cell.img):AddLuaHandler(function(_go, eventData)
			self:_onDragingCell(_go, eventData)
		end)
		DropHandler.Get(cell.img):AddLuaHandler(function(_go, eventData)
			self:_onDropCell(_go, eventData)
		end)
		EndDragHandler.Get(cell.img):AddLuaHandler(function(_go, eventData)
			self:_onEndDragCell(_go, eventData)
		end)

		cell.btn = Framework.ButtonAdapter.Get(cell.img)

		goutil.setActive(cell.backBg, true)
		goutil.setActive(cell.frontBg, false)

		self._cellList[i] = cell
	end
end

function FanRuiChallengePosView:bindEvents()
	FanRuiChallengePosView.super.bindEvents(self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)

	for i, v in ipairs(self._cellList) do
		v.btn:AddClickListener(function()
			self:_onClickPet(i)
		end)
	end
end

function FanRuiChallengePosView:unbindEvents()
	FanRuiChallengePosView.super.unbindEvents(self)
	self._btnHide:RemoveClickListener()
	self._btnArrow:RemoveClickListener()
	self._btnBuff:RemoveClickListener()

	for i, v in ipairs(self._cellList) do
		v.btn:RemoveClickListener()
	end
end

function FanRuiChallengePosView:onEnter()
	FanRuiChallengePosView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo._activityId
	self._stageId = self._fmtMo._stageId
	self._childStageId = self._fmtMo._childStageId

	local cfgStage = FanRuiChallengeConfig.instance:getControlClgStageCfg(self._activityId, self._stageId)

	self._creepsMasterId = cfgStage.creepsMasterIds[self._childStageId]

	local cfgs = FanRuiChallengeConfig.instance:getCreepsCfgs(self._creepsMasterId)

	self._cfgCreeps = TableUtil.deepcopy(cfgs)

	self:_initPopupState()
	self:_initPetHeads()

	self._dragPointerId = nil
	self._dragingConGo = nil
	self._dragingIndex = nil
end

function FanRuiChallengePosView:onExit()
	FanRuiChallengePosView.super.onExit(self)
	self:_clearHeadIcon()
end

function FanRuiChallengePosView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xShow, self._yPos, 0), Vector3.New(self._xHide, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
		self:_refreshMissionView()
	end
end

function FanRuiChallengePosView:_onClickArrow()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xShow, self._yPos, 0), Vector3.New(self._xHide, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
		self:_refreshMissionView()
	else
		self._isPopupState = true

		goutil.setActive(self._btnHide.gameObject, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xHide, self._yPos, 0), Vector3.New(self._xShow, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

function FanRuiChallengePosView:_onClickBuff()
	UIStateManager.instance:push(ViewName.FanRuiChallengeForecastView, self._creepsMasterId)
end

function FanRuiChallengePosView:_onClickPet(index)
	printInfo("test FanRuiChallengePosView:_onClickPet", index)

	if self._dragPointerId == nil then
		local cfgEnemy = self:_isExistPetHead(index)

		if cfgEnemy then
			local cell = self._cellList[index]

			CommonTipsMgr.instance:openMaterialTips(cell.img, MatType.Pet, cfgEnemy.raceId)
		end
	end
end

function FanRuiChallengePosView:_onBeginDragCell(go, eventData)
	if self._dragingConGo then
		return
	end

	if self._dragPointerId then
		return
	end

	local index = checknumber(go.name)

	if not self:_isExistPetHead(index) then
		return
	end

	local cell = self._cellList[index]

	goutil.setActive(cell.frontBg, false)

	self._dragingConGo = cell.con

	self._dragingConGo.transform:SetParent(self._fmtParent.transform, true)

	self._dragPointerId = eventData.pointerId
	self._dragingIndex = index

	goutil.addComponentOnce(self._dragingConGo, typeof(UnityEngine.Canvas))

	self._scaleTween = self._dragingConGo.transform:DOScale(Vector3.New(1, 1, 1), 0.1)
end

function FanRuiChallengePosView:_onDragingCell(go, eventData)
	if not self._dragingConGo then
		return
	end

	if self._dragPointerId == nil or self._dragPointerId ~= eventData.pointerId then
		return
	end

	self._dragingConGo.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function FanRuiChallengePosView:_onDropCell(go, eventData)
	printInfo("test FanRuiChallengePosView:_onDropCell", go.name)

	if not self._dragingConGo then
		return
	end

	if not self._dragingIndex then
		return
	end

	if self._dragPointerId == nil or self._dragPointerId ~= eventData.pointerId then
		return
	end

	local endIndex = checknumber(go.name)

	if self._dragingIndex == endIndex then
		return
	end

	self:_swagPetPos(self._dragingIndex, endIndex)
end

function FanRuiChallengePosView:_onEndDragCell(go, eventData)
	printInfo("test FanRuiChallengePosView:_onEndDragCell", go.name)

	if not self._dragingConGo then
		return
	end

	if not self._dragingIndex then
		return
	end

	if self._dragPointerId == nil or self._dragPointerId ~= eventData.pointerId then
		return
	end

	local dragCell = self._cellList[self._dragingIndex]

	if dragCell.con.transform.parent == self._fmtParent.transform then
		dragCell.con.transform:SetParent(dragCell.go.transform)
		dragCell.con.transform:SetSiblingIndex(2)
	end

	if self._scaleTween then
		self._scaleTween:Kill()

		self._scaleTween = nil
	end

	self:_refreshConPos()

	self._dragPointerId = nil
	self._dragingConGo = nil
	self._dragingIndex = nil
end

function FanRuiChallengePosView:_swagPetPos(dragingPosIndex, endPosIndex)
	local dragingCell = self._cellList[dragingPosIndex]
	local endCell = self._cellList[endPosIndex]

	dragingCell.con.transform:SetParent(endCell.go.transform)
	endCell.con.transform:SetParent(dragingCell.go.transform)

	dragingCell.con = endCell.con
	endCell.con = dragingCell.con

	dragingCell.con.transform:SetSiblingIndex(2)
	endCell.con.transform:SetSiblingIndex(2)

	for i, cfgEnemy in ipairs(self._cfgCreeps) do
		if cfgEnemy.posId == dragingPosIndex then
			cfgEnemy.posId = endPosIndex
		elseif cfgEnemy.posId == endPosIndex then
			cfgEnemy.posId = dragingPosIndex
		end
	end
end

function FanRuiChallengePosView:_refreshConPos()
	for i, v in ipairs(self._cellList) do
		GameUtil.setAnchoredPos(v.con, 0, 0.22)
		GameUtil.setLocalScale(v.con, 0.8, 0.8, 0.8)
		goutil.setActive(v.frontBg, self:_isExistPetHead(i))

		local canvas = v.con:GetComponent(typeof(UnityEngine.Canvas))

		if not goutil.isNil(canvas) then
			goutil.destroy(canvas)
		end
	end
end

function FanRuiChallengePosView:_resetPetPos(dragingIndex)
	return
end

function FanRuiChallengePosView:_initPopupState()
	self._isPopupState = true

	goutil.setActive(self._btnHide.gameObject, true)
	Framework.TransformUtil.SetAnchoredPos(self._moveNode.transform, self._xShow, self._yPos)
	Framework.TransformUtil.SetLocalRotation(self._arrowRectTrans.transform, 0, 0, 0)
end

function FanRuiChallengePosView:_initPetHeads()
	self:_clearHeadIcon()

	for i, cfgEnemy in ipairs(self._cfgCreeps) do
		local cell = self._cellList[cfgEnemy.posId]

		if cell and cell.frontBg then
			goutil.setActive(cell.frontBg, true)
			GameUtil.setLocalScale(cell.con, 0.8, 0.8, 0.8)
			MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, cell.con)
		end
	end
end

function FanRuiChallengePosView:_clearHeadIcon()
	for i, v in ipairs(self._cellList) do
		MaterialMgr.resetAll(v.con)
		goutil.setActive(v.frontBg, false)
	end
end

function FanRuiChallengePosView:_isExistPetHead(posIndex)
	for i, cfgEnemy in ipairs(self._cfgCreeps) do
		if cfgEnemy.posId == posIndex then
			return cfgEnemy
		end
	end
end

function FanRuiChallengePosView:_refreshMissionView()
	GlobalDispatcher:dispatch(GlobalNotify.FanRuiControlUpdateEnemyFmt, self._cfgCreeps)
end

return FanRuiChallengePosView
