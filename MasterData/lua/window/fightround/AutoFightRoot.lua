local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local FH = require("Logic/HelpLogic")
local TLog = require("Common/TlogUtil")
local DEFINE = require("Logic/Define")
local m_tutorialManager = S:Get("TutorialManager")
local AutoFightMode = {
  [1] = "AutoCastMode",
  [2] = "CommandCastMode"
}
local WeaponUnlockPos = {
  {cellWidth = -256, y = 47},
  {cellWidth = 1142, y = 65}
}
local m_params, m_autoFightMode, m_autoFightCommands, m_autoData

function OnEnable()
  WU.BindButtonEvent(REF.BtnAutoFight, OnBtnAutoFight)
  WU.BindButtonEvent(REF.AutoSetting, OnBtnAutoSetting)
  WU.BindButtonEvent(REF.SpeedAdd, OnBtnSpeedAdd)
  this:RegisterGameEvent("FightUI_RunAI", OnFightRunAI)
  this:RegisterGameEvent("OnFightAutoSetting", RefreshAutoFightSetting)
  this:RegisterGameEvent("SwitchAutoFightMode", OnSwitchAutoFightMode)
end

function OnDisable()
  WU.ClearButtonEvent(REF.BtnAutoFight, OnBtnAutoFight)
  WU.ClearButtonEvent(REF.AutoSetting, OnBtnAutoSetting)
  WU.ClearButtonEvent(REF.SpeedAdd, OnBtnSpeedAdd)
  this:UnregisterGameEvent("FightUI_RunAI", OnFightRunAI)
  this:UnregisterGameEvent("OnFightAutoSetting", RefreshAutoFightSetting)
  this:UnregisterGameEvent("SwitchAutoFightMode", OnSwitchAutoFightMode)
end

function SetupAutoFight(params)
  m_params = params
  m_autoData = this:GetData("fci/autoFightSetting/")
  if m_autoData == nil then
    m_autoData = {}
  end
  if m_params.dungeonType ~= 0 then
    local auto_val = m_autoData["1"]
    if auto_val ~= nil then
      m_params.isAutoFight = 1 << tonumber(m_params.dungeonType) & auto_val ~= 0
    end
    local speed_val = m_autoData["2"]
    if speed_val ~= nil and speed_val ~= 0 then
      m_params.isSpeedUp = true
    end
    local effect_val = m_autoData["3"]
    if effect_val ~= nil and effect_val ~= 0 then
      REF.BtnAutoSettingEffect.gameObject:SetActive(false)
    end
  end
  if CS.SceneFight.s_Standalone then
    m_params.weaponUnlocked = true
  end
  local i = fif(m_params.weaponUnlocked, 1, 2)
  REF.BigGrid.UIGrid.cellWidth = WeaponUnlockPos[i].cellWidth
  local base = REF.BigGrid.transform.localPosition
  REF.BigGrid.transform.localPosition = CS.UnityEngine.Vector3(base.x, WeaponUnlockPos[i].y, base.z)
  WU.SetActive(REF.BtnBG, m_params.weaponUnlocked)
end

function InitAutoFight(teamInfo, dungeonMonster)
  m_autoFightCommands = nil
  if teamInfo then
    local key = ""
    for i = 1, #teamInfo.playerList do
      local roundPlayerInfo = teamInfo.playerList[i]
      if roundPlayerInfo.playerId == this:GetData("playerId") or CS.SceneFight.s_Standalone then
        for ai = 1, #roundPlayerInfo.actorList do
          local roundActorInfo = roundPlayerInfo.actorList[ai]
          key = key .. tostring(roundActorInfo.actorInfo.id)
        end
      end
    end
    if key ~= "" then
      local configPrefix = this:GetData("playerId") or ""
      local modeIndex = WU.GetGameDataCache(configPrefix .. "/Fight/AutoFightMode" .. m_params.dungeonId)
      local commands = WU.GetGameDataCache(configPrefix .. "/Fight/CommandSequences" .. m_params.dungeonId)
      if commands and commands.key ~= key then
        WU.SetGameDataCache(configPrefix .. "/Fight/CommandSequences" .. m_params.dungeonId, nil)
        commands = nil
      end
      modeIndex = fif(commands == nil or not FH.enableAutoFightCommandMode(m_params.dungeonType), 1, 2)
      m_autoFightMode = modeIndex
      m_autoFightCommands = {
        seat1 = {},
        seat2 = {},
        seat3 = {},
        mode = modeIndex,
        key = key,
        weaponPrevious = {},
        weapon = {}
      }
      if commands ~= nil then
        table.merge(m_autoFightCommands.seat1, commands.seat1)
        table.merge(m_autoFightCommands.seat2, commands.seat2)
        table.merge(m_autoFightCommands.seat3, commands.seat3)
        table.merge(m_autoFightCommands.weaponPrevious, commands.weapon)
      end
      local isDungeonChain = dungeonMonster and dungeonMonster.nextDungeonId ~= 0
      local prevDungeonId = this:GetData("Fight/PrevDungeonChain")
      if isDungeonChain and prevDungeonId then
        local dungeonMonsterPrev = PB.get("DungeonMonster", prevDungeonId)
        if dungeonMonsterPrev and dungeonMonsterPrev.nextDungeonId == dungeonMonster.dungeonID then
          local lastCommands = WU.GetGameDataCache(configPrefix .. "/Fight/CommandSequences" .. prevDungeonId)
          if lastCommands then
            table.merge(m_autoFightCommands.seat1, lastCommands.seat1)
            table.merge(m_autoFightCommands.seat2, lastCommands.seat2)
            table.merge(m_autoFightCommands.seat3, lastCommands.seat3)
            table.merge(m_autoFightCommands.weapon, lastCommands.weapon)
            table.merge(m_autoFightCommands.weaponPrevious, lastCommands.weaponPrevious)
          end
        end
        this:SetData("Fight/PrevDungeonChain", nil)
      end
    end
  end
  this:SetData("Fight/CommandSequenceTemp", m_autoFightCommands)
end

function OnSwitchAutoFightMode(modeIndex)
  if m_autoFightCommands then
    m_autoFightMode = modeIndex
    m_autoFightCommands.mode = modeIndex
    RefreshAutoFightSetting()
  end
end

function RefreshAutoFightSetting()
  if m_autoFightMode then
    for i = 1, #m_params.skillGroupList do
      local info = m_params.skillGroupList[i]
      if info:HaveCard() then
        local index = FH.getAutoSettingKey(info.linkIndex, info:GetActorID(), info.cardIndex, info.scardIndex)
        if m_params.isAutoFight and AutoFightMode[m_autoFightMode] == "AutoCastMode" then
          if m_autoData[index] == nil or m_autoData[index] == 0 then
            _ENV["$"](m_params.skillGroupList[i].btn).SkillSetting.gameObject:SetActive(false)
          else
            _ENV["$"](m_params.skillGroupList[i].btn).SkillSetting.gameObject:SetActive(true)
          end
        else
          _ENV["$"](m_params.skillGroupList[i].btn).SkillSetting.gameObject:SetActive(false)
        end
      end
    end
    if AutoFightMode[m_autoFightMode] == "AutoCastMode" then
      REF.AutoSetting.UISprite.spriteName = "chat_autoset"
      REF.AutoSettingLabel.UILabel.text = WU.GetString("FIGHT_AUTO_SET")
    else
      REF.AutoSetting.UISprite.spriteName = "chat_record"
      REF.AutoSettingLabel.UILabel.text = WU.GetString("FIGHT_COMMAND_SET")
    end
  end
end

function AutoFightRefresh(tutorialVal)
  local dungeonType = m_params.dungeonType
  local auto = m_params.isAutoFight
  if tutorialVal ~= 2 and tutorialVal ~= 3 then
    m_params.autoFightDelayTime = 0
    local icon = "chat_automatic"
    if dungeonType == PB.enum.DungeonType.Story or dungeonType == PB.enum.DungeonType.Training or dungeonType == PB.enum.DungeonType.Challenge then
      icon = "chat_manual_lock"
    elseif auto then
      icon = "chat_manual"
    end
    REF.BtnAutoFight.UISprite.spriteName = icon
    local showAutoSetting = m_params.isAutoFight and EnableAutoSetting(tutorialVal)
    WU.SetActive(REF.AutoSetting, showAutoSetting)
    WU.SetActive(REF.AutoSettingPlaceHolder, not showAutoSetting)
    if auto then
      CS.UIWindowHelp.ChangeUIWidgetEnable(REF.BtnSkipRound.gameObject, false)
    end
    CS.FightRoundBase.Instance:SetAutoFightLua(auto)
  end
  if dungeonType ~= 0 then
    local cur_auto = 1 << tonumber(dungeonType)
    local auto_val = m_autoData["1"]
    if auto_val == nil then
      auto_val = 0
    end
    if auto then
      auto_val = auto_val | cur_auto
    else
      auto_val = auto_val & ~cur_auto
    end
    m_autoData["1"] = auto_val
    this:SetData("fci/autoFightSetting/", m_autoData)
  end
  RefreshAutoFightSetting()
end

function AutoClickSkill(obj)
  if AutoFightMode[m_autoFightMode] == "AutoCastMode" then
    for i = 1, #m_params.skillGroupList do
      local info = m_params.skillGroupList[i]
      if info.btn == obj and info:HaveCard() then
        local index = FH.getAutoSettingKey(info.linkIndex, info:GetActorID(), info.cardIndex, info.scardIndex)
        if m_autoData[index] == nil or m_autoData[index] == 0 then
          m_autoData[index] = 1
          _ENV["$"](m_params.skillGroupList[i].btn).SkillSetting.gameObject:SetActive(true)
        else
          m_autoData[index] = 0
          _ENV["$"](m_params.skillGroupList[i].btn).SkillSetting.gameObject:SetActive(false)
        end
        this:SetData("fci/autoFightSetting/", m_autoData)
        RefreshAutoFightSetting()
        break
      end
    end
  end
end

function EnableAutoSetting(tutorialVal)
  local function EnablePause(tutorialVal)
    return tutorialVal ~= 2 and tutorialVal ~= 3 and not m_tutorialManager.IsTutorialUIShowing()
  end
  
  local function IsTutorialUIFight(tutorialVal)
    return tutorialVal == 2 or tutorialVal == 3 or tutorialVal == 8 or tutorialVal == 9 or tutorialVal == 10 or m_tutorialManager.IsTrainingTutorial(tutorialVal)
  end
  
  if CS.GameLogic.IsLocalMode() and EnablePause(tutorialVal) and not IsTutorialUIFight(tutorialVal) and not m_params.isRecordGame then
    return true
  end
  return false
end

function OnBtnAutoSetting()
  if not EnableAutoSetting() then
    return
  end
  local sceneInstance = CS.SceneFight.Instance
  if sceneInstance and sceneInstance:EnablePauseGame() and m_params.stateWidget.alpha == 1 then
    CS.FightLuaLogic.Instance.mFightRoundSandBox.FightAutoSettingOpen()
    if AutoFightMode[m_autoFightMode] == "AutoCastMode" then
      m_autoData["3"] = m_autoFightMode
      this:SetData("fci/autoFightSetting/", m_autoData)
    end
    REF.BtnAutoSettingEffect.gameObject:SetActive(false)
    local window = WU.AcquireWindow("FightAutoSetting")
    _ENV["$"](window)["$$SetMode"](m_autoFightMode)
  end
end

function GetCurrentSkillIndex(gameRound)
  if AutoFightMode[m_autoFightMode] == "CommandCastMode" then
    local actor = FH.getActorByUid(m_params.teamInfo, m_params.sequenceActor)
    local baseSeat = fif(actor, actor.baseSeat, -1)
    if m_autoFightCommands and 0 < baseSeat then
      local gameRound = CS.FightLuaLogic.Instance.GameRound
      local weaponCommands = m_autoFightCommands.weaponPrevious
      for i = 1, #weaponCommands do
        local w = weaponCommands[i]
        if w.round == gameRound and w.seat == baseSeat then
          table.remove(weaponCommands, i)
          return w.command
        end
      end
      local command = m_autoFightCommands["seat" .. baseSeat]
      local skillIndex = command[gameRound]
      return skillIndex
    end
  end
end

function RecordSkillIndex(recordIndex)
  if recordIndex and m_autoFightCommands then
    local actor = FH.getActorByUid(m_params.teamInfo, m_params.sequenceActor)
    local baseSeat = fif(actor, actor.baseSeat, -1)
    if 0 < baseSeat then
      local currentRound = CS.FightLuaLogic.Instance.GameRound
      if recordIndex >= DEFINE.PreDefinedCommand.WeaponCommandBase and recordIndex < DEFINE.PreDefinedCommand.WeaponCommandLimit then
        table.insert(m_autoFightCommands.weapon, {
          round = currentRound,
          command = recordIndex,
          seat = baseSeat
        })
      else
        local commands = m_autoFightCommands["seat" .. baseSeat]
        commands[currentRound] = recordIndex
        for i = currentRound - 1, 1, -1 do
          if commands[i] then
            break
          end
          commands[i] = 0
        end
      end
      if CS.SceneFight.s_Standalone then
        WU.SetGameDataCache("/Fight/CommandSequences" .. m_params.dungeonId, m_autoFightCommands)
      end
    end
  end
end

function SpeedUpRefresh()
  local speed_val = m_autoData["2"]
  if m_params.isSpeedUp then
    speed_val = 1
    REF.SpeedAdd.UISprite.spriteName = "chat_speed_on"
  else
    speed_val = 0
    REF.SpeedAdd.UISprite.spriteName = "chat_speed_off"
  end
  m_autoData["2"] = speed_val
  this:SetData("fci/autoFightSetting/", m_autoData)
end

function OnBtnSpeedAdd()
  local baseInfo = this:GetData("fci/baseinfo/")
  if baseInfo ~= nil then
    local unlockLevel = PB.all("Misc"):first().unlockFightSpeedLevel
    if unlockLevel > baseInfo.level then
      WU.ShowHintText(WU.GetString("WindowUnlock_Hint", WU.GetString("UnlockType_90"), unlockLevel))
      return
    end
  end
  if m_params.isSpeedUp then
    local sceneFight = CS.SceneFight.Instance
    if sceneFight and not sceneFight:IsGamePause() then
      CS.GameTime.timeScale = 1.0
    end
  end
  m_params.isSpeedUp = not m_params.isSpeedUp
  SpeedUpRefresh()
end

function OnBtnAutoFight()
  if m_params.skipNeedShow and REF.BtnSkipRound.UISprite.graify then
    CS.UIWindowHelp.ChangeUIWidgetEnable(REF.BtnSkipRound.gameObject, true)
  end
  if AutoFightCheck() then
    TLog.CollectButtonClick("autoBattle")
    m_params.isAutoFight = not m_params.isAutoFight
    AutoFightRefresh()
  end
end

function AutoFightCheck()
  local dungeonType = m_params.dungeonType
  if dungeonType == PB.enum.DungeonType.Training then
    WU.ShowHintText(WU.GetString("Training_dungeon_auto_fighting_locked"))
    return false
  elseif dungeonType == PB.enum.DungeonType.Story then
    WU.ShowHintText(WU.GetString("Story_dungeon_auto_fighting_locked"))
    return false
  elseif dungeonType == PB.enum.DungeonType.Challenge then
    WU.ShowHintText(WU.GetString("ChallengeDungeonAutoFightingLocked"))
    return false
  end
  local baseInfo = this:GetData("fci/baseinfo/")
  if baseInfo ~= nil and WU.WindowIsLocked(PB.enum.UnlockWindow.AutoFight, PB.enum.UnlockWindow.AutoFight) then
    return false
  end
  return true
end

function OnFightRunAI()
  local skillIndex = GetCurrentSkillIndex()
  local skillGroupList = m_params.skillGroupList
  if skillIndex and 0 < skillIndex then
    if skillIndex == DEFINE.PreDefinedCommand.SkipCommand then
      CS.FightLuaLogic.Instance.mFightRoundSandBox.SendUseCard(0, 0, 0, nil, 0)
      return
    elseif skillIndex >= DEFINE.PreDefinedCommand.WeaponCommandBase and skillIndex < DEFINE.PreDefinedCommand.WeaponCommandLimit then
      local uniqueId = DEFINE.WeaponCommand(true, skillIndex)
      if TryClickWeapon(m_params.weaponBtnInfos[uniqueId], skillIndex) then
        return
      end
    elseif TryClickSkill(skillGroupList[skillIndex]) then
      return
    end
  end
  if TryClickSkill(skillGroupList[3]) then
    return
  end
  if TryClickSkill(skillGroupList[5]) then
    return
  end
  if TryClickSkill(skillGroupList[6]) then
    return
  end
  if TryClickSkill(skillGroupList[7]) then
    return
  end
  if TryClickSkill(skillGroupList[8]) then
    return
  end
  local val = math.random(1, 2)
  if val == 1 then
    if TryClickSkill(skillGroupList[2]) then
      return
    end
    if TryClickSkill(skillGroupList[4]) then
      return
    end
  elseif val == 2 then
    if TryClickSkill(skillGroupList[4]) then
      return
    end
    if TryClickSkill(skillGroupList[2]) then
      return
    end
  end
  if TryClickSkill(skillGroupList[1]) then
    return
  end
  CS.FightLuaLogic.Instance.mFightRoundSandBox.SendUseCard(0, 0, 0, nil, 0)
end

function TryClickWeapon(info, index)
  if info and info:IsEnableClick() then
    local ref = _ENV["$"](info.btn)
    CS.FightLuaLogic.Instance.mFightRoundSandBox.CastSkillOrWeapon(ref, info, index)
    return true
  end
  return false
end

function TryClickSkill(info)
  if info and info:IsEnableClick() and info.baseY > -1000 and not _ENV["$"](info.btn).SkillSetting.gameObject.activeSelf then
    local index = table.find(m_params.skillGroupList, function(i, v)
      return v == info
    end)
    CS.FightLuaLogic.Instance.mFightRoundSandBox.SendUseCard(info.cardIndex, info.scardIndex, info.linkIndex, info.cardList, 0, index or 0)
    return true
  end
  return false
end
