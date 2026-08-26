-- chunkname: @modules/logic/fight/view/FightBossPassiveTipsItemView.lua

module("modules.logic.fight.view.FightBossPassiveTipsItemView", package.seeall)

local FightBossPassiveTipsItemView = class("FightBossPassiveTipsItemView", FightBaseView)

function FightBossPassiveTipsItemView:onInitView()
	self.icon = gohelper.findChildImage(self.viewGO, "title/simage_icon")
	self.nameText = gohelper.findChildText(self.viewGO, "title/txt_name")
	self.descText = gohelper.findChildText(self.viewGO, "txt_desc")
end

function FightBossPassiveTipsItemView:addEvents()
	return
end

function FightBossPassiveTipsItemView:removeEvents()
	return
end

function FightBossPassiveTipsItemView:onRefreshItemData(skillInfo)
	self.viewHeight = 0
	self.skillInfo = skillInfo

	UISpriteSetMgr.instance:setFightPassiveSprite(self.icon, skillInfo.icon)

	local skillCO = lua_skill.configDict[skillInfo.skillId]

	self.nameText.text = skillCO.name

	self.nameText:ForceMeshUpdate(true, true)

	self.viewHeight = self.viewHeight + self.nameText:GetRenderedValues().y

	local desctxt = FightConfig.instance:getEntitySkillDesc(self.PARENT_VIEW.entityId, skillCO)

	desctxt = HeroSkillModel.instance:skillDesToSpot(desctxt, "#CC492F", "#485E92")
	self.descText.text = desctxt

	self.descText:ForceMeshUpdate(true, true)

	self.viewHeight = self.viewHeight + self.descText:GetRenderedValues().y
	self.viewHeight = self.viewHeight + 40

	recthelper.setAnchorY(gohelper.findChild(self.viewGO, "txt_desc/image_line").transform, -self.viewHeight + 120)
end

function FightBossPassiveTipsItemView:onClose()
	return
end

function FightBossPassiveTipsItemView:onDestroyView()
	return
end

return FightBossPassiveTipsItemView
