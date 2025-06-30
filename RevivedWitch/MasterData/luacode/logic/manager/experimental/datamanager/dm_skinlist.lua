-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_skinlist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_SkinList = class("DM_SkinList")
DM_SkinList.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).skinlist
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).skinlist = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).taskstate = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).totalskinNum = 0
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).currentNum = 0
end

DM_SkinList.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  while ((self._data).skinlist)[#(self._data).skinlist] do
    (table.remove)((self._data).skinlist, #(self._data).skinlist)
  end
  while ((self._data).taskstate)[#(self._data).taskstate] do
    (table.remove)((self._data).taskstate, #(self._data).taskstate)
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).totalskinNum = 0
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).currentNum = 0
end

DM_SkinList.OnSGetSkinOverview = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).totalskinNum = 0
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).currentNum = 0
  local str = ""
  for k,v in pairs(protocol.skins) do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R8 in 'UnsetPending'

    if v == 1 then
      (self._data).currentNum = (self._data).currentNum + 1
      str = str .. tostring(k) .. "," .. tostring(v) .. ";"
    end
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._data).totalskinNum = (self._data).totalskinNum + 1
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self._data).skinlist)[k] = v
  end
end

DM_SkinList.OnSAddOverviewSkin = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  if (table.contain)((self._data).skinlist, protocol.skinId) then
    LogErrorFormat("DM_SkinList", "SAddOverviewSkin Repeat Unlock %s", protocol.skinId)
    return 
  end
  LogInfoFormat("DM_SkinList", "UnLock%d", protocol.skinId)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).skinlist)[protocol.skinId] = 1
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).currentNum = (self._data).currentNum + 1
end

DM_SkinList.OnSRefreshSkinCollectTask = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  local str = ""
  for k,v in ipairs(protocol.tasks) do
    str = str .. tostring(k) .. "," .. tostring(v) .. ";"
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self._data).taskstate)[k] = v
  end
  LogInfoFormat("DM_SkinList", "OnSGetSkinOverview:%s", str)
end

return DM_SkinList

