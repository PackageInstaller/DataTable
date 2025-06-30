-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/mainlinefloordialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MainLineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local Item = require("logic.manager.experimental.types.item")
local MainLineFloorDialog = class("MainLineFloorDialog", Dialog)
MainLineFloorDialog.AssetBundleName = "ui/layouts.mainline"
MainLineFloorDialog.AssetName = "MainLineFloor"
local limit = nil
MainLineFloorDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainLineFloorDialog
  ((MainLineFloorDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._spirit = nil
  self._floorData = {}
  self._itemData = {}
  self._firstItemData = {}
  self._floorDetail = {}
  self._selectRequestSpirit = 0
  self._goGuideEffectHandler = nil
end

MainLineFloorDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : limit, _ENV, TableFrame
  limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._goBtn = self:GetChild("GoBtn")
  self._goGuideEffect = self:GetChild("GoBtn/Effect")
  self._vitPanel = self:GetChild("TopGroup/VIT")
  self._vitNum = self:GetChild("TopGroup/VIT/Text")
  self._addVIT = self:GetChild("TopGroup/VIT/Add")
  self._floorName = self:GetChild("RightPanel/ChapterName")
  self._exploreProgress = self:GetChild("RightPanel/Detail1/Txt2")
  self._recommendCapacity = self:GetChild("RightPanel/Detail2/Txt2")
  self._description = self:GetChild("RightPanel/Detail3/Txt")
  self._power = self:GetChild("Txt2")
  self._powerRed = self:GetChild("Txt2Red")
  self._itemPanel = self:GetChild("RightPanel/CellPanel")
  self._firstItemPanel = self:GetChild("RightPanel/CellPanel2")
  self._leftArrow = self:GetChild("RightPanel/LeftArrow")
  self._rightArrow = self:GetChild("RightPanel/RightArrow")
  self._floorPanel = self:GetChild("LeftPanel")
  self._floorFrame = (TableFrame.Create)(self._floorPanel, self, true, true, true)
  ;
  (self._floorFrame):SetMargin(20, 0)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClicked, self)
  ;
  (self._vitPanel):Subscribe_PointerClickEvent(self.OnAddVITBtnClicked, self)
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  (self._vitNum):SetText(tostring(self._spirit) .. "/" .. tostring(limit))
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(4)
end

MainLineFloorDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
  if self._firstItemFrame then
    (self._firstItemFrame):Destroy()
  end
  ;
  (self._floorFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.spiritrecoverdialog")
  ;
  (DialogManager.DestroySingletonDialog)("teamedit.teameditprewardialog")
end

MainLineFloorDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, MainLineTable
  self._floorData = {}
  local curZone = nil
  for _,v in ipairs(data) do
    local oneline = MainLineTable:GetRecorder(v.id)
    curZone = v.curZone
    if oneline then
      local temp = {}
      temp.id = oneline.id
      temp.spirit = v.spirit
      temp.items = v.items
      temp.firstItem = v.firstItem
      temp.firstGet = v.firstGet
      temp.img = oneline.sceneimage
      temp.floor = oneline.floor
      temp.name = (TextManager.GetText)(oneline.nameTextID)
      ;
      (table.insert)(self._floorData, temp)
    end
  end
  ;
  (self._floorFrame):ReloadAllCell()
  if #self._floorData ~= 0 then
    (self._floorFrame):MoveTopToIndex(1)
  end
  for i,v in ipairs(self._floorData) do
    if curZone == v.id then
      self._select = v
      if #self._floorData ~= 0 then
        (self._floorFrame):MoveTopToIndex(i)
      end
    end
  end
  if self._select then
    self:OnCellClicked(self._select)
  else
    LogWarning("MainLineFloorDialog", "there is no current floor")
  end
end

MainLineFloorDialog.GetSelectedId = function(self)
  -- function num : 0_4
  if self._select then
    return (self._select).id
  else
    return 0
  end
end

MainLineFloorDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5 , upvalues : ItemTypeEnum
  if frame == self._floorFrame then
    return "mainline.mainline.mainlineselectcell"
  else
    if frame == self._itemFrame then
      if ((self._itemData)[index]):GetItemType() == ItemTypeEnum.BASEITEM then
        return "mainline.mainline.mainlineflooritemcell"
      else
        if ((self._itemData)[index]):GetItemType() == ItemTypeEnum.EQUIP then
          return "mainline.mainline.mainlinefloorequipcell"
        end
      end
    else
      if frame == self._firstItemFrame then
        if (((self._firstItemData)[index]).item):GetItemType() == ItemTypeEnum.BASEITEM then
          return "mainline.mainline.mainlineflooritemcell"
        else
          if (((self._firstItemData)[index]).item):GetItemType() == ItemTypeEnum.EQUIP then
            return "mainline.mainline.mainlinefloorequipcell"
          end
        end
      end
    end
  end
end

MainLineFloorDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._floorFrame then
    return (self._floorData)[index]
  else
    if frame == self._itemFrame then
      return (self._itemData)[index]
    else
      if frame == self._firstItemFrame then
        return (self._firstItemData)[index]
      end
    end
  end
end

MainLineFloorDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  if frame == self._floorFrame then
    return #self._floorData
  else
    if frame == self._itemFrame then
      return #self._itemData
    else
      if frame == self._firstItemFrame then
        return #self._firstItemData
      end
    end
  end
end

MainLineFloorDialog.SetFloorFrameSelectedID = function(self, args)
  -- function num : 0_8
  self._selectedID = args
  ;
  (self._floorFrame):FireEvent("SetFloorSelectedState", self._selectedID)
end

MainLineFloorDialog.OnCellClicked = function(self, select)
  -- function num : 0_9 , upvalues : _ENV, MainLineTable, ItemTypeEnum, Item, Equip, Skill, TableFrame
  self._select = select
  self:SetFloorFrameSelectedID(select.id)
  for _,v in ipairs(self._floorData) do
    if select.id == v.id then
      local oneline = MainLineTable:GetRecorder(v.id)
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self._floorDetail).id = v.id
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self._floorDetail).spirit = v.spirit
      ;
      (self._floorName):SetText((TextManager.GetText)(oneline.nameTextID))
      ;
      (self._recommendCapacity):SetText(oneline.magic)
      ;
      (self._description):SetText((TextManager.GetText)(oneline.describeTextID))
      self._selectRequestSpirit = v.spirit
      if self._spirit < v.spirit then
        (self._power):SetActive(false)
        ;
        (self._powerRed):SetActive(true)
      else
        ;
        (self._power):SetActive(true)
        ;
        (self._powerRed):SetActive(false)
      end
      ;
      (self._power):SetText(v.spirit)
      ;
      (self._powerRed):SetText(v.spirit)
      self._firstItemData = {}
      for _,w in ipairs(v.firstItem) do
        local item = nil
        if w.gain == 1 then
          if w.itemtype == ItemTypeEnum.BASEITEM then
            item = ((NekoData.BehaviorManager).BM_BagInfo):GetItem(w.id)
          else
            if w.itemtype == ItemTypeEnum.EQUIP then
              item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(w.id)
            end
          end
        else
          if w.itemtype == ItemTypeEnum.BASEITEM then
            item = (Item.Create)(w.id)
          else
            if w.itemtype == ItemTypeEnum.EQUIP then
              item = (Equip.Create)(w.id)
            else
              if w.itemtype == ItemTypeEnum.SKILL then
                item = (Skill.Create)(w.id)
              end
            end
          end
          item:InitWithItemInfo(w)
        end
        local temp = {item = item, get = false}
        temp.get = v.firstGet
        ;
        (table.insert)(self._firstItemData, temp)
      end
      if self._firstItemFrame then
        (self._firstItemFrame):Destroy()
        self._firstItemFrame = nil
      end
      self._firstItemFrame = (TableFrame.Create)(self._firstItemPanel, self, false, true, false)
      ;
      (self._firstItemFrame):SetMargin(40, 40)
      ;
      (self._firstItemFrame):ReloadAllCell()
      self._itemData = {}
      for _,w in ipairs(v.items) do
        local item = nil
        if w.gain == 1 then
          if w.itemtype == ItemTypeEnum.BASEITEM then
            item = ((NekoData.BehaviorManager).BM_BagInfo):GetItem(w.id)
          else
            if w.itemtype == ItemTypeEnum.EQUIP then
              item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(w.id)
            end
          end
        else
          if w.itemtype == ItemTypeEnum.BASEITEM then
            item = (Item.Create)(w.id)
          else
            if w.itemtype == ItemTypeEnum.EQUIP then
              item = (Equip.Create)(w.id)
            else
              if w.itemtype == ItemTypeEnum.SKILL then
                item = (Skill.Create)(w.id)
              end
            end
          end
          item:InitWithItemInfo(w)
        end
        ;
        (table.insert)(self._itemData, item)
      end
      local equip = {}
      local item = {}
      for _,v in ipairs(self._itemData) do
        if v:GetItemType() == ItemTypeEnum.BASEITEM then
          (table.insert)(item, v)
        else
          ;
          (table.insert)(equip, v)
        end
      end
      ;
      (table.sort)(item, function(a, b)
    -- function num : 0_9_0
    do return b:GetPinJiID() < a:GetPinJiID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      ;
      (table.sort)(equip, function(a, b)
    -- function num : 0_9_1
    do return b:GetPinJiID() < a:GetPinJiID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      self._itemData = {}
      for _,v in ipairs(equip) do
        (table.insert)(self._itemData, v)
      end
      for _,v in ipairs(item) do
        (table.insert)(self._itemData, v)
      end
      if #self._itemData <= 4 then
        (self._leftArrow):SetActive(false)
        ;
        (self._rightArrow):SetActive(false)
      else
        ;
        (self._leftArrow):SetActive(false)
        ;
        (self._rightArrow):SetActive(true)
      end
      if self._itemFrame then
        (self._itemFrame):Destroy()
        self._itemFrame = nil
      end
      self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, true, false)
      ;
      (self._itemFrame):SetMargin(40, 40)
      ;
      (self._itemFrame):ReloadAllCell()
      break
    end
  end
  do
    -- DECOMPILER ERROR at PC365: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC365: Unhandled construct in 'MakeBoolean' P1

    if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(5, 3) and select.id == 2 and self._goGuideEffectHandler == nil then
      self._goGuideEffectHandler = ((NekoData.BehaviorManager).BM_Guide):CreateGuide(self._goGuideEffect)
    end
    ;
    ((NekoData.BehaviorManager).BM_Guide):DestroyGuide(self._goGuideEffect, self._goGuideEffectHandler)
    self._goGuideEffectHandler = nil
  end
end

MainLineFloorDialog.OnGoBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if self._spirit < (self._floorDetail).spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    ;
    ((NekoData.DataManager).DM_Team):ClearSupportRole()
    ;
    ((NekoData.BehaviorManager).BM_Team):SaveTeamEditCopyInfo("MainLine", self:GetSelectedId())
    local crefreshSupportRoleList = (LuaNetManager.CreateProtocol)("protocol.chat.crefreshsupportrolelist")
    crefreshSupportRoleList:Send()
  end
end

MainLineFloorDialog.OnLeftArrowClicked = function(self)
  -- function num : 0_11
  local rightIndex = (self._itemFrame):GetRightIndex()
  ;
  (self._itemFrame):MoveRightToIndex(rightIndex - 1, true)
end

MainLineFloorDialog.OnRightArrowClicked = function(self)
  -- function num : 0_12
  local leftIndex = (self._itemFrame):GetLeftIndex()
  ;
  (self._itemFrame):MoveLeftToIndex(leftIndex + 1, true)
end

MainLineFloorDialog.OnCurPosChange = function(self, frame, ratio)
  -- function num : 0_13
  if frame == self._itemFrame then
    if ratio == 0 then
      (self._leftArrow):SetActive(false)
    else
      if ratio == 1 then
        (self._rightArrow):SetActive(false)
      else
        ;
        (self._leftArrow):SetActive(true)
        ;
        (self._rightArrow):SetActive(true)
      end
    end
  end
end

MainLineFloorDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_14 , upvalues : _ENV, limit
  self._spirit = (notification.userInfo).spirit
  ;
  (self._vitNum):SetText(tostring(self._spirit) .. "/" .. tostring(limit))
  if self._spirit < self._selectRequestSpirit then
    (self._power):SetActive(false)
    ;
    (self._powerRed):SetActive(true)
  else
    ;
    (self._power):SetActive(true)
    ;
    (self._powerRed):SetActive(false)
  end
end

MainLineFloorDialog.OnBackPressed = function(self)
  -- function num : 0_15
  self:Destroy()
  return true, true
end

MainLineFloorDialog.GetFloorDetail = function(self)
  -- function num : 0_16
  return self._floorDetail
end

MainLineFloorDialog.OnAddVITBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

return MainLineFloorDialog

