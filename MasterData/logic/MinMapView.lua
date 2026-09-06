-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/map/view/MinMapView.lua

module("logic.extensions.map.view.MinMapView", package.seeall)

local MinMapView = class("MinMapView", ViewComponent)
local mapScale = 10
local minMapMoType = {
	TaskNpc = 2,
	ChallengeNpc = 3,
	TransFormPoint = 1,
	Monster = 4
}
local minMapMoDes = {
	"传送点",
	"任务",
	"挑战",
	"野怪"
}

function MinMapView:ctor()
	MinMapView.super.ctor(self)
end

function MinMapView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnToMap:AddClickListener(self._onClickToMap, self)
	self._btnMinMap:AddClickListener(self._onClickMinMap, self)
end

function MinMapView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnToMap:RemoveClickListener()
	self._btnMinMap:RemoveClickListener()
end

function MinMapView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnToMap = self:getBtn("btnToMap")
	self._nowPos = self:getGo("temp/nowPos")
	self._targetPos = self:getGo("temp/targetPos")
	self._txtNowPos = goutil.findChildComponent(self.mainGO, "txtNowPos", "Text")
	self._txtSceneName = goutil.findChildComponent(self.mainGO, "txtSceneName", "Text")
	self._rectMinMap = goutil.findChildComponent(self.mainGO, "map", "RectTransform")
	self._btnMinMap = Framework.ButtonAdapter.Get(self._rectMinMap.gameObject)
	self._mapCell = self:getGo("map/cell")

	goutil.setActive(self._mapCell, false)

	self._mapCells = {}

	table.insert(self._mapCells, self._mapCell.gameObject)

	self._tableView = goutil.findChildComponent(self.mainGO, "tableview", "UITableview")
	self._tableCell = self:getGo("tablecell")

	goutil.setActive(self._tableCell, false)
	self._tableView:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableView:RegisterUpdateCellCallback(self._updateCell)
	self._tableView:SetOffsetWithoutRefresh(0)
end

function MinMapView:destroyUI()
	return
end

function MinMapView:onEnter()
	self._curViewDatas = {}

	goutil.setActive(self._targetPos, false)

	local tps = SceneFacade.instance:getTransmitPoints()

	for i = 0, tps.Length - 1 do
		local mo = {}

		mo.enum = minMapMoType.TransFormPoint
		mo.x = tps[i].position.x
		mo.y = tps[i].position.y
		mo.toSceneId = tps[i].toSceneId

		local cfg = SceneConfig.instance:getSceneCo(mo.toSceneId)

		mo.name = cfg.scene_name

		table.insert(self._curViewDatas, mo)
	end

	local npcs = SceneFacade.instance:getNpcs()

	if npcs then
		for k, unit in pairs(npcs) do
			local mo = {}

			mo.x, mo.y = unit.transform:getPos()
			mo.name = unit:getUnitName()

			local challengeIds = SceneFacade.instance:getNpcChallengeId(unit.npcId)

			if challengeIds then
				mo.enum = minMapMoType.ChallengeNpc
			end

			local isTask = SceneFacade.instance:isTaskNpc(unit.npcId)

			if isTask then
				mo.state = SceneFacade.instance:getNpcTaskState(unit.npcId)
				mo.enum = minMapMoType.TaskNpc
			end

			if mo.enum then
				table.insert(self._curViewDatas, mo)
			end
		end
	end

	local ms = SceneFacade.instance:getSceneMonsterZones()

	for i = 0, ms.Length - 1 do
		local mo = {}

		mo.enum = minMapMoType.Monster
		mo.x, mo.y = ms[i].position.x, ms[i].position.y
		mo.name = "野怪"

		table.insert(self._curViewDatas, mo)
	end

	self._tableView:ReloadData()

	local cfg = SceneConfig.instance:getSceneCo(SceneMgr.instance:getCurSceneId())

	self._txtSceneName.text = cfg.scene_name
	self._mainPlayer = SceneFacade.instance:getMainPlayer()
	self._sceneSize = SceneFacade.instance:getSceneSize()
	mapScale = 600 / math.max(self._sceneSize.x, self._sceneSize.y)

	self:_drawMinMap()
end

function MinMapView:onEnterFinished()
	return
end

function MinMapView:onExit()
	for _, v in ipairs(self._mapCells) do
		goutil.setActive(v, false)
	end

	removetimer(self._updateMainPlayerPos, self)
end

function MinMapView:onExitFinished()
	return
end

function MinMapView:_numInView()
	return #self._curViewDatas
end

function MinMapView:_cellSize(view, index)
	return 210, 72
end

function MinMapView:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)
	cell.index = idx

	self:_updateCell(view, cell)

	return cell
end

function MinMapView:_updateCell(view, cell)
	local idx = cell.index
	local data = self._curViewDatas[idx + 1]
	local txtName = goutil.findChildComponent(cell.gameObject, "txtName", "Text")

	txtName.text = data.name

	self:_updateMapCell(cell.gameObject, data, idx + 1)

	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickCell(data)
	end)
end

function MinMapView:_drawMinMap()
	local size = SceneFacade.instance:getSceneSize()

	self._rectMinMap.sizeDelta = Vector2.New(size.x * mapScale, size.y * mapScale)

	for k, mo in ipairs(self._curViewDatas) do
		print("draw min map k = " .. k)

		local cell = self:getMapCell()

		self:_updateMapCell(cell, mo, k)
		Framework.TransformUtil.SetLocalPos(cell.transform, (mo.x - size.x * 0.5) * mapScale, (mo.y - size.y * 0.5) * mapScale, 0)
	end

	self:_updateMainPlayerPos()
end

function MinMapView:_updateMapCell(cell, mo, index)
	local imgType = goutil.findChildComponent(cell.gameObject, "imgType", "Image")
	local txtType = goutil.findChildComponent(cell.gameObject, "txtType", "Text")
	local txtIndex = goutil.findChildComponent(cell.gameObject, "txtIndex", "Text")

	if mo.enum == minMapMoType.ChallengeNpc then
		Game.ImageUtil.SetColorRGBA(imgType, 0.8549019607843137, 0.25882352941176473, 0.25882352941176473, 1)
	elseif mo.enum == minMapMoType.TaskNpc then
		Game.ImageUtil.SetColorRGBA(imgType, 0.35294117647058826, 0.8549019607843137, 0.25882352941176473, 1)
	elseif mo.enum == minMapMoType.TransFormPoint then
		Game.ImageUtil.SetColorRGBA(imgType, 0.16862745098039217, 0.8980392156862745, 0.9647058823529412, 1)
	elseif mo.enum == minMapMoType.Monster then
		Game.ImageUtil.SetColorRGBA(imgType, 0.9647058823529412, 0.5803921568627451, 0.16862745098039217, 1)
	end

	txtType.text = minMapMoDes[mo.enum]
	txtIndex.text = tostring(index)
end

function MinMapView:_updateMainPlayerPos()
	if self._mainPlayer then
		local x, y = self._mainPlayer.transform:getPos()

		self._txtNowPos.text = string.format("(%d, %d)", x, y)

		Framework.TransformUtil.SetLocalPos(self._nowPos.transform, (x - self._sceneSize.x * 0.5) * mapScale, (y - self._sceneSize.y * 0.5) * mapScale, 0)
	end
end

function MinMapView:getMapCell()
	local go

	for _, cell in ipairs(self._mapCells) do
		if not cell.activeSelf then
			go = cell

			break
		end
	end

	if not go then
		go = goutil.cloneAndSetParent(self._mapCell, self._rectMinMap.transform)

		table.insert(self._mapCells, go)
	end

	goutil.setActive(go, true)

	return go
end

function MinMapView:_onClickMinMap()
	local localPos = UGUIToolHelper.ScreenToUGUILocalPosition(self._rectMinMap.transform, GlobalModel.instance.uiCamera, UGUIToolHelper.GetTouchPosition())

	self:_runToTarget(localPos.x, localPos.y, true, true)
end

function MinMapView:LocalToWorld(x, y)
	return x / mapScale + self._sceneSize.x * 0.5, y / mapScale + self._sceneSize.y * 0.5
end

function MinMapView:WorldToLocal(x, y)
	return (x - self._sceneSize.x * 0.5) * mapScale, (y - self._sceneSize.y * 0.5) * mapScale
end

function MinMapView:_runToTarget(x, y, isLocal, showArrow)
	local localX, localY = 0, 0

	if isLocal then
		localY = y
		localX = x
		x, y = self:LocalToWorld(x, y)
	else
		localX, localY = self:WorldToLocal(x, y)
	end

	if self._mainPlayer then
		settimer(0, self._updateMainPlayerPos, self)
		self._mainPlayer:runPath(x, y, self._onRunFinished, self)
	end

	Framework.TransformUtil.SetLocalPos(self._targetPos.transform, localX, localY, 0)
	goutil.setActive(self._targetPos, showArrow)
end

function MinMapView:_onRunFinished()
	goutil.setActive(self._targetPos, false)
	removetimer(self._updateMainPlayerPos, self)
end

function MinMapView:_onClickCell(mo)
	self:_runToTarget(mo.x, mo.y, false, false)
end

function MinMapView:_onClickClose()
	UIStateManager.instance:pop()
end

function MinMapView:_onClickToMap()
	UIStateManager.instance:push(ViewName.Map)
end

return MinMapView
