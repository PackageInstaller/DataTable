-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/loadingdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CLoadingTip = (BeanManager.GetTableByName)("message.cloadingtip")
local LoadingDialog = class("LoadingDialog", Dialog)
LoadingDialog.AssetBundleName = "ui/layouts.loading"
LoadingDialog.AssetName = "Loading"
local UpdateView = function(self, id)
  -- function num : 0_0 , upvalues : _ENV
  local preProgress = self._currentStartProgress / self._totalProgress
  local newProgress = (1 - preProgress) * (self._currentProgress - self._currentStartProgress) / self._currentTotalProgress
  local resultProgress = preProgress + newProgress
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._progressImage).fillAmount = resultProgress
  if resultProgress >= 1 and self._navMeshReady then
    LogInfoFormat("LoadingDialog", "--- self._navMeshReady = %s ------", self._navMeshReady)
    if id == 30011 and (not ((NekoData.BehaviorManager).BM_SEnterMainCity):GetCurBattleInfo() or (((NekoData.BehaviorManager).BM_SEnterMainCity):GetCurBattleInfo()).battleid <= 0) then
      self._gameTimerID = (GameTimer.AddTask)(0.5, -1, function()
    -- function num : 0_0_0 , upvalues : resultProgress, self, _ENV
    resultProgress = 1
    self._isDestroying = true
    LogInfo("LoadingDialog 30001 PlayEndAnimation")
    ;
    (self:GetRootWindow()):SetAnimatorInteger("loadingEnd", 1)
    self._loadingState = 2
  end
)
    else
      resultProgress = 1
      self._isDestroying = true
      if (((NekoData.BehaviorManager).BM_SEnterDungeon):GetCurBattleInfo() and (((NekoData.BehaviorManager).BM_SEnterDungeon):GetCurBattleInfo()).battleid > 0) or ((NekoData.BehaviorManager).BM_SEnterMainCity):GetCurBattleInfo() and (((NekoData.BehaviorManager).BM_SEnterMainCity):GetCurBattleInfo()).battleid > 0 then
        local userInfo = {}
        userInfo.loadProgressTable = self._loadProgressTable
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_LoadingProgressFinish, self, userInfo)
      else
        do
          LogInfo("LoadingDialog PlayEndAnimation")
          ;
          (self:GetRootWindow()):SetAnimatorInteger("loadingEnd", 1)
          self._loadingState = 2
          ;
          (self._image):SetXPosition((self._imageOriginalXPos).anchor, (self._imageOriginalXPos).offset + (self._progressImageSize).widht * resultProgress)
          LogInfo("LoadingDialog", tostring(resultProgress))
        end
      end
    end
  end
end

LoadingDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : LoadingDialog
  ((LoadingDialog.super).Ctor)(self, ...)
  self._groupName = "Loading"
  self._progressImage = nil
  self._image = nil
  self._progress = nil
  self._loadProgressTable = nil
  self._currentProgress = nil
  self._totalProgress = nil
  self._currentStartProgress = nil
  self._currentTotalProgress = nil
  self._progressImageSize = nil
  self._imageOriginalXPos = nil
  self._isDestroying = nil
  self._navMeshReady = false
  self._gameTimerID = nil
  self._topNoticeDialog = nil
  self._unreadTipIdList = nil
  self._readTipIdList = nil
  self._curSceneLoadingId = 0
  self._loadingState = 0
  self._loadingAnimationTime = 0
end

LoadingDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self._tipsText = self:GetChild("Tips")
  self._progress = self:GetChild("ProgressSimple/_Progress")
  self._progressImage = ((self._progress):GetUIObject()):GetComponent("Image")
  self._image = self:GetChild("Image")
  self._backPanel = self:GetChild("BackImage")
  self._loadProgressTable = {}
  self._currentProgress = 0
  self._currentStartProgress = 0
  self._totalProgress = 0
  self._currentTotalProgress = 0
  local widht, height = (self._progress):GetRectSize()
  self._progressImageSize = {widht = widht, height = height}
  local anchor, offset = (self._image):GetXPosition()
  self._imageOriginalXPos = {anchor = anchor, offset = offset}
  self._isDestroying = false
  ;
  (self._backPanel):Subscribe_PointerClickEvent(self.OnBackPanelClick, self)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._progressImage).fillAmount = 0
  ;
  (self:GetRootWindow()):SetAnimatorInteger("loadingEnd", 0)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNavMeshBuildFinish, Common.n_NavMeshBuildFinish, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  self:InitTipDialog()
  self._topNoticeDialog = (DialogManager.GetDialog)("topnoticebar.topnoticebardialog")
  if not self._topNoticeDialog then
    self._topNoticeDialog = (DialogManager.GetDialog)("topnoticebar.topnoticeloadbardialog")
  end
  if self._topNoticeDialog then
    ((self._topNoticeDialog):GetRootWindow()):SetActive(false)
  end
end

LoadingDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  if self._topNoticeDialog then
    ((self._topNoticeDialog):GetRootWindow()):SetActive(true)
  end
  local userInfo = {}
  userInfo.loadProgressTable = self._loadProgressTable
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_LoadingProgressFinish, self, userInfo)
  local message = ((NekoData.BehaviorManager).BM_SEnterDungeon):GetTopMessage()
  if message and message.messageId ~= 0 then
    ((NekoData.BehaviorManager).BM_Message):SendTopMessage(message.messageId, message.parameters)
  end
end

LoadingDialog.InitTipDialog = function(self)
  -- function num : 0_4 , upvalues : _ENV, CLoadingTip
  self._readTipIdList = ((NekoData.BehaviorManager).BM_Game):GetReadTips()
  self._unreadTipIdList = {}
  if self._readTipIdList == nil then
    LogError("LoadingDialog", "self._readTipIdList is nil! Fallback to empty table!")
    self._readTipIdList = {}
  end
  for _,id in ipairs(CLoadingTip:GetAllIds()) do
    if not (table.keyof)(self._readTipIdList, id) then
      (table.insert)(self._unreadTipIdList, id)
    end
  end
end

LoadingDialog.AddSceneToLoad = function(self, id)
  -- function num : 0_5 , upvalues : _ENV
  if id > 20000 then
    self._navMeshReady = true
  end
  if (self._loadProgressTable)[id] ~= nil then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._loadProgressTable)[id] = 0
  self._currentTotalProgress = self._totalProgress - self._currentProgress + 1
  self._totalProgress = self._totalProgress + 1
  self._currentStartProgress = self._currentProgress
  LogInfo("LoadingDialog", "add scene " .. id)
end

LoadingDialog.ShowTips = function(self, curSceneLoadingId)
  -- function num : 0_6 , upvalues : _ENV
  LogInfo("LoadingDialog", "ShowTips is called, curSceneLoadingId is " .. curSceneLoadingId)
  self._curSceneLoadingId = curSceneLoadingId
  self:OnBackPanelClick()
end

LoadingDialog.UpdateSceneProgress = function(self, id, progress)
  -- function num : 0_7 , upvalues : _ENV, UpdateView
  local oldProgress = (self._loadProgressTable)[id]
  if oldProgress == nil then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._loadProgressTable)[id] = progress
  local distance = progress - oldProgress
  self._currentProgress = self._currentProgress + distance
  LogInfo("LoadingDialog", "update scene load progress " .. id .. " " .. progress)
  UpdateView(self, id)
end

LoadingDialog.OnNavMeshBuildFinish = function(self)
  -- function num : 0_8 , upvalues : UpdateView
  if (self._progressImage).fillAmount >= 1 and not self._navMeshReady then
    self._navMeshReady = true
    UpdateView(self)
  else
    self._navMeshReady = true
  end
end

LoadingDialog.IsDestroying = function(self)
  -- function num : 0_9
  return self._isDestroying
end

LoadingDialog.OnBackPanelClick = function(self)
  -- function num : 0_10 , upvalues : _ENV, CLoadingTip
  local randomTipIdList = {}
  if #self._unreadTipIdList ~= 0 then
    for _,tipId in pairs(self._unreadTipIdList) do
      if ((NekoData.BehaviorManager).BM_Game):GetTipsCanUse(CLoadingTip, tipId, self._curSceneLoadingId) then
        (table.insert)(randomTipIdList, tipId)
      end
    end
  end
  do
    local readFromReadList = false
    if #randomTipIdList == 0 then
      readFromReadList = true
      for _,tipId in pairs(self._readTipIdList) do
        if ((NekoData.BehaviorManager).BM_Game):GetTipsCanUse(CLoadingTip, tipId, self._curSceneLoadingId) then
          (table.insert)(randomTipIdList, tipId)
        end
      end
    end
    do
      if #randomTipIdList ~= 0 then
        local curTipID = self:GetRandomWithWeight(randomTipIdList)
        if curTipID ~= nil then
          local chat = CLoadingTip:GetRecorder(curTipID)
          if chat ~= nil then
            (self._tipsText):SetText((TextManager.GetText)(chat.tipMsgTextID))
            if not readFromReadList then
              self:RecordReadTip(curTipID)
            end
          else
            LogError("LoadingDialog", "Unable to get recorder from CLoadingTip! curTipID is illegal!")
          end
        else
          do
            do
              LogError("LoadingDialog", "Unable to get TipId! curTipID is nil!")
              LogError("LoadingDialog", "Unable to get TipId! randomTipIdList is empty!")
            end
          end
        end
      end
    end
  end
end

LoadingDialog.RecordReadTip = function(self, curTipID)
  -- function num : 0_11 , upvalues : _ENV
  (table.insert)(self._readTipIdList, curTipID)
  ;
  (table.removebyvalue)(self._unreadTipIdList, curTipID)
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.crecordtip")
  csend.id = curTipID
  csend.kind = csend.TIP
  csend:Send()
end

LoadingDialog.GetRandomWithWeight = function(self, weightTable)
  -- function num : 0_12 , upvalues : _ENV, CLoadingTip
  local totalWeight = 0
  local weightIdDic = {}
  for _,id in pairs(weightTable) do
    local curWeight = (CLoadingTip:GetRecorder(id)).weight
    totalWeight = totalWeight + curWeight
    ;
    (table.insert)(weightIdDic, {id = id, weight = curWeight})
  end
  ;
  (table.sort)(weightIdDic, function(v1, v2)
    -- function num : 0_12_0
    do return v2.weight < v1.weight end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local randomValue = (math.random)() * (totalWeight)
  for _,value in ipairs(weightIdDic) do
    randomValue = randomValue - value.weight
    if randomValue < 0 then
      return value.id
    end
  end
  LogError("LoadingDialog", "Unable to get randomId! fallback to the first item!")
  return (weightIdDic[1]).id
end

LoadingDialog.OnUpdate = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV
  if self._loadingState == 0 then
    self._loadingAnimationTime = self._loadingAnimationTime + (notification.userInfo).unscaledDeltaTime
    if self._loadingAnimationTime > 0.6 then
      self._loadingAnimationTime = 0
      self._loadingState = 1
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_LoadingStartAnimationEnd, self, nil)
      return 
    end
  end
  if self._loadingState == 2 then
    self._loadingAnimationTime = self._loadingAnimationTime + (notification.userInfo).unscaledDeltaTime
    if self._loadingAnimationTime > 1 then
      self._loadingAnimationTime = 0
      self._loadingState = 3
      self:Destroy()
      return 
    end
  end
end

LoadingDialog.OnAnimationEnd = function(self, handler, stateName, normalizedTime)
  -- function num : 0_14 , upvalues : _ENV
  LogInfoFormat("LoadingDialog", "----- stateName = %s ------", stateName)
  if stateName == "Start" then
    (LuaNotificationCenter.PostNotification)(Common.n_LoadingStartAnimationEnd, self, nil)
  else
    if stateName == "End" then
      self:Destroy()
    end
  end
end

return LoadingDialog

