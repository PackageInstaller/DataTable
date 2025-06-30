-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/signactivitytemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local SignActivityItemCell = class("SignActivityItemCell", Dialog)
SignActivityItemCell.AssetBundleName = "ui/layouts.welfare"
SignActivityItemCell.AssetName = "SignActivityDayCell"
SignActivityItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SignActivityItemCell
  ((SignActivityItemCell.super).Ctor)(self, ...)
  self._effect_handler = nil
end

SignActivityItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._select = self:GetChild("Cell/Select")
  self._dayText = self:GetChild("Cell/Day")
  self._icon = self:GetChild("Cell/Icon")
  self._num = self:GetChild("Cell/Num")
  self._grey = self:GetChild("Cell/Grey")
  self._get = self:GetChild("Cell/Get")
  self._rank = self:GetChild("Cell/Rank")
  self._effect = self:GetChild("Cell/Effect")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

SignActivityItemCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._effect_handler then
    (self._effect):ReleaseEffect(self._effect_handler)
    self._effect_handler = nil
  end
end

local SetNodeActive = function(self, get, select, grey)
  -- function num : 0_3
  (self._get):SetActive(get)
  ;
  (self._select):SetActive(select)
  ;
  (self._grey):SetActive(grey)
end

SignActivityItemCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, SetNodeActive, Item
  if self._effect_handler then
    (self._effect):ReleaseEffect(self._effect_handler)
    self._effect_handler = nil
  end
  ;
  (self._dayText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1062, {data.index}))
  if data.receive then
    SetNodeActive(self, true, false, false)
  else
    if data.index <= (self._delegate)._totalSignTimes then
      SetNodeActive(self, false, true, false)
      self._effect_handler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1057))
    else
      SetNodeActive(self, false, false, false)
    end
  end
  local item = (Item.Create)(data.itemId)
  local imgRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._num):SetText(data.itemNum)
  imgRecord = item:GetShopPinJiBackGroundImage()
  ;
  (self._rank):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
end

SignActivityItemCell.OnCellClick = function(self)
  -- function num : 0_5 , upvalues : _ENV, Item
  if not (self._cellData).receive and (self._cellData).index <= (self._delegate)._totalSignTimes then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceiveaward")
    protocol.actId = (self._delegate)._activityId
    protocol.index = (self._cellData).index
    protocol:Send()
  else
    do
      local width, height = (self:GetRootWindow()):GetRectSize()
      local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
      if dialog then
        dialog:Init({item = (Item.Create)((self._cellData).itemId)})
        dialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
      end
    end
  end
end

return SignActivityItemCell

