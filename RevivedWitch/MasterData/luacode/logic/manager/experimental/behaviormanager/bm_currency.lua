-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_currency.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local BM_Currency = class("BM_Currency")
local CCurrencySymbol = (BeanManager.GetTableByName)("topup.ccurrencysymbol")
local HaveAddWaysCurrencyEnum = {[DataCommon.DiamodID] = true, [DataCommon.SpiritID] = true}
BM_Currency.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._currency = (NekoData.Data).currency
end

BM_Currency.GetCurrencyNum = function(self, currencyId)
  -- function num : 0_1
  return ((self._currency).moneyInfo)[currencyId] or 0
end

BM_Currency.GetMoney = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.ManaID] or 0
end

BM_Currency.GetDiamond = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.DiamodID] or 0
end

BM_Currency.GetFriendShip = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.FriendShipID] or 0
end

BM_Currency.GetSpirit = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.SpiritID] or 0
end

BM_Currency.GetEther = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.EtherID] or 0
end

BM_Currency.GetAgCoin = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.AgCoinID] or 0
end

BM_Currency.GetWhiteCoin = function(self)
  -- function num : 0_8 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.WhiteCoin] or 0
end

BM_Currency.GetGoldCoin = function(self)
  -- function num : 0_9 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.GoldCoin] or 0
end

BM_Currency.GetFurnitureCion = function(self)
  -- function num : 0_10 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.FurnitureCion] or 0
end

BM_Currency.GetFashionCoin = function(self)
  -- function num : 0_11 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.FashionID] or 0
end

BM_Currency.GetTowerCoin = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.TowerCoin] or 0
end

BM_Currency.GetPVPKeys = function(self)
  -- function num : 0_13 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.PVPKeys] or 0
end

BM_Currency.GetPVPCoin = function(self)
  -- function num : 0_14 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.PVPCoin] or 0
end

BM_Currency.GetSoulDropCoin = function(self)
  -- function num : 0_15 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.SoulDropID] or 0
end

BM_Currency.GetGuildCoin = function(self)
  -- function num : 0_16 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.GuildCoin] or 0
end

BM_Currency.GetMemoryPieces = function(self)
  -- function num : 0_17 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.MemoryPieces] or 0
end

BM_Currency.GetLoveCarefullyPreparedGift = function(self)
  -- function num : 0_18 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.LoveCarefullyPreparedGift] or 0
end

BM_Currency.GetNextSpiritLeftTime = function(self)
  -- function num : 0_19
  return (self._currency).nextSpiritLeftTime
end

BM_Currency.GetSpiritRecoverTimes = function(self)
  -- function num : 0_20
  if not (self._currency).spiritRecoverTimes then
    return {}
  end
end

BM_Currency.GetSpiritFull = function(self)
  -- function num : 0_21 , upvalues : _ENV
  return (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
end

BM_Currency.IsDiamodEnough = function(self, num)
  -- function num : 0_22
  do return num <= self:GetDiamond() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Currency.IsSpiritEnough = function(self, num)
  -- function num : 0_23
  do return num <= self:GetSpirit() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Currency.IsSoulDropEnough = function(self, num)
  -- function num : 0_24
  do return num <= self:GetSoulDropCoin() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Currency.IsCurrencyEnough = function(self, currencyId, num)
  -- function num : 0_25
  do return num <= ((self._currency).moneyInfo)[currencyId] end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Currency.RequestOpenAddCurrencyDlg = function(self, currencyId)
  -- function num : 0_26 , upvalues : _ENV
  if currencyId == DataCommon.SpiritID then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
    return 
  else
    if currencyId == DataCommon.SpringFestivalFu then
      (DialogManager.CreateSingletonDialog)("activity.springfestival.spiritrecoverdialog")
      return 
    end
  end
end

BM_Currency.GetAP = function(self)
  -- function num : 0_27 , upvalues : _ENV
  return ((self._currency).moneyInfo)[DataCommon.APID] or 0
end

BM_Currency.IsCurrency = function(self, id)
  -- function num : 0_28
  if ((self._currency).moneyInfo)[id] then
    return true
  end
  return false
end

BM_Currency.AddCurrencyById = function(self, currencyId)
  -- function num : 0_29 , upvalues : _ENV
  if currencyId == DataCommon.DiamodID then
    ((NekoData.BehaviorManager).BM_Shop):JumpToShopBuyDiamonds()
  else
    if currencyId == DataCommon.SpiritID then
      ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
    end
  end
end

BM_Currency.HaveAddWays = function(self, currencyId)
  -- function num : 0_30 , upvalues : HaveAddWaysCurrencyEnum
  return HaveAddWaysCurrencyEnum[currencyId]
end

BM_Currency.IsRealityCurrency = function(self, id)
  -- function num : 0_31 , upvalues : CCurrencySymbol, _ENV
  local allIds = CCurrencySymbol:GetAllIds()
  if id then
    return (table.contain)(allIds, id)
  end
end

BM_Currency.GetRealityCurrencySymbol = function(self, id)
  -- function num : 0_32 , upvalues : CCurrencySymbol
  local recoder = CCurrencySymbol:GetRecorder(id)
  if recoder then
    return recoder.symbol
  end
  return ""
end

return BM_Currency

