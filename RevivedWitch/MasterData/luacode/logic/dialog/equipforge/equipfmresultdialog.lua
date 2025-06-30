-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipfmresultdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipSpecialCfg = (BeanManager.GetTableByName)("equip.cequipspecialcfg")
local CRandomAbility = (BeanManager.GetTableByName)("equip.crandomability")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CEquipEnchantItem = (BeanManager.GetTableByName)("equip.cequipenchantitem")
local EquipFMResultDialog = class("EquipFMResultDialog", Dialog)
local ReplacePercent = function(str)
  -- function num : 0_0 , upvalues : _ENV
  str = (string.gsub)(str, "%%", "%%%%")
  return str
end

EquipFMResultDialog.AssetBundleName = "ui/layouts.equip"
EquipFMResultDialog.AssetName = "EquipFMResult"
EquipFMResultDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : EquipFMResultDialog
  ((EquipFMResultDialog.super).Ctor)(self, ...)
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

EquipFMResultDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV, TableFrame, CStringRes, CEquipSpecialCfg
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
  ;
  (self._equipIconImage):Subscribe_PointerClickEvent(self.HandleEquipIconImageClicked, self)
  ;
  (self._againButton):Subscribe_PointerClickEvent(self.HandleAgainButtonClicked, self)
  ;
  (self._abandonButton):Subscribe_PointerClickEvent(self.HandleAbandonButtonClicked, self)
  ;
  (self._changeButton):Subscribe_PointerClickEvent(self.HandleReplaceButtonClicked, self)
  ;
  (self._rootWindow):Subscribe_UpdateEvent(self.OnUpdate, self)
  ;
  (self._rootWindow):Subscribe_AnimationEvent("EquipFMResult", self.OnAnimationEnd, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEnchantEquipSuccess, Common.n_EnchantEquip, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEnchantEquipCancel, Common.n_EnchantEquipCancel, nil)
  self._wordTableFrame = (TableFrame.Create)(self._wordTableFrameNode, self, true, false, true)
  ;
  (self._talkText):SetText((CStringRes:GetRecorder(1381)).msg)
  local superWordRecord = CEquipSpecialCfg:GetRecorder(3)
  self._superWordRank = superWordRecord.parameter
  local maxLuckValueRecord = CEquipSpecialCfg:GetRecorder(2)
  self._maxLuckValue = maxLuckValueRecord.parameter
  self._firstFlag = true
end

EquipFMResultDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._wordTableFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

EquipFMResultDialog.RefreshFromCachedFM = function(self, equipKeyTable)
  -- function num : 0_4 , upvalues : _ENV
  (self._againButton):SetActive(false)
  local tempList = {}
  for k,v in pairs(equipKeyTable) do
    (table.insert)(tempList, k)
  end
  self._cachedFMKeyList = tempList
  self._isFromCached = true
  self:RefreshFromCachedByIndex(1)
end

EquipFMResultDialog.RefreshFromCachedByIndex = function(self, index)
  -- function num : 0_5 , upvalues : _ENV
  self._fromCachedIndex = index
  if #self._cachedFMKeyList < index then
    self:Destroy()
    return 
  end
  self._lastKey = (self._cachedFMKeyList)[index]
  local equipKey = (self._cachedFMKeyList)[index]
  local protocol = {}
  local equip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(equipKey)
  protocol.equipKey = equipKey
  protocol.entries = equip:GetPreRandomEntry()
  self:Refresh(protocol)
end

EquipFMResultDialog.Refresh = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV, CRandomAbility
  self._protocolSent = false
  if self._animationEndFlag then
    self:ResetEffect()
  end
  self._equip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(protocol.equipKey)
  ;
  (self._rootWindow):PlayAnimation("EquipFMResult")
  if self._isFromCached then
    self._curentLuckValue = (self._equip):GetLuckValue()
    self._targetLuckValue = self._curentLuckValue
  else
    local lastLuck = ((NekoData.BehaviorManager).BM_BagInfo):GetPreFMLastLuckValueTable(protocol.equipKey)
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
  do
    self:RefreshLuckValue(self._curentLuckValue, self._maxLuckValue, false)
    self._luckValueAnimatonSpeed = (self._targetLuckValue - self._curentLuckValue) / self._luckValueAnimationTime
    self._replaceFlag = false
    self._replaceTimer = 0
    self._hasNewSuperWord = false
    self._hasOldSuperWord = false
    self._animationEndFlag = false
    self._data = protocol
    local icon = (self._equip):GetIcon()
    local pinjiIcon = (self._equip):GetPinJiImage()
    ;
    (self._equipIconImage):SetSprite(icon.assetBundle, icon.assetName)
    ;
    (self._equipPinjiImage):SetSprite(pinjiIcon.assetBundle, pinjiIcon.assetName)
    ;
    (self._equipNameText):SetText((self._equip):GetName())
    self._attrList = {}
    local randomWordList = (self._equip):GetRandomEntry()
    for i,v in pairs(protocol.entries) do
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
      if temp.newAttrRank >= 5 then
        self._hasNewSuperWord = true
      end
      ;
      (table.insert)(self._attrList, temp)
    end
  end
end

EquipFMResultDialog.OnAnimationEnd = function(self)
  -- function num : 0_7 , upvalues : CRandomAbility, _ENV
  self._animationEndFlag = true
  local finalRandomEntry = (self._data).finalAttr
  if finalRandomEntry ~= nil and finalRandomEntry.attr ~= 0 then
    self._unlockNewWord = true
    local temp = {}
    temp.isNew = true
    local randomAbilityRecord = CRandomAbility:GetRecorder(finalRandomEntry.randomId)
    temp.newAttrId = finalRandomEntry.attr
    temp.newAttrRank = randomAbilityRecord.rank
    temp.newValue = finalRandomEntry.attrValue
    temp.newRandomAbilityId = finalRandomEntry.randomId
    ;
    (table.insert)(self._attrList, temp)
    local equipFMTipDialog = (DialogManager.CreateSingletonDialog)("equipforge.equipfmresulttipdialog")
    equipFMTipDialog:Refresh(temp)
  else
    do
      self._unlockNewWord = false
      ;
      (self._wordTableFrame):ReloadAllCell()
    end
  end
end

EquipFMResultDialog.RefreshLuckValue = function(self, current, max, isPlayEffect)
  -- function num : 0_8 , upvalues : _ENV
  if max <= current then
    (self._currentLuckIsMaxText):SetActive(true)
    ;
    (self._luckValueNode):SetActive(false)
    if isPlayEffect and self._maxLuckValueEffectHandler == nil then
      self._maxLuckValueEffectHandler = (self._maxLuckEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1106))
    end
  else
    if self._maxLuckValueEffectHandler then
      (self._maxLuckEffect):ReleaseEffect(self._maxLuckValueEffectHandler)
      self._maxLuckValueEffectHandler = nil
    end
    ;
    (self._currentLuckIsMaxText):SetActive(false)
    ;
    (self._luckValueNode):SetActive(true)
    ;
    (self._currentLuckText):SetText((math.floor)(current))
    ;
    (self._maxLuckText):SetText(max)
    ;
    (self._luckProgress):SetFillAmount(current / max)
  end
end

EquipFMResultDialog.ResetEffect = function(self)
  -- function num : 0_9
  self._attrList = {}
  ;
  (self._wordTableFrame):ReloadAllCell()
  if self._maxLuckValueEffectHandler then
    (self._maxLuckEffect):ReleaseEffect(self._maxLuckValueEffectHandler)
    self._maxLuckValueEffectHandler = nil
  end
end

EquipFMResultDialog.OnEnchantEquipSuccess = function(self, notification)
  -- function num : 0_10 , upvalues : _ENV
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  LogInfo("equip enchant", "OnEnchantEquipSuccess isFromCached" .. tostring(self._isFromCached))
  if self._isFromCached then
    ((NekoData.BehaviorManager).BM_BagInfo):RemoveCachedFMKey((self._equip):GetKey())
    self:RefreshFromCachedByIndex(self._fromCachedIndex + 1)
  else
    self._replaceFlag = true
    self._protocolSent = false
  end
end

EquipFMResultDialog.OnEnchantEquipCancel = function(self, notification)
  -- function num : 0_11 , upvalues : _ENV
  if self._isFromCached then
    ((NekoData.BehaviorManager).BM_BagInfo):RemoveCachedFMKey((self._equip):GetKey())
    self:RefreshFromCachedByIndex(self._fromCachedIndex + 1)
    return 
  end
  self:Destroy()
end

EquipFMResultDialog.OnUpdate = function(self, deltaTime)
  -- function num : 0_12
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
  if self._replaceTotalTime < self._replaceTimer then
    self:Destroy()
  end
end

EquipFMResultDialog.IsMaxLuck = function(self)
  -- function num : 0_13
  local currentLuckValue = (self._data).luck
  do return self._maxLuckValue <= currentLuckValue end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipFMResultDialog.HasNewSuperAttr = function(self)
  -- function num : 0_14
  return self._hasNewSuperWord
end

EquipFMResultDialog.HasOldSuperAttr = function(self)
  -- function num : 0_15
  return self._hasOldSuperWord
end

EquipFMResultDialog.HandleEquipIconImageClicked = function(self, args)
  -- function num : 0_16 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
  if tipsDialog then
    local width, height = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    do
      tipsDialog:Init((self._equip):GetKey())
      tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_16_0 , upvalues : self, width, height
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
    end
  end
end

EquipFMResultDialog.HandleAgainButtonClicked = function(self, args)
  -- function num : 0_17 , upvalues : _ENV
  if self._replaceFlag then
    LogInfo("EquipFMResultDialog", "HandleAgainButtonClicked replace true")
    return 
  end
  if not ((NekoData.BehaviorManager).BM_Game):GetCanPreEnchantEquip() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100266)
    return 
  end
  local requiredMana = (self._data).nextCostMaNa
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID) < requiredMana then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100006)
    return 
  end
  if self._protocolSent then
    LogInfo("EquipFMResultDialog", "HandleAgainButtonClicked protocolSent true")
    return 
  end
  if self._animationEndFlag ~= true and (self._animationEndFlag ~= false or self._firstFlag ~= true) then
    return 
  end
  local stuffCount = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById((self._data).stuff)
  if stuffCount <= 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100237)
    return 
  end
  if self:HasNewSuperAttr() then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(88, nil, function()
    -- function num : 0_17_0 , upvalues : self, _ENV
    if self:IsMaxLuck() then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(86, nil, function()
      -- function num : 0_17_0_0 , upvalues : self
      self:SendEnchantEquip()
    end
)
    else
      self:SendEnchantEquip()
    end
  end
)
  else
    if self:IsMaxLuck() then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(86, nil, function()
    -- function num : 0_17_1 , upvalues : self
    self:SendEnchantEquip()
  end
)
    else
      self:SendEnchantEquip()
    end
  end
  self._firstFlag = false
end

EquipFMResultDialog.HandleAbandonButtonClicked = function(self, args)
  -- function num : 0_18 , upvalues : _ENV
  if self._replaceFlag then
    LogInfo("EquipFMResultDialog", "HandleAbandonButtonClicked replaceFlag true")
    return 
  end
  if self._protocolSent then
    LogInfo("EquipFMResultDialog", "HandleAbandonButtonClicked protocolSent true")
    return 
  end
  if self:HasNewSuperAttr() then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(87, nil, function()
    -- function num : 0_18_0 , upvalues : self
    self:Abandon()
  end
)
  else
    self:Abandon()
  end
end

EquipFMResultDialog.HandleReplaceButtonClicked = function(self, args)
  -- function num : 0_19 , upvalues : _ENV
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
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(118, nil, function()
    -- function num : 0_19_0 , upvalues : self, _ENV
    if self:HasOldSuperAttr() then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(88, nil, function()
      -- function num : 0_19_0_0 , upvalues : self
      self:Replace()
    end
)
    else
      self:Replace()
    end
  end
)
  else
    if self:HasOldSuperAttr() then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(88, nil, function()
    -- function num : 0_19_1 , upvalues : self
    self:Replace()
  end
)
    else
      self:Replace()
    end
  end
end

EquipFMResultDialog.Replace = function(self)
  -- function num : 0_20
  self:SendSureEnchante(1)
end

EquipFMResultDialog.Abandon = function(self)
  -- function num : 0_21
  if self:SendSureEnchante(2) then
  end
end

EquipFMResultDialog.SendSureEnchante = function(self, sureKind)
  -- function num : 0_22 , upvalues : _ENV
  local cSureEnchantEquip = (LuaNetManager.CreateProtocol)("protocol.item.csureenchantequip")
  if cSureEnchantEquip then
    cSureEnchantEquip.kind = sureKind
    cSureEnchantEquip.equipKey = (self._data).equipKey
    cSureEnchantEquip:Send()
    self._protocolSent = true
    return true
  end
  LogError("EquipFMResultDialog", "SendSureEnchante protocol create fail")
  return false
end

EquipFMResultDialog.SendEnchantEquip = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local cenchantequip = (LuaNetManager.CreateProtocol)("protocol.item.cenchantequip")
  if cenchantequip then
    ((NekoData.BehaviorManager).BM_BagInfo):SetPreFMLastLuckValueTable((self._data).equipKey, (self._data).luck)
    cenchantequip.equipKey = (self._data).equipKey
    cenchantequip.stuff = (self._data).stuff
    cenchantequip:Send()
    self._protocolSent = true
    return true
  end
  LogError("EquipFMResultDialog", "SendEnchantEquip protocol create fail")
  return false
end

EquipFMResultDialog.NumberOfCell = function(self, frame)
  -- function num : 0_24
  return #self._attrList
end

EquipFMResultDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_25
  return (self._attrList)[index]
end

EquipFMResultDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_26
  return "equipforge.equipfmresultcell"
end

return EquipFMResultDialog

