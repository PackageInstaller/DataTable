-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventChangeScene.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventChangeScene", package.seeall)

local FightTLEventChangeScene = class("FightTLEventChangeScene", FightTimelineTrackItem)

function FightTLEventChangeScene:onTrackStart(fightStepData, duration, paramsArr)
	if not string.nilorempty(paramsArr[1]) then
		local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)

		FightGameMgr.sceneLevelMgr:loadScene(nil, tonumber(paramsArr[1]))
	end

	if not string.nilorempty(paramsArr[2]) then
		local arr = string.split(paramsArr[2], "|")

		FightDataHelper.tempMgr.monsterPosList = {}

		for _, v in ipairs(arr) do
			local list = string.splitToNumber(v, ",")

			table.insert(FightDataHelper.tempMgr.monsterPosList, list)
		end
	end

	if not string.nilorempty(paramsArr[3]) then
		local rgb = string.splitToNumber(paramsArr[3], "#")

		FightGameMgr.spineColorBySceneMgr._spineColor = Color.New(rgb[1], rgb[2], rgb[3], 1)

		FightGameMgr.spineColorBySceneMgr:_setAllSpineColor()
	end
end

function FightTLEventChangeScene:onTrackEnd()
	return
end

return FightTLEventChangeScene
