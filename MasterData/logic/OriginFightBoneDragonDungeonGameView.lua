-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightBoneDragonDungeonGameView.lua

module("logic.extensions.originfight.view.OriginFightOriginFightBoneDragonDungeonGameView", package.seeall)

local OriginFightBoneDragonDungeonGameView = class("OriginFightBoneDragonDungeonGameView", ViewComponent)
local EventType = {
	SwitchCtrl = "switchCtrl",
	Rail = "rail",
	Injured = "injured",
	Battle = "battle",
	Barrier = "barrier",
	Exit = "exit",
	Chest = "chest",
	Believer = "believer"
}
local EFFECT_PATH_JIAO_HU = "20250627/shenghailongpaotu/fx_ui_shenghailongpaotu_jh6.prefab"
local EFFECT_PATH_FEN_WEI = "20250627/shenghailongpaotu/fx_ui_shenghailongpaotu_fw5.prefab"
local EFFECT_PATH_LUO_DI = "20250627/shenghailongpaotu/fx_ui_shenghailongpaotu_ld4.prefab"

function OriginFightBoneDragonDungeonGameView:ctor()
	OriginFightBoneDragonDungeonGameView.super.ctor(self)
end

function OriginFightBoneDragonDungeonGameView:unbindEvents()
	OriginFightBoneDragonDungeonGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginFightBoneDragonDungeonGameView:bindEvents()
	OriginFightBoneDragonDungeonGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnUp, self._onClickUp, self)
	GameUtil.addClickHandler(self._btnDown, self._onClickDown, self)
	GameUtil.addClickHandler(self._btnOperate, self._onClickOperate, self)
end

function OriginFightBoneDragonDungeonGameView:buildUI()
	OriginFightBoneDragonDungeonGameView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnReset = self:getGo("btnReset")
	self._btnShop = self:getGo("btnShop")
	self._mapCon = self:getGo("mapCon")
	self._bgCon = self:getGo("bgCon")
	self._bgContainer = self:getGo("mapCon/bg")
	self._linkCon = self:getGo("linkCon")
	self._linkContainer = self:getGo("mapCon/link")
	self._lineCon = self:getGo("lineCon")
	self._linesContainer = self:getGo("mapCon/lines")
	self._eventCell = self:getGo("cell")
	self._eventCellContainer = self:getGo("cellContainer")
	self._playerCon = self:getGo("playerCon")
	self._playerContainer = self:getGo("playerContainer")
	self._effectCell = self:getGo("effectContainer/effectCell")
	self._effectContainer = self:getGo("effectContainer")
	self._btnRight = self:getGo("dirBtns/btnRight")
	self._btnLeft = self:getGo("dirBtns/btnLeft")
	self._btnUp = self:getGo("dirBtns/btnUp")
	self._btnDown = self:getGo("dirBtns/btnDown")
	self._btnOperate = self:getGo("btnOperate")
	self._txtCanOperate = self:getGo("txtCanOperate")
	self._txtNotCanOperate = self:getGo("txtNotCanOperate")
	self._roleTableView = self:getGo("roleTableview")
	self._roleTableCell = self:getGo("roleTableview/roleTableCell")
	self._roleTableList = ScrollerList.create(self._roleTableView, self._roleTableCell, GameUtil.handler(self._updateRoleCell, self), GameUtil.handler(self._clearRoleCell, self))
	self._typeTableCell = self:getGo("typeTableCell")
	self._txtStage = self:getTxt("stageTips/txtStage")
end

function OriginFightBoneDragonDungeonGameView:onExit()
	OriginFightBoneDragonDungeonGameView.super.onExit(self)
	self:_clearMap()
	self._roleTableList:dispose()

	for i, v in pairs(self._typeListMap) do
		v:dispose()
	end

	self._typeListMap = nil

	if self.bgEffect then
		self:stopViewEffect(self.bgEffect)

		self.bgEffect = nil
	end

	self._effectPool:clear()
end

function OriginFightBoneDragonDungeonGameView:onEnter()
	self.addGEvent(self, GlobalNotify.PM_OriginFightCommonGodFavorRes, self._onGodFavorRes, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._godFavorId = checknumber(params[2])
	self._stageId = 1
	self._stageCfg = OriginFightConfig.instance:getDungeonStageCfg(self._stageId)
	self._operationList = {}
	self._typeListMap = {}
	self._gamming = false
	self._isEffectPlaying = false
	self._inOnExit = false

	self:_enterNewMap()

	self.bgEffect = self:playViewEffect(EFFECT_PATH_FEN_WEI, nil, nil, true)
	self._effectPool = ObjectPool.New(5, function()
		local obj = goutil.cloneAndSetParent(self._effectCell, self._effectContainer.transform, "effectCell")

		GameUtil.SetActive(obj, true)

		return obj
	end, function(obj)
		self:stopViewEffectUniGo(obj)
		goutil.destroy(obj)
	end, function(obj)
		self:stopViewEffectUniGo(obj)
		GameUtil.SetActive(obj, false)
	end)

	local pos = GameUtil.getAnchoredPos(self._mapCon)

	GameUtil.setAnchoredPos(self._effectContainer, pos.x, pos.y)
end

function OriginFightBoneDragonDungeonGameView:_initMap()
	self:_clearMap()

	self._col = self._stageCfg.mapSize[1]
	self._row = self._stageCfg.mapSize[2]
	self._mapBgConMap = {}
	self._mapInfo = {}
	self._playPosInfo = {}

	local list = {}

	for i = 1, self._col do
		for j = 1, self._row do
			self._mapInfo[i] = self._mapInfo[i] or {}
			self._mapInfo[i][j] = 0
			self._playPosInfo[i] = self._playPosInfo[i] or {}
			self._playPosInfo[i][j] = 0

			table.insert(list, {
				x = i,
				y = j
			})
		end
	end

	local bgSizeX, bgSizeY = self:getBgCellSize()

	self._offsetX = bgSizeX * self._col / 2
	self._offsetY = bgSizeY * self._row / 2

	GameUtil.updateCellsList(self._bgContainer, self._bgCon, list, self._initBgCell, self)
	table.clear(list)

	self._lineGoMap = {}

	for i = 1, self._row do
		table.insert(list, i)
	end

	GameUtil.updateCellsList(self._linesContainer, self._lineCon, list, self._initLineCell, self)

	self._eventGoMap = {}

	local eventCfgs = OriginFightConfig.instance:getDungeonEventCfgs(self._stageId)
	local resultList = {}

	for i, v in ipairs(eventCfgs) do
		if not OriginFightModel.instance:isEventFinish(v.eventId) then
			table.insert(resultList, v)
		end
	end

	self._exitOpen = self:_checkExitOpen()

	GameUtil.updateCellsList(self._eventCellContainer, self._eventCell, resultList, self._initEventCell, self)
	table.clear(list)

	local rolePos = {}

	for i, v in ipairs(self._stageCfg.initPoses) do
		table.insert(rolePos, v)
	end

	self._playerGoMap = {}

	for i, v in ipairs(self._stageCfg.roles) do
		list[i] = {
			x = self._stageCfg.initPoses[v][1] + 1,
			y = rolePos[v][2] + 1,
			index = i,
			type = v
		}
	end

	GameUtil.updateCellsList(self._playerContainer, self._playerCon, list, self._initPlayerCell, self)
	self:_checkOperate()
	self:_checkTypeFinish()
	self._roleTableList:reloadData(list)
end

function OriginFightBoneDragonDungeonGameView:getBgCellSize()
	return 70, 120
end

function OriginFightBoneDragonDungeonGameView:_initBgCell(cell, data, index)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local imageSelect = goutil.findChild(go, "select")

	go.name = string.format("cell_%d_%d", data.x, data.y)

	GameUtil.SetActive(imageSelect, false)

	self._mapBgConMap[data.x] = self._mapBgConMap[data.x] or {}
	self._mapBgConMap[data.x][data.y] = go

	local posX, posY = self:getLocalPosByPos(data.x, data.y)

	GameUtil.setAnchoredPos(go, posX, posY)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickBlock(data.x, data.y)
	end)
end

function OriginFightBoneDragonDungeonGameView:_selectCell(x, y, isSelect)
	if self._mapBgConMap[x] then
		local go = self._mapBgConMap[x][y]

		if go then
			local imageSelect = goutil.findChild(go, "select")

			GameUtil.SetActive(imageSelect, isSelect)
		end
	end
end

function OriginFightBoneDragonDungeonGameView:_initLineCell(cell, data, index)
	local go = cell.gameObject

	self._lineGoMap[data] = go
	go.name = string.format("line_%d", data)
end

function OriginFightBoneDragonDungeonGameView:_initEventCell(cell, data, index)
	local go = cell
	local chest = goutil.findChild(go, "chest")
	local switchCtrl = goutil.findChild(go, "switchCtrl")
	local rail = goutil.findChild(go, "rail")
	local battle = goutil.findChild(go, "battle")
	local injured = goutil.findChild(go, "injured")
	local barrier = goutil.findChild(go, "barrier")
	local believer = goutil.findChild(go, "believer")
	local exit = goutil.findChild(go, "exit")

	self._eventGoMap[data.eventId] = go

	local lineGo = self._lineGoMap[data.y + 1]

	goutil.addChildToParent(go, lineGo)

	self._mapInfo[data.x + 1][data.y + 1] = data.eventId

	local posX, posY = self:getLocalPosByPos(data.x + 1, data.y + 1)

	GameUtil.setAnchoredPos(go, posX, posY)

	local eventCfg = OriginFightConfig.instance:getDungeonEventCfgById(self._stageId, data.eventId)

	GameUtil.SetActive(chest, eventCfg.eventType == EventType.Chest)
	GameUtil.SetActive(switchCtrl, eventCfg.eventType == EventType.SwitchCtrl)
	GameUtil.SetActive(rail, eventCfg.eventType == EventType.Rail)
	GameUtil.SetActive(battle, eventCfg.eventType == EventType.Battle)
	GameUtil.SetActive(injured, eventCfg.eventType == EventType.Injured)
	GameUtil.SetActive(barrier, eventCfg.eventType == EventType.Barrier)
	GameUtil.SetActive(believer, eventCfg.eventType == EventType.Believer)
	GameUtil.SetActive(exit, eventCfg.eventType == EventType.Exit)

	if eventCfg.eventType == EventType.Rail then
		self:_setRailState(go, OriginFightModel.instance:isRailOpen(data.eventId))
	elseif eventCfg.eventType == EventType.SwitchCtrl then
		self:_setSwitchCtrlState(go, OriginFightModel.instance:isSwitchOpen(data.eventId))
	elseif eventCfg.eventType == EventType.Exit then
		self:_setExitState(go, self._exitOpen)
	end
end

function OriginFightBoneDragonDungeonGameView:_setRailState(go, isOpen)
	local rail = goutil.findChildComponent(go, "rail", ComponentType.UIImageSpriteChange)

	if isOpen == false then
		rail:SetState(0)
	else
		rail:SetState(1)
	end
end

function OriginFightBoneDragonDungeonGameView:_setSwitchCtrlState(go, isOpen)
	local switchCtrl = goutil.findChildComponent(go, "switchCtrl", ComponentType.UIImageSpriteChange)

	if isOpen == false then
		switchCtrl:SetState(0)
	else
		switchCtrl:SetState(1)
	end
end

function OriginFightBoneDragonDungeonGameView:_setExitState(go, isOpen)
	local switchCtrl = goutil.findChildComponent(go, "exit", ComponentType.UIImageSpriteChange)

	if isOpen == false then
		switchCtrl:SetState(0)
	else
		switchCtrl:SetState(1)
	end
end

function OriginFightBoneDragonDungeonGameView:_initPlayerCell(cell, data, index)
	local go = cell
	local con = goutil.findChild(go, "con")
	local txtType = goutil.findChildTextComponent(go, "txtType")
	local lineGo = self._lineGoMap[data.y]

	self._playPosInfo[data.x][data.y] = data.index

	goutil.addChildToParent(go, lineGo)

	local posX, posY = self:getLocalPosByPos(data.x, data.y)
	local roleCfg = OriginFightConfig.instance:getDungeonRoleCfgById(self._activityId, data.type)
	local path = roleCfg.modelRes

	if self._playerGoMap[data.index] then
		if not self._playerGoMap[data.index].obj then
			local obj

			obj = RoleObjectPool.instance:addSpineToParent(obj, path, con, 0.2, function()
				RoleObjectPool.instance:playAnimation(con, "idle", true)
			end, 0, 0)
			self._playerGoMap[data.index] = {
				go = go,
				x = data.x,
				y = data.y,
				index = data.index,
				obj = obj,
				type = data.type
			}

			GameUtil.setAnchoredPos(go, posX, posY)

			txtType.text = data.type
		end
	end
end

function OriginFightBoneDragonDungeonGameView:pos2Id(row, col)
	return (row - 1) * self._col + col
end

function OriginFightBoneDragonDungeonGameView:getLocalPosByPos(row, col)
	local bgSizeX, bgSizeY = self:getBgCellSize()
	local posX, posY = GameUtil.getPosWihtRowAndCol(bgSizeX, bgSizeY, self:pos2Id(row, col), self._row, self._col, 0, 0)

	return posY - self._offsetY + bgSizeY / 2, -posX + self._offsetX - bgSizeX / 2
end

function OriginFightBoneDragonDungeonGameView:_updateRoleCell(view, cell, data, tag)
	local go = cell.gameObject
	local typeTableView = goutil.findChild(go, "typeTableView")
	local txtType = goutil.findChildTextComponent(go, "txtType")
	local icon = goutil.findChild(go, "icon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local roleType = self._stageCfg.roles[data.index]
	local roleCfg = OriginFightConfig.instance:getDungeonRoleCfgById(self._activityId, roleType)

	txtType.text = roleType
	txtName.text = roleCfg.name

	if typeTableView and self._typeTableCell then
		if not self._typeListMap[typeTableView] then
			local typeTableList = ScrollerList.create(typeTableView, self._typeTableCell, GameUtil.handler(self._updateTypeCell, self), GameUtil.handler(self._clearTypeCell, self))

			self._typeListMap[typeTableView] = self._typeListMap[typeTableView]

			self._typeListMap[typeTableView]:reloadData(roleCfg.specificEventTypes)
		end
	end

	uGuiUtil.clearImage(icon)
	uGuiUtil.setSpriteToImage(icon, nil, roleCfg.headIconRes)
end

function OriginFightBoneDragonDungeonGameView:_clearRoleCell(cell)
	local go = cell.gameObject
	local typeTableView = goutil.findChild(go, "typeTableView")
	local icon = goutil.findChild(go, "icon")

	if self._typeListMap[typeTableView] then
		self._typeListMap[typeTableView]:dispose()

		self._typeListMap[typeTableView] = nil
	end

	uGuiUtil.clearImage(icon)
end

function OriginFightBoneDragonDungeonGameView:_updateTypeCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChange = goutil.findChildComponent(go, "img", ComponentType.UIImageSpriteChange)
	local imgColorChange = goutil.findChildComponent(go, "img", ComponentType.UIImageColorChange)
	local finishGo = goutil.findChild(go, "finish")

	if data == EventType.Battle then
		imgChange:SetState(10)
	elseif data == EventType.SwitchCtrl then
		imgChange:SetState(2)
	elseif data == EventType.Rail then
		imgChange:SetState(4)
	elseif data == EventType.Barrier then
		imgChange:SetState(7)
	elseif data == EventType.Believer then
		imgChange:SetState(9)
	elseif data == EventType.Injured then
		imgChange:SetState(8)
	elseif data == EventType.Chest then
		imgChange:SetState(0)
	elseif data == EventType.Exit then
		imgChange:SetState(1)
	end

	if not self._typeFinishState[data] then
		local isFinish = false

		if isFinish == true then
			imgColorChange:SetState(1)
		else
			imgColorChange:SetState(0)
		end

		GameUtil.SetActive(finishGo, isFinish)
	end
end

function OriginFightBoneDragonDungeonGameView:_clearTypeCell(cell)
	return
end

function OriginFightBoneDragonDungeonGameView:_initTypeFinish()
	self._typeFinishState = {
		[EventType.Battle] = true,
		[EventType.SwitchCtrl] = false,
		[EventType.Rail] = false,
		[EventType.Barrier] = true,
		[EventType.Believer] = true,
		[EventType.Injured] = true,
		[EventType.Chest] = true,
		[EventType.Exit] = false
	}
end

function OriginFightBoneDragonDungeonGameView:_checkTypeFinish()
	self:_initTypeFinish()

	local eventCfgs = OriginFightConfig.instance:getDungeonEventCfgs(self._stageId)

	for i, v in ipairs(eventCfgs) do
		if not OriginFightModel.instance:isEventFinish(v.eventId) then
			self._typeFinishState[v.eventType] = false
		end
	end
end

function OriginFightBoneDragonDungeonGameView:_moveDir(dirX, dirY)
	if self._isMove == true then
		return false
	end

	self._moveCount = 0

	local hasChange = false

	for i, v in pairs(self._playerGoMap) do
		local moveX = v.x + dirX
		local moveY = v.y + dirY
		local isBlock = not self:_isBlock(moveX, moveY, dirX, dirY)

		if isBlock == true then
			self._isMove = true
			v.x = moveX
			v.y = moveY

			local posX, posY = self:getLocalPosByPos(v.x, v.y)
			local curPos = GameUtil.getAnchoredPos(v.go)
			local con = goutil.findChild(v.go, "con")
			local scaleCon = GameUtil.getLocalScale(con)

			if dirX < 0 then
				GameUtil.setLocalScale(con, -math.abs(scaleCon.x), scaleCon.y, scaleCon.z)
				RoleObjectPool.instance:playAnimation(con, "move", true, nil, true)
			else
				GameUtil.setLocalScale(con, math.abs(scaleCon.x), scaleCon.y, scaleCon.z)
				RoleObjectPool.instance:playAnimation(con, "move", true, nil, true)
			end

			local tweens = UnityTweens.TweenPosition.Create(v.go, Vector3.New(curPos.x, curPos.y, 0), Vector3.New(posX, posY, 0), 0.5, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)

			self._moveCount = self._moveCount + 1

			tweens:AddListener(function()
				local lineGo = self._lineGoMap[v.y]

				goutil.addChildToParent(v.go, lineGo)
				GameUtil.setAnchoredPos(v.go, posX, posY)
				self:_checkMove()
				RoleObjectPool.instance:playAnimation(con, "idle", true, nil, true)
			end, self)

			hasChange = true
		end
	end

	return hasChange
end

function OriginFightBoneDragonDungeonGameView:_checkMove()
	self._moveCount = self._moveCount - 1

	if self._moveCount <= 0 then
		self._isMove = false

		for i, lineInfo in pairs(self._playPosInfo) do
			for j, v in pairs(lineInfo) do
				self._playPosInfo[i][j] = 0
			end
		end

		local isOnExit = true

		for k, v in pairs(self._playerGoMap) do
			self._playPosInfo[v.x][v.y] = v.index

			if self._mapInfo[v.x][v.y] ~= 0 then
				local eventCfg = OriginFightConfig.instance:getDungeonEventCfgById(self._stageCfg.eventPlanId, self._mapInfo[v.x][v.y])

				if eventCfg.eventType ~= EventType.Exit then
					isOnExit = false
				end
			else
				isOnExit = false
			end
		end

		self._inOnExit = isOnExit

		self:_checkOperate()

		if isOnExit == true then
			local isAllComplete = true
			local eventCfgs = OriginFightConfig.instance:getDungeonEventCfgs(self._stageId)

			for i, v in ipairs(eventCfgs) do
				if v.finishToExit == true and not OriginFightModel.instance:isEventFinish(v.eventId) then
					isAllComplete = false
				end
			end

			if isAllComplete == false then
				FloatWordMgr.instance:show(lang("存在未完成的事件"))
			else
				self:_onClickClose()
			end
		end
	end
end

function OriginFightBoneDragonDungeonGameView:_isBlock(moveX, moveY, dirX, dirY)
	if moveX <= 0 or moveX > self._row or moveY <= 0 or moveY > self._col then
		return true
	end

	local isEventBlock = false
	local eventId = self._mapInfo[moveX][moveY]

	if eventId ~= 0 then
		local eventCfg = OriginFightConfig.instance:getDungeonEventCfgById(self._stageId, eventId)

		isEventBlock = eventCfg.eventType == EventType.Rail and not OriginFightModel.instance:isRailOpen(eventId) or eventCfg.eventType ~= EventType.Exit
	end

	if isEventBlock == true then
		return true
	elseif self._playPosInfo[moveX][moveY] ~= 0 then
		return self:_isBlock(moveX + dirX, moveY + dirY, dirX, dirY)
	else
		return false
	end
end

function OriginFightBoneDragonDungeonGameView:_checkOperate()
	table.clear(self._operationList)

	for x, line in pairs(self._playPosInfo) do
		for y, v in pairs(line) do
			if v ~= 0 then
				local playerType = self._stageCfg.roles[v]

				if self:_isCanOperate(playerType, x, y) == true then
					table.insert(self._operationList, {
						x = x,
						y = y,
						roleId = playerType
					})
				end

				if self:_isCanOperate(playerType, x + 1, y) == true then
					table.insert(self._operationList, {
						x = x + 1,
						y = y,
						roleId = playerType
					})
				end

				if self:_isCanOperate(playerType, x - 1, y) == true then
					table.insert(self._operationList, {
						x = x - 1,
						y = y,
						roleId = playerType
					})
				end

				if self:_isCanOperate(playerType, x, y + 1) == true then
					table.insert(self._operationList, {
						x = x,
						y = y + 1,
						roleId = playerType
					})
				end

				if self:_isCanOperate(playerType, x, y - 1) == true then
					table.insert(self._operationList, {
						x = x,
						y = y - 1,
						roleId = playerType
					})
				end
			end
		end
	end

	self:_refreshLink()
end

function OriginFightBoneDragonDungeonGameView:_isCanOperate(playerType, x, y)
	if x <= 0 or x > self._row or y <= 0 or y > self._col then
		return false
	end

	local eventId = self._mapInfo[x][y]

	if eventId == 0 then
		return false
	else
		local eventCfg = OriginFightConfig.instance:getDungeonEventCfgById(self._stageId, eventId)
		local roleCfg = OriginFightConfig.instance:getDungeonRoleCfgById(self._activityId, playerType)

		for i, v in ipairs(roleCfg.specificEventTypes) do
			if eventCfg.eventType == v then
				return true
			end
		end

		return false
	end
end

function OriginFightBoneDragonDungeonGameView:_refreshLink()
	for i = 1, self._col do
		for j = 1, self._row do
			self:_selectCell(i, j, false)
		end
	end

	GameUtil.updateCellsList(self._linkContainer, self._linkCon, self._operationList, self._updateLinkCell, self)
end

function OriginFightBoneDragonDungeonGameView:_clearAllLink()
	for i = 1, self._col do
		for j = 1, self._row do
			self:_selectCell(i, j, false)
		end
	end

	GameUtil.updateCellsList(self._linkContainer, self._linkCon, {}, self._updateLinkCell, self)
end

function OriginFightBoneDragonDungeonGameView:_updateLinkCell(cell, data, index)
	local go = cell.gameObject
	local hengGo = goutil.findChild(go, "heng")
	local shuGo = goutil.findChild(go, "shu")
	local targetGoInfo

	if self._playerGoMap then
		for playerIndex, goInfo in pairs(self._playerGoMap) do
			if goInfo.type == data.roleId then
				targetGoInfo = goInfo
			end
		end
	end

	if not targetGoInfo then
		return
	end

	GameUtil.SetActive(hengGo, targetGoInfo.y == data.y)
	GameUtil.SetActive(shuGo, targetGoInfo.x == data.x)

	local eventPosX, eventPosY = self:getLocalPosByPos(data.x, data.y)
	local playerPosX, playerPosY = self:getLocalPosByPos(targetGoInfo.x, targetGoInfo.y)

	GameUtil.setAnchoredPos(go, (eventPosX + playerPosX) / 2, (eventPosY + playerPosY) / 2)
	self:_selectCell(targetGoInfo.x, targetGoInfo.y, true)
	self:_selectCell(data.x, data.y, true)
end

function OriginFightBoneDragonDungeonGameView:_clearLinkCell()
	return
end

function OriginFightBoneDragonDungeonGameView:_clearMap()
	if self._eventGoMap then
		for i, v in pairs(self._eventGoMap) do
			goutil.addChildToParent(v, self._eventCellContainer)
			GameUtil.SetActive(v)
		end

		self._eventGoMap = nil

		GameUtil.clearCells(self._eventCellContainer, nil, nil, true)
	end

	if self._playerGoMap then
		for i, v in pairs(self._playerGoMap) do
			goutil.addChildToParent(v.go, self._playerContainer)
			GameUtil.SetActive(v.go)
		end

		self._playerGoMap = nil

		GameUtil.clearCells(self._playerContainer, nil, nil, true)
	end
end

function OriginFightBoneDragonDungeonGameView:_enterNewMap()
	OriginFightModel.instance:initRailState(self._activityId, self._stageId)
	OriginFightModel.instance:initSwitchState(self._activityId, self._stageId)

	self._gamming = false

	self:_initMap()

	self._tempCount = 0

	for i, v in pairs(self._playerGoMap) do
		self:stopViewEffectUniGo(v.go)

		self._tempCount = self._tempCount + 1

		self:playViewEffectUniGo(EFFECT_PATH_LUO_DI, v.go, nil, false, function()
			self._tempCount = self._tempCount - 1

			if self._tempCount <= 0 then
				self._gamming = true
			end
		end)
	end

	if self._tempCount <= 0 then
		self._gamming = true
	end
end

function OriginFightBoneDragonDungeonGameView:_refreshExitState()
	self._exitOpen = self:_checkExitOpen()

	for eventId, go in pairs(self._eventGoMap) do
		local eventCfg = OriginFightConfig.instance:getDungeonEventCfgById(self._stageId, eventId)

		if eventCfg.eventType == EventType.Exit then
			self:_setExitState(go, self._exitOpen)
		end
	end
end

function OriginFightBoneDragonDungeonGameView:_checkExitOpen()
	local eventCfgs = OriginFightConfig.instance:getDungeonEventCfgs(self._stageId)
	local isAllEventFinish = true

	for i, v in ipairs(eventCfgs) do
		if v.finishToExit == true and not OriginFightModel.instance:isEventFinish(v.eventId) then
			isAllEventFinish = false
		end
	end

	return isAllEventFinish
end

function OriginFightBoneDragonDungeonGameView:_onClickBlock(posX, posY)
	if self._isEffectPlaying == true then
		return
	end

	if #self._operationList <= 0 then
		FloatWordMgr.instance:show(lang("该地块没有可互动的事件噢"))

		return
	end

	local hasSelect = false
	local selectRole

	for i, v in ipairs(self._operationList) do
		if v.x == posX and v.y == posY then
			selectRole = v.roleId
			hasSelect = true

			break
		end
	end

	if hasSelect then
		self._selectX = posX
		self._selectY = posY
		self._selectRole = selectRole

		self:_onClickOperate()
	else
		FloatWordMgr.instance:show(lang("没有角色可互动的事件噢"))
	end
end

function OriginFightBoneDragonDungeonGameView:_onClickRight()
	if self._gamming == true and self:_moveDir(1, 0) == true then
		self._isMoving = true

		self:_clearAllLink()
	end
end

function OriginFightBoneDragonDungeonGameView:_onClickLeft()
	if self._gamming == true and self:_moveDir(-1, 0) == true then
		self._isMoving = true

		self:_clearAllLink()
	end
end

function OriginFightBoneDragonDungeonGameView:_onClickUp()
	if self._gamming == true and self:_moveDir(0, -1) == true then
		self._isMoving = true

		self:_clearAllLink()
	end
end

function OriginFightBoneDragonDungeonGameView:_onClickDown()
	if self._gamming == true and self:_moveDir(0, 1) == true then
		self._isMoving = true

		self:_clearAllLink()
	end
end

function OriginFightBoneDragonDungeonGameView:_onClickOperate()
	if self._isEffectPlaying == true then
		return
	end

	if #self._operationList > 0 then
		local isSame = true
		local sameX, sameY

		for i, v in ipairs(self._operationList) do
			if not sameX and not sameY then
				sameX = v.x
				sameY = v.y
			end

			if sameX ~= v.x or sameY ~= v.y then
				isSame = false

				break
			end
		end

		if isSame == true then
			self._selectX, self._selectY, self._selectRole = self._operationList[1].x, self._operationList[1].y, self._operationList[1].roleId
		end
	end

	if self._selectX == 0 or self._selectY == 0 then
		FloatWordMgr.instance:show(lang("靠近并点击选中后才能交互事件噢"))

		return
	end

	if not self._gamming then
		FloatWordMgr.instance:show(lang("游戏未开始，请稍后"))

		return
	end

	local eventId = self._mapInfo[self._selectX][self._selectY]
	local eventGo = self._eventGoMap[eventId]
	local eventCfg = OriginFightConfig.instance:getDungeonEventCfgById(self._stageId, eventId)

	if eventCfg.eventType == EventType.SwitchCtrl then
		self:handlerEventSwitchCtrl(eventId, eventGo)
	elseif eventCfg.eventType == EventType.Believer then
		self:handlerEventBeliever(eventId, eventGo)
	elseif eventCfg.eventType == EventType.Injured then
		self:handlerEventInjured(eventId, eventGo)
	elseif eventCfg.eventType == EventType.Chest then
		self:handlerEventChest(eventId, eventGo)
	end

	self:_checkOperate()
end

function OriginFightBoneDragonDungeonGameView:_onClickClose()
	local content = lang("中途离开当前地图将还原至初始状态，是否继续？\n<color=#FF4444FF>注：仅还原角色位置、路障状态。</color>")

	if not self._inOnExit then
		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			self:_PM_BoneDragonDungeonExitOrResetRes(true)
		end)
	else
		OriginFightController.instance:sendPM_OriginFightCommonGodFavorReq(self._activityId, self._godFavorId)
	end
end

function OriginFightBoneDragonDungeonGameView:_onClickTip()
	TipsFacade.instance:openRulesView("bone_dragon_dungeon_rule")
end

function OriginFightBoneDragonDungeonGameView:_onClickShop()
	UIStateManager.instance:push(ViewName.BoneDragonDungeonShopView, self._activityId)
end

function OriginFightBoneDragonDungeonGameView:_onClickReset()
	local content = lang("当前地图将还原至初始状态，是否继续？\n<color=#FF4444FF>注：仅还原角色位置、路障状态。</color>")

	TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
		self:_PM_BoneDragonDungeonExitOrResetRes(false)
	end)
end

function OriginFightBoneDragonDungeonGameView:handlerEventSwitchCtrl(eventId, eventGo)
	self:_PM_BoneDragonDungeonHandleEventRes()

	local eventCfg = OriginFightConfig.instance:getDungeonEventCfgById(self._stageId, eventId)
	local railArrs = string.split(eventCfg.eventParam, ",")
	local isBlock = false

	for i, v in ipairs(railArrs) do
		local railEventId = checknumber(v)
		local railEventCfg = OriginFightConfig.instance:getDungeonEventCfgById(self._stageId, eventId)

		if self._playPosInfo[railEventCfg.x + 1][railEventCfg.y + 1] ~= 0 then
			isBlock = true

			break
		end
	end

	if isBlock == true then
		FloatWordMgr.instance:show(lang("栏杆处有角色"))

		return
	end

	self:stopViewEffectUniGo(eventGo)
	self:playViewEffectUniGo(EFFECT_PATH_JIAO_HU, eventGo, nil, false, nil, function()
		self:_doSwitchAction(eventId, railArrs)
	end)
end

function OriginFightBoneDragonDungeonGameView:_doSwitchAction(eventId, railArrs)
	OriginFightModel.instance:switchSwitchState(eventId)

	for i, v in ipairs(railArrs) do
		local railEventId = checknumber(v)

		OriginFightModel.instance:switchRailState(railEventId)
	end

	for railEventId, openState in pairs(OriginFightModel.instance:getSwitchStateMap()) do
		self:_setSwitchCtrlState(self._eventGoMap[railEventId], openState)
	end

	for railEventId, openState in pairs(OriginFightModel.instance:getRailStateMap()) do
		self:_setRailState(self._eventGoMap[railEventId], openState)
	end
end

function OriginFightBoneDragonDungeonGameView:handlerEventBeliever(eventId)
	self._isEffectPlaying = true

	local eventGo = self._eventGoMap[eventId]
	local effectGo = self._effectPool:fetchObject()
	local pos = GameUtil.getAnchoredPos(eventGo)

	GameUtil.setAnchoredPos(effectGo, pos.x, pos.y)
	GameUtil.SetActive(effectGo, true)
	self:playViewEffectUniGo(EFFECT_PATH_JIAO_HU, effectGo, nil, false, function()
		self._effectPool:returnObject(effectGo)
	end)
	settimer(0.8, function()
		self:_onBelieverEffectEnd(eventId, eventGo)
	end, self, false)
end

function OriginFightBoneDragonDungeonGameView:_onBelieverEffectEnd(eventId, eventGo)
	self._isEffectPlaying = false

	self:_PM_BoneDragonDungeonHandleEventRes()

	self._mapInfo[self._selectX][self._selectY] = 0

	GameUtil.SetActive(eventGo, false)
end

function OriginFightBoneDragonDungeonGameView:handlerEventInjured(eventId)
	self._isEffectPlaying = true

	local eventGo = self._eventGoMap[eventId]
	local effectGo = self._effectPool:fetchObject()
	local pos = GameUtil.getAnchoredPos(eventGo)

	GameUtil.setAnchoredPos(effectGo, pos.x, pos.y)
	GameUtil.SetActive(effectGo, true)
	self:playViewEffectUniGo(EFFECT_PATH_JIAO_HU, effectGo, nil, false, function()
		self._effectPool:returnObject(effectGo)
	end)
	settimer(0.8, function()
		self:_onInjuredEffectEnd(eventId, eventGo)
	end, self, false)
end

function OriginFightBoneDragonDungeonGameView:_onInjuredEffectEnd(eventId, eventGo)
	self._isEffectPlaying = false

	self:_PM_BoneDragonDungeonHandleEventRes()

	self._mapInfo[self._selectX][self._selectY] = 0

	GameUtil.SetActive(eventGo, false)
end

function OriginFightBoneDragonDungeonGameView:handlerEventChest(eventId)
	self._isEffectPlaying = true

	local eventGo = self._eventGoMap[eventId]
	local effectGo = self._effectPool:fetchObject()
	local pos = GameUtil.getAnchoredPos(eventGo)

	GameUtil.setAnchoredPos(effectGo, pos.x, pos.y)
	GameUtil.SetActive(effectGo, true)
	self:playViewEffectUniGo(EFFECT_PATH_JIAO_HU, effectGo, nil, false, function()
		self._effectPool:returnObject(effectGo)
	end)
	settimer(0.8, function()
		self:_onChestEffectEnd(eventId, eventGo)
	end, self, false)
end

function OriginFightBoneDragonDungeonGameView:_onChestEffectEnd(eventId, eventGo)
	self._isEffectPlaying = false

	self:_PM_BoneDragonDungeonHandleEventRes()

	self._mapInfo[self._selectX][self._selectY] = 0

	GameUtil.SetActive(eventGo, false)
end

function OriginFightBoneDragonDungeonGameView:_PM_BoneDragonDungeonExitOrResetRes(isExit)
	if isExit == true then
		self:close()
	else
		self:_initMap()
	end
end

function OriginFightBoneDragonDungeonGameView:_PM_BoneDragonDungeonHandleEventRes()
	self:_checkOperate()
	self:_refreshExitState()
	self:_checkTypeFinish()
	self._roleTableList:refresh()
end

function OriginFightBoneDragonDungeonGameView:_onGodFavorRes()
	local storyId = OriginFightConfig.instance:getStoryIdById(self._activityId, self._godFavorId)

	OriginFightModel.instance:pushStoryId(storyId)
	self:_PM_BoneDragonDungeonExitOrResetRes(true)
end

return OriginFightBoneDragonDungeonGameView
