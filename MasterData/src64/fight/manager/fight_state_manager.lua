local var_0_0 = _G
local var_0_3 = math
local var_0_4 = table
local var_0_9 = pairs
local var_0_13 = FIGHTSTATE_SEARCHING
local var_0_14 = FIGHTSTATE_PREFIGHTING
local var_0_15 = FIGHTSTATE_FAIL
local var_0_16 = FIGHTSTATE_SUCCESS
local var_0_17 = FIGHTSTATE_PASS_LEVEL
local var_0_18 = FIGHTSTATE_SEARCHING
local var_0_19 = FIGHTSTATE_PREFIGHTING
local var_0_20 = FIGHTSTATE_FIGHTING
local var_0_21 = FIGHTSTATE_ENDFIGHT
local var_0_22 = FIGHTSTATE_FAIL
local var_0_23 = FIGHTSTATE_SUCCESS
local var_0_24 = FIGHTSTATE_NEXT
local var_0_25 = FIGHTSTATE_WAIT
local var_0_26 = FIGHTSTATE_PASS_LEVEL
local var_0_27 = FIGHTSTATE_REFRESH
local var_0_28 = FIGHTSTATE_NEXT_CHAPTER
local var_0_29 = STATE_ENDFIGHT
local var_0_30 = STATE_DIED
local var_0_31 = STATE_FIGHTWIN
local var_0_32 = STATE_REVIVAL
local var_0_33 = STATE_SEARCHING
local var_0_34 = STATE_PREFIGHTING
local var_0_37 = STATE_DIED
local var_0_42 = FIGHTTYPE_NORMAL
local var_0_43 = FIGHTTYPE_ADVENTURE
local var_0_44 = FIGHTTYPE_ADVENTURE_TOWER
local var_0_45 = FIGHTTYPE_ARENA
local var_0_46 = FIGHTTYPE_LAB
local var_0_47 = FIGHTTYPE_EXPLORE
local var_0_48 = FIGHTTYPE_SCOREARENA
local var_0_50 = FIGHTTYPE_AIATTACK
local var_0_51 = FIGHTTYPE_SUBSTITUTION_OLD
local var_0_53 = FIGHTTYPE_TOWER
local var_0_54 = FIGHTTYPE_FRIENDFIGHT
local var_0_55 = FIGHTTYPE_STAKE_PVP
local var_0_56 = FIGHTTYPE_STAKE_PVE
local var_0_57 = FIGHTTYPE_EXPEDITION
local var_0_58 = FIGHTTYPE_EXPEDITION_TOWER
local var_0_59 = FIGHTTYPE_EXPEDITION_MONOPOLY
local var_0_60 = FIGHTTYPE_MONOPOLY
local var_0_61 = FIGHTTYPE_ROGUEEXPLORE
local var_0_62 = FIGHTTYPE_GROUPFIGHT
local var_0_63 = FIGHTTYPE_FLYCHESS
local var_0_64 = FIGHTTYPE_WORLDBOSS
local playermodel = require("model.playermodel")
local xp_effect_manager = require("fight.xp.xp_effect_manager")
local aiattack_manager = require("controller.aiattack_manager")
local tower_defence_manager = require("controller.tower_defence_manager")
local expedition_manager = require("controller.expedition_manager")

return function(arg_1_0)
	return setfenv(function()
		local var_2_0 = {
			[var_0_42] = true,
			[var_0_43] = true,
			[var_0_44] = true,
			[var_0_45] = true,
			[var_0_46] = true,
			[var_0_47] = true,
			[var_0_48] = true,
			[var_0_54] = true,
			[var_0_55] = true,
			[var_0_56] = true,
			[var_0_60] = true,
			[var_0_51] = true,
			[var_0_61] = true,
			[var_0_62] = true,
			[var_0_63] = true,
			[var_0_64] = true
		}

		FightStatus = var_0_13

		function setFightState(arg_3_0)
			FightStatus = arg_3_0
		end

		function getFightState()
			return FightStatus
		end

		setFightStatus = setFightState
		getFightStatus = getFightState

		local function var_2_1()
			for iter_5_0, iter_5_1 in var_0_9(enemies) do
				clearHalo(iter_5_1.index)
				iter_5_1:removeFromParent()

				enemies[iter_5_0] = nil
			end

			charactersCount.enemiesCount = 17
			bossDie = false
		end

		local function var_2_2()
			for iter_6_0, iter_6_1 in var_0_9(players) do
				clearHalo(iter_6_1.index)
				iter_6_1:removeFromParent()

				players[iter_6_0] = nil
			end

			charactersCount.playersCount = 17
		end

		local function var_2_3()
			for iter_7_0, iter_7_1 in var_0_9(bullets) do
				iter_7_1:destroy()
			end

			bullets = {}
		end

		local function var_2_4()
			playerOnUpdate = false
			playerOnChangeComponent = false
			playerOnUpdateHorcrux = false
			playerOnReplaceWeapon = false
			playerOnWeaponSkill = false
			playerOnSkillUpdate = false
		end

		local function var_2_5()
			if playerOnUpdate then
				updatePlayers()
			end

			if playerOnChangeComponent then
				changePlayerComponent()
			end

			if playerOnUpdateHorcrux then
				changePlayerHorcrux()
			end

			if playerOnReplaceWeapon then
				changePlayerWeapon()
			elseif playerOnWeaponSkill then
				changePlayerWeaponSkill()
			end

			if playerOnSkillUpdate then
				updatePlayerSkillLevel()
			end

			var_2_4()
		end

		local function var_2_6()
			if fighttype == var_0_50 or fighttype == var_0_53 or fighttype == var_0_58 then
				setFightStatus(var_0_14)

				return
			end

			local var_10_0 = 0

			for iter_10_0, iter_10_1 in var_0_9(players) do
				if iter_10_1:getStatus() ~= var_0_37 then
					if iter_10_1:getStatus() == var_0_33 and iter_10_1:getDistance() >= search_enemy_distance then
						setFightStatus(var_0_14)
					end

					var_10_0 = var_10_0 + 1
				end
			end

			if var_10_0 <= 0 then
				setFightStatus(var_0_22)
			end
		end

		local var_2_7 = false

		local function var_2_8()
			local var_11_0 = true

			for iter_11_0, iter_11_1 in var_0_9(players) do
				if iter_11_1:getStatus() ~= var_0_37 and iter_11_1:getStatus() ~= var_0_33 then
					var_11_0 = false

					break
				end
			end

			if var_11_0 then
				enemiesAppear()

				for iter_11_2, iter_11_3 in var_0_9(players) do
					if iter_11_3:getStatus() ~= var_0_37 then
						iter_11_3:setStatus(var_0_34)
					end
				end

				setFightStatus(var_0_20)
				updateStatisticsModel()
				resetFightTimeStatistics()

				if isPVPFight() then
					resetPlayerCDOnPVP()
				end

				if fighttype == var_0_53 and not var_0_0.GuideListener.isGuideFinish(var_0_0.TRIGGER_FIGHT, 211) then
					fightconsoleRef.towerDefencePanel:setGlobalTouchLock(true)
					getCamera().scanFightWorldMap(function()
						fightconsoleRef.towerDefencePanel:setGlobalTouchLock(false)
						var_0_0.GuideListener.triggerGuideTowerFight(211, fightconsoleRef.playerItems[1])
					end)
				elseif fighttype == var_0_58 and not var_0_0.GuideListener.isGuideFinish(var_0_0.TRIGGER_FIGHT, 211) then
					fightconsoleRef.expeditionTowerPanel:setGlobalTouchLock(true)
					getCamera().scanFightWorldMap(function()
						fightconsoleRef.expeditionTowerPanel:setGlobalTouchLock(false)
						var_0_0.GuideListener.triggerGuideTowerFight(211, fightconsoleRef.playerItems[1])
					end)
				end

				var_2_7 = true
			end
		end

		local function var_2_9(arg_14_0)
			if var_2_7 then
				triggerOnFightBeginFirst()
				triggerOnFightBegin()

				var_2_7 = false
			end

			var_0_0.global_gold_drop_timer = var_0_0.global_gold_drop_timer - arg_14_0

			if not xp_effect_manager.isXPNow() then
				updateFightTimeStatistics(arg_14_0)
			end

			if fighttype == var_0_50 then
				if charactersCount.playersCount <= 17 and aiattack_manager:isNoHaveAI() then
					setFightStatus(var_0_21)
				elseif charactersCount.enemiesCount <= 17 or bossDie then
					setFightStatus(var_0_21)
				end
			elseif fighttype == var_0_53 or fighttype == var_0_58 then
				if not xp_effect_manager.isXPNow() then
					updateEnemyAppear(arg_14_0)
				end

				if fighttype == var_0_53 and tower_defence_manager:isBossDie() then
					setFightStatus(var_0_21)
				elseif fighttype == var_0_58 and expedition_manager:isBossDie() then
					setFightStatus(var_0_21)
				end
			elseif charactersCount.playersCount <= 17 then
				setFightStatus(var_0_21)
			elseif charactersCount.enemiesCount <= 17 or bossDie then
				setFightStatus(var_0_21)
			end

			if FightStatus == var_0_20 and var_2_0[fighttype] then
				local var_14_0 = getFightTimeStatistics()

				if fighttype == var_0_51 or var_0_64 then
					if var_14_0 >= 180 then
						fightSurrender()
					end
				elseif var_14_0 >= 150 then
					fightSurrender()
				end
			end
		end

		local function var_2_10()
			if fighttype == var_0_53 then
				if tower_defence_manager:isBossDie("player") then
					setFightStatus(var_0_15)
				elseif tower_defence_manager:isBossDie("enemy") then
					setFightState(var_0_17)
				end
			elseif fighttype == var_0_58 then
				if expedition_manager:isBossDie("player") then
					setFightStatus(var_0_15)
				elseif expedition_manager:isBossDie("enemy") then
					setFightState(var_0_17)
				end
			elseif charactersCount.playersCount <= 17 then
				setFightState(var_0_15)
			elseif charactersCount.enemiesCount <= 17 or bossDie then
				if not isNormalFight() then
					var_2_4()
					setFightState(var_0_17)
				else
					var_2_5()

					if charactersCount.playersCount <= 17 then
						setFightState(var_0_15)
					elseif isFightingBoss() then
						setFightState(var_0_17)
					else
						setFightState(var_0_16)
					end
				end
			end
		end

		local function var_2_11()
			for iter_16_0, iter_16_1 in var_0_9(enemies) do
				if iter_16_1:getState() ~= var_0_30 then
					iter_16_1:monsterDestroy()
				end

				character_garbage[#character_garbage + 1] = iter_16_1
				enemies[iter_16_0] = nil
			end

			bossDie = false

			local var_16_0 = 0

			for iter_16_2, iter_16_3 in var_0_9(players) do
				if iter_16_3:getState() ~= var_0_30 then
					if iter_16_3:getState() ~= var_0_32 then
						iter_16_3:setState(var_0_29)
					end

					var_16_0 = var_16_0 + 1
				end
			end

			if var_16_0 > 0 then
				onNormalFightSuccess()
			else
				setFightState(var_0_15)
			end
		end

		local function var_2_12(arg_17_0)
			local var_17_0 = {}

			if fighttype == var_0_57 or fighttype == var_0_59 then
				for iter_17_0, iter_17_1 in var_0_9(players) do
					if iter_17_1.model.servantid then
						local var_17_1 = iter_17_1.model:getAttribute("curhp") / iter_17_1.model:getAttribute("hp") * 100
						local var_17_2 = getPlayerItem(iter_17_0)

						var_0_4.insert(var_17_0, {
							servantid = iter_17_1.model.servantid,
							bloodpercent = arg_17_0 == 1 and var_17_1 or 0,
							energypercent = var_17_2:getXPPercent()
						})
					end
				end
			elseif fighttype == var_0_58 then
				local var_17_3 = #expedition_manager:getCurLevelInfo().baseConfig[1]

				for iter_17_2, iter_17_3 in var_0_9(players) do
					if not iter_17_3:isBoss() then
						local var_17_4 = iter_17_3.model

						if iter_17_3.model.servantid then
							local var_17_5 = var_17_4:getAttribute("curhp") / var_17_4:getAttribute("hp") * 100

							var_0_4.insert(var_17_0, {
								servantid = var_17_4.servantid,
								bloodpercent = arg_17_0 == 1 and var_17_5 or 0,
								energypercent = var_0_3.floor(iter_17_3:getRagePercent() * 100)
							})
						end
					end
				end
			end

			return var_17_0
		end

		local function var_2_13(arg_18_0)
			local var_18_0 = {}

			if fighttype == var_0_57 then
				for iter_18_0, iter_18_1 in var_0_9(enemies) do
					local var_18_1 = getPlayerItem(iter_18_0)

					var_0_4.insert(var_18_0, {
						monsterid = iter_18_1.model.monsterid,
						bloodpercent = iter_18_1.model:getAttribute("curhp") / iter_18_1.model:getAttribute("hp") * 100,
						energypercent = var_18_1:getXPPercent()
					})
				end
			elseif fighttype == var_0_58 then
				for iter_18_2, iter_18_3 in var_0_9(enemies) do
					if not iter_18_3:isBoss() then
						var_0_4.insert(var_18_0, {
							monsterid = iter_18_3.model.monsterid,
							bloodpercent = iter_18_3.model:getAttribute("curhp") / iter_18_3.model:getAttribute("hp") * 100
						})
					end
				end
			elseif fighttype == var_0_59 then
				if arg_18_0 == 2 then
					if var_0_0.require("controller.expedition_manager"):isEndlessMode() == false then
						for iter_18_4, iter_18_5 in var_0_9(enemies) do
							local var_18_2 = getPlayerItem(iter_18_4)

							var_0_4.insert(var_18_0, {
								monsterid = iter_18_5.model.monsterid,
								bloodpercent = var_0_3.max(iter_18_5.bloodpercent - 25, 0),
								energypercent = var_18_2:getXPPercent()
							})
						end

						goto label_18_0
					end
				end

				for iter_18_6, iter_18_7 in var_0_9(enemies) do
					local var_18_3 = getPlayerItem(iter_18_6)

					var_0_4.insert(var_18_0, {
						monsterid = iter_18_7.model.monsterid,
						bloodpercent = iter_18_7.model:getAttribute("curhp") / iter_18_7.model:getAttribute("hp") * 100,
						energypercent = var_18_3:getXPPercent()
					})
				end
			end

			::label_18_0::

			return var_18_0
		end

		local function var_2_14()
			if fighttype == var_0_57 then
				var_0_0.require("controller.expedition_manager"):updateTeamList(var_2_12(0))
				var_0_0.require("controller.expedition_manager"):updateEnemyList(var_2_13())
			elseif fighttype == var_0_59 then
				var_0_0.require("controller.expedition_manager"):updateEnemyList(var_2_13())
			end

			var_2_1()
			var_2_2()
			var_2_3()

			charactersCount = {
				enemiesCount = 17,
				playersCount = 17
			}

			xp_effect_manager.removeXP()
			onFightFail[fighttype]()
		end

		local function var_2_15()
			for iter_20_0, iter_20_1 in var_0_9(enemies) do
				if iter_20_1:getState() ~= var_0_30 then
					iter_20_1:monsterDestroy()
				end

				character_garbage[#character_garbage + 1] = iter_20_1
				enemies[iter_20_0] = nil
			end

			bossDie = false

			for iter_20_2, iter_20_3 in var_0_9(players) do
				if iter_20_3:getState() ~= var_0_30 and iter_20_3:getState() ~= var_0_32 then
					iter_20_3:setState(var_0_31)
				end
			end

			if fighttype == var_0_57 or fighttype == var_0_58 then
				var_0_0.require("controller.expedition_manager"):updateTeamList(var_2_12(1))
				var_0_0.require("controller.expedition_manager"):updateEnemyList(var_2_13())
			end

			onFightSuccess[fighttype]()
		end

		local function var_2_16()
			error("FIGHTSTATE_NEXTLEVEL is Deprecated!!!!")
		end

		local function var_2_17()
			var_2_1()
			var_2_2()
			var_2_3()

			charactersCount = {
				enemiesCount = 17,
				playersCount = 17
			}

			xp_effect_manager.removeXP()

			if fighttype == var_0_53 then
				tower_defence_manager:refreshTowerFight()
			elseif fighttype == var_0_58 then
				var_0_0.require("controller.expedition_manager"):refreshExpeditionTowerFight()
			end

			onFightRefresh()
		end

		local function var_2_18()
			for iter_23_0, iter_23_1 in var_0_9(enemies) do
				clearHalo(iter_23_1.index)
				iter_23_1:removeFromParent()

				enemies[iter_23_0] = nil
			end

			charactersCount.enemiesCount = 17
			bossDie = false

			for iter_23_2, iter_23_3 in var_0_9(players) do
				clearHalo(iter_23_3.index)
				iter_23_3:removeFromParent()

				players[iter_23_2] = nil
			end

			charactersCount.playersCount = 17
			charactersCount = {
				enemiesCount = 17,
				playersCount = 17
			}

			for iter_23_4, iter_23_5 in var_0_9(bullets) do
				iter_23_5:destroy()
			end

			bullets = {}

			xp_effect_manager.removeXP()
			battlefieldRef:gotoNextChapter()
		end

		function updateFightStatus(arg_24_0)
			if FightStatus == var_0_18 then
				var_2_6()
			elseif FightStatus == var_0_19 then
				var_2_8()
			elseif FightStatus == var_0_20 then
				var_2_9(arg_24_0)
			elseif FightStatus == var_0_21 then
				var_2_10()
			elseif FightStatus == var_0_23 then
				var_2_11()
			elseif FightStatus == var_0_22 then
				var_2_14()
			elseif FightStatus == var_0_26 then
				var_2_15()
			elseif FightStatus == var_0_24 then
				var_2_16()
			elseif FightStatus == var_0_27 then
				var_2_17()
			elseif FightStatus == var_0_28 then
				var_2_18()
			elseif FightStatus == var_0_25 then
				return
			end
		end

		function fightSurrender()
			if FightStatus ~= var_0_20 then
				return
			end

			if fighttype == var_0_0.FIGHTTYPE_GUIDE then
				return
			end

			var_2_1()
			var_2_2()
			var_2_3()

			charactersCount = {
				enemiesCount = 17,
				playersCount = 17
			}

			xp_effect_manager.removeXP()
			onFightFail[fighttype](true)
		end

		function fightFailExtern()
			if FightStatus ~= var_0_20 then
				return
			end

			var_2_1()
			var_2_2()
			var_2_3()

			charactersCount = {
				enemiesCount = 17,
				playersCount = 17
			}

			xp_effect_manager.removeXP()
			onFightFail[fighttype]()
		end

		function fightEndExtern(arg_27_0)
			if FightStatus ~= var_0_20 then
				return
			end

			if fighttype == var_0_0.FIGHTTYPE_EXPEDITION_MONOPOLY then
				pauseBattleField()
				var_0_0.require("controller.expedition_manager"):updateTeamList(var_2_12(1))
				var_0_0.require("controller.expedition_manager"):updateEnemyList(var_2_13(arg_27_0))
				onFightSuccess[fighttype](arg_27_0)
			else
				var_2_1()
				var_2_2()
				var_2_3()

				charactersCount = {
					enemiesCount = 17,
					playersCount = 17
				}

				xp_effect_manager.removeXP()
				onFightFail[fighttype]()
			end
		end

		function refreshAtOnce(arg_28_0)
			var_2_1()
			var_2_2()
			var_2_3()

			charactersCount = {
				enemiesCount = 17,
				playersCount = 17
			}

			xp_effect_manager.removeXP()
			onFightRefresh(arg_28_0)
		end

		function removeAllElements()
			var_2_1()
			var_2_2()
			var_2_3()

			charactersCount = {
				enemiesCount = 17,
				playersCount = 17
			}

			xp_effect_manager.removeXP()
		end

		function triggerOnFightBegin()
			for iter_30_0, iter_30_1 in var_0_9(players) do
				iter_30_1.triggerStatus(iter_30_1, "onFightBegin", iter_30_1)
			end

			for iter_30_2, iter_30_3 in var_0_9(enemies) do
				iter_30_3.triggerStatus(iter_30_3, "onFightBegin", iter_30_3)
			end
		end

		function triggerOnFightBeginFirst()
			for iter_31_0, iter_31_1 in var_0_9(players) do
				iter_31_1.triggerStatus(iter_31_1, "onFightBeginFirst", iter_31_1)
			end

			for iter_31_2, iter_31_3 in var_0_9(enemies) do
				iter_31_3.triggerStatus(iter_31_3, "onFightBeginFirst", iter_31_3)
			end
		end

		function resetPlayerCDOnPVP()
			for iter_32_0, iter_32_1 in var_0_9(players) do
				iter_32_1:resetAllCD()
			end
		end

		function refreshFight()
			doResetFightTimeEnabled(true)
			setFightState(var_0_27)
		end
	end, arg_1_0)
end
