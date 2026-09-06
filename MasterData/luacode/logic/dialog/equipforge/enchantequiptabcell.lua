local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAttrEffectidNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CRandomAbilityTable = BeanManager.GetTableByName("equip.crandomability")
local CEquipEnchantItemTable = BeanManager.GetTableByName("equip.cequipenchantitem")
local CAttreffectidName = BeanManager.GetTableByName("role.cattreffectidname")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local CEquipSpecialCfg = BeanManager.GetTableByName("equip.cequipspecialcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local EnchantEquipTabCell = class("EnchantEquipTabCell", Dialog)

local function ReplacePercent(str)
  str = string.gsub(str, "%%", "%%%%")
  return str
end

EnchantEquipTabCell.AssetBundleName = "ui/layouts.equip"
EnchantEquipTabCell.AssetName = "EquipFM"

function EnchantEquipTabCell:Ctor(...)
  EnchantEquipTabCell.super.Ctor(self, ...)
  self._equip = nil
  self._selectedItemId = nil
  self._selectedWordId = nil
  self._attrList = {}
  self._maxLuckValue = nil
  self._maxLuckEffectHandler = nil
  self._effectHandler = nil
  self._superWordRank = nil
  self._startTime = 0
end

function EnchantEquipTabCell:OnCreate()
  self._equipIcon = self:GetChild("EquipCell/BackGround/Icon")
  self._frame = self:GetChild("EquipCell/BackGround/Frame")
  self._equipPoint = self:GetChild("EquipCell/BreakPoint")
  self._effect = self:GetChild("Frame3/Effect")
  self._effect:Subscribe_UIEffectEndEvent(self.OnEnd, self)
  self._equipName = self:GetChild("EquipName")
  self._propertyPanel = self:GetChild("PropertyFrame")
  self._needMoneyNum = self:GetChild("Frame/NumBack1/Num")
  self._needMoneyNumRed = self:GetChild("Frame/NumBack1/NumRed")
  self._startPanel = self:GetChild("Frame/Start")
  self._start_addIcon = self:GetChild("Frame/Start/Item/Add")
  self._start_itemIcon = self:GetChild("Frame/Start/Item/Item")
  self._start_itemFrame = self:GetChild("Frame/Start/Item")
  self._itemDetailText = self:GetChild("Frame/Start/ItemDetail")
  self._luckProgress = self:GetChild("Frame/Start/ProgressBack/Progress")
  self._currentLuckIsMaxText = self:GetChild("Frame/Start/ProgressBack/Max")
  self._luckValueNode = self:GetChild("Frame/Start/ProgressBack/Num")
  self._currentLuckText = self:GetChild("Frame/Start/ProgressBack/Num/Num")
  self._maxLuckText = self:GetChild("Frame/Start/ProgressBack/Num/NumMax")
  self._maxLuckEffect = self:GetChild("Frame/Start/ProgressBack/Effect")
  self._start_startBtn = self:GetChild("Frame/Start/StartBtn")
  self._start_startBtn:SetInteractable(false)
  self._start_startBtn:Subscribe_PointerClickEvent(self.OnStartBtn, self)
  self._buttomText = self:GetChild("Frame/Start/Text")
  self._buttomText:SetText(TextManager.GetText(CStringRes:GetRecorder(1380).msgTextID))
  self._infoButton = self:GetChild("Ibtn")
  self._infoButton:Subscribe_PointerClickEvent(self.ShowInfoDialog, self)
  LuaNotificationCenter.AddObserver(self, self.OnPreEnchantEquip, Common.n_PreEnchantEquip, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EnchantEquip, nil)
  local maxLuckValueRecord = CEquipSpecialCfg:GetRecorder(2)
  self._maxLuckValue = maxLuckValueRecord.parameter
  local superWordRecord = CEquipSpecialCfg:GetRecorder(3)
  self._superWordRank = superWordRecord.parameter
  self._wordFrame = TableFrame.Create(self._propertyPanel, self, true, false, true)
end

function EnchantEquipTabCell:OnDestroy()
  self._wordFrame:Destroy()
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function EnchantEquipTabCell:OnHidden()
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
end

function EnchantEquipTabCell:OnPreEnchantEquip(notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  local requiredMana = userInfo.nextCostMaNa
  if requiredMana > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID) then
    self._needMoneyNum:SetActive(false)
    self._needMoneyNumRed:SetActive(true)
    self._needMoneyNumRed:SetNumber(math.ceil(requiredMana))
    self._start_startBtn:SetInteractable(false)
  else
    self._needMoneyNum:SetActive(true)
    self._needMoneyNumRed:SetActive(false)
    self._needMoneyNum:SetNumber(math.ceil(requiredMana))
    if self._selectedItemId then
      self._start_startBtn:SetInteractable(true)
    end
  end
  self:RefreshLuck()
end

function EnchantEquipTabCell:OnEnd()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  if self._effectHandler then
    self._effectHandler = nil
  end
end

function EnchantEquipTabCell:OnRefresh(notification)
  local equipKey = notification.userInfo.equipKey
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1081))
  if equipKey == self._equip:GetKey() then
    self:Init(equipKey)
  end
end

function EnchantEquipTabCell:RefreshTabCell()
end

function EnchantEquipTabCell:Init(equipKey)
  local defaultCellVarRecord = CVarconfig:GetRecorder(28)
  local imageRecord = CImagePathTable:GetRecorder(tonumber(defaultCellVarRecord.Value))
  self._start_itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._startPanel:SetActive(true)
  self._start_startBtn:SetInteractable(false)
  self._itemDetailText:SetActive(false)
  self._attrList = {}
  self._selectedItemId = nil
  self._start_addIcon:SetActive(true)
  self._start_itemIcon:SetActive(false)
  self._equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(equipKey)
  self._originalRandomWordCount = #self._equip:GetRandomAbility()
  local record = self._equip:GetIcon()
  self._equipIcon:SetSprite(record.assetBundle, record.assetName)
  self._equipPoint:SetText(self._equip:GetEquipStarStr())
  record = self._equip:GetPinJiImage()
  self._frame:SetSprite(record.assetBundle, record.assetName)
  local equipName = self._equip:GetName()
  self._equipName:SetText(equipName)
  local enchantItemArrtRecorder = CEquipEnchantItemTable:GetRecorder(self._selectedItemId)
  local requiredMana = self._equip:GetFMRequiredMana()
  if requiredMana > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID) then
    self._needMoneyNum:SetActive(false)
    self._needMoneyNumRed:SetActive(true)
    self._needMoneyNumRed:SetNumber(math.ceil(requiredMana))
  else
    self._needMoneyNum:SetActive(true)
    self._needMoneyNumRed:SetActive(false)
    self._needMoneyNum:SetNumber(math.ceil(requiredMana))
  end
  local randomWordList = self._equip:GetRandomEntry()
  for i, v in pairs(randomWordList) do
    if v.kind == 1 or v.kind == 3 then
      local temp = {}
      local randomAbilityRecord = CRandomAbilityTable:GetRecorder(v.randomId)
      temp.tag = "RandomProp"
      temp.attrId = v.attr
      temp.attrRank = randomAbilityRecord.rank
      temp.value = v.attrValue
      temp.unlock = true
      temp.randomAbilityId = v.randomId
      temp.kind = v.kind
      table.insert(self._attrList, temp)
    end
  end
  local finalRandomEntry = self._equip:GetFinalRandomEntry()
  if finalRandomEntry == nil then
    table.insert(self._attrList, {unlock = false})
  end
  self._wordFrame:ReloadAllCell()
  self:RefreshLuck()
end

function EnchantEquipTabCell:RefreshLuck()
  local currentLuckValue = self._equip:GetLuckValue()
  if currentLuckValue >= self._maxLuckValue then
    self._currentLuckIsMaxText:SetActive(true)
    self._luckValueNode:SetActive(false)
    self._luckProgress:SetFillAmount(1)
    if self._maxLuckEffectHandler == nil then
      self._maxLuckEffectHandler = self._maxLuckEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1102))
    end
  else
    if self._maxLuckEffectHandler ~= nil then
      self._maxLuckEffect:ReleaseEffect(self._maxLuckEffectHandler)
      self._maxLuckEffectHandler = nil
    end
    self._currentLuckIsMaxText:SetActive(false)
    self._luckValueNode:SetActive(true)
    self._currentLuckText:SetText(self._equip:GetLuckValue())
    self._maxLuckText:SetText(self._maxLuckValue)
    self._luckProgress:SetFillAmount(self._equip:GetLuckValue() / self._maxLuckValue)
  end
end

function EnchantEquipTabCell:RefreshItemFrame(items)
  self._selectedItemId = nil
  for key, value in pairs(items) do
    self._selectedItemId = key
  end
  if self._selectedItemId then
    local imageId = CItemAttrTable:GetRecorder(self._selectedItemId).icon
    local imageRecord = CImagePathTable:GetRecorder(imageId)
    self._itemDetailText:SetActive(true)
    self._start_itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._start_itemIcon:SetActive(true)
    local item = Item.Create(self._selectedItemId)
    imageRecord = item:GetPinJiImage()
    self._start_itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._start_addIcon:SetActive(false)
    local requiredMana = self._equip:GetFMRequiredMana()
    if requiredMana > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID) then
      self._start_startBtn:SetInteractable(false)
    else
      self._start_startBtn:SetInteractable(true)
    end
  else
    self._start_itemIcon:SetActive(false)
    self._itemDetailText:SetActive(false)
    self._start_addIcon:SetActive(true)
    local defaultCellVarRecord = CVarconfig:GetRecorder(28)
    local imageRecord = CImagePathTable:GetRecorder(tonumber(defaultCellVarRecord.Value))
    self._start_itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._start_startBtn:SetInteractable(false)
    return
  end
  local enchantItemArrtRecorder = CEquipEnchantItemTable:GetRecorder(self._selectedItemId)
  local itemTextID = enchantItemArrtRecorder.itemText
  local itemText = TextManager.GetText(itemTextID)
  itemText = string.gsub(itemText, "%$parameter1%$", self._originalRandomWordCount)
  self._itemDetailText:SetText(itemText)
end

function EnchantEquipTabCell:RefreshStartButton()
end

function EnchantEquipTabCell:IsMaxLuck()
  local currentLuckValue = self._equip:GetLuckValue()
  return currentLuckValue >= self._maxLuckValue
end

function EnchantEquipTabCell:OnToggleClicked(index)
  self._selectedWordId = index
  self._wordFrame:FireEvent("OffAllToggle", index)
end

function EnchantEquipTabCell:DisabledAllToggle()
  self._wordFrame:FireEvent("DisabledAllToggle")
end

function EnchantEquipTabCell:OnStartBtn()
  if not NekoData.BehaviorManager.BM_Game:GetCanPreEnchantEquip() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100266)
    return
  end
  if self._selectedItemId then
    local currentTime = os.time()
    if currentTime - self._startTime < 1 then
      LogError("1111", "22222")
      return
    end
    self._startTime = currentTime
    if self:IsMaxLuck() then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(86, nil, function()
        self:SendEnchantEquip()
      end)
    else
      self:SendEnchantEquip()
    end
  end
end

function EnchantEquipTabCell:SendEnchantEquip()
  local cenchantequip = LuaNetManager.CreateProtocol("protocol.item.cenchantequip")
  if cenchantequip then
    NekoData.BehaviorManager.BM_BagInfo:SetPreFMLastLuckValueTable(self._equip:GetKey(), self._equip:GetLuckValue())
    cenchantequip.equipKey = self._equip:GetKey()
    cenchantequip.stuff = self._selectedItemId
    cenchantequip:Send()
  end
end

function EnchantEquipTabCell:ShowInfoDialog()
  DialogManager.CreateSingletonDialog("equipforge.equipfmtipsdialog")
end

function EnchantEquipTabCell:NumberOfCell(frame)
  return #self._attrList
end

function EnchantEquipTabCell:CellAtIndex(frame, index)
  return "equipforge.equipfmcell"
end

function EnchantEquipTabCell:DataAtIndex(frame, index)
  return self._attrList[index]
end

return EnchantEquipTabCell
