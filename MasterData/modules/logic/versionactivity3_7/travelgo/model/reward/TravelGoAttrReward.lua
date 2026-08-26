-- chunkname: @modules/logic/versionactivity3_7/travelgo/model/reward/TravelGoAttrReward.lua

module("modules.logic.versionactivity3_7.travelgo.model.reward.TravelGoAttrReward", package.seeall)

local TravelGoAttrReward = pureTable("TravelGoAttrReward", TravelGoRewardBase)

function TravelGoAttrReward:onSetData(param)
	self.attrId = tonumber(param[1])
	self.valueType = tonumber(param[2])
	self.value = tonumber(param[3])
end

function TravelGoAttrReward:giveRewards(param)
	local playerEntity = TravelGoController.instance.travelGoEntityMgr.playerEntity

	playerEntity.attributes:addModifier(self.valueType == 0, self.attrId, self.value, {
		eventId = self.eventId
	})
end

function TravelGoAttrReward:getRewardDesc(isStoryEvent)
	local attrId = self.attrId
	local cfg = lua_activity220_attribute.configDict[attrId]
	local str

	if self.valueType == 0 then
		if self.value >= 0 then
			local v = math.abs(self.value / 1000 * 100)

			str = isStoryEvent and string.format("%s<color=#B0E3A4>+%s%%</color>", cfg.name, v) or string.format("%s+%s%%", cfg.name, v)
		else
			local v = math.abs(self.value / 1000 * 100)

			str = isStoryEvent and string.format("%s<color=#B0E3A4>-%s%%</color>", cfg.name, v) or string.format("%s-%s%%", cfg.name, v)
		end
	else
		str = self.value >= 0 and (isStoryEvent and cfg.name .. "<color=#B0E3A4>" .. "+" .. self.value .. "</color>" or cfg.name .. "+" .. self.value) or isStoryEvent and cfg.name .. "<color=#B0E3A4>" .. "-" .. math.abs(self.value) .. "</color>" or cfg.name .. "-" .. math.abs(self.value)
	end

	return str
end

function TravelGoAttrReward:getRewardIcon()
	if self.attrId == TravelGoBattleEnum.AttrType.Hp or self.attrId == TravelGoBattleEnum.AttrType.MaxHp then
		return "v3a7_xiaoruiannong_game_lifeicon"
	elseif self.attrId == TravelGoBattleEnum.AttrType.Attack then
		return "v3a7_xiaoruiannong_game_magicicon"
	elseif self.attrId == TravelGoBattleEnum.AttrType.Defence then
		return "v3a7_xiaoruiannong_game_defenceicon"
	else
		return "v3a7_xiaoruiannong_game_magicicon"
	end
end

function TravelGoAttrReward:getRewardBkg()
	if self.attrId == TravelGoBattleEnum.AttrType.Hp or self.attrId == TravelGoBattleEnum.AttrType.MaxHp then
		return "v3a7_xiaoruiannong_game_lifetxtbg"
	elseif self.attrId == TravelGoBattleEnum.AttrType.Attack then
		return "v3a7_xiaoruiannong_game_magictxtbg"
	elseif self.attrId == TravelGoBattleEnum.AttrType.Defence then
		return "v3a7_xiaoruiannong_game_defencetxtbg"
	end

	return "v3a7_xiaoruiannong_game_magictxtbg"
end

return TravelGoAttrReward
