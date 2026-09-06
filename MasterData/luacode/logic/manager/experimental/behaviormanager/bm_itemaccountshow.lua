local BM_ItemAccountShow = class("BM_ItemAccountShow")
local AccountDialogMap = {
  ["shop.monthcarddailyawarddialog"] = DataCommon.ShowDialogType.MonthCardDailyAward,
  ["achievement.roleachievementgetshowdialog"] = DataCommon.ShowDialogType.RoleAchievementGetShow,
  ["bag.itemaccountdialog"] = DataCommon.ShowDialogType.ItemAccount,
  ["base.maincityfirstawarddialog"] = DataCommon.ShowDialogType.MainCityFirstAward,
  ["base.maincityaccountdialog"] = DataCommon.ShowDialogType.MainCityAccount,
  ["traincamp.trainaccountdialog"] = DataCommon.ShowDialogType.TrainAccount,
  ["gacha.gachamoviedialog"] = DataCommon.ShowDialogType.GainRole,
  ["shop.fashionbuyresultdialog"] = DataCommon.ShowDialogType.GainRoleSkin,
  ["uniqueequip.uniqueequipunlockdialog"] = DataCommon.ShowDialogType.UniqueEquipUnlock
}

function BM_ItemAccountShow:Ctor()
  self._itemAccountData = NekoData.Data.itemAccountData
  self._cacheItemAccountData = NekoData.Data.cacheItemAccountData
  self._dm = NekoData.DataManager.DM_ItemAccountShow
  LuaNotificationCenter.AddObserver(self, self.OnSingletonDialogDestroy, Common.n_SingletonDialogDestroy, nil)
end

local function CanOpenNextShowDialog(tag)
  if tag == DataCommon.ShowDialogType.MonthCardDailyAward or tag == DataCommon.ShowDialogType.RoleAchievementGetShow or tag == DataCommon.ShowDialogType.ItemAccount or tag == DataCommon.ShowDialogType.GainRoleSkin then
    if DialogManager.GetDialog("shop.monthcarddailyawarddialog") then
      return false
    end
    if DialogManager.GetDialog("achievement.roleachievementgetshowdialog") then
      return false
    end
    if DialogManager.GetDialog("bag.itemaccountdialog") then
      return false
    end
    if DialogManager.GetDialog("shop.fashionbuyresultdialog") then
      return false
    end
    if tag == DataCommon.ShowDialogType.ItemAccount and not DialogManager.GetDialog("gacha.gachamaindialog") and DialogManager.GetDialog("gacha.gachamoviedialog") then
      return false
    end
  elseif tag == DataCommon.ShowDialogType.MainCityFirstAward or tag == DataCommon.ShowDialogType.MainCityAccount then
    if DialogManager.GetDialog("base.maincityfirstawarddialog") then
      return false
    end
    if DialogManager.GetDialog("base.maincityaccountdialog") then
      return false
    end
  elseif tag == DataCommon.ShowDialogType.TrainAccount then
    if DialogManager.GetDialog("traincamp.trainaccountdialog") then
      return false
    end
  elseif tag == DataCommon.ShowDialogType.GainRole then
    if DialogManager.GetDialog("gacha.gachamoviedialog") then
      return false
    end
    if DialogManager.GetDialog("bag.itemaccountdialog") then
      return false
    end
  elseif tag == DataCommon.ShowDialogType.UniqueEquipUnlock then
    if DialogManager.GetDialog("uniqueequip.uniqueequipunlockdialog") then
      return false
    end
  elseif tag == DataCommon.ShowDialogType.AprilFoolsDayActivityItems and DialogManager.GetDialog("bag.itemaccountdialog") then
    return false
  end
  return true
end

function BM_ItemAccountShow:OnSingletonDialogDestroy(notification)
  local dialogName = notification.userInfo._dialogName
  if dialogName and AccountDialogMap[dialogName] and not NekoData.BehaviorManager.BM_Game:GetClosedClient() then
    self:ShowAccountOrReward()
  end
end

function BM_ItemAccountShow:ShowAccountOrReward()
  if not NekoData.BehaviorManager.BM_Game:GetClosedClient() then
    local value = self._itemAccountData[1]
    if value and CanOpenNextShowDialog(value.tag) then
      if value.tag == DataCommon.ShowDialogType.MonthCardDailyAward then
        DialogManager.CreateSingletonDialog("shop.monthcarddailyawarddialog"):SetData(value.data)
      elseif value.tag == DataCommon.ShowDialogType.RoleAchievementGetShow then
        DialogManager.CreateSingletonDialog("achievement.roleachievementgetshowdialog"):SetData(value.data)
      elseif value.tag == DataCommon.ShowDialogType.ItemAccount then
        DialogManager.CreateSingletonDialog("bag.itemaccountdialog"):LoadData(value.data)
      elseif value.tag == DataCommon.ShowDialogType.MainCityFirstAward then
        DialogManager.CreateSingletonDialog("base.maincityfirstawarddialog"):SetData(value.data)
      elseif value.tag == DataCommon.ShowDialogType.MainCityAccount then
        DialogManager.CreateSingletonDialog("base.maincityaccountdialog"):SetData(value.data)
      elseif value.tag == DataCommon.ShowDialogType.TrainAccount then
        DialogManager.CreateSingletonDialog("traincamp.trainaccountdialog"):SetData(value.data)
      elseif value.tag == DataCommon.ShowDialogType.GainRole then
        DialogManager.CreateSingletonDialog("gacha.gachamoviedialog"):DisplaySpecialCard(value.data)
      elseif value.tag == DataCommon.ShowDialogType.GainRoleSkin then
        DialogManager.CreateSingletonDialog("shop.fashionbuyresultdialog"):SetData(value.data)
      elseif value.tag == DataCommon.ShowDialogType.UniqueEquipUnlock then
        DialogManager.CreateSingletonDialog("uniqueequip.uniqueequipunlockdialog"):SetData(value.data)
      elseif value.tag == DataCommon.ShowDialogType.AprilFoolsDayActivityItems then
        local dialog = DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
        if dialog then
          dialog:SetData(dialog.ShowDialogType.Item, value.data)
        end
      end
      table.remove(self._itemAccountData, 1)
    end
  end
end

function BM_ItemAccountShow:DataListIsEmpty()
  return next(self._itemAccountData) == nil
end

function BM_ItemAccountShow:AddShowDialogDataFromCache(type)
  local indexList = {}
  for i, v in ipairs(self._cacheItemAccountData) do
    if v.tag and v.tag == type then
      self._dm:AddShowDialogData(v)
      table.insert(indexList, i)
    end
  end
  while indexList[#indexList] do
    table.remove(self._cacheItemAccountData, indexList[#indexList])
    table.remove(indexList, #indexList)
  end
end

function BM_ItemAccountShow:GetShowDialogDataFromCache(type)
  for i, v in ipairs(self._cacheItemAccountData) do
    if v.tag and v.tag == type then
      return true
    end
  end
end

return BM_ItemAccountShow
