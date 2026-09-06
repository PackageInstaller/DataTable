-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/view/ShenyaolongzunshengzhuextView.lua

module("logic.extensions.shenyaolongzunshengzhu.view.ShenyaolongzunshengzhuextView", package.seeall)

local ShenyaolongzunshengzhuextView = class("ShenyaolongzunshengzhuextView", ViewComponent)

function ShenyaolongzunshengzhuextView:ctor()
	ShenyaolongzunshengzhuextView.super.ctor(self)

	self._yPos = 80
	self._xHide = 400
	self._xShow = -112
end

function ShenyaolongzunshengzhuextView:buildUI()
	ShenyaolongzunshengzhuextView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._btnBuff = self:getBtn("moveNode/btnBuff")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._fmtParent = self:getGo("moveNode/fmt")
	self._infoList = {}
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
		goutil.setActive(cell.backBg, true)
		goutil.setActive(cell.frontBg, false)

		self._cellList[i] = cell

		local go = self:getGo("moveNode/info/item_" .. i)

		table.insert(self._infoList, go)
	end
end

function ShenyaolongzunshengzhuextView:_addDragEvent(gameObject)
	BeginDragHandler.Get(gameObject):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragCell(_go, eventData)
	end)
	DragHandler.Get(gameObject):AddLuaHandler(function(_go, eventData)
		self:_onDragingCell(_go, eventData)
	end)
	DropHandler.Get(gameObject):AddLuaHandler(function(_go, eventData)
		self:_onDropCell(_go, eventData)
	end)
	EndDragHandler.Get(gameObject):AddLuaHandler(function(_go, eventData)
		self:_onEndDragCell(_go, eventData)
	end)
end

function ShenyaolongzunshengzhuextView:bindEvents()
	ShenyaolongzunshengzhuextView.super.bindEvents(self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)

	for i, v in ipairs(self._cellList) do
		GameUtil.addClickHandler(v.img, GameUtil.handler(self._onClickPet, self, i))
	end
end

function ShenyaolongzunshengzhuextView:unbindEvents()
	ShenyaolongzunshengzhuextView.super.unbindEvents(self)
	self._btnHide:RemoveClickListener()
	self._btnArrow:RemoveClickListener()
	self._btnBuff:RemoveClickListener()

	for i, v in ipairs(self._cellList) do
		GameUtil.rmClickHandler(v.img)
	end
end

function ShenyaolongzunshengzhuextView:onEnter()
	ShenyaolongzunshengzhuextView.super.onEnter(self)

	local customFmtMo = self:getFirstParam() or {}

	self._dragPointerId = nil
	self._dragingConGo = nil
	self._dragingIndex = nil
	self.activityId = customFmtMo.activityId
	self.curStageId = customFmtMo.curStageId

	local cfg = ShenyaolongzunshengzhuConfig.instance:getStageCfgById(self.activityId, self.curStageId) or {}

	self.creepsMasterId = cfg.creepsMasterId

	local cfgs = ShenyaolongzunshengzhuConfig.instance:getCreepsCfgById(self.creepsMasterId) or {}

	self._cfgCreeps = TableUtil.deepcopy(cfgs)

	self:_initPopupState()
	self:_initPetHeads()
end

function ShenyaolongzunshengzhuextView:onExit()
	ShenyaolongzunshengzhuextView.super.onExit(self)
	self:_clearHeadIcon()
end

function ShenyaolongzunshengzhuextView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xShow, self._yPos, 0), Vector3.New(self._xHide, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
		self:_refreshMissionView()
	end
end

function ShenyaolongzunshengzhuextView:_onClickArrow()
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

function ShenyaolongzunshengzhuextView:_onClickBuff()
	UIStateManager.instance:push(ViewName.FanRuiChallengeForecastView, self._creepsMasterId)
end

function ShenyaolongzunshengzhuextView:_onClickPet(index)
	if self._dragPointerId == nil then
		local petMo = self._formations[index]

		if petMo then
			CommonTipsMgr.instance:showPetTips(petMo)
		end
	end
end

function ShenyaolongzunshengzhuextView:_onBeginDragCell(go, eventData)
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

function ShenyaolongzunshengzhuextView:_onDragingCell(go, eventData)
	if not self._dragingConGo then
		return
	end

	if self._dragPointerId == nil or self._dragPointerId ~= eventData.pointerId then
		return
	end

	self._dragingConGo.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function ShenyaolongzunshengzhuextView:_onDropCell(go, eventData)
	printInfo("test ShenyaolongzunshengzhuextView:_onDropCell", go.name)

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

function ShenyaolongzunshengzhuextView:_onEndDragCell(go, eventData)
	printInfo("test ShenyaolongzunshengzhuextView:_onEndDragCell", go.name)

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

function ShenyaolongzunshengzhuextView:_swagPetPos(dragingPosIndex, endPosIndex)
	local dragingCell = self._cellList[dragingPosIndex]
	local endCell = self._cellList[endPosIndex]

	dragingCell.con.transform:SetParent(endCell.go.transform)
	endCell.con.transform:SetParent(dragingCell.go.transform)

	dragingCell.con = endCell.con
	endCell.con = dragingCell.con

	dragingCell.con.transform:SetSiblingIndex(2)
	endCell.con.transform:SetSiblingIndex(2)

	for i, cfgEnemy in pairs(self._cfgCreeps) do
		if cfgEnemy.posId == dragingPosIndex then
			cfgEnemy.posId = endPosIndex
		elseif cfgEnemy.posId == endPosIndex then
			cfgEnemy.posId = dragingPosIndex
		end
	end
end

function ShenyaolongzunshengzhuextView:_refreshConPos()
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

function ShenyaolongzunshengzhuextView:_initPopupState()
	self._isPopupState = true

	goutil.setActive(self._btnHide.gameObject, true)
	Framework.TransformUtil.SetAnchoredPos(self._moveNode.transform, self._xShow, self._yPos)
	Framework.TransformUtil.SetLocalRotation(self._arrowRectTrans.transform, 0, 0, 0)
end

function ShenyaolongzunshengzhuextView:_initPetHeads()
	self:_clearHeadIcon()

	for i, v in ipairs(self._infoList) do
		GameUtil.SetActive(v, false)
	end

	local teams = {}

	self._formations = {}

	if self._cfgCreeps then
		for i, v in pairs(self._cfgCreeps) do
			if checknumber(v.posId) > 0 then
				local petMo = FightingPowerPetMo.New()

				petMo:fromChallengeCreepCo(v, creepCfg)

				petMo.creepName = v.creepName

				table.insert(teams, petMo)

				self._formations[v.posId] = petMo
			end
		end
	end

	for i, cfgEnemy in pairs(self._cfgCreeps) do
		local cell = self._cellList[cfgEnemy.posId]

		if cell.frontBg then
			goutil.setActive(cell.frontBg, true)
			GameUtil.setLocalScale(cell.con, 0.8, 0.8, 0.8)
			MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, cell.con)
		end

		local tagType = checknumber(cfgEnemy.tagType)
		local item = self._infoList[cfgEnemy.posId]

		if item and tagType > 0 then
			GameUtil.SetActive(item, true)

			local img = goutil.findChild(item, "img")

			GameUtil.setUIImageSpriteIdx(img, tagType - 1)

			for j = 1, 6 do
				local go = goutil.findChild(item, "txt_" .. j)

				GameUtil.SetActive(go, tagType == j)
			end
		end
	end
end

function ShenyaolongzunshengzhuextView:_clearHeadIcon()
	for i, v in ipairs(self._cellList) do
		MaterialMgr.resetAll(v.con)
		goutil.setActive(v.frontBg, false)
	end
end

function ShenyaolongzunshengzhuextView:_isExistPetHead(posIndex)
	for i, cfgEnemy in pairs(self._cfgCreeps) do
		if cfgEnemy.posId == posIndex then
			return cfgEnemy
		end
	end
end

function ShenyaolongzunshengzhuextView:_refreshMissionView()
	return
end

return ShenyaolongzunshengzhuextView
