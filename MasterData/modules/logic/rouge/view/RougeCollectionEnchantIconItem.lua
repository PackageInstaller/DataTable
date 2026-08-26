-- chunkname: @modules/logic/rouge/view/RougeCollectionEnchantIconItem.lua

module("modules.logic.rouge.view.RougeCollectionEnchantIconItem", package.seeall)

local RougeCollectionEnchantIconItem = class("RougeCollectionEnchantIconItem", RougeCollectionIconItem)

function RougeCollectionEnchantIconItem:ctor(viewGO)
	RougeCollectionEnchantIconItem.super.ctor(self, viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionEnchantIconItem:addEvents()
	return
end

function RougeCollectionEnchantIconItem:removeEvents()
	return
end

function RougeCollectionEnchantIconItem:_editableInitView()
	self._holeImageTab = self:getUserDataTb_()

	self.addEventCb(self, RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, self.updateEnchantInfo, self)
end

function RougeCollectionEnchantIconItem:onUpdateMO(mo)
	RougeCollectionEnchantIconItem.super.onUpdateMO(self, mo.cfgId)

	self._mo = mo

	self:refreshAllHoles()
end

function RougeCollectionEnchantIconItem:refreshAllHoles()
	if self._collectionCfg then
		if not self._collectionCfg.holeNum then
			local holeNum = 0

			gohelper.setActive(self._goholetool, holeNum > 0)

			if holeNum > 0 then
				local allEnchants = self._mo:getAllEnchantId() or {}

				gohelper.CreateObjList(self, self.refrehHole, allEnchants, self._goholetool, self._goholeitem)
			end
		end
	end
end

function RougeCollectionEnchantIconItem:refrehHole(obj, enchantId, index)
	local gonone = gohelper.findChild(obj, "go_none")
	local goget = gohelper.findChild(obj, "go_get")
	local hasEncahnt = enchantId and enchantId > 0

	gohelper.setActive(goget, hasEncahnt)
	gohelper.setActive(gonone, not hasEncahnt)

	if not hasEncahnt then
		return
	end

	local iconImg = gohelper.findChildSingleImage(obj, "go_get/image_enchanticon")
	local _, enchantCfgId = self._mo:getEnchantIdAndCfgId(index)
	local iconUrl = RougeCollectionHelper.getCollectionIconUrl(enchantCfgId)

	iconImg:LoadImage(iconUrl)

	self._holeImageTab[iconImg] = true
end

function RougeCollectionEnchantIconItem:updateEnchantInfo(collectionId)
	if not self._mo or self._mo.id ~= collectionId then
		return
	end

	self:refreshAllHoles()
end

function RougeCollectionEnchantIconItem:destroy()
	if self._holeImageTab then
		for iconImage, _ in pairs(self._holeImageTab) do
			iconImage:UnLoadImage()
		end
	end

	RougeCollectionEnchantIconItem.super.destroy(self)
end

return RougeCollectionEnchantIconItem
