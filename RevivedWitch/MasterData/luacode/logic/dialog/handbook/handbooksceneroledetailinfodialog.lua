-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/handbooksceneroledetailinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CFavourPresentType = (BeanManager.GetTableByName)("role.cfavourpresenttype")
local CSoundCatalog = (BeanManager.GetTableByName)("sound.csoundcatalog")
local CSoundLines = (BeanManager.GetTableByName)("sound.csoundlines")
local CSoundLines_skin = (BeanManager.GetTableByNameWithLanguage)("sound.csoundlines_skin")
local CFavourPresent = (BeanManager.GetTableByName)("role.cfavourpresent")
local CSoundAnimations = (BeanManager.GetTableByName)("sound.clive2dmotion")
local CEmotion = (BeanManager.GetTableByName)("npc.cemotion")
local CCardRoleConfig_HandBook = (BeanManager.GetTableByName)("handbook.ccardroleconfig_handbook")
local CNpcHandBookCfg = (BeanManager.GetTableByName)("handbook.cnpcconfig_handbook")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
local Role = require("logic.manager.experimental.types.role")
local timeofword = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(88)).Value)
local HandBookRoleDetailInfoDialog = class("HandBookRoleDetailInfoDialog", Dialog)
HandBookRoleDetailInfoDialog.AssetBundleName = "ui/layouts.tujian"
HandBookRoleDetailInfoDialog.AssetName = "CharDataMain"
local TabType = {Favour = 2, Story = 1, Voice = 3}
HandBookRoleDetailInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HandBookRoleDetailInfoDialog
  ((HandBookRoleDetailInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

HandBookRoleDetailInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TabType, CStringRes, TabFrame
  self._rolePanel = self:GetChild("Role")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._maxLevelEffect = self:GetChild("EffectAround")
  self._giftEffect = self:GetChild("EffectHead")
  self._levelUpEffect = self:GetChild("BackGround/EffectFavourLevelUpTxt")
  self._clickPanel = self:GetChild("Click")
  self._dialogPanel = self:GetChild("BackGround/Dialog")
  self._dialogPanel_txt = self:GetChild("BackGround/Dialog/Text")
  ;
  (self._dialogPanel):SetActive(false)
  self._dialogPanel_width = (self._dialogPanel):GetDeltaSize()
  self._dialogPanel_txt_width = (self._dialogPanel_txt):GetDeltaSize()
  self._tabInfo = {}
  for _,v in pairs(TabType) do
    do
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

      (self._tabInfo)[v] = {}
      local btnStr = nil
      if v == TabType.Favour then
        btnStr = 2
        -- DECOMPILER ERROR at PC69: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((self._tabInfo)[v]).title = self:GetChild("Top/Title3")
        ;
        (((self._tabInfo)[v]).title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1291)).msgTextID))
      else
        if v == TabType.Story then
          btnStr = 1
          -- DECOMPILER ERROR at PC93: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self._tabInfo)[v]).title = self:GetChild("Top/Title1")
          ;
          (((self._tabInfo)[v]).title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1289)).msgTextID))
        else
          if v == TabType.Voice then
            btnStr = 3
            -- DECOMPILER ERROR at PC117: Confused about usage of register: R7 in 'UnsetPending'

            ;
            ((self._tabInfo)[v]).title = self:GetChild("Top/Title2")
            ;
            (((self._tabInfo)[v]).title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1290)).msgTextID))
          end
        end
      end
      -- DECOMPILER ERROR at PC138: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._tabInfo)[v]).btnPanel = self:GetChild("BackGround/GroupBtnArea/Btn" .. btnStr)
      -- DECOMPILER ERROR at PC147: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._tabInfo)[v]).btnPanel_groupBtn = self:GetChild("BackGround/GroupBtnArea/Btn" .. btnStr .. "/GroupBtn")
      -- DECOMPILER ERROR at PC156: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._tabInfo)[v]).btnPanel_redDot = self:GetChild("BackGround/GroupBtnArea/Btn" .. btnStr .. "/GroupBtn/RedDot")
      -- DECOMPILER ERROR at PC168: Confused about usage of register: R7 in 'UnsetPending'

      if v == TabType.Favour then
        ((self._tabInfo)[v]).btnPanel_favourLv = self:GetChild("BackGround/GroupBtnArea/Btn" .. btnStr .. "/Num")
      end
      ;
      (((self._tabInfo)[v]).btnPanel_groupBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, v
    self:OnTabBtnClick(v)
  end
)
    end
  end
  self._panelWnd = self:GetChild("BackGround/RightPanel")
  self._pageHelper = (TabFrame.Create)(self._panelWnd, self)
  self._leftArrow = self:GetChild("BackGround/LeftArrow")
  self._rightArrow = self:GetChild("BackGround/RightArrow")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._uniqueEquipBtn = self:GetChild("BackGround/GroupBtnArea/Btn4")
  ;
  (self._clickPanel):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnLiHuiClicked()
  end
, self)
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._uniqueEquipBtn):Subscribe_PointerClickEvent(self.OnUniqueEquipBtnClicked, self)
  ;
  (self._rolePanel):Subscribe_StateExitEvent(self.OnRoleChangeStateExit, self)
  ;
  (self._dialogPanel):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnCuePlayEnd, Common.n_CuePlayEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnCuePlayEnd, Common.n_CuePlayStop, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRoleGood, Common.n_RefreshRoleGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshReceiveAward, Common.n_RoleGoodReceiveAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshUniqueEquipPanel, Common.n_UniqueEquipAvailable, nil)
  self._cutoverbtnPanel = self:GetChild("BackGround/CutoverBtn")
  self._cutoverbtnPanel_groupBtn = self:GetChild("BackGround/CutoverBtn/GroupBtn")
  ;
  (self._cutoverbtnPanel_groupBtn):SetSelected(false)
  self._cutoverbtnPanel_redDot = self:GetChild("BackGround/CutoverBtn/GroupBtn/RedDot")
  ;
  (self._cutoverbtnPanel_groupBtn):Subscribe_PointerClickEvent(self.OnCutoverBtnClick, self)
end

HandBookRoleDetailInfoDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._pageHelper):Destroy()
  if self._voiceId then
    ((NekoData.BehaviorManager).BM_Voice):StopVoice(self._voiceId)
    self._voiceId = nil
  end
  if self._contentTimer then
    (GameTimer.RemoveTask)(self._contentTimer)
    self._contentTimer = nil
  end
end

HandBookRoleDetailInfoDialog.OnRefreshRoleGood = function(self, notification)
  -- function num : 0_3 , upvalues : CSoundCatalog, CSoundLines_skin, CSoundLines, CSoundAnimations, CFavourPresentType, _ENV, TabType
  local protocol = notification.userInfo
  local roleId = (self._role):GetId()
  if protocol.roleId == roleId then
    local tag = false
    if self._giveItemId then
      local soundCatalogRecord = (CSoundCatalog:GetRecorder(roleId))
      local soundLinesRecord = nil
      local fashionId = (self._role):GetDefaultFashion()
      if fashionId > 0 then
        soundLinesRecord = CSoundLines_skin:GetRecorder(fashionId)
      end
      if not soundLinesRecord then
        soundLinesRecord = CSoundLines:GetRecorder(roleId)
      end
      local soundAnimationRecord = CSoundAnimations:GetRecorder(roleId)
      local favourPresentTypeRecord = CFavourPresentType:GetRecorder(self._giveItemId)
      self._giveItemId = nil
      if self._giftEffectHandler then
        (self._giftEffect):ReleaseEffect(self._giftEffectHandler)
        self._giftEffectHandler = nil
      end
      local heartEffectNum = favourPresentTypeRecord.presentuplevel
      if favourPresentTypeRecord.presenttype == (self._role):GetFavourGiftType() then
        if not self._voiceId or self._voiceId ~= soundCatalogRecord.FavoriteGift then
          self:SetVoiceIdNil()
          self:SetVoiceAndLines2(roleId, fashionId, (((NekoData.BehaviorManager).BM_Voice).VoiceType).FavoriteGift, nil, soundLinesRecord.FavoriteGift, soundAnimationRecord.FavoriteGift)
        end
        if heartEffectNum == 1 then
          self._giftEffectHandler = (self._giftEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1119))
        else
          if heartEffectNum == 2 then
            self._giftEffectHandler = (self._giftEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1120))
          else
            if heartEffectNum == 3 then
              self._giftEffectHandler = (self._giftEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1121))
            end
          end
        end
      else
        if not self._voiceId or self._voiceId ~= soundCatalogRecord.NormalGift then
          self:SetVoiceIdNil()
          self:SetVoiceAndLines2(roleId, fashionId, (((NekoData.BehaviorManager).BM_Voice).VoiceType).NormalGift, nil, soundLinesRecord.NormalGift, soundAnimationRecord.NormalGift)
        end
        if heartEffectNum == 1 then
          self._giftEffectHandler = (self._giftEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1116))
        else
          if heartEffectNum == 2 then
            self._giftEffectHandler = (self._giftEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1117))
          else
            if heartEffectNum == 3 then
              self._giftEffectHandler = (self._giftEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1118))
            end
          end
        end
      end
      if (self._pageHelper):GetCurrentIndex() == TabType.Favour then
        tag = true
        local tabCell = (self._pageHelper):GetCellAtIndex(TabType.Favour)
        tabCell:PlayFavourProgressUpEffect(protocol.level, protocol.progress)
      end
    end
    do
      self:RefreshPanel(roleId)
      for _,v in pairs(TabType) do
        if v ~= TabType.Favour or v == TabType.Favour and not tag then
          local tabCell = (self._pageHelper):GetCellAtIndex(v)
          tabCell:RefreshTabCell(true, true)
        end
      end
    end
  end
end

HandBookRoleDetailInfoDialog.OnRefreshReceiveAward = function(self, notification)
  -- function num : 0_4 , upvalues : TabType, CFavourPresent, _ENV
  local protocol = notification.userInfo
  local roleId = (self._role):GetId()
  if protocol.roleId == (self._role):GetId() then
    self:RefreshTabsRedDot()
    local tabCell = (self._pageHelper):GetCellAtIndex(TabType.Favour)
    tabCell:RefreshTabCell(true)
    local relationPresentRecord = CFavourPresent:GetRecorder(protocol.roleId)
    if relationPresentRecord then
      local rewardType = (relationPresentRecord.levelRewardType)[protocol.level]
      if rewardType == (DataCommon.Favour).BackgroundStory then
        tabCell = (self._pageHelper):GetCellAtIndex(TabType.Story)
        tabCell:RefreshTabCell(true, true)
      else
        if rewardType == (DataCommon.Favour).Voice then
          tabCell = (self._pageHelper):GetCellAtIndex(TabType.Voice)
          tabCell:RefreshTabCell(true, true)
        end
      end
    end
  end
end

HandBookRoleDetailInfoDialog.OnRefreshUniqueEquipPanel = function(self)
  -- function num : 0_5
  (self._uniqueEquipBtn):SetActive((self._role):GetUniqueEquipId())
end

HandBookRoleDetailInfoDialog.AddLevelUpEffect = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (self._levelUpEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1115))
end

HandBookRoleDetailInfoDialog.RefreshPanel = function(self, roleID)
  -- function num : 0_7 , upvalues : _ENV, TabType
  if self._lastRoleId == nil or self._lastRoleId ~= roleID then
    local theRoleID = (self._role):GetId()
    do
      local theFashionID = (self._role):GetDefaultFashion()
      self._picTouchData = {((NekoData.BehaviorManager).BM_RoleTouch):GetPicTouchInfo(theRoleID, theFashionID)}
      if self._handler then
        (self._live2D):Release(self._handler)
        self._handler = nil
      end
      local live2dRecord = (self._role):GetShapeLive2DRecord()
      if (self._role):IsFashionLive2D() and (Live2DManager.CanUse)() and live2dRecord.live2DPrefabName and live2dRecord.live2DAssetBundleName then
        (self._photo):SetActive(false)
        self._handler = (self._live2D):AddLive2D(live2dRecord.live2DAssetBundleName, live2dRecord.live2DPrefabName, live2dRecord.live2DScale)
        ;
        (self._live2D):SetLive2DAnimatorInteger(self._handler, "isLoop", 1)
        if not (self._live2D):OnlyFor0916Func() then
          (self._clickPanel):SetActive(true)
        else
          local touchRecordList = ((NekoData.BehaviorManager).BM_RoleTouch):GetLive2DTouchInfo(theRoleID, theFashionID)
          if #touchRecordList > 0 then
            (self._live2D):AddPointerDownListener(self._handler, function(_, posName)
    -- function num : 0_7_0 , upvalues : self, theRoleID, theFashionID, touchRecordList
    self:OnLive2DPointerDown(posName, theRoleID, theFashionID, touchRecordList)
  end
, self)
            ;
            (self._clickPanel):SetActive(false)
          else
            ;
            (self._clickPanel):SetActive(true)
          end
        end
      else
        do
          local lihuiImage = (self._role):GetShapeLiHuiImageRecord()
          ;
          (self._photo):SetActive(true)
          ;
          (self._photo):SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
          local scale = (self._role):GetPhotoScale()
          ;
          (self._photo):SetLocalScale(scale, scale, scale)
          local photoPos = (self._role):GetPhotoPosition()
          ;
          (self._photo):SetAnchoredPosition(photoPos[1], photoPos[2])
          ;
          (self._clickPanel):SetActive(true)
        end
      end
      do
        self._lastRoleId = roleID
        local relationLv = (self._role):GetRelationLevel()
        local relationMaxLv = (self._role):GetRelationMaxLevel()
        if not self._maxLevelEffectHandler and relationMaxLv <= relationLv then
          self._maxLevelEffectHandler = (self._maxLevelEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1114))
        else
          if self._maxLevelEffectHandler and relationLv < relationMaxLv then
            (self._maxLevelEffect):ReleaseEffect(self._maxLevelEffectHandler)
            self._maxLevelEffectHandler = nil
          end
        end
        ;
        (((self._tabInfo)[TabType.Favour]).btnPanel_favourLv):SetText((self._role):GetRelationLevel())
        self:RefreshTabsRedDot()
        ;
        (self._uniqueEquipBtn):SetActive((self._role):GetUniqueEquipId())
      end
    end
  end
end

HandBookRoleDetailInfoDialog.Refresh = function(self, roleID, npcID)
  -- function num : 0_8 , upvalues : _ENV, TabType
  self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleID)
  self:RefreshPanel(roleID)
  ;
  (self._rolePanel):SetAnimatorTrigger("loadReady")
  self:OnTabBtnClick(TabType.Story)
  self:OnLiHuiClicked(true)
  ;
  (self._cutoverbtnPanel):SetActive(npcID ~= nil)
  self._roleId = roleID
  self._npcId = npcID
  ;
  (self._cutoverbtnPanel_redDot):SetActive(false)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HandBookRoleDetailInfoDialog.RefreshTabsRedDot = function(self)
  -- function num : 0_9 , upvalues : _ENV, TabType
  local isShowFavourRedDot, isShowStoryRedDot, isShowVoiceRedDot = nil, nil, nil
  local relationReceiveMap = (self._role):GetRelationReceiveMap()
  local relationLv = (self._role):GetRelationLevel()
  local rewardList = (self._role):GetRelationRewardList()
  for i,v in ipairs(rewardList) do
    local favourLv = v.favourLv
    if favourLv <= relationLv then
      if not relationReceiveMap[favourLv] then
        isShowFavourRedDot = true
        if v.rewardType == (DataCommon.Favour).BackgroundStory then
          isShowStoryRedDot = true
        else
          if v.rewardType == (DataCommon.Favour).Voice then
            isShowVoiceRedDot = true
          end
        end
      end
    else
      break
    end
  end
  do
    ;
    (((self._tabInfo)[TabType.Favour]).btnPanel_redDot):SetActive(isShowFavourRedDot)
    ;
    (((self._tabInfo)[TabType.Story]).btnPanel_redDot):SetActive(isShowStoryRedDot)
    ;
    (((self._tabInfo)[TabType.Voice]).btnPanel_redDot):SetActive(isShowVoiceRedDot)
  end
end

HandBookRoleDetailInfoDialog.OnTabBtnClick = function(self, index)
  -- function num : 0_10 , upvalues : TabType, _ENV
  if (self._pageHelper):GetCurrentIndex() ~= index then
    if (self._pageHelper):GetCurrentIndex() == TabType.Favour then
      (DialogManager.DestroySingletonDialog)("handbook.favour.givegiftdialog")
      ;
      ((self._pageHelper):GetCellAtIndex(TabType.Favour)):Leave()
    end
    ;
    (self._pageHelper):ToPage(index)
  end
end

HandBookRoleDetailInfoDialog.DidToPage = function(self, helper, index)
  -- function num : 0_11 , upvalues : _ENV, TabType
  local tabCell = (self._pageHelper):GetCellAtIndex(index)
  if tabCell then
    tabCell:RefreshTabCell()
  end
  for _,v in pairs(TabType) do
    (((self._tabInfo)[v]).btnPanel_groupBtn):SetSelected(index == v)
    ;
    (((self._tabInfo)[v]).title):SetActive(index == v)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

HandBookRoleDetailInfoDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_12 , upvalues : TabType
  if index == TabType.Story then
    return "handbook.favour.rolestorytabcell"
  else
    if index == TabType.Voice then
      return "handbook.favour.rolevoicetabcell"
    else
      if index == TabType.Favour then
        return "handbook.favour.rolefavourtabcell"
      end
    end
  end
end

HandBookRoleDetailInfoDialog.SetVoiceAndLines2 = function(self, roleID, fashionID, tableKey, index, contentId, animation, playHandBook)
  -- function num : 0_13 , upvalues : _ENV, CEmotion, timeofword, TabType
  if not (self._role):CanPlayVoice() then
    return 
  end
  if self._voiceId then
    return 
  end
  if playHandBook then
    self._voiceId = ((NekoData.BehaviorManager).BM_Voice):PlayHandBook(roleID, tableKey, index)
  else
    self._voiceId = ((NekoData.BehaviorManager).BM_Voice):Play2(roleID, fashionID, tableKey, index)
  end
  if self._voiceId == nil then
    return 
  end
  if contentId then
    self._linesText = (TextManager.GetText)(contentId)
  else
    self._linesText = ((NekoData.BehaviorManager).BM_Lines):GetLines2(roleID, fashionID, tableKey, index)
  end
  do
    if animation and self._handler then
      local recorder = CEmotion:GetRecorder(animation)
      if recorder then
        (self._live2D):PlayLive2DAnimation(recorder.Name, self._handler)
      else
        LogErrorFormat("SetVoiceAndLines2", "No AnimationName Width ID %s", tostring(animation))
      end
    end
    ;
    (self._dialogPanel):SetActive(true)
    ;
    (self._dialogPanel):PlayAnimation("CharDataMainDialogShow")
    ;
    (self._dialogPanel_txt):SetText(self._linesText)
    local _, textheight = (self._dialogPanel_txt):GetPreferredSize()
    if self._dialogPanel_txt_height < textheight then
      (self._dialogPanel_txt):SetDeltaSize(self._dialogPanel_txt_width, textheight)
      ;
      (self._dialogPanel):SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height + textheight - self._dialogPanel_txt_height)
    else
      ;
      (self._dialogPanel_txt):SetDeltaSize(self._dialogPanel_txt_width, self._dialogPanel_txt_height)
      ;
      (self._dialogPanel):SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height)
    end
    do
      if self._voiceId == 0 then
        local text = (string.trim)(self._linesText)
        if self._contentTimer then
          (GameTimer.RemoveTask)(self._contentTimer)
          self._contentTimer = nil
        end
        self._contentTimer = (GameTimer.AddTask)((utf8.len)(text) * timeofword / 1000, -1, function()
    -- function num : 0_13_0 , upvalues : self
    if not (self._dialogPanel):IsActive() then
      self:SetVoiceIdNil(true)
    else
      ;
      (self._dialogPanel):PlayAnimation("CharDataMainDialogHide")
    end
  end
)
      end
      local tabCell = (self._pageHelper):GetCellAtIndex(TabType.Voice)
      ;
      (tabCell._black):SetActive(true)
    end
  end
end

HandBookRoleDetailInfoDialog.SetVoiceIdNil = function(self, auto)
  -- function num : 0_14 , upvalues : _ENV, TabType
  if self._voiceId then
    if not auto then
      ((NekoData.BehaviorManager).BM_Voice):StopVoice(self._voiceId)
    end
    self._voiceId = nil
    local tabCell = (self._pageHelper):GetCellAtIndex(TabType.Voice)
    ;
    (tabCell._black):SetActive(false)
    ;
    (self._dialogPanel):SetActive(false)
  end
  do
    if self._contentTimer then
      (GameTimer.RemoveTask)(self._contentTimer)
      self._contentTimer = nil
    end
  end
end

HandBookRoleDetailInfoDialog.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_15
  if stateName == "CharDataMainDialogHide" then
    self:SetVoiceIdNil(true)
  end
end

HandBookRoleDetailInfoDialog.OnCuePlayEnd = function(self, notification)
  -- function num : 0_16 , upvalues : _ENV
  if self._voiceId then
    local cueSheet, cueName = (LuaAudioManager.GetCueSheetAndCueNameWithVoiceID)(self._voiceId)
    if cueSheet == (notification.userInfo).cueSheet and cueName == (notification.userInfo).cueName then
      if not (self._dialogPanel):IsActive() then
        self:SetVoiceIdNil(true)
      else
        ;
        (self._dialogPanel):PlayAnimation("CharDataMainDialogHide")
      end
    end
  end
end

HandBookRoleDetailInfoDialog.OnLiHuiClicked = function(self, onInitial)
  -- function num : 0_17 , upvalues : _ENV
  if self._picTouchData == nil or #self._picTouchData == 0 or not (self._role):CanPlayVoice() then
    return 
  end
  local roleID = (self._picTouchData)[3]
  local fashionID = (self._picTouchData)[4]
  local thisList = nil
  if onInitial then
    thisList = (self._picTouchData)[1]
  else
    thisList = (self._picTouchData)[2]
  end
  local randomForPicTouch = (math.random)(1, #thisList)
  local thisVal = thisList[randomForPicTouch]
  self:SetVoiceAndLines2(roleID, fashionID, thisVal[1], thisVal[2])
end

HandBookRoleDetailInfoDialog.OnLive2DPointerDown = function(self, posName, roleID, fashionID, touchRecordList)
  -- function num : 0_18 , upvalues : _ENV
  if self._voiceId then
    return 
  end
  local touchRecord = nil
  posName = (string.trim)(posName)
  for _,tempRecord in ipairs(touchRecordList) do
    if (string.trim)(tempRecord.area) == posName then
      touchRecord = tempRecord
      break
    end
  end
  do
    if touchRecord then
      local ramdomNum = (math.random)(1, #touchRecord.state)
      local animaState = (touchRecord.state)[ramdomNum]
      ;
      (self._live2D):SetLive2DAnimatorTrigger(self._handler, animaState)
      local voiceAndLinesIDSplit = (string.split)((touchRecord.volume_id)[ramdomNum], ",")
      if #voiceAndLinesIDSplit > 1 then
        self:SetVoiceAndLines2(roleID, fashionID, voiceAndLinesIDSplit[1], tonumber(voiceAndLinesIDSplit[2]))
      else
        self:SetVoiceAndLines2(roleID, fashionID, voiceAndLinesIDSplit[1])
      end
    end
  end
end

HandBookRoleDetailInfoDialog.CacheGiveItemId = function(self, itemId)
  -- function num : 0_19
  self._giveItemId = itemId
end

HandBookRoleDetailInfoDialog.RefreshByRoleId = function(self, roleID)
  -- function num : 0_20 , upvalues : _ENV, TabType, CNpcHandBookCfg, HandBookTypeEnum
  self._canChangeRole = false
  if self._giftEffectHandler then
    (self._giftEffect):ReleaseEffect(self._giftEffectHandler)
    self._giftEffectHandler = nil
  end
  self._giveItemId = nil
  self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleID)
  self:SetVoiceIdNil()
  self:RefreshPanel(roleID)
  ;
  (self._rolePanel):SetAnimatorTrigger("loadReady")
  for _,v in pairs(TabType) do
    local tabCell = (self._pageHelper):GetCellAtIndex(v)
    if v == TabType.Story then
      tabCell:RefreshTabCell(true, false, true)
    else
      tabCell:RefreshTabCell(true)
    end
  end
  if (self._pageHelper):GetCurrentIndex() == TabType.Favour then
    (DialogManager.DestroySingletonDialog)("handbook.favour.givegiftdialog")
  end
  local npcID = nil
  for k,v in ipairs(CNpcHandBookCfg:GetAllIds()) do
    local recoder = CNpcHandBookCfg:GetRecorder(v)
    if recoder.roleID == roleID then
      npcID = v
    end
  end
  if npcID and not ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(npcID, HandBookTypeEnum.NPC) then
    npcID = nil
  end
  ;
  (self._cutoverbtnPanel):SetActive(npcID ~= nil)
  self._roleId = roleID
  self._npcId = npcID
  ;
  (self._cutoverbtnPanel_redDot):SetActive(false)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HandBookRoleDetailInfoDialog.OnLeftArrowClick = function(self)
  -- function num : 0_21
  if not self._roleListInit then
    self:InitRoleList()
  end
  if self._canChangeRole then
    if self._pos == 1 then
      self._pos = #self._roleList
    else
      self._pos = self._pos - 1
    end
    self:RefreshByRoleId((self._roleList)[self._pos])
  end
end

HandBookRoleDetailInfoDialog.OnRightArrowClick = function(self)
  -- function num : 0_22
  if not self._roleListInit then
    self:InitRoleList()
  end
  if self._canChangeRole then
    if self._pos == #self._roleList then
      self._pos = 1
    else
      self._pos = self._pos + 1
    end
    self:RefreshByRoleId((self._roleList)[self._pos])
  end
end

HandBookRoleDetailInfoDialog.InitRoleList = function(self)
  -- function num : 0_23 , upvalues : _ENV, CCardRoleConfig_HandBook
  self._roleListInit = true
  self._roleList = {}
  self._pos = 0
  for _,v in ipairs(CCardRoleConfig_HandBook:GetAllIds()) do
    local record = CCardRoleConfig_HandBook:GetRecorder(v)
    if record.isShow == 1 and ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock(record.id) then
      (table.insert)(self._roleList, record.id)
      if record.id == (self._role):GetId() then
        self._pos = #self._roleList
      end
    end
  end
end

HandBookRoleDetailInfoDialog.OnRoleChangeStateExit = function(self, arg1, arg2)
  -- function num : 0_24
  if arg2 == "CharChangeRole" then
    self._canChangeRole = true
  end
end

HandBookRoleDetailInfoDialog.OnUniqueEquipBtnClicked = function(self)
  -- function num : 0_25 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).UniqueEquip) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100376)
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("uniqueequip.uniqueequipdialog")
  dialog:HideUnlockBtn()
  dialog:SetData((self._role):GetUniqueEquipId())
end

HandBookRoleDetailInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_26
  self:Destroy()
end

HandBookRoleDetailInfoDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_27 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

HandBookRoleDetailInfoDialog.OnCutoverBtnClick = function(self)
  -- function num : 0_28 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("handbook.npcdetailinfodialog")):Refresh(self._npcId, self._roleId)
  self:Destroy()
end

return HandBookRoleDetailInfoDialog

