-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_allroles.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local CTimeCfgTable = (BeanManager.GetTableByName)("role.ctimecfg")
local BM_AllRoles = class("BM_AllRoles")
local X = (CTimeCfgTable:GetRecorder(1)).timeCfg
local Y = (CTimeCfgTable:GetRecorder(2)).timeCfg
local Z = (CTimeCfgTable:GetRecorder(3)).timeCfg
BM_AllRoles.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._allroles = (NekoData.Data).allroles
end

BM_AllRoles.GetRoleList = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local roleList = {}
  for roleId,role in pairs((self._allroles).roles) do
    (table.insert)(roleList, readonly(role))
  end
  return roleList
end

BM_AllRoles.GetAllRolesMap = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local roleMap = {}
  for roleId,role in pairs((self._allroles).roles) do
    roleMap[roleId] = readonly(role)
  end
  return roleMap
end

BM_AllRoles.GetContainMaterialRoleList = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local roleList = {}
  for roleId,role in pairs((self._allroles).roles) do
    (table.insert)(roleList, readonly(role))
  end
  return roleList
end

BM_AllRoles.GetRoleListByRoleID = function(self, roleID)
  -- function num : 0_4 , upvalues : _ENV
  local roleList = {}
  for roleId,role in pairs((self._allroles).roles) do
    if role:GetId() == roleID then
      (table.insert)(roleList, readonly(role))
    end
  end
  return roleList
end

BM_AllRoles.GetRoleListByDifferentID = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local roleList = {}
  local isHas = false
  for roleId,role in pairs((self._allroles).roles) do
    isHas = false
    for _,v in pairs(roleList) do
      if v:GetId() == role:GetId() then
        isHas = true
        break
      end
    end
    do
      do
        if not isHas then
          (table.insert)(roleList, readonly(role))
        end
        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return roleList
end

BM_AllRoles.GetAllRolesCapacity = function(self)
  -- function num : 0_6
  return (self._allroles).capacity
end

BM_AllRoles.GetRole = function(self, roleId)
  -- function num : 0_7 , upvalues : _ENV
  if roleId and ((self._allroles).roles)[roleId] then
    return readonly(((self._allroles).roles)[roleId])
  end
end

BM_AllRoles.GetRoleIsUnlock = function(self, roleId)
  -- function num : 0_8
  do return ((self._allroles).roles)[roleId] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_AllRoles.GetRoleById = function(self, roleId)
  -- function num : 0_9
  return self:GetRole(roleId)
end

BM_AllRoles.GetRoleHurtExtent = function(self, restRepairTime)
  -- function num : 0_10 , upvalues : X, Y, Z, _ENV
  local time = restRepairTime / 1000
  if time <= 0 then
    return 0
  end
  local timeA = 30 * X
  local timeB = 70 * X + 40 * Y
  local timeC = 99 * X + 69 * Y + 2871 * Z
  if time <= timeA then
    return (math.ceil)(time / X)
  else
    if time <= timeB then
      return (math.ceil)((time + 30 * Y) / (X + Y))
    else
      if time <= timeC then
        local a = Z
        local b = X + Y - 70 * Z
        local c = -(time + 30 * Y)
        local t = b * b - 4 * a * c
        if t > 0 then
          local r1 = (math.ceil)(((math.sqrt)(t) - b) / (2 * a))
          if r1 <= 99 and r1 >= 1 then
            return r1
          end
          local r2 = (math.ceil)((-(math.sqrt)(t) - b) / (2 * a))
          if r2 <= 99 and r2 >= 1 then
            return r2
          end
        else
          do
            do
              if t == 0 then
                local r = (math.ceil)(((math.sqrt)(t) - b) / (2 * a))
                if r <= 99 and r >= 1 then
                  return r
                end
              end
              do return 99 end
            end
          end
        end
      end
    end
  end
end

BM_AllRoles.GetRoleLevel = function(self, roleId)
  -- function num : 0_11
  if roleId and ((self._allroles).roles)[roleId] then
    return (((self._allroles).roles)[roleId]):GetLevel()
  end
  return nil
end

BM_AllRoles.GetSoulRefineRoleId = function(self)
  -- function num : 0_12
  return (self._allroles).soulRefineRoleId
end

BM_AllRoles.IsShowRoleEvolutionRed = function(self)
  -- function num : 0_13
  return (self._allroles).showRoleEvolutionRedPoint
end

BM_AllRoles.IsShowRoleRelationRedDot = function(self)
  -- function num : 0_14 , upvalues : _ENV
  for k,v in pairs((self._allroles).roles) do
    if v:IsShowRelationRedDot() then
      return true
    end
  end
  return false
end

BM_AllRoles.IsShowRoleRedDot = function(self)
  -- function num : 0_15 , upvalues : _ENV
  for k,v in pairs((self._allroles).roles) do
    if v:IsShowRelationRedDot() or v:IsShowSkillRedDot() or v:IsShowSkinRedDot() then
      return true
    end
  end
  return false
end

BM_AllRoles.IsHasNewRole = function(self)
  -- function num : 0_16
  return (self._allroles).hasNewRole
end

BM_AllRoles.GetRoleRelationLevelWithRoleId = function(self, roleId)
  -- function num : 0_17 , upvalues : _ENV
  for _,role in pairs((self._allroles).roles) do
    if role:GetId() == roleId then
      return role:GetRelationLevel()
    end
  end
end

BM_AllRoles.PostRoleEvolutionRedDataNotification = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local userInfo = {}
  userInfo.ShowRed = (self._allroles).showRoleEvolutionRedPoint
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshRoleEvolutionRedData, nil, userInfo)
end

BM_AllRoles.SetSkinRedDotChecked = function(self, skinRecorder)
  -- function num : 0_19 , upvalues : _ENV
  if skinRecorder and type(skinRecorder) == "table" then
    local role = ((self._allroles).roles)[skinRecorder.roleid]
    if role then
      local redDotData = role:IsShowSkinRedDot()
      if redDotData and redDotData[skinRecorder.id] then
        local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cskinredpoints")
        protocol.looked = skinRecorder.id
        protocol:Send()
        ;
        ((NekoData.DataManager).DM_AllRoles):SetSkinRedDotChecked(skinRecorder)
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_SkinCheckedOrGain, nil, skinRecorder)
      end
    end
  end
end

return BM_AllRoles

