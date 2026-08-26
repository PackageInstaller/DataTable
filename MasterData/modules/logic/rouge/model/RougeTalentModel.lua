-- chunkname: @modules/logic/rouge/model/RougeTalentModel.lua

module("modules.logic.rouge.model.RougeTalentModel", package.seeall)

local RougeTalentModel = class("RougeTalentModel", BaseModel)

function RougeTalentModel:onInit()
	return
end

function RougeTalentModel:reInit()
	return
end

function RougeTalentModel:setOutsideInfo(rougeInfo)
	self.season = rougeInfo.season
	self.talentponint = rougeInfo.geniusPoint
	self._isNewStage = rougeInfo.isGeniusNewStage

	if rougeInfo.geniusIds then
		self.hadUnlockTalent = rougeInfo.geniusIds
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentTreeInfo)
end

function RougeTalentModel:updateGeniusIDs(rougeInfo)
	local geniusId

	if self.season == rougeInfo.season then
		if rougeInfo.geniusIds then
			self.hadUnlockTalent = rougeInfo.geniusIds
		end

		if rougeInfo.geniusId then
			geniusId = rougeInfo.geniusId
		end
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentTreeInfo, geniusId)
end

function RougeTalentModel:calculateTalent()
	if not self.hadUnlockTalent or #self.hadUnlockTalent == 0 then
		return
	end

	local attributeList = {}
	local showList = {}
	local tempList1 = {}
	local tempList2 = {}

	for i, id in ipairs(self.hadUnlockTalent) do
		local season = RougeOutsideModel.instance:season()
		local talentco = RougeTalentConfig.instance:getBranchConfigByID(season, id)

		if talentco.show == 1 then
			local talent = talentco.talent

			showList[talent] = showList[talent] or {}

			table.insert(showList[talent], id)
		elseif not string.nilorempty(talentco.attribute) then
			local temp1 = string.split(talentco.attribute, "|")

			for index, value in ipairs(temp1) do
				local co = {}

				co.rate = nil

				local temp = string.split(value, "#")
				local attribute = temp[1]
				local attributeconfig = HeroConfig.instance:getHeroAttributeCO(tonumber(attribute))

				co.id = tonumber(attribute)
				co.name = attributeconfig.name
				co.rate = tonumber(temp[2])
				co.ismul = true
				co.icon = co.id == 215 and "icon_att_205" or co.id == 216 and "icon_att_206" or "icon_att_" .. attribute
				co.isattribute = true

				if #tempList1 > 0 then
					local isplus = false

					for _, v in ipairs(tempList1) do
						if co.id == v.id then
							v.rate = v.rate + co.rate
							isplus = true
						end
					end

					if not isplus then
						table.insert(tempList1, co)
					end
				else
					table.insert(tempList1, co)
				end
			end
		elseif not string.nilorempty(talentco.openDesc) then
			local overconfig = RougeTalentConfig.instance:getTalentOverConfigById(tonumber(talentco.openDesc))
			local co = {}

			co.id = overconfig.id
			co.name = overconfig.name
			co.rate = tonumber(overconfig.value)
			co.ismul = overconfig.ismul == 1
			co.icon = overconfig.icon
			co.isattribute = false

			if #tempList2 > 0 then
				local isplus = false

				for _, temp in ipairs(tempList2) do
					if co.id == temp.id then
						temp.rate = temp.rate + co.rate
						isplus = true
					end
				end

				if not isplus then
					table.insert(tempList2, co)
				end
			else
				table.insert(tempList2, co)
			end
		end
	end

	table.sort(tempList1, RougeTalentModel.sortattributeList)
	table.sort(tempList2, RougeTalentModel.sortattributeList)
	tabletool.addValues(attributeList, tempList1)
	tabletool.addValues(attributeList, tempList2)

	return attributeList, showList
end

function RougeTalentModel.sortattributeList(a, b)
	return a.id < b.id
end

function RougeTalentModel:isTalentUnlock(id)
	for _, value in pairs(self.hadUnlockTalent) do
		if value == id then
			return true
		end
	end

	return false
end

function RougeTalentModel:getHadConsumeTalentPoint()
	if not self.hadUnlockTalent or #self.hadUnlockTalent == 0 then
		return 0
	end

	local consume = 0
	local season = RougeOutsideModel.instance:season()

	for index, id in ipairs(self.hadUnlockTalent) do
		local co = RougeTalentConfig.instance:getBranchConfigByID(season, id)

		consume = consume + co.cost
	end

	return consume
end

function RougeTalentModel:getHadAllTalentPoint()
	local consume = self:getHadConsumeTalentPoint()
	local count = consume
	local limit = RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.SkillPointLimit)

	limit = tonumber(limit)

	if self.talentponint then
		local temp = consume + self.talentponint

		count = limit < temp and limit or temp
	end

	return count
end

function RougeTalentModel:getTalentPoint()
	return self.talentponint
end

function RougeTalentModel:getUnlockNumByTalent(talentid)
	if not self.hadUnlockTalent or #self.hadUnlockTalent == 0 then
		return 0
	end

	local num = 0

	for i, id in ipairs(self.hadUnlockTalent) do
		local season = RougeOutsideModel.instance:season()
		local co = RougeTalentConfig.instance:getBranchConfigByID(season, id)

		if co.talent == talentid then
			num = num + 1
		end
	end

	return num
end

function RougeTalentModel:checkNodeLock(config)
	local id = config.id

	if config.talent == 1 and config.isOrigin == 1 then
		return false
	end

	if not self.hadUnlockTalent or #self.hadUnlockTalent == 0 then
		return true
	end

	local season = RougeOutsideModel.instance:season()
	local config = RougeTalentConfig.instance:getBranchConfigByID(season, id)

	if config.isOrigin == 1 then
		return self:checkBigNodeLock(config.talent)
	else
		return self:checkBeforeNodeLock(id)
	end

	return true
end

function RougeTalentModel:checkBeforeNodeLock(id)
	local season = RougeOutsideModel.instance:season()
	local config = RougeTalentConfig.instance:getBranchConfigByID(season, id)

	if config.isOrigin == 1 then
		return false
	end

	local beforeids = string.split(config.before, "|")

	if beforeids then
		for _, unlockid in ipairs(self.hadUnlockTalent) do
			for i, beforeid in ipairs(beforeids) do
				if unlockid == tonumber(beforeid) then
					return false
				end
			end
		end
	end

	return true
end

function RougeTalentModel:checkBigNodeLock(id)
	if id == 1 then
		return false
	end

	local season = RougeOutsideModel.instance:season()
	local config = RougeTalentConfig.instance:getConfigByTalent(season, id)

	if self:getHadConsumeTalentPoint() >= config.cost then
		return false
	end

	return true
end

function RougeTalentModel:checkNodeCanLevelUp(config)
	if self:checkNodeLock(config) then
		return
	end

	local isFirstNode = config.talent == 1 and config.isOrigin == 1

	if self:checkNodeLight(config.id) then
		if isFirstNode then
			return false
		end
	elseif not self.talentponint or self.talentponint <= 0 then
		return false
	elseif self.talentponint >= config.cost then
		return true
	end
end

function RougeTalentModel:checkBigNodeShowUp(id)
	local list = RougeTalentConfig.instance:getBranchConfigListByTalent(id)
	local canup = false

	for _, co in ipairs(list) do
		canup = self:checkNodeCanLevelUp(co)

		if co.talent == 1 then
			local unlockNum = self:getUnlockNumByTalent(1)
			local coNum = RougeTalentConfig.instance:getBranchNumByTalent(1)

			if unlockNum == coNum then
				return false
			end
		end

		if canup then
			return canup
		end
	end
end

function RougeTalentModel:checkAnyNodeCanUp()
	local season = RougeOutsideModel.instance:season()
	local list = RougeTalentConfig.instance:getRougeTalentDict(season)
	local canup = false

	for index, co in ipairs(list) do
		if self:checkBigNodeShowUp(co.id) then
			canup = true

			break
		end
	end

	return canup
end

function RougeTalentModel:setCurrentSelectIndex(index)
	self._currentSelectIndex = index
end

function RougeTalentModel:checkIsCurrentSelectView(index)
	if not self._currentSelectIndex or not index then
		return false
	end

	return self._currentSelectIndex == index
end

function RougeTalentModel:setNewStage(stage)
	self._isNewStage = stage
end

function RougeTalentModel:checkIsNewStage()
	return self._isNewStage
end

function RougeTalentModel:checkNodeLight(id)
	for _, value in ipairs(self.hadUnlockTalent) do
		if value == id then
			return true
		end
	end

	return false
end

function RougeTalentModel:getUnlockTalent()
	return self.hadUnlockTalent
end

function RougeTalentModel:getAllUnlockPoint()
	if not self.hadUnlockTalent or #self.hadUnlockTalent == 0 then
		return 0
	end

	return #self.hadUnlockTalent
end

function RougeTalentModel:getNextNeedUnlockTalent()
	local season = RougeOutsideModel.instance:season()
	local coList = RougeTalentConfig.instance:getRougeTalentDict(season)
	local cost2talent = {}

	for _, co in ipairs(coList) do
		cost2talent[co.cost] = cost2talent[co.cost] or {}

		table.insert(cost2talent[co.cost], co.id)
	end

	local cost

	for index, co in ipairs(coList) do
		if self:checkBigNodeLock(index) then
			cost = co.cost

			break
		end
	end

	if cost2talent[cost] then
		return cost2talent[cost]
	end
end

function RougeTalentModel:calcTalentUnlockIds(refIdsDict)
	for _, value in pairs(self.hadUnlockTalent) do
		if refIdsDict[value] ~= nil then
			refIdsDict[value] = true
		end
	end
end

RougeTalentModel.instance = RougeTalentModel.New()

return RougeTalentModel
