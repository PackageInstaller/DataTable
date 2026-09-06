local UIManager = CS.PixelNeko.UI.UIManager
local NpcChat = require("logic.manager.experimental.types.npcchat")
local TableFrame = require("framework.ui.frame.table.tableframe")
local cNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local cImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local cEmotion = BeanManager.GetTableByName("npc.cemotion")
local cRoleConfig = BeanManager.GetTableByName("role.roleconfig")
local cBattleChatLibrary = BeanManager.GetTableByName("dialog.cbattlechatconfig")
local cBattleChatConfig = BeanManager.GetTableByName("dialog.cbattlechatlist")
local cDramaChatLibrary = BeanManager.GetTableByName("dialog.cdramachatconfig")
local cDramaChatConfig = BeanManager.GetTableByName("dialog.cdramachatlist")
local cChooseEffectConfig = BeanManager.GetTableByName("dialog.cchooseeffectconfig")
local cHomeChatLibrary = BeanManager.GetTableByName("dialog.chomechatconfig")
local cHomeChatConfig = BeanManager.GetTableByName("dialog.chomechatlist")
local cRuneChatLibrary = BeanManager.GetTableByName("welfare.crunechatconfig")
local cRuneChatConfig = BeanManager.GetTableByName("welfare.crunechatlist")
local cArenaChatList = BeanManager.GetTableByName("dialog.carenachatconfig")
local cArenaChatConfig = BeanManager.GetTableByName("dialog.carenachatlist")
local cStarryMirrorChatLibrary = BeanManager.GetTableByName("dialog.cstarrymirrorchatconfig")
local cStarryMirrorChatConfig = BeanManager.GetTableByName("dialog.cstarrymirrorchatlist")
local cSwimSuitChatLibrary = BeanManager.GetTableByName("dialog.chexagonchatconfig")
local cSwimSuitChatConfig = BeanManager.GetTableByName("dialog.chexagonchatlist")
local cMidAutumnChatLibrary = BeanManager.GetTableByName("dialog.cmidautumnchatconfig")
local cMidAutumnChatConfig = BeanManager.GetTableByName("dialog.cmidautumnchatlist")
local cChrismasChatLibrary = BeanManager.GetTableByName("dialog.cchristmaschatconfig")
local cChristmasChatConfig = BeanManager.GetTableByName("dialog.cchristmaschatlist")
local cLoverChatLibrary = BeanManager.GetTableByName("dialog.cvalentinechatconfig")
local cLoverChatConfig = BeanManager.GetTableByName("dialog.cvalentinechatlist")
local cAprilFoolsChatLibrary = BeanManager.GetTableByName("dialog.cclownchatconfig")
local cAprilFoolsChatConfig = BeanManager.GetTableByName("dialog.cclownchatlist")
local CForesightChatLibrary = BeanManager.GetTableByName("dialog.cforesightchatconfig")
local CForesightChatList = BeanManager.GetTableByName("dialog.cforesightchatlist")
local cAnniversaryChatLibrary = BeanManager.GetTableByName("dialog.canniversarychatconfig")
local cAnniversaryChatConfig = BeanManager.GetTableByName("dialog.canniversarychatlist")
local CSRChatConfig = BeanManager.GetTableByName("dialog.csrchatconfig")
local CSRChatList = BeanManager.GetTableByName("dialog.csrchatlist")
local cDialogLibrary, cChatConfig
local FunctionType = {Resonance = 1}
local ResonanceRefValue = cRuneChatConfig:GetRecorder(1).chooseTextID[1]
ResonanceRefValue = TextManager.GetText(ResonanceRefValue)
local NewNpcChatDialog = class("NewNpcChatDialog", Dialog)
NewNpcChatDialog.AssetBundleName = "ui/layouts.dramadialog"
NewNpcChatDialog.AssetName = "BattleChat"

function NewNpcChatDialog:Ctor(...)
  NewNpcChatDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._timer = nil
  self._isTimerCanClick = false
  self._leftLive2DID = 0
  self._rightLive2DID = 0
  self._leftLive2DEmotion = 0
  self._rightLive2DEmotion = 0
  self._chatList = {}
  self._currentChatIndex = 0
  self._initialLibraryId = nil
  self._dramaChatParagraph = {startTime = nil, duration = -1}
  self.DialogType = {
    Foresight = -2,
    MidAutumn = -1,
    Resonance = 1,
    Arena = 2,
    StarMirage = 3,
    SwimSuit = 4,
    Christmas = 5,
    Lover = 6,
    AprilFools = 7,
    Anniversary = 8,
    SummerEchoes = 9
  }
end

function NewNpcChatDialog:Clear(...)
  self._dramaChatParagraph.startTime = nil
  self._dramaChatParagraph.duration = -1
  self._chatList = {}
  self._currentChatIndex = 0
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  if self._backTxtTimer then
    GameTimer.RemoveTask(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._delayToNext then
    GameTimer.RemoveTask(self._delayToNext)
    self._delayToNext = nil
  end
  if self._frame then
    LogInfo("NewNpcChatDialog", "in Clear function frame being Destroy")
    self._frame:Destroy()
    self._frame = nil
  end
end

function NewNpcChatDialog:OnCreate()
  self._background = self:GetChild("Black")
  self._starMirageBackground = self:GetChild("Background")
  self._leftRoleShowPanel = self:GetChild("PhotoL")
  self._leftModel = self:GetChild("PhotoL/Image")
  self._leftModelNameBoard = self:GetChild("UI/NameL")
  self._leftModelName = self:GetChild("UI/NameL/Text")
  self._leftModelLive2D = self:GetChild("PhotoL/Live2D")
  self._rightRoleShowPanel = self:GetChild("PhotoR")
  self._rightModel = self:GetChild("PhotoR/Image")
  self._rightModelLive2D = self:GetChild("PhotoR/Live2D")
  self._rightModelNameBoard = self:GetChild("UI/NameR")
  self._rightModelName = self:GetChild("UI/NameR/Text")
  self._uiBack = self:GetChild("UI/Back")
  self._backText = self:GetChild("UI/Back/Text")
  self._nextBtn = self:GetChild("UI/Back/NextBtn")
  self._nextTxt = self:GetChild("UI/Back/NextTxt")
  self._nextBtn:SetActive(false)
  self._nextTxt:SetActive(false)
  self._backLogBtn = self:GetChild("UI/BackBtn")
  self._backLogBtn:SetActive(false)
  self._effectWnd = self:GetChild("UI/Effects")
  self._skipBtn = self:GetChild("UI/SkipBtn")
  self._skipBtn:SetActive(false)
  self._nextWnd = self:GetChild("UI/Panel")
  self._selectionWnd = self:GetChild("UI/Selection")
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self._selectionWnd:GetPosition()
  _, self._initHeight = self._selectionWnd:GetHeight()
  self._skipBtn:Subscribe_PointerClickEvent(self.OnSkipBtnClicked, self)
  self._nextWnd:Subscribe_PointerClickEvent(self.OnNextBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSingletonDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  self:GetRootWindow():Subscribe_StateEnterEvent(self.OnStateEnter, self)
end

function NewNpcChatDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    LogInfo("NewNpcChatDialog", "in OnDestroy function frame being Destroy")
    self._frame:Destroy()
    self._frame = nil
  end
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  if self._backTxtTimer then
    GameTimer.RemoveTask(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._delayToNext then
    GameTimer.RemoveTask(self._delayToNext)
    self._delayToNext = nil
  end
  if self._isBaseCharChat and self._isBaseCharChat == 1 and GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity" then
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if controller then
      controller:ForgerPlayAnimation()
    end
  end
  if self._dalogType and self._dalogType == self.DialogType.MidAutumn then
    if self._initialLibraryId and self._initialLibraryId == tonumber(BeanManager.GetTableByName("dungeonselect.canniversaryspecialcfg"):GetRecorder(4).type) and NekoData.BehaviorManager.BM_Anniversary:IsDisplayFirstDrama() then
      local protocol = LuaNetManager.CreateProtocol("protocol.activity.canniversarydramapass")
      protocol:Send()
      DialogManager.CreateSingletonDialog("activity.anniversary.anniversarymaindialog"):SetTabType(NekoData.BehaviorManager.BM_Game:GetLocalCache(DataCommon.LocalCache.AnniversaryOpenType))
    end
  elseif self._dalogType and self._dalogType == self.DialogType.SummerEchoes and self._initialLibraryId and self._initialLibraryId == DataCommon.SummerEchoesChatId_FirstOpenChallenge then
    NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.SummerEchoesChallengeFirstOpen)
    NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):OnBlockClick(DataCommon.SummerEchoesChallengeBlockId)
  end
  LuaNotificationCenter.PostNotification(Common.n_NPCChatEnd, self, self._initialLibraryId)
end

function NewNpcChatDialog:SetDialogLibraryId(libraryId, isBaseCharChat, dialogType)
  self:Clear()
  self._isBaseCharChat = isBaseCharChat
  if dialogType then
    self._dalogType = dialogType
  end
  self._initialLibraryId = self._initialLibraryId or libraryId
  if isBaseCharChat then
    if self._dalogType == self.DialogType.Resonance then
      self._functionType = FunctionType.Resonance
      cDialogLibrary = cRuneChatLibrary
      cChatConfig = cRuneChatConfig
    elseif self._dalogType == self.DialogType.Arena then
      cDialogLibrary = cArenaChatList
      cChatConfig = cArenaChatConfig
    else
      cDialogLibrary = cHomeChatLibrary
      cChatConfig = cHomeChatConfig
    end
  elseif self._dalogType == self.DialogType.StarMirage then
    cDialogLibrary = cStarryMirrorChatLibrary
    cChatConfig = cStarryMirrorChatConfig
  elseif self._dalogType == self.DialogType.SwimSuit then
    cDialogLibrary = cSwimSuitChatLibrary
    cChatConfig = cSwimSuitChatConfig
  elseif self._dalogType == self.DialogType.MidAutumn then
    cDialogLibrary = cMidAutumnChatLibrary
    cChatConfig = cMidAutumnChatConfig
  elseif self._dalogType == self.DialogType.Christmas then
    cDialogLibrary = cChrismasChatLibrary
    cChatConfig = cChristmasChatConfig
  elseif self._dalogType == self.DialogType.Lover then
    cDialogLibrary = cLoverChatLibrary
    cChatConfig = cLoverChatConfig
  elseif self._dalogType == self.DialogType.AprilFools then
    cDialogLibrary = cAprilFoolsChatLibrary
    cChatConfig = cAprilFoolsChatConfig
  elseif self._dalogType == self.DialogType.Foresight then
    cDialogLibrary = CForesightChatLibrary
    cChatConfig = CForesightChatList
  elseif self._dalogType == self.DialogType.Anniversary then
    cDialogLibrary = cAnniversaryChatLibrary
    cChatConfig = cAnniversaryChatConfig
  elseif self._dalogType == self.DialogType.SummerEchoes then
    cDialogLibrary = CSRChatConfig
    cChatConfig = CSRChatList
  elseif libraryId <= 10000 then
    cDialogLibrary = cDramaChatLibrary
    cChatConfig = cDramaChatConfig
  else
    cDialogLibrary = cBattleChatLibrary
    cChatConfig = cBattleChatConfig
  end
  self._libraryRecord = cDialogLibrary:GetRecorder(libraryId)
  if not self._libraryRecord then
    LogErrorFormat("NewNpcChatDialog ", " libraryId:%s is not in cbattlechatconfig", libraryId)
    return
  end
  self._skipBtnCanSkip = self._libraryRecord.canSkip ~= nil and self._libraryRecord.canSkip == 1
  self._skipBtn:SetActive(self._skipBtnCanSkip)
  local strList = string.split(self._libraryRecord.dialogList, ",")
  for _, str in pairs(strList) do
    local strIdRange = string.split(str, "-")
    if strIdRange[1] and strIdRange[2] then
      for id = tonumber(strIdRange[1]), tonumber(strIdRange[2]) do
        table.insert(self._chatList, id)
      end
    elseif strIdRange[1] then
      table.insert(self._chatList, tonumber(strIdRange[1]))
    end
  end
  self._currentChatIndex = 1
  self:SetChatId(self._chatList[self._currentChatIndex])
  if not isBaseCharChat and dialogType ~= self.DialogType.MidAutumn and libraryId <= 10000 and self._libraryRecord.skipTime > -1 then
    self._dramaChatParagraph.startTime = ServerGameTimer.GetServerTimeForecast()
    self._dramaChatParagraph.duration = self._libraryRecord.skipTime
  end
end

function NewNpcChatDialog:SetChatId(chatId)
  self._chatConfig = cChatConfig:GetRecorder(chatId)
  if not self._chatConfig then
    LogErrorFormat("NewNpcChatDialog ", " chatId:%s is not in cbattlechatlist", chatId)
    return
  end
  if not self._isBaseCharChat and self._initialLibraryId and self._initialLibraryId <= 10000 then
    self._chatChooseEffectRecorder = cChooseEffectConfig:GetRecorder(chatId)
  end
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  if self._backTxtTimer then
    GameTimer.RemoveTask(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._nextWnd then
    self._nextWnd:SetActive(self._chatConfig.isClickable == 1)
  else
    LogError("NewNpcChatDialog", "nextwnd(UI/Panel) is nil, why")
  end
  if self._chatConfig.chatType == 4 or self._chatConfig.chatType == 5 then
    self:SetNodeActive(false)
  else
    self:SetNodeActive(true)
  end
  if self._chatConfig.shake and self._chatConfig.shake ~= 0 then
    self._rootWindow:SetAnimatorInteger("Shock", self._chatConfig.shake)
  else
    self._rootWindow:SetAnimatorInteger("Shock", 0)
  end
  self:PlayVoice()
  self:SetLeftInfo()
  self:SetRightInfo()
  self:SetBackground()
  if self._chatConfig.chatType == 3 then
    self:ShowChoose()
  elseif self._chatConfig.chatType == 5 then
    self:OpenBlackCoverDialog()
  else
    self:ShowContent()
  end
  UIManager.SetAnimatorAndParticleUseUnscaleTime(self:GetRootWindow():GetUIObject())
end

function NewNpcChatDialog:SetBackground()
  self._starMirageBackground:SetActive(false)
  if self._dalogType == self.DialogType.Arena or self._dalogType == self.DialogType.StarMirage or self._dalogType == self.DialogType.SwimSuit or self._dalogType == self.DialogType.Christmas or self._dalogType == self.DialogType.Lover or self._dalogType == self.DialogType.SummerEchoes or self._dalogType == self.DialogType.Anniversary then
    local recorder = self._libraryRecord.bgImage
    if recorder ~= 0 then
      local background = BeanManager.GetTableByName("ui.cimagepath"):GetRecorder(recorder)
      if background then
        if self._dalogType == self.DialogType.StarMirage or self._dalogType == self.DialogType.Lover or self._dalogType == self.DialogType.Anniversary then
          self._starMirageBackground:SetActive(true)
          self._starMirageBackground:SetSprite(background.assetBundle, background.assetName)
          self._starMirageBackground:SetColor(CS.UnityEngine.Color(1, 1, 1, 1))
        else
          self._background:SetSprite(background.assetBundle, background.assetName)
          self._background:SetColor(CS.UnityEngine.Color(1, 1, 1, 1))
        end
      end
    end
  end
  self._background:SetActive(self._chatConfig.isBlack == 1)
end

function NewNpcChatDialog:PlayVoice()
  if self._chatConfig.voiceId ~= 0 then
    LuaAudioManager.PlayVoice(self._chatConfig.voiceId)
  end
end

function NewNpcChatDialog:PickRandomRoleID()
  local keys = NekoData.BehaviorManager.BM_Team:GetCurrentRoleKeys()
  local id
  local list = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
  if #list == 1 then
    return 3
  end
  local valid_keys = {}
  for _, v in pairs(keys) do
    if v ~= 0 then
      valid_keys[#valid_keys + 1] = v
    end
  end
  if #valid_keys < 2 then
    id = list[math.random(#list)]:GetId()
  else
    id = valid_keys[math.random(#valid_keys)]
  end
  return id
end

function NewNpcChatDialog:GetRandomRoleInfo(randomid)
  self._randomRoles = self._randomRoles or {}
  if not self._randomRoles[randomid] then
    local roleid, info
    repeat
      roleid = self:PickRandomRoleID()
    until roleid ~= 1 and not table.any(self._randomRoles, function(k, v)
      return v:GetId() == roleid
    end)
    info = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleid)
    self._randomRoles[randomid] = info
  end
  return self._randomRoles[randomid]
end

function NewNpcChatDialog:SetLeftInfo()
  local bShow = true
  local random = false
  if self._chatConfig.chatType == 0 or self._chatConfig.chatType == 3 or self._chatConfig.shapeId[1] == 0 then
    bShow = false
  elseif self._chatConfig.shapeId[1] <= -1 then
    random = true
  end
  self:SetLive2DNodeActive(1, bShow)
  local roleinfo
  if random then
    roleinfo = self:GetRandomRoleInfo(self._chatConfig.shapeId[1])
  end
  local name
  if random and self._chatConfig.nameTextID[1] == self._chatConfig.shapeId[1] then
    name = roleinfo:GetRoleName()
  else
    name = TextManager.GetText(self._chatConfig.nameTextID[1]) or ""
  end
  self._leftModelNameBoard:SetActive(name ~= "null")
  name = string.gsub(name, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username or "")
  self._leftModelName:SetText(name)
  if not bShow then
    return
  end
  local shapeid
  if random then
    shapeid = roleinfo:GetRoleConfig().shapeID
  else
    shapeid = self._chatConfig.shapeId[1]
  end
  local npcShapeRecorder = cNPCShape:GetRecorder(shapeid)
  local newLive2D = self:SetLive2DOrLiHuiInfo(self._leftModel, self._leftModelLive2D, self._live2dLeft, self._leftLive2DID, npcShapeRecorder)
  if Live2DManager.CanUse() and npcShapeRecorder.live2DAssetBundleName ~= "" then
    self._live2dLeft = newLive2D
    self._leftLive2DID = self._chatConfig.shapeId[1]
    if self._chatConfig.emotionId[1] ~= 0 and self._leftLive2DEmotion ~= self._chatConfig.emotionId[1] then
      local emotionName = cEmotion:GetRecorder(self._chatConfig.emotionId[1]).Name
      self._leftModelLive2D:PlayLive2DAnimation(emotionName, self._live2dLeft)
      self._leftLive2DEmotion = self._chatConfig.emotionId[1]
    end
  end
  if self._chatConfig.chatType == 2 or self._chatConfig.chatType == 102 then
    if self._live2dLeft then
      local live2dcfg = self:GetLive2DColorConfig(self._chatConfig.chatType)
      self._leftModelLive2D:SetColorTint(self._live2dLeft, live2dcfg.r, live2dcfg.g, live2dcfg.b, live2dcfg.a)
    else
      local imagecfg = self:GetImageColorConfig(self._chatConfig.chatType)
      self._leftModel:SetColor(CS.UnityEngine.Color(imagecfg.r, imagecfg.g, imagecfg.b, imagecfg.a))
    end
  elseif self._live2dLeft then
    self._leftModelLive2D:SetColorTint(self._live2dLeft, 1, 1, 1, 1)
  else
    self._leftModel:SetColor("white")
  end
end

function NewNpcChatDialog:SetRightInfo()
  local bShow = true
  local random = false
  if self._chatConfig.chatType == 0 or self._chatConfig.chatType == 3 or self._chatConfig.shapeId[2] == 0 then
    bShow = false
  elseif self._chatConfig.shapeId[2] <= -1 then
    random = true
  end
  self:SetLive2DNodeActive(2, bShow)
  local roleinfo
  if random then
    roleinfo = self:GetRandomRoleInfo(self._chatConfig.shapeId[2])
  end
  local name
  if random and self._chatConfig.nameTextID[2] == self._chatConfig.shapeId[2] then
    name = roleinfo:GetRoleName()
  else
    name = TextManager.GetText(self._chatConfig.nameTextID[2]) or ""
  end
  self._rightModelNameBoard:SetActive(self._chatConfig.nameTextID[2] and name ~= "null")
  name = string.gsub(name, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username or "")
  self._rightModelName:SetText(name)
  if not bShow then
    return
  end
  local shapeid
  if random then
    shapeid = roleinfo:GetRoleConfig().shapeID
  else
    shapeid = self._chatConfig.shapeId[2]
  end
  local npcShapeRecorder = cNPCShape:GetRecorder(shapeid)
  local newLive2D = self:SetLive2DOrLiHuiInfo(self._rightModel, self._rightModelLive2D, self._live2d, self._rightLive2DID, npcShapeRecorder, true)
  if Live2DManager.CanUse() and npcShapeRecorder.live2DAssetBundleName ~= "" then
    self._live2d = newLive2D
    self._rightLive2DID = self._chatConfig.shapeId[2]
    if self._chatConfig.emotionId[2] ~= 0 and self._rightLive2DEmotion ~= self._chatConfig.emotionId[2] then
      local emotionName = cEmotion:GetRecorder(self._chatConfig.emotionId[2]).Name
      self._rightModelLive2D:PlayLive2DAnimation(emotionName, self._live2d)
      self._rightLive2DEmotion = self._chatConfig.emotionId[2]
    end
  end
  if self._chatConfig.chatType == 1 or self._chatConfig.chatType == 101 then
    if self._live2d then
      local live2dcfg = self:GetLive2DColorConfig(self._chatConfig.chatType)
      self._rightModelLive2D:SetColorTint(self._live2d, live2dcfg.r, live2dcfg.g, live2dcfg.b, live2dcfg.a)
    else
      local imagecfg = self:GetImageColorConfig(self._chatConfig.chatType)
      self._rightModel:SetColor(CS.UnityEngine.Color(imagecfg.r, imagecfg.g, imagecfg.b, imagecfg.a))
    end
  elseif self._live2d then
    self._rightModelLive2D:SetColorTint(self._live2d, 1, 1, 1, 1)
  else
    self._rightModel:SetColor("white")
  end
end

local function SetBackText(self, text)
  if self._chatConfig.chatType ~= 4 then
    self._backText:SetText(text)
  else
    local dialog = DialogManager.GetDialog("npcchat.blacknarrationdialog")
    dialog = dialog or DialogManager.CreateSingletonChildDialog("npcchat.blacknarrationdialog", self._dialogName, self:GetRootWindow())
    dialog:SetText(text, self._chatConfig.position)
  end
end

function NewNpcChatDialog:ShowContent()
  self._uiBack:SetActive(true)
  if tonumber(self._chatConfig.speed) and tonumber(self._chatConfig.speed) ~= 0 then
    local initString = self._chatConfig.contentTextID
    initString = TextManager.GetText(initString):gsub("%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username or "")
    local deltTime = tonumber(self._chatConfig.speed)
    local chars = stringutils.split2table(initString)
    local index = 0
    self._backTxtTimer = GameTimer.AddTask(0, deltTime, function()
      index = index + 1
      if index > #chars then
        SetBackText(self, table.concat(chars))
        if self._chatConfig.skipTime ~= 0 then
          self._timer = GameTimer.AddTask(self._chatConfig.skipTime, 0, function()
            self:ToNextChat()
          end, nil, true)
        end
        GameTimer.RemoveTask(self._backTxtTimer)
        self._backTxtTimer = nil
      else
        SetBackText(self, table.concat(chars, "", 1, index))
      end
    end, nil, true)
  else
    if self._chatConfig.skipTime ~= 0 then
      self._timer = GameTimer.AddTask(self._chatConfig.skipTime, 0, function()
        self:ToNextChat()
      end, nil, true)
    end
    local contentText = TextManager.GetText(self._chatConfig.contentTextID):gsub("%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username or "")
    SetBackText(self, contentText)
  end
end

function NewNpcChatDialog:ShowChoose()
  self._uiBack:SetActive(false)
  if self._frame then
    LogInfo("NewNpcChatDialog", "in ShowChoose function frame should Destroy")
    self._frame:Destroy()
    self._frame = nil
  else
    LogInfo("NewNpcChatDialog", "in ShowChoose function frame being Create")
  end
  self._frame = TableFrame.Create(self._selectionWnd, self, true, false, true)
  local itemFrameHeight = 166 * table.nums(self._chatConfig.chooseTextID)
  self._selectionWnd:SetHeight(0, itemFrameHeight)
  self._frame:ReloadAllCell()
  self._selectionWnd:SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y + (self._initHeight - itemFrameHeight) / 2)
end

local function _to_next_chat(self)
  local dialog = DialogManager.GetDialog("npcchat.blacknarrationdialog")
  if dialog then
    dialog:Skip()
    return
  end
  if self._currentChatIndex >= #self._chatList then
    if self._libraryRecord.nextDialog and self._libraryRecord.nextDialog > 0 then
      self:SetDialogLibraryId(self._libraryRecord.nextDialog, self._isBaseCharChat)
    else
      self:Destroy()
    end
    GameTimer.RemoveTask(self._delayToNext)
    self._delayToNext = nil
    return
  end
  self._currentChatIndex = self._currentChatIndex + 1
  self:SetChatId(self._chatList[self._currentChatIndex])
  GameTimer.RemoveTask(self._delayToNext)
  self._delayToNext = nil
end

function NewNpcChatDialog:ToNextChat(directShow)
  if directShow then
    _to_next_chat(self)
  elseif not self._delayToNext then
    self._delayToNext = GameTimer.AddTask(0.2, -1, _to_next_chat, self, true)
  end
end

function NewNpcChatDialog:OnSkipBtnClicked(args)
  if self._libraryRecord.nextDialog and self._libraryRecord.nextDialog > 0 then
    self:SetDialogLibraryId(self._libraryRecord.nextDialog, self._isBaseCharChat)
  else
    self:Destroy()
  end
end

function NewNpcChatDialog:OnBackBtnClicked()
  self:OnSkipBtnClicked()
end

function NewNpcChatDialog:OnNextBtnClicked(args, luawindow, tag)
  if self._chatConfig.isClickable == 1 then
    if self._backTxtTimer then
      local contentText = TextManager.GetText(self._chatConfig.contentTextID):gsub("%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username or "")
      SetBackText(self, contentText)
      if self._chatConfig.skipTime ~= 0 then
        self._timer = GameTimer.AddTask(self._chatConfig.skipTime, 0, function()
          self:ToNextChat(tag)
        end, nil, true)
      end
      GameTimer.RemoveTask(self._backTxtTimer)
      self._backTxtTimer = nil
    else
      self:ToNextChat(tag)
    end
  end
end

function NewNpcChatDialog:OnCellClicked(index)
  if self._functionType == FunctionType.Resonance and self._chatConfig.id == 1 then
    local chooseText = TextManager.GetText(self._chatConfig.chooseTextID[index])
    if chooseText == ResonanceRefValue then
      DialogManager.CreateSingletonDialog("resonance.resonancedialog")
    else
      LuaNotificationCenter.PostNotification(Common.n_ResonanceNpcChatEnd, nil, nil)
    end
  end
  if self._frame then
    LogInfo("NewNpcChatDialog", "in OnCellClicked function frame being Destroy")
    self._frame:Destroy()
    self._frame = nil
  end
  local jumpLibraryID = self._chatConfig.chooseValue[index]
  if jumpLibraryID then
    self:SetDialogLibraryId(jumpLibraryID, self._isBaseCharChat)
  else
    self:ToNextChat(true)
  end
end

function NewNpcChatDialog:NumberOfCell(frame)
  return table.nums(self._chatConfig.chooseTextID)
end

function NewNpcChatDialog:CellAtIndex(frame)
  return "npcchat.npcchatselectcell"
end

function NewNpcChatDialog:DataAtIndex(frame, index)
  local data = {}
  data[index] = {index = index}
  if self._chatConfig.chooseTextID[index] then
    data[index].chooseText = TextManager.GetText(self._chatConfig.chooseTextID[index])
  end
  if self._chatConfig.chooseValue[index] then
    data[index].chooseValue = self._chatConfig.chooseValue[index]
  end
  data[index].playEffect = self._chatChooseEffectRecorder and self._chatChooseEffectRecorder.ifEffect[index] == 1
  return data[index]
end

local function SetPosition(image, pos, reverse)
  local x = tonumber(pos[1])
  if reverse then
    x = x * -1
  end
  local y = tonumber(pos[2])
  image:SetAnchoredPosition(x, y)
end

function NewNpcChatDialog:SetLive2DOrLiHuiInfo(modelWnd, live2dWnd, oldLive2D, oldLive2dId, npcShapeRecorder, reverse)
  if Live2DManager.CanUse() and npcShapeRecorder.live2DAssetBundleName ~= "" then
    modelWnd:SetActive(false)
    live2dWnd:SetActive(true)
    if oldLive2dId ~= npcShapeRecorder.id then
      if oldLive2D then
        live2dWnd:Release(oldLive2D)
      end
      local live2D = live2dWnd:AddLive2D(npcShapeRecorder.live2DAssetBundleName, npcShapeRecorder.live2DPrefabName, npcShapeRecorder.live2DScale)
      return live2D
    else
      return oldLive2D
    end
  else
    modelWnd:SetActive(true)
    live2dWnd:SetActive(false)
    local iconID = npcShapeRecorder.lihuiID
    local imageRecord = cImagePathTable:GetRecorder(iconID)
    if imageRecord then
      modelWnd:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      local scale = npcShapeRecorder.photoScale
      modelWnd:SetLocalScale(scale, scale, scale)
      modelWnd:SetAnchoredPosition(npcShapeRecorder.photoLocation[1], npcShapeRecorder.photoLocation[2])
    end
  end
end

local function split_var_config(id)
  local value = BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(id).Value
  local scale = value:split(",")
  for i, v in pairs(scale) do
    scale[i] = tonumber(v)
  end
  return table.unpack(scale)
end

function NewNpcChatDialog:GetLive2DColorConfig(chatType)
  local var_config_id
  if chatType == 1 or chatType == 2 then
    var_config_id = 2
  elseif chatType == 101 or chatType == 102 then
    var_config_id = 122
  end
  if var_config_id then
    local a, r, g, b, x, y, z = split_var_config(var_config_id)
    return {
      a = a,
      r = r,
      g = g,
      b = b,
      x = x,
      y = y,
      z = z
    }
  else
    LogErrorFormat("NewNpcChatDialog", "chatType: %s is not supported.", chatType)
  end
end

function NewNpcChatDialog:GetImageColorConfig(chatType)
  local var_config_id
  if chatType == 1 or chatType == 2 then
    var_config_id = 3
  elseif chatType == 101 or chatType == 102 then
    var_config_id = 123
  end
  if var_config_id then
    local a, r, g, b, x, y, z = split_var_config(var_config_id)
    return {
      a = a,
      r = r,
      g = g,
      b = b,
      x = x,
      y = y,
      z = z
    }
  else
    LogErrorFormat("NewNpcChatDialog", "chatType: %s is not supported.", chatType)
  end
end

function NewNpcChatDialog:OnUpdate()
  if self._dramaChatParagraph.startTime and ServerGameTimer.GetServerTimeForecast() - self._dramaChatParagraph.startTime >= self._dramaChatParagraph.duration * 1000 then
    if self._libraryRecord.nextDialog and self._libraryRecord.nextDialog > 0 then
      self:SetDialogLibraryId(self._libraryRecord.nextDialog, self._isBaseCharChat)
    else
      self:Destroy()
    end
  end
end

function NewNpcChatDialog:OnSingletonDialogDestroy(notification)
  local dialogName = notification.userInfo._dialogName
  if dialogName == "npcchat.blacknarrationdialog" or dialogName == "npcchat.blackcoverdialog" then
    self:ToNextChat(true)
  end
end

function NewNpcChatDialog:OpenBlackCoverDialog()
  local dialog = DialogManager.CreateSingletonChildDialog("npcchat.blackcoverdialog", self._dialogName, self:GetRootWindow())
  if dialog then
    dialog:SetData(self._chatConfig.position)
  end
end

function NewNpcChatDialog:SetLive2DNodeActive(tag, active)
  local alpha = 1
  if not active then
    alpha = 0
  end
  if tag == 1 then
    self._leftRoleShowPanel:SetAlpha(alpha)
    if self._live2dLeft then
      self._leftModelLive2D:SetLocalScale(alpha, alpha, alpha)
    end
  else
    self._rightRoleShowPanel:SetAlpha(alpha)
    if self._live2d then
      self._rightModelLive2D:SetLocalScale(alpha, alpha, alpha)
    end
  end
end

function NewNpcChatDialog:SetNodeActive(active)
  if not active then
    self._starMirageBackground_isActive = self._starMirageBackground:IsActive()
    self._starMirageBackground:SetActive(false)
    self:SetLive2DNodeActive(1, false)
    self:SetLive2DNodeActive(2, false)
    self:GetChild("UI"):SetActive(false)
    self._backText:SetText("")
  else
    self._starMirageBackground:SetActive(self._starMirageBackground_isActive)
    self:SetLive2DNodeActive(1, true)
    self:SetLive2DNodeActive(2, true)
    self:GetChild("UI"):SetActive(true)
  end
end

function NewNpcChatDialog:OnStateEnter(handle, statename, normalizedTime)
  if statename == "Shock" then
    self._rootWindow:SetAnimatorInteger("Shock", 0)
  end
end

return NewNpcChatDialog
