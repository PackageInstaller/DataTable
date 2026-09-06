-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/model/PetAssistModel.lua

module("logic.extensions.petassist.model.PetAssistModel", package.seeall)

local PetAssistModel = class("PetAssistModel", BaseModel)

function PetAssistModel:ctor()
	self.assistLevel = 0
	self.allTeamInfos = nil
end

function PetAssistModel:onInit()
	PetAssistModel.super.onInit(self)
	self:onReset()
end

function PetAssistModel:onReset()
	self.assistLevel = 0
	self.allTeamInfos = nil
end

function PetAssistModel:GetMainAllTeamInfo()
	return self.allTeamInfos
end

function PetAssistModel:InitAllAssistInfos(teamInfo)
	self.allTeamInfos = {}

	for i = 1, 7 do
		self.allTeamInfos[i] = {
			teamLevel = 0,
			teamType = i,
			posPetInfos = {}
		}
	end

	for _, info in pairs(teamInfo or {}) do
		if info and info.teamType then
			self.allTeamInfos[info.teamType] = {
				teamType = info.teamType,
				teamLevel = info.teamLevel,
				posPetInfos = {}
			}

			for _, item in pairs(info.positionInfo or {}) do
				if item and checknumber(item.position) > 0 then
					self.allTeamInfos[info.teamType].posPetInfos[item.position] = item.petId
				end
			end
		end
	end

	self:GetTotalAttributes(true)
	BagPetsController.instance:calcAllAssistAttr()
end

function PetAssistModel:UpgradePetTeamLevel(teamType)
	if teamType == nil then
		return
	end

	if self.allTeamInfos[teamType] == nil then
		self.allTeamInfos[teamType] = {
			teamLevel = 0,
			teamType = teamType,
			posPetInfos = {}
		}
	end

	self.allTeamInfos[teamType].teamLevel = self.allTeamInfos[teamType].teamLevel + 1

	self:GetTotalAttributes(true)
	BagPetsController.instance:calcAllAssistAttr()
	GlobalDispatcher:dispatch("PetTeamInfoChange")
end

function PetAssistModel:UpgradePetTeamsLevel(teamInfo)
	local hasChange = false

	if not teamInfo then
		return hasChange
	end

	local changeInfo = {}

	for i, v in ipairs(teamInfo) do
		if v.teamType ~= nil then
			if self.allTeamInfos[v.teamType] == nil then
				self.allTeamInfos[v.teamType] = {
					teamLevel = 0,
					teamType = v.teamType,
					posPetInfos = {}
				}
				hasChange = true
			end

			if self.allTeamInfos[v.teamType].teamLevel ~= v.teamLevel then
				changeInfo[v.teamType] = {
					oldLevel = self.allTeamInfos[v.teamType].teamLevel,
					newLevel = v.teamLevel
				}
				self.allTeamInfos[v.teamType].teamLevel = v.teamLevel
				hasChange = true
			end
		end
	end

	self:GetTotalAttributes(true)
	BagPetsController.instance:calcAllAssistAttr()
	GlobalDispatcher:dispatch("PetTeamInfoChange")

	return hasChange, changeInfo
end

function PetAssistModel:PetTeamAddPetInfo(info)
	if info == nil or info.teamType == nil then
		return
	end

	if self.allTeamInfos[info.teamType] == nil then
		self.allTeamInfos[info.teamType] = {
			teamLevel = 0,
			teamType = info.teamType,
			posPetInfos = {}
		}
	end

	self.allTeamInfos[info.teamType].posPetInfos[info.pos] = info.petId

	self:GetTotalAttributes(true)
	BagPetsController.instance:calcAllAssistAttr()
	GlobalDispatcher:dispatch("PetTeamInfoChange")
end

function PetAssistModel:PetTeamDropPetInfo(data)
	if self.allTeamInfos == nil then
		return
	end

	for _, info in pairs(data or {}) do
		if info and info.dropPositions and self.allTeamInfos[info.teamType] and self.allTeamInfos[info.teamType].posPetInfos then
			for k, pos in pairs(info.dropPositions) do
				self.allTeamInfos[info.teamType].posPetInfos[pos] = nil
			end
		end
	end

	self:GetTotalAttributes(true)
	BagPetsController.instance:calcAllAssistAttr()
	GlobalDispatcher:dispatch("PetTeamInfoChange")
end

function PetAssistModel:GetSubTeamInfo(teamType)
	if checknumber(teamType) < 1 or self.allTeamInfos == nil then
		return
	end

	return self.allTeamInfos[teamType]
end

function PetAssistModel:GetTeamAllItems(teamType)
	if checknumber(teamType) < 1 then
		return
	end

	local unlockList = PetAssistConfig.instance:GetTeamUnlockAllCfgs(teamType)

	if unlockList == nil then
		return
	end

	local info = self:GetSubTeamInfo(teamType)

	if info then
		if not info.teamLevel then
			local teamLevel = 0

			if info then
				if not info.posPetInfos then
					local petPos = {}
					local list = {}

					for _, cfg in pairs(unlockList) do
						if cfg and cfg.type == teamType then
							local data = {}

							data.teamType = teamType
							data.posId = cfg.position
							data.unlockLv = cfg.unlockLevel
							data.isUnlock = teamLevel >= cfg.unlockLevel
							data.petId = petPos[cfg.position]

							table.insert(list, data)
						end
					end

					if list and #list > 1 then
						table.sort(list, function(a, b)
							return a.posId < b.posId
						end)
					end

					return list
				end
			end
		end
	end
end

function PetAssistModel:GetTeamMaxLevel(teamType)
	if checknumber(teamType) < 1 then
		return 0
	end

	local levelList = PetAssistConfig.instance:GetTeamUpgradeAllCfgs(teamType)
	local maxLv = 0

	for _, cfg in pairs(levelList or {}) do
		if cfg and maxLv < cfg.level then
			maxLv = cfg.level
		end
	end

	return maxLv
end

function PetAssistModel:GetTeamAttrsAndPower(teamType)
	local info = self:GetSubTeamInfo(teamType)
	local petAttrs = {}
	local teamCfg = PetAssistConfig.instance:GetTeamUpgradeCfg(teamType, (info and checknumber(info.teamLevel) > 0 or nil) and info.teamLevel)

	if teamCfg and not string.nilorempty(teamCfg.propertyParam) then
		table.insert(petAttrs, teamCfg.propertyParam)
	end

	teamCfg = nil

	if info then
		if not info.posPetInfos then
			local posList = {}

			for pos, petId in pairs(posList) do
				local str = self:GetPetAttrsToStr(petId)

				if not string.nilorempty(str) then
					table.insert(petAttrs, str)
				end
			end

			if petAttrs == nil or #petAttrs == 0 then
				return nil, 0
			end

			local allAttrsList = {}

			for i = 1, #petAttrs do
				local attrList = string.split(petAttrs[i], "#")

				if attrList and #attrList > 0 then
					for j = 1, #attrList do
						local list = string.split(attrList[j], "+")

						if list and #list == 2 then
							if allAttrsList[list[1]] == nil then
								allAttrsList[list[1]] = 0
							end

							allAttrsList[list[1]] = allAttrsList[list[1]] + tonumber(list[2])
						end
					end
				end
			end

			local tempList, targList = {}, {}

			for str, value in pairs(allAttrsList) do
				if not string.nilorempty(str) and checknumber(value) > 0 then
					local index = table.indexof(GameEnum.AttrTypeName, str)

					if checknumber(index) > 0 then
						tempList[index] = value

						table.insert(targList, {
							index = index,
							name = str,
							value = value
						})
					end
				end
			end

			local power = AttrMo.calcFightPowerByAttrs(tempList)

			return targList, power * 5
		end
	end
end

function PetAssistModel:GetTeamChangeAttrs(teamType, addInfo)
	local info = self:GetSubTeamInfo(teamType)

	if info == nil or checknumber(info.teamLevel) < 0 then
		return nil
	end

	if addInfo == nil or addInfo.petId == nil then
		local cfg = PetAssistConfig.instance:GetTeamUpgradeCfg(teamType, info.teamLevel)

		if cfg == nil or string.nilorempty(cfg.propertyParam) then
			return nil
		end

		local list, oldList, tempList = {}, {}, {}

		table.insert(tempList, {
			name = "等级上限",
			oldCount = info.teamLevel - 1,
			newCount = info.teamLevel
		})

		local newList = self:GetAttrsStrToList(cfg.propertyParam, list)

		cfg = PetAssistConfig.instance:GetTeamUpgradeCfg(teamType, info.teamLevel - 1)

		for name, value in pairs(list) do
			if not string.nilorempty(name) then
				table.insert(tempList, {
					name = name,
					oldCount = checknumber(((cfg and not string.nilorempty(cfg.propertyParam) or nil) and self:GetAttrsStrToList(cfg.propertyParam, list))[name]),
					newCount = checknumber(newList[name])
				})
			end
		end

		return tempList
	end

	local oldAttrStr = ""
	local newAttrStr = ""

	for pos, petId in pairs(info.posPetInfos) do
		local str = self:GetPetAttrsToStr(petId)

		if not string.nilorempty(str) then
			newAttrStr = string.nilorempty(newAttrStr) and str or newAttrStr .. "#" .. str
		end

		if pos == addInfo.pos then
			str = ""
			str = self:GetPetAttrsToStr(addInfo.oldPetId)
		end

		if not string.nilorempty(str) then
			oldAttrStr = string.nilorempty(oldAttrStr) and str or oldAttrStr .. "#" .. str
		end
	end

	if not string.nilorempty(newAttrStr) then
		local list, tempList = {}, {}
		local oldList = self:GetAttrsStrToList(oldAttrStr, list) or {}
		local newList = self:GetAttrsStrToList(newAttrStr, list) or {}

		for name, value in pairs(list) do
			if not string.nilorempty(name) then
				table.insert(tempList, {
					name = name,
					oldCount = checknumber(oldList[name]),
					newCount = checknumber(newList[name])
				})
			end
		end

		return tempList
	end

	return nil
end

function PetAssistModel:GetAttrsStrToList(str, list)
	if string.nilorempty(str) then
		return
	end

	local attrList = string.split(str, "#")

	if attrList == nil or #attrList == 0 then
		return
	end

	local tempList = {}

	for i = 1, #attrList do
		local aa = string.split(attrList[i], "+")

		if aa and not string.nilorempty(aa[1]) and checknumber(aa[2]) > 0 then
			if tempList[aa[1]] == nil then
				tempList[aa[1]] = 0
			end

			tempList[aa[1]] = tempList[aa[1]] + tonumber(aa[2])

			if list then
				list[aa[1]] = 0
			end
		end
	end

	return tempList
end

function PetAssistModel:GetPetAttrsToStr(petId)
	if checknumber(petId) < 1 then
		return
	end

	local petInfo = BagModel.instance:getPet(petId)

	if petInfo == nil then
		return
	end

	local xs = petInfo.awakeLevel
	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, petInfo.raceId)
	local cfg = PetAssistConfig.instance:GetPetStarCfg((petCfg or nil) and petCfg.evaluateLevel, xs)
	local allStr = ""

	if cfg and not string.nilorempty(cfg.propertyParam) then
		allStr = cfg.propertyParam
	end

	cfg = PetAssistConfig.instance:GetPetLevelCfg(petInfo.level)

	if cfg and not string.nilorempty(cfg.propertyParam) then
		allStr = allStr .. "#" .. cfg.propertyParam
	end

	return allStr
end

function PetAssistModel:GetTeamChangeAttrsByChangeInfo(changeInfo)
	local result = {}
	local tempMap = {}
	local allPetTeamCfgs = PetAssistConfig.instance:getPetTeamCfgs()

	for i, v in ipairs(allPetTeamCfgs) do
		local teamType = v.teamId
		local info = self:GetSubTeamInfo(teamType)

		if info ~= nil and checknumber(info.teamLevel) >= 0 then
			if changeInfo[teamType] then
				local teamChangeInfo = changeInfo[teamType]
				local cfg = PetAssistConfig.instance:GetTeamUpgradeCfg(teamType, teamChangeInfo.newLevel)

				if cfg == nil or string.nilorempty(cfg.propertyParam) then
					return nil
				end

				local list, oldList, tempList = {}, {}, {}
				local newList = self:GetAttrsStrToList(cfg.propertyParam, list)

				cfg = PetAssistConfig.instance:GetTeamUpgradeCfg(teamType, teamChangeInfo.oldLevel)

				for name, value in pairs(list) do
					if not string.nilorempty(name) then
						tempMap[name] = tempMap[name] or {}
						tempMap[name].oldCount = (tempMap[name].oldCount or 0) + checknumber(((cfg and not string.nilorempty(cfg.propertyParam) or nil) and self:GetAttrsStrToList(cfg.propertyParam, list))[name])
						tempMap[name].newCount = (tempMap[name].newCount or 0) + checknumber(newList[name])
					end
				end
			else
				local cfg = PetAssistConfig.instance:GetTeamUpgradeCfg(teamType, info.teamLevel)

				if cfg == nil or string.nilorempty(cfg.propertyParam) then
					return nil
				end

				local list, oldList, tempList = {}, {}, {}
				local newList = self:GetAttrsStrToList(cfg.propertyParam, list)

				cfg = PetAssistConfig.instance:GetTeamUpgradeCfg(teamType, info.teamLevel)

				for name, value in pairs(list) do
					if not string.nilorempty(name) then
						tempMap[name] = tempMap[name] or {}
						tempMap[name].oldCount = (tempMap[name].oldCount or 0) + checknumber(((cfg and not string.nilorempty(cfg.propertyParam) or nil) and self:GetAttrsStrToList(cfg.propertyParam, list))[name])
						tempMap[name].newCount = (tempMap[name].newCount or 0) + checknumber(newList[name])
					end
				end
			end
		end
	end

	for name, info in pairs(tempMap) do
		table.insert(result, {
			name = name,
			oldCount = info.oldCount,
			newCount = info.newCount
		})
	end

	return result
end

function PetAssistModel:GetChoisePetAttrsList(petId)
	local allStr = self:GetPetAttrsToStr(petId)

	if string.nilorempty(allStr) then
		return
	end

	local list = self:GetAttrsStrToList(allStr)
	local tempList, attrList = {}, {}

	for name, value in pairs(list or {}) do
		if not string.nilorempty(name) and checknumber(value) > 0 then
			local index = table.indexof(GameEnum.AttrTypeName, name)

			if checknumber(index) > 0 then
				table.insert(tempList, {
					index = index,
					name = name,
					value = value
				})

				attrList[index] = value
			end
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a.index < b.index
		end)
	end

	return tempList, attrList
end

function PetAssistModel:GetTeamTypeAllPets(teamType, pos)
	local teamCfg = PetAssistConfig.instance:GetPetTeamCfg(teamType)

	if teamCfg == nil or string.nilorempty(teamCfg.teamAttr) then
		return
	end

	local allPets = BagPetsController.instance:getBagPets()

	if allPets == nil then
		return
	end

	local tepeList = {}

	for _, info in pairs(allPets) do
		if info and info:checkHasRace(teamCfg.teamAttr) and not self:IsZhuzhenByPetId(teamType, info.petId, pos) then
			local _, attrList = self:GetChoisePetAttrsList(info.petId)

			info.assistPower = AttrMo.calcFightPowerByAttrs(attrList)

			table.insert(tepeList, info)
		end
	end

	if #tepeList > 1 then
		table.sort(tepeList, function(a, b)
			return a.assistPower > b.assistPower
		end)
	end

	return tepeList
end

function PetAssistModel:IsZhuzhenByPetId(teamType, petId, posNum)
	if checknumber(teamType) < 1 or checknumber(petId) < 1 then
		return false
	end

	local info = self:GetSubTeamInfo(teamType)

	if info == nil or info.posPetInfos == nil then
		return false
	end

	for pos, id in pairs(info.posPetInfos) do
		if checknumber(pos) ~= posNum and checknumber(id) == petId then
			return true
		end
	end

	return false
end

function PetAssistModel:GetTotalPowerCount()
	local allPower = 0

	for i = 1, 7 do
		local _, power = self:GetTeamAttrsAndPower(i)

		if checknumber(power) > 0 then
			allPower = allPower + power
		end
	end

	return allPower
end

function PetAssistModel:GetOtherTotalAttributes(petMo)
	local res = {}

	if petMo and petMo.assistTeamInfoList and petMo.assistTeamInfoList.assistTeamInfo then
		for i, info in ipairs(petMo.assistTeamInfoList.assistTeamInfo) do
			local teamCfg = PetAssistConfig.instance:GetTeamUpgradeCfg(info.type, info.level)

			if teamCfg then
				local attrs = FightingPowerFormula.instance:parseAttrValues(teamCfg.propertyParam)

				res = AttrMo.addSameAttrs(attrs, res)
			end

			local posPetInfos = info.assistPetDetailList

			for _k, petInfo in pairs(posPetInfos or {}) do
				local xs = petInfo.awakenLv
				local petCfg = MaterialMgr.getMatCfg(MatType.Pet, petInfo.raceId)
				local cfg = PetAssistConfig.instance:GetPetStarCfg((petCfg or nil) and petCfg.evaluateLevel, xs)

				if cfg then
					local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyParam)

					res = AttrMo.addSameAttrs(attrs, res)
				end

				cfg = PetAssistConfig.instance:GetPetLevelCfg(petInfo.petLv)

				if cfg then
					local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyParam)

					res = AttrMo.addSameAttrs(attrs, res)
				end
			end
		end
	end

	return res
end

function PetAssistModel:GetTotalAttributes(force)
	if force then
		self.attrRes = nil
	end

	if self.allTeamInfos and self.attrRes == nil then
		local res = {}

		for k, info in pairs(self.allTeamInfos) do
			local teamCfg = PetAssistConfig.instance:GetTeamUpgradeCfg(info.teamType, info.teamLevel)

			if teamCfg then
				local attrs = FightingPowerFormula.instance:parseAttrValues(teamCfg.propertyParam)

				res = AttrMo.addSameAttrs(attrs, res)
			end

			local posPetInfos = info.posPetInfos

			for _k, petId in pairs(posPetInfos or {}) do
				local petMo = BagModel.instance:getPet(petId)

				if petMo then
					local xs = petMo.awakeLevel
					local petCfg = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)
					local cfg = PetAssistConfig.instance:GetPetStarCfg((petCfg or nil) and petCfg.evaluateLevel, xs)

					if cfg then
						local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyParam)

						res = AttrMo.addSameAttrs(attrs, res)
					end

					cfg = PetAssistConfig.instance:GetPetLevelCfg(petMo.level)

					if cfg then
						local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyParam)

						res = AttrMo.addSameAttrs(attrs, res)
					end
				end
			end
		end

		self.attrRes = res
	end

	return self.attrRes
end

function PetAssistModel:GetPetAssistRedPoint()
	if not FuncOpenModel.instance:getFuncIsOpen(173) then
		return false
	end

	for i = 1, 5 do
		if self:IsCanTeamUpgrade(i) then
			return true
		end

		if self:IsTeamShowRedpoint(i) then
			return true
		end
	end

	return false
end

function PetAssistModel:IsCanTeamUpgrade(teamType)
	local info = self:GetSubTeamInfo(teamType)

	if info == nil then
		return false
	end

	local nextCfg = PetAssistConfig.instance:GetTeamUpgradeCfg(teamType, info.teamLevel + 1)

	if nextCfg == nil or string.nilorempty(nextCfg.cost) then
		return false
	end

	local goodsList = string.split(nextCfg.cost, "#")

	if goodsList == nil or #goodsList == 0 then
		return false
	end

	for i = 1, #goodsList do
		local str = string.split(goodsList[i], ":")

		if str and #str > 2 then
			local have = MaterialModel.instance:getMaterialsNumber(str[1], str[2]) or 0
			local need = tonumber(str[3])

			if have < need then
				return false
			end
		end
	end

	return true
end

function PetAssistModel:IsTeamShowRedpoint(teamType)
	local allPetInfos = self:GetTeamTypeAllPets(teamType)

	if allPetInfos == nil or #allPetInfos == 0 then
		return false
	end

	local posCfgs = PetAssistConfig.instance:GetTeamUnlockAllCfgs(teamType)

	if posCfgs == nil or #posCfgs == 0 then
		return false
	end

	local info = self:GetSubTeamInfo(teamType)

	if info then
		if not info.teamLevel then
			local teamLv = 0

			if info then
				if not info.posPetInfos then
					local posPetInfos = {}

					for i = 1, #posCfgs do
						if teamLv >= posCfgs[i].unlockLevel then
							local petId = posPetInfos[posCfgs[i].position]

							if self:IsHaveBetterPetByTeam(allPetInfos, petId) then
								return true
							end
						end
					end

					return false
				end
			end
		end
	end
end

function PetAssistModel:IsTeamPosShowRedpoint(teamType, pos)
	local posCfg = PetAssistConfig.instance:GetTeamUnlockCfg(teamType, pos)

	if posCfg == nil then
		return false
	end

	local info = self:GetSubTeamInfo(teamType)

	if info then
		if not info.teamLevel then
			local teamLv = 0

			if info then
				if not info.posPetInfos then
					local posPetInfos = {}

					if teamLv < posCfg.unlockLevel then
						return false
					end

					local allPetInfos = self:GetTeamTypeAllPets(teamType, nil)

					if allPetInfos == nil or #allPetInfos == 0 then
						return false
					end

					if posPetInfos[pos] == nil then
						return true
					end

					return self:IsHaveBetterPetByTeam(allPetInfos, posPetInfos[pos])
				end
			end
		end
	end
end

function PetAssistModel:IsHaveBetterPetByTeam(allPetInfos, petId)
	if checknumber(petId) < 1 then
		return true
	end

	local petInfo = BagPetsController.instance:getPet(petId)

	if petInfo == nil then
		return false
	end

	local _, attrList = self:GetChoisePetAttrsList(petInfo.petId)
	local power = AttrMo.calcFightPowerByAttrs(attrList)

	for i = 1, #allPetInfos do
		if allPetInfos[i] and checknumber(allPetInfos[i].assistPower) > checknumber(power) then
			return true
		end
	end

	return false
end

PetAssistModel.instance = PetAssistModel.New()

return PetAssistModel
