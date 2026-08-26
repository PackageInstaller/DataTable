-- chunkname: @modules/logic/fight/view/FightViewTempOperateCardItem.lua

module("modules.logic.fight.view.FightViewTempOperateCardItem", package.seeall)

local FightViewTempOperateCardItem = class("FightViewTempOperateCardItem", UserDataDispose)

function FightViewTempOperateCardItem:init(viewGo, skillId, entityId)
	self:__onInit()

	self.viewGo = viewGo
	self.cardGo = gohelper.findChild(viewGo, "card")
	self.skillId = skillId
	self.entityId = entityId

	self:initView()
end

function FightViewTempOperateCardItem:initView()
	self.lvGoList = self:getUserDataTb_()
	self.lvImgCompList = self:getUserDataTb_()

	for i = 0, 4 do
		local lvGo = gohelper.findChild(self.cardGo, "lv" .. i)
		local lvIcon = gohelper.findChildSingleImage(lvGo, "imgIcon")

		gohelper.setActive(lvGo, true)

		self.lvGoList[i] = lvGo
		self.lvImgCompList[i] = lvIcon
	end
end

function FightViewTempOperateCardItem:refreshCardIcon()
	local skillCo = lua_skill.configDict[self.skillId]
	local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)

	for level, lvGo in pairs(self.lvGoList) do
		gohelper.setActive(lvGo, true)
		gohelper.setActiveCanvasGroup(lvGo, skillCardLv == level)
	end

	local targetIconUrl = ResUrl.getSkillIcon(skillCo.icon)

	for _, image in pairs(self.lvImgCompList) do
		image:LoadImage(targetIconUrl)
	end
end

function FightViewTempOperateCardItem:onDispose()
	if self.lvImgCompList then
		for _, image in pairs(self.lvImgCompList) do
			image:UnLoadImage()
		end
	end

	self:__onDispose()
end

return FightViewTempOperateCardItem
