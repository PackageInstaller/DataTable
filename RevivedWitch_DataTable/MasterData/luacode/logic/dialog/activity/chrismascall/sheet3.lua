-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/chrismascall/sheet3.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ShopGoodsCellHelper = require("logic.dialog.activity.chrismascall.shopgoodscellhelper")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local SkinTypeId = 91
local Sheet3 = class("Sheet3", Dialog)
Sheet3.AssetBundleName = "ui/layouts.activitychristmascall"
Sheet3.AssetName = "ActivityChristmasCallShop"
Sheet3.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet3
  ((Sheet3.super).Ctor)(self, ...)
end

Sheet3.OnCreate = function(self)
  -- function num : 0_1 , upvalues : ShopGoodsCellHelper, _ENV
  self._tipsBtn = self:GetChild("Tips")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._frame = self:GetChild("FrameShop")
  self._activeTime = self:GetChild("ActiveTime")
  self._goodsCell1 = self:GetChild("ActivityChristmasCallShopCell1")
  self._goodsCell2 = self:GetChild("ActivityChristmasCallShopCell2")
  self._goodsCell3 = self:GetChild("ActivityChristmasCallShopCell3")
  self._goodsCellHelper1 = (ShopGoodsCellHelper.Create)(self._goodsCell1, 1)
  self._goodsCellHelper2 = (ShopGoodsCellHelper.Create)(self._goodsCell2, 2)
  self._goodsCellHelper3 = (ShopGoodsCellHelper.Create)(self._goodsCell3, 3)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShopInfo, Common.n_RefreshShopInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShopInfo, Common.n_BuyShopGood, nil)
  self:SetStaticRes()
end

Sheet3.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  (self._activeTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1688)).msgTextID))
end

Sheet3.OnDestroy = function(self)
  -- function num : 0_3
  if self._goodsCellHelper1 then
    (self._goodsCellHelper1):OnDestroy()
  end
  if self._goodsCellHelper2 then
    (self._goodsCellHelper2):OnDestroy()
  end
  if self._goodsCellHelper3 then
    (self._goodsCellHelper3):OnDestroy()
  end
end

Sheet3.SetData = function(self, shopID)
  -- function num : 0_4 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._shopID = shopID
  self:RefreshShopInfo()
end

Sheet3.RefreshShopInfo = function(self)
  -- function num : 0_5 , upvalues : _ENV, Item, SkinTypeId
  local goodsData = ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(self._shopID)
  if #goodsData ~= 3 then
    LogErrorFormat("ChrismasCall.Sheet3.SetData", "The shop goods length error! | %d", #goodsData)
    return 
  end
  local freeGoodsData, notFreeGoodsData, skinGoodsData = nil, nil, nil
  if PrintTable then
    PrintTable(goodsData, 3, "goodsData")
  end
  for _,goods in pairs(goodsData) do
    if goods.discountPrice == 0 then
      freeGoodsData = goods
    else
      if type(goods.itemId) == "table" then
        local isSkin = false
        for _,value in pairs(goods.itemId) do
          local item = (Item.Create)(value)
          isSkin = item:GetItemTypeId() == SkinTypeId
        end
        if isSkin or isSkin then
          skinGoodsData = goods
        else
          notFreeGoodsData = goods
        end
      end
    end
  end
  if freeGoodsData then
    (self._goodsCell1):SetActive(true)
    ;
    (self._goodsCellHelper1):RefreshCell(freeGoodsData, self._shopID)
  else
    (self._goodsCell1):SetActive(false)
    LogErrorFormat("ChrismasCall.Sheet3.SetData", "The shop freeGoodsData parse error!")
  end
  if notFreeGoodsData then
    (self._goodsCell2):SetActive(true)
    ;
    (self._goodsCellHelper2):RefreshCell(notFreeGoodsData, self._shopID)
  else
    (self._goodsCell2):SetActive(false)
    LogErrorFormat("ChrismasCall.Sheet3.SetData", "The shop goods notFreeGoodsData error!")
  end
  if skinGoodsData then
    (self._goodsCell3):SetActive(true)
    ;
    (self._goodsCellHelper3):RefreshCell(skinGoodsData, self._shopID)
  else
    (self._goodsCell3):SetActive(false)
    LogErrorFormat("ChrismasCall.Sheet3.SetData", "The shop goods skinGoodsData error!")
  end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

Sheet3.OnTipsBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV, CStringRes
  local dialogName = "activity.chrismascall.tipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1671)).msgTextID, (CStringRes:GetRecorder(1670)).msgTextID)
  end
end

return Sheet3

