-- chunkname: @modules/ugui/icon/IconMaterialMgr.lua

module("modules.ugui.icon.IconMaterialMgr", package.seeall)

local IconMaterialMgr = class("IconMaterialMgr")

IconMaterialMgr.LoadFail = -1

function IconMaterialMgr:init()
	self.variantIdToMaterialPath = {
		"ui/materials/dynamic/ui_headicon_stylization_1.mat",
		"ui/materials/dynamic/ui_headicon_stylization_2.mat",
		"ui/materials/dynamic/ui_headicon_stylization_3.mat",
		"ui/materials/dynamic/ui_headicon_stylization_4.mat",
		"ui/materials/dynamic/ui_headicon_stylization_5.mat",
		"ui/materials/dynamic/ui_headicon_stylization_6.mat",
		"ui/materials/dynamic/ui_headicon_stylization_assist.mat",
		"ui/materials/dynamic/ui_headicon_stylization_7.mat",
		"ui/materials/dynamic/ui_headicon_stylization_shadow.mat",
		"ui/materials/dynamic/ui_headicon_stylization_10.mat",
		"ui/materials/dynamic/ui_headicon_stylization_11.mat",
		"ui/materials/dynamic/ui_headicon_stylization_12.mat"
	}
	self.variantIdToMaterialPathWithRound = {
		[0] = "ui/materials/dynamic/ui_enemyinfo_headicon_mask.mat",
		"ui/materials/dynamic/ui_headicon_stylization_1_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_2_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_3_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_4_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_5_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_6_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_assist_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_7_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_shadow_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_10_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_11_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_12_round.mat"
	}
	self.needSetMaterialIconImages = {}
	self.loadedMaterials = {}
	self.loadingMaterialCount = 0
	self.assetItems = {}
end

function IconMaterialMgr:getMaterialPath(variantId)
	return self.variantIdToMaterialPath[variantId]
end

function IconMaterialMgr:getMaterialPathWithRound(variantId)
	return self.variantIdToMaterialPathWithRound[variantId]
end

function IconMaterialMgr:loadMaterialAddSet(materialPath, image)
	if not materialPath then
		logError("materialPath is nil")

		return
	end

	if self.loadedMaterials[materialPath] then
		local material = self.loadedMaterials[materialPath]

		if material ~= IconMaterialMgr.LoadFail then
			image.material = self.loadedMaterials[materialPath]
		end

		return
	end

	self.loadingMaterialCount = self.loadingMaterialCount + 1
	self.needSetMaterialIconImages[materialPath] = self.needSetMaterialIconImages[materialPath] or {}

	table.insert(self.needSetMaterialIconImages[materialPath], image)
	loadAbAsset(materialPath, false, self.loadAssetCallback, self)
end

function IconMaterialMgr:loadAssetCallback(assetItem)
	if assetItem.IsLoadSuccess then
		table.insert(self.assetItems, assetItem)
		assetItem:Retain()

		self.loadedMaterials[assetItem.AssetUrl] = assetItem:GetResource(assetItem.AssetUrl)
	else
		logError(string.format("load '%s' failed", assetItem.AssetUrl))

		self.loadedMaterials[assetItem.AssetUrl] = IconMaterialMgr.LoadFail
	end

	self.loadingMaterialCount = self.loadingMaterialCount - 1

	if self.loadingMaterialCount == 0 then
		for materialPath, images in pairs(self.needSetMaterialIconImages) do
			for i = 1, #images do
				local material = self.loadedMaterials[materialPath]

				if material ~= IconMaterialMgr.LoadFail and not gohelper.isNil(images[i]) then
					images[i].material = material
				end
			end
		end

		self:recycleNeedSetMaterialImages()
	end
end

function IconMaterialMgr:recycleNeedSetMaterialImages()
	for _, list in pairs(self.needSetMaterialIconImages) do
		tabletool.clear(list)
	end
end

IconMaterialMgr.instance = IconMaterialMgr.New()

return IconMaterialMgr
