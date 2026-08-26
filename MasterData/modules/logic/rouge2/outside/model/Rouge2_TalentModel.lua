-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_TalentModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_TalentModel", package.seeall)

local Rouge2_TalentModel = class("Rouge2_TalentModel", BaseModel)

function Rouge2_TalentModel:onInit()
	self:reInit()
end

function Rouge2_TalentModel:reInit()
	self._talentMoDic = {}
	self.talentUpdatePoint = 0
	self.haveAllTalentUpdatePoint = 0
	self._curTalentId = nil
	self.activeTalentCount = 0
	self.hadUnlockTalent = {}
	self.hadUnlockTalentDic = {}
	self._careerExpDic = {}
	self._careerLevelDic = {}
	self._careerMaxLevelDic = {}
	self._newUnlockCareerTalentList = {}
	self._careerAddExpDic = {}
end

function Rouge2_TalentModel:updateInfo(info)
	self:updateUnlockTalent(info.geniusIds)
	self:updateTalentUpdatePoint(info.geniusPoint)
	self:updateCareerLevel(info.careerLevelInfo)
	Rouge2_OutsideModel.instance:checkTalentRedDot()
end

function Rouge2_TalentModel:updateTalentUpdatePoint(geniusPoint)
	self.talentUpdatePoint = geniusPoint or 0

	self:calculateUseTalent()
	Rouge2_OutsideModel.instance:checkTalentRedDot()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnUpdateRougeInfoTalentPoint)
end

function Rouge2_TalentModel:updateUnlockTalent(geniusIds)
	tabletool.clear(self.hadUnlockTalent)
	tabletool.clear(self.hadUnlockTalentDic)

	self.activeTalentCount = 0

	if geniusIds then
		for _, talentId in ipairs(geniusIds) do
			table.insert(self.hadUnlockTalent, talentId)

			self.hadUnlockTalentDic[talentId] = true
			self.activeTalentCount = self.activeTalentCount + 1
		end
	end

	self:calculateUseTalent()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_Event.OnUpdateRougeTalentTreeInfo)
end

function Rouge2_TalentModel:onActiveTalentNode(geniusId)
	if self:isTalentActive(geniusId) then
		logError("Rouge2 talent is already active geniusId: " .. geniusId)

		return
	end

	self.hadUnlockTalentDic[geniusId] = true

	table.insert(self.hadUnlockTalent, geniusId)

	self.activeTalentCount = self.activeTalentCount + 1

	self:calculateUseTalent()
	Rouge2_AlchemyModel.instance:updateFormulaInfo()
	Rouge2_OutsideModel.instance:checkTalentRedDot()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnUpdateCommonTalent, geniusId)
end

function Rouge2_TalentModel:calculateUseTalent()
	local consume = self:getHadConsumeTalentPoint()
	local count = consume
	local maxTalentPointConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.TalentPointMaxCount)
	local limit = tonumber(maxTalentPointConfig.value)

	if self.talentUpdatePoint then
		local temp = consume + self.talentUpdatePoint

		count = limit < temp and limit or temp
	end

	self.haveAllTalentUpdatePoint = count
end

function Rouge2_TalentModel:getHadConsumeTalentPoint()
	local consume = 0

	for index, id in ipairs(self.hadUnlockTalent) do
		local co = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(id)

		consume = consume + co.pointCost
	end

	return consume
end

function Rouge2_TalentModel:getTalentPoint()
	return self.talentUpdatePoint
end

function Rouge2_TalentModel:getActiveTalentPoint()
	return self.activeTalentCount
end

function Rouge2_TalentModel:getHadAllTalentPoint()
	return self.haveAllTalentUpdatePoint
end

function Rouge2_TalentModel:isTalentActive(talentId)
	return self.hadUnlockTalentDic[talentId] ~= nil
end

function Rouge2_TalentModel:getHadUnlockTalentDict()
	return self.hadUnlockTalentDic
end

function Rouge2_TalentModel:isTalentUnlock(talentId)
	local config = Rouge2_OutSideConfig.instance:getTalentConfigById(talentId)
	local typeConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(talentId)

	if not typeConfig then
		logError("not such typeConfig talentId: " .. tostring(talentId))

		return false
	end

	if typeConfig.order == Rouge2_OutsideEnum.TalentOriginOrder then
		return true
	end

	local preOrder = typeConfig.order - 1
	local preConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByOrder(typeConfig.talent, preOrder)

	if not preConfig then
		logError("not such order talentId: " .. tostring(talentId) .. "order " .. tostring(preOrder))

		return false
	end

	return self:isTalentActive(preConfig.geniusId)
end

function Rouge2_TalentModel:getNextOrderTalentId(talentId)
	local config = Rouge2_OutSideConfig.instance:getTalentConfigById(talentId)
	local typeConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(talentId)

	if not typeConfig then
		logError("not such typeConfig talentId: " .. tostring(talentId))

		return false
	end

	local preOrder = typeConfig.order + 1
	local preConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByOrder(typeConfig.talent, preOrder)

	if not preConfig then
		return nil
	end

	return preConfig.geniusId
end

function Rouge2_TalentModel:isTalentCanActive(talentId)
	local typeConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(talentId)

	return self.talentUpdatePoint >= typeConfig.pointCost
end

function Rouge2_TalentModel:setCurSelectId(talendId)
	self._curTalentId = talendId
end

function Rouge2_TalentModel:getCurSelectId()
	return self._curTalentId
end

function Rouge2_TalentModel:calculateTalent()
	if self.activeTalentCount == 0 then
		return nil, nil
	end

	local attributeList = {}
	local showList = {}
	local tempList1 = {}
	local commonTalentList = Rouge2_OutSideConfig.instance:getTalentConfigListByType(Rouge2_Enum.TalentType.Common)
	local showListTypeDic = {}

	for i, talentTypeConfig in ipairs(commonTalentList) do
		if self:isTalentActive(talentTypeConfig.geniusId) then
			local talentco = Rouge2_OutSideConfig.instance:getTalentConfigById(talentTypeConfig.geniusId)

			if talentco.talentType ~= nil and talentco.talentType ~= 0 then
				local previousConfig = showListTypeDic[talentco.talentType]

				showListTypeDic[talentco.talentType] = not previousConfig and talentco or talentco.talentOrder > previousConfig.talentOrder and talentco or previousConfig
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
			end
		end
	end

	for _, talentCo in pairs(showListTypeDic) do
		table.insert(showList, talentCo.id)
	end

	table.sort(tempList1, Rouge2_TalentModel.sortattributeList)
	table.sort(showList, Rouge2_TalentModel.sortShowList)
	tabletool.addValues(attributeList, tempList1)

	return attributeList, showList
end

function Rouge2_TalentModel.sortattributeList(a, b)
	return a.id < b.id
end

function Rouge2_TalentModel.sortShowList(a, b)
	local configA = Rouge2_OutSideConfig.instance:getTalentConfigById(a)
	local configB = Rouge2_OutSideConfig.instance:getTalentConfigById(b)

	return configA.talentType < configB.talentType
end

function Rouge2_TalentModel:setCurTalentId(talentId)
	self._curTalentId = talentId
end

function Rouge2_TalentModel:getCurTalentId()
	return self._curTalentId
end

function Rouge2_TalentModel:updateCareerLevel(careerLevelInfo)
	if not Rouge2_OutsideController.instance:isCareerUnlock() then
		return
	end

	tabletool.clear(self._careerExpDic)
	tabletool.clear(self._careerLevelDic)
	tabletool.clear(self._careerMaxLevelDic)

	for _, info in ipairs(careerLevelInfo) do
		self._careerExpDic[info.careerId] = info.exp

		local level, isMaxLevel = self:calculateCareerLevel(info.careerId)

		self._careerLevelDic[info.careerId] = level

		if isMaxLevel then
			self._careerMaxLevelDic[info.careerId] = true
		end
	end
end

function Rouge2_TalentModel:checkNewUnlockCareerTalent()
	tabletool.clear(self._newUnlockCareerTalentList)
end

function Rouge2_TalentModel:calculateCareerLevel(careerId)
	local exp = self:getCareerExp(careerId)

	return self:getCareerLevelByExp(exp)
end

function Rouge2_TalentModel:getCareerLevelByExp(exp)
	local list = Rouge2_OutSideConfig.instance:getJobConfigList()

	if not list then
		return 0
	end

	local talentLevel = 1

	for _, config in ipairs(list) do
		if config.geniusId and exp >= config.geniusId then
			talentLevel = config.talent
		end
	end

	local isMaxLevel = talentLevel >= list[#list].talent

	return talentLevel, isMaxLevel
end

function Rouge2_TalentModel:getCareerLevel(careerId)
	if not self._careerLevelDic[careerId] then
		return 0
	end

	return self._careerLevelDic[careerId]
end

function Rouge2_TalentModel:getCareerExp(careerId)
	return self._careerExpDic[careerId] or 0
end

function Rouge2_TalentModel:canActiveCareerTalent(careerId)
	local talentTypeConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(careerId)
	local exp = talentTypeConfig.careerExp
	local curExp = self:getCareerExp(talentTypeConfig.talent)

	return exp <= curExp
end

function Rouge2_TalentModel:isCareerTransferOpen(transferId)
	return false
end

function Rouge2_TalentModel:setCurTransferId(transferId)
	self._curTransferId = transferId
end

function Rouge2_TalentModel:getCurTransferId()
	return self._curTransferId
end

function Rouge2_TalentModel:updateResultInfo(resultInfo)
	if Rouge2_OutsideController.instance:isCareerUnlock() and resultInfo and resultInfo.reviewInfo and resultInfo.reviewInfo.curCareer then
		self:onGainCareerExp(resultInfo.reviewInfo.curCareer, resultInfo.addCareerExp)
	end
end

function Rouge2_TalentModel:onGainCareerExp(careerId, gainExp)
	if self._careerMaxLevelDic[careerId] then
		logNormal("肉鸽2 当前等级已经满级, 无需添加经验表现")

		return
	end

	self._careerAddExpDic[careerId] = not self._careerAddExpDic[careerId] and gainExp or self._careerAddExpDic[careerId] + gainExp
end

function Rouge2_TalentModel:clearCareerGainExp(careerId)
	self._careerAddExpDic[careerId] = 0
end

function Rouge2_TalentModel:getCareerGainExp(careerId)
	return self._careerAddExpDic[careerId] or 0
end

Rouge2_TalentModel.instance = Rouge2_TalentModel.New()

return Rouge2_TalentModel
