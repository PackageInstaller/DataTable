-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/controller/PetFilterMgr.lua

module("logic.extensions.bag.controller.PetFilterMgr", package.seeall)

local PetFilterMgr = class("PetFilterMgr")

PetFilterMgr.TYPE_PETVIEW = 1
PetFilterMgr.TYPE_FMT_RIGHT = 2
PetFilterMgr.TYPE_PET_FILES = 3
PetFilterMgr.TYPE_SELECT_VIEW = 4
PetFilterMgr.TYPE_TIMEWHEEL = 5
PetFilterMgr.TYPE_WARRIOR = 6
PetFilterMgr.TYPE_GOODFEEL = 7
PetFilterMgr.TYPE_PET_RANK = 8
PetFilterMgr.TYPE_PET_BUDDY_HIRE = 9
PetFilterMgr.TYPE_SEASON_BAG = 10
PetFilterMgr.TYPE_SEASON_HIRE = 11
PetFilterMgr.TYPE_EXCHANGE_SHOP = 12
PetFilterMgr.TYPE_SKIN_PREVIEW = 13
PetFilterMgr.TYPE_DIVINE_EVOLVE = 14
PetFilterMgr.TYPE_ROGUE_LIKE = 15
PetFilterMgr.TYPE_DIVINEBOUNTY = 16
PetFilterMgr.TYPE_EQUIP_RECYCLE = 17
PetFilterMgr.TYPE_NEWYEAR_GOODSSHOP = 18
PetFilterMgr.TYPE_BONE_DRAGON = 19
PetFilterMgr.TYPE_ITEM_SELECT_EQUIP = 20
PetFilterMgr.TYPE_ANNI_MATCH_BAN = 21
PetFilterMgr.TYPE_AOQI_GOD = 22
PetFilterMgr.TYPE_ETERNAL_CITY = 23
PetFilterMgr.TYPE_LOTTERY_PRIZE = 24
PetFilterMgr.MAX_PET_JOB_INDEX = 33
PetFilterMgr.JOB_AGE_OTHER_INDEX = PetFilterMgr.MAX_PET_JOB_INDEX + 1
PetFilterMgr.JOB_ALL_AGE_LIST = {
	[GameEnum.CareerType.Shenqi] = true,
	[GameEnum.CareerType.ShenYao] = true,
	[GameEnum.CareerType.SourceTrace] = true
}

function PetFilterMgr:ctor()
	return
end

function PetFilterMgr:openFilterViewByType(presentor, type, pos, sizeDelta, callback)
	UIStateManager.instance:open(ViewName.PetFilterView, pos, sizeDelta, presentor, type, GameUtil.handler(callback, type))
end

function PetFilterMgr:checkIsMatch(type, cfg, rare, skinId)
	if rare == nil then
		rare = CharacterConfig.instance:getRareByAwakenLv(cfg.initAwakenLv, cfg.raceId)
	end

	if skinId == nil then
		skinId = cfg.raceId
	end

	local data = self:getFilterData(type)
	local rareList = data.rareSelectList
	local raceList = data.raceSelectList
	local jobList = data.jobSelectList
	local jobAgeList = data.jobAgeSelectList
	local atkList = data.atkSelectList
	local racdIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	racdIdx = racdIdx % 10

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(skinId)
	local thirdJobIdx = PetSkinConfig.instance:getThirdJobIdx(skinId)
	local careerClassify = PetSkinConfig.instance:getFirstJobClassify(skinId)
	local hasSkillLabel = false
	local skillInfocfg = CharacterConfig.instance:getSkillInfoByLvl(skinId, 1)
	local petCo = PetSkinConfig.instance:getPetSkinCfg(skinId)

	for index, v in ipairs(MaterialMgr.SkillName) do
		local skillId = checknumber(skillInfocfg[v])

		if skillId > 0 then
			local skillCo = BattleConfig.instance:getSkillCo(skillId, skinId)

			if skillCo == nil then
				if enableDebug then
					printError(">>>>>>>>>>>>>> 技能是空的 skillid:", skillId, " skinId:", skinId)
				end

				skillCo = {}
			end

			if not skillCo.labelIds then
				local labelIds = {}

				if #labelIds == 0 then
					hasSkillLabel = hasSkillLabel or ItemFilter.checkIsMatch(data.skillSelectList, -1)

					if hasSkillLabel then
						break
					end
				end

				for i, lbId in ipairs(labelIds) do
					hasSkillLabel = hasSkillLabel or ItemFilter.checkIsMatch(data.skillSelectList, lbId)

					if hasSkillLabel then
						break
					end
				end

				if hasSkillLabel then
					break
				end
			end
		end
	end

	local pcfg = CharacterConfig.instance:getPetInfoCo(cfg.raceId)
	local posIdx = 0

	if pcfg and pcfg.bestPosition == GameEnum.FRONT_PET then
		posIdx = 1
	elseif pcfg and pcfg.bestPosition == GameEnum.BACK_PET then
		posIdx = 2
	end

	local checkOther = false

	for k, v in pairs(jobAgeList) do
		if v and checknumber(k) == PetFilterMgr.JOB_AGE_OTHER_INDEX then
			checkOther = true
		end
	end

	local isAge = ItemFilter.checkIsMatch(jobAgeList, firstJobIdx) or ItemFilter.checkIsMatch(jobAgeList, secondJobIdx) or ItemFilter.checkIsMatch(jobAgeList, thirdJobIdx)

	if checkOther == true then
		isAge = isAge or not ItemFilter.checkIsMatch(PetFilterMgr.JOB_ALL_AGE_LIST, firstJobIdx) and not ItemFilter.checkIsMatch(PetFilterMgr.JOB_ALL_AGE_LIST, secondJobIdx) and not ItemFilter.checkIsMatch(PetFilterMgr.JOB_ALL_AGE_LIST, thirdJobIdx)
	end

	return hasSkillLabel and isAge and ItemFilter.checkIsMatch(rareList, rare) and ItemFilter.checkIsMatch(raceList, racdIdx) and (ItemFilter.checkIsMatch(jobList, firstJobIdx) or ItemFilter.checkIsMatch(jobList, secondJobIdx) or ItemFilter.checkIsMatch(jobList, thirdJobIdx)) and ItemFilter.checkIsMatch(atkList, careerClassify) and ItemFilter.checkIsMatch(data.posSelectList, posIdx)
end

function PetFilterMgr:resetDataByType(type)
	local data = self:getFilterData(type)

	self:resetData(data)
end

function PetFilterMgr:resetData(data)
	if data then
		data.rareSelectList = data.rareSelectList or {}
		data.rareActiveList = data.rareActiveList or {}
		data.rareClickAble = data.rareClickAble or {}
		data.raceSelectList = data.raceSelectList or {}
		data.raceActiveList = data.raceActiveList or {}
		data.raceClickAble = data.raceClickAble or {}
		data.jobAgeSelectList = data.jobAgeSelectList or {}
		data.jobAgeActiveList = data.jobAgeActiveList or {}
		data.jobAgeClickAble = data.jobAgeClickAble or {}
		data.jobSelectList = data.jobSelectList or {}
		data.jobActiveList = data.jobActiveList or {}
		data.jobClickAble = data.jobClickAble or {}
		data.atkSelectList = data.atkSelectList or {}
		data.atkActiveList = data.atkActiveList or {}
		data.atkClickAble = data.atkClickAble or {}
		data.defenceSelectList = data.defenceSelectList or {}
		data.defenceActiveList = data.defenceActiveList or {}
		data.defenceClickAble = data.defenceClickAble or {}
		data.skillSelectList = data.skillSelectList or {}
		data.skillActiveList = data.skillActiveList or {}
		data.skillClickAble = data.skillClickAble or {}
		data.posSelectList = data.posSelectList or {}
		data.posActiveList = data.posActiveList or {}
		data.posClickAble = data.posClickAble or {}

		for i = 1, 4 do
			data.rareSelectList[i] = false
			data.rareActiveList[i] = true
			data.rareClickAble[i] = true
		end

		for i = 1, 8 do
			data.raceSelectList[i] = false
			data.raceActiveList[i] = true
			data.raceClickAble[i] = true
		end

		for i = 1, PetFilterMgr.JOB_AGE_OTHER_INDEX do
			data.jobAgeSelectList[i] = false
			data.jobAgeActiveList[i] = true
			data.jobAgeClickAble[i] = true
		end

		for i = 1, PetFilterMgr.MAX_PET_JOB_INDEX do
			data.jobSelectList[i] = false
			data.jobActiveList[i] = true
			data.jobClickAble[i] = true
		end

		for i = 1, 2 do
			data.atkSelectList[i] = false
			data.atkActiveList[i] = true
			data.atkClickAble[i] = true
		end

		for i = 3, 4 do
			data.defenceSelectList[i] = false
			data.defenceActiveList[i] = true
			data.defenceClickAble[i] = true
		end

		for i = 1, 20 do
			data.skillSelectList[i] = false
			data.skillActiveList[i] = true
			data.skillClickAble[i] = true
		end

		for i = 1, 2 do
			data.posSelectList[i] = false
			data.posActiveList[i] = true
			data.posClickAble[i] = true
		end
	end

	return data
end

function PetFilterMgr:getFilterData(type)
	self.all_filter_list = self.all_filter_list or {}

	if self.all_filter_list[type] == nil then
		local data = {}

		self:resetData(data)

		self.all_filter_list[type] = data
	end

	return self.all_filter_list[type]
end

function PetFilterMgr:resetAll()
	self.all_filter_list = {}
end

PetFilterMgr.instance = PetFilterMgr.New()

return PetFilterMgr
