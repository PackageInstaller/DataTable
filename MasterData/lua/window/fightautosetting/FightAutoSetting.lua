local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local FH = require("Logic/HelpLogic")
local DEFINE = require("Logic/Define")
local SE = require("Common/SkillEffect")
local m_autoBtnTable = {}
local m_autoBtnList = {}
local autoData, m_autoFightMode, m_dungeonId

local function WeaponAppendCommandHolder(commandInfos, weaponsCommand, isPrevious)
  if weaponsCommand == nil then
    return
  end
  for i = 1, #weaponsCommand do
    local data = weaponsCommand[i]
    local _, e = table.find(commandInfos, function(_, v)
      return v.round == data.round
    end)
    if e then
      do
        local _, roundInfo = table.find(e, function(_, v)
          return v.upDownIndex == data.seat
        end)
        if roundInfo then
          local commandHolder = roundInfo.command
          local uniqueId = DEFINE.WeaponCommand(true, data.command)
          local teamInfo = this:GetData("Fight/SelfTeamInfo")
          if teamInfo then
            local roundActorInfo = FH.getActorByUid(teamInfo, uniqueId)
            if roundActorInfo then
              table.insert(commandHolder.weapons, {
                id = roundActorInfo.actorInfo.id,
                skin = roundActorInfo.actorInfo.uniqueWeaponSkin or 0,
                isPrevious = isPrevious
              })
            end
          end
        end
      end
    end
  end
end

function SetupWindow()
  for j = 1, 3 do
    REF["AutoOneActor" .. j].gameObject:SetActive(false)
    REF["CommandOneActor" .. j].gameObject:SetActive(false)
    for i = 1, 5 do
      local ref_btn = _ENV["$"](_ENV["$"](_ENV["$"](REF["AutoOneActor" .. j]).AutoAllSkillGrid)["AutoBtnSkill_" .. i])
      local key_name = "AutoBtnSkill_" .. j .. "_" .. i
      ref_btn["$"].gameObject.name = key_name
      WU.BindButtonEvent(ref_btn["$"], OnAutoSkillClick)
    end
  end
  REF.AutoLabelSkillName.UILabel.text = ""
  REF.AutoLabelCurrentDesc.UIHtmlLabel.text = ""
  REF.AutoLabelKind.UILabel.text = ""
  WU.BindButtonEvent(REF.SkillAutoExit, OnUIExit)
  WU.BindKeyEvent(REF.SkillAutoExit, OnUIExit)
  WU.BindButtonEvent(REF.SwitchBtn, function()
    local configPrefix = this:GetData("playerId") or ""
    if WU.GetGameDataCache(configPrefix .. "/Fight/CommandSequences" .. m_dungeonId) then
      m_autoFightMode = m_autoFightMode % 2 + 1
      this:BroadcastGameEvent("SwitchAutoFightMode", m_autoFightMode)
      SetMode(m_autoFightMode)
    else
      WU.ShowHintText(WU.GetString("Fight_AutoSettingSwitchFailed"))
    end
  end)
  WU.SetActive(REF.SwitchBtn, FH.enableAutoFightCommandMode(this:GetData("FightDungeonType")))
end

function SetMode(mode)
  m_dungeonId = this:GetData("WindowDungeon/DungeonId")
  m_autoFightMode = mode
  REF.SwitchLabel.UILabel.text = fif(m_autoFightMode == 1, WU.GetString("FightAutoSetting_AutoCastMode"), WU.GetString("FightAutoSetting_CommandCastMode"))
  WU.SetActive(REF.CommandCastMode, m_autoFightMode == 2)
  WU.SetActive(REF.AutoCastMode, m_autoFightMode == 1)
  if m_autoFightMode == 1 then
    AutoCastMode()
  elseif m_autoFightMode == 2 then
    OnCommandSequence(this:GetData("Fight/CommandSequenceTemp"))
  end
end

function OnCommandSequence(commands)
  if commands == nil or m_autoFightMode ~= 2 then
    return
  end
  local configPrefix = this:GetData("playerId") or ""
  local oldCommands = WU.GetGameDataCache(configPrefix .. "/Fight/CommandSequences" .. m_dungeonId)
  local player_table = this:GetData("FightCommandSettingPlayer")
  local commandInfos = {}
  for j = 1, #player_table do
    local ref = _ENV["$"](REF["CommandOneActor" .. j])
    local path_table = player_table[j][2]
    local sequence = player_table[j][3]
    local uid = player_table[j][5]
    local groupTable = player_table[j][4]
    local actorList = groupTable[1]
    local baseSeat
    for i = 1, #actorList do
      local roundActorInfo = actorList[i][1]
      if not roundActorInfo.isAssist then
        baseSeat = roundActorInfo.baseSeat
      end
    end
    if path_table[1] ~= "" then
      ref.Commandheadmain.UITexture.mainTexturePath = path_table[1]
    else
      ref.Commandheadmain.gameObject:SetActive(false)
    end
    if path_table[2] ~= "" then
      ref.Commandheadlink.UITexture.mainTexturePath = path_table[2]
    else
      ref.Commandheadlink.gameObject:SetActive(false)
    end
    ref.Commandposition.gameObject:SetActive(sequence and sequence ~= 0)
    ref.Commandposition.UISprite.spriteName = "position_0" .. sequence
    local percent = this:GetData("FightUIActorHP_" .. uid)
    if percent == nil then
      percent = 0
    end
    ref.CommandHpval.UISprite.fillAmount = percent
    local info_table = player_table[j][1]
    local currentSequence = commands["seat" .. tonumber(baseSeat)]
    local oldSequence = oldCommands["seat" .. tonumber(baseSeat)]
    for i = 1, #currentSequence do
      local sequenceIndex = currentSequence[i]
      local commandHolder = {}
      local info = info_table[sequenceIndex]
      if info then
        commandHolder.texturePath = info[5]
        commandHolder.kindIcon = info[6]
        commandHolder.useSp = info[8]
      end
      commandHolder.index = sequenceIndex
      commandHolder.isChanged = oldSequence == nil or sequenceIndex ~= oldSequence[i]
      commandHolder.weapons = commandHolder.weapons or {}
      local roundInfo = commandInfos[i] or {}
      roundInfo.round = i
      table.insert(roundInfo, {command = commandHolder, upDownIndex = j})
      commandInfos[i] = roundInfo
    end
    WU.SetActive(ref["$gameObject"], true)
  end
  WeaponAppendCommandHolder(commandInfos, commands.weaponPrevious, true)
  WeaponAppendCommandHolder(commandInfos, commands.weapon, false)
  REF.ScrollViewNode["$SetData"](commandInfos, #player_table)
end

function AutoCastMode()
  autoData = this:GetData("fci/autoFightSetting/")
  if autoData == nil then
    autoData = {}
  end
  REF.AutoLabelSkillName.UILabel.text = ""
  REF.AutoLabelCurrentDesc.UIHtmlLabel.text = WU.GetString("FIGHT_AUTOSET_TIP")
  REF.AutoLabelKind.UILabel.text = ""
  local player_table = this:GetData("FightAutoSettingPlayer")
  local leftTeam = this:GetData("FightAutoSettingTeam")
  m_autoBtnTable = {}
  m_autoBtnList = {}
  for j = 1, #player_table do
    local path_table = player_table[j][2]
    local sequence = player_table[j][3]
    local uid = player_table[j][5]
    local player_head = _ENV["$"](_ENV["$"](REF["AutoOneActor" .. j]).AutoPlayer)
    if path_table[1] ~= "" then
      player_head.Autoheadmain.UITexture.mainTexturePath = path_table[1]
    else
      player_head.Autoheadmain.gameObject:SetActive(false)
    end
    if path_table[2] ~= "" then
      player_head.Autoheadlink.UITexture.mainTexturePath = path_table[2]
    else
      player_head.Autoheadlink.gameObject:SetActive(false)
    end
    if sequence == nil or sequence == 0 then
      player_head.Autoposition.gameObject:SetActive(false)
    else
      player_head.Autoposition.UISprite.spriteName = "position_0" .. sequence
      player_head.Autoposition.gameObject:SetActive(true)
    end
    local percent = this:GetData("FightUIActorHP_" .. uid)
    if percent == nil then
      percent = 0
    end
    player_head.AutoHpval.UISprite.fillAmount = percent
    local info_table = player_table[j][1]
    for i = 1, #info_table do
      local ref_btn = _ENV["$"](_ENV["$"](_ENV["$"](REF["AutoOneActor" .. j]).AutoAllSkillGrid)["AutoBtnSkill_" .. i])
      local key_name = ref_btn["$"].gameObject.name
      local list = info_table[i][1]
      local uniqueID = -1
      local actorID = 0
      if 0 < #list then
        uniqueID = list[1][1]
        actorID = list[1][2]
      end
      local result = GetSkillTipInfo(leftTeam, uniqueID)
      local tipSkillID = 0
      local tipLinkID = 0
      if info_table[i][4] ~= 0 then
        tipLinkID = info_table[i][4]
      else
        local skill_info = PB.get("ActorCombo", actorID, info_table[i][2], info_table[i][3])
        if skill_info ~= nil then
          tipSkillID = skill_info.placeIndex
        end
      end
      local index = FH.getAutoSettingKey(info_table[i][4], actorID, info_table[i][2], info_table[i][3])
      m_autoBtnTable[key_name] = {
        result[1],
        tipSkillID,
        tipLinkID,
        player_table[j][4][2],
        result[2],
        result[3],
        index
      }
      if result[1] ~= nil then
        table.insert(m_autoBtnList, ref_btn["$"].gameObject)
      end
      local tex_path = info_table[i][5]
      local have_card = tex_path ~= nil
      ref_btn.SkillIconTexture.UITexture.mainTexturePath = tex_path
      ref_btn.SkillIconTexture.gameObject:SetActive(tex_path ~= nil)
      ref_btn.SkillDescribe.UISprite.spriteName = info_table[i][6]
      ref_btn.SkillDescribe.gameObject:SetActive(have_card)
      if i == 3 then
        ref_btn.SkillBg.UISprite.spriteName = "fight_skill_bg_2"
      else
        ref_btn.SkillBg.UISprite.spriteName = "fight_skill_bg_1"
      end
      if not have_card then
        ref_btn.SkillBg.UISprite.spriteName = "fight_skill_bg_3"
      end
      ref_btn.SkillBg.UISprite:MakePixelPerfect()
      local num = info_table[i][7]
      ref_btn.SkillEnergyLabel.UILabel.text = num
      if info_table[i][8] == 1 then
        ref_btn.SkillEnergyLabel.UILabel.color = CS.NGUIMath.HexToColor(16777215)
      elseif info_table[i][8] == 2 then
        ref_btn.SkillEnergyLabel.UILabel.color = CS.NGUIMath.HexToColor(4294902015)
      end
      ref_btn.SkillUseLabel.UILabel.text = ""
      ref_btn.SkillLock.gameObject:SetActive(false)
      ref_btn.SkillSetting.gameObject:SetActive(false)
    end
    REF["AutoOneActor" .. j].gameObject:SetActive(true)
  end
  RefreshAutoFightAdvSetting()
end

function OnAutoSkillClick(obj)
  local skill_info = m_autoBtnTable[obj.name]
  if skill_info == nil then
    return
  end
  local result_info = GetSkillTipDesc(skill_info[1], skill_info[2], skill_info[3], skill_info[4], skill_info[5], skill_info[6])
  REF.AutoLabelSkillName.UILabel.text = result_info[1]
  REF.AutoLabelCurrentDesc.UIHtmlLabel.text = result_info[2]
  REF.AutoLabelKind.UILabel.text = result_info[3]
  if result_info[1] ~= "" then
    local index = skill_info[7]
    if autoData[index] == nil or autoData[index] == 0 then
      autoData[index] = 1
      _ENV["$"](obj).SkillSetting.gameObject:SetActive(true)
    else
      autoData[index] = 0
      _ENV["$"](obj).SkillSetting.gameObject:SetActive(false)
    end
    this:SetData("fci/autoFightSetting/", autoData)
    this:BroadcastGameEvent("OnFightAutoSetting")
  end
end

function RefreshAutoFightAdvSetting()
  for i = 1, #m_autoBtnList do
    local btn = m_autoBtnList[i]
    local info = m_autoBtnTable[btn.name]
    if info ~= nil then
      local index = info[7]
      if autoData[index] == nil or autoData[index] == 0 then
        _ENV["$"](btn).SkillSetting.gameObject:SetActive(false)
      else
        _ENV["$"](btn).SkillSetting.gameObject:SetActive(true)
      end
    end
  end
end

function OnUIExit()
  local sceneFight = CS.SceneFight.Instance
  if sceneFight ~= nil then
    sceneFight:PauseGame(false)
  end
  this:BroadcastGameEvent("OnFightGamePause")
  WU.RecycleWindow(this)
end

function GetSkillTipDesc(skillActor, skillID, linkID, totalStar, buffIndex, speacialIndex)
  local tip_skillName = ""
  local tip_skillDesc = ""
  local tip_skillKind = ""
  local tip_skillLevel = ""
  if linkID ~= 0 then
    local link_info = PB.get("ActorLink", linkID)
    tip_skillName = WU.GetString("Window_ActorLinkName_" .. link_info.linkID)
    tip_skillDesc = AU.GetActorLinkDesc(link_info.linkID, totalStar + 1, "#72e6ff", buffIndex + 1, speacialIndex + 1)
    tip_skillKind = WU.GetString(link_info.kindIcon)
    tip_skillLevel = WU.GetString("Window_ActorRelationSkill")
  elseif skillID ~= 0 then
    local m_skills = SE.GetActorSkills(skillActor.id)
    if 0 < #m_skills then
      local m_skillDesc = SE.GetSkillDetail(skillActor, m_skills[skillID], "#72e6ff", buffIndex + 1, speacialIndex + 1)
      tip_skillName = m_skillDesc.skillNames[1]
      for i = 1, #m_skillDesc.describes do
        tip_skillDesc = tip_skillDesc .. m_skillDesc.describes[i] .. "\n"
      end
      tip_skillLevel = WU.GetString("Window_Level", m_skillDesc.skillLevel)
    end
  end
  return {
    tip_skillName,
    tip_skillDesc,
    tip_skillKind,
    tip_skillLevel
  }
end

function GetSkillTipInfo(teamInfo, uniqueID)
  if teamInfo == nil then
    return {
      nil,
      0,
      0
    }
  else
    for i = 1, #teamInfo.playerList do
      local actorList = teamInfo.playerList[i].actorList
      for k = 1, #actorList do
        if uniqueID == actorList[k].uniqueID then
          return {
            actorList[k].actorInfo,
            actorList[k].buffIndex,
            actorList[k].specialIndex
          }
        end
      end
    end
  end
  return {
    nil,
    0,
    0
  }
end
