local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")

function Start()
  WU.BindButtonEvent(REF.BtnGoodShop, function()
    this:SetData("EventActivityExchange/ShopId", 23)
    WU.AcquireWindowAsync("EventActivityExchange")
  end)
  WU.BindButtonEvent(REF.BtnBuffShop, function()
    this:SetData("Welfare/ActivityType", PB.enum.ActivityType.Christmas)
    WU.AcquireWindowAsync("Carnival91Pass")
  end)
  WU.BindButtonEvent(REF.BtnInvite, function()
    WU.AcquireWindowAsync("ChristmasParty")
  end)
  WU.BindButtonEvent(REF.BtnDungeon, function()
    local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.Christmas) or _ENV["!"]({})
    local dungeonList = _ENV["!"](activities):where(function(k, v)
      return v.category == PB.enum.ActivityCategory.Dungeon
    end):toarray()
    for i = 1, #dungeonList do
      if ACU.IsOpenForDoing(dungeonList[i]) then
        WU.AcquireWindowAsync("EventChristmasStage")
        return
      end
    end
    WU.ShowHintText(WU.GetString("Window_Activity_Close"))
  end)
  WU.BindButtonEvent(REF.BtnTask, function()
    local activity = m_activityManager.GetActivitySync(PB.enum.ActivityType.Task, 11016)
    if activity and ACU.IsOpenForDoing(activity) then
      WU.AcquireWindowAsync("ChristmasTask")
      return
    end
    activity = m_activityManager.GetActivitySync(PB.enum.ActivityType.Task, 11017)
    if activity and ACU.IsOpenForDoing(activity) then
      WU.AcquireWindowAsync("ChristmasTask")
      return
    end
    activity = m_activityManager.GetActivitySync(PB.enum.ActivityType.Task, 11018)
    if activity and ACU.IsOpenForDoing(activity) then
      WU.AcquireWindowAsync("ChristmasTask")
      return
    end
    WU.ShowHintText(WU.GetString("Window_Activity_Close"))
  end)
  WU.BindButtonEvent(REF.BtnMinGame, function()
    local gameActivity
    local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.Christmas) or _ENV["!"]({})
    local gameActivities = PB.all("ActivityMiniGames"):where(function(k, v)
      return v.gameId == 91001
    end)
    for i = 1, #activities do
      local _, v = table.find(gameActivities, function(k, v)
        return v.activityId == activities[i].activityId
      end)
      if v then
        gameActivity = activities[i]
        break
      end
    end
    if gameActivity == nil then
      WU.ShowHintText(WU.GetString("Window_GachaToBeOpened"))
      return
    end
    local gameStatus = ACU.GetStatus(gameActivity)
    if gameStatus == PB.enum.ActivityStatus.PreHeat or gameStatus == PB.enum.ActivityStatus.None then
      WU.ShowHintText(WU.GetString("Window_GachaToBeOpened"))
      return
    elseif gameStatus == PB.enum.ActivityStatus.Finished or gameStatus == PB.enum.ActivityStatus.Close then
      WU.ShowHintText(WU.GetString("Window_Activity_Close"))
      return
    end
    this:SetData("GameFlappy/ActivityId", gameActivity.activityId)
    this:SetData("GameFlappy/ActivityType", PB.enum.ActivityType.Christmas)
    WU.AcquireWindowAsync("GameFlappy")
  end)
end

function OnEnable()
  RU.SetRedMark("Welfare/Christmas/First", false)
  WU.RecordFirstTimeInClient("Welfare2018Christmas")
  RU.BindRedMark(this, "Welfare/Christmas/Reward", function(flag)
    WU.SetActive(_ENV["$"](REF.BtnDungeon).SpriteRed, flag)
  end)
  RU.BindRedMark(this, "Welfare/Christmas/Task", function(flag)
    WU.SetActive(_ENV["$"](REF.BtnTask).SpriteRed, flag)
  end)
  RU.BindRedMark(this, "Welfare/Christmas/Invite", function(flag)
    WU.SetActive(_ENV["$"](REF.BtnInvite).SpriteRed, flag)
  end)
end
