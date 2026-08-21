local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local m_missionInfo, m_selectedRoles, m_roleActors
local m_bottomBarVisible = false

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    WU.RecordButtonClick(100132201)
    WU.RecycleWindow("DeployActorSelection")
  end)
  LU.Bind(REF.WrapContentActor, {
    dataSource = function(dataIndex)
      return m_roleActors and m_roleActors[dataIndex]
    end,
    updateSlot = UpdateActorSlot,
    delta = 0.01
  })
end

function InitWindow()
  m_roleActors = nil
  LU.Set(REF.WrapContentActor, 0)
  this:Bind("Deploy/SelectedMission", OnCurrentMissionChange)
  REF.SelectedActors["$Reset"]()
end

function UninitWindow()
  if m_bottomBarVisible then
    m_bottomBarVisible = false
    REF.SelectedActors["$Hide"]()
  end
end

function OnCurrentMissionChange(mission)
  if mission ~= nil then
    m_missionInfo = mission
    m_selectedRoles = m_missionInfo.roleid
    if m_roleActors == nil then
      GetRoleData()
    end
    SetSelectedRole()
  end
end

function OnActorSlotClick(ref, role)
  if m_selectedRoles ~= nil then
    local i, roleId = _ENV["!"](m_selectedRoles):find(function(_, v)
      return v == role
    end)
    if roleId == nil then
      if m_missionInfo ~= nil and #m_selectedRoles < m_missionInfo.config.needRoleNum then
        table.insert(m_selectedRoles, role)
        ref.root["$SetSelected"](true)
      end
    else
      table.remove(m_selectedRoles, i)
      ref.root["$SetSelected"](false)
    end
    this:SetData("Deploy/SelectedMission", m_missionInfo)
    SetBottomBar()
  end
end

function UpdateActorSlot(ref, info)
  WU.ToggleRendering(ref["$"], info ~= nil)
  if info ~= nil then
    local tip
    if info.busy then
      tip = "actorBusy"
    end
    ref["$$SetActorByRoleId"](info.roleId)
    ref["$$SetTips"](tip)
    ref["$$SetMask"](not info.owned)
    local _, role = _ENV["!"](m_selectedRoles):find(function(_, v)
      return v == info.roleId
    end)
    ref["$$SetSelected"](role ~= nil)
    if not info.busy and info.owned then
      ref["$$SetClickCallback"](function()
        OnActorSlotClick(ref, info.roleId)
      end)
    else
      ref["$$SetClickCallback"](nil)
    end
  end
end

function SetSelectedRole()
  for i = 0, #REF.Actors - 1 do
    local needActor = m_missionInfo ~= nil and i < m_missionInfo.config.needRoleNum
    REF.Actors[i].root.gameObject:SetActive(needActor)
    if needActor then
      local ref = REF.Actors[i]
      if m_selectedRoles ~= nil and i < #m_selectedRoles then
        ref["$$SetActorByRoleId"](m_selectedRoles[i + 1])
        ref["$$ShowCustom"]({name = false})
      else
        ref["$$SetEmpty"](1)
      end
    end
  end
end

function GetRoleData()
  local validRoles = {}
  local actorConfigList = PB.all("ActorConfig")
  for _, actorConfig in pairs(actorConfigList) do
    if AU.IsActorOpen(actorConfig.id, actorConfig.openTime) then
      local role = actorConfig.role
      if validRoles[role] == nil and IsRoleValid(role) then
        validRoles[role] = {
          roleId = role,
          actorId = actorConfig.id,
          owned = false,
          busy = false
        }
      end
    end
  end
  local ownedActors = this:GetData("fci/actor/")
  for _, actor in pairs(ownedActors) do
    local role = PB.get("ActorConfig", actor.id).role
    if validRoles[role] ~= nil then
      validRoles[role].owned = true
    end
  end
  local allMissions = this:GetData("fci/deploy/mission/").missionInfo
  for _, mission in pairs(allMissions) do
    if mission.id ~= m_missionInfo.id then
      for _, roleId in pairs(mission.roleid) do
        if validRoles[roleId] ~= nil then
          validRoles[roleId].busy = true
        end
      end
    end
  end
  m_roleActors = _ENV["!"](validRoles):toarray()
  table.sort(m_roleActors, SortRole)
  local row = math.ceil(#m_roleActors / #REF.WrapContentActor[0]["$"])
  LU.Set(REF.WrapContentActor, row)
  REF.NodeEmpty.gameObject:SetActive(#m_roleActors == 0)
  _ENV["$"](REF.ScrollViewActor).BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContentActor.UIWrapContent.itemSize, 0)
  _ENV["$"](REF.ScrollViewActor).BottomBarSpace.gameObject:SetActive(0 < row)
  SetBottomBar()
end

function IsRoleValid(role)
  for _, condition in pairs(m_missionInfo.config.roleCon) do
    if condition.type == PB.enum.DeployMissionCondition.Lable then
      return false
    elseif condition.type == PB.enum.DeployMissionCondition.Role then
      if condition.needIds[1] == role then
        return true
      end
    elseif condition.type == PB.enum.DeployMissionCondition.None then
      return true
    end
  end
  return false
end

function SortRole(a, b)
  local value
  if a.busy or b.busy then
    if a.busy and b.busy then
      value = SortRoleById(a, b)
    else
      value = not a.busy or b.busy
    end
  elseif a.owned or b.owned then
    if a.owned and b.owned then
      value = SortRoleById(a, b)
    else
      value = a.owned or not b.owned
    end
  else
    value = SortRoleById(a, b)
  end
  return value
end

function SortRoleById(a, b)
  return a.roleId < b.roleId
end

function SetBottomBar()
  if m_selectedRoles ~= nil then
    if not m_bottomBarVisible and 0 < #m_selectedRoles then
      m_bottomBarVisible = true
      REF.SelectedActors["$Show"]()
    elseif m_bottomBarVisible and #m_selectedRoles == 0 then
      m_bottomBarVisible = false
      REF.SelectedActors["$Hide"]()
    end
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001322, on)
end
