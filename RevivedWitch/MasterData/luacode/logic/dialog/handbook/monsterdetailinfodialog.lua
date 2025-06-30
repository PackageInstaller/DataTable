-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/monsterdetailinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterBookCfg = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local MonsterDetailInfoDialog = class("MonsterDetailInfoDialog", Dialog)
MonsterDetailInfoDialog.AssetBundleName = "ui/layouts.tujian"
MonsterDetailInfoDialog.AssetName = "MonsterBookDetail"
MonsterDetailInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonsterDetailInfoDialog
  ((MonsterDetailInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._skillIDs = {}
end

MonsterDetailInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._back = self:GetChild("Back2")
  self._skillPanel = self:GetChild("Back2/Frame")
  self._skillframe = (TableFrame.Create)(self._skillPanel, self, true, true, true)
  ;
  (self._skillframe):SetMargin(15, 0)
  self._hpScore = self:GetChild("Back2/Frame2/Detail1/Num")
  self._adScore = self:GetChild("Back2/Frame2/Detail2/Num")
  self._apScore = self:GetChild("Back2/Frame2/Detail3/Num")
  self._pdScore = self:GetChild("Back2/Frame2/Detail4/Num")
  self._mdScore = self:GetChild("Back2/Frame2/Detail5/Num")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

MonsterDetailInfoDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._skillframe):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

MonsterDetailInfoDialog.SetMonsterInfo = function(self, monsterid)
  -- function num : 0_3 , upvalues : CMonsterBookCfg, _ENV
  local bookcfg = CMonsterBookCfg:GetRecorder(monsterid)
  ;
  (self._hpScore):SetText(bookcfg.hpScore)
  ;
  (self._adScore):SetText(bookcfg.adScore)
  ;
  (self._apScore):SetText(bookcfg.apScore)
  ;
  (self._pdScore):SetText(bookcfg.pdScore)
  ;
  (self._mdScore):SetText(bookcfg.mdScore)
  self._skillIDs = {}
  for _,skillid in pairs(bookcfg.skillid) do
    (table.insert)(self._skillIDs, skillid)
  end
  ;
  (self._skillframe):ReloadAllCell()
  ;
  (self._skillframe):MoveToTop()
end

MonsterDetailInfoDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  if frame == self._skillframe then
    return #self._skillIDs
  end
end

MonsterDetailInfoDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._skillframe then
    return "handbook.monsterskillcell"
  end
end

MonsterDetailInfoDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._skillframe then
    return (self._skillIDs)[index]
  end
end

MonsterDetailInfoDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_7 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

MonsterDetailInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

MonsterDetailInfoDialog.ShouldLengthChange = function(self)
  -- function num : 0_9
  return true
end

return MonsterDetailInfoDialog

