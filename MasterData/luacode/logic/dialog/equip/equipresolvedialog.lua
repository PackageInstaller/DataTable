local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Item = require("logic.manager.experimental.types.item")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local EquipResolveDialog = class("EquipResolveDialog", Dialog)
EquipResolveDialog.AssetBundleName = "ui/layouts.equip"
EquipResolveDialog.AssetName = "EquipResolve"
local ColumnsNum = 5
local MinRowNum = 5
local BottomToTop = 3

function EquipResolveDialog:Ctor(...)
  EquipResolveDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._equipList = {}
  self._resolveEquips = {}
  self._itemList = {}
  self._qulityToggles = {}
  self._equipTypeToggles = {}
  self._receiveRemoveItemMsgNum = 0
end

function EquipResolveDialog:OnCreate()
  for i = 1, 4 do
    if i < 4 then
      self._equipTypeToggles[i] = self:GetChild("Left/ToggleGroup2/_Toggle_" .. i - 1)
    end
    self._qulityToggles[i] = self:GetChild("Left/ToggleGroup1/_Toggle_" .. i - 1)
    self._qulityToggles[i]:Subscribe_ValueChangedEvent(self.AutoSelectEquip, self)
    if i < 4 then
      self._equipTypeToggles[i]:Subscribe_ValueChangedEvent(self.AutoSelectEquip, self)
    end
  end
  self._noSelectIntensifyToggle = self:GetChild("Left/ToggleGroup3/_Toggle_0")
  self._noSelectEnchantToggle = self:GetChild("Left/ToggleGroup3/_Toggle_1")
  self._noSelectIntensifyToggle:Subscribe_ValueChangedEvent(self.AutoSelectEquip, self)
  self._noSelectEnchantToggle:Subscribe_ValueChangedEvent(self.AutoSelectEquip, self)
  self._gainItemPanel = self:GetChild("Left/Frame")
  self._gainItemFrame = TableFrame.Create(self._gainItemPanel, self, false, true)
  self._selectEquipNum = self:GetChild("Left/Txt5")
  self._resolveButton = self:GetChild("Left/ResolveBtn")
  self._resolveButton:Subscribe_PointerClickEvent(self.OnClickResolveBtn, self)
  self._equipPanel = self:GetChild("EquipFrame")
  self._equipFrame = GridFrame.Create(self._equipPanel, self, true, ColumnsNum)
  self._equipFrame:SetMargin(15, 0)
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._tips = self:GetChild("Tips")
  self._tips:SetText(NekoData.BehaviorManager.BM_Message:GetString(1305))
  self:RefreshEquipTable()
  LuaNotificationCenter.AddObserver(self, self.OnDecomposeEquips, Common.n_DecomposeEquips, nil)
  self._inDungeon = GlobalGameFSM:GetCurrentState() == "Dungeon"
  self._menuBtn:SetActive(not self._inDungeon)
end

function EquipResolveDialog:OnDestroy()
  self._gainItemFrame:Destroy()
  self._equipFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
  if dialog then
    dialog:SetActive(true)
  end
  dialog = DialogManager.GetDialog("equip.presetequipdialog")
  if dialog then
    dialog:SetActive(true)
  end
end

function EquipResolveDialog:OnDecomposeEquips()
  self._resolveEquips = {}
  self:RefreshEquipTable()
  self:RefreshGainItems()
end

function EquipResolveDialog:RefreshEquipTable()
  self._equipList = {}
  for i, equip in ipairs(NekoData.BehaviorManager.BM_BagInfo:GetEquipList()) do
    if not equip:IsLocked() and equip:GetRoleKey() == 0 then
      table.insert(self._equipList, equip)
    end
  end
  table.sort(self._equipList, function(a, b)
    return a:GetScore() < b:GetScore()
  end)
  self._equipFrame:ReloadAllCell()
end

function EquipResolveDialog:AutoSelectEquip()
  self._resolveEquips = {}
  local alltype = {}
  alltype[1] = EquipTypeEnum.WEAPON
  alltype[2] = EquipTypeEnum.ARMOR
  alltype[3] = EquipTypeEnum.JEWELRY
  local qulityList = {}
  local typeList = {}
  local qulityListNum = 0
  local typeListNum = 0
  for i = 1, 4 do
    if self._qulityToggles[i]:GetIsOnType() then
      if i == 4 then
        qulityList[5] = true
      else
        qulityList[i] = true
      end
      qulityListNum = qulityListNum + 1
    end
    if self._equipTypeToggles[i] and self._equipTypeToggles[i]:GetIsOnType() then
      typeList[alltype[i]] = true
      typeListNum = typeListNum + 1
    end
  end
  if qulityListNum == 0 and 0 < typeListNum then
    for i = 1, 4 do
      if i == 4 then
        qulityList[5] = true
      else
        qulityList[i] = true
      end
    end
  end
  if 0 < qulityListNum and typeListNum == 0 then
    for i = 1, 3 do
      typeList[alltype[i]] = true
    end
  end
  local bSelectNoIntensify = self._noSelectIntensifyToggle:GetIsOnType()
  local bSelectNoEnchant = self._noSelectEnchantToggle:GetIsOnType()
  for i, equip in ipairs(self._equipList) do
    local pinzhi = equip:GetPinJiID()
    local equiptype = equip:GetEquipType()
    if qulityList[pinzhi] and typeList[equiptype] then
      if bSelectNoIntensify and bSelectNoEnchant then
        local level = equip:GetStrengthenLevel()
        local hasEnchanted = equip:GetIsEnchanted()
        if level == 1 and hasEnchanted == false then
          table.insert(self._resolveEquips, equip)
        end
      elseif bSelectNoIntensify then
        local level = equip:GetStrengthenLevel()
        if level == 1 then
          table.insert(self._resolveEquips, equip)
        end
      elseif bSelectNoEnchant then
        local hasEnchanted = equip:GetIsEnchanted()
        if hasEnchanted == false then
          table.insert(self._resolveEquips, equip)
        end
      else
        table.insert(self._resolveEquips, equip)
      end
    end
  end
  self._equipFrame:FireEvent("ChooseResolveEquip")
  self:RefreshGainItems()
end

function EquipResolveDialog:IsInResolveEquips(equip)
  for i, v in ipairs(self._resolveEquips) do
    if v:GetKey() == equip:GetKey() then
      return i
    end
  end
  return nil
end

function EquipResolveDialog:OnSelectEquipsChange(equip, bSelect)
  if bSelect then
    table.insert(self._resolveEquips, equip)
  else
    local index = self:IsInResolveEquips(equip)
    table.remove(self._resolveEquips, index)
  end
  self:RefreshGainItems()
end

function EquipResolveDialog:RefreshGainItems()
  local num = #self._resolveEquips
  self._selectEquipNum:SetText(tostring(num))
  local items = {}
  self._itemList = {}
  for i, v in ipairs(self._resolveEquips) do
    local returnItemInfo = v:GetResolveItemInfo()
    for id, num in pairs(returnItemInfo) do
      local item = items[id]
      if item then
        item:SetCount(item:GetCount() + num)
      else
        item = Item.Create(id)
        item:SetCount(num)
        items[id] = item
      end
    end
  end
  for k, v in pairs(items) do
    table.insert(self._itemList, v)
  end
  table.sort(self._itemList, function(a, b)
    return a:GetID() < b:GetID()
  end)
  if #self._itemList >= 3 then
    self._gainItemFrame:SetSlide(true)
  else
    self._gainItemFrame:SetSlide(false)
  end
  self._gainItemFrame:ReloadAllCell()
end

function EquipResolveDialog:OnClickCancelBtn()
  self:Destroy()
end

function EquipResolveDialog:OnClickResolveBtn()
  local list = {}
  local bHaveGoldEquip = false
  for i, equip in ipairs(self._resolveEquips) do
    local pinzhi = equip:GetPinJiID()
    if pinzhi == 5 then
      bHaveGoldEquip = true
    end
    table.insert(list, equip:GetKey())
  end
  if #list == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100083)
    return
  end
  local confirmStrId = 37
  if bHaveGoldEquip then
    confirmStrId = 2
  end
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(confirmStrId, nil, function()
    local cdecomposeEquips = LuaNetManager.CreateProtocol("protocol.item.cdecomposeequips")
    if cdecomposeEquips then
      cdecomposeEquips.equipKeys = list
      cdecomposeEquips:Send()
    end
  end, {}, nil, {})
end

function EquipResolveDialog:NumberOfCell(frame)
  if frame == self._equipFrame then
    if #self._equipList < ColumnsNum * MinRowNum then
      return ColumnsNum * MinRowNum
    else
      return #self._equipList
    end
  else
    return #self._itemList
  end
end

function EquipResolveDialog:CellAtIndex(frame, index)
  if frame == self._equipFrame then
    return "equip.resolveequipcell"
  else
    return "equip.resolveequipitemcell"
  end
end

function EquipResolveDialog:DataAtIndex(frame, index)
  if frame == self._equipFrame then
    return self._equipList[index]
  else
    return self._itemList[index]
  end
end

function EquipResolveDialog:OnCurPosChange(frame, proportion)
  local width, height = self._equipPanel:GetRectSize()
  local total = self._equipFrame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function EquipResolveDialog:OnBackBtnClicked()
  self:Destroy()
end

function EquipResolveDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return EquipResolveDialog
