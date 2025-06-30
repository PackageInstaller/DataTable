-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/share/sharemaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CShareReward = (BeanManager.GetTableByName)("sharesystem.csharereward")
local CBannerAndEntrance = (BeanManager.GetTableByName)("activity.cbannerandentrance")
local Item = require("logic.manager.experimental.types.item")
local ShareMainDialog = class("ShareMainDialog", Dialog)
ShareMainDialog.AssetBundleName = "ui/layouts.share"
ShareMainDialog.AssetName = "ActivityShare"
ShareMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShareMainDialog
  ((ShareMainDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
end

ShareMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._itemFrame = self:GetChild("Back/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Back/ItemCell/_BackGround/Icon")
  self._itemNum = self:GetChild("Back/ItemCell/_Count")
  self._itemCell = self:GetChild("Back/ItemCell")
  self._timeTxt = self:GetChild("Back/TimeLimit/TxtTime")
  self._gotPanel = self:GetChild("Back/ItemGet")
  self._shareBtn = self:GetChild("Back/Btn")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  (self._shareBtn):Subscribe_PointerClickEvent(self.OnShareBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshShareActivity, Common.n_RefreshShareActivity, nil)
end

ShareMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("activity.share.fullscreendialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.share.sharesingledialog")
end

ShareMainDialog.OnRefreshShareActivity = function(self)
  -- function num : 0_3
  self:SetId(self._bannerId)
end

ShareMainDialog.SetId = function(self, bannerId)
  -- function num : 0_4 , upvalues : CShareReward, CBannerAndEntrance, _ENV, Item
  self._bannerId = bannerId
  local record = CShareReward:GetRecorder(2)
  local bannerRecord = CBannerAndEntrance:GetRecorder(bannerId)
  local entranceStartStr = (string.sub)(bannerRecord.entrancestart, 6, -1)
  entranceStartStr = (string.sub)(entranceStartStr, 1, 11)
  local entranceEndStr = (string.sub)(bannerRecord.entranceend, 6, -1)
  entranceEndStr = (string.sub)(entranceEndStr, 1, 11)
  ;
  (self._timeTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1511, {entranceStartStr, entranceEndStr}))
  self._item = (Item.Create)((record.itemID)[1])
  local image = (self._item):GetPinJiImage()
  ;
  (self._itemFrame):SetSprite(image.assetBundle, image.assetName)
  image = (self._item):GetIcon()
  ;
  (self._itemIcon):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._itemNum):SetText((NumberManager.GetShowNumber)((record.itemNum)[1]))
  local value = ((NekoData.BehaviorManager).BM_Activity):GetShareActivity(bannerId)
  if value == 0 then
    (self._gotPanel):SetActive(false)
  else
    if value == 1 then
      (self._gotPanel):SetActive(true)
    end
  end
end

ShareMainDialog.OnItemCellClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local width, height = (self._itemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
  end
end

ShareMainDialog.OnShareBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("activity.share.fullscreendialog")
end

ShareMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

return ShareMainDialog

