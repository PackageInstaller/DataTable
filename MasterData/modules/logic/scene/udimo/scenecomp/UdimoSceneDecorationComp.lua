-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneDecorationComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneDecorationComp", package.seeall)

local UdimoSceneDecorationComp = class("UdimoSceneDecorationComp", BaseSceneComp)

function UdimoSceneDecorationComp:onInit()
	return
end

function UdimoSceneDecorationComp:onSceneStart(sceneId, levelId)
	return
end

function UdimoSceneDecorationComp:init(sceneId, levelId)
	self:initSiteEntities()
	self:refreshSiteDecoration()
	self:refreshDecorationHighlight()
	self:addEventListeners()
end

function UdimoSceneDecorationComp:initSiteEntities()
	self:clearAllSiteEntities()

	local sitePosDataList = {}
	local scene = self:getCurScene()
	local sceneObj = scene.level:getSceneGo()
	local decorationGO = gohelper.findChild(sceneObj, UdimoEnum.SceneGOName.Decoration)
	local decorationTrans = decorationGO.transform
	local childCount = decorationTrans.childCount

	for i = 1, childCount do
		local child = decorationTrans:GetChild(i - 1)
		local posIndex = tonumber(child.name)

		if posIndex then
			local x, y, z = transformhelper.getPos(child)

			sitePosDataList[i] = {
				posIndex = posIndex,
				worldPos = {
					x = x,
					y = y,
					z = z
				}
			}
		end
	end

	local decorationRoot = scene.go:getDecorationRoot()
	local siteGO = scene.go:getDecorationSiteGO()

	gohelper.CreateObjList(self, self._onCreateSiteEntity, sitePosDataList, decorationRoot, siteGO, DecorationSiteEntity)
end

function UdimoSceneDecorationComp:_onCreateSiteEntity(obj, data, _)
	obj:initPosData(data)

	self._siteEntityDict[data.posIndex] = obj
end

function UdimoSceneDecorationComp:addEventListeners()
	UdimoController.instance:registerCallback(UdimoEvent.OnClickDecorationEntity, self._onClickDecorationEntity, self)
	UdimoController.instance:registerCallback(UdimoEvent.OnSelectDecorationItem, self._onSelectDecorationItem, self)
	UdimoController.instance:registerCallback(UdimoEvent.OnChangeDecoration, self._onChangeDecoration, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function UdimoSceneDecorationComp:removeEventListeners()
	UdimoController.instance:unregisterCallback(UdimoEvent.OnClickDecorationEntity, self._onClickDecorationEntity, self)
	UdimoController.instance:unregisterCallback(UdimoEvent.OnSelectDecorationItem, self._onSelectDecorationItem, self)
	UdimoController.instance:unregisterCallback(UdimoEvent.OnChangeDecoration, self._onChangeDecoration, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

function UdimoSceneDecorationComp:_onClickDecorationEntity()
	self:refreshDecorationHighlight()
end

function UdimoSceneDecorationComp:_onSelectDecorationItem(notPreview)
	local camFocusX = 0
	local selectedDecorationId = UdimoItemModel.instance:getSelectedDecorationId()

	if selectedDecorationId then
		local posIndex = UdimoConfig.instance:getDecorationPos(selectedDecorationId)

		if self._siteEntityDict then
			local siteEntity = self._siteEntityDict[posIndex]

			if siteEntity and not notPreview then
				siteEntity:setPreviewDecorationId(selectedDecorationId)
			end

			local worldPos = siteEntity:getWorldPos()

			if worldPos then
				camFocusX = worldPos.x
			end
		end
	else
		self:refreshDecorationHighlight()
	end

	local scene = self:getCurScene()

	if scene then
		scene.camera:tweenCameraFocusX(camFocusX)
	end
end

function UdimoSceneDecorationComp:_onChangeDecoration()
	self:refreshSiteDecoration()
end

function UdimoSceneDecorationComp:_onOpenView(viewName)
	if viewName == ViewName.UdimoChangeDecorationView then
		self:refreshDecorationHighlight()
	end
end

function UdimoSceneDecorationComp:_onCloseView(viewName)
	if viewName == ViewName.UdimoChangeDecorationView then
		self:refreshDecorationHighlight()
	end
end

function UdimoSceneDecorationComp:onScenePrepared(sceneId, levelId)
	return
end

function UdimoSceneDecorationComp:refreshSiteDecoration()
	if not self._siteEntityDict then
		return
	end

	for _, siteEntity in pairs(self._siteEntityDict) do
		local posIndex = siteEntity:getPosIndex()
		local decorationId = UdimoItemModel.instance:getUseDecoration(posIndex)

		siteEntity:setDecorationId(decorationId)
	end
end

function UdimoSceneDecorationComp:refreshDecorationHighlight()
	if not self._siteEntityDict then
		return
	end

	for _, siteEntity in pairs(self._siteEntityDict) do
		siteEntity:refreshHighlight()
	end
end

function UdimoSceneDecorationComp:getSiteEntityDict()
	return self._siteEntityDict
end

function UdimoSceneDecorationComp:getSiteEntityByDecorationId(decorationId)
	local posIndex = UdimoConfig.instance:getDecorationPos(decorationId)

	if self._siteEntityDict then
		local siteEntity = self._siteEntityDict[posIndex]
		local curDecorationId = siteEntity:getDecorationId()

		if decorationId and curDecorationId == decorationId then
			return siteEntity
		end
	end
end

function UdimoSceneDecorationComp:clearAllSiteEntities()
	if self._siteEntityDict then
		for _, siteEntity in pairs(self._siteEntityDict) do
			siteEntity:clear()
		end
	end

	self._siteEntityDict = {}
end

function UdimoSceneDecorationComp:onSceneClose()
	self:removeEventListeners()
	self:clearAllSiteEntities()
end

return UdimoSceneDecorationComp
