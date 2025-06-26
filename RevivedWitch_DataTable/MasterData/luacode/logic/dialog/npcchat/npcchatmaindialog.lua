-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/npcchat/npcchatmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NpcChat = require("logic.manager.experimental.types.npcchat")
local TableFrame = require("framework.ui.frame.table.tableframe")
local cNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local cImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local cEmotion = (BeanManager.GetTableByName)("npc.cemotion")
local cRoleConfig = (BeanManager.GetTableByName)("role.roleconfig")
local NpcChatMainDialog = class("NpcChatMainDialog", Dialog)
NpcChatMainDialog.AssetBundleName = "ui/layouts.dramadialog"
NpcChatMainDialog.AssetName = "DramaMain"
NpcChatMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NpcChatMainDialog
  ((NpcChatMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._chatRecord = nil
  self._timer = nil
  self._isTimerCanClick = false
  self._initialChatID = nil
  self._leftLive2DID = 0
  self._rightLive2DID = 0
  self._leftLive2DEmotion = 0
  self._rightLive2DEmotion = 0
  self._jumpValue = nil
end

NpcChatMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._background = self:GetChild("Black")
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
  self._backText = self:GetChild("UI/Back/Text")
  self._nextBtn = self:GetChild("UI/Back/NextBtn")
  self._nextTxt = self:GetChild("UI/Back/NextTxt")
  ;
  (self._nextBtn):SetActive(false)
  ;
  (self._nextTxt):SetActive(false)
  self._backLogBtn = self:GetChild("UI/BackBtn")
  self._effectWnd = self:GetChild("UI/Effects")
  self._skipBtn = self:GetChild("UI/SkipBtn")
  self._nextWnd = self:GetChild("UI/Panel")
  self._selectionWnd = self:GetChild("UI/Selection")
  self._talk_pos_x = (self._selectionWnd):GetPosition()
  _ = (self._selectionWnd):GetHeight()
  ;
  (self._backLogBtn):Subscribe_PointerClickEvent(self.OnBackLogBtnClicked, R4_PC87)
  -- DECOMPILER ERROR at PC104: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._skipBtn):Subscribe_PointerClickEvent(self.OnSkipBtnClicked, R4_PC87)
  -- DECOMPILER ERROR at PC109: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._nextWnd):Subscribe_PointerClickEvent(self.OnNextBtnClicked, R4_PC87)
end

NpcChatMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
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
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_NPCChatEnd, self, self._initialChatID)
  if self._jumpValue then
    ((NekoData.BehaviorManager).BM_NPCChat):CheckNormalOption(self._jumpValue)
  end
end

local SetPosition = function(image, pos)
  -- function num : 0_3 , upvalues : _ENV
  local x = tonumber(pos[1])
  local y = tonumber(pos[2])
  image:SetAnchoredPosition(x, y)
end

local SetScale = function(image, scale)
  -- function num : 0_4
  if scale ~= 0 then
    image:SetLocalScale(scale, scale, scale)
  end
end

NpcChatMainDialog.SetData = function(self, id, isBaseCharChat)
  -- function num : 0_5 , upvalues : _ENV, TableFrame, cNPCShape, cEmotion, cImagePathTable
  self._isBaseCharChat = isBaseCharChat
  if id == 161 then
    (self._background):SetActive(false)
  end
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
  if self._backTxtTimer then
    (GameTimer.RemoveTask)(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._frame then
    (self._frame):Destroy()
  end
  self._npcChatID = id
  self._initialChatID = self._initialChatID or id
  self._chatRecord = ((NekoData.BehaviorManager).BM_PlotConfig):GetPlotRecord(self._npcChatID, isBaseCharChat)
  local chatRecord = (self._chatRecord):GetNpcChatRecord()
  local audioId = (self._chatRecord):GetVoiceId()
  if audioId ~= 0 then
    (LuaAudioManager.PlayBGM)(audioId)
  end
  ;
  (self:GetChild("UI/Back")):SetActive(chatRecord.content ~= "")
  if (table.nums)(chatRecord.Choose) ~= 0 then
    self._frame = (TableFrame.Create)(self._selectionWnd, self, true, false, true)
    local itemFrameHeight = 166 * (table.nums)(chatRecord.Choose)
    ;
    (self._selectionWnd):SetHeight(0, itemFrameHeight)
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._selectionWnd):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y + (self._initHeight - itemFrameHeight) / 2)
  end
  local chattype = (self._chatRecord):GetChatType()
  do
    (self._leftModelNameBoard):SetActive(chattype == 1)
    ;
    (self._rightModelNameBoard):SetActive(chattype == 2)
    if chattype ~= (self._chatRecord).E_Narratage then
      local npcShape1 = (self._chatRecord):GetNpc1ShapeId()
      if npcShape1 > 0 then
        local npcShapeRecorder = cNPCShape:GetRecorder(npcShape1)
        if (Live2DManager.CanUse)() and npcShapeRecorder.live2DAssetBundleName ~= "" then
          (self._rightModel):SetActive(true)
          ;
          (self._rightModel):SetEnable(false)
          ;
          (self._rightModelName):SetText((self._chatRecord):GetNpcName1())
          ;
          (self._rightModelLive2D):SetActive(true)
          if self._rightLive2DID ~= npcShape1 then
            if self._live2d then
              (self._rightModelLive2D):Release(self._live2d)
              self._live2d = nil
            end
            self._live2d = (self._rightModelLive2D):AddLive2D(npcShapeRecorder.live2DAssetBundleName, npcShapeRecorder.live2DPrefabName, npcShapeRecorder.live2DScale)
            self._rightLive2DID = npcShape1
          end
          if (chatRecord.Emotion_id)[1] ~= 0 and self._rightLive2DEmotion ~= (chatRecord.Emotion_id)[1] then
            local emotionName = (cEmotion:GetRecorder((chatRecord.Emotion_id)[1])).Name
            ;
            (self._rightModelLive2D):PlayLive2DAnimation(emotionName, self._live2d)
            self._rightLive2DEmotion = (chatRecord.Emotion_id)[1]
          end
        else
          (self._rightModel):SetActive(true)
          ;
          (self._rightModelLive2D):SetActive(false)
          ;
          (self._rightModel):SetEnable(true)
          ;
          (self._rightModelName):SetText((self._chatRecord):GetNpcName1())
          local iconID = npcShapeRecorder.lihuiID
          local imageRecord = cImagePathTable:GetRecorder(iconID)
          if imageRecord then
            (self._rightModel):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            local scale = npcShapeRecorder.photoScale
            ;
            (self._rightModel):SetLocalScale(scale, scale, scale)
            ;
            (self._rightModel):SetAnchoredPosition((npcShapeRecorder.photoLocation)[1], (npcShapeRecorder.photoLocation)[2])
          end
        end
      else
        (self._rightModel):SetActive(false)
        ;
        (self._rightModelLive2D):SetActive(false)
      end
      local npcShape2 = (self._chatRecord):GetNpc2ShapeId()
      if npcShape2 > 0 then
        local npcShapeRecorder = cNPCShape:GetRecorder(npcShape2)
        if (Live2DManager.CanUse)() and npcShapeRecorder.live2DAssetBundleName ~= "" then
          (self._leftModel):SetActive(true)
          ;
          (self._leftModel):SetEnable(false)
          ;
          (self._leftModelLive2D):SetActive(true)
          if self._leftLive2DID ~= npcShape2 then
            if self._live2dLeft then
              (self._leftModelLive2D):Release(self._live2dLeft)
              self._live2dLeft = nil
            end
            self._live2dLeft = (self._leftModelLive2D):AddLive2D(npcShapeRecorder.live2DAssetBundleName, npcShapeRecorder.live2DPrefabName, npcShapeRecorder.live2DScale)
            self._leftLive2DID = (self._chatRecord):GetNpc2ShapeId()
          end
          if (chatRecord.Emotion_id)[2] ~= 0 and self._leftLive2DEmotion ~= (chatRecord.Emotion_id)[2] then
            local emotionName = (cEmotion:GetRecorder((chatRecord.Emotion_id)[2])).Name
            ;
            (self._leftModelLive2D):PlayLive2DAnimation(emotionName, self._live2dLeft)
            self._leftLive2DEmotion = (chatRecord.Emotion_id)[2]
          end
        else
          (self._leftModel):SetActive(true)
          ;
          (self._leftModelName):SetText((self._chatRecord):GetNpcName2())
          ;
          (self._leftModelLive2D):SetActive(false)
          local iconID = npcShapeRecorder.lihuiID
          local imageRecord = cImagePathTable:GetRecorder(iconID)
          if imageRecord then
            (self._leftModel):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            local scale = npcShapeRecorder.photoScale
            ;
            (self._leftModel):SetLocalScale(scale, scale, scale)
            ;
            (self._leftModel):SetAnchoredPosition((npcShapeRecorder.photoLocation)[1], (npcShapeRecorder.photoLocation)[2])
          end
        end
      else
        (self._leftModel):SetActive(false)
        ;
        (self._leftModelLive2D):SetActive(false)
      end
      if chattype ~= (self._chatRecord).E_Choice then
        local rightname = (self._chatRecord):GetNpcName1()
        ;
        (self._rightModelName):SetText(rightname)
        ;
        (self._rightModelNameBoard):SetActive(not rightname or rightname ~= "null")
        local leftname = (self._chatRecord):GetNpcName2()
        ;
        (self._leftModelName):SetText(leftname)
        ;
        (self._leftModelNameBoard):SetActive(not leftname or leftname ~= "null")
      else
        (self._rightModelNameBoard):SetActive(false)
        ;
        (self._leftModelNameBoard):SetActive(false)
      end
      if self._live2dLeft or self._live2d then
        local live2dcfg = ((self._chatRecord).GetLive2DGrayConfig)()
        local imagecfg = (((self._chatRecord).GetImageGrayConfig)())
        local npcShapeRecorder1 = nil
        if npcShape1 > 0 then
          npcShapeRecorder1 = cNPCShape:GetRecorder(npcShape1)
        end
        local scale1 = 1
        if npcShapeRecorder1 then
          scale1 = tonumber(npcShapeRecorder1.scaleDialog)
        end
        local npcShapeRecorder2 = nil
        if npcShape2 > 0 then
          npcShapeRecorder2 = cNPCShape:GetRecorder(npcShape2)
        end
        local scale2 = 1
        if npcShapeRecorder2 then
          scale2 = tonumber(npcShapeRecorder2.scaleDialog)
        end
        if chattype == (self._chatRecord).E_Left then
          if self._live2dLeft then
            (self._leftModelLive2D):SetColorTint(self._live2dLeft, 1, 1, 1, 1)
          else
            (self._leftModel):SetColor("white")
          end
          if self._live2d then
            (self._rightModelLive2D):SetColorTint(self._live2d, live2dcfg.r, live2dcfg.g, live2dcfg.b, live2dcfg.a)
          else
            (self._rightModel):SetColor(((CS.UnityEngine).Color)(imagecfg.r, imagecfg.g, imagecfg.b, imagecfg.a))
          end
        elseif chattype == (self._chatRecord).E_Right then
          if self._live2dLeft then
            (self._leftModelLive2D):SetColorTint(self._live2dLeft, live2dcfg.r, live2dcfg.g, live2dcfg.b, live2dcfg.a)
          else
            (self._leftModel):SetColor(((CS.UnityEngine).Color)(imagecfg.r, imagecfg.g, imagecfg.b, imagecfg.a))
          end
          if self._live2d then
            (self._rightModelLive2D):SetColorTint(self._live2d, 1, 1, 1, 1)
          else
            (self._rightModel):SetColor("white")
          end
        else
          if self._live2dLeft then
            (self._leftModelLive2D):SetColorTint(self._live2dLeft, 1, 1, 1, 1)
          else
            (self._leftModel):SetColor("white")
          end
          if self._live2d then
            (self._rightModelLive2D):SetColorTint(self._live2d, 1, 1, 1, 1)
          else
            (self._rightModel):SetColor("white")
          end
        end
      end
    else
      (self._leftModel):SetActive(false)
      ;
      (self._leftModelNameBoard):SetActive(false)
      ;
      (self._leftModelLive2D):SetActive(false)
      ;
      (self._rightModel):SetActive(false)
      ;
      (self._rightModelNameBoard):SetActive(false)
      ;
      (self._rightModelLive2D):SetActive(false)
    end
    if tonumber(chatRecord.time) and tonumber(chatRecord.time) ~= 0 then
      (self._nextBtn):SetActive(false)
      ;
      (self._nextTxt):SetActive(false)
      local initString = chatRecord.content
      local deltTime = tonumber(chatRecord.time) / 3
      local chars = (stringutils.split2table)(initString)
      local index = 0
      self._backTxtTimer = (GameTimer.AddTask)(0, deltTime, function()
    -- function num : 0_5_0 , upvalues : index, chars, self, initString, chatRecord, _ENV
    index = index + 1
    if #chars < index then
      (self._backText):SetText(initString)
      ;
      (self._nextBtn):SetActive(true)
      ;
      (self._nextTxt):SetActive(true)
      if chatRecord.SkipTime ~= 0 then
        self._timer = (GameTimer.AddTask)(chatRecord.SkipTime, 0, function()
      -- function num : 0_5_0_0 , upvalues : self
      self:ToNextChat()
    end
, nil)
      end
      ;
      (GameTimer.RemoveTask)(self._backTxtTimer)
      self._backTxtTimer = nil
    else
      ;
      (self._backText):SetText((table.concat)(chars, "", 1, index))
    end
  end
, nil)
    else
      if chatRecord.SkipTime ~= 0 then
        self._timer = (GameTimer.AddTask)(chatRecord.SkipTime, 0, function()
    -- function num : 0_5_1 , upvalues : self
    self:ToNextChat()
  end
, nil)
      end
      ;
      (self._backText):SetText(chatRecord.content)
      ;
      (self._nextBtn):SetActive(true)
      ;
      (self._nextTxt):SetActive(true)
    end
    ;
    (self._nextWnd):SetActive(chatRecord.click == 1)
    ;
    (self._skipBtn):SetActive(chatRecord.skip == 1)
    if chatRecord.backlog == "" then
      (self._backLogBtn):SetActive(not chatRecord.backlog)
      ;
      (self._backLogBtn):SetActive(false)
      if chatRecord.animation ~= "0" then
        self:PlayAnimation(chatRecord.animation)
      end
      ;
      (self._background):SetActive((self._chatRecord):ShouldShowBackground())
      -- DECOMPILER ERROR: 47 unprocessed JMP targets
    end
  end
end

NpcChatMainDialog.PlayAnimation = function(self, name)
  -- function num : 0_6
  (self:GetRootWindow()):PlayAnimation(name)
end

NpcChatMainDialog.OnBackLogBtnClicked = function(self, args)
  -- function num : 0_7 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("npcchat.npcchatbacklogdialog")
  dialog:SetData((self._chatRecord):GetNpcChatRecord())
end

NpcChatMainDialog.OnSkipBtnClicked = function(self, args)
  -- function num : 0_8
  local dest, should_finish = (self._chatRecord):GetSkipDestination()
  if should_finish then
    self:Destroy()
  else
    self:SetData(dest, self._isBaseCharChat)
  end
end

NpcChatMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:OnSkipBtnClicked()
end

NpcChatMainDialog.ToNextChat = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if not self._delayToNext then
    self._delayToNext = (GameTimer.AddTask)(0.2, -1, function(self)
    -- function num : 0_10_0 , upvalues : _ENV
    local chatInfo = (self._chatRecord):GetIdFromDialogID(((self._chatRecord):GetNpcChatRecord()).Next_id)
    if chatInfo then
      self:SetData(chatInfo.id, self._isBaseCharChat)
    else
      local nextChatTable = (self._chatRecord):GetCurrentChatTable()
      if (table.nums)(nextChatTable) > 1 then
        local currentIndex = ((self._chatRecord):GetNpcChatRecord()).index
        if nextChatTable[currentIndex + 1] then
          self:SetData((nextChatTable[currentIndex + 1]).id, self._isBaseCharChat)
        else
          self:Destroy()
        end
      else
        do
          do
            self:Destroy()
            if self._delayToNext then
              (GameTimer.RemoveTask)(self._delayToNext)
              self._delayToNext = nil
            end
          end
        end
      end
    end
  end
, self, true)
  end
end

NpcChatMainDialog.OnNextBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local record = (self._chatRecord):GetNpcChatRecord()
  if record.click == 0 then
    return 
  end
  if self._backTxtTimer then
    (self._backText):SetText(record.content)
    ;
    (self._nextBtn):SetActive(true)
    ;
    (self._nextTxt):SetActive(true)
    if record.SkipTime ~= 0 then
      self._timer = (GameTimer.AddTask)(record.SkipTime, 0, function()
    -- function num : 0_11_0 , upvalues : self
    self:ToNextChat()
  end
, nil)
    end
    ;
    (GameTimer.RemoveTask)(self._backTxtTimer)
    self._backTxtTimer = nil
  else
    self:ToNextChat()
  end
end

NpcChatMainDialog.OnCellClicked = function(self, id)
  -- function num : 0_12 , upvalues : _ENV
  local dialogid = (((self._chatRecord):GetNpcChatRecord()).choose_value)[id]
  if ((self._chatRecord):GetNpcChatRecord()).jump_value then
    self._jumpValue = (((self._chatRecord):GetNpcChatRecord()).jump_value)[id]
  end
  ;
  (self._frame):Destroy()
  if dialogid then
    local chatInfo = (self._chatRecord):GetIdFromDialogID(dialogid)
    self:SetData(chatInfo.id, self._isBaseCharChat)
  else
    do
      local nextChatTable = (self._chatRecord):GetCurrentChatTable()
      if (table.nums)(nextChatTable) > 1 then
        local currentIndex = ((self._chatRecord):GetNpcChatRecord()).index
        if nextChatTable[currentIndex + 1] then
          self:SetData((nextChatTable[currentIndex + 1]).id, self._isBaseCharChat)
        else
          self:Destroy()
        end
      else
        do
          self:Destroy()
        end
      end
    end
  end
end

NpcChatMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_13 , upvalues : _ENV
  return (table.nums)(((self._chatRecord):GetNpcChatRecord()).Choose)
end

NpcChatMainDialog.CellAtIndex = function(self, frame)
  -- function num : 0_14
  return "npcchat.npcchatselectcell"
end

NpcChatMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  local data = {}
  data[index] = {index = index}
  local record = (self._chatRecord):GetNpcChatRecord()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  if (record.Choose)[index] then
    (data[index]).chooseText = (record.Choose)[index]
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  if (record.choose_value)[index] then
    (data[index]).chooseValue = (record.choose_value)[index]
  end
  return data[index]
end

return NpcChatMainDialog

