-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/chartalkshowdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSoundLines = (BeanManager.GetTableByName)("sound.csoundlines")
local CSoundLines_skin = (BeanManager.GetTableByNameWithLanguage)("sound.csoundlines_skin")
local CSoundAnimations = (BeanManager.GetTableByName)("sound.clive2dmotion")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CEmotion = (BeanManager.GetTableByName)("npc.cemotion")
local CharTalkShowDialog = class("CharTalkShowDialog", Dialog)
CharTalkShowDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharTalkShowDialog.AssetName = "CharTalkShow"
local SHOWTALKTYPE = {Evolve = 1, Break = 2}
local MillisecondToSecond = 1000
CharTalkShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharTalkShowDialog
  ((CharTalkShowDialog.super).Ctor)(self, ...)
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

CharTalkShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._rolePanel = self:GetChild("Role")
  self._live2D = self:GetChild("Role/Live2D")
  self._photo = self:GetChild("Role/Photo")
  self._effect = self:GetChild("Effect")
  ;
  (self._effect):Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
  self._linesText = self:GetChild("Back/Text")
  self._text_size_x = (self._linesText):GetSize()
  self._text_pos_x = (self._linesText):GetPosition()
  self._initialAnchorMinX = (self._linesText):GetXPosition()
  self._textMaxWidth = (self._linesText):GetRectSize()
  local _ = 0
  _ = (self._linesText):GetPreferredSize()
  self._skipBtn = self:GetChild("SkipBtn")
  ;
  (self._skipBtn):Subscribe_PointerClickEvent(self.Skip, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

CharTalkShowDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  if self._L2DHandler then
    (self._live2D):Release(self._L2DHandler)
    self._L2DHandler = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if (self._showSuccessData).gainSkin == nil or (self._showSuccessData).gainSkin == 0 then
    local roleInfoDialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
    if roleInfoDialog then
      (roleInfoDialog:GetRootWindow()):SetLocalScale(1, 1, 1)
    end
  end
end

CharTalkShowDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CSkin
  local roleInfoDialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
  if roleInfoDialog then
    (roleInfoDialog:GetRootWindow()):SetLocalScale(0, 0, 0)
  end
  self._role = data.role
  self._type = data.type
  self._showSuccessData = data.showSuccessData
  local fashionId = ((self._role):GetDefaultFashion())
  local fashionData = nil
  if fashionId > 0 then
    fashionData = CSkin:GetRecorder(fashionId)
  end
  self:SetLive2D(self._role, fashionData)
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(data.effect))
  ;
  (self._linesText):SetActive(false)
  ;
  (self._linesText):SetText("")
end

CharTalkShowDialog.SetLive2D = function(self, role, fashionData)
  -- function num : 0_4 , upvalues : CNpcShapeTable, _ENV, CVarConfig
  if not role and not fashionData then
    return 
  end
  local record = role:GetShapeLive2DRecord()
  do
    if fashionData then
      local shapeId = fashionData.shapeID
      record = CNpcShapeTable:GetRecorder(shapeId)
    end
    ;
    (self._rolePanel):SetAnimatorTrigger("loadReady")
    if self._L2DHandler then
      (self._live2D):Release(self._L2DHandler)
      self._L2DHandler = nil
    end
    local offset = tonumber((CVarConfig:GetRecorder(53)).Value)
    local x, y = (self._rolePanel):GetAnchoredPosition()
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._endPos).X = x
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._endPos).Y = y
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._tweenPos).X = x + offset
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._tweenPos).Y = y
    ;
    (self._rolePanel):SetAnchoredPosition(x + offset, y)
    if (Live2DManager.CanUse)() and record.live2DAssetBundleName and record.live2DPrefabName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName ~= "" then
      (self._photo):SetActive(false)
      self._L2DHandler = (self._live2D):AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
    else
      ;
      (self._photo):SetActive(true)
      ;
      (self._photo):SetSprite((role:GetShapeLiHuiImageRecord()).assetBundle, (role:GetShapeLiHuiImageRecord()).assetName)
      local scale = role:GetPhotoScale()
      ;
      (self._photo):SetLocalScale(scale, scale, scale)
      local photoPos = role:GetPhotoPosition()
      ;
      (self._photo):SetAnchoredPosition(photoPos[1], photoPos[2])
    end
  end
end

CharTalkShowDialog.OnEffectEnd = function(self)
  -- function num : 0_5 , upvalues : CSoundLines_skin, CSoundLines, SHOWTALKTYPE, _ENV, CSoundAnimations
  if self._effectHandler then
    self._effectHandler = nil
  end
  local linesTextID, animationID, soundLinesRecord = nil, nil, nil
  do
    if (self._role):CanPlayVoice() then
      local fashionId = (self._role):GetDefaultFashion()
      if fashionId > 0 then
        soundLinesRecord = CSoundLines_skin:GetRecorder(fashionId)
      end
      if not soundLinesRecord then
        soundLinesRecord = CSoundLines:GetRecorder((self._role):GetId())
      end
    end
    if self._type == SHOWTALKTYPE.Evolve then
      if soundLinesRecord then
        self._voiceId = ((NekoData.BehaviorManager).BM_Voice):Play((self._role):GetId(), (((NekoData.BehaviorManager).BM_Voice).VoiceType).RareUp, nil)
        linesTextID = soundLinesRecord.RareUp
      end
      animationID = (CSoundAnimations:GetRecorder((self._role):GetId())).RareUp
    else
      if self._type == SHOWTALKTYPE.Break then
        if soundLinesRecord then
          self._voiceId = ((NekoData.BehaviorManager).BM_Voice):Play((self._role):GetId(), (((NekoData.BehaviorManager).BM_Voice).VoiceType).LimitUp, nil)
          linesTextID = soundLinesRecord.LimitUp
        end
        animationID = (CSoundAnimations:GetRecorder((self._role):GetId())).LimitUp
      end
    end
    self:SetLinesAndAnimation(linesTextID, animationID)
  end
end

CharTalkShowDialog.SetLinesAndAnimation = function(self, linesTextID, animationID)
  -- function num : 0_6 , upvalues : CEmotion, _ENV, CVarConfig, MillisecondToSecond
  do
    if self._L2DHandler then
      local recorder = CEmotion:GetRecorder(animationID)
      if recorder then
        (self._live2D):PlayLive2DAnimation(recorder.Name, self._L2DHandler)
      else
        LogErrorFormat("CharTalkShowDialog", "No AnimationName Width ID %s", tostring(animationID))
      end
    end
    self._end = true
    if not linesTextID then
      return 
    end
    self._currentLinesTextID = linesTextID
    local initString = (TextManager.GetText)(linesTextID)
    local chars = (stringutils.split2table)(initString)
    local fontsize = (self._linesText):GetFontSize()
    local count = #chars
    local text_size_x = count * fontsize
    if text_size_x < self._textMaxWidth then
      (self._linesText):SetSize(self._text_size_x, text_size_x, self._text_size_y, self._text_size_offset_y)
      ;
      (self._linesText):SetPosition(self._text_pos_x, -text_size_x / 2, self._text_pos_y, self._text_pos_offset_y)
    else
      ;
      (self._linesText):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
      ;
      (self._linesText):SetText(initString)
      local _, textheight = (self._linesText):GetPreferredSize()
      local line = (math.ceil)((textheight - self._height) / self._oneline)
      local delta = line * fontsize
      ;
      (self._linesText):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
      ;
      (self._linesText):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
      ;
      (self._linesText):SetText("")
    end
    do
      ;
      (self._linesText):SetActive(true)
      local deltTime = (CVarConfig:GetRecorder(52)).Value
      deltTime = tonumber(deltTime) / MillisecondToSecond
      local index = 0
      if self._backTxtTimer then
        (GameTimer.RemoveTask)(self._backTxtTimer)
        self._backTxtTimer = nil
      end
      self._backTxtTimer = (GameTimer.AddTask)(0, deltTime, function()
    -- function num : 0_6_0 , upvalues : index, chars, _ENV, self
    index = index + 1
    if #chars < index then
      (GameTimer.RemoveTask)(self._backTxtTimer)
      self._backTxtTimer = nil
      return 
    end
    ;
    (self._linesText):SetText((table.concat)(chars, "", 1, index))
  end
, nil, true)
    end
  end
end

CharTalkShowDialog.OnClick = function(self)
  -- function num : 0_7
  if self._end then
    self:ShowResult()
  end
end

CharTalkShowDialog.Skip = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._voiceId then
    ((NekoData.BehaviorManager).BM_Voice):StopVoice(self._voiceId)
  end
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  self:ShowResult()
end

CharTalkShowDialog.ShowResult = function(self)
  -- function num : 0_9 , upvalues : SHOWTALKTYPE, _ENV
  local dialogPath = nil
  if self._type == SHOWTALKTYPE.Evolve then
    dialogPath = "character.newcharevolvesuccessdialog"
  else
    if self._type == SHOWTALKTYPE.Break then
      dialogPath = "character.newcharbreaksuccessdialog"
    end
  end
  ;
  ((DialogManager.CreateSingletonDialog)(dialogPath)):SetData(self._showSuccessData)
  self._tween = (Tween.new)(0.5, self._tweenPos, self._endPos, "linear")
  self._running = true
  ;
  (self._linesText):SetActive(false)
end

CharTalkShowDialog.OnUpdate = function(self, notification)
  -- function num : 0_10
  if self._running then
    (self._tween):update((notification.userInfo).deltaTime)
    ;
    (self._rolePanel):SetAnchoredPosition((self._endPos).X, (self._endPos).Y)
  end
end

return CharTalkShowDialog

