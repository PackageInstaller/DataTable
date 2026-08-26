-- chunkname: @modules/logic/fight/system/flow/FightStepBuilder.lua

module("modules.logic.fight.system.flow.FightStepBuilder", package.seeall)

local FightStepBuilder = class("FightStepBuilder")

FightStepBuilder.ActEffectWorkCls = {
	[FightEnum.EffectType.MISS] = FightWorkEffectMiss,
	[FightEnum.EffectType.DAMAGE] = FightWorkEffectDamage,
	[FightEnum.EffectType.CRIT] = FightWorkEffectDamage,
	[FightEnum.EffectType.HEAL] = FightWorkEffectHeal,
	[FightEnum.EffectType.HEALCRIT] = FightWorkEffectHeal,
	[FightEnum.EffectType.BUFFADD] = FightWorkStepBuff,
	[FightEnum.EffectType.BUFFDEL] = FightWorkStepBuff,
	[FightEnum.EffectType.BUFFUPDATE] = FightWorkStepBuff,
	[FightEnum.EffectType.BUFFDELNOEFFECT] = FightWorkStepBuff,
	[FightEnum.EffectType.DAMAGEFROMLOSTHP] = FightWorkDamageFromLostHp,
	[FightEnum.EffectType.ENCHANTBURNDAMAGE] = FightWorkEffectEnchantBurnDamage,
	[FightEnum.EffectType.DEAD] = FightWorkEffectDeadPerformance,
	[FightEnum.EffectType.BLOODLUST] = FightWorkEffectHeal,
	[FightEnum.EffectType.ADDACT] = FightWorkEffectAddAct,
	[FightEnum.EffectType.SHIELD] = FightWorkEffectShield,
	[FightEnum.EffectType.BEATBACK] = FightWorkEffectDamage,
	[FightEnum.EffectType.DAMAGEEXTRA] = FightWorkDamageExtra,
	[FightEnum.EffectType.SHIELDCHANGE] = FightWorkEffectShieldChange,
	[FightEnum.EffectType.UNIVERSALCARD] = FightWorkEffectUniversalCard,
	[FightEnum.EffectType.DEALCARD1] = FightWorkEffectDealCard1,
	[FightEnum.EffectType.DEALCARD2] = FightWorkEffectDistributeCard,
	[FightEnum.EffectType.ROUNDEND] = FightWorkEffectRoundEnd,
	[FightEnum.EffectType.SHIELDDEL] = FightWorkEffectShieldDel,
	[FightEnum.EffectType.MONSTERCHANGE] = FightWorkEffectMonsterChange,
	[FightEnum.EffectType.REDEALCARD] = FightWorkEffectRedealCard,
	[FightEnum.EffectType.CARDLEVELCHANGE] = FightWorkEffectCardLevelChange,
	[FightEnum.EffectType.EXTRAMOVEACT] = FightWorkEffectExtraMoveAct,
	[FightEnum.EffectType.CARDEFFECTCHANGE] = FightWorkEffectCardEffectChange,
	[FightEnum.EffectType.SUMMON] = FightWorkEffectSummon,
	[FightEnum.EffectType.SKILLWEIGHTSELECT] = FightWorkEffectDice,
	[FightEnum.EffectType.EXPOINTMAXADD] = FightWorkEffectExpointMaxAdd,
	[FightEnum.EffectType.CLEARUNIVERSALCARD] = FightWorkRemoveUnivesalCards,
	[FightEnum.EffectType.CARDDISAPPEAR] = FightWorkCardDisappear,
	[FightEnum.EffectType.MAXHPCHANGE] = FightWorkMaxHpChange,
	[FightEnum.EffectType.CURRENTHPCHANGE] = FightWorkCurrentHpChange,
	[FightEnum.EffectType.KILL] = FightWorkKill,
	[FightEnum.EffectType.EXPOINTCHANGE] = FightWorkExPointChange,
	[FightEnum.EffectType.EXSKILLPOINTCHANGE] = FightWorkExSkillPointChange,
	[FightEnum.EffectType.INDICATORCHANGE] = FightWorkIndicatorChange,
	[FightEnum.EffectType.MULTIHPCHANGE] = FightWorkMultiHpChange,
	[FightEnum.EffectType.SPCARDADD] = FightWorkSpCardAdd,
	[FightEnum.EffectType.TRIGGER] = FightWorkTrigger,
	[FightEnum.EffectType.POWERMAXADD] = FightWorkEffectPowerMaxAdd,
	[FightEnum.EffectType.POWERCHANGE] = FightWorkEffectPowerChange,
	[FightEnum.EffectType.ORIGINDAMAGE] = FightWorkOriginDamage,
	[FightEnum.EffectType.ORIGINCRIT] = FightWorkOriginCrit,
	[FightEnum.EffectType.SHIELDBROCKEN] = FightWorkEffectShieldBroken,
	[FightEnum.EffectType.CARDREMOVE] = FightWorkCardRemove,
	[FightEnum.EffectType.CARDREMOVE2] = FightWorkCardRemove2,
	[FightEnum.EffectType.SUMMONEDADD] = FightWorkSummonedAdd,
	[FightEnum.EffectType.SUMMONEDDELETE] = FightWorkSummonedDelete,
	[FightEnum.EffectType.SUMMONEDLEVELUP] = FightWorkSummonedLevelUp,
	[FightEnum.EffectType.MAGICCIRCLEADD] = FightWorkMagicCircleAdd,
	[FightEnum.EffectType.MAGICCIRCLEDELETE] = FightWorkMagicCircleDelete,
	[FightEnum.EffectType.MAGICCIRCLEUPDATE] = FightWorkMagicCircleUpdate,
	[FightEnum.EffectType.MAGICCIRCLEUPGRADE] = FightWorkMagicCircleUpgrade340,
	[FightEnum.EffectType.CHANGETOTEMPCARD] = FightWorkChangeToTempCard,
	[FightEnum.EffectType.MASTERPOWERCHANGE] = FightWorkMasterPowerChange,
	[FightEnum.EffectType.ADDHANDCARD] = FightWorkAddHandCard,
	[FightEnum.EffectType.REMOVEENTITYCARDS] = FightWorkRemoveEntityCards,
	[FightEnum.EffectType.CARDSCOMPOSE] = FightWorkCardsCompose,
	[FightEnum.EffectType.BFSGCONVERTCARD] = FightWorkBFSGConvertCard,
	[FightEnum.EffectType.BFSGUSECARD] = FightWorkBFSGUseCard,
	[FightEnum.EffectType.BFSGSKILLEND] = FightWorkBFSGSkillEnd,
	[FightEnum.EffectType.USECARDS] = FightWorkUseCards,
	[FightEnum.EffectType.CARDINVALID] = FightWorkCardInvalid,
	[FightEnum.EffectType.CARDSPUSH] = FightWorkCardsPush,
	[FightEnum.EffectType.BFSGSKILLSTART] = FightWorkBFSGSkillStart,
	[FightEnum.EffectType.CARDACONVERTCARDB] = FightWorkCardAConvertCardB,
	[FightEnum.EffectType.HEROUPGRADE] = FightWorkHeroUpgrade,
	[FightEnum.EffectType.NOTIFYUPGRADEHERO] = FightWorkNotifyUpgradeHero,
	[FightEnum.EffectType.ROUGEPOWERLIMITCHANGE] = FightWorkRougePowerLimitChange,
	[FightEnum.EffectType.ROUGEPOWERCHANGE] = FightWorkRougePowerChange,
	[FightEnum.EffectType.ROUGECOINCHANGE] = FightWorkRougeCoinChange,
	[FightEnum.EffectType.STORAGEINJURY] = FightWorkStorageInjury,
	[FightEnum.EffectType.DAMAGEFROMABSORB] = FightWorkDamageFromAbsorb,
	[FightEnum.EffectType.INJURYBANKHEAL] = FightWorkInjuryBankHeal,
	[FightEnum.EffectType.MASTERCARDREMOVE] = FightWorkMasterCardRemove,
	[FightEnum.EffectType.MASTERADDHANDCARD] = FightWorkMasterAddHandCard,
	[FightEnum.EffectType.FIGHTCOUNTER] = FightWorkFightCounter,
	[FightEnum.EffectType.CHANGECAREER] = FightWorkChangeCareer,
	[FightEnum.EffectType.POLARIZATIONLEVEL] = FightWorkPolarizationLevel,
	[FightEnum.EffectType.RESONANCELEVEL] = FightWorkResonanceLevel,
	[FightEnum.EffectType.MOVE] = FightWorkMove,
	[FightEnum.EffectType.MOVEFRONT] = FightWorkMoveFront,
	[FightEnum.EffectType.MOVEBACK] = FightWorkMoveBack,
	[FightEnum.EffectType.CHANGEROUND] = FightWorkChangeRound,
	[FightEnum.EffectType.FIGHTSTEP] = FightWorkFightStep,
	[FightEnum.EffectType.ADDUSECARD] = FightWorkAddUseCard,
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = FightWorkPlayAroundUpRank,
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = FightWorkPlayAroundDownRank,
	[FightEnum.EffectType.PLAYSETGRAY] = FightWorkPlaySetGray,
	[FightEnum.EffectType.EXPOINTOVERFLOWBANK] = FightWorkUpdateStoredExPoint,
	[FightEnum.EffectType.CHANGEHERO] = FightWorkChangeHero,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = FightWorkShieldValueChange,
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = FightWorkPlayChangeRankFail,
	[FightEnum.EffectType.STRESSTRIGGER] = FightWorkTriggerStress,
	[FightEnum.EffectType.RESISTANCES] = FightWorkTriggerResistance,
	[FightEnum.EffectType.ENTERFIGHTDEAL] = FightWorkEnterFightDeal,
	[FightEnum.EffectType.LAYERHALOSYNC] = FightWorkLayerHaloSync,
	[FightEnum.EffectType.SUBHEROLIFECHANGE] = FightWorkSubHeroLifeChange,
	[FightEnum.EffectType.GUARDCHANGE] = FightWorkGuardChange,
	[FightEnum.EffectType.ENTITYSYNC] = FightWorkEntitySync,
	[FightEnum.EffectType.NOTIFIYHEROCONTRACT] = FightWorkNotifyBindContract,
	[FightEnum.EffectType.SPEXPOINTMAXADD] = FightWorkEffectSpExpointMaxAdd,
	[FightEnum.EffectType.GUARDBREAK] = FightWorkEffectGuardBreak,
	[FightEnum.EffectType.CARDDECKGENERATE] = FightWorkCardDeckGenerate,
	[FightEnum.EffectType.CARDDECKDELETE] = FightWorkCardDeckDelete,
	[FightEnum.EffectType.CARDDECKCLEAR] = FightWorkCardClear,
	[FightEnum.EffectType.CARDDECKNUM] = FightWorkCardDeckNum,
	[FightEnum.EffectType.DELCARDANDDAMAGE] = FightWorkDelCardAndDamage,
	[FightEnum.EffectType.PROGRESSCHANGE] = FightWorkProgressChange,
	[FightEnum.EffectType.ASSISTBOSSSKILLCD] = FightWorkChangeAssistBossCD,
	[FightEnum.EffectType.DAMAGESHAREHP] = FightWorkDamageShareHp,
	[FightEnum.EffectType.PROGRESSMAXCHANGE] = FightWorkProgressMaxChange,
	[FightEnum.EffectType.ASSISTBOSSSKILLCHANGE] = FightWorkAssistBossSkillChange,
	[FightEnum.EffectType.ASSISTBOSSCHANGE] = FightWorkAssistBossChange,
	[FightEnum.EffectType.ZXQREMOVECARD] = FightWorkZXQRemoveCard,
	[FightEnum.EffectType.ADDITIONALDAMAGE] = FightWorkAdditionalDamage,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = FightWorkAdditionalDamageCrit,
	[FightEnum.EffectType.ACT174FIRST] = FightWorkAct174First,
	[FightEnum.EffectType.ACT174USECARD] = FightWorkAct174UseCard,
	[FightEnum.EffectType.CHANGESHIELD] = FightWorkChangeShield,
	[FightEnum.EffectType.TOWERSCORECHANGE] = FightWorkTowerScoreChangeWork,
	[FightEnum.EffectType.ACT174MONSTERAICARD] = FightWorkAct174MonsterAiCard,
	[FightEnum.EffectType.AFTERREDEALCARD] = FightWorkAfterRedealCard,
	[FightEnum.EffectType.SHAREHURT] = FightWorkShareHurt,
	[FightEnum.EffectType.PLAYERFINISHERSKILLCHANGE] = FightWorkPlayerFinisherSkillChange,
	[FightEnum.EffectType.SIMPLEPOLARIZATIONLEVEL] = FightWorkSimplePolarizationLevel,
	[FightEnum.EffectType.CALLMONSTERTOSUB] = FightWorkCallMonsterToSub,
	[FightEnum.EffectType.AVERAGELIFE] = FightWorkAverageLife,
	[FightEnum.EffectType.POWERINFOCHANGE] = FightWorkPowerInfoChange,
	[FightEnum.EffectType.CARDHEATINIT] = FightWorkCardHeatinit,
	[FightEnum.EffectType.CARDHEATVALUECHANGE] = FightWorkCardHeatValueChange,
	[FightEnum.EffectType.ENCHANTDEPRESSEDAMAGE] = FightWorkEnchantDepresseDamage314,
	[FightEnum.EffectType.ADDSPHANDCARD] = FightWorkAddSpHandCard320,
	[FightEnum.EffectType.CLEARMONSTERSUB] = FightWorkClearMonsterSub322,
	[FightEnum.EffectType.FIGHTTASKUPDATE] = FightWorkFightTaskUpdate323,
	[FightEnum.EffectType.REMOVEMONSTERSUB] = FightWorkRemoveMonsterSub325,
	[FightEnum.EffectType.ADDCARDRECORDBYROUND] = FightWorkAddRecordCard,
	[FightEnum.EffectType.FIGHTPARAMCHANGE] = FightWorkFightParamChange330,
	[FightEnum.EffectType.BLOODPOOLMAXCREATE] = FightWorkCreateBloodPool333,
	[FightEnum.EffectType.BLOODPOOLMAXCHANGE] = FightWorkBloodPoolMaxChange334,
	[FightEnum.EffectType.BLOODPOOLVALUECHANGE] = FightWorkBloodPoolValueChange335,
	[FightEnum.EffectType.COLDSATURDAYHURT] = FightWorkColdSaturdayHurt336,
	[FightEnum.EffectType.NEWCHANGEWAVE] = FightWorkNewChangeWave337,
	[FightEnum.EffectType.CLIENTEFFECT] = FightWorkClientEffect339,
	[FightEnum.EffectType.NUODIKARANDOMATTACK] = FightWorkNuoDiKaRandomAttack341,
	[FightEnum.EffectType.NUODIKATEAMATTACK] = FightWorkNuoDiKaTeamAttack342,
	[FightEnum.EffectType.NUODIKARANDOMATTACKNUM] = FightWorkNuoDiKaRandomAttackNum349,
	[FightEnum.EffectType.BUFFACTINFOUPDATE] = FightWorkBuffActInfoUpdate350,
	[FightEnum.EffectType.CURE] = FightBuffTriggerEffect,
	[FightEnum.EffectType.DOT] = FightBuffTriggerEffect,
	[FightEnum.EffectType.REBOUND] = FightBuffTriggerEffect,
	[FightEnum.EffectType.EXPOINTFIX] = FightBuffTriggerEffect,
	[FightEnum.EffectType.ADDTOATTACKER] = FightBuffTriggerEffect,
	[FightEnum.EffectType.ADDTOTARGET] = FightBuffTriggerEffect,
	[FightEnum.EffectType.DODGESPECSKILL] = FightBuffTriggerEffect,
	[FightEnum.EffectType.DODGESPECSKILL2] = FightBuffTriggerEffect,
	[FightEnum.EffectType.EXPOINTADD] = FightBuffTriggerEffect,
	[FightEnum.EffectType.EXPOINTDEL] = FightBuffTriggerEffect,
	[FightEnum.EffectType.IMMUNITY] = FightBuffTriggerEffect,
	[FightEnum.EffectType.EMITTERCREATE] = FightWorkCreateEmitterEntity,
	[FightEnum.EffectType.EMITTERENERGYCHANGE] = FightWorkEmitterEnergyChange,
	[FightEnum.EffectType.EMITTERREMOVE] = FightWorkEmitterRemove,
	[FightEnum.EffectType.TEAMENERGYCHANGE] = FightWorkTeamEnergyChange,
	[FightEnum.EffectType.ALLOCATECARDENERGY] = FightWorkAllocateCardEnergy,
	[FightEnum.EffectType.CHANGECARDENERGY] = FightWorkChangeCardEnergy,
	[FightEnum.EffectType.REDORBLUECOUNTCHANGE] = FightWorkRedOrBlueCountChange,
	[FightEnum.EffectType.REDORBLUECOUNTEXSKILL] = FightWorkRedOrBlueCountExSkill,
	[FightEnum.EffectType.TOCARDAREAREDORBLUE] = FightWorkToCardAreaRedOrBlue,
	[FightEnum.EffectType.REDORBLUECHANGETRIGGER] = FightWorkRedOrBlueChangeTrigger,
	[FightEnum.EffectType.TRIGGERANALYSIS] = FightWorkTriggerAnalysis343,
	[FightEnum.EffectType.GETSECRETKEY] = FightWorkGetSecretKey344,
	[FightEnum.EffectType.SAVEFIGHTRECORDUPDATE] = FightWorkSaveFightRecordUpdate,
	[FightEnum.EffectType.ROUNDOFFSET] = FightWorkRoundOffset,
	[FightEnum.EffectType.EZIOBIGSKILLDAMAGE] = FightWorkEzioBigSkillDamage1000,
	[FightEnum.EffectType.EZIOBIGSKILLORIGINDAMAGE] = FightWorkEzioBigSkillOriginDamage1001,
	[FightEnum.EffectType.UPDATEITEMPLAYERSKILL] = FightWorkUpdateItemPlayerSkill1002,
	[FightEnum.EffectType.EZIOBIGSKILLEXIT] = FightWorkEzioBigSkillExit1003,
	[FightEnum.EffectType.SURVIVALHEALTHCHANGE] = FightWorkSurvivalHealthChange345,
	[FightEnum.EffectType.REALDAMAGEKILL] = FightWorkRealDamageKill351,
	[FightEnum.EffectType.BUFFDELREASON] = FightWorkBuffDelReason352,
	[FightEnum.EffectType.RANDOMDICEUSESKILL] = FightWorkRandomDiceUseSkill353,
	[FightEnum.EffectType.TOWERDEEPCHANGE] = FightWorkTowerDeepChange354,
	[FightEnum.EffectType.CRYSTALSELECT] = FightWorkCrystalSelect358,
	[FightEnum.EffectType.CRYSTALADDCARD] = FightWorkCrystalAddCard359,
	[FightEnum.EffectType.ROUGE2MUSICCARDCHANGE] = FightWorkRouge2MusicCardChange360,
	[FightEnum.EffectType.ROUGE2MUSICBALLCHANGE] = FightWorkRouge2MusicBallChange361,
	[FightEnum.EffectType.ADDMAXROUND] = FightWorkAddMaxRound356,
	[FightEnum.EffectType.ROUGE2CHECK] = FightWorkRouge2Check362,
	[FightEnum.EffectType.INDICATORDIFFCHANGE] = FightWorkIndicatorDiffChange363,
	[FightEnum.EffectType.CHANGESCENE] = FightWorkChangeScene364,
	[FightEnum.EffectType.EMITTEREXTRADEMAGE] = FightWorkEmitterExtraDemage367,
	[FightEnum.EffectType.BUFFERFLYADDHANDCARD] = FightWorkAddHandCard,
	[FightEnum.EffectType.EXTCAREERWEAK] = FightWorkExtCareerWeak368,
	[FightEnum.EffectType.TOUGHNESSRECOVER] = FightWorkToughnessRecover369,
	[FightEnum.EffectType.TOUGHNESSCHANGE] = FightWorkToughnessChange370,
	[FightEnum.EffectType.INITDEVICE] = FightWorkInitDevice372,
	[FightEnum.EffectType.DEVICESKILLINDEX] = FightWorkDeviceSkillIndex373,
	[FightEnum.EffectType.DEVICEPOWERCHANGE] = FightWorkDevicePowerChange374,
	[FightEnum.EffectType.MOVECARD] = FightWorkMoveCard376,
	[FightEnum.EffectType.UPDATECARDDATA] = FightWorkUpdateCardData377,
	[FightEnum.EffectType.INSERTHANDCARD] = FightWorkInsertHandCard378,
	[FightEnum.EffectType.DEVICERUNNING] = FightWorkDeviceRunning379,
	[FightEnum.EffectType.TOUGHNESSRESET] = FightWorkToughnessReset375,
	[FightEnum.EffectType.UNNAMEDSTRENGTHEN] = FightWorkUnnamedStrengthen380,
	[FightEnum.EffectType.COUNTERCHANGE] = FightWorkCounterChange381,
	[FightEnum.EffectType.DEVICEPOWERCLEAR] = FightWorkDevicePowerClear382,
	[FightEnum.EffectType.DEVICESTOP] = FightWorkDeviceStop383
}
FightStepBuilder.EffectType2FlowOrWork = {
	[FightEnum.EffectType.ADDSPHANDCARD] = FightWorkAddSpHandCard320Container,
	[FightEnum.EffectType.SPCARDADD] = FightWorkSpCardAddContainer,
	[FightEnum.EffectType.BUFFADD] = FightWorkBuffAddContainer,
	[FightEnum.EffectType.DEAD] = FightWorkDeadContainer,
	[FightEnum.EffectType.SKILLWEIGHTSELECT] = FightWorkSkillWeightSelectContainer,
	[FightEnum.EffectType.KILL] = FightWorkKillContainer,
	[FightEnum.EffectType.SUMMON] = FightWorkEffectSummonContainer,
	[FightEnum.EffectType.INJURYBANKHEAL] = FightWorkInjuryBankHealContainer,
	[FightEnum.EffectType.ADDHANDCARD] = FightWorkAddHandCardContainer,
	[FightEnum.EffectType.CARDACONVERTCARDB] = FightWorkCardAConvertCardBContainer,
	[FightEnum.EffectType.MASTERADDHANDCARD] = FightWorkMasterAddHandCardContainer,
	[FightEnum.EffectType.MASTERCARDREMOVE] = FightWorkMasterCardRemoveContainer,
	[FightEnum.EffectType.REMOVEENTITYCARDS] = FightWorkRemoveEntityCardsContainer,
	[FightEnum.EffectType.CLEARUNIVERSALCARD] = FightWorkRemoveUnivesalCardsContainer,
	[FightEnum.EffectType.CARDINVALID] = FightWorkCardInvalidContainer,
	[FightEnum.EffectType.CARDLEVELCHANGE] = FightWorkEffectCardLevelChangeContainer,
	[FightEnum.EffectType.CARDREMOVE] = FightWorkCardRemoveContainer,
	[FightEnum.EffectType.CARDREMOVE2] = FightWorkCardRemove2Container,
	[FightEnum.EffectType.ADDUSECARD] = FightWorkAddUseCardContainer,
	[FightEnum.EffectType.CHANGEHERO] = FightWorkChangeHeroContainer,
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = FightWorkPlayAroundUpRankContainer,
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = FightWorkPlayAroundDownRankContainer,
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = FightWorkPlayChangeRankFailContainer,
	[FightEnum.EffectType.GUARDBREAK] = FightWorkEffectGuardBreakContainer,
	[FightEnum.EffectType.ZXQREMOVECARD] = FightWorkZXQRemoveCardContainer,
	[FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE] = FightWorkDeadlyPoisonContainer,
	[FightEnum.EffectType.DEADLYPOISONORIGINCRIT] = FightWorkDeadlyPoisonCritContainer,
	[FightEnum.EffectType.COLDSATURDAYHURT] = FightWorkColdSaturdayHurt336Container,
	[FightEnum.EffectType.BUFFERFLYADDHANDCARD] = FightWorkAddHandCardContainer
}

setmetatable(FightStepBuilder.EffectType2FlowOrWork, {
	__index = FightStepBuilder.ActEffectWorkCls
})

function FightStepBuilder.buildStepWorkList(fightStepList)
	if not fightStepList then
		return
	end

	FightSkillBuffMgr.instance:clearCompleteBuff()

	FightStepBuilder.ASFDIndex = 0

	local preStepData
	local stepWorkList = {}
	local skillFlowList = {}

	for i, fightStepData in ipairs(fightStepList) do
		table.insert(stepWorkList, FightWorkBeforeSkillEffect.New(fightStepData))

		if fightStepData.actType == FightEnum.ActType.SKILL then
			if FightHelper.isASFDSkill(fightStepData.actId) then
				local nextStepData = fightStepList[i + 1]

				FightStepBuilder._buildASFDSkillWork(fightStepData, stepWorkList, skillFlowList, nextStepData)
			else
				preStepData = FightStepBuilder._buildSkillWork(fightStepList, fightStepData, preStepData, fightStepList[i + 1], stepWorkList, skillFlowList)
			end
		elseif fightStepData.actType == FightEnum.ActType.EFFECT then
			tabletool.addValues(stepWorkList, FightStepBuilder._buildEffectWorks(fightStepData, nil))

			for _, actEffectData in ipairs(fightStepData.actEffect) do
				if actEffectData.effectType == FightEnum.EffectType.DEALCARD1 or actEffectData.effectType == FightEnum.EffectType.DEALCARD2 or actEffectData.effectType == FightEnum.EffectType.ROUNDEND or actEffectData.effectType == FightEnum.EffectType.NEWCHANGEWAVE then
					if actEffectData.effectType == FightEnum.EffectType.NEWCHANGEWAVE then
						FightDataHelper.tempMgr.hasNextWave = true

						FightController.instance:dispatchEvent(FightEvent.HaveNextWave)
					end

					preStepData = nil

					break
				end
			end

			table.insert(stepWorkList, FunctionWork.New(function()
				fightStepData.hasPlay = true
			end))
		elseif fightStepData.actType == FightEnum.ActType.CHANGEHERO then
			preStepData = nil

			local cloneSkillFlowList = tabletool.copy(skillFlowList)

			table.insert(stepWorkList, FightWorkWaitForSkillsDone.New(cloneSkillFlowList))
			table.insert(stepWorkList, FightWorkStepChangeHero.New(fightStepData))
			table.insert(stepWorkList, FunctionWork.New(function()
				fightStepData.hasPlay = true
			end))
		elseif fightStepData.actType == FightEnum.ActType.CHANGEWAVE then
			preStepData = nil

			local cloneSkillFlowList = tabletool.copy(skillFlowList)

			table.insert(stepWorkList, FightWorkWaitForSkillsDone.New(cloneSkillFlowList))
			table.insert(stepWorkList, FightWorkStepChangeWave.New())
			table.insert(stepWorkList, FightWorkAppearTimeline.New())
			table.insert(stepWorkList, FightWorkStartBornEnemy.New())
			table.insert(stepWorkList, FightWorkFocusMonster.New())
			table.insert(stepWorkList, FunctionWork.New(function()
				fightStepData.hasPlay = true

				FightController.instance:beginWave()
			end))
		elseif fightStepData.actType == FightEnum.ActType.DEVICE then
			preStepData = FightStepBuilder._buildSkillWork(fightStepList, fightStepData, preStepData, fightStepList[i + 1], stepWorkList, skillFlowList)
		else
			logError("step actType not implement: " .. fightStepData.actType)
			tabletool.addValues(stepWorkList, FightStepBuilder._buildEffectWorks(fightStepData, nil))
		end

		table.insert(stepWorkList, FightWorkAfterSkillEffect.New(fightStepData))
	end

	return stepWorkList, skillFlowList
end

function FightStepBuilder._buildSkillWork(fightStepList, fightStepData, preStepData, nextStepData, stepWorkList, skillFlowList)
	table.insert(stepWorkList, FightGuideBeforeSkill.New(fightStepData))

	local entityMO = FightDataHelper.entityMgr:getById(fightStepData.fromId)
	local skinId = entityMO and entityMO.skin
	local timeline = FightConfig.instance:getSkinSkillTimeline(skinId, fightStepData.actId)

	if not string.nilorempty(timeline) then
		local hasStory = FightWorkFbStory.checkHasFbStory()

		if hasStory then
			table.insert(stepWorkList, FightWorkFbStory.New(FightWorkFbStory.Type_BeforePlaySkill, fightStepData.actId))
		end

		table.insert(stepWorkList, FightWorkShowEquipSkillEffect.New(fightStepData, nextStepData))

		local skillFlow = FightSkillFlow.New(fightStepData)

		table.insert(stepWorkList, skillFlow)
		table.insert(skillFlowList, skillFlow)
		skillFlow:addAfterSkillEffects(FightStepBuilder._buildEffectWorks(fightStepData))

		if hasStory then
			table.insert(stepWorkList, FightWorkFbStory.New(FightWorkFbStory.Type_AfterPlaySkill, fightStepData.actId))
		end

		table.insert(stepWorkList, FightParallelPlayNextSkillStep.New(fightStepData, preStepData, fightStepList))
		table.insert(stepWorkList, FightNextSkillIsSameStep.New(fightStepData, preStepData))

		preStepData = fightStepData
	else
		table.insert(stepWorkList, FightWorkShowEquipSkillEffect.New(fightStepData, nextStepData))
		table.insert(stepWorkList, FightNonTimelineSkillStep.New(fightStepData))
		tabletool.addValues(stepWorkList, FightStepBuilder._buildEffectWorks(fightStepData))
	end

	table.insert(stepWorkList, FunctionWork.New(FightStepBuilder.maskFightStepDataDone, fightStepData))
	table.insert(stepWorkList, FightWorkSkillDelay.New(fightStepData))
	table.insert(stepWorkList, FightWorkSpecialDelay.New(fightStepData))

	return preStepData
end

function FightStepBuilder.maskFightStepDataDone(fightStepData)
	fightStepData.hasPlay = true

	FightController.instance:dispatchEvent(FightEvent.OnSkillEffectPlayFinish, fightStepData)
end

FightStepBuilder.ASFDIndex = 0

function FightStepBuilder._buildASFDSkillWork(fightStepData, stepWorkList, skillFlowList, nextStepData)
	FightStepBuilder.ASFDIndex = FightStepBuilder.ASFDIndex + 1

	local ASFDFlow = FightASFDFlow.New(fightStepData, nextStepData, FightStepBuilder.ASFDIndex)

	table.insert(stepWorkList, ASFDFlow)
	table.insert(skillFlowList, ASFDFlow)

	return ASFDFlow
end

FightStepBuilder.lastEffect = nil

function FightStepBuilder._buildEffectWorks(fightStepData)
	FightStepBuilder.lastEffect = nil

	local flow = FightWorkFlowSequence.New()

	FightStepBuilder.addAnAnFocusBuffWork(flow, fightStepData)
	FightStepBuilder.addEffectWork(flow, fightStepData)

	FightStepBuilder.lastEffect = nil

	local stepWork = FightStepEffectWork.New()

	stepWork:setFlow(flow)

	return {
		stepWork
	}
end

function FightStepBuilder.addAnAnFocusBuffWork(flow, fightStepData)
	local actEffect = FightHelper.getActEffectData(FightEnum.EffectType.ANANFOCUSBUFF, fightStepData)

	if not actEffect then
		return
	end

	flow:registWork(FightWorkAnAnFocusBuff366, fightStepData, actEffect)
end

function FightStepBuilder.addEffectWork(flow, fightStepData)
	for i, actEffectData in ipairs(fightStepData.actEffect) do
		local effectType = actEffectData.effectType

		if not ((effectType == FightEnum.EffectType.FIGHTSTEP and not actEffectData.fightStep or nil) and true) then
			local class = FightStepBuilder.EffectType2FlowOrWork[effectType]

			if class then
				local work = flow:registWork(class, fightStepData, actEffectData)

				if FightStepBuilder.lastEffect then
					FightStepBuilder.lastEffect.nextActEffectData = actEffectData
				end

				FightStepBuilder.lastEffect = actEffectData

				if effectType == FightEnum.EffectType.FIGHTSTEP then
					local stepEffectFlow = FightWorkFlowSequence.New()

					FightStepBuilder.addEffectWork(stepEffectFlow, actEffectData.fightStep)
					work:setFlow(stepEffectFlow)

					actEffectData.fightStepNextActEffectData = fightStepData.actEffect[i + 1]
				end
			end
		end
	end
end

return FightStepBuilder
