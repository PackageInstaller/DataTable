-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/shopitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CChrisExp = (BeanManager.GetTableByName)("recharge.cchrisexp")
local CChrisSing = (BeanManager.GetTableByName)("recharge.cchrissing")
local CChrisDance = (BeanManager.GetTableByName)("recharge.cchrisdance")
local ShopTypeMap = (DataCommon.StarMirage).Shop
local ShopItemCell = class("ShopItemCell", Dialog)
ShopItemCell.AssetBundleName = "ui/layouts.activitychristmas"
ShopItemCell.AssetName = "ActivityChristmasShopCell"
local isLock = function(self)
  -- function num : 0_0 , upvalues : _ENV, CChrisSing, Item, CChrisDance, CChrisExp
  local recoder = nil
  local curNum = 0
  self._nameStr = ""
  if (self._data).moneyType == DataCommon.ChristmasSing then
    recoder = CChrisSing:GetRecorder((self._data).goodId)
    curNum = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):GetScoreByType(DataCommon.ChristmasSing)
    local currencyItem = (Item.Create)(DataCommon.ChristmasSing)
    self._nameStr = currencyItem:GetName()
  else
    do
      if (self._data).moneyType == DataCommon.ChristmasJump then
        recoder = CChrisDance:GetRecorder((self._data).goodId)
        curNum = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):GetScoreByType(DataCommon.ChristmasJump)
        local currencyItem = (Item.Create)(DataCommon.ChristmasJump)
        self._nameStr = currencyItem:GetName()
      else
        do
          if (self._data).moneyType == DataCommon.ChristmasExpressiveForce then
            recoder = CChrisExp:GetRecorder((self._data).goodId)
            curNum = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):GetScoreByType(DataCommon.ChristmasExpressiveForce)
            local currencyItem = (Item.Create)(DataCommon.ChristmasExpressiveForce)
            self._nameStr = currencyItem:GetName()
          end
          do
            self._limitNum = recoder.PointNum
            if curNum < recoder.PointNum then
              return true
            end
            return false
          end
        end
      end
    end
  end
end

ShopItemCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : ShopItemCell
  ((ShopItemCell.super).Ctor)(self, ...)
end

ShopItemCell.OnCreate = function(self)
  -- function num : 0_2
  self._hard_back = self:GetChild("CellBack/CellBackHard")
  self._back = self:GetChild("CellBack/Back")
  self._icon = self:GetChild("CellBack/Item")
  self._name = self:GetChild("CellBack/ItemName")
  self._priceIcon = self:GetChild("CellBack/Price/Image")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._num = self:GetChild("CellBack/Num/Num")
  self._limit = self:GetChild("CellBack/Limit")
  self._limit_txt = self:GetChild("CellBack/Limit/Limit")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  self._lockIcon = self:GetChild("CellBack/Lock")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopItemCell.OnDestroy = function(self)
  -- function num : 0_3
end

ShopItemCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : Item, _ENV, CStringRes, isLock
  self._data = data
  local item = (Item.Create)(data.itemId)
  local imageRecord = item:GetShopPinJiBackGroundImage()
  ;
  (self._back):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1169)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", item:GetName())
  str = (string.gsub)(str, "%$parameter2%$", data.itemSum)
  ;
  (self._name):SetText(str)
  item = (Item.Create)(data.moneyType)
  imageRecord = item:GetIcon()
  ;
  (self._priceIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._priceNum):SetText(tostring(data.discountPrice))
  if data.goodRemain == 0 then
    (self._soldOut):SetActive(true)
    ;
    (self._num):SetText(0)
  else
    ;
    (self._soldOut):SetActive(false)
    if data.goodRemain == -1 then
      (self._num):SetText(tostring(99 .. "+"))
    else
      ;
      (self._num):SetText(tostring(data.goodRemain))
    end
  end
  if not data.beginTime or not data.endTime or data.beginTime == 0 or data.endTime == 0 then
    (self._limit):SetActive(false)
  else
    ;
    (self._limit):SetActive(true)
    ;
    (self._limit_txt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr(data.endTime))
  end
  self._lock = isLock(self)
  ;
  (self._lockIcon):SetActive(self._lock)
end

ShopItemCell.OnCellClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self._data).goodRemain == 0 then
    return 
  end
  if not self._lock then
    ((DialogManager.CreateSingletonDialog)("shop.itembuydialog")):SetData(self._data, ((self._delegate)._delegate)._selectShopId)
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100437, {self._nameStr, self._limitNum})
  end
end

return ShopItemCell

