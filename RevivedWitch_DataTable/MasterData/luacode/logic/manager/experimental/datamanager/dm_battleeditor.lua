-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_battleeditor.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_BattleEditor = class("DM_BattleEditor")
DM_BattleEditor.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._battleEditorData = (NekoData.Data).battleeditor
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleEditorData).pve = {battleId = 0, 
right = {}
}
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleEditorData).pvp = {
left = {}
, 
right = {}
}
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._battleEditorData).pve).battleId = (((CS.UnityEngine).PlayerPrefs).GetInt)("battleId")
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[1] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[1]")
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[2] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[2]")
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[3] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[3]")
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[4] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[4]")
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[5] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[5]")
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[6] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[6]")
  -- DECOMPILER ERROR at PC95: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[7] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[7]")
  -- DECOMPILER ERROR at PC105: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[8] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[8]")
  -- DECOMPILER ERROR at PC115: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[9] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[9]")
  -- DECOMPILER ERROR at PC125: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[1] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[1]")
  -- DECOMPILER ERROR at PC135: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[2] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[2]")
  -- DECOMPILER ERROR at PC145: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[3] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[3]")
  -- DECOMPILER ERROR at PC155: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[4] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[4]")
  -- DECOMPILER ERROR at PC165: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[5] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[5]")
  -- DECOMPILER ERROR at PC175: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[6] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[6]")
  -- DECOMPILER ERROR at PC185: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[7] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[7]")
  -- DECOMPILER ERROR at PC195: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[8] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[8]")
  -- DECOMPILER ERROR at PC205: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[9] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[9]")
  -- DECOMPILER ERROR at PC215: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[1] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[1]")
  -- DECOMPILER ERROR at PC225: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[2] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[2]")
  -- DECOMPILER ERROR at PC235: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[3] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[3]")
  -- DECOMPILER ERROR at PC245: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[4] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[4]")
  -- DECOMPILER ERROR at PC255: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[5] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[5]")
  -- DECOMPILER ERROR at PC265: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[6] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[6]")
  -- DECOMPILER ERROR at PC275: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[7] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[7]")
  -- DECOMPILER ERROR at PC285: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[8] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[8]")
  -- DECOMPILER ERROR at PC295: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[9] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[9]")
end

DM_BattleEditor.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ((self._battleEditorData).pve).battleId = (((CS.UnityEngine).PlayerPrefs).GetInt)("battleId")
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[1] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[1]")
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[2] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[2]")
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[3] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[3]")
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[4] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[4]")
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[5] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[5]")
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[6] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[6]")
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[7] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[7]")
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[8] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[8]")
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pve).right)[9] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pve.right[9]")
  -- DECOMPILER ERROR at PC108: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[1] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[1]")
  -- DECOMPILER ERROR at PC118: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[2] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[2]")
  -- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[3] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[3]")
  -- DECOMPILER ERROR at PC138: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[4] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[4]")
  -- DECOMPILER ERROR at PC148: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[5] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[5]")
  -- DECOMPILER ERROR at PC158: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[6] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[6]")
  -- DECOMPILER ERROR at PC168: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[7] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[7]")
  -- DECOMPILER ERROR at PC178: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[8] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[8]")
  -- DECOMPILER ERROR at PC188: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).left)[9] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.left[9]")
  -- DECOMPILER ERROR at PC198: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[1] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[1]")
  -- DECOMPILER ERROR at PC208: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[2] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[2]")
  -- DECOMPILER ERROR at PC218: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[3] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[3]")
  -- DECOMPILER ERROR at PC228: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[4] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[4]")
  -- DECOMPILER ERROR at PC238: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[5] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[5]")
  -- DECOMPILER ERROR at PC248: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[6] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[6]")
  -- DECOMPILER ERROR at PC258: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[7] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[7]")
  -- DECOMPILER ERROR at PC268: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[8] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[8]")
  -- DECOMPILER ERROR at PC278: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._battleEditorData).pvp).right)[9] = (((CS.UnityEngine).PlayerPrefs).GetInt)("pvp.right[9]")
end

DM_BattleEditor.SetPVPLeft = function(self, pos, roleConfigId)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  (((self._battleEditorData).pvp).left)[pos] = roleConfigId
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)("pvp.left[" .. tostring(pos) .. "]", roleConfigId)
end

DM_BattleEditor.SetPVPRight = function(self, pos, roleConfigId)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  (((self._battleEditorData).pvp).right)[pos] = roleConfigId
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)("pvp.right[" .. tostring(pos) .. "]", roleConfigId)
end

DM_BattleEditor.SetPVEBattleId = function(self, battleId)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._battleEditorData).pve).battleId = battleId
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)("battleId", battleId)
end

DM_BattleEditor.SetPVERight = function(self, pos, roleConfigId)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  (((self._battleEditorData).pve).right)[pos] = roleConfigId
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)("pve.right[" .. tostring(pos) .. "]", roleConfigId)
end

return DM_BattleEditor

