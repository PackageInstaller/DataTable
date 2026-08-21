-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/util/PlayerCourseUtil.lua

module("logic.extensions.playerinfo.util.PlayerCourseUtil", package.seeall)

local PlayerCourseUtil = {}

function PlayerCourseUtil.sortChooseList(showList, editList, type)
	if type == GameEnum.DisplayTypeEnum.Hero then
		table.sort(showList, PlayerCourseUtil._otherEditSortFun)
		table.sort(editList, PlayerCourseUtil._heroEditSortFun)
	else
		table.sort(showList, PlayerCourseUtil._otherEditSortFun)
		table.sort(editList, PlayerCourseUtil._otherEditSortFun)
	end
end

function PlayerCourseUtil.sortDairy(list)
	table.sort(list, PlayerCourseUtil._diarySortFun)
end

function PlayerCourseUtil._heroEditSortFun(hero1, hero2)
	local res1, res2 = PlayerCourseUtil._otherEditSortFun(hero1, hero2)

	if not res2 then
		return res1
	end

	local item1 = hero1:getSortMo()
	local item2 = hero2:getSortMo()

	if not item1:getCharacterCo() then
		printError("检查角色表有不存在 id = ", item1:getId())

		return false
	end

	if not item2:getCharacterCo() then
		printError("检查角色表有不存在 id = ", item2:getId())

		return false
	end

	local config = HeroSortRuleConfig.instance:getTeamRule()
	local sort_vars = config[CommEnum.HeroSortFieldType.Default]

	for i, v in pairs(sort_vars) do
		local ret = false

		if i == 1 then
			ret = CharacterUtil._doCompareCommonDescending(item1, item2, v)
		else
			ret = CharacterUtil._doCompareCommonDescending(item1, item2, v)
		end

		if ret ~= -1 then
			return ret
		end
	end

	return false
end

function PlayerCourseUtil._otherEditSortFun(item1, item2)
	if item1.sortIndex then
		if item2.sortIndex then
			return item2.sortIndex > item1.sortIndex
		else
			return true
		end
	elseif item2.sortIndex then
		return false
	else
		return false, true
	end
end

function PlayerCourseUtil._diarySortFun(item1, item2)
	return item1.index < item2.index
end

return PlayerCourseUtil
