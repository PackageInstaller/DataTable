-- chunkname: @modules/logic/survival/view/tech/item/SurvivalTechBkgItem.lua

module("modules.logic.survival.view.tech.item.SurvivalTechBkgItem", package.seeall)

local SurvivalTechBkgItem = class("SurvivalTechBkgItem", SimpleListItem)

function SurvivalTechBkgItem:onInit()
	self.Image_BG1 = gohelper.findChild(self.viewGO, "Image_BG1")
	self.Image_BG2 = gohelper.findChild(self.viewGO, "Image_BG2")
	self.Image_BG3 = gohelper.findChild(self.viewGO, "Image_BG3")
end

function SurvivalTechBkgItem:onItemShow(data)
	gohelper.setActive(self.Image_BG1, self.isFirstItem)
	gohelper.setActive(self.Image_BG2, not self.isFirstItem and not self.isLastItem)
	gohelper.setActive(self.Image_BG3, self.isLastItem)
end

return SurvivalTechBkgItem
