local CSkin = BeanManager.GetTableByName("role.cskin")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CEmotion = BeanManager.GetTableByName("npc.cemotion")
local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local CSoundCatalog = BeanManager.GetTableByName("sound.csoundcatalog")
local CSoundLines = BeanManager.GetTableByName("sound.csoundlines")
local CSoundLines_Skin = BeanManager.GetTableByNameWithLanguage("sound.csoundlines_skin")
local CSoundAnimations = BeanManager.GetTableByName("sound.clive2dmotion")
local CFavourPresentType = BeanManager.GetTableByName("role.cfavourpresenttype")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CPosterGirlNpc = BeanManager.GetTableByName("welfare.cpostergirlnpc")
local CDungeonSelectMainLine = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CHomeChatConfig = BeanManager.GetTableByName("dialog.chomechatconfig")
local CHomeChatList = BeanManager.GetTableByName("dialog.chomechatlist")
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local TAG = {
  Main = 1,
  Gift = 2,
  Change = 3,
  Sign = 4
}
local SignboardMainDialog = class("SignboardMainDialog", Dialog)
SignboardMainDialog.AssetBundleName = "ui/layouts.signboard"
SignboardMainDialog.AssetName = "SignboardMain"
local progressUpEffectTime = 1
local timeofword = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(88).Value)

local function FinishGuide(self)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(22, 3) then
    LuaNotificationCenter.RemoveObserver(self, Common.n_GuideResponseClick)
    NekoData.BehaviorManager.BM_Guide:FinishGuide(22)
  end
end

function SignboardMainDialog:Ctor(...)
  SignboardMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._cacheHeartEffectData = {}
  self._cachePlayHeartEffectList = {}
  self._lastRoleId = nil
  self._heartInfo = {}
  self._randomChat1IdList = nil
  self._screeningConditions = {}
  self._sortCriteriaNameId = 501827
  self._isAscendingOrder = false
  self._listByConditions = {}
end

function SignboardMainDialog:OnCreate()
  self:GetRootWindow():Subscribe_AnimationEvent("SignboardSign", self.OnAnimationEvent, self)
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._rolePanel = self:GetChild("Role")
  self._live2D = self:GetChild("Role/Live2D")
  self._photo = self:GetChild("Role/Photo")
  self._clickPanel = self:GetChild("Role/Live2D/Live2dClick")
  self._dialogPanel = self:GetChild("Role/Dialog")
  self._dialogPanel_txt = self:GetChild("Role/Dialog/Text")
  self._dialogPanel_width, self._dialogPanel_height = self._dialogPanel:GetDeltaSize()
  self._dialogPanel_txt_width, self._dialogPanel_txt_height = self._dialogPanel_txt:GetDeltaSize()
  self._dialogPanel:SetActive(false)
  self._giftBtn = self:GetChild("UI/GiftBtn")
  self._giftLockBtn = self:GetChild("UI/LockBtn")
  self._changeBtn = self:GetChild("UI/ChangeBtn")
  self._signBtn = self:GetChild("UI/SignBtn")
  self._giftBtn:Subscribe_PointerClickEvent(self.OnGiftBtnClicked, self)
  self._giftLockBtn:Subscribe_PointerClickEvent(self.OnGiftLockBtnClicked, self)
  self._changeBtn:Subscribe_PointerClickEvent(self.OnChangeBtnClicked, self)
  self._signBtn:Subscribe_PointerClickEvent(self.OnSignBtnClicked, self)
  self._clickPanel:Subscribe_PointerClickEvent(function()
    self:OnLiHuiClicked()
  end, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  LuaNotificationCenter.AddObserver(self, self.OnCuePlayEnd, Common.n_CuePlayEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_OnSChooseBackGround, nil)
  for i = 1, 5 do
    self._heartInfo[i] = {}
    self._heartInfo[i].back = self:GetChild("Gift/Back/Level/Heart" .. i .. "Back")
    self._heartInfo[i].light = self:GetChild("Gift/Back/Level/Heart" .. i)
    self._heartInfo[i].effect = self:GetChild("Gift/Back/Level/Heart" .. i .. "/Effect")
  end
  self._progress = self:GetChild("Gift/Back/Level/Heart")
  self._favourLvTxt = self:GetChild("Gift/Back/Level/LvNum")
  self._favourExpTxt = self:GetChild("Gift/Back/Level/Num")
  self._giftBtn = self:GetChild("Gift/Back/Level/Box")
  self._giftBtnIcon = self:GetChild("Gift/Back/Level/Box/Box")
  self._boxEffect = self:GetChild("Gift/Back/Level/Box/Effect")
  self._redDot = self:GetChild("Gift/Back/Level/RedDot")
  self._giftEffect = self:GetChild("EffectHead")
  self._itemEmpty = self:GetChild("Gift/Back/Empty")
  self._itemEmptyTxt = self:GetChild("Gift/Back/Empty/Txt")
  self._itemPanel = self:GetChild("Gift/Back/Frame")
  self._itemFrame = GridFrame.Create(self._itemPanel, self, true, 3)
  self._detailBorder = self:GetChild("Gift/Back/Detail")
  self._detail_name = self:GetChild("Gift/Back/Detail/ItemName")
  self._detail_description = self:GetChild("Gift/Back/Detail/Detail")
  self._heartEffectPanel = self:GetChild("Gift/Back/Detail/HeartFrame")
  self._heartEffectFrame = TableFrame.Create(self._heartEffectPanel, self, false, false)
  self._numBorder = self:GetChild("Gift/Back/Num")
  self._curGiveNumTxt = self:GetChild("Gift/Back/Num/Num")
  self._reduceBtn = self:GetChild("Gift/Back/Num/MinusBtn")
  self._addBtn = self:GetChild("Gift/Back/Num/AddBtn")
  self._minBtn = self:GetChild("Gift/Back/Num/MinBtn")
  self._maxBtn = self:GetChild("Gift/Back/Num/MaxBtn")
  self._giveBtn = self:GetChild("Gift/Back/GiveBtn")
  self._itemEmptyTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1471).msgTextID))
  self._giftBtn:Subscribe_PointerClickEvent(self.OnGiftBtnClick, self)
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  self._minBtn:Subscribe_PointerClickEvent(self.OnMinBtnClicked, self)
  self._maxBtn:Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  self._giveBtn:Subscribe_PointerClickEvent(self.OnGiveBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoleGood, Common.n_RefreshRoleGood, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshReceiveAward, Common.n_RoleGoodReceiveAward, nil)
  self._filterBtn = self:GetChild("Change/FliterBtn")
  self._levelBtn = self:GetChild("Change/LevelBtn")
  self._levelBtnTxt = self:GetChild("Change/LevelBtn/_Text")
  self._sortBtn = self:GetChild("Change/SortBtn")
  self._sortUpBtnImg = self:GetChild("Change/SortBtn/Up")
  self._sortUpBtnImg:SetActive(self._isAscendingOrder)
  self._sortDownBtnImg = self:GetChild("Change/SortBtn/Down")
  self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt = self:GetChild("Change/SortBtn/_TextUp")
  self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt = self:GetChild("Change/SortBtn/_TextDown")
  self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  self._filterBtn:Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self._levelBtn:Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  self._sortBtn:Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  self._filterPanel = self:GetChild("Change/BaseCharacterListFliterNew")
  self._filterDlg = require("logic.dialog.common.filterdialog").Create(self._filterPanel)
  local uiSortInfo = NekoData.BehaviorManager.BM_Game:GetUISortType(CUpdateUISortType.ROLES_HANDBOOK)
  if uiSortInfo then
    self._sortCriteriaNameId = uiSortInfo.nameTxtId or self._sortCriteriaNameId
    self._isAscendingOrder = uiSortInfo.isAscending or self._isAscendingOrder
    self._sortUpBtnImg:SetActive(self._isAscendingOrder)
    self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
    self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
    self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  end
  self._scrollBar = self:GetChild("Change/Scrollbar")
  self.roleListPanel = self:GetChild("Change/CellFrame")
  self._clothesPanel = self:GetChild("Change/ClothesFrame")
  self._size_x, self._size_offset_x, self._size_y, self._size_offset_y = self.roleListPanel:GetSize()
  self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y = self.roleListPanel:GetPosition()
  LuaNotificationCenter.AddObserver(self, self.SetFashionsInfo, Common.n_SGetFashion, nil)
  self._sign_dialog = self:GetChild("Sign/Dialog")
  self._sign_dialogTxt = self:GetChild("Sign/Dialog/Text")
  self._sign_dialogPanel_width, self._sign_dialogPanel_height = self._sign_dialog:GetDeltaSize()
  self._sign_dialogPanel_txt_width, self._sign_dialogPanel_txt_height = self._sign_dialogTxt:GetDeltaSize()
  self._sign_dialog:SetActive(false)
  self._sign_time = self:GetChild("Sign/Time/Text")
  self._active_box = {}
  for i = 1, 7 do
    self._active_box[i] = {
      panel = self:GetChild("Sign/Day" .. i),
      img = self:GetChild("Sign/Day" .. i .. "/Back/Icon"),
      num = self:GetChild("Sign/Day" .. i .. "/Back/Num"),
      getImg = self:GetChild("Sign/Day" .. i .. "/Get/IconGrey"),
      getNum = self:GetChild("Sign/Day" .. i .. "/Get/Num"),
      select = self:GetChild("Sign/Day" .. i .. "/Select"),
      checkMark = self:GetChild("Sign/Day" .. i .. "/Get"),
      effect = self:GetChild("Sign/Day" .. i .. "/Effect"),
      effect_handler = nil
    }
    self._active_box[i].effect:Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
  end
  for i, v in ipairs(self._active_box) do
    v.panel:Subscribe_PointerClickEvent(function()
      self:OnAccumulateClicked(i)
    end, self)
  end
  LuaNotificationCenter.AddObserver(self, self.OnAccumulatedSignResult, Common.n_AccumulatedSignResult, nil)
  LuaNotificationCenter.AddObserver(self, FinishGuide, Common.n_GuideResponseClick, nil)
  self._tag = TAG.Main
end

function SignboardMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("character.characterfashionshowdialog")
  DialogManager.DestroySingletonDialog("handbook.favour.favourgiftdialog")
  DialogManager.DestroySingletonDialog("handbook.favour.givegiftdialog")
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  self._itemFrame:Destroy()
  self._heartEffectFrame:Destroy()
  if self.roleListFrame then
    self.roleListFrame:Destroy()
  end
  if self._fashionFrame then
    self._fashionFrame:Destroy()
  end
  if self._filterDlg then
    self._filterDlg:Destroy()
    self._filterDlg = nil
  end
  if self._voiceId then
    NekoData.BehaviorManager.BM_Voice:StopVoice(self._voiceId)
    self._voiceId = nil
  end
  if self._contentTimer then
    GameTimer.RemoveTask(self._contentTimer)
    self._contentTimer = nil
  end
end

function SignboardMainDialog:Refresh()
  self._roleHasBeenChanged = true
  self:Init()
  self._fashionFrame:ReloadAllCell()
end

local function GetFloorSort(floor)
  local record = CDungeonSelectMainLine:GetRecorder(floor)
  if record then
    return record.sort
  else
    LogErrorFormat("SignboardMainDialog", "GetRecorder in CDungeonSelectMainLine failed with floor %d", floor)
    return -1
  end
end

function SignboardMainDialog:Init(fromLogin)
  self._fromeLogin = fromLogin
  self._roleId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().backgroundRole
  self._skinId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().backgroundSkin
  if self._roleId == 0 then
    local mainLineProgress = NekoData.BehaviorManager.BM_Game:GetMainLineProgress()
    self._progressFloorSort = GetFloorSort(mainLineProgress.floor)
    self:RefreshRamdomChat1IdList()
    self:SetAiLinNa()
  else
    self._giftLockBtn:SetActive(false)
    self._giftBtn:SetActive(true)
    self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._roleId)
    local fashionData
    if self._skinId > 0 then
      fashionData = CSkin:GetRecorder(self._skinId)
    end
    self:SetLive2D(self._role, fashionData)
  end
  if fromLogin then
    self:OnSignBtnClicked()
  elseif CS.UnityEngine.PlayerPrefs.HasKey("FirstUnlockSignBoard") then
    CS.UnityEngine.PlayerPrefs.DeleteKey("FirstUnlockSignBoard")
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if controller then
      controller:RefrashCharBubble()
    end
  end
  if self._tag ~= TAG.Change then
    self:PlayWelcomVoice()
  end
end

function SignboardMainDialog:RefreshRamdomChat1IdList()
  self._randomChat1IdList = {}
  local allIss = CHomeChatConfig:GetAllIds()
  local recorder
  for i, id in ipairs(allIss) do
    recorder = CHomeChatConfig:GetRecorder(id)
    local effectRange = string.split(recorder.effectRange, ",")
    local cUpfloor = tonumber(effectRange[1])
    local cDownfloor = cUpfloor
    if cUpfloor and 0 < cUpfloor then
      if effectRange[2] then
        cDownfloor = tonumber(effectRange[2])
      end
      local cUpfloorSort = GetFloorSort(cUpfloor)
      local cDownfloorSort = GetFloorSort(cDownfloor)
      if cUpfloorSort <= self._progressFloorSort and cDownfloorSort >= self._progressFloorSort and recorder.character == 1 then
        table.insert(self._randomChat1IdList, {
          dialogId = tonumber(recorder.dialogList),
          weight = recorder.weight,
          animation = recorder.animation
        })
      end
    end
  end
end

function SignboardMainDialog:GetRamdomChat1ByWeight()
  local totalWeight = 0
  local weightIdDic = {}
  for _, value in pairs(self._randomChat1IdList) do
    local curWeight = value.weight
    totalWeight = totalWeight + curWeight
  end
  table.sort(self._randomChat1IdList, function(a, b)
    return a.weight > b.weight
  end)
  local randomValue = math.random() * totalWeight
  for _, value in ipairs(self._randomChat1IdList) do
    randomValue = randomValue - value.weight
    if randomValue < 0 then
      return value
    end
  end
  LogError("SignboardMainDialog", "Unable to get randomId! fallback to the first item!")
  return self._randomChat1IdList[1]
end

function SignboardMainDialog:SetAiLinNa()
  local aiLinNaRecorder = CPosterGirlNpc:GetRecorder(0)
  local record = CNpcShapeTable:GetRecorder(aiLinNaRecorder.shapeId)
  if self._handler then
    self._live2D:Release(self._handler)
    self._handler = nil
  end
  if Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" then
    self._photo:SetActive(false)
    self._handler = self._live2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
  else
    self._photo:SetActive(true)
    local recorder = CImagePathTable:GetRecorder(record.lihuiID)
    self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
    local scale = record.photoScale
    self._photo:SetLocalScale(scale, scale, scale)
    self._photo:SetAnchoredPosition(record.photoLocation[1], record.photoLocation[2])
  end
  self._clickPanel:SetActive(true)
  self._giftLockBtn:SetActive(true)
  self._giftBtn:SetActive(false)
end

function SignboardMainDialog:SetLive2D(data, fashionData)
  if not data and not fashionData then
    return
  end
  local theRoleID = data:GetId()
  local theFashionID = data:GetDefaultFashion()
  local record = data:GetShapeLive2DRecord()
  if fashionData then
    local shapeId = fashionData.shapeID
    record = CNpcShapeTable:GetRecorder(shapeId)
    theRoleID = fashionData.roleid
    theFashionID = fashionData.id
  end
  self._picTouchData = {
    NekoData.BehaviorManager.BM_RoleTouch:GetPicTouchInfo(theRoleID, theFashionID)
  }
  if self._handler then
    self._live2D:Release(self._handler)
    self._handler = nil
  end
  if fashionData.shapeType == 2 and Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" then
    self._photo:SetActive(false)
    self._handler = self._live2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
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
    self._clickPanel:SetActive(true)
    self._photo:SetActive(true)
    if fashionData then
      local recorder = CImagePathTable:GetRecorder(record.lihuiID)
      self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
      local scale = record.photoScale
      self._photo:SetLocalScale(scale, scale, scale)
      self._photo:SetAnchoredPosition(record.photoLocation[1], record.photoLocation[2])
    else
      local recorder = data:GetShapeLiHuiImageRecord()
      self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
      local scale = data:GetPhotoScale()
      self._photo:SetLocalScale(scale, scale, scale)
      local photoPos = data:GetPhotoPosition()
      self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
    end
  end
end

function SignboardMainDialog:PlayWelcomVoice()
  if self._role and not self._role:CanPlayVoice() then
    return
  end
  local id = self._roleId
  local soundLinesRecord = CSoundLines:GetRecorder(id)
  local contentId, key
  contentId = soundLinesRecord.PosterGirlWelcome
  key = NekoData.BehaviorManager.BM_Voice.VoiceType.PosterGirlWelcome
  self:SetVoiceAndLines2(self._roleId, nil, key, nil, contentId)
end

function SignboardMainDialog:SetVoiceAndLines2(roleID, fashionID, tableKey, index, contentId, animation, playHandBook)
  if self._role and not self._role:CanPlayVoice() then
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
  if self._tag == TAG.Sign then
    self._sign_dialog:SetActive(true)
    self._sign_dialog:PlayAnimation("CharDataMainDialogShow")
    self._sign_dialogTxt:SetText(self._linesText)
    local _, textheight = self._sign_dialogTxt:GetPreferredSize()
    if textheight > self._sign_dialogPanel_txt_height then
      self._sign_dialogTxt:SetDeltaSize(self._sign_dialogPanel_txt_width, textheight)
      self._sign_dialog:SetDeltaSize(self._sign_dialogPanel_width, self._sign_dialogPanel_height + textheight - self._sign_dialogPanel_txt_height)
    else
      self._sign_dialogTxt:SetDeltaSize(self._sign_dialogPanel_txt_width, self._sign_dialogPanel_txt_height)
      self._sign_dialog:SetDeltaSize(self._sign_dialogPanel_width, self._sign_dialogPanel_height)
    end
  else
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
  end
  if self._voiceId == 0 then
    local text = string.trim(self._linesText)
    if self._contentTimer then
      GameTimer.RemoveTask(self._contentTimer)
      self._contentTimer = nil
    end
    if self._tag == TAG.Sign then
      self._contentTimer = GameTimer.AddTask(utf8.len(text) * timeofword / 1000, -1, function()
        self:SetVoiceIdNil(true)
      end)
    else
      self._contentTimer = GameTimer.AddTask(utf8.len(text) * timeofword / 1000, -1, function()
        self:SetVoiceIdNil(true)
      end)
    end
  end
end

function SignboardMainDialog:SetVoiceIdNil(auto)
  if self._voiceId then
    if not auto then
      NekoData.BehaviorManager.BM_Voice:StopVoice(self._voiceId)
    end
    self._voiceId = nil
    self._sign_dialog:SetActive(false)
    self._dialogPanel:SetActive(false)
  end
  if self._contentTimer then
    GameTimer.RemoveTask(self._contentTimer)
    self._contentTimer = nil
  end
end

function SignboardMainDialog:OnCuePlayEnd(notification)
  if self._voiceId then
    local cueSheet, cueName = LuaAudioManager.GetCueSheetAndCueNameWithVoiceID(self._voiceId)
    if cueSheet == notification.userInfo.cueSheet and cueName == notification.userInfo.cueName then
      self:SetVoiceIdNil(true)
    end
  end
end

function SignboardMainDialog:OnLiHuiClicked(onInitial)
  if self._tag == TAG.Sign or self._tag == TAG.Change then
    return
  end
  if self._picTouchData == nil or #self._picTouchData == 0 then
    return
  end
  if self._roleId == 0 then
    if self._voiceId then
      return
    end
    local chatdata = self:GetRamdomChat1ByWeight()
    if not chatdata then
      return
    end
    local textId = CHomeChatList:GetRecorder(chatdata.dialogId).contentTextID
    local voiceId = CHomeChatList:GetRecorder(chatdata.dialogId).voiceId
    self:SetVoiceAndLines2(nil, nil, nil, nil, textId, chatdata.animation)
    if voiceId ~= 0 then
      self._voiceId = voiceId
      LuaAudioManager.PlayVoice(self._voiceId)
    end
  elseif self._role:CanPlayVoice() then
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
end

function SignboardMainDialog:OnLive2DPointerDown(posName, roleID, fashionID, touchRecordList)
  if self._tag == TAG.Sign or self._tag == TAG.Change then
    return
  end
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
    if 1 < #voiceAndLinesIDSplit then
      self:SetVoiceAndLines2(roleID, fashionID, voiceAndLinesIDSplit[1], tonumber(voiceAndLinesIDSplit[2]))
    else
      self:SetVoiceAndLines2(roleID, fashionID, voiceAndLinesIDSplit[1])
    end
  end
end

function SignboardMainDialog:OnGiftBtnClicked()
  self._tag = TAG.Gift
  self:GetRootWindow():SetAnimatorInteger("state", 2)
  self:GiftRefresh(true)
end

function SignboardMainDialog:OnGiftLockBtnClicked()
  NekoData.BehaviorManager.BM_Message:SendMessageById(100311)
end

function SignboardMainDialog:OnChangeBtnClicked()
  self._tag = TAG.Change
  self:GetRootWindow():SetAnimatorInteger("state", 3)
  self:ChangeRefresh()
end

function SignboardMainDialog:OnSignBtnClicked()
  self._tag = TAG.Sign
  self:GetRootWindow():SetAnimatorInteger("state", 4)
  self:SignRefresh()
end

function SignboardMainDialog:OnBackBtnClicked()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(30) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(30)
  end
  if self._fromeLogin then
    if self._receive then
      self:Destroy()
    end
  elseif self._tag == TAG.Main then
    self:Destroy()
  else
    if self._tag == TAG.Gift then
      self:GetRootWindow():PlayAnimation("SignboardGiftHide")
    else
      self:GetRootWindow():SetAnimatorInteger("state", 1)
    end
    self._tag = TAG.Main
  end
end

function SignboardMainDialog:OnAnimationEnd(handler, stateName, normalizedTime)
  self:GetRootWindow():SetAnimatorInteger("state", -1)
  if stateName == "SignboardChange" and self._roleHasBeenChanged then
    self._roleHasBeenChanged = false
    self:SetVoiceIdNil()
    self:OnLiHuiClicked(true)
  end
end

function SignboardMainDialog:OnAnimationEvent()
  if self._accIndex ~= 0 then
    self._active_box[self._accIndex].select:SetActive(true)
    self._active_box[self._accIndex].checkMark:SetActive(false)
    self._active_box[self._accIndex].effect_handler = self._active_box[self._accIndex].effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1136))
  end
end

function SignboardMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

local function PlayHeartEffect(self)
  local isplaying
  for i, data in ipairs(self._cachePlayHeartEffectList) do
    if data.playing then
      isplaying = true
      break
    end
  end
  if not isplaying then
    local data = self._cachePlayHeartEffectList[1]
    if data then
      if data.effectType == "LeftHalf" then
        data.heartEffectHandler = self._heartInfo[data.index].effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1123))
        data.playing = true
      elseif data.effectType == "RightHalf" then
        data.heartEffectHandler = self._heartInfo[data.index].effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1124))
        data.playing = true
      elseif data.effectType == "Whole" then
        data.heartEffectHandler = self._heartInfo[data.index].effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1128))
        data.playing = true
      end
    end
  end
end

function SignboardMainDialog:OnHeartEffectEnd(index, window, effectHandler)
  local deleteIndex
  for i, data in ipairs(self._cachePlayHeartEffectList) do
    if data.index == index and data.heartEffectHandler == effectHandler then
      if data.effectType == "LeftHalf" then
        self._heartInfo[index].light:SetFillAmount(0.5)
      else
        self._heartInfo[index].light:SetFillAmount(1)
      end
      deleteIndex = i
      break
    end
  end
  if deleteIndex then
    table.remove(self._cachePlayHeartEffectList, deleteIndex)
    PlayHeartEffect(self)
  end
end

local function RefreshProgress(self)
  local maxLv = self._role:GetRelationMaxLevel()
  local maxProgress = self._role:GetRelationMaxProgress()
  local amount
  if maxLv > self._curLv then
    self._favourExpTxt:SetText(self._curProgress .. "/" .. maxProgress)
    amount = self._curProgress / maxProgress
  else
    self._favourExpTxt:SetText("MAX")
    amount = 1
  end
  self._progress:SetFillAmount(amount)
end

function SignboardMainDialog:GiftRefresh(refreshData, notChangePos)
  if refreshData then
    if self._progressTask then
      self._progressTask = nil
      self._times = 0
    end
    while self._cacheHeartEffectData[#self._cacheHeartEffectData] do
      table.remove(self._cacheHeartEffectData, #self._cacheHeartEffectData)
    end
    while self._cachePlayHeartEffectList[#self._cachePlayHeartEffectList] do
      table.remove(self._cachePlayHeartEffectList, #self._cachePlayHeartEffectList)
    end
    self._rarityId = self._role:GetRarityId()
    local curLv = self._role:GetRelationLevel()
    self._curLv = curLv
    self._lastLv = self._curLv
    local maxLv = self._role:GetRelationMaxLevel()
    local curProgress = self._role:GetRelationProgress()
    self._curProgress = curProgress
    local favourExpRecord = CFavourExp:GetRecorder(curLv)
    local curHeartNum = favourExpRecord.heartnum / 10
    local maxHeartNum = math.ceil(CFavourExp:GetRecorder(maxLv).heartnum / 10)
    local integer, decimal = math.modf(curHeartNum)
    for i, v in ipairs(self._heartInfo) do
      if i > maxHeartNum then
        v.back:SetActive(false)
        v.light:SetActive(false)
      elseif curHeartNum > i - 1 and i > curHeartNum then
        v.light:SetFillAmount(decimal)
      elseif i <= curHeartNum then
        v.light:SetFillAmount(1)
      else
        v.light:SetFillAmount(0)
      end
    end
    self._favourLvTxt:SetText(curLv)
    RefreshProgress(self)
    local value = self._role:IsShowRelationRedDot()
    if value then
      self._redDot:SetActive(true)
      self._giftBtnIcon:SetActive(false)
      if not self._boxEffectHandler then
        self._boxEffectHandler = self._boxEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1122))
      end
    else
      self._redDot:SetActive(false)
      self._giftBtnIcon:SetActive(true)
      if self._boxEffectHandler then
        self._boxEffect:ReleaseEffect(self._boxEffectHandler)
        self._boxEffectHandler = nil
      end
    end
  end
  self:OnSendBtnClick()
end

local function GetRelationMaxProgress(self, level)
  local favourExpRecord = CFavourExp:GetRecorder(level)
  if self._rarityId == 1 then
    return favourExpRecord.Rfavourexp
  end
  if self._rarityId == 2 then
    return favourExpRecord.SRfavourexp
  end
  if self._rarityId == 3 then
    return favourExpRecord.SSRfavourexp
  end
  if self._rarityId == 4 then
    return favourExpRecord.URfavourexp
  end
  if self._rarityId == 5 then
    return favourExpRecord.EXfavourexp
  end
end

local function RefreshProgressByUpdate(self, level, progress)
  local maxLv = self._role:GetRelationMaxLevel()
  local maxProgress = GetRelationMaxProgress(self, level)
  local amount
  if level >= maxLv then
    self._favourExpTxt:SetText("MAX")
    amount = 1
  else
    self._favourExpTxt:SetText(math.floor(progress) .. "/" .. maxProgress)
    amount = progress / maxProgress
  end
  self._progress:SetFillAmount(amount)
end

local function PlayFavourUpEffect(self, level, progress)
  self._lastLv = self._curLv
  local curLv = self._curLv
  local maxLv = self._role:GetRelationMaxLevel()
  self._curLv = level
  local curProgress = self._curProgress
  self._curProgress = progress
  if curLv < maxLv then
    local addNum
    if level == curLv then
      addNum = progress - curProgress
    else
      local rarityId = self._role:GetRarityId()
      local curRecord = CFavourExp:GetRecorder(curLv)
      local curMaxFavourExp = 0
      if rarityId == 1 then
        curMaxFavourExp = curRecord.Rfavourexp
      elseif rarityId == 2 then
        curMaxFavourExp = curRecord.SRfavourexp
      elseif rarityId == 3 then
        curMaxFavourExp = curRecord.SSRfavourexp
      elseif rarityId == 4 then
        curMaxFavourExp = curRecord.URfavourexp
      elseif rarityId == 5 then
        curMaxFavourExp = curRecord.EXfavourexp
      end
      addNum = curMaxFavourExp - curProgress
      for i = curLv + 1, level - 1 do
        local num
        local record = CFavourExp:GetRecorder(i)
        if rarityId == 1 then
          num = record.Rfavourexp
        elseif rarityId == 2 then
          num = record.SRfavourexp
        elseif rarityId == 3 then
          num = record.SSRfavourexp
        elseif rarityId == 4 then
          num = record.URfavourexp
        elseif rarityId == 5 then
          num = record.EXfavourexp
        end
        addNum = addNum + num
      end
      addNum = addNum + progress
    end
    NekoData.BehaviorManager.BM_Message:SendMessageById(100250, {addNum})
  end
  self._favourLvTxt:SetText(self._curLv)
  local value = self._role:IsShowRelationRedDot()
  if value then
    self._redDot:SetActive(true)
    self._giftBtnIcon:SetActive(false)
    if not self._boxEffectHandler then
      self._boxEffectHandler = self._boxEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1122))
    end
  else
    self._redDot:SetActive(false)
    self._giftBtnIcon:SetActive(true)
    if self._boxEffectHandler then
      self._boxEffect:ReleaseEffect(self._boxEffectHandler)
      self._boxEffectHandler = nil
    end
  end
  self:SetData(self._role:GetId())
end

function SignboardMainDialog:OnUpdate(notification)
  if self._progressTask then
    if self._progressTask:update(notification.userInfo.deltaTime) then
      local progress = self._progressTask.target.progress
      local level = self._progressTask.target.level
      local trueLv = self._progressTask.target.trueLv
      local trueProgress = self._progressTask.target.trueProgress
      RefreshProgressByUpdate(self, self._progressTask.initial.level, progress)
      if trueProgress and progress / GetRelationMaxProgress(self, self._progressTask.initial.level) ~= trueProgress / GetRelationMaxProgress(self, trueLv) or trueLv and level < trueLv then
        if trueLv and level < trueLv then
          if self._times == 2 or level == trueLv - 1 then
            self._progressTask = Tween.new(progressUpEffectTime, {progress = 0, level = trueLv}, {progress = trueProgress, level = trueLv}, "linear")
          else
            self._times = self._times + 1
            self._progressTask = Tween.new(progressUpEffectTime, {
              progress = 0,
              level = level,
              trueLv = level,
              trueProgress = progress
            }, {
              progress = GetRelationMaxProgress(self, level),
              level = level + 1,
              trueLv = trueLv,
              trueProgress = trueProgress
            }, "linear")
          end
        else
          self._progressTask = Tween.new(progressUpEffectTime, {progress = 0, level = level}, {progress = trueProgress, level = level}, "linear")
        end
      else
        self._progressTask = nil
        self._times = 0
        if self._lastLv < self._curLv then
          self._delegate:AddLevelUpEffect()
          table.insert(self._cacheHeartEffectData, {
            startLv = self._lastLv,
            endLv = self._curLv
          })
          self:PlayHeartEffect()
        end
      end
    else
      RefreshProgressByUpdate(self, self._progressTask.initial.level, self._progressTask.subject.progress)
    end
  end
end

function SignboardMainDialog:PlayFavourProgressUpEffect(level, progress)
  self._times = 0
  if self._progressTask then
    self._progressTask = nil
    if self._lastLv < self._curLv then
      self._delegate:AddLevelUpEffect()
      table.insert(self._cacheHeartEffectData, {
        startLv = self._lastLv,
        endLv = self._curLv
      })
      self:PlayHeartEffect()
    end
  end
  if progress > self._curProgress or level > self._curLv then
    if level > self._curLv then
      self._times = 1
      self._progressTask = Tween.new(progressUpEffectTime, {
        progress = self._curProgress,
        level = self._curLv,
        trueLv = self._curLv,
        trueProgress = self._curProgress
      }, {
        progress = GetRelationMaxProgress(self, self._curLv),
        level = self._curLv + 1,
        trueLv = level,
        trueProgress = progress
      }, "linear")
    else
      self._progressTask = Tween.new(progressUpEffectTime, {
        progress = self._curProgress,
        level = self._curLv
      }, {progress = progress, level = level}, "linear")
    end
  end
  PlayFavourUpEffect(self, level, progress)
end

function SignboardMainDialog:PlayHeartEffect()
  local data = self._cacheHeartEffectData[1]
  if data then
    table.remove(self._cacheHeartEffectData, 1)
    local lastLv = data.startLv
    for i = data.startLv + 1, data.endLv do
      local lastHeartNum = CFavourExp:GetRecorder(lastLv).heartnum / 10
      local lastInteger, lastDecimal = math.modf(lastHeartNum)
      local favourExpRecord = CFavourExp:GetRecorder(i)
      local curHeartNum = favourExpRecord.heartnum / 10
      local integer, decimal = math.modf(curHeartNum)
      if lastInteger == integer then
        if i == data.endLv and lastDecimal < decimal then
          table.insert(self._cachePlayHeartEffectList, {
            index = math.ceil(curHeartNum),
            effectType = "LeftHalf"
          })
          lastLv = i
        end
      elseif lastInteger < integer then
        if lastDecimal > decimal then
          table.insert(self._cachePlayHeartEffectList, {
            index = math.ceil(curHeartNum),
            effectType = "RightHalf"
          })
          lastLv = i
        else
          table.insert(self._cachePlayHeartEffectList, {
            index = math.ceil(curHeartNum),
            effectType = "Whole"
          })
          lastLv = i
        end
      end
    end
  end
  PlayHeartEffect(self)
end

function SignboardMainDialog:Leave()
  if self._progressTask then
    self._progressTask = nil
    self:GiftRefresh(true)
    self._times = 0
  end
  while self._cacheHeartEffectData[#self._cacheHeartEffectData] do
    table.remove(self._cacheHeartEffectData, #self._cacheHeartEffectData)
  end
  while self._cachePlayHeartEffectList[#self._cachePlayHeartEffectList] do
    table.remove(self._cachePlayHeartEffectList, #self._cachePlayHeartEffectList)
  end
end

function SignboardMainDialog:OnShowBtnClick()
  DialogManager.CreateSingletonDialog("character.characterfashionshowdialog"):SetData(self._role:GetDefaultFashion())
end

function SignboardMainDialog:OnGiftBtnClick()
  if not self._giveItemId then
    DialogManager.CreateSingletonDialog("handbook.favour.favourgiftdialog"):SetData(self._role:GetId())
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100252)
  end
end

function SignboardMainDialog:OnSendBtnClick()
  if #NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(75) > 0 then
    self:SetData(self._role:GetId())
    self._itemEmpty:SetActive(false)
    self._giveBtn:SetInteractable(true)
    self._numBorder:SetActive(true)
    self._itemPanel:SetActive(true)
    self._detailBorder:SetActive(true)
  else
    self._itemEmpty:SetActive(true)
    self._giveBtn:SetInteractable(false)
    self._numBorder:SetActive(false)
    self._itemPanel:SetActive(false)
    self._detailBorder:SetActive(false)
  end
end

function SignboardMainDialog:SetData(roleId)
  self._itemList = {}
  self._needExp = 0
  self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  local rarityId = self._role:GetRarityId()
  local curLv = self._role:GetRelationLevel()
  local maxLv = self._role:GetRelationMaxLevel()
  local curProgress = self._role:GetRelationProgress()
  if curLv < maxLv then
    for i = curLv, maxLv do
      local record = CFavourExp:GetRecorder(i)
      local num
      if rarityId == 1 then
        num = record.Rfavourexp
      elseif rarityId == 2 then
        num = record.SRfavourexp
      elseif rarityId == 3 then
        num = record.SSRfavourexp
      elseif rarityId == 4 then
        num = record.URfavourexp
      elseif rarityId == 5 then
        num = record.EXfavourexp
      end
      if i == curLv then
        self._needExp = self._needExp + num - curProgress
      else
        self._needExp = self._needExp + num
      end
    end
  end
  self._favourGiftType = self._role:GetFavourGiftType()
  local itemList = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(75)
  local list = {}
  for i, v in ipairs(itemList) do
    local pinJiID = v:GetPinJiID()
    if not list[pinJiID] then
      list[pinJiID] = {}
    end
    table.insert(list[pinJiID], v)
  end
  local temp = {}
  for k, v in pairs(list) do
    table.insert(temp, k)
  end
  table.sort(temp, function(a, b)
    return b < a
  end)
  local map = {}
  for k, v in pairs(list) do
    map[k] = {
      likeItemList = {},
      dislikeItemList = {}
    }
    for i, item in ipairs(v) do
      local favourPresentTypeRecord = CFavourPresentType:GetRecorder(item:GetID())
      if favourPresentTypeRecord.presenttype == self._favourGiftType then
        table.insert(map[k].likeItemList, item)
      else
        table.insert(map[k].dislikeItemList, item)
      end
    end
    table.sort(map[k].likeItemList, function(a, b)
      local a_id, b_id = a:GetID(), b:GetID()
      return a_id < b_id
    end)
  end
  for k, v in pairs(temp) do
    local data = map[v]
    for _, item in ipairs(data.likeItemList) do
      table.insert(self._itemList, item)
    end
  end
  for k, v in pairs(temp) do
    local data = map[v]
    for _, item in ipairs(data.dislikeItemList) do
      table.insert(self._itemList, item)
    end
  end
  if self._selectItem == nil then
    self._selectItem = self._itemList[1]
  elseif self._selectItemIndex then
    for i = self._selectItemIndex, 1, -1 do
      if self._itemList[i] then
        self._selectItem = self._itemList[i]
        break
      end
    end
  end
  self:RefreshSelectItemDetail()
  self._itemFrame:ReloadAllCell()
end

function SignboardMainDialog:RefreshSelectItemDetail()
  self._detail_name:SetText(self._selectItem:GetName())
  self._detail_description:SetText(self._selectItem:GetDestribe())
  local favourPresentTypeRecord = CFavourPresentType:GetRecorder(self._selectItem:GetID())
  self._heartEffectNum = favourPresentTypeRecord.presentuplevel
  self._favourExpNum = favourPresentTypeRecord.favour
  if favourPresentTypeRecord.presenttype == self._favourGiftType then
    self._heartEffectNum = self._heartEffectNum * 2
    self._favourExpNum = self._favourExpNum + favourPresentTypeRecord.exfavour
  end
  self._sendMaxNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(self._selectItem:GetID())
  self._sendNum = 1
  self._curGiveNumTxt:SetText(self._sendNum)
end

function SignboardMainDialog:SetSelectItem(item, index)
  if item:GetID() ~= self._selectItem:GetID() then
    self._selectItem = item
    self._selectItemIndex = index
    self:RefreshSelectItemDetail()
    self._itemFrame:FireEvent("SetSelectItem", self._selectItem:GetID())
  end
end

function SignboardMainDialog:OnReduceBtnClicked()
  if self._sendNum > 1 then
    self._sendNum = self._sendNum - 1
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100253)
  end
end

function SignboardMainDialog:OnAddBtnClicked()
  if self._sendNum < self._sendMaxNum then
    self._sendNum = self._sendNum + 1
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100254)
  end
end

function SignboardMainDialog:OnMinBtnClicked()
  if self._sendNum ~= 1 then
    self._sendNum = 1
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100253)
  end
end

function SignboardMainDialog:OnMaxBtnClicked()
  if self._sendNum ~= self._sendMaxNum then
    if self._needExp == 0 then
      self._sendNum = self._sendMaxNum
    else
      self._sendNum = self._sendMaxNum
      local num = math.ceil(self._needExp / self._favourExpNum)
      if num < self._sendMaxNum then
        self._sendNum = num
      end
    end
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100254)
  end
end

function SignboardMainDialog:OnGiveBtnClicked()
  if self._role:GetRelationLevel() < self._role:GetRelationMaxLevel() then
    local csend = LuaNetManager.CreateProtocol("protocol.good.cpresent")
    csend.roleId = self._role:GetId()
    csend.itemId = self._selectItem:GetID()
    csend.itemNum = self._sendNum
    csend:Send()
    self:CacheGiveItemId(self._selectItem:GetID())
  else
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(89, nil, function()
      local csend = LuaNetManager.CreateProtocol("protocol.good.cpresent")
      csend.roleId = self._role:GetId()
      csend.itemId = self._selectItem:GetID()
      csend.itemNum = self._sendNum
      csend:Send()
      self:CacheGiveItemId(self._selectItem:GetID())
    end, {}, nil, {})
  end
end

function SignboardMainDialog:CacheGiveItemId(itemId)
  self._giveItemId = itemId
end

function SignboardMainDialog:OnRefreshRoleGood(notification)
  local protocol = notification.userInfo
  local roleId = self._role:GetId()
  if protocol.roleId == roleId then
    local tag = false
    if self._giveItemId then
      local soundCatalogRecord = CSoundCatalog:GetRecorder(roleId)
      local soundLinesRecord
      local fashionId = self._role:GetDefaultFashion()
      if 0 < fashionId then
        soundLinesRecord = CSoundLines_Skin:GetRecorder(fashionId)
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
            self:SetVoiceAndLines2(self._roleId, fashionId, NekoData.BehaviorManager.BM_Voice.VoiceType.FavoriteGift, nil, soundLinesRecord.FavoriteGift, soundAnimationRecord.FavoriteGift)
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
            self:SetVoiceAndLines2(self._roleId, fashionId, NekoData.BehaviorManager.BM_Voice.VoiceType.NormalGift, nil, soundLinesRecord.NormalGift, soundAnimationRecord.NormalGift)
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
      self:PlayFavourProgressUpEffect(protocol.level, protocol.progress)
    end
    self:GiftRefresh(true, true)
  end
end

function SignboardMainDialog:OnRefreshReceiveAward(notification)
  local protocol = notification.userInfo
  local roleId = self._role:GetId()
  if protocol.roleId == self._role:GetId() then
    self:GiftRefresh(true)
  end
end

function SignboardMainDialog:ChangeRefresh()
  if self.roleListFrame then
    self.roleListFrame:Destroy()
  end
  self.roleListFrame = GridFrame.Create(self.roleListPanel, self, true, 9)
  self._data = NekoData.BehaviorManager.BM_AllRoles:GetContainMaterialRoleList()
  local leadIndex
  for i, v in ipairs(self._data) do
    if v:GetId() == 1 then
      leadIndex = i
      break
    end
  end
  table.remove(self._data, leadIndex)
  self._filterBtn:SetActive(true)
  self._levelBtn:SetActive(true)
  self._sortBtn:SetActive(true)
  if self._contentTimer then
    GameTimer.RemoveTask(self._contentTimer)
    self._contentTimer = nil
  end
  self._dialogPanel:SetActive(false)
  self:ScreeningAndSorting()
end

function SignboardMainDialog:OnFilterBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 1, "SignBordRole", self._screeningConditions)
end

function SignboardMainDialog:OnLevelBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 2, "SignBordRole", self._sortCriteriaNameId)
end

function SignboardMainDialog:OnSortBtnClick()
  self._isAscendingOrder = not self._isAscendingOrder
  self._sortUpBtnImg:SetActive(self._isAscendingOrder)
  self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  self:ScreeningAndSorting()
  NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.ROLES_HANDBOOK, self._sortCriteriaNameId, self._isAscendingOrder)
end

function SignboardMainDialog:SetSortCriteriaNameId(nameId)
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
    NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.ROLES_HANDBOOK, self._sortCriteriaNameId, self._isAscendingOrder)
  end
end

function SignboardMainDialog:SetScreeningConditions(screeningConditions)
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

function SignboardMainDialog:SendCUpdateUISortType()
  local OrderType = {Ascending = 1, Descending = 2}
  local csend = LuaNetManager.CreateProtocol("protocol.login.cupdateuisorttype")
  csend.key = CUpdateUISortType.ROLES_HANDBOOK
  local order = OrderType.Ascending
  if not self._isAscendingOrder then
    order = OrderType.Descending
  end
  csend.Showtype = self._sortCriteriaNameId * 10 + order
  csend:Send()
end

function SignboardMainDialog:GetNumByRoleId(id)
  local count = 0
  for i, v in ipairs(self._listByConditions) do
    if v:GetId() == id then
      count = count + 1
    end
  end
  return count
end

function SignboardMainDialog:ScreeningAndSorting()
  self._levelBtnTxt:SetText(TextManager.GetText(self._sortCriteriaNameId))
  self._listByConditions = {}
  for i, v in ipairs(self._data) do
    table.insert(self._listByConditions, v)
  end
  for k, v in pairs(self._screeningConditions) do
    local select = false
    local indexMap = {}
    for index, value in ipairs(v) do
      select = true
      for i, role in ipairs(self._listByConditions) do
        if value.nameid == 501833 and role:GetRarityId() == 1 or value.nameid == 501832 and role:GetRarityId() == 2 or value.nameid == 501831 and role:GetRarityId() == 3 or value.nameid == 501834 and role:GetRarityId() == 4 or value.nameid == 502614 and role:GetRarityId() == 5 then
          indexMap[i] = i
        end
      end
    end
    for index, value in ipairs(v) do
      for i, role in ipairs(self._listByConditions) do
        if value.nameid == role:GetVocationNameId() then
          indexMap[i] = i
        end
      end
    end
    for index, value in ipairs(v) do
      for i, role in ipairs(self._listByConditions) do
        if value.nameid == 502771 and role:GetElement() == 1 or value.nameid == 502772 and role:GetElement() == 2 or value.nameid == 502773 and role:GetElement() == 3 or value.nameid == 502774 and role:GetElement() == 4 then
          indexMap[i] = i
        end
      end
    end
    if select then
      local deleteList = {}
      for i = 1, #self._listByConditions do
        if not indexMap[i] then
          table.insert(deleteList, i)
        end
      end
      while deleteList[#deleteList] do
        table.remove(self._listByConditions, deleteList[#deleteList])
        table.remove(deleteList, #deleteList)
      end
    end
  end
  table.sort(self._listByConditions, function(a, b)
    local _a, _b
    if self._sortCriteriaNameId == 501827 then
      _a = a:GetLevel()
      _b = b:GetLevel()
    elseif self._sortCriteriaNameId == 501828 then
      _a = a:GetRarityId()
      _b = b:GetRarityId()
    elseif self._sortCriteriaNameId == 501829 then
      _a = a:GetBirthDay()
      _b = b:GetBirthDay()
    end
    if _a == _b and self._sortCriteriaNameId ~= 501829 then
      local aId, bId
      if self._sortCriteriaNameId == 501827 or self._sortCriteriaNameId == 501828 then
        aId, bId = a:GetRarityId(), b:GetRarityId()
      end
      if aId == bId then
        local aKey, bKey
        aKey, bKey = a:GetBirthDay(), b:GetBirthDay()
        if self._isAscendingOrder then
          return aKey > bKey
        else
          return aKey < bKey
        end
      elseif self._isAscendingOrder then
        return aId < bId
      else
        return aId > bId
      end
    elseif self._isAscendingOrder then
      return _a < _b
    else
      return _a > _b
    end
  end)
  local alinnaData = false
  table.insert(self._listByConditions, 1, alinnaData)
  if self.roleListFrame then
    self.roleListFrame:ReloadAllCell()
  end
end

function SignboardMainDialog:OnCurPosChange(frame, proportion)
  if frame == self.roleListFrame then
    local width, height = self.roleListPanel:GetRectSize()
    local total = self.roleListFrame:GetTotalLength()
    if height < total then
      self._scrollBar:SetActive(true)
      self._scrollBar:SetScrollSize(height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetActive(false)
    end
  end
end

function SignboardMainDialog:OnCharCellClick(role)
  if role == false then
    self._selectRole = nil
    self._fishionData = {}
    local aiLinNaRecorder = CPosterGirlNpc:GetRecorder(0)
    local shapeRecord = CNpcShapeTable:GetRecorder(aiLinNaRecorder.shapeId)
    local alinnaData = {isAlinna = true, data = shapeRecord}
    table.insert(self._fishionData, alinnaData)
    if self._fashionFrame then
      self._fashionFrame:Destroy()
    end
    self._fashionFrame = TableFrame.Create(self._clothesPanel, self, false, true)
    self._fashionFrame:ReloadAllCell()
    self:SetFashionFrameWidth()
    self:OnFashionCellClick(self._fishionData[1])
  else
    local cmd = LuaNetManager.CreateProtocol("protocol.item.cgetroleskin")
    cmd.roleId = role:GetId()
    cmd:Send()
    self._selectRole = role
  end
  self.roleListFrame:FireEvent("ChangedSelected", role)
end

function SignboardMainDialog:SetFashionsInfo()
  local allFashionData = self._selectRole:GetFashionData()
  self._fishionData = {}
  for i, v in ipairs(allFashionData.list) do
    if v.hasGotten then
      table.insert(self._fishionData, v)
    end
  end
  if self._fashionFrame then
    self._fashionFrame:Destroy()
  end
  self._fashionFrame = TableFrame.Create(self._clothesPanel, self, false, #self._fishionData > 2)
  self._fashionFrame:ReloadAllCell()
  self:SetFashionFrameWidth()
  self._fashionFrame:ReloadAllCell()
  self:OnFashionCellClick(self._fishionData[1])
end

function SignboardMainDialog:OnFashionCellClick(data)
  local cmd = LuaNetManager.CreateProtocol("protocol.user.cchoosebackground")
  if data.isAlinna then
    cmd.roleId = 0
    cmd.skin = 0
  else
    cmd.roleId = self._selectRole:GetId()
    cmd.skin = data.skinID
  end
  cmd:Send()
end

function SignboardMainDialog:SetFashionFrameWidth()
  local delta = #self._fishionData * self._fashionFrame:GetLogicCell(1)._size
  delta = math.min(delta, self._fashionFrame:GetLogicCell(1)._size * 2.5)
  local x, y = self._clothesPanel:GetDeltaSize()
  self._clothesPanel:SetDeltaSize(delta + 25, y)
end

function SignboardMainDialog:SignRefresh()
  local data = NekoData.BehaviorManager.BM_Welfare:GetTotalLoginInfo()
  self._signedNum = data.signedNum
  self._accDayList = data.accumulatedDayList
  self._totleSignDay = NekoData.BehaviorManager.BM_Welfare:GetTotleSignDay()
  local str = TextManager.GetText(CStringRes:GetRecorder(1500).msgTextID)
  str = string.gsub(str, "%$parameter1%$", self._totleSignDay)
  self._sign_time:SetText(str)
  self._accItemList = {}
  for i, d in ipairs(data.accumulatedAwardList) do
    table.insert(self._accItemList, d.id)
    local item = Item.Create(d.id)
    if item:GetItemAttr() then
      self._active_box[i].img:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
      self._active_box[i].getImg:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
    end
    self._active_box[i].num:SetText(d.num)
    self._active_box[i].getNum:SetText(d.num)
  end
  self._accIndex = data.accumulatedIndex
  self:SetAccumulatedLine(self._signedNum, self._accIndex)
end

function SignboardMainDialog:SetAccumulatedLine(signDayNum, index)
  self._signedNum = signDayNum
  for i = 1, 7 do
    if signDayNum >= self._accDayList[i] then
      self._active_box[i].select:SetActive(false)
      self._active_box[i].checkMark:SetActive(true)
      if self._active_box[i].effect_handler then
        self._active_box[i].effect:ReleaseEffect(self._active_box[i].effect_handler)
        self._active_box[i].effect_handler = nil
      end
    else
      self._active_box[i].select:SetActive(false)
      self._active_box[i].checkMark:SetActive(false)
    end
  end
end

function SignboardMainDialog:OnAccumulateClicked(index)
  local width, height = self._active_box[index].panel:GetRectSize()
  local tipsdialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsdialog then
    tipsdialog:Init({
      item = Item.Create(self._accItemList[index])
    })
    tipsdialog:SetTipsPosition(width, height, self._active_box[index].panel:GetLocalPointInUiRootPanel())
  end
end

function SignboardMainDialog:OnEffectEnd()
  local protocol = LuaNetManager.CreateProtocol("protocol.login.ctotalsignaward")
  if protocol then
    protocol:Send()
  else
    LogError("ActiveLoginRewardDialog", "there is no protocol ctotalsignaward can be used")
  end
end

function SignboardMainDialog:OnAccumulatedSignResult(notification)
  self._receive = true
  if notification.userInfo.result == 1 then
    NekoData.DataManager.DM_Welfare:SetTotleSignState(true)
    self._accIndex = NekoData.BehaviorManager.BM_Welfare:GetAccumulatedIndex()
    self:SetAccumulatedLine(self._signedNum, self._accIndex)
  else
  end
end

function SignboardMainDialog:NumberOfCell(frame)
  if frame == self._itemFrame then
    return #self._itemList
  elseif frame == self.roleListFrame then
    return #self._listByConditions
  elseif frame == self._fashionFrame then
    return #self._fishionData
  else
    return self._heartEffectNum
  end
end

function SignboardMainDialog:CellAtIndex(frame, index)
  if frame == self._itemFrame then
    return "handbook.favour.givegiftitemcell"
  elseif frame == self.roleListFrame then
    return "signboard.signboardcharcell"
  elseif frame == self._fashionFrame then
    return "signboard.signboardcharfashioncell"
  else
    return "handbook.favour.givegiftheartcell"
  end
end

function SignboardMainDialog:DataAtIndex(frame, index)
  if frame == self._itemFrame then
    return {
      data = self._itemList[index],
      index = index
    }
  elseif frame == self.roleListFrame then
    return self._listByConditions[index]
  elseif frame == self._fashionFrame then
    return self._fishionData[index]
  end
end

return SignboardMainDialog
