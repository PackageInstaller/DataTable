local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CallProgressDialog = class("CallProgressDialog", Dialog)
CallProgressDialog.AssetBundleName = "ui/layouts.activitychristmascall"
CallProgressDialog.AssetName = "ActivityChristmasCallTask"

function CallProgressDialog:Ctor(...)
  CallProgressDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._progressData = {
    [1] = {},
    [2] = {}
  }
  self._progressType = 1
end

function CallProgressDialog:OnCreate()
  self._backBtn = self:GetChild("BackImage/CloseBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("BackImage/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._sheetBtn = {}
  for i = 1, 2 do
    self._sheetBtn[i] = {}
    self._sheetBtn[i].root = self:GetChild("TabBtn" .. tostring(i))
    self._sheetBtn[i].redDot = self:GetChild("TabBtn" .. tostring(i) .. "/RedDot")
    self._sheetBtn[i].root:Subscribe_PointerClickEvent(function()
      self:OnSheetBtnClicked(i)
    end, self)
  end
  self._tabText1 = self:GetChild("TabBtn1/_Text")
  self._tabText2 = self:GetChild("TabBtn2/_Text")
  self._timeTxt = self:GetChild("BackImage/TimeTxt")
  self._tips = self:GetChild("BackImage/Tips")
  LuaNotificationCenter.AddObserver(self, self.PlayStory, Common.n_OnSReceiveSupportReward, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshProgressData(false)
  end, Common.n_OnSOpenTotalSupportScore, nil)
  LuaNotificationCenter.AddObserver(self, function()
    self:RefreshProgressData(true)
  end, Common.n_OnSReceiveSupportReward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnSChristmasSupportRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnLocalRefreshChristmasSupportRedpoint, nil)
  self:SetStaticRes()
  self:SetData()
  self:OnSheetBtnClicked(self._progressType)
end

function CallProgressDialog:SetStaticRes()
  self._tabText1:SetText(TextManager.GetText(CStringRes:GetRecorder(1682).msgTextID))
  self._tabText2:SetText(TextManager.GetText(CStringRes:GetRecorder(1683).msgTextID))
  self._timeTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1666).msgTextID))
  self._tips:SetText(TextManager.GetText(CStringRes:GetRecorder(1689).msgTextID))
end

function CallProgressDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function CallProgressDialog:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self:RefreshProgressData()
  self:RefreshRedDot()
end

function CallProgressDialog:RefreshProgressData(refresh)
  for _, value in pairs(self._progressData) do
    for key2, _ in pairs(value) do
      value[key2] = nil
    end
  end
  local localData = self._bm:GetCChristmasCallCfgCfg()
  local haveGetStage = false
  local haveGetAll = false
  for _, cfgID in ipairs(localData:GetAllIds()) do
    local record = localData:GetRecorder(cfgID)
    local totalScore = 0
    if record.callType == 1 then
      totalScore = self._bm:GetNowScore()
    else
      totalScore = self._bm:GetNowGlobalScore()
    end
    local canGet = totalScore >= record.endEvent
    local isGet = self._bm:GetRewardState()[cfgID]
    if record.callType == 1 then
      haveGetStage = haveGetStage or canGet and not isGet
    else
      haveGetAll = haveGetAll or canGet and not isGet
    end
    table.insert(self._progressData[record.callType], {
      localData = record,
      remoteData = {
        isGet = isGet,
        canGet = canGet,
        totalScore = totalScore
      }
    })
  end
  if haveGetStage ~= self._bm:GetRedDot(self._bm:GetSChristmasSupportRedPointDef().STAGE) then
    if haveGetStage then
      self._bm:AddRedDot(self._bm:GetSChristmasSupportRedPointDef().STAGE)
    else
      self._bm:KillRedDot(self._bm:GetSChristmasSupportRedPointDef().STAGE)
    end
    LuaNotificationCenter.PostNotification(Common.n_OnLocalRefreshChristmasSupportRedpoint, nil, nil)
  end
  if haveGetAll ~= self._bm:GetRedDot(self._bm:GetSChristmasSupportRedPointDef().TOTAL_CALL) then
    if haveGetAll then
      self._bm:AddRedDot(self._bm:GetSChristmasSupportRedPointDef().TOTAL_CALL)
    else
      self._bm:KillRedDot(self._bm:GetSChristmasSupportRedPointDef().TOTAL_CALL)
    end
    LuaNotificationCenter.PostNotification(Common.n_OnLocalRefreshChristmasSupportRedpoint, nil, nil)
  end
  for _, value in pairs(self._progressData) do
    table.sort(value, function(a, b)
      local sortIDA, sortIDB
      if a.remoteData.isGet then
        sortIDA = 2
      else
        sortIDA = 1
      end
      if b.remoteData.isGet then
        sortIDB = 2
      else
        sortIDB = 1
      end
      if sortIDA == sortIDB then
        return a.localData.id < b.localData.id
      else
        return sortIDA < sortIDB
      end
    end)
  end
  if refresh then
    local lastPos = self._frame:GetCurrentPosition()
    self._frame:ReloadAllCell()
    if lastPos then
      self._frame:MoveToAssignedPos(lastPos)
    end
  else
    self._frame:ReloadAllCell()
    self._frame:MoveToTop()
  end
end

function CallProgressDialog:PlayStory(notification)
  local protocol = notification.userInfo
  local localData = self._bm:GetCChristmasCallCfgCfg()
  local record = localData:GetRecorder(protocol.id)
  if record and record.npcTalk ~= 0 then
    DialogManager.DestroySingletonDialog("activity.chrismascall.callprogressdialog")
    DialogManager.DestroySingletonDialog("activity.chrismascall.maindialog")
    local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if sceneController then
      sceneController._baseMainFSM:SetNumber("storyId", record.npcTalk)
    end
  end
end

function CallProgressDialog:OnSheetBtnClicked(index)
  for key, value in pairs(self._sheetBtn) do
    value.root:SetSelected(key == index)
  end
  self._progressType = index
  self._bm:SendCOpenTotalSupportScore()
end

function CallProgressDialog:OnBackBtnClicked()
  self:Destroy()
end

function CallProgressDialog:CellAtIndex(frame, index)
  return "activity.chrismascall.callprogresscell"
end

function CallProgressDialog:NumberOfCell(frame, index)
  return #self._progressData[self._progressType]
end

function CallProgressDialog:DataAtIndex(frame, index)
  return self._progressData[self._progressType][index]
end

function CallProgressDialog:RefreshRedDot()
  self._sheetBtn[1].redDot:SetActive(self._bm:GetRedDot(self._bm:GetSChristmasSupportRedPointDef().STAGE))
  self._sheetBtn[2].redDot:SetActive(self._bm:GetRedDot(self._bm:GetSChristmasSupportRedPointDef().TOTAL_CALL))
end

return CallProgressDialog
