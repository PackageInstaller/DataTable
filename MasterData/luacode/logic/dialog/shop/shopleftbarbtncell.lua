local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CShopTypeConfig = BeanManager.GetTableByName("recharge.cshoptypeconfig")
local DM_RedDot = NekoData.DataManager.DM_RedDot
local ShopLeftBarBtnCell = class("ShopLeftBarBtnCell", Dialog)
ShopLeftBarBtnCell.AssetBundleName = "ui/layouts.baseshop"
ShopLeftBarBtnCell.AssetName = "RecommendShopGroupBtn"

function ShopLeftBarBtnCell:Ctor(...)
  ShopLeftBarBtnCell.super.Ctor(self, ...)
  self._name = ""
end

function ShopLeftBarBtnCell:OnCreate()
  self._btn = self:GetChild("GroupBtn")
  self._btnTxt = self:GetChild("GroupBtn/Text")
  self._icon = self:GetChild("GroupBtn/Img")
  self._redDot = self:GetChild("GroupBtn/RedDot")
  self._btn:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ShopLeftBarBtnCell:OnDestroy()
end

function ShopLeftBarBtnCell:RefreshCell(record)
  self._groupBtnID = record
  local shopTypeCfg = CShopTypeConfig:GetRecorder(record)
  self._name = TextManager.GetText(shopTypeCfg.NameTextID)
  self._btnTxt:SetText(self._name)
  self._iconId = shopTypeCfg.Image
  self._selectIconId = shopTypeCfg.ImageSelect
  if self._iconId ~= 0 then
    local iconCfg = CImagePathTable:GetRecorder(self._selectIconId)
    self._btn:SetTextImgSelected(iconCfg.assetBundle, iconCfg.assetName)
  end
  if self._selectIconId ~= 0 then
    local iconCfg = CImagePathTable:GetRecorder(self._iconId)
    self._btn:SetTextImgNormal(iconCfg.assetBundle, iconCfg.assetName)
  end
  self._redDotNode = DM_RedDot.nodeChildShop[self._groupBtnID]
  self:ShowRedDot()
end

function ShopLeftBarBtnCell:OnCellClicked(args)
  self._delegate:OnGroupBtnClicked(self._groupBtnID, true)
end

function ShopLeftBarBtnCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    local oldBarSelected = self._barSelected
    self._barSelected = self._groupBtnID == arg
    self._btn:SetSelected(self._barSelected)
    if self._redDotNode then
      if self._barSelected then
        DM_RedDot.SetNodeRead(self._redDotNode, true)
        LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
      elseif oldBarSelected then
        local itemData = self._redDotNode.childNode.ItemData
        if itemData then
          for _, value in pairs(itemData.childNode) do
            DM_RedDot.SetNodeRead(value, true)
          end
          LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
        end
      end
    end
  elseif eventName == "RedPointInfo" then
    self:ShowRedDot()
  end
end

function ShopLeftBarBtnCell:ShowRedDot()
  if self._redDotNode then
    self._nodeResult = DM_RedDot.GetNodeResult(self._redDotNode)
    self._redDot:SetActive(self._nodeResult)
  else
    self._redDot:SetActive(false)
  end
end

return ShopLeftBarBtnCell
