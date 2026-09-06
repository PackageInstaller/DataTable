local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local RoleTypeId = 27
local TowerShopCell = class("TowerShopCell", Dialog)
TowerShopCell.AssetBundleName = "ui/layouts.baseshop"
TowerShopCell.AssetName = "TowerShopCell"

function TowerShopCell:Ctor(...)
  TowerShopCell.super.Ctor(self, ...)
end

function TowerShopCell:OnCreate()
  self:GetChild("CellBack/Show"):SetActive(false)
  self._normal = self:GetChild("CellBack/Normal")
  self._special = self:GetChild("CellBack/Special")
  self._img = self:GetChild("CellBack/Item")
  self._img_char = self:GetChild("CellBack/Char")
  self._name = self:GetChild("CellBack/ItemName")
  self._specailnameback = self:GetChild("CellBack/SpecailName")
  self._specailname = self:GetChild("CellBack/SpecailName/ItemName")
  self._back = self:GetChild("CellBack/Back")
  self._price = self:GetChild("CellBack/Price")
  self._priceImg = self:GetChild("CellBack/Price/Image")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._priceDeleteNum = self:GetChild("CellBack/Price/TextDelete")
  self._price2 = self:GetChild("CellBack/Price2")
  self._price2Img = self:GetChild("CellBack/Price2/Image")
  self._price2Num = self:GetChild("CellBack/Price2/Text")
  self._leftNum = self:GetChild("CellBack/Num/Num")
  self._sale = self:GetChild("CellBack/Sale")
  self._limit = self:GetChild("CellBack/Limit")
  self._limitT = self:GetChild("CellBack/Limit/Limit")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function TowerShopCell:OnDestroy()
end

function TowerShopCell:RefreshCell(data)
  self._data = data
  local isEquip = data.iteminfo.goodId > 1000 and data.iteminfo.goodId < 2000
  local isUniqueEquip = false
  local item = Item.Create(data.iteminfo.itemId)
  if item then
    isUniqueEquip = item:IsUniqueEquip()
  end
  local isUniqueEquipBuy35026 = false
  local monyeyItem = Item.Create(data.iteminfo.moneyType)
  if monyeyItem then
    isUniqueEquipBuy35026 = monyeyItem:IsUniqueEquip() and data.iteminfo.itemId == 35026
  end
  self._special:SetActive(isEquip)
  self._normal:SetActive(not isEquip)
  self._specailnameback:SetActive(isEquip)
  self._name:SetActive(not isEquip)
  if data.iteminfo.goodRemain == 0 then
    self._soldOut:SetActive(true)
    self._leftNum:SetText(0)
  else
    self._soldOut:SetActive(false)
    if data.iteminfo.goodRemain == -1 then
      self._leftNum:SetText(tostring(99 .. "+"))
    else
      self._leftNum:SetText(tostring(data.iteminfo.goodRemain))
    end
  end
  if not (not isUniqueEquip and not isUniqueEquipBuy35026 and data.iteminfo.beginTime and data.iteminfo.endTime) or data.iteminfo.beginTime == 0 or data.iteminfo.endTime == 0 then
    self._limit:SetActive(false)
  else
    self._limit:SetActive(true)
    self._limitT:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(data.iteminfo.endTime))
  end
  if data.iteminfo.discount == 0 then
    self._price:SetActive(false)
    self._price2:SetActive(true)
    self._sale:SetActive(false)
  elseif data.iteminfo.discount == -1 then
    self._price:SetActive(false)
    self._price2:SetActive(true)
    self._sale:SetActive(false)
  else
    self._price:SetActive(true)
    self._price2:SetActive(false)
    self._sale:SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder(10 - data.iteminfo.discount + 11392)
    self._sale:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local item = Item.Create(data.iteminfo.itemId)
  local imageRecord
  local isRole = item:GetItemTypeId() == RoleTypeId
  self._img_char:SetActive(isRole)
  self._img:SetActive(not isRole)
  if isRole then
    local roleid = CRoleItem:GetRecorder(data.iteminfo.itemId).roleid
    local roleRecorder = RoleConfigTable:GetRecorder(roleid)
    local npcshaperecord = CNPCShape:GetRecorder(roleRecorder.shapeID)
    imageRecord = CImagePathTable:GetRecorder(npcshaperecord.skillHeadID)
    self._img_char:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    imageRecord = item:GetIcon()
    self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  imageRecord = item:GetShopPinJiBackGroundImage()
  self._back:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str
  if isEquip then
    str = item:GetName()
    self._specailname:SetText(str)
  else
    str = TextManager.GetText(CStringRes:GetRecorder(1169).msgTextID)
    str = string.gsub(str, "%$parameter1%$", item:GetName())
    str = string.gsub(str, "%$parameter2%$", data.iteminfo.itemSum)
    self._name:SetText(str)
  end
  item = Item.Create(data.iteminfo.moneyType)
  imageRecord = item:GetIcon()
  if data.iteminfo.discount == 0 or data.iteminfo.discount == -1 then
    self._price2Img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._price2Num:SetText(tostring(data.iteminfo.discountPrice))
  else
    self._priceImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._priceNum:SetText(tostring(data.iteminfo.discountPrice))
    self._priceDeleteNum:SetText(tostring(data.iteminfo.price))
  end
  if data.iteminfo.discountPrice == data.iteminfo.price then
    self._priceDeleteNum:SetActive(false)
  else
    self._priceDeleteNum:SetActive(true)
  end
end

function TowerShopCell:OnCellClicked()
  if self._data.iteminfo.goodRemain == 0 then
    return
  end
  local shopID = self._delegate._delegate._selectShopID
  local item = Item.Create(self._data.iteminfo.itemId)
  if item:IsUniqueEquip() then
    DialogManager.CreateSingletonDialog("shop.uniqueequipbuydialog"):SetData(self._data.iteminfo, shopID)
  elseif self._data.iteminfo.goodId < 1000 or self._data.iteminfo.goodId > 2000 then
    DialogManager.CreateSingletonDialog("shop.itembuydialog"):SetData(self._data.iteminfo, shopID)
  else
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetequipchestinfo")
    if protocol then
      protocol.chestID = self._data.iteminfo.goodId
      protocol:Send()
    end
  end
end

function TowerShopCell:OnEvent(eventName, arg)
  if eventName == "BuyGoodRefresh" then
    local info = arg.goodInfo[self._data.iteminfo.goodId]
    if info then
      self._data.iteminfo = info
      if self._data.iteminfo.goodRemain == 0 then
        self._soldOut:SetActive(true)
        self._leftNum:SetText(0)
      else
        self._soldOut:SetActive(false)
        if self._data.iteminfo.goodRemain == -1 then
          self._leftNum:SetText(tostring(99 .. "+"))
        else
          self._leftNum:SetText(tostring(self._data.iteminfo.goodRemain))
        end
      end
      if self._data.iteminfo.discount == 0 then
        self._sale:SetActive(false)
      elseif self._data.iteminfo.discount == -1 then
        self._sale:SetActive(false)
      else
        self._sale:SetActive(true)
        local imageRecord = CImagePathTable:GetRecorder(10 - self._data.iteminfo.discount + 11392)
        self._sale:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      self._priceNum:SetText(tostring(self._data.iteminfo.discountPrice))
      self._priceDeleteNum:SetText(tostring(self._data.iteminfo.price))
    end
  end
end

return TowerShopCell
