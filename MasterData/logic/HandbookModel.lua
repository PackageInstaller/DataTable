-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/model/HandbookModel.lua

module("logic.extensions.handbook.model.HandbookModel", package.seeall)

local HandbookModel = class("HandbookModel", BaseModel)

HandbookModel.ATTTYPE_MAP = {
	攻击 = 2,
	生命 = 1,
	魔防 = 4,
	物防 = 3
}

function HandbookModel:ctor()
	return
end

function HandbookModel:onInit()
	self:onReset()
end

function HandbookModel:onReset()
	self._userOwnedRaceIdMap = {}
	self.selectTabId = nil
	self._redKeyMap = {}
	self._attributeMap = {}
	self._posterDataList = {}
end

function HandbookModel:setSelectTabId(idx)
	self.selectTabId = idx
end

function HandbookModel:getSelectTabId()
	self.selectTabId = self.selectTabId or 1

	return self.selectTabId
end

function HandbookModel:getUserOwnedRaceIdMap()
	return self._userOwnedRaceIdMap
end

function HandbookModel:isHasPet(raceId)
	return self._userOwnedRaceIdMap[raceId] ~= nil
end

function HandbookModel:getAwakenNum(raceId)
	return checknumber(self._userOwnedRaceIdMap[raceId])
end

function HandbookModel:getAttributeLevel(raceId)
	if self._attributeMap[raceId] == nil then
		return -1
	else
		return checknumber(self._attributeMap[raceId])
	end
end

function HandbookModel:setAttributeLevel(raceId, level, isIgnoreAttr)
	self._attributeMap[raceId] = level

	if not isIgnoreAttr then
		self:calcHandBookAttr(true)
	end
end

function HandbookModel:onUserPetManualInfoRes(msg)
	self._userOwnedRaceIdMap = {}
	self._attributeMap = {}

	for _, info in ipairs(msg.userOwnedManual) do
		local preAwakenLv = checknumber(self._userOwnedRaceIdMap[info.raceIds])

		self._userOwnedRaceIdMap[info.raceIds] = math.max(info.bestAwakenLv, preAwakenLv)
		self._attributeMap[info.raceIds] = info.benefitLv
	end

	local infos = {}

	for _, info in ipairs(msg.teamGainInfos) do
		local teamInfo = {}
		local id = checkint(info.teamId)

		teamInfo.petListHasGain = GameUtil.pbToTable(info.raceIds, {})
		teamInfo.isGainTeamPrize = checkbool(info.isGainTeamPrize)

		if id and id > 0 then
			infos[id] = teamInfo
		end
	end

	self:CreatePosterDataList(infos)
	self:calcHandBookAttr(true)
	GlobalDispatcher:dispatch(GlobalNotify.RedPointUpdate, 8)
end

function HandbookModel:calcHandBookAttr(force)
	if self._attributeMap and (self.baseAttr == nil or self.percentAttr == nil or force) then
		local res = {}
		local res2 = {}

		for raceId, lvl in pairs(self._attributeMap) do
			if lvl >= 0 then
				local petCo = CharacterConfig.instance:getPetCo(raceId)

				if petCo and checknumber(petCo.bookIds) ~= 0 and HandbookModel.instance:isHasPet(raceId) then
					local manualBenefitId = petCo.manualBenefitId
					local cfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, lvl)

					if cfg then
						local propertyArr = string.split(cfg.propertyParam, "#")

						for _, propertyStr in ipairs(propertyArr) do
							local tempArr = string.split(propertyStr, "+")
							local attrName = tempArr[1]
							local attrValue = checknumber(tempArr[2])
							local attrs = self:parseAttrValues(attrName, attrValue)

							res = AttrMo.addSameAttrs(attrs, res)
						end

						local tmp = string.split(cfg.formulaPropertyType, "#")
						local tmp2 = string.split(cfg.formulaWanPercent, "#")

						for ii, vv in ipairs(tmp) do
							local perAttr = self:parseAttrValues(vv, tmp2[ii] / 10000)

							res2 = AttrMo.addSameAttrs(perAttr, res2)
						end
					end
				end
			end
		end

		local wanPercentUp = checknumber(HandbookConfig.instance:getPetCommonCfgs("WAN_PERCENT_UP"))
		local limit = wanPercentUp / 10000

		for k, v in pairs(res2) do
			res2[k] = Mathf.Clamp(v, 0, limit)
		end

		self.baseAttr = res
		self.percentAttr = res2

		BagPetsController.instance:calcAllPetHandbookAttr()
	end

	return self.baseAttr, self.percentAttr
end

function HandbookModel:calcOhterHandBookAttr(petMo)
	local res = {}
	local res2 = {}

	if petMo and petMo.benefitInfoList and petMo.benefitInfoList.benefitInfo then
		for i, info in ipairs(petMo.benefitInfoList.benefitInfo) do
			local num = info.num

			for i = 1, num do
				local lvl = info.benefitLv

				if lvl >= 0 then
					local cfg = HandbookConfig.instance:getBenefitCfg(info.benefitId, lvl)
					local propertyArr = string.split(cfg.propertyParam, "#")

					for _, propertyStr in ipairs(propertyArr) do
						local tempArr = string.split(propertyStr, "+")
						local attrName = tempArr[1]
						local attrValue = checknumber(tempArr[2])
						local attrs = self:parseAttrValues(attrName, attrValue)

						res = AttrMo.addSameAttrs(attrs, res)
					end

					local tmp = string.split(cfg.formulaPropertyType, "#")
					local tmp2 = string.split(cfg.formulaWanPercent, "#")

					for ii, vv in ipairs(tmp) do
						local perAttr = self:parseAttrValues(vv, tmp2[ii] / 10000)

						res2 = AttrMo.addSameAttrs(perAttr, res2)
					end
				end
			end
		end
	end

	local wanPercentUp = checknumber(HandbookConfig.instance:getPetCommonCfgs("WAN_PERCENT_UP"))
	local limit = wanPercentUp / 10000

	for k, v in pairs(res2) do
		res2[k] = Mathf.Clamp(v, 0, limit)
	end

	return res, res2
end

function HandbookModel:parseAttrValues(str, attrVal)
	if string.nilorempty(str) then
		return
	end

	local attrs = string.split(str, "#")
	local attrValues

	for i = 1, #attrs do
		local attrName = attrs[i]
		local attrType = FightingPowerFormula.instance:getAttrTypeByName(attrName)

		if attrType then
			attrValues = attrValues or {}
			attrValues[attrType] = attrVal
		end
	end

	return attrValues
end

function HandbookModel:getPosterDataList()
	return self._posterDataList
end

function HandbookModel:getPosterDataByTeamId(teamId)
	return self._posterDataList[teamId]
end

function HandbookModel:CreatePosterDataList(infos)
	local curinfos = infos or {}

	self._posterDataList = {}

	local cfgs = HandbookConfig.instance:getCfgs()

	for _, v in pairs(cfgs) do
		if checkint(v.teamId) > 0 then
			local data = {}

			data.cfg = v

			local info = curinfos[v.teamId]

			if not info then
				info = {}
				info.isGainTeamPrize = false
				info.petListHasGain = {}
			end

			data.info = info

			if not data.cfg.needRaceIds then
				data.hasCollect = {}

				for k, v in pairs(data.cfg.needRaceIds) do
					if HandbookModel.instance:isHasPet(v) then
						table.insert(data.hasCollect, v)
					end
				end

				self._posterDataList[data.cfg.teamId] = data
			end
		end
	end
end

function HandbookModel:getPosterPetPrize(teamId, petId)
	if self._posterDataList then
		table.insert(self._posterDataList[teamId].info.petListHasGain, petId)
	end
end

function HandbookModel:getPosterTeamPetPrize(teamId)
	if self._posterDataList then
		self._posterDataList[teamId].info.isGainTeamPrize = true
	end
end

function HandbookModel:getIsPosterShowRedPointByTeamId(teamId)
	local isShowDot = false

	if self._posterDataList and self._posterDataList[checkint(teamId)] then
		local data = self._posterDataList[checkint(teamId)]
		local cfg = data.cfg
		local info = data.info
		local hasCollect = data.hasCollect

		if info and info.petListHasGain then
			if not #info.petListHasGain then
				local hasGainPetNum = 0

				if not #hasCollect then
					local hasCollectPetNum = 0

					if cfg.needRaceIds then
						if not #cfg.needRaceIds then
							local totalGainPetNum = 1

							isShowDot = not info.isGainTeamPrize and hasGainPetNum == totalGainPetNum or hasGainPetNum < hasCollectPetNum
						end
					end
				end
			end
		end
	end

	return isShowDot
end

function HandbookModel:getIsPosterShowRedPointWithoutTeamId(teamId)
	for i = 1, #self._posterDataList do
		if teamId ~= i and self:getIsPosterShowRedPointByTeamId(i) then
			return true
		end
	end

	return false
end

function HandbookModel:_initRedPointKeys()
	local teamCfgs = HandbookConfig.instance:getCfgs()

	for teamId, _ in pairs(teamCfgs) do
		self:_updateTeamRedPoint(teamId, false)
	end
end

function HandbookModel:_updateTeamRedPoint(teamId, isNotify)
	local teamCfg = HandbookConfig.instance:getCfgById(teamId)

	if teamCfg then
		local prizes = HandbookConfig.instance:getTeamPrize(teamId)

		if prizes then
			for pid, prizeCfg in pairs(prizes) do
				local initLevel = CharacterConfig.instance:getPetCo(teamCfg.needRaceIds[1]).initAwakenLv
				local progressType = checknumber(prizeCfg.awakenLevel) > 0 and "awaken" or "collect"
				local progress = prizeCfg.progress

				if not self:getPrizeReceived(teamId, pid) then
					local curIsActive = false

					if progressType == "collect" then
						local collectNum = 0

						for _, raceId in ipairs(teamCfg.needRaceIds) do
							local awakenLv = checknumber(self._userOwnedRaceIdMap[raceId])

							if awakenLv > 0 then
								collectNum = collectNum + 1
							end
						end

						curIsActive = progress <= collectNum
					elseif progressType == "awaken" then
						local awakenNum = 0

						for _, raceId in ipairs(teamCfg.needRaceIds) do
							local awakenLv = checknumber(self._userOwnedRaceIdMap[raceId])

							if awakenLv >= prizeCfg.awakenLevel then
								awakenNum = awakenNum + 1
							end
						end

						curIsActive = progress <= awakenNum
					end

					self:_dealRedPoint(teamId, pid, curIsActive, isNotify)
				end
			end
		end
	end
end

function HandbookModel:_dealRedPoint(teamId, pid, curIsActive, isNotify)
	local redKey = string.format("%s_%s", teamId, pid)
	local preActive = self._redKeyMap[redKey] == true

	if preActive ~= curIsActive then
		self._redKeyMap[redKey] = curIsActive

		local parentKey = teamId
		local rootKey = "petteam"
		local offset = curIsActive and 1 or -1

		self._redKeyMap[parentKey] = checknumber(self._redKeyMap[parentKey]) + offset
		self._redKeyMap[rootKey] = checknumber(self._redKeyMap[rootKey]) + offset

		if isNotify ~= false then
			GlobalDispatcher:dispatch(GlobalNotify.RedPointUpdate, RedPointModel.ID_PETTEAMS)
		end
	end
end

function HandbookModel:getPetTeamIsRed()
	local rootKey = "petteam"

	return checknumber(self._redKeyMap[rootKey]) > 0
end

function HandbookModel:onPetMoChange(mo)
	if mo ~= nil then
		local raceId = mo.raceId
		local awakenLv = mo.awakeLevel
		local preAwakenLv = checknumber(self._userOwnedRaceIdMap[raceId])

		if preAwakenLv < awakenLv and preAwakenLv == 0 then
			PetDisplayModel.instance:addNewPetId(mo.petId)
		end

		self._userOwnedRaceIdMap[raceId] = math.max(awakenLv, checknumber(self._userOwnedRaceIdMap[raceId]))

		if HandbookController.instance:getIsDataInit() then
			local teamIds = HandbookConfig.instance:getTeamIdsByRaceId(raceId)

			if #teamIds > 0 then
				for _, teamId in ipairs(teamIds) do
					local collectList = self._posterDataList[teamId].hasCollect

					if not table.indexof(collectList, raceId) then
						table.insert(collectList, raceId)
					end
				end
			end
		end
	end
end

function HandbookModel:setPrizeReceived(teamId, pid)
	if not self._teamPrizeStateMap[teamId] then
		table.insert(self._teamPrizeStateMap[teamId], pid)

		self._teamPrizeStateMap[teamId] = self._teamPrizeStateMap[teamId]

		self:_dealRedPoint(teamId, pid, false)
	end
end

function HandbookModel:getPrizeReceived(teamId, pid)
	pid = checknumber(pid)

	local tempState = self._teamPrizeStateMap[teamId]

	return tempState ~= nil and table.indexof(tempState, pid) ~= false
end

function HandbookModel:getTeamPrizeIsRedById(teamId)
	return checknumber(self._redKeyMap[teamId]) > 0
end

function HandbookModel:getTeamPrizeIsRed()
	local cfgs = HandbookConfig.instance:getCfgs()

	for _, cfg in ipairs(cfgs) do
		if self:getTeamPrizeIsRedById(cfg.teamId) then
			return true
		end
	end

	return false
end

HandbookModel.instance = HandbookModel.New()

return HandbookModel
