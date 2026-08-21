-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/puzzlerewardhelper.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local AwardStatusEnum = (require("logic.manager.experimental.datamanager.activity.dm_giftoftimepuzzle")).awardStatusEnum
local PuzzleRewardHelper = class("PuzzleRewardHelper")
PuzzleRewardHelper.Ctor = function(self, rootElement, indexNum)
  -- function num : 0_0 , upvalues : _ENV
  self._rootElement = rootElement
  self._indexNum = indexNum
  ;
  (self._rootElement):Subscribe_PointerClickEvent(self.OnRootClicked, self)
  self._rank = (self._rootElement):FindChild("CellBack/Rank")
  self._itemName = (self._rootElement):FindChild("CellBack/ItemName")
  self._itemIcon = (self._rootElement):FindChild("CellBack/Item")
  self._num = (self._rootElement):FindChild("CellBack/Price/Num")
  self._lock = (self._rootElement):FindChild("CellBack/Lock")
  self._get = (self._rootElement):FindChild("CellBack/GotGrey")
  self._txtAll = (self._rootElement):FindChild("CellBack/Lock/TxtAll")
  self._effect = (self._rootElement):FindChild("CellBack/Effect")
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  self:SetStaticRes()
end

PuzzleRewardHelper.SetStaticRes = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._txtAll then
    (self._txtAll):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1959))
  end
end

PuzzleRewardHelper.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

PuzzleRewardHelper.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, AwardStatusEnum, _ENV
  self._data = data
  self._item = (Item.Create)((self._data).itemID)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetPinJiImage()
  ;
  (self._rank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemName):SetText((self._item):GetName())
  ;
  (self._num):SetText((self._data).itemNum)
  if (self._data).status == AwardStatusEnum.Get then
    (self._lock):SetActive(false)
    ;
    (self._get):SetActive(true)
    ;
    (self._effect):SetActive(false)
  else
    if (self._data).status == AwardStatusEnum.Lock or (self._data).status == false then
      (self._lock):SetActive(true)
      ;
      (self._get):SetActive(false)
      ;
      (self._effect):SetActive(false)
    else
      if (self._data).status == AwardStatusEnum.UnlockButNotGet then
        (self._lock):SetActive(false)
        ;
        (self._get):SetActive(false)
        ;
        (self._effect):SetActive(true)
      else
        ;
        (self._lock):SetActive(true)
        ;
        (self._get):SetActive(false)
        ;
        (self._effect):SetActive(false)
        LogError("PuzzleRewardHelper:RefreshCell")
      end
    end
  end
end

PuzzleRewardHelper.OnRootClicked = function(self)
  -- function num : 0_4 , upvalues : AwardStatusEnum, _ENV
  if (self._data).status == AwardStatusEnum.UnlockButNotGet then
    (self._bm):SendCReceivedBpAward(self._indexNum)
  else
    local width, height = (self._itemIcon):GetRectSize()
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = self._item})
      tipsDialog:SetTipsPosition(width, height, (self._itemIcon):GetLocalPointInUiRootPanel())
    end
  end
end

return PuzzleRewardHelper

