-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_anniversaryshare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SAnniversaryShareInfoDef = (LuaNetManager.GetProtocolDef)("protocol.activity.sanniversaryshareinfo")
local DM_AnniversaryShare = class("DM_AnniversaryShare")
DM_AnniversaryShare.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).anniversaryshare
  self:Clear()
end

DM_AnniversaryShare.Clear = function(self)
  -- function num : 0_1 , upvalues : SAnniversaryShareInfoDef
  self:KillAllTimer()
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).initialTime = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).leftTime = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).shareLeftTime = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).pictureID = 0
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).totalShare = 0
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).totShareAward = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).dailyShareAward = SAnniversaryShareInfoDef.LOCKED
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).totShareAwardCanGet = {}
end

DM_AnniversaryShare.OnSAnniversaryShareInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV, SAnniversaryShareInfoDef
  self:KillAllTimer()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).initialTime = (ServerGameTimer.GetServerTimeForecast)()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).leftTime = protocol.leftTime
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).shareLeftTime = protocol.shareLeftTime
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.leftTime > 0 then
    (self._data).totalTimerId = (ServerGameTimer.AddTask)(protocol.leftTime / 1000, -1, function()
    -- function num : 0_2_0 , upvalues : self, _ENV, protocol
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (self._data).leftTime = 0
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnSAnniversaryShareInfo, nil, protocol)
  end
)
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.shareLeftTime > 0 then
    (self._data).shareTimerId = (ServerGameTimer.AddTask)(protocol.shareLeftTime / 1000, -1, function()
    -- function num : 0_2_1 , upvalues : self, _ENV, protocol
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (self._data).shareLeftTime = 0
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnSAnniversaryShareInfo, nil, protocol)
  end
)
  end
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).pictureID = protocol.picture
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).totalShare = protocol.totalShare
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).totShareAward = protocol.totShareAward
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).dailyShareAward = protocol.dailyShareAward
  for key,value in pairs(protocol.totShareAward) do
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R7 in 'UnsetPending'

    if value == SAnniversaryShareInfoDef.UNLOCKED then
      ((self._data).totShareAwardCanGet)[key] = value
    else
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R7 in 'UnsetPending'

      if value == SAnniversaryShareInfoDef.FETCHED then
        ((self._data).totShareAwardCanGet)[key] = nil
      end
    end
  end
  if PrintTable then
    PrintTable(protocol, 3, "OnSAnniversaryShareInfo")
  end
end

DM_AnniversaryShare.KillAllTimer = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if (self._data).totalTimerId then
    (ServerGameTimer.RemoveTask)((self._data).totalTimerId)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._data).totalTimerId = nil
  end
  if (self._data).shareTimerId then
    (ServerGameTimer.RemoveTask)((self._data).shareTimerId)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._data).shareTimerId = nil
  end
end

return DM_AnniversaryShare

