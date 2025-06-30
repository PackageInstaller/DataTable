-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_guide.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cGuideLinkConfing = (BeanManager.GetTableByName)("guide.cguidelinkconfig")
local DM_Guide = class("DM_Guide")
local Guide = require("logic.guide.guide")
DM_Guide.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, cGuideLinkConfing
  self._guide = (NekoData.Data).guide
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guide).finishedGuideIDTable = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guide).currentGuideTable = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guide).currentGuide = nil
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guide).cachedGuideTable = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guide).weakGuideDialogs = {}
  self._guideLinkCfgRecords = {}
  local allIds = cGuideLinkConfing:GetAllIds()
  for i = 1, #allIds do
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

    (self._guideLinkCfgRecords)[allIds[i]] = cGuideLinkConfing:GetRecorder(allIds[i])
  end
end

DM_Guide.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs((self._guide).finishedGuideIDTable) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._guide).finishedGuideIDTable)[k] = nil
  end
  if (self._guide).currentGuide then
    ((self._guide).currentGuide):Destroy()
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._guide).currentGuide = nil
  end
  for k,v in pairs((self._guide).cachedGuideTable) do
    v:Destroy()
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._guide).cachedGuideTable)[k] = nil
  end
  for k,v in pairs((self._guide).weakGuideDialogs) do
    for stageId,dialog in pairs(v) do
      dialog:Destroy()
      dialog:RootWindowDestroy()
      v[stageId] = nil
    end
  end
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guide).weakGuideDialogs = {}
end

DM_Guide.OnSEnter = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (self._guide).finishedGuideIDTable = (protocol.userInfo).procedures
  for k,v in pairs((self._guide).finishedGuideIDTable) do
  end
  for k,v in pairs(self._guideLinkCfgRecords) do
    if not ((self._guide).finishedGuideIDTable)[k] then
      self:CacheGuide(k)
    end
  end
end

DM_Guide.OnSRecordProcedure = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if not self:HasFinished(protocol.procedure) then
    ((self._guide).finishedGuideIDTable)[protocol.procedure] = true
    local guide = nil
    if (self._guide).currentGuide and ((self._guide).currentGuide):GetID() == protocol.procedure then
      guide = (self._guide).currentGuide
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self._guide).currentGuide = nil
    else
      guide = ((self._guide).cachedGuideTable)[protocol.procedure]
    end
    if guide then
      guide:Finished()
    end
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._guide).cachedGuideTable)[protocol.procedure] = nil
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_GuideStatusChanged, self, {guideStatus = "Finish", guideID = protocol.procedure})
  end
end

DM_Guide.FinishGuide = function(self, guideID)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._guide).finishedGuideIDTable)[guideID] = true
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  if (self._guide).currentGuide and ((self._guide).currentGuide):GetID() == guideID then
    (self._guide).currentGuide = nil
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guide).cachedGuideTable)[guideID] = nil
  local cRecordProcedire = (LuaNetManager.CreateProtocol)("protocol.user.crecordprocedure")
  cRecordProcedire.procedure = guideID
  LogInfoFormat("DM_Guide", "---FinishGuide--- guideID = %s ----------", guideID)
  cRecordProcedire:Send()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_GuideStatusChanged, self, {guideStatus = "Finish", guideID = guideID})
end

DM_Guide.HasFinished = function(self, guideID)
  -- function num : 0_5
  do return ((self._guide).finishedGuideIDTable)[guideID] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_Guide.CacheGuide = function(self, guideID)
  -- function num : 0_6 , upvalues : Guide
  local guide = (Guide.Create)(guideID)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._guide).cachedGuideTable)[guideID] = guide
end

DM_Guide.GetCachedGuideIDs = function(self)
  -- function num : 0_7
  return (self._guide).cachedGuideTable
end

DM_Guide.IsCurrentGuide = function(self, guideID)
  -- function num : 0_8
  do return not (self._guide).currentGuide or ((self._guide).currentGuide):GetID() == guideID end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DM_Guide.IsCurrentStage = function(self, guideID, stageID)
  -- function num : 0_9
  if self:IsCurrentGuide(guideID) == false then
    return false
  end
  local guide = (self._guide).currentGuide
  if guide then
    return guide:IsCurrentStage(stageID)
  end
end

DM_Guide.HasCurrentGuide = function(self)
  -- function num : 0_10
  do return (self._guide).currentGuide ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_Guide.CancleCurrentGuide = function(self, guideID)
  -- function num : 0_11 , upvalues : _ENV
  local guide = (self._guide).currentGuide
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._guide).cachedGuideTable)[guideID] = guide
  if guide then
    guide:Cancle()
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._guide).currentGuide = nil
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_GuideStatusChanged, self, {guideStatus = "Cancle", guideID = guideID})
end

DM_Guide.AddCurrentGuideFromCached = function(self, guideID)
  -- function num : 0_12
  local guide = ((self._guide).cachedGuideTable)[guideID]
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._guide).cachedGuideTable)[guideID] = nil
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._guide).currentGuide = guide
  return guide
end

DM_Guide.GetCurrentGuide = function(self)
  -- function num : 0_13
  return (self._guide).currentGuide
end

DM_Guide.GetGuide = function(self, guideId)
  -- function num : 0_14
  if (self._guide).currentGuide and ((self._guide).currentGuide):GetID() == guideId then
    return (self._guide).currentGuide
  else
    return ((self._guide).cachedGuideTable)[guideId]
  end
end

return DM_Guide

