-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shoprecommendpagedreamspiralcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local UnlockCfg = (BeanManager.GetTableByName)("recharge.cseasonpassunlock")
local ShopRecommendPageDreamSpiralCell = class("ShopRecommendPageDreamSpiralCell", Dialog)
ShopRecommendPageDreamSpiralCell.AssetBundleName = "ui/layouts.baseshop"
ShopRecommendPageDreamSpiralCell.AssetName = "RecommendShopPage4"
ShopRecommendPageDreamSpiralCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopRecommendPageDreamSpiralCell
  ((ShopRecommendPageDreamSpiralCell.super).Ctor)(self, ...)
end

ShopRecommendPageDreamSpiralCell.OnCreate = function(self)
  -- function num : 0_1
  self._animationPanel = self._rootWindow
  self._backImage = self:GetChild("Cell1")
  self._name = self:GetChild("Cell1/Name")
  self._goBtn = self:GetChild("Cell1/StopBtn")
  self._buyBtn = self:GetChild("Cell1/GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self:RefreshCell()
end

ShopRecommendPageDreamSpiralCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopRecommendPageDreamSpiralCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, UnlockCfg, CImagePathTable
  local mgr = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  self._info = mgr:GetBaseInfo()
  local hasUnlock = (self._info).highUnlocked ~= 0
  ;
  (self._goBtn):SetActive(hasUnlock)
  ;
  (self._buyBtn):SetActive(not hasUnlock)
  local unlockCfg = UnlockCfg:GetRecorder((self._info).actId)
  do
    if unlockCfg then
      if not CImagePathTable:GetRecorder(unlockCfg.shopBackImageID) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._backImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      if not CImagePathTable:GetRecorder(unlockCfg.nameImageID) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._name):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

ShopRecommendPageDreamSpiralCell.OnGoBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):GetFloorIsPassWithMainLineId(3) then
    local mgr = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
    if mgr:IsAgCoinActivityOpen() then
      if (DialogManager.GetDialog)("welfare.welfaremaindialog") then
        (DialogManager.DestroySingletonDialog)("welfare.welfaremaindialog")
      end
      local dialog = (DialogManager.CreateSingletonDialog)("welfare.welfaremaindialog")
      if dialog then
        dialog:SetData(true)
        dialog:SetSelectedTab((dialog.WelfareType).dreamSpiral)
      end
    else
      do
        do
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100033)
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100347)
        end
      end
    end
  end
end

ShopRecommendPageDreamSpiralCell.PlayShowAnimation = function(self)
  -- function num : 0_5
  (self._animationPanel):PlayAnimation("RecommendShopPage4")
end

return ShopRecommendPageDreamSpiralCell

