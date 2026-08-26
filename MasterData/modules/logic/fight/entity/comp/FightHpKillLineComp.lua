-- chunkname: @modules/logic/fight/entity/comp/FightHpKillLineComp.lua

module("modules.logic.fight.entity.comp.FightHpKillLineComp", package.seeall)

local FightHpKillLineComp = class("FightHpKillLineComp", UserDataDispose)

FightHpKillLineComp.resPath = "ui/viewres/fight/fightkilllineview.prefab"
FightHpKillLineComp.LoadStatus = {
	Loaded = 2,
	NotLoaded = 0,
	Loading = 1
}

local LoadStatus = FightHpKillLineComp.LoadStatus

FightHpKillLineComp.KillLineType = {
	NameUiHp = 3,
	BossHp = 1,
	FocusHp = 2
}
FightHpKillLineComp.LineType2NodeName = {
	[FightHpKillLineComp.KillLineType.BossHp] = "boss_hp",
	[FightHpKillLineComp.KillLineType.FocusHp] = "focus_hp",
	[FightHpKillLineComp.KillLineType.NameUiHp] = "name_ui_hp"
}

function FightHpKillLineComp:ctor(lineType)
	self.lineType = lineType
end

function FightHpKillLineComp:init(entityId, containerGo)
	self:__onInit()

	self.loadStatus = LoadStatus.NotLoaded
	self.containerGo = containerGo
	self.containerWidth = recthelper.getWidth(self.containerGo:GetComponent(gohelper.Type_RectTransform))
	self.entityId = entityId
	self.entityMo = FightDataHelper.entityMgr:getById(self.entityId)

	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateBuffActInfo, self.onUpdateBuffActInfo, self)
	self:checkNeedLoadRes()
end

function FightHpKillLineComp:checkNeedLoadRes()
	if self.entityMo and self.entityMo:hasBuffFeature(FightEnum.BuffType_RealDamageKill) then
		self:loadRes()
	end
end

function FightHpKillLineComp:onUpdateBuffActInfo(entityId, buffUid, buffActInfo)
	if entityId ~= self.entityId then
		return
	end

	if not self.entityMo then
		return
	end

	local buffDict = self.entityMo:getBuffDic()
	local buffMo = buffDict and buffDict[buffUid]

	if not buffMo then
		return
	end

	if not self:checkIsKillBuff(buffMo.buffId) then
		return
	end

	self:updateKillLine()
end

function FightHpKillLineComp:onBuffUpdate(entityId, effectType, buffId, buff_uid, configEffect, buffInfoData)
	if entityId ~= self.entityId then
		return
	end

	if not self:checkIsKillBuff(buffId) then
		return
	end

	if effectType == FightEnum.EffectType.BUFFADD then
		self:addKillLine()
	elseif effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
		self:updateKillLine()
	elseif effectType == FightEnum.EffectType.BUFFUPDATE then
		self:updateKillLine()
	end
end

function FightHpKillLineComp:checkIsKillBuff(buffId)
	local featureList = self.entityMo:getFeaturesSplitInfoByBuffId(buffId)

	if not featureList then
		return false
	end

	for _, oneFeature in ipairs(featureList) do
		local buffActCO = lua_buff_act.configDict[oneFeature[1]]

		if buffActCO and buffActCO.type == FightEnum.BuffType_RealDamageKill then
			return true
		end
	end

	return false
end

function FightHpKillLineComp:addKillLine()
	if self.loadStatus == LoadStatus.Loaded then
		return self:updateKillLine()
	end

	if self.loadStatus == LoadStatus.Loading then
		return
	end

	self:loadRes()
end

function FightHpKillLineComp:updateKillLine()
	if self.loadStatus ~= LoadStatus.Loaded then
		return
	end

	gohelper.setActive(self.killLineGo, false)

	if self.entityMo then
		local buffDict = self.entityMo:getBuffDic()

		for _, buffMo in pairs(buffDict) do
			if self:checkIsKillBuff(buffMo.buffId) then
				local actInfoList = buffMo.actInfo

				for _, actInfo in ipairs(actInfoList) do
					if actInfo.actId == FightEnum.BuffActId.RealDamageKill then
						return self:_updateKillLine(actInfo.strParam)
					end
				end
			end
		end
	end
end

function FightHpKillLineComp:_updateKillLine(value)
	if not self.entityMo then
		return
	end

	gohelper.setActive(self.killLineGo, true)

	value = tonumber(value)

	local attrMo = self.entityMo.attrMO
	local maxHp = attrMo.hp
	local rate = value / maxHp
	local anchorX = rate * self.containerWidth

	recthelper.setAnchorX(self.rectKillLine, anchorX)
end

function FightHpKillLineComp:loadRes()
	self.loadStatus = LoadStatus.Loading
	self.loader = PrefabInstantiate.Create(self.containerGo)

	self.loader:startLoad(FightHpKillLineComp.resPath, self.onResLoaded, self)
end

function FightHpKillLineComp:onResLoaded()
	self.loadStatus = LoadStatus.Loaded
	self.killLineGo = self.loader:getInstGO()
	self.rectKillLine = self.killLineGo:GetComponent(gohelper.Type_RectTransform)

	for _, lineType in pairs(FightHpKillLineComp.KillLineType) do
		local go = gohelper.findChild(self.killLineGo, FightHpKillLineComp.LineType2NodeName[lineType])
		local isCurLine = self.lineType == lineType

		gohelper.setActive(go, isCurLine)

		if isCurLine then
			local rectGo = go:GetComponent(gohelper.Type_RectTransform)
			local width = recthelper.getWidth(rectGo)
			local height = recthelper.getHeight(rectGo)

			recthelper.setSize(self.rectKillLine, width, height)
		end
	end

	self:updateKillLine()
end

function FightHpKillLineComp:removeKillLine()
	if self.loader then
		self.loader:onDestroy()

		self.loader = nil
	end

	if self.killLineGo then
		gohelper.destroy(self.killLineGo)

		self.killLineGo = nil
	end

	self.loadStatus = LoadStatus.NotLoaded
end

function FightHpKillLineComp:beforeDestroy()
	self:destroy()
end

function FightHpKillLineComp:destroy()
	self:removeKillLine()
	self:__onDispose()
end

return FightHpKillLineComp
