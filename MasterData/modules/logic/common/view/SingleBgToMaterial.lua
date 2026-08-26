-- chunkname: @modules/logic/common/view/SingleBgToMaterial.lua

module("modules.logic.common.view.SingleBgToMaterial", package.seeall)

local SingleBgToMaterial = class("SingleBgToMaterial", LuaCompBase)

function SingleBgToMaterial:loadMaterial(image, path)
	self.materialPath = string.format("ui/materials/dynamic/%s.mat", path)
	self.image = image.gameObject:GetComponent(gohelper.Type_Image)

	if string.nilorempty(self.materialPath) then
		logError("materialPath is not exit:" .. self.materialPath)

		return
	end

	if not image then
		logError("image is nil:")

		return
	end

	self.materialLoader = MultiAbLoader.New()

	self.materialLoader:addPath(self.materialPath)
	self.materialLoader:startLoad(self.buildMaterial, self)
end

function SingleBgToMaterial:buildMaterial()
	local assetItem = self.materialLoader:getAssetItem(self.materialPath)

	self.material = assetItem:GetResource(self.materialPath)
	self.materialGO = UnityEngine.Object.Instantiate(self.material)
	self.image.material = self.materialGO

	self:loadFinish()
end

function SingleBgToMaterial:dispose()
	if self.materialLoader then
		self.materialLoader:dispose()
	end
end

function SingleBgToMaterial:finishLoadCallBack(callback)
	self.callback = callback
end

function SingleBgToMaterial:loadFinish()
	if self.callback then
		self:callback()
	end
end

return SingleBgToMaterial
