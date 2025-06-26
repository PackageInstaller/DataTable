-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newcharevolvesuccessdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillShow_Soul = (BeanManager.GetTableByName)("skill.cskillshow_soul")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSoundLines = (BeanManager.GetTableByName)("sound.csoundlines")
local CSoundLines_skin = (BeanManager.GetTableByNameWithLanguage)("sound.csoundlines_skin")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CSoundAnimations = (BeanManager.GetTableByName)("sound.clive2dmotion")
local CEmotion = (BeanManager.GetTableByName)("npc.cemotion")
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local NewCharEvolveSuccessDialog = class("NewCharEvolveSuccessDialog", Dialog)
NewCharEvolveSuccessDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
NewCharEvolveSuccessDialog.AssetName = "CharEvolveSuccess"
local SHOWTALKTYPE = {Evolve = 1, Break = 2}
local MillisecondToSecond = 1000
NewCharEvolveSuccessDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewCharEvolveSuccessDialog
  ((NewCharEvolveSuccessDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._effectHandler = nil
  self._L2DHandler = nil
  self._role = nil
  self._type = nil
  self._state = -1
  self._showSuccessData = nil
  self._endPos = {}
  self._tweenPos = {}
end

NewCharEvolveSuccessDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : AnimatorStaticFunctions, _ENV
  self._preBreakPoints = self:GetChild("RightInfo/BreakPoint/BreakPoint1")
  self._nextBreakPoints = self:GetChild("RightInfo/BreakPoint/BreakPoint2")
  self._changeProNameTxt = self:GetChild("RightInfo/Property/Name")
  self._preProTxt = self:GetChild("RightInfo/Property/Num")
  self._nextPorTxt = self:GetChild("RightInfo/Property/Num2")
  self._animator = (AnimatorStaticFunctions.Get)((self:GetRootWindow())._uiObject)
  self._rolePanel = self:GetChild("Role")
  self._live2D = self:GetChild("Role/Live2D")
  self._photo = self:GetChild("Role/Photo")
  self._effect = self:GetChild("RightInfo/CharTalkShow/Effect")
  ;
  (self._effect):Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
  self._linesText = self:GetChild("RightInfo/CharTalkShow/Back/Text")
  self._text_size_x = (self._linesText):GetSize()
  self._text_pos_x = (self._linesText):GetPosition()
  self._initialAnchorMinX = (self._linesText):GetXPosition()
  self._textMaxWidth = (self._linesText):GetRectSize()
  local _ = 0
  _ = (self._linesText):GetPreferredSize()
  self._skipBtn = self:GetChild("RightInfo/CharTalkShow/SkipBtn")
  ;
  (self._skipBtn):Subscribe_PointerClickEvent(self.Skip, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

NewCharEvolveSuccessDialog.OnDestroy = function(self)
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
end

NewCharEvolveSuccessDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CSkin, _ENV
  self._role = data.role
  self._type = data.type
  self._showSuccessData = data.showSuccessData
  local fashionId = ((self._role):GetDefaultFashion())
  -- DECOMPILER ERROR at PC9: Overwrote pending register: R3 in 'AssignReg'

  local fashionData = .end
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

NewCharEvolveSuccessDialog.SetLive2D = function(self, role, fashionData)
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
    if self._L2DHandler then
      (self._live2D):Release(self._L2DHandler)
      self._L2DHandler = nil
    end
    local offset = tonumber((CVarConfig:GetRecorder(53)).Value)
    local x, y = (self._rolePanel):GetAnchoredPosition()
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._endPos).X = x
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._endPos).Y = y
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._tweenPos).X = x + offset
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._tweenPos).Y = y
    ;
    (self._rolePanel):SetAnchoredPosition(x + offset, y)
    if role:IsFashionLive2D() and (Live2DManager.CanUse)() and record.live2DAssetBundleName and record.live2DPrefabName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName ~= "" then
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

NewCharEvolveSuccessDialog.OnEffectEnd = function(self)
  -- function num : 0_5 , upvalues : CSoundLines_skin, CSoundLines, _ENV, CSoundAnimations
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
    if soundLinesRecord then
      self._voiceId = ((NekoData.BehaviorManager).BM_Voice):Play((self._role):GetId(), (((NekoData.BehaviorManager).BM_Voice).VoiceType).RareUp, nil)
      linesTextID = soundLinesRecord.RareUp
    end
    animationID = (CSoundAnimations:GetRecorder((self._role):GetId())).RareUp
    self:SetLines(linesTextID, animationID)
  end
end

NewCharEvolveSuccessDialog.SetLines = function(self, linesTextID, animationID)
  -- function num : 0_6 , upvalues : CEmotion, _ENV, CVarConfig, MillisecondToSecond
  do
    if self._L2DHandler then
      local recorder = CEmotion:GetRecorder(animationID)
      if recorder then
        (self._live2D):PlayLive2DAnimation(recorder.Name, self._L2DHandler)
      else
        LogErrorFormat("NewCharEvolveSuccessDialog", "No AnimationName Width ID %s", tostring(animationID))
      end
    end
    self._state = 0
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

NewCharEvolveSuccessDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  if self._state == 0 then
    self:ShowResult()
  else
    if self._state == 1 then
      self:Destroy()
    end
  end
end

NewCharEvolveSuccessDialog.Skip = function(self)
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

NewCharEvolveSuccessDialog.ShowResult = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local str = ""
  for i = 1, (self._showSuccessData).maxLv do
    if i <= (self._showSuccessData).curLv then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  ;
  (self._preBreakPoints):SetText(str)
  str = ""
  for i = 1, (self._showSuccessData).maxLv do
    if i <= (self._showSuccessData).curLv + 1 then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  ;
  (self._nextBreakPoints):SetText(str)
  ;
  (self._changeProNameTxt):SetText((self._showSuccessData).changeProName)
  ;
  (self._preProTxt):SetText((self._showSuccessData).addProOriginal)
  ;
  (self._nextPorTxt):SetText((self._showSuccessData).newProValue)
  self._tween = (Tween.new)(0.5, self._tweenPos, self._endPos, "linear")
  self._running = true
  ;
  (self._linesText):SetActive(false)
  ;
  (self._animator):SetInteger("talkOver", 1)
  self._state = 1
end

NewCharEvolveSuccessDialog.OnUpdate = function(self, notification)
  -- function num : 0_10
  if self._running then
    (self._tween):update((notification.userInfo).deltaTime)
    ;
    (self._rolePanel):SetAnchoredPosition((self._endPos).X, (self._endPos).Y)
  end
end

return NewCharEvolveSuccessDialog

