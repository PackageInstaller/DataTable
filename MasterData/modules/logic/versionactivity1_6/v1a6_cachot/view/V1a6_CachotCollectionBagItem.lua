-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionBagItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionBagItem", package.seeall)

local V1a6_CachotCollectionBagItem = class("V1a6_CachotCollectionBagItem", ListScrollCellExtend)

function V1a6_CachotCollectionBagItem:onInitView()
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#simage_collection")
	self._imageframe = gohelper.findChildImage(self.viewGO, "#image_frame")
	self._gogrid1 = gohelper.findChild(self.viewGO, "layout/#go_grid1")
	self._gonone1 = gohelper.findChild(self.viewGO, "layout/#go_grid1/#go_none1")
	self._goget1 = gohelper.findChildSingleImage(self.viewGO, "layout/#go_grid1/#go_get1")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "layout/#go_grid1/#go_get1/#simage_icon1")
	self._gonone2 = gohelper.findChild(self.viewGO, "layout/#go_grid2/#go_none2")
	self._gogrid2 = gohelper.findChild(self.viewGO, "layout/#go_grid2")
	self._goget2 = gohelper.findChild(self.viewGO, "layout/#go_grid2/#go_get2")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "layout/#go_grid2/#go_get2/#simage_icon2")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionBagItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V1a6_CachotCollectionBagItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V1a6_CachotCollectionBagItem:_btnclickOnClick()
	if self._isSelect then
		return
	end

	if self._clickCallBack then
		self._clickCallBack(self._clickCallBackObj)
	else
		self:defaultClickCallBack()
	end
end

function V1a6_CachotCollectionBagItem:_editableInitView()
	return
end

function V1a6_CachotCollectionBagItem:_editableAddEvents()
	return
end

function V1a6_CachotCollectionBagItem:_editableRemoveEvents()
	return
end

function V1a6_CachotCollectionBagItem:onUpdateMO(mo)
	gohelper.setActive(self.viewGO, not mo.isFake)

	if mo.isFake then
		return
	end

	self._mo = mo

	self:refreshUI()
end

function V1a6_CachotCollectionBagItem:refreshUI()
	local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(self._mo.cfgId)

	if collectionCfg then
		self:refreshEnchants(collectionCfg)
		UISpriteSetMgr.instance:setV1a6CachotSprite(self._imageframe, string.format("v1a6_cachot_img_collectionframe%s", collectionCfg.showRare))

		local collectionState = self._mo.state

		gohelper.setActive(self._gonew, collectionState == V1a6_CachotEnum.CollectionState.New)
		self._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. collectionCfg.icon))
	end
end

function V1a6_CachotCollectionBagItem:refreshEnchants(collectionCfg)
	gohelper.setActive(self._gogrid1, collectionCfg and collectionCfg.holeNum >= 1)
	gohelper.setActive(self._gogrid2, collectionCfg and collectionCfg.holeNum >= 2)

	if not collectionCfg or collectionCfg.holeNum <= 0 then
		return
	end

	self:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Left)
	self:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Right)
end

function V1a6_CachotCollectionBagItem:refreshSingleHole(holeIndex)
	if self._mo then
		local enchantId = self._mo:getEnchantId(holeIndex)

		if enchantId and enchantId ~= 0 then
			gohelper.setActive(self["_gonone" .. holeIndex], false)
			gohelper.setActive(self["_goget" .. holeIndex], true)

			local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
			local enchantMO = rogueInfo and rogueInfo:getCollectionByUid(enchantId)
			local enchantCfgId = enchantMO and enchantMO.cfgId
			local enchantCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(enchantCfgId)

			if enchantCfg then
				self["_simageicon" .. holeIndex]:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. enchantCfg.icon))
			end
		else
			gohelper.setActive(self["_gonone" .. holeIndex], true)
			gohelper.setActive(self["_goget" .. holeIndex], false)
		end
	end
end

function V1a6_CachotCollectionBagItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goselect, isSelect)
end

function V1a6_CachotCollectionBagItem:setClickCallBack(callBack, callBackObj)
	self._clickCallBack = callBack
	self._clickCallBackObj = callBackObj
end

function V1a6_CachotCollectionBagItem:defaultClickCallBack()
	V1a6_CachotCollectionBagController.instance:onSelectBagItemByIndex(self._index)
end

function V1a6_CachotCollectionBagItem:onDestroyView()
	self._clickCallBack = nil
	self._clickCallBackObj = nil

	self._simagecollection:UnLoadImage()
end

return V1a6_CachotCollectionBagItem
