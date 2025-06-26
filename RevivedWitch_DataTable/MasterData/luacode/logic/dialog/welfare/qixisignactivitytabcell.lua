-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/qixisignactivitytabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CTotalLoginActivity = (BeanManager.GetTableByName)("welfare.ctotalloginactivity")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local QiXiSignActivityTabCell = class("QiXiSignActivityTabCell", Dialog)
QiXiSignActivityTabCell.AssetBundleName = "ui/layouts.welfare"
QiXiSignActivityTabCell.AssetName = "SignActivityQixi"
QiXiSignActivityTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : QiXiSignActivityTabCell
  ((QiXiSignActivityTabCell.super).Ctor)(self, ...)
  self._init = false
  self._itemList = {}
  self._totalSignTimes = nil
  self._endTime = nil
end

QiXiSignActivityTabCell.OnCreate = function(self)
  -- function num : 0_1
  self._backImg = self:GetChild("BackImage")
  self._description = self:GetChild("BackImage/Txt")
  self._timeTxt = self:GetChild("BackImage/Time")
  self._leftArrow = self:GetChild("BackImage/Left")
  self._rightArrow = self:GetChild("BackImage/Right")
  self._normalCells = {}
  for i = 1, 7 do
    do
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

      (self._normalCells)[i] = {}
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).index = i
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).cell = self:GetChild("BackImage/Cell" .. i)
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).select = self:GetChild("BackImage/Cell" .. i .. "/Select")
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).dayText = self:GetChild("BackImage/Cell" .. i .. "/Day")
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).icon = self:GetChild("BackImage/Cell" .. i .. "/Icon")
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).iconGrey = self:GetChild("BackImage/Cell" .. i .. "/IconGrey")
      -- DECOMPILER ERROR at PC84: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).num = self:GetChild("BackImage/Cell" .. i .. "/Num")
      -- DECOMPILER ERROR at PC93: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).grey = self:GetChild("BackImage/Cell" .. i .. "/Grey")
      -- DECOMPILER ERROR at PC102: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).get = self:GetChild("BackImage/Cell" .. i .. "/Get")
      -- DECOMPILER ERROR at PC111: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).getIcon = self:GetChild("BackImage/Cell" .. i .. "/CheckMark")
      -- DECOMPILER ERROR at PC120: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).rank = self:GetChild("BackImage/Cell" .. i .. "/Rank")
      -- DECOMPILER ERROR at PC129: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).effect = self:GetChild("BackImage/Cell" .. i .. "/Effect")
      -- DECOMPILER ERROR at PC132: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).effect_handler = nil
      ;
      (((self._normalCells)[i]).cell):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnCellClick(i)
  end
)
      ;
      (((self._normalCells)[i]).effect):Subscribe_UIEffectEndEvent(function(effectHandler, window)
    -- function num : 0_1_1 , upvalues : self, i
    self:OnEffectEnd(i, effectHandler, window)
  end
)
    end
  end
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

QiXiSignActivityTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._activityTask then
    (GameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
end

local SetNodeActive = function(cell, get, select, grey)
  -- function num : 0_3
  (cell.get):SetActive(get)
  ;
  (cell.getIcon):SetActive(get)
  ;
  (cell.icon):SetActive(not get)
  ;
  (cell.iconGrey):SetActive(get)
  ;
  (cell.select):SetActive(select)
  ;
  (cell.grey):SetActive(grey)
end

local PlayEnableReceiveEffect = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for i,v in ipairs(self._normalCells) do
    local dataTmp = (self._itemList)[i]
    if not dataTmp.receive and dataTmp.index <= self._totalSignTimes then
      v.effect_handler = (v.effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1137))
    end
  end
end

QiXiSignActivityTabCell.RefreshTabCell = function(self, activityId, refresh, refreshByProtocol)
  -- function num : 0_5 , upvalues : _ENV, CTotalLoginActivity, CImagePathTable, SetNodeActive, PlayEnableReceiveEffect, Item
  local tag = nil
  if not self._init or not refresh then
    (self._rootWindow):PlayAnimation("SignActivity")
    tag = true
  end
  self._activityId = activityId
  if ((NekoData.BehaviorManager).BM_Activity):HasActivity(activityId) and (not self._init or refresh) then
    local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetSignActivityById(activityId)
    if not self._init then
      self._init = true
      local activityRecord = CTotalLoginActivity:GetRecorder(activityId)
      ;
      (self._description):SetText((TextManager.GetText)(activityRecord.description))
      if not CImagePathTable:GetRecorder(activityRecord.bgImage) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._backImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    do
      do
        self._totalSignTimes = data.totalSignNum
        self._itemList = data.awards
        for i,v in ipairs(self._normalCells) do
          local dataTmp = (self._itemList)[i]
          if v.effect_handler then
            (v.effect):ReleaseEffect(v.effect_handler)
            v.effect_handler = nil
          end
          ;
          (v.dayText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1062, {dataTmp.index}))
          if dataTmp.receive then
            SetNodeActive(v, true, false, false)
          else
            if dataTmp.index <= self._totalSignTimes then
              SetNodeActive(v, false, true, false)
              if not tag and refreshByProtocol then
                (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
                PlayEnableReceiveEffect(self)
              else
                if tag and (self._delegate)._selectedTab == self._activityId then
                  (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
                end
              end
            else
              SetNodeActive(v, false, false, false)
            end
          end
          local item = (Item.Create)(dataTmp.itemId)
          local imgRecord = item:GetIcon()
          ;
          (v.icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
          ;
          (v.iconGrey):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
          ;
          (v.num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1475, {dataTmp.itemNum}))
          imgRecord = item:GetShopPinJiBackGroundImage()
          ;
          (v.rank):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
        end
        self._endTime = ((NekoData.BehaviorManager).BM_Activity):GetEndTime(self._activityId)
        self:RefreshTime()
        if not self._activityTask then
          self._activityTask = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_5_0 , upvalues : self
    self:RefreshTime()
  end
)
        end
        if self._activityTask then
          (GameTimer.RemoveTask)(self._activityTask)
          self._activityTask = nil
        end
      end
    end
  end
end

QiXiSignActivityTabCell.OnCellClick = function(self, index)
  -- function num : 0_6 , upvalues : _ENV, Item
  local data = (self._itemList)[index]
  local width, height = (self:GetRootWindow()):GetRectSize()
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = (Item.Create)(data.itemId)})
    dialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

QiXiSignActivityTabCell.GetCanGetFirstIndex = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for i,v in ipairs(self._itemList) do
    if not v.receive and v.index <= self._totalSignTimes then
      return i
    end
  end
end

QiXiSignActivityTabCell.RefreshTime = function(self)
  -- function num : 0_8 , upvalues : _ENV, CStringRes
  if self._endTime then
    local time = (self._endTime - (ServerGameTimer.GetServerTimeForecast)()) / 1000
    local day = (math.floor)(time / 86400)
    local hour = (math.floor)((time - day * 24 * 60 * 60) / 3600)
    local min = (math.floor)((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = (math.floor)(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1042)).msgTextID)
    if day > 0 then
      local str1 = (TextManager.GetText)((CStringRes:GetRecorder(1043)).msgTextID)
      ;
      (self._timeTxt):SetText(str .. day .. str1)
    else
      do
        if hour > 0 then
          local str2 = (TextManager.GetText)((CStringRes:GetRecorder(1044)).msgTextID)
          ;
          (self._timeTxt):SetText(str .. hour .. str2)
        else
          do
            local str3 = (TextManager.GetText)((CStringRes:GetRecorder(1045)).msgTextID)
            ;
            (self._timeTxt):SetText(str .. min .. str3)
          end
        end
      end
    end
  end
end

QiXiSignActivityTabCell.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_9 , upvalues : PlayEnableReceiveEffect
  if stateName == "SignActivty" then
    PlayEnableReceiveEffect(self)
  end
end

QiXiSignActivityTabCell.OnEffectEnd = function(self, index, window, effectHandler)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ((self._normalCells)[index]).effect_handler = nil
  local allEffectsEnd = true
  for i,v in ipairs(self._normalCells) do
    if v.effect_handler then
      allEffectsEnd = false
      break
    end
  end
  do
    if allEffectsEnd then
      (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
      local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceiveaward")
      protocol.actId = self._activityId
      protocol:Send()
    end
  end
end

return QiXiSignActivityTabCell

