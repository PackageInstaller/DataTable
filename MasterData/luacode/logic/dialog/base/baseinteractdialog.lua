local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local Physics = CS.UnityEngine.Physics
local PhysicsStaticFunctions = CS.PixelNeko.Lua.PhysicsStaticFunctions
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIManager = CS.PixelNeko.UI.UIManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local BaseSceneCamera = CS.PixelNeko.P1.Camera.BaseSceneCamera
local RuneStateEnum = LuaNetManager.GetProtocolDef("protocol.rune.sruneinfo")
local CBaseText = BeanManager.GetTableByName("scene.cbasetext")
local CHomeChatConfig = BeanManager.GetTableByName("dialog.chomechatconfig")
local CRuneChatCondition = BeanManager.GetTableByName("welfare.crunechatcondition")
local CDungeonSelectMainLine = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CTimedActivitySwitch = BeanManager.GetTableByName("activity.ctimedactivityswitch")
local StarMirageUnlockRecord = CTimedActivitySwitch:GetRecorder(DataCommon.Activities.StarMirage)
local CEffectWordChangeConfig = BeanManager.GetTableByName("overseas.ceffectwordchangeconfig")
local TextUIToConFig = {
  3,
  5,
  1,
  4,
  2
}
local BaseInteractDialog = class("BaseInteractDialog", Dialog)
BaseInteractDialog.AssetBundleName = "ui/layouts.basemainhud"
BaseInteractDialog.AssetName = "BaseInteract"
local _MainCameraTag = "Main"

function BaseInteractDialog:OnCtor(...)
  BaseInteractDialog.super.Ctor(self, ...)
  self._baseSceneController = nil
  self._raycastHits = nil
  self._textGOs = nil
  self._textAnimators = nil
  self._uiPointsInfo = nil
  self._textParentGO = nil
  self._readChatIdlist = nil
  self._unreadChatIdList = nil
  self._randomChat1IdList = nil
  self._randomChat2IdList = nil
  self._readFromReadList1 = false
  self._readFromReadList2 = false
  self._mainLineProgress = nil
  self._progressFloorSort = nil
end

function BaseInteractDialog:OnCreate()
  self._guideTxt = self:GetChild("TitleUI/BaseTitle1/GuideTxt")
  self._guideTxtText = self:GetChild("TitleUI/BaseTitle1/GuideTxt/Text")
  self._starPanel = self:GetChild("TitleUI/BaseTitle5/GuideTxt")
  self._starPanelTxt = self:GetChild("TitleUI/BaseTitle5/GuideTxt/Text")
  self._starPanel:SetActive(false)
  self._raycastHits = PhysicsStaticFunctions.CreateRaycastHits(2)
  self._rootWindow:Subscribe_PointerClickEvent(self.OnBackClicked, self)
  self._beginDragHandler = self._rootWindow:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._dragHandler = self._rootWindow:Subscribe_DragEvent(self.OnDrag, self)
  self._endDragHandler = self._rootWindow:Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._cancelDragHandler = self._rootWindow:Subscribe_CancelDragEvent(self.OnEndDrag, self)
  LuaNotificationCenter.AddObserver(self, self.SetGuideTxt, Common.n_ReceiveDungeonList, nil)
  LuaNotificationCenter.AddObserver(self, self.InitBaseCharChat, Common.n_ReceiveDungeonList, nil)
  LuaNotificationCenter.AddObserver(self, self.InitBaseCharChat, Common.n_ReceiveResonanceResult, nil)
  LuaNotificationCenter.AddObserver(self, self.InitBaseCharChat, Common.n_RefreshResonanceInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAllModalDialogClose, Common.n_AllModalDialogClose, nil)
  LuaNetManager.CreateProtocol("protocol.battle.copendungeonlist"):Send()
  LuaNetManager.CreateProtocol("protocol.battle.cresourcepanel"):Send()
  LuaNetManager.CreateProtocol("protocol.battle.copenbosspanel"):Send()
  local text1 = self:GetChild("TitleUI/BaseTitle1")
  local text2 = self:GetChild("TitleUI/BaseTitle3")
  local text3 = self:GetChild("TitleUI/BaseTitle2")
  local text4 = self:GetChild("TitleUI/BaseTitle4")
  local text5 = self:GetChild("TitleUI/BaseTitle6")
  local text6 = self:GetChild("TitleUI/BaseTitle5")
  self._texts = {}
  self._texts[1] = text1
  self._texts[2] = text2
  self._texts[3] = text3
  self._texts[4] = text4
  self._texts[5] = text5
  self._textAnimators = {}
  self._textEffects = {}
  self._textEffects[1] = self:GetChild("TitleUI/BaseTitle1/Effect")
  self._textEffects[2] = self:GetChild("TitleUI/BaseTitle3/Effect")
  self._textEffects[3] = self:GetChild("TitleUI/BaseTitle2/Effect")
  self._textEffects[4] = self:GetChild("TitleUI/BaseTitle4/Effect")
  self._textEffects[5] = self:GetChild("TitleUI/BaseTitle6/Effect")
  self._textParentGO = self:GetChild("TitleUI")._uiObject
  NekoData.BehaviorManager.BM_Game:SetGMHideUIByDialog(DataCommon.GMHideUI.MainCity, self)
  self:SetGuideTxt()
end

function BaseInteractDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  local baseSceneCamera = BaseSceneCamera.GetBaseSceneCamera(self._baseSceneController:GetCamera().gameObject)
  baseSceneCamera:ClearTransformChangedCallback(self.CameraTransformChangedChangedCallback, self)
end

function BaseInteractDialog:Init(sceneController)
  self._baseSceneController = sceneController
  local baseSceneCamera = BaseSceneCamera.GetBaseSceneCamera(sceneController:GetCamera().gameObject)
  baseSceneCamera:SetTransformChangedCallback(self.CameraTransformChangedChangedCallback, self)
  local sceneTextGOTable = sceneController:GetSceneTextGameObjectTable()
  self._uiPointsInfo = {}
  for k, v in ipairs(CBaseText:GetAllIds()) do
    local info = {}
    local go = sceneTextGOTable[v]
    info.transform = go.transform
    local record = CBaseText:GetRecorder(v)
    info.distance = record.hideDistance
    local x, y, z = TransformStaticFunctions.GetPosition(go)
    info.pos = {
      x = x,
      y = y,
      z = z
    }
    self._uiPointsInfo[v] = info
  end
  if DialogManager.GetGroup("Default"):GetObjectActive() and self:isActive() then
    self:SetTextsEffect()
    self:SetTextsPosition()
    self:CheckSceneTextDissolve()
    self._textsEffectinitialized = true
  end
end

function BaseInteractDialog:OnAllModalDialogClose()
  if not self._textsEffectinitialized then
    self:SetTextsEffect()
    self:SetTextsPosition()
    self:CheckSceneTextDissolve()
    self._textsEffectinitialized = true
  end
end

function BaseInteractDialog:SetGuideTxt()
  local floor = NekoData.BehaviorManager.BM_Game:GetLastNotPassFloorId()
  if floor ~= nil then
    local tmpRes = CDungeonSelectMainLine:GetRecorder(floor)
    if tmpRes and tmpRes.wordId ~= 0 then
      self._guideTxt:SetActive(true)
      self._guideTxtText:SetText(TextManager.GetText(tmpRes.wordId))
    else
      self._guideTxt:SetActive(false)
    end
  else
    self._guideTxt:SetActive(false)
  end
end

local function BuildChatList(self, rList, record, isBasic)
  local t2 = {}
  for _, i in ipairs(rList) do
    table.insert(t2, tonumber(i))
  end
  table.insert(self._chatList, {
    chat = t2,
    isRepeat = record.isRepeat,
    animation = record.animation,
    record = record,
    isBasic = isBasic
  })
end

local function GetFloorSort(floor)
  local record = CDungeonSelectMainLine:GetRecorder(floor)
  if record then
    return record.sort
  else
    return -1
  end
end

function BaseInteractDialog:InitBaseCharChat()
  LogInfo("BaseInteractDialog", "InitBaseCharChat")
  self._readChatIdlist = NekoData.BehaviorManager.BM_Game:GetReadNpcTips()
  if self._readChatIdlist == nil then
    LogError("BaseInteractDialog", "self._readChatIdlist is nil! Fallback to empty table!")
    self._readChatIdlist = {}
  end
  self._unreadChatIdList = {}
  for _, id in ipairs(CHomeChatConfig:GetAllIds()) do
    if not table.keyof(self._readChatIdlist, id) then
      table.insert(self._unreadChatIdList, id)
    end
  end
  self._chatList = {}
  self._runeChatId = nil
  self._mainLineProgress = NekoData.BehaviorManager.BM_Game:GetMainLineProgress()
  self._progressFloorSort = GetFloorSort(self._mainLineProgress.floor)
  local basicConversationCfg = {}
  local runeInfo = NekoData.BehaviorManager.BM_Game:GetRuneInfo()
  if runeInfo and runeInfo.state == RuneStateEnum.NO_RUNE then
    if runeInfo.dialogId ~= 0 then
      self._runeChatId = runeInfo.dialogId
    else
      self._runeChatId = -1
      local allIds = CRuneChatCondition:GetAllIds()
      for i, v in ipairs(allIds) do
        local record = CRuneChatCondition:GetRecorder(v)
        local condition = string.split(record.levelCondition, ",")
        local rList = string.split(record.randomRange, ",")
        local cUpfloor = tonumber(condition[1])
        local cDownfloor = cUpfloor
        local flag = false
        if cUpfloor then
          if cUpfloor == 0 then
            basicConversationCfg = {record = record, list = rList}
          else
            if condition[2] then
              cDownfloor = tonumber(condition[2])
            end
            local cUpfloorSort = GetFloorSort(cUpfloor)
            local cDownfloorSort = GetFloorSort(cDownfloor)
            if cUpfloorSort <= self._progressFloorSort and cDownfloorSort >= self._progressFloorSort then
              flag = true
            end
          end
        else
          condition = string.split(record.levelCondition, ";")
          for _, floorId in ipairs(condition) do
            if self._mainLineProgress.floor == tonumber(floorId) then
              flag = true
              break
            end
          end
        end
        if flag then
          BuildChatList(self, rList, record)
        end
      end
      BuildChatList(self, basicConversationCfg.list, basicConversationCfg.record, true)
    end
  else
    self:RefreshRamdomChat1IdList()
  end
  self:RefreshRamdomChat2IdList()
end

function BaseInteractDialog:RefreshRamdomChat1IdList()
  if self._randomChat1IdList == nil then
    self._randomChat1IdList = {}
  end
  for key, _ in pairs(self._randomChat1IdList) do
    self._randomChat1IdList[key] = nil
  end
  if #self._unreadChatIdList ~= 0 then
    for _, tipId in pairs(self._unreadChatIdList) do
      if self:GetChatIdCanUse(tipId) and CHomeChatConfig:GetRecorder(tipId).character == 1 then
        table.insert(self._randomChat1IdList, tipId)
      end
    end
  end
  self._readFromReadList1 = false
  if #self._randomChat1IdList == 0 then
    self._readFromReadList1 = true
    for _, tipId in pairs(self._readChatIdlist) do
      if self:GetChatIdCanUse(tipId) and CHomeChatConfig:GetRecorder(tipId).character == 1 then
        table.insert(self._randomChat1IdList, tipId)
      end
    end
  end
end

function BaseInteractDialog:RefreshRamdomChat2IdList()
  if self._randomChat2IdList == nil then
    self._randomChat2IdList = {}
  end
  for key, _ in pairs(self._randomChat2IdList) do
    self._randomChat2IdList[key] = nil
  end
  if #self._unreadChatIdList ~= 0 then
    for _, tipId in pairs(self._unreadChatIdList) do
      if self:GetChatIdCanUse(tipId) and CHomeChatConfig:GetRecorder(tipId).character == 2 then
        table.insert(self._randomChat2IdList, tipId)
      end
    end
  end
  self._readFromReadList2 = false
  if #self._randomChat2IdList == 0 then
    self._readFromReadList2 = true
    for _, tipId in pairs(self._readChatIdlist) do
      if self:GetChatIdCanUse(tipId) and CHomeChatConfig:GetRecorder(tipId).character == 2 then
        table.insert(self._randomChat2IdList, tipId)
      end
    end
  end
end

function BaseInteractDialog:OnBackClicked(args)
  if not self._baseSceneController._responseMouseClick then
    return
  else
    local dialog = DialogManager.GetDialog("guide.guidedialog")
    if not dialog or not dialog._startTime then
    else
      return
    end
  end
  local position = args.position
  local camera = self._baseSceneController:GetCamera()
  local outputViewPos = UIManager.ScreenToViewportPointInMargin("Main", position.x, position.y, 0)
  local ray = camera:ViewportPointToRay(outputViewPos)
  local count
  self._raycastHits, count = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  local countTmp = 0
  local tmpChristmasLayerID = 4
  self._raycastHitsTmp, countTmp = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHits, 1000000, tmpChristmasLayerID)
  LogInfo("Christmas CountTmp", tostring(countTmp))
  if count == 0 and countTmp == 0 then
    return
  end
  local raycastHit
  if self._raycastHits then
    raycastHit = self._raycastHits[0]
  else
    raycastHit = self._raycastHitsTmp[0]
  end
  local sceneObjectClick = SceneObjectClick.GetSceneObjectClick(raycastHit.collider.gameObject)
  if sceneObjectClick == nil then
    return
  end
  local char001CanChat = true
  if sceneObjectClick.StringData == "HomeChatStart" and char001CanChat then
    if sceneObjectClick.IntData == 0 then
      if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Signboard) then
        self:OpenSignboard()
      else
        self:ClickChar1Chat()
      end
    elseif sceneObjectClick.IntData == 1 then
      self:ClickChar2Chat()
    end
  elseif sceneObjectClick.StringData and string.find(sceneObjectClick.StringData, "Base_Christmas_Click_") == 1 then
    local clickObj = raycastHit.collider.gameObject
    local animator = AnimatorStaticFunctions.Get(clickObj)
    if animator then
      animator:SetTrigger("Click")
    end
  elseif sceneObjectClick.StringData and sceneObjectClick.StringData == "Object_Touch" then
    local clickObj = raycastHit.collider.gameObject
    local animator = AnimatorStaticFunctions.Get(clickObj)
    if animator then
      animator:SetTrigger("Click")
    end
  else
    local functionID = sceneObjectClick.IntData
    if functionID ~= 8 then
      self._baseSceneController:SetCameraAnimatorState(functionID)
    else
      return
    end
  end
end

function BaseInteractDialog:OpenSignboard()
  local dialog = DialogManager.CreateSingletonDialog("signboard.signboardmaindialog")
  if dialog then
    dialog:Init()
  end
end

function BaseInteractDialog:ClickChar1Chat()
  local chatId = -1
  if self._runeChatId then
    if self._runeChatId ~= -1 then
      chatId = self._runeChatId
    else
      local i1 = 1
      while true do
        local len = #self._chatList
        if self._chatList and len ~= 0 and 1 < len and i1 < len then
          local currentTime = ServerGameTimer.GetServerTimeForecast() // 1000
          local curTime = os.date("*t", currentTime)
          if #self._chatList[i1].chat ~= 0 then
            local record = self._chatList[i1].record
            local timeStrList = string.split(record.timeCondition, ",")
            if #timeStrList == 2 then
              local timeDownList = string.split(timeStrList[1], ":")
              local timeUpList = string.split(timeStrList[2], ":")
              local down = {
                hour = tonumber(timeDownList[1]),
                min = tonumber(timeDownList[2])
              }
              local up = {
                hour = tonumber(timeUpList[1]),
                min = tonumber(timeUpList[2])
              }
              local timeDown, timeUp
              curTime.hour = down.hour
              curTime.min = down.min
              timeDown = os.time(curTime)
              curTime.hour = up.hour
              curTime.min = up.min
              timeUp = os.time(curTime)
              if down.hour * 60 + down.min > up.hour * 60 + up.min then
                timeUp = timeUp + 86400
              end
              if currentTime > timeDown and currentTime < timeUp then
                local rList = string.split(record.randomRange, ",")
                local len = #rList
                local i2 = math.random(1, len)
                chatId = tonumber(rList[i2])
                local animation = record.animation
                if animation ~= "0" then
                  self._baseSceneController:GetChar001forbase():GetComponent("Animator"):SetTrigger(animation)
                end
                break
              end
            end
            i1 = i1 + 1
          else
            table.remove(self._chatList, i1)
          end
        else
          break
        end
      end
      if chatId == -1 then
        local len = #self._chatList
        if self._chatList and len ~= 0 and self._chatList[len].isBasic and #self._chatList[len].chat ~= 0 then
          local i2 = math.random(1, #self._chatList[len].chat)
          chatId = self._chatList[len].chat[i2]
          local animation = self._chatList[len].animation
          if animation ~= "0" then
            self._baseSceneController:GetChar001forbase():GetComponent("Animator"):SetTrigger(animation)
          end
          local isRepeat = self._chatList[len].isRepeat
          if isRepeat and isRepeat ~= 1 then
            table.remove(self._chatList[len].chat, i2)
          end
        end
      end
    end
  elseif chatId == -1 then
    if #self._randomChat1IdList ~= 0 then
      local curChatID = self:GetRandomWithWeight(CHomeChatConfig, self._randomChat1IdList)
      if curChatID ~= nil then
        local tempRecoder = CHomeChatConfig:GetRecorder(curChatID)
        if tempRecoder ~= nil then
          chatId = curChatID
          local animation = tempRecoder.animation
          if animation ~= "0" then
            self._baseSceneController:GetChar001forbase():GetComponent("Animator"):SetTrigger(animation)
          end
          if self._readFromReadList1 == false then
            table.removebyvalue(self._randomChat1IdList, curChatID)
            self:RecordReadTip(curChatID, tempRecoder.wetherOnlyOnce == 0)
            if #self._randomChat1IdList == 0 then
              self:RefreshRamdomChat1IdList()
            end
          elseif tempRecoder.wetherOnlyOnce ~= 0 then
            table.removebyvalue(self._randomChat1IdList, curChatID)
          end
        else
          LogError("BaseInteractDialog", "Unable to get recorder from CHomeChatConfig! curChatID is illegal!")
        end
      else
        LogError("BaseInteractDialog", "Unable to get chatId! curChatID is nil!")
      end
    else
      LogError("BaseInteractDialog", "Unable to get chatId! randomChatIdList is empty!")
    end
  end
  if chatId ~= -1 then
    local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
    if dialog then
      if self._runeChatId then
        dialog:SetDialogLibraryId(chatId, true, dialog.DialogType.Resonance)
      else
        dialog:SetDialogLibraryId(chatId, true)
      end
    end
  end
end

function BaseInteractDialog:ClickChar2Chat()
  local chatId = -1
  if #self._randomChat2IdList ~= 0 then
    local curChatID = self:GetRandomWithWeight(CHomeChatConfig, self._randomChat2IdList)
    if curChatID ~= nil then
      local tempRecoder = CHomeChatConfig:GetRecorder(curChatID)
      if tempRecoder ~= nil then
        chatId = curChatID
        if self._readFromReadList2 == false then
          table.removebyvalue(self._randomChat2IdList, curChatID)
          self:RecordReadTip(curChatID, tempRecoder.wetherOnlyOnce == 0)
          if #self._randomChat2IdList == 0 then
            self:RefreshRamdomChat2IdList()
          end
        elseif tempRecoder.wetherOnlyOnce ~= 0 then
          table.removebyvalue(self._randomChat2IdList, curChatID)
        end
      else
        LogError("BaseInteractDialog", "Unable to get recorder from CHomeChatConfig! curChatID is illegal!")
      end
    else
      LogError("BaseInteractDialog", "Unable to get chatId! curChatID is nil!")
    end
  else
    LogError("BaseInteractDialog", "Unable to get chatId! randomChatIdList is empty!")
  end
  if chatId ~= -1 then
    local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
    if dialog then
      dialog:SetDialogLibraryId(chatId, 1)
    end
  end
end

function BaseInteractDialog:GetChatIdCanUse(tipId)
  local record = CHomeChatConfig:GetRecorder(tipId)
  local effectRange = string.split(record.effectRange, ",")
  local cUpfloor = tonumber(effectRange[1])
  local cDownfloor = cUpfloor
  if cUpfloor then
    if cUpfloor == -1 then
      return true
    else
      if effectRange[2] then
        cDownfloor = tonumber(effectRange[2])
      end
      local cUpfloorSort = GetFloorSort(cUpfloor)
      local cDownfloorSort = GetFloorSort(cDownfloor)
      if cUpfloorSort <= self._progressFloorSort and cDownfloorSort >= self._progressFloorSort then
        return true
      end
    end
  else
    effectRange = string.split(record.effectRange, ";")
    for _, floorId in ipairs(effectRange) do
      if self._mainLineProgress.floor == tonumber(floorId) then
        return true
      end
    end
  end
  return false
end

function BaseInteractDialog:GetRandomWithWeight(srcTable, weightTable)
  local totalWeight = 0
  local weightIdDic = {}
  for _, id in pairs(weightTable) do
    local curWeight = srcTable:GetRecorder(id).weight
    totalWeight = totalWeight + curWeight
    table.insert(weightIdDic, {id = id, weight = curWeight})
  end
  table.sort(weightIdDic, function(v1, v2)
    return v1.weight > v2.weight
  end)
  local randomValue = math.random() * totalWeight
  for _, value in ipairs(weightIdDic) do
    randomValue = randomValue - value.weight
    if randomValue < 0 then
      return value.id
    end
  end
  LogError("BaseInteractDialog", "Unable to get randomId! fallback to the first item!")
  return weightIdDic[1].id
end

function BaseInteractDialog:RecordReadTip(curChatID, notOnlyOnce)
  if notOnlyOnce then
    table.insert(self._readChatIdlist, curChatID)
  end
  table.removebyvalue(self._unreadChatIdList, curChatID)
  local csend = LuaNetManager.CreateProtocol("protocol.battle.crecordtip")
  csend.id = curChatID
  csend.kind = csend.NPC
  csend:Send()
end

function BaseInteractDialog:OnBeginDrag(args)
  self._baseSceneController:MoveCamera(0)
end

function BaseInteractDialog:OnDrag(args)
  self._baseSceneController:MoveCamera(-args.delta.x)
end

function BaseInteractDialog:OnEndDrag(args)
  self._baseSceneController:MoveCamera(0)
end

function BaseInteractDialog:SetDragEnable(flag)
  if flag then
    if self._beginDragHandler then
      self._rootWindow:Unsubscribe_BeginDragEvent(self._beginDragHandler)
      self._beginDragHandler = nil
    end
    if self._dragHandler then
      self._rootWindow:Unsubscribe_DragEvent(self._dragHandler)
      self._dragHandler = nil
    end
    if self._endDragHandler then
      self._rootWindow:Unsubscribe_EndDragEvent(self._endDragHandler)
      self._endDragHandler = nil
    end
    if self._cancelDragHandler then
      self._rootWindow:Unsubscribe_CancelDragEvent(self._cancelDragHandler)
      self._cancelDragHandler = nil
    end
    self._beginDragHandler = self._rootWindow:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
    self._dragHandler = self._rootWindow:Subscribe_DragEvent(self.OnDrag, self)
    self._endDragHandler = self._rootWindow:Subscribe_EndDragEvent(self.OnEndDrag, self)
    self._cancelDragHandler = self._rootWindow:Subscribe_CancelDragEvent(self.OnEndDrag, self)
  else
    if self._beginDragHandler then
      self._rootWindow:Unsubscribe_BeginDragEvent(self._beginDragHandler)
      self._beginDragHandler = nil
    end
    if self._dragHandler then
      self._rootWindow:Unsubscribe_DragEvent(self._dragHandler)
      self._dragHandler = nil
    end
    if self._endDragHandler then
      self._rootWindow:Unsubscribe_EndDragEvent(self._endDragHandler)
      self._endDragHandler = nil
    end
    if self._cancelDragHandler then
      self._rootWindow:Unsubscribe_CancelDragEvent(self._cancelDragHandler)
      self._cancelDragHandler = nil
    end
  end
end

function BaseInteractDialog:SetTextsEffect()
  local effectName = {}
  local languageId = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(101).Value)
  for i, v in ipairs(self._textEffects) do
    local recorder = CEffectWordChangeConfig:GetRecorder(TextUIToConFig[i])
    local assetBundleName = recorder.assetBundle
    local assetName
    if languageId == 1 then
      assetName = recorder.cn
    elseif languageId == 2 then
      assetName = recorder.en
    elseif languageId == 3 then
      assetName = recorder.kr
    elseif languageId == 4 then
      assetName = recorder.jp
    end
    v:AddEffectSync(assetBundleName, assetName)
    effectName[i] = assetName
  end
  self._textAnimators[1] = AnimatorStaticFunctions.Get(self:GetChild("TitleUI/BaseTitle1/Effect/Effect/" .. effectName[1] .. "(Clone)(Clone)")._uiObject)
  self._textAnimators[2] = AnimatorStaticFunctions.Get(self:GetChild("TitleUI/BaseTitle3/Effect/Effect/" .. effectName[2] .. "(Clone)(Clone)")._uiObject)
  self._textAnimators[3] = AnimatorStaticFunctions.Get(self:GetChild("TitleUI/BaseTitle2/Effect/Effect/" .. effectName[3] .. "(Clone)(Clone)")._uiObject)
  self._textAnimators[4] = AnimatorStaticFunctions.Get(self:GetChild("TitleUI/BaseTitle4/Effect/Effect/" .. effectName[4] .. "(Clone)(Clone)")._uiObject)
  self._textAnimators[5] = AnimatorStaticFunctions.Get(self:GetChild("TitleUI/BaseTitle6/Effect/Effect/" .. effectName[5] .. "(Clone)(Clone)")._uiObject)
end

function BaseInteractDialog:SetTextsPosition()
  for k, v in pairs(self._uiPointsInfo) do
    local pos = v.pos
    local screenX, screenY = UIManager.WorldToScreenPointInMargin(_MainCameraTag, pos.x, pos.y, pos.z)
    local x, y = UIManager.ScreenPointToLocalPointInRectangle(self._textParentGO, screenX, screenY)
    self._texts[k]:SetAnchoredPosition(x, y)
  end
end

function BaseInteractDialog:CheckSceneTextDissolve()
  local cameraPosX = self._baseSceneController:GetCameraTransform().position.x
  for k, v in pairs(self._uiPointsInfo) do
    if math.abs(v.transform.position.x - cameraPosX) > v.distance then
      self._textAnimators[k]:SetInteger("isShow", 0)
    else
      self._textAnimators[k]:SetInteger("isShow", 1)
    end
  end
end

function BaseInteractDialog:CameraTransformChangedChangedCallback()
  self:SetTextsPosition()
  self:CheckSceneTextDissolve()
end

function BaseInteractDialog:ShowText()
  for k, v in pairs(self._texts) do
    v:SetActive(true)
  end
end

function BaseInteractDialog:HideText()
  for k, v in pairs(self._texts) do
    v:SetActive(false)
  end
end

return BaseInteractDialog
