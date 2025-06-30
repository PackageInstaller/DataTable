-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/maskdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Item = require("logic.manager.experimental.types.item")
local CFrameConfig = (BeanManager.GetTableByName)("activity.cframeconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ColumnNum = 4
local ShowDialog = class("ShowDialog", Dialog)
ShowDialog.AssetBundleName = "ui/layouts.activitysummer"
ShowDialog.AssetName = "ActivitySummerMask"
ShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShowDialog
  ((ShowDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._currencyData = {}
  self._maskData = {}
  self._selectedMaskIndex = 1
end

ShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, GridFrame, ColumnNum, _ENV
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
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false, true)
  self._maskFrame = (GridFrame.Create)(self._maskPanel, self, true, ColumnNum, false)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._maskLockBtn):Subscribe_PointerClickEvent(self.OnMaskLockBtnClicked, self)
  ;
  (self._maskUnLockSwitchBtn):Subscribe_PointerClickEvent(self.OnMaskUnlockSwitchBtnClicked, self)
  ;
  (self._maskLockEffectIcon1):Subscribe_PointerClickEvent(self.OnMaskLockEffectIcon1Clicked, self)
  ;
  (self._maskLockEffectIcon2):Subscribe_PointerClickEvent(self.OnMaskLockEffectIcon2Clicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
end

ShowDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._currencyFrame):Destroy()
  ;
  (self._maskFrame):Destroy()
end

ShowDialog.SetData = function(self, data)
  -- function num : 0_3
  self:RefreshCurrencyData()
  self:RefreshMaskData(data.masks)
  self:RefreshSumPointData()
  self:ShowOneMaskDetail(self._selectedMaskIndex)
end

ShowDialog.RefreshCurrencyData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for key,_ in pairs(self._currencyData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._currencyData)[key] = nil
  end
  ;
  (table.insert)(self._currencyData, DataCommon.SwimSuitStone)
  ;
  (table.insert)(self._currencyData, DataCommon.SwimSuitSand)
  ;
  (table.insert)(self._currencyData, DataCommon.SwimSuitWood)
  ;
  (self._currencyFrame):ReloadAllCell()
end

ShowDialog.RefreshMaskData = function(self, serverData)
  -- function num : 0_5 , upvalues : _ENV, CFrameConfig
  for key,_ in pairs(self._maskData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

    (self._maskData)[key] = nil
  end
  for _,id in pairs(CFrameConfig:GetAllIds()) do
    local record = CFrameConfig:GetRecorder(id)
    ;
    (table.insert)(self._maskData, {id = record.id, sort = record.sort, name = record.name, descTextID = record.descTextID, image = record.image, point = record.point, itemID = record.itemID, itemNum = record.itemNum, isUnlock = serverData[id]})
  end
  ;
  (table.sort)(self._maskData, function(a, b)
    -- function num : 0_5_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._maskFrame):ReloadAllCell()
end

ShowDialog.RefreshSumPointData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local sumPoint = 0
  for _,mask in pairs(self._maskData) do
    if mask.isUnlock == 2 then
      sumPoint = sumPoint + mask.point
    end
  end
  ;
  (self._pointNum):SetText(sumPoint)
end

ShowDialog.OnSOperateMask = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  for key,value in pairs(self._maskData) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

    if value.id == protocol.mask then
      ((self._maskData)[key]).isUnlock = protocol.state
      break
    end
  end
  do
    ;
    (self._maskFrame):ReloadAllCell()
    self:RefreshSumPointData()
    self:ShowOneMaskDetail(self._selectedMaskIndex)
  end
end

ShowDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  if frame == self._currencyFrame then
    return #self._currencyData
  else
    if frame == self._maskFrame then
      return #self._maskData
    end
  end
end

ShowDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._currencyFrame then
    return "activity.swimsuit.shopcurrencycell"
  else
    if frame == self._maskFrame then
      return "activity.swimsuit.maskcell"
    end
  end
end

ShowDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._currencyFrame then
    return (self._currencyData)[index]
  else
    if frame == self._maskFrame then
      return {index = index, data = (self._maskData)[index]}
    end
  end
end

ShowDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11
  self:Destroy()
end

ShowDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ShowDialog.OnMaskLockBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if not self._maskCanUnlock then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100386)
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.coperatemask")
  if protocol then
    protocol.mask = ((self._maskData)[self._selectedMaskIndex]).id
    protocol.operate = 1
    protocol:Send()
  end
end

ShowDialog.OnMaskUnlockSwitchBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local operation = nil
  if ((self._maskData)[self._selectedMaskIndex]).isUnlock == 1 then
    operation = 2
  else
    if ((self._maskData)[self._selectedMaskIndex]).isUnlock == 2 then
      operation = 0
    end
  end
  if operation then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.coperatemask")
    if protocol then
      protocol.mask = ((self._maskData)[self._selectedMaskIndex]).id
      protocol.operate = operation
      protocol:Send()
    end
  end
end

ShowDialog.ShowOneMaskDetail = function(self, index)
  -- function num : 0_15 , upvalues : CImagePathTable, _ENV, Item, CStringRes
  (self._maskFrame):FireEvent("ChangedSelected", index)
  self._selectedMaskIndex = index
  local maskData = (self._maskData)[index]
  if maskData.isUnlock == 0 then
    (self._maskLockPanel):SetActive(true)
    ;
    (self._maskUnLockPanel):SetActive(false)
    if not CImagePathTable:GetRecorder(maskData.image) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._maskLockIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._maskLockText):SetText((TextManager.GetText)(maskData.descTextID))
    self._maskCanUnlock = true
    local hadNum = nil
    imageRecord = ((Item.Create)((maskData.itemID)[1])):GetIcon()
    ;
    (self._maskLockEffectIcon1):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    hadNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((maskData.itemID)[1])
    if hadNum < (maskData.itemNum)[1] then
      (self._maskLockEffectText1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1622)).msgTextID, (maskData.itemNum)[1]))
      self._maskCanUnlock = false
    else
      ;
      (self._maskLockEffectText1):SetText((maskData.itemNum)[1])
    end
    if (maskData.itemID)[2] then
      (self._maskLockEffectBack2):SetActive(true)
      imageRecord = ((Item.Create)((maskData.itemID)[2])):GetIcon()
      ;
      (self._maskLockEffectIcon2):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      hadNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((maskData.itemID)[2])
      if hadNum < (maskData.itemNum)[2] then
        (self._maskLockEffectText2):SetText((TextManager.GetText)((CStringRes:GetRecorder(1622)).msgTextID, (maskData.itemNum)[2]))
        self._maskCanUnlock = false
      else
        ;
        (self._maskLockEffectText2):SetText((maskData.itemNum)[2])
      end
    else
      ;
      (self._maskLockEffectBack2):SetActive(false)
    end
    ;
    (self._maskLockBtnTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1610)).msgTextID))
  else
    do
      if maskData.isUnlock == 1 or maskData.isUnlock == 2 then
        (self._maskLockPanel):SetActive(false)
        ;
        (self._maskUnLockPanel):SetActive(true)
        if not CImagePathTable:GetRecorder(maskData.image) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._maskUnLockIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._maskUnLockText):SetText((TextManager.GetText)(maskData.descTextID))
        if maskData.isUnlock == 1 then
          (self._maskUnLockSwitchBtnText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1611)).msgTextID))
          ;
          (self._maskUnWorkBackOn):SetActive(false)
          ;
          (self._maskUnWorkBackOff):SetActive(true)
        else
          ;
          (self._maskUnLockSwitchBtnText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1612)).msgTextID))
          ;
          (self._maskUnWorkBackOn):SetActive(true)
          ;
          (self._maskUnWorkBackOff):SetActive(false)
        end
      else
        do
          ;
          (self._maskLockPanel):SetActive(false)
          ;
          (self._maskUnLockPanel):SetActive(false)
          LogError("ShowDialog:ShowOneMaskDetail()", "Mask State Error!")
        end
      end
    end
  end
end

ShowDialog.OnMaskLockEffectIcon1Clicked = function(self)
  -- function num : 0_16 , upvalues : _ENV, Item
  local maskData = (self._maskData)[self._selectedMaskIndex]
  local width, height = (self._maskLockEffectBack1):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)((maskData.itemID)[1])})
    tipsDialog:SetTipsPosition(width, height, (self._maskLockEffectBack1):GetLocalPointInUiRootPanel())
  end
end

ShowDialog.OnMaskLockEffectIcon2Clicked = function(self)
  -- function num : 0_17 , upvalues : _ENV, Item
  local maskData = (self._maskData)[self._selectedMaskIndex]
  local width, height = (self._maskLockEffectBack2):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)((maskData.itemID)[2])})
    tipsDialog:SetTipsPosition(width, height, (self._maskLockEffectBack2):GetLocalPointInUiRootPanel())
  end
end

return ShowDialog

