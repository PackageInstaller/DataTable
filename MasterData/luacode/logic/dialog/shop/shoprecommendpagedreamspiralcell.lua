local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local UnlockCfg = BeanManager.GetTableByName("recharge.cseasonpassunlock")
local ShopRecommendPageDreamSpiralCell = class("ShopRecommendPageDreamSpiralCell", Dialog)
ShopRecommendPageDreamSpiralCell.AssetBundleName = "ui/layouts.baseshop"
ShopRecommendPageDreamSpiralCell.AssetName = "RecommendShopPage4"

function ShopRecommendPageDreamSpiralCell:Ctor(...)
  ShopRecommendPageDreamSpiralCell.super.Ctor(self, ...)
end

function ShopRecommendPageDreamSpiralCell:OnCreate()
  self._animationPanel = self._rootWindow
  self._backImage = self:GetChild("Cell1")
  self._name = self:GetChild("Cell1/Name")
  self._goBtn = self:GetChild("Cell1/StopBtn")
  self._buyBtn = self:GetChild("Cell1/GoBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self._buyBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self:RefreshCell()
end

function ShopRecommendPageDreamSpiralCell:OnDestroy()
end

function ShopRecommendPageDreamSpiralCell:RefreshCell()
  local mgr = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  self._info = mgr:GetBaseInfo()
  local hasUnlock = self._info.highUnlocked ~= 0
  self._goBtn:SetActive(hasUnlock)
  self._buyBtn:SetActive(not hasUnlock)
  local unlockCfg = UnlockCfg:GetRecorder(self._info.actId)
  if unlockCfg then
    local imageRecord = CImagePathTable:GetRecorder(unlockCfg.shopBackImageID) or DataCommon.DefaultImageAsset
    self._backImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = CImagePathTable:GetRecorder(unlockCfg.nameImageID) or DataCommon.DefaultImageAsset
    self._name:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

function ShopRecommendPageDreamSpiralCell:OnGoBtnClick()
  if NekoData.BehaviorManager.BM_Game:GetFloorIsPassWithMainLineId(3) then
    local mgr = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
    if mgr:IsAgCoinActivityOpen() then
      if DialogManager.GetDialog("welfare.welfaremaindialog") then
        DialogManager.DestroySingletonDialog("welfare.welfaremaindialog")
      end
      local dialog = DialogManager.CreateSingletonDialog("welfare.welfaremaindialog")
      if dialog then
        dialog:SetData(true)
        dialog:SetSelectedTab(dialog.WelfareType.dreamSpiral)
      end
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100033)
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100347)
  end
end

function ShopRecommendPageDreamSpiralCell:PlayShowAnimation()
  self._animationPanel:PlayAnimation("RecommendShopPage4")
end

return ShopRecommendPageDreamSpiralCell
