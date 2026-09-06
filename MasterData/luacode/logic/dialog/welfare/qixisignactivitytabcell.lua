local CTotalLoginActivity = BeanManager.GetTableByName("welfare.ctotalloginactivity")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local QiXiSignActivityTabCell = class("QiXiSignActivityTabCell", Dialog)
QiXiSignActivityTabCell.AssetBundleName = "ui/layouts.welfare"
QiXiSignActivityTabCell.AssetName = "SignActivityQixi"

function QiXiSignActivityTabCell:Ctor(...)
  QiXiSignActivityTabCell.super.Ctor(self, ...)
  self._init = false
  self._itemList = {}
  self._totalSignTimes = nil
  self._endTime = nil
end

function QiXiSignActivityTabCell:OnCreate()
  self._backImg = self:GetChild("BackImage")
  self._description = self:GetChild("BackImage/Txt")
  self._timeTxt = self:GetChild("BackImage/Time")
  self._leftArrow = self:GetChild("BackImage/Left")
  self._rightArrow = self:GetChild("BackImage/Right")
  self._normalCells = {}
  for i = 1, 7 do
    self._normalCells[i] = {}
    self._normalCells[i].index = i
    self._normalCells[i].cell = self:GetChild("BackImage/Cell" .. i)
    self._normalCells[i].select = self:GetChild("BackImage/Cell" .. i .. "/Select")
    self._normalCells[i].dayText = self:GetChild("BackImage/Cell" .. i .. "/Day")
    self._normalCells[i].icon = self:GetChild("BackImage/Cell" .. i .. "/Icon")
    self._normalCells[i].iconGrey = self:GetChild("BackImage/Cell" .. i .. "/IconGrey")
    self._normalCells[i].num = self:GetChild("BackImage/Cell" .. i .. "/Num")
    self._normalCells[i].grey = self:GetChild("BackImage/Cell" .. i .. "/Grey")
    self._normalCells[i].get = self:GetChild("BackImage/Cell" .. i .. "/Get")
    self._normalCells[i].getIcon = self:GetChild("BackImage/Cell" .. i .. "/CheckMark")
    self._normalCells[i].rank = self:GetChild("BackImage/Cell" .. i .. "/Rank")
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

function QiXiSignActivityTabCell:OnDestroy()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  LuaNotificationCenter.RemoveObserver(self)
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
end

local function SetNodeActive(cell, get, select, grey)
  cell.get:SetActive(get)
  cell.getIcon:SetActive(get)
  cell.icon:SetActive(not get)
  cell.iconGrey:SetActive(get)
  cell.select:SetActive(select)
  cell.grey:SetActive(grey)
end

local function PlayEnableReceiveEffect(self)
  for i, v in ipairs(self._normalCells) do
    local dataTmp = self._itemList[i]
    if not dataTmp.receive and dataTmp.index <= self._totalSignTimes then
      v.effect_handler = v.effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1137))
    end
  end
end

function QiXiSignActivityTabCell:RefreshTabCell(activityId, refresh, refreshByProtocol)
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
        self._description:SetText(TextManager.GetText(activityRecord.description))
        local imageRecord = CImagePathTable:GetRecorder(activityRecord.bgImage) or DataCommon.DefaultImageAsset
        self._backImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      self._totalSignTimes = data.totalSignNum
      self._itemList = data.awards
      for i, v in ipairs(self._normalCells) do
        local dataTmp = self._itemList[i]
        if v.effect_handler then
          v.effect:ReleaseEffect(v.effect_handler)
          v.effect_handler = nil
        end
        v.dayText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1062, {
          dataTmp.index
        }))
        if dataTmp.receive then
          SetNodeActive(v, true, false, false)
        elseif dataTmp.index <= self._totalSignTimes then
          SetNodeActive(v, false, true, false)
          if not tag and refreshByProtocol then
            DialogManager.CreateSingletonDialog("guide.blockclickdialog")
            PlayEnableReceiveEffect(self)
          elseif tag and self._delegate._selectedTab == self._activityId then
            DialogManager.CreateSingletonDialog("guide.blockclickdialog")
          end
        else
          SetNodeActive(v, false, false, false)
        end
        local item = Item.Create(dataTmp.itemId)
        local imgRecord = item:GetIcon()
        v.icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
        v.iconGrey:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
        v.num:SetText(NekoData.BehaviorManager.BM_Message:GetString(1475, {
          dataTmp.itemNum
        }))
        imgRecord = item:GetShopPinJiBackGroundImage()
        v.rank:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
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

function QiXiSignActivityTabCell:OnCellClick(index)
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

function QiXiSignActivityTabCell:GetCanGetFirstIndex()
  for i, v in ipairs(self._itemList) do
    if not v.receive and v.index <= self._totalSignTimes then
      return i
    end
  end
end

function QiXiSignActivityTabCell:RefreshTime()
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

function QiXiSignActivityTabCell:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "SignActivty" then
    PlayEnableReceiveEffect(self)
  end
end

function QiXiSignActivityTabCell:OnEffectEnd(index, window, effectHandler)
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

return QiXiSignActivityTabCell
