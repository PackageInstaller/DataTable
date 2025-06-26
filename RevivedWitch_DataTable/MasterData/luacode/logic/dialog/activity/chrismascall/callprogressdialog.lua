-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/chrismascall/callprogressdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CallProgressDialog = class("CallProgressDialog", Dialog)
CallProgressDialog.AssetBundleName = "ui/layouts.activitychristmascall"
CallProgressDialog.AssetName = "ActivityChristmasCallTask"
CallProgressDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CallProgressDialog
  ((CallProgressDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._progressData = {
[1] = {}
, 
[2] = {}
}
  self._progressType = 1
end

CallProgressDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._backBtn = self:GetChild("BackImage/CloseBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("BackImage/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._sheetBtn = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

      (self._sheetBtn)[i] = {}
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._sheetBtn)[i]).root = self:GetChild("TabBtn" .. tostring(i))
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._sheetBtn)[i]).redDot = self:GetChild("TabBtn" .. tostring(i) .. "/RedDot")
      ;
      (((self._sheetBtn)[i]).root):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSheetBtnClicked(i)
  end
, self)
    end
  end
  self._tabText1 = self:GetChild("TabBtn1/_Text")
  self._tabText2 = self:GetChild("TabBtn2/_Text")
  self._timeTxt = self:GetChild("BackImage/TimeTxt")
  self._tips = self:GetChild("BackImage/Tips")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.PlayStory, Common.n_OnSReceiveSupportReward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_1 , upvalues : self
    self:RefreshProgressData(false)
  end
, Common.n_OnSOpenTotalSupportScore, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_2 , upvalues : self
    self:RefreshProgressData(true)
  end
, Common.n_OnSReceiveSupportReward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_OnSChristmasSupportRedpoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_OnLocalRefreshChristmasSupportRedpoint, nil)
  self:SetStaticRes()
  self:SetData()
  self:OnSheetBtnClicked(self._progressType)
end

CallProgressDialog.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  (self._tabText1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1682)).msgTextID))
  ;
  (self._tabText2):SetText((TextManager.GetText)((CStringRes:GetRecorder(1683)).msgTextID))
  ;
  (self._timeTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1666)).msgTextID))
  ;
  (self._tips):SetText((TextManager.GetText)((CStringRes:GetRecorder(1689)).msgTextID))
end

CallProgressDialog.OnDestroy = function(self)
  -- function num : 0_3
  if self._frame then
    (self._frame):Destroy()
  end
end

CallProgressDialog.SetData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)
  self:RefreshProgressData()
  self:RefreshRedDot()
end

CallProgressDialog.RefreshProgressData = function(self, refresh)
  -- function num : 0_5 , upvalues : _ENV
  for _,value in pairs(self._progressData) do
    for key2,_ in pairs(value) do
      value[key2] = nil
    end
  end
  local localData = (self._bm):GetCChristmasCallCfgCfg()
  local haveGetStage = false
  local haveGetAll = false
  for _,cfgID in ipairs(localData:GetAllIds()) do
    local record = localData:GetRecorder(R12_PC25)
    local totalScore = 0
    R12_PC25 = record.callType
    if R12_PC25 == 1 then
      R12_PC25 = self._bm
      R12_PC25 = R12_PC25(R12_PC25)
      totalScore = R12_PC25
    else
      R12_PC25 = self._bm
      R12_PC25 = R12_PC25(R12_PC25)
      totalScore = R12_PC25
    end
    R12_PC25 = record.endEvent
    R12_PC25 = R12_PC25 <= totalScore
    local canGet = nil
    local isGet = ((self._bm):GetRewardState())[cfgID]
    if record.callType == 1 then
      if not haveGetStage and canGet then
        do
          haveGetStage = not isGet
          if not haveGetAll and canGet then
            haveGetAll = not isGet
          end
          ;
          (table.insert)((self._progressData)[record.callType], {localData = record, 
remoteData = {isGet = isGet, canGet = canGet, totalScore = totalScore}
})
          -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if haveGetStage ~= (self._bm):GetRedDot(((self._bm):GetSChristmasSupportRedPointDef()).STAGE) then
    if haveGetStage then
      (self._bm):AddRedDot(((self._bm):GetSChristmasSupportRedPointDef()).STAGE)
    else
      (self._bm):KillRedDot(((self._bm):GetSChristmasSupportRedPointDef()).STAGE)
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnLocalRefreshChristmasSupportRedpoint, nil, nil)
  end
  if haveGetAll ~= (self._bm):GetRedDot(((self._bm):GetSChristmasSupportRedPointDef()).TOTAL_CALL) then
    if haveGetAll then
      (self._bm):AddRedDot(((self._bm):GetSChristmasSupportRedPointDef()).TOTAL_CALL)
    else
      (self._bm):KillRedDot(((self._bm):GetSChristmasSupportRedPointDef()).TOTAL_CALL)
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnLocalRefreshChristmasSupportRedpoint, nil, nil)
  end
  for _,value in pairs(self._progressData) do
    (table.sort)(R11_PC149, function(a, b)
    -- function num : 0_5_0
    local sortIDA, sortIDB = nil, nil
    if (a.remoteData).isGet then
      sortIDA = 2
    else
      sortIDA = 1
    end
    if (b.remoteData).isGet then
      sortIDB = 2
    else
      sortIDB = 1
    end
    if (a.localData).id >= (b.localData).id then
      do return sortIDA ~= sortIDB end
      do return sortIDA < sortIDB end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  end
  if refresh then
    local lastPos = (self._frame):GetCurrentPosition()
    ;
    (self._frame):ReloadAllCell()
    if lastPos then
      (self._frame):MoveToAssignedPos(lastPos)
    end
  else
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  end
  -- DECOMPILER ERROR: 14 unprocessed JMP targets
end

CallProgressDialog.PlayStory = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = notification.userInfo
  local localData = (self._bm):GetCChristmasCallCfgCfg()
  local record = localData:GetRecorder(protocol.id)
  if record and record.npcTalk ~= 0 then
    (DialogManager.DestroySingletonDialog)("activity.chrismascall.callprogressdialog")
    ;
    (DialogManager.DestroySingletonDialog)("activity.chrismascall.maindialog")
    local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    if sceneController then
      (sceneController._baseMainFSM):SetNumber("storyId", record.npcTalk)
    end
  end
end

CallProgressDialog.OnSheetBtnClicked = function(self, index)
  -- function num : 0_7 , upvalues : _ENV
  for key,value in pairs(self._sheetBtn) do
    (value.root):SetSelected(key == index)
  end
  self._progressType = index
  ;
  (self._bm):SendCOpenTotalSupportScore()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

CallProgressDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

CallProgressDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "activity.chrismascall.callprogresscell"
end

CallProgressDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_10
  return #(self._progressData)[self._progressType]
end

CallProgressDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  return ((self._progressData)[self._progressType])[index]
end

CallProgressDialog.RefreshRedDot = function(self)
  -- function num : 0_12
  (((self._sheetBtn)[1]).redDot):SetActive((self._bm):GetRedDot(((self._bm):GetSChristmasSupportRedPointDef()).STAGE))
  ;
  (((self._sheetBtn)[2]).redDot):SetActive((self._bm):GetRedDot(((self._bm):GetSChristmasSupportRedPointDef()).TOTAL_CALL))
end

return CallProgressDialog

