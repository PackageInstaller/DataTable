local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipSpecialCfg = BeanManager.GetTableByName("equip.cequipspecialcfg")
local CRandomAbility = BeanManager.GetTableByName("equip.crandomability")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CEquipEnchantItem = BeanManager.GetTableByName("equip.cequipenchantitem")
local EquipFMResultDialog = class("EquipFMResultDialog", Dialog)

local function ReplacePercent(str)
  str = string.gsub(str, "%%", "%%%%")
  return str
end

EquipFMResultDialog.AssetBundleName = "ui/layouts.equip"
EquipFMResultDialog.AssetName = "EquipFMResult"

function EquipFMResultDialog:Ctor(...)
  EquipFMResultDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._equip = nil
  self._maxLuckValue = nil
  self._data = nil
  self._attrList = nil
  self._wordTableFrame = nil
  self._replaceTimer = nil
  self._replaceFlag = nil
  self._hasNewSuperWord = nil
  self._hasOldSuperWord = nil
  self._replaceTotalTime = 1
  self._curentLuckValue = nil
  self._targetLuckValue = nil
  self._luckValueAnimationTime = 2
  self._luckValueAnimatonSpeed = nil
  self._maxLuckValueEffectHandler = nil
  self._animationEndFlag = nil
  self._firstFlag = nil
  self._isFromCached = false
  self._fromCachedIndex = 0
  self._cachedFMKeyList = nil
  self._protocolSent = false
  self._lastKey = nil
  self._unlockNewWord = false
end

function EquipFMResultDialog:OnCreate()
  self._equipIconImage = self:GetChild("Panel/EquipCell/BackGround/Icon")
  self._equipPinjiImage = self:GetChild("Panel/EquipCell/BackGround/Frame")
  self._equipNameText = self:GetChild("Panel/EquipCell/EquipName")
  self._luckProgress = self:GetChild("Panel/ProgressBack/Progress")
  self._currentLuckIsMaxText = self:GetChild("Panel/ProgressBack/Max")
  self._luckValueNode = self:GetChild("Panel/ProgressBack/Num")
  self._currentLuckText = self:GetChild("Panel/ProgressBack/Num/Num")
  self._maxLuckText = self:GetChild("Panel/ProgressBack/Num/NumMax")
  self._maxLuckEffect = self:GetChild("Panel/ProgressBack/Effect")
  self._againButton = self:GetChild("Panel/AgainBtn")
  self._abandonButton = self:GetChild("Panel/AbandonBtn")
  self._changeButton = self:GetChild("Panel/ChangeBtn")
  self._wordTableFrameNode = self:GetChild("Panel/PropertyFrame")
  self._talkText = self:GetChild("Panel/Dialog/Text")
  self._equipIconImage:Subscribe_PointerClickEvent(self.HandleEquipIconImageClicked, self)
  self._againButton:Subscribe_PointerClickEvent(self.HandleAgainButtonClicked, self)
  self._abandonButton:Subscribe_PointerClickEvent(self.HandleAbandonButtonClicked, self)
  self._changeButton:Subscribe_PointerClickEvent(self.HandleReplaceButtonClicked, self)
  self._rootWindow:Subscribe_UpdateEvent(self.OnUpdate, self)
  self._rootWindow:Subscribe_AnimationEvent("EquipFMResult", self.OnAnimationEnd, self)
  LuaNotificationCenter.AddObserver(self, self.OnEnchantEquipSuccess, Common.n_EnchantEquip, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEnchantEquipCancel, Common.n_EnchantEquipCancel, nil)
  self._wordTableFrame = TableFrame.Create(self._wordTableFrameNode, self, true, false, true)
  self._talkText:SetText(CStringRes:GetRecorder(1381).msg)
  local superWordRecord = CEquipSpecialCfg:GetRecorder(3)
  self._superWordRank = superWordRecord.parameter
  local maxLuckValueRecord = CEquipSpecialCfg:GetRecorder(2)
  self._maxLuckValue = maxLuckValueRecord.parameter
  self._firstFlag = true
end

function EquipFMResultDialog:OnDestroy()
  self._wordTableFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function EquipFMResultDialog:RefreshFromCachedFM(equipKeyTable)
  self._againButton:SetActive(false)
  local tempList = {}
  for k, v in pairs(equipKeyTable) do
    table.insert(tempList, k)
  end
  self._cachedFMKeyList = tempList
  self._isFromCached = true
  self:RefreshFromCachedByIndex(1)
end

function EquipFMResultDialog:RefreshFromCachedByIndex(index)
  self._fromCachedIndex = index
  if index > #self._cachedFMKeyList then
    self:Destroy()
    return
  end
  self._lastKey = self._cachedFMKeyList[index]
  local equipKey = self._cachedFMKeyList[index]
  local protocol = {}
  local equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(equipKey)
  protocol.equipKey = equipKey
  protocol.entries, protocol.finalAttr = equip:GetPreRandomEntry()
  self:Refresh(protocol)
end

function EquipFMResultDialog:Refresh(protocol)
  self._protocolSent = false
  if self._animationEndFlag then
    self:ResetEffect()
  end
  self._equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(protocol.equipKey)
  self._rootWindow:PlayAnimation("EquipFMResult")
  if self._isFromCached then
    self._curentLuckValue = self._equip:GetLuckValue()
    self._targetLuckValue = self._curentLuckValue
  else
    local lastLuck = NekoData.BehaviorManager.BM_BagInfo:GetPreFMLastLuckValueTable(protocol.equipKey)
    if lastLuck then
      if lastLuck == self._maxLuckValue then
        self._curentLuckValue = 0
      else
        self._curentLuckValue = lastLuck
      end
    else
      self._curentLuckValue = protocol.luck
    end
    self._targetLuckValue = protocol.luck
  end
  self:RefreshLuckValue(self._curentLuckValue, self._maxLuckValue, false)
  self._luckValueAnimatonSpeed = (self._targetLuckValue - self._curentLuckValue) / self._luckValueAnimationTime
  self._replaceFlag = false
  self._replaceTimer = 0
  self._hasNewSuperWord = false
  self._hasOldSuperWord = false
  self._animationEndFlag = false
  self._data = protocol
  local icon = self._equip:GetIcon()
  local pinjiIcon = self._equip:GetPinJiImage()
  self._equipIconImage:SetSprite(icon.assetBundle, icon.assetName)
  self._equipPinjiImage:SetSprite(pinjiIcon.assetBundle, pinjiIcon.assetName)
  self._equipNameText:SetText(self._equip:GetName())
  self._attrList = {}
  local randomWordList = self._equip:GetRandomEntry()
  for i, v in pairs(protocol.entries) do
    local temp = {}
    local oldWordData = randomWordList[i]
    local randomAbilityRecord = CRandomAbility:GetRecorder(oldWordData.randomId)
    temp.oldAttrId = oldWordData.attr
    temp.oldAttrRank = randomAbilityRecord.rank
    temp.oldValue = oldWordData.attrValue
    temp.oldRandomAbilityId = oldWordData.randomId
    if temp.oldAttrRank >= 5 then
      self._hasOldSuperWord = true
    end
    randomAbilityRecord = CRandomAbility:GetRecorder(v.randomId)
    temp.newAttrId = v.attr
    temp.newAttrRank = randomAbilityRecord.rank
    temp.newValue = v.attrValue
    temp.newRandomAbilityId = v.randomId
    if 5 <= temp.newAttrRank then
      self._hasNewSuperWord = true
    end
    table.insert(self._attrList, temp)
  end
end

function EquipFMResultDialog:OnAnimationEnd()
  self._animationEndFlag = true
  local finalRandomEntry = self._data.finalAttr
  if finalRandomEntry ~= nil and finalRandomEntry.attr ~= 0 then
    self._unlockNewWord = true
    local temp = {}
    temp.isNew = true
    local randomAbilityRecord = CRandomAbility:GetRecorder(finalRandomEntry.randomId)
    temp.newAttrId = finalRandomEntry.attr
    temp.newAttrRank = randomAbilityRecord.rank
    temp.newValue = finalRandomEntry.attrValue
    temp.newRandomAbilityId = finalRandomEntry.randomId
    table.insert(self._attrList, temp)
    local equipFMTipDialog = DialogManager.CreateSingletonDialog("equipforge.equipfmresulttipdialog")
    equipFMTipDialog:Refresh(temp)
  else
    self._unlockNewWord = false
  end
  self._wordTableFrame:ReloadAllCell()
end

function EquipFMResultDialog:RefreshLuckValue(current, max, isPlayEffect)
  if max <= current then
    self._currentLuckIsMaxText:SetActive(true)
    self._luckValueNode:SetActive(false)
    if isPlayEffect and self._maxLuckValueEffectHandler == nil then
      self._maxLuckValueEffectHandler = self._maxLuckEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1106))
    end
  else
    if self._maxLuckValueEffectHandler then
      self._maxLuckEffect:ReleaseEffect(self._maxLuckValueEffectHandler)
      self._maxLuckValueEffectHandler = nil
    end
    self._currentLuckIsMaxText:SetActive(false)
    self._luckValueNode:SetActive(true)
    self._currentLuckText:SetText(math.floor(current))
    self._maxLuckText:SetText(max)
    self._luckProgress:SetFillAmount(current / max)
  end
end

function EquipFMResultDialog:ResetEffect()
  self._attrList = {}
  self._wordTableFrame:ReloadAllCell()
  if self._maxLuckValueEffectHandler then
    self._maxLuckEffect:ReleaseEffect(self._maxLuckValueEffectHandler)
    self._maxLuckValueEffectHandler = nil
  end
end

function EquipFMResultDialog:OnEnchantEquipSuccess(notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  LogInfo("equip enchant", "OnEnchantEquipSuccess isFromCached" .. tostring(self._isFromCached))
  if self._isFromCached then
    NekoData.BehaviorManager.BM_BagInfo:RemoveCachedFMKey(self._equip:GetKey())
    self:RefreshFromCachedByIndex(self._fromCachedIndex + 1)
  else
    self._replaceFlag = true
    self._protocolSent = false
  end
end

function EquipFMResultDialog:OnEnchantEquipCancel(notification)
  if self._isFromCached then
    NekoData.BehaviorManager.BM_BagInfo:RemoveCachedFMKey(self._equip:GetKey())
    self:RefreshFromCachedByIndex(self._fromCachedIndex + 1)
    return
  end
  self:Destroy()
end

function EquipFMResultDialog:OnUpdate(deltaTime)
  if self._animationEndFlag == false then
    return
  end
  if self._curentLuckValue <= self._targetLuckValue then
    self._curentLuckValue = self._curentLuckValue + self._luckValueAnimatonSpeed * deltaTime
    self:RefreshLuckValue(self._curentLuckValue, self._maxLuckValue, true)
  end
  if self._replaceFlag == false then
    return
  end
  self._replaceTimer = self._replaceTimer + deltaTime
  if self._replaceTimer > self._replaceTotalTime then
    self:Destroy()
  end
end

function EquipFMResultDialog:IsMaxLuck()
  local currentLuckValue = self._data.luck
  return currentLuckValue >= self._maxLuckValue
end

function EquipFMResultDialog:HasNewSuperAttr()
  return self._hasNewSuperWord
end

function EquipFMResultDialog:HasOldSuperAttr()
  return self._hasOldSuperWord
end

function EquipFMResultDialog:HandleEquipIconImageClicked(args)
  local tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
  if tipsDialog then
    local width, height = self:GetRootWindow():GetLocalPointInUiRootPanel()
    tipsDialog:Init(self._equip:GetKey())
    tipsDialog:SetTipsParmFunc(function()
      local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
      return {
        width = width,
        height = height,
        posX = pos.x,
        posY = pos.y
      }
    end)
  end
end

function EquipFMResultDialog:HandleAgainButtonClicked(args)
  if self._replaceFlag then
    LogInfo("EquipFMResultDialog", "HandleAgainButtonClicked replace true")
    return
  end
  if not NekoData.BehaviorManager.BM_Game:GetCanPreEnchantEquip() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100266)
    return
  end
  local requiredMana = self._data.nextCostMaNa
  if requiredMana > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100006)
    return
  end
  if self._protocolSent then
    LogInfo("EquipFMResultDialog", "HandleAgainButtonClicked protocolSent true")
    return
  end
  if self._animationEndFlag ~= true and (self._animationEndFlag ~= false or self._firstFlag ~= true) then
    return
  end
  local stuffCount = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(self._data.stuff)
  if stuffCount <= 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100237)
    return
  end
  if self:HasNewSuperAttr() then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(88, nil, function()
      if self:IsMaxLuck() then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(86, nil, function()
          self:SendEnchantEquip()
        end)
      else
        self:SendEnchantEquip()
      end
    end)
  elseif self:IsMaxLuck() then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(86, nil, function()
      self:SendEnchantEquip()
    end)
  else
    self:SendEnchantEquip()
  end
  self._firstFlag = false
end

function EquipFMResultDialog:HandleAbandonButtonClicked(args)
  if self._replaceFlag then
    LogInfo("EquipFMResultDialog", "HandleAbandonButtonClicked replaceFlag true")
    return
  end
  if self._protocolSent then
    LogInfo("EquipFMResultDialog", "HandleAbandonButtonClicked protocolSent true")
    return
  end
  if self:HasNewSuperAttr() then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(87, nil, function()
      self:Abandon()
    end)
  else
    self:Abandon()
  end
end

function EquipFMResultDialog:HandleReplaceButtonClicked(args)
  if self._protocolSent then
    LogInfo("EquipFMResultDialog", "HandleReplaceButtonClicked protocolSent true")
    return
  end
  if self._replaceFlag then
    LogInfo("EquipFMResultDialog", "HandleReplaceButtonClicked replaceFlag true")
    return
  end
  if self._animationEndFlag == false then
    return
  end
  if self._unlockNewWord then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(118, nil, function()
      if self:HasOldSuperAttr() then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(88, nil, function()
          self:Replace()
        end)
      else
        self:Replace()
      end
    end)
  elseif self:HasOldSuperAttr() then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(88, nil, function()
      self:Replace()
    end)
  else
    self:Replace()
  end
end

function EquipFMResultDialog:Replace()
  self:SendSureEnchante(1)
end

function EquipFMResultDialog:Abandon()
  if self:SendSureEnchante(2) then
  end
end

function EquipFMResultDialog:SendSureEnchante(sureKind)
  local cSureEnchantEquip = LuaNetManager.CreateProtocol("protocol.item.csureenchantequip")
  if cSureEnchantEquip then
    cSureEnchantEquip.kind = sureKind
    cSureEnchantEquip.equipKey = self._data.equipKey
    cSureEnchantEquip:Send()
    self._protocolSent = true
    return true
  end
  LogError("EquipFMResultDialog", "SendSureEnchante protocol create fail")
  return false
end

function EquipFMResultDialog:SendEnchantEquip()
  local cenchantequip = LuaNetManager.CreateProtocol("protocol.item.cenchantequip")
  if cenchantequip then
    NekoData.BehaviorManager.BM_BagInfo:SetPreFMLastLuckValueTable(self._data.equipKey, self._data.luck)
    cenchantequip.equipKey = self._data.equipKey
    cenchantequip.stuff = self._data.stuff
    cenchantequip:Send()
    self._protocolSent = true
    return true
  end
  LogError("EquipFMResultDialog", "SendEnchantEquip protocol create fail")
  return false
end

function EquipFMResultDialog:NumberOfCell(frame)
  return #self._attrList
end

function EquipFMResultDialog:DataAtIndex(frame, index)
  return self._attrList[index]
end

function EquipFMResultDialog:CellAtIndex(frame, index)
  return "equipforge.equipfmresultcell"
end

return EquipFMResultDialog
