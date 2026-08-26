-- chunkname: @modules/logic/character/model/extra/CharacterExtraWeaponMO.lua

module("modules.logic.character.model.extra.CharacterExtraWeaponMO", package.seeall)

local CharacterExtraWeaponMO = class("CharacterExtraWeaponMO")

function CharacterExtraWeaponMO:isUnlockSystem()
	return self:isUnlockWeapon(CharacterExtraEnum.WeaponType.First)
end

function CharacterExtraWeaponMO:isUnlockWeapon(weaponType)
	local value = self:getUnlockWeaponRank(weaponType)

	return value <= self.heroMo.rank
end

function CharacterExtraWeaponMO:getUnlockSystemRank()
	return self:getUnlockWeaponRank(CharacterExtraEnum.WeaponType.First)
end

function CharacterExtraWeaponMO:getUnlockWeaponRank(weaponType)
	local const = CharacterExtraEnum.WeaponParams[weaponType].UnlockConst
	local constCo = lua_fight_const.configDict[const]

	return (tonumber(constCo.value))
end

function CharacterExtraWeaponMO:refreshMo(extraStr, heroMo)
	self.heroMo = heroMo

	self:initConfig()

	if not string.nilorempty(extraStr) then
		local split = string.splitToNumber(extraStr, "#")

		for _, type in pairs(CharacterExtraEnum.WeaponType) do
			self:setCurEquipWeapon(type, split[type])
		end
	end

	self:refreshStatus()
end

function CharacterExtraWeaponMO:initConfig()
	if not self._weaponMos then
		self._weaponMos = {}

		local cos = CharacterExtraConfig.instance:getEzioWeaponConfigs()

		for type, list in pairs(cos) do
			self._weaponMos[type] = self._weaponMos[type] or {}

			for i, co in ipairs(list) do
				local showMo = CharacterWeaponShowMO.New()

				showMo:initMo(self.heroMo.heroId, co)

				self._weaponMos[type][co.weaponId] = showMo
			end
		end
	end
end

function CharacterExtraWeaponMO:refreshStatus()
	for type, mos in pairs(self._weaponMos) do
		for _, mo in pairs(mos) do
			local status = CharacterExtraEnum.WeaponStatus.Normal
			local isEquip = self:getCurEquipWeapon(type) == mo.weaponId
			local isUnlock = self:isUnlockWeapon(type)

			if not isUnlock then
				status = CharacterExtraEnum.WeaponStatus.Lock
			elseif isEquip then
				status = CharacterExtraEnum.WeaponStatus.Equip
			end

			mo:setStatus(status)
		end
	end
end

function CharacterExtraWeaponMO:getWeaponMosByType(type)
	local moList = {}

	if self._weaponMos[type] then
		for i, mo in pairs(self._weaponMos[type]) do
			table.insert(moList, mo)
		end

		table.sort(moList, CharacterExtraWeaponMO.sortWeaponMo)
	end

	return moList
end

function CharacterExtraWeaponMO.sortWeaponMo(a, b)
	return a.weaponId < b.weaponId
end

function CharacterExtraWeaponMO:getWeaponMoByTypeId(type, id)
	return self._weaponMos[type] and self._weaponMos[type][id]
end

function CharacterExtraWeaponMO:getCurEquipWeapon(type)
	return (self._curEquipWeapon or nil) and (self._curEquipWeapon[type] or 0)
end

function CharacterExtraWeaponMO:setCurEquipWeapon(type, id)
	self._curEquipWeapon = self._curEquipWeapon or {}
	self._curEquipWeapon[type] = id
end

function CharacterExtraWeaponMO:getWeaponGroupCo()
	local mainEquipedId = self:getCurEquipWeapon(CharacterExtraEnum.WeaponType.First)
	local secondEquipedId = self:getCurEquipWeapon(CharacterExtraEnum.WeaponType.Second)

	return (CharacterExtraConfig.instance:getEzioWeaponGroupCos(mainEquipedId, secondEquipedId, self.heroMo.exSkillLevel))
end

function CharacterExtraWeaponMO:isConfirmWeaponGroup(mainId, secondId)
	local mainEquipedId = self:getCurEquipWeapon(CharacterExtraEnum.WeaponType.First)
	local secondEquipedId = self:getCurEquipWeapon(CharacterExtraEnum.WeaponType.Second)

	return mainEquipedId == mainId and secondEquipedId == secondId
end

function CharacterExtraWeaponMO:setChoiceHero3123WeaponRequest(type, id)
	local mainId, secondId

	self._curEquipWeapon = self._curEquipWeapon or {}

	if type == CharacterExtraEnum.WeaponType.First then
		mainId = id
		secondId = self._curEquipWeapon[CharacterExtraEnum.WeaponType.Second] or 0
	else
		mainId = self._curEquipWeapon[CharacterExtraEnum.WeaponType.First] or 0

		if mainId == 0 then
			GameFacade.showToast(ToastEnum.CharacterNoEquipFirstWeapon)

			return
		end

		secondId = id
	end

	HeroRpc.instance:setChoiceHero3123WeaponRequest(self.heroMo.heroId, mainId, secondId)
end

function CharacterExtraWeaponMO:confirmWeaponGroup(firstId, secondId)
	HeroRpc.instance:setChoiceHero3123WeaponRequest(self.heroMo.heroId, firstId or 0, secondId or 0)
end

function CharacterExtraWeaponMO:getUnlockRankStr(rank)
	local unlocktxt = {}
	local unlockFormat = luaLang("character_rankup_unlock_system")

	for type, param in ipairs(CharacterExtraEnum.WeaponParams) do
		if self:getUnlockWeaponRank(type) == rank then
			local txt = GameUtil.getSubPlaceholderLuaLangOneParam(unlockFormat, luaLang(param.RankupShow))

			table.insert(unlocktxt, txt)
		end
	end

	return unlocktxt
end

function CharacterExtraWeaponMO:isShowWeaponReddot(weaponType)
	if self:isUnlockWeapon(weaponType) then
		local key = self:_getReddotKey(weaponType)
		local value = GameUtil.playerPrefsGetNumberByUserId(key, 0)

		return value == 0
	end

	return false
end

function CharacterExtraWeaponMO:checkReddot()
	local hasReddot = false

	for type, _ in ipairs(CharacterExtraEnum.WeaponParams) do
		local isShow = self:isShowWeaponReddot(type)

		if isShow then
			local key = self:_getReddotKey(type)

			GameUtil.playerPrefsSetNumberByUserId(key, 1)

			hasReddot = true
		end
	end

	if hasReddot then
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function CharacterExtraWeaponMO:_getReddotKey(type)
	return (string.format("%s_%s_%s", CharacterExtraEnum.WeaponTypeReddot, self.heroMo.heroId, type))
end

function CharacterExtraWeaponMO:getCurEquipGroupCo()
	local mainEquipedId = self:getCurEquipWeapon(CharacterExtraEnum.WeaponType.First)
	local secondEquipedId = self:getCurEquipWeapon(CharacterExtraEnum.WeaponType.Second)

	return (CharacterExtraConfig.instance:getEzioWeaponGroupCos(mainEquipedId, secondEquipedId, self.heroMo.exSkillLevel))
end

function CharacterExtraWeaponMO:getReplaceSkill()
	local co = self:getCurEquipGroupCo()

	if co then
		return string.format("1#%s|2#%s", co.skillGroup1, co.skillGroup2), co.skillEx, co.passiveSkill
	end
end

function CharacterExtraWeaponMO:getReplacePassiveSkills(skillIds)
	local co = self:getCurEquipGroupCo()

	if co and not string.nilorempty(co.exchangeSkills) then
		local passiveSkill = GameUtil.splitString2(co.exchangeSkills, true, "|", "#")

		for i, id in pairs(skillIds) do
			for _, skillId in ipairs(passiveSkill) do
				local orignSkillId = skillId[1]
				local newSkillId = skillId[2]

				if id == orignSkillId then
					skillIds[i] = newSkillId
				end
			end
		end
	end

	return skillIds
end

return CharacterExtraWeaponMO
