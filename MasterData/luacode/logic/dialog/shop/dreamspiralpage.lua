local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local UnlockCfg = BeanManager.GetTableByName("recharge.cseasonpassunlock")
local CRole = BeanManager.GetTableByName("item.croleitem")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Collection = LuaNetManager.CreateBean("protocol.activity.collection")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local DreamSpiralPage = class("DreamSpiralPage", Dialog)
DreamSpiralPage.AssetBundleName = "ui/layouts.baseshop"
DreamSpiralPage.AssetName = "BattlePass"

function DreamSpiralPage:Ctor(...)
  DreamSpiralPage.super.Ctor(self, ...)
  self._timerId = 0
  self._shopMoneyTypeInfo = {
    DataCommon.DiamodID,
    DataCommon.AgCoinID
  }
end

function DreamSpiralPage:OnCreate()
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
  self._normalAward = {
    quality = self:GetChild("Normal/Back"),
    image = self:GetChild("Normal/Image"),
    name = self:GetChild("Normal/Text")
  }
  self._advanceAwardLock = self:GetChild("Advance/Lock")
  self._unlockBtn = self:GetChild("UnLockBtn")
  self._boughtBtn = self:GetChild("Buy")
  self._cellArea = self:GetChild("CellFrame")
  self._cellFrame = GridFrame.Create(self._cellArea, self, false, 1)
  self._topGroup = self:GetChild("TopGroup")
  self._topGroupFrame = TableFrame.Create(self._topGroup, self, false, false, true)
  self._unlockBtn:Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  self._detailBtn:Subscribe_PointerClickEvent(self.OnDetailBtnClicked, self)
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyAgcoinLevelBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshTopGroundFrame, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTabCell, Common.n_DreamSpiralRefresh, nil)
end

function DreamSpiralPage:OnDestroy()
  self._cellFrame:Destroy()
  self._topGroupFrame:Destroy()
  if self._timerId ~= 0 then
    GameTimer.RemoveTask(self._timerId)
    self._timerId = 0
  end
end

local function format_str(id, value)
  local s = TextManager.GetText(CStringRes:GetRecorder(id).msgTextID)
  return string.gsub(s, "%$parameter1%$", value)
end

function DreamSpiralPage:UpdateLeftTime()
  self._info.leftTime = self._info.leftTime - 1
  if self._info.leftTime < 0 then
    GameTimer.RemoveTask(self._timerId)
    self._timerId = 0
    return
  end
  local time = self._info.leftTime
  local day = time // 86400
  local hour = time // 3600
  local min = time // 60
  local str = ""
  if 1 <= day then
    str = format_str(1508, day)
  elseif 1 <= hour then
    str = format_str(1509, hour)
  else
    str = format_str(1510, min)
  end
  self._leftTime:SetText(str)
end

function DreamSpiralPage:RefreshTabCell(info)
  local tag = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.AG_COIN)
  if tag and tag == 0 then
    NekoData.BehaviorManager.BM_Game:SetGuideTag(GuidTypes.AG_COIN, 1)
    LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, nil, nil)
  end
  if info and info.userInfo and info.userInfo == "close" then
    local dialog = DialogManager.GetDialog("welfare.welfaremaindialog")
    if dialog then
      dialog:SetData(true, true, true)
    else
      LogError("DreamSpiralPage", "Cannot find welfaremaindialog!")
    end
    return
  end
  local mgr = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  self._info = mgr:GetBaseInfo()
  self._data = mgr:GetColltion()
  self._max = #self._data
  local curLv = self._info.dreamLevel
  self._level:SetText(curLv)
  self:UpdateLeftTime()
  if self._timerId ~= 0 then
    GameTimer.RemoveTask(self._timerId)
    self._timerId = 0
  end
  self._timerId = GameTimer.AddTask(1, 1, self.UpdateLeftTime, self)
  local unlockCfg = UnlockCfg:GetRecorder(self._info.actId)
  local itemId = unlockCfg.ItemID
  local roleCfg = CRole:GetRecorder(itemId)
  local role = Role.Create(roleCfg.roleid)
  self._name:SetText(role:GetRoleName())
  local rarity = role:GetRarityImageRecord()
  self._rank:SetSprite(rarity.assetBundle, rarity.assetName)
  local imageRecord = CImagePathTable:GetRecorder(unlockCfg.backImageID) or DataCommon.DefaultImageAsset
  self._back2:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = CImagePathTable:GetRecorder(unlockCfg.nameImageID) or DataCommon.DefaultImageAsset
  self._nameImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  str = TextManager.GetText(CStringRes:GetRecorder(1332).msgTextID)
  str = string.gsub(str, "%$parameter1%$", unlockCfg.unlockLevel)
  self._lockTxt:SetText(str)
  local chipInfo = self._info.chipInfo
  if chipInfo then
    self._curNum:SetText(chipInfo.has)
    self._maxNum:SetText(chipInfo.max)
    self._diffNum = chipInfo.max - chipInfo.has
    self._progress:SetFillAmount(chipInfo.has / chipInfo.max)
  else
    LogWarning("nil chipinfo")
  end
  local hasUnlock = self._info.highUnlocked ~= 0
  self._advanceAwardLock:SetActive(not hasUnlock)
  self._boughtBtn:SetActive(hasUnlock)
  self._unlockBtn:SetActive(not hasUnlock)
  local moveToIdx = 0
  for k, v in ipairs(self._data) do
    if v.common.state == Collection.UN_RECEIVE or v.high.state == Collection.UN_RECEIVE then
      moveToIdx = k
      break
    end
  end
  if moveToIdx == 0 then
    for k, v in ipairs(self._data) do
      if v.common.state == Collection.LOCK or v.high.state == Collection.LOCK then
        moveToIdx = k
        break
      end
    end
  end
  self._cellFrame:ReloadAllCell()
  self._cellFrame:MoveLeftToIndex(moveToIdx)
  self:RefreshTopGroundFrame()
end

function DreamSpiralPage:RefreshTopGroundFrame()
  self._topGroupFrame:ReloadAllCell()
end

function DreamSpiralPage:NumberOfCell(frame)
  if frame == self._cellFrame then
    return #self._data
  else
    return #self._shopMoneyTypeInfo
  end
end

function DreamSpiralPage:CellAtIndex(frame, index)
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

function DreamSpiralPage:DataAtIndex(frame, index)
  if frame == self._cellFrame then
    return self._data[index]
  else
    return {
      moneyType = self._shopMoneyTypeInfo[index]
    }
  end
end

function DreamSpiralPage:OnDetailBtnClicked()
  local dialog = DialogManager.GetDialog("task.taskmaindialog")
  if dialog then
    DialogManager.DestroySingletonDialog("task.taskmaindialog")
  end
  local dlg = DialogManager.CreateSingletonDialog("task.taskmaindialog")
  if dlg then
    dlg:ToPage(5)
  end
end

function DreamSpiralPage:OnUnlockBtnClicked()
  DialogManager.CreateSingletonDialog("shop.dreamspiralunlockdialog"):Refresh(self._info.chargeInfo.chargeMoneyType)
end

function DreamSpiralPage:OnBuyAgcoinLevelBtnClicked()
  local levelPrice = self._info.chargeInfo.levelPrice
  local itemID = self._info.chargeInfo.chargeMoneyType
  local showText = string.gsub(TextManager.GetText(CStringRes:GetRecorder(1472).msgTextID), "%$parameter1%$", self._diffNum)
  local moneyItem = Item.Create(itemID)
  local dialog = DialogManager.CreateSingletonDialog("shop.dreamspiralsecondconfirm")
  dialog:SetData(showText, moneyItem, levelPrice)
end

return DreamSpiralPage
