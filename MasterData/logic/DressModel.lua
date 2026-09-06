-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/model/DressModel.lua

module("logic.extensions.dress.model.DressModel", package.seeall)

local DressModel = class("DressModel", BaseModel)

DressModel.defaultFemaleSkelId = 1
DressModel.defaultMaleSkelId = 2
DressModel.EscortMountId = "EscortMount"
DressModel.EscortMountModel = "60001_jingyu"

function DressModel:getDefaultAvatarMo(id)
	return AvatarConfig.instance:getAvatarMoByCfgId(id)
end

function DressModel:getAvatarByUserVar(userVar)
	local gender = userVar:getDisplayVar(UserVarKey.GENDER)
	local petRace = userVar:getDisplayVar(UserVarKey.ILLUSION_CUTE_PET_RACE)
	local clothes = userVar:getDisplayVar(UserVarKey.CLOTHES) or {}

	if userVar:getDisplayVar(UserVarKey.CONVOY_STATE) then
		if not DressModel.EscortMountId then
			local id1 = 0
			local id2 = userVar:getDisplayVarToNum(UserVarKey.MOUNT)
			local mountId = 0

			mountId = id1 == DressModel.EscortMountId and id1 or math.max(checknumber(id1), id2)

			local skeId = self:getSkeIdByGender(gender)

			skeId = self:getSkeIdByPetRace(petRace, skeId)

			return self:getAvatarPlayerMo(skeId, clothes, mountId)
		end
	end
end

function DressModel:getAvatarByGender(gender)
	local skeId = self:getSkeIdByGender(gender)

	return self:getAvatarPlayerMo(skeId, {}, 0)
end

function DressModel:getSkeIdByGender(gender)
	local skeId = 0

	if gender then
		if gender == GameEnum.Gender.Female then
			skeId = DressConfig.instance:getGirlSkeId()
		elseif gender == GameEnum.Gender.Male then
			skeId = DressConfig.instance:getBoySkeId()
		end
	end

	return skeId
end

function DressModel:getSkeIdByPetRace(petRace, defalutSkeId)
	petRace = checknumber(petRace)

	if petRace > 0 then
		local raceCfg = CutePetConfig.instance:getCutePetById(petRace)

		if raceCfg then
			return raceCfg.modelId
		end
	end

	return defalutSkeId
end

function DressModel:getAvatarPlayerMo(skeId, clothes, mountId)
	clothes = clothes or {}

	if mountId ~= DressModel.EscortMountId then
		mountId = checknumber(mountId)
	end

	local mo = AvatarPlayerMo.New(skeId, true)

	mo:dressSuit(clothes)

	mo.mount = mountId
	mo.isMount = mountId ~= 0

	mo:setDefaultState()

	return mo
end

function DressModel:getAvatarMoByOrigin(userVar)
	local gender = userVar:getOriginVar(UserVarKey.GENDER) or 0
	local clothes = userVar:getOriginVar(UserVarKey.CLOTHES) or {}
	local skeId = self:getSkeIdByGender(gender)

	return self:getAvatarPlayerMo(skeId, clothes, 0)
end

function DressModel:getAvatarMoByGrCosAndMount(gender, clothes, mount)
	gender = gender or GameEnum.Gender.Female

	local mountId = checkint(mount)

	clothes = clothes or {}

	local skeId = self:getSkeIdByGender(gender)
	local mo = AvatarConfig.instance:getAvatarMoByCfgId(skeId)

	mo:dressSuit(clothes)

	mo.mount = mountId
	mo.isMount = mo.mount ~= 0

	mo:setDefaultState()

	return mo
end

function DressModel:getAvatarMoWithDefaultSuit(gender)
	gender = gender or GameEnum.Gender.Female

	local suitId
	local clothes = DressConfig.instance:getSuitInclude(gender == GameEnum.Gender.Female and DressConfig.instance:getGrilSuitId() or DressConfig.instance:getBoySuitId())

	return self:getAvatarMoByGrCosAndMount(gender, clothes)
end

function DressModel:ctor()
	DressModel.super.ctor(self)
end

function DressModel:onInit()
	self:onReset()
end

function DressModel:onReset()
	self._curOwnDresses = {}
	self._curChangeDresses = {}
	self._outDressDatas = {}
	self._curOwnSuits = {}
	self._presetMap = {}
	self._initData = false
end

function DressModel:updateAfterGetNotoutDressInfo(msg)
	local ClotheDatas = {}

	for _, v in pairs(msg.userClothes) do
		local data = ClotheData.New()

		data:setData(v)

		if data.id > 0 then
			table.insert(ClotheDatas, data)
		end
	end

	self:updateDressData(ClotheDatas)

	self._initData = true
end

function DressModel:updateAfterGetOutDressInfo(msg)
	local ClotheDatas = {}

	for _, v in pairs(msg.userClothes) do
		local data = ClotheData.New()

		data:setData(v)

		if data.id > 0 then
			table.insert(ClotheDatas, data)
		end
	end

	self:updatePassDressData(ClotheDatas)
end

function DressModel:updateAfterGetDressInfo(msg)
	local ClotheDatas = {}

	for _, v in pairs(msg.clothes) do
		local data = ClotheData.New()

		data:setData(v)

		if data.id > 0 then
			table.insert(ClotheDatas, data)
		end
	end

	self:addDressData(ClotheDatas)
end

function DressModel:updateAfterSaveAvatar(msg)
	return
end

function DressModel:getIsInitData()
	return self._initData
end

function DressModel:getCurOwnDresses()
	return self._curOwnDresses
end

function DressModel:getCurChangeDresses()
	return self._curChangeDresses
end

function DressModel:getOutDressDatas()
	return self._outDressDatas
end

function DressModel:getCurOwnSuits()
	return self._curOwnSuits
end

function DressModel:getCurOwnDressById(dressId)
	if self._curOwnDresses then
		for _, d in ipairs(self._curOwnDresses) do
			if d.id == dressId then
				return d
			end
		end
	end

	if self._curChangeDresses then
		for _, d in ipairs(self._curChangeDresses) do
			if d.id == dressId then
				return d
			end
		end
	end
end

function DressModel:getIsOwnDressById(dressId)
	local dressData = self:getCurOwnDressById(dressId)

	if dressData then
		return dressData.isOwn
	else
		return false
	end
end

function DressModel:updateDressData(ClotheDatas)
	self._curOwnDresses = {}
	self._curChangeDresses = {}

	local roleGender = RoleModel.instance:getGender()

	for k, d in ipairs(ClotheDatas) do
		if d.dressCfg and d.dressCfg.clothesGender == GameEnum.Gender.Neutral or d.dressCfg.clothesGender == roleGender then
			table.insert(self._curOwnDresses, d)
		else
			table.insert(self._curChangeDresses, d)
		end
	end

	self:updateSuitData()
end

function DressModel:updatePassDressData(ClotheDatas)
	self._outDressDatas = {}

	local roleGender = RoleModel.instance:getGender()

	for k, d in ipairs(ClotheDatas) do
		if d.dressCfg and d.dressCfg.clothesGender == GameEnum.Gender.Neutral or d.dressCfg.clothesGender == roleGender then
			table.insert(self._outDressDatas, d)
		end
	end
end

function DressModel:addDressData(ClotheDatas)
	local roleGender = RoleModel.instance:getGender()

	for k, d in ipairs(ClotheDatas) do
		if d.dressCfg.clothesGender == GameEnum.Gender.Neutral or d.dressCfg.clothesGender == roleGender then
			local exitSameDress = self:getCurOwnDressById(d.id)

			if exitSameDress then
				table.removebyvalue(self._curOwnDresses, exitSameDress, true)
			end

			table.insert(self._curOwnDresses, d)
		else
			local exitSameDress = self:getCurOwnDressById(d.id)

			if exitSameDress then
				table.removebyvalue(self._curChangeDresses, exitSameDress, true)
			end

			table.insert(self._curChangeDresses, d)
		end
	end

	self:updateSuitData()
end

function DressModel:updateSuitData()
	self._curOwnSuits = {}

	local ownSuitId = {}

	for k, d in ipairs(self._curOwnDresses) do
		local suitId = d.dressCfg.suitId

		if suitId > 0 and not table.indexof(ownSuitId, suitId) then
			local suitInclude = DressConfig.instance:getSuitInclude(suitId)

			if suitInclude then
				local isOwn = true
				local suitDayActive, suitDateGet

				for k, v in ipairs(suitInclude) do
					local curClothe = self:getCurOwnDressById(v)

					if curClothe then
						if suitDayActive then
							if suitDayActive > curClothe.dayActive then
								suitDayActive = curClothe.dayActive
							end
						else
							suitDayActive = curClothe.dayActive
						end

						if suitDateGet then
							if suitDateGet < curClothe.dateGet then
								suitDateGet = curClothe.dateGet
							end
						else
							suitDateGet = curClothe.dateGet
						end
					else
						isOwn = false

						break
					end
				end

				if isOwn then
					local cfg = DressConfig.instance:getSuitCfgById(suitId)
					local suit = {
						id = suitId,
						sortId = suitId,
						dateGet = suitDateGet,
						dayActive = suitDayActive,
						inClude = suitInclude,
						suitCfg = cfg
					}

					table.insert(self._curOwnSuits, suit)
					table.insert(ownSuitId, suitId)
				end
			end
		end
	end
end

function DressModel:getPresetMap()
	return self._presetMap
end

function DressModel:handleGetClothesPresetRes(msg)
	local clothesPresetList = msg.clothesPresetList

	if clothesPresetList then
		for _, info in ipairs(clothesPresetList) do
			self._presetMap[info.presetId] = info
		end
	end
end

function DressModel:handleUpdateClothesPresetRes(msg)
	if msg.clothesPreset then
		local info = msg.clothesPreset

		self._presetMap[info.presetId] = info
	end
end

function DressModel:getUserClothesPresetNO(curPresetId, curGender, curClothesIds)
	return {
		presetId = curPresetId,
		gender = curGender,
		clothesIds = curClothesIds
	}
end

DressModel.instance = DressModel.New()

return DressModel
