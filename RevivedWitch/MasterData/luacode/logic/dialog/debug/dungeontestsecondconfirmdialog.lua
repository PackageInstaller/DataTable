-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/debug/dungeontestsecondconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonTestSecondConfirmDialog = class("DungeonTestSecondConfirmDialog", Dialog)
DungeonTestSecondConfirmDialog.AssetBundleName = "ui/layouts.gm"
DungeonTestSecondConfirmDialog.AssetName = "DungeonTestSecondConfirm"
DungeonTestSecondConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonTestSecondConfirmDialog
  ((DungeonTestSecondConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

DungeonTestSecondConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._input = self:GetChild("InputField")
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton = self:GetChild("ConfirmButton")
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

DungeonTestSecondConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonTestSecondConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

DungeonTestSecondConfirmDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local battleid = (self._input):GetText()
  if battleid ~= "" and tonumber(battleid) then
    self:Destroy()
    ;
    ((NekoData.BehaviorManager).BM_Chat):SendMsg("//go " .. battleid)
  end
end

return DungeonTestSecondConfirmDialog

