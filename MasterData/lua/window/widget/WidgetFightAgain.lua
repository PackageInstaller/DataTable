local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local PU = require("Common/PlatformUtil")
local ATU = require("Common/AutumnUtil")
local m_dungeonId, m_dungeonReward, m_selectedGroupId
local m_powerMultiple = 1
local m_leaveRequest
local m_restTimes = 0
local m_showPlayTimesLimit
local m_shareVideoMap = {}
local m_wheelMode = false
local m_wheelModeEntranceDungeonId, m_wheelModePrice, m_enterParam

function Awake()
  m_leaveRequest = {}
  m_leaveRequest[PB.enum.DungeonType.Normal] = "fci/dungeon/{Dungeon/DungeonUid}"
  m_leaveRequest[PB.enum.DungeonType.Story] = "fci/dungeon/{Dungeon/DungeonUid}"
  m_leaveRequest[PB.enum.DungeonType.Training] = "fci/dungeon/{Dungeon/DungeonUid}"
  m_leaveRequest[PB.enum.DungeonType.Challenge] = "fci/dungeon/{Dungeon/DungeonUid}"
  m_leaveRequest[PB.enum.DungeonType.WeekActivity] = "fci/activity-dungeon/{Dungeon/DungeonUid}"
  m_leaveRequest[PB.enum.DungeonType.SemiFixed] = "fci/semifixed-dungeon/{Dungeon/DungeonUid}"
  m_shareVideoMap[PB.enum.DungeonType.Normal] = true
  m_shareVideoMap[PB.enum.DungeonType.Story] = true
  m_shareVideoMap[PB.enum.DungeonType.Training] = true
  this:RegisterGameEvent("RePosAddStrangerGrid", function()
    REF.Grid.UIGrid:Reposition()
  end)
  WU.BindButtonEvent(REF.ButtonFightAgain, FightAgain)
  WU.BindButtonEvent(REF.ButtonAddTimes, OnButtonAddTimesClick)
  if REF.ButtonVideo then
    WU.BindButtonEvent(REF.ButtonVideo, function()
      WU.AcquireWindowAsync("RecordVideo")
    end)
  end
end

function SetContinueCall(call)
  WU.BindButtonEvent(REF.ButtonContinue, call)
  WU.BindButtonEvent(REF.ButtonContinue2, call)
end

function ShowNodePower(show)
  WU.ToggleRendering(REF.NodePower, show)
end

function CalcAuraAttrs(param)
  local fightActorInfo = this:GetData("FightActorInfo")
  local temp = {}
  for i = 1, #fightActorInfo[1].actors do
    local actor = fightActorInfo[1].actors[i]
    if actor ~= nil and not table.empty(actor) and actor.uid and actor.uid > 0 then
      temp[i] = this:GetData("fci/actor/" .. actor.uid)
    else
      temp[i] = {}
    end
  end
  fightActorInfo[1].actors = temp
  this:SetData("FightActorInfo", fightActorInfo)
  this:BroadcastGameEvent("MedalAttrAppend")
  param.price = fif(m_wheelMode, m_wheelModePrice, DU.GetDungeonPrice(m_dungeonId))
  this:SetData("WindowDungeon/EnterParam", param)
end

function SetRestTimes(chapter)
  REF.ButtonAddTimes.gameObject:SetActive(chapter ~= nil)
  if chapter then
    m_showPlayTimesLimit = m_dungeonReward and m_dungeonReward.enterTimes > 0
    REF.ButtonAddTimes.gameObject:SetActive(m_showPlayTimesLimit)
    if m_showPlayTimesLimit then
      local dungeonRecord = chapter.recordDungeons[m_dungeonId]
      if dungeonRecord then
        m_restTimes = math.max(0, m_dungeonReward.enterTimes - dungeonRecord.doneTimes)
        REF.SpriteAddTimes.gameObject:SetActive(m_restTimes <= 0)
        REF.LabelRestTimes.UILabel.text = m_restTimes
      end
    end
    REF.ButtonAddTimes.UIButton.isEnabled = m_restTimes <= 0
    REF.NodePower.UIGrid:Reposition()
  end
end

function SetEventRestTimes(dungeonId, record)
  local records = record
  local _, dungeonRecord = table.find(records, function(_, v)
    return v.dungeonId == dungeonId
  end)
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  if dungeonRecord == nil then
    dungeonRecord = {
      finished = false,
      multiPower = 0,
      targetsDone = {},
      doneTimes = 0
    }
  end
  m_showPlayTimesLimit = dungeonReward and 0 < dungeonReward.enterTimes
  WU.ToggleRendering(REF.ButtonAddTimes, dungeonRecord ~= nil and m_showPlayTimesLimit)
  if dungeonRecord and m_showPlayTimesLimit then
    m_restTimes = math.max(0, dungeonReward.enterTimes - dungeonRecord.doneTimes)
    REF.LabelRestTimes.UILabel.text = m_restTimes
    REF.SpriteAddTimes.gameObject:SetActive(m_restTimes <= 0)
    REF.ButtonAddTimes.UIButton.isEnabled = m_restTimes <= 0
    REF.ButtonAddTimes.BoxCollider2D.enabled = m_restTimes <= 0
  end
end

function OnButtonAddTimesClick()
  if IsInEventStage() then
    WU.ShowHintText(WU.GetString("Error_DungeonDoneTimes"))
  else
    WU.Exchange(PB.enum.ResourceType.ResDungeonPlayTimesLimit, m_dungeonId, true)
  end
end

function Start()
  m_enterParam = this:GetData("WindowDungeon/EnterParam") or {}
  m_wheelMode = m_enterParam.wheelMode
  m_wheelModePrice = m_enterParam.price
  m_wheelModeEntranceDungeonId = m_enterParam.dungeonId
  REF.ButtonFightAgain.gameObject:SetActive(false)
  REF.NodePower.gameObject:SetActive(false)
  this:RegisterGameEvent("RecordVideoExit", function(b)
    REF.ButtonVideo.gameObject:SetActive(not b)
  end)
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  m_dungeonId = dungeonId
  m_dungeonReward = PB.get("DungeonReward", m_dungeonId)
  local type = this:GetData("FightDungeonType")
  m_restTimes = 0
  local listRecord = this:GetData("RecordVideoList")
  local preferences = m_configDataManager.GetPreferences()
  if not PU.IsRecordVideoEnabled() or listRecord == nil or #listRecord == 0 or m_shareVideoMap[type] == nil then
    REF.ButtonVideo.gameObject:SetActive(false)
  else
    REF.ButtonVideo.gameObject:SetActive(true)
  end
  local isShowStar = DU.IsShowStar(m_dungeonId)
  if m_leaveRequest[type] then
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.FightAgain, nil) then
      REF.NodePower.gameObject:SetActive(true)
      REF.ButtonFightAgain.gameObject:SetActive(isShowStar)
      local chapterId = this:GetData("WindowDungeon/ChapterId")
      if chapterId then
        this:Bind("fci/dungeon/chapter/" .. chapterId, function(chapter)
          SetRestTimes(chapter)
        end)
      elseif IsInEventStage() then
        this:Bind("fci/event-dungeon/record/", function(record)
          SetEventRestTimes(m_dungeonId, record)
        end)
      else
        SetRestTimes(nil)
      end
      this:RegisterGameEvent("ResourceExchangeSucceed", OnResourceExchangeSucceed)
    end
  else
    REF.ButtonFightAgain.gameObject:SetActive(false)
  end
  REF.WidgetPowerList.gameObject:SetActive(isShowStar)
  SwitchMultiPower(true)
  if type == PB.enum.DungeonType.Normal or type == PB.enum.DungeonType.WeekActivity then
    REF.LabelContinue.UILabel.text = WU.GetString("Window_ContinueChallenge")
  else
    REF.LabelContinue.UILabel.text = WU.GetString("Window_Back")
  end
  REF.NodePower.UIGrid:Reposition()
  if (REF.NodePower.gameObject.activeSelf == false or REF.WidgetPowerList.gameObject.activeSelf == false and REF.ButtonAddTimes.gameObject.activeSelf == false) and REF.ButtonFightAgain.gameObject.activeSelf == false then
    REF.BtnPanelMulti.gameObject:SetActive(false)
    REF.BtnPanelSingle.gameObject:SetActive(true)
  else
    REF.BtnPanelMulti.gameObject:SetActive(true)
    REF.BtnPanelSingle.gameObject:SetActive(false)
  end
end

function SwitchMultiPower(enable)
  REF.ButtonMultiPower.UIButton.isEnabled = enable
  REF.SpriteMultiPower.UISprite.alpha = fif(enable, 1, 0.3)
end

function OnResourceExchangeSucceed(buy)
  if buy.type == PB.enum.ResourceType.ResDungeonPlayTimesLimit then
    local chapterId = this:GetData("WindowDungeon/ChapterId")
    local chapterInfo = this:GetData("fci/dungeon/chapter/" .. chapterId)
    chapterInfo.recordDungeons[m_dungeonId].doneTimes = chapterInfo.recordDungeons[m_dungeonId].doneTimes - buy.count
    this:SetData("fci/dungeon/chapter/" .. chapterId, chapterInfo)
  end
end

function SetSelectedGroupId(id)
  m_selectedGroupId = id
end

function IsInEventStage()
  local acType = this:GetData("Event/ActivityType")
  return acType ~= nil
end

function SelectedGroupIdValidate(type)
  if m_selectedGroupId == nil then
    error("WidgetFightAgain", "DungeonType -> " .. tostring(type) .. " SelectedGroupId is nil?")
    return false
  end
  return true
end

function EnterDungeon()
  local type = this:GetData("FightDungeonType")
  m_powerMultiple = REF.WidgetPowerList["$GetPowerMultiple"]()
  local acType = this:GetData("Event/ActivityType")
  if acType then
    if not SelectedGroupIdValidate(acType) then
      return
    end
    local activityId = this:GetData("Event/ActivityId")
    local param = {
      selectActorGroupId = m_selectedGroupId,
      dungeonId = fif(m_wheelMode, m_wheelModeEntranceDungeonId, m_dungeonId),
      activityId = activityId,
      activityType = acType,
      multiPower = m_powerMultiple,
      wheelMode = m_wheelMode,
      wheelModeBalanceDungeonId = m_enterParam.wheelModeBalanceDungeonId,
      price = m_enterParam.price or DU.GetDungeonPrice(m_dungeonId)
    }
    this:SetData("PowerMultiple", m_powerMultiple)
    CalcAuraAttrs(param)
    local wireFormatTable = ProtobufT("ApiEventDungeon", param)
    this:GameRequest("fci/event-dungeon/"):Post(wireFormatTable, function(response)
      WU.EnterGameLevel(response.dungeonUid, response.baseInfo, fif(m_wheelMode, m_wheelModeEntranceDungeonId, m_dungeonId), type, 1, false)
    end)
    return
  end
  if type == PB.enum.DungeonType.Normal then
    if not SelectedGroupIdValidate(type) then
      return
    end
    local param = {
      dungeonId = m_dungeonId,
      selectActorGroupId = m_selectedGroupId,
      multiPower = m_powerMultiple,
      isChallengeMode = this:GetData("IsCultivationPVPMode"),
      reduceInfo = DU.CultivationPVPRatioConvert(this:GetData("fci/ActorGroup")[tostring(m_selectedGroupId)].members, this:GetData("ActorGroup/CurrentCultivationRatios/" .. m_dungeonId))
    }
    this:SetData("PowerMultiple", m_powerMultiple)
    CalcAuraAttrs(param)
    this:GameRequest("fci/dungeon/"):Post(param, function(result)
      this:SetData("EnteredChapterId", this:GetData("WindowDungeon/ChapterId"))
      DBH.ResChange(result.resChange)
      WU.EnterGameLevel(result.dungeonUid, result.baseInfo, m_dungeonId, type, 1, true)
    end)
  elseif type == PB.enum.DungeonType.WeekActivity then
    if not SelectedGroupIdValidate(type) then
      return
    end
    local currentType = this:GetData("Activity/CurrentType")
    local currentActivityId = this:GetData("Activity/CurrentMaterialId")
    local param = {
      activityId = currentActivityId,
      activityType = currentType,
      dungeonId = m_dungeonId,
      selectActorGroupId = m_selectedGroupId,
      multiPower = m_powerMultiple
    }
    this:SetData("PowerMultiple", m_powerMultiple)
    CalcAuraAttrs(param)
    this:GameRequest("fci/activity-dungeon/"):Post(param, function(response)
      DBH.ResChange(response.resChange)
      WU.EnterGameLevel(response.dungeonUid, response.baseInfo, m_dungeonId, type, 1, false)
    end)
  elseif type == PB.enum.DungeonType.Story or type == PB.enum.DungeonType.Training or type == PB.enum.DungeonType.Challenge then
    WU.EnterStoryDungeon(m_dungeonId, nil, nil, type)
  elseif type == PB.enum.DungeonType.SemiFixed then
    local param = {
      dungeonId = m_dungeonId,
      multiPower = m_powerMultiple,
      activityId = this:GetData("SemiFixed/ActivityId"),
      activityType = PB.enum.ActivityType.Carnival91
    }
    this:SetData("PowerMultiple", m_powerMultiple)
    CalcAuraAttrs(param)
    this:GameRequest("fci/semifixed-dungeon/"):Post(param, function(result)
      DBH.ResChange(result.resChange)
      WU.EnterGameLevel(result.dungeonUid, result.baseInfo, m_dungeonId, type, 1, true)
    end)
  end
end

function FightAgain()
  if m_showPlayTimesLimit and m_restTimes <= 0 then
    if IsInEventStage() then
      WU.ShowHintText(WU.GetString("Error_DungeonDoneTimes"))
    else
      WU.ShowMessageYesNo(WU.GetString("Window_AskToBuyPlayTimes"), function(result)
        if result == "YES" then
          OnButtonAddTimesClick()
        end
      end)
    end
  else
    local function fightAgain()
      this:SetData("FightInfo/Aura", nil)
      
      local dungeonType = this:GetData("FightDungeonType")
      local url = m_leaveRequest[dungeonType]
      if IsInEventStage() then
        url = "fci/event-dungeon/{Dungeon/DungeonUid}"
      end
      if url then
        DB:GameRequest(url):Delete(function(response)
          local fightData = this:GetData("FightAgainInfo")
          if fightData then
            local actorList = {}
            for i, v in ipairs(fightData[1].actors) do
              local actor
              if v.uid and v.uid > 0 then
                actor = this:GetData("fci/actor/" .. v.uid)
                if actor == nil then
                  warning("Debug", "actor is nil ,need check uid:" .. v.uid)
                end
              end
              if actor == nil then
                actor = {}
              end
              actorList[i] = actor
            end
            fightData[1].actors = actorList
          else
            fightData = {
              {
                playerId = this:GetData("playerId"),
                actors = {
                  {},
                  {},
                  {},
                  {},
                  {},
                  {}
                }
              }
            }
          end
          this:SetData("FightActorInfo", fightData)
          EnterDungeon()
        end)
      end
    end
    
    local price = fif(m_wheelMode, m_wheelModePrice, DU.GetDungeonPrice(m_dungeonId))
    local cnt = REF.WidgetPowerList["$GetPowerMultiple"]()
    if DU.IsPriceLegal(price) then
      WU.TryToPay(price.type, price.id, cnt * price.count, fightAgain, function()
        WU.ShowMessageYesNo(WU.GetString("ActorGroup_PowerNotEnough"), function(result)
          if result == "YES" then
            WU.Exchange(PB.enum.ResourceType.ResPlayerPower)
          end
        end)
      end)
    else
      fightAgain()
    end
  end
end
