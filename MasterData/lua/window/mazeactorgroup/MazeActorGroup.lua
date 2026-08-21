local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local m_selectedGroupId, m_groups, m_dungeonId, m_dungeonType, m_selectedGroupMode, m_dungeonReward, m_price, m_actorsReady
local m_powerMultiple = 1
local m_dungeonStar = 0
local m_maxTeamNumber = 5
local m_waitForPolling
local m_showPlayTimesLimit = false
local m_restTimes = 0
local m_multiPowerLevelLimit
local m_multiPowerOpend = false
local m_displayAttrs = false
local m_eventActivityType, m_members, m_membersDetail, m_buffRowList

function SetupWindow()
  LU.Bind(REF.BuffWrapContent, {
    updateRow = UpdateBuffRowCell
  })
  CS.EventDelegate.Add(REF.ToggleAttrs.UIToggle.onChange, function()
    m_displayAttrs = CS.UIToggle.current.value
    RefreshAttrDisplay()
  end)
  WU.BindButtonEvent(REF.ButtonSprite, function()
    if not DU.IsWaitingForJob(OnButtonFightClick) then
      OnButtonFightClick()
    end
  end)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups = patchData
    OnGetActorGroup(m_groups)
  end)
  m_selectedGroupId = 1
end

function UpdateBuffRowCell(rowRef, wrapIndex, realIndex)
  if m_buffRowList and realIndex ~= nil and realIndex < #m_buffRowList then
    local index = realIndex + 1
    local buffData = m_buffRowList[index]
    if buffData then
      local buffInfo = PB.get("MazeBuff", buffData.buffId)
      if buffInfo then
        rowRef.root.UISprite.spriteName = buffInfo.buffIcon
        local buffId = buffData.buffId
        WU.BindButtonEvent(rowRef.root, function()
          WU.AcquireWindowAsync("WidgetMazeBuffList", function(ui)
            _ENV["$"](ui)["$$SetData"](buffId)
          end)
        end)
      end
    end
  end
end

function InitWindow()
  m_displayAttrs = false
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  RefreshAttrDisplay()
  UpdateBuffList()
  m_waitForPolling = false
  m_actorsReady = false
  m_dungeonReward = nil
  m_price = nil
  m_restTimes = 0
  m_dungeonStar = 0
  m_showPlayTimesLimit = false
  m_multiPowerLevelLimit = nil
  m_multiPowerOpend = false
  m_powerMultiple = 1
  m_eventActivityType = this:GetData("Event/ActivityType")
  this:SetData("ActorGroup/Mode", PB.enum.ActorGroupType.Maze)
  this:SetData("ActorGroup/GroupUri", "fci/Maze/FightActorGroup/")
  this:Unbind("WindowDungeon/DungeonId", OnDungeonInit)
  this:Bind("WindowDungeon/DungeonId", OnDungeonInit)
  this:Unbind("fci/Maze/FightActorGroup", OnGetActorGroup)
  this:Bind("fci/Maze/FightActorGroup", OnGetActorGroup)
  local actorGroup = this:GetData("fci/Maze/FightActorGroup/")
  if actorGroup == nil then
    this:GameRequest("fci/Maze/FightActorGroup/"):Get(function(resp)
      local actorGroup = {}
      actorGroup["1"] = resp.fightGroup[1]
      this:SetData("fci/Maze/FightActorGroup/", actorGroup)
      WU.AcquireWindowAsync("MazeActorSelect")
    end)
  end
end

function BackWindow()
end

function UpdateWindow()
  if m_actorsReady then
    REF.ButtonSprite.UISprite.color = CS.NGUIMath.HexToColor(4294967295)
  else
    REF.ButtonSprite.UISprite.color = CS.NGUIMath.HexToColor(3318072831)
  end
end

function SetMaxTeamNumber(maxTeam)
  m_maxTeamNumber = maxTeam
end

function OnActorGroupButtonClick(go)
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  WU.AcquireWindowAsync("MazeActorSelect")
end

function UpdateBuffList()
  local buffMap = this:GetData("MazeBuff")
  if buffMap == nil then
    return
  end
  local buffList = {}
  for k, v in pairs(buffMap) do
    if v.buffId > 0 then
      if (v.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Battle or v.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Cell) and 0 < v.leftRound then
        buffList[#buffList + 1] = v
      elseif v.persistentType ~= PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Battle and v.persistentType ~= PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Cell then
        buffList[#buffList + 1] = v
      end
    end
  end
  m_buffRowList = buffList
  local len = #buffList
  LU.Set(REF.BuffWrapContent, len)
end

function OnGetActorGroup(actorGroup)
  if actorGroup ~= nil and m_selectedGroupId ~= nil then
    m_groups = actorGroup["1"]
    PollingActors(m_groups.members)
    UpdateGroupView()
  end
end

function UpdateGroupView()
  WU.ToggleRendering(REF.WidgetGroupMembers, true)
  m_membersDetail = {}
  for i, v in ipairs(m_groups.members) do
    local actorWrap
    if v.actorUid and v.actorUid > 0 then
      actorWrap = this:GetData("fci/mazeactor/" .. v.actorUid)
    end
    if actorWrap then
      v.hp = actorWrap.hp
      v.actor = actorWrap.actor
    end
    m_membersDetail[v.index + 1] = v.actor or {}
  end
  for i = 1, 3 do
    local member = m_groups.members[i]
    local hp
    if member and member.hp and member.actorUid ~= 0 then
      hp = member.hp
    end
    if hp == 0 then
      member.dead = true
    end
  end
  if m_groups ~= nil then
    m_members = m_groups.members
    REF.WidgetGroupMembers["$SetMazeGroupMembers"](m_members)
    REF.WidgetGroupMembers["$ShowCustom"]({showNew = false, showName = true})
  end
end

function OnButtonFightClick()
  Fight()
end

function Fight()
  if GU.GroupIsOK(m_groups.members, true) and GU.CheckHp(m_groups.members, true) then
    EnterDungeon()
  end
end

function SaveCurrentGroupID()
end

function OnDungeonInit(dungeonId)
  if dungeonId then
    m_dungeonId = dungeonId
  end
end

function EnterDungeon()
  local cellIndex = this:GetData("MazeSelectIndex")
  local postData = {cellIndex = cellIndex}
  this:GameRequest("fci/maze-dungeon/"):Post(postData, function(result)
    local fightActorInfo = {
      {
        playerId = this:GetData("playerId"),
        actors = m_membersDetail
      }
    }
    this:SetData("FightActorInfo", fightActorInfo)
    CalcAuraAttrs()
    local hps = {}
    for _, member in ipairs(m_members) do
      if member.hp == nil then
        table.insert(hps, 0)
      elseif member.dead then
        table.insert(hps, -1)
      else
        local k2, v2 = table.find(result.myRecord, function(k, v)
          return v.actorUid == member.actorUid
        end)
        if v2 then
          table.insert(hps, v2.hp)
        else
          table.insert(hps, member.hp)
        end
      end
    end
    if m_groups ~= nil then
      local group = _ENV["!"](m_groups)
      local groupInfo = {
        hp = hps,
        sp = result.energySp,
        mp = result.energyMp
      }
      if result.enemyRecord then
        local enemyHps = result.enemyRecord.hp
        for i = 1, 6 do
          if enemyHps[i] == nil then
            enemyHps[i] = 0
          elseif enemyHps[i] == 0 then
            enemyHps[i] = -1
          end
        end
      end
      local fightInitInfo = {
        groupInfo,
        result.enemyRecord
      }
      this:SetData("FightInitInfo", fightInitInfo)
      UpdateBattleBuffRound(-1)
      WU.EnterGameLevel(result.dungeonUid, result.baseInfo, result.baseInfo.dungeonId, PB.enum.DungeonType.Maze, 1, false)
    end
  end)
end

function UpdateBattleBuffRound(round)
  local temp = this:GetData("MazeBuff")
  if temp then
    local buffMap = {}
    for k, v in pairs(temp) do
      if v.buffId and v.buffId > 0 then
        local buffInfo = PB.get("MazeBuff", v.buffId)
        if buffInfo and buffInfo.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Battle then
          v.leftRound = v.leftRound + round
          if 0 < v.leftRound then
            buffMap[v.buffId] = v
          end
        elseif buffInfo then
          buffMap[v.buffId] = v
        end
      end
    end
    this:SetData("MazeBuff", buffMap)
  end
end

function SetSelectActorGroupId(actorList)
  local fightActorInfo = {
    {
      playerId = this:GetData("playerId"),
      actors = actorList
    }
  }
  this:SetData("FightActorInfo", fightActorInfo)
  this:SetData("FightAgainInfo", fightActorInfo)
  m_actorsReady = true
end

function PollingActors(members)
  local actorList = {}
  this:RegisterGameEvent("fci/actor/", function()
    if m_waitForPolling then
      m_waitForPolling = false
      SetSelectActorGroupId(actorList)
    end
  end)
  local isRemoteData = false
  for i = 1, #members do
    local member = members[i]
    if member.actorUid and member.actorUid ~= 0 then
      if not this:GetData("fci/mazeactor/" .. member.actorUid) then
        isRemoteData = true
        m_waitForPolling = true
      end
      this:Bind("fci/mazeactor/" .. member.actorUid, function(actor)
        if actor ~= nil and actor.id ~= 0 then
          actorList[member.index + 1] = actor
        end
      end)
    else
      do
        local space = {}
        space.index = member.index
        actorList[member.index + 1] = space
      end
    end
  end
  if not isRemoteData then
    SetSelectActorGroupId(actorList)
  end
end

function RefreshAttrDisplay()
  REF.WidgetGroupMembers["$DisplayAttrs"](m_displayAttrs)
  if REF.ToggleAttrs.UIToggle.value ~= m_displayAttrs then
    REF.ToggleAttrs.UIToggle.value = m_displayAttrs
  end
end

function SetEventActivityType(type)
  m_eventActivityType = type
end
