-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/growgiftcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local GrowGiftCell = class("GrowGiftCell", Dialog)
GrowGiftCell.AssetBundleName = "ui/layouts.welfare"
GrowGiftCell.AssetName = "GrowGiftCell"
GrowGiftCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GrowGiftCell
  ((GrowGiftCell.super).Ctor)(self, ...)
end

GrowGiftCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Panel/Item")
  self._lock = self:GetChild("Panel/Lock")
  self._getPanel = self:GetChild("Panel/GetBack")
  self._getPanel_btn = self:GetChild("Panel/GetBack/GetBtn")
  self._levelLimitTxt = self:GetChild("Panel/Text1")
  self._received = self:GetChild("Panel/Grey")
  self._numTxt = self:GetChild("Panel/Num/Num")
  ;
  (self._icon):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self._getPanel_btn):Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

GrowGiftCell.OnDestroy = function(self)
  -- function num : 0_2
end

GrowGiftCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  self._item = (Item.Create)(((data.record).itemID)[1])
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._numTxt):SetText(((data.record).ItemNum)[1])
  if data.status == ((self._delegate).cellStatus).Lock then
    (self._lock):SetActive(true)
    ;
    (self._getPanel):SetActive(true)
    ;
    (self._getPanel_btn):SetInteractable(false)
    ;
    (self._received):SetActive(false)
  else
    if data.status == ((self._delegate).cellStatus).CanNotReceive then
      (self._lock):SetActive(false)
      ;
      (self._getPanel):SetActive(true)
      ;
      (self._getPanel_btn):SetInteractable(false)
      ;
      (self._received):SetActive(false)
    else
      if data.status == ((self._delegate).cellStatus).Available then
        (self._lock):SetActive(false)
        ;
        (self._getPanel):SetActive(true)
        ;
        (self._getPanel_btn):SetInteractable(true)
        ;
        (self._received):SetActive(false)
      else
        if data.status == ((self._delegate).cellStatus).Received then
          (self._lock):SetActive(false)
          ;
          (self._getPanel):SetActive(false)
          ;
          (self._received):SetActive(true)
        end
      end
    end
  end
  ;
  (self._levelLimitTxt):SetText((data.record).level)
end

GrowGiftCell.OnGetBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.creceivelevelupreward")
  if protocol then
    protocol.id = ((self._cellData).record).id
    protocol:Send()
  end
end

GrowGiftCell.OnCellClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return GrowGiftCell

