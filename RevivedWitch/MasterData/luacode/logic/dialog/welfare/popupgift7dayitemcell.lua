-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/popupgift7dayitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CSkinItem = (BeanManager.GetTableByName)("item.cskinitem")
local PopUpGift7DayItemCell = class("PopUpGift7DayItemCell", Dialog)
PopUpGift7DayItemCell.AssetBundleName = "ui/layouts.welfare"
PopUpGift7DayItemCell.AssetName = "Promotions7DaysItem"
PopUpGift7DayItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PopUpGift7DayItemCell
  ((PopUpGift7DayItemCell.super).Ctor)(self, ...)
end

PopUpGift7DayItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("Item/ItemCell/_BackGround/Frame")
  self._img = self:GetChild("Item/ItemCell/_BackGround/Icon")
  self._num = self:GetChild("Item/ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

PopUpGift7DayItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

PopUpGift7DayItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local imageRecord = (data.item):GetIcon()
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._num):SetText(data.num)
  local pinjiRecord = (data.item):GetPinJiImage()
  ;
  (self._frame):SetSprite(pinjiRecord.assetBundle, pinjiRecord.assetName)
end

PopUpGift7DayItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : CRoleItem, _ENV, CSkinItem
  local itemType = ((self._cellData).item):GetItemTypeId()
  local itemId = ((self._cellData).item):GetID()
  if itemType == 27 then
    local cfg = CRoleItem:GetRecorder(itemId)
    local dlg = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
    dlg:Init({
roleIdList = {cfg.roleid}
, 
cfgIdList = {2}
, index = 1}, 3)
  else
    do
      if itemType == 91 then
        local cfg = CSkinItem:GetRecorder(itemId)
        local dlg = (DialogManager.CreateSingletonDialog)("shop.fashionbuydialog")
        local data = {}
        ;
        (table.insert)(data, {itemId = cfg.Skinid})
        dlg:SetData((dlg.TargetType).OnlyShow, data)
      else
        do
          if itemType == 299 then
            local dialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
            if dialog then
              dialog:Init(itemId)
              dialog:SetTipsParmFunc(function()
    -- function num : 0_4_0 , upvalues : self
    local width, height = (self._rootWindow):GetRectSize()
    local pos = (self._rootWindow):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
            end
          else
            do
              local width, height = (self._rootWindow):GetRectSize()
              local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
              if tipsDialog then
                tipsDialog:Init({item = (self._cellData).item})
                tipsDialog:SetTipsPosition(width, height, (self._rootWindow):GetLocalPointInUiRootPanel())
              end
            end
          end
        end
      end
    end
  end
end

return PopUpGift7DayItemCell

