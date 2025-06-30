-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/indefinitedaysignactivity/indefinitedayssigncellhelper.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local IndefiniteDaysSignCellHelper = class("IndefiniteDaysSignCellHelper")
local dayImageRecordTable = {[1] = CImagePathTable:GetRecorder(14834), [2] = CImagePathTable:GetRecorder(14835), [3] = CImagePathTable:GetRecorder(14836), [4] = CImagePathTable:GetRecorder(14837), [5] = CImagePathTable:GetRecorder(14838), [6] = CImagePathTable:GetRecorder(14839), [7] = CImagePathTable:GetRecorder(14840), [8] = CImagePathTable:GetRecorder(14841), [9] = CImagePathTable:GetRecorder(14842), [10] = CImagePathTable:GetRecorder(13862), [11] = CImagePathTable:GetRecorder(14843), [12] = CImagePathTable:GetRecorder(14844), [13] = CImagePathTable:GetRecorder(14845), [14] = CImagePathTable:GetRecorder(14846)}
IndefiniteDaysSignCellHelper.Ctor = function(self, rootElement)
  -- function num : 0_0
  self._effectHandler = nil
  self._rootElement = rootElement
  self._back1 = (self._rootElement):FindChild("Back1")
  self._grey = (self._rootElement):FindChild("Grey")
  self._select = (self._rootElement):FindChild("Select")
  self._dayDescriImage = (self._rootElement):FindChild("Day/Day")
  self._dayImage = (self._rootElement):FindChild("Day/Image")
  self._rank = (self._rootElement):FindChild("Rank")
  self._icon = (self._rootElement):FindChild("Icon")
  self._icongrey = (self._rootElement):FindChild("IconGrey")
  self._num = (self._rootElement):FindChild("Num")
  self._checkmark = (self._rootElement):FindChild("CheckMark")
  self._effect = (self._rootElement):FindChild("Effect")
  ;
  (self._effect):Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
  ;
  (self._rootElement):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

IndefiniteDaysSignCellHelper.OnDestroy = function(self)
  -- function num : 0_1
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
end

IndefiniteDaysSignCellHelper.RefreshCell = function(self, delegate, data)
  -- function num : 0_2 , upvalues : _ENV, CImagePathTable, dayImageRecordTable, Item
  self._delegate = delegate
  self._data = data
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  local backImageID = tonumber(((self._data).extraCfg)[1])
  if not CImagePathTable:GetRecorder(backImageID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._back1):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if not dayImageRecordTable[(self._data).index] then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._dayImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local dayDescriID = ((self._data).extraCfg)[3]
  if dayDescriID then
    if not CImagePathTable:GetRecorder(tonumber(((self._data).extraCfg)[3])) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._dayDescriImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  if (self._data).receive then
    self:SetNodeActive(true, false, true)
  else
    if (self._data).index <= (self._delegate)._totalSignTimes then
      self:SetNodeActive(false, true, false)
    else
      self:SetNodeActive(false, false, false)
    end
  end
  local item = (Item.Create)((self._data).itemId)
  imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._icongrey):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1475, {(NumberManager.GetShowNumber)((self._data).itemNum)}))
  imageRecord = item:GetShopPinJiBackGroundImage()
  ;
  (self._rank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

IndefiniteDaysSignCellHelper.SetNodeActive = function(self, get, select, grey)
  -- function num : 0_3
  (self._select):SetActive(select)
  ;
  (self._grey):SetActive(grey)
  ;
  (self._icon):SetActive(not get)
  ;
  (self._icongrey):SetActive(grey)
  ;
  (self._checkmark):SetActive(grey)
end

IndefiniteDaysSignCellHelper.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, Item
  local width, height = (self._rootElement):GetRectSize()
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = (Item.Create)((self._data).itemId)})
    dialog:SetTipsPosition(width, height, (self._rootElement):GetLocalPointInUiRootPanel())
  end
end

IndefiniteDaysSignCellHelper.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : _ENV
  if eventName == "ReceiveEffect" and not (self._data).receive and (self._data).index <= (self._delegate)._totalSignTimes then
    if self._effectHandler then
      (self._effect):ReleaseEffect(self._effectHandler)
      self._effectHandler = nil
    end
    self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1137))
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._delegate)._effectList)[(self._data).index] = self._effectHandler
  end
end

IndefiniteDaysSignCellHelper.OnEffectEnd = function(self)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self._delegate)._effectList)[(self._data).index] = nil
  ;
  (self._delegate):OnEffectEnd((self._data).index)
end

return IndefiniteDaysSignCellHelper

