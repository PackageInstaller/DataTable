-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gacharesultcell/twocell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TwoCardCell = class("TwoCardCell", Dialog)
TwoCardCell.AssetBundleName = "ui/layouts.gacha"
TwoCardCell.AssetName = "GachaResultTenCell"
TwoCardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TwoCardCell
  ((TwoCardCell.super).Ctor)(self, ...)
  self._backEffectHandler = nil
end

TwoCardCell.OnCreate = function(self)
  -- function num : 0_1
  self._left = self:GetChild("FrameShort")
  self._right = self:GetChild("FrameTall")
  ;
  (self:GetRootWindow()):SetAnimatorTrigger("New Trigger")
end

TwoCardCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._leftDlg then
    (self._leftDlg):Destroy()
    self._leftDlg = nil
  end
  if self._rightDlg then
    (self._rightDlg):Destroy()
    self._rightDlg = nil
  end
end

local cellList = {"gacha.gacharesultcell.r", "gacha.gacharesultcell.sr", "gacha.gacharesultcell.ssr", "gacha.gacharesultcell.ur", "gacha.gacharesultcell.ex"}
TwoCardCell.GetCellName = function(self, data)
  -- function num : 0_3 , upvalues : cellList
  local rarity = (data.role):GetRarityId()
  return cellList[rarity]
end

TwoCardCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  self._data = data
  if data and #data > 0 then
    local dlgName = self:GetCellName(data[1])
    self._leftDlg = (DialogManager.CreateDialog)(dlgName, (self._left)._uiObject)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._leftDlg)._delegate = self
    ;
    (self._leftDlg):RefreshCell(data[1])
    if data[2] then
      local dlgName = self:GetCellName(data[2])
      self._rightDlg = (DialogManager.CreateDialog)(dlgName, (self._right)._uiObject)
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._rightDlg)._delegate = self
      ;
      (self._rightDlg):RefreshCell(data[2])
    end
  end
end

TwoCardCell.CheckRoleInfo = function(self, args)
  -- function num : 0_5
  (self._delegate):CheckRoleInfo(args)
end

TwoCardCell.OnEvent = function(self, name, args)
  -- function num : 0_6
  if name == "hidenew" then
    (self._leftDlg):HideNew()
    if self._rightDlg then
      (self._rightDlg):HideNew()
    end
  end
end

return TwoCardCell

