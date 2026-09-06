local TableFrame = require("framework.ui.frame.table.tableframe")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CEquipStrengthenItemTable = BeanManager.GetTableByName("equip.cequipstrengthenitem")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local StrengthenEquipTabCell = class("StrengthenEquipTabCell", Dialog)
StrengthenEquipTabCell.AssetBundleName = "ui/layouts.equip"
StrengthenEquipTabCell.AssetName = "EquipQH"

local function FinishGuide(self)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(53, 5) then
    LuaNotificationCenter.RemoveObserver(self, Common.n_GuideResponseClick)
    NekoData.BehaviorManager.BM_Guide:FinishGuide(53)
  end
end

function StrengthenEquipTabCell:Ctor(...)
  StrengthenEquipTabCell.super.Ctor(self, ...)
  self._equip = nil
  self._attrList = {}
  self.addLv = 0
  self._selectedItems = {}
  self._selectedItemsCellData = {}
  self._effectHandler = nil
  self._isItemEnough = false
end

function StrengthenEquipTabCell:OnCreate()
  self._equipIcon = self:GetChild("EquipCell/BackGround/Icon")
  self._frame = self:GetChild("EquipCell/BackGround/Frame")
  self._equipPoint = self:GetChild("EquipCell/BreakPoint")
  self._levelMax = self:GetChild("Lv/LevelMax")
  self._levelNum = self:GetChild("Lv/LevelNum")
  self._levelNumGreen = self:GetChild("Lv/LevelNumGreen")
  self._effect = self:GetChild("Frame3/Effect")
  self._tips = self:GetChild("Tips")
  self._tips:SetText(NekoData.BehaviorManager.BM_Message:GetString(1305))
  self._ibtn = self:GetChild("IbtnImg")
  self._equipName = self:GetChild("EquipName")
  self._expNum = self:GetChild("EXPNum")
  self._progress = self:GetChild("ProgressLevel/_BackGround/Progress")
  self._addProgress = self:GetChild("ProgressLevel/_BackGround/Progress2")
  self._propertyPanel = self:GetChild("PropertyFrame")
  self._needMoneyNum = self:GetChild("Frame/NumBack1/Num")
  self._needMoneyNumRed = self:GetChild("Frame/NumBack1/NumRed")
  self._emptyList = {}
  for i = 1, 5 do
    self._emptyList[i] = self:GetChild("Frame/Empty" .. i)
  end
  self._itemPanel = self:GetChild("Frame/CellFrame")
  self._quickChooseBtn = self:GetChild("Frame/ChooseBtn")
  self._startStrengthenBtn = self:GetChild("Frame/StartBtn")
  self._startStrengthenBtn:SetInteractable(false)
  self._propertyFrame = TableFrame.Create(self._propertyPanel, self, true, false, true)
  self._itemFrame = TableFrame.Create(self._itemPanel, self, false, false)
  self._effect:Subscribe_UIEffectEndEvent(self.OnEnd, self)
  self._quickChooseBtn:Subscribe_PointerClickEvent(self.OnQuickChooseBtn, self)
  self._startStrengthenBtn:Subscribe_PointerClickEvent(self.OnStartStrengthenBtn, self)
  self._ibtn:Subscribe_PointerClickEvent(self.OnIBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipExpUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, FinishGuide, Common.n_GuideResponseClick, nil)
end

function StrengthenEquipTabCell:OnDestroy()
  self._propertyFrame:Destroy()
  self._itemFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
end

function StrengthenEquipTabCell:OnHidden()
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
end

function StrengthenEquipTabCell:OnRefresh(notification)
  local equipKey = notification.userInfo.equipKey
  if self._preLv < self._equip:GetStrengthenLevel() and equipKey == self._equip:GetKey() then
    local dialog = DialogManager.CreateSingletonDialog("equipforge.equipstrengthensuccessdialog")
    if dialog then
      dialog:SetData(self._equip, self._preLv)
    end
  end
  self:Init(equipKey)
end

function StrengthenEquipTabCell:RefreshTabCell()
end

function StrengthenEquipTabCell:Init(equipKey)
  self.addLv = 0
  self._isItemEnough = false
  self._startStrengthenBtn:SetInteractable(false)
  self._equipkey = equipKey
  local CPreviewEquipAttrs = LuaNetManager.CreateProtocol("protocol.item.cpreviewequipattrs")
  CPreviewEquipAttrs.key = equipKey
  CPreviewEquipAttrs:Send()
  self._selectedItems = {}
  self._selectedItemsCellData = {}
  self._equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(equipKey)
  local record = self._equip:GetIcon()
  self._equipIcon:SetSprite(record.assetBundle, record.assetName)
  self._equipPoint:SetText(self._equip:GetEquipStarStr())
  local equipName = self._equip:GetName()
  self._equipName:SetText(equipName)
  local curLv = self._equip:GetStrengthenLevel()
  self._levelNum:SetText(curLv)
  self._levelNum:SetActive(true)
  self._levelNumGreen:SetActive(false)
  local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
  local maxLevel = self._equip:GetMaxLevel()
  self._levelMax:SetText(maxLevel)
  self._addProgress:SetFillAmount(0)
  self._progress:SetActive(true)
  record = self._equip:GetPinJiImage()
  self._frame:SetSprite(record.assetBundle, record.assetName)
  local equipExp = self._equip:GetEquipExp()
  local needExpByStrengthenLevel
  if curLv == maxLevel then
    self._progress:SetFillAmount(1)
    self:OnItemEnough()
    needExpByStrengthenLevel = self._equip:GetNeedExpByStrengthenLevel(curLv)
    local str = TextManager.GetText(CStringRes:GetRecorder(1203).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(needExpByStrengthenLevel))
    str = string.gsub(str, "%$parameter2%$", tostring(needExpByStrengthenLevel))
    self._expNum:SetText(str)
    self._quickChooseBtn:SetInteractable(false)
  else
    needExpByStrengthenLevel = self._equip:GetNeedExpByStrengthenLevel(curLv + 1)
    self._progress:SetFillAmount(equipExp / needExpByStrengthenLevel)
    local str = TextManager.GetText(CStringRes:GetRecorder(1203).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(equipExp))
    str = string.gsub(str, "%$parameter2%$", tostring(needExpByStrengthenLevel))
    self._expNum:SetText(str)
    self._quickChooseBtn:SetInteractable(true)
  end
  self._needMoneyNum:SetActive(true)
  self._needMoneyNumRed:SetActive(false)
  self._needMoneyNum:SetNumber(0)
  for i = 1, 5 do
    self._emptyList[i]:SetActive(true)
  end
  while self._attrList[#self._attrList] do
    table.remove(self._attrList, #self._attrList)
  end
  record = CEquipItemTable:GetRecorder(self._equip:GetID())
  local breakMultiple = self._equip:GetCurrentBreakMultiple()
  for i, v in ipairs(record.abilityID) do
    local gemSuitAttrRate = self._equip:GetGemSuitAttrRate(v)
    local temp = {}
    temp.attrId = v
    temp.value = record.abilityValue[i] * (record.initMagnify + (curLv - 1) + breakMultiple) * (1 + gemSuitAttrRate)
    temp.param1 = record.abilityValue[i] * (1 + gemSuitAttrRate)
    temp.param2 = record.initMagnify + breakMultiple
    temp.curLv = curLv
    table.insert(self._attrList, temp)
  end
  table.sort(self._attrList, function(a, b)
    return a.attrId < b.attrId
  end)
  self._propertyFrame:ReloadAllCell()
  self._propertyFrame:MoveToTop()
  self._itemFrame:ReloadAllCell()
end

function StrengthenEquipTabCell:RefreshItemFrame(selectedItems)
  self._selectedItems = selectedItems
  local selectedItemsExp = 0
  self._selectedItemsCellData = {}
  for _, value in pairs(selectedItems) do
    local temp = {}
    temp.key = value.key
    temp.count = value.count
    temp.tag = value.tag
    table.insert(self._selectedItemsCellData, temp)
    if value.tag == "item" then
      local recorder = CEquipStrengthenItemTable:GetRecorder(value.key)
      if recorder then
        selectedItemsExp = selectedItemsExp + recorder.Exp * value.count
      end
    elseif value.tag == "equip" then
      local equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(value.key)
      local itemList = equip:GetResolveItemInfo()
      for id, count in pairs(itemList) do
        local record = CEquipStrengthenItemTable:GetRecorder(id)
        if record then
          selectedItemsExp = selectedItemsExp + record.Exp * count
        end
      end
    end
  end
  local equipExp = self._equip:GetEquipExp()
  local curLv = self._equip:GetStrengthenLevel()
  local needExpByStrengthenLevel = self._equip:GetNeedExpByStrengthenLevel(curLv + 1)
  local maxLv = self._equip:GetMaxLevel()
  if table.nums(selectedItems) == 0 or curLv == maxLv then
    self._needMoneyNum:SetActive(true)
    self._needMoneyNumRed:SetActive(false)
    self._needMoneyNum:SetNumber(0)
    self._startStrengthenBtn:SetInteractable(false)
  else
    local mana = self._equip:GetNeedManaByExp(selectedItemsExp)
    if mana > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID) then
      self._needMoneyNum:SetActive(false)
      self._needMoneyNumRed:SetActive(true)
      self._needMoneyNumRed:SetNumber(math.ceil(mana))
      self._startStrengthenBtn:SetInteractable(false)
    else
      self._needMoneyNum:SetActive(true)
      self._needMoneyNumRed:SetActive(false)
      self._needMoneyNum:SetNumber(math.ceil(mana))
      self._startStrengthenBtn:SetInteractable(true)
    end
  end
  local notEmptyCount = #self._selectedItemsCellData
  if 0 < notEmptyCount then
    for i = 1, notEmptyCount do
      self._emptyList[i]:SetActive(false)
    end
    for i = notEmptyCount + 1, 5 do
      self._emptyList[i]:SetActive(true)
    end
  else
    for i = 1, 5 do
      self._emptyList[i]:SetActive(true)
    end
  end
  local lv = self._equip:GetLevelByExp(self._equip:GetEquipTotalExp() + selectedItemsExp)
  if maxLv <= lv then
    lv = maxLv
    self:OnItemEnough()
  else
    self:OnItemNotEnough()
  end
  self.addLv = lv - curLv
  if curLv < lv then
    self._levelNumGreen:SetText(lv)
    self._levelNumGreen:SetActive(true)
    self._levelNum:SetActive(false)
    local exp
    if maxLv > lv then
      needExpByStrengthenLevel = self._equip:GetNeedExpByStrengthenLevel(lv + 1)
      local afteLvNeedExp = 0
      for i = 1, lv - curLv do
        afteLvNeedExp = afteLvNeedExp + self._equip:GetNeedExpByStrengthenLevel(curLv + i)
      end
      exp = equipExp + selectedItemsExp - afteLvNeedExp
    elseif maxLv <= lv then
      needExpByStrengthenLevel = self._equip:GetNeedExpByStrengthenLevel(lv)
      exp = needExpByStrengthenLevel
    end
    self._addProgress:SetFillAmount(exp / needExpByStrengthenLevel)
    local str = TextManager.GetText(CStringRes:GetRecorder(1210).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(exp))
    str = string.gsub(str, "%$parameter2%$", tostring(needExpByStrengthenLevel))
    self._expNum:SetText(str)
    self._progress:SetActive(false)
  else
    self._levelNum:SetText(curLv)
    self._levelNumGreen:SetActive(false)
    self._levelNum:SetActive(true)
    self._addProgress:SetFillAmount((equipExp + selectedItemsExp) / needExpByStrengthenLevel)
    if 0 < selectedItemsExp then
      local str = TextManager.GetText(CStringRes:GetRecorder(1210).msgTextID)
      str = string.gsub(str, "%$parameter1%$", tostring(equipExp + selectedItemsExp))
      str = string.gsub(str, "%$parameter2%$", tostring(needExpByStrengthenLevel))
      self._expNum:SetText(str)
    else
      local str = TextManager.GetText(CStringRes:GetRecorder(1203).msgTextID)
      str = string.gsub(str, "%$parameter1%$", tostring(equipExp + selectedItemsExp))
      str = string.gsub(str, "%$parameter2%$", tostring(needExpByStrengthenLevel))
      self._expNum:SetText(str)
    end
    self._progress:SetActive(true)
  end
  self._itemFrame:ReloadAllCell()
  self._propertyFrame:ReloadAllCell()
  self._propertyFrame:MoveToTop()
end

function StrengthenEquipTabCell:ReduceItems(id)
  LuaNotificationCenter.PostNotification(Common.n_EquipStrengthenReduceItems, self, id)
end

function StrengthenEquipTabCell:OnQuickChooseBtn()
  for k, v in pairs(self._selectedItemsCellData) do
    self._selectedItemsCellData[k] = nil
  end
  local selectedItemsExp = 0
  local equipTotalExp = self._equip:GetEquipTotalExp()
  local strengthenItemList = {}
  local itemList = {}
  local record = NekoData.BehaviorManager.BM_BagInfo:GetStrengthenItemList()
  local maxLevelExp = self._equip:GetExpByMaxStrengthenLevel()
  for key, value in ipairs(record) do
    local itemCount = value:GetCount()
    local recorder = CEquipStrengthenItemTable:GetRecorder(value:GetID())
    if recorder then
      selectedItemsExp = selectedItemsExp + recorder.Exp * value:GetCount()
    end
    if maxLevelExp < self._equip:GetEquipTotalExp() + selectedItemsExp then
      selectedItemsExp = selectedItemsExp - recorder.Exp * value:GetCount()
      for i = 1, value:GetCount() do
        selectedItemsExp = selectedItemsExp + recorder.Exp
        if maxLevelExp <= self._equip:GetEquipTotalExp() + selectedItemsExp then
          itemCount = i
          local temp = {}
          temp.exp = recorder.Exp
          temp.value = value
          temp.tag = "item"
          temp.count = itemCount
          table.insert(itemList, temp)
          local overFlow = self._equip:GetEquipTotalExp() + selectedItemsExp - maxLevelExp
          self:HandlingOverFlow(itemList, overFlow)
          break
        end
      end
      self:OnItemEnough()
      break
    end
    local temp = {}
    temp.exp = recorder.Exp
    temp.value = value
    temp.tag = "item"
    temp.count = itemCount
    table.insert(itemList, temp)
  end
  table.sort(itemList, function(a, b)
    local sortA = CEquipStrengthenItemTable:GetRecorder(a.value:GetID()).sort
    local sortB = CEquipStrengthenItemTable:GetRecorder(b.value:GetID()).sort
    if sortA < sortB then
      return true
    elseif sortA == sortB then
      return a.value:GetID() < b.value:GetID()
    end
  end)
  for _, value in ipairs(itemList) do
    table.insert(strengthenItemList, value)
  end
  local equipList = {}
  record = NekoData.BehaviorManager.BM_BagInfo:GetUnLockEquipList()
  table.sort(record, function(a, b)
    if a:GetScore() < b:GetScore() then
      return true
    elseif a:GetScore() == b:GetScore() then
      if a:GetID() < b:GetID() then
        return true
      elseif a:GetID() == b:GetID() then
        return a:GetKey() < b:GetKey()
      end
    end
  end)
  local pinJi = self._equip:GetPinJiID()
  if maxLevelExp > self._equip:GetEquipTotalExp() + selectedItemsExp then
    for key, value in ipairs(record) do
      if value:GetKey() ~= self._equipkey and value:GetRoleKey() == 0 and not (1 < value:GetStrengthenLevel()) and not (0 < value:GetEquipExp()) then
        local equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(value:GetKey())
        local resolveItemList = equip:GetResolveItemInfo()
        for id, count in pairs(resolveItemList) do
          local record = CEquipStrengthenItemTable:GetRecorder(id)
          if record then
            selectedItemsExp = selectedItemsExp + record.Exp * count
          end
        end
        if maxLevelExp < self._equip:GetEquipTotalExp() + selectedItemsExp then
          local temp = {}
          temp.value = value
          temp.tag = "equip"
          table.insert(equipList, temp)
          break
        end
        local temp = {}
        temp.value = value
        temp.tag = "equip"
        table.insert(equipList, temp)
      end
    end
  end
  for _, value in ipairs(equipList) do
    table.insert(strengthenItemList, value)
  end
  self._selectedItems = {}
  for k, v in ipairs(strengthenItemList) do
    if table.nums(self._selectedItems) < 5 then
      if v.tag == "equip" then
        local temp = {}
        temp.count = 1
        temp.tag = v.tag
        temp.key = v.value:GetKey()
        table.insert(self._selectedItems, temp)
      elseif v.tag == "item" then
        local temp = {}
        temp.count = v.count
        temp.tag = v.tag
        temp.key = v.value:GetID()
        table.insert(self._selectedItems, temp)
      end
    end
  end
  for _, value in pairs(self._selectedItems) do
    local temp = {}
    temp.key = value.key
    temp.count = value.count
    temp.tag = value.tag
    table.insert(self._selectedItemsCellData, temp)
  end
  local emptyCount = 5 - #self._selectedItemsCellData
  if emptyCount ~= 0 then
    for i = emptyCount, 5 do
      self._emptyList[i]:SetActive(false)
    end
  else
    for i = 1, 5 do
      self._emptyList[i]:SetActive(true)
    end
  end
  self:RefreshItemFrame(self._selectedItems)
  self._itemFrame:ReloadAllCell()
  LuaNotificationCenter.PostNotification(Common.n_EquipStrengthenQuickChoose, self, self._selectedItems)
end

function StrengthenEquipTabCell:HandlingOverFlow(itemList, overFlow)
  local overFlowCount
  for i = #itemList, 1, -1 do
    overFlowCount = math.floor(overFlow / itemList[i].exp)
    if overFlowCount > itemList[i].count then
      overFlowCount = itemList[i].count
    end
    if 0 < overFlowCount then
      itemList[i].count = itemList[i].count - overFlowCount
      overFlow = overFlow - overFlowCount * itemList[i].exp
    end
  end
  for i = #itemList, 1, -1 do
    if itemList[i].count <= 0 then
      table.remove(itemList, i)
    end
  end
end

function StrengthenEquipTabCell:OnStartStrengthenBtn()
  local hasStrengthened = false
  local hasHighPinJi = false
  for key, value in pairs(self._selectedItems) do
    if value.tag == "equip" then
      local equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(value.key)
      if equip:GetStrengthenLevel() > 1 or equip:GetEquipExp() > 0 then
        hasStrengthened = true
      end
      if equip:GetPinJiID() > 2 then
        hasHighPinJi = true
      end
    end
  end
  if hasStrengthened and not hasHighPinJi then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(51, nil, function()
      self:SendCStrengthenEquip()
    end)
    return
  end
  if not hasStrengthened and hasHighPinJi then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(52, nil, function()
      self:SendCStrengthenEquip()
    end)
    return
  end
  if hasStrengthened and hasHighPinJi then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(53, nil, function()
      self:SendCStrengthenEquip()
    end)
    return
  end
  self:SendCStrengthenEquip()
end

function StrengthenEquipTabCell:SendCStrengthenEquip()
  self._preLv = self._equip:GetStrengthenLevel()
  local cstrengthenequip = LuaNetManager.CreateProtocol("protocol.item.cstrengthenequip")
  if cstrengthenequip then
    local stuffs = {}
    local equips = {}
    for _, value in pairs(self._selectedItems) do
      if value.tag == "item" then
        stuffs[value.key] = value.count
      end
    end
    for _, value in pairs(self._selectedItems) do
      if value.tag == "equip" then
        table.insert(equips, value.key)
      end
    end
    cstrengthenequip.equipKey = self._equip:GetKey()
    cstrengthenequip.stuffs = stuffs
    cstrengthenequip.costEquip = equips
    cstrengthenequip:Send()
  end
end

function StrengthenEquipTabCell:OnEnd()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  if self._effectHandler then
    self._effectHandler = nil
  end
end

function StrengthenEquipTabCell:OnItemEnough()
  self._isItemEnough = true
  LuaNotificationCenter.PostNotification(Common.n_EquipStrengthenItemEnough, self, nil)
end

function StrengthenEquipTabCell:OnItemNotEnough()
  if self._isItemEnough then
    self._isItemEnough = false
    LuaNotificationCenter.PostNotification(Common.n_EquipStrengthenItemNotEnough, self, nil)
  end
end

function StrengthenEquipTabCell:NumberOfCell(frame)
  if frame == self._propertyFrame then
    return #self._attrList
  elseif frame == self._itemFrame then
    return #self._selectedItemsCellData
  end
end

function StrengthenEquipTabCell:CellAtIndex(frame, index)
  if frame == self._propertyFrame then
    return "equipforge.equipqhpropcell"
  elseif frame == self._itemFrame then
    if self._selectedItemsCellData[index].tag == "item" then
      return "equipforge.equipqhitemcell"
    elseif self._selectedItemsCellData[index].tag == "equip" then
      return "equipforge.equipqhequipcell"
    end
  end
end

function StrengthenEquipTabCell:DataAtIndex(frame, index)
  if frame == self._propertyFrame then
    return self._attrList[index]
  elseif frame == self._itemFrame then
    return self._selectedItemsCellData[index]
  end
end

function StrengthenEquipTabCell:OnIBtnClick()
  DialogManager.CreateSingletonDialog("equipforge.equipqhtips"):Init(1517)
end

return StrengthenEquipTabCell
