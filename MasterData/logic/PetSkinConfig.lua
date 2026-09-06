-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/config/PetSkinConfig.lua

module("logic.extensions.petskin.config.PetSkinConfig", package.seeall)

local PetSkinConfig = class("PetSkinConfig", BaseConfig)

function PetSkinConfig:getNames()
	return {
		"pet_skin",
		"petskin_common_config",
		"poster_model",
		"bg_skin",
		"pet_sell",
		"pet_skin_goto",
		"pet_skin_try_items"
	}
end

function PetSkinConfig:handleConfig(name, content)
	if name == "pet_skin" then
		self.pet_skin_cfg = content

		self:createSkinPool()
	elseif name == "petskin_common_config" then
		self.petskin_common_cfg = content
	elseif name == "poster_model" then
		self.poster_modelCfg = content

		self:initAllPoster()
	elseif name == "bg_skin" then
		self.bg_skin = content
	elseif name == "pet_sell" then
		self.pet_sell = content
	elseif name == "pet_skin_goto" then
		self.petSkinGotoCfgs = content
	elseif name == "pet_skin_try_items" then
		self.pet_skin_try_itemsCfg = content
	end
end

function PetSkinConfig:onInit()
	self._skinAttrsMap = {}
	self._petSkinBodyMap = {}

	self:onReset()
end

function PetSkinConfig:onReset()
	return
end

function PetSkinConfig:getTryItemCfg(id)
	return self.pet_skin_try_itemsCfg[id]
end

function PetSkinConfig:getPosterModelCo(id)
	return self.poster_modelCfg[id]
end

function PetSkinConfig:initAllPoster()
	self.poster_skins_cfg = {}

	for i = #self.poster_modelCfg.dataList, 1, -1 do
		local cfg = self.poster_modelCfg.dataList[i]
		local arr = cfg.skinId

		for j, skinId in ipairs(arr) do
			self.poster_skins_cfg[skinId] = self.poster_skins_cfg[skinId] or {}

			local cfgPetSkin = self:getPetSkinCfg(skinId)

			if cfgPetSkin and cfgPetSkin.skinGroup > 0 then
				local petSkinList = self:getPetSkinListBySkinGroup(cfgPetSkin.skinGroup)

				for k, cfgSamePetSkin in ipairs(petSkinList) do
					self.poster_skins_cfg[cfgSamePetSkin.skinId] = self.poster_skins_cfg[cfgSamePetSkin.skinId] or {}

					table.insert(self.poster_skins_cfg[cfgSamePetSkin.skinId], cfg)
				end
			else
				table.insert(self.poster_skins_cfg[skinId], cfg)
			end
		end
	end
end

function PetSkinConfig:getPosterList(skinId)
	return self.poster_skins_cfg[skinId]
end

function PetSkinConfig:createSkinPool()
	self.pet_skin_pool = {}
	self.pet_skin_quality_pool = {}
	self.pet_skin_group_pool = {}

	local arr = self.pet_skin_cfg.dataList

	if arr then
		for i, cfg in ipairs(arr) do
			if checknumber(cfg.isHide) == 0 then
				self.pet_skin_pool[cfg.raceId] = self.pet_skin_pool[cfg.raceId] or {}

				local tem = self.pet_skin_pool[cfg.raceId]

				table.insert(tem, cfg)

				self.pet_skin_pool[cfg.raceId] = tem

				local bodyType = cfg.bodyType

				self._petSkinBodyMap[cfg.raceId] = self._petSkinBodyMap[cfg.raceId] or {}
				self._petSkinBodyMap[cfg.raceId][bodyType] = self._petSkinBodyMap[cfg.raceId][bodyType] or {}

				local tem = self._petSkinBodyMap[cfg.raceId][bodyType]

				table.insert(tem, cfg)

				self._petSkinBodyMap[cfg.raceId][bodyType] = tem

				local quality = cfg.quality
				local skinId = cfg.skinId

				self.pet_skin_quality_pool[quality] = self.pet_skin_quality_pool[quality] or {}
				self.pet_skin_quality_pool[quality][skinId] = cfg

				if cfg.skinGroup > 0 then
					self.pet_skin_group_pool[cfg.skinGroup] = self.pet_skin_group_pool[cfg.skinGroup] or {}

					table.insert(self.pet_skin_group_pool[cfg.skinGroup], cfg)
				end
			end
		end
	end
end

function PetSkinConfig:getPetSkinListBySkinId(skinId)
	local cfg = self:getPetSkinCfg(skinId)

	if cfg then
		local raceId = cfg.raceId
		local bodyType = cfg.bodyType
		local map = self._petSkinBodyMap[raceId]

		if map then
			return map[bodyType]
		end
	end

	return {}
end

function PetSkinConfig:getPetSkinListByQuality(quality)
	local hashList = self.pet_skin_quality_pool[quality]

	return hashList or {}
end

function PetSkinConfig:tryChangePetSkinId(skinId, ele)
	if self:checkHasEleAttr(skinId, ele) then
		return skinId
	else
		local cfg = self:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId
			local bodyType = cfg.bodyType
			local bodyTypeGroupId = cfg.bodyTypeGroupId
			local map = self._petSkinBodyMap[raceId]

			for k, v in pairs(map or {}) do
				if k ~= bodyType then
					for i, co in ipairs(v) do
						if co.bodyTypeGroupId == bodyTypeGroupId and self:checkHasEleAttr(co.skinId, ele) then
							return co.skinId
						end
					end
				end
			end
		end
	end

	return skinId
end

function PetSkinConfig:getAllPetSkinListByRaceId(raceId)
	return self.pet_skin_pool[raceId]
end

function PetSkinConfig:getPetSkinCommonCfg(key)
	return self.petskin_common_cfg[key]
end

function PetSkinConfig:getPetSkinCfgList()
	return self.pet_skin_cfg.dataList
end

function PetSkinConfig:getPetSkinCfg(skinId)
	skinId = checknumber(skinId)

	return self.pet_skin_cfg[skinId]
end

function PetSkinConfig:getPetSkinBodyMap(skinId)
	skinId = checknumber(skinId)

	local cfg = self:getPetSkinCfg(skinId)

	if cfg then
		local raceId = cfg.raceId

		return self._petSkinBodyMap[raceId]
	end

	return nil
end

function PetSkinConfig:checkHasMutiBody(skinId)
	skinId = checknumber(skinId)

	local map = self:getPetSkinBodyMap(skinId)

	return ((map or nil) and table.nums(map)) > 1
end

function PetSkinConfig:getPetSkinName(skinId)
	skinId = checknumber(skinId)

	local cfg = self.pet_skin_cfg[skinId]

	if cfg then
		return cfg.skinName
	end

	return ""
end

function PetSkinConfig:getPetSkinRaceId(skinId)
	skinId = checknumber(skinId)

	local cfg = self.pet_skin_cfg[skinId]

	if cfg then
		return cfg.raceId
	end

	return 0
end

function PetSkinConfig:getSkinCvName(skinId)
	skinId = checknumber(skinId)

	local cfg = self.pet_skin_cfg[skinId]

	if cfg then
		return cfg.cvName
	end

	return ""
end

function PetSkinConfig:getSkinShowTime(skinId)
	skinId = checknumber(skinId)

	local cfg = self.pet_skin_cfg[skinId]

	if cfg then
		return cfg.showTime
	end

	return ""
end

function PetSkinConfig:checkIsSameGender(skinId, genderId)
	skinId = checknumber(skinId)
	genderId = checknumber(genderId)

	local cfg = self.pet_skin_cfg[skinId]

	if cfg then
		return cfg.genderId == genderId
	end

	return false
end

function PetSkinConfig:getBgSkinCfgs()
	return self.bg_skin.dataList
end

function PetSkinConfig:getPetSkinSellCfgs()
	return self.pet_sell.dataList
end

function PetSkinConfig:getPetSkinGotoCfgs()
	return self.petSkinGotoCfgs.dataList
end

function PetSkinConfig:getCurActPetSkinGotoCfgs()
	local curActCfgs = {}

	for k, v in pairs(self.petSkinGotoCfgs.dataList) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			table.insert(curActCfgs, v)
		end
	end

	return curActCfgs
end

function PetSkinConfig:getSkinAttrs(skinId)
	skinId = checknumber(skinId)

	local extInfo = self._skinAttrsMap[skinId]

	if extInfo == nil then
		local cfg = self:getPetSkinCfg(skinId)

		if cfg then
			extInfo = {}

			local jobStrs = string.split(cfg.job, ",")

			extInfo.first_jobKey = jobStrs[1]
			extInfo.first_jobIdx = GameEnum.JobZh[jobStrs[1]]
			extInfo.second_jobIdx = -1
			extInfo.second_jobKey = ""

			if jobStrs[2] and #jobStrs[2] > 0 then
				extInfo.second_jobKey = jobStrs[2]
				extInfo.second_jobIdx = GameEnum.JobZh[jobStrs[2]]
			end

			if jobStrs[3] and #jobStrs[3] > 0 then
				extInfo.third_jobKey = jobStrs[3]
				extInfo.third_jobIdx = GameEnum.JobZh[jobStrs[3]]
			end

			extInfo.jobKeyList = {}

			if jobStrs then
				for _, str in ipairs(jobStrs) do
					table.insert(extInfo.jobKeyList, str)
				end
			end

			local elementAttrList = string.split(cfg.elementAttr, ",")

			extInfo.elementAttrList = elementAttrList

			if #elementAttrList > 0 then
				extInfo.first_elementAttrIdx = GameEnum.Races[elementAttrList[1]]
			end

			local modelCo = CharacterConfig.instance:getModelCo(skinId)

			if modelCo then
				extInfo.icon = modelCo.headName
			end

			self._skinAttrsMap[skinId] = extInfo
		end
	end

	return extInfo
end

function PetSkinConfig:getAllElementAttrs(skinId)
	local extInfo = self:getSkinAttrs(skinId)

	if extInfo and extInfo.elementAttrList then
		return extInfo.elementAttrList
	end

	printError(">>>>>>>>> PetSkinConfig:getAllElementAttrs 对应的皮肤没配置属性数据：", skinId)
end

function PetSkinConfig:getFisrtEleAttrIdx(skinId)
	local extInfo = self:getSkinAttrs(skinId)

	if extInfo and extInfo.first_elementAttrIdx then
		return extInfo.first_elementAttrIdx
	end

	printError(">>>>>>>>> PetSkinConfig:getFisrtEleAttr 对应的皮肤没配置属性数据：", skinId)
end

function PetSkinConfig:checkIsSameFirstEleAttr(skinId1, skinId2)
	local idx1 = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId1)
	local idx2 = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId2)

	return idx1 == idx2
end

function PetSkinConfig:checkHasEleAttr(skinId, ele)
	if ele and type(ele) == "string" then
		ele = GameEnum.Races[ele]
	end

	local extInfo = self:getSkinAttrs(skinId)

	if extInfo then
		return extInfo.first_elementAttrIdx == ele
	end

	printError(">>>>>>>>> PetSkinConfig:checkHasEleAttr 对应的皮肤没配置属性数据：", skinId)
end

function PetSkinConfig:getFirstJobKey(skinId)
	local extInfo = self:getSkinAttrs(skinId)

	if extInfo then
		return extInfo.first_jobKey
	end

	if enableDebug then
		printError(">>>>>>>>> PetSkinConfig:getFirstJobCfg 对应的皮肤没配置 职业 数据：", skinId)
	end

	return -1
end

function PetSkinConfig:getFirstJobIdx(skinId)
	local extInfo = self:getSkinAttrs(skinId)

	if extInfo then
		return extInfo.first_jobIdx
	end

	printError(">>>>>>>>> PetSkinConfig:getFirstJobIdx 对应的皮肤没配置 职业 数据：", skinId)

	return -1
end

function PetSkinConfig:getSecondJobIdx(skinId)
	local extInfo = self:getSkinAttrs(skinId)

	if extInfo then
		return extInfo.second_jobIdx
	end

	return -1
end

function PetSkinConfig:getThirdJobIdx(skinId)
	local extInfo = self:getSkinAttrs(skinId)

	if extInfo then
		return extInfo.third_jobIdx
	end

	return -1
end

function PetSkinConfig:getJobKeyList(skinId)
	local extInfo = self:getSkinAttrs(skinId)

	if extInfo then
		return extInfo.jobKeyList
	end

	return {}
end

function PetSkinConfig:checkHasJob(skinId, job)
	if job and type(job) == "string" then
		job = GameEnum.JobZh[job]
	end

	local extInfo = self:getSkinAttrs(skinId)

	if extInfo then
		return extInfo.first_jobIdx == job or extInfo.second_jobIdx == job or extInfo.third_jobIdx ~= nil and extInfo.third_jobIdx == job
	end

	return false
end

function PetSkinConfig:getFirstJobClassify(skinId)
	local firstJobIdx = self:getFirstJobIdx(skinId)

	if firstJobIdx == GameEnum.CareerType.Mofa or firstJobIdx == GameEnum.CareerType.ZhiLiao then
		return 2
	else
		return 1
	end
end

function PetSkinConfig:isExistSkinGroup(skinId)
	local cfg = self:getPetSkinCfg(skinId)

	return cfg and cfg.skinGroup > 0
end

function PetSkinConfig:getPetSkinListBySkinGroup(skinGroupId)
	if skinGroupId > 0 and self.pet_skin_group_pool and self.pet_skin_group_pool[skinGroupId] then
		return self.pet_skin_group_pool[skinGroupId]
	else
		return {}
	end
end

function PetSkinConfig:getPetSkinCfgBySkinGroupAndRaceId(skinGroup, raceId)
	local list = self:getPetSkinListBySkinGroup(skinGroup)

	for i, v in ipairs(list) do
		if v.raceId == raceId then
			return v
		end
	end
end

function PetSkinConfig:isMainSkinCfgBySkinGroup(petskinCfg)
	if self:isExistSkinGroup(petskinCfg.skinId) then
		if petskinCfg.skinGroup == petskinCfg.skinId then
			return true
		end
	else
		return false
	end
end

function PetSkinConfig:getMainSkinGroupCfgBySkinId(skinId)
	local cfg = self:getPetSkinCfg(skinId)

	if cfg and cfg.skinGroup > 0 then
		local mainPetSkinId = cfg.skinGroup

		return (self:getPetSkinCfg(mainPetSkinId))
	end
end

function PetSkinConfig:getMainSkinGroupCfgBySkinGroup(skinGroup)
	return (self:getPetSkinCfg(skinGroup))
end

function PetSkinConfig:isSkinInteractable(skinId)
	return true
end

function PetSkinConfig:getStoryId(skinId)
	local petSkinCfg = self:getPetSkinCfg(skinId)

	return petSkinCfg.storyId
end

PetSkinConfig.instance = PetSkinConfig.New()

return PetSkinConfig
