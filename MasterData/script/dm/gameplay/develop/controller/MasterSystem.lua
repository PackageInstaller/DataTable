-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/controller/MasterSystem.lua

MasterSystem = class("MasterSystem", legs.Actor, _M)

MasterSystem:has("_masterService", {
	is = "r"
}):injectWith("MasterService")
MasterSystem:has("_curTab1MasterSkillId", {
	is = "rw"
})
MasterSystem:has("_curTab1MasterSkillIndex", {
	is = "rw"
})
MasterSystem:has("_curTab2MasterSkillId", {
	is = "rw"
})
MasterSystem:has("_curTabIndex", {
	is = "rw"
})
MasterSystem:has("_curTab1MasterID", {
	is = "rw"
})
MasterSystem:has("_showMasterIds", {
	is = "rw"
})
MasterSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
MasterSystem:has("_doStageLvUpAnim", {
	is = "rw"
})

MasterLeadStageCondiState = {
	KRareityHero = "RareityHero",
	KEquipRareityLevel = "EquipRareityLevel",
	KSuit = "Suit",
	KEquip = "Equip",
	KAwaken = "Awaken",
	KLeadStage = "LeadStage",
	KStarHero = "StarHero"
}

function MasterSystem:initialize(developSystem)
	super.initialize(self)

	self._developSystem = developSystem
	self._bagSystem = developSystem:getBagSystem()
	self._player = self._developSystem:getPlayer()
	self._curTab1MasterSkillId = 0
	self._curTab1MasterSkillIndex = 1
	self._curTab1MasterID = 0
	self._curTab2MasterSkillId = 0
	self._curTabIndex = 1
	self._temppreData = {}
	self._leaderSkillNum = 6
	self._showMasterIds = nil
	self._doStageLvUpAnim = false
end

function MasterSystem:checkEnabled(params)
	local result, tip = self._systemKeeper:isUnlock("Master_All")

	if not result then
		return result, tip
	end

	if params and params.tabType then
		local tabType = tonumber(params.tabType)

		if tabType == 1 then
			result = true
		elseif tabType == 2 then
			result, tip = self._systemKeeper:isUnlock("Master_StarUp")
		elseif tabType == 3 then
			result, tip = self._systemKeeper:isUnlock("Master_Skill")
		elseif tabType == 4 then
			result, tip = self._systemKeeper:isUnlock("Master_Equip")
		end
	end

	return result, tip
end

function MasterSystem:tryEnter(params)
	local function callback()
		local view = self:getInjector():getInstance("MasterMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, params))
	end

	local result, tip = self:checkEnabled(params)

	if not result then
		self:dispatch(ShowTipEvent({
			tip = tip
		}))

		return
	end

	callback()
end

function MasterSystem:enterBaseShowView(info)
	require("dm.gameplay.develop.view.herostrength.HeroBaseShowView")

	return HeroBaseShowView:new(info)
end

function MasterSystem:getMasterSkillTag(quality, level)
	local content = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_SkillQuality", "content")
	local text = content[tostring(quality)]

	if text then
		return Strings:get(text) .. ((level > 0 or nil) and "+" .. tostring(level))
	end

	return nil
end

function MasterSystem:showTips(key)
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:find(key)
	}))
end

function MasterSystem:getAllMasterStarNumber()
	local masters = self._player:getMasterList():getAllMaster()
	local star = 0

	for k, v in pairs(masters) do
		if v then
			star = star + v:getStar()
		end
	end

	return star
end

function MasterSystem:getMasterByIndex(index)
	return self._player:getMasterList():getMasterByIndex(index)
end

function MasterSystem:getMasterNumber()
	return self._player:getMasterList():getMasterNumber()
end

function MasterSystem:getSkillLevelMax()
	local level = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_SkillMax", "content")

	return level or 0
end

function MasterSystem:sendApplyAllMasters(notShowWaiting, callback)
	local params = {}

	self._masterService:requestGetAllMasters(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._player:getMasterList():synchronize(response.data)
		end

		if callback then
			callback(response)
		end
	end, notShowWaiting)
end

function MasterSystem:sendApplyAllMastersByUrl(data, notShowWaiting, callback)
	local params = {}

	self._masterService:requestGetAllMasters(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._player:getMasterList():synchronize(response.data)

			local playerCultivateView = self:getInjector():getInstance("MasterCultivateView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, playerCultivateView, nil, data))
		end

		if callback then
			callback(response)
		end
	end, notShowWaiting)
end

function MasterSystem:sendApplyComposeMaster(itemid, callback)
	local params = {
		itemId = itemid
	}

	self._masterService:requestComposeMaster(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._player:getMasterList():synchronize(response.data.masters)
			self:dispatch(Event:new(EVT_MASTER_SYNC_COMBIN_SUCC, {}))

			if callback then
				callback()
			end
		end
	end)
end

function MasterSystem:sendApplyMasterStarUp(masterId, preData, callback)
	local params = {
		masterId = masterId
	}
	local preenable = {}

	for k, v in pairs(preData.skills) do
		preenable[k] = v._enable
	end

	self._temppreData = {}

	table.deepcopy(preenable, self._temppreData)
	self._masterService:requestMasterStarUp(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			local masterModel = self._player:getMasterList():getMasterById(masterId)

			masterModel:synchronize(response.data)
			self:dispatch(Event:new(EVT_MASTER_STARUP_SUCC, {
				preData = preData
			}))
			self:dispatch(Event:new(EVT_MASTER_SYNC_UPDATE, {}))

			if callback and response.data.star and response.data.star ~= preData.star then
				callback(self._temppreData, response.data)
			end
		end
	end)
end

function MasterSystem:sendApplyMasterSkillLevelUp(masterId, skillId)
	local params = {
		masterId = masterId,
		skillId = skillId
	}

	self._masterService:requestMasterSkillLevelUp(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			local masterModel = self._player:getMasterList():getMasterById(masterId)

			masterModel:synchronize(response.data)
			self:dispatch(Event:new(EVT_MASTER_SYNC_UPDATE_SKILL, {}))
			self:showTips("MASTER_SKILL_LUP_SUCCESS")
		end
	end)
end

function MasterSystem:requestMasterAuraUp(auraType, callback)
	local params = {
		type = auraType
	}

	self._masterService:requestMasterAuraUp(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_AURA_LEVELUP_SUC, {}))
			self:showTips("MASTER_SKILL_QUP_SUCCESS")

			if callback then
				callback(response)
			end
		end
	end)
end

function MasterSystem:sendApplyMasterSkillUnlock(masterId, skillId)
	self:dispatch(Event:new(EVT_MASTER_SYNC_UPDATE_SKILL, {}))
	self:showTips("MASTER_SKILL_UNLOCK_SUCCESS")
end

function MasterSystem:sendApplyMasterGeneralSkillLevelUp(masterId, skillId)
	local params = {
		masterId = masterId,
		skillId = skillId
	}

	self._masterService:requestMasterGeneralSkillLevelUp(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._player:getMasterGeneral():synchronize(response.data)
			self:dispatch(Event:new(EVT_MASTER_SYNC_UPDATE_SKILL, {}))
			self:showTips("MASTER_SKILL_LUP_SUCCESS")
		end
	end)
end

function MasterSystem:sendApplyMasterGeneralSkillQualityUp(masterId, skillId, index, callback)
	local params = {
		masterId = masterId,
		skillId = skillId
	}

	self._masterService:requestMasterGeneralSkillQualityUp(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._player:getMasterGeneral():synchronize(response.data)
			self:dispatch(Event:new(EVT_MASTER_SYNC_UPDATE_SKILL, {}))
			self:showTips("MASTER_SKILL_QUP_SUCCESS")

			if callback then
				local skillModel = self._player:getMasterGeneral():getSkillByIndex(index)

				callback(skillModel)
			end
		end
	end)
end

function MasterSystem:sendApplyMasterGeneralSkillUnlock(masterId, skillId)
	local params = {
		masterId = masterId,
		skillId = skillId
	}

	self._masterService:requestMasterGeneralSkillUnlock(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._player:getMasterGeneral():synchronize(response.data)
			self:dispatch(Event:new(EVT_MASTER_SYNC_UPDATE_SKILL, {}))
			self:showTips("MASTER_SKILL_UNLOCK_SUCCESS")
		end
	end)
end

function MasterSystem:requestMasterEmblemInfo()
	local params = {}

	self._masterService:requestMasterEmblemInfo(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._player:getMasterEmblemList():synchronize(response.data)
		end
	end)
end

function MasterSystem:requestMasterEmblemLevelUp(emblemId, preData)
	local params = {
		emblemId = emblemId
	}

	self._masterService:requestMasterEmblemLevelUp(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._player:getMasterEmblemList():synchronize(response.data.emblems)
			self._player:getMasterList():synchronize(response.data.masters)
			self:dispatch(Event:new(EVT_EMBLEM_LEVELUP_SUCC, {
				emblemId = emblemId,
				preData = preData
			}))
		end
	end)
end

function MasterSystem:requestMasterEmblemQualityUp(emblemId)
	local params = {
		emblemId = emblemId
	}

	self._masterService:requestMasterEmblemQualityUp(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._player:getMasterEmblemList():synchronize(response.data.emblems)
			self._player:getMasterList():synchronize(response.data.masters)
			self:dispatch(Event:new(EVT_EMBLEM_REFORGE_SUCC, {
				emblemId = emblemId
			}))
		end
	end)
end

function MasterSystem:requestMasterEmblemOnekeyLevelup(emblemId, preData)
	local params = {
		emblemId = emblemId
	}

	self._masterService:requestMasterEmblemOnekeyLevelup(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._player:getMasterEmblemList():synchronize(response.data.emblems)
			self._player:getMasterList():synchronize(response.data.masters)
			self:dispatch(Event:new(EVT_EMBLEM_LEVELUP_SUCC, {
				emblemId = emblemId,
				preData = preData
			}))
		end
	end)
end

function MasterSystem:requestBuyAuraItem(num, callfun)
	local params = {
		num = num
	}

	self._masterService:requestBuyAuraItem(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_MASTER_BUY_MASTER_AURA))

			if callfun then
				callfun()
			end
		end
	end)
end

function MasterSystem:getMasterById(masterId)
	return self._player:getMasterList():getMasterById(masterId)
end

function MasterSystem:getMasterProperty(masterId)
	local master = self:getMasterById(masterId)

	if not master or not master:isShow() then
		return nil
	end

	local models = self:getShowMasterList()

	if not masterId and models[3] then
		masterId = models[3]:getId()
	end

	local list = {}
	local valueName = getAttName()
	local value = getAttNumber(master)

	for i = 1, #valueName do
		list[valueName[i]] = {
			attrType = Strings:get(valueName[i]),
			attrNum = value[i]
		}
	end

	return list
end

function MasterSystem:getShowMasterList()
	return self._player:getMasterList():getShowMasterList()
end

function MasterSystem:getShowMasterIds()
	if not self._showMasterIds then
		self._showMasterIds = {}

		local masterBaseConfig = ConfigReader:getDataTable("MasterBase")

		if masterBaseConfig then
			for k, v in pairs(masterBaseConfig) do
				if v.IfHidden == 1 then
					self._showMasterIds[k] = true
				end
			end
		end
	end

	return self._showMasterIds
end

function MasterSystem:hasMaster(masterId)
	local models = self._player:getMasterList()

	return models:isExistMaster(masterId)
end

function MasterSystem:getSkillTypeName(skillType)
	local skillTypeArr = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_SkillName", "content")

	return Strings:get(skillTypeArr[tostring(skillType)])
end

function MasterSystem:getSkillTypeIcon(skillType)
	local iconData = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_SkillIcon", "content")
	local icon1 = iconData[skillType] .. "_1.png"
	local icon2 = iconData[skillType] .. "_2.png"

	return "asset/heroRect/heroSkillType/" .. icon1, "asset/heroRect/heroSkillType/" .. icon2
end

function MasterSystem:checkIsKeySkill(masterId, skillId)
	local skills = self:getShowMasterSkillList(masterId)

	for i = 1, #skills do
		local skill = skills[i]
		local showType = skill:getSkillType()

		if skill:getId() == skillId and showType == "PassiveSkill" then
			return skill
		end
	end

	return nil
end

function MasterSystem:getShowMasterListUnLock()
	return self._player:getMasterList():getShowMasterList()
end

function MasterSystem:getShowmasterIdsUnLock()
	local models = self._player:getMasterList():getShowMasterList()
	local list = {}

	for i = 1, #models do
		table.insert(list, models[i]:getId())
	end

	return list
end

function MasterSystem:isMasterLockById(masterId)
	local list = self:getShowmasterIdsUnLock()

	for i = 1, #list do
		if list[i] == masterId then
			return false
		end
	end

	return true
end

function MasterSystem:getShowMasterSkillList(masterId)
	local masters = self:getShowMasterList()

	for i = 1, #masters do
		local v = masters[i]

		if v:getId() == tostring(masterId) then
			local skills = {}

			for i = 1, 5 do
				table.insert(skills, v:getSkillByIndex(i))
			end

			return skills
		end
	end

	return nil
end

function MasterSystem:getMasterLeaderSkillNum()
	return self._leaderSkillNum
end

function MasterSystem:getMasterLeaderSkillList(masterId)
	local masters = self:getShowMasterList()

	for i = 1, #masters do
		local v = masters[i]

		if v:getId() == tostring(masterId) then
			local skills = {}

			for i = 1, self._leaderSkillNum do
				table.insert(skills, v:getTeamSkillByIndex(i))
			end

			return skills
		end
	end

	return nil
end

local Master_SkillShowType = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_SkillShowType", "content")

function MasterSystem:getSkillLevelUpItemCost(masterId, skillId)
	local master = self:getMasterById(masterId)
	local skillIndex = master:getSkillIndex(skillId)
	local skill = master:getSkillById(skillId)
	local masterPrototype = PrototypeFactory:getInstance():getMasterPrototype(masterId)
	local showType = Master_SkillShowType[skillIndex]
	local config = masterPrototype:getConfig()
	local costData = config.SkillCost[showType]

	if costData then
		local count = costData.amount[skill:getLevel() + 1] or costData.amount[#costData.amount]

		return {
			itemId = costData.code,
			count = count
		}
	end

	return nil
end

function MasterSystem:checkHasKeySkill(masterId)
	local skills = self:getShowMasterSkillList(masterId)

	for i = 1, #skills do
		local skill = skills[i]
		local showType = skill:getSkillType()

		if showType == "PassiveSkill" then
			return skill
		end
	end

	return nil
end

function MasterSystem:getEnemyMasterSkillList(masterId)
	local masters = self:getShowMasterList()

	for i = 1, #masters do
		local v = masters[i]

		if v:getId() == tostring(masterId) then
			local skills = {}

			for i = 1, 7 do
				table.insert(skills, v:getSkillByIndex(i))
			end

			return skills
		end
	end

	return nil
end

function MasterSystem:getMasterInitiativeSkillList(masterId)
	local skills = self:getShowMasterSkillList(masterId)
	local initiativeSkill = {}

	for k, v in pairs(skills) do
		if v:getBaseType() ~= SkillType.kPassive then
			table.insert(initiativeSkill, v)
		end
	end

	return initiativeSkill
end

function MasterSystem:getShowMaster(masterId)
	local masters = self:getShowMasterList()

	for i = 1, #masters do
		local v = masters[i]

		if v:getId() == tostring(masterId) then
			return v
		end
	end

	return nil
end

function MasterSystem:getEmblemList()
	local emblemList = self._player:getMasterEmblemList():getEmblemList()
	local list = {}

	for k, v in pairs(emblemList) do
		list[tonumber(string.split(k, "_")[2])] = v
	end

	return list
end

function MasterSystem:isEmblemUnlock(id)
	local emblemList = self._player:getMasterEmblemList():getEmblemList()

	for k, v in pairs(emblemList) do
		if tostring(k) == tostring(id) then
			return true
		end
	end

	return false
end

function MasterSystem:getEmblemAllAttribute()
	local emblemList = self._player:getMasterEmblemList():getEmblemList()
	local allAttrList = {}

	for k, v in pairs(emblemList) do
		local attrList = v:getAttList()

		for i, value in pairs(attrList) do
			local isHas, attrIndex = self:isHasAttrbute(allAttrList, value.attrType)

			if isHas == true then
				allAttrList[attrIndex].attrNum = allAttrList[attrIndex].attrNum + value.attrNum
			else
				value.order = AttOrder[value.attrType]
				allAttrList[#allAttrList + 1] = value
			end
		end
	end

	table.sort(allAttrList, function(a, b)
		return a.order < b.order
	end)

	return allAttrList
end

function MasterSystem:isHasAttrbute(allAttrList, attrType)
	for i, value in pairs(allAttrList) do
		if value.attrType == attrType then
			return true, i
		end
	end

	return false
end

function MasterSystem:getMasterNameById(masterId)
	local masterPrototype = PrototypeFactory:getInstance():getMasterPrototype(masterId)

	return masterPrototype._config.Name
end

function MasterSystem:isStarUpgradable(masterModel)
	do return false end

	local unlock = self:getInjector():getInstance("SystemKeeper"):isUnlock("Master_StarUp")

	if not unlock then
		return false
	end

	if masterModel:getIsLock() then
		return false
	end

	local upid = masterModel:getStarUpItemId()
	local number = self._bagSystem:getItemCount(upid)
	local maxnumber = masterModel:getStarUpItemCostByStar()
	local mycrystal = self._developSystem:getCrystal()
	local costCrystal = masterModel:getStarUpMoneyCostByStar()
	local maxStar = masterModel:getMaxStar()
	local star = masterModel:getStar()

	if maxnumber <= number and costCrystal <= mycrystal and star ~= maxStar then
		return true
	end

	return false
end

function MasterSystem:canMasterActive(masterModel)
	if not masterModel:getIsLock() then
		return false
	end

	local upid = masterModel:getStarUpItemId()
	local number = self._bagSystem:getItemCount(upid)
	local maxnumber = masterModel:getCompositePay()

	if maxnumber <= number then
		return true
	end

	return false
end

function MasterSystem:checkIsShowRedPoint()
	local isShow = false
	local masters = self:getShowMasterList()

	for i = 1, #masters do
		local master = masters[i]

		if self:isStarUpgradable(master) then
			isShow = true
		end

		if self:canMasterActive(master) then
			isShow = true
		end

		if self:checkLeadStageRedPoint(master:getId()) then
			return true
		end
	end

	return isShow
end

function MasterSystem:requestLeadStageUp(masterId)
	self:setMastertAwakeAttr(masterId)

	local params = {
		masterId = masterId
	}

	self._masterService:requestLeadStageUp(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			dump(response.data, "response.dataresponse.data")
			self:dispatch(Event:new(EVT_LEADSTASGE_UPDONE, {}))

			if callback then
				callback()
			end
		end
	end)
end

function MasterSystem:setMastertAwakeAttr(masterId)
	local masterData = self:getMasterById(masterId)
	local combat, attrData = masterData:getCombat()

	self._awakeAttrNum = {
		ATK = attrData.attack,
		HP = attrData.hp,
		DEF = attrData.defense
	}
	self._oldLeadStageId, self._oldLeadStageLevel = self:getMasterLeadStatgeLevel(masterId)
end

function MasterSystem:getMastertAwakeAttr()
	if not self._awakeAttrNum then
		self._awakeAttrNum = {
			DEF = 0,
			HP = 0,
			ATK = 0
		}
		self._oldLeadStageId = ""
		self._oldLeadStageLevel = 0
	end

	return self._awakeAttrNum, self._oldLeadStageId, self._oldLeadStageLevel
end

function MasterSystem:checkLeadStageRedPoint(masterId)
	if not CommonUtils.GetSwitch("fn_master_leadStage") then
		return false
	end

	if not self._systemKeeper:isUnlock("LeadStage") then
		return false
	end

	local masterData = self:getMasterById(masterId)
	local ismaxLevel = masterData:getLeadStageData():isMaxLevel()

	if ismaxLevel then
		return false
	end

	local var_73_0

	if not masterData:getLeadStageData():getIsOpen() then
		do return false end

		var_73_0 = masterData:getLeadStageData()
	end

	local rets = self:checkLeadStageCondition(masterId, var_73_0:getLeadStageLevel() + 1)

	if table.indexof(rets, false) then
		return false
	end

	local cost = masterData:getLeadStageData():getCost()

	for i = 1, #cost do
		local hasNum = self._bagSystem:getItemCount(cost[i].id)
		local needNum = cost[i].n

		if hasNum < needNum then
			return false
		end
	end

	return true
end

function MasterSystem:checkLeadStageCondition(masterId, leadStageLv, isNeedNum)
	local ret = {}
	local nums = {}

	if not self._systemKeeper:isUnlock("LeadStage") then
		return {
			false
		}
	end

	local masterData = self:getMasterById(masterId)
	local leadStageData = masterData:getLeadStageData()
	local leadStageDetailConfig = leadStageData:getConfigInfo()
	local conditionInfo = leadStageData:getShowConditionByStageLv(leadStageLv)
	local c = leadStageDetailConfig[leadStageLv]

	if c.LeadStageControl == 0 then
		return {
			false
		}
	end

	for i, info in ipairs(conditionInfo) do
		local k = info.key
		local v = info.value

		if k == MasterLeadStageCondiState.KStarHero or k == MasterLeadStageCondiState.KRareityHero or k == MasterLeadStageCondiState.KAwaken then
			local num = 0
			local heros = self._player:getHeroList():getHeros()

			for _, hero in pairs(heros) do
				if hero:getType() == v.Job and (k == MasterLeadStageCondiState.KStarHero and hero:getStar() >= v.HeroStar or k == MasterLeadStageCondiState.KRareityHero and hero:getRarity() >= v.Rareity or k == MasterLeadStageCondiState.KAwaken and hero:heroAwaked()) then
					num = num + 1

					if num >= v.Count then
						break
					end
				end
			end

			table.insert(ret, num >= v.Count and true or false)
			table.insert(nums, num)
		elseif k == MasterLeadStageCondiState.KEquip then
			local num = 0
			local equipList = self._player:getEquipList()
			local equipIds = equipList:getEquipsByType(v.Location)

			for id, _ in pairs(equipIds) do
				local equip = equipList:getEquipById(id)

				if equip:getRarity() >= v.EquipRareity then
					num = num + 1

					if num >= v.Count then
						break
					end
				end
			end

			table.insert(ret, num >= v.Count and true or false)
			table.insert(nums, num)
		elseif k == MasterLeadStageCondiState.KLeadStage then
			local num = 0
			local masterList = self._player:getMasterList():getAllMaster()

			for id, _ in pairs(masterList) do
				local master = self:getMasterById(id)

				if master:getLeadStageData():getLeadStageLevel() >= v.Lv then
					num = num + 1

					if num >= v.Count then
						break
					end
				end
			end

			table.insert(ret, num >= v.Count and true or false)
			table.insert(nums, num)
		elseif k == MasterLeadStageCondiState.KSuit then
			local HeroEquipAllPos = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipPowerUpOrder", "content")
			local posNum = {}
			local equipList = self._player:getEquipList()

			for i = 1, #HeroEquipAllPos do
				local equipType = HeroEquipAllPos[i]
				local equipIds = equipList:getEquipsByType(equipType)

				posNum[i] = 0

				for id, _ in pairs(equipIds) do
					local equip = equipList:getEquipById(id)

					if equip:getRarity() >= v.EquipRareity and equip:getLevel() >= tonumber(v.SuitLevel) then
						posNum[i] = posNum[i] + 1

						if posNum[i] >= v.Count then
							break
						end
					end
				end
			end

			local minValue = math.min(unpack(posNum))

			table.insert(ret, minValue >= v.Count and true or false)
			table.insert(nums, minValue)
		elseif k == MasterLeadStageCondiState.KEquipRareityLevel then
			local HeroEquipAllPos = v.Location
			local posNum = {}
			local equipList = self._player:getEquipList()

			for i = 1, #HeroEquipAllPos do
				local equipType = HeroEquipAllPos[i]
				local equipIds = equipList:getEquipsByType(equipType)

				posNum[i] = 0

				for id, _ in pairs(equipIds) do
					local equip = equipList:getEquipById(id)

					if equip:getRarity() == v.EquipRareity and equip:getLevel() >= tonumber(v.Level) then
						posNum[i] = posNum[i] + 1

						if posNum[i] >= v.Count then
							break
						end
					end
				end
			end

			local minValue = math.min(unpack(posNum))

			table.insert(ret, minValue >= v.Count and true or false)
			table.insert(nums, minValue)
			print("checkCondition  " .. k .. " " .. minValue .. "  " .. v.Count)
		else
			assert(k, "not support kind " .. k)
		end
	end

	return ret, nums
end

function MasterSystem:getMasterLeadStatgeModelByMasterId(masterId)
	local master = self:getMasterById(id)
	local level = master:getLeadStageData():getLeadStageLevel()

	if level <= 0 then
		return (ConfigReader:getDataByNameIdAndKey("MasterBase", id, "RoleModel"))
	else
		local id = master:getLeadStageData():getLeadStageId()
		local data = ConfigReader:getRecordById("MasterLeadStage", leadStageId)

		return data.ModelId
	end
end

function MasterSystem:getMasterLeadStatgeModelByLSId(leadStageId, roleModelId)
	if leadStageId == "" then
		return (ConfigReader:getDataByNameIdAndKey("RoleModel", roleModelId, "Model"))
	else
		local data = ConfigReader:getRecordById("MasterLeadStage", leadStageId)

		return data.ModelId
	end
end

function MasterSystem:getMasterLeadStatgeLevel(masterId)
	local master = self:getMasterById(masterId)

	if not master then
		return
	end

	local level = master:getLeadStageData():getLeadStageLevel()
	local id = master:getLeadStageData():getLeadStageId()

	return id, level
end

function MasterSystem:getMasterLeadStageModel(masterId, leadStageId)
	if leadStageId == "" then
		return (ConfigReader:requireDataByNameIdAndKey("MasterBase", masterId, "RoleModel"))
	else
		local data = ConfigReader:getRecordById("MasterLeadStage", leadStageId)

		return data.ModelId
	end
end

function MasterSystem:getMasterActiveSkills(masterId)
	local ret = {}
	local masterData = self:getMasterById(masterId)
	local leadStageData = masterData:getLeadStageData()
	local curLv = leadStageData:getLeadStageLevel()

	if curLv == 0 then
		return ret
	end

	local leadStageDetailConfig = leadStageData:getConfigInfo()
	local skills = leadStageDetailConfig[curLv].skills

	for i, v in ipairs(skills) do
		if skills[v].level > 0 then
			local info = {
				skillId = v,
				level = skills[v].level,
				kind = leadStageData:getSkillKind(v)
			}

			if leadStageData:getSkillKind(v) == "Attr" then
				info.skillVId = leadStageDetailConfig[curLv].SkillName[i]
			end

			table.insert(ret, info)
		end
	end

	return ret
end

function MasterSystem:getMasterCurLeadStageConfig(masterId)
	local masterData = self:getMasterById(masterId)

	if not masterData then
		return
	end

	local leadStageData = masterData:getLeadStageData()
	local curId = leadStageData:getLeadStageId()

	if curId ~= "" then
		return ConfigReader:getRecordById("MasterLeadStage", curId)
	end

	return nil
end

function MasterSystem:getMasterLeadStatgeInfoById(leadStageId)
	if leadStageId ~= "" then
		return ConfigReader:getRecordById("MasterLeadStage", leadStageId)
	end

	return nil
end

function MasterSystem:getMasterLeadStageHeadById(masterId, condition)
	if condition.LeadStage then
		local id, level = self:getMasterLeadStatgeLevel(masterId)

		if level then
			return level >= condition.LeadStage
		end
	end

	return false
end
