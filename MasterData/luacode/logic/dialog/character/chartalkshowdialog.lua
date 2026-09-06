local CSkin = BeanManager.GetTableByName("role.cskin")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CSoundLines = BeanManager.GetTableByName("sound.csoundlines")
local CSoundLines_skin = BeanManager.GetTableByNameWithLanguage("sound.csoundlines_skin")
local CSoundAnimations = BeanManager.GetTableByName("sound.clive2dmotion")
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local CEmotion = BeanManager.GetTableByName("npc.cemotion")
local CharTalkShowDialog = class("CharTalkShowDialog", Dialog)
CharTalkShowDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharTalkShowDialog.AssetName = "CharTalkShow"
local SHOWTALKTYPE = {Evolve = 1, Break = 2}
local MillisecondToSecond = 1000

function CharTalkShowDialog:Ctor(...)
  CharTalkShowDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._effectHandler = nil
  self._L2DHandler = nil
  self._role = nil
  self._type = nil
  self._end = false
  self._showSuccessData = nil
  self._endPos = {}
  self._tweenPos = {}
end

function CharTalkShowDialog:OnCreate()
  self._rolePanel = self:GetChild("Role")
  self._live2D = self:GetChild("Role/Live2D")
  self._photo = self:GetChild("Role/Photo")
  self._effect = self:GetChild("Effect")
  self._effect:Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
  self._linesText = self:GetChild("Back/Text")
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._linesText:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._linesText:GetPosition()
  self._initialAnchorMinX, self._initialOffsetMinX = self._linesText:GetXPosition()
  self._textMaxWidth, self._height = self._linesText:GetRectSize()
  local _ = 0
  _, self._oneline = self._linesText:GetPreferredSize()
  self._skipBtn = self:GetChild("SkipBtn")
  self._skipBtn:Subscribe_PointerClickEvent(self.Skip, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function CharTalkShowDialog:OnDestroy()
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  if self._L2DHandler then
    self._live2D:Release(self._L2DHandler)
    self._L2DHandler = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
  if self._showSuccessData.gainSkin == nil or self._showSuccessData.gainSkin == 0 then
    local roleInfoDialog = DialogManager.GetDialog("character.newcharacterinfodialog")
    if roleInfoDialog then
      roleInfoDialog:GetRootWindow():SetLocalScale(1, 1, 1)
    end
  end
end

function CharTalkShowDialog:SetData(data)
  local roleInfoDialog = DialogManager.GetDialog("character.newcharacterinfodialog")
  if roleInfoDialog then
    roleInfoDialog:GetRootWindow():SetLocalScale(0, 0, 0)
  end
  self._role = data.role
  self._type = data.type
  self._showSuccessData = data.showSuccessData
  local fashionId = self._role:GetDefaultFashion()
  local fashionData
  if 0 < fashionId then
    fashionData = CSkin:GetRecorder(fashionId)
  end
  self:SetLive2D(self._role, fashionData)
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(data.effect))
  self._linesText:SetActive(false)
  self._linesText:SetText("")
end

function CharTalkShowDialog:SetLive2D(role, fashionData)
  if not role and not fashionData then
    return
  end
  local record = role:GetShapeLive2DRecord()
  if fashionData then
    local shapeId = fashionData.shapeID
    record = CNpcShapeTable:GetRecorder(shapeId)
  end
  self._rolePanel:SetAnimatorTrigger("loadReady")
  if self._L2DHandler then
    self._live2D:Release(self._L2DHandler)
    self._L2DHandler = nil
  end
  local offset = tonumber(CVarConfig:GetRecorder(53).Value)
  local x, y = self._rolePanel:GetAnchoredPosition()
  self._endPos.X = x
  self._endPos.Y = y
  self._tweenPos.X = x + offset
  self._tweenPos.Y = y
  self._rolePanel:SetAnchoredPosition(x + offset, y)
  if Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DPrefabName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName ~= "" then
    self._photo:SetActive(false)
    self._L2DHandler = self._live2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
  else
    self._photo:SetActive(true)
    self._photo:SetSprite(role:GetShapeLiHuiImageRecord().assetBundle, role:GetShapeLiHuiImageRecord().assetName)
    local scale = role:GetPhotoScale()
    self._photo:SetLocalScale(scale, scale, scale)
    local photoPos = role:GetPhotoPosition()
    self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
  end
end

function CharTalkShowDialog:OnEffectEnd()
  if self._effectHandler then
    self._effectHandler = nil
  end
  local linesTextID, animationID, soundLinesRecord
  if self._role:CanPlayVoice() then
    local fashionId = self._role:GetDefaultFashion()
    if 0 < fashionId then
      soundLinesRecord = CSoundLines_skin:GetRecorder(fashionId)
    end
    soundLinesRecord = soundLinesRecord or CSoundLines:GetRecorder(self._role:GetId())
  end
  if self._type == SHOWTALKTYPE.Evolve then
    if soundLinesRecord then
      self._voiceId = NekoData.BehaviorManager.BM_Voice:Play(self._role:GetId(), NekoData.BehaviorManager.BM_Voice.VoiceType.RareUp, nil)
      linesTextID = soundLinesRecord.RareUp
    end
    animationID = CSoundAnimations:GetRecorder(self._role:GetId()).RareUp
  elseif self._type == SHOWTALKTYPE.Break then
    if soundLinesRecord then
      self._voiceId = NekoData.BehaviorManager.BM_Voice:Play(self._role:GetId(), NekoData.BehaviorManager.BM_Voice.VoiceType.LimitUp, nil)
      linesTextID = soundLinesRecord.LimitUp
    end
    animationID = CSoundAnimations:GetRecorder(self._role:GetId()).LimitUp
  end
  self:SetLinesAndAnimation(linesTextID, animationID)
end

function CharTalkShowDialog:SetLinesAndAnimation(linesTextID, animationID)
  if self._L2DHandler then
    local recorder = CEmotion:GetRecorder(animationID)
    if recorder then
      self._live2D:PlayLive2DAnimation(recorder.Name, self._L2DHandler)
    else
      LogErrorFormat("CharTalkShowDialog", "No AnimationName Width ID %s", tostring(animationID))
    end
  end
  self._end = true
  if not linesTextID then
    return
  end
  self._currentLinesTextID = linesTextID
  local initString = TextManager.GetText(linesTextID)
  local chars = stringutils.split2table(initString)
  local fontsize = self._linesText:GetFontSize()
  local count = #chars
  local text_size_x = count * fontsize
  if text_size_x < self._textMaxWidth then
    self._linesText:SetSize(self._text_size_x, text_size_x, self._text_size_y, self._text_size_offset_y)
    self._linesText:SetPosition(self._text_pos_x, -text_size_x / 2, self._text_pos_y, self._text_pos_offset_y)
  else
    self._linesText:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
    self._linesText:SetText(initString)
    local _, textheight = self._linesText:GetPreferredSize()
    local line = math.ceil((textheight - self._height) / self._oneline)
    local delta = line * fontsize
    self._linesText:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._linesText:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
    self._linesText:SetText("")
  end
  self._linesText:SetActive(true)
  local deltTime = CVarConfig:GetRecorder(52).Value
  deltTime = tonumber(deltTime) / MillisecondToSecond
  local index = 0
  if self._backTxtTimer then
    GameTimer.RemoveTask(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  self._backTxtTimer = GameTimer.AddTask(0, deltTime, function()
    index = index + 1
    if index > #chars then
      GameTimer.RemoveTask(self._backTxtTimer)
      self._backTxtTimer = nil
      return
    end
    self._linesText:SetText(table.concat(chars, "", 1, index))
  end, nil, true)
end

function CharTalkShowDialog:OnClick()
  if self._end then
    self:ShowResult()
  end
end

function CharTalkShowDialog:Skip()
  if self._voiceId then
    NekoData.BehaviorManager.BM_Voice:StopVoice(self._voiceId)
  end
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  self:ShowResult()
end

function CharTalkShowDialog:ShowResult()
  local dialogPath
  if self._type == SHOWTALKTYPE.Evolve then
    dialogPath = "character.newcharevolvesuccessdialog"
  elseif self._type == SHOWTALKTYPE.Break then
    dialogPath = "character.newcharbreaksuccessdialog"
  end
  DialogManager.CreateSingletonDialog(dialogPath):SetData(self._showSuccessData)
  self._tween = Tween.new(0.5, self._tweenPos, self._endPos, "linear")
  self._running = true
  self._linesText:SetActive(false)
end

function CharTalkShowDialog:OnUpdate(notification)
  if self._running then
    self._tween:update(notification.userInfo.deltaTime)
    self._rolePanel:SetAnchoredPosition(self._endPos.X, self._endPos.Y)
  end
end

return CharTalkShowDialog
