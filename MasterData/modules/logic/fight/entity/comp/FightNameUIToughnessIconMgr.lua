-- chunkname: @modules/logic/fight/entity/comp/FightNameUIToughnessIconMgr.lua

module("modules.logic.fight.entity.comp.FightNameUIToughnessIconMgr", package.seeall)

local FightNameUIToughnessIconMgr = class("FightNameUIToughnessIconMgr", FightBaseClass)

function FightNameUIToughnessIconMgr:onConstructor(entity, viewGO, monsterConfig)
	self.entity = entity
	self.entityData = entity.entityData
	self.viewGO = viewGO
	self.monsterConfig = monsterConfig
	self.toughnessConfig = lua_toughnessskill.configDict[monsterConfig.toughnessSkill]

	if not self.toughnessConfig then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self.buffId = self.toughnessConfig.cdBuff

	local featureList = self.entityData:getFeaturesSplitInfoByBuffId(self.buffId) or {}

	self.maxCd = 0

	for i, v in ipairs(featureList) do
		if v[1] == 1102 then
			self.maxCd = v[2] + 1
		end
	end

	self.empty = gohelper.findChild(self.viewGO, "empty")
	self.has = gohelper.findChild(self.viewGO, "has")
	self.icon = gohelper.findChildImage(self.viewGO, "has/#image_reward")
	self.cd = gohelper.findChild(self.viewGO, "has/cd")

	gohelper.addChild(self.viewGO, self.cd)

	self.cdText = gohelper.findChildText(self.cd, "#txt_cd")
	self.cdImage = gohelper.findChildImage(self.cd, "#go_progress")

	self:showIcon()
	self:com_registFightEvent(FightEvent.OnHpChange, self.onHpChange)
	self:com_registMsg(FightMsgId.OnAddBuff, self.onAddBuff)
	self:com_registMsg(FightMsgId.OnRemoveBuff, self.onRemoveBuff)
	self:com_registMsg(FightMsgId.OnUpdateBuff, self.onUpdateBuff)
	self:com_registMsg(FightMsgId.ChangeEntityToughness, self.showIcon)
	self:com_registMsg(FightMsgId.UpdateEntityBuffActInfo, self.onUpdateEntityBuffActInfo)
end

function FightNameUIToughnessIconMgr:onHpChange(entity)
	if entity.id ~= self.entityData.id then
		return
	end

	self:showIcon()
end

function FightNameUIToughnessIconMgr:onUpdateEntityBuffActInfo(targetId, buffUid, buffActInfo)
	if targetId ~= self.entityData.id then
		return
	end

	if buffActInfo.actId ~= 1102 then
		return
	end

	self:showIcon()
end

function FightNameUIToughnessIconMgr:onAddBuff(buffData)
	if buffData.buffId == self.buffId then
		self:showIcon()
	end
end

function FightNameUIToughnessIconMgr:onRemoveBuff(buffData)
	if buffData.buffId == self.buffId then
		self:showIcon()
	end
end

function FightNameUIToughnessIconMgr:onUpdateBuff(buffData)
	if buffData.buffId == self.buffId then
		self:showIcon()
	end
end

function FightNameUIToughnessIconMgr:showIcon()
	local isBroken = self.entityData.isBroken

	if not isBroken then
		gohelper.setActive(self.empty, false)
		gohelper.setActive(self.has, true)
		gohelper.setActive(self.cd, false)
		UISpriteSetMgr.instance:setFightSprite(self.icon, self.toughnessConfig.iconNormal, true)
	else
		local hasBuff
		local buffData = self.entityData:getBuffDataByBuffId(self.buffId)

		if buffData and buffData.actInfo then
			for i, v in ipairs(buffData.actInfo) do
				if v.actId == 1102 and v.param[1] > 0 then
					hasBuff = v.param[1]
				end
			end

			if hasBuff then
				gohelper.setActive(self.empty, false)
				gohelper.setActive(self.has, false)
				gohelper.setActive(self.cd, true)

				self.cdText.text = hasBuff
				self.cdImage.fillAmount = hasBuff / self.maxCd
			else
				gohelper.setActive(self.empty, false)
				gohelper.setActive(self.has, false)
				gohelper.setActive(self.cd, true)

				self.cdText.text = self.maxCd
				self.cdImage.fillAmount = 1
			end
		else
			gohelper.setActive(self.empty, true)
			gohelper.setActive(self.has, false)
			gohelper.setActive(self.cd, false)
		end
	end
end

return FightNameUIToughnessIconMgr
