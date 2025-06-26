-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversarypackage/skinlistdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CItemPinji = (BeanManager.GetTableByName)("item.citempinji")
local CSkinShopCfg = (BeanManager.GetTableByName)("activity.cskinshopcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SkillListDialog = class("SkillListDialog", Dialog)
SkillListDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
SkillListDialog.AssetName = "Activity1YearOtherShopFashion"
SkillListDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillListDialog
  ((SkillListDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._skinList = {}
end

SkillListDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._titleText = self:GetChild("Back/Title")
  ;
  (self._titleText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2068))
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

SkillListDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
  end
end

SkillListDialog.RefreshList = function(self)
  -- function num : 0_3 , upvalues : _ENV, CSkinShopCfg
  for i,v in ipairs(CSkinShopCfg:GetAllIds()) do
    local recorde = CSkinShopCfg:GetRecorder(v)
    ;
    (table.insert)(self._skinList, recorde)
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

SkillListDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

SkillListDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._skinList
end

SkillListDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.anniversarypackage.skincell"
end

SkillListDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._skinList)[index]
end

return SkillListDialog

