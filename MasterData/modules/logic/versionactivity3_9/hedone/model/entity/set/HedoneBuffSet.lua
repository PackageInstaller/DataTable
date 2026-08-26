-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/set/HedoneBuffSet.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.set.HedoneBuffSet", package.seeall)

local HedoneBuffSet = class("HedoneBuffSet", HedoneBaseSet)

function HedoneBuffSet:onCtor()
	self._buffUidDict = {}
	self._buffId2UidList = {}
end

function HedoneBuffSet:addBuff2Set(buffId)
	local buff
	local cfg = HedoneConfig.instance:getHedoneBuffCfg(buffId, true)

	if cfg then
		local lifeType = HedoneConfig.instance:getHedoneBuffLifeRule(buffId)

		if not HedoneGameEnum.BuffLifeRuleDict[lifeType] then
			logError(string.format("HedoneBuffSet:addBuff2Set error, buff life type %s is invalid, buffId:%s", lifeType, buffId))
		end

		local uid = self:_generateUid()

		buff = HedoneBuff.New(uid, buffId)
		self._buffUidDict[uid] = buff

		local uidList = GameUtil.tabletool_checkDictTable(self._buffId2UidList, buffId)

		uidList[#uidList + 1] = uid
	end

	return buff
end

function HedoneBuffSet:consumeBuffLifeInSet(lifeType, subLifeType, reduceVal)
	if lifeType == HedoneGameEnum.BuffLifeRule.Permanent then
		return
	end

	local removeUidList = {}

	for buffId, uidList in pairs(self._buffId2UidList) do
		local tKey = HedoneGameHelper.getBuffLifeUniqueKey(buffId)

		if tKey == ((not string.nilorempty(subLifeType) or nil) and string.format("%s#%s", lifeType, subLifeType)) then
			for _, buffUid in ipairs(uidList) do
				self:_consumeSingleBuffLife(buffUid, reduceVal, removeUidList)
			end
		end
	end

	return removeUidList
end

function HedoneBuffSet:_consumeSingleBuffLife(buffUid, reduceVal, removeUidList)
	local buff = self:getBuffInSet(buffUid)

	if not buff then
		return
	end

	local isAlive = buff:addConsumedLife(reduceVal)

	if not isAlive then
		removeUidList[#removeUidList + 1] = buffUid
	end
end

function HedoneBuffSet:removeBuffInSet(uid)
	local buff = self._buffUidDict[uid]

	if not buff then
		return
	end

	local buffId = buff:getId()
	local uidList = self._buffId2UidList[buffId]

	if uidList then
		tabletool.removeValue(uidList, uid)
	end

	self._buffUidDict[uid] = nil

	return buff
end

function HedoneBuffSet:getBuffId2UidList()
	return self._buffId2UidList
end

function HedoneBuffSet:getBuffInSet(uid)
	return self._buffUidDict[uid]
end

return HedoneBuffSet
