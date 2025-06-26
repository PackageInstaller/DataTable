-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/npcchat/newnpcchatdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local NpcChat = require("logic.manager.experimental.types.npcchat")
local TableFrame = require("framework.ui.frame.table.tableframe")
local cNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local cImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local cEmotion = (BeanManager.GetTableByName)("npc.cemotion")
local cRoleConfig = (BeanManager.GetTableByName)("role.roleconfig")
local cBattleChatLibrary = (BeanManager.GetTableByName)("dialog.cbattlechatconfig")
local cBattleChatConfig = (BeanManager.GetTableByName)("dialog.cbattlechatlist")
local cDramaChatLibrary = (BeanManager.GetTableByName)("dialog.cdramachatconfig")
local cDramaChatConfig = (BeanManager.GetTableByName)("dialog.cdramachatlist")
local cChooseEffectConfig = (BeanManager.GetTableByName)("dialog.cchooseeffectconfig")
local cHomeChatLibrary = (BeanManager.GetTableByName)("dialog.chomechatconfig")
local cHomeChatConfig = (BeanManager.GetTableByName)("dialog.chomechatlist")
local cRuneChatLibrary = (BeanManager.GetTableByName)("welfare.crunechatconfig")
local cRuneChatConfig = (BeanManager.GetTableByName)("welfare.crunechatlist")
local cArenaChatList = (BeanManager.GetTableByName)("dialog.carenachatconfig")
local cArenaChatConfig = (BeanManager.GetTableByName)("dialog.carenachatlist")
local cStarryMirrorChatLibrary = (BeanManager.GetTableByName)("dialog.cstarrymirrorchatconfig")
local cStarryMirrorChatConfig = (BeanManager.GetTableByName)("dialog.cstarrymirrorchatlist")
local cSwimSuitChatLibrary = (BeanManager.GetTableByName)("dialog.chexagonchatconfig")
local cSwimSuitChatConfig = (BeanManager.GetTableByName)("dialog.chexagonchatlist")
local cMidAutumnChatLibrary = (BeanManager.GetTableByName)("dialog.cmidautumnchatconfig")
local cMidAutumnChatConfig = (BeanManager.GetTableByName)("dialog.cmidautumnchatlist")
local cChrismasChatLibrary = (BeanManager.GetTableByName)("dialog.cchristmaschatconfig")
local cChristmasChatConfig = (BeanManager.GetTableByName)("dialog.cchristmaschatlist")
local cLoverChatLibrary = (BeanManager.GetTableByName)("dialog.cvalentinechatconfig")
local cLoverChatConfig = (BeanManager.GetTableByName)("dialog.cvalentinechatlist")
local cAprilFoolsChatLibrary = (BeanManager.GetTableByName)("dialog.cclownchatconfig")
local cAprilFoolsChatConfig = (BeanManager.GetTableByName)("dialog.cclownchatlist")
local CForesightChatLibrary = (BeanManager.GetTableByName)("dialog.cforesightchatconfig")
local CForesightChatList = (BeanManager.GetTableByName)("dialog.cforesightchatlist")
local cAnniversaryChatLibrary = (BeanManager.GetTableByName)("dialog.canniversarychatconfig")
local cAnniversaryChatConfig = (BeanManager.GetTableByName)("dialog.canniversarychatlist")
local CSRChatConfig = (BeanManager.GetTableByName)("dialog.csrchatconfig")
local CSRChatList = ((BeanManager.GetTableByName)("dialog.csrchatlist"))
local cDialogLibrary, cChatConfig = nil, nil
local FunctionType = {Resonance = 1}
local ResonanceRefValue = ((cRuneChatConfig:GetRecorder(1)).chooseTextID)[1]
ResonanceRefValue = (TextManager.GetText)(ResonanceRefValue)
local NewNpcChatDialog = class("NewNpcChatDialog", Dialog)
NewNpcChatDialog.AssetBundleName = "ui/layouts.dramadialog"
NewNpcChatDialog.AssetName = "BattleChat"
NewNpcChatDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewNpcChatDialog
  ((NewNpcChatDialog.super).Ctor)(self, ...)
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
  self.DialogType = {Foresight = -2, MidAutumn = -1, Resonance = 1, Arena = 2, StarMirage = 3, SwimSuit = 4, Christmas = 5, Lover = 6, AprilFools = 7, Anniversary = 8, SummerEchoes = 9}
end

NewNpcChatDialog.Clear = function(self, ...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._dramaChatParagraph).startTime = nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._dramaChatParagraph).duration = -1
  self._chatList = {}
  self._currentChatIndex = 0
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
  if self._backTxtTimer then
    (GameTimer.RemoveTask)(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._delayToNext then
    (GameTimer.RemoveTask)(self._delayToNext)
    self._delayToNext = nil
  end
  if self._frame then
    LogInfo("NewNpcChatDialog", "in Clear function frame being Destroy")
    ;
    (self._frame):Destroy()
    self._frame = nil
  end
end

NewNpcChatDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV
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
  ;
  (self._nextBtn):SetActive(false)
  ;
  (self._nextTxt):SetActive(false)
  self._backLogBtn = self:GetChild("UI/BackBtn")
  ;
  (self._backLogBtn):SetActive(false)
  self._effectWnd = self:GetChild("UI/Effects")
  self._skipBtn = self:GetChild("UI/SkipBtn")
  ;
  (self._skipBtn):SetActive(false)
  self._nextWnd = self:GetChild("UI/Panel")
  self._selectionWnd = self:GetChild("UI/Selection")
  self._talk_pos_x = (self._selectionWnd):GetPosition()
  _ = (self._selectionWnd):GetHeight()
  ;
  (self._skipBtn):Subscribe_PointerClickEvent(self.OnSkipBtnClicked, R4_PC103)
  -- DECOMPILER ERROR at PC120: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._nextWnd):Subscribe_PointerClickEvent(self.OnNextBtnClicked, R4_PC103)
  -- DECOMPILER ERROR at PC126: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC127: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, R4_PC103, nil)
  -- DECOMPILER ERROR at PC134: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC135: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSingletonDialogDestroy, R4_PC103, nil)
  -- DECOMPILER ERROR at PC142: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self:GetRootWindow()):Subscribe_StateEnterEvent(self.OnStateEnter, R4_PC103)
end

NewNpcChatDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    LogInfo("NewNpcChatDialog", "in OnDestroy function frame being Destroy")
    ;
    (self._frame):Destroy()
    self._frame = nil
  end
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
  if self._backTxtTimer then
    (GameTimer.RemoveTask)(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._delayToNext then
    (GameTimer.RemoveTask)(self._delayToNext)
    self._delayToNext = nil
  end
  do
    if self._isBaseCharChat and self._isBaseCharChat == 1 and GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity" then
      local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
      if controller then
        controller:ForgerPlayAnimation()
      end
    end
    do
      if self._dalogType and self._dalogType == (self.DialogType).MidAutumn and self._initialLibraryId and self._initialLibraryId == tonumber((((BeanManager.GetTableByName)("dungeonselect.canniversaryspecialcfg")):GetRecorder(4)).type) and ((NekoData.BehaviorManager).BM_Anniversary):IsDisplayFirstDrama() then
        local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.canniversarydramapass")
        protocol:Send()
        ;
        ((DialogManager.CreateSingletonDialog)("activity.anniversary.anniversarymaindialog")):SetTabType(((NekoData.BehaviorManager).BM_Game):GetLocalCache((DataCommon.LocalCache).AnniversaryOpenType))
      end
      if self._dalogType and self._dalogType == (self.DialogType).SummerEchoes and self._initialLibraryId and self._initialLibraryId == DataCommon.SummerEchoesChatId_FirstOpenChallenge then
        ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).SummerEchoesChallengeFirstOpen)
        ;
        (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):OnBlockClick(DataCommon.SummerEchoesChallengeBlockId)
      end
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_NPCChatEnd, self, self._initialLibraryId)
    end
  end
end

NewNpcChatDialog.SetDialogLibraryId = function(self, libraryId, isBaseCharChat, dialogType)
  -- function num : 0_4 , upvalues : FunctionType, cDialogLibrary, cRuneChatLibrary, cChatConfig, cRuneChatConfig, cArenaChatList, cArenaChatConfig, cHomeChatLibrary, cHomeChatConfig, cStarryMirrorChatLibrary, cStarryMirrorChatConfig, cSwimSuitChatLibrary, cSwimSuitChatConfig, cMidAutumnChatLibrary, cMidAutumnChatConfig, cChrismasChatLibrary, cChristmasChatConfig, cLoverChatLibrary, cLoverChatConfig, cAprilFoolsChatLibrary, cAprilFoolsChatConfig, CForesightChatLibrary, CForesightChatList, cAnniversaryChatLibrary, cAnniversaryChatConfig, CSRChatConfig, CSRChatList, cDramaChatLibrary, cDramaChatConfig, cBattleChatLibrary, cBattleChatConfig, _ENV
  self:Clear()
  self._isBaseCharChat = isBaseCharChat
  if dialogType then
    self._dalogType = dialogType
  end
  self._initialLibraryId = self._initialLibraryId or libraryId
  if isBaseCharChat then
    if self._dalogType == (self.DialogType).Resonance then
      self._functionType = FunctionType.Resonance
      cDialogLibrary = cRuneChatLibrary
      cChatConfig = cRuneChatConfig
    else
      if self._dalogType == (self.DialogType).Arena then
        cDialogLibrary = cArenaChatList
        cChatConfig = cArenaChatConfig
      else
        cDialogLibrary = cHomeChatLibrary
        cChatConfig = cHomeChatConfig
      end
    end
  else
    if self._dalogType == (self.DialogType).StarMirage then
      cDialogLibrary = cStarryMirrorChatLibrary
      cChatConfig = cStarryMirrorChatConfig
    else
      if self._dalogType == (self.DialogType).SwimSuit then
        cDialogLibrary = cSwimSuitChatLibrary
        cChatConfig = cSwimSuitChatConfig
      else
        if self._dalogType == (self.DialogType).MidAutumn then
          cDialogLibrary = cMidAutumnChatLibrary
          cChatConfig = cMidAutumnChatConfig
        else
          if self._dalogType == (self.DialogType).Christmas then
            cDialogLibrary = cChrismasChatLibrary
            cChatConfig = cChristmasChatConfig
          else
            if self._dalogType == (self.DialogType).Lover then
              cDialogLibrary = cLoverChatLibrary
              cChatConfig = cLoverChatConfig
            else
              if self._dalogType == (self.DialogType).AprilFools then
                cDialogLibrary = cAprilFoolsChatLibrary
                cChatConfig = cAprilFoolsChatConfig
              else
                if self._dalogType == (self.DialogType).Foresight then
                  cDialogLibrary = CForesightChatLibrary
                  cChatConfig = CForesightChatList
                else
                  if self._dalogType == (self.DialogType).Anniversary then
                    cDialogLibrary = cAnniversaryChatLibrary
                    cChatConfig = cAnniversaryChatConfig
                  else
                    if self._dalogType == (self.DialogType).SummerEchoes then
                      cDialogLibrary = CSRChatConfig
                      cChatConfig = CSRChatList
                    else
                      if libraryId <= 10000 then
                        cDialogLibrary = cDramaChatLibrary
                        cChatConfig = cDramaChatConfig
                      else
                        cDialogLibrary = cBattleChatLibrary
                        cChatConfig = cBattleChatConfig
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  self._libraryRecord = cDialogLibrary:GetRecorder(libraryId)
  if not self._libraryRecord then
    LogErrorFormat("NewNpcChatDialog ", " libraryId:%s is not in cbattlechatconfig", libraryId)
    return 
  end
  self._skipBtnCanSkip = (self._libraryRecord).canSkip ~= nil and (self._libraryRecord).canSkip == 1
  ;
  (self._skipBtn):SetActive(self._skipBtnCanSkip)
  local strList = (string.split)((self._libraryRecord).dialogList, ",")
  for _,str in pairs(strList) do
    local strIdRange = (string.split)(str, "-")
    if strIdRange[1] and strIdRange[2] then
      for id = tonumber(strIdRange[1]), tonumber(strIdRange[2]) do
        (table.insert)(self._chatList, id)
      end
    elseif strIdRange[1] then
      (table.insert)(self._chatList, tonumber(strIdRange[1]))
    end
  end
  self._currentChatIndex = 1
  self:SetChatId((self._chatList)[self._currentChatIndex])
  -- DECOMPILER ERROR at PC240: Confused about usage of register: R5 in 'UnsetPending'

  if not isBaseCharChat and dialogType ~= (self.DialogType).MidAutumn and libraryId <= 10000 and (self._libraryRecord).skipTime > -1 then
    (self._dramaChatParagraph).startTime = (ServerGameTimer.GetServerTimeForecast)()
    -- DECOMPILER ERROR at PC244: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._dramaChatParagraph).duration = (self._libraryRecord).skipTime
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

NewNpcChatDialog.SetChatId = function(self, chatId)
  -- function num : 0_5 , upvalues : cChatConfig, _ENV, cChooseEffectConfig, UIManager
  self._chatConfig = cChatConfig:GetRecorder(chatId)
  if not self._chatConfig then
    LogErrorFormat("NewNpcChatDialog ", " chatId:%s is not in cbattlechatlist", chatId)
    return 
  end
  if not self._isBaseCharChat and self._initialLibraryId and self._initialLibraryId <= 10000 then
    self._chatChooseEffectRecorder = cChooseEffectConfig:GetRecorder(chatId)
  end
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
  if self._backTxtTimer then
    (GameTimer.RemoveTask)(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if (self._chatConfig).isClickable ~= 1 then
    (self._nextWnd):SetActive(not self._nextWnd)
    LogError("NewNpcChatDialog", "nextwnd(UI/Panel) is nil, why")
    if (self._chatConfig).chatType == 4 or (self._chatConfig).chatType == 5 then
      self:SetNodeActive(false)
    else
      self:SetNodeActive(true)
    end
    if (self._chatConfig).shake and (self._chatConfig).shake ~= 0 then
      (self._rootWindow):SetAnimatorInteger("Shock", (self._chatConfig).shake)
    else
      (self._rootWindow):SetAnimatorInteger("Shock", 0)
    end
    self:PlayVoice()
    self:SetLeftInfo()
    self:SetRightInfo()
    self:SetBackground()
    if (self._chatConfig).chatType == 3 then
      self:ShowChoose()
    elseif (self._chatConfig).chatType == 5 then
      self:OpenBlackCoverDialog()
    else
      self:ShowContent()
    end
    ;
    (UIManager.SetAnimatorAndParticleUseUnscaleTime)((self:GetRootWindow()):GetUIObject())
    -- DECOMPILER ERROR: 11 unprocessed JMP targets
  end
end

NewNpcChatDialog.SetBackground = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (self._starMirageBackground):SetActive(false)
  if self._dalogType == (self.DialogType).Arena or self._dalogType == (self.DialogType).StarMirage or self._dalogType == (self.DialogType).SwimSuit or self._dalogType == (self.DialogType).Christmas or self._dalogType == (self.DialogType).Lover or self._dalogType == (self.DialogType).SummerEchoes or self._dalogType == (self.DialogType).Anniversary then
    local recorder = (self._libraryRecord).bgImage
    if recorder ~= 0 then
      local background = ((BeanManager.GetTableByName)("ui.cimagepath")):GetRecorder(recorder)
      if background then
        if self._dalogType == (self.DialogType).StarMirage or self._dalogType == (self.DialogType).Lover or self._dalogType == (self.DialogType).Anniversary then
          (self._starMirageBackground):SetActive(true)
          ;
          (self._starMirageBackground):SetSprite(background.assetBundle, background.assetName)
          ;
          (self._starMirageBackground):SetColor(((CS.UnityEngine).Color)(1, 1, 1, 1))
        else
          ;
          (self._background):SetSprite(background.assetBundle, background.assetName)
          ;
          (self._background):SetColor(((CS.UnityEngine).Color)(1, 1, 1, 1))
        end
      end
    end
  end
  do
    ;
    (self._background):SetActive((self._chatConfig).isBlack == 1)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

NewNpcChatDialog.PlayVoice = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if (self._chatConfig).voiceId ~= 0 then
    (LuaAudioManager.PlayVoice)((self._chatConfig).voiceId)
  end
end

NewNpcChatDialog.PickRandomRoleID = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (((NekoData.BehaviorManager).BM_Team):GetCurrentRoleKeys())
  local keys = nil
  local id = nil
  local list = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
  if #list == 1 then
    return 3
  end
  local valid_keys = {}
  for _,v in pairs(keys) do
    if v ~= 0 then
      valid_keys[#valid_keys + 1] = v
    end
  end
  if #valid_keys < 2 then
    id = (list[(math.random)(#list)]):GetId()
  else
    id = valid_keys[(math.random)(#valid_keys)]
  end
  return id
end

NewNpcChatDialog.GetRandomRoleInfo = function(self, randomid)
  -- function num : 0_9 , upvalues : _ENV
  if not self._randomRoles then
    self._randomRoles = {}
    do
      if not (self._randomRoles)[randomid] then
        local roleid, info = nil, nil
        do
          repeat
            repeat
              roleid = self:PickRandomRoleID()
            until roleid ~= 1
          until not (table.any)(self._randomRoles, function(k, v)
    -- function num : 0_9_0 , upvalues : roleid
    do return v:GetId() == roleid end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
          info = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleid)
          -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

          ;
          (self._randomRoles)[randomid] = info
        end
      end
      return (self._randomRoles)[randomid]
    end
  end
end

NewNpcChatDialog.SetLeftInfo = function(self)
  -- function num : 0_10 , upvalues : _ENV, cNPCShape, cEmotion
  local bShow = true
  local random = false
  if (self._chatConfig).chatType == 0 or (self._chatConfig).chatType == 3 or ((self._chatConfig).shapeId)[1] == 0 then
    bShow = false
  else
    if ((self._chatConfig).shapeId)[1] <= -1 then
      random = true
    end
  end
  self:SetLive2DNodeActive(1, bShow)
  local roleinfo = nil
  if random then
    roleinfo = self:GetRandomRoleInfo(((self._chatConfig).shapeId)[1])
  end
  local name = nil
  if random and ((self._chatConfig).nameTextID)[1] == ((self._chatConfig).shapeId)[1] then
    name = roleinfo:GetRoleName()
  else
    name = (TextManager.GetText)(((self._chatConfig).nameTextID)[1]) or ""
  end
  ;
  (self._leftModelNameBoard):SetActive(name ~= "null")
  name = (string.gsub)(name, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username or "")
  ;
  (self._leftModelName):SetText(name)
  if not bShow then
    return 
  end
  local shapeid = nil
  if random then
    shapeid = (roleinfo:GetRoleConfig()).shapeID
  else
    shapeid = ((self._chatConfig).shapeId)[1]
  end
  local npcShapeRecorder = cNPCShape:GetRecorder(shapeid)
  local newLive2D = self:SetLive2DOrLiHuiInfo(self._leftModel, self._leftModelLive2D, self._live2dLeft, self._leftLive2DID, npcShapeRecorder)
  if (Live2DManager.CanUse)() and npcShapeRecorder.live2DAssetBundleName ~= "" then
    self._live2dLeft = newLive2D
    self._leftLive2DID = ((self._chatConfig).shapeId)[1]
    if ((self._chatConfig).emotionId)[1] ~= 0 and self._leftLive2DEmotion ~= ((self._chatConfig).emotionId)[1] then
      local emotionName = (cEmotion:GetRecorder(((self._chatConfig).emotionId)[1])).Name
      ;
      (self._leftModelLive2D):PlayLive2DAnimation(emotionName, self._live2dLeft)
      self._leftLive2DEmotion = ((self._chatConfig).emotionId)[1]
    end
  end
  if (self._chatConfig).chatType == 2 or (self._chatConfig).chatType == 102 then
    if self._live2dLeft then
      local live2dcfg = self:GetLive2DColorConfig((self._chatConfig).chatType)
      ;
      (self._leftModelLive2D):SetColorTint(self._live2dLeft, live2dcfg.r, live2dcfg.g, live2dcfg.b, live2dcfg.a)
    else
      local imagecfg = self:GetImageColorConfig((self._chatConfig).chatType)
      ;
      (self._leftModel):SetColor(((CS.UnityEngine).Color)(imagecfg.r, imagecfg.g, imagecfg.b, imagecfg.a))
    end
  elseif self._live2dLeft then
    (self._leftModelLive2D):SetColorTint(self._live2dLeft, 1, 1, 1, 1)
  else
    (self._leftModel):SetColor("white")
  end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

NewNpcChatDialog.SetRightInfo = function(self)
  -- function num : 0_11 , upvalues : _ENV, cNPCShape, cEmotion
  local bShow = true
  local random = false
  if (self._chatConfig).chatType == 0 or (self._chatConfig).chatType == 3 or ((self._chatConfig).shapeId)[2] == 0 then
    bShow = false
  else
    if ((self._chatConfig).shapeId)[2] <= -1 then
      random = true
    end
  end
  self:SetLive2DNodeActive(2, bShow)
  local roleinfo = nil
  if random then
    roleinfo = self:GetRandomRoleInfo(((self._chatConfig).shapeId)[2])
  end
  local name = nil
  if random and ((self._chatConfig).nameTextID)[2] == ((self._chatConfig).shapeId)[2] then
    name = roleinfo:GetRoleName()
  else
    name = (TextManager.GetText)(((self._chatConfig).nameTextID)[2]) or ""
  end
  ;
  (self._rightModelNameBoard):SetActive(not ((self._chatConfig).nameTextID)[2] or name ~= "null")
  name = (string.gsub)(name, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username or "")
  ;
  (self._rightModelName):SetText(name)
  if not bShow then
    return 
  end
  local shapeid = nil
  if random then
    shapeid = (roleinfo:GetRoleConfig()).shapeID
  else
    shapeid = ((self._chatConfig).shapeId)[2]
  end
  local npcShapeRecorder = cNPCShape:GetRecorder(shapeid)
  local newLive2D = self:SetLive2DOrLiHuiInfo(self._rightModel, self._rightModelLive2D, self._live2d, self._rightLive2DID, npcShapeRecorder, true)
  if (Live2DManager.CanUse)() and npcShapeRecorder.live2DAssetBundleName ~= "" then
    self._live2d = newLive2D
    self._rightLive2DID = ((self._chatConfig).shapeId)[2]
    if ((self._chatConfig).emotionId)[2] ~= 0 and self._rightLive2DEmotion ~= ((self._chatConfig).emotionId)[2] then
      local emotionName = (cEmotion:GetRecorder(((self._chatConfig).emotionId)[2])).Name
      ;
      (self._rightModelLive2D):PlayLive2DAnimation(emotionName, self._live2d)
      self._rightLive2DEmotion = ((self._chatConfig).emotionId)[2]
    end
  end
  if (self._chatConfig).chatType == 1 or (self._chatConfig).chatType == 101 then
    if self._live2d then
      local live2dcfg = self:GetLive2DColorConfig((self._chatConfig).chatType)
      ;
      (self._rightModelLive2D):SetColorTint(self._live2d, live2dcfg.r, live2dcfg.g, live2dcfg.b, live2dcfg.a)
    else
      local imagecfg = self:GetImageColorConfig((self._chatConfig).chatType)
      ;
      (self._rightModel):SetColor(((CS.UnityEngine).Color)(imagecfg.r, imagecfg.g, imagecfg.b, imagecfg.a))
    end
  elseif self._live2d then
    (self._rightModelLive2D):SetColorTint(self._live2d, 1, 1, 1, 1)
  else
    (self._rightModel):SetColor("white")
  end
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

local SetBackText = function(self, text)
  -- function num : 0_12 , upvalues : _ENV
  if (self._chatConfig).chatType ~= 4 then
    (self._backText):SetText(text)
  else
    local dialog = (DialogManager.GetDialog)("npcchat.blacknarrationdialog")
    if not dialog then
      dialog = (DialogManager.CreateSingletonChildDialog)("npcchat.blacknarrationdialog", self._dialogName, self:GetRootWindow())
    end
    dialog:SetText(text, (self._chatConfig).position)
  end
end

NewNpcChatDialog.ShowContent = function(self)
  -- function num : 0_13 , upvalues : _ENV, SetBackText
  (self._uiBack):SetActive(true)
  if tonumber((self._chatConfig).speed) and tonumber((self._chatConfig).speed) ~= 0 then
    local initString = (self._chatConfig).contentTextID
    do
      initString = ((TextManager.GetText)(initString)):gsub("%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username or "")
      local deltTime = tonumber((self._chatConfig).speed)
      local chars = (stringutils.split2table)(initString)
      local index = 0
      self._backTxtTimer = (GameTimer.AddTask)(0, deltTime, function()
    -- function num : 0_13_0 , upvalues : index, chars, SetBackText, self, _ENV
    index = index + 1
    if #chars < index then
      SetBackText(self, (table.concat)(chars))
      if (self._chatConfig).skipTime ~= 0 then
        self._timer = (GameTimer.AddTask)((self._chatConfig).skipTime, 0, function()
      -- function num : 0_13_0_0 , upvalues : self
      self:ToNextChat()
    end
, nil, true)
      end
      ;
      (GameTimer.RemoveTask)(self._backTxtTimer)
      self._backTxtTimer = nil
    else
      SetBackText(self, (table.concat)(chars, "", 1, index))
    end
  end
, nil, true)
    end
  else
    do
      if (self._chatConfig).skipTime ~= 0 then
        self._timer = (GameTimer.AddTask)((self._chatConfig).skipTime, 0, function()
    -- function num : 0_13_1 , upvalues : self
    self:ToNextChat()
  end
, nil, true)
      end
      local contentText = ((TextManager.GetText)((self._chatConfig).contentTextID)):gsub("%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username or "")
      SetBackText(self, contentText)
    end
  end
end

NewNpcChatDialog.ShowChoose = function(self)
  -- function num : 0_14 , upvalues : _ENV, TableFrame
  (self._uiBack):SetActive(false)
  if self._frame then
    LogInfo("NewNpcChatDialog", "in ShowChoose function frame should Destroy")
    ;
    (self._frame):Destroy()
    self._frame = nil
  else
    LogInfo("NewNpcChatDialog", "in ShowChoose function frame being Create")
  end
  self._frame = (TableFrame.Create)(self._selectionWnd, self, true, false, true)
  local itemFrameHeight = 166 * (table.nums)((self._chatConfig).chooseTextID)
  ;
  (self._selectionWnd):SetHeight(0, itemFrameHeight)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._selectionWnd):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y + (self._initHeight - itemFrameHeight) / 2)
end

local _to_next_chat = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("npcchat.blacknarrationdialog")
  if dialog then
    dialog:Skip()
    return 
  end
  if #self._chatList <= self._currentChatIndex then
    if (self._libraryRecord).nextDialog and (self._libraryRecord).nextDialog > 0 then
      self:SetDialogLibraryId((self._libraryRecord).nextDialog, self._isBaseCharChat)
    else
      self:Destroy()
    end
    ;
    (GameTimer.RemoveTask)(self._delayToNext)
    self._delayToNext = nil
    return 
  end
  self._currentChatIndex = self._currentChatIndex + 1
  self:SetChatId((self._chatList)[self._currentChatIndex])
  ;
  (GameTimer.RemoveTask)(self._delayToNext)
  self._delayToNext = nil
end

NewNpcChatDialog.ToNextChat = function(self, directShow)
  -- function num : 0_16 , upvalues : _to_next_chat, _ENV
  if directShow then
    _to_next_chat(self)
  else
    if not self._delayToNext then
      self._delayToNext = (GameTimer.AddTask)(0.2, -1, _to_next_chat, self, true)
    end
  end
end

NewNpcChatDialog.OnSkipBtnClicked = function(self, args)
  -- function num : 0_17
  if (self._libraryRecord).nextDialog and (self._libraryRecord).nextDialog > 0 then
    self:SetDialogLibraryId((self._libraryRecord).nextDialog, self._isBaseCharChat)
  else
    self:Destroy()
  end
end

NewNpcChatDialog.OnBackBtnClicked = function(self)
  -- function num : 0_18
  self:OnSkipBtnClicked()
end

NewNpcChatDialog.OnNextBtnClicked = function(self, args, luawindow, tag)
  -- function num : 0_19 , upvalues : _ENV, SetBackText
  if self._backTxtTimer then
    if not (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username then
      do
        local contentText = ((TextManager.GetText)((self._chatConfig).contentTextID)):gsub("%$heroine%$", (self._chatConfig).isClickable ~= 1 or "")
        SetBackText(self, contentText)
        if (self._chatConfig).skipTime ~= 0 then
          self._timer = (GameTimer.AddTask)((self._chatConfig).skipTime, 0, function()
    -- function num : 0_19_0 , upvalues : self, tag
    self:ToNextChat(tag)
  end
, nil, true)
        end
        ;
        (GameTimer.RemoveTask)(self._backTxtTimer)
        self._backTxtTimer = nil
        self:ToNextChat(tag)
      end
    end
  end
end

NewNpcChatDialog.OnCellClicked = function(self, index)
  -- function num : 0_20 , upvalues : FunctionType, _ENV, ResonanceRefValue
  do
    if self._functionType == FunctionType.Resonance and (self._chatConfig).id == 1 then
      local chooseText = (TextManager.GetText)(((self._chatConfig).chooseTextID)[index])
      if chooseText == ResonanceRefValue then
        (DialogManager.CreateSingletonDialog)("resonance.resonancedialog")
      else
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_ResonanceNpcChatEnd, nil, nil)
      end
    end
    if self._frame then
      LogInfo("NewNpcChatDialog", "in OnCellClicked function frame being Destroy")
      ;
      (self._frame):Destroy()
      self._frame = nil
    end
    local jumpLibraryID = ((self._chatConfig).chooseValue)[index]
    if jumpLibraryID then
      self:SetDialogLibraryId(jumpLibraryID, self._isBaseCharChat)
    else
      self:ToNextChat(true)
    end
  end
end

NewNpcChatDialog.NumberOfCell = function(self, frame)
  -- function num : 0_21 , upvalues : _ENV
  return (table.nums)((self._chatConfig).chooseTextID)
end

NewNpcChatDialog.CellAtIndex = function(self, frame)
  -- function num : 0_22
  return "npcchat.npcchatselectcell"
end

NewNpcChatDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_23 , upvalues : _ENV
  local data = {}
  data[index] = {index = index}
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  if ((self._chatConfig).chooseTextID)[index] then
    (data[index]).chooseText = (TextManager.GetText)(((self._chatConfig).chooseTextID)[index])
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

  if ((self._chatConfig).chooseValue)[index] then
    (data[index]).chooseValue = ((self._chatConfig).chooseValue)[index]
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (data[index]).playEffect = not self._chatChooseEffectRecorder or ((self._chatChooseEffectRecorder).ifEffect)[index] == 1
  do return data[index] end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

local SetPosition = function(image, pos, reverse)
  -- function num : 0_24 , upvalues : _ENV
  local x = tonumber(pos[1])
  if reverse then
    x = x * -1
  end
  local y = tonumber(pos[2])
  image:SetAnchoredPosition(x, y)
end

NewNpcChatDialog.SetLive2DOrLiHuiInfo = function(self, modelWnd, live2dWnd, oldLive2D, oldLive2dId, npcShapeRecorder, reverse)
  -- function num : 0_25 , upvalues : _ENV, cImagePathTable
  if (Live2DManager.CanUse)() and npcShapeRecorder.live2DAssetBundleName ~= "" then
    modelWnd:SetActive(false)
    live2dWnd:SetActive(true)
    if oldLive2dId ~= npcShapeRecorder.id then
      if oldLive2D then
        live2dWnd:Release(oldLive2D)
      end
      local live2D = live2dWnd:AddLive2D(npcShapeRecorder.live2DAssetBundleName, npcShapeRecorder.live2DPrefabName, npcShapeRecorder.live2DScale)
      return live2D
    else
      do
        do return oldLive2D end
        modelWnd:SetActive(true)
        live2dWnd:SetActive(false)
        local iconID = npcShapeRecorder.lihuiID
        local imageRecord = cImagePathTable:GetRecorder(iconID)
        if imageRecord then
          modelWnd:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          local scale = npcShapeRecorder.photoScale
          modelWnd:SetLocalScale(scale, scale, scale)
          modelWnd:SetAnchoredPosition((npcShapeRecorder.photoLocation)[1], (npcShapeRecorder.photoLocation)[2])
        end
      end
    end
  end
end

local split_var_config = function(id)
  -- function num : 0_26 , upvalues : _ENV
  local value = (((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(id)).Value
  local scale = value:split(",")
  for i,v in pairs(scale) do
    scale[i] = tonumber(v)
  end
  return (table.unpack)(scale)
end

NewNpcChatDialog.GetLive2DColorConfig = function(self, chatType)
  -- function num : 0_27 , upvalues : split_var_config, _ENV
  local var_config_id = nil
  if chatType == 1 or chatType == 2 then
    var_config_id = 2
  else
    if chatType == 101 or chatType == 102 then
      var_config_id = 122
    end
  end
  if var_config_id then
    local a, r, g, b, x, y, z = split_var_config(var_config_id)
    return {a = a, r = r, g = g, b = b, x = x, y = y, z = z}
  else
    do
      LogErrorFormat("NewNpcChatDialog", "chatType: %s is not supported.", chatType)
    end
  end
end

NewNpcChatDialog.GetImageColorConfig = function(self, chatType)
  -- function num : 0_28 , upvalues : split_var_config, _ENV
  local var_config_id = nil
  if chatType == 1 or chatType == 2 then
    var_config_id = 3
  else
    if chatType == 101 or chatType == 102 then
      var_config_id = 123
    end
  end
  if var_config_id then
    local a, r, g, b, x, y, z = split_var_config(var_config_id)
    return {a = a, r = r, g = g, b = b, x = x, y = y, z = z}
  else
    do
      LogErrorFormat("NewNpcChatDialog", "chatType: %s is not supported.", chatType)
    end
  end
end

NewNpcChatDialog.OnUpdate = function(self)
  -- function num : 0_29 , upvalues : _ENV
  if (self._dramaChatParagraph).startTime and (self._dramaChatParagraph).duration * 1000 <= (ServerGameTimer.GetServerTimeForecast)() - (self._dramaChatParagraph).startTime then
    if (self._libraryRecord).nextDialog and (self._libraryRecord).nextDialog > 0 then
      self:SetDialogLibraryId((self._libraryRecord).nextDialog, self._isBaseCharChat)
    else
      self:Destroy()
    end
  end
end

NewNpcChatDialog.OnSingletonDialogDestroy = function(self, notification)
  -- function num : 0_30
  local dialogName = (notification.userInfo)._dialogName
  if dialogName == "npcchat.blacknarrationdialog" or dialogName == "npcchat.blackcoverdialog" then
    self:ToNextChat(true)
  end
end

NewNpcChatDialog.OpenBlackCoverDialog = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonChildDialog)("npcchat.blackcoverdialog", self._dialogName, self:GetRootWindow())
  if dialog then
    dialog:SetData((self._chatConfig).position)
  end
end

NewNpcChatDialog.SetLive2DNodeActive = function(self, tag, active)
  -- function num : 0_32
  local alpha = 1
  if not active then
    alpha = 0
  end
  if tag == 1 then
    (self._leftRoleShowPanel):SetAlpha(alpha)
    if self._live2dLeft then
      (self._leftModelLive2D):SetLocalScale(alpha, alpha, alpha)
    end
  else
    ;
    (self._rightRoleShowPanel):SetAlpha(alpha)
    if self._live2d then
      (self._rightModelLive2D):SetLocalScale(alpha, alpha, alpha)
    end
  end
end

NewNpcChatDialog.SetNodeActive = function(self, active)
  -- function num : 0_33
  if not active then
    self._starMirageBackground_isActive = (self._starMirageBackground):IsActive()
    ;
    (self._starMirageBackground):SetActive(false)
    self:SetLive2DNodeActive(1, false)
    self:SetLive2DNodeActive(2, false)
    ;
    (self:GetChild("UI")):SetActive(false)
    ;
    (self._backText):SetText("")
  else
    ;
    (self._starMirageBackground):SetActive(self._starMirageBackground_isActive)
    self:SetLive2DNodeActive(1, true)
    self:SetLive2DNodeActive(2, true)
    ;
    (self:GetChild("UI")):SetActive(true)
  end
end

NewNpcChatDialog.OnStateEnter = function(self, handle, statename, normalizedTime)
  -- function num : 0_34
  if statename == "Shock" then
    (self._rootWindow):SetAnimatorInteger("Shock", 0)
  end
end

return NewNpcChatDialog

