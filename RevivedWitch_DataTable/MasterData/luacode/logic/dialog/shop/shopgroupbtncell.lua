-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopgroupbtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CShopTypeShow = (BeanManager.GetTableByName)("recharge.cshoptypeshow")
local CShopTypeConfig = (BeanManager.GetTableByName)("recharge.cshoptypeconfig")
local Shop_CountID = {[1] = 11, [2] = 10, [3] = 12, [4] = 13, [5] = 15, [6] = 14, [7] = 16}
local DM_RedDot = (NekoData.DataManager).DM_RedDot
local ShopGroupBtnCell = class("ShopGroupBtnCell", Dialog)
ShopGroupBtnCell.AssetBundleName = "ui/layouts.baseshop"
ShopGroupBtnCell.AssetName = "ShopGroupBtn"
ShopGroupBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopGroupBtnCell
  ((ShopGroupBtnCell.super).Ctor)(self, ...)
end

ShopGroupBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("GroupBtn")
  self._icon = self:GetChild("GroupBtn/Img")
  self._redPoint = self:GetChild("GroupBtn/RedDot")
  ;
  (self._redPoint):SetActive(false)
  self._btnTxt = self:GetChild("GroupBtn/Text")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopGroupBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopGroupBtnCell.RefreshCell = function(self, temp)
  -- function num : 0_3 , upvalues : _ENV, CShopTypeShow, CImagePathTable
  if temp.id == 0 then
    self._groupBtnID = 0
    local str = (TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1222)).msgTextID)
    ;
    (self._btnTxt):SetText(str)
  else
    do
      self._groupBtnID = temp.id
      local showCfg = CShopTypeShow:GetRecorder(self._groupBtnID)
      local iconCfg = CImagePathTable:GetRecorder(showCfg.Image)
      ;
      (self._btnTxt):SetText((TextManager.GetText)(showCfg.TypeNameTextID))
      if iconCfg then
        (self._icon):SetActive(true)
        ;
        (self._btn):SetTextImgSelected(iconCfg.assetBundle, iconCfg.assetName)
        ;
        (self._btn):SetTextImgNormal(iconCfg.assetBundle, iconCfg.assetName)
      else
        ;
        (self._icon):SetActive(false)
      end
      self:ShowRedDot()
    end
  end
end

ShopGroupBtnCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : Shop_CountID, _ENV
  (self._delegate):OnGroupBtnCellClicked(self._groupBtnID)
  local count_ID = Shop_CountID[self._groupBtnID]
  if count_ID then
    local jsonStr = (JSON.encode)({eventName = "event", id = tostring(count_ID)})
    ;
    (ThinkingAnalyticsInterface.UploadEvent_TA)(jsonStr)
  end
end

ShopGroupBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "ChangedSelected" then
    if self._groupBtnID == arg then
      (self._btn):SetSelected(true)
    else
      -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

      if arg >= 100 and arg <= 1000 and self._groupBtnID == 0 then
        (self._btn):SetSelected(true)
      end
    end
    ;
    (self._btn):SetSelected(false)
  else
    if eventName == "RedPointInfo" then
      self:ShowRedDot()
    end
  end
end

ShopGroupBtnCell.ShowRedDot = function(self)
  -- function num : 0_6 , upvalues : _ENV, DM_RedDot, CShopTypeConfig
  local showRedDot = false
  for key,value in pairs(DM_RedDot.nodeChildShop) do
    local rec = CShopTypeConfig:GetRecorder(key)
    if rec and rec.ShopType == self._groupBtnID and (DM_RedDot.GetNodeResult)(value) then
      showRedDot = true
      break
    end
  end
  do
    if self._groupBtnID == 1 then
      local dailyGiftShop = ((DM_RedDot.nodeShop).childNode).KeyDailyGiftShop
      if dailyGiftShop and (DM_RedDot.GetNodeResult)(dailyGiftShop) then
        showRedDot = true
      end
    else
      do
        if self._groupBtnID == 2 then
          local hasAccumulationRewardToGet = ((DM_RedDot.nodeShop).childNode).KeyHasAccumulationRewardToGet
          if hasAccumulationRewardToGet and (DM_RedDot.GetNodeResult)(hasAccumulationRewardToGet) then
            showRedDot = true
          end
        else
          do
            do
              if self._groupBtnID == 4 then
                local hasShopFashionRewardToGet = ((DM_RedDot.nodeShop).childNode).KeyHasFashionRewardToGet
                if hasShopFashionRewardToGet and (DM_RedDot.GetNodeResult)(hasShopFashionRewardToGet) then
                  showRedDot = true
                end
              end
              ;
              (self._redPoint):SetActive(showRedDot)
            end
          end
        end
      end
    end
  end
end

return ShopGroupBtnCell

