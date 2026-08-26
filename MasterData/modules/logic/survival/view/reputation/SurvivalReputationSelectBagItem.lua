-- chunkname: @modules/logic/survival/view/reputation/SurvivalReputationSelectBagItem.lua

module("modules.logic.survival.view.reputation.SurvivalReputationSelectBagItem", package.seeall)

local SurvivalReputationSelectBagItem = class("SurvivalReputationSelectBagItem", SimpleListItem)

function SurvivalReputationSelectBagItem:onInit(viewGO)
	local resPath = "ui/viewres/survival/map/survivalmapbagitem.prefab"
	local item = self.viewContainer:getResInst(resPath, self.viewGO)

	self.survivalBagItem = MonoHelper.addNoUpdateLuaComOnceToGo(item, SurvivalBagItem)
end

function SurvivalReputationSelectBagItem:onItemShow(survivalBagItemMo)
	self.survivalBagItem:updateMo(survivalBagItemMo)
end

function SurvivalReputationSelectBagItem:playSearch()
	self.survivalBagItem:playSearch()
end

return SurvivalReputationSelectBagItem
