-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmasbagdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ChrisFrameCfg = (BeanManager.GetTableByName)("dungeonselect.cchrisframeconfig")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local MaxColumnNums = 4
local ChristmasBagDialog = class("ChristmasBagDialog", Dialog)
ChristmasBagDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasBagDialog.AssetName = "ActivityChristmasBag"
local RefreshCell = function(self, id)
  -- function num : 0_0 , upvalues : CImagePathTable, _ENV
  local data = (self._dataList)[id]
  ;
  (((self._cell)[id]).text):SetText((data.item):GetName())
  local imageRecord = nil
  if data.unlock and not CImagePathTable:GetRecorder((data.record).imagex) then
    imageRecord = DataCommon.DefaultImageAsset
    if not CImagePathTable:GetRecorder((data.record).imagey) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (((self._cell)[id]).image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

local RefreshAllCell = function(self)
  -- function num : 0_1 , upvalues : _ENV, RefreshCell
  for i,v in ipairs(self._cell) do
    if (self._dataList)[i] then
      (((self._cell)[i]).cell):SetActive(true)
      RefreshCell(self, i)
    else
      ;
      (((self._cell)[i]).cell):SetActive(false)
    end
  end
end

ChristmasBagDialog.Ctor = function(self, ...)
  -- function num : 0_2 , upvalues : ChristmasBagDialog
  ((ChristmasBagDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._dataList = {}
  self._selectBuffItemId = nil
end

ChristmasBagDialog.OnCreate = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._title = self:GetChild("Title")
  self._tip = self:GetChild("Text")
  ;
  (self._title):SetText((TextManager.GetText)(1901204))
  ;
  (self._tip):SetText((TextManager.GetText)(1901452))
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._cell = {}
  for i = 1, 9 do
    do
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

      (self._cell)[i] = {}
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).cell = self:GetChild("ActivityChristmasBagCell/ActivityChristmasBagCell" .. i)
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).text = self:GetChild("ActivityChristmasBagCell/ActivityChristmasBagCell" .. i .. "/Text")
      -- DECOMPILER ERROR at PC74: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).mask = self:GetChild("ActivityChristmasBagCell/ActivityChristmasBagCell" .. i .. "/Mask")
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).image = self:GetChild("ActivityChristmasBagCell/ActivityChristmasBagCell" .. i .. "/Image")
      -- DECOMPILER ERROR at PC92: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._cell)[i]).imageBack = self:GetChild("ActivityChristmasBagCell/ActivityChristmasBagCell" .. i .. "/ImageBack")
      ;
      (((self._cell)[i]).image):SetActive(true)
      ;
      (((self._cell)[i]).imageBack):SetActive(false)
      ;
      (((self._cell)[i]).mask):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_0 , upvalues : i, self
    local index = i
    self:OnCellClicked(index)
  end
, self)
    end
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
end

ChristmasBagDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChristmasBagDialog.SetData = function(self, data)
  -- function num : 0_5 , upvalues : _ENV, ChrisFrameCfg, Item, RefreshAllCell
  while (self._dataList)[#self._dataList] do
    (table.remove)(self._dataList, #self._dataList)
  end
  for k,v in pairs(data) do
    local record = ChrisFrameCfg:GetRecorder(k)
    if record then
      local item = (Item.Create)(k)
      if v ~= 1 then
        do
          do
            local unlock = not item
            ;
            (table.insert)(self._dataList, {itemId = k, unlock = unlock, record = record, item = item})
            LogErrorFormat("ChristmasBagDialog", "buff with id %s is not exist in cchrisframeconfig.", k)
            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  ;
  (table.sort)(self._dataList, function(a, b)
    -- function num : 0_5_0
    do return (a.record).sort < (b.record).sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  RefreshAllCell(self)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ChristmasBagDialog.SelectedCell = function(self, itemId)
  -- function num : 0_6
  if itemId ~= self._selectBuffItemId then
    self._selectBuffItemId = itemId
  end
end

ChristmasBagDialog.OnTipsDestroy = function(self, notification)
  -- function num : 0_7
  if (notification.userInfo)._dialogName == "bag.itemtipsdialog" then
    self:SelectedCell(nil)
  end
end

ChristmasBagDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

ChristmasBagDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ChristmasBagDialog.OnCellClicked = function(self, index)
  -- function num : 0_10 , upvalues : _ENV
  local itemId = ((self._dataList)[index]).item
  self:SelectedCell(itemId)
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = itemId})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return ChristmasBagDialog

