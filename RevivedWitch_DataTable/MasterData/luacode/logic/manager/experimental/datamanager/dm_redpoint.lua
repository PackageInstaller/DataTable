-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_redpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRedPointLinkConfig = (BeanManager.GetTableByName)("role.credpointlinkconfig")
local RedPoint = require("logic.redpoint.redpoint")
local TreeNode = require("logic.redpoint.treenode")
local _paramTypeHandlers = {}
local _paramTypeHandlersPath = "logic.redpoint.paramtypehandlers."
local _redPointNumHandlers = {}
local _redPointNumHandlersPath = "logic.redpoint.redpointnumhandlers."
local _getParentParamsHandlers = {}
local _getParentParamsHandlersPath = "logic.redpoint.getparentparamshandlers."
local DM_RedPoint = class("DM_RedPoint")
local HandleParamType = function(self, paramTypes, params)
  -- function num : 0_0 , upvalues : _ENV, _paramTypeHandlers, _paramTypeHandlersPath
  for i,paramType in ipairs(paramTypes) do
    local handler = _paramTypeHandlers[paramType]
    if not handler then
      handler = require(_paramTypeHandlersPath .. paramType)
      if not handler then
        LogErrorFormat("DM_RedPoint", "redPoint paramType with id %s is not exist.", paramType)
        return 
      else
        _paramTypeHandlers[paramType] = handler
      end
    end
    local value = handler(params[i], params)
    if not value then
      LogErrorFormat("DM_RedPoint", "redPoint param(: %s) and paramType(: %s) do not match.", params[i], paramType)
      return false
    end
  end
  return true
end

local HandleRedPointNum = function(self, type, params, childRedPointId, selfRedPointId)
  -- function num : 0_1 , upvalues : _redPointNumHandlers, _ENV, _redPointNumHandlersPath
  local handler = _redPointNumHandlers[type]
  if not handler then
    handler = require(_redPointNumHandlersPath .. type)
    if not handler then
      LogErrorFormat("DM_RedPoint", "redPoint NumType with id %s is not exist", type)
      return 
    else
      _redPointNumHandlers[type] = handler
    end
  end
  return handler(params, childRedPointId, selfRedPointId)
end

local HandleGetParentParams = function(self, type, childParams)
  -- function num : 0_2 , upvalues : _getParentParamsHandlers, _ENV, _getParentParamsHandlersPath
  local handler = _getParentParamsHandlers[type]
  if not handler then
    handler = require(_getParentParamsHandlersPath .. type)
    if not handler then
      LogErrorFormat("DM_RedPoint", "getParentParamsType(: %s) is not exist", type)
      return 
    else
      _getParentParamsHandlers[type] = handler
    end
  end
  return handler(childParams)
end

local BuildLinkTree = function(self)
  -- function num : 0_3 , upvalues : _ENV, TreeNode
  self._linkTreeNodes = {}
  for k,v in pairs(self._redPointLinkCfgRecords) do
    local treeNode = (TreeNode.Create)()
    treeNode._id = k
    for i,v in ipairs(v.childs) do
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R12 in 'UnsetPending'

      (treeNode._childs)[v] = true
    end
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._linkTreeNodes)[k] = treeNode
  end
  for k,v in pairs(self._linkTreeNodes) do
    for i,_ in pairs(v._childs) do
      local treeNode = (self._linkTreeNodes)[i]
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (treeNode._parents)[k] = true
    end
  end
end

DM_RedPoint.Ctor = function(self)
  -- function num : 0_4 , upvalues : _ENV, CRedPointLinkConfig, BuildLinkTree
  self._redPoint = (NekoData.Data).redPoint
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._redPoint).redPoints = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._redPoint).cacheRefreshNotifications = {}
  self._redPointLinkCfgRecords = {}
  local allIds = CRedPointLinkConfig:GetAllIds()
  for i = 1, #allIds do
    local id = allIds[i]
    local record = CRedPointLinkConfig:GetRecorder(id)
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._redPointLinkCfgRecords)[id] = record
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

    if record.paramNum > 0 then
      ((self._redPoint).cacheRefreshNotifications)[id] = {}
    end
  end
  BuildLinkTree(self)
end

DM_RedPoint.Clear = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in pairs((self._redPoint).redPoints) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._redPoint).redPoints)[k] = nil
  end
  self:ClearCacheRefreshNotifications()
end

DM_RedPoint.ClearCacheRefreshNotifications = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for k,v in pairs((self._redPoint).cacheRefreshNotifications) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._redPoint).cacheRefreshNotifications)[k] = nil
    local record = (self._redPointLinkCfgRecords)[k]
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

    if record.paramNum > 0 then
      ((self._redPoint).cacheRefreshNotifications)[k] = {}
    end
  end
end

local GetRedPoint = function(self, map, index, paramNum, params, id)
  -- function num : 0_7 , upvalues : GetRedPoint, RedPoint
  local key = params[index]
  if index < paramNum then
    if not map[key] then
      map[key] = {}
    end
    return GetRedPoint(self, map[key], index + 1, paramNum, params, id)
  else
    if index == paramNum then
      if map[key] then
        return map[key]
      else
        local redPoint = (RedPoint.Create)(id, params)
        map[key] = redPoint
        return redPoint
      end
    end
  end
end

local GetRedPointByLocalCache = function(self, map, index, paramNum, params, id)
  -- function num : 0_8 , upvalues : GetRedPointByLocalCache
  local key = params[index]
  local redPoint = nil
  if index < paramNum then
    if not map[key] then
      return 
    else
      redPoint = GetRedPointByLocalCache(self, map[key], index + 1, paramNum, params, id)
    end
  else
    if index == paramNum then
      if map[key] then
        return map[key]
      else
        return 
      end
    end
  end
  return redPoint
end

DM_RedPoint.UpdateRedPointNum = function(self, id, params)
  -- function num : 0_9 , upvalues : _ENV, HandleParamType, GetRedPoint, RedPoint, HandleRedPointNum
  if not id then
    LogError("DM_RedPoint", "RedPoint id is nil.")
    return 
  end
  local redPointRecord = (self._redPointLinkCfgRecords)[id]
  if not redPointRecord then
    LogErrorFormat("DM_RedPoint", "redPoint with id %s is not exist in credpointlinkconfig.", id)
    return 
  end
  if redPointRecord.paramNum > 0 then
    if not params then
      LogErrorFormat("DM_RedPoint", "RedPoint(id: %s) params is nil.", id)
      return 
    else
      local paramsNum = #params
      if paramsNum < redPointRecord.paramNum then
        LogErrorFormat("DM_RedPoint", "RedPoint(id: %s) params: %s is lacking.", id, params)
        return 
      end
      while redPointRecord.paramNum < #params do
        (table.remove)(params, #params)
      end
      if not HandleParamType(self, redPointRecord.paramTypes, params) then
        LogErrorFormat("DM_RedPoint", "RedPoint(id: %s) params: %s is error.", id, params)
        return 
      end
    end
  end
  do
    local redPoint = nil
    -- DECOMPILER ERROR at PC76: Confused about usage of register: R5 in 'UnsetPending'

    if redPointRecord.paramNum > 0 then
      if not ((self._redPoint).redPoints)[id] then
        ((self._redPoint).redPoints)[id] = {}
      end
      redPoint = GetRedPoint(self, ((self._redPoint).redPoints)[id], 1, redPointRecord.paramNum, params, id)
    else
      if not ((self._redPoint).redPoints)[id] then
        redPoint = (RedPoint.Create)(id, params)
        -- DECOMPILER ERROR at PC101: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self._redPoint).redPoints)[id] = redPoint
      else
        redPoint = ((self._redPoint).redPoints)[id]
      end
    end
    redPoint:UpdateRedPointNum(function(childRedPointId)
    -- function num : 0_9_0 , upvalues : HandleRedPointNum, self, redPointRecord, params, id
    return HandleRedPointNum(self, redPointRecord.type, params, childRedPointId, id)
  end
)
    return redPoint:GetRedPointNum()
  end
end

DM_RedPoint.ChangeRedPointNum = function(self, id, params, deltaNum)
  -- function num : 0_10 , upvalues : _ENV, GetRedPointByLocalCache
  local redPointRecord = (self._redPointLinkCfgRecords)[id]
  if not redPointRecord then
    LogErrorFormat("DM_RedPoint", "redPoint with id %s is not exist in credpointlinkconfig", id)
    return 
  end
  local redPoint = nil
  if redPointRecord.paramNum > 0 then
    redPoint = GetRedPointByLocalCache(self, ((self._redPoint).redPoints)[id], 1, redPointRecord.paramNum, params, id)
  else
    redPoint = ((self._redPoint).redPoints)[id]
  end
  if redPoint then
    redPoint:ChangeRedPointNum(deltaNum)
  else
    self:UpdateRedPointNum(id, params)
  end
end

DM_RedPoint.GetRedPointNum = function(self, id, params)
  -- function num : 0_11 , upvalues : _ENV, GetRedPointByLocalCache
  if not id then
    LogError("DM_RedPoint", "RedPoint id is nil.")
    return 
  end
  local redPointRecord = (self._redPointLinkCfgRecords)[id]
  if not redPointRecord then
    LogErrorFormat("DM_RedPoint", "redPoint with id %s is not exist in credpointlinkconfig.", id)
    return 
  end
  local redPoint = nil
  if redPointRecord.paramNum > 0 and ((self._redPoint).redPoints)[id] then
    redPoint = GetRedPointByLocalCache(self, ((self._redPoint).redPoints)[id], 1, redPointRecord.paramNum, params, id)
  end
  redPoint = ((self._redPoint).redPoints)[id]
  if redPoint then
    return redPoint:GetRedPointNum()
  else
    return self:UpdateRedPointNum(id, params)
  end
end

DM_RedPoint.GetParentsIdAndParams = function(self, childId, childParams)
  -- function num : 0_12 , upvalues : _ENV, HandleGetParentParams
  local treeNode = (self._linkTreeNodes)[childId]
  if treeNode then
    local map = {}
    local empty = true
    local redPointRecord = (self._redPointLinkCfgRecords)[childId]
    for k,v in pairs(treeNode._parents) do
      local getParentParamsType = redPointRecord.getParentParamsType
      if getParentParamsType == -1 then
        LogErrorFormat("DM_RedPoint", "parent\'s(id: %s) childs and getParentParamsType(childId: %s) do not match.", k, childId)
      else
        if getParentParamsType == 0 then
          map[k] = true
          empty = false
        else
          local params = HandleGetParentParams(self, getParentParamsType, childParams)
          if not params or type(params) ~= "table" then
            LogError("DM_RedPoint", "RedPoint id is nil.")
          else
            map[k] = params
            empty = false
          end
        end
      end
    end
    if not empty then
      return map
    end
  else
    do
      LogErrorFormat("DM_RedPoint", "RedPoint id(: %s, childParams: %s) is error.", childId, childParams)
    end
  end
end

return DM_RedPoint

