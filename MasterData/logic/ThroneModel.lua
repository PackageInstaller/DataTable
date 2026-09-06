-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/model/ThroneModel.lua

module("logic.extensions.throne.view.ThroneModel", package.seeall)

local ThroneModel = class("ThroneModel", BaseModel)

function ThroneModel:ctor()
	return
end

function ThroneModel:onInit()
	self:onReset()
end

function ThroneModel:onReset()
	self._throneInfos = nil
	self._hasGainDailyPrize = nil
	self._achievementPrizeArr = nil
	self._newThroneList = {}
	self._mainRoleAttr = nil
	self._throneMoList = {}
	self._fInitthroneId = 0
end

function ThroneModel:getThroneByShowType(id)
	local cfgs = ThroneConfig.instance:getThroneByShowType(id)
	local list = {}

	if self._throneInfos then
		local kvList = {}

		for i, v in ipairs(cfgs) do
			kvList[v.id] = v
		end

		for i, v in ipairs(self._throneInfos) do
			if kvList[v.throneId] then
				table.insert(list, v)
			end
		end
	end

	return list
end

function ThroneModel:setThronesChange(list)
	if not self._throneInfos then
		self._throneInfos = list

		self:_calMianRoleAttr()
		self:_updateAllMo()

		return
	end

	local kvList = {}

	for i, v in ipairs(self._throneInfos) do
		kvList[v.throneId] = v
	end

	for i, v in ipairs(list) do
		if kvList[v.throneId] then
			kvList[v.throneId].leftNum = v.leftNum
			kvList[v.throneId].lv = v.lv
		else
			self._newThroneList[v.throneId] = true

			table.insert(self._throneInfos, v)
			GlobalDispatcher:dispatch(ThroneController.UpdateRedDot)
		end
	end

	local oldAttrMap = {}

	for k, v in pairs(self._mainRoleAttr or {}) do
		oldAttrMap[k] = v
	end

	self:_calMianRoleAttr()

	self._tempChangeMap = {}

	for k, v in pairs(self._mainRoleAttr or {}) do
		if not oldAttrMap[k] or oldAttrMap[k] ~= v then
			self._tempChangeMap[k] = {
				oldAttr = checknumber(oldAttrMap[k]),
				newAttr = checknumber(v)
			}
		end
	end

	self:_updateAllMo()
end

function ThroneModel:getTempChangeMap()
	return self._tempChangeMap
end

function ThroneModel:setAllThrones(infos)
	self._throneInfos = infos

	self:_calMianRoleAttr()
	self:_updateAllMo()
end

function ThroneModel:_updateAllMo()
	self._throneMoList = {}

	for i, v in ipairs(self._throneInfos or {}) do
		local mo = ThroneMo.New()

		mo:initData(MatType.Throne, v.throneId, v.leftNum)
		mo:setLevel(v.lv)
		table.insert(self._throneMoList, mo)
	end
end

function ThroneModel:getThroneNum()
	return (self._throneInfos or nil) and #self._throneInfos
end

function ThroneModel:getAllThroneInfos()
	return self._throneInfos or {}
end

function ThroneModel:getAllThroneMoList()
	return self._throneMoList
end

function ThroneModel:getThroneMoById(id)
	for i, mo in ipairs(self._throneMoList) do
		if mo:getId() == id then
			return mo
		end
	end

	return nil
end

function ThroneModel:getThroneData(id)
	local data

	if self._throneInfos then
		for i, v in ipairs(self._throneInfos) do
			if v.throneId == id then
				data = v

				break
			end
		end
	end

	return data
end

function ThroneModel:getThroneBagNum(id)
	local num = 0

	if self._throneInfos then
		for i, v in ipairs(self._throneInfos) do
			if v.throneId == id then
				num = v.leftNum + 1

				break
			end
		end
	end

	return num
end

function ThroneModel:setPanelInfo(msg)
	self._hasGainDailyPrize = msg.hasGainDailyPrize
	self._achievementPrizeArr = msg.achievementPrizeArr
end

function ThroneModel:hasGainDailyPrize()
	return self._hasGainDailyPrize
end

function ThroneModel:getAchievementPrizeArr()
	local list = {}

	if self._achievementPrizeArr then
		for i, v in ipairs(self._achievementPrizeArr) do
			list[i] = v
		end
	end

	return list
end

function ThroneModel:getTodayCanGetPrize()
	local num = self:getThroneNum()
	local cfgs = ThroneConfig.instance:getAchievementCfgs()
	local data

	for i = #cfgs, 1, -1 do
		if num >= cfgs[i].num then
			data = cfgs[i]

			break
		end
	end

	return data
end

function ThroneModel:setAchievementPrizeRes(id)
	self._achievementPrizeArr = self._achievementPrizeArr or {
		id = true
	}
	self._achievementPrizeArr[id] = true
end

function ThroneModel:setGetDailyPrize()
	self._hasGainDailyPrize = true
end

function ThroneModel:setLookThrone(throneId)
	if self._newThroneList[throneId] then
		self._newThroneList[throneId] = false

		GlobalDispatcher:dispatch(ThroneController.UpdateRedDot)
	end
end

function ThroneModel:checkThoneRedDot()
	return self:checkRedDotByShowType(GameEnum.ThroneTabType.All)
end

function ThroneModel:checkRedDotByShowType(id)
	local dot = false
	local list = {}

	if self._throneInfos then
		for i, v in ipairs(self._throneInfos) do
			local cfg = ThroneConfig.instance:getThroneCfg(v.throneId)

			if id == GameEnum.ThroneTabType.All or cfg.showType == id then
				table.insert(list, v)
			end
		end
	end

	for i, v in ipairs(list) do
		dot = self:checkNewThroneById(v.throneId) or self:checkThroneGoodsItemRedDot(v.throneId, v)

		if dot then
			break
		end
	end

	return dot
end

function ThroneModel:checkThroneGoodsItemRedDot(id, data)
	return self:checkNewThroneById(id) or self:checkThronCanUpgradeRedDot(id, data)
end

function ThroneModel:checkThronCanUpgradeRedDot(id, data)
	local dot = false

	data = data or self:getThroneData(id)

	if data then
		local cfg = ThroneConfig.instance:getThroneCfg(data.throneId)
		local lvCfgs = ThroneConfig.instance:getLvStrategyCfg(cfg.levelStrategy)
		local nextCfg = lvCfgs[data.lv + 1]

		if nextCfg then
			dot = data.leftNum >= nextCfg.costNum and MaterialFacade.instance:isMatsEnough(nextCfg.costMp)
		end
	end

	return dot
end

function ThroneModel:checkNewThrone()
	for k, v in pairs(self._newThroneList) do
		if v then
			return true
		end
	end
end

function ThroneModel:checkNewThroneById(id)
	return self._newThroneList[id]
end

function ThroneModel:getRoleThroneAttr(isMyPet, throneInfos)
	return (isMyPet or nil) and (self._mainRoleAttr or self:_calRoleAttr(throneInfos))
end

function ThroneModel:_calMianRoleAttr()
	self._mainRoleAttr, self._myPetAttr = self:_calRoleAttr(self._throneInfos)
end

function ThroneModel:getPetThroneAttr(petMo)
	if petMo.isMyPackPet then
		return self._myPetAttr
	else
		local r1, res = self:_calRoleAttr(petMo.throneList)

		return res
	end
end

function ThroneModel:getCurrPetAttr()
	return self._myPetAttr
end

function ThroneModel:_calRoleAttr(throneInfos)
	if not throneInfos then
		return nil, nil
	end

	local cfg, lvCfgs, lvCfg, result
	local res = {}
	local resultTemp

	for i, v in ipairs(throneInfos) do
		lvCfg = ThroneConfig.instance:getLvStrategyCfg(ThroneConfig.instance:getThroneCfg(v.throneId).levelStrategy)[v.lv]
		resultTemp = self:_parseToAttr(lvCfg.mainProps)
		result = GameUtil.addSameAttrs(resultTemp, result)
		resultTemp = self:_parseToAttr(lvCfg.subProps)
		result = GameUtil.addSameAttrs(resultTemp, result)

		local attrs = FightingPowerFormula.instance:parseAttrValues(lvCfg.mainProps) or {}

		res = AttrMo.addSameAttrs(attrs, res)

		local attrs = FightingPowerFormula.instance:parseAttrValues(lvCfg.subProps) or {}

		res = AttrMo.addSameAttrs(attrs, res)
	end

	return result, res
end

function ThroneModel:_parseToAttr(str)
	local resultTemp = {}

	if not string.nilorempty(str) then
		local tempList = string.split(str, "#")

		for _, v1 in ipairs(tempList) do
			local tempList1 = string.split(v1, "+")

			resultTemp[tempList1[1]] = checknumber(tempList1[2])
		end
	end

	return resultTemp
end

function ThroneModel:setFactoryInitthroneId(throneId)
	self._fInitthroneId = throneId
end

function ThroneModel:getFactoryInitthroneId()
	return self._fInitthroneId
end

ThroneModel.instance = ThroneModel.New()

return ThroneModel
