-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/npcchat/npcchatselectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NpcChatSelectCell = class("NpcChatSelectCell", Dialog)
NpcChatSelectCell.AssetBundleName = "ui/layouts.dramadialog"
NpcChatSelectCell.AssetName = "DramaSelectionCell"
NpcChatSelectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NpcChatSelectCell
  ((NpcChatSelectCell.super).Ctor)(self, ...)
end

NpcChatSelectCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Select1/_Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

NpcChatSelectCell.OnDestroy = function(self)
  -- function num : 0_2
end

NpcChatSelectCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  if data.chooseText then
    (self._text):SetText(tostring(data.chooseText))
  end
  if data.playEffect then
    (self:GetRootWindow()):SetAnimatorInteger("important", 1)
  else
    ;
    (self:GetRootWindow()):SetAnimatorInteger("important", 0)
  end
end

NpcChatSelectCell.OnCellClicked = function(self, args, luawindow)
  -- function num : 0_4
  (self._delegate):OnCellClicked((self._cellData).index)
end

return NpcChatSelectCell

