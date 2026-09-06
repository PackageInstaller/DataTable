-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkmapView.lua

module("logic.extensions.elementspark.view.ElementsparkmapView", package.seeall)

local ElementsparkmapView = class("ElementsparkmapView", ViewComponent)

ElementsparkmapView.RayCastItemNamePre = "chunkRaycast_"

function ElementsparkmapView:ctor()
	ElementsparkmapView.super.ctor(self)

	self._chunkMinSale = 1
	self._chunkMaxSale = 5
	self._chunkScaleStep = 0.2
	self._uiChunkCellSize = {
		x = 226,
		y = 226
	}
	self._uiChunkCellStep = {
		x = self._uiChunkCellSize.x / 2,
		y = self._uiChunkCellSize.y / 4
	}
end

function ElementsparkmapView:destroyUI()
	self:_releaseChunks()
end

function ElementsparkmapView:unbindEvents()
	ElementsparkmapView.super.unbindEvents(self)
	self._btnZoomIn:RemoveClickListener()
	self._btnZoomOut:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnTag)
	self._btnRetreat:RemoveListener()
	self._btnAttack:RemoveListener()
	self._btnDefend:RemoveListener()
	self._btnChunksdragray:RemoveClickListener()
	self._btnTagCancel:RemoveClickListener()
	self._btnTagReplace:RemoveClickListener()
	self._btnOpRetreat:RemoveClickListener()
	self._btnOpDefend:RemoveClickListener()
	self._btnOpAttack:RemoveClickListener()
end

function ElementsparkmapView:bindEvents()
	ElementsparkmapView.super.bindEvents(self)
	self._btnZoomIn:AddClickListener(self._onClickbtnZoomIn, self)
	self._btnZoomOut:AddClickListener(self._onClickbtnZoomOut, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	GameUtil.addClickHandler(self._btnTag, self._onClickShowTag, self)
	self._btnRetreat:AddListener(self._onClickbtnRetreat, self)
	self._btnAttack:AddListener(self._onClickbtnAttack, self)
	self._btnDefend:AddListener(self._onClickbtnDefend, self)
	self._btnChunksdragray:AddClickListener(self._onClickChunksRaycast, self)
	self._btnTagCancel:AddClickListener(self._onClickbtnTagCancel, self)
	self._btnTagReplace:AddClickListener(self._onClickbtnTagReplace, self)
	self._btnOpRetreat:AddClickListener(self._onClickbtnOpRetreat, self)
	self._btnOpDefend:AddClickListener(self._onClickbtnOpDefend, self)
	self._btnOpAttack:AddClickListener(self._onClickbtnOpAttack, self)
end

function ElementsparkmapView:buildUI()
	ElementsparkmapView.super.buildUI(self)

	self._btnZoomIn = self:getBtn("chunks/btnZoomIn")
	self._btnZoomOut = self:getBtn("chunks/btnZoomOut")
	self._chunksRootGo = self:getGo("chunks/mask/chunksRoot")
	self._btnClose = self:getBtn("chunks/btnClose")
	self._tagAction = self:getGo("tagAction")
	self._btnTag = self:getBtn("btnTag")
	self._txtTagNum = self:getTxt("btnTag/num/txt")
	self._btnRetreat = self:getBtn("tagAction/btnRetreatcon/btnRetreat"):GetComponent("UILongPressed")
	self._btnAttack = self:getBtn("tagAction/btnAttackcon/btnAttack"):GetComponent("UILongPressed")
	self._btnDefend = self:getBtn("tagAction/btnDefendcon/btnDefend"):GetComponent("UILongPressed")
	self._tagoplayerGo = self:getGo("chunks/mask/chunksRoot/tagoplayer")
	self._tagopGo = self:getGo("chunks/mask/chunksRoot/tagoplayer/tagop")
	self._btnTagCancel = self:getBtn("chunks/mask/chunksRoot/tagoplayer/tagop/btnTagCancel")
	self._btnTagReplace = self:getBtn("chunks/mask/chunksRoot/tagoplayer/tagop/btnTagReplace")
	self._tagOpBtnIconChange = self:getGo("chunks/mask/chunksRoot/tagoplayer/tagop/btn"):GetComponent(ComponentType.UIImageSpriteChange)
	self._btnOpRetreat = self:getBtn("chunks/mask/chunksRoot/tagoplayer/tagop/tagAction/btnRetreat")
	self._btnOpDefend = self:getBtn("chunks/mask/chunksRoot/tagoplayer/tagop/tagAction/btnDefend")
	self._btnOpAttack = self:getBtn("chunks/mask/chunksRoot/tagoplayer/tagop/tagAction/btnAttack")
	self._txtOpBtn = self:getTxt("chunks/mask/chunksRoot/tagoplayer/tagop/btn/txt")
	self._tagOpActionGo = self:getGo("chunks/mask/chunksRoot/tagoplayer/tagop/tagAction")
	self._btnTagCancel = self:getBtn("chunks/mask/chunksRoot/tagoplayer/tagop/btnTagCancel")
	self._btnTagReplace = self:getBtn("chunks/mask/chunksRoot/tagoplayer/tagop/btnTagReplace")
	self._chunksdragrayGo = self:getGo("chunks/mask/chunksRoot/chunksdragray")
	self._btnChunksdragray = self:getBtn("chunks/mask/chunksRoot/chunksdragray")
	self._taglayerGo = self:getGo("chunks/mask/chunksRoot/taglayer")
	self._chunklayerGo = self:getGo("chunks/mask/chunksRoot/chunklayer")
	self._topGo = self:getGo("chunks/mask/chunksRoot/viewMask/top")
	self._rigtGo = self:getGo("chunks/mask/chunksRoot/viewMask/rigt")
	self._leftGo = self:getGo("chunks/mask/chunksRoot/viewMask/left")
	self._bottomGo = self:getGo("chunks/mask/chunksRoot/viewMask/bottom")
	self._bglayerGo = self:getGo("chunks/mask/chunksRoot/bglayer")

	BeginDragHandler.Get(self._chunksdragrayGo):AddLuaHandler(function(_go, eventData)
		self:_OnBeginDragSeat(_go, eventData)
	end)
	EndDragHandler.Get(self._chunksdragrayGo):AddLuaHandler(function(_go, eventData)
		self:_OnEndDragSeat(_go, eventData)
	end)
	DragHandler.Get(self._chunksdragrayGo):AddLuaHandler(function(_go, eventData)
		self:_OnDragSeat(_go, eventData)
	end)
end

function ElementsparkmapView:_OnBeginDragSeat(go, eventData)
	self._chunkTouchDownPos = UGUIToolHelper.GetTouchPosition()
	self._chunkTouchDownOriPos = self._chunkTouchDownPos
	self._isMinMapMoveOp = false
	self._beginDrag = true
end

function ElementsparkmapView:_OnEndDragSeat(go, eventData)
	self._beginDrag = false

	self:_resetMoveParams()
end

function ElementsparkmapView:_OnDragSeat(go, eventData)
	self:_onTouchMinMapMove()
end

function ElementsparkmapView:onExit()
	ElementsparkmapView.super.onExit(self)
	removetimer(self._update, self)
end

function ElementsparkmapView:onEnter()
	ElementsparkmapView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ElementSparkTagChange, self._onElementSparkTagChange, self)
	self.addGEvent(self, GlobalNotify.OnMsgAdd, self._onMsgAdd, self)

	self._activityId = ElementSparkController.instance:getActivityId()

	self:_initChunksParams()
	self:_resetMoveParams()
	self:_loadUIChunks()
	settimer(0, self._update, self, true)

	local isCommander = ElementSparkController.instance:isCommander()

	GameUtil.SetActive(self._btnTag.gameObject, isCommander)
	GameUtil.SetActive(self._tagAction, false)

	self._showTagAction = false

	self:_visibleTagop(false)
	goutil.setActive(self._chunksdragrayGo, true)
	self:_setTagNum()
end

function ElementsparkmapView:_resetMoveParams()
	self._chunkTouchDownOriPos = nil
	self._isTouchMinMapDown = false
	self._chunkTouchDownPos = nil
	self._tagType = -1
end

function ElementsparkmapView:_update()
	if self._isLongPressDown then
		self:_onTagMove()
	end
end

function ElementsparkmapView:_onTouchMinMapMove()
	if not self._chunksLoad or not self._chunkTouchDownPos then
		return
	end

	local screenPos = UGUIToolHelper.GetTouchPosition()
	local moveX = screenPos.x - self._chunkTouchDownPos.x
	local moveY = screenPos.y - self._chunkTouchDownPos.y

	self._chunkTouchDownPos = screenPos

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._chunksRootGo.transform, 0, 0)
	local targetX = x + moveX
	local targetY = y + moveY

	targetX = Mathf.Clamp(targetX, self._rootMinX, self._rootMaxX)
	targetY = Mathf.Clamp(targetY, self._rootMinY, self._rootMaxY)

	Framework.TransformUtil.SetAnchoredPos(self._chunksRootGo.transform, targetX, targetY)

	if not self._isMinMapMoveOp and (math.abs(self._chunkTouchDownOriPos.x - screenPos.x) >= 10 or math.abs(self._chunkTouchDownOriPos.y - screenPos.y) >= 10) then
		self._isMinMapMoveOp = true
	end
end

function ElementsparkmapView:_releaseChunks()
	self._chunksLoad = false

	if self._chunksId2Items then
		for i, v in ipairs(self._chunksId2Items) do
			if v.tagcell then
				local icon = goutil.findChild(v.tagcell, "icon")

				MaterialMgr.resetAll(icon)
			end
		end

		self._chunksGos = {}
	end

	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)
	end

	self._resLoader = nil
end

function ElementsparkmapView:_onChunkResourcesLoaded(loader)
	self._chunksId2Items = {}

	self:_buildBg()
	self:_buildChunks()

	self._chunksLoad = true

	self:_updateChunks()
	self:_moveViewToCenter()
	self:_setChunkRootScale()
end

function ElementsparkmapView:_buildChunks()
	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfgs = ElementSparkConfig.instance:getMapChunkCfgs(planId)
	local list = {}

	for i, v in pairs(chunkCfgs) do
		local order = v.anotherPos[1] * 1000 + v.anotherPos[2]

		table.insert(list, {
			order = order,
			chunkCfg = v
		})
	end

	table.sort(list, function(a, b)
		return a.order < b.order
	end)

	for i, data in ipairs(list) do
		local v = data.chunkCfg
		local resPath = self:_getUIPrefabAssetPath(v.assetPath)
		local x, y = self:_getTilePos(v.pos, v.anotherPos)

		y = y + self._chunkOffsetY

		local res = self._resLoader:getResource(resPath)
		local prefab = res:GetMainAsset()

		if prefab then
			local go = goutil.clone(prefab, "chunk_" .. v.pos[1] .. "_" .. v.pos[2])

			go.transform:SetParent(self._chunklayerGo.transform)
			Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(go.transform, x, y, 0)

			self._chunksId2Items[v.chunkId] = {
				mainGO = go,
				chunkCfg = v,
				posX = x,
				posY = y
			}
		end
	end
end

function ElementsparkmapView:_buildBg()
	local activityId = ElementSparkController.instance:getActivityId()
	local actCfg = ElementSparkConfig.instance:getActivityCfgById(activityId)
	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfgs = ElementSparkConfig.instance:getMapChunkCfgs(planId)
	local list = {}

	for k, v in pairs(chunkCfgs) do
		for i = v.pos[1], v.anotherPos[1] do
			for j = v.pos[2], v.anotherPos[2] do
				local order = i * 1000 + j

				table.insert(list, {
					order = order,
					chunkCfg = v,
					row = i,
					col = j
				})
			end
		end
	end

	table.sort(list, function(a, b)
		return a.order < b.order
	end)

	for i, v in ipairs(list) do
		local resPath = self:_getChunkBgPrefabAssetPath(v.chunkCfg.bgAssetPath)
		local res = self._resLoader:getResource(resPath)
		local prefab = res:GetMainAsset()

		if prefab then
			local x, y = self:_getTilePos({
				v.row,
				v.col
			}, {
				v.row,
				v.col
			})

			y = y + self._chunkOffsetY

			local go = goutil.clone(prefab, "chunkbg_" .. v.row .. "_" .. v.col)

			go.transform:SetParent(self._bglayerGo.transform)
			Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(go.transform, x, y, 0)
		end
	end
end

function ElementsparkmapView:_onClickbtnZoomIn()
	self._chunkScale = self._chunkScale + self._chunkMinSale * 2
	self._chunkScale = math.min(self._chunkScale, self._chunkMaxSale)

	self:_setChunkRootScale()
end

function ElementsparkmapView:_onClickbtnZoomOut()
	self._chunkScale = self._chunkScale - self._chunkMinSale * 2
	self._chunkScale = math.max(self._chunkScale, self._chunkMinSale)

	self:_setChunkRootScale()
end

function ElementsparkmapView:_setChunkRootScale()
	self._rootMinX = -self._mapHalfSizeX * self._chunkScale
	self._rootMaxX = -self._rootMinX
	self._rootMinY = -self._mapHalfSizeY * self._chunkScale
	self._rootMaxY = -self._rootMinY

	Framework.TransformUtil.SetLocalScale(self._chunksRootGo.transform, self._chunkScale, self._chunkScale, 1)

	local targetX, targetY = Framework.TransformUtil.GetLocalPos(self._chunksRootGo.transform, 0, 0, 0)

	targetX = Mathf.Clamp(targetX, self._rootMinX, self._rootMaxX)
	targetY = Mathf.Clamp(targetY, self._rootMinY, self._rootMaxY)

	Framework.TransformUtil.SetLocalPos(self._chunksRootGo.transform, targetX, targetY, 0)
end

function ElementsparkmapView:_updateChunks()
	self:_setViewMaskRect()

	for k, v in pairs(self._chunksId2Items or {}) do
		self:_updateChunkCell(v)
	end
end

function ElementsparkmapView:_updateChunkCell(item)
	local levelChanges = {}
	local chunkCfg = item.chunkCfg
	local iconChange = goutil.findChild(item.mainGO, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local levelGo = goutil.findChild(item.mainGO, "level")
	local raycastGo = goutil.findChild(item.mainGO, "raycast")

	if levelGo then
		levelChanges = {
			levelGo:GetComponent(ComponentType.UIImageSpriteChange)
		}
	end

	local chunkId = chunkCfg.chunkId

	if raycastGo then
		raycastGo.name = ElementsparkmapView.RayCastItemNamePre .. chunkId
	end

	local needShowLevel = false
	local needShowIcon = true
	local level = ElementSparkModel.instance:getChunkLevel(chunkId)
	local belong = ElementSparkModel.instance:getChunkBelong(chunkId)

	if chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Camp then
		iconChange:SetState(belong - 1)

		needShowLevel = true
		level = 1
	elseif chunkCfg.chunkType == GameEnum.ElementSparkChunkType.PetShop then
		iconChange:SetState(chunkCfg.initCamp - 1)
	elseif chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Resource then
		for i = 1, 5 do
			local lvGo = goutil.findChild(item.mainGO, "level" .. i)

			if lvGo then
				table.insert(levelChanges, lvGo:GetComponent(ComponentType.UIImageSpriteChange))
			end
		end

		needShowLevel = true
		level = 1
	elseif chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Guard then
		local star = chunkCfg.star

		needShowLevel = true
		needShowIcon = star > 1

		if needShowIcon then
			iconChange:SetState(star - 1)
		end
	elseif chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Spark then
		needShowLevel = true
		level = 1
	end

	if needShowLevel and belong > 0 then
		for i, levelChange in ipairs(levelChanges) do
			goutil.setActive(levelChange.gameObject, true)
			levelChange:SetState((belong - 1) * 3 + level - 1)
		end
	else
		for i, v in ipairs(levelChanges) do
			goutil.setActive(v.gameObject, false)
		end
	end

	if iconChange then
		goutil.setActive(iconChange.gameObject, needShowIcon)
	end

	self:_updateChunkCellTag(item)
end

function ElementsparkmapView:_updateChunkCellTag(item)
	local chunkCfg = item.chunkCfg
	local tagcell = item.tagcell

	if tagcell then
		goutil.setActive(tagcell, false)
	end

	local tagInfo = ElementSparkModel.instance:getTagInfo(chunkCfg.chunkId)

	if tagInfo then
		if not tagInfo.signId then
			local signId = 0
			local chunkId2TeamId = ElementSparkModel.instance:getDefenseChunkId2TeamId()

			if signId <= 0 and not chunkId2TeamId[chunkCfg.chunkId] then
				return
			end

			if not tagcell then
				tagcell = self:getResInstance(ElementsparkmapViewPresentor.ChunkUITagCell)

				tagcell.transform:SetParent(self._taglayerGo.transform)
				Framework.TransformUtil.SetLocalScale(tagcell.transform, 1, 1, 1)
				Framework.TransformUtil.SetLocalPos(tagcell.transform, item.posX, item.posY, 0)

				item.tagcell = tagcell
			end

			goutil.setActive(tagcell, true)

			local iconbg = goutil.findChild(tagcell, "iconbg")
			local icon = goutil.findChild(tagcell, "iconbg/mask/icon")
			local tagChange = goutil.findChild(tagcell, "tagbg"):GetComponent(ComponentType.UIImageSpriteChange)
			local txtTag = goutil.findChildTextComponent(tagcell, "tagbg/txtTag")
			local btnTag = Framework.ButtonAdapter.GetFrom(tagcell, "tagbg")

			goutil.setActive(tagChange.gameObject, signId > 0)
			goutil.setActive(txtTag.gameObject, signId > 0)

			if signId > 0 then
				tagChange:SetState(signId - 1)

				txtTag.text = ConstString.ElementSparkTagTypeName[signId]
			end

			btnTag:AddClickListener(function()
				self:_onClickTagOp(item)
			end)

			local result = ElementSparkController.instance:setDefensePetIcon(icon, chunkCfg.chunkId)

			goutil.setActive(iconbg, result)
		end
	end
end

function ElementsparkmapView:_onClickTagOp(item)
	if not ElementSparkController:isCommander() then
		FloatWordMgr.instance:show("只有指挥官才能修改标记")

		return
	end

	if ElementSparkController.instance:checkResultTime() then
		FloatWordMgr.instance:show("公示阶段，无法操作")

		return
	end

	self._currClickTagOpChunkId = item.chunkCfg.chunkId

	local tagInfo = ElementSparkModel.instance:getTagInfo(self._currClickTagOpChunkId)

	if tagInfo then
		if not tagInfo.signId then
			if tagInfo then
				self._currClickTagOpTagId = tagInfo.tagId or 0
			end

			if self._currClickTagOpTagId <= 0 then
				return
			end

			Framework.TransformUtil.SetAnchoredPos(self._tagopGo.transform, item.posX - 30, item.posY - 24.5)
			goutil.setActive(self._btnTagCancel.gameObject, true)
			goutil.setActive(self._btnTagReplace.gameObject, true)
			goutil.setActive(self._tagOpActionGo.gameObject, false)
			goutil.setActive(self._tagOpBtnIconChange.gameObject, false)
		end
	end
end

function ElementsparkmapView:_onClickbtnTagCancel()
	self:_visibleTagop(false)

	local tagInfo = ElementSparkModel.instance:getTagInfo(self._currClickTagOpChunkId)

	if tagInfo then
		if not tagInfo.signId then
			local signId = 0

			if signId <= 0 then
				return
			end

			ElementSparkController.instance:sendPM_EleSparkModifyTagReq(self._activityId, tagInfo.tagId, -1, self._currClickTagOpChunkId)
		end
	end
end

function ElementsparkmapView:_onClickbtnTagReplace()
	goutil.setActive(self._tagOpActionGo, true)
end

function ElementsparkmapView:_initChunksParams()
	local activityId = ElementSparkController.instance:getActivityId()
	local actCfg = ElementSparkConfig.instance:getActivityCfgById(activityId)
	local row = actCfg.mapSize[1]
	local col = actCfg.mapSize[2]
	local ltx, lty = self:_getTilePos({
		0,
		0
	}, {
		0,
		0
	})
	local rbx, rby = self:_getTilePos({
		row - 1,
		col - 1
	}, {
		row - 1,
		col - 1
	})
	local rtx, rty = self:_getTilePos({
		0,
		col - 1
	}, {
		0,
		col - 1
	})
	local lbx, lby = self:_getTilePos({
		row - 1,
		0
	}, {
		row - 1,
		0
	})
	local width = math.abs(lbx - rtx) + self._uiChunkCellSize.x
	local height = math.abs(lty - rby) + self._uiChunkCellSize.y

	GameUtil.setWidth(self._chunksRootGo, width)
	GameUtil.setHeight(self._chunksRootGo, height)

	self._chunkMinSale = 4 / math.abs(lbx - rtx) * self._uiChunkCellSize.x
	self._chunkMaxSale = self._chunkMinSale * 5
	self._chunkScale = self._chunkMinSale
	self._mapSizeX = width
	self._mapSizeY = height
	self._mapHalfSizeX = width / 2
	self._mapHalfSizeY = height / 2
	self._chunkOffsetY = self._mapHalfSizeY - self._uiChunkCellSize.y / 2

	GameUtil.setWidth(self._chunksdragrayGo, width * 2)
	GameUtil.setHeight(self._chunksdragrayGo, height * 2)
end

function ElementsparkmapView:_getUIPrefabAssetPath(assetName)
	if string.nilorempty(assetName) then
		printError("传空的值了")
	end

	return string.format("ui/views/elementspark/mapchunk/%s.prefab", assetName)
end

function ElementsparkmapView:_getChunkBgPrefabAssetPath(assetName)
	if string.nilorempty(assetName) then
		printError("传空的值了")
	end

	return string.format("ui/views/elementspark/mapchunk/%s.prefab", assetName)
end

function ElementsparkmapView:_loadUIChunks()
	if self._chunksLoad then
		self:_updateChunks()
		self:_setChunkRootScale()
		self:_moveViewToCenter()

		return
	end

	local toloadList = self:_getTotalLoadList()

	self._resLoader = MultiResLoader.New()

	self._resLoader:setResPaths(toloadList)
	self._resLoader:load(self._onChunkResourcesLoaded, nil, self)
end

function ElementsparkmapView:_getTotalLoadList()
	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfgs = ElementSparkConfig.instance:getMapChunkCfgs(planId)
	local kvList = {}

	for k, v in pairs(chunkCfgs) do
		kvList[v.assetPath] = kvList[v.assetPath] or self:_getUIPrefabAssetPath(v.assetPath)
		kvList[v.bgAssetPath] = kvList[v.bgAssetPath] or self:_getChunkBgPrefabAssetPath(v.bgAssetPath)
	end

	return table.values(kvList)
end

function ElementsparkmapView:_getTilePos(pos, anotherPos)
	local newPos = {
		x = pos[2],
		y = -pos[1]
	}
	local newAnotherPos = {
		x = anotherPos[2],
		y = -anotherPos[1]
	}
	local startX = newPos.x * self._uiChunkCellStep.x - math.abs(newPos.y) * self._uiChunkCellStep.x
	local startY = newPos.y * self._uiChunkCellStep.y - math.abs(newPos.x) * self._uiChunkCellStep.y
	local endX = newAnotherPos.x * self._uiChunkCellStep.x - math.abs(newAnotherPos.y) * self._uiChunkCellStep.x
	local endY = newAnotherPos.y * self._uiChunkCellStep.y - math.abs(newAnotherPos.x) * self._uiChunkCellStep.y

	return (startX + endX) / 2, (startY + endY) / 2
end

function ElementsparkmapView:_onClickChunkCell(chunkId)
	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, chunkId)
	local belongStr = ""
	local belong = ElementSparkModel.instance:getChunkBelong(chunkId)

	if belong > 0 then
		local campCfg = ElementSparkConfig.instance:getCampCfgById(self._activityId, belong)

		belongStr = string.format("\n当前属于%s阵营", campCfg.name)
	else
		belongStr = "\n当前地块未被占领"
	end

	local levelStr = ""

	if chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Guard then
		local level = ElementSparkModel.instance:getChunkLevel(chunkCfg.chunkId)

		levelStr = string.format("\n等级%s级", level)
	end

	local function sendFunc()
		if ElementSparkController.instance:checkResultTime() then
			FloatWordMgr.instance:show("公示阶段，无法发送坐标")

			return
		end

		local text = string.format("{\"params\":{\"chunkPlanId\":%s,\"chunkId\":%s}}", planId, chunkId)

		ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.ElementSpark, GameEnum.ChatType.System, text)
	end

	local function gotoFunc()
		self:close()
		ElementSparkSceneController.instance:moveChunkToCenterAndLocation(chunkId)
	end

	local content = string.format("%s(%s,%s)%s%s", chunkCfg.chunkName, chunkCfg.pos[1], chunkCfg.pos[2], belongStr, levelStr)

	TipsFacade.instance:openPopupWindowWithX("地块信息", content, sendFunc, gotoFunc, "发送", "前往", UnityEngine.TextAnchor.MiddleCenter)
end

function ElementsparkmapView:_onClickbtnClose()
	self:close()
end

function ElementsparkmapView:_onClickShowTag()
	if ElementSparkController.instance:checkResultTime() then
		return
	end

	self._showTagAction = not self._showTagAction

	GameUtil.SetActive(self._tagAction, self._showTagAction)
end

function ElementsparkmapView:_onClickbtnRetreat(isUp)
	self:_onLongPressTag(isUp, GameEnum.ElementSparkTagType.Retreat)
end

function ElementsparkmapView:_onClickbtnAttack(isUp)
	self:_onLongPressTag(isUp, GameEnum.ElementSparkTagType.Attack)
end

function ElementsparkmapView:_onClickbtnDefend(isUp)
	self:_onLongPressTag(isUp, GameEnum.ElementSparkTagType.Defend)
end

function ElementsparkmapView:_onLongPressTag(isUp, tagType)
	if not self._isLongPressDown and isUp then
		self:_visibleTagop(false)

		return
	end

	if self._isLongPressDown and isUp then
		self:_onLongPressUp()

		return
	end

	local isOk = self:_checkTagEnough()

	if not isOk then
		FloatWordMgr.instance:show("标记次数不足")

		return
	end

	self._isLongPressDown = true
	self._tagType = tagType

	self:_visibleTagOpToMousePos()
end

function ElementsparkmapView:_visibleTagOpToMousePos()
	self._tagOpBtnIconChange:SetState(self._tagType - 1)
	goutil.setActive(self._btnTagReplace.gameObject, false)
	goutil.setActive(self._btnTagCancel.gameObject, false)
	goutil.setActive(self._tagOpActionGo, false)
	goutil.setActive(self._tagOpBtnIconChange.gameObject, true)

	self._txtOpBtn.text = ConstString.ElementSparkTagTypeName[self._tagType]

	self:_onTagMove()
	goutil.setActive(self._tagopGo, true)
end

function ElementsparkmapView:_visibleTagop(visible)
	if not visible then
		Framework.TransformUtil.SetLocalPos(self._tagopGo.transform, 10000, 0, 0)
	end
end

function ElementsparkmapView:_onLongPressUp()
	local signId = self._tagType

	self._isLongPressDown = nil
	self._tagType = -1

	self:_visibleTagop(false)
	goutil.setActive(self._chunksdragrayGo, false)

	local hitUI = UGUIToolHelper.IsHitVisibleUI()

	goutil.setActive(self._chunksdragrayGo, true)

	if not hitUI then
		return
	end

	local name = hitUI.name
	local idx = string.find(name, ElementsparkmapView.RayCastItemNamePre)

	if idx then
		local chunkId = tonumber(string.sub(name, string.len(ElementsparkmapView.RayCastItemNamePre) + 1))
		local tagInfo = ElementSparkModel.instance:getTagInfo(chunkId)

		if tagInfo and tagInfo.signId == signId then
			FloatWordMgr.instance:show("当前地块已有标记")

			return
		end

		local planId = ElementSparkController.instance:getMapPlanId()
		local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, chunkId)

		if chunkCfg.chunkType == GameEnum.ElementSparkChunkType.Blank then
			FloatWordMgr.instance:show("路障不可标记")

			return
		end

		ElementSparkController.instance:sendPM_EleSparkAddTagReq(self._activityId, chunkId, signId)
	end
end

function ElementsparkmapView:_onTagMove()
	local screenPos = UGUIToolHelper.GetTouchPosition()
	local pos = goutil.screenToLocalPos(screenPos, self._tagoplayerGo.transform)

	Framework.TransformUtil.SetAnchoredPos(self._tagopGo.transform, pos.x, pos.y)
end

function ElementsparkmapView:_checkTagEnough()
	local use = ElementSparkModel.instance:getTagUseNum()
	local total = ElementSparkConfig.instance:getCommonCfgByKey("TAG_NUM", true)

	return use < total
end

function ElementsparkmapView:_onClickChunksRaycast()
	if self._beginDrag then
		return
	end

	goutil.setActive(self._chunksdragrayGo, false)

	local hitUI = UGUIToolHelper.IsHitVisibleUI()

	goutil.setActive(self._chunksdragrayGo, true)

	if hitUI then
		local name = hitUI.name
		local idx = string.find(name, ElementsparkmapView.RayCastItemNamePre)

		if idx then
			local chunkId = tonumber(string.sub(name, string.len(ElementsparkmapView.RayCastItemNamePre) + 1))

			if not chunkId then
				return
			end

			self:_onClickChunkCell(chunkId)
		end
	end
end

function ElementsparkmapView:_onElementSparkTagChange(chunkId)
	for k, v in pairs(self._chunksId2Items or {}) do
		if v.chunkCfg.chunkId == chunkId then
			self:_updateChunkCell(v)

			break
		end
	end

	self:_setTagNum()
end

function ElementsparkmapView:_onClickbtnOpRetreat()
	self:_changeTagSign(GameEnum.ElementSparkTagType.Retreat)
end

function ElementsparkmapView:_onClickbtnOpDefend()
	self:_changeTagSign(GameEnum.ElementSparkTagType.Defend)
end

function ElementsparkmapView:_onClickbtnOpAttack()
	self:_changeTagSign(GameEnum.ElementSparkTagType.Attack)
end

function ElementsparkmapView:_changeTagSign(newSignId)
	self:_visibleTagop(false)
	ElementSparkController.instance:sendPM_EleSparkModifyTagReq(self._activityId, self._currClickTagOpTagId, newSignId, self._currClickTagOpChunkId)
end

function ElementsparkmapView:_setTagNum()
	self._txtTagNum.text = string.format("%s/%s", ElementSparkModel.instance:getTagUseNum(), ElementSparkConfig.instance:getCommonCfgByKey("TAG_NUM"))
end

function ElementsparkmapView:_setViewMaskRect()
	local nearChunkId = ElementSparkSceneController.instance:getNearCameraChunkId()

	if nearChunkId <= 0 then
		return
	end

	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, nearChunkId)
	local x, y = self:_getTilePos(chunkCfg.pos, chunkCfg.anotherPos)

	y = y + self._chunkOffsetY

	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()
	local camSizeH = mainCam.orthographicSize * 2
	local camSizeW = mainCam.aspect * camSizeH
	local uiViewWidth = camSizeW * 100
	local uiViewHeight = camSizeH * 100

	GameUtil.setWidth(self._leftGo, self._mapSizeX)
	GameUtil.setHeight(self._leftGo, self._mapSizeY * 5)
	GameUtil.setWidth(self._rigtGo, self._mapSizeX)
	GameUtil.setHeight(self._rigtGo, self._mapSizeY * 5)

	local scaleY = 4

	GameUtil.setWidth(self._topGo, uiViewWidth)
	GameUtil.setHeight(self._topGo, self._mapSizeY * scaleY)
	GameUtil.setWidth(self._bottomGo, uiViewWidth)
	GameUtil.setHeight(self._bottomGo, self._mapSizeY * scaleY)

	local lx = x - uiViewWidth / 2 - self._mapSizeX / 2

	Framework.TransformUtil.SetLocalPos(self._leftGo.transform, lx, y, 0)

	local rx = x + uiViewWidth / 2 + self._mapSizeX / 2

	Framework.TransformUtil.SetLocalPos(self._rigtGo.transform, rx, y, 0)

	local ty = y + uiViewHeight / 2 + self._mapSizeY * scaleY / 2

	Framework.TransformUtil.SetLocalPos(self._topGo.transform, x, ty, 0)

	local by = y - uiViewHeight / 2 - self._mapSizeY * scaleY / 2

	Framework.TransformUtil.SetLocalPos(self._bottomGo.transform, x, by, 0)
end

function ElementsparkmapView:_moveViewToCenter()
	Framework.TransformUtil.SetLocalPos(self._chunksRootGo.transform, 0, 0, 0)
end

function ElementsparkmapView:_onMsgAdd(channel, friendId, msgCount, isMe)
	if channel ~= GameEnum.ChatChannel.ElementSpark then
		return
	end

	FloatWordMgr.instance:show("发送坐标成功")
end

return ElementsparkmapView
