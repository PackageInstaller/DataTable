local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_target = "Welfare"
local m_currentActivityId, m_startFly
local m_target = "Welfare"
local m_window

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonFinish, function()
    this:SetData("PopupCoverJumpinShareRewardCurrentActivityId", nil)
    WU.SetActive(REF.ButtonShare, false)
    REF["$Animator"]:Play("Close")
    this:DelayInvokeInSeconds(0.16, function()
      REF.Black.gameObject:SetActive(false)
      m_startFly = true
      this:DelayInvokeInSeconds(0.2, function()
        local pos = REF.root.transform:InverseTransformPoint(_ENV["$"](m_window)[m_target].gameObject.transform.position)
        U.Translate(REF.Effect.transform, pos.x, pos.y, 0)
        REF.Effect.EffectGenerator:Play()
        REF.ButtonFinish.gameObject:SetActive(false)
        this:DelayInvokeInSeconds(0.8, function()
          WU.RecycleWindow(this)
        end)
      end)
    end)
  end)
  if REF.ButtonShare then
    WU.BindButtonEvent(REF.ButtonShare, OnClickButtonShare)
  end
end

function InitWindow()
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  REF["$Animator"]:Play("Open")
  m_window = WU.FindWindow("City")
  WU.SetActive(REF.ButtonShare, true)
  m_currentActivityId = this:GetData("PopupCoverJumpinShareRewardCurrentActivityId")
  SetActivity(m_currentActivityId)
end

function UninitWindow()
  this:UnregisterGameEvent("UI/WindowUninited", OnWindowUninited)
end

function UpdateWindow()
  if m_startFly == true then
    local pos = REF.root.transform:InverseTransformPoint(_ENV["$"](m_window)[m_target].gameObject.transform.position)
    U.Translate(REF.StarADD.transform, pos.x / 6, pos.y / 6, 0)
  end
end

function SetActivity(id)
  WU.SetGameDataCache("lastCoverJumpTime_CoverJumpShareReward_" .. DB:GetData("playerId") .. "_" .. id, CS.GameTime.serverUtc)
  local popupInfo = PB.get("PopupInfo", id)
  local popup = DB:GetData("fci/popup/")
  local alreadyShared = table.find(popup.rewardActivityId, function(k, v)
    return v == id
  end)
  if popupInfo.flyTarget then
    m_target = popupInfo.flyTarget
  end
  if popupInfo.closeEffect then
    REF.Effect.EffectGenerator.m_EffectName = popupInfo.closeEffect
    REF.Effect.EffectGenerator:Reset()
  end
  if popupInfo and popupInfo.shareReward and not alreadyShared then
    WU.SetActive(REF.SpriteTip, true)
    WU.SetActive(REF.HtmlLabelShareReward, true)
    local text = WU.GetString("Window_ShareRewardFirstTime")
    for _, v in ipairs(popupInfo.shareReward) do
      text = text .. GetResIcon_sString(v.type, v.id) .. "x" .. v.count
    end
    REF.Leaf01.UITexture.mainTexturePath = "Texture/CoverJumpShareReward/" .. popupInfo.titleTextureName
    REF.BG.UITexture.mainTexturePath = "Texture/CoverJumpShareReward/" .. popupInfo.bgTextureName
    REF.BBG.UITexture.mainTexturePath = "Texture/CoverJumpShareReward/" .. popupInfo.bgTextureName
    REF.BGADD.UITexture.mainTexturePath = "Texture/CoverJumpShareReward/" .. popupInfo.bgTextureName
    REF.HtmlLabelShareReward.UIHtmlLabel.text = text
  else
    WU.SetActive(REF.SpriteTip, false)
    WU.SetActive(REF.HtmlLabelShareReward, false)
  end
end

function GetResIcon_sString(type, id)
  if type == PB.enum.ResourceType.ResPlayerPayMoney then
    return "<img src='ResIcon_s.ResPlayerPayMoney_0'/>"
  elseif type == PB.enum.ResourceType.ResPlayerMoney then
    return "<img src='ResIcon_s.ResPlayerMoney_0'/>"
  elseif type == PB.enum.ResourceType.ResPlayerGold then
    return "<img src='ResIcon_s.ResPlayerGold_0'/>"
  else
    return "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[type] .. "_" .. id .. "'/>"
  end
end

function OnClickButtonShare()
  WU.RecordButtonClick(901)
  this:SetData("Share/CoverJumpShareReward", {activityId = m_currentActivityId})
  this:SetData("ShareConfig", {
    shareName = "CoverJumpShareReward",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  local oldWindow = REF["$gameObject"]
  WU.AcquireWindowAsync("Share", function()
    WU.ToggleRendering(oldWindow, false)
  end)
end

function OnWindowUninited(window)
  if window.name == "Share" then
    WU.ToggleRendering(REF["$gameObject"], true)
  end
end
