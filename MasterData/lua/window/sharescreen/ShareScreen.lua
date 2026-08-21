local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local m_originalPosition
local m_span = 130
local m_first = true
local m_hasBroad = false
local id_ActivityShareWeekly = 24001

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonShare, OnShareClick)
  m_originalPosition = REF.NodeButton.transform.localPosition
end

function InitWindow()
  local top = WU.TopWindow()
  if top and top.name == "CollectionsActor" then
    MoveButton(-1)
  elseif top and top.name == "RacePVP" then
  elseif top and top.name == "TowerNewPrepare" then
    MoveButton(0)
  elseif top and top.name == "DungeonBalanceBurstLink" then
  elseif top and top.name == "MaidCafeRecruitMent" then
  else
    MoveButton(0)
    ToggleButton(true)
  end
  ToggleShareReward()
  this:Bind("Share/CollectionsActorEnough", OnCollectionsActorEnough)
  this:Bind("Share/RacePvpHasScore", ToggleButton2)
  this:Bind("Share/BurstLinkHasWin", ToggleButton2)
  this:Bind("Share/TowerNewHasScore", ToggleButton2)
end

function OnShareClick()
  WU.RecordButtonClick(901)
  local shareWindow = WU.TopWindow()
  if shareWindow then
    _ENV["$"](shareWindow)["$$SetShareInfo"]()
    WU.AcquireWindowAsync("Share")
  end
end

function MoveButton(step)
  if step == 0 then
    REF.NodeButton.transform.localPosition = m_originalPosition
  else
    REF.NodeButton.transform.localPosition = {
      x = m_originalPosition.x + step * m_span,
      y = m_originalPosition.y,
      z = m_originalPosition.z
    }
  end
end

function ToggleButton(visible)
  REF.NodeButton.gameObject:SetActive(visible)
end

function OnCollectionsActorEnough(visible)
  if visible == nil then
    return
  end
  ToggleButton(visible)
  if not m_hasBroad and visible then
    m_hasBroad = true
  end
end

function ToggleButton2(visible)
  if visible == nil then
    return
  end
  ToggleButton(visible)
end

function ToggleShareReward()
  REF.NodeReward.gameObject:SetActive(false)
  local activityLists = this:GetData("ActivityList")
  local _, activityInfo = table.find(activityLists, function(k, v)
    return v.activityId == id_ActivityShareWeekly
  end)
  if activityInfo and ACU.GetStatus(activityInfo) == PB.enum.ActivityStatus.Started then
    local reward = PB.get("ShareReward", id_ActivityShareWeekly).reward
    if reward then
      this:BindRemote(this:GameRequest("fci/share"), function(res)
        if res and not res.weeklyRewarded then
          UpdateRewardUI(reward)
        else
          REF.NodeReward.gameObject:SetActive(false)
        end
      end)
    end
  end
end

function UpdateRewardUI(reward)
  local resImg
  if reward[1].type == PB.enum.ResourceType.ResItem then
    local itemInfo = PB.get("ItemInfo", reward[1].id)
    resImg = itemInfo.icon
  elseif reward[1].type == PB.enum.ResourceType.ResPlayerGold then
    resImg = "ResPlayerGold_0"
  elseif reward[1].type == PB.enum.ResourceType.ResPlayerMoney then
    resImg = "ResIcon_s.ResPlayerMoney_0"
  elseif reward[1].type == PB.enum.ResourceType.ResPlayerPower then
    resImg = "ResIcon_s.ResPlayerPower_0"
  end
  local count = reward[1].count
  REF.SpriteReward.UISprite.spriteName = resImg
  REF.LabelCount.UILabel.text = tostring(count)
  REF.NodeReward.gameObject:SetActive(true)
  REF.NodeButton.UIPlayTween:ResetToBeginning()
  REF.NodeButton.UIPlayTween:Play(true)
end
