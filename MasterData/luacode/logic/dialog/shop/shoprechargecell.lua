-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shoprechargecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ShopRechargeCell = class("ShopRechargeCell", Dialog)
ShopRechargeCell.AssetBundleName = "ui/layouts.baseshop"
ShopRechargeCell.AssetName = "RechargeShopCell"
ShopRechargeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopRechargeCell
  ((ShopRechargeCell.super).Ctor)(self, ...)
end

ShopRechargeCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._effect = self:GetChild("CellBack/Effect")
  self._back1 = self:GetChild("CellBack/Back1")
  self._back2 = self:GetChild("CellBack/Back2")
  self._img = self:GetChild("CellBack/MonthCardImg")
  self._name = self:GetChild("CellBack/ItemName")
  self._giveBoard = self:GetChild("CellBack/Give")
  self._giveTxt = self:GetChild("CellBack/Give/Text")
  self._giveImage = self:GetChild("CellBack/Give/Image")
  self._giveNum = self:GetChild("CellBack/Give/Num")
  ;
  (self._giveTxt):SetText((TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1176)).msgTextID))
  self._priceType = self:GetChild("CellBack/Price/RMB")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._topShow = {}
  for i = 1, 4 do
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

    (self._topShow)[i] = {}
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R5 in 'UnsetPending'

    if i == 1 then
      ((self._topShow)[i]).image = self:GetChild("CellBack/Show/Image")
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._topShow)[i]).num = self:GetChild("CellBack/Show/Text")
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._topShow)[i]).board = self:GetChild("CellBack/Show")
    else
      -- DECOMPILER ERROR at PC96: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._topShow)[i]).image = self:GetChild("CellBack/Show" .. R9_PC94 .. "/Image")
      -- DECOMPILER ERROR at PC105: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._topShow)[i]).num = self:GetChild("CellBack/Show" .. R9_PC94 .. "/Text")
      -- DECOMPILER ERROR at PC110: Overwrote pending register: R9 in 'AssignReg'

      -- DECOMPILER ERROR at PC113: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._topShow)[i]).board = self:GetChild("CellBack/Show" .. R9_PC94)
    end
  end
  self._doubleBoard = self:GetChild("CellBack/Double")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopRechargeCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._visiualEffectHandler then
    (self._effect):ReleaseEffect(self._visiualEffectHandler)
    self._visiualEffectHandler = nil
  end
end

ShopRechargeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable
  self._data = data
  ;
  (self._back1):SetActive((self._data).isLastDiamondCell)
  ;
  (self._back2):SetActive(not (self._data).isLastDiamondCell)
  ;
  (self._soldOut):SetActive(((self._data).iteminfo).goodRemain == 0)
  if ((self._data).iteminfo).freeDiamondSum <= 0 then
    (self._doubleBoard):SetActive(((self._data).iteminfo).goodType ~= 12)
    if ((self._data).iteminfo).goodType == 11 then
      (self._doubleBoard):SetActive(false)
    else
      (self._doubleBoard):SetActive(false)
      LogErrorFormat("ShopRechargeCell", "钻石购买发现 goodType 为 11、12 之外的值！[goodType=%d]", ((self._data).iteminfo).goodType)
    end
    if ((self._data).iteminfo).freeDiamondSum > 0 then
      (self._giveBoard):SetActive(true)
      local imageRecord = CImagePathTable:GetRecorder(11421)
      ;
      (self._giveImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._giveNum):SetText(((self._data).iteminfo).freeDiamondSum)
    else
      (self._giveBoard):SetActive(false)
    end
    ;
    (self._priceNum):SetText(((self._data).iteminfo).discountPrice)
    local imageRecord = CImagePathTable:GetRecorder(((self._data).iteminfo).pictureId)
    ;
    (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._name):SetText((TextManager.GetText)(((self._data).iteminfo).goodName))
    imageRecord = CImagePathTable:GetRecorder(11421)
    for i = 1, 4 do
      local le = (string.len)(tostring(((self._data).iteminfo).diamondSum))
      ;
      (((self._topShow)[i]).board):SetActive(le == i)
      ;
      (((self._topShow)[i]).num):SetText(((self._data).iteminfo).diamondSum)
      ;
      (((self._topShow)[i]).image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    if self._visiualEffectHandler then
      (self._effect):ReleaseEffect(self._visiualEffectHandler)
      self._visiualEffectHandler = nil
    end
    local effectID = ((self._data).iteminfo).visiualEffect
    if effectID ~= 0 then
      self._visiualEffectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(effectID))
    end
    -- DECOMPILER ERROR: 10 unprocessed JMP targets
  end
end

ShopRechargeCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
  if protocol then
    protocol.goodId = ((self._data).iteminfo).goodId
    protocol:Send()
  end
end

ShopRechargeCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "BuyGoodRefresh" and ((self._data).iteminfo).goodId == (arg.goodInfo).goodId then
    self:RefreshCell({iteminfo = arg.goodInfo, isLastDiamondCell = (self._data).isLastDiamondCell})
  end
end

return ShopRechargeCell

