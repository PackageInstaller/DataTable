-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingMoudleCollectTipsView.lua

module("logic.extensions.livingfacilities.view.LivingMoudleCollectTipsView", package.seeall)

local M = class("LivingMoudleCollectTipsView", ViewComponent)

function M:buildUI()
	self._btnCancel = self:getBtn("health_tips_990624757")
	self._btnUsing = self:getBtn("health_tips_1992688632")
	self._btnClose = self:getBtn("health_tips_-1683292806")
	self._inputText = self:getInput("living_moudle_collect_tips_960076213")
	self._imgIcon = self:getImage("living_moudle_collect_tips_1078570873")
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._clickCancel, self)
	self._btnUsing:AddClickListener(self._clickUsing, self)
	self._btnClose:AddClickListener(self._clickClose, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnUsing:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._index = self:getFirstParam()

	local defaultName = string.format(ConstConfig.instance:getStrValueByKey(ConstConfigKeyEnum.HouseTempleDefaultName), self._index)

	self._inputText:SetText(defaultName)
	self:_capturePhoto()
end

function M:_capturePhoto()
	local rectTransform = self.mainGO:GetComponent(UIComponentType.RectTransform)
	local rect = Astral.GeometryUtil.GetNativePixelRect(rectTransform, CameraTargetMgr.instance:getUICameraTarget():getCamera())

	rect.x = 0
	rect.y = 0
	rect.width = LivingFacilitiesZoneController.SNAPSHOT_RT_WIDTH
	rect.height = LivingFacilitiesZoneController.SNAPSHOT_RT_HEIGHT

	local camera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local fileName = LivingFacilitiesZoneController.instance:getTemplateIconFullPath(zoneMo:getType(), self._index)

	Astral.SnapshotTaker.Instance:CaptureCamera(camera, rect, self._captureCallBack, self, fileName)
end

function M:_captureCallBack()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local fileName = LivingFacilitiesZoneController.instance:getTemplateIconFullPath(zoneMo:getType(), self._index)
	local width = LivingFacilitiesZoneController.SNAPSHOT_RT_WIDTH
	local height = LivingFacilitiesZoneController.SNAPSHOT_RT_HEIGHT

	SpaceXFileUtil.SetImageSpriteByIO(self._imgIcon, fileName, width, height)
end

function M:onExit()
	return
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._btnCancel = nil
	self._btnUsing = nil
	self._btnClose = nil
	self._inputText = nil
end

function M:_clickCancel()
	self:close()
end

function M:_clickUsing()
	local name = self._inputText:GetText()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local type = zoneMo:getType()
	local furnitureList = HouseFacade.instance:getCurrFurnitureDatas(zoneMo:getId()) or {}

	if #furnitureList > 0 then
		HouseAgent.instance:sendSaveFurnitureTemplateRequest(type, self._index, name, furnitureList)
		self:close()
	else
		FloatWordMgr.instance:show(lang("不能收藏空房间"))
	end
end

function M:_clickClose()
	self:close()
end

return M
