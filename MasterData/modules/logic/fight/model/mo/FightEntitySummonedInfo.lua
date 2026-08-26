-- chunkname: @modules/logic/fight/model/mo/FightEntitySummonedInfo.lua

module("modules.logic.fight.model.mo.FightEntitySummonedInfo", package.seeall)

local FightEntitySummonedInfo = pureTable("FightEntitySummonedInfo")

function FightEntitySummonedInfo:ctor()
	self.stanceDic = {}
	self.dataDic = {}
end

function FightEntitySummonedInfo:init(list)
	self.stanceDic = {}
	self.dataDic = {}

	for i, v in ipairs(list) do
		self:addData(v)
	end
end

function FightEntitySummonedInfo:addData(info)
	local data = {}

	data.summonedId = info.summonedId
	data.level = info.level
	data.uid = info.uid
	data.fromUid = info.fromUid
	self.dataDic[info.uid] = data

	local config = FightConfig.instance:getSummonedConfig(data.summonedId, data.level)
	local stanceId = config.stanceId
	local stanceConfig = lua_fight_summoned_stance.configDict[stanceId]

	if stanceConfig then
		self.stanceDic[stanceId] = self.stanceDic[stanceId] or {}

		for i = 1, 20 do
			if not stanceConfig["pos" .. i] then
				break
			end

			if #stanceConfig["pos" .. i] == 0 then
				break
			end

			if not self.stanceDic[stanceId][i] then
				self.stanceDic[stanceId][i] = data.uid
				data.stanceIndex = i

				break
			end
		end
	end

	if not data.stanceIndex then
		logError("挂件位置都被占用了,或者坐标数据没有配置,或者位置表找不到id:" .. stanceId)

		data.stanceIndex = 1
	end

	return data
end

function FightEntitySummonedInfo:removeData(uid)
	local data = self:getData(uid)
	local config = FightConfig.instance:getSummonedConfig(data.summonedId, data.level)
	local stanceId = config.stanceId

	if self.stanceDic[stanceId] then
		for k, v in pairs(self.stanceDic[stanceId]) do
			if v == uid then
				self.stanceDic[stanceId][k] = nil

				break
			end
		end
	end

	self.dataDic[uid] = nil
end

function FightEntitySummonedInfo:getDataDic()
	return self.dataDic
end

function FightEntitySummonedInfo:getData(uid)
	return self.dataDic[uid]
end

function FightEntitySummonedInfo:setLevel(uid, level)
	local info = self.dataDic[uid]

	if info then
		info.level = level
	end
end

return FightEntitySummonedInfo
