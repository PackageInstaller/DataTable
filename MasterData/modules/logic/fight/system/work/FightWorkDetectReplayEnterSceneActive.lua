-- chunkname: @modules/logic/fight/system/work/FightWorkDetectReplayEnterSceneActive.lua

module("modules.logic.fight.system.work.FightWorkDetectReplayEnterSceneActive", package.seeall)

local FightWorkDetectReplayEnterSceneActive = class("FightWorkDetectReplayEnterSceneActive", BaseWork)

function FightWorkDetectReplayEnterSceneActive:onStart()
	if FightDataHelper.stateMgr.isReplay then
		local battleId = FightModel.instance:getBattleId()
		local config = lua_fight_replay_enter_scene_root_active.configDict[battleId]

		if config then
			config = config[FightModel.instance:getCurWaveId()]

			if config then
				local fightScene = GameSceneMgr.instance:getCurScene()

				if fightScene then
					local sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()

					if sceneObj then
						local childCount = sceneObj.transform.childCount

						for i = 0, childCount - 1 do
							local childItem = sceneObj.transform:GetChild(i)

							gohelper.setActive(childItem.gameObject, childItem.name == config.activeRootName)
						end
					end

					if not string.nilorempty(config.switch) then
						FightGameMgr.bgmMgr._cur_switch = config.switch

						FightGameMgr.bgmMgr:_switchMonsterGroup()
					end
				end
			end
		end
	end

	self:onDone(true)
end

function FightWorkDetectReplayEnterSceneActive:clearWork()
	return
end

return FightWorkDetectReplayEnterSceneActive
