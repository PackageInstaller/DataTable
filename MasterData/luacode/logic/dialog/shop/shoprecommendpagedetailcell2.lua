local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local CFirstRechargeReward = BeanManager.GetTableByName("welfare.cfirstrechargereward")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local Item = require("logic.manager.experimental.types.item")
local ShopRecommendPageDetailCell2 = class("ShopRecommendPageDetailCell2", Dialog)
ShopRecommendPageDetailCell2.AssetBundleName = "ui/layouts.baseshop"
ShopRecommendPageDetailCell2.AssetName = "RecommendShopPage2"
local ItemIdType = {Role = 27, Equip = 299}

function ShopRecommendPageDetailCell2:Ctor(...)
  ShopRecommendPageDetailCell2.super.Ctor(self, ...)
end

function ShopRecommendPageDetailCell2:OnCreate()
  self._animationPanel = self:GetChild("BackImage")
  self._model = self:GetChild("BackImage/Up/Model")
  self._model:Subscribe_PointerClickEvent(self.ModelClick, self)
  self._frame1GetBtn = self:GetChild("BackImage/Frame1/GetBtn")
  self._frame1GetBtnGrey = self:GetChild("BackImage/Frame1/GetBtnGrey")
  self._frame2GetBtn = self:GetChild("BackImage/Frame2/GetBtn")
  self._frame2GetBtnGrey = self:GetChild("BackImage/Frame2/GetBtnGrey")
  self._iBtn = self:GetChild("BackImage/Up/Ibtn")
  self._toActivePageBtn = self:GetChild("BackImage/Up/StopBtn")
  self._itemCells = {}
  self._itemBacks = {}
  self._itemIcons = {}
  self._itemCounts = {}
  for i = 1, 4 do
    self._itemCells[i] = self:GetChild("BackImage/Up/Item" .. i .. "/ItemCell/_BackGround")
    self._itemBacks[i] = self:GetChild("BackImage/Up/Item" .. i .. "/ItemCell/_BackGround/Frame")
    self._itemIcons[i] = self:GetChild("BackImage/Up/Item" .. i .. "/ItemCell/_BackGround/Icon")
    self._itemCounts[i] = self:GetChild("BackImage/Up/Item" .. i .. "/ItemCell/_Count")
    self._itemCells[i]:Subscribe_PointerClickEvent(function()
      self:OnCellClick(i)
    end, self)
  end
  self._iBtn:Subscribe_PointerClickEvent(self.IButtonClick, self)
  self._toActivePageBtn:Subscribe_PointerClickEvent(self.ToActivePageButtonClick, self)
end

function ShopRecommendPageDetailCell2:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ShopRecommendPageDetailCell2:RefreshCell()
  local itemsId = CFirstRechargeReward:GetRecorder(1).itemID
  local itemscount = CFirstRechargeReward:GetRecorder(1).ItemNum
  self._items = {}
  for _, id in ipairs(itemsId) do
    local itemTemp = Item.Create(id)
    table.insert(self._items, itemTemp)
  end
  for i, item in ipairs(self._items) do
    local imageRecord = item:GetPinJiImage()
    self._itemBacks[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = item:GetIcon()
    self._itemIcons[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._itemCounts[i]:SetText(NumberManager.GetShowNumber(itemscount[i]))
  end
end

function ShopRecommendPageDetailCell2:ModelClick()
  local animator = AnimatorStaticFunctions.Get(self._model._uiObject)
  animator:SetTrigger("onClick")
end

function ShopRecommendPageDetailCell2:IButtonClick()
  DialogManager.CreateSingletonDialog("welfare.firtstrechargetip")
end

function ShopRecommendPageDetailCell2:ToActivePageButtonClick()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cfirstchargeopenpanel")
  csend:Send()
  DialogManager.DestroySingletonDialog("shop.shopmaindialog")
end

function ShopRecommendPageDetailCell2:OnCellClick(index)
  local item = self._items[index]
  local dialog
  if item:GetItemTypeId() == ItemIdType.Role then
    local roleID = CRoleItem:GetRecorder(item:GetID()).roleid
    dialog = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
    if dialog then
      dialog:Init({
        roleIdList = {roleID},
        cfgIdList = {1},
        index = 1
      }, dialog.ShowType.BaseLevelInfo)
    end
  elseif item:GetItemTypeId() == ItemIdType.Equip then
    dialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
    if dialog then
      dialog:Init(item:GetID())
      dialog:SetTipsParmFunc(function()
        local width, height = self._itemBacks[index]:GetRectSize()
        local pos = self._itemBacks[index]:GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  else
    dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if dialog then
      dialog:Init({item = item})
    end
  end
end

function ShopRecommendPageDetailCell2:PlayShowAnimation()
  self._animationPanel:PlayAnimation("RecommendShopPage2")
end

return ShopRecommendPageDetailCell2
