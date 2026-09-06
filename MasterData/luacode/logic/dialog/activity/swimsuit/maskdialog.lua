local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Item = require("logic.manager.experimental.types.item")
local CFrameConfig = BeanManager.GetTableByName("activity.cframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ColumnNum = 4
local ShowDialog = class("ShowDialog", Dialog)
ShowDialog.AssetBundleName = "ui/layouts.activitysummer"
ShowDialog.AssetName = "ActivitySummerMask"

function ShowDialog:Ctor(...)
  ShowDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._currencyData = {}
  self._maskData = {}
  self._selectedMaskIndex = 1
end

function ShowDialog:OnCreate()
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._pointNum = self:GetChild("DownBack/num")
  self._maskLockPanel = self:GetChild("MaskLock")
  self._maskLockIcon = self:GetChild("MaskLock/Item")
  self._maskLockText = self:GetChild("MaskLock/Text")
  self._maskLockEffectBack1 = self:GetChild("MaskLock/back1")
  self._maskLockEffectIcon1 = self:GetChild("MaskLock/back1/Image")
  self._maskLockEffectText1 = self:GetChild("MaskLock/back1/Num")
  self._maskLockEffectBack2 = self:GetChild("MaskLock/back2")
  self._maskLockEffectIcon2 = self:GetChild("MaskLock/back2/Image")
  self._maskLockEffectText2 = self:GetChild("MaskLock/back2/Num")
  self._maskLockBtn = self:GetChild("MaskLock/MenuBtn")
  self._maskLockBtnTxt = self:GetChild("MaskLock/MenuBtn/Text")
  self._maskUnLockPanel = self:GetChild("MaskUnlock")
  self._maskUnLockIcon = self:GetChild("MaskUnlock/Item")
  self._maskUnLockText = self:GetChild("MaskUnlock/Text")
  self._maskUnLockSwitchBtn = self:GetChild("MaskUnlock/MenuBtn")
  self._maskUnLockSwitchBtnText = self:GetChild("MaskUnlock/MenuBtn/Text")
  self._maskUnWorkBackOn = self:GetChild("MaskUnlock/WorkBackon")
  self._maskUnWorkBackOff = self:GetChild("MaskUnlock/WorkBackoff")
  self._currencyPanel = self:GetChild("TopGroup")
  self._maskPanel = self:GetChild("frame")
  self._currencyFrame = TableFrame.Create(self._currencyPanel, self, false, false, true)
  self._maskFrame = GridFrame.Create(self._maskPanel, self, true, ColumnNum, false)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._maskLockBtn:Subscribe_PointerClickEvent(self.OnMaskLockBtnClicked, self)
  self._maskUnLockSwitchBtn:Subscribe_PointerClickEvent(self.OnMaskUnlockSwitchBtnClicked, self)
  self._maskLockEffectIcon1:Subscribe_PointerClickEvent(self.OnMaskLockEffectIcon1Clicked, self)
  self._maskLockEffectIcon2:Subscribe_PointerClickEvent(self.OnMaskLockEffectIcon2Clicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
end

function ShowDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._currencyFrame:Destroy()
  self._maskFrame:Destroy()
end

function ShowDialog:SetData(data)
  self:RefreshCurrencyData()
  self:RefreshMaskData(data.masks)
  self:RefreshSumPointData()
  self:ShowOneMaskDetail(self._selectedMaskIndex)
end

function ShowDialog:RefreshCurrencyData()
  for key, _ in pairs(self._currencyData) do
    self._currencyData[key] = nil
  end
  table.insert(self._currencyData, DataCommon.SwimSuitStone)
  table.insert(self._currencyData, DataCommon.SwimSuitSand)
  table.insert(self._currencyData, DataCommon.SwimSuitWood)
  self._currencyFrame:ReloadAllCell()
end

function ShowDialog:RefreshMaskData(serverData)
  for key, _ in pairs(self._maskData) do
    self._maskData[key] = nil
  end
  for _, id in pairs(CFrameConfig:GetAllIds()) do
    local record = CFrameConfig:GetRecorder(id)
    table.insert(self._maskData, {
      id = record.id,
      sort = record.sort,
      name = record.name,
      descTextID = record.descTextID,
      image = record.image,
      point = record.point,
      itemID = record.itemID,
      itemNum = record.itemNum,
      isUnlock = serverData[id]
    })
  end
  table.sort(self._maskData, function(a, b)
    return a.sort < b.sort
  end)
  self._maskFrame:ReloadAllCell()
end

function ShowDialog:RefreshSumPointData()
  local sumPoint = 0
  for _, mask in pairs(self._maskData) do
    if mask.isUnlock == 2 then
      sumPoint = sumPoint + mask.point
    end
  end
  self._pointNum:SetText(sumPoint)
end

function ShowDialog:OnSOperateMask(protocol)
  for key, value in pairs(self._maskData) do
    if value.id == protocol.mask then
      self._maskData[key].isUnlock = protocol.state
      break
    end
  end
  self._maskFrame:ReloadAllCell()
  self:RefreshSumPointData()
  self:ShowOneMaskDetail(self._selectedMaskIndex)
end

function ShowDialog:NumberOfCell(frame, index)
  if frame == self._currencyFrame then
    return #self._currencyData
  elseif frame == self._maskFrame then
    return #self._maskData
  end
end

function ShowDialog:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "activity.swimsuit.shopcurrencycell"
  elseif frame == self._maskFrame then
    return "activity.swimsuit.maskcell"
  end
end

function ShowDialog:DataAtIndex(frame, index)
  if frame == self._currencyFrame then
    return self._currencyData[index]
  elseif frame == self._maskFrame then
    return {
      index = index,
      data = self._maskData[index]
    }
  end
end

function ShowDialog:OnBackBtnClicked()
  self:Destroy()
end

function ShowDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ShowDialog:OnMaskLockBtnClicked()
  if not self._maskCanUnlock then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100386)
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.coperatemask")
  if protocol then
    protocol.mask = self._maskData[self._selectedMaskIndex].id
    protocol.operate = 1
    protocol:Send()
  end
end

function ShowDialog:OnMaskUnlockSwitchBtnClicked()
  local operation
  if self._maskData[self._selectedMaskIndex].isUnlock == 1 then
    operation = 2
  elseif self._maskData[self._selectedMaskIndex].isUnlock == 2 then
    operation = 0
  end
  if operation then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.coperatemask")
    if protocol then
      protocol.mask = self._maskData[self._selectedMaskIndex].id
      protocol.operate = operation
      protocol:Send()
    end
  end
end

function ShowDialog:ShowOneMaskDetail(index)
  self._maskFrame:FireEvent("ChangedSelected", index)
  self._selectedMaskIndex = index
  local maskData = self._maskData[index]
  if maskData.isUnlock == 0 then
    self._maskLockPanel:SetActive(true)
    self._maskUnLockPanel:SetActive(false)
    local imageRecord = CImagePathTable:GetRecorder(maskData.image) or DataCommon.DefaultImageAsset
    self._maskLockIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._maskLockText:SetText(TextManager.GetText(maskData.descTextID))
    self._maskCanUnlock = true
    local hadNum
    imageRecord = Item.Create(maskData.itemID[1]):GetIcon()
    self._maskLockEffectIcon1:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    hadNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(maskData.itemID[1])
    if hadNum < maskData.itemNum[1] then
      self._maskLockEffectText1:SetText(TextManager.GetText(CStringRes:GetRecorder(1622).msgTextID, maskData.itemNum[1]))
      self._maskCanUnlock = false
    else
      self._maskLockEffectText1:SetText(maskData.itemNum[1])
    end
    if maskData.itemID[2] then
      self._maskLockEffectBack2:SetActive(true)
      imageRecord = Item.Create(maskData.itemID[2]):GetIcon()
      self._maskLockEffectIcon2:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      hadNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(maskData.itemID[2])
      if hadNum < maskData.itemNum[2] then
        self._maskLockEffectText2:SetText(TextManager.GetText(CStringRes:GetRecorder(1622).msgTextID, maskData.itemNum[2]))
        self._maskCanUnlock = false
      else
        self._maskLockEffectText2:SetText(maskData.itemNum[2])
      end
    else
      self._maskLockEffectBack2:SetActive(false)
    end
    self._maskLockBtnTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1610).msgTextID))
  elseif maskData.isUnlock == 1 or maskData.isUnlock == 2 then
    self._maskLockPanel:SetActive(false)
    self._maskUnLockPanel:SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder(maskData.image) or DataCommon.DefaultImageAsset
    self._maskUnLockIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._maskUnLockText:SetText(TextManager.GetText(maskData.descTextID))
    if maskData.isUnlock == 1 then
      self._maskUnLockSwitchBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1611).msgTextID))
      self._maskUnWorkBackOn:SetActive(false)
      self._maskUnWorkBackOff:SetActive(true)
    else
      self._maskUnLockSwitchBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1612).msgTextID))
      self._maskUnWorkBackOn:SetActive(true)
      self._maskUnWorkBackOff:SetActive(false)
    end
  else
    self._maskLockPanel:SetActive(false)
    self._maskUnLockPanel:SetActive(false)
    LogError("ShowDialog:ShowOneMaskDetail()", "Mask State Error!")
  end
end

function ShowDialog:OnMaskLockEffectIcon1Clicked()
  local maskData = self._maskData[self._selectedMaskIndex]
  local width, height = self._maskLockEffectBack1:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(maskData.itemID[1])
    })
    tipsDialog:SetTipsPosition(width, height, self._maskLockEffectBack1:GetLocalPointInUiRootPanel())
  end
end

function ShowDialog:OnMaskLockEffectIcon2Clicked()
  local maskData = self._maskData[self._selectedMaskIndex]
  local width, height = self._maskLockEffectBack2:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(maskData.itemID[2])
    })
    tipsDialog:SetTipsPosition(width, height, self._maskLockEffectBack2:GetLocalPointInUiRootPanel())
  end
end

return ShowDialog
