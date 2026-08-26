-- chunkname: @modules/logic/weekwalk/model/WeekWalkCardListModel.lua

module("modules.logic.weekwalk.model.WeekWalkCardListModel", package.seeall)

local WeekWalkCardListModel = class("WeekWalkCardListModel", ListScrollModel)

function WeekWalkCardListModel:verifyCondition(buffId)
	local _buffId = buffId
	local _buffConfig = lua_weekwalk_buff.configDict[_buffId]
	local _prayId = tonumber(_buffConfig.param)
	local _prayConfig = lua_weekwalk_pray.configDict[_prayId]
	local _sacrificeLimitLevel = 0
	local _sacrificeLimitCareer = 0
	local _sacrificeLimitHeroId = 0
	local limitList = GameUtil.splitString2(_prayConfig.sacrificeLimit, true, "|", "#")

	if limitList then
		for i, v in ipairs(limitList) do
			local id = v[1]
			local value = v[2]

			if id == 1 then
				_sacrificeLimitCareer = value
			elseif id == 2 then
				_sacrificeLimitLevel = value
			elseif id == 3 then
				_sacrificeLimitHeroId = value
			end
		end
	end

	local _blessingLimit = _prayConfig.blessingLimit == "1"
	local hero1 = self:_verify(_sacrificeLimitCareer, _sacrificeLimitLevel, nil, nil, _sacrificeLimitHeroId)

	if not hero1 then
		GameFacade.showToast(ToastEnum.WeekWalkCardNoHero)

		return false
	end

	local limitCareer = _sacrificeLimitCareer

	if _sacrificeLimitHeroId ~= 0 then
		local heroConfig = HeroConfig.instance:getHeroCO(_sacrificeLimitHeroId)

		limitCareer = heroConfig.career
	end

	local careerLimit = _blessingLimit and limitCareer or 0
	local hero2 = self:_verify(careerLimit, 0, hero1, nil, 0)

	if not hero2 then
		GameFacade.showToast(ToastEnum.WeekWalkCardNoHero)

		return false
	end

	return true
end

function WeekWalkCardListModel:_verify(limitCareer, limitLevel, hero1, hero2, heroId)
	local list = HeroModel.instance:getList()
	local weekWalkInfo = WeekWalkModel.instance:getInfo()

	for i, v in ipairs(list) do
		if limitLevel <= v.level and (heroId == 0 or v.heroId == heroId) and weekWalkInfo:getHeroHp(v.heroId) > 0 and (limitCareer == 0 or limitCareer == v.config.career) and v ~= hero1 and v ~= hero2 then
			return v
		end
	end
end

function WeekWalkCardListModel:setCardList(limitCareer, limitLevel, hero1, hero2, heroId)
	local weekWalkInfo = WeekWalkModel.instance:getInfo()
	local result = self:getCardList(limitCareer, limitLevel, hero1, hero2, heroId)

	table.sort(result, function(a, b)
		local a_hp = weekWalkInfo:getHeroHp(a.heroId) <= 0 and 0 or 1
		local b_hp = weekWalkInfo:getHeroHp(b.heroId) <= 0 and 0 or 1

		if a_hp ~= b_hp then
			return b_hp < a_hp
		elseif a.level ~= b.level then
			return a.level > b.level
		elseif a.config.rare ~= b.config.rare then
			return a.config.rare > b.config.rare
		elseif a.createTime ~= b.createTime then
			return a.createTime <= b.createTime
		end

		return a.heroId > b.heroId
	end)
	self:setList(result)
end

function WeekWalkCardListModel:getCardList(limitCareer, limitLevel, hero1, hero2, heroId)
	local weekWalkInfo = WeekWalkModel.instance:getInfo()
	local list = HeroModel.instance:getList()
	local result = {}

	for i, v in ipairs(list) do
		if limitLevel <= v.level and (heroId == 0 or v.heroId == heroId) and weekWalkInfo:getHeroHp(v.heroId) > 0 and (limitCareer == 0 or limitCareer == v.config.career) and v ~= hero1 and v ~= hero2 then
			table.insert(result, v)
		end
	end

	return result
end

function WeekWalkCardListModel:setCharacterList(list)
	local weekWalkInfo = WeekWalkModel.instance:getInfo()
	local result = {}
	local deathList = {}

	for i, v in ipairs(list) do
		local hp = weekWalkInfo:getHeroHp(v.heroId)

		if hp <= 0 then
			table.insert(deathList, v)
		else
			table.insert(result, v)
		end
	end

	tabletool.addValues(result, deathList)
	self:setList(result)
end

WeekWalkCardListModel.instance = WeekWalkCardListModel.New()

return WeekWalkCardListModel
