local CRedPointLinkConfig = BeanManager.GetTableByName("role.credpointlinkconfig")
local RedPoint = require("logic.redpoint.redpoint")
local TreeNode = require("logic.redpoint.treenode")
local _paramTypeHandlers = {}
local _paramTypeHandlersPath = "logic.redpoint.paramtypehandlers."
local _redPointNumHandlers = {}
local _redPointNumHandlersPath = "logic.redpoint.redpointnumhandlers."
local _getParentParamsHandlers = {}
local _getParentParamsHandlersPath = "logic.redpoint.getparentparamshandlers."
local DM_RedPoint = class("DM_RedPoint")

local function HandleParamType(self, paramTypes, params)
  for i, paramType in ipairs(paramTypes) do
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

local function HandleRedPointNum(self, type, params, childRedPointId, selfRedPointId)
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

local function HandleGetParentParams(self, type, childParams)
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

local function BuildLinkTree(self)
  self._linkTreeNodes = {}
  for k, v in pairs(self._redPointLinkCfgRecords) do
    local treeNode = TreeNode.Create()
    treeNode._id = k
    for i, v in ipairs(v.childs) do
      treeNode._childs[v] = true
    end
    self._linkTreeNodes[k] = treeNode
  end
  for k, v in pairs(self._linkTreeNodes) do
    for i, _ in pairs(v._childs) do
      local treeNode = self._linkTreeNodes[i]
      treeNode._parents[k] = true
    end
  end
end

function DM_RedPoint:Ctor()
  self._redPoint = NekoData.Data.redPoint
  self._redPoint.redPoints = {}
  self._redPoint.cacheRefreshNotifications = {}
  self._redPointLinkCfgRecords = {}
  local allIds = CRedPointLinkConfig:GetAllIds()
  for i = 1, #allIds do
    local id = allIds[i]
    local record = CRedPointLinkConfig:GetRecorder(id)
    self._redPointLinkCfgRecords[id] = record
    if record.paramNum > 0 then
      self._redPoint.cacheRefreshNotifications[id] = {}
    end
  end
  BuildLinkTree(self)
end

function DM_RedPoint:Clear()
  for k, v in pairs(self._redPoint.redPoints) do
    self._redPoint.redPoints[k] = nil
  end
  self:ClearCacheRefreshNotifications()
end

function DM_RedPoint:ClearCacheRefreshNotifications()
  for k, v in pairs(self._redPoint.cacheRefreshNotifications) do
    self._redPoint.cacheRefreshNotifications[k] = nil
    local record = self._redPointLinkCfgRecords[k]
    if record.paramNum > 0 then
      self._redPoint.cacheRefreshNotifications[k] = {}
    end
  end
end

local function GetRedPoint(self, map, index, paramNum, params, id)
  local key = params[index]
  if index < paramNum then
    if not map[key] then
      map[key] = {}
    end
    return GetRedPoint(self, map[key], index + 1, paramNum, params, id)
  elseif index == paramNum then
    if map[key] then
      return map[key]
    else
      local redPoint = RedPoint.Create(id, params)
      map[key] = redPoint
      return redPoint
    end
  end
end

local function GetRedPointByLocalCache(self, map, index, paramNum, params, id)
  local key = params[index]
  local redPoint
  if index < paramNum then
    if not map[key] then
      return
    else
      redPoint = GetRedPointByLocalCache(self, map[key], index + 1, paramNum, params, id)
    end
  elseif index == paramNum then
    if map[key] then
      return map[key]
    else
      return
    end
  end
  return redPoint
end

function DM_RedPoint:UpdateRedPointNum(id, params)
  if not id then
    LogError("DM_RedPoint", "RedPoint id is nil.")
    return
  end
  local redPointRecord = self._redPointLinkCfgRecords[id]
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
      while #params > redPointRecord.paramNum do
        table.remove(params, #params)
      end
      if not HandleParamType(self, redPointRecord.paramTypes, params) then
        LogErrorFormat("DM_RedPoint", "RedPoint(id: %s) params: %s is error.", id, params)
        return
      end
    end
  end
  local redPoint
  if redPointRecord.paramNum > 0 then
    if not self._redPoint.redPoints[id] then
      self._redPoint.redPoints[id] = {}
    end
    redPoint = GetRedPoint(self, self._redPoint.redPoints[id], 1, redPointRecord.paramNum, params, id)
  elseif not self._redPoint.redPoints[id] then
    redPoint = RedPoint.Create(id, params)
    self._redPoint.redPoints[id] = redPoint
  else
    redPoint = self._redPoint.redPoints[id]
  end
  redPoint:UpdateRedPointNum(function(childRedPointId)
    return HandleRedPointNum(self, redPointRecord.type, params, childRedPointId, id)
  end)
  return redPoint:GetRedPointNum()
end

function DM_RedPoint:ChangeRedPointNum(id, params, deltaNum)
  local redPointRecord = self._redPointLinkCfgRecords[id]
  if not redPointRecord then
    LogErrorFormat("DM_RedPoint", "redPoint with id %s is not exist in credpointlinkconfig", id)
    return
  end
  local redPoint
  if redPointRecord.paramNum > 0 then
    redPoint = GetRedPointByLocalCache(self, self._redPoint.redPoints[id], 1, redPointRecord.paramNum, params, id)
  else
    redPoint = self._redPoint.redPoints[id]
  end
  if redPoint then
    redPoint:ChangeRedPointNum(deltaNum)
  else
    self:UpdateRedPointNum(id, params)
  end
end

function DM_RedPoint:GetRedPointNum(id, params)
  if not id then
    LogError("DM_RedPoint", "RedPoint id is nil.")
    return
  end
  local redPointRecord = self._redPointLinkCfgRecords[id]
  if not redPointRecord then
    LogErrorFormat("DM_RedPoint", "redPoint with id %s is not exist in credpointlinkconfig.", id)
    return
  end
  local redPoint
  if redPointRecord.paramNum > 0 then
    if self._redPoint.redPoints[id] then
      redPoint = GetRedPointByLocalCache(self, self._redPoint.redPoints[id], 1, redPointRecord.paramNum, params, id)
    end
  else
    redPoint = self._redPoint.redPoints[id]
  end
  if redPoint then
    return redPoint:GetRedPointNum()
  else
    return self:UpdateRedPointNum(id, params)
  end
end

function DM_RedPoint:GetParentsIdAndParams(childId, childParams)
  local treeNode = self._linkTreeNodes[childId]
  if treeNode then
    local map = {}
    local empty = true
    local redPointRecord = self._redPointLinkCfgRecords[childId]
    for k, v in pairs(treeNode._parents) do
      local getParentParamsType = redPointRecord.getParentParamsType
      if getParentParamsType == -1 then
        LogErrorFormat("DM_RedPoint", "parent's(id: %s) childs and getParentParamsType(childId: %s) do not match.", k, childId)
      elseif getParentParamsType == 0 then
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
    if not empty then
      return map
    end
  else
    LogErrorFormat("DM_RedPoint", "RedPoint id(: %s, childParams: %s) is error.", childId, childParams)
  end
end

return DM_RedPoint
