-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonMiniMapView.lua

module("logic.extensions.season.view.SeasonMiniMapView", package.seeall)

local SeasonMiniMapView = class("SeasonMiniMapView", ViewComponent)
local state_overView = 1
local state_regionMiniMap = 2

function SeasonMiniMapView:ctor()
	SeasonMiniMapView.super.ctor(self)
end

function SeasonMiniMapView:buildUI()
	SeasonMiniMapView.super.buildUI(self)
	self:_initOverviewNode()
	self:_initRegionMapNode()
	self:_initTeamCoordsNode()
end

function SeasonMiniMapView:_initTeamCoordsNode()
	self._overviewTeamCoords = {}

	for i = 1, 3 do
		local coord = self:getGo("myTeamInfo/coord_team" .. i)
		local coordCfg = {}

		coordCfg.go = coord
		coordCfg.coordTxt = goutil.findChildTextComponent(coord, "coord_pos")
		coordCfg.btnView = Framework.UIClickTrigger.Get(goutil.findChild(coord, "btnView"))
		coordCfg.selectChange = coord:GetComponent(ComponentType.UIImageSpriteChange)

		table.insert(self._overviewTeamCoords, coordCfg)
	end

	self._overviewOtherTeamCoords = {}
	self._otherTeamInfo = self:getGo("otherTeamInfo")

	for i = 1, 3 do
		local coord = self:getGo("otherTeamInfo/coord_otherTeam" .. i)
		local coordCfg = {}

		coordCfg.go = coord
		coordCfg.coordTxt = goutil.findChildTextComponent(coord, "coord_pos")
		coordCfg.btnView = Framework.UIClickTrigger.Get(goutil.findChild(coord, "btnView"))

		table.insert(self._overviewOtherTeamCoords, coordCfg)
	end
end

function SeasonMiniMapView:_initOverviewNode()
	self._overviewNode = self:getGo("overview")
	self._overviewCloseButton = self:getBtn("overview/btnClose")
	self._overviewMapImg = self:getGo("overview/mask/minimap"):GetComponent(ComponentType.RawImage)
	self._btnTestRegion = self:getBtn("overview/btnTestRegion")

	self._btnTestRegion.gameObject:SetActive(Framework.OSDef.isEditor)

	self._btnRegions = {}

	local idx = 1

	while true do
		local go = self:getGo("overview/btnRegions/region" .. idx)

		if not go then
			break
		end

		idx = idx + 1

		table.insert(self._btnRegions, Framework.UIClickTrigger.Get(go))
	end
end

function SeasonMiniMapView:_initRegionMapNode()
	self._regionNode = self:getGo("region")
	self._regionCloseButton = self:getBtn("region/btnClose")
	self._regionCamera = self:getGo("region/Camera"):GetComponent(ComponentType.Camera)
	self._regionMiniMapImg = self:getGo("region/mask/minimap"):GetComponent(ComponentType.RawImage)
	self._regionMinimapViewRange = self:getGo("region/mask/minimapViewRange").transform
	self._regionGenerating = self:getGo("region/generating")
	self._regionCamera.orthographic = true
	self._regionCamera.orthographicSize = 3.6
	self._regionCamera.allowHDR = false
	self._regionCamera.allowMSAA = false
	self._regionCamera.allowDynamicResolution = false
	self._regionCamera.depth = 10
	self._regionCamera.clearFlags = UnityEngine.CameraClearFlags.SolidColor
	self._regionCamera.backgroundColor = Color.New(0, 0, 0, 0)
	self._regionDragMinimap = DragHandler.Get(self._regionMiniMapImg.gameObject)
	self._clickRegionMiniMap = Framework.UIClickTrigger.Get(self._regionMiniMapImg.gameObject)
	self._regionMask = self:getGo("region/mask").transform
end

function SeasonMiniMapView:bindEvents()
	SeasonMiniMapView.super.bindEvents(self)
	self._overviewCloseButton:AddClickListener(self._onClickOverviewClose, self)
	self._regionCloseButton:AddClickListener(self._onClickRegionClose, self)

	self._regionDragHandler = self._regionDragMinimap:AddLuaHandler(function()
		self:_focusRegionByTouchPos()
	end)

	self._clickRegionMiniMap:AddClickListener(function()
		self:_focusRegionByTouchPos()
	end)
	self._btnTestRegion:AddClickListener(self._onClickToggleTestRegion, self)

	for i = 1, #self._btnRegions do
		self._btnRegions[i]:AddClickListener(function()
			self:_onClickRegion(i)
		end)
	end

	for i = 1, #self._overviewTeamCoords do
		self._overviewTeamCoords[i].btnView:AddClickListener(function()
			self:_viewTeamByIndex(i)
		end)
	end

	for i = 1, #self._overviewOtherTeamCoords do
		self._overviewOtherTeamCoords[i].btnView:AddClickListener(function()
			self:_viewOtherTeamByIndex(i)
		end)
	end
end

function SeasonMiniMapView:unbindEvents()
	SeasonMiniMapView.super.unbindEvents(self)

	for i = 1, #self._btnRegions do
		self._btnRegions[i]:RemoveClickListener()
	end

	self._overviewCloseButton:RemoveClickListener()
	self._regionCloseButton:RemoveClickListener()
	self._clickRegionMiniMap:RemoveClickListener()
	self._btnTestRegion:RemoveClickListener()

	if self._regionDragHandler then
		self._regionDragMinimap:RemoveLuaHandler(self._regionDragHandler)

		self._regionDragHandler = nil
	end

	for i = 1, #self._overviewTeamCoords do
		self._overviewTeamCoords[i].btnView:RemoveClickListener()
	end

	for i = 1, #self._overviewOtherTeamCoords do
		self._overviewOtherTeamCoords[i].btnView:RemoveClickListener()
	end
end

function SeasonMiniMapView:onEnterFinished()
	SeasonMiniMapView.super.onEnterFinished(self)
	settimer(1, self._updateTeamCoords, self)
	self:_showOverview()

	if #self._btnRegions == 1 then
		self:_onClickRegion(1)
	end
end

function SeasonMiniMapView:onExit()
	removetimer(self._updateTeamCoords, self)

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.minimap then
		scene.minimap:stopGenerateMinimap()
	end

	self._overviewMapImg.texture = nil
	self._testRegionBeginPos = nil
	self._testRegionDestPos = nil

	SeasonMiniMapView.super.onExit(self)
end

function SeasonMiniMapView:_onClickOverviewClose()
	self:close()
end

function SeasonMiniMapView:_onClickRegionClose()
	self:_showOverview()

	if #self._btnRegions == 1 then
		self:close()
	end
end

function SeasonMiniMapView:_onClickToggleTestRegion()
	ViewMgr.instance:open(ViewName.SeasonMiniMapRegionParamsView)
end

function SeasonMiniMapView:_showOverview()
	self._curState = state_overView

	self._overviewNode:SetActive(true)
	self._regionNode:SetActive(false)
	self._overviewMapImg.gameObject:SetActive(false)
	SeasonMinimapController.instance:loadMinimap(self._onMinimapTextureLoaded, self)
	self:_updateTeamCoords()
end

function SeasonMiniMapView:_showRegionMinimap(index)
	local scene = SceneMgr.instance:getCurScene()
	local bounds, uvParams = scene.miniMap:getRegionMiniMapParams(index)

	if not bounds then
		FloatWordMgr.instance:show("点击的区域无效")

		return
	end

	self._curState = state_regionMiniMap

	self._overviewNode:SetActive(false)
	self._regionNode:SetActive(true)

	self._regionBounds = bounds
	self._regionUvParams = uvParams
	self._regionIndex = index
	self._regionCamera.orthographicSize = self._regionBounds.size * 0.5

	local mainCamera = GlobalModel.instance.mainCamera

	self:_setupRegionMinimapViewRange(mainCamera.aspect, mainCamera.orthographicSize)
	scene.miniMap:generateRegionMinimap(self._regionIndex, self._regionCamera, self._onRegionMinimapStatusChange, self)

	local rendererTex = scene.miniMap:getRenderTexture()

	self._regionCamera.targetTexture = rendererTex
	self._regionMiniMapImg.texture = rendererTex
end

function SeasonMiniMapView:_onRegionMinimapStatusChange(status)
	local isBasicFinish = status > SceneCompMiniMap.minimapStepBasic

	self._regionGenerating:SetActive(not isBasicFinish)
	self._regionMinimapViewRange.gameObject:SetActive(isBasicFinish)

	if status == SceneCompMiniMap.minimapStepEverything then
		local mainCamera = GlobalModel.instance.mainCamera
		local mainCamX, mainCamY, _ = Framework.TransformUtil.GetPos(mainCamera.transform, nil, nil, nil)

		self:_focusRegionMiniMapByWorldPos(mainCamX, mainCamY)
	end
end

function SeasonMiniMapView:_setupRegionMinimapViewRange(aspect, orthographicSize)
	local sizeMapImg = self._regionMiniMapImg.transform.sizeDelta
	local height = orthographicSize * 2 * self._regionUvParams.scale
	local width = aspect * height
	local sizeDelta = self._regionMinimapViewRange.sizeDelta

	sizeDelta.x = width * sizeMapImg.x
	sizeDelta.y = height * sizeMapImg.y
	self._regionMinimapViewRange.sizeDelta = sizeDelta
end

function SeasonMiniMapView:_onMinimapTextureLoaded()
	if self._overviewMapImg then
		local minimapTexture = SeasonMiniMapModel.instance:getMinimapTexture()

		self._overviewMapImg.gameObject:SetActive(true)

		self._overviewMapImg.texture = minimapTexture
	end
end

function SeasonMiniMapView:_updateTeamCoords()
	if SeasonModel.instance:getGroupState() == SeasonModel.GVE_GROUP_STATE_GVE then
		GameUtil.SetActive(self._otherTeamInfo, true)
	else
		GameUtil.SetActive(self._otherTeamInfo, false)
	end

	local scene = SceneMgr.instance:getCurScene()
	local leaders = scene.leaders:getTeamUnits()

	self._leaders = self._leaders or {}
	self._otherLeaders = self._otherLeaders or {}

	table.clear(self._leaders)
	table.clear(self._otherLeaders)

	if leaders then
		for k, v in pairs(leaders) do
			if not v.teamData:getIsOtherTeam() then
				table.insert(self._leaders, v)
			else
				table.insert(self._otherLeaders, v)
			end
		end
	end

	for i = 1, #self._leaders do
		local coordCfg = self._overviewTeamCoords[i]

		if coordCfg then
			coordCfg.go:SetActive(true)

			local posx, posy, _ = self._leaders[i].transform:getPos()
			local cx, cy = SeasonPathFindingDataModel.instance:pos2Grid(posx, posy)

			coordCfg.coordTxt.text = string.format("第%d队:(%d,%d)", i, cx, cy)

			if coordCfg.selectChange then
				if i == SeasonTeamsModel.instance:getCurrTeamId() then
					coordCfg.selectChange:SetState(1)
				else
					coordCfg.selectChange:SetState(0)
				end
			end
		end
	end

	for i = #self._leaders + 1, #self._overviewTeamCoords do
		local coordCfg = self._overviewTeamCoords[i]

		if not coordCfg then
			return
		end

		coordCfg.go:SetActive(false)
	end

	for i = 1, #self._otherLeaders do
		local coordCfg = self._overviewOtherTeamCoords[i]

		if coordCfg then
			coordCfg.go:SetActive(true)

			local posx, posy, _ = self._otherLeaders[i].transform:getPos()
			local cx, cy = SeasonPathFindingDataModel.instance:pos2Grid(posx, posy)

			coordCfg.coordTxt.text = string.format("第%d队:(%d,%d)", i, cx, cy)
		end
	end

	for i = #self._otherLeaders + 1, #self._overviewOtherTeamCoords do
		local coordCfg = self._overviewOtherTeamCoords[i]

		if not coordCfg then
			return
		end

		coordCfg.go:SetActive(false)
	end
end

function SeasonMiniMapView:_getTextureClickLocalPos(img)
	local pos = UGUIToolHelper.GetTouchPosition()
	local worldPos = GlobalModel.instance.uiCamera:ScreenToWorldPoint(pos)

	return (img.transform:InverseTransformPoint(worldPos))
end

function SeasonMiniMapView:_getTextureClickUVPos(img)
	local localPos = self:_getTextureClickLocalPos(img)
	local ux, uy = self:_textureLocalPosToUVPos(localPos, img)

	return ux, uy
end

function SeasonMiniMapView:_textureLocalPosToUVPos(localPos, img)
	local sizeDelta = img.transform.sizeDelta
	local ux = (localPos.x + sizeDelta.x * 0.5) / sizeDelta.x
	local uy = (localPos.y + sizeDelta.y * 0.5) / sizeDelta.y

	ux = math.max(0, math.min(ux, 1))
	uy = math.max(0, math.min(uy, 1))

	return ux, uy
end

function SeasonMiniMapView:_onClickRegion(idx)
	self:_showRegionMinimap(idx)
end

function SeasonMiniMapView:_focusRegionByTouchPos()
	local ux, uy = self:_getTextureClickUVPos(self._regionMiniMapImg)

	self:_focusRegionMiniMapByUV(ux, uy)
end

function SeasonMiniMapView:_focusRegionMiniMapByUV(uvx, uvy)
	local scene = SceneMgr.instance:getCurScene()
	local x, y = scene.miniMap:regionUVToWorldPosition(self._regionUvParams, uvx, uvy)

	self:_focusRegionMiniMapByWorldPos(x, y)
end

function SeasonMiniMapView:_focusRegionMiniMapByWorldPos(x, y)
	local scene = SceneMgr.instance:getCurScene()
	local uvx, uvy = scene.miniMap:worldPositionToRegionUV(self._regionUvParams, x, y)
	local mx, my, mz = Framework.TransformUtil.GetLocalPos(self._regionMiniMapImg.transform, nil, nil, nil)
	local deltaX, deltaY = self:_getBoundDelta()
	local sizeDelta = self._regionMiniMapImg.transform.sizeDelta
	local vx, vy = mx - sizeDelta.x * 0.5 + sizeDelta.x * uvx, my - sizeDelta.y * 0.5 + sizeDelta.y * uvy
	local halfWidth = sizeDelta.x * 0.5 - deltaX
	local halfHeight = sizeDelta.y * 0.5 - deltaY

	self._minimapBounds = self._minimapBounds or {}
	self._minimapBounds.minx = mx - halfWidth
	self._minimapBounds.maxx = mx + halfWidth
	self._minimapBounds.miny = my - halfHeight
	self._minimapBounds.maxy = my + halfHeight

	local viewsizeDelta = self._regionMinimapViewRange.sizeDelta
	local viewHalfWidth = viewsizeDelta.x * 0.5
	local viewHalfHeight = viewsizeDelta.y * 0.5

	vx = math.max(self._minimapBounds.minx + viewHalfWidth, math.min(vx, self._minimapBounds.maxx - viewHalfWidth))
	vy = math.max(self._minimapBounds.miny + viewHalfHeight, math.min(vy, self._minimapBounds.maxy - viewHalfHeight))

	Framework.TransformUtil.SetLocalPos(self._regionMinimapViewRange.transform, vx, vy, 0)

	local minimapLX = mx - sizeDelta.x * 0.5
	local minimapLY = my - sizeDelta.y * 0.5
	local yOffset = scene.camera:getPosFocusYOffset()

	uvx = (vx - minimapLX) / sizeDelta.x
	uvy = (vy - minimapLY) / sizeDelta.y
	x, y = scene.miniMap:regionUVToWorldPosition(self._regionUvParams, (vx - minimapLX) / sizeDelta.x, (vy - minimapLY) / sizeDelta.y)

	scene.camera:enablFollowTarget(false)
	scene.camera:setPosFocus(x, y - yOffset)

	local maskSize = self._regionMask.sizeDelta

	maskSize.x = sizeDelta.x - deltaX * 2
	maskSize.y = sizeDelta.y - deltaY * 2
	self._regionMask.sizeDelta = maskSize
end

function SeasonMiniMapView:_getBoundDelta()
	if not self._regionBounds then
		return 0, 0
	end

	local size = self._regionBounds.size
	local originSize = self._regionBounds.originSize
	local sizeMapImg = self._regionMiniMapImg.transform.sizeDelta
	local boundDeltaX = (size - originSize.width) * 0.5 * self._regionUvParams.scale * sizeMapImg.x
	local boundDeltaY = (size - originSize.height) * 0.5 * self._regionUvParams.scale * sizeMapImg.y

	return boundDeltaX, boundDeltaY
end

function SeasonMiniMapView:_viewTeamByIndex(i)
	if not self._leaders or not self._leaders[i] then
		return
	end

	local posx, posy, _ = self._leaders[i].transform:getPos()
	local scene = SceneMgr.instance:getCurScene()
	local yOffset = scene.camera:getPosFocusYOffset()

	scene.camera:enablFollowTarget(false)
	scene.camera:setPosFocus(posx, posy - yOffset)
	self:close()
end

function SeasonMiniMapView:_viewOtherTeamByIndex(i)
	if not self._otherLeaders or not self._otherLeaders[i] then
		return
	end

	local posx, posy, _ = self._otherLeaders[i].transform:getPos()
	local scene = SceneMgr.instance:getCurScene()
	local yOffset = scene.camera:getPosFocusYOffset()

	scene.camera:enablFollowTarget(false)
	scene.camera:setPosFocus(posx, posy - yOffset)
	self:close()
end

return SeasonMiniMapView
