-- chunkname: @modules/logic/survival/view/shelter/SurvivalHardItem.lua

module("modules.logic.survival.view.shelter.SurvivalHardItem", package.seeall)

local SurvivalHardItem = class("SurvivalHardItem", ListScrollCellExtend)

SurvivalHardItem.ColorSetting = {
	"#82B18C",
	"#709cc6",
	"#9A75A8",
	"#BF865C",
	"#B35555"
}
SurvivalHardItem.IconColorSetting = {
	"#4B814A",
	"#165E88",
	"#8C539A",
	"#C86F2D",
	"#B02525"
}

function SurvivalHardItem:onInitView()
	self.goLine = gohelper.findChild(self.viewGO, "image_Line")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "txt_Desc")
	self.goEmpty = gohelper.findChild(self.viewGO, "#go_Empty")
	self.goIcon = gohelper.findChild(self.viewGO, "#go_Icon")
	self.imageIcon = gohelper.findChildImage(self.viewGO, "#go_Icon")
	self.simageIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Icon/image_Icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalHardItem:addEvents()
	return
end

function SurvivalHardItem:removeEvents()
	return
end

function SurvivalHardItem:_editableInitView()
	return
end

function SurvivalHardItem:onUpdateMO(mo)
	self.mo = mo

	local isEmpty = mo.hardId == nil

	gohelper.setActive(self.goEmpty, isEmpty)
	gohelper.setActive(self.goIcon, not isEmpty)

	if isEmpty then
		self.txtDesc.text = ""
	else
		local config = lua_survival_hardness.configDict[mo.hardId]

		if not SurvivalHardItem.ColorSetting[config.level] then
			self.txtDesc.text = string.format("<color=%s>%s</color>", SurvivalHardItem.ColorSetting[config.level], config.desc)

			if not SurvivalHardItem.IconColorSetting[config.level] then
				SLFramework.UGUI.GuiHelper.SetColor(self.imageIcon, SurvivalHardItem.IconColorSetting[config.level])

				local iconPath = string.format("singlebg/survival_singlebg/difficulty/difficulticon/%s.png", config.icon)

				if string.nilorempty(config.icon) then
					logError("缺少难度图标" .. config.id)
				end

				self.simageIcon:LoadImage(iconPath)
			end
		end
	end
end

function SurvivalHardItem:onDestroyView()
	self.simageIcon:UnLoadImage()
end

return SurvivalHardItem
