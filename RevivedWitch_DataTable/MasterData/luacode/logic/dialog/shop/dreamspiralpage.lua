-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/dreamspiralpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local UnlockCfg = (BeanManager.GetTableByName)("recharge.cseasonpassunlock")
local CRole = (BeanManager.GetTableByName)("item.croleitem")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Collection = (LuaNetManager.CreateBean)("protocol.activity.collection")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local DreamSpiralPage = class("DreamSpiralPage", Dialog)
DreamSpiralPage.AssetBundleName = "ui/layouts.baseshop"
DreamSpiralPage.AssetName = "BattlePass"
DreamSpiralPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DreamSpiralPage, _ENV
  ((DreamSpiralPage.super).Ctor)(self, ...)
  self._timerId = 0
  self._shopMoneyTypeInfo = {DataCommon.DiamodID, DataCommon.AgCoinID}
end

DreamSpiralPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, TableFrame, _ENV
  self._back2 = self:GetChild("Back2")
  self._nameImage = self:GetChild("Show/NameImage")
  self._level = self:GetChild("Level/LevelBack/LVNum")
  self._curNum = self:GetChild("Level/Num/Num")
  self._maxNum = self:GetChild("Level/Num/NumMax")
  self._progress = self:GetChild("Level/Loading/BackGround/Progress")
  self._detailBtn = self:GetChild("Level/DetailBtn")
  self._buyBtn = self:GetChild("Level/BuyBtn")
  self._photo = self:GetChild("Show/Mask/Photo")
  self._rank = self:GetChild("Show/Rank")
  self._name = self:GetChild("Show/Name")
  self._lockTxt = self:GetChild("Show/LockTxt")
  self._leftTime = self:GetChild("Show/Time/Txt2")
  self._normalAward = {quality = self:GetChild("Normal/Back"), image = self:GetChild("Normal/Image"), name = self:GetChild("Normal/Text")}
  self._advanceAwardLock = self:GetChild("Advance/Lock")
  self._unlockBtn = self:GetChild("UnLockBtn")
  self._boughtBtn = self:GetChild("Buy")
  self._cellArea = self:GetChild("CellFrame")
  self._cellFrame = (GridFrame.Create)(self._cellArea, self, false, 1)
  self._topGroup = self:GetChild("TopGroup")
  self._topGroupFrame = (TableFrame.Create)(self._topGroup, self, false, false, true)
  ;
  (self._unlockBtn):Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  ;
  (self._detailBtn):Subscribe_PointerClickEvent(self.OnDetailBtnClicked, self)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyAgcoinLevelBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTopGroundFrame, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTabCell, Common.n_DreamSpiralRefresh, nil)
end

DreamSpiralPage.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cellFrame):Destroy()
  ;
  (self._topGroupFrame):Destroy()
  if self._timerId ~= 0 then
    (GameTimer.RemoveTask)(self._timerId)
    self._timerId = 0
  end
end

local format_str = function(id, value)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  local s = (TextManager.GetText)((CStringRes:GetRecorder(id)).msgTextID)
  return (string.gsub)(s, "%$parameter1%$", value)
end

DreamSpiralPage.UpdateLeftTime = function(self)
  -- function num : 0_4 , upvalues : _ENV, format_str
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (self._info).leftTime = (self._info).leftTime - 1
  if (self._info).leftTime < 0 then
    (GameTimer.RemoveTask)(self._timerId)
    self._timerId = 0
    return 
  end
  local time = (self._info).leftTime
  local day = time // 86400
  local hour = time // 3600
  local min = time // 60
  local str = ""
  if day >= 1 then
    str = format_str(1508, day)
  else
    if hour >= 1 then
      str = format_str(1509, hour)
    else
      str = format_str(1510, min)
    end
  end
  ;
  (self._leftTime):SetText(str)
end

DreamSpiralPage.RefreshTabCell = function(self, info)
  -- function num : 0_5 , upvalues : _ENV, GuidTypes, UnlockCfg, CRole, Role, CImagePathTable, CStringRes, Collection
  local tag = ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuidTypes.AG_COIN)
  if tag and tag == 0 then
    ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuidTypes.AG_COIN, 1)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, nil, nil)
  end
  do
    if info and info.userInfo and info.userInfo == "close" then
      local dialog = (DialogManager.GetDialog)("welfare.welfaremaindialog")
      if dialog then
        dialog:SetData(true, true, true)
      else
        LogError("DreamSpiralPage", "Cannot find welfaremaindialog!")
      end
      return 
    end
    local mgr = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
    self._info = mgr:GetBaseInfo()
    self._data = mgr:GetColltion()
    self._max = #self._data
    local curLv = (self._info).dreamLevel
    ;
    (self._level):SetText(curLv)
    self:UpdateLeftTime()
    if self._timerId ~= 0 then
      (GameTimer.RemoveTask)(self._timerId)
      self._timerId = 0
    end
    self._timerId = (GameTimer.AddTask)(1, 1, self.UpdateLeftTime, self)
    local unlockCfg = UnlockCfg:GetRecorder((self._info).actId)
    local itemId = unlockCfg.ItemID
    local roleCfg = CRole:GetRecorder(itemId)
    local role = (Role.Create)(roleCfg.roleid)
    ;
    (self._name):SetText(role:GetRoleName())
    local rarity = role:GetRarityImageRecord()
    ;
    (self._rank):SetSprite(rarity.assetBundle, rarity.assetName)
    if not CImagePathTable:GetRecorder(unlockCfg.backImageID) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._back2):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if not CImagePathTable:GetRecorder(unlockCfg.nameImageID) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._nameImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    str = (TextManager.GetText)((CStringRes:GetRecorder(1332)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", unlockCfg.unlockLevel)
    ;
    (self._lockTxt):SetText(str)
    local chipInfo = (self._info).chipInfo
    if chipInfo then
      (self._curNum):SetText(chipInfo.has)
      ;
      (self._maxNum):SetText(chipInfo.max)
      self._diffNum = chipInfo.max - chipInfo.has
      ;
      (self._progress):SetFillAmount(chipInfo.has / chipInfo.max)
    else
      LogWarning("nil chipinfo")
    end
    local hasUnlock = (self._info).highUnlocked ~= 0
    ;
    (self._advanceAwardLock):SetActive(not hasUnlock)
    ;
    (self._boughtBtn):SetActive(hasUnlock)
    ;
    (self._unlockBtn):SetActive(not hasUnlock)
    local moveToIdx = 0
    for k,v in ipairs(self._data) do
      if (v.common).state == Collection.UN_RECEIVE or (v.high).state == Collection.UN_RECEIVE then
        moveToIdx = k
        break
      end
    end
    if moveToIdx == 0 then
      for k,v in ipairs(self._data) do
        if (v.common).state == Collection.LOCK or (v.high).state == Collection.LOCK then
          moveToIdx = k
          break
        end
      end
    end
    ;
    (self._cellFrame):ReloadAllCell()
    ;
    (self._cellFrame):MoveLeftToIndex(moveToIdx)
    self:RefreshTopGroundFrame()
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
  end
end

DreamSpiralPage.RefreshTopGroundFrame = function(self)
  -- function num : 0_6
  (self._topGroupFrame):ReloadAllCell()
end

DreamSpiralPage.NumberOfCell = function(self, frame)
  -- function num : 0_7
  if frame == self._cellFrame then
    return #self._data
  else
    return #self._shopMoneyTypeInfo
  end
end

DreamSpiralPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._cellFrame then
    if index == #self._data then
      return "shop.dreamspiralmaxcell"
    else
      return "shop.dreamspiralcell"
    end
  else
    return "shop.shoptopgroupcell"
  end
end

DreamSpiralPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._cellFrame then
    return (self._data)[index]
  else
    return {moneyType = (self._shopMoneyTypeInfo)[index]}
  end
end

DreamSpiralPage.OnDetailBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("task.taskmaindialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("task.taskmaindialog")
  end
  local dlg = (DialogManager.CreateSingletonDialog)("task.taskmaindialog")
  if dlg then
    dlg:ToPage(5)
  end
end

DreamSpiralPage.OnUnlockBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("shop.dreamspiralunlockdialog")):Refresh(((self._info).chargeInfo).chargeMoneyType)
end

DreamSpiralPage.OnBuyAgcoinLevelBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV, CStringRes, Item
  local levelPrice = ((self._info).chargeInfo).levelPrice
  local itemID = ((self._info).chargeInfo).chargeMoneyType
  local showText = (string.gsub)((TextManager.GetText)((CStringRes:GetRecorder(1472)).msgTextID), "%$parameter1%$", self._diffNum)
  local moneyItem = (Item.Create)(itemID)
  local dialog = (DialogManager.CreateSingletonDialog)("shop.dreamspiralsecondconfirm")
  dialog:SetData(showText, moneyItem, levelPrice)
end

return DreamSpiralPage

