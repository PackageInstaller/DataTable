-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopleftbarbtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CShopTypeConfig = (BeanManager.GetTableByName)("recharge.cshoptypeconfig")
local DM_RedDot = (NekoData.DataManager).DM_RedDot
local ShopLeftBarBtnCell = class("ShopLeftBarBtnCell", Dialog)
ShopLeftBarBtnCell.AssetBundleName = "ui/layouts.baseshop"
ShopLeftBarBtnCell.AssetName = "RecommendShopGroupBtn"
ShopLeftBarBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopLeftBarBtnCell
  ((ShopLeftBarBtnCell.super).Ctor)(self, ...)
  self._name = ""
end

ShopLeftBarBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("GroupBtn")
  self._btnTxt = self:GetChild("GroupBtn/Text")
  self._icon = self:GetChild("GroupBtn/Img")
  self._redDot = self:GetChild("GroupBtn/RedDot")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopLeftBarBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopLeftBarBtnCell.RefreshCell = function(self, record)
  -- function num : 0_3 , upvalues : CShopTypeConfig, _ENV, CImagePathTable, DM_RedDot
  self._groupBtnID = record
  local shopTypeCfg = CShopTypeConfig:GetRecorder(record)
  self._name = (TextManager.GetText)(shopTypeCfg.NameTextID)
  ;
  (self._btnTxt):SetText(self._name)
  self._iconId = shopTypeCfg.Image
  self._selectIconId = shopTypeCfg.ImageSelect
  do
    if self._iconId ~= 0 then
      local iconCfg = CImagePathTable:GetRecorder(self._selectIconId)
      ;
      (self._btn):SetTextImgSelected(iconCfg.assetBundle, iconCfg.assetName)
    end
    do
      if self._selectIconId ~= 0 then
        local iconCfg = CImagePathTable:GetRecorder(self._iconId)
        ;
        (self._btn):SetTextImgNormal(iconCfg.assetBundle, iconCfg.assetName)
      end
      self._redDotNode = (DM_RedDot.nodeChildShop)[self._groupBtnID]
      self:ShowRedDot()
    end
  end
end

ShopLeftBarBtnCell.OnCellClicked = function(self, args)
  -- function num : 0_4
  (self._delegate):OnGroupBtnClicked(self._groupBtnID, true)
end

ShopLeftBarBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : DM_RedDot, _ENV
  if eventName == "ChangedSelected" then
    local oldBarSelected = self._barSelected
    self._barSelected = self._groupBtnID == arg
    ;
    (self._btn):SetSelected(self._barSelected)
    if self._redDotNode then
      if self._barSelected then
        (DM_RedDot.SetNodeRead)(self._redDotNode, true)
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
      elseif oldBarSelected then
        local itemData = ((self._redDotNode).childNode).ItemData
        if itemData then
          for _,value in pairs(itemData.childNode) do
            (DM_RedDot.SetNodeRead)(value, true)
          end
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
        end
      end
    end
  elseif eventName == "RedPointInfo" then
    self:ShowRedDot()
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

ShopLeftBarBtnCell.ShowRedDot = function(self)
  -- function num : 0_6 , upvalues : DM_RedDot
  if self._redDotNode then
    self._nodeResult = (DM_RedDot.GetNodeResult)(self._redDotNode)
    ;
    (self._redDot):SetActive(self._nodeResult)
  else
    ;
    (self._redDot):SetActive(false)
  end
end

return ShopLeftBarBtnCell

