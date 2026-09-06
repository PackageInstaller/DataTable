local TabFrame = require("framework.ui.frame.tab.tabframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CFavourPresentType = BeanManager.GetTableByName("role.cfavourpresenttype")
local CSoundCatalog = BeanManager.GetTableByName("sound.csoundcatalog")
local CSoundLines = BeanManager.GetTableByName("sound.csoundlines")
local CSoundLines_skin = BeanManager.GetTableByNameWithLanguage("sound.csoundlines_skin")
local CFavourPresent = BeanManager.GetTableByName("role.cfavourpresent")
local CSoundAnimations = BeanManager.GetTableByName("sound.clive2dmotion")
local CEmotion = BeanManager.GetTableByName("npc.cemotion")
local timeofword = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(88).Value)
local RoleDetailInfoDialog = class("RoleDetailInfoDialog", Dialog)
RoleDetailInfoDialog.AssetBundleName = "ui/layouts.tujian"
RoleDetailInfoDialog.AssetName = "CharDataMain"
local TabType = {
  Favour = 2,
  Story = 1,
  Voice = 3
}

function RoleDetailInfoDialog:Ctor(...)
  RoleDetailInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function RoleDetailInfoDialog:OnCreate()
  self._rolePanel = self:GetChild("Role")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._maxLevelEffect = self:GetChild("EffectAround")
  self._giftEffect = self:GetChild("EffectHead")
  self._levelUpEffect = self:GetChild("BackGround/EffectFavourLevelUpTxt")
  self._clickPanel = self:GetChild("Click")
  self._dialogPanel = self:GetChild("BackGround/Dialog")
  self._dialogPanel_txt = self:GetChild("BackGround/Dialog/Text")
  self._dialogPanel:SetActive(false)
  self._dialogPanel_width, self._dialogPanel_height = self._dialogPanel:GetDeltaSize()
  self._dialogPanel_txt_width, self._dialogPanel_txt_height = self._dialogPanel_txt:GetDeltaSize()
  self._tabInfo = {}
  for _, v in pairs(TabType) do
    self._tabInfo[v] = {}
    local btnStr
    if v == TabType.Favour then
      btnStr = 2
      self._tabInfo[v].title = self:GetChild("Top/Title3")
      self._tabInfo[v].title:SetText(TextManager.GetText(CStringRes:GetRecorder(1291).msgTextID))
    elseif v == TabType.Story then
      btnStr = 1
      self._tabInfo[v].title = self:GetChild("Top/Title1")
      self._tabInfo[v].title:SetText(TextManager.GetText(CStringRes:GetRecorder(1289).msgTextID))
    elseif v == TabType.Voice then
      btnStr = 3
      self._tabInfo[v].title = self:GetChild("Top/Title2")
      self._tabInfo[v].title:SetText(TextManager.GetText(CStringRes:GetRecorder(1290).msgTextID))
    end
    self._tabInfo[v].btnPanel = self:GetChild("BackGround/GroupBtnArea/Btn" .. btnStr)
    self._tabInfo[v].btnPanel_groupBtn = self:GetChild("BackGround/GroupBtnArea/Btn" .. btnStr .. "/GroupBtn")
    self._tabInfo[v].btnPanel_redDot = self:GetChild("BackGround/GroupBtnArea/Btn" .. btnStr .. "/GroupBtn/RedDot")
    if v == TabType.Favour then
      self._tabInfo[v].btnPanel_favourLv = self:GetChild("BackGround/GroupBtnArea/Btn" .. btnStr .. "/Num")
    end
    self._tabInfo[v].btnPanel_groupBtn:Subscribe_PointerClickEvent(function()
      self:OnTabBtnClick(v)
    end)
  end
  self._panelWnd = self:GetChild("BackGround/RightPanel")
  self._pageHelper = TabFrame.Create(self._panelWnd, self)
  self._leftArrow = self:GetChild("BackGround/LeftArrow")
  self._rightArrow = self:GetChild("BackGround/RightArrow")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._uniqueEquipBtn = self:GetChild("BackGround/GroupBtnArea/Btn4")
  self._clickPanel:Subscribe_PointerClickEvent(function()
    self:OnLiHuiClicked()
  end, self)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._uniqueEquipBtn:Subscribe_PointerClickEvent(self.OnUniqueEquipBtnClicked, self)
  self._rolePanel:Subscribe_StateExitEvent(self.OnRoleChangeStateExit, self)
  self._dialogPanel:Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnCuePlayEnd, Common.n_CuePlayEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnCuePlayEnd, Common.n_CuePlayStop, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoleGood, Common.n_RefreshRoleGood, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshReceiveAward, Common.n_RoleGoodReceiveAward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshUniqueEquipPanel, Common.n_UniqueEquipAvailable, nil)
  self._cutoverbtnPanel = self:GetChild("BackGround/CutoverBtn")
  self._cutoverbtnPanel_groupBtn = self:GetChild("BackGround/CutoverBtn/GroupBtn")
  self._cutoverbtnPanel_groupBtn:SetSelected(false)
  self._cutoverbtnPanel_redDot = self:GetChild("BackGround/CutoverBtn/GroupBtn/RedDot")
  self._cutoverbtnPanel_groupBtn:Subscribe_PointerClickEvent(self.OnCutoverBtnClick, self)
end

function RoleDetailInfoDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._pageHelper:Destroy()
  if self._voiceId then
    NekoData.BehaviorManager.BM_Voice:StopVoice(self._voiceId)
    self._voiceId = nil
  end
  if self._contentTimer then
    GameTimer.RemoveTask(self._contentTimer)
    self._contentTimer = nil
  end
end

function RoleDetailInfoDialog:OnRefreshRoleGood(notification)
  local protocol = notification.userInfo
  local roleId = self._role:GetId()
  if protocol.roleId == roleId then
    local tag = false
    if self._giveItemId then
      local soundCatalogRecord = CSoundCatalog:GetRecorder(roleId)
      local soundLinesRecord
      local fashionId = self._role:GetDefaultFashion()
      if 0 < fashionId then
        soundLinesRecord = CSoundLines_skin:GetRecorder(fashionId)
      end
      soundLinesRecord = soundLinesRecord or CSoundLines:GetRecorder(roleId)
      local soundAnimationRecord = CSoundAnimations:GetRecorder(roleId)
      local favourPresentTypeRecord = CFavourPresentType:GetRecorder(self._giveItemId)
      self._giveItemId = nil
      if self._giftEffectHandler then
        self._giftEffect:ReleaseEffect(self._giftEffectHandler)
        self._giftEffectHandler = nil
      end
      local heartEffectNum = favourPresentTypeRecord.presentuplevel
      if favourPresentTypeRecord.presenttype == self._role:GetFavourGiftType() then
        if not self._voiceId or self._voiceId ~= soundCatalogRecord.FavoriteGift then
          self:SetVoiceIdNil()
          if self._role:CanPlayVoice() then
            self:SetVoiceAndLines2(roleId, fashionId, NekoData.BehaviorManager.BM_Voice.VoiceType.FavoriteGift, nil, soundLinesRecord.FavoriteGift, soundAnimationRecord.FavoriteGift)
          end
        end
        if heartEffectNum == 1 then
          self._giftEffectHandler = self._giftEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1119))
        elseif heartEffectNum == 2 then
          self._giftEffectHandler = self._giftEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1120))
        elseif heartEffectNum == 3 then
          self._giftEffectHandler = self._giftEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1121))
        end
      else
        if not self._voiceId or self._voiceId ~= soundCatalogRecord.NormalGift then
          self:SetVoiceIdNil()
          if self._role:CanPlayVoice() then
            self:SetVoiceAndLines2(roleId, fashionId, NekoData.BehaviorManager.BM_Voice.VoiceType.NormalGift, nil, soundLinesRecord.NormalGift, soundAnimationRecord.NormalGift)
          end
        end
        if heartEffectNum == 1 then
          self._giftEffectHandler = self._giftEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1116))
        elseif heartEffectNum == 2 then
          self._giftEffectHandler = self._giftEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1117))
        elseif heartEffectNum == 3 then
          self._giftEffectHandler = self._giftEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1118))
        end
      end
      if self._pageHelper:GetCurrentIndex() == TabType.Favour then
        tag = true
        local tabCell = self._pageHelper:GetCellAtIndex(TabType.Favour)
        tabCell:PlayFavourProgressUpEffect(protocol.level, protocol.progress)
      end
    end
    self:RefreshPanel(roleId)
    for _, v in pairs(TabType) do
      if v ~= TabType.Favour or v == TabType.Favour and not tag then
        local tabCell = self._pageHelper:GetCellAtIndex(v)
        tabCell:RefreshTabCell(true, true)
      end
    end
  end
end

function RoleDetailInfoDialog:OnRefreshReceiveAward(notification)
  local protocol = notification.userInfo
  local roleId = self._role:GetId()
  if protocol.roleId == self._role:GetId() then
    self:RefreshTabsRedDot()
    local tabCell = self._pageHelper:GetCellAtIndex(TabType.Favour)
    tabCell:RefreshTabCell(true)
    local relationPresentRecord = CFavourPresent:GetRecorder(protocol.roleId)
    if relationPresentRecord then
      local rewardType = relationPresentRecord.levelRewardType[protocol.level]
      if rewardType == DataCommon.Favour.BackgroundStory then
        tabCell = self._pageHelper:GetCellAtIndex(TabType.Story)
        tabCell:RefreshTabCell(true, true)
      elseif rewardType == DataCommon.Favour.Voice then
        tabCell = self._pageHelper:GetCellAtIndex(TabType.Voice)
        tabCell:RefreshTabCell(true, true)
      end
    end
  end
end

function RoleDetailInfoDialog:OnRefreshUniqueEquipPanel()
  self._uniqueEquipBtn:SetActive(self._role:GetUniqueEquipId())
end

function RoleDetailInfoDialog:AddLevelUpEffect()
  self._levelUpEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1115))
end

function RoleDetailInfoDialog:RefreshPanel(roleID)
  if self._lastRoleId == nil or self._lastRoleId ~= roleID then
    local theRoleID = self._role:GetId()
    local theFashionID = self._role:GetDefaultFashion()
    self._picTouchData = {
      NekoData.BehaviorManager.BM_RoleTouch:GetPicTouchInfo(theRoleID, theFashionID)
    }
    if self._handler then
      self._live2D:Release(self._handler)
      self._handler = nil
    end
    local live2dRecord = self._role:GetShapeLive2DRecord()
    if self._role:IsFashionLive2D() and Live2DManager.CanUse() and live2dRecord.live2DPrefabName and live2dRecord.live2DAssetBundleName then
      self._photo:SetActive(false)
      self._handler = self._live2D:AddLive2D(live2dRecord.live2DAssetBundleName, live2dRecord.live2DPrefabName, live2dRecord.live2DScale)
      self._live2D:SetLive2DAnimatorInteger(self._handler, "isLoop", 1)
      if not self._live2D:OnlyFor0916Func() then
        self._clickPanel:SetActive(true)
      else
        local touchRecordList = NekoData.BehaviorManager.BM_RoleTouch:GetLive2DTouchInfo(theRoleID, theFashionID)
        if 0 < #touchRecordList then
          self._live2D:AddPointerDownListener(self._handler, function(_, posName)
            self:OnLive2DPointerDown(posName, theRoleID, theFashionID, touchRecordList)
          end, self)
          self._clickPanel:SetActive(false)
        else
          self._clickPanel:SetActive(true)
        end
      end
    else
      do
        local lihuiImage = self._role:GetShapeLiHuiImageRecord()
        self._photo:SetActive(true)
        self._photo:SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
        local scale = self._role:GetPhotoScale()
        self._photo:SetLocalScale(scale, scale, scale)
        local photoPos = self._role:GetPhotoPosition()
        self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
        self._clickPanel:SetActive(true)
      end
    end
  end
  self._lastRoleId = roleID
  local relationLv = self._role:GetRelationLevel()
  local relationMaxLv = self._role:GetRelationMaxLevel()
  if not self._maxLevelEffectHandler and relationLv >= relationMaxLv then
    self._maxLevelEffectHandler = self._maxLevelEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1114))
  elseif self._maxLevelEffectHandler and relationLv < relationMaxLv then
    self._maxLevelEffect:ReleaseEffect(self._maxLevelEffectHandler)
    self._maxLevelEffectHandler = nil
  end
  self._tabInfo[TabType.Favour].btnPanel_favourLv:SetText(self._role:GetRelationLevel())
  self:RefreshTabsRedDot()
  self._uniqueEquipBtn:SetActive(self._role:GetUniqueEquipId())
end

function RoleDetailInfoDialog:Refresh(roleID, npcID)
  self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleID)
  self:RefreshPanel(roleID)
  self._rolePanel:SetAnimatorTrigger("loadReady")
  self:OnTabBtnClick(TabType.Story)
  self:OnLiHuiClicked(true)
  self._cutoverbtnPanel:SetActive(npcID ~= nil)
  self._roleId = roleID
  self._npcId = npcID
  self._cutoverbtnPanel_redDot:SetActive(false)
end

function RoleDetailInfoDialog:RefreshTabsRedDot()
  local isShowFavourRedDot, isShowStoryRedDot, isShowVoiceRedDot
  local relationReceiveMap = self._role:GetRelationReceiveMap()
  local relationLv = self._role:GetRelationLevel()
  local rewardList = self._role:GetRelationRewardList()
  for i, v in ipairs(rewardList) do
    local favourLv = v.favourLv
    if relationLv >= favourLv then
      if not relationReceiveMap[favourLv] then
        isShowFavourRedDot = true
        if v.rewardType == DataCommon.Favour.BackgroundStory then
          isShowStoryRedDot = true
        elseif v.rewardType == DataCommon.Favour.Voice then
          isShowVoiceRedDot = true
        end
      end
    else
      break
    end
  end
  self._tabInfo[TabType.Favour].btnPanel_redDot:SetActive(isShowFavourRedDot)
  self._tabInfo[TabType.Story].btnPanel_redDot:SetActive(isShowStoryRedDot)
  self._tabInfo[TabType.Voice].btnPanel_redDot:SetActive(isShowVoiceRedDot)
end

function RoleDetailInfoDialog:OnTabBtnClick(index)
  if self._pageHelper:GetCurrentIndex() ~= index then
    if self._pageHelper:GetCurrentIndex() == TabType.Favour then
      DialogManager.DestroySingletonDialog("handbook.favour.givegiftdialog")
      self._pageHelper:GetCellAtIndex(TabType.Favour):Leave()
    end
    self._pageHelper:ToPage(index)
  end
end

function RoleDetailInfoDialog:DidToPage(helper, index)
  local tabCell = self._pageHelper:GetCellAtIndex(index)
  if tabCell then
    tabCell:RefreshTabCell()
  end
  for _, v in pairs(TabType) do
    self._tabInfo[v].btnPanel_groupBtn:SetSelected(index == v)
    self._tabInfo[v].title:SetActive(index == v)
  end
end

function RoleDetailInfoDialog:CellAtIndex(helper, index)
  if index == TabType.Story then
    return "handbook.favour.rolestorytabcell"
  elseif index == TabType.Voice then
    return "handbook.favour.rolevoicetabcell"
  elseif index == TabType.Favour then
    return "handbook.favour.rolefavourtabcell"
  end
end

function RoleDetailInfoDialog:SetVoiceAndLines2(roleID, fashionID, tableKey, index, contentId, animation, playHandBook)
  if not self._role:CanPlayVoice() then
    return
  end
  if self._voiceId then
    return
  end
  if playHandBook then
    self._voiceId = NekoData.BehaviorManager.BM_Voice:PlayHandBook(roleID, tableKey, index)
  else
    self._voiceId = NekoData.BehaviorManager.BM_Voice:Play2(roleID, fashionID, tableKey, index)
  end
  if self._voiceId == nil then
    return
  end
  if contentId then
    self._linesText = TextManager.GetText(contentId)
  else
    self._linesText = NekoData.BehaviorManager.BM_Lines:GetLines2(roleID, fashionID, tableKey, index)
  end
  if animation and self._handler then
    local recorder = CEmotion:GetRecorder(animation)
    if recorder then
      self._live2D:PlayLive2DAnimation(recorder.Name, self._handler)
    else
      LogErrorFormat("SetVoiceAndLines2", "No AnimationName Width ID %s", tostring(animation))
    end
  end
  self._dialogPanel:SetActive(true)
  self._dialogPanel:PlayAnimation("CharDataMainDialogShow")
  self._dialogPanel_txt:SetText(self._linesText)
  local _, textheight = self._dialogPanel_txt:GetPreferredSize()
  if textheight > self._dialogPanel_txt_height then
    self._dialogPanel_txt:SetDeltaSize(self._dialogPanel_txt_width, textheight)
    self._dialogPanel:SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height + textheight - self._dialogPanel_txt_height)
  else
    self._dialogPanel_txt:SetDeltaSize(self._dialogPanel_txt_width, self._dialogPanel_txt_height)
    self._dialogPanel:SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height)
  end
  if self._voiceId == 0 then
    local text = string.trim(self._linesText)
    if self._contentTimer then
      GameTimer.RemoveTask(self._contentTimer)
      self._contentTimer = nil
    end
    self._contentTimer = GameTimer.AddTask(utf8.len(text) * timeofword / 1000, -1, function()
      if not self._dialogPanel:IsActive() then
        self:SetVoiceIdNil(true)
      else
        self._dialogPanel:PlayAnimation("CharDataMainDialogHide")
      end
    end)
  end
  local tabCell = self._pageHelper:GetCellAtIndex(TabType.Voice)
  tabCell._black:SetActive(true)
end

function RoleDetailInfoDialog:SetVoiceIdNil(auto)
  if self._voiceId then
    if not auto then
      NekoData.BehaviorManager.BM_Voice:StopVoice(self._voiceId)
    end
    self._voiceId = nil
    local tabCell = self._pageHelper:GetCellAtIndex(TabType.Voice)
    tabCell._black:SetActive(false)
    self._dialogPanel:SetActive(false)
  end
  if self._contentTimer then
    GameTimer.RemoveTask(self._contentTimer)
    self._contentTimer = nil
  end
end

function RoleDetailInfoDialog:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "CharDataMainDialogHide" then
    self:SetVoiceIdNil(true)
  end
end

function RoleDetailInfoDialog:OnCuePlayEnd(notification)
  if self._voiceId then
    local cueSheet, cueName = LuaAudioManager.GetCueSheetAndCueNameWithVoiceID(self._voiceId)
    if cueSheet == notification.userInfo.cueSheet and cueName == notification.userInfo.cueName then
      if not self._dialogPanel:IsActive() then
        self:SetVoiceIdNil(true)
      else
        self._dialogPanel:PlayAnimation("CharDataMainDialogHide")
      end
    end
  end
end

function RoleDetailInfoDialog:OnLiHuiClicked(onInitial)
  if self._picTouchData == nil or #self._picTouchData == 0 or not self._role:CanPlayVoice() then
    return
  end
  local roleID = self._picTouchData[3]
  local fashionID = self._picTouchData[4]
  local thisList
  if onInitial then
    thisList = self._picTouchData[1]
  else
    thisList = self._picTouchData[2]
  end
  local randomForPicTouch = math.random(1, #thisList)
  local thisVal = thisList[randomForPicTouch]
  self:SetVoiceAndLines2(roleID, fashionID, thisVal[1], thisVal[2])
end

function RoleDetailInfoDialog:OnLive2DPointerDown(posName, roleID, fashionID, touchRecordList)
  if self._voiceId then
    return
  end
  local touchRecord
  posName = string.trim(posName)
  for _, tempRecord in ipairs(touchRecordList) do
    if string.trim(tempRecord.area) == posName then
      touchRecord = tempRecord
      break
    end
  end
  if touchRecord then
    local ramdomNum = math.random(1, #touchRecord.state)
    local animaState = touchRecord.state[ramdomNum]
    self._live2D:SetLive2DAnimatorTrigger(self._handler, animaState)
    local voiceAndLinesIDSplit = string.split(touchRecord.volume_id[ramdomNum], ",")
    if self._role:CanPlayVoice() then
      if 1 < #voiceAndLinesIDSplit then
        self:SetVoiceAndLines2(roleID, fashionID, voiceAndLinesIDSplit[1], tonumber(voiceAndLinesIDSplit[2]))
      else
        self:SetVoiceAndLines2(roleID, fashionID, voiceAndLinesIDSplit[1])
      end
    end
  end
end

function RoleDetailInfoDialog:CacheGiveItemId(itemId)
  self._giveItemId = itemId
end

function RoleDetailInfoDialog:RefreshByRoleId(roleID)
  self._canChangeRole = false
  if self._giftEffectHandler then
    self._giftEffect:ReleaseEffect(self._giftEffectHandler)
    self._giftEffectHandler = nil
  end
  self._giveItemId = nil
  self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleID)
  self:SetVoiceIdNil()
  self:RefreshPanel(roleID)
  self._rolePanel:SetAnimatorTrigger("loadReady")
  for _, v in pairs(TabType) do
    local tabCell = self._pageHelper:GetCellAtIndex(v)
    if v == TabType.Story then
      tabCell:RefreshTabCell(true, false, true)
    else
      tabCell:RefreshTabCell(true)
    end
  end
  if self._pageHelper:GetCurrentIndex() == TabType.Favour then
    DialogManager.DestroySingletonDialog("handbook.favour.givegiftdialog")
  end
end

function RoleDetailInfoDialog:OnLeftArrowClick()
  if self._canChangeRole then
    if DialogManager.GetDialog("character.basecharacterlistalldialog") then
      local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
      if dialog and dialog:OnLeftArrowClick(true) then
        self:RefreshByRoleId(dialog._data:GetRoleId())
      end
    else
      local dialog = DialogManager.GetDialog("handbook.handbookdialog")
      if dialog then
        local roleBookListTab = dialog._pageHelper:GetCellAtIndex(4)
        local len = #roleBookListTab._listByConditions
        if 1 < len then
          local leftPos, curPos, pos
          for i, v in ipairs(roleBookListTab._listByConditions) do
            if v:GetRoleId() == self._role:GetRoleId() then
              curPos = i
              break
            end
            if NekoData.BehaviorManager.BM_AllRoles:GetRoleIsUnlock(v:GetRoleId()) then
              leftPos = i
            end
          end
          if leftPos and curPos and curPos > leftPos then
            pos = leftPos
          end
          if not pos then
            for i = len, curPos, -1 do
              if NekoData.BehaviorManager.BM_AllRoles:GetRoleIsUnlock(roleBookListTab._listByConditions[i]:GetRoleId()) and i > curPos then
                pos = i
                break
              end
            end
          end
          if pos then
            self:RefreshByRoleId(roleBookListTab._listByConditions[pos]:GetRoleId())
          end
        end
      end
    end
  end
end

function RoleDetailInfoDialog:OnRightArrowClick()
  if self._canChangeRole then
    if DialogManager.GetDialog("character.basecharacterlistalldialog") then
      local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
      if dialog and dialog:OnRightArrowClick(true) then
        self:RefreshByRoleId(dialog._data:GetRoleId())
      end
    else
      local dialog = DialogManager.GetDialog("handbook.handbookdialog")
      if dialog then
        local roleBookListTab = dialog._pageHelper:GetCellAtIndex(4)
        local len = #roleBookListTab._listByConditions
        if 1 < len then
          local rightPos, curPos, pos
          for i, v in ipairs(roleBookListTab._listByConditions) do
            if v:GetRoleId() == self._role:GetRoleId() then
              curPos = i
            end
            if NekoData.BehaviorManager.BM_AllRoles:GetRoleIsUnlock(v:GetRoleId()) then
              rightPos = i
            end
            if rightPos and curPos and curPos < rightPos then
              pos = rightPos
              break
            end
          end
          if not pos then
            for i = 1, curPos do
              if NekoData.BehaviorManager.BM_AllRoles:GetRoleIsUnlock(roleBookListTab._listByConditions[i]:GetRoleId()) and i < curPos then
                pos = i
                break
              end
            end
          end
          if pos then
            self:RefreshByRoleId(roleBookListTab._listByConditions[pos]:GetRoleId())
          end
        end
      end
    end
  end
end

function RoleDetailInfoDialog:OnRoleChangeStateExit(arg1, arg2)
  if arg2 == "CharChangeRole" then
    self._canChangeRole = true
  end
end

function RoleDetailInfoDialog:OnUniqueEquipBtnClicked()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.UniqueEquip) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100376)
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("uniqueequip.uniqueequipdialog")
  dialog:HideUnlockBtn()
  dialog:SetData(self._role:GetUniqueEquipId())
end

function RoleDetailInfoDialog:OnBackBtnClicked()
  self:Destroy()
end

function RoleDetailInfoDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function RoleDetailInfoDialog:OnCutoverBtnClick()
  DialogManager.CreateSingletonDialog("handbook.npcdetailinfodialog"):Refresh(self._npcId, self._roleId)
  self:Destroy()
end

return RoleDetailInfoDialog
