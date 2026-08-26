-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionEnchantItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionEnchantItem", package.seeall)

local V1a6_CachotCollectionEnchantItem = class("V1a6_CachotCollectionEnchantItem", ListScrollCellExtend)

function V1a6_CachotCollectionEnchantItem:onInitView()
	self._imageframe = gohelper.findChildImage(self.viewGO, "#image_frame")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#simage_collection")
	self._goenchant = gohelper.findChild(self.viewGO, "#go_enchant")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_enchant/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._godescitem = gohelper.findChild(self.viewGO, "scroll_effect/Viewport/Content/#go_descitem")
	self._goselect = gohelper.findChild(self.viewGO, "select")
	self._btnclick = gohelper.getClickWithDefaultAudio(self.viewGO)
	self._scrolleffect = gohelper.findChildScrollRect(self.viewGO, "scroll_effect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionEnchantItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V1a6_CachotCollectionEnchantItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V1a6_CachotCollectionEnchantItem:_btnclickOnClick()
	V1a6_CachotCollectionEnchantController.instance:onSelectEnchantItem(self._mo.id, true)
end

function V1a6_CachotCollectionEnchantItem:_editableInitView()
	self._goScrollContent = gohelper.findChild(self.viewGO, "scroll_effect/Viewport/Content")
end

function V1a6_CachotCollectionEnchantItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function V1a6_CachotCollectionEnchantItem:refreshUI()
	local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(self._mo.cfgId)

	if collectionCfg then
		self._txtname.text = tostring(collectionCfg.name)

		self._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. collectionCfg.icon))
		UISpriteSetMgr.instance:setV1a6CachotSprite(self._imageframe, string.format("v1a6_cachot_img_collectionframe%s", collectionCfg.showRare))
		self:refreshCollectionUI()
		V1a6_CachotCollectionHelper.refreshSkillDesc(collectionCfg, self._goScrollContent, self._godescitem, self._refreshSingleSkillDesc)

		self._scrolleffect.verticalNormalizedPosition = 1
	end
end

function V1a6_CachotCollectionEnchantItem:refreshCollectionUI()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local enchantTargetMO = rogueInfo and rogueInfo:getCollectionByUid(self._mo.enchantUid)

	gohelper.setActive(self._goenchant, enchantTargetMO ~= nil)

	if enchantTargetMO then
		local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(enchantTargetMO.cfgId)

		if collectionCfg then
			self._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. collectionCfg.icon))
		end
	end
end

local skillPercentColor = "#C66030"
local skillBracketColor = "#C66030"

function V1a6_CachotCollectionEnchantItem:_refreshSingleSkillDesc(obj, skillId, index)
	local skillCfg = lua_rule.configDict[skillId]

	if skillCfg then
		local txtEffectDesc = gohelper.findChildText(obj, "txt_desc")

		txtEffectDesc.text = HeroSkillModel.instance:skillDesToSpot(skillCfg.desc, skillPercentColor, skillBracketColor)
	end
end

function V1a6_CachotCollectionEnchantItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function V1a6_CachotCollectionEnchantItem:onDestroyView()
	self._simagecollection:UnLoadImage()
end

return V1a6_CachotCollectionEnchantItem
