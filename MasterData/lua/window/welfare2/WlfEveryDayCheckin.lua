local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local SDU = require("Common/SoundUtil")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local m_showRewardOn = false
local m_changeIndex, m_activityInfo, m_nowDay, m_allDayCount, m_activityId, m_itemContentsRef, m_labelEveryDayActTime
local m_isInit = true
local m_NoviceGiftInfo
local EnumClaimStatus = {
  SC_PENDING = 1,
  SC_CLAIMED = 2,
  SC_CAN_CLAIM = 3,
  SC_NONE = 4,
  SC_TIMEOUT = 5
}

function Awake()
  for i = 1, #REF.ItemContents10 do
    WU.BindButtonEvent(REF.ItemContents10[i - 1].root, OnClickItem)
    REF.ItemContents10[i - 1]["@index"] = i
  end
  for i = 1, #REF.ItemContents24 do
    WU.BindButtonEvent(REF.ItemContents24[i - 1].root, OnClickItem)
    REF.ItemContents24[i - 1]["@index"] = i
  end
end

function OnEnable()
  REF.Checkin10days.gameObject:SetActive(false)
  REF.Checkin24days.gameObject:SetActive(false)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.EveryDayCheckin, function(activityList)
    if activityList then
      for k, v in pairs(activityList) do
        if v.type == PB.enum.ActivityType.EveryDayCheckin and ACU.IsOpenForDoing(v) then
          m_activityInfo = v
          InitData()
          break
        end
      end
    end
  end)
end

function OnDisable()
  this:Unbind("everydaysignin", OnActivityInfoChange)
end

function OnClickItem(go)
  local state = _ENV["$"](go)["@state"]
  local index = _ENV["$"](go)["@index"]
  if state == EnumClaimStatus.SC_CAN_CLAIM then
    this:GameRequest("/fci/everyday-signin/" .. m_activityId .. "/"):Post({}, function(response)
      DBH.ResChange(response.resChange)
      m_showRewardOn = true
      WU.ShowRewards(response.resChange, function()
        m_showRewardOn = false
      end)
      table.insert(m_NoviceGiftInfo.signinedDays, index)
      m_changeIndex = index
      this:SetData("everydaysignin", m_NoviceGiftInfo)
      RU.SetRedMark("Welfare/EveryDayCheckin", false)
    end)
  elseif state == EnumClaimStatus.SC_PENDING then
    if m_showRewardOn then
      return
    end
    WU.ShowHintText(WU.GetString("Error_EveryDayLoginDaysNotReach"))
  elseif state == EnumClaimStatus.SC_CLAIMED then
    if m_showRewardOn then
      return
    end
    WU.ShowHintText(WU.GetString("Error_ReceiveContinuousLoginPrize"))
  elseif state == EnumClaimStatus.SC_TIMEOUT then
    if m_showRewardOn then
      return
    end
    WU.ShowHintText(WU.GetString("Error_EveryDayLoginDaysTimeOut"))
  end
end

function InitData()
  if not m_activityInfo then
    return
  end
  if m_activityId ~= m_activityInfo.activityId then
    this:SetData("everydaysignin", nil)
    m_activityId = m_activityInfo.activityId
    m_isInit = true
  end
  local nowTime = CS.GameTime.serverUtc - m_activityInfo.timestampStart
  local allTime = m_activityInfo.timestampEnd - m_activityInfo.timestampStart
  local timeSpanNow = CS.System.TimeSpan(0, 0, nowTime)
  local timeSpanAll = CS.System.TimeSpan(0, 0, allTime)
  local startTime = CS.GameTime.UtcToLocal(m_activityInfo.timestampStart)
  local endTime = CS.GameTime.UtcToLocal(m_activityInfo.timestampEnd)
  m_nowDay = timeSpanNow.Days + 1
  m_allDayCount = timeSpanAll.Days + 1
  if m_activityId == 46001 or m_activityId == 46004 then
    m_itemContentsRef = REF.ItemContents10
    m_labelEveryDayActTime = REF.LabelEveryDayActTime10
    REF.Checkin10days.gameObject:SetActive(true)
    REF.ItemContents10.gameObject:SetActive(false)
    local activity46001 = m_activityId == 46001
    REF.TextureBG.UITexture.mainTexturePath = "Texture/Background/" .. fif(activity46001, "pringles_bg", "half_year_bg_1")
    REF.BG10.gameObject:SetActive(activity46001)
    REF.BGTop10.gameObject:SetActive(activity46001)
    REF.BG_HalfYear.gameObject:SetActive(not activity46001)
    REF.BGTop_HalfYear.gameObject:SetActive(not activity46001)
    REF.BGTop10Front.gameObject:SetActive(activity46001)
  elseif m_activityId == 46003 then
    m_itemContentsRef = REF.ItemContents24
    m_labelEveryDayActTime = REF.LabelEveryDayActTime24
    REF.Checkin24days.gameObject:SetActive(true)
    REF.ItemContents24.gameObject:SetActive(false)
    REF.TextureBG.UITexture.mainTexturePath = "Texture/Background/christmasSign_bg_1"
  end
  if m_itemContentsRef == nil then
    warning("No itemContents!")
    return
  end
  local detail = this:GetData("everydaysignin")
  if detail == nil then
    this:GameRequest("fci/everyday-signin/" .. m_activityId .. "/"):Get(function(res)
      local signinRes = res
      signinRes.day = CS.GameTime.serverNow.Day
      signinRes.allDayCount = m_allDayCount
      signinRes.nowDay = m_nowDay
      this:Bind("everydaysignin", OnActivityInfoChange)
      this:SetData("everydaysignin", signinRes)
    end)
  else
    this:Bind("everydaysignin", OnActivityInfoChange)
  end
  m_labelEveryDayActTime.UIHtmlLabel.text = WU.GetString("Window_Month_Day_Hour", startTime.Month, startTime.Day, startTime.Hour) .. " ~ " .. WU.GetString("Window_Month_Day_Hour", endTime.Month, endTime.Day, endTime.Hour + 1)
end

function OnActivityInfoChange(detail)
  if detail == nil then
    return
  end
  m_NoviceGiftInfo = detail
  if m_isInit then
    local prizeList = PB.all("ActivitySigninGift"):where(function(k, v)
      return v.activityId == m_activityId
    end):toarray()
    table.sort(prizeList, function(a, b)
      return a.days < b.days
    end)
    if #prizeList < #m_itemContentsRef then
      error("GamePlay", "ActivitySigninGift.xlsx has not enough reward")
      return
    end
    for i = 1, #m_itemContentsRef do
      local prizeReward = prizeList[i].reward[1]
      local ref = m_itemContentsRef[i - 1]
      ref.WidgetIconSlot["$SetData"](prizeReward.type, prizeReward.id, prizeReward.count)
      ref.ButtonSlot.gameObject:SetActive(false)
      if m_activityId == 46001 or m_activityId == 46004 then
        ref.Effect.gameObject.transform.localScale = CS.UnityEngine.Vector3(0.7, 0.7, 1)
      elseif m_activityId == 46003 then
        ref.Effect.gameObject.transform.localScale = CS.UnityEngine.Vector3(0.5, 0.5, 1)
      end
      if prizeReward.param == 1 then
        if m_activityId == 46001 or m_activityId == 46004 then
          ref.IconDayNumber.UISprite.spriteName = "tag_3_m"
          ref.BGSpecial.UISprite.spriteName = "tag_1_m"
        elseif m_activityId == 46003 then
          ref.IconDayNumber.UISprite.spriteName = "tag_3_s"
          ref.BGSpecial.UISprite.spriteName = "tag_1_s"
        end
      elseif m_activityId == 46001 or m_activityId == 46004 then
        ref.IconDayNumber.UISprite.spriteName = "tag_2_m"
        ref.BGSpecial.UISprite.spriteName = "Halloween/halloween_6"
      elseif m_activityId == 46003 then
        ref.IconDayNumber.UISprite.spriteName = "tag_2_s"
        ref.BGSpecial.UISprite.spriteName = "Halloween/halloween_6"
      end
      ref.LabelDayNumber.UILabel.text = tostring(i)
      if m_activityId == 46001 or m_activityId == 46004 then
        local dateTime = CS.GameTime.UtcToLocal(m_activityInfo.timestampStart):AddDays(i - 1)
        ref.LabelDateTime.UIHtmlLabel.text = WU.GetString("Window_Month_Day", dateTime.Month, dateTime.Day)
      else
        ref.LabelDateTime.gameObject:SetActive(false)
      end
      SetPrizeState(i)
    end
    m_isInit = false
  elseif m_changeIndex then
    SetPrizeState(m_changeIndex)
    m_itemContentsRef[m_changeIndex - 1].IconItem.transform.localScale = CS.UnityEngine.Vector3.one
    m_changeIndex = nil
  else
    for i = 1, #m_itemContentsRef do
      m_itemContentsRef[i - 1].IconItem.transform.localScale = CS.UnityEngine.Vector3.one
      SetPrizeState(i)
    end
  end
  m_itemContentsRef.gameObject:SetActive(true)
end

function SetPrizeState(index)
  local ref = m_itemContentsRef[index - 1]
  local state = EnumClaimStatus.SC_NONE
  if index <= m_NoviceGiftInfo.nowDay then
    local _, prize = table.find(m_NoviceGiftInfo.signinedDays, function(k, v)
      return v == index
    end)
    if prize then
      state = EnumClaimStatus.SC_CLAIMED
      ref.IconHasClaimed.gameObject:SetActive(true)
      ref.IconItem.TweenScale.enabled = false
      ref.MaskTimeOut.gameObject:SetActive(true)
      ref.Effect.gameObject:SetActive(false)
    elseif index == m_NoviceGiftInfo.nowDay then
      state = EnumClaimStatus.SC_CAN_CLAIM
      ref.IconHasClaimed.gameObject:SetActive(false)
      ref.IconItem.TweenScale.enabled = true
      ref.MaskTimeOut.gameObject:SetActive(false)
      ref.Effect.gameObject:SetActive(true)
      RU.SetRedMark("Welfare/EveryDayCheckin", true)
    else
      state = EnumClaimStatus.SC_TIMEOUT
      ref.IconHasClaimed.gameObject:SetActive(false)
      ref.IconItem.TweenScale.enabled = false
      ref.MaskTimeOut.gameObject:SetActive(true)
      ref.Effect.gameObject:SetActive(false)
    end
  else
    state = EnumClaimStatus.SC_PENDING
    ref.IconHasClaimed.gameObject:SetActive(false)
    ref.IconItem.TweenScale.enabled = false
    ref.MaskTimeOut.gameObject:SetActive(false)
    ref.Effect.gameObject:SetActive(false)
  end
  ref["@state"] = state
end
