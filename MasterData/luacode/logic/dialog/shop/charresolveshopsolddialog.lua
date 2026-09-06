local Item = require("logic.manager.experimental.types.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CharResolveShopSoldDialig = class("CharResolveShopSoldDialig", Dialog)
CharResolveShopSoldDialig.AssetBundleName = "ui/layouts.baseshop"
CharResolveShopSoldDialig.AssetName = "CharResolveShopSold"

function CharResolveShopSoldDialig:Ctor(...)
  CharResolveShopSoldDialig.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function CharResolveShopSoldDialig:OnCreate()
  self._goldFlowerNum = self:GetChild("Panel/Flower1/Text")
  self._goldFlowerAddNum = self:GetChild("Panel/Flower1/Add")
  self._whiteFlowerNum = self:GetChild("Panel/Flower2/Text")
  self._whiteFlowerAddNum = self:GetChild("Panel/Flower2/Add")
  self._cancelBtn = self:GetChild("Panel/CancelButton")
  self._confirmBtn = self:GetChild("Panel/ConfirmButton")
  self._area = self:GetChild("Panel/Frame")
  self._frame = GridFrame.Create(self._area, self, true, 5, true)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function CharResolveShopSoldDialig:OnDestroy()
  self._frame:Destroy()
end

function CharResolveShopSoldDialig:SetData(roleList, whitenum, goldnum)
  self._roleList = {}
  for k, v in pairs(roleList) do
    table.insert(self._roleList, {itemid = k, num = v})
  end
  self._whiteFlowerNum:SetText(NekoData.BehaviorManager.BM_Currency:GetWhiteCoin())
  if whitenum == 0 then
    self._whiteFlowerAddNum:SetActive(false)
  else
    self._whiteFlowerAddNum:SetText("+" .. whitenum)
  end
  self._goldFlowerNum:SetText(NekoData.BehaviorManager.BM_Currency:GetGoldCoin())
  if goldnum == 0 then
    self._goldFlowerAddNum:SetActive(false)
  else
    self._goldFlowerAddNum:SetText("+" .. goldnum)
  end
  self._frame:ReloadAllCell()
end

function CharResolveShopSoldDialig:NumberOfCell(frame)
  return #self._roleList
end

function CharResolveShopSoldDialig:CellAtIndex(frame, index)
  return "shop.charresolveshopsoldcell"
end

function CharResolveShopSoldDialig:DataAtIndex(frame, index)
  local data = {}
  data.itemid = self._roleList[index].itemid
  data.num = self._roleList[index].num
  return data
end

function CharResolveShopSoldDialig:OnBackBtnClicked()
  self:Destroy()
end

function CharResolveShopSoldDialig:OnConfirmBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cquickdecompose2petal")
  if protocol then
    protocol:Send()
  end
end

return CharResolveShopSoldDialig
