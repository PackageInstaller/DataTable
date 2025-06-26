-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_battleeditor.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_BattleEditor = class("BM_BattleEditor")
BM_BattleEditor.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._battleEditorData = (NekoData.Data).battleeditor
end

BM_BattleEditor.GetPVPLeftData = function(self, pos)
  -- function num : 0_1
  return (((self._battleEditorData).pvp).left)[pos]
end

BM_BattleEditor.GetPVPRightData = function(self, pos)
  -- function num : 0_2
  return (((self._battleEditorData).pvp).right)[pos]
end

BM_BattleEditor.GetPVEBattleId = function(self)
  -- function num : 0_3
  return ((self._battleEditorData).pve).battleId
end

BM_BattleEditor.GetPVERightData = function(self, pos)
  -- function num : 0_4
  return (((self._battleEditorData).pve).right)[pos]
end

return BM_BattleEditor

