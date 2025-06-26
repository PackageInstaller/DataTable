-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/halloween/halloweenrewardcell1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local HalloweenRewardCell1 = class("HalloweenRewardCell1", Dialog)
HalloweenRewardCell1.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenRewardCell1.AssetName = "ActivityHalloweenRewardCellItem"
HalloweenRewardCell1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HalloweenRewardCell1
  ((HalloweenRewardCell1.super).Ctor)(self, ...)
end

HalloweenRewardCell1.OnCreate = function(self)
  -- function num : 0_1
  self._numBack1 = self:GetChild("NumBack1")
  self._numBack2 = self:GetChild("NumBack2")
  self._getBack1 = self:GetChild("GetBack1")
  self._getBack2 = self:GetChild("GetBack2")
  self._itemCell = self:GetChild("Panel/ItemCell")
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemMask = self:GetChild("Panel/ItemCell/_BackGround/Mask")
  self._itemCount = self:GetChild("Panel/ItemCell/_Count")
  self._payNum = self:GetChild("NumPay")
  self._payIcon = self:GetChild("Icon")
  self._idShow = self:GetChild("Num")
  self._lineLight = self:GetChild("Line")
  self._lineDark = self:GetChild("LinebBack")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

HalloweenRewardCell1.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : Item, _ENV
  self._data = data
  local item = (Item.Create)(((self._data).rewarditem)[1])
  ;
  (self._itemCount):SetText((NumberManager.GetShowNumber)(((self._data).rewardquantity)[1]))
  ;
  (self._itemIcon):SetSprite((item:GetIcon()).assetBundle, (item:GetIcon()).assetName)
  ;
  (self._itemFrame):SetSprite((item:GetPinJiImage()).assetBundle, (item:GetPinJiImage()).assetName)
  ;
  (self._itemMask):SetActive((not (self._data).canGet and not (self._data).isGet))
  ;
  (self._getBack1):SetActive((self._data).isGet)
  ;
  (self._getBack2):SetActive((self._data).canGet)
  ;
  (self._numBack1):SetActive((not (self._data).canGet and not (self._data).isGet))
  if not (self._data).canGet then
    (self._numBack2):SetActive((self._data).isGet)
    if not (self._data).canGet then
      (self._lineLight):SetActive((self._data).isGet)
      ;
      (self._lineDark):SetActive((not (self._data).canGet and not (self._data).isGet))
      item = (Item.Create)(DataCommon.Pumpkin)
      ;
      (self._payIcon):SetSprite((item:GetIcon()).assetBundle, (item:GetIcon()).assetName)
      ;
      (self._payNum):SetText((self._data).neednum)
      ;
      (self._idShow):SetText((self._data).id)
      -- DECOMPILER ERROR: 8 unprocessed JMP targets
    end
  end
end

HalloweenRewardCell1.OnItemCellClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if (self._data).canGet and not (self._data).isGet then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgethalloweenreward")
    if protocol then
      protocol.rewardId = (self._data).id
      protocol:Send()
    end
  end
end

return HalloweenRewardCell1

