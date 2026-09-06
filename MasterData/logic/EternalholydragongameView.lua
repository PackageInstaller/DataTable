-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/view/EternalholydragongameView.lua

module("logic.extensions.eternalholydragon.view.EternalholydragongameView", package.seeall)

local EternalholydragongameView = class("EternalholydragongameView", ViewComponent)

EternalholydragongameView.RowSpace = 106
EternalholydragongameView.ColSpace = 109
EternalholydragongameView.MapCellNamePre = "mapcell"

function EternalholydragongameView:ctor()
	EternalholydragongameView.super.ctor(self)
end

function EternalholydragongameView:destroyUI()
	for i, list in pairs(self._mapObj) do
		for k, v in pairs(list) do
			v:destroyUI()
		end
	end
end

function EternalholydragongameView:unbindEvents()
	EternalholydragongameView.super.unbindEvents(self)
	self._btnGoto:RemoveClickListener()
	self._btnRevert:RemoveClickListener()
	self._btnDropCancel:RemoveClickListener()
	self._btnDropSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnclosepanel:RemoveClickListener()
	self._btncloselanditem:RemoveClickListener()
	self._btnHideItem:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnClosePass:RemoveClickListener()
end

function EternalholydragongameView:bindEvents()
	EternalholydragongameView.super.bindEvents(self)
	self._btnGoto:AddClickListener(self._onClickbtnGoto, self)
	self._btnRevert:AddClickListener(self._onClickbtnRevert, self)
	self._btnDropCancel:AddClickListener(self._onClickbtnDropCancel, self)
	self._btnDropSure:AddClickListener(self._onClickbtnDropSure, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnclosepanel:AddClickListener(self._onCliclBtnClosepanel, self)
	self._btncloselanditem:AddClickListener(self._onClickbtncloselanditem, self)
	self._btnHideItem:AddClickListener(self._onClickbtnHideItem, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClosePass:AddClickListener(self._onClickbtnClosePass, self)
end

function EternalholydragongameView:buildUI()
	EternalholydragongameView.super.buildUI(self)

	self._mapcellGo = self:getGo("mapcell")
	self._mapGo = self:getGo("map/con")

	self:_buildMap(self._mapGo, self._mapcellGo)

	self._itemconSingleLine = self:getGo("items/content/con"):GetComponent(ComponentType.UILayoutSingleLine)
	self._itemconGo = self:getGo("items/content/con")
	self._itemcellGo = self:getGo("items/content/cell")
	self._itemGroup = ItemGroup.New(self._itemconGo, self._itemcellGo, nil, nil, true, self._clearItemCell, self)
	self._btnGoto = self:getBtn("dragvisible/btnGoto")
	self._btnRevert = self:getBtn("dragvisible/btnRevert")
	self._choosepanelGo = self:getGo("choosepanel")
	self._btnDropCancel = self:getBtn("choosepanel/content/btnDropCancel")
	self._btnDropSure = self:getBtn("choosepanel/content/btnDropSure")
	self._btnClose = self:getBtn("dragvisible/btnClose")

	local headcellGo = self:getGo("map/headcell")

	self._headcellTr = headcellGo.transform
	self._headcellTween = headcellGo:GetComponent(UnityTweensType.TweenPosition)
	self._tipGo = self:getGo("dragvisible/top/tip")
	self._txtTip = self:getTxt("dragvisible/top/tip/txtTip")
	self._txtRound = self:getTxt("dragvisible/top/txtRound")
	self._btnclosepanel = self:getBtn("choosepanel/btnclosepanel")
	self._chooscontentGo = self:getGo("choosepanel/content")
	self._txtItemTip = self:getTxt("items/content/txtItemTip")
	self._dragvisibleGo = self:getGo("dragvisible")
	self._itemsTr = self:getGo("items").transform
	self._itemContentTr = self:getGo("items/content").transform
	self._btncloselanditem = self:getBtn("btncloselanditem")
	self._btnHideItem = self:getBtn("items/content/btnHideItem")
	self._txtTitle = self:getTxt("dragvisible/txtTitle")
	self._btnTip = self:getBtn("dragvisible/btnTip")
	self._myheadIconGo = self:getGo("map/headcell/icon")
	self._passStageGo = self:getGo("passStage")
	self._btnClosePass = self:getBtn("passStage/btnClosePass")

	goutil.setActive(self._passStageGo, false)
end

function EternalholydragongameView:_buildMap(mapcon, mapcell)
	goutil.setActive(mapcell, true)

	self._mapObj = {}

	for i = 0, EternalholydragonController.MaxRow - 1 do
		for j = 0, EternalholydragonController.MaxCol - 1 do
			local go = goutil.cloneAndSetParent(mapcell, mapcon.transform, EternalholydragongameView.MapCellNamePre .. "_" .. i .. "_" .. j)
			local obj = EternalholydragonMapItem.New()

			obj:setIndex(i, j)
			obj:buildUI(go)
			DropHandler.Get(obj.dropGo):AddLuaHandler(function(_go, eventData)
				self:_onDrop(obj)
			end)
			PointerEnterHandler.Get(obj.dropGo):AddLuaHandler(function(_go, eventData)
				self:_onEnterCell(obj)
			end)
			PointerExitHandler.Get(obj.dropGo):AddLuaHandler(function(_go, eventData)
				self:_onExitCell(obj)
			end)

			self._mapObj[i] = self._mapObj[i] or {}
			self._mapObj[i][j] = obj

			local col = j
			local row = i
			local x = col * EternalholydragongameView.RowSpace
			local y = row * EternalholydragongameView.ColSpace

			Framework.TransformUtil.SetAnchoredPos(go.transform, x, -y)
		end
	end

	goutil.setActive(mapcell, false)
end

function EternalholydragongameView:onExit()
	EternalholydragongameView.super.onExit(self)
	self._itemGroup:dispose()
	GlobalModel.instance:setUIInteractable(true)
	uGuiUtil.clearImage(self._myheadIconGo)

	for i, list in pairs(self._mapObj) do
		for k, v in pairs(list) do
			v:onExit()
		end
	end
end

function EternalholydragongameView:onEnter()
	EternalholydragongameView.super.onEnter(self)
	self.addGEvent(self, EternalHolyDragonChallengeAgent.EHolyDragonClgForwardRes, self._onForward, self)
	self.addGEvent(self, EternalHolyDragonChallengeAgent.EHolyDragonClgResetStageRes, self._onResetStage, self)
	self.addGEvent(self, EternalHolyDragonChallengeAgent.EHolyDragonClgUseItemOnLandRes, self._updateUI, self)
	self.addGEvent(self, EternalholydragonController.GotoNextBattle, self._onClickbtnGoto, self)

	self._activityId = EternalholydragonModel.instance:getActivityId()

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self._headcellTween:Stop()

	self._itemRangEffect = {}

	goutil.setActive(self._choosepanelGo, false)
	self:_updateUI()
	self:_onCliclBtnClosepanel()
	self:_clearCache()

	self._hideItemContent = false

	self:_setAoqiGodUI()
	self:_setItemsContenet()
	self:_setMyHead()
	self:_setPassStage()
end

function EternalholydragongameView:onEnterFinished()
	EternalholydragongameView.super.onEnterFinished(self)
	self:_showItemGet()
end

function EternalholydragongameView:_setAoqiGodUI()
	GameUtil.SetActive(self._tipGo, not self._isAoqiGodProcessType)
end

function EternalholydragongameView:_clearCache()
	self._currPathObj = nil
	self._endPathObj = nil

	self:_hideItemRangeEffect()

	self._dragGo = nil
	self._dragItemId = 0
	self._isDropInMapCell = false
end

function EternalholydragongameView:_onClickbtnGoto()
	if self._isMoving then
		return
	end

	self._currPathObj = nil
	self._endPathObj = nil

	if self._movePathObjHead and self._info then
		local curObj = self._movePathObjHead

		while curObj do
			local r, c = curObj.obj:getIndex()

			if r == self._info.pos.x and c == self._info.pos.y then
				break
			end

			curObj = curObj.nextPathObj
		end

		if curObj then
			local endObj
			local curObj2 = curObj

			while curObj2 do
				local t = curObj2.obj:getType()

				if EternalholydragonMapItem.Type.Battle == t then
					endObj = curObj2

					break
				end

				curObj2 = curObj2.nextPathObj
			end

			if endObj then
				if curObj then
					if curObj.nextPathObj == endObj then
						local r, c = endObj.obj:getIndex()
						local creepsMasterId = checknumber(endObj.obj:getGridElementParams())

						EternalholydragonController.instance:enterMission(r, c, creepsMasterId)
					else
						self._currPathObj = curObj
						self._endPathObj = endObj

						EternalHolyDragonChallengeAgent.instance:sendPM_EHolyDragonClgForwardReq(self._activityId)
					end
				end
			else
				FloatWordMgr.instance:show("前方畅通无阻")
			end
		end
	end
end

function EternalholydragongameView:_onClickbtnRevert()
	if self._info then
		local row, col = EternalholydragonController.instance:getStartPos(self._mapCfgs)
		local ginfos = EternalholydragonModel.instance:getGridInfos()

		if self._info.pos.x == row and self._info.pos.y == col and #ginfos <= 0 then
			FloatWordMgr.instance:show("未挑战 无需重置该关卡")

			return
		end

		local content = "是否重置本关卡?"

		TipsFacade.instance:openPopupWindow("提示", content, function()
			EternalHolyDragonChallengeAgent.instance:sendPM_EHolyDragonClgResetStageReq(self._activityId)
		end)
	end
end

function EternalholydragongameView:_onClickbtnDropCancel()
	if self._dropOpObj then
		self._dropOpObj:resetIcon()
	end

	goutil.setActive(self._choosepanelGo, false)
	self:_hideItemRangeEffect()
	self:_resetDragItem()

	self._dropOpObj = nil
	self._dragItemId = nil
end

function EternalholydragongameView:_onClickbtnDropSure(force)
	local isClearId = EternalholydragonController:isClearLandMonsterItemId(self._itemPlanId, self._dragItemId)

	if isClearId and not force then
		local content = "是否清除此障碍?"

		TipsFacade.instance:openPopupWindow("提示", content, function()
			self:_onClickbtnDropSure(true)
		end)
	else
		goutil.setActive(self._choosepanelGo, false)
		self:_hideItemRangeEffect()

		if self._dropOpObj and self._dragItemId then
			local row, col = self._dropOpObj:getIndex()

			EternalHolyDragonChallengeAgent.instance:sendPM_EHolyDragonClgUseItemOnLandReq(self._activityId, self._dragItemId, {
				x = row,
				y = col
			})
			self._dropOpObj:resetIcon()

			self._dropOpObj = nil
			self._dragItemId = nil
		end
	end

	self:_resetDragItem()
end

function EternalholydragongameView:_onClickbtnClose()
	self:close()
end

function EternalholydragongameView:_updateUI()
	self._info = EternalholydragonModel.instance:getInfo()

	if not self._info then
		return
	end

	self:_setItems()
	self:_setMap()
	self:_setRound()
end

function EternalholydragongameView:_setItems()
	if not self._info then
		return
	end

	local stageId = self._info.clgProgress + 1
	local stageCfg = EternalholydragonConfig.instance:getStageCfg(self._activityId, stageId)

	self._itemPlanId = stageCfg.itemPlanId

	local ownedItem = EternalholydragonModel.instance:getOwnedItem()
	local itemIds = {}

	for i, v in ipairs(ownedItem) do
		for j = 1, v.value do
			table.insert(itemIds, v.id)
		end
	end

	self._itemGroup:updateWithMoArray(itemIds, self._updateItemCell, self)
	self._itemconSingleLine:Layout()

	self._txtItemTip.text = string.format("<color=#ffb400>提示：</color>可拖拽使用物品，最多存<color=red>%s</color>种", stageCfg.itemMaxOwnCount)
end

function EternalholydragongameView:_updateItemCell(item, itemId)
	local iconGo = goutil.findChild(item.mainGO, "icon")
	local btn = Framework.ButtonAdapter.Get(iconGo)
	local iconChange = iconGo:GetComponent(ComponentType.UIImageSpriteChange)
	local cfg = EternalholydragonConfig.instance:getItemCfg(self._itemPlanId, itemId)

	uGuiUtil.setSpriteToImage(iconGo, nil, cfg.iconName .. ".png")
	BeginDragHandler.Get(iconGo):AddLuaHandler(function(_go, eventData)
		self:_onBeginDrag(_go, itemId)
	end)
	EndDragHandler.Get(iconGo):AddLuaHandler(function(_go, eventData)
		self:_onEndDrag(_go, itemId)
	end)
	DragHandler.Get(iconGo):AddLuaHandler(function(_go, eventData)
		self:_onDragCell(_go, itemId)
	end)
	btn:AddClickListener(function()
		if self._dragGo then
			return
		end

		CommonTipsMgr.instance:showTips(cfg.desc, btn.gameObject)
	end)
end

function EternalholydragongameView:_clearItemCell(item)
	local iconGo = goutil.findChild(item.mainGO, "icon")

	uGuiUtil.clearImage(iconGo)
end

function EternalholydragongameView:_setMap()
	local stageCfg = EternalholydragonConfig.instance:getStageCfg(self._activityId, self._info.clgProgress + 1)

	self._mapId = stageCfg.mapId
	self._mapCfgs = EternalholydragonConfig.instance:getMapCfgs(self._mapId)
	self._movePathObjHead = self:_getMovePathObjs(self._mapCfgs)

	self:_setHeadCellPos()

	local gridInfo = EternalholydragonModel.instance:getGridInfos()
	local gridInfo_kv = {}
	local lua_gridInfo = {}

	for i, v in ipairs(gridInfo) do
		gridInfo_kv[v.pos.x] = gridInfo_kv[v.pos.x] or {}
		gridInfo_kv[v.pos.x][v.pos.y] = v
	end

	local endRow, endCol = EternalholydragonController.instance:getEndPos(self._mapCfgs)
	local count = 1

	for i = 0, EternalholydragonController.MaxRow - 1 do
		for j = 0, EternalholydragonController.MaxCol - 1 do
			local value = self._mapCfgs[i]["c" .. j]
			local oriLandValue = value

			if gridInfo_kv[i] and gridInfo_kv[i][j] then
				if value > 0 then
					local gridCfg = EternalholydragonConfig.instance:getGridCfg(self._mapCfgs[i].mapId, value)

					oriLandValue = gridCfg.gridType
				end

				lua_gridInfo[count] = {
					gridElementType = gridInfo_kv[i][j].gridElementType,
					gridElementParams = gridInfo_kv[i][j].gridElementParams
				}
			elseif value > 0 then
				local gridCfg = EternalholydragonConfig.instance:getGridCfg(self._mapCfgs[i].mapId, value)

				lua_gridInfo[count] = {
					gridElementType = gridCfg.gridElementType,
					gridElementParams = gridCfg.gridParams
				}
				oriLandValue = gridCfg.gridType
			else
				lua_gridInfo[count] = {
					gridElementType = 0
				}
			end

			lua_gridInfo[count].pos = {
				x = i,
				y = j
			}
			lua_gridInfo[count].oriLand = oriLandValue <= 0

			if endRow == i and endCol == j then
				lua_gridInfo[count].isBoos = true
			end

			count = count + 1
		end
	end

	for i, v in ipairs(lua_gridInfo) do
		self:_setMapCell(v)
	end
end

function EternalholydragongameView:_setMapCell(gridInfo)
	local obj = self._mapObj[gridInfo.pos.x][gridInfo.pos.y]

	obj:setData(gridInfo, self._mapCfgs, self._itemPlanId, self)
end

function EternalholydragongameView:_setHeadCellPos()
	if not self._info then
		return
	end

	local x, y

	if self._info.pos then
		y = self._info.pos.y
		x = self._info.pos.x
	else
		x, y = self._movePathObjHead.obj:getIndex()
	end

	Framework.TransformUtil.SetAnchoredPos(self._headcellTr, y * EternalholydragongameView.RowSpace, -x * EternalholydragongameView.ColSpace)
end

function EternalholydragongameView:_getMovePathObjs(mapCfgs)
	local startRow, startCol = EternalholydragonController.instance:getStartPos(mapCfgs)
	local endRow, endCol = EternalholydragonController.instance:getEndPos(mapCfgs)
	local visited = {}

	for i = 0, EternalholydragonController.MaxRow - 1 do
		visited[i] = {}

		for j = 0, EternalholydragonController.MaxCol - 1 do
			visited[i][j] = false
		end
	end

	local dx = {
		-1,
		1,
		0,
		0
	}
	local dy = {
		0,
		0,
		-1,
		1
	}
	local path = {}

	for i = 0, EternalholydragonController.MaxRow - 1 do
		path[i] = {}

		for j = 0, EternalholydragonController.MaxCol - 1 do
			path[i][j] = {
				walk = 0
			}
		end
	end

	local function isWalkable(x, y)
		if x < 0 or x > EternalholydragonController.MaxRow - 1 or y < 0 or y > EternalholydragonController.MaxCol - 1 then
			return false
		end

		if visited[x][y] then
			return false
		end

		local value = mapCfgs[x]["c" .. y]

		if value > 0 then
			local gcfg = EternalholydragonConfig.instance:getGridCfg(self._mapId, value)

			return gcfg.gridType == 1
		end

		return false
	end

	local function dfs(x, y, mo)
		visited[x][y] = true

		if x == endRow and y == endCol then
			return true
		end

		for i = 1, 4 do
			local nx = x + dx[i]
			local ny = y + dy[i]

			if isWalkable(nx, ny) then
				mo.nextPos = {
					nx,
					ny
				}

				if dfs(nx, ny, path[nx][ny]) then
					path[nx][ny].walk = 1

					return true
				end
			end
		end

		return false
	end

	path[startRow][startCol].walk = 1

	dfs(startRow, startCol, path[startRow][startCol])

	local obj = self._mapObj[startRow][startCol]
	local pathObjHead = {
		obj = obj,
		nextPos = path[startRow][startCol].nextPos
	}
	local pathObj = pathObjHead

	while pathObj.nextPos do
		local r, c = pathObj.nextPos[1], pathObj.nextPos[2]
		local p = {
			obj = self._mapObj[r][c],
			nextPos = path[r][c].nextPos
		}

		pathObj.nextPathObj = p
		pathObj = p
	end

	return pathObjHead
end

function EternalholydragongameView:_onDrop(obj)
	self._isDropInMapCell = true

	local isPass = false
	local isClearId = EternalholydragonController:isClearLandMonsterItemId(self._itemPlanId, self._dragItemId)

	if isClearId then
		if not obj:isCanDrop(self._dragItemId) then
			FloatWordMgr.instance:show("该道具使用必须有障碍物")

			isPass = false
		else
			isPass = true
		end
	elseif not obj:isCanDrop(self._dragItemId) then
		FloatWordMgr.instance:show("当前位置不可放置道具")

		isPass = false
	else
		isPass = true
	end

	if not isPass then
		self._isDropInMapCell = false

		self:_hideItemRangeEffect()
	else
		self:_pushChoosePanel(obj)
	end
end

function EternalholydragongameView:_pushChoosePanel(obj)
	goutil.setActive(self._choosepanelGo, true)

	self._dropOpObj = obj

	if self._dragItemId and self._dragItemId > 0 then
		obj:replaceIcon(self._dragItemId)
	end

	local x, y, z = Framework.TransformUtil.GetPos(obj.iconGo.transform, 0, 0, 0)

	Framework.TransformUtil.SetPos(self._chooscontentGo.transform, x, y, z)
end

function EternalholydragongameView:_onEnterCell(obj)
	if not self._dragGo then
		return
	end

	self:_hideItemRangeEffect()

	if not obj:isBlock() then
		local itemCfg = EternalholydragonConfig.instance:getItemCfg(self._itemPlanId, self._dragItemId)

		self:_showItemRangeEffect(obj, itemCfg.effectScope)
	end
end

function EternalholydragongameView:_onExitCell(obj)
	self:_hideItemRangeEffect()
end

function EternalholydragongameView:_onBeginDrag(go, itemId)
	self._dragGo = go
	self._dragItemId = itemId
	self._dragGo:GetComponent(goutil.Type_UIImage).raycastTarget = false

	goutil.setActive(self._choosepanelGo, false)
	goutil.setActive(self._dragvisibleGo, false)
	self:_setMapCellDropObjVisible(true)
	Framework.TransformUtil.SetAnchoredPos(self._itemsTr, 10000, 10000)
end

function EternalholydragongameView:_onEndDrag(go)
	if not self._isDropInMapCell then
		self:_hideItemRangeEffect()
	end

	self:_resetDragItem()
	self:_setMapCellDropObjVisible(false)
	goutil.setActive(self._dragvisibleGo, true)
	Framework.TransformUtil.SetAnchoredPos(self._itemsTr, 87, 70)
end

function EternalholydragongameView:_onDragCell()
	if not self._dragGo then
		return
	end

	self._dragGo.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function EternalholydragongameView:_hideItemRangeEffect()
	self._isDropInMapCell = false

	for k, obj in pairs(self._itemRangEffect) do
		obj:setRangeVisible(false)
	end

	self._itemRangEffect = {}
end

function EternalholydragongameView:_showItemRangeEffect(obj, effectScope)
	local row, col = obj:getIndex()

	obj:setRangeVisible(true)

	self._itemRangEffect[obj] = obj

	if not effectScope then
		return
	end

	for i, xy in ipairs(effectScope) do
		local targetRow = row + xy[2]
		local rowObjs = self._mapObj[targetRow]

		if rowObjs then
			local targetCol = col + xy[1]
			local targetObj = rowObjs[targetCol]

			if targetObj then
				targetObj:setRangeVisible(true)

				self._itemRangEffect[targetObj] = targetObj
			end
		end
	end
end

function EternalholydragongameView:_setMapCellDropObjVisible(visible)
	for i = 0, EternalholydragonController.MaxRow - 1 do
		for j = 0, EternalholydragonController.MaxCol - 1 do
			self._mapObj[i][j]:setDropObjVisible(visible)
		end
	end
end

function EternalholydragongameView:_onForward()
	if self._currPathObj and self._endPathObj then
		self:_doMove()
	end
end

function EternalholydragongameView:_realEnterMission()
	GlobalModel.instance:setUIInteractable(true)

	local r, c = self._endPathObj.obj:getIndex()
	local creepsMasterId = checknumber(self._endPathObj.obj:getGridElementParams())

	EternalholydragonController.instance:enterMission(r, c, creepsMasterId)

	self._currPathObj = nil
	self._endPathObj = nil
end

function EternalholydragongameView:_calMovePath()
	local moveLocalPaths = {}

	if self._currPathObj and self._endPathObj then
		if self._currPathObj == self._endPathObj or self._currPathObj.nextPathObj == self._endPathObj then
			return moveLocalPaths
		end

		local r, c
		local currPathObj = self._currPathObj

		while currPathObj and currPathObj ~= self._endPathObj do
			local var_48_0, var_48_1 = currPathObj.obj:getIndex()

			table.insert(moveLocalPaths, {
				y = -var_48_0 * EternalholydragongameView.RowSpace,
				x = var_48_1 * EternalholydragongameView.ColSpace
			})

			currPathObj = currPathObj.nextPathObj
		end
	end

	return moveLocalPaths
end

function EternalholydragongameView:_doMove()
	GlobalModel.instance:setUIInteractable(false)

	local moveLocalPaths = self:_calMovePath()

	if #moveLocalPaths <= 0 then
		self:_realEnterMission()
	else
		self._moveIndex = 0
		self._moveMaxIndex = #moveLocalPaths
		self._moveSpeed = 10
		self._moveLocalPaths = moveLocalPaths
		self._v3cache = Vector3.New(0, 0, 0)

		self:_move()
	end
end

function EternalholydragongameView:_move()
	if self._moveIndex >= self._moveMaxIndex - 1 then
		self._headcellTween:Stop()
		self._headcellTween:RemoveListener()
		self:_realEnterMission()

		self._isMoving = false

		return
	end

	self._isMoving = true
	self._moveIndex = self._moveIndex + 1

	local path = self._moveLocalPaths[self._moveIndex]

	if self._moveIndex == 1 then
		self._v3cache.x = path.x
		self._v3cache.y = path.y
		self._headcellTween.from = self._v3cache
	else
		self._v3cache.x = self._headcellTween.to.x
		self._v3cache.y = self._headcellTween.to.y
		self._headcellTween.from = self._v3cache
	end

	local nextPath = self._moveLocalPaths[self._moveIndex + 1]

	if nextPath then
		self._v3cache.x = nextPath.x
		self._v3cache.y = nextPath.y
		self._headcellTween.to = self._v3cache
	end

	self._headcellTween:RemoveListener()

	self._headcellTween.time = 0.3

	self._headcellTween:Begin()
	self._headcellTween:AddListener(self._move, self)
end

function EternalholydragongameView:_onResetStage()
	self:_setItems()
	self:_setMap()
end

function EternalholydragongameView:_setRound()
	if not self._info then
		return
	end

	local clgProgress = self._info.clgProgress + 1
	local cfgs = EternalholydragonConfig.instance:getStageCfgs(self._activityId)

	self._txtRound.text = string.format("回合：%s/%s", clgProgress, #cfgs)

	if not self._isAoqiGodProcessType then
		local stageCfg = EternalholydragonConfig.instance:getStageCfg(self._activityId, clgProgress)
		local matType, id, matNum = MaterialMgr.getMatParams(stageCfg.passStagePrize)
		local matName = MaterialMgr.getMaterialsName(matType, id)

		self._txtTip.text = string.format("通关本回合将获得\n%s张%s", matNum, matName)
		self._txtTitle.text = string.format("第%s回合", clgProgress)
	end
end

function EternalholydragongameView:_showItemGet()
	local hasR = EternalholydragonController.instance:hasRecordItem()

	if hasR then
		local isMax = EternalholydragonController.instance:isItemMax()

		if isMax then
			FloatWordMgr.instance:show("物品栏已满 不会获得该关卡奖励")
		else
			local newItems = EternalholydragonController.instance:getNewGainedItem()

			if newItems then
				for i, v in ipairs(newItems) do
					local cfg = EternalholydragonConfig.instance:getItemCfg(self._itemPlanId, v.id)

					FloatWordMgr.instance:show(string.format("已获得%s", cfg.name))
				end
			end
		end
	end

	EternalholydragonController.instance:clearRecordItem()
end

function EternalholydragongameView:_onCliclBtnClosepanel()
	self:_onClickbtnDropCancel()
end

function EternalholydragongameView:_onClickLandItem(obj)
	goutil.setActive(self._btncloselanditem.gameObject, true)

	local itemCfg = EternalholydragonConfig.instance:getItemCfg(self._itemPlanId, checknumber(obj:getGridElementParams()))

	self:_showItemRangeEffect(obj, itemCfg.effectScope)
end

function EternalholydragongameView:_onClickbtncloselanditem()
	goutil.setActive(self._btncloselanditem.gameObject, false)
	self:_hideItemRangeEffect()
end

function EternalholydragongameView:_resetDragItem()
	if self._dragGo then
		self._dragGo:GetComponent(goutil.Type_UIImage).raycastTarget = true

		Framework.TransformUtil.SetAnchoredPos(self._dragGo.transform, 0, 0)

		self._dragGo = nil
	end
end

function EternalholydragongameView:_onClickbtnHideItem()
	self._hideItemContent = not self._hideItemContent

	self:_setItemsContenet()
end

function EternalholydragongameView:_setItemsContenet()
	if not self._hideItemContent then
		Framework.TransformUtil.SetAnchoredPos(self._itemContentTr, 0, 0)
		Framework.TransformUtil.SetLocalScale(self._btnHideItem.transform, 1, -1, 1)
	else
		Framework.TransformUtil.SetAnchoredPos(self._itemContentTr, 0, -100)
		Framework.TransformUtil.SetLocalScale(self._btnHideItem.transform, 1, 1, 1)
	end
end

function EternalholydragongameView:_onClickbtnTip()
	local actCfg = EternalholydragonConfig.instance:getActivityCfg(self._activityId)

	TipsFacade.instance:openRulesView(actCfg.gameRuleKey)
end

function EternalholydragongameView:_setMyHead()
	local actCfg = EternalholydragonConfig.instance:getActivityCfg(self._activityId)

	uGuiUtil.setSpriteToImage(self._myheadIconGo, nil, actCfg.iconName .. ".png")
end

function EternalholydragongameView:_setPassStage()
	local passStage = EternalholydragonController.instance:getPassStage()

	if passStage then
		EternalholydragonController.instance:clearPassStage()
		goutil.setActive(self._passStageGo, true)
	end
end

function EternalholydragongameView:_onClickbtnClosePass()
	goutil.setActive(self._passStageGo, false)
end

return EternalholydragongameView
