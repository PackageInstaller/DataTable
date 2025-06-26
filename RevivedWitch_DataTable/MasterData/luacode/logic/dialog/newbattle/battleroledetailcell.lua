-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battleroledetailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleRoleDetailCell = class("BattleRoleDetailCell", Dialog)
BattleRoleDetailCell.AssetBundleName = "ui/layouts.battlenew"
BattleRoleDetailCell.AssetName = "BattleDetail2Cell"
BattleRoleDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleRoleDetailCell
  ((BattleRoleDetailCell.super).Ctor)(self, ...)
end

BattleRoleDetailCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Text")
  self._whiteName = self:GetChild("Text2")
  ;
  (self._whiteName):SetActive(false)
  self._num = self:GetChild("Num")
end

BattleRoleDetailCell.OnDestroy = function(self)
  -- function num : 0_2
end

BattleRoleDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._name):SetText(data.name)
  ;
  (self._num):SetText(data.num)
end

return BattleRoleDetailCell

