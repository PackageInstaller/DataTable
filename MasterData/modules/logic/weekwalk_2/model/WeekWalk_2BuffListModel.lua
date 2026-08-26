-- chunkname: @modules/logic/weekwalk_2/model/WeekWalk_2BuffListModel.lua

module("modules.logic.weekwalk_2.model.WeekWalk_2BuffListModel", package.seeall)

local WeekWalk_2BuffListModel = class("WeekWalk_2BuffListModel", ListScrollModel)

function WeekWalk_2BuffListModel.getPrevBattleSkillId()
	local mapInfo = WeekWalk_2Model.instance:getCurMapInfo()
	local battleId = HeroGroupModel.instance.battleId
	local battleInfo = mapInfo:getBattleInfoByBattleId(battleId)
	local prevBattleInfo = mapInfo:getBattleInfo(battleInfo.index - 1)

	return prevBattleInfo and prevBattleInfo:getChooseSkillId()
end

function WeekWalk_2BuffListModel.getCurHeroGroupSkillId()
	local skillId = WeekWalk_2BuffListModel._getCurHeroGroupSkillId()

	if skillId then
		local mapInfo = WeekWalk_2Model.instance:getCurMapInfo()
		local num = mapInfo:getChooseSkillNum()
		local info = WeekWalk_2Model.instance:getInfo()
		local skillList = info:getOptionSkills()
		local index = tabletool.indexOf(skillList, skillId)

		if not index or num < index then
			skillId = nil
		end
	end

	return skillId
end

function WeekWalk_2BuffListModel._getCurHeroGroupSkillId()
	local info = WeekWalk_2Model.instance:getInfo()
	local skillId = info and info:getHeroGroupSkill(HeroGroupModel.instance.curGroupSelectIndex)
	local prevSkillId = WeekWalk_2BuffListModel.getPrevBattleSkillId()

	return skillId ~= prevSkillId and skillId or nil
end

function WeekWalk_2BuffListModel:initBuffList(isBattle)
	local timeId = WeekWalk_2Model.instance:getTimeId()
	local timeConfig = lua_weekwalk_ver2_time.configDict[timeId]
	local skillList = string.split(timeConfig.optionalSkills, "#")
	local num = #skillList

	if isBattle then
		local mapInfo = WeekWalk_2Model.instance:getCurMapInfo()

		num = mapInfo:getChooseSkillNum()
	end

	local list = {}

	for i, id in ipairs(skillList) do
		local skillId = tonumber(id)

		if i <= num then
			local skillConfig = lua_weekwalk_ver2_skill.configDict[skillId]

			if skillConfig then
				table.insert(list, skillConfig)
			end
		else
			break
		end
	end

	self.prevBattleSkillId = nil
	self.isBattle = isBattle

	local selectedIndex = 1

	if isBattle then
		self.prevBattleSkillId = WeekWalk_2BuffListModel.getPrevBattleSkillId()

		local selectedSkillId = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()

		if self.prevBattleSkillId then
			for i, v in ipairs(list) do
				if self.prevBattleSkillId == v.id then
					table.remove(list, i)
					table.insert(list, v)

					break
				end
			end
		end

		for i, v in ipairs(list) do
			if selectedSkillId == v.id then
				selectedIndex = i

				break
			end
		end
	end

	self:setList(list)
	self:selectCell(selectedIndex, true)
end

WeekWalk_2BuffListModel.instance = WeekWalk_2BuffListModel.New()

return WeekWalk_2BuffListModel
