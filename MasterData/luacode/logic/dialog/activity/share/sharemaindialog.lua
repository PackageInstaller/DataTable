local CShareReward = BeanManager.GetTableByName("sharesystem.csharereward")
local CBannerAndEntrance = BeanManager.GetTableByName("activity.cbannerandentrance")
local Item = require("logic.manager.experimental.types.item")
local ShareMainDialog = class("ShareMainDialog", Dialog)
ShareMainDialog.AssetBundleName = "ui/layouts.share"
ShareMainDialog.AssetName = "ActivityShare"

function ShareMainDialog:Ctor(...)
  ShareMainDialog.super.Ctor(self, ...)
  self._groupName = "Default"
end

function ShareMainDialog:OnCreate()
  self._itemFrame = self:GetChild("Back/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Back/ItemCell/_BackGround/Icon")
  self._itemNum = self:GetChild("Back/ItemCell/_Count")
  self._itemCell = self:GetChild("Back/ItemCell")
  self._timeTxt = self:GetChild("Back/TimeLimit/TxtTime")
  self._gotPanel = self:GetChild("Back/ItemGet")
  self._shareBtn = self:GetChild("Back/Btn")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._shareBtn:Subscribe_PointerClickEvent(self.OnShareBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshShareActivity, Common.n_RefreshShareActivity, nil)
end

function ShareMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("activity.share.fullscreendialog")
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("activity.share.sharesingledialog")
end

function ShareMainDialog:OnRefreshShareActivity()
  self:SetId(self._bannerId)
end

function ShareMainDialog:SetId(bannerId)
  self._bannerId = bannerId
  local record = CShareReward:GetRecorder(2)
  local bannerRecord = CBannerAndEntrance:GetRecorder(bannerId)
  local entranceStartStr = string.sub(bannerRecord.entrancestart, 6, -1)
  entranceStartStr = string.sub(entranceStartStr, 1, 11)
  local entranceEndStr = string.sub(bannerRecord.entranceend, 6, -1)
  entranceEndStr = string.sub(entranceEndStr, 1, 11)
  self._timeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1511, {entranceStartStr, entranceEndStr}))
  self._item = Item.Create(record.itemID[1])
  local image = self._item:GetPinJiImage()
  self._itemFrame:SetSprite(image.assetBundle, image.assetName)
  image = self._item:GetIcon()
  self._itemIcon:SetSprite(image.assetBundle, image.assetName)
  self._itemNum:SetText(NumberManager.GetShowNumber(record.itemNum[1]))
  local value = NekoData.BehaviorManager.BM_Activity:GetShareActivity(bannerId)
  if value == 0 then
    self._gotPanel:SetActive(false)
  elseif value == 1 then
    self._gotPanel:SetActive(true)
  end
end

function ShareMainDialog:OnItemCellClicked()
  local width, height = self._itemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
  end
end

function ShareMainDialog:OnShareBtnClicked()
  DialogManager.CreateSingletonDialog("activity.share.fullscreendialog")
end

function ShareMainDialog:OnBackBtnClicked()
  self:Destroy()
end

return ShareMainDialog
