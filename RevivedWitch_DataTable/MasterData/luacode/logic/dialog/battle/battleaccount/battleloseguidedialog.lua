-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battleloseguidedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Live2DLoadBehaviour = (((CS.PixelNeko).P1).Live2D).Live2DLoaderBehaviour
local cFailDialog = (BeanManager.GetTableByName)("dialog.cquestenddialogconfig")
local cFailDialogLib = (BeanManager.GetTableByName)("dialog.cquestenddialoglib")
local cNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local cImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BattleLoseGuideDialog = class("BattleLoseGuideDialog", Dialog)
BattleLoseGuideDialog.AssetBundleName = "ui/layouts.dramadialog"
BattleLoseGuideDialog.AssetName = "DramaMain"
BattleLoseGuideDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleLoseGuideDialog
  ((BattleLoseGuideDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._timer = nil
  self._showTimer = nil
  self._leftLive2DID = 0
  self._hasTriggerGuide = false
  self._hasTriggerResourceGuide = false
end

BattleLoseGuideDialog.OnCreate = function(self)
  -- function num : 0_1
  self._skipBtn = self:GetChild("UI/SkipBtn")
  ;
  (self._skipBtn):SetActive(false)
  self._backBtn = self:GetChild("UI/BackBtn")
  ;
  (self._backBtn):SetActive(false)
  self._nextBtn = self:GetChild("UI/Back/NextBtn")
  ;
  (self._nextBtn):SetActive(false)
  self._nextTxt = self:GetChild("UI/Back/NextTxt")
  ;
  (self._nextTxt):SetActive(false)
  self._selection = self:GetChild("UI/Selection")
  ;
  (self._selection):SetActive(false)
  self._uiBoard = self:GetChild("UI")
  self._modelNameBoard = {self:GetChild("UI/NameL"), self:GetChild("UI/NameR")}
  self._name = {self:GetChild("UI/NameL/Text"), self:GetChild("UI/NameR/Text")}
  self._model = {self:GetChild("PhotoL/Image"), self:GetChild("PhotoR/Image")}
  self._modelLive2D = {self:GetChild("PhotoL/Live2D"), self:GetChild("PhotoR/Live2D")}
  self._showPanel = {self:GetChild("PhotoL"), self:GetChild("PhotoR")}
  self._conversation = self:GetChild("UI/Back/Text")
  self._panelNext = self:GetChild("UI/Panel")
  self._animator = ((self._rootWindow):GetUIObject()):GetComponent("Animator")
  ;
  (self._panelNext):Subscribe_PointerClickEvent(self.OnPanelNextClicked, self)
end

BattleLoseGuideDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
  if self._showTimer then
    (GameTimer.RemoveTask)(self._showTimer)
    self._showTimer = nil
  end
end

BattleLoseGuideDialog.Show = function(self, npcChatId)
  -- function num : 0_3 , upvalues : cFailDialogLib
  local start = (cFailDialogLib:GetRecorder(npcChatId)).startDialogID
  self:ToNextChat(start)
end

local local_func = function(self, guide)
  -- function num : 0_4 , upvalues : _ENV
  self._speekover = true
  if self._showTimer then
    (GameTimer.RemoveTask)(self._showTimer)
    self._showTimer = nil
  end
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
  self._timer = (GameTimer.AddTask)(guide.SkipTime, 0, function()
    -- function num : 0_4_0 , upvalues : guide, self
    if guide.Next_id == 0 then
      self:Destroy()
    else
      self:ToNextChat(guide.Next_id)
    end
  end
, nil)
end

BattleLoseGuideDialog.ToNextChat = function(self, dialogId)
  -- function num : 0_5 , upvalues : cFailDialog, _ENV, local_func, cNPCShape, cImagePathTable
  local guide = cFailDialog:GetRecorder(dialogId)
  if not guide then
    LogError("BattleLoseGuideDialog", "wrong dialog id")
    return 
  end
  self._curDialogRecorder = guide
  local count = 0
  local targetStr = ""
  if guide.time ~= 0 then
    local initString = (TextManager.GetText)(guide.contentTextID)
    do
      if self._showTimer then
        (GameTimer.RemoveTask)(self._showTimer)
        self._showTimer = nil
      end
      self._showTimer = (GameTimer.AddTask)(0, tonumber(guide.time) / 3, function()
    -- function num : 0_5_0 , upvalues : count, targetStr, _ENV, initString, local_func, self, guide
    count = count + 1
    targetStr = targetStr .. (string.sub)(initString, count, count)
    if (string.len)(initString) < count then
      local_func(self, guide)
    else
      self._speekover = false
      ;
      (self._conversation):SetText(targetStr)
    end
  end
, nil)
    end
  else
    do
      ;
      (self._conversation):SetText((TextManager.GetText)(guide.contentTextID))
      if guide.Voice_id ~= 0 then
        (LuaAudioManager.PlayBGM)(guide.Voice_id)
      end
      local _, uiBoardY = (self._uiBoard):GetRectSize()
      local imageRecord = nil
      ;
      ((self._modelNameBoard)[2]):SetActive(false)
      ;
      ((self._model)[2]):SetActive(false)
      ;
      ((self._modelLive2D)[2]):SetActive(false)
      ;
      ((self._name)[1]):SetText((TextManager.GetText)(guide.NPC_NameTextID))
      local shape = cNPCShape:GetRecorder(guide.NPC_ShapeID)
      local iconID = shape.lihuiID
      imageRecord = cImagePathTable:GetRecorder(iconID)
      ;
      ((self._modelNameBoard)[1]):SetActive(true)
      ;
      ((self._model)[1]):SetActive(true)
      ;
      ((self._modelLive2D)[1]):SetActive(true)
      if (Live2DManager.CanUse)() and shape.live2DPrefabName ~= "" and shape.live2DPrefabName ~= "" then
        ((self._model)[1]):SetEnable(false)
        ;
        ((self._modelLive2D)[1]):SetActive(true)
        if self._leftLive2DID ~= guide.NPCShapeID then
          if self._live2d then
            ((self._modelLive2D)[1]):Release(self._live2d)
            self._live2d = nil
          end
          self._live2d = ((self._modelLive2D)[1]):AddLive2D(shape.live2DAssetBundleName, shape.live2DPrefabName, shape.live2DScale)
          self._leftLive2DID = guide.NPCShapeID
        end
      else
        ;
        ((self._model)[1]):SetEnable(true)
        if imageRecord then
          ((self._model)[1]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          ((self._model)[1]):SetLocalScale(shape.photoScale, shape.photoScale, shape.photoScale)
        end
        ;
        ((self._model)[1]):SetAnchoredPosition((shape.photoLocation)[1], (shape.photoLocation)[2])
      end
    end
  end
end

BattleLoseGuideDialog.OnPanelNextClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV, local_func
  if self._speekover then
    if (self._curDialogRecorder).Next_id == 0 then
      self:Destroy()
    else
      if self._timer then
        (GameTimer.RemoveTask)(self._timer)
        self._timer = nil
      end
      self:ToNextChat((self._curDialogRecorder).Next_id)
    end
  else
    local content = (TextManager.GetText)((self._curDialogRecorder).contentTextID)
    ;
    (self._conversation):SetText(content)
    local_func(self, self._curDialogRecorder)
  end
end

BattleLoseGuideDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:OnPanelNextClicked()
end

return BattleLoseGuideDialog

