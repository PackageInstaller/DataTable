-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionUnLockItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionUnLockItem", package.seeall)

local V1a6_CachotCollectionUnLockItem = class("V1a6_CachotCollectionUnLockItem", ListScrollCellExtend)

function V1a6_CachotCollectionUnLockItem:onInitView()
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_collection")
	self._txtname = gohelper.findChildText(self.viewGO, "top/#txt_name")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionUnLockItem:addEvents()
	return
end

function V1a6_CachotCollectionUnLockItem:removeEvents()
	return
end

function V1a6_CachotCollectionUnLockItem:_editableInitView()
	return
end

function V1a6_CachotCollectionUnLockItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function V1a6_CachotCollectionUnLockItem:refreshUI()
	local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(self._mo.id)

	if collectionCfg then
		self._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. collectionCfg.icon))

		self._txtname.text = tostring(collectionCfg.name)
	end
end

function V1a6_CachotCollectionUnLockItem:onDestroyView()
	self._simagecollection:UnLoadImage()
end

return V1a6_CachotCollectionUnLockItem
