local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleRenderEvent = require("Battle.DbgEngine.Event.BattleRenderEvent")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleRecord, Super = System.NewClass("BattleRecord", BattleEngineComponent)

function BattleRecord:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.time = 0
  self.isRecording = false
  self:ResetRecordData()
end

function BattleRecord:Dispose()
  self.battleEngine = nil
end

function BattleRecord:BeginRecord()
  if self.isRecording then
    self.battleEngine:Warn("ERROR: 已经在录像中，又尝试开始启新录像！")
    return
  end
  self.isRecording = true
  self:ResetRecordData()
  self:AddBaseTimeFrame()
end

function BattleRecord:EndRecord()
  self.isRecording = false
  self:AddBaseTimeFrame()
  local recordData = self:GetRecordData()
  self.battleEngine:SendCommand(BattleCommand.rd_BattleCut, recordData)
end

function BattleRecord:GetRecordData()
  return self.recordData
end

function BattleRecord:ResetRecordData()
  self.recordData = {
    queueType = bc.BattleRecordQueueType.OneCut,
    frameList = {}
  }
end

function BattleRecord:PushRecord(frameData)
  table.insert(self.recordData.frameList, frameData)
end

function BattleRecord:AddBaseTimeFrame()
  local frameData = {
    time = self.battleEngine:GetCurPassTime()
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnUseCard(cardUid, camp)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.UseCard,
    data = {cardUid = cardUid, camp = camp}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnCardInteract(cardUid, camp, animState)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.CardInteract,
    data = {
      cardUid = cardUid,
      camp = camp,
      animState = animState
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnInsertHistory(data)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.InsertHistory,
    data = data
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChangeBoutPhase(oldPhase, newPhase, config)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeBoutPhase,
    data = {
      oldPhase = oldPhase,
      newPhase = newPhase,
      boutNumber = config.boutNumber,
      config = config
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChangeCardListDeck(cardUidList, oldDeck, newDeck, isShuffle, changeReason, camp, show)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeCardListDeck,
    data = {
      cardUidList = cardUidList,
      oldDeck = oldDeck,
      newDeck = newDeck,
      isShuffle = isShuffle,
      changeReason = changeReason,
      camp = camp,
      show = show
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnMoveCardToDeck(cardUid, targetDeck, targetPos, camp)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.MoveCardToDeck,
    data = {
      cardUid = cardUid,
      targetDeck = targetDeck,
      targetPos = targetPos,
      camp = camp
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnAddNewCard(cardData, deck, show, camp)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.AddNewCard,
    data = {
      cards = cardData,
      deck = deck,
      show = show,
      camp = camp
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnUpdateCardArgs(changeList)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.CardArgsChange,
    data = changeList
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSkillArgs(roleUid, args, descArgs)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SkillArgsChange,
    data = {
      roleUid = roleUid,
      args = args,
      descArgs = descArgs
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSilverKeyAwakeArgs(roleUid, args, descArgs)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SilverKeyAwakeArgsChange,
    data = {
      roleUid = roleUid,
      args = args,
      descArgs = descArgs
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:SetCardHighlight(highlightList)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SetCardHighlight,
    data = {highlightList = highlightList}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnRoleChangeFsmState(roleUid, oldState, newState, config)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeRoleFsmState,
    data = {
      uid = roleUid,
      oldState = oldState,
      newState = newState,
      config = config
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnAddState(data)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.AddState,
    data = data
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChangeStateLayer(data)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeStateLayer,
    data = data
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnDelState(ownerUid, stateUid, stateType, showText)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.DelState,
    data = {
      stateUid = stateUid,
      ownerUid = ownerUid,
      stateType = stateType,
      showText = showText
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnAddCardState(data)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.AddCardState,
    data = data
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnPlayEffectSfx(targetType, targetUids, sfxConfigId, cmdId)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.PlayEffectSfx,
    data = {
      targetType = targetType,
      targetUids = targetUids,
      sfxConfigId = sfxConfigId,
      cmdId = cmdId
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnBeHit(roleUid, beHitConfig)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.BeHit,
    data = {roleUid = roleUid, beHitConfig = beHitConfig}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnBattleFinish(winCamp, isShow, battleFinishData)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.BattleFinish,
    data = {
      winCamp = winCamp,
      isShow = isShow,
      battleFinishData = battleFinishData
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnRemoveRole(roleUid)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.RemoveRole,
    data = {roleUid = roleUid}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSpawnWaveMonster(waveIndex, roleDataList)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SpawnWaveMonster,
    data = {waveIndex = waveIndex, roleDataList = roleDataList}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSpawnMonster(roleData)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SpawnMonster,
    data = {roleData = roleData}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnMonsterChangePos(roleUid, battleFieldPos)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.MonsterChangePos,
    data = {roleUid = roleUid, battleFieldPos = battleFieldPos}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnMonsterIntenion(roleUid, intention, damageInfo, descArgs)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.MonsterIntention,
    data = {
      roleUid = roleUid,
      intention = intention,
      damageInfo = damageInfo or {},
      descArgs = descArgs
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnRoleIdleStateChanged(roleUid, idleState)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.IdleStateChanged,
    data = {roleUid = roleUid, idleState = idleState}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnPropertyChanged(uid, propertyType, changedValue, value, reason, extraData)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.PropertyChanged,
    data = {
      uid = uid,
      propertyType = propertyType,
      changedValue = changedValue,
      value = value,
      reason = reason,
      extraData = extraData
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSelectTargets(data)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SelectTargets,
    data = data
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnModifyCardCost(cardDeck, cardUid, changedValue, value)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ModifyCardCost,
    data = {
      cardDeck = cardDeck,
      cardUid = cardUid,
      changedValue = changedValue,
      value = value
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnAfterUseCard(cardUid, state, leftUseCount, camp)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.AfterUseCard,
    data = {
      cardUid = cardUid,
      leftUseCount = leftUseCount,
      state = state,
      camp = camp
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChangeCard(data)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeCardId,
    data = data
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnRelicEffect(relicTid)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.RelicEffect,
    data = {relicTid = relicTid}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnTentacleAttack(roleUid, tentacleCount, targetUids)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.TentacleAttack,
    data = {
      roleUid = roleUid,
      tentacleCount = tentacleCount,
      targetUids = targetUids
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSetCardAttribute(cardDeck, cardUid, attribute, val)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SetCardAttribute,
    data = {
      cardDeck = cardDeck,
      cardUid = cardUid,
      attribute = attribute,
      val = val
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnBeginPlayStory(storyId)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.PlayStory,
    data = {storyId = storyId}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnPlayOpeningDialogue(camp, voiceID)
  self:BeginRecord()
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.PlayOpeningDialogue,
    data = {camp = camp, voiceID = voiceID}
  }
  self:PushRecord(frameData)
  self:EndRecord()
end

function BattleRecord:OnPlayNormalDialogues(camp1VoiceID, camp2VoiceID)
  self:BeginRecord()
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.PlayNormalDialogue,
    data = {camp1VoiceID = camp1VoiceID, camp2VoiceID = camp2VoiceID}
  }
  self:PushRecord(frameData)
  self:EndRecord()
end

function BattleRecord:OnBattleBegin()
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.BattleBegin,
    data = {}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnMoneyChange(value, totalValue, floatText)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.MoneyChange,
    data = {
      value = value,
      floatText = floatText,
      totalValue = totalValue
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnStressChange(value, totalValue)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.StressChange,
    data = {value = value, totalValue = totalValue}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSwapAwaker(roleUid1, roleUid2)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SwapAwaker,
    data = {roleUid1 = roleUid1, roleUid2 = roleUid2}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnRespawn(roleUid, deadTimes)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.Respawn,
    data = {roleUid = roleUid, deadTimes = deadTimes}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnDeathResist(roleUid)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.DeathResist,
    data = {roleUid = roleUid}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSkillTimesChange(roleUid, times)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SkillTimesChange,
    data = {roleUid = roleUid, times = times}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSilverKeyAwakeTimesChange(roleUid, times)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SilverKeyAwakeTimesChange,
    data = {roleUid = roleUid, times = times}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChaosType2SkillTimesChange(roleUid, times)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChaosType2SkillTimesChange,
    data = {roleUid = roleUid, times = times}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChaosType2Skill2TimesChange(roleUid, times)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChaosType2Skill2TimesChange,
    data = {roleUid = roleUid, times = times}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnBloodRecoverTimesChange(roleUid, times)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.BloodRecoverTimesChange,
    data = {roleUid = roleUid, times = times}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnFloatingText(roleUid, text, textType, args)
  local color
  if args then
    color = args.color
    args.color = nil
  end
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.FloatingText,
    data = {
      roleUid = roleUid,
      text = text,
      textType = textType,
      args = args,
      color = color
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnShowTips(tipsId, showTime)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ShowTips,
    data = {tipsId = tipsId, showTime = showTime}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnMonsterBubble(monsterUid, tipsId, showTime)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.MonsterBubble,
    data = {
      monsterUid = monsterUid,
      tipsId = tipsId,
      showTime = showTime
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChangeCardAffixes(cardUid, cardAffixes)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeCardAffixes,
    data = {cardUid = cardUid, cardAffixes = cardAffixes}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChangeExtraBout(isExtraBout)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeExtraBout,
    data = {isExtraBout = isExtraBout}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSelectCardEffect(effectUid, showList, num)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SelectCardEffect,
    data = {
      effectUid = effectUid,
      showList = showList,
      num = num
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnConfirm(effectUid, confirmType, lives, reason)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.Confirm,
    data = {
      effectUid = effectUid,
      confirmType = confirmType,
      lives = lives,
      reason = reason or bc.ConfirmReason.None
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnBattleRecover()
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.BattleRecover,
    data = {}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnDoEffect(data)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.DoEffect,
    data = data
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChangeBg(changeId)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeBg,
    data = {bgId = changeId}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSetTempArg(argKey, argValue)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SetTempArg,
    data = {argKey = argKey, argValue = argValue}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnAfterAction(roleUid, actionType)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.AfterAction,
    data = {roleUid = roleUid, actionType = actionType}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnUseKeeperSkill(roleUid, skillId)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.UseKeeperSkill,
    data = {roleUid = roleUid, skillId = skillId}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnUseSilverKeyAwake(roleUid, skillId)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.UseSilverKeyAwake,
    data = {roleUid = roleUid, skillId = skillId}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnUseDimensionSkill(roleUid, skillId)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.UseDimensionSkill,
    data = {roleUid = roleUid, skillId = skillId}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnUpdateSchoolSpecialArgs(roleUid, params)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.UpdateSchoolSpecialArgs,
    data = {roleUid = roleUid, schoolSpecialArgs = params}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnUpdateSchoolArgs(roleUid, params)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.UpdateSchoolArgs,
    data = {roleUid = roleUid, schoolArgs = params}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnUpdateStateArgs(updateList)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.UpdateStateArgs,
    data = {updateList = updateList}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnTimelineLoop(times)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.TimelineLoop,
    data = {times = times}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSelectInitCard(playerUid, cardUids)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SelectInitCard,
    data = {roleUid = playerUid, targetUids = cardUids}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnShuffleCard(camp)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ShuffleCard,
    data = {camp = camp}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChangeMotion(target)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeMotion,
    data = {
      uid = target.uid,
      motion = table.deepclone(target.data.motion)
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChangeKeeperSkill(tid, changeType)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeKeeperSkill,
    data = {tid = tid, changeType = changeType}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnSwitchOceanModel(model)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SwitchOceanModel,
    data = {model = model}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnChangeMonsterAnim(uid, animIdx)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeMonsterAnim,
    data = {uid = uid, animIdx = animIdx}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnNotAwakerTimeline(roleUid, skillId)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.NotAwakerTimeline,
    data = {roleUid = roleUid, skillId = skillId}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnRunTimeline(roleUid, targetUids, timelinePath, runType)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.RunTimeline,
    data = {
      roleUid = roleUid,
      targetUids = targetUids,
      timelinePath = timelinePath,
      runType = runType
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnUpdateMonsterDamage(monsterDamage, damageOrder)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.UpdateMonsterDamage,
    data = {monsterDamage = monsterDamage, damageOrder = damageOrder}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnMonsterHpNumChange(uid, hpNum)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.MonsterHpNumChange,
    data = {uid = uid, hpNum = hpNum}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnMonsterChangeName(uid, showNameKey)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.MonsterChangeName,
    data = {uid = uid, showName = showNameKey}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnPlayCardVFX(uids, vfx)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.PlayCardVFX,
    data = {cardUids = uids, vfx = vfx}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnCardDisplayChange(cardUid, skillTid, sfxId, srcHoldTimeMs, dstHoldTimeMs, condList, skillArgs, descArgs)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.CardDisplayChange,
    data = {
      cardUid = cardUid,
      skillTid = skillTid,
      sfxId = sfxId,
      srcHoldTimeMs = srcHoldTimeMs,
      dstHoldTimeMs = dstHoldTimeMs,
      condList = condList,
      skillArgs = skillArgs,
      descArgs = descArgs
    }
  }
  self.battleEngine:DebugS("OnCardDisplayChange {frameData}", table.tostring(frameData))
  self:PushRecord(frameData)
end

function BattleRecord:OnPlaySceneVFX(sceneVfxId)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.PlaySceneVFX,
    data = {vfx = sceneVfxId}
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnAddNewRelic(relic)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.AddNewRelic,
    data = {relic = relic}
  }
  self.battleEngine:InfoS("OnAddNewRelic {frameData}", table.tostring(frameData))
  self:PushRecord(frameData)
end

function BattleRecord:OnRemoveRelic(tid)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.RemoveRelic,
    data = {tid = tid}
  }
  self.battleEngine:InfoS("OnRemoveRelic {frameData}", table.tostring(frameData))
  self:PushRecord(frameData)
end

function BattleRecord:OnAttachPostAction(producerUid, casterUid, skillTid, isPerform)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.AttachPostAction,
    data = {
      producerUid = producerUid,
      casterUid = casterUid,
      skillTid = skillTid,
      isPerform = isPerform
    }
  }
  self:PushRecord(frameData)
end

function BattleRecord:OnLockedEnemyChanged(lockerUidToLockedUid)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.LockedEnemyChanged,
    data = {
      lockerUidToLockedUid = table.deepclone(lockerUidToLockedUid or {})
    }
  }
  self:PushRecord(frameData)
end

return BattleRecord
