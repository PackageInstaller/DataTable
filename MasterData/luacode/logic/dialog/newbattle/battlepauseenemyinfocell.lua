local BattlePauseEnemyInfoCell = class("BattlePauseEnemyInfoCell", Dialog)
BattlePauseEnemyInfoCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseEnemyInfoCell.AssetName = "BattlePauseCellEnemy"

function BattlePauseEnemyInfoCell:Ctor(...)
  BattlePauseEnemyInfoCell.super.Ctor(self, ...)
end

function BattlePauseEnemyInfoCell:OnCreate()
  self._titleBack = self:GetChild("Skill/TitleBack")
  self._title = self:GetChild("Skill/TitleBack/Txt")
  self._describe = self:GetChild("Skill/Txt")
  self._width, self._height = self._describe:GetRectSize()
  local _ = 0
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function BattlePauseEnemyInfoCell:OnDestroy()
end

function BattlePauseEnemyInfoCell:RefreshCell(data)
  self._title:SetText(data.title)
  local titleWidth = self._title:GetPreferredSize()
  self._titleBack:SetWidth(0, titleWidth)
  self._describe:SetText(data.describe)
  local _, textheight = self._describe:GetPreferredSize()
  local fontsize = self._describe:GetFontSize()
  local delta = math.ceil(textheight - self._height)
  self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
end

return BattlePauseEnemyInfoCell
