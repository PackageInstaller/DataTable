-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/quicklevelup/quicklevelupconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Num = 3
local QuickLevelUpConfirmDialog = class("QuickLevelUpConfirmDialog", Dialog)
QuickLevelUpConfirmDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
QuickLevelUpConfirmDialog.AssetName = "CharFastLevelUpSecond"
QuickLevelUpConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : QuickLevelUpConfirmDialog
  ((QuickLevelUpConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

QuickLevelUpConfirmDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV, CImagePathTable
  self._cur_lv = self:GetChild("Tips/BreakLevelBack1/LevelNum")
  self._cur_breakLevelBackBlack = self:GetChild("Tips/BreakLevelBack1/BreakLevelBackBlack")
  self._cur_breakLvBack = self:GetChild("Tips/BreakLevelBack1/BreakLevelBack")
  self._cur_breakLv = self:GetChild("Tips/BreakLevelBack1/BreakLevelNum")
  self._next_lv = self:GetChild("Tips/BreakLevelBack2/LevelNum")
  self._next_breakLevelBackBlack = self:GetChild("Tips/BreakLevelBack2/BreakLevelBackBlack")
  self._next_breakLvBack = self:GetChild("Tips/BreakLevelBack2/BreakLevelBack")
  self._next_breakLv = self:GetChild("Tips/BreakLevelBack2/BreakLevelNum")
  self._roleName = self:GetChild("RoleName")
  self._cost_breakMaterial_panel = self:GetChild("Frame")
  self._cost_breakMaterial_frame = (TableFrame.Create)(self._cost_breakMaterial_panel, self, false, false)
  self._cost_breakMaterial_frame_width = (self._cost_breakMaterial_panel):GetRectSize()
  self._cost_breakMaterial_frame_anchoredx = (self._cost_breakMaterial_panel):GetAnchoredPosition()
  self._confirmBtn = self:GetChild("CommonBtn")
  self._cancelBtn = self:GetChild("CancelBtn")
  self._back = self:GetChild("Tips")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_NoTargetWindowClick, nil)
  ;
  (self:GetChild("text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1747))
  if not CImagePathTable:GetRecorder(14211) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._cur_breakLvBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._next_breakLvBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

QuickLevelUpConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._cost_breakMaterial_frame):Destroy()
end

QuickLevelUpConfirmDialog.SetData = function(self, role, curLv, nextLv, costData)
  -- function num : 0_3 , upvalues : _ENV, Num
  self._role = role
  self._costData = costData
  self._nextLv = nextLv
  local breakLv, showLv = (self._role):GetBreakLvAndShowLvByRoleLv(curLv)
  ;
  (self._cur_lv):SetText(showLv)
  ;
  (self._cur_breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._cur_breakLvBack):SetActive(breakLv > 0)
  ;
  (self._cur_breakLv):SetActive(breakLv > 0)
  if breakLv > 0 then
    (self._cur_breakLv):SetText(breakLv)
  end
  breakLv = (self._role):GetBreakLvAndShowLvByRoleLv(nextLv)
  ;
  (self._next_lv):SetText(showLv)
  ;
  (self._next_breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._next_breakLvBack):SetActive(breakLv > 0)
  ;
  (self._next_breakLv):SetActive(breakLv > 0)
  if breakLv > 0 then
    (self._next_breakLv):SetText(breakLv)
  end
  ;
  (self._roleName):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1748, {(self._role):GetRoleName()}))
  local cellPanelWidth = self._cost_breakMaterial_frame_width / Num * #costData.breakMaterials
  ;
  (self._cost_breakMaterial_panel):SetSize(0, cellPanelWidth, 0, self._cost_breakMaterial_frame_height)
  ;
  (self._cost_breakMaterial_panel):SetAnchoredPosition(self._cost_breakMaterial_frame_anchoredx, self._cost_breakMaterial_frame_anchoredy)
  ;
  (self._cost_breakMaterial_frame):ReloadAllCell()
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

QuickLevelUpConfirmDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.login.crolequicklevelup")
  protocol.roleId = (self._role):GetId()
  protocol.level = self._nextLv
  protocol:Send()
end

QuickLevelUpConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

QuickLevelUpConfirmDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_6 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

QuickLevelUpConfirmDialog.NumberOfCell = function(self)
  -- function num : 0_7
  if self._costData then
    return #(self._costData).breakMaterials
  else
    return 0
  end
end

QuickLevelUpConfirmDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "character.quicklevelup.costbreakmaterialitemcell"
end

QuickLevelUpConfirmDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if self._costData then
    return ((self._costData).breakMaterials)[index]
  end
end

return QuickLevelUpConfirmDialog

