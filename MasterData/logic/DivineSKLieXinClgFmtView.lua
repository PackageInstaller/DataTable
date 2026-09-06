-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/view/DivineSKLieXinClgFmtView.lua

module("logic.extensions.divineskliexinclg.view.DivineSKLieXinClgFmtView", package.seeall)

local DivineSKLieXinClgFmtView = class("DivineSKLieXinClgFmtView", ViewComponent)

function DivineSKLieXinClgFmtView:ctor()
	DivineSKLieXinClgFmtView.super.ctor(self)
end

function DivineSKLieXinClgFmtView:unbindEvents()
	DivineSKLieXinClgFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnArrow)

	for i = 1, 9 do
		if self._cellMap[i] then
			GameUtil.rmClickHandler(self._cellMap[i].btn)
		end
	end
end

function DivineSKLieXinClgFmtView:bindEvents()
	DivineSKLieXinClgFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnArrow, self._onClickArrow, self)

	for i = 1, 9 do
		if self._cellMap[i] then
			GameUtil.addClickHandler(self._cellMap[i].btn, function()
				self:_onClickCell(i)
			end, self)
		end
	end
end

function DivineSKLieXinClgFmtView:buildUI()
	DivineSKLieXinClgFmtView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._cellMap = {}

	local fmtGo = self:getGo("moveNode/fmt")

	for i = 1, 9 do
		local cell = {}

		cell.go = goutil.findChild(fmtGo, "cell_" .. i)
		cell.con = goutil.findChild(cell.go, "con")
		cell.conTag = goutil.findChild(cell.go, "tag")
		cell.emptyTag = goutil.findChild(fmtGo, string.format("bg/cell_%d/tag", i))
		cell.btn = goutil.findChild(fmtGo, string.format("btns/btnCell_%d", i))
		self._cellMap[i] = cell
	end

	self._tagTableCell = self:getGo("moveNode/tagTableView/tablecell")
	self._tagTableView = self:getGo("moveNode/tagTableView")
	self._tagTableList = ScrollerList.create(self._tagTableView, self._tagTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._dragcell = self:getGo("dragcell")

	self._tagTableList:getView():RegisterDraggingCallback(nil, GameUtil.handler(self._onDragCellStart, self), nil, nil, GameUtil.handler(self._onCloneDragObj, self), nil)
	self._tagTableList:getView():RegisterDragEndedCallback(self._onDragCellEnd, self)
end

function DivineSKLieXinClgFmtView:onExit()
	DivineSKLieXinClgFmtView.super.onExit(self)
end

function DivineSKLieXinClgFmtView:onEnter()
	DivineSKLieXinClgFmtView.super.onEnter(self)

	self._customFmtMo = self:getFirstParam()
	self._activityId = self._customFmtMo.activityId
	self._stageId = self._customFmtMo.stageId
	self._isPopupState = true

	self:_initView()
	self:_refreshView()
end

function DivineSKLieXinClgFmtView:_initView()
	for i = 1, 9 do
		GameUtil.SetActive(self._cellMap[i].go, false)
	end

	local activityCfg = DivineSKLieXinClgConfig.instance:getActivityCfg(self._activityId)
	local stageCfg = DivineSKLieXinClgConfig.instance:getStageCfg(activityCfg.stagePlanId, self._stageId)
	local masterList = DivineSKLieXinClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)

	for i, v in ipairs(masterList) do
		if self._cellMap[v.posId] then
			GameUtil.SetActive(self._cellMap[v.posId].go, true)
			MaterialMgr.setIcon(self._cellMap[v.posId].con, MatType.Pet, v.raceId)
		end
	end

	GameUtil.SetActive(self._dragcell, false)
	GameUtil.SetActive(self._btnHide, true)
	GameUtil.setAnchoredPos(self._moveNode, -110, 80)
	GameUtil.setLocalRotation(self._arrowRectTrans, 0, 0, 0)
end

function DivineSKLieXinClgFmtView:_refreshView()
	local applyCount = 0

	for i = 1, 9 do
		if self._customFmtMo:getTagPos(i) == true then
			applyCount = applyCount + 1

			GameUtil.SetActive(self._cellMap[i].conTag, true)
			GameUtil.SetActive(self._cellMap[i].emptyTag, true)
		else
			GameUtil.SetActive(self._cellMap[i].conTag, false)
			GameUtil.SetActive(self._cellMap[i].emptyTag, false)
		end
	end

	local activityCfg = DivineSKLieXinClgConfig.instance:getActivityCfg(self._activityId)
	local stageCfg = DivineSKLieXinClgConfig.instance:getStageCfg(activityCfg.stagePlanId, self._stageId)

	self._curTagCount = stageCfg.tagCount - applyCount

	local tagList = {}

	for i = 1, self._curTagCount do
		table.insert(tagList, i)
	end

	self._tagTableList:reloadData(tagList)
end

function DivineSKLieXinClgFmtView:_updateCell(view, cell, data, tag)
	cell.gameObject.name = "cell_" .. data
end

function DivineSKLieXinClgFmtView:_clearCell(cell)
	return
end

function DivineSKLieXinClgFmtView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function DivineSKLieXinClgFmtView:_onClickArrow()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	else
		self._isPopupState = true

		goutil.setActive(self._btnHide.gameObject, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(400, 80, 0), Vector3.New(-110, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

function DivineSKLieXinClgFmtView:_onDragCellStart(startContainer, cell)
	GameUtil.SetActive(self._dragcell, true)

	self._drag = true
end

function DivineSKLieXinClgFmtView:_onDragCellEnd(startContainer, cell, endContainer)
	if endContainer then
		local cellGoStrArr = string.split(endContainer.name, "_")
		local cellId = checknumber(cellGoStrArr[2])

		if not self._customFmtMo:getTagPos(cellId) then
			self._customFmtMo:setTagPos(cellId, true)
			self:_refreshView()
		end
	end

	GameUtil.SetActive(self._dragcell, false)

	self._drag = false

	return true
end

function DivineSKLieXinClgFmtView:_onCloneDragObj(table, cell)
	local targetPos = GameUtil.getPos(cell.gameObject)

	GameUtil.setPos(self._dragcell, targetPos.x, targetPos.y, targetPos.z)

	return self._dragcell
end

function DivineSKLieXinClgFmtView:_onClickCell(index)
	if self._customFmtMo:getTagPos(index) == true then
		self._customFmtMo:setTagPos(index, nil)
		self:_refreshView()
	end
end

return DivineSKLieXinClgFmtView
