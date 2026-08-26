-- chunkname: @modules/logic/versionactivity3_9/racingcar/model/V3a9RacingTalentModel.lua

module("modules.logic.versionactivity3_9.racingcar.model.V3a9RacingTalentModel", package.seeall)

local V3a9RacingTalentModel = class("V3a9RacingTalentModel", BaseModel)

function V3a9RacingTalentModel:onInit()
	self:reInit()
end

function V3a9RacingTalentModel:reInit()
	self._talentGroupMos = nil
	self._talentGroupMoList = nil
	self._talentMos = nil
	self._unlockTalents = {}
end

function V3a9RacingTalentModel:onGetInfos(actId, info)
	if not info then
		return
	end

	self._actId = actId

	self:refreshTalentInfo(actId, info.gifts)
	V3a9RacingRoleListModel.instance:onGetInfos(info.unlockedRacers)
end

function V3a9RacingTalentModel:getActId()
	return self._actId
end

function V3a9RacingTalentModel:getUnlockTalents()
	local group = {}
	local mos = V3a9RacingCarConfig.instance:getTalentCosByActId(self._actId)

	for k, v in pairs(self._unlockTalents) do
		local giftPointConfig = mos[k]

		if giftPointConfig then
			local talentConfig = giftPointConfig[v]

			if talentConfig and (not group[talentConfig.gift_point] or group[talentConfig.gift_point].level < talentConfig.level) then
				group[talentConfig.gift_point] = talentConfig
			end
		end
	end

	return group
end

function V3a9RacingTalentModel:refreshTalentInfo(actId, info)
	local tb = {}

	if info and #info then
		local len = #info

		if len > 0 then
			V3a9RacingCarController.instance:finishTalentGuide()
		end

		for i = 1, len do
			tb[info[i].giftPoint] = info[i].level
		end
	end

	self._unlockTalents = tb

	local mos = self:getTalentMos(actId)
	local unlockTalent = {}

	if mos then
		for id, mo in pairs(mos) do
			local level = tb[id]

			mo:refreshCurLevel(level)

			if level and level > 0 then
				local group = mo:getGroup()

				if (not unlockTalent[group] or unlockTalent[group] < mo:getOrder()) and mo:isMaxLevel() then
					unlockTalent[group] = mo:getOrder()
				end
			end
		end
	end

	local groupMos = self:getTalentGroupMos(actId)

	for group, mo in pairs(groupMos) do
		if not unlockTalent[group] then
			local order = 0

			mo:checkCanUnlockTalent(order)
		end
	end
end

function V3a9RacingTalentModel:onLevelUpTalent(actId, info)
	local unlockTalent = {}

	if info then
		local talentId = info.giftPoint
		local level = info.level

		self._unlockTalents[talentId] = level

		local mo = self:getTalentMoById(actId, talentId)

		if mo then
			local group = mo:getGroup()

			mo:refreshCurLevel(level)

			if (not unlockTalent[group] or unlockTalent[group] < mo:getOrder()) and mo:isMaxLevel() then
				unlockTalent[group] = mo:getOrder()
			end
		end
	end

	local groupMos = self:getTalentGroupMos(actId)

	for group, order in pairs(unlockTalent) do
		local mo = groupMos[group]

		mo:checkCanUnlockTalent(order)
	end
end

function V3a9RacingTalentModel:getTalentMos(actId)
	if not self._talentMos then
		self._talentMos = {}

		local cos = V3a9RacingCarConfig.instance:getTalentCosByActId(actId)

		if cos then
			for id, coList in pairs(cos) do
				local mo = V3a9RacingTalentMO.New()

				mo:init(id, coList)

				self._talentMos[id] = mo
			end
		end
	end

	return self._talentMos
end

function V3a9RacingTalentModel:_initTalentGroupMos(actId)
	self._talentGroupMos = {}
	self._talentGroupMoList = {}

	local mos = self:getTalentMos(actId)

	if mos then
		for id, mo in pairs(mos) do
			local group = mo:getGroup()

			if not self._talentGroupMos[group] then
				self._talentGroupMos[group] = V3a9RacingTalentGroupMO.New()

				self._talentGroupMos[group]:init(group)
			end

			self._talentGroupMos[group]:addTalentMo(mo)
		end

		for _, groupMo in pairs(self._talentGroupMos) do
			table.insert(self._talentGroupMoList, groupMo)
		end

		table.sort(self._talentGroupMoList, function(a, b)
			return a:getGroup() < b:getGroup()
		end)
	end
end

function V3a9RacingTalentModel:getTalentGroupMoList(actId)
	if not self._talentGroupMoList then
		self:_initTalentGroupMos(actId)
	end

	return self._talentGroupMoList
end

function V3a9RacingTalentModel:getTalentGroupMos(actId)
	if not self._talentGroupMos then
		self:_initTalentGroupMos(actId)
	end

	return self._talentGroupMos
end

function V3a9RacingTalentModel:getTalentGroupMoByGroup(actId, group)
	if not self._talentGroupMos then
		self:_initTalentGroupMos(actId)
	end

	return self._talentGroupMos[group]
end

function V3a9RacingTalentModel:getTalentMoById(actId, id)
	local mos = self:getTalentMos(actId)

	return mos and mos[id]
end

function V3a9RacingTalentModel:getCurrencyId(actId)
	self._currencyId = self._currencyId or V3a9RacingCarConfig.instance:getAct243ConstValue(actId, V3a9RacingCarEnum.Act243Const.CurrencyId, false, true, 3902)

	return self._currencyId
end

function V3a9RacingTalentModel:getCurrencyNum(actId)
	local currencyId = self:getCurrencyId(actId)

	return CurrencyModel.instance:getCurrency(currencyId)
end

V3a9RacingTalentModel.instance = V3a9RacingTalentModel.New()

return V3a9RacingTalentModel
