local WU, DB = require("Common/WindowUtil")()
local U = require("Common/Util")
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local TU = require("Common/TextUtil")
local AU = require("Common/ActorUtil")
local GU = {
  EnumToSelectedGroupApi = {
    [PB.enum.ActorGroupType.Dungeon] = "StoryMode",
    [PB.enum.ActorGroupType.Tower] = "tower",
    [PB.enum.ActorGroupType.AsyncPvp] = "asyncPvp",
    [PB.enum.ActorGroupType.Show] = "",
    [PB.enum.ActorGroupType.Aura] = "",
    [PB.enum.ActorGroupType.Gold] = "gold-dungeon",
    [PB.enum.ActorGroupType.BurstLinkPvp] = "burstLinkPvp",
    [PB.enum.ActorGroupType.RacePvp] = "racePVP",
    [PB.enum.ActorGroupType.Activity] = "activity-dun",
    [PB.enum.ActorGroupType.Triggered] = "triggeredEvent",
    [PB.enum.ActorGroupType.Guild] = "guild-dungeon",
    [PB.enum.ActorGroupType.TowerNew] = "extreme-challenge",
    [PB.enum.ActorGroupType.FriendPvp] = "FriendPvp",
    [PB.enum.ActorGroupType.AsyncPvpNew] = "asyncPvpV2"
  },
  EnumToGroupApi = {
    [PB.enum.ActorGroupType.Dungeon] = "fci/ActorGroup/",
    [PB.enum.ActorGroupType.Tower] = "fci/tower/actorgroup/",
    [PB.enum.ActorGroupType.AsyncPvp] = "fci/ActorGroup/",
    [PB.enum.ActorGroupType.Show] = "",
    [PB.enum.ActorGroupType.Aura] = "",
    [PB.enum.ActorGroupType.Gold] = "fci/ActorGroup/",
    [PB.enum.ActorGroupType.BurstLinkPvp] = "fci/BurstLinkPvpActorGroup/",
    [PB.enum.ActorGroupType.RacePvp] = "fci/ActorGroup/",
    [PB.enum.ActorGroupType.Activity] = "fci/ActorGroup/",
    [PB.enum.ActorGroupType.Triggered] = "fci/ActorGroup/",
    [PB.enum.ActorGroupType.Guild] = "fci/guild/GuildDungeonActorGroup/",
    [PB.enum.ActorGroupType.TowerNew] = "fci/extreme-challenge/actorgroup/",
    [PB.enum.ActorGroupType.FriendPvp] = "fci/friendpvp/match/",
    [PB.enum.ActorGroupType.AsyncPvpNew] = "fci/ActorGroup/"
  }
}

function GU.GroupIsOK(members, showTip)
  if 0 < #members then
    local hasMain = false
    for i = 1, 3 do
      local member = members[i]
      local memberB = members[i + 3]
      if member.actorUid ~= nil and member.actorUid ~= 0 or member.actorUid == nil and member.actor ~= nil or member.isNpc or member.actorGuildUid ~= nil and member.actorGuildUid ~= 0 then
        hasMain = true
      elseif memberB.actorUid ~= nil and memberB.actorUid ~= 0 or memberB.actorUid == nil and memberB.actor ~= nil or memberB.isNpc or memberB.actorGuildUid ~= nil and memberB.actorGuildUid ~= 0 then
        if showTip then
          WU.ShowHintText(WU.GetString("WindowActorGroup_AssistActorMustBeCarriedWithMain"))
        end
        return false
      end
    end
    if not hasMain and showTip then
      WU.ShowHintText(WU.GetString("WindowActorGroup_MustChooseFightMember"))
    end
    return hasMain
  end
  return false
end

function GU.CheckHp(members, showTip)
  if 0 < #members then
    local hasMain = false
    for i = 1, 3 do
      local member = members[i]
      local memberB = members[i + 3]
      local hp1, hp2
      if member and member.hp then
        hp1 = member.hp
      end
      if memberB and memberB.hp then
        hp2 = memberB.hp
      end
      if member and member.actorUid ~= 0 then
        local bAllZero = true
        if hp1 and 0 < hp1 then
          bAllZero = false
        end
        if bAllZero then
          if showTip then
            WU.ShowHintText(WU.GetString("LocalMaze_Tips22"))
          end
          return false
        end
      end
      if memberB and memberB.actorUid ~= 0 then
        local bAllZero = true
        if hp2 and 0 < hp2 then
          bAllZero = false
        end
        if bAllZero then
          if showTip then
            WU.ShowHintText(WU.GetString("LocalMaze_Tips22"))
          end
          return false
        end
      end
    end
    return true
  end
  return false
end

function GU.TowerGroupIsDead(members)
  local result = true
  for i = 1, #members do
    if members[i].actor and not members[i].dead then
      result = false
      break
    end
  end
  return result
end

function GU.GetTowerNotOKGroup(groups)
  local invalidGroups = ""
  for groupId = 1, _ENV["!"](groups):count() do
    local OK = GU.GroupIsOK(groups[tostring(groupId)].members)
    if not OK then
      if invalidGroups ~= "" then
        invalidGroups = invalidGroups .. ", "
      end
      invalidGroups = invalidGroups .. WU.GetString("WindowTower_GroupName" .. groupId)
    end
  end
  return invalidGroups
end

function GU.GroupUidsAdd(uids, mode)
  if CS.DataBindingManager.Instance ~= nil then
    local number = 1 << mode - 1
    local groupActorUids = DB:GetData("GroupActorUids")
    uids = _ENV["!"](uids):distinct()
    for i = 1, #uids do
      local uid = uids[i]
      groupActorUids[uid] = (groupActorUids[uid] or 0) | number
    end
    DB:SetData("GroupActorUids", groupActorUids)
  end
end

function GU.GroupUidsReset(resetZeroUids, mode)
  if CS.DataBindingManager.Instance ~= nil then
    local number = 1 << mode - 1
    local groupActorUids = DB:GetData("GroupActorUids")
    resetZeroUids = _ENV["!"](resetZeroUids):distinct()
    for i = 1, #resetZeroUids do
      local uid = resetZeroUids[i]
      if groupActorUids[uid] then
        groupActorUids[uid] = groupActorUids[uid] & ~number
      end
    end
    DB:SetData("GroupActorUids", groupActorUids)
  end
end

function GU.UpdateGroupActorUids(groupsBefore, groupsNow, mode)
  local number = 1 << mode - 1
  local groupActorUids = DB:GetData("GroupActorUids")
  local tmpUids = _ENV["!"]({})
  _ENV["!"](groupActorUids):copy(tmpUids)
  local uids = _ENV["!"]({})
  for _, v in pairs(groupsBefore) do
    for i = 1, #v.members do
      table.insert(uids, v.members[i].actorUid)
    end
  end
  uids = uids:distinct()
  for i = 1, #uids do
    groupActorUids[uids[i]] = (groupActorUids[uids[i]] or 0) & ~number
  end
  uids = _ENV["!"]({})
  for _, v in pairs(groupsNow) do
    for i = 1, #v.members do
      table.insert(uids, v.members[i].actorUid)
    end
  end
  uids = uids:distinct()
  for i = 1, #uids do
    groupActorUids[uids[i]] = (groupActorUids[uids[i]] or 0) | number
  end
  DB:SetData("GroupActorUids", groupActorUids)
end

function GU.ActorNotInGroup(uid)
  if uid == 0 then
    return true
  end
  local groupActorUids = DB:GetData("GroupActorUids")
  if groupActorUids[uid] then
    return groupActorUids[uid] == 0
  else
    return true
  end
end

function GU.IsMainIndex(index)
  return index < 3
end

function GU.SetGroupMode(mode, branch)
  if mode == nil then
    warning("ActorGroup", "mode is nil")
    return
  end
  local groupUri = GU.EnumToGroupApi[mode]
  local suffix = GU.EnumToSelectedGroupApi[mode]
  DB:SetData("ActorGroup/GroupUri", groupUri)
  DB:SetData("ActorGroup/SelectedGroupIdUri", "fci/SelectedGroupId/" .. (suffix or ""))
  DB:SetData("ActorGroup/Mode", mode)
  return mode
end

function GU.GroupTagCheck(uids)
  local groupActorUids = DB:GetData("GroupActorUids")
  local groupTags = _ENV["!"]({})
  for i = 1, #uids do
    local k = 1
    local binary = groupActorUids[uids[i]] or 0
    while 0 < binary do
      if binary & 1 == 1 then
        groupTags[k] = true
      end
      k = k + 1
      binary = binary >> 1
    end
  end
  local syncRemote = _ENV["!"]({})
  for k, _ in pairs(groupTags) do
    if U.trim(GU.EnumToGroupApi[k]) ~= "" then
      table.insert(syncRemote, GU.EnumToGroupApi[k])
    end
  end
  syncRemote = syncRemote:distinct()
  for _, v in pairs(syncRemote) do
    DB:SyncRemote(DB:GameRequest(v))
  end
end

function GU.MonsterGroup(monsterIds)
  local actors = {}
  for k, id in pairs(monsterIds) do
    local actorId = -3
    if id ~= nil and id ~= 0 then
      local monsterInfo = PB.get("MonsterInfo", id)
      if monsterInfo == nil then
        error("Tower", "no monsterId " .. id .. " in MonsterInfo! ")
      else
        actorId = monsterInfo.actorID
      end
    end
    actors[k] = {id = actorId}
  end
  local pairCount = #table.select(actors, function(v)
    if v.id ~= -3 then
      return v
    end
  end):toarray() / 2
  return actors, pairCount
end

function GU.GetHpFillAmount(members, index)
  local hp = fif(members[index].dead, 0, members[index].hp)
  local maxHp = 0
  local attrs = members[index].actor.attrs
  for k, v in pairs(attrs) do
    if v.type == PB.enum.AttrType.Hp then
      maxHp = v.value
    end
  end
  local hp2 = 0
  if members[index + 3] and members[index + 3].actor then
    attrs = members[index + 3].actor.attrs
    hp2 = members[index + 3].hp
    for k, v in pairs(attrs) do
      if v.type == PB.enum.AttrType.Hp then
        maxHp = maxHp + v.value
      end
    end
  end
  return (hp + hp2) / maxHp
end

function GU.GetHpFillAmountNew(members, index)
  local function ManageHp(index)
    if members[index].actor == nil then
      return nil
    end
    local maxHp = 0
    local hp = members[index].hp or members[index].actor.hp
    local attrs = members[index].actor.attrs
    for k, v in pairs(attrs) do
      if v.type == PB.enum.AttrType.Hp then
        maxHp = v.value
        hp = fif(hp == 0 or hp == nil, v.value, hp)
      end
    end
    return hp, maxHp
  end
  
  local hp, maxHp = ManageHp(index)
  local hp2, maxHp2 = ManageHp(index + 3)
  local fillMain, fillSub
  if hp then
    fillMain = hp / maxHp
  end
  if hp2 then
    fillSub = hp2 / maxHp2
  end
  return fillMain, fillSub
end

function GU.IsShowRedMark(uid)
  local groupActorUids = DB:GetData("GroupActorUids")
  local groupTags = groupActorUids[uid]
  if groupTags == nil or groupTags | 24 == 24 then
    return false
  end
  return true
end

function GU.GetActorInWhichGroups(uid)
  local actorInWhichGroups = DB:GetData("ActorInWhichGroups") or {}
  return actorInWhichGroups[uid] or {}
end

function GU.GetGroupApi(mode)
  return GU.EnumToGroupApi[mode]
end

function GU.ChangeToActorInfo(info, typeIsMember)
  local actor, uid
  if info.isGuildActor then
    if typeIsMember then
      uid = info.actorGuildUid or 0
    else
      uid = info.uid or 0
    end
    local rentActors = DB:GetData("DungeonGuild/RentActors") or _ENV["!"]({})
    local _, v = table.find(rentActors, function(k1, v1)
      return v1.uid == uid
    end)
    actor = v
  else
    if typeIsMember then
      uid = info.actorUid or 0
    else
      uid = info.uid or 0
    end
    actor = DB:GetData("fci/actor/" .. uid)
  end
  return actor, uid
end

function GU.CreateEmptyMembers()
  local members = {}
  for i = 1, 6 do
    members[i] = {
      index = i - 1,
      actorUid = 0
    }
  end
  return members
end

function GU.GetHpFillAmountNew2(members, index)
  local function ManageHp(index)
    if members[index].actor == nil then
      return nil
    end
    local maxHp = 0
    local hp = members[index].hp or members[index].actor.hp
    local attrs = members[index].actor.attrs
    for k, v in pairs(attrs) do
      if v.type == PB.enum.AttrType.Hp then
        maxHp = v.value
        hp = fif(hp == nil, v.value, hp)
      end
    end
    return hp, maxHp
  end
  
  local hp, maxHp = ManageHp(index)
  local hp2, maxHp2 = ManageHp(index + 3)
  local fillMain, fillSub
  if hp then
    fillMain = hp / maxHp
  end
  if hp2 then
    fillSub = hp2 / maxHp2
  end
  return fillMain, fillSub
end

return GU
