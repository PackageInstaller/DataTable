-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonMiniMapRegionParamsView.lua

module("logic.extensions.season.view.SeasonMiniMapRegionParamsView", package.seeall)

local SeasonMiniMapRegionParamsView = class("SeasonMiniMapRegionParamsView", ViewComponent)
local minimapParamsResPath = "ui/bigbg/season/season_minimap_params.png"

function SeasonMiniMapRegionParamsView:buildUI()
	SeasonMiniMapRegionParamsView.super.buildUI(self)
	self:_initOverviewNode()
end

function SeasonMiniMapRegionParamsView:_initOverviewNode()
	self._overviewNode = self:getGo("overview")
	self._overviewCloseButton = self:getBtn("overview/btnClose")
	self._overviewMapImg = self:getGo("overview/mask/minimap"):GetComponent(ComponentType.RawImage)
	self._txtTestRegion = self:getTxt("overview/txtTestRegion")
	self._testRegionBeginDrag = PointerDownHandler.Get(self._overviewMapImg.gameObject)
	self._testRegionDrag = DragHandler.Get(self._overviewMapImg.gameObject)
	self._testRegionEndDrag = PointerUpHandler.Get(self._overviewMapImg.gameObject)
	self._regionParamsRange = self:getGo("overview/mask/regionRange")

	self._regionParamsRange:SetActive(false)
	self._txtTestRegion.gameObject:SetActive(false)
end

function SeasonMiniMapRegionParamsView:bindEvents()
	SeasonMiniMapView.super.bindEvents(self)
	self._overviewCloseButton:AddClickListener(self._onClickOverviewClose, self)

	self._testRegionBeginDragHandler = self._testRegionBeginDrag:AddLuaHandler(function()
		self:_beginTestRegionParams()
	end)
	self._testRegionDragHandler = self._testRegionDrag:AddLuaHandler(function()
		self:_dragTestRegionParams()
	end)
	self._testRegionEndDrawHandler = self._testRegionEndDrag:AddLuaHandler(function()
		self:_endTestRegionParams()
	end)
end

function SeasonMiniMapRegionParamsView:unbindEvents()
	SeasonMiniMapView.super.unbindEvents(self)
	self._overviewCloseButton:RemoveClickListener()

	if self._testRegionBeginDragHandler then
		self._testRegionBeginDrag:RemoveLuaHandler(self._testRegionBeginDragHandler)

		self._testRegionBeginDragHandler = nil
	end

	if self._testRegionDragHandler then
		self._testRegionDrag:RemoveLuaHandler(self._testRegionDragHandler)

		self._testRegionDragHandler = nil
	end

	if self._testRegionEndDrawHandler then
		self._testRegionEndDrag:RemoveLuaHandler(self._testRegionEndDrawHandler)

		self._testRegionEndDrawHandler = nil
	end
end

function SeasonMiniMapRegionParamsView:onEnterFinished()
	SeasonMiniMapView.super.onEnterFinished(self)
	self._regionParamsRange:SetActive(false)
	self._txtTestRegion.gameObject:SetActive(false)
	getres(minimapParamsResPath, self._onMinimapParamsLoaded, self)
end

function SeasonMiniMapRegionParamsView:_onMinimapParamsLoaded(res)
	self._resMinimap = res

	res:Retain()

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	self._overviewMapImg.texture = mainAsset
end

function SeasonMiniMapRegionParamsView:onExit()
	if self._resMinimap then
		self._resMinimap:Release()

		self._resMinimap = nil
	end

	removeresl(minimapParamsResPath, self._onMinimapParamsLoaded, self)

	self._overviewMapImg.texture = nil
	self._testRegionBeginPos = nil
	self._testRegionDestPos = nil

	SeasonMiniMapView.super.onExit(self)
end

function SeasonMiniMapRegionParamsView:_onClickOverviewClose()
	self:close()
end

function SeasonMiniMapRegionParamsView:_beginTestRegionParams()
	self._testRegionBeginPos = self:_getTextureClickLocalPos(self._overviewMapImg)
end

function SeasonMiniMapRegionParamsView:_dragTestRegionParams()
	self:_endTestRegionParams()
end

function SeasonMiniMapRegionParamsView:_endTestRegionParams()
	self._testRegionDestPos = self:_getTextureClickLocalPos(self._overviewMapImg)

	self:_drawTestRegionRange()
end

function SeasonMiniMapRegionParamsView:_drawTestRegionRange()
	if not self._testRegionDestPos or not self._testRegionBeginPos then
		return
	end

	self._regionParamsRange:SetActive(true)
	self._txtTestRegion.gameObject:SetActive(true)

	local dx = self._testRegionDestPos.x - self._testRegionBeginPos.x
	local dy = self._testRegionDestPos.y - self._testRegionBeginPos.y
	local minmapLocalPosX, minmapLocalPosY = Framework.TransformUtil.GetLocalPos(self._overviewMapImg.transform, nil, nil, nil)
	local centerX = minmapLocalPosX + (self._testRegionDestPos.x + self._testRegionBeginPos.x) * 0.5
	local centerY = minmapLocalPosY + (self._testRegionDestPos.y + self._testRegionBeginPos.y) * 0.5
	local rectTrans = self._regionParamsRange.transform
	local sizeDelta = rectTrans.sizeDelta

	sizeDelta.x = math.abs(dx)
	sizeDelta.y = math.abs(dy)

	Framework.TransformUtil.SetLocalPos(rectTrans, centerX, centerY, 0)

	rectTrans.sizeDelta = sizeDelta

	local scene = SceneMgr.instance:getCurScene()
	local beginUVX, beginUVY = self:_textureLocalPosToUVPos(self._testRegionBeginPos, self._overviewMapImg)
	local destUVX, destUVY = self:_textureLocalPosToUVPos(self._testRegionDestPos, self._overviewMapImg)
	local beginWPosX, beginWPosY = scene.miniMap:UVToWorldPosition(beginUVX, beginUVY)
	local destWPosX, destWPosY = scene.miniMap:UVToWorldPosition(destUVX, destUVY)
	local minX, maxX, minY, maxY = math.min(beginWPosX, destWPosX), math.max(beginWPosX, destWPosX), math.min(beginWPosY, destWPosY), math.max(beginWPosY, destWPosY)
	local curParamText = string.format("%.2f,%.2f,%.2f,%.2f", minX, maxX, minY, maxY)

	self._txtTestRegion.text = string.format("当前参数：%s", curParamText)
end

function SeasonMiniMapRegionParamsView:_getTextureClickLocalPos(img)
	local pos = UGUIToolHelper.GetTouchPosition()
	local worldPos = GlobalModel.instance.uiCamera:ScreenToWorldPoint(pos)

	return (img.transform:InverseTransformPoint(worldPos))
end

function SeasonMiniMapRegionParamsView:_textureLocalPosToUVPos(localPos, img)
	local sizeDelta = img.transform.sizeDelta
	local ux = (localPos.x + sizeDelta.x * 0.5) / sizeDelta.x
	local uy = (localPos.y + sizeDelta.y * 0.5) / sizeDelta.y

	ux = math.max(0, math.min(ux, 1))
	uy = math.max(0, math.min(uy, 1))

	return ux, uy
end

return SeasonMiniMapRegionParamsView
