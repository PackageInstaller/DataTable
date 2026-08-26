-- chunkname: @modules/logic/survival/view/shelter/SummaryAct/SurvivalSummaryActReputationItem.lua

module("modules.logic.survival.view.shelter.SummaryAct.SurvivalSummaryActReputationItem", package.seeall)

local SurvivalSummaryActReputationItem = class("SurvivalSummaryActReputationItem", SimpleListItem)

function SurvivalSummaryActReputationItem:onInit(viewGO)
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#image_icon")
	self._txtdec1 = gohelper.findChildText(self.viewGO, "root/#txt_dec1")
	self._txtdec2 = gohelper.findChildText(self.viewGO, "root/#txt_dec2")
end

function SurvivalSummaryActReputationItem:onItemShow(info)
	self.reputationId = info.reputationId
	self.value = info.value
	self.npcs = info.npcs
	self.weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	local survivalShelterBuildingMo = self.weekInfo:getBuildingMoByReputationId(self.reputationId)

	self.reputationLevel = survivalShelterBuildingMo.survivalReputationPropMo.prop.reputationLevel
	self.reputationCfg = SurvivalConfig.instance:getReputationCfgById(self.reputationId, self.reputationLevel)

	local reputationType = self.reputationCfg.type
	local icon = SurvivalUnitIconHelper.instance:getRelationIcon(reputationType)

	UISpriteSetMgr.instance:setSurvivalSprite(self._imageicon, icon)

	local reputationName = self.reputationCfg.name

	self._txtdec1.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalSummaryActReputationItem_1"), {
		reputationName,
		#self.npcs
	})
	self._txtdec2.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalSummaryActReputationItem_2"), {
		reputationName,
		self.value
	})
end

return SurvivalSummaryActReputationItem
