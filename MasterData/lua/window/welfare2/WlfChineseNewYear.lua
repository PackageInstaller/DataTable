local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local m_gameReceiveFood
local m_dungeonTeamWelfareLimitLv = PB.all("Misc")[1].dungeonTeamWelfareLimitLv

function Start()
  WU.BindButtonEvent(REF.BtnDungeon, OnBtnDungeonClick)
  WU.BindButtonEvent(REF.BtnMinGame, OnBtnMiniGameClick)
  WU.BindButtonEvent(REF.BtnHotPot, OnBtnHotPotClick)
  WU.BindButtonEvent(REF.BtnTeam, OnBtnTeamClick)
end

function OnEnable()
  RU.SetRedMark("Welfare/ChineseNewYear/First", false)
  WU.RecordFirstTimeInClient("Welfare2019CNY")
  RU.BindRedMark(this, "Welfare/ChineseNewYear/Reward", function(flag)
    WU.SetActive(_ENV["$"](REF.BtnDungeon).SpriteRed, flag)
  end)
  RU.BindRedMark(this, "Welfare/ChineseNewYear/MiniGame", function(flag)
    m_gameReceiveFood = flag
    WU.SetActive(_ENV["$"](REF.BtnMinGame).SpriteRed, flag)
    WU.SetActive(REF.TextureGameClose, not flag)
  end)
  RU.BindRedMark(this, "Welfare/ChineseNewYear/HotPot", function(flag)
    WU.SetActive(_ENV["$"](REF.BtnHotPot).SpriteRed, flag)
  end)
  RU.BindRedMark(this, "Welfare/ChineseNewYear/Team", function(flag)
    WU.SetActive(_ENV["$"](REF.BtnTeam).SpriteRed, flag)
  end)
end

function OnBtnHotPotClick()
  DoSthWithDifferentStatus(PB.enum.ActivityType.Cooking, "HotPotDining")
end

function OnBtnMiniGameClick()
  if m_gameReceiveFood then
    DoSthWithDifferentStatus(PB.enum.ActivityType.MiniGame_CatchItem, "GameReceiveFood")
  else
    WU.ShowHintText(WU.GetString("ReceiveFood_GameNotTriggered"))
  end
end

function OnBtnDungeonClick()
  DoSthWithDifferentStatus(PB.enum.ActivityType.ChineseNewYear, "EventCNYStage")
end

function OnBtnTeamClick()
  DoSthWithDifferentStatus(PB.enum.ActivityType.DungeonTeamWelfare, "DungeonTeamWelfare")
end

function DoSthWithDifferentStatus(activityType, windowName)
  local activities = m_activityManager.GetActivitiesByTypeSync(activityType) or _ENV["!"]({})
  local realActivities
  if activityType == PB.enum.ActivityType.ChineseNewYear then
    realActivities = _ENV["!"](activities):where(function(k, v)
      return v.category == PB.enum.ActivityCategory.Dungeon
    end):toarray()
  else
    realActivities = activities
  end
  if #realActivities == 0 then
    WU.ShowHintText(WU.GetString("Window_GachaToBeOpened"))
    return
  end
  local statusMap = _ENV["!"]({})
  for i = 1, #realActivities do
    table.insert(statusMap, ACU.GetStatus(realActivities[i]))
  end
  local open = table.has(statusMap, PB.enum.ActivityStatus.Started)
  if open then
    if windowName == "DungeonTeamWelfare" then
      local playerLv = this:GetData("fci/baseinfo/").level
      if playerLv >= m_dungeonTeamWelfareLimitLv then
        this:GameRequest("fci/teamdungeongroups/"):Get(function(result)
          this:SetData("fci/teamdungeongroups/", result)
          this:SetData("DungeonTeamType", PB.enum.ActivityType.DungeonTeamWelfare)
          WU.AcquireWindowAsync("DungeonTeam")
        end)
        return
      else
        WU.ShowHintText(WU.GetString("WindowAccount_LevelLimit", m_dungeonTeamWelfareLimitLv))
        return
      end
    else
      WU.AcquireWindowAsync(windowName)
      return
    end
  end
  local pre = table.has(statusMap, PB.enum.ActivityStatus.PreHeat)
  if pre then
    WU.ShowHintText(WU.GetString("Window_GachaToBeOpened"))
    return
  end
  WU.ShowHintText(WU.GetString("Window_Activity_Close"))
end
