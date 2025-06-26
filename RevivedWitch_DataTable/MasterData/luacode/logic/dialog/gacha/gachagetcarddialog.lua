-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gachagetcarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MaterialStaticFunctions = ((CS.PixelNeko).Lua).MaterialStaticFunctions
local GameObjectHelper = ((CS.PixelNeko).Common).GameObjectHelper
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local CItemTable = (BeanManager.GetTableByName)("item.citemattr")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CSoundLines = (BeanManager.GetTableByName)("sound.csoundlines")
local CardInfoTypeEnum = (LuaNetManager.GetBeanDef)("protocol.card.cardinfo")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CCardGetItem = (BeanManager.GetTableByName)("item.ccardgetitem")
local CardPool = (BeanManager.GetTableByName)("item.ccardpool")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
local CSoundAnimations = (BeanManager.GetTableByName)("sound.clive2dmotion")
local CEmotion = (BeanManager.GetTableByName)("npc.cemotion")
local GachaGetCardDialog = class("GachaGetCardDialog", Dialog)
GachaGetCardDialog.AssetBundleName = "ui/layouts.gacha"
GachaGetCardDialog.AssetName = "GachaGetCard"
local resolveItemNum = 2
local MillisecondToSecond = 1000
GachaGetCardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaGetCardDialog
  ((GachaGetCardDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._cardList = {}
  self._handler = 0
  self._tag = false
  self._viewVisibe = true
  self._tenDrawGuide = false
  self._effects = nil
  self._itemList = {}
end

GachaGetCardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV, CRoleItemTable, CItemTable
  self._photo = self:GetChild("Role/Photo")
  self._live2d = self:GetChild("Role/Live2D")
  self._ui = self:GetChild("UI")
  self._title = self:GetChild("UI/ShortInfo/ShortName")
  self._name = self:GetChild("UI/ShortInfo/Name")
  self._rank = self:GetChild("UI/Rank")
  self._rankSubimg = self:GetChild("UI/Rank/RankSubimg")
  self._job = self:GetChild("UI/Job")
  self._jobTxt = self:GetChild("UI/JobTxt")
  self._skipBtn = self:GetChild("UI/SkipBtn")
  self._new = self:GetChild("UI/GetNew")
  self._repeatCharPanel = self:GetChild("UI/Same")
  self._repeatCharPanel_title = self:GetChild("UI/Same/Txt")
  self._repeatCharPanel_itemsPanel = self:GetChild("UI/Same/Frame")
  self._share = self:GetChild("UI/ShareBtn")
  self._shareAward = {icon = self:GetChild("UI/ShareBtn/Item"), num = self:GetChild("UI/ShareBtn/Num"), back = self:GetChild("UI/ShareBtn/TextBack"), txt = self:GetChild("UI/ShareBtn/Text")}
  self._qrcode = self:GetChild("UI/Code")
  self._logo = self:GetChild("UI/Logo")
  self._elementImg = self:GetChild("UI/Element")
  self._itemsFrame = (TableFrame.Create)(self._repeatCharPanel_itemsPanel, self, false, false)
  self._effect = self:GetChild("Effect")
  self._linesText = self:GetChild("UI/Back/Text")
  self._text_size_x = (self._linesText):GetSize()
  self._text_pos_x = (self._linesText):GetPosition()
  self._initialAnchorMinX = (self._linesText):GetXPosition()
  self._textMaxWidth = (self._linesText):GetRectSize()
  local _ = 0
  _ = (self._linesText):GetPreferredSize()
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMouseClick, self)
  ;
  (self._skipBtn):Subscribe_PointerClickEvent(self.OnSkipBtnClick, self)
  ;
  (self:GetRootWindow()):Subscribe_StateEnterEvent(self.OnAnimationEnter, self)
  ;
  (self._share):Subscribe_PointerClickEvent(self.OnShareClick, self)
  self._cRoleItemTable = {}
  for _,id in ipairs(CRoleItemTable:GetAllIds()) do
    (table.insert)(self._cRoleItemTable, CRoleItemTable:GetRecorder(id))
  end
  self._cItemTable = {}
  for _,id in ipairs(CItemTable:GetAllIds()) do
    (table.insert)(self._cItemTable, CItemTable:GetRecorder(id))
  end
  self:SetEffect()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RevertCanShare, Common.n_ShareSingleDialogClosed, nil)
end

GachaGetCardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV, GameObjectHelper
  (self._itemsFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._otherWayGet then
    (LuaAudioManager.StopBGM)(231)
  end
  if self._backTxtTimer then
    (GameTimer.RemoveTask)(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._effects then
    for i = 0, (self._effects).Length - 1 do
      local effect = (self._effects)[i]
      ;
      (GameObjectHelper.DestroyObject)(effect)
    end
    self._effects = nil
  end
  if self._shareTimer then
    (GameTimer.RemoveTask)(self._shareTimer)
    self._shareTimer = nil
  end
  local gachaMovieDialog = (DialogManager.GetDialog)("gacha.gachamoviedialog")
  if gachaMovieDialog then
    gachaMovieDialog:VideoFadeOut()
  end
end

GachaGetCardDialog.RevertCanShare = function(self)
  -- function num : 0_3
  self._canShare = true
end

GachaGetCardDialog.SetTenDrawGuide = function(self)
  -- function num : 0_4
  self._tenDrawGuide = true
end

GachaGetCardDialog.SetOtherWayGetCard = function(self)
  -- function num : 0_5
  self._otherWayGet = true
end

GachaGetCardDialog.SetEffect = function(self)
  -- function num : 0_6 , upvalues : MaterialStaticFunctions
  self._effects = (MaterialStaticFunctions.CopyAndUseMaterialsInChildren)((self._effect)._uiObject, true)
  if self._effects ~= nil then
    for i = 0, (self._effects).Length - 1 do
      local effect = (self._effects)[i]
      effect:SetFloat("_ZTest", 8)
    end
  end
end

GachaGetCardDialog.SetData = function(self, cardList, otherItemsFromMail)
  -- function num : 0_7 , upvalues : _ENV, Item
  local dialog = (DialogManager.GetDialog)("gacha.gachamaindialog")
  if dialog then
    dialog:Refresh()
  end
  self._list = cardList
  for i,v in ipairs(cardList) do
    (table.insert)(self._cardList, v)
  end
  if #self._cardList >= 1 and (self._cardList)[1] then
    self:Refresh((self._cardList)[1], true)
  end
  self._otherItemsFromMail = nil
  if otherItemsFromMail and #otherItemsFromMail > 0 then
    self._otherItemsFromMail = otherItemsFromMail
  end
  if #cardList ~= 2 then
    local rarityId = (self._role):GetRarityId()
    ;
    (self._share):SetActive(not ((NekoData.BehaviorManager).BM_Gacha):IsCanShare() or rarityId > 2)
    local recorder = ((BeanManager.GetTableByName)("sharesystem.csharereward")):GetRecorder(1)
    local id = tonumber((recorder.itemID)[1])
    local num = tonumber((recorder.itemNum)[1])
    local item = (Item.Create)(id)
    local img = item:GetIcon()
    ;
    ((self._shareAward).icon):SetSprite(img.assetBundle, img.assetName)
    ;
    ((self._shareAward).num):SetText(num)
  else
    (self._share):SetActive(false)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

GachaGetCardDialog.Refresh = function(self, card, isFirst)
  -- function num : 0_8 , upvalues : _ENV, CardInfoTypeEnum, Role, CCardGetItem, Item
  while (self._itemList)[#self._itemList] do
    (table.remove)(self._itemList, #self._itemList)
  end
  do
    if not isFirst then
      local gachaMovieDialog = (DialogManager.GetDialog)("gacha.gachamoviedialog")
      if gachaMovieDialog then
        gachaMovieDialog:PlayEnd()
      end
    end
    ;
    (self._linesText):SetActive(false)
    ;
    (self._linesText):SetText("")
    self._tag = false
    local repeatCard = false
    -- DECOMPILER ERROR at PC47: Unhandled construct in 'MakeBoolean' P1

    if not self._tenDrawGuide and (card.cardtype ~= CardInfoTypeEnum.ITEM) or card.cardtype == CardInfoTypeEnum.ROLE then
      self._role = (Role.Create)(card.cardId)
      if not self._role then
        LogErrorFormat("GachaGetCardDialog", "role id %s received from server is wrong", card.cardId)
      end
    end
    self._role = (Role.Create)(card.cardId)
    if not self._role then
      LogErrorFormat("GachaGetCardDialog", "role id %s received from server is wrong", card.cardId)
    end
    self:RefreshShare()
    if card.isNew == 1 then
      repeatCard = false
      ;
      (self._new):SetActive(true)
    else
      repeatCard = true
      ;
      (self._new):SetActive(false)
    end
    if self._handler and self._handler ~= 0 then
      (self._live2d):Release(self._handler)
      self._handler = 0
    end
    local cardGetItemRecord = nil
    if self._role then
      local record = (self._role):GetShapeLive2DRecord()
      ;
      (self._photo):SetActive(true)
      ;
      (self._photo):SetSprite(((self._role):GetShapeLiHuiImageRecord()).assetBundle, ((self._role):GetShapeLiHuiImageRecord()).assetName)
      local scale = (self._role):GetPhotoScale()
      ;
      (self._photo):SetLocalScale(scale, scale, scale)
      local photoPos = (self._role):GetPhotoPosition()
      ;
      (self._photo):SetAnchoredPosition(photoPos[1], photoPos[2])
      local rarityId = (self._role):GetRarityId()
      if rarityId == 1 then
        (self:GetRootWindow()):PlayAnimation("R")
      else
        if rarityId == 2 then
          (self:GetRootWindow()):PlayAnimation("SR")
        else
          if rarityId == 3 then
            (self:GetRootWindow()):PlayAnimation("SSR")
          else
            if rarityId == 4 then
              (self:GetRootWindow()):PlayAnimation("UR")
            else
              if rarityId == 5 then
                (self:GetRootWindow()):PlayAnimation("UR")
              end
            end
          end
        end
      end
      ;
      (self._name):SetText((self._role):GetRoleName())
      ;
      (self._title):SetText((self._role):GetTitle())
      ;
      (self._rank):SetSprite(((self._role):GetBigRarityImageRecord()).assetBundle, ((self._role):GetBigRarityImageRecord()).assetName)
      ;
      (self._rankSubimg):SetSprite(((self._role):GetBigRarityImageRecord()).assetBundle, ((self._role):GetBigRarityImageRecord()).assetName)
      ;
      (self._job):SetSprite(((self._role):GetVocationImgDrawRecord()).assetBundle, ((self._role):GetVocationImgDrawRecord()).assetName)
      ;
      (self._jobTxt):SetText((self._role):GetVocationName())
      ;
      (self._elementImg):SetSprite(((self._role):GetElementImageRecord()).assetBundle, ((self._role):GetElementImageRecord()).assetName)
      cardGetItemRecord = CCardGetItem:GetRecorder(rarityId)
    end
    do
      ;
      (self._repeatCharPanel):SetActive(true)
      self._showRepeat = true
      if repeatCard then
        (self._repeatCharPanel_title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1428))
        if not self._otherWayGet then
          (table.insert)(self._itemList, {itemId = cardGetItemRecord.item2, itemNum = cardGetItemRecord.num2})
        end
        local roleId = card.cardId
        local itemId = nil
        local isLeader = false
        if roleId == 1 then
          isLeader = true
        end
        if isLeader then
          (self._repeatCharPanel):SetActive(false)
          self._showRepeat = false
        else
          for _,v in ipairs(self._cRoleItemTable) do
            if v.roleid == roleId then
              itemId = v.id
              break
            end
          end
          do
            if itemId then
              local roleItem = (Item.Create)(itemId)
              local resolveItemIdList = roleItem:GetResolveItemId()
              local resolveItemNumList = roleItem:GetResolveItemNum()
              for i,itemId in ipairs(resolveItemIdList) do
                if itemId ~= 0 then
                  (table.insert)(self._itemList, {itemId = itemId, itemNum = resolveItemNumList[i]})
                end
              end
            else
              do
                do
                  LogErrorFormat("GachaGetCardDialog", "role ID %s doesnt have item ID in croleitem", roleId)
                  if not self._otherWayGet then
                    (self._repeatCharPanel_title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1427))
                    ;
                    (table.insert)(self._itemList, {itemId = cardGetItemRecord.item1, itemNum = cardGetItemRecord.num1})
                  else
                    ;
                    (self._repeatCharPanel):SetActive(false)
                    self._showRepeat = false
                  end
                  self._repeatCard = repeatCard
                  ;
                  (self._itemsFrame):ReloadAllCell()
                end
              end
            end
          end
        end
      end
    end
  end
end

GachaGetCardDialog.RefreshShare = function(self, state)
  -- function num : 0_9 , upvalues : _ENV
  if not state then
    state = ((NekoData.BehaviorManager).BM_Gacha):GetShareState()
  end
  local rarityId = (self._role):GetRarityId()
  ;
  (self._share):SetActive(not ((NekoData.BehaviorManager).BM_Gacha):IsCanShare() or rarityId > 2)
  if state == 1 then
    ((self._shareAward).icon):SetActive(true)
    ;
    ((self._shareAward).num):SetActive(true)
    ;
    ((self._shareAward).back):SetActive(true)
    ;
    ((self._shareAward).txt):SetActive(true)
  else
    ((self._shareAward).icon):SetActive(false)
    ;
    ((self._shareAward).num):SetActive(false)
    ;
    ((self._shareAward).back):SetActive(false)
    ;
    ((self._shareAward).txt):SetActive(false)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

GachaGetCardDialog.OnMouseClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if self._tag and self._viewVisibe then
    if #self._cardList > 1 then
      (table.remove)(self._cardList, 1)
      self:Refresh((self._cardList)[1], false)
    else
      local dialog = (DialogManager.CreateSingletonDialog)("gacha.gacharesultdialog")
      if self._tenDrawGuide then
        dialog:SetTenDrawGuide()
      end
      dialog:SetOtherWayGetCard(self._otherWayGet)
      dialog:SetData(self._list, self._otherItemsFromMail)
      self:Destroy()
    end
  else
    do
      do
        if not self._tag then
          local rarityId = (self._role):GetRarityId()
          if rarityId == 1 then
            (self:GetRootWindow()):PlayAnimation("GachaR")
          else
            if rarityId == 2 then
              (self:GetRootWindow()):PlayAnimation("GachaSR")
            else
              if rarityId == 3 then
                (self:GetRootWindow()):PlayAnimation("GachaSSR")
              else
                if rarityId == 4 then
                  (self:GetRootWindow()):PlayAnimation("GachaUR")
                else
                  if rarityId == 5 then
                    (self:GetRootWindow()):PlayAnimation("GachaUR")
                  end
                end
              end
            end
          end
        end
        self._canShare = false
      end
    end
  end
end

GachaGetCardDialog.OnViewBtnClick = function(self)
  -- function num : 0_11
  self._viewVisibe = false
  ;
  (self._ui):SetActive(false)
end

GachaGetCardDialog.OnSkipBtnClick = function(self)
  -- function num : 0_12 , upvalues : _ENV, CardPool, Role
  if #self._cardList > 1 then
    (table.remove)(self._cardList, 1)
    local cardPoolID = ((NekoData.BehaviorManager).BM_Game):GetCurrentCardPoolID()
    if cardPoolID then
      local cardPoolRecorder = CardPool:GetRecorder(cardPoolID)
      if #cardPoolRecorder.skipRare > 0 then
        local skipRaritys = (string.split)(cardPoolRecorder.skipRare, ",")
        do
          if tonumber(skipRaritys[1]) == -1 then
            local dialog = (DialogManager.CreateSingletonDialog)("gacha.gacharesultdialog")
            if self._tenDrawGuide then
              dialog:SetTenDrawGuide()
            end
            dialog:SetOtherWayGetCard(self._otherWayGet)
            dialog:SetData(self._list, self._otherItemsFromMail)
            self:Destroy()
            return 
          end
          local max = #self._cardList
          do
            do
              local index = 1
              while 1 do
                if index <= max then
                  local isNew = ((self._cardList)[index]).isNew
                  if isNew ~= 1 then
                    local role = (Role.Create)(((self._cardList)[index]).cardId)
                    local rarityId = role:GetRarityId()
                    for i,v in ipairs(skipRaritys) do
                      if rarityId == tonumber(v) then
                        (table.remove)(self._cardList, index)
                        index = index - 1
                        max = max - 1
                        break
                      end
                    end
                  end
                  do
                    do
                      index = index + 1
                      -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                end
              end
              ;
              ((NekoData.DataManager).DM_Game):ClearCurrentCardPoolID()
              if #self._cardList > 1 then
                self:Refresh((self._cardList)[1], false)
                self._canShare = true
              else
                if #self._cardList == 1 then
                  self:Refresh((self._cardList)[1], false)
                  ;
                  (table.remove)(self._cardList, 1)
                  self._canShare = true
                else
                  local dialog = (DialogManager.CreateSingletonDialog)("gacha.gacharesultdialog")
                  if self._tenDrawGuide then
                    dialog:SetTenDrawGuide()
                  end
                  dialog:SetOtherWayGetCard(self._otherWayGet)
                  dialog:SetData(self._list, self._otherItemsFromMail)
                  self:Destroy()
                end
              end
              do
                local dialog = (DialogManager.CreateSingletonDialog)("gacha.gacharesultdialog")
                if self._tenDrawGuide then
                  dialog:SetTenDrawGuide()
                end
                dialog:SetOtherWayGetCard(self._otherWayGet)
                dialog:SetData(self._list, self._otherItemsFromMail)
                self:Destroy()
              end
            end
          end
        end
      end
    end
  end
end

local set_visibility = function(self, visible)
  -- function num : 0_13 , upvalues : _ENV
  (self._qrcode):SetActive(visible)
  ;
  (self._logo):SetActive(visible)
  ;
  (self._share):SetActive(not visible)
  ;
  (self._skipBtn):SetActive(not visible)
  ;
  (self._linesText):SetActive(not visible)
  ;
  ((DialogManager.GetGroup)("ClickEffect")):SetObjectActive(not visible)
  ;
  (self._repeatCharPanel):SetActive((not visible and self._showRepeat))
  ;
  (self._new):SetActive((not visible and not self._repeatCard))
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

GachaGetCardDialog.OnShareClick = function(self)
  -- function num : 0_14 , upvalues : set_visibility, _ENV, cimagepath
  if not self._canShare then
    return 
  end
  self._canShare = false
  set_visibility(self, true)
  local qrCodeID = ((NekoData.BehaviorManager).BM_Gacha):GetShareQRCodeID()
  if qrCodeID == -1 then
    (self._qrcode):SetActive(false)
  else
    local img = cimagepath:GetRecorder(qrCodeID)
    ;
    (self._qrcode):SetSprite(img.assetBundle, img.assetName)
  end
  do
    ;
    (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
    self._runner = ((self:GetRootWindow()):GetUIObject()):AddComponent(typeof(((CS.PixelNeko).Tools).ScreenShot))
    ;
    (self._runner):StartCoroutine((xLuaUtil.cs_generator)(function()
    -- function num : 0_14_0 , upvalues : _ENV, self, set_visibility
    (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(0.25))
    local plat = (((CS.PixelNeko).LuaManager).GetSystemType)()
    local systemType = require("protocols.bean.protocol.common.systemtype")
    local getTextureCount = 0
    if plat == systemType.IOS then
      local path = ((((CS.PixelNeko).Tools).ScreenShotHelper).CaptureToFile)((os.time)() .. ".png")
      do
        self._shareTimer = (GameTimer.AddTask)(0.2, 0.1, function()
      -- function num : 0_14_0_0 , upvalues : getTextureCount, _ENV, path, set_visibility, self
      getTextureCount = getTextureCount + 1
      local texture = ((((CS.PixelNeko).Tools).ExternalImageLoaderHelper).GetTexture)(path)
      if texture or DataCommon.GetTextureCount <= getTextureCount then
        set_visibility(self, false)
        LogInfoFormat("GachaGetCardDialog", "--- getTextureCount = %s, texture = %s, GetTextureCount = %s ---", getTextureCount, texture, DataCommon.GetTextureCount)
        ;
        ((DialogManager.CreateSingletonDialog)("gacha.share.gachasharesingledialog")):SetData(texture)
        if self._shareTimer then
          (GameTimer.RemoveTask)(self._shareTimer)
          self._shareTimer = nil
        end
        self._canShare = true
      end
    end
, nil, true)
      end
    else
      do
        local texture = (((CS.UnityEngine).ScreenCapture).CaptureScreenshotAsTexture)()
        self._shareTimer = (GameTimer.AddTask)(0.2, 0, function()
      -- function num : 0_14_0_1 , upvalues : set_visibility, self, _ENV, texture
      set_visibility(self, false)
      ;
      ((DialogManager.CreateSingletonDialog)("gacha.share.gachasharesingledialog")):SetData(texture)
      self._shareTimer = nil
      self._canShare = true
    end
)
      end
    end
  end
))
  end
end

GachaGetCardDialog.OnAnimationEnter = function(self, handle, statename, normalizedTime)
  -- function num : 0_15 , upvalues : Role, _ENV, CSoundLines, CSoundAnimations, CEmotion, CVarConfig, MillisecondToSecond
  if #self._cardList > 0 and (statename == "GachaSSR" or statename == "GachaSR" or statename == "GachaR" or statename == "GachaUR" or statename == "GachaEX") then
    self._canShare = true
    self._tag = true
    local roleID = ((self._cardList)[1]).cardId
    local role = (Role.Create)(roleID)
    local index = #self._cardList
    if index ~= self._index then
      if role:CanPlayVoice() then
        self._voiceId = ((NekoData.BehaviorManager).BM_Voice):Play(roleID, (((NekoData.BehaviorManager).BM_Voice).VoiceType).Summory, nil)
      end
      self._index = index
    end
    local record = CSoundLines:GetRecorder(roleID)
    if record then
      local animationId = (CSoundAnimations:GetRecorder(roleID)).Summory
      do
        do
          if self._handler then
            local recorder = CEmotion:GetRecorder(animationId)
            if recorder then
              (self._live2d):PlayLive2DAnimation(recorder.Name, self._handler)
            else
              LogErrorFormat("GachaGetCardDialog", "No AnimationName Width ID %s", tostring(animationId))
            end
          end
          if not role:CanPlayVoice() then
            return 
          end
          local initString = (TextManager.GetText)(record.Summory)
          local chars = (stringutils.split2table)(initString)
          local fontsize = (self._linesText):GetFontSize()
          local count = #chars
          local text_size_x = count * fontsize
          if text_size_x < self._textMaxWidth then
            (self._linesText):SetWidth(0, text_size_x)
            ;
            (self._linesText):SetXPosition(self._initialAnchorMinX, -text_size_x / 2)
            ;
            (self._linesText):SetText("")
          else
            ;
            (self._linesText):SetText(initString)
            local _, textheight = (self._linesText):GetPreferredSize()
            local line = (math.ceil)((textheight - self._height) / self._oneline)
            local delta = line * fontsize
            ;
            (self._linesText):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
            ;
            (self._linesText):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
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
    -- function num : 0_15_0 , upvalues : index, chars, _ENV, self
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
    end
  end
end

GachaGetCardDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_16
  return #self._itemList
end

GachaGetCardDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_17
  return "gacha.gachagetcarditemcell"
end

GachaGetCardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_18
  return (self._itemList)[index]
end

return GachaGetCardDialog

