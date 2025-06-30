-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/givegiftitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFavourPresentType = (BeanManager.GetTableByName)("role.cfavourpresenttype")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local GiveGiftItemCell = class("GiveGiftItemCell", Dialog)
GiveGiftItemCell.AssetBundleName = "ui/layouts.tujian"
GiveGiftItemCell.AssetName = "FavourGiveItemCell"
GiveGiftItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GiveGiftItemCell
  ((GiveGiftItemCell.super).Ctor)(self, ...)
end

GiveGiftItemCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self._hearts = {}
  for i = 1, 3 do
    (table.insert)(self._hearts, self:GetChild("Heart" .. i))
  end
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

GiveGiftItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

GiveGiftItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CFavourPresentType, CImagePathTable, _ENV
  self._data = data.data
  self._index = data.index
  local imageRecord = (self._data):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local favourPresentTypeRecord = CFavourPresentType:GetRecorder((self._data):GetID())
  if favourPresentTypeRecord.presenttype == (self._delegate)._favourGiftType then
    if not CImagePathTable:GetRecorder(12429) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    local heartEffectNum = favourPresentTypeRecord.presentuplevel
    for i,v in ipairs(self._hearts) do
      v:SetActive(i <= heartEffectNum)
    end
  else
    imageRecord = (self._data):GetPinJiImage()
    for _,v in ipairs(self._hearts) do
      v:SetActive(false)
    end
  end
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._count):SetText((NumberManager.GetShowNumber)(((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById((self._data):GetID())))
  ;
  (self._select):SetActive(((self._delegate)._selectItem):GetID() == (self._data):GetID())
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

GiveGiftItemCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):SetSelectItem(self._data, self._index)
end

GiveGiftItemCell.OnEvent = function(self, eventName, args)
  -- function num : 0_5
  if args ~= (self._data):GetID() then
    (self._select):SetActive(eventName ~= "SetSelectItem")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return GiveGiftItemCell

