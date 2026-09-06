local CStringRes = BeanManager.GetTableByName("message.cstringres")
local BM_Currency = class("BM_Currency")
local CCurrencySymbol = BeanManager.GetTableByName("topup.ccurrencysymbol")
local HaveAddWaysCurrencyEnum = {
  [DataCommon.DiamodID] = true,
  [DataCommon.SpiritID] = true
}

function BM_Currency:Ctor()
  self._currency = NekoData.Data.currency
end

function BM_Currency:GetCurrencyNum(currencyId)
  return self._currency.moneyInfo[currencyId] or 0
end

function BM_Currency:GetMoney()
  return self._currency.moneyInfo[DataCommon.ManaID] or 0
end

function BM_Currency:GetDiamond()
  return self._currency.moneyInfo[DataCommon.DiamodID] or 0
end

function BM_Currency:GetFriendShip()
  return self._currency.moneyInfo[DataCommon.FriendShipID] or 0
end

function BM_Currency:GetSpirit()
  return self._currency.moneyInfo[DataCommon.SpiritID] or 0
end

function BM_Currency:GetEther()
  return self._currency.moneyInfo[DataCommon.EtherID] or 0
end

function BM_Currency:GetAgCoin()
  return self._currency.moneyInfo[DataCommon.AgCoinID] or 0
end

function BM_Currency:GetWhiteCoin()
  return self._currency.moneyInfo[DataCommon.WhiteCoin] or 0
end

function BM_Currency:GetGoldCoin()
  return self._currency.moneyInfo[DataCommon.GoldCoin] or 0
end

function BM_Currency:GetFurnitureCion()
  return self._currency.moneyInfo[DataCommon.FurnitureCion] or 0
end

function BM_Currency:GetFashionCoin()
  return self._currency.moneyInfo[DataCommon.FashionID] or 0
end

function BM_Currency:GetTowerCoin()
  return self._currency.moneyInfo[DataCommon.TowerCoin] or 0
end

function BM_Currency:GetPVPKeys()
  return self._currency.moneyInfo[DataCommon.PVPKeys] or 0
end

function BM_Currency:GetPVPCoin()
  return self._currency.moneyInfo[DataCommon.PVPCoin] or 0
end

function BM_Currency:GetSoulDropCoin()
  return self._currency.moneyInfo[DataCommon.SoulDropID] or 0
end

function BM_Currency:GetGuildCoin()
  return self._currency.moneyInfo[DataCommon.GuildCoin] or 0
end

function BM_Currency:GetMemoryPieces()
  return self._currency.moneyInfo[DataCommon.MemoryPieces] or 0
end

function BM_Currency:GetLoveCarefullyPreparedGift()
  return self._currency.moneyInfo[DataCommon.LoveCarefullyPreparedGift] or 0
end

function BM_Currency:GetNextSpiritLeftTime()
  return self._currency.nextSpiritLeftTime
end

function BM_Currency:GetSpiritRecoverTimes()
  return self._currency.spiritRecoverTimes or {}
end

function BM_Currency:GetSpiritFull()
  return NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
end

function BM_Currency:IsDiamodEnough(num)
  return num <= self:GetDiamond()
end

function BM_Currency:IsSpiritEnough(num)
  return num <= self:GetSpirit()
end

function BM_Currency:IsSoulDropEnough(num)
  return num <= self:GetSoulDropCoin()
end

function BM_Currency:IsCurrencyEnough(currencyId, num)
  return num <= self._currency.moneyInfo[currencyId]
end

function BM_Currency:RequestOpenAddCurrencyDlg(currencyId)
  if currencyId == DataCommon.SpiritID then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
    return
  elseif currencyId == DataCommon.SpringFestivalFu then
    DialogManager.CreateSingletonDialog("activity.springfestival.spiritrecoverdialog")
    return
  end
end

function BM_Currency:GetAP()
  return self._currency.moneyInfo[DataCommon.APID] or 0
end

function BM_Currency:IsCurrency(id)
  if self._currency.moneyInfo[id] then
    return true
  end
  return false
end

function BM_Currency:AddCurrencyById(currencyId)
  if currencyId == DataCommon.DiamodID then
    NekoData.BehaviorManager.BM_Shop:JumpToShopBuyDiamonds()
  elseif currencyId == DataCommon.SpiritID then
    NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

function BM_Currency:HaveAddWays(currencyId)
  return HaveAddWaysCurrencyEnum[currencyId]
end

function BM_Currency:IsRealityCurrency(id)
  local allIds = CCurrencySymbol:GetAllIds()
  return id and table.contain(allIds, id)
end

function BM_Currency:GetRealityCurrencySymbol(id)
  local recoder = CCurrencySymbol:GetRecorder(id)
  if recoder then
    return recoder.symbol
  end
  return ""
end

return BM_Currency
