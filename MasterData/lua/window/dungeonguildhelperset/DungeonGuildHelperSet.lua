inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local GU = require("Common/GuildUtil")
local m_guildId, m_helpers, m_myFighter, m_lastSelectedRef, m_path

function SetupWindow()
  LU.Bind(REF.WrapContentActor, {
    dataSource = function(dataIndex)
      return m_helpers and m_helpers[dataIndex]
    end,
    updateSlot = OnUpdateSlot
  })
  WU.BindButtonEvent(REF.NodeMyActor, OnMyActorClick)
  WU.TraverseChildren(REF.WrapContentActor, function(go)
    WU.TraverseChildren(_ENV["$"](go).root, function(innerGo)
      WU.BindButtonEvent(innerGo, OnSelectActorClick)
    end)
  end)
end

function InitWindow()
  this:Bind("guildId", function(guildId)
    m_guildId = guildId
    ValidateRestrictions(guildId)
    m_path = "fci/guild/" .. tostring(m_guildId) .. "/rent-actor/"
  end)
  this:RegisterGameEvent("DungeonGuildFighterSet", OnMyFighterSet)
  RefreshUI()
end

function UninitWindow()
  this:UnregisterGameEvent("DungeonGuildFighterSet", OnMyFighterSet)
end

function RefreshUI()
  WU.ToggleRendering(REF.ListActor, false)
  WU.SetActive(REF.NodeMyActor[0]["$gameObject"], false)
  WU.SetActive(REF.NodeLock, false)
  WU.SetActive(REF.NodeMyActor[1]["$gameObject"], true)
  REF.SpriteEmpty.gameObject:SetActive(false)
  REF.BottomBarSpace.gameObject:SetActive(false)
  this:GameRequest(m_path):Get(function(res)
    if res == nil then
      return
    end
    this:SetData(m_path, res)
    UpdateMyFighterUI()
    HandleHelperPoolData()
    UpdateHelperPoolUI()
  end)
end

function HandleHelperPoolData()
  local data = this:GetData(m_path)
  if data == nil then
    return
  end
  m_helpers = data.rentActorInfo
  if #m_helpers ~= 0 then
    for i = 1, #m_helpers do
      m_helpers[i].ownerName = GU.GetMemberName(m_helpers[i].playerId)
    end
    table.sort(m_helpers, function(a, b)
      if a.cultivationDegree == b.cultivationDegree then
        if a.fightTimes == b.fightTimes then
          if a.actor.id == b.actor.id then
            return a.actor.uid < b.actor.uid
          else
            return a.actor.id < b.actor.id
          end
        else
          return a.fightTimes > b.fightTimes
        end
      else
        return a.cultivationDegree > b.cultivationDegree
      end
    end)
  end
  this:SetData("DungeonGuild/HelpersInOrder", m_helpers)
end

function UpdateHelperPoolUI()
  local count = #m_helpers
  REF.SpriteEmpty.gameObject:SetActive(count == 0)
  if count ~= 0 then
    WU.ToggleRendering(REF.ListActor, true)
    local row = math.ceil(count / #REF.WrapContentActor[0]["$"])
    LU.Set(REF.WrapContentActor, row)
    REF.BottomBarSpace.gameObject:SetActive(true)
    REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContentActor.UIWrapContent.itemSize, 0)
  end
end

function UpdateMyFighterUI()
  local data = this:GetData(m_path)
  if data == nil then
    return
  end
  local _, v = table.find(data.rentActorInfo, function(k1, v1)
    return v1.playerId == this:GetData("playerId")
  end)
  m_myFighter = v
  local hasFighter = m_myFighter ~= nil
  WU.SetActive(REF.NodeMyActor[0]["$gameObject"], hasFighter)
  WU.SetActive(REF.NodeMyActor[1]["$gameObject"], not hasFighter)
  WU.SetActive(REF.NodeMyActor, true)
  if hasFighter then
    REF.NodeMyActor[0]["$$SetActor"](m_myFighter.actor)
    local show = m_myFighter.actor.uniqueWeaponId and m_myFighter.actor.uniqueWeaponId ~= 0
    REF.NodeMyActor[0]["$$ShowCustom"]({showArm = show})
  end
  WU.SetActive(REF.NodeLock, m_myFighter and m_myFighter.used)
  local summary = this:GetData("DungeonGuild/Summary")
  local fighter = summary.playerRentInfo
  local fightTimes = 0
  if fighter.fightTimes then
    fightTimes = fighter.fightTimes
  end
  REF.LabelCount.UILabel.text = fightTimes
  local earnedScore = 0
  if fighter.earnedScore then
    earnedScore = fighter.earnedScore
  end
  if fighter.earnedScore == 0 and hasFighter then
    earnedScore = PB.all("Misc"):first().guildLoanActorContributionReward
  end
  REF.LabelScore.UILabel.text = earnedScore
end

function OnUpdateSlot(ref, info)
  _ENV["$"](ref.WidgetIconActor)["$$SetActor"](info.actor)
  local show = info.actor.uniqueWeaponId and info.actor.uniqueWeaponId ~= 0
  _ENV["$"](ref.WidgetIconActor)["$$ShowCustom"]({showArm = show})
  ref.LabelFightScore.UILabel.text = WU.GetString("CultivationPvP_PlayerRank2", info.cultivationDegree)
  ref.LabelInviteCount.UILabel.text = WU.GetString("DungeonGuild_UseTimes", info.fightTimes)
  ref.LabelOwner.UILabel.text = info.ownerName
  local infofontColor = fif(info.playerId == this:GetData("playerId"), 9498367, 995593727)
  ref.LabelFightScore.UILabel.color = CS.NGUIMath.HexToColor(infofontColor)
  ref.LabelInviteCount.UILabel.color = CS.NGUIMath.HexToColor(infofontColor)
  ref.LabelOwner.UILabel.color = CS.NGUIMath.HexToColor(infofontColor)
  ref["@info"] = info
end

function OnMyActorClick(go)
  if m_myFighter and m_myFighter.used then
    return
  end
  WU.AcquireWindowAsync("DungeonGuildFighterPick")
end

function OnSelectActorClick(go)
  local info = _ENV["$"](go)["@info"]
  WU.AcquireWindowAsync("DungeonGuildHelperDetail", function(window)
    _ENV["$"](window)["$$SetActor"](info)
  end)
end

function OnMyFighterSet()
  UpdateMyFighterUI()
  HandleHelperPoolData()
  UpdateHelperPoolUI()
end
