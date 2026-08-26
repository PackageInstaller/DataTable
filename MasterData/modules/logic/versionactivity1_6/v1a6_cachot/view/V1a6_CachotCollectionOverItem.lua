-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionOverItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionOverItem", package.seeall)

local V1a6_CachotCollectionOverItem = class("V1a6_CachotCollectionOverItem", ListScrollCellExtend)

function V1a6_CachotCollectionOverItem:onInitView()
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
	self._txtdec = gohelper.findChildText(self.viewGO, "#txt_dec")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionOverItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V1a6_CachotCollectionOverItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V1a6_CachotCollectionOverItem:_btnclickOnClick()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnClickCachotOverItem, self._mo.id)
end

function V1a6_CachotCollectionOverItem:_editableInitView()
	return
end

function V1a6_CachotCollectionOverItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function V1a6_CachotCollectionOverItem:refreshUI()
	local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(self._mo.cfgId)

	if collectionCfg then
		self:refreshEnchants(collectionCfg)
		self:refreshEffectDesc(collectionCfg)
		UISpriteSetMgr.instance:setV1a6CachotSprite(self._imageframe, string.format("v1a6_cachot_img_collectionframe%s", collectionCfg.showRare))
		self._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. collectionCfg.icon))

		self._txtname.text = tostring(collectionCfg.name)
	end
end

V1a6_CachotCollectionOverItem.SkillEffectDescColor = "#CAC8C5"
V1a6_CachotCollectionOverItem.CollectionSpDescColor = "#5A8F5C"

function V1a6_CachotCollectionOverItem:refreshEffectDesc(collectionCfg)
	local totalDescStr = ""
	local effectDescStr = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(collectionCfg)

	totalDescStr = string.format("<%s>%s</color>", V1a6_CachotCollectionOverItem.SkillEffectDescColor, effectDescStr)

	local collectionSpDesc = collectionCfg and collectionCfg.spdesc

	if not string.nilorempty(collectionSpDesc) then
		collectionSpDesc = HeroSkillModel.instance:skillDesToSpot(collectionSpDesc)
		collectionSpDesc = string.format("<%s>%s</color>", V1a6_CachotCollectionOverItem.CollectionSpDescColor, collectionSpDesc)
		totalDescStr = string.format("%s\n%s", totalDescStr, collectionSpDesc)
	end

	self._txtdec.text = totalDescStr
end

function V1a6_CachotCollectionOverItem:refreshEnchants(collectionCfg)
	gohelper.setActive(self._gogrid1, collectionCfg and collectionCfg.holeNum >= 1)
	gohelper.setActive(self._gogrid2, collectionCfg and collectionCfg.holeNum >= 2)

	if not collectionCfg or collectionCfg.holeNum <= 0 then
		return
	end

	self:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Left)
	self:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Right)
end

function V1a6_CachotCollectionOverItem:refreshSingleHole(holeIndex)
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

function V1a6_CachotCollectionOverItem:releaseSingleImage()
	if V1a6_CachotEnum.CollectionHole then
		for _, collectionHole in pairs(V1a6_CachotEnum.CollectionHole) do
			local simage = self["_simageicon" .. collectionHole]

			if simage then
				simage:UnLoadImage()
			end
		end
	end
end

function V1a6_CachotCollectionOverItem:onDestroyView()
	self._simagecollection:UnLoadImage()
	self:releaseSingleImage()
end

return V1a6_CachotCollectionOverItem
