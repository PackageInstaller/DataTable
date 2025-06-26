-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/foresight/commoncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local CommonCell = class("CommonCell", Dialog)
CommonCell.AssetBundleName = "ui/layouts.welfare"
CommonCell.AssetName = "ActivityForesightDayCell"
CommonCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CommonCell
  ((CommonCell.super).Ctor)(self, ...)
end

CommonCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Cell/Title")
  self._itemRank = self:GetChild("Cell/Item/Rank")
  self._itemIcon = self:GetChild("Cell/Item/Icon")
  self._itemNum = self:GetChild("Cell/Item/Num")
  ;
  (self._itemIcon):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._getMask = self:GetChild("Cell/Get")
  self._greyLock = self:GetChild("Cell/GreyLock")
  self._greyLockTxt = self:GetChild("Cell/GreyLock/Txt")
  self._playBtn = self:GetChild("Cell/PlayBtn")
  ;
  (self._playBtn):Subscribe_PointerClickEvent(self.OnPlayBtnClicked, self)
  self._redDot = self:GetChild("Cell/PlayBtn/RedDot")
end

CommonCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._refreshTimer then
    (ServerGameTimer.RemoveTask)(self._refreshTimer)
    self._refreshTimer = nil
  end
end

CommonCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item, CStringres
  self._dm = (NekoData.DataManager).DM_Foresight
  self._bm = (NekoData.BehaviorManager).BM_Foresight
  self._data = data
  ;
  (self._title):SetText((TextManager.GetText)((self._data).cellTitle))
  self._item = (Item.Create)((self._data).itemId)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetShopPinJiBackGroundImage()
  ;
  (self._itemRank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemNum):SetText((TextManager.GetText)((CStringres:GetRecorder(1873)).msgTextID, (NumberManager.GetShowNumber)((self._data).itemNum)))
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

CommonCell.OnItemCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._data).isUnlock then
    local width, height = (self._itemIcon):GetRectSize()
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = self._item})
      tipsDialog:SetTipsPosition(width, height, (self._itemIcon):GetLocalPointInUiRootPanel())
    end
  end
end

CommonCell.OnPlayBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self._data).isUnlock then
    if not (self._data).isGet then
      (self._bm):SendCReceiveForesightAct((self._data).dayIndex)
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._delegate)._chatId = (self._data).chatId
    else
      local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
      if dialog then
        dialog:SetDialogLibraryId((self._data).chatId, false, (dialog.DialogType).Foresight)
      end
    end
  end
end

return CommonCell

