-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikeTriggerSkill.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikeTriggerSkill", package.seeall)

local DeleikeTriggerSkill = class("DeleikeTriggerSkill", DeleikeTriggerBase)

function DeleikeTriggerSkill:init(go)
	DeleikeTriggerSkill.super.init(self, go)

	self.goSkill1 = gohelper.findChild(go, "skill1")
	self.goSkill2 = gohelper.findChild(go, "skill2")
	self.pickupDist = 65
end

function DeleikeTriggerSkill:onSetData()
	gohelper.setActive(self.goSkill1, self.type == DeleikeEnum.TriggerType.Skill1)
	gohelper.setActive(self.goSkill2, self.type == DeleikeEnum.TriggerType.Skill2)
end

function DeleikeTriggerSkill:onPicked()
	DeleikeGameMgr.instance:onTriggerPicked(self.type)
end

function DeleikeTriggerSkill:tryEat()
	if self.isCollected then
		return false
	end

	self:_collect()
	gohelper.setActive(self.go, false)
	DeleikeGameMgr.instance:onTriggerPicked(self.type)

	return true
end

return DeleikeTriggerSkill
