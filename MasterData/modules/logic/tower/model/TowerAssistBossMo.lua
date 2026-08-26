-- chunkname: @modules/logic/tower/model/TowerAssistBossMo.lua

module("modules.logic.tower.model.TowerAssistBossMo", package.seeall)

local TowerAssistBossMo = pureTable("TowerAssistBossMo")

function TowerAssistBossMo:init(id)
	self.id = id
	self.level = 0
	self.talentPoint = 0
	self.useTalentPlan = 1
	self.customPlanCount = 1
	self.trialLevel = 0
	self.trialTalentPlan = 0
	self.isTemp = false
end

function TowerAssistBossMo:setTrialInfo(level, talentPlan)
	self.trialLevel = level
	self.trialTalentPlan = talentPlan
end

function TowerAssistBossMo:onTowerActiveTalent(info)
	self:addTalentId(info.talentId)

	self.talentPoint = info.talentPoint
	self.talentPlanDict[self.useTalentPlan].talentPoint = self.talentPoint
end

function TowerAssistBossMo:onTowerResetTalent(info)
	self.talentPoint = info.talentPoint

	if info.talentId == 0 then
		self:initTalentIds()

		self.talentPlanDict[self.useTalentPlan].talentIds = self.talentIdList
		self.talentPlanDict[self.useTalentPlan].talentPoint = self.talentPoint
	else
		self:removeTalentId(info.talentId)
	end
end

function TowerAssistBossMo:updateInfo(info)
	self.level = info.level
	self.useTalentPlan = info.useTalentPlan or 1

	self:initTalentPlanInfos(info.talentPlans)
	self:refreshTalent()
end

function TowerAssistBossMo:refreshTalent()
	self:initCurTalentInfo()
	self:initTalentIds(self.talentIds)
end

function TowerAssistBossMo:initCurTalentInfo()
	if self.trialTalentPlan > 0 then
		if not self.trialTalentPlan then
			local curTalentPlan = self.useTalentPlan

			self.customPlanCount = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount))

			if curTalentPlan <= self.customPlanCount then
				if self.talentPlanDict then
					self.talentIds = self.talentPlanDict[curTalentPlan].talentIds or {}
				end

				if self.talentPlanDict then
					self.talentPoint = self.talentPlanDict[curTalentPlan].talentPoint or 0
				end
			else
				local var_7_1

				if self.trialTalentPlan > 0 then
					var_7_1 = self.trialTalentPlan or self.useTalentPlan

					local var_7_2

					if self.trialLevel > 0 then
						var_7_2 = self.trialLevel or self.level
					end
				end

				self.talentIds = TowerConfig.instance:getTalentPlanNodeIds(self.id, var_7_1, var_7_2)

				if self.trialLevel > 0 then
					local totalTalentPoint = TowerConfig.instance:getAllTalentPoint(self.id, self.trialLevel or self.level)

					self:initTalentIds(self.talentIds)

					local costPoint = self:getCurCostTalentPoint()

					self.talentPoint = totalTalentPoint - costPoint
				end
			end
		end
	end
end

function TowerAssistBossMo:initTalentIds(ids)
	self.talentIdDict = {}
	self.talentIdList = {}
	self.talentIdCount = 0

	if ids then
		for i = 1, #ids do
			self:addTalentId(ids[i])
		end
	end
end

function TowerAssistBossMo:addTalentId(talentId)
	if not talentId or self:isActiveTalent(talentId) then
		return
	end

	self.talentIdCount = self.talentIdCount + 1
	self.talentIdDict[talentId] = 1
	self.talentIdList[self.talentIdCount] = talentId

	if self.talentPlanDict and self.useTalentPlan <= self.customPlanCount then
		self.talentPlanDict[self.useTalentPlan].talentIds = self.talentIdList
	end
end

function TowerAssistBossMo:removeTalentId(talentId)
	if not talentId or not self:isActiveTalent(talentId) then
		return
	end

	self.talentIdCount = self.talentIdCount - 1
	self.talentIdDict[talentId] = nil

	tabletool.removeValue(self.talentIdList, talentId)

	if self.useTalentPlan <= self.customPlanCount then
		self.talentPlanDict[self.useTalentPlan].talentIds = self.talentIdList
	end
end

function TowerAssistBossMo:isActiveTalent(talentId)
	return self.talentIdDict[talentId] ~= nil
end

function TowerAssistBossMo:getTalentPoint()
	return self.talentPoint
end

function TowerAssistBossMo:getTalentTree()
	if not self.talentTree then
		self.talentTree = TowerTalentTree.New()

		local talentConfig = TowerConfig.instance:getAssistTalentConfig()
		local talents = talentConfig.configDict[self.id]

		self.talentTree:initTree(self, talents)
	end

	return self.talentTree
end

function TowerAssistBossMo:getTalentActiveCount()
	return self:getCurCostTalentPoint(), self.talentPoint
end

function TowerAssistBossMo:getCurCostTalentPoint()
	local costTalentPoint = 0

	for index, talentId in ipairs(self.talentIdList) do
		local talentConfig = TowerConfig.instance:getAssistTalentConfigById(self.id, talentId)

		costTalentPoint = costTalentPoint + talentConfig.consume
	end

	return costTalentPoint
end

function TowerAssistBossMo:hasTalentCanActive()
	if self.useTalentPlan > self.customPlanCount then
		return false
	end

	local tree = self:getTalentTree()

	return tree:hasTalentCanActive()
end

function TowerAssistBossMo:initTalentPlanInfos(talentPlanList)
	self.talentPlanDict = {}

	local customTypeCount = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount)

	for index = 1, customTypeCount do
		local talentPlanMO = talentPlanList[index]

		if not talentPlanMO then
			talentPlanMO = {
				talentIds = {}
			}

			logWarn("boss" .. self.id .. "天赋方案数据为空" .. index)
		end

		local talentPlan = {}

		talentPlan.planId = talentPlanMO.planId or index
		talentPlan.talentPoint = talentPlanMO.talentPoint or TowerConfig.instance:getAllTalentPoint(self.id, (self.trialLevel > 0 or nil) and (self.trialLevel or self.level))
		talentPlan.planName = string.nilorempty(talentPlanMO.planName) and GameUtil.getSubPlaceholderLuaLang(luaLang("towerbosstalentplan"), {
			index
		}) or talentPlanMO.planName
		talentPlan.talentIds = {}

		for _, talentId in ipairs(talentPlanMO.talentIds) do
			table.insert(talentPlan.talentIds, talentId)
		end

		self.talentPlanDict[talentPlan.planId] = talentPlan
	end
end

function TowerAssistBossMo:renameTalentPlan(name)
	local curTalentPlan = self.talentPlanDict[self.useTalentPlan]

	if curTalentPlan then
		curTalentPlan.planName = name
	end
end

function TowerAssistBossMo:getTalentPlanInfos()
	return self.talentPlanDict
end

function TowerAssistBossMo:setCurUseTalentPlan(planId, isTrial)
	if isTrial then
		self.trialTalentPlan = planId
	else
		self.useTalentPlan = planId
		self.trialTalentPlan = 0
	end

	self:refreshTalent()
end

function TowerAssistBossMo:getCurUseTalentPlan()
	return self.useTalentPlan
end

function TowerAssistBossMo:setTempState(isTemp)
	self.isTemp = isTemp
end

function TowerAssistBossMo:getTempState()
	return self.isTemp
end

function TowerAssistBossMo:isSelectedSystemTalentPlan()
	if self.trialTalentPlan > 0 then
		if not self.trialTalentPlan then
			local curTalentPlan = self.useTalentPlan

			self.customPlanCount = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount))

			return curTalentPlan > self.customPlanCount
		end
	end
end

return TowerAssistBossMo
