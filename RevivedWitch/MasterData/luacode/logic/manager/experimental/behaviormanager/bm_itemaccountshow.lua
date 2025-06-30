-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_itemaccountshow.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_ItemAccountShow = class("BM_ItemAccountShow")
local AccountDialogMap = {["shop.monthcarddailyawarddialog"] = (DataCommon.ShowDialogType).MonthCardDailyAward, ["achievement.roleachievementgetshowdialog"] = (DataCommon.ShowDialogType).RoleAchievementGetShow, ["bag.itemaccountdialog"] = (DataCommon.ShowDialogType).ItemAccount, ["base.maincityfirstawarddialog"] = (DataCommon.ShowDialogType).MainCityFirstAward, ["base.maincityaccountdialog"] = (DataCommon.ShowDialogType).MainCityAccount, ["traincamp.trainaccountdialog"] = (DataCommon.ShowDialogType).TrainAccount, ["gacha.gachamoviedialog"] = (DataCommon.ShowDialogType).GainRole, ["shop.fashionbuyresultdialog"] = (DataCommon.ShowDialogType).GainRoleSkin, ["uniqueequip.uniqueequipunlockdialog"] = (DataCommon.ShowDialogType).UniqueEquipUnlock}
BM_ItemAccountShow.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._itemAccountData = (NekoData.Data).itemAccountData
  self._cacheItemAccountData = (NekoData.Data).cacheItemAccountData
  self._dm = (NekoData.DataManager).DM_ItemAccountShow
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSingletonDialogDestroy, Common.n_SingletonDialogDestroy, nil)
end

local CanOpenNextShowDialog = function(tag)
  -- function num : 0_1 , upvalues : _ENV
  if tag == (DataCommon.ShowDialogType).MonthCardDailyAward or tag == (DataCommon.ShowDialogType).RoleAchievementGetShow or tag == (DataCommon.ShowDialogType).ItemAccount or tag == (DataCommon.ShowDialogType).GainRoleSkin then
    if (DialogManager.GetDialog)("shop.monthcarddailyawarddialog") then
      return false
    end
    if (DialogManager.GetDialog)("achievement.roleachievementgetshowdialog") then
      return false
    end
    if (DialogManager.GetDialog)("bag.itemaccountdialog") then
      return false
    end
    if (DialogManager.GetDialog)("shop.fashionbuyresultdialog") then
      return false
    end
    if tag == (DataCommon.ShowDialogType).ItemAccount and not (DialogManager.GetDialog)("gacha.gachamaindialog") and (DialogManager.GetDialog)("gacha.gachamoviedialog") then
      return false
    end
  else
    if tag == (DataCommon.ShowDialogType).MainCityFirstAward or tag == (DataCommon.ShowDialogType).MainCityAccount then
      if (DialogManager.GetDialog)("base.maincityfirstawarddialog") then
        return false
      end
      if (DialogManager.GetDialog)("base.maincityaccountdialog") then
        return false
      end
    else
      if tag == (DataCommon.ShowDialogType).TrainAccount and (DialogManager.GetDialog)("traincamp.trainaccountdialog") then
        return false
      end
    end
  end
  if tag == (DataCommon.ShowDialogType).GainRole then
    if (DialogManager.GetDialog)("gacha.gachamoviedialog") then
      return false
    end
    if (DialogManager.GetDialog)("bag.itemaccountdialog") then
      return false
    end
  else
    if tag == (DataCommon.ShowDialogType).UniqueEquipUnlock and (DialogManager.GetDialog)("uniqueequip.uniqueequipunlockdialog") then
      return false
    end
  end
  if tag == (DataCommon.ShowDialogType).AprilFoolsDayActivityItems and (DialogManager.GetDialog)("bag.itemaccountdialog") then
    return false
  end
  return true
end

BM_ItemAccountShow.OnSingletonDialogDestroy = function(self, notification)
  -- function num : 0_2 , upvalues : AccountDialogMap, _ENV
  local dialogName = (notification.userInfo)._dialogName
  if dialogName and AccountDialogMap[dialogName] and not ((NekoData.BehaviorManager).BM_Game):GetClosedClient() then
    self:ShowAccountOrReward()
  end
end

BM_ItemAccountShow.ShowAccountOrReward = function(self)
  -- function num : 0_3 , upvalues : _ENV, CanOpenNextShowDialog
  if not ((NekoData.BehaviorManager).BM_Game):GetClosedClient() then
    local value = (self._itemAccountData)[1]
    if value and CanOpenNextShowDialog(value.tag) then
      if value.tag == (DataCommon.ShowDialogType).MonthCardDailyAward then
        ((DialogManager.CreateSingletonDialog)("shop.monthcarddailyawarddialog")):SetData(value.data)
      else
        if value.tag == (DataCommon.ShowDialogType).RoleAchievementGetShow then
          ((DialogManager.CreateSingletonDialog)("achievement.roleachievementgetshowdialog")):SetData(value.data)
        else
          if value.tag == (DataCommon.ShowDialogType).ItemAccount then
            ((DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")):LoadData(value.data)
          else
            if value.tag == (DataCommon.ShowDialogType).MainCityFirstAward then
              ((DialogManager.CreateSingletonDialog)("base.maincityfirstawarddialog")):SetData(value.data)
            else
              if value.tag == (DataCommon.ShowDialogType).MainCityAccount then
                ((DialogManager.CreateSingletonDialog)("base.maincityaccountdialog")):SetData(value.data)
              else
                if value.tag == (DataCommon.ShowDialogType).TrainAccount then
                  ((DialogManager.CreateSingletonDialog)("traincamp.trainaccountdialog")):SetData(value.data)
                else
                  if value.tag == (DataCommon.ShowDialogType).GainRole then
                    ((DialogManager.CreateSingletonDialog)("gacha.gachamoviedialog")):DisplaySpecialCard(value.data)
                  else
                    if value.tag == (DataCommon.ShowDialogType).GainRoleSkin then
                      ((DialogManager.CreateSingletonDialog)("shop.fashionbuyresultdialog")):SetData(value.data)
                    else
                      if value.tag == (DataCommon.ShowDialogType).UniqueEquipUnlock then
                        ((DialogManager.CreateSingletonDialog)("uniqueequip.uniqueequipunlockdialog")):SetData(value.data)
                      else
                        if value.tag == (DataCommon.ShowDialogType).AprilFoolsDayActivityItems then
                          local dialog = (DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolsgottensecondconfirmdialog")
                          if dialog then
                            dialog:SetData((dialog.ShowDialogType).Item, value.data)
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      do
        ;
        (table.remove)(self._itemAccountData, 1)
      end
    end
  end
end

BM_ItemAccountShow.DataListIsEmpty = function(self)
  -- function num : 0_4 , upvalues : _ENV
  do return next(self._itemAccountData) == nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_ItemAccountShow.AddShowDialogDataFromCache = function(self, type)
  -- function num : 0_5 , upvalues : _ENV
  local indexList = {}
  for i,v in ipairs(self._cacheItemAccountData) do
    if v.tag and v.tag == type then
      (self._dm):AddShowDialogData(v)
      ;
      (table.insert)(indexList, i)
    end
  end
  do
    while indexList[#indexList] do
      (table.remove)(self._cacheItemAccountData, indexList[#indexList])
      ;
      (table.remove)(indexList, #indexList)
    end
  end
end

BM_ItemAccountShow.GetShowDialogDataFromCache = function(self, type)
  -- function num : 0_6 , upvalues : _ENV
  for i,v in ipairs(self._cacheItemAccountData) do
    if v.tag and v.tag == type then
      return true
    end
  end
end

return BM_ItemAccountShow

