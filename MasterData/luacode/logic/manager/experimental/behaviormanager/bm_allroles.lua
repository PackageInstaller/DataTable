local Role = require("logic.manager.experimental.types.role")
local CTimeCfgTable = BeanManager.GetTableByName("role.ctimecfg")
local BM_AllRoles = class("BM_AllRoles")
local X = CTimeCfgTable:GetRecorder(1).timeCfg
local Y = CTimeCfgTable:GetRecorder(2).timeCfg
local Z = CTimeCfgTable:GetRecorder(3).timeCfg

function BM_AllRoles:Ctor()
  self._allroles = NekoData.Data.allroles
end

function BM_AllRoles:GetRoleList()
  local roleList = {}
  for roleId, role in pairs(self._allroles.roles) do
    table.insert(roleList, readonly(role))
  end
  return roleList
end

function BM_AllRoles:GetAllRolesMap()
  local roleMap = {}
  for roleId, role in pairs(self._allroles.roles) do
    roleMap[roleId] = readonly(role)
  end
  return roleMap
end

function BM_AllRoles:GetContainMaterialRoleList()
  local roleList = {}
  for roleId, role in pairs(self._allroles.roles) do
    table.insert(roleList, readonly(role))
  end
  return roleList
end

function BM_AllRoles:GetRoleListByRoleID(roleID)
  local roleList = {}
  for roleId, role in pairs(self._allroles.roles) do
    if role:GetId() == roleID then
      table.insert(roleList, readonly(role))
    end
  end
  return roleList
end

function BM_AllRoles:GetRoleListByDifferentID()
  local roleList = {}
  local isHas = false
  for roleId, role in pairs(self._allroles.roles) do
    isHas = false
    for _, v in pairs(roleList) do
      if v:GetId() == role:GetId() then
        isHas = true
        break
      end
    end
    if not isHas then
      table.insert(roleList, readonly(role))
    end
  end
  return roleList
end

function BM_AllRoles:GetAllRolesCapacity()
  return self._allroles.capacity
end

function BM_AllRoles:GetRole(roleId)
  if roleId and self._allroles.roles[roleId] then
    return readonly(self._allroles.roles[roleId])
  end
end

function BM_AllRoles:GetRoleIsUnlock(roleId)
  return self._allroles.roles[roleId] ~= nil
end

function BM_AllRoles:GetRoleById(roleId)
  return self:GetRole(roleId)
end

function BM_AllRoles:GetRoleHurtExtent(restRepairTime)
  local time = restRepairTime / 1000
  if time <= 0 then
    return 0
  end
  local timeA = 30 * X
  local timeB = 70 * X + 40 * Y
  local timeC = 99 * X + 69 * Y + 2871 * Z
  if time <= timeA then
    return math.ceil(time / X)
  elseif time <= timeB then
    return math.ceil((time + 30 * Y) / (X + Y))
  elseif time <= timeC then
    local a = Z
    local b = X + Y - 70 * Z
    local c = -(time + 30 * Y)
    local t = b * b - 4 * a * c
    if 0 < t then
      local r1 = math.ceil((math.sqrt(t) - b) / (2 * a))
      if r1 <= 99 and 1 <= r1 then
        return r1
      end
      local r2 = math.ceil((-math.sqrt(t) - b) / (2 * a))
      if r2 <= 99 and 1 <= r2 then
        return r2
      end
    elseif t == 0 then
      local r = math.ceil((math.sqrt(t) - b) / (2 * a))
      if r <= 99 and 1 <= r then
        return r
      end
    end
  else
    return 99
  end
end

function BM_AllRoles:GetRoleLevel(roleId)
  if roleId and self._allroles.roles[roleId] then
    return self._allroles.roles[roleId]:GetLevel()
  end
  return nil
end

function BM_AllRoles:GetSoulRefineRoleId()
  return self._allroles.soulRefineRoleId
end

function BM_AllRoles:IsShowRoleEvolutionRed()
  return self._allroles.showRoleEvolutionRedPoint
end

function BM_AllRoles:IsShowRoleRelationRedDot()
  for k, v in pairs(self._allroles.roles) do
    if v:IsShowRelationRedDot() then
      return true
    end
  end
  return false
end

function BM_AllRoles:IsShowRoleRedDot()
  for k, v in pairs(self._allroles.roles) do
    if v:IsShowRelationRedDot() or v:IsShowSkillRedDot() or v:IsShowSkinRedDot() then
      return true
    end
  end
  return false
end

function BM_AllRoles:IsHasNewRole()
  return self._allroles.hasNewRole
end

function BM_AllRoles:GetRoleRelationLevelWithRoleId(roleId)
  for _, role in pairs(self._allroles.roles) do
    if role:GetId() == roleId then
      return role:GetRelationLevel()
    end
  end
end

function BM_AllRoles:PostRoleEvolutionRedDataNotification()
  local userInfo = {}
  userInfo.ShowRed = self._allroles.showRoleEvolutionRedPoint
  LuaNotificationCenter.PostNotification(Common.n_RefreshRoleEvolutionRedData, nil, userInfo)
end

function BM_AllRoles:SetSkinRedDotChecked(skinRecorder)
  if skinRecorder and type(skinRecorder) == "table" then
    local role = self._allroles.roles[skinRecorder.roleid]
    if role then
      local redDotData = role:IsShowSkinRedDot()
      if redDotData and redDotData[skinRecorder.id] then
        local protocol = LuaNetManager.CreateProtocol("protocol.shop.cskinredpoints")
        protocol.looked = skinRecorder.id
        protocol:Send()
        NekoData.DataManager.DM_AllRoles:SetSkinRedDotChecked(skinRecorder)
        LuaNotificationCenter.PostNotification(Common.n_SkinCheckedOrGain, nil, skinRecorder)
      end
    end
  end
end

return BM_AllRoles
