-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipforgedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Item = require("logic.manager.experimental.types.item")
local CEQuipEnchantItem = (BeanManager.GetTableByName)("equip.cequipenchantitem")
local CEquipStrengthenTtem = (BeanManager.GetTableByName)("equip.cequipstrengthenitem")
local ColumnsNum = 3
local MinRowNum = 4
local TabIndex = {Strengthen = 1, Break = 2, Enchant = 3}
local MainCityState = require("logic.fsm.gamefsm.maincity")
local EquipForgeDialog = class("EquipForgeDialog", Dialog)
EquipForgeDialog.AssetBundleName = "ui/layouts.equip"
EquipForgeDialog.AssetName = "EquipForge"
EquipForgeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipForgeDialog
  ((EquipForgeDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._tab = nil
  self._equipkey = nil
  self._equip = nil
  self._forgeIetmData = {}
  self._strengthenSelectItemData = {}
  self._selectedItems = {}
end

EquipForgeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TabFrame, GridFrame, ColumnsNum, MainCityState
  self._manaBtn = self:GetChild("TopGroup/Num1")
  self._manaTxt = self:GetChild("TopGroup/Num1/Text")
  self._diamondBtn = self:GetChild("TopGroup/Num2")
  self._diamondTxt = self:GetChild("TopGroup/Num2/Text")
  ;
  (self._manaTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID))
  ;
  (self._diamondTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.DiamodID))
  ;
  (self._manaBtn):Subscribe_PointerClickEvent(self.OnManaBtnClick, self)
  ;
  (self._diamondBtn):Subscribe_PointerClickEvent(self.OnDiamondBtnClick, self)
  self._panel_tab = self:GetChild("BackImg/Panel")
  self._panel_grid = self:GetChild("BackImg/Frame")
  self._groupBtns = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtns)[i] = self:GetChild("GroupBtn" .. i)
      ;
      ((self._groupBtns)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnGroupBtnClick(i)
  end
)
    end
  end
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._tab_frame = (TabFrame.Create)(self._panel_tab, self)
  self._item_frame = (GridFrame.Create)(self._panel_grid, self, true, ColumnsNum)
  ;
  (self._item_frame):SetMargin(30, 0)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAPChange, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnStrengthenReduceItems, Common.n_EquipStrengthenReduceItems, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnStrengthenQuickChoose, Common.n_EquipStrengthenQuickChoose, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEquipStrengthenItemEnough, Common.n_EquipStrengthenItemEnough, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEquipStrengthenItemNotEnough, Common.n_EquipStrengthenItemNotEnough, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_PreEnchantEquip, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_EquipLevelUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_EquipExpUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_EquipBreak, nil)
  self._inDungeon = GlobalGameFSM:GetCurrentState() == "Dungeon"
  local dialog = (DialogManager.GetDialog)("battle.battleaccount.battlelosetextdialog")
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCityBattle" and MainCityState.uIBackManagerIsActive then
    (UIBackManager.SetActive)(true)
  else
    (UIBackManager.SetUIBackShow)(true)
    ;
    (UIBackManager.SetUIModalBackColor)(2)
  end
  ;
  (self._menuBtn):SetActive((not self._inDungeon and not dialog))
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

EquipForgeDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV, MainCityState
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCityBattle" and MainCityState.uIBackManagerIsActive then
    (UIBackManager.SetActive)(false)
  else
    ;
    (UIBackManager.SetUIBackShow)(false)
  end
  ;
  (self._tab_frame):Destroy()
  ;
  (self._item_frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  local dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
  if dialog then
    dialog:SetActive(true)
  end
  local dialog = (DialogManager.GetDialog)("equip.presetequipdialog")
  if dialog then
    dialog:SetActive(true)
  end
end

EquipForgeDialog.Init = function(self, equipkey)
  -- function num : 0_3 , upvalues : _ENV
  self._equipkey = equipkey
  self._equip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(equipkey)
  if #(self._equip):GetRandomEntry() < 1 then
    ((self._groupBtns)[3]):SetActive(false)
  end
  self:OnGroupBtnClick(1)
end

EquipForgeDialog.OnRefresh = function(self)
  -- function num : 0_4
  self:OnGroupBtnClick(self._tab)
end

EquipForgeDialog.OnGroupBtnClick = function(self, index)
  -- function num : 0_5 , upvalues : TabIndex, _ENV, CEquipStrengthenTtem, CEQuipEnchantItem, Item
  if index == TabIndex.Break and not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Equip_Break) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100177)
    return 
  else
    if index == TabIndex.Enchant and not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Equip_Enchant) then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100178)
      return 
    end
  end
  ;
  (self._item_frame):FireEvent("ItemEnough", true)
  self._selectedItems = {}
  self._strengthenSelectItemData = {}
  ;
  ((self._tab_frame):GetCellAtIndex(index)):OnHidden()
  if self._tab ~= index then
    self._tab = index
    local cellPage = (self._tab_frame):ToPage(self._tab)
    if cellPage and cellPage.RefreshCell then
      cellPage:RefreshCell()
    end
  end
  do
    self._forgeIetmData = {}
    if index == TabIndex.Strengthen then
      local itemList = {}
      local record = ((NekoData.BehaviorManager).BM_BagInfo):GetStrengthenItemList()
      for _,value in ipairs(record) do
        local temp = {}
        temp.value = value
        temp.tag = "item"
        ;
        (table.insert)(itemList, temp)
      end
      ;
      (table.sort)(itemList, function(a, b)
    -- function num : 0_5_0 , upvalues : CEquipStrengthenTtem
    local sortA = (CEquipStrengthenTtem:GetRecorder((a.value):GetID())).sort
    local sortB = (CEquipStrengthenTtem:GetRecorder((b.value):GetID())).sort
    if sortA < sortB then
      return true
    else
      if (a.value):GetID() >= (b.value):GetID() then
        do return sortA ~= sortB end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
)
      for _,value in ipairs(itemList) do
        (table.insert)(self._forgeIetmData, value)
      end
      local equipList = {}
      record = ((NekoData.BehaviorManager).BM_BagInfo):GetUnLockEquipList()
      for _,value in ipairs(record) do
        if value:GetRoleKey() == 0 and value:GetKey() ~= self._equipkey and value:GetStrengthenLevel() <= 1 and value:GetEquipExp() <= 0 then
          local temp = {}
          temp.value = value
          temp.tag = "equip"
          ;
          (table.insert)(equipList, temp)
        end
      end
      ;
      (table.sort)(equipList, function(a, b)
    -- function num : 0_5_1
    if (a.value):GetScore() < (b.value):GetScore() then
      return true
    else
      if (a.value):GetScore() == (b.value):GetScore() then
        if (a.value):GetID() < (b.value):GetID() then
          return true
        else
          if (a.value):GetKey() >= (b.value):GetKey() then
            do return (a.value):GetID() ~= (b.value):GetID() end
            -- DECOMPILER ERROR: 2 unprocessed JMP targets
          end
        end
      end
    end
  end
)
      for _,value in ipairs(equipList) do
        (table.insert)(self._forgeIetmData, value)
      end
    else
      do
        if index == TabIndex.Break then
          local pinJi = (self._equip):GetBreaKNeedEquipsPinji()
          local equipList = {}
          local record = ((NekoData.BehaviorManager).BM_BagInfo):GetUnLockEquipList()
          for key,value in ipairs(record) do
            if value:GetRoleKey() == 0 then
              local temp = {}
              if value:GetPinJiID() == pinJi and value:GetKey() ~= self._equipkey then
                temp.value = value
                temp.tag = "equip"
                ;
                (table.insert)(equipList, temp)
              end
            end
          end
          ;
          (table.sort)(equipList, function(a, b)
    -- function num : 0_5_2
    if (a.value):GetRoleKey() < (b.value):GetRoleKey() then
      return true
    else
      if (a.value):GetStrengthenLevel() >= (b.value):GetStrengthenLevel() then
        do return (a.value):GetRoleKey() ~= (b.value):GetRoleKey() end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
)
          for _,value in ipairs(equipList) do
            (table.insert)(self._forgeIetmData, value)
          end
        else
          do
            if index == TabIndex.Enchant then
              local itemList = {}
              local record = ((NekoData.BehaviorManager).BM_BagInfo):GetEnchantItemList()
              local idTable = {}
              for k,v in pairs(CEQuipEnchantItem:GetAllIds()) do
                idTable[v] = v
              end
              for k,v in ipairs(record) do
                idTable[v:GetID()] = nil
              end
              for k,v in pairs(idTable) do
                if (CEQuipEnchantItem:GetRecorder(v)).show == 1 then
                  local item = (Item.Create)(v)
                  item:SetCount(0)
                  ;
                  (table.insert)(record, item)
                end
              end
              for key,value in ipairs(record) do
                local temp = {}
                temp.value = value
                temp.tag = "item"
                ;
                (table.insert)(itemList, temp)
              end
              ;
              (table.sort)(itemList, function(a, b)
    -- function num : 0_5_3 , upvalues : CEQuipEnchantItem
    local sortA = (CEQuipEnchantItem:GetRecorder((a.value):GetID())).sort
    local sortB = (CEQuipEnchantItem:GetRecorder((b.value):GetID())).sort
    if sortB < sortA then
      return true
    else
      if (a.value):GetID() >= (b.value):GetID() then
        do return sortA ~= sortB end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
)
              for _,value in ipairs(itemList) do
                (table.insert)(self._forgeIetmData, value)
              end
            end
            do
              ;
              (self._item_frame):ReloadAllCell()
            end
          end
        end
      end
    end
  end
end

EquipForgeDialog.DidToPage = function(self, frame, index)
  -- function num : 0_6 , upvalues : _ENV
  for k,v in pairs(self._groupBtns) do
    if k == index then
      v:SetSelected(true)
    else
      v:SetSelected(false)
    end
  end
  local dlg = (self._tab_frame):GetCellAtIndex(index)
  if dlg.Init then
    dlg:Init(self._equipkey)
  end
end

EquipForgeDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._tab_frame then
    if index == 1 then
      return "equipforge.strengthenequiptabcell"
    else
      if index == 2 then
        return "equipforge.breakequiptabcell"
      else
        if index == 3 then
          return "equipforge.enchantequiptabcell"
        end
      end
    end
  else
    if frame == self._item_frame then
      if self._tab == 1 then
        if ((self._forgeIetmData)[index]).tag == "equip" then
          return "equipforge.equipforgeequipcell"
        else
          if ((self._forgeIetmData)[index]).tag == "item" then
            return "equipforge.equipforgeitemcell"
          end
        end
      else
        if self._tab == 3 then
          return "equipforge.equipforgeitemcell"
        else
          if self._tab == 2 then
            return "equipforge.equipforgeequipcell"
          end
        end
      end
    end
  end
end

EquipForgeDialog.NumberOfCell = function(self, frame)
  -- function num : 0_8
  local num = #self._forgeIetmData
  return num
end

EquipForgeDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._forgeIetmData)[index]
end

EquipForgeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

EquipForgeDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

EquipForgeDialog.OnManaBtnClick = function(self)
  -- function num : 0_12 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.ManaID)})
    local width, height = (self._manaBtn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._manaBtn):GetLocalPointInUiRootPanel())
  end
end

EquipForgeDialog.OnDiamondBtnClick = function(self)
  -- function num : 0_13 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.DiamodID)})
    local width, height = (self._diamondBtn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._diamondBtn):GetLocalPointInUiRootPanel())
  end
end

EquipForgeDialog.OnAPChange = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (self._manaTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID))
  ;
  (self._diamondTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.DiamodID))
end

EquipForgeDialog.SelectItems = function(self, key, tag)
  -- function num : 0_15 , upvalues : TabIndex, _ENV
  if self._tab == TabIndex.Strengthen then
    local isExist = false
    for i,value in ipairs(self._strengthenSelectItemData) do
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R9 in 'UnsetPending'

      if ((self._strengthenSelectItemData)[i]).key == key then
        ((self._strengthenSelectItemData)[i]).count = ((self._strengthenSelectItemData)[i]).count + 1
        isExist = true
        break
      end
    end
    do
      do
        do
          if not isExist then
            local temp = {}
            temp.count = 1
            temp.tag = tag
            temp.key = key
            ;
            (table.insert)(self._strengthenSelectItemData, temp)
          end
          self:SetSelectedItems()
          ;
          (self._item_frame):FireEvent("ChangeSelectedItemNum", key)
          -- DECOMPILER ERROR at PC58: Unhandled construct in 'MakeBoolean' P1

          if self._tab == TabIndex.Break and (table.nums)(self._selectedItems) < (self._equip):GetBreaKNeedEquipsCount() then
            local isExist = false
            for i,v in ipairs(self._selectedItems) do
              if v == key then
                isExist = true
                break
              end
            end
            do
              do
                if not isExist then
                  (table.insert)(self._selectedItems, key)
                  self:SetSelectedItems()
                  ;
                  (self._item_frame):FireEvent("ChangeSelectedItemNum", key)
                end
                if self._tab == TabIndex.Enchant then
                  self._selectedItems = {}
                  -- DECOMPILER ERROR at PC90: Confused about usage of register: R3 in 'UnsetPending'

                  ;
                  (self._selectedItems)[key] = 1
                  self:SetSelectedItems()
                  ;
                  (self._item_frame):FireEvent("ChangeSelectedItemNum", nil)
                end
              end
            end
          end
        end
      end
    end
  end
end

EquipForgeDialog.SetSelectedItems = function(self, selectedItems)
  -- function num : 0_16
  if selectedItems then
    local temp = nil
    if self._tab == 1 then
      temp = self._strengthenSelectItemData
    else
      temp = self._selectedItems
    end
    local dlg = (self._tab_frame):GetCellAtIndex(self._tab)
    if dlg.RefreshItemFrame then
      dlg:RefreshItemFrame(temp)
    end
  end
end

EquipForgeDialog.ReduceItems = function(self, id)
  -- function num : 0_17 , upvalues : TabIndex, _ENV
  if self._tab == TabIndex.Strengthen then
    local removeIndex, num = nil, nil
    for i,value in ipairs(self._strengthenSelectItemData) do
      if ((self._strengthenSelectItemData)[i]).key == id then
        num = ((self._strengthenSelectItemData)[i]).count - 1
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R9 in 'UnsetPending'

        if num > 0 then
          ((self._strengthenSelectItemData)[i]).count = num
          break
        end
        removeIndex = i
        break
      end
    end
    do
      do
        if removeIndex then
          (table.remove)(self._strengthenSelectItemData, removeIndex)
        end
        if self._tab == TabIndex.Break then
          for i,value in ipairs(self._selectedItems) do
            if value == id then
              removeIndex = i
              break
            end
          end
          do
            ;
            (table.remove)(self._selectedItems, removeIndex)
            if self._tab == TabIndex.Enchant then
              self._selectedItems = {}
            end
            self:SetSelectedItems()
            ;
            (self._item_frame):FireEvent("ChangeSelectedItemNum", id)
          end
        end
      end
    end
  end
end

EquipForgeDialog.OnStrengthenReduceItems = function(self, notification)
  -- function num : 0_18
  local id = notification.userInfo
  self:ReduceItems(id)
end

EquipForgeDialog.OnStrengthenQuickChoose = function(self, notification)
  -- function num : 0_19
  local list = notification.userInfo
  self._strengthenSelectItemData = list
  ;
  (self._item_frame):FireEvent("ChangeSelectedItemNum", nil)
end

EquipForgeDialog.OnEquipStrengthenItemEnough = function(self, notification)
  -- function num : 0_20
  (self._item_frame):FireEvent("ItemEnough", false)
end

EquipForgeDialog.OnEquipStrengthenItemNotEnough = function(self, notification)
  -- function num : 0_21
  (self._item_frame):FireEvent("ItemEnough", true)
end

EquipForgeDialog.OnEquipBreakFull = function(self)
  -- function num : 0_22
  (self._item_frame):FireEvent("EquipBreakFull", false)
end

EquipForgeDialog.OnEquipBreakNotFull = function(self)
  -- function num : 0_23
  (self._item_frame):FireEvent("EquipBreakNotFull", false)
end

EquipForgeDialog.IsEquipStrengthenItemEnough = function(self)
  -- function num : 0_24 , upvalues : TabIndex
  return ((self._tab_frame):GetCellAtIndex(TabIndex.Strengthen))._isItemEnough
end

EquipForgeDialog.IsEquipBreakFull = function(self)
  -- function num : 0_25 , upvalues : TabIndex
  return (((self._tab_frame):GetCellAtIndex(TabIndex.Break))._equip):GetBreakMaxLevel()
end

return EquipForgeDialog

