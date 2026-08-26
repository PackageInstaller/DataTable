-- chunkname: @modules/logic/fight/view/assistboss/FightAssistBoss0.lua

module("modules.logic.fight.view.assistboss.FightAssistBoss0", package.seeall)

local FightAssistBoss0 = class("FightAssistBoss0", FightAssistBossBase)

function FightAssistBoss0:setPrefabPath()
	self.prefabPath = "ui/viewres/assistboss/boss0.prefab"
end

function FightAssistBoss0:initView()
	self.txtValue = gohelper.findChildText(self.viewGo, "txt_value")
	self.txtCD = gohelper.findChildText(self.viewGo, "txt_cd")
	self.goCDMask = gohelper.findChild(self.viewGo, "go_cdmask")
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGo, "image")

	self.click:AddClickListener(self.onClickSelf, self)
end

function FightAssistBoss0:onClickSelf()
	self:playAssistBossCard()
end

function FightAssistBoss0:refreshPower()
	FightAssistBoss0.super.refreshPower(self)

	self.txtValue.text = FightDataHelper.paTaMgr:getAssistBossPower()
end

function FightAssistBoss0:refreshCD()
	local cd = FightDataHelper.paTaMgr:getCurCD()

	self.txtCD.text = string.format("CD:%s", cd)

	gohelper.setActive(self.goCDMask, cd and cd > 0)
end

function FightAssistBoss0:destroy()
	if self.click then
		self.click:RemoveClickListener()
	end

	FightAssistBoss0.super.destroy(self)
end

return FightAssistBoss0
