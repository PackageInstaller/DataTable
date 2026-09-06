local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRoleItemTable = BeanManager.GetTableByName("item.croleitem")
local CBackActivity = BeanManager.GetTableByName("welfare.cbackactivity")
local ReturnSignTabCell = class("ReturnSignTabCell", Dialog)
ReturnSignTabCell.AssetBundleName = "ui/layouts.welfare"
ReturnSignTabCell.AssetName = "ReturnWelfareDay"

function ReturnSignTabCell:Ctor(...)
  ReturnSignTabCell.super.Ctor(self, ...)
  self._init = false
  self._itemList = {}
  self._totalSignTimes = nil
  self._endTime = nil
  self._effectList = {}
end

function ReturnSignTabCell:OnCreate()
  self._backImg = self:GetChild("BackImage")
  self._title = self:GetChild("BackImage/Title")
  self._timeTxt = self:GetChild("BackImage/Time")
  self._itemPanel = self:GetChild("BackImage/Frame")
  self._itemFrame = GridFrame.Create(self._itemPanel, self, false, 1, true)
end

local function PlayEnableReceiveEffect(self)
  self._effectList = {}
  self._itemFrame:FireEvent("ReceiveEffect")
end

function ReturnSignTabCell:RefreshTabCell(activityId, refresh, refreshByProtocol)
  local tag
  if not self._init or not refresh then
    self._delaytimeTask = GameTimer.AddTask(0.1, -1, function()
      PlayEnableReceiveEffect(self)
    end)
    tag = true
  end
  self._activityId = activityId
  if NekoData.BehaviorManager.BM_Activity:HasActivity(activityId) then
    if not self._init or refresh then
      local data = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivityById(activityId)
      if not self._init then
        self._init = true
        local activityRecord = CBackActivity:GetRecorder(activityId)
        if not CImagePathTable:GetRecorder(activityRecord.bgImage) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
      end
      self._totalSignTimes = data.totalSignNum
      self._itemList = data.awards
      for i, v in ipairs(self._itemList) do
        v.cell = CBackActivity:GetRecorder(activityId).cell[i]
        if v.receive then
        elseif v.index <= self._totalSignTimes then
          if not tag and refreshByProtocol then
            DialogManager.CreateSingletonDialog("guide.blockclickdialog")
            PlayEnableReceiveEffect(self)
          elseif tag and self._delegate._selectedTab == self._activityId then
            DialogManager.CreateSingletonDialog("guide.blockclickdialog")
          end
        end
      end
      self._endTime = NekoData.BehaviorManager.BM_Activity:GetEndTime(self._activityId)
      self:RefreshTime()
      if not self._activityTask then
        self._activityTask = GameTimer.AddTask(0, 60, function()
          self:RefreshTime()
        end)
      end
      self._itemFrame:ReloadAllCell()
    elseif not refresh then
      local index = self:GetCanGetFirstIndex()
      if index then
        self._itemFrame:MoveLeftToIndex(index)
      else
        self._itemFrame:MoveToLeft()
      end
    end
  elseif self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
end

function ReturnSignTabCell:GetCanGetFirstIndex()
  for i, v in ipairs(self._itemList) do
    if not v.receive and v.index <= self._totalSignTimes then
      return i
    end
  end
end

function ReturnSignTabCell:OnDestroy()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  LuaNotificationCenter.RemoveObserver(self)
  self._itemFrame:Destroy()
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
  if self._delaytimeTask then
    GameTimer.RemoveTask(self._delaytimeTask)
    self._delaytimeTask = nil
  end
end

function ReturnSignTabCell:OnCellClick(index)
  local data = self._itemList[index]
  if index == roleDay then
    self:OnRoleDetailBtnClick()
  else
    local width, height = self:GetRootWindow():GetRectSize()
    local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if dialog then
      dialog:Init({
        item = Item.Create(data.itemId)
      })
      dialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  end
end

function ReturnSignTabCell:NumberOfCell(frame)
  return #self._itemList
end

function ReturnSignTabCell:CellAtIndex(frame, index)
  return "welfare.returnwelfare.returnsignactivityitemcell"
end

function ReturnSignTabCell:DataAtIndex(frame, index)
  return self._itemList[index]
end

function ReturnSignTabCell:RefreshTime()
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

function ReturnSignTabCell:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "SignActivty" then
    PlayEnableReceiveEffect(self)
  end
end

function ReturnSignTabCell:OnEffectEnd(index)
  if self._effectList[index] then
    self._effectList[index] = nil
  end
  local allEffectsEnd = true
  for i, v in pairs(self._effectList) do
    if v then
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

return ReturnSignTabCell
