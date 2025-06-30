-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/sevendaysignactivitytabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CTotalLoginActivity = (BeanManager.GetTableByName)("welfare.ctotalloginactivity")
local CWelfareTabCfg = (BeanManager.GetTableByName)("welfare.cwelfaretabconfig")
local CTotalLoginActivityShow = (BeanManager.GetTableByName)("welfare.ctotalloginactivityshow")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local dayImageRecordTable = {[1] = CImagePathTable:GetRecorder(13853), [2] = CImagePathTable:GetRecorder(13854), [3] = CImagePathTable:GetRecorder(13855), [4] = CImagePathTable:GetRecorder(13856), [5] = CImagePathTable:GetRecorder(13857), [6] = CImagePathTable:GetRecorder(13858), [7] = CImagePathTable:GetRecorder(13859)}
local SevenDaySignActivityTabCell = class("SevenDaySignActivityTabCell", Dialog)
SevenDaySignActivityTabCell.AssetBundleName = "ui/layouts.welfare"
SevenDaySignActivityTabCell.AssetName = "SignActivity7Day"
SevenDaySignActivityTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SevenDaySignActivityTabCell
  ((SevenDaySignActivityTabCell.super).Ctor)(self, ...)
  self._init = false
  self._endTime = nil
  self._totalSignTimes = nil
  self._itemList = {}
end

SevenDaySignActivityTabCell.OnCreate = function(self)
  -- function num : 0_1
  self._backImage = self:GetChild("BackImage")
  self._titleImage = self:GetChild("BackImage/Title")
  self._tipsTxt = self:GetChild("BackImage/Txt")
  self._timeTxt = self:GetChild("BackImage/Time")
  self._normalCells = {}
  for i = 1, 7 do
    do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

      (self._normalCells)[i] = {}
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).index = i
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).cell = self:GetChild("BackImage/Cell" .. i)
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).back1 = self:GetChild("BackImage/Cell" .. i .. "/Back1")
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).back2 = self:GetChild("BackImage/Cell" .. i .. "/Back2")
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).grey = self:GetChild("BackImage/Cell" .. i .. "/Grey")
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).get = self:GetChild("BackImage/Cell" .. i .. "/Get")
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).select = self:GetChild("BackImage/Cell" .. i .. "/Select")
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).dayImage = self:GetChild("BackImage/Cell" .. i .. "/Day/Image")
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).rank = self:GetChild("BackImage/Cell" .. i .. "/Rank")
      -- DECOMPILER ERROR at PC107: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).icon = self:GetChild("BackImage/Cell" .. i .. "/Icon")
      -- DECOMPILER ERROR at PC116: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).iconGrey = self:GetChild("BackImage/Cell" .. i .. "/IconGrey")
      -- DECOMPILER ERROR at PC125: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).num = self:GetChild("BackImage/Cell" .. i .. "/Num")
      -- DECOMPILER ERROR at PC134: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).checkMark = self:GetChild("BackImage/Cell" .. i .. "/CheckMark")
      -- DECOMPILER ERROR at PC143: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._normalCells)[i]).effect = self:GetChild("BackImage/Cell" .. i .. "/Effect")
      -- DECOMPILER ERROR at PC146: Confused about usage of register: R5 in 'UnsetPending'

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

SevenDaySignActivityTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._activityTask then
    (GameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
end

SevenDaySignActivityTabCell.SetNodeActive = function(self, cell, get, select, grey)
  -- function num : 0_3
  (cell.grey):SetActive(grey)
  ;
  (cell.select):SetActive(select)
  ;
  (cell.get):SetActive(get)
  ;
  (cell.icon):SetActive(not get)
  ;
  (cell.iconGrey):SetActive(get)
  ;
  (cell.checkMark):SetActive(get)
end

SevenDaySignActivityTabCell.PlayEnableReceiveEffect = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for i,v in ipairs(self._normalCells) do
    local dataTmp = (self._itemList)[i]
    if not dataTmp.receive and dataTmp.index <= self._totalSignTimes then
      v.effect_handler = (v.effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1137))
    end
  end
end

SevenDaySignActivityTabCell.RefreshTabCell = function(self, activityId, refresh, refreshByProtocol)
  -- function num : 0_5 , upvalues : CTotalLoginActivityShow, _ENV, CTotalLoginActivity, CImagePathTable, dayImageRecordTable, Item
  self._totalCellShow = CTotalLoginActivityShow:GetRecorder(activityId)
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
      (self._tipsTxt):SetText((TextManager.GetText)(activityRecord.description))
      if not CImagePathTable:GetRecorder(activityRecord.bgImage) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._backImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      if not CImagePathTable:GetRecorder(activityRecord.titleImage) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._titleImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    do
      do
        self._totalSignTimes = data.totalSignNum
        self._itemList = data.awards
        for index,value in ipairs(self._itemList) do
          value.extraCfg = (string.split)(((self._totalCellShow).reward)[index], ";")
        end
        for i,v in ipairs(self._normalCells) do
          local dataTmp = (self._itemList)[i]
          if v.effect_handler then
            (v.effect):ReleaseEffect(v.effect_handler)
            v.effect_handler = nil
          end
          if not dayImageRecordTable[v.index] then
            local imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (v.dayImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          if dataTmp.receive then
            self:SetNodeActive(v, true, false, false)
          else
            if dataTmp.index <= self._totalSignTimes then
              self:SetNodeActive(v, false, true, false)
              if not tag and refreshByProtocol then
                (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
                self:PlayEnableReceiveEffect()
              else
                if tag and (self._delegate)._selectedTab == self._activityId then
                  (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
                end
              end
            else
              self:SetNodeActive(v, false, false, false)
            end
          end
          local item = (Item.Create)(dataTmp.itemId)
          local imgRecord = item:GetIcon()
          ;
          (v.icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
          ;
          (v.iconGrey):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
          ;
          (v.num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1475, {(NumberManager.GetShowNumber)(dataTmp.itemNum)}))
          imgRecord = item:GetShopPinJiBackGroundImage()
          ;
          (v.rank):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
          if not CImagePathTable:GetRecorder(tonumber((dataTmp.extraCfg)[1])) then
            local imageRecord = DataCommon.DefaultImageAsset
          end
          ;
          (v.back1):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          (v.back1):SetActive(true)
          ;
          (v.back2):SetActive(false)
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

SevenDaySignActivityTabCell.OnCellClick = function(self, index)
  -- function num : 0_6 , upvalues : _ENV, Item
  local data = (self._itemList)[index]
  local width, height = (self:GetRootWindow()):GetRectSize()
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = (Item.Create)(data.itemId)})
    dialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

SevenDaySignActivityTabCell.GetCanGetFirstIndex = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for i,v in ipairs(self._itemList) do
    if not v.receive and v.index <= self._totalSignTimes then
      return i
    end
  end
end

SevenDaySignActivityTabCell.RefreshTime = function(self)
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

SevenDaySignActivityTabCell.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_9
  if stateName == "SignActivty" then
    self:PlayEnableReceiveEffect()
  end
end

SevenDaySignActivityTabCell.OnEffectEnd = function(self, index, window, effectHandler)
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

return SevenDaySignActivityTabCell

