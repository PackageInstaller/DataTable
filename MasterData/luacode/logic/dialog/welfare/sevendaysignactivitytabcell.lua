local Item = require("logic.manager.experimental.types.item")
local CTotalLoginActivity = BeanManager.GetTableByName("welfare.ctotalloginactivity")
local CWelfareTabCfg = BeanManager.GetTableByName("welfare.cwelfaretabconfig")
local CTotalLoginActivityShow = BeanManager.GetTableByName("welfare.ctotalloginactivityshow")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local dayImageRecordTable = {
  [1] = CImagePathTable:GetRecorder(13853),
  [2] = CImagePathTable:GetRecorder(13854),
  [3] = CImagePathTable:GetRecorder(13855),
  [4] = CImagePathTable:GetRecorder(13856),
  [5] = CImagePathTable:GetRecorder(13857),
  [6] = CImagePathTable:GetRecorder(13858),
  [7] = CImagePathTable:GetRecorder(13859)
}
local SevenDaySignActivityTabCell = class("SevenDaySignActivityTabCell", Dialog)
SevenDaySignActivityTabCell.AssetBundleName = "ui/layouts.welfare"
SevenDaySignActivityTabCell.AssetName = "SignActivity7Day"

function SevenDaySignActivityTabCell:Ctor(...)
  SevenDaySignActivityTabCell.super.Ctor(self, ...)
  self._init = false
  self._endTime = nil
  self._totalSignTimes = nil
  self._itemList = {}
end

function SevenDaySignActivityTabCell:OnCreate()
  self._backImage = self:GetChild("BackImage")
  self._titleImage = self:GetChild("BackImage/Title")
  self._tipsTxt = self:GetChild("BackImage/Txt")
  self._timeTxt = self:GetChild("BackImage/Time")
  self._normalCells = {}
  for i = 1, 7 do
    self._normalCells[i] = {}
    self._normalCells[i].index = i
    self._normalCells[i].cell = self:GetChild("BackImage/Cell" .. i)
    self._normalCells[i].back1 = self:GetChild("BackImage/Cell" .. i .. "/Back1")
    self._normalCells[i].back2 = self:GetChild("BackImage/Cell" .. i .. "/Back2")
    self._normalCells[i].grey = self:GetChild("BackImage/Cell" .. i .. "/Grey")
    self._normalCells[i].get = self:GetChild("BackImage/Cell" .. i .. "/Get")
    self._normalCells[i].select = self:GetChild("BackImage/Cell" .. i .. "/Select")
    self._normalCells[i].dayImage = self:GetChild("BackImage/Cell" .. i .. "/Day/Image")
    self._normalCells[i].rank = self:GetChild("BackImage/Cell" .. i .. "/Rank")
    self._normalCells[i].icon = self:GetChild("BackImage/Cell" .. i .. "/Icon")
    self._normalCells[i].iconGrey = self:GetChild("BackImage/Cell" .. i .. "/IconGrey")
    self._normalCells[i].num = self:GetChild("BackImage/Cell" .. i .. "/Num")
    self._normalCells[i].checkMark = self:GetChild("BackImage/Cell" .. i .. "/CheckMark")
    self._normalCells[i].effect = self:GetChild("BackImage/Cell" .. i .. "/Effect")
    self._normalCells[i].effect_handler = nil
    self._normalCells[i].cell:Subscribe_PointerClickEvent(function()
      self:OnCellClick(i)
    end)
    self._normalCells[i].effect:Subscribe_UIEffectEndEvent(function(effectHandler, window)
      self:OnEffectEnd(i, effectHandler, window)
    end)
  end
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

function SevenDaySignActivityTabCell:OnDestroy()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  LuaNotificationCenter.RemoveObserver(self)
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
end

function SevenDaySignActivityTabCell:SetNodeActive(cell, get, select, grey)
  cell.grey:SetActive(grey)
  cell.select:SetActive(select)
  cell.get:SetActive(get)
  cell.icon:SetActive(not get)
  cell.iconGrey:SetActive(get)
  cell.checkMark:SetActive(get)
end

function SevenDaySignActivityTabCell:PlayEnableReceiveEffect()
  for i, v in ipairs(self._normalCells) do
    local dataTmp = self._itemList[i]
    if not dataTmp.receive and dataTmp.index <= self._totalSignTimes then
      v.effect_handler = v.effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1137))
    end
  end
end

function SevenDaySignActivityTabCell:RefreshTabCell(activityId, refresh, refreshByProtocol)
  self._totalCellShow = CTotalLoginActivityShow:GetRecorder(activityId)
  local tag
  if not self._init or not refresh then
    self._rootWindow:PlayAnimation("SignActivity")
    tag = true
  end
  self._activityId = activityId
  if NekoData.BehaviorManager.BM_Activity:HasActivity(activityId) then
    if not self._init or refresh then
      local data = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivityById(activityId)
      if not self._init then
        self._init = true
        local activityRecord = CTotalLoginActivity:GetRecorder(activityId)
        self._tipsTxt:SetText(TextManager.GetText(activityRecord.description))
        local imageRecord = CImagePathTable:GetRecorder(activityRecord.bgImage) or DataCommon.DefaultImageAsset
        self._backImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        imageRecord = CImagePathTable:GetRecorder(activityRecord.titleImage) or DataCommon.DefaultImageAsset
        self._titleImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      self._totalSignTimes = data.totalSignNum
      self._itemList = data.awards
      for index, value in ipairs(self._itemList) do
        value.extraCfg = string.split(self._totalCellShow.reward[index], ";")
      end
      for i, v in ipairs(self._normalCells) do
        local dataTmp = self._itemList[i]
        if v.effect_handler then
          v.effect:ReleaseEffect(v.effect_handler)
          v.effect_handler = nil
        end
        local imageRecord = dayImageRecordTable[v.index] or DataCommon.DefaultImageAsset
        v.dayImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        if dataTmp.receive then
          self:SetNodeActive(v, true, false, false)
        elseif dataTmp.index <= self._totalSignTimes then
          self:SetNodeActive(v, false, true, false)
          if not tag and refreshByProtocol then
            DialogManager.CreateSingletonDialog("guide.blockclickdialog")
            self:PlayEnableReceiveEffect()
          elseif tag and self._delegate._selectedTab == self._activityId then
            DialogManager.CreateSingletonDialog("guide.blockclickdialog")
          end
        else
          self:SetNodeActive(v, false, false, false)
        end
        local item = Item.Create(dataTmp.itemId)
        local imgRecord = item:GetIcon()
        v.icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
        v.iconGrey:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
        v.num:SetText(NekoData.BehaviorManager.BM_Message:GetString(1475, {
          NumberManager.GetShowNumber(dataTmp.itemNum)
        }))
        imgRecord = item:GetShopPinJiBackGroundImage()
        v.rank:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
        local imageRecord = CImagePathTable:GetRecorder(tonumber(dataTmp.extraCfg[1])) or DataCommon.DefaultImageAsset
        v.back1:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        v.back1:SetActive(true)
        v.back2:SetActive(false)
      end
      self._endTime = NekoData.BehaviorManager.BM_Activity:GetEndTime(self._activityId)
      self:RefreshTime()
      if not self._activityTask then
        self._activityTask = GameTimer.AddTask(0, 60, function()
          self:RefreshTime()
        end)
      end
    end
  elseif self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
end

function SevenDaySignActivityTabCell:OnCellClick(index)
  local data = self._itemList[index]
  local width, height = self:GetRootWindow():GetRectSize()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = Item.Create(data.itemId)
    })
    dialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

function SevenDaySignActivityTabCell:GetCanGetFirstIndex()
  for i, v in ipairs(self._itemList) do
    if not v.receive and v.index <= self._totalSignTimes then
      return i
    end
  end
end

function SevenDaySignActivityTabCell:RefreshTime()
  if self._endTime then
    local time = (self._endTime - ServerGameTimer.GetServerTimeForecast()) / 1000
    local day = math.floor(time / 86400)
    local hour = math.floor((time - day * 24 * 60 * 60) / 3600)
    local min = math.floor((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = math.floor(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = TextManager.GetText(CStringRes:GetRecorder(1042).msgTextID)
    if 0 < day then
      local str1 = TextManager.GetText(CStringRes:GetRecorder(1043).msgTextID)
      self._timeTxt:SetText(str .. day .. str1)
    elseif 0 < hour then
      local str2 = TextManager.GetText(CStringRes:GetRecorder(1044).msgTextID)
      self._timeTxt:SetText(str .. hour .. str2)
    else
      local str3 = TextManager.GetText(CStringRes:GetRecorder(1045).msgTextID)
      self._timeTxt:SetText(str .. min .. str3)
    end
  end
end

function SevenDaySignActivityTabCell:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "SignActivty" then
    self:PlayEnableReceiveEffect()
  end
end

function SevenDaySignActivityTabCell:OnEffectEnd(index, window, effectHandler)
  self._normalCells[index].effect_handler = nil
  local allEffectsEnd = true
  for i, v in ipairs(self._normalCells) do
    if v.effect_handler then
      allEffectsEnd = false
      break
    end
  end
  if allEffectsEnd then
    DialogManager.DestroySingletonDialog("guide.blockclickdialog")
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceiveaward")
    protocol.actId = self._activityId
    protocol:Send()
  end
end

return SevenDaySignActivityTabCell
