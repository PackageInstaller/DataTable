-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlepauseenemyinfocell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattlePauseEnemyInfoCell = class("BattlePauseEnemyInfoCell", Dialog)
BattlePauseEnemyInfoCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseEnemyInfoCell.AssetName = "BattlePauseCellEnemy"
BattlePauseEnemyInfoCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattlePauseEnemyInfoCell
  ((BattlePauseEnemyInfoCell.super).Ctor)(self, ...)
end

BattlePauseEnemyInfoCell.OnCreate = function(self)
  -- function num : 0_1
  self._titleBack = self:GetChild("Skill/TitleBack")
  self._title = self:GetChild("Skill/TitleBack/Txt")
  self._describe = self:GetChild("Skill/Txt")
  self._width = (self._describe):GetRectSize()
  local _ = 0
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
end

BattlePauseEnemyInfoCell.OnDestroy = function(self)
  -- function num : 0_2
end

BattlePauseEnemyInfoCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._title):SetText(data.title)
  local titleWidth = (self._title):GetPreferredSize()
  ;
  (self._titleBack):SetWidth(0, titleWidth)
  ;
  (self._describe):SetText(data.describe)
  local _, textheight = (self._describe):GetPreferredSize()
  local fontsize = (self._describe):GetFontSize()
  local delta = (math.ceil)(textheight - self._height)
  ;
  (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
end

return BattlePauseEnemyInfoCell

