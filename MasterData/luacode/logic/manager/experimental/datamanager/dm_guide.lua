local cGuideLinkConfing = BeanManager.GetTableByName("guide.cguidelinkconfig")
local DM_Guide = class("DM_Guide")
local Guide = require("logic.guide.guide")

function DM_Guide:Ctor()
  self._guide = NekoData.Data.guide
  self._guide.finishedGuideIDTable = {}
  self._guide.currentGuideTable = {}
  self._guide.currentGuide = nil
  self._guide.cachedGuideTable = {}
  self._guide.weakGuideDialogs = {}
  self._guideLinkCfgRecords = {}
  local allIds = cGuideLinkConfing:GetAllIds()
  for i = 1, #allIds do
    self._guideLinkCfgRecords[allIds[i]] = cGuideLinkConfing:GetRecorder(allIds[i])
  end
end

function DM_Guide:Clear()
  for k, v in pairs(self._guide.finishedGuideIDTable) do
    self._guide.finishedGuideIDTable[k] = nil
  end
  if self._guide.currentGuide then
    self._guide.currentGuide:Destroy()
    self._guide.currentGuide = nil
  end
  for k, v in pairs(self._guide.cachedGuideTable) do
    v:Destroy()
    self._guide.cachedGuideTable[k] = nil
  end
  for k, v in pairs(self._guide.weakGuideDialogs) do
    for stageId, dialog in pairs(v) do
      dialog:Destroy()
      dialog:RootWindowDestroy()
      v[stageId] = nil
    end
  end
  self._guide.weakGuideDialogs = {}
end

function DM_Guide:OnSEnter(protocol)
  self._guide.finishedGuideIDTable = protocol.userInfo.procedures
  for k, v in pairs(self._guide.finishedGuideIDTable) do
  end
  for k, v in pairs(self._guideLinkCfgRecords) do
    if not self._guide.finishedGuideIDTable[k] then
      self:CacheGuide(k)
    end
  end
end

function DM_Guide:OnSRecordProcedure(protocol)
  if not self:HasFinished(protocol.procedure) then
    self._guide.finishedGuideIDTable[protocol.procedure] = true
    local guide
    if self._guide.currentGuide and self._guide.currentGuide:GetID() == protocol.procedure then
      guide = self._guide.currentGuide
      self._guide.currentGuide = nil
    else
      guide = self._guide.cachedGuideTable[protocol.procedure]
    end
    if guide then
      guide:Finished()
    end
    self._guide.cachedGuideTable[protocol.procedure] = nil
    LuaNotificationCenter.PostNotification(Common.n_GuideStatusChanged, self, {
      guideStatus = "Finish",
      guideID = protocol.procedure
    })
  end
end

function DM_Guide:FinishGuide(guideID)
  self._guide.finishedGuideIDTable[guideID] = true
  if self._guide.currentGuide and self._guide.currentGuide:GetID() == guideID then
    self._guide.currentGuide = nil
  end
  self._guide.cachedGuideTable[guideID] = nil
  local cRecordProcedire = LuaNetManager.CreateProtocol("protocol.user.crecordprocedure")
  cRecordProcedire.procedure = guideID
  LogInfoFormat("DM_Guide", "---FinishGuide--- guideID = %s ----------", guideID)
  cRecordProcedire:Send()
  LuaNotificationCenter.PostNotification(Common.n_GuideStatusChanged, self, {guideStatus = "Finish", guideID = guideID})
end

function DM_Guide:HasFinished(guideID)
  return self._guide.finishedGuideIDTable[guideID] ~= nil
end

function DM_Guide:CacheGuide(guideID)
  local guide = Guide.Create(guideID)
  self._guide.cachedGuideTable[guideID] = guide
end

function DM_Guide:GetCachedGuideIDs()
  return self._guide.cachedGuideTable
end

function DM_Guide:IsCurrentGuide(guideID)
  return self._guide.currentGuide and self._guide.currentGuide:GetID() == guideID
end

function DM_Guide:IsCurrentStage(guideID, stageID)
  if self:IsCurrentGuide(guideID) == false then
    return false
  end
  local guide = self._guide.currentGuide
  if guide then
    return guide:IsCurrentStage(stageID)
  end
end

function DM_Guide:HasCurrentGuide()
  return self._guide.currentGuide ~= nil
end

function DM_Guide:CancleCurrentGuide(guideID)
  local guide = self._guide.currentGuide
  self._guide.cachedGuideTable[guideID] = guide
  if guide then
    guide:Cancle()
  end
  self._guide.currentGuide = nil
  LuaNotificationCenter.PostNotification(Common.n_GuideStatusChanged, self, {guideStatus = "Cancle", guideID = guideID})
end

function DM_Guide:AddCurrentGuideFromCached(guideID)
  local guide = self._guide.cachedGuideTable[guideID]
  self._guide.cachedGuideTable[guideID] = nil
  self._guide.currentGuide = guide
  return guide
end

function DM_Guide:GetCurrentGuide()
  return self._guide.currentGuide
end

function DM_Guide:GetGuide(guideId)
  if self._guide.currentGuide and self._guide.currentGuide:GetID() == guideId then
    return self._guide.currentGuide
  else
    return self._guide.cachedGuideTable[guideId]
  end
end

return DM_Guide
