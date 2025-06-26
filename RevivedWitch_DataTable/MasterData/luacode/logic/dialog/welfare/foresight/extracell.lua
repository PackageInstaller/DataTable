-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/foresight/extracell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local ExtraCell = class("ExtraCell", Dialog)
ExtraCell.AssetBundleName = "ui/layouts.welfare"
ExtraCell.AssetName = "ActivityForesightAwardCell"
ExtraCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ExtraCell
  ((ExtraCell.super).Ctor)(self, ...)
end

ExtraCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Cell/Title")
  self._goodIcon = self:GetChild("Cell/Item/Icon")
  ;
  (self._goodIcon):Subscribe_PointerClickEvent(self.OnGoodIconClicked, self)
  self._moneyIcon = self:GetChild("Cell/Money/Icon")
  self._moneyNum = self:GetChild("Cell/Money/Num")
  ;
  (self._moneyIcon):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._getMask = self:GetChild("Cell/Get")
  self._greyLock = self:GetChild("Cell/GreyLock")
  self._greyLockTxt = self:GetChild("Cell/GreyLock/Txt")
  self._redDot = self:GetChild("Cell/RedDot")
end

ExtraCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._refreshTimer then
    (ServerGameTimer.RemoveTask)(self._refreshTimer)
    self._refreshTimer = nil
  end
end

ExtraCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable, Item
  self._dm = (NekoData.DataManager).DM_Foresight
  self._bm = (NekoData.BehaviorManager).BM_Foresight
  self._data = data
  ;
  (self._title):SetText((TextManager.GetText)((self._data).goodName))
  if not CImagePathTable:GetRecorder((self._data).pictureId) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._goodIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._moneyItem = (Item.Create)((self._data).moneyType)
  imageRecord = (self._moneyItem):GetIcon()
  ;
  (self._moneyIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._moneyNum):SetText((NumberManager.GetShowNumber)((self._data).price))
  ;
  (self._getMask):SetActive((self._data).isGet)
  ;
  (self._greyLock):SetActive(not (self._data).isUnlock)
  if self._refreshTimer then
    (ServerGameTimer.RemoveTask)(self._refreshTimer)
    self._refreshTimer = nil
  end
  if not (self._data).isUnlock then
    self._refreshTimer = (ServerGameTimer.AddTask)(0, 60, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    local timeAppendIndex = ((self._data).dayIndex - (self._bm):GetUnlockedDay() - 1) * 24 * 60 * 60 * 1000
    local leftTime = (self._bm):GetCurLeftTime() + timeAppendIndex
    if leftTime > 0 then
      (self._greyLockTxt):SetText((self._bm):GetRemainTimeStr(leftTime))
    else
      if self._refreshTimer then
        (ServerGameTimer.RemoveTask)(self._refreshTimer)
        self._refreshTimer = nil
      end
    end
  end
)
  end
  if (self._data).isUnlock then
    (self._redDot):SetActive(not (self._data).isGet)
  end
end

ExtraCell.OnItemCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._data).isUnlock then
    local width, height = (self._moneyIcon):GetRectSize()
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = self._moneyItem})
      tipsDialog:SetTipsPosition(width, height, (self._moneyIcon):GetLocalPointInUiRootPanel())
    end
  end
end

ExtraCell.OnGoodIconClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self._data).isUnlock and not (self._data).isGet then
    local dialog = (DialogManager.CreateSingletonDialog)("welfare.foresight.itembuydialog")
    if dialog then
      dialog:SetData(self._data)
    end
  end
end

return ExtraCell

