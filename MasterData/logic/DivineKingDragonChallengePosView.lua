-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/view/DivineKingDragonChallengePosView.lua

module("logic.extensions.divinekingdragonchallenge.view.DivineKingDragonChallengePosView", package.seeall)

local DivineKingDragonChallengePosView = class("DivineKingDragonChallengePosView", ViewComponent)

function DivineKingDragonChallengePosView:ctor()
	DivineKingDragonChallengePosView.super.ctor(self)

	self._yPos = 80
	self._xHide = 400
	self._xShow = -112
end

function DivineKingDragonChallengePosView:buildUI()
	DivineKingDragonChallengePosView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._btnBuff = self:getBtn("moveNode/btnBuff")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._fmtParent = self:getGo("moveNode/fmt")
	self._cellList = {}

	local children = GameUtil.getChildren(self._fmtParent)

	for i, mainGo in ipairs(children) do
		local cell = {}

		cell.go = mainGo
		cell.backBg = goutil.findChild(mainGo, "backBg")
		cell.frontBg = goutil.findChild(mainGo, "frontBg")
		cell.con = goutil.findChild(mainGo, "con")
		cell.img = goutil.findChild(mainGo, "img")
		cell.txtTag = goutil.findChild(mainGo, "txtTag")
		cell.txtTag_txt = goutil.findChildTextComponent(mainGo, "txtTag/txt")
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

function DivineKingDragonChallengePosView:bindEvents()
	DivineKingDragonChallengePosView.super.bindEvents(self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
end

function DivineKingDragonChallengePosView:unbindEvents()
	DivineKingDragonChallengePosView.super.unbindEvents(self)
	self._btnHide:RemoveClickListener()
	self._btnArrow:RemoveClickListener()
	self._btnBuff:RemoveClickListener()

	for i, v in ipairs(self._cellList) do
		v.btn:RemoveClickListener()
	end
end

function DivineKingDragonChallengePosView:onEnter()
	DivineKingDragonChallengePosView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local customFmtMo = params[1]
	local cfgCreeps = customFmtMo:getMonsterConfigListOfReal()

	self._cfgCreeps = TableUtil.deepcopy(cfgCreeps)

	self:_initPopupState()
	self:_initPetHeads()

	self._drayCallBack = nil
	self._isNeedDrag = self._drayCallBack ~= nil
	self._dragPointerId = nil
	self._dragingConGo = nil
	self._dragingIndex = nil
end

function DivineKingDragonChallengePosView:onExit()
	DivineKingDragonChallengePosView.super.onExit(self)
	self:_clearHeadIcon()
end

function DivineKingDragonChallengePosView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xShow, self._yPos, 0), Vector3.New(self._xHide, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
		self:_refreshMissionView()
	end
end

function DivineKingDragonChallengePosView:_onClickArrow()
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

function DivineKingDragonChallengePosView:_onClickBuff()
	UIStateManager.instance:push(ViewName.FanRuiChallengeForecastView, self._creepsMasterId)
end

function DivineKingDragonChallengePosView:_onClickPet(index)
	printInfo("test DivineKingDragonChallengePosView:_onClickPet", index)

	if self._dragPointerId == nil then
		local cfgEnemy = self:_isExistPetHead(index)

		if cfgEnemy then
			local tmpMo = FightingPowerPetMo.createPetByLevel(cfgEnemy.raceId, 1, 1, 0)

			CommonTipsMgr.instance:showPetTips(tmpMo, true)
		end
	end
end

function DivineKingDragonChallengePosView:_onBeginDragCell(go, eventData)
	if not self._isNeedDrag then
		return
	end

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

function DivineKingDragonChallengePosView:_onDragingCell(go, eventData)
	if not self._isNeedDrag then
		return
	end

	if not self._dragingConGo then
		return
	end

	if self._dragPointerId == nil or self._dragPointerId ~= eventData.pointerId then
		return
	end

	self._dragingConGo.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function DivineKingDragonChallengePosView:_onDropCell(go, eventData)
	if not self._isNeedDrag then
		return
	end

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

function DivineKingDragonChallengePosView:_onEndDragCell(go, eventData)
	if not self._isNeedDrag then
		return
	end

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

function DivineKingDragonChallengePosView:_swagPetPos(dragingPosIndex, endPosIndex)
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

function DivineKingDragonChallengePosView:_refreshConPos()
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

function DivineKingDragonChallengePosView:_resetPetPos(dragingIndex)
	return
end

function DivineKingDragonChallengePosView:_initPopupState()
	self._isPopupState = true

	goutil.setActive(self._btnHide.gameObject, true)
	Framework.TransformUtil.SetAnchoredPos(self._moveNode.transform, self._xShow, self._yPos)
	Framework.TransformUtil.SetLocalRotation(self._arrowRectTrans.transform, 0, 0, 0)
end

function DivineKingDragonChallengePosView:_initPetHeads()
	self:_clearHeadIcon()

	for posId, cell in ipairs(self._cellList) do
		local cfgEnemy

		for _, data in ipairs(self._cfgCreeps) do
			if data.posId == posId then
				cfgEnemy = data

				break
			end
		end

		if cfgEnemy then
			goutil.setActive(cell.frontBg, true)
			GameUtil.setLocalScale(cell.con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, cell.con)

			if proxy then
				local function func()
					self:_onClickPet(posId)
				end

				proxy.binder:setClickCallBack(func)
			end

			cell.txtTag_txt.text = cfgEnemy.txtTag

			GameUtil.SetActive(cell.txtTag.gameObject, not string.nilorempty(cfgEnemy.txtTag))
		else
			MaterialMgr.resetAll(cell.con)
			GameUtil.SetActive(cell.txtTag.gameObject, false)
		end
	end
end

function DivineKingDragonChallengePosView:_clearHeadIcon()
	for i, v in ipairs(self._cellList) do
		MaterialMgr.resetAll(v.con)
		goutil.setActive(v.frontBg, false)
	end
end

function DivineKingDragonChallengePosView:_isExistPetHead(posIndex)
	for i, cfgEnemy in ipairs(self._cfgCreeps) do
		if cfgEnemy.posId == posIndex then
			return cfgEnemy
		end
	end
end

function DivineKingDragonChallengePosView:_refreshMissionView()
	GameUtil.callBack(self._drayCallBack)
end

return DivineKingDragonChallengePosView
