-- chunkname: @modules/logic/seasonver/act166/utils/Season166HeroGroupUtils.lua

module("modules.logic.seasonver.act166.utils.Season166HeroGroupUtils", package.seeall)

local Season166HeroGroupUtils = class("Season166HeroGroupUtils")

function Season166HeroGroupUtils.buildSnapshotHeroGroups(snapshots)
	local list = {}
	local snapshotsTab = #snapshots == 0 and {
		snapshots
	} or snapshots

	for _, v in ipairs(snapshotsTab) do
		local snapMo = Season166HeroGroupMO.New()
		local isEmpty = v.heroList == nil or #v.heroList <= 0

		if isEmpty then
			if not Season166HeroGroupUtils.checkFirstCopyHeroGroup(v, snapMo) then
				Season166HeroGroupUtils.createEmptyGroup(v, snapMo)

				list[snapMo.groupId] = snapMo
			end
		else
			snapMo:init(v)

			list[v.groupId] = snapMo
		end
	end

	table.sort(list, function(a, b)
		return a.groupId < b.groupId
	end)

	return list
end

function Season166HeroGroupUtils.checkFirstCopyHeroGroup(snapshot, snapMo)
	if snapshot.groupId == 1 then
		local mainHeroGroupMo = Season166HeroGroupModel.instance:getById(1)

		if mainHeroGroupMo then
			snapMo.id = snapshot.groupId
			snapMo.groupId = snapshot.groupId
			snapMo.name = mainHeroGroupMo.name
			snapMo.heroList = {}

			for i = 1, Season166Enum.MaxHeroCount do
				table.insert(snapMo.heroList, Season166Enum.EmptyUid)
			end

			snapMo.aidDict = LuaUtil.deepCopy(mainHeroGroupMo.aidDict)
			snapMo.clothId = mainHeroGroupMo.clothId
			snapMo.equips = LuaUtil.deepCopy(mainHeroGroupMo.equips)

			return true
		end
	end

	return false
end

function Season166HeroGroupUtils.createEmptyGroup(snapshot, snapMo)
	local mainHeroGroupMo = Season166HeroGroupModel.instance:getById(1)

	snapMo.id = snapshot.groupId or 1
	snapMo.groupId = snapshot.groupId or 1
	snapMo.name = ""
	snapMo.heroList = {}

	for i = 1, Season166Enum.MaxHeroCount do
		table.insert(snapMo.heroList, Season166Enum.EmptyUid)
	end

	if mainHeroGroupMo then
		snapMo.clothId = mainHeroGroupMo.clothId
	end

	snapMo.equips = {}

	local maxHeroCount = Season166Enum.MaxHeroCount

	for i = 0, maxHeroCount - 1 do
		local equipMo = HeroGroupEquipMO.New()

		equipMo:init({
			index = i,
			equipUid = {
				Season166Enum.EmptyUid
			}
		})

		snapMo.equips[i] = equipMo
	end
end

function Season166HeroGroupUtils.buildFightGroupAssistHero(heroGroupType, fightGroup)
	if heroGroupType == ModuleEnum.HeroGroupType.Season166Train then
		local assistMO = Season166HeroSingleGroupModel.instance.assistMO

		if assistMO and tonumber(assistMO.pickAssistHeroMO.heroUid) ~= 0 then
			fightGroup.assistUserId = assistMO.userId
			fightGroup.assistHeroUid = assistMO.pickAssistHeroMO.heroUid
		end
	end
end

return Season166HeroGroupUtils
