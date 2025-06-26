-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equipresolvedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Item = require("logic.manager.experimental.types.item")
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local EquipResolveDialog = class("EquipResolveDialog", Dialog)
EquipResolveDialog.AssetBundleName = "ui/layouts.equip"
EquipResolveDialog.AssetName = "EquipResolve"
local ColumnsNum = 5
local MinRowNum = 5
local BottomToTop = 3
EquipResolveDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipResolveDialog
  ((EquipResolveDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._equipList = {}
  self._resolveEquips = {}
  self._itemList = {}
  self._qulityToggles = {}
  self._equipTypeToggles = {}
  self._receiveRemoveItemMsgNum = 0
end

EquipResolveDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, GridFrame, ColumnsNum, BottomToTop, _ENV
  for i = 1, 4 do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    if i < 4 then
      (self._equipTypeToggles)[i] = self:GetChild("Left/ToggleGroup2/_Toggle_" .. i - 1)
    end
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._qulityToggles)[i] = self:GetChild("Left/ToggleGroup1/_Toggle_" .. i - 1)
    ;
    ((self._qulityToggles)[i]):Subscribe_ValueChangedEvent(self.AutoSelectEquip, self)
    if i < 4 then
      ((self._equipTypeToggles)[i]):Subscribe_ValueChangedEvent(self.AutoSelectEquip, self)
    end
  end
  self._noSelectIntensifyToggle = self:GetChild("Left/ToggleGroup3/_Toggle_0")
  self._noSelectEnchantToggle = self:GetChild("Left/ToggleGroup3/_Toggle_1")
  ;
  (self._noSelectIntensifyToggle):Subscribe_ValueChangedEvent(self.AutoSelectEquip, self)
  ;
  (self._noSelectEnchantToggle):Subscribe_ValueChangedEvent(self.AutoSelectEquip, self)
  self._gainItemPanel = self:GetChild("Left/Frame")
  self._gainItemFrame = (TableFrame.Create)(self._gainItemPanel, self, false, true)
  self._selectEquipNum = self:GetChild("Left/Txt5")
  self._resolveButton = self:GetChild("Left/ResolveBtn")
  ;
  (self._resolveButton):Subscribe_PointerClickEvent(self.OnClickResolveBtn, self)
  self._equipPanel = self:GetChild("EquipFrame")
  self._equipFrame = (GridFrame.Create)(self._equipPanel, self, true, ColumnsNum)
  ;
  (self._equipFrame):SetMargin(15, 0)
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._tips = self:GetChild("Tips")
  ;
  (self._tips):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1305))
  self:RefreshEquipTable()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDecomposeEquips, Common.n_DecomposeEquips, nil)
  self._inDungeon = GlobalGameFSM:GetCurrentState() == "Dungeon"
  ;
  (self._menuBtn):SetActive(not self._inDungeon)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipResolveDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._gainItemFrame):Destroy()
  ;
  (self._equipFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  local dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
  if dialog then
    dialog:SetActive(true)
  end
  dialog = (DialogManager.GetDialog)("equip.presetequipdialog")
  if dialog then
    dialog:SetActive(true)
  end
end

EquipResolveDialog.OnDecomposeEquips = function(self)
  -- function num : 0_3
  self._resolveEquips = {}
  self:RefreshEquipTable()
  self:RefreshGainItems()
end

EquipResolveDialog.RefreshEquipTable = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._equipList = {}
  for i,equip in ipairs(((NekoData.BehaviorManager).BM_BagInfo):GetEquipList()) do
    if not equip:IsLocked() and equip:GetRoleKey() == 0 then
      (table.insert)(self._equipList, equip)
    end
  end
  ;
  (table.sort)(self._equipList, function(a, b)
    -- function num : 0_4_0
    do return a:GetScore() < b:GetScore() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._equipFrame):ReloadAllCell()
end

EquipResolveDialog.AutoSelectEquip = function(self)
  -- function num : 0_5 , upvalues : EquipTypeEnum, _ENV
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
    if ((self._qulityToggles)[i]):GetIsOnType() then
      if i == 4 then
        qulityList[5] = true
      else
        qulityList[i] = true
      end
      qulityListNum = qulityListNum + 1
    end
    if (self._equipTypeToggles)[i] and ((self._equipTypeToggles)[i]):GetIsOnType() then
      typeList[alltype[i]] = true
      typeListNum = typeListNum + 1
    end
  end
  if qulityListNum == 0 and typeListNum > 0 then
    for i = 1, 4 do
      if i == 4 then
        qulityList[5] = true
      else
        qulityList[i] = true
      end
    end
  end
  do
    if qulityListNum > 0 and typeListNum == 0 then
      for i = 1, 3 do
        typeList[alltype[i]] = true
      end
    end
    do
      local bSelectNoIntensify = (self._noSelectIntensifyToggle):GetIsOnType()
      local bSelectNoEnchant = (self._noSelectEnchantToggle):GetIsOnType()
      for i,equip in ipairs(self._equipList) do
        local pinzhi = equip:GetPinJiID()
        local equiptype = equip:GetEquipType()
        if qulityList[pinzhi] and typeList[equiptype] then
          if bSelectNoIntensify and bSelectNoEnchant then
            local level = equip:GetStrengthenLevel()
            local hasEnchanted = equip:GetIsEnchanted()
            if level == 1 and hasEnchanted == false then
              (table.insert)(self._resolveEquips, equip)
            end
          else
            do
              if bSelectNoIntensify then
                local level = equip:GetStrengthenLevel()
                if level == 1 then
                  (table.insert)(self._resolveEquips, equip)
                end
              else
                do
                  if bSelectNoEnchant then
                    local hasEnchanted = equip:GetIsEnchanted()
                    if hasEnchanted == false then
                      (table.insert)(self._resolveEquips, equip)
                    end
                  else
                    do
                      do
                        ;
                        (table.insert)(self._resolveEquips, equip)
                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_STMT

                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      ;
      (self._equipFrame):FireEvent("ChooseResolveEquip")
      self:RefreshGainItems()
    end
  end
end

EquipResolveDialog.IsInResolveEquips = function(self, equip)
  -- function num : 0_6 , upvalues : _ENV
  for i,v in ipairs(self._resolveEquips) do
    if v:GetKey() == equip:GetKey() then
      return i
    end
  end
  return nil
end

EquipResolveDialog.OnSelectEquipsChange = function(self, equip, bSelect)
  -- function num : 0_7 , upvalues : _ENV
  if bSelect then
    (table.insert)(self._resolveEquips, equip)
  else
    local index = self:IsInResolveEquips(equip)
    ;
    (table.remove)(self._resolveEquips, index)
  end
  do
    self:RefreshGainItems()
  end
end

EquipResolveDialog.RefreshGainItems = function(self)
  -- function num : 0_8 , upvalues : _ENV, Item
  local num = #self._resolveEquips
  ;
  (self._selectEquipNum):SetText(tostring(num))
  local items = {}
  self._itemList = {}
  for i,v in ipairs(self._resolveEquips) do
    local returnItemInfo = v:GetResolveItemInfo()
    for id,num in pairs(returnItemInfo) do
      local item = items[id]
      if item then
        item:SetCount(item:GetCount() + num)
      else
        item = (Item.Create)(id)
        item:SetCount(num)
        items[id] = item
      end
    end
  end
  for k,v in pairs(items) do
    (table.insert)(self._itemList, v)
  end
  ;
  (table.sort)(self._itemList, function(a, b)
    -- function num : 0_8_0
    do return a:GetID() < b:GetID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if #self._itemList >= 3 then
    (self._gainItemFrame):SetSlide(true)
  else
    ;
    (self._gainItemFrame):SetSlide(false)
  end
  ;
  (self._gainItemFrame):ReloadAllCell()
end

EquipResolveDialog.OnClickCancelBtn = function(self)
  -- function num : 0_9
  self:Destroy()
end

EquipResolveDialog.OnClickResolveBtn = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local list = {}
  local bHaveGoldEquip = false
  for i,equip in ipairs(self._resolveEquips) do
    local pinzhi = equip:GetPinJiID()
    if pinzhi == 5 then
      bHaveGoldEquip = true
    end
    ;
    (table.insert)(list, equip:GetKey())
  end
  if #list == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100083)
    return 
  end
  local confirmStrId = 37
  if bHaveGoldEquip then
    confirmStrId = 2
  end
  ;
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(confirmStrId, nil, function()
    -- function num : 0_10_0 , upvalues : _ENV, list
    local cdecomposeEquips = (LuaNetManager.CreateProtocol)("protocol.item.cdecomposeequips")
    if cdecomposeEquips then
      cdecomposeEquips.equipKeys = list
      cdecomposeEquips:Send()
    end
  end
, {}, nil, {})
end

EquipResolveDialog.NumberOfCell = function(self, frame)
  -- function num : 0_11 , upvalues : ColumnsNum, MinRowNum
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

EquipResolveDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_12
  if frame == self._equipFrame then
    return "equip.resolveequipcell"
  else
    return "equip.resolveequipitemcell"
  end
end

EquipResolveDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_13
  if frame == self._equipFrame then
    return (self._equipList)[index]
  else
    return (self._itemList)[index]
  end
end

EquipResolveDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_14
  local width, height = (self._equipPanel):GetRectSize()
  local total = (self._equipFrame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

EquipResolveDialog.OnBackBtnClicked = function(self)
  -- function num : 0_15
  self:Destroy()
end

EquipResolveDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return EquipResolveDialog

