-- chunkname: @modules/logic/fight/view/assistboss/FightAssistBoss2.lua

module("modules.logic.fight.view.assistboss.FightAssistBoss2", package.seeall)

local FightAssistBoss2 = class("FightAssistBoss2", FightAssistBossBase)

function FightAssistBoss2:setPrefabPath()
	self.prefabPath = "ui/viewres/assistboss/boss2.prefab"
end

FightAssistBoss2.MaxPower = 6

function FightAssistBoss2:initView()
	FightAssistBoss2.super.initView(self)

	self.goPowerList = self:getUserDataTb_()

	for i = 1, FightAssistBoss2.MaxPower do
		table.insert(self.goPowerList, gohelper.findChild(self.viewGo, string.format("go_energy/%s/light", i)))
	end
end

function FightAssistBoss2:refreshPower()
	FightAssistBoss2.super.refreshPower(self)

	local curPower = FightDataHelper.paTaMgr:getAssistBossPower()

	for i = 1, FightAssistBoss2.MaxPower do
		gohelper.setActive(self.goPowerList[i], i <= curPower)
	end
end

function FightAssistBoss2:onPowerChange(entityId, powerId, oldNum, newNum)
	FightAssistBoss2.super.onPowerChange(self, entityId, powerId, oldNum, newNum)

	if oldNum < newNum then
		FightAudioMgr.instance:playAudio(20232001)
	end
end

return FightAssistBoss2
