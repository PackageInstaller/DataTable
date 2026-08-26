-- chunkname: @modules/logic/scene/udimo/entity/DecorationSiteEntity.lua

module("modules.logic.scene.udimo.entity.DecorationSiteEntity", package.seeall)

local DecorationSiteEntity = class("DecorationSiteEntity", LuaCompBase)

function DecorationSiteEntity:ctor()
	self:clear()
end

function DecorationSiteEntity:init(go)
	self.go = go
	self.trans = go.transform

	self:clear()
end

function DecorationSiteEntity:initPosData(posData)
	self.posIndex = posData and posData.posIndex
	self.worldPos = posData and posData.worldPos

	if self.worldPos then
		transformhelper.setPos(self.trans, self.worldPos.x, self.worldPos.y, self.worldPos.z)
	end
end

function DecorationSiteEntity:setDecorationId(decorationId)
	if self.decorationId and self.decorationId == decorationId then
		return
	end

	self:_clearDecoration()
	self:_clearPreviewDecoration()

	self.decorationId = decorationId

	if self.decorationId then
		local scene = UdimoController.instance:getUdimoScene()

		if scene then
			local res = UdimoConfig.instance:getDecorationRes(self.decorationId)

			self.decorationResPath = ResUrl.getDungeonMapRes(res)

			scene.loader:makeSureLoaded({
				self.decorationResPath
			}, self._onLoadDecoration, self)
		end
	end
end

function DecorationSiteEntity:_onLoadDecoration()
	local scene = UdimoController.instance:getUdimoScene()

	if not scene or not self.decorationId or string.nilorempty(self.decorationResPath) then
		return
	end

	local assetRes = scene.loader:getResource(self.decorationResPath)

	self.goDecoration = gohelper.clone(assetRes, self.go, self.decorationId)
	self.goHighlight = gohelper.findChild(self.goDecoration, "glow")

	local goCenter = gohelper.findChild(self.goDecoration, "center")
	local x, y, z = transformhelper.getPos(goCenter.transform)

	self.centerPos = {
		x = x,
		y = y,
		z = z
	}

	scene.level:addGameObjectToColorCtrl(self.goDecoration, true)
	self:addClick()
	self:refreshHighlight()

	local selectedPos = self:getSelectedPos()

	UdimoController.instance:dispatchEvent(UdimoEvent.RefreshDecorationSelectPos, selectedPos)
end

function DecorationSiteEntity:addClick()
	if gohelper.isNil(self.goHighlight) then
		return
	end

	local boxCollider = gohelper.onceAddComponent(self.goHighlight, typeof(UnityEngine.BoxCollider2D))

	boxCollider.enabled = true
end

function DecorationSiteEntity:_clearDecoration()
	local scene = UdimoController.instance:getUdimoScene()

	if scene and scene.level then
		scene.level:removeGameObjectToColorCtrl(self.goDecoration, true)
	end

	self.goHighlight = nil

	gohelper.destroy(self.goDecoration)

	self.goDecoration = nil
	self.decorationResPath = nil
	self.decorationId = nil
	self.centerPos = nil
end

function DecorationSiteEntity:setPreviewDecorationId(previewDecorationId)
	if self.previewDecorationId and previewDecorationId == self.previewDecorationId then
		return
	end

	self:_clearPreviewDecoration()

	if self.decorationId == previewDecorationId then
		return
	end

	self.previewDecorationId = previewDecorationId

	if self.previewDecorationId then
		local scene = UdimoController.instance:getUdimoScene()

		if scene then
			local res = UdimoConfig.instance:getDecorationRes(self.previewDecorationId)

			self.previewDecorationResPath = ResUrl.getDungeonMapRes(res)

			scene.loader:makeSureLoaded({
				self.previewDecorationResPath
			}, self._onLoadPreviewDecoration, self)
		end
	end
end

function DecorationSiteEntity:_onLoadPreviewDecoration()
	local scene = UdimoController.instance:getUdimoScene()

	if not scene or not self.previewDecorationId or string.nilorempty(self.previewDecorationResPath) then
		return
	end

	local assetRes = scene.loader:getResource(self.previewDecorationResPath)

	self.goPreviewDecoration = gohelper.clone(assetRes, self.go, string.format("preview-%s", self.previewDecorationId))

	local goPreviewHighlight = gohelper.findChild(self.goPreviewDecoration, "glow")
	local goCenter = gohelper.findChild(self.goPreviewDecoration, "center")
	local x, y, z = transformhelper.getPos(goCenter.transform)

	self.previewCenterPos = {
		x = x,
		y = y,
		z = z
	}

	scene.level:addGameObjectToColorCtrl(self.goPreviewDecoration, true)
	gohelper.setActive(goPreviewHighlight, false)
	gohelper.setActive(self.goDecoration, false)

	local selectedPos = self:getSelectedPos()

	UdimoController.instance:dispatchEvent(UdimoEvent.RefreshDecorationSelectPos, selectedPos)
end

function DecorationSiteEntity:_clearPreviewDecoration()
	local scene = UdimoController.instance:getUdimoScene()

	if scene and scene.level then
		scene.level:removeGameObjectToColorCtrl(self.goPreviewDecoration, true)
	end

	gohelper.destroy(self.goPreviewDecoration)

	self.goPreviewDecoration = nil
	self.previewDecorationResPath = nil
	self.previewDecorationId = nil
	self.previewCenterPos = nil

	gohelper.setActive(self.goDecoration, true)

	local selectedPos = self:getSelectedPos()

	UdimoController.instance:dispatchEvent(UdimoEvent.RefreshDecorationSelectPos, selectedPos)
end

function DecorationSiteEntity:onClick()
	UdimoController.instance:selectDecoration(self.decorationId)

	local selectedPos = self:getSelectedPos()

	UdimoController.instance:dispatchEvent(UdimoEvent.OnClickDecorationEntity, self.decorationId, selectedPos)
end

function DecorationSiteEntity:refreshHighlight()
	local isOpenView = ViewMgr.instance:isOpen(ViewName.UdimoChangeDecorationView)
	local selectedPosIndex = UdimoItemModel.instance:getSelectedDecorationPosIndex()

	if not isOpenView or not selectedPosIndex then
		self:_clearPreviewDecoration()
	end

	local isShowHighlight = isOpenView and not selectedPosIndex

	gohelper.setActive(self.goHighlight, isShowHighlight)
end

function DecorationSiteEntity:getDecorationId()
	return self.decorationId
end

function DecorationSiteEntity:getPosIndex()
	return self.posIndex
end

function DecorationSiteEntity:getWorldPos()
	return self.worldPos
end

function DecorationSiteEntity:getSelectedPos()
	return self.previewCenterPos or self.centerPos or self.worldPos
end

function DecorationSiteEntity:clear()
	self:initPosData()
	self:_clearDecoration()
	self:_clearPreviewDecoration()
end

function DecorationSiteEntity:onDestroy()
	self.decorationId = nil
end

return DecorationSiteEntity
