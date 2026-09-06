local TabFrame = require("framework.ui.frame.tab.tabframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Item = require("logic.manager.experimental.types.item")
local CEQuipEnchantItem = BeanManager.GetTableByName("equip.cequipenchantitem")
local CEquipStrengthenTtem = BeanManager.GetTableByName("equip.cequipstrengthenitem")
local CBaoShiItem = BeanManager.GetTableByName("item.cbaoshi")
local CBaoShiSelect = BeanManager.GetTableByName("equip.cbaoshiselect")
local UIManager = CS.PixelNeko.UI.UIManager
local ColumnsNum = 3
local GemType = 571
local TabIndex = {
  Strengthen = 1,
  Break = 2,
  Enchant = 3,
  GemSetting = 4
}
local MainCityState = require("logic.fsm.gamefsm.maincity")
local EquipForgeDialog = class("EquipForgeDialog", Dialog)
EquipForgeDialog.AssetBundleName = "ui/layouts.equip"
EquipForgeDialog.AssetName = "EquipForge"

function EquipForgeDialog:Ctor(...)
  EquipForgeDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._tab = nil
  self._equipkey = nil
  self._equip = nil
  self._forgeIetmData = {}
  self._strengthenSelectItemData = {}
  self._selectedItems = {}
end

function EquipForgeDialog:OnCreate()
  self._manaBtn = self:GetChild("TopGroup/Num1")
  self._manaTxt = self:GetChild("TopGroup/Num1/Text")
  self._diamondBtn = self:GetChild("TopGroup/Num2")
  self._diamondTxt = self:GetChild("TopGroup/Num2/Text")
  self._manaTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID))
  self._diamondTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
  self._manaBtn:Subscribe_PointerClickEvent(self.OnManaBtnClick, self)
  self._diamondBtn:Subscribe_PointerClickEvent(self.OnDiamondBtnClick, self)
  self._panel_tab = self:GetChild("BackImg/Panel")
  self._panel_grid = self:GetChild("BackImg/Frame")
  self._groupBtns = {}
  for i = 1, 4 do
    self._groupBtns[i] = self:GetChild("GroupBtn" .. i)
    self._groupBtns[i]:Subscribe_PointerClickEvent(function()
      self:OnGroupBtnClick(i)
    end)
  end
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._tips = self:GetChild("BackImg/Tips")
  self._title = self:GetChild("BackImg/LeftTitle/Text")
  self._fliterBtn = self:GetChild("BackImg/FliterBtn")
  self._confirm_fliterBtn = self:GetChild("BackImg/EquipXQFliterFrame/ConfirmBtn")
  self._gemfliter_back = self:GetChild("BackImg/EquipXQFliterFrame")
  self._gemfliter_grid = self:GetChild("BackImg/EquipXQFliterFrame/Frame")
  self._gemfliter_frame = GridFrame.Create(self._gemfliter_grid, self, true, 2)
  self._gemfliter_frame:SetMargin(15, 0)
  self._tab_frame = TabFrame.Create(self._panel_tab, self)
  self._item_frame = GridFrame.Create(self._panel_grid, self, true, ColumnsNum)
  self._item_frame:SetMargin(30, 0)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._fliterBtn:Subscribe_PointerClickEvent(self.OnFliterBtnClicked, self)
  self._confirm_fliterBtn:Subscribe_PointerClickEvent(self.OnConfirmFliterBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnAPChange, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnStrengthenReduceItems, Common.n_EquipStrengthenReduceItems, nil)
  LuaNotificationCenter.AddObserver(self, self.OnStrengthenQuickChoose, Common.n_EquipStrengthenQuickChoose, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEquipStrengthenItemEnough, Common.n_EquipStrengthenItemEnough, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEquipStrengthenItemNotEnough, Common.n_EquipStrengthenItemNotEnough, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_PreEnchantEquip, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipExpUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipBreak, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipGemSetting, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_NoTargetWindowClick, nil)
  self._inDungeon = GlobalGameFSM:GetCurrentState() == "Dungeon"
  local dialog = DialogManager.GetDialog("battle.battleaccount.battlelosetextdialog")
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCityBattle" and MainCityState.uIBackManagerIsActive then
    UIBackManager.SetActive(true)
  else
    UIBackManager.SetUIBackShow(true)
    UIBackManager.SetUIModalBackColor(2)
  end
  self._menuBtn:SetActive(not self._inDungeon and not dialog)
end

function EquipForgeDialog:OnDestroy()
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCityBattle" and MainCityState.uIBackManagerIsActive then
    UIBackManager.SetActive(false)
  else
    UIBackManager.SetUIBackShow(false)
  end
  self._tab_frame:Destroy()
  self._item_frame:Destroy()
  self._gemfliter_frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
  if dialog then
    dialog:SetActive(true)
  end
  local dialog = DialogManager.GetDialog("equip.presetequipdialog")
  if dialog then
    dialog:SetActive(true)
  end
end

function EquipForgeDialog:Init(equipkey)
  self._equipkey = equipkey
  self._equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(equipkey)
  if #self._equip:GetRandomEntry() < 1 then
    self._groupBtns[3]:SetActive(false)
  end
  self:OnGroupBtnClick(1)
end

function EquipForgeDialog:OnRefresh()
  self:OnGroupBtnClick(self._tab)
end

function EquipForgeDialog:OnGroupBtnClick(index)
  if index == TabIndex.Break and not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Equip_Break) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100177)
    return
  elseif index == TabIndex.Enchant and not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Equip_Enchant) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100178)
    return
  end
  self._fliterBtn:SetActive(index == TabIndex.GemSetting)
  self._tips:SetActive(index ~= TabIndex.GemSetting)
  if index == TabIndex.GemSetting then
    self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(2279))
  else
    self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(2293))
  end
  self._showFliter = false
  self._gemfliter_back:SetActive(false)
  self._panel_grid:SetActive(true)
  self._item_frame:FireEvent("ItemEnough", true)
  self._selectedItems = {}
  self._strengthenSelectItemData = {}
  self._tab_frame:GetCellAtIndex(index):OnHidden()
  if self._tab ~= index then
    self._tab = index
    local cellPage = self._tab_frame:ToPage(self._tab)
    if cellPage and cellPage.RefreshCell then
      cellPage:RefreshCell()
    end
  end
  self._forgeIetmData = {}
  if index == TabIndex.Strengthen then
    local itemList = {}
    local record = NekoData.BehaviorManager.BM_BagInfo:GetStrengthenItemList()
    for _, value in ipairs(record) do
      local temp = {}
      temp.value = value
      temp.tag = "item"
      table.insert(itemList, temp)
    end
    table.sort(itemList, function(a, b)
      local sortA = CEquipStrengthenTtem:GetRecorder(a.value:GetID()).sort
      local sortB = CEquipStrengthenTtem:GetRecorder(b.value:GetID()).sort
      if sortA < sortB then
        return true
      elseif sortA == sortB then
        return a.value:GetID() < b.value:GetID()
      end
    end)
    for _, value in ipairs(itemList) do
      table.insert(self._forgeIetmData, value)
    end
    local equipList = {}
    record = NekoData.BehaviorManager.BM_BagInfo:GetUnLockEquipList()
    for _, value in ipairs(record) do
      if value:GetRoleKey() == 0 and value:GetKey() ~= self._equipkey and not (value:GetStrengthenLevel() > 1) and not (0 < value:GetEquipExp()) then
        local temp = {}
        temp.value = value
        temp.tag = "equip"
        table.insert(equipList, temp)
      end
    end
    table.sort(equipList, function(a, b)
      if a.value:GetScore() < b.value:GetScore() then
        return true
      elseif a.value:GetScore() == b.value:GetScore() then
        if a.value:GetID() < b.value:GetID() then
          return true
        elseif a.value:GetID() == b.value:GetID() then
          return a.value:GetKey() < b.value:GetKey()
        end
      end
    end)
    for _, value in ipairs(equipList) do
      table.insert(self._forgeIetmData, value)
    end
  elseif index == TabIndex.Break then
    local pinJi = self._equip:GetBreaKNeedEquipsPinji()
    local equipList = {}
    local record = NekoData.BehaviorManager.BM_BagInfo:GetUnLockEquipList()
    for key, value in ipairs(record) do
      if value:GetRoleKey() == 0 then
        local temp = {}
        if value:GetPinJiID() == pinJi and value:GetKey() ~= self._equipkey then
          temp.value = value
          temp.tag = "equip"
          table.insert(equipList, temp)
        end
      end
    end
    table.sort(equipList, function(a, b)
      if a.value:GetRoleKey() < b.value:GetRoleKey() then
        return true
      elseif a.value:GetRoleKey() == b.value:GetRoleKey() then
        return a.value:GetStrengthenLevel() < b.value:GetStrengthenLevel()
      end
    end)
    for _, value in ipairs(equipList) do
      table.insert(self._forgeIetmData, value)
    end
  elseif index == TabIndex.Enchant then
    local itemList = {}
    local record = NekoData.BehaviorManager.BM_BagInfo:GetEnchantItemList()
    local idTable = {}
    for k, v in pairs(CEQuipEnchantItem:GetAllIds()) do
      idTable[v] = v
    end
    for k, v in ipairs(record) do
      idTable[v:GetID()] = nil
    end
    for k, v in pairs(idTable) do
      if CEQuipEnchantItem:GetRecorder(v).show == 1 then
        local item = Item.Create(v)
        item:SetCount(0)
        table.insert(record, item)
      end
    end
    for key, value in ipairs(record) do
      local temp = {}
      temp.value = value
      temp.tag = "item"
      table.insert(itemList, temp)
    end
    table.sort(itemList, function(a, b)
      local sortA = CEQuipEnchantItem:GetRecorder(a.value:GetID()).sort
      local sortB = CEQuipEnchantItem:GetRecorder(b.value:GetID()).sort
      if sortA > sortB then
        return true
      elseif sortA == sortB then
        return a.value:GetID() < b.value:GetID()
      end
    end)
    for _, value in ipairs(itemList) do
      table.insert(self._forgeIetmData, value)
    end
  elseif index == TabIndex.GemSetting then
    self:RefreshGemItemList()
  end
  self._item_frame:ReloadAllCell()
end

function EquipForgeDialog:DidToPage(frame, index)
  for k, v in pairs(self._groupBtns) do
    if k == index then
      v:SetSelected(true)
    else
      v:SetSelected(false)
    end
  end
  local dlg = self._tab_frame:GetCellAtIndex(index)
  if dlg.Init then
    dlg:Init(self._equipkey)
  end
end

function EquipForgeDialog:CellAtIndex(frame, index)
  if frame == self._tab_frame then
    if index == 1 then
      return "equipforge.strengthenequiptabcell"
    elseif index == 2 then
      return "equipforge.breakequiptabcell"
    elseif index == 3 then
      return "equipforge.enchantequiptabcell"
    elseif index == 4 then
      return "equipforge.gemsettingequiptabcell"
    end
  elseif frame == self._item_frame then
    if self._tab == 1 then
      if self._forgeIetmData[index].tag == "equip" then
        return "equipforge.equipforgeequipcell"
      elseif self._forgeIetmData[index].tag == "item" then
        return "equipforge.equipforgeitemcell"
      end
    elseif self._tab == 3 then
      return "equipforge.equipforgeitemcell"
    elseif self._tab == 2 then
      return "equipforge.equipforgeequipcell"
    elseif self._tab == 4 then
      return "equipforge.equipforgeitemcell"
    end
  elseif frame == self._gemfliter_frame then
    return "equipforge.equipgemflitercell"
  end
end

function EquipForgeDialog:NumberOfCell(frame)
  if frame == self._gemfliter_frame then
    return #self._gemFliterDatas
  end
  local num = #self._forgeIetmData
  return num
end

function EquipForgeDialog:DataAtIndex(frame, index)
  if frame == self._gemfliter_frame then
    return self._gemFliterDatas[index]
  end
  return self._forgeIetmData[index]
end

function EquipForgeDialog:OnBackBtnClicked()
  self:Destroy()
end

function EquipForgeDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function EquipForgeDialog:OnManaBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.ManaID)
    })
    local width, height = self._manaBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._manaBtn:GetLocalPointInUiRootPanel())
  end
end

function EquipForgeDialog:OnDiamondBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.DiamodID)
    })
    local width, height = self._diamondBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._diamondBtn:GetLocalPointInUiRootPanel())
  end
end

function EquipForgeDialog:OnAPChange()
  self._manaTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID))
  self._diamondTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
end

function EquipForgeDialog:SelectItems(key, tag)
  if self._tab == TabIndex.Strengthen then
    local isExist = false
    for i, value in ipairs(self._strengthenSelectItemData) do
      if self._strengthenSelectItemData[i].key == key then
        self._strengthenSelectItemData[i].count = self._strengthenSelectItemData[i].count + 1
        isExist = true
        break
      end
    end
    if not isExist then
      local temp = {}
      temp.count = 1
      temp.tag = tag
      temp.key = key
      table.insert(self._strengthenSelectItemData, temp)
    end
    self:SetSelectedItems()
    self._item_frame:FireEvent("ChangeSelectedItemNum", key)
  elseif self._tab == TabIndex.Break then
    if table.nums(self._selectedItems) < self._equip:GetBreaKNeedEquipsCount() then
      local isExist = false
      for i, v in ipairs(self._selectedItems) do
        if v == key then
          isExist = true
          break
        end
      end
      if not isExist then
        table.insert(self._selectedItems, key)
        self:SetSelectedItems()
        self._item_frame:FireEvent("ChangeSelectedItemNum", key)
      end
    end
  elseif self._tab == TabIndex.Enchant then
    self._selectedItems = {}
    self._selectedItems[key] = 1
    self:SetSelectedItems()
    self._item_frame:FireEvent("ChangeSelectedItemNum", nil)
  elseif self._tab == TabIndex.GemSetting then
    self._selectedItems = {}
    self._selectedItems[key] = 1
    self._item_frame:FireEvent("ChangeSelectedItemNum", key)
  end
end

function EquipForgeDialog:SetSelectedItems(selectedItems)
  if selectedItems then
  else
    local temp
    if self._tab == 1 then
      temp = self._strengthenSelectItemData
    else
      temp = self._selectedItems
    end
    local dlg = self._tab_frame:GetCellAtIndex(self._tab)
    if dlg.RefreshItemFrame then
      dlg:RefreshItemFrame(temp)
    end
  end
end

function EquipForgeDialog:ReduceItems(id)
  if self._tab == TabIndex.Strengthen then
    local removeIndex, num
    for i, value in ipairs(self._strengthenSelectItemData) do
      if self._strengthenSelectItemData[i].key == id then
        num = self._strengthenSelectItemData[i].count - 1
        if 0 < num then
          self._strengthenSelectItemData[i].count = num
          break
        end
        removeIndex = i
        break
      end
    end
    if removeIndex then
      table.remove(self._strengthenSelectItemData, removeIndex)
    end
  elseif self._tab == TabIndex.Break then
    for i, value in ipairs(self._selectedItems) do
      if value == id then
        removeIndex = i
        break
      end
    end
    table.remove(self._selectedItems, removeIndex)
  elseif self._tab == TabIndex.Enchant then
    self._selectedItems = {}
  end
  self:SetSelectedItems()
  self._item_frame:FireEvent("ChangeSelectedItemNum", id)
end

function EquipForgeDialog:OnStrengthenReduceItems(notification)
  local id = notification.userInfo
  self:ReduceItems(id)
end

function EquipForgeDialog:OnStrengthenQuickChoose(notification)
  local list = notification.userInfo
  self._strengthenSelectItemData = list
  self._item_frame:FireEvent("ChangeSelectedItemNum", nil)
end

function EquipForgeDialog:OnEquipStrengthenItemEnough(notification)
  self._item_frame:FireEvent("ItemEnough", false)
end

function EquipForgeDialog:OnEquipStrengthenItemNotEnough(notification)
  self._item_frame:FireEvent("ItemEnough", true)
end

function EquipForgeDialog:OnEquipBreakFull()
  self._item_frame:FireEvent("EquipBreakFull", false)
end

function EquipForgeDialog:OnEquipBreakNotFull()
  self._item_frame:FireEvent("EquipBreakNotFull", false)
end

function EquipForgeDialog:IsEquipStrengthenItemEnough()
  return self._tab_frame:GetCellAtIndex(TabIndex.Strengthen)._isItemEnough
end

function EquipForgeDialog:IsEquipBreakFull()
  return self._tab_frame:GetCellAtIndex(TabIndex.Break)._equip:GetBreakMaxLevel()
end

function EquipForgeDialog:OnFliterBtnClicked()
  if self._showFliter then
    return
  end
  self._showFliter = true
  if not self._gemFliterDatas then
    self._gemFliterDatas = {}
    self._gemFliterIDs = {}
    self._temFliterIDs = {}
    local allIDs = CBaoShiSelect:GetAllIds()
    for _, id in pairs(allIDs) do
      local cfg = CBaoShiSelect:GetRecorder(id)
      self._gemFliterIDs[cfg.id] = true
      self._temFliterIDs[cfg.id] = true
      table.insert(self._gemFliterDatas, cfg)
    end
    self._gemfliter_frame:ReloadAllCell()
  end
  self._gemfliter_back:SetActive(true)
  self._panel_grid:SetActive(false)
end

function EquipForgeDialog:RefreshGemItemList()
  self._forgeIetmData = {}
  local itemList = {}
  local allGems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(GemType)
  for _, value in ipairs(allGems) do
    local temp = {}
    temp.value = value
    temp.tag = "Gem"
    if not self._gemFliterIDs then
      table.insert(itemList, temp)
    else
      local cfg = CBaoShiItem:GetRecorder(value:GetID())
      if self._gemFliterIDs[cfg.baoshitype] then
        table.insert(itemList, temp)
      end
    end
  end
  table.sort(itemList, function(a, b)
    local sortA = CBaoShiItem:GetRecorder(a.value:GetID()).level
    local sortB = CBaoShiItem:GetRecorder(b.value:GetID()).level
    if sortA == sortB then
      return a.value:GetID() < b.value:GetID()
    else
      return sortA > sortB
    end
  end)
  for _, value in ipairs(itemList) do
    table.insert(self._forgeIetmData, value)
  end
end

function EquipForgeDialog:OnGemFliterIDSelect(fliterId)
  if self._temFliterIDs[fliterId] then
    self._temFliterIDs[fliterId] = false
    self._gemfliter_frame:FireEvent("Select", fliterId, false)
  else
    self._temFliterIDs[fliterId] = true
    self._gemfliter_frame:FireEvent("Select", fliterId, true)
  end
end

function EquipForgeDialog:OnConfirmFliterBtnClicked()
  self._showFliter = false
  self._gemfliter_back:SetActive(false)
  self._panel_grid:SetActive(true)
  local bChange = false
  for fliterid, bSelect in pairs(self._temFliterIDs) do
    if self._gemFliterIDs[fliterid] ~= bSelect then
      bChange = true
      self._gemFliterIDs[fliterid] = bSelect
    end
  end
  if bChange then
    self:RefreshGemItemList()
    self._item_frame:ReloadAllCell()
  end
end

function EquipForgeDialog:OpenGemTips(gemID, parmFunc)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.gemtipsdialog")
  if tipsDialog then
    local pos = self._tab_frame:GetCellAtIndex(TabIndex.GemSetting):GetSelectPos()
    tipsDialog:Init(gemID, self._equip:GetKey(), pos, self)
    tipsDialog:SetTipsParmFunc(parmFunc)
  end
end

function EquipForgeDialog:OnGemTipsClose()
  self._selectedItems = {}
  self._item_frame:FireEvent("ChangeSelectedItemNum", nil)
end

function EquipForgeDialog:OnGlobalPointerDown(args)
  if not self._showFliter then
    return
  end
  local win1 = args.userInfo.luaWindow
  if not win1 then
    self._showFliter = false
  elseif not UIManager.RectangleContainsScreenPoint(self._panel_grid._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self._showFliter = false
  end
  if not self._showFliter then
    self._gemfliter_back:SetActive(false)
    self._panel_grid:SetActive(true)
  end
end

return EquipForgeDialog
