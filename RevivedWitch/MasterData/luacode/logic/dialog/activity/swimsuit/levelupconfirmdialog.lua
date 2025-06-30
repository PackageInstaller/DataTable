-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/levelupconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local LevelUpConfirmDialog = class("LevelUpConfirmDialog", Dialog)
LevelUpConfirmDialog.AssetBundleName = "ui/layouts.activitysummer"
LevelUpConfirmDialog.AssetName = "ActivitySummerLevelUpConfirm"
LevelUpConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LevelUpConfirmDialog
  ((LevelUpConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._consumeData = {}
  self._canLevelUp = true
end

LevelUpConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._consumePanel = self:GetChild("Frame")
  self._size_x = (self._consumePanel):GetSize()
  self._pos_x = (self._consumePanel):GetPosition()
  self._showText = self:GetChild("Text1")
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._confirmText = self:GetChild("CancelButton/_Text")
  self._cancelText = self:GetChild("ConfirmButton/_Text")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, R4_PC7)
  -- DECOMPILER ERROR at PC46: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, R4_PC7)
end

LevelUpConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._consumeFrame):Destroy()
end

LevelUpConfirmDialog.SetData = function(self, data, name)
  -- function num : 0_3 , upvalues : _ENV, CStringRes, TableFrame
  self._constructionId = data.landID
  self._nextConstructionLevel = data.level
  self._itemIDs = data.itemID
  self._itemAmount = data.itemAmount
  ;
  (self._showText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1589)).msgTextID, name, self._nextConstructionLevel - 1, self._nextConstructionLevel))
  self._consumeData = {}
  for i = 1, #self._itemIDs do
    (table.insert)(self._consumeData, {itemID = (self._itemIDs)[i], itemNum = (self._itemAmount)[i]})
  end
  ;
  (self._confirmText):SetText((TextManager.GetText)((CStringRes:GetRecorder(2)).msgTextID))
  ;
  (self._cancelText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1)).msgTextID))
  self._canLevelUp = true
  local num = #self._itemIDs or 0
  local offset = self._size_offset_x / 6
  ;
  (self._consumePanel):SetSize(self._size_x, offset * num * 2, self._size_y, self._size_offset_y)
  ;
  (self._consumePanel):SetPosition(self._pos_x, -1 * offset * num, self._pos_y, self._pos_offset_y)
  self._consumeFrame = (TableFrame.Create)(self._consumePanel, self, false, false, false)
  ;
  (self._consumeFrame):ReloadAllCell()
end

LevelUpConfirmDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  return #self._consumeData
end

LevelUpConfirmDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "activity.swimsuit.levelupconsumecell"
end

LevelUpConfirmDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._consumeData)[index]
end

LevelUpConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

LevelUpConfirmDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._canLevelUp then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cupdatesummerconstruction")
    if protocol then
      protocol.ID = self._constructionId
      protocol:Send()
    end
    self:Destroy()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100385)
    end
  end
end

return LevelUpConfirmDialog

