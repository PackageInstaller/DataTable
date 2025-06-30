-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/base/playerlevelupmaxcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CPlayerLevel = (BeanManager.GetTableByName)("role.cplayerlevel")
local PlayerLevelUpMaxCell = class("PlayerLevelUpMaxCell", Dialog)
PlayerLevelUpMaxCell.AssetBundleName = "ui/layouts.basemainhud"
PlayerLevelUpMaxCell.AssetName = "MagicLevelUpMax"
PlayerLevelUpMaxCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PlayerLevelUpMaxCell
  ((PlayerLevelUpMaxCell.super).Ctor)(self, ...)
end

PlayerLevelUpMaxCell.OnCreate = function(self)
  -- function num : 0_1
  self._spiritPre = self:GetChild("Txt2")
  self._spiritCur = self:GetChild("Txt3")
end

PlayerLevelUpMaxCell.OnDestroy = function(self)
  -- function num : 0_2
end

PlayerLevelUpMaxCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CPlayerLevel
  local lv = (self._delegate):GetLevel()
  ;
  (self._spiritCur):SetText(data.value)
  local playerInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  local recorder = CPlayerLevel:GetRecorder(lv - 1)
  local spiritPre = recorder.strengthLimit
  ;
  (self._spiritPre):SetText(spiritPre)
end

return PlayerLevelUpMaxCell

