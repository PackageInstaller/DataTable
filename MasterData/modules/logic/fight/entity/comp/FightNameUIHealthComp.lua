-- chunkname: @modules/logic/fight/entity/comp/FightNameUIHealthComp.lua

module("modules.logic.fight.entity.comp.FightNameUIHealthComp", package.seeall)

local FightNameUIHealthComp = class("FightNameUIHealthComp", UserDataDispose)

FightNameUIHealthComp.PrefabPath = "ui/viewres/fight/fightsurvivalhealthview.prefab"

function FightNameUIHealthComp.Create(entity, containerGo)
	local comp = FightNameUIHealthComp.New()

	comp:initComp(entity, containerGo)

	return comp
end

function FightNameUIHealthComp:initComp(entity, containerGo)
	self:__onInit()

	self.containerGo = containerGo
	self.entity = entity
	self.entityId = self.entity.id

	self:loadPrefab()
end

function FightNameUIHealthComp:loadPrefab()
	self:clearLoader()

	self.loader = PrefabInstantiate.Create(self.containerGo)

	self.loader:startLoad(FightNameUIHealthComp.PrefabPath, self.onLoadFinish, self)
end

FightNameUIHealthComp.AnchorY = 95

function FightNameUIHealthComp:onLoadFinish()
	self.instanceGo = self.loader:getInstGO()

	local rect = self.instanceGo:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchorY(rect, FightNameUIHealthComp.AnchorY)

	self.imageIcon = gohelper.findChildImage(self.instanceGo, "root/#image_icon")

	self:hideHealth()
	self:tryShowHealth()
	self.addEventCb(self, FightController.instance, FightEvent.HeroHealthValueChange, self.onHeroHealthChange, self)
end

function FightNameUIHealthComp:onHeroHealthChange(entityId, oldHealth, newHealth, offset)
	if entityId ~= self.entityId then
		return
	end

	self:tryShowHealth()
end

function FightNameUIHealthComp:hideHealth()
	gohelper.setActive(self.instanceGo, false)
end

function FightNameUIHealthComp:showHealth()
	gohelper.setActive(self.instanceGo, true)
end

FightNameUIHealthComp.HealthStatus = {
	Two = 2,
	One = 1,
	Four = 4,
	Three = 3
}
FightNameUIHealthComp.HealthThreshold = {
	[FightNameUIHealthComp.HealthStatus.One] = 0,
	[FightNameUIHealthComp.HealthStatus.Two] = 0.334,
	[FightNameUIHealthComp.HealthStatus.Three] = 0.667,
	[FightNameUIHealthComp.HealthStatus.Four] = 1
}
FightNameUIHealthComp.HealthList = {
	FightNameUIHealthComp.HealthStatus.Two,
	FightNameUIHealthComp.HealthStatus.Three,
	FightNameUIHealthComp.HealthStatus.Four
}
FightNameUIHealthComp.HealthStatus2Icon = {
	[FightNameUIHealthComp.HealthStatus.One] = "fight_dikangli_icon_1",
	[FightNameUIHealthComp.HealthStatus.Two] = "fight_dikangli_icon_2",
	[FightNameUIHealthComp.HealthStatus.Three] = "fight_dikangli_icon_3",
	[FightNameUIHealthComp.HealthStatus.Four] = "fight_dikangli_icon_4"
}
FightNameUIHealthComp.HealthStatus2TitleConst = {
	[FightNameUIHealthComp.HealthStatus.One] = 2317,
	[FightNameUIHealthComp.HealthStatus.Two] = 2316,
	[FightNameUIHealthComp.HealthStatus.Three] = 2315,
	[FightNameUIHealthComp.HealthStatus.Four] = 2314
}
FightNameUIHealthComp.HealthStatus2DescConst = {
	[FightNameUIHealthComp.HealthStatus.One] = 2313,
	[FightNameUIHealthComp.HealthStatus.Two] = 2312,
	[FightNameUIHealthComp.HealthStatus.Three] = 2311,
	[FightNameUIHealthComp.HealthStatus.Four] = 2310
}

function FightNameUIHealthComp:tryShowHealth()
	local curHealth = FightHelper.getSurvivalEntityHealth(self.entityId)

	if not curHealth then
		TaskDispatcher.cancelTask(self.hideHealth, self)
		self:hideHealth()

		return
	end

	local healthStatus = self.getCurHealthStatus(curHealth)

	if self.preShowHealthStatus == healthStatus then
		return
	end

	TaskDispatcher.cancelTask(self.hideHealth, self)
	self:showHealth()

	self.preShowHealthStatus = healthStatus

	local icon = FightNameUIHealthComp.HealthStatus2Icon[healthStatus]

	UISpriteSetMgr.instance:setFightSprite(self.imageIcon, icon, true)
	TaskDispatcher.runDelay(self.hideHealth, self, 1)
end

function FightNameUIHealthComp.getCurHealthStatus(health)
	local maxHealth = FightHelper.getSurvivalMaxHealth()

	if not maxHealth then
		return FightNameUIHealthComp.HealthStatus.Four
	end

	if health <= 0 then
		return FightNameUIHealthComp.HealthStatus.One
	end

	local rate = health / maxHealth

	for _, healthStatus in ipairs(FightNameUIHealthComp.HealthList) do
		local threshold = FightNameUIHealthComp.HealthThreshold[healthStatus]

		if rate <= threshold then
			return healthStatus
		end
	end

	return FightNameUIHealthComp.HealthStatus.Four
end

function FightNameUIHealthComp.getHealthIcon(health)
	local status = FightNameUIHealthComp.getCurHealthStatus(health)

	return FightNameUIHealthComp.HealthStatus2Icon[status]
end

function FightNameUIHealthComp.getHealthTitle(healthStatus)
	local constId = FightNameUIHealthComp.HealthStatus2TitleConst[healthStatus]
	local co = constId and lua_survival_const.configDict[constId]

	return co and co.value2
end

function FightNameUIHealthComp.getHealthDesc(healthStatus)
	local constId = FightNameUIHealthComp.HealthStatus2DescConst[healthStatus]
	local co = constId and lua_survival_const.configDict[constId]

	return co and co.value2
end

function FightNameUIHealthComp:clearLoader()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function FightNameUIHealthComp:beforeDestroy()
	TaskDispatcher.cancelTask(self.hideHealth, self)
	self:clearLoader()
	self:__onDispose()
end

return FightNameUIHealthComp
