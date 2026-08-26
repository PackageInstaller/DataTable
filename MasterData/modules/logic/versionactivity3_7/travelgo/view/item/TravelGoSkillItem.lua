-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/item/TravelGoSkillItem.lua

module("modules.logic.versionactivity3_7.travelgo.view.item.TravelGoSkillItem", package.seeall)

local TravelGoSkillItem = class("TravelGoSkillItem", SimpleListItem)

function TravelGoSkillItem:onInit()
	self.imgIcon = gohelper.findChildImage(self.viewGO, "textDesc/title/#image_IconBG/#image_Icon")
	self.textTitle = gohelper.findChildText(self.viewGO, "textDesc/title/Image_Title/textTitle")
	self.textDesc = gohelper.findChildText(self.viewGO, "textDesc")
	self._imageIconBG = gohelper.findChildImage(self.viewGO, "textDesc/title/#image_IconBG")
	self._imageTitle = gohelper.findChildImage(self.viewGO, "textDesc/title/Image_Title")
end

function TravelGoSkillItem:onItemShow(data)
	self.skill = data
	self.cfg = self.skill.cfg
	self.textTitle.text = self.cfg.name
	self.textDesc.text = self.cfg.desc

	local colorStr = TravelGoController.instance:getSkillRareColor(self.cfg.rare)
	local color = GameUtil.parseColor(colorStr)

	self._imageIconBG.color = color
	self._imageTitle.color = color

	UISpriteSetMgr.instance:setBuffSprite(self.imgIcon, self.cfg.icon)
end

return TravelGoSkillItem
