-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/runeadvancement/runeadvancementmixdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRoleadvancedItemExchange = (BeanManager.GetTableByName)("role.croleadvanceditemexchange")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Num = 3
local RuneAdvancementMixDialog = class("RuneAdvancementMixDialog", Dialog)
RuneAdvancementMixDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
RuneAdvancementMixDialog.AssetName = "CharUpgradeMix"
RuneAdvancementMixDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RuneAdvancementMixDialog
  ((RuneAdvancementMixDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._which = 1
end

RuneAdvancementMixDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, Num, TableFrame
  (self:GetChild("Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2047))
  ;
  (self:GetChild("GroupBtnBack/GroupBtn1/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2043))
  ;
  (self:GetChild("GroupBtnBack/GroupBtn2/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2044))
  ;
  (self:GetChild("GroupBtnBack/GroupBtn3/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2045))
  self._groupBtn = {}
  for i = 1, Num do
    do
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtn)[i] = self:GetChild("GroupBtnBack/GroupBtn" .. R9_PC54)
      ;
      ((self._groupBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSelectWhich(i)
  end
, self)
    end
  end
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._backBtn = self:GetChild("CloseBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:OnSelectWhich(1, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_1 , upvalues : self
    self:OnRefresh()
  end
, Common.n_ItemNumModify, nil)
end

RuneAdvancementMixDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

RuneAdvancementMixDialog.OnSelectWhich = function(self, index, refresh)
  -- function num : 0_3 , upvalues : Num
  if self._which == index and not refresh then
    return 
  end
  for i = 1, Num do
    ((self._groupBtn)[i]):SetSelected(i == index)
  end
  self._which = index
  self:OnRefresh()
  ;
  (self._frame):MoveToTop()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

RuneAdvancementMixDialog.OnRefresh = function(self)
  -- function num : 0_4 , upvalues : _ENV, CRoleadvancedItemExchange
  local lastPos = (self._frame):GetCurrentPosition()
  local templist = {}
  for i,v in ipairs(CRoleadvancedItemExchange:GetAllIds()) do
    local record = CRoleadvancedItemExchange:GetRecorder(v)
    if record.itemQuality == self._which then
      (table.insert)(templist, record)
    end
  end
  ;
  (table.sort)(templist, function(a, b)
    -- function num : 0_4_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self._dataList = templist
  ;
  (self._frame):ReloadAllCell()
  if lastPos then
    (self._frame):MoveToAssignedPos(lastPos)
  end
end

RuneAdvancementMixDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

RuneAdvancementMixDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._dataList
end

RuneAdvancementMixDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "character.runeadvancement.runeadvancementmixcell"
end

RuneAdvancementMixDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._dataList)[index]
end

return RuneAdvancementMixDialog

