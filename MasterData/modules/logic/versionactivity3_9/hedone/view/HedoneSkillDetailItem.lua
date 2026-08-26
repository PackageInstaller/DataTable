-- chunkname: @modules/logic/versionactivity3_9/hedone/view/HedoneSkillDetailItem.lua

module("modules.logic.versionactivity3_9.hedone.view.HedoneSkillDetailItem", package.seeall)

local HedoneSkillDetailItem = class("HedoneSkillDetailItem", SimpleListItem)

function HedoneSkillDetailItem:onInit()
	self._imgIcon = gohelper.findChildImage(self.viewGO, "textDesc/title/#image_IconBG/#image_Icon")
	self._textTitle = gohelper.findChildText(self.viewGO, "textDesc/title/Image_Title/textTitle")
	self._textDesc = gohelper.findChildText(self.viewGO, "textDesc")
end

function HedoneSkillDetailItem:onItemShow(skillId)
	self._textTitle.text = HedoneConfig.instance:getHedoneSkillName(skillId)
	self._textDesc.text = HedoneConfig.instance:getHedoneSkillDesc(skillId)

	local icon = HedoneConfig.instance:getHedoneSkillIcon(skillId)

	UISpriteSetMgr.instance:setV3a9HedoneSprite(self._imgIcon, icon)
end

return HedoneSkillDetailItem
