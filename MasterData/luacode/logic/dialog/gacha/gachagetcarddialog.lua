local MaterialStaticFunctions = CS.PixelNeko.Lua.MaterialStaticFunctions
local GameObjectHelper = CS.PixelNeko.Common.GameObjectHelper
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CRoleItemTable = BeanManager.GetTableByName("item.croleitem")
local CItemTable = BeanManager.GetTableByName("item.citemattr")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CSoundLines = BeanManager.GetTableByName("sound.csoundlines")
local CardInfoTypeEnum = LuaNetManager.GetBeanDef("protocol.card.cardinfo")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local CCardGetItem = BeanManager.GetTableByName("item.ccardgetitem")
local CardPool = BeanManager.GetTableByName("item.ccardpool")
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")
local CSoundAnimations = BeanManager.GetTableByName("sound.clive2dmotion")
local CEmotion = BeanManager.GetTableByName("npc.cemotion")
local GachaGetCardDialog = class("GachaGetCardDialog", Dialog)
GachaGetCardDialog.AssetBundleName = "ui/layouts.gacha"
GachaGetCardDialog.AssetName = "GachaGetCard"
local resolveItemNum = 2
local MillisecondToSecond = 1000

function GachaGetCardDialog:Ctor(...)
  GachaGetCardDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._cardList = {}
  self._handler = 0
  self._tag = false
  self._viewVisibe = true
  self._tenDrawGuide = false
  self._effects = nil
  self._itemList = {}
end

function GachaGetCardDialog:OnCreate()
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
  self._share:SetActive(false)
  self._shareAward = {
    icon = self:GetChild("UI/ShareBtn/Item"),
    num = self:GetChild("UI/ShareBtn/Num"),
    back = self:GetChild("UI/ShareBtn/TextBack"),
    txt = self:GetChild("UI/ShareBtn/Text")
  }
  self._logo = self:GetChild("UI/Logo")
  self._elementImg = self:GetChild("UI/Element")
  self._itemsFrame = TableFrame.Create(self._repeatCharPanel_itemsPanel, self, false, false)
  self._effect = self:GetChild("Effect")
  self._linesText = self:GetChild("UI/Back/Text")
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._linesText:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._linesText:GetPosition()
  self._initialAnchorMinX, self._initialOffsetMinX = self._linesText:GetXPosition()
  self._textMaxWidth, self._height = self._linesText:GetRectSize()
  local _ = 0
  _, self._oneline = self._linesText:GetPreferredSize()
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnMouseClick, self)
  self._skipBtn:Subscribe_PointerClickEvent(self.OnSkipBtnClick, self)
  self:GetRootWindow():Subscribe_StateEnterEvent(self.OnAnimationEnter, self)
  self._share:Subscribe_PointerClickEvent(self.OnShareClick, self)
  self._cRoleItemTable = {}
  for _, id in ipairs(CRoleItemTable:GetAllIds()) do
    table.insert(self._cRoleItemTable, CRoleItemTable:GetRecorder(id))
  end
  self._cItemTable = {}
  for _, id in ipairs(CItemTable:GetAllIds()) do
    table.insert(self._cItemTable, CItemTable:GetRecorder(id))
  end
  self:SetEffect()
  LuaNotificationCenter.AddObserver(self, self.RevertCanShare, Common.n_ShareSingleDialogClosed, nil)
  LogInfoFormat("GachaGetCardDialog", "=====OnCreate")
end

function GachaGetCardDialog:OnDestroy()
  LogInfoFormat("GachaGetCardDialog", "=====OnDestroy")
  self._itemsFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._otherWayGet then
    LuaAudioManager.StopBGM(231)
  end
  if self._backTxtTimer then
    GameTimer.RemoveTask(self._backTxtTimer)
    self._backTxtTimer = nil
  end
  if self._effects then
    for i = 0, self._effects.Length - 1 do
      local effect = self._effects[i]
      GameObjectHelper.DestroyObject(effect)
    end
    self._effects = nil
  end
  if self._shareTimer then
    GameTimer.RemoveTask(self._shareTimer)
    self._shareTimer = nil
  end
  local gachaMovieDialog = DialogManager.GetDialog("gacha.gachamoviedialog")
  if gachaMovieDialog then
    gachaMovieDialog:VideoFadeOut()
  end
end

function GachaGetCardDialog:RevertCanShare()
  self._canShare = true
end

function GachaGetCardDialog:SetTenDrawGuide()
  self._tenDrawGuide = true
end

function GachaGetCardDialog:SetOtherWayGetCard()
  self._otherWayGet = true
end

function GachaGetCardDialog:SetEffect()
  self._effects = MaterialStaticFunctions.CopyAndUseMaterialsInChildren(self._effect._uiObject, true)
  if self._effects ~= nil then
    for i = 0, self._effects.Length - 1 do
      local effect = self._effects[i]
      effect:SetFloat("_ZTest", 8)
    end
  end
end

function GachaGetCardDialog:SetData(cardList, otherItemsFromMail)
  LogInfoFormat("GachaGetCardDialog", "=====SetData")
  local dialog = DialogManager.GetDialog("gacha.gachamaindialog")
  if dialog then
    dialog:Refresh()
  end
  self._list = cardList
  for i, v in ipairs(cardList) do
    table.insert(self._cardList, v)
  end
  if #self._cardList >= 1 and self._cardList[1] then
    self:Refresh(self._cardList[1], true)
  end
  self._otherItemsFromMail = nil
  if otherItemsFromMail and 0 < #otherItemsFromMail then
    self._otherItemsFromMail = otherItemsFromMail
  end
  if #cardList ~= 2 then
    local rarityId = self._role:GetRarityId()
    local recorder = BeanManager.GetTableByName("sharesystem.csharereward"):GetRecorder(1)
    local id = tonumber(recorder.itemID[1])
    local num = tonumber(recorder.itemNum[1])
    local item = Item.Create(id)
    local img = item:GetIcon()
    self._shareAward.icon:SetSprite(img.assetBundle, img.assetName)
    self._shareAward.num:SetText(num)
  else
  end
end

function GachaGetCardDialog:Refresh(card, isFirst)
  while self._itemList[#self._itemList] do
    table.remove(self._itemList, #self._itemList)
  end
  if not isFirst then
    local gachaMovieDialog = DialogManager.GetDialog("gacha.gachamoviedialog")
    if gachaMovieDialog then
      gachaMovieDialog:PlayEnd()
    end
  end
  self._linesText:SetActive(false)
  self._linesText:SetText("")
  self._tag = false
  local repeatCard = false
  if not self._tenDrawGuide then
    if card.cardtype == CardInfoTypeEnum.ITEM then
    end
    if card.cardtype == CardInfoTypeEnum.ROLE then
      self._role = Role.Create(card.cardId)
      if not self._role then
        LogErrorFormat("GachaGetCardDialog", "role id %s received from server is wrong", card.cardId)
      end
    end
  else
    self._role = Role.Create(card.cardId)
    if not self._role then
      LogErrorFormat("GachaGetCardDialog", "role id %s received from server is wrong", card.cardId)
    end
  end
  self:RefreshShare()
  if card.isNew == 1 then
    repeatCard = false
    self._new:SetActive(true)
  else
    repeatCard = true
    self._new:SetActive(false)
  end
  if self._handler and self._handler ~= 0 then
    self._live2d:Release(self._handler)
    self._handler = 0
  end
  local cardGetItemRecord
  if self._role then
    local record = self._role:GetShapeLive2DRecord()
    self._photo:SetActive(true)
    self._photo:SetSprite(self._role:GetShapeLiHuiImageRecord().assetBundle, self._role:GetShapeLiHuiImageRecord().assetName)
    local scale = self._role:GetPhotoScale()
    self._photo:SetLocalScale(scale, scale, scale)
    local photoPos = self._role:GetPhotoPosition()
    self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
    local rarityId = self._role:GetRarityId()
    if rarityId == 1 then
      self:GetRootWindow():PlayAnimation("R")
    elseif rarityId == 2 then
      self:GetRootWindow():PlayAnimation("SR")
    elseif rarityId == 3 then
      self:GetRootWindow():PlayAnimation("SSR")
    elseif rarityId == 4 then
      self:GetRootWindow():PlayAnimation("UR")
    elseif rarityId == 5 then
      self:GetRootWindow():PlayAnimation("UR")
    end
    self._name:SetText(self._role:GetRoleName())
    self._title:SetText(self._role:GetTitle())
    self._rank:SetSprite(self._role:GetBigRarityImageRecord().assetBundle, self._role:GetBigRarityImageRecord().assetName)
    self._rankSubimg:SetSprite(self._role:GetBigRarityImageRecord().assetBundle, self._role:GetBigRarityImageRecord().assetName)
    self._job:SetSprite(self._role:GetVocationImgDrawRecord().assetBundle, self._role:GetVocationImgDrawRecord().assetName)
    self._jobTxt:SetText(self._role:GetVocationName())
    self._elementImg:SetSprite(self._role:GetElementImageRecord().assetBundle, self._role:GetElementImageRecord().assetName)
    cardGetItemRecord = CCardGetItem:GetRecorder(rarityId)
  end
  self._repeatCharPanel:SetActive(true)
  self._showRepeat = true
  if repeatCard then
    self._repeatCharPanel_title:SetText(NekoData.BehaviorManager.BM_Message:GetString(1428))
    if not self._otherWayGet then
      table.insert(self._itemList, {
        itemId = cardGetItemRecord.item2,
        itemNum = cardGetItemRecord.num2
      })
    end
    local roleId = card.cardId
    local itemId
    local isLeader = false
    if roleId == 1 then
      isLeader = true
    end
    if isLeader then
      self._repeatCharPanel:SetActive(false)
      self._showRepeat = false
    else
      for _, v in ipairs(self._cRoleItemTable) do
        if v.roleid == roleId then
          itemId = v.id
          break
        end
      end
      if itemId then
        local roleItem = Item.Create(itemId)
        local resolveItemIdList = roleItem:GetResolveItemId()
        local resolveItemNumList = roleItem:GetResolveItemNum()
        for i, itemId in ipairs(resolveItemIdList) do
          if itemId ~= 0 then
            table.insert(self._itemList, {
              itemId = itemId,
              itemNum = resolveItemNumList[i]
            })
          end
        end
      else
        LogErrorFormat("GachaGetCardDialog", "role ID %s doesnt have item ID in croleitem", roleId)
      end
    end
  elseif not self._otherWayGet then
    self._repeatCharPanel_title:SetText(NekoData.BehaviorManager.BM_Message:GetString(1427))
    table.insert(self._itemList, {
      itemId = cardGetItemRecord.item1,
      itemNum = cardGetItemRecord.num1
    })
  else
    self._repeatCharPanel:SetActive(false)
    self._showRepeat = false
  end
  self._repeatCard = repeatCard
  self._itemsFrame:ReloadAllCell()
end

function GachaGetCardDialog:RefreshShare(state)
  state = state or NekoData.BehaviorManager.BM_Gacha:GetShareState()
  local rarityId = self._role:GetRarityId()
  if state == 1 then
    self._shareAward.icon:SetActive(false)
    self._shareAward.num:SetActive(false)
    self._shareAward.back:SetActive(false)
    self._shareAward.txt:SetActive(false)
  else
    self._shareAward.icon:SetActive(false)
    self._shareAward.num:SetActive(false)
    self._shareAward.back:SetActive(false)
    self._shareAward.txt:SetActive(false)
  end
end

function GachaGetCardDialog:OnMouseClick()
  if self._tag and self._viewVisibe then
    if #self._cardList > 1 then
      table.remove(self._cardList, 1)
      self:Refresh(self._cardList[1], false)
    else
      local dialog = DialogManager.CreateSingletonDialog("gacha.gacharesultdialog")
      if self._tenDrawGuide then
        dialog:SetTenDrawGuide()
      end
      dialog:SetOtherWayGetCard(self._otherWayGet)
      dialog:SetData(self._list, self._otherItemsFromMail)
      self:Destroy()
    end
  elseif not self._tag then
    local rarityId = self._role:GetRarityId()
    if rarityId == 1 then
      self:GetRootWindow():PlayAnimation("GachaR")
    elseif rarityId == 2 then
      self:GetRootWindow():PlayAnimation("GachaSR")
    elseif rarityId == 3 then
      self:GetRootWindow():PlayAnimation("GachaSSR")
    elseif rarityId == 4 then
      self:GetRootWindow():PlayAnimation("GachaUR")
    elseif rarityId == 5 then
      self:GetRootWindow():PlayAnimation("GachaUR")
    end
  end
  self._canShare = false
end

function GachaGetCardDialog:OnViewBtnClick()
  self._viewVisibe = false
  self._ui:SetActive(false)
end

function GachaGetCardDialog:OnSkipBtnClick()
  if #self._cardList > 1 then
    table.remove(self._cardList, 1)
    local cardPoolID = NekoData.BehaviorManager.BM_Game:GetCurrentCardPoolID()
    if cardPoolID then
      local cardPoolRecorder = CardPool:GetRecorder(cardPoolID)
      if #cardPoolRecorder.skipRare > 0 then
        local skipRaritys = string.split(cardPoolRecorder.skipRare, ",")
        if tonumber(skipRaritys[1]) == -1 then
          local dialog = DialogManager.CreateSingletonDialog("gacha.gacharesultdialog")
          if self._tenDrawGuide then
            dialog:SetTenDrawGuide()
          end
          dialog:SetOtherWayGetCard(self._otherWayGet)
          dialog:SetData(self._list, self._otherItemsFromMail)
          self:Destroy()
          return
        end
        local max = #self._cardList
        local index = 1
        while max >= index do
          local isNew = self._cardList[index].isNew
          if isNew ~= 1 then
            local role = Role.Create(self._cardList[index].cardId)
            local rarityId = role:GetRarityId()
            for i, v in ipairs(skipRaritys) do
              if rarityId == tonumber(v) then
                table.remove(self._cardList, index)
                index = index - 1
                max = max - 1
                break
              end
            end
          end
          index = index + 1
        end
      end
      NekoData.DataManager.DM_Game:ClearCurrentCardPoolID()
    end
    if #self._cardList > 1 then
      self:Refresh(self._cardList[1], false)
      self._canShare = true
    elseif #self._cardList == 1 then
      self:Refresh(self._cardList[1], false)
      table.remove(self._cardList, 1)
      self._canShare = true
    else
      local dialog = DialogManager.CreateSingletonDialog("gacha.gacharesultdialog")
      if self._tenDrawGuide then
        dialog:SetTenDrawGuide()
      end
      dialog:SetOtherWayGetCard(self._otherWayGet)
      dialog:SetData(self._list, self._otherItemsFromMail)
      self:Destroy()
    end
  else
    local dialog = DialogManager.CreateSingletonDialog("gacha.gacharesultdialog")
    if self._tenDrawGuide then
      dialog:SetTenDrawGuide()
    end
    dialog:SetOtherWayGetCard(self._otherWayGet)
    dialog:SetData(self._list, self._otherItemsFromMail)
    self:Destroy()
  end
end

local function set_visibility(self, visible)
  self._logo:SetActive(visible)
  self._skipBtn:SetActive(not visible)
  self._linesText:SetActive(not visible)
  DialogManager.GetGroup("ClickEffect"):SetObjectActive(not visible)
  self._repeatCharPanel:SetActive(not visible and self._showRepeat)
  self._new:SetActive(not visible and not self._repeatCard)
end

function GachaGetCardDialog:OnShareClick()
  if not self._canShare then
    return
  end
  self._canShare = false
  set_visibility(self, true)
  DialogManager.CreateSingletonDialog("guide.blockclickdialog")
  self._runner = self:GetRootWindow():GetUIObject():AddComponent(typeof(CS.PixelNeko.Tools.ScreenShot))
  self._runner:StartCoroutine(xLuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.25))
    local plat = CS.PixelNeko.LuaManager.GetSystemType()
    local systemType = require("protocols.bean.protocol.common.systemtype")
    local getTextureCount = 0
    if plat == systemType.IOS then
      local path = CS.PixelNeko.Tools.ScreenShotHelper.CaptureToFile(os.time() .. ".png")
      self._shareTimer = GameTimer.AddTask(0.2, 0.1, function()
        getTextureCount = getTextureCount + 1
        local texture = CS.PixelNeko.Tools.ExternalImageLoaderHelper.GetTexture(path)
        if texture or getTextureCount >= DataCommon.GetTextureCount then
          set_visibility(self, false)
          LogInfoFormat("GachaGetCardDialog", "--- getTextureCount = %s, texture = %s, GetTextureCount = %s ---", getTextureCount, texture, DataCommon.GetTextureCount)
          DialogManager.CreateSingletonDialog("gacha.share.gachasharesingledialog"):SetData(texture)
          if self._shareTimer then
            GameTimer.RemoveTask(self._shareTimer)
            self._shareTimer = nil
          end
          self._canShare = true
        end
      end, nil, true)
    else
      local texture = CS.UnityEngine.ScreenCapture.CaptureScreenshotAsTexture()
      self._shareTimer = GameTimer.AddTask(0.2, 0, function()
        set_visibility(self, false)
        DialogManager.CreateSingletonDialog("gacha.share.gachasharesingledialog"):SetData(texture)
        self._shareTimer = nil
        self._canShare = true
      end)
    end
  end))
end

function GachaGetCardDialog:OnAnimationEnter(handle, statename, normalizedTime)
  if #self._cardList > 0 and (statename == "GachaSSR" or statename == "GachaSR" or statename == "GachaR" or statename == "GachaUR" or statename == "GachaEX") then
    self._canShare = true
    self._tag = true
    local roleID = self._cardList[1].cardId
    local role = Role.Create(roleID)
    local index = #self._cardList
    if index ~= self._index then
      if role:CanPlayVoice() then
        self._voiceId = NekoData.BehaviorManager.BM_Voice:Play(roleID, NekoData.BehaviorManager.BM_Voice.VoiceType.Summory, nil)
      end
      self._index = index
    end
    local record = CSoundLines:GetRecorder(roleID)
    if record then
      local animationId = CSoundAnimations:GetRecorder(roleID).Summory
      if self._handler then
        local recorder = CEmotion:GetRecorder(animationId)
        if recorder then
          self._live2d:PlayLive2DAnimation(recorder.Name, self._handler)
        else
          LogErrorFormat("GachaGetCardDialog", "No AnimationName Width ID %s", tostring(animationId))
        end
      end
      if not role:CanPlayVoice() then
        return
      end
      local initString = TextManager.GetText(record.Summory)
      local chars = stringutils.split2table(initString)
      local fontsize = self._linesText:GetFontSize()
      local count = #chars
      local text_size_x = count * fontsize
      if text_size_x < self._textMaxWidth then
        self._linesText:SetWidth(0, text_size_x)
        self._linesText:SetXPosition(self._initialAnchorMinX, -text_size_x / 2)
        self._linesText:SetText("")
      else
        self._linesText:SetText(initString)
        local _, textheight = self._linesText:GetPreferredSize()
        local line = math.ceil((textheight - self._height) / self._oneline)
        local delta = line * fontsize
        self._linesText:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
        self._linesText:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
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
  end
end

function GachaGetCardDialog:NumberOfCell(frame, index)
  return #self._itemList
end

function GachaGetCardDialog:CellAtIndex(frame, index)
  return "gacha.gachagetcarditemcell"
end

function GachaGetCardDialog:DataAtIndex(frame, index)
  return self._itemList[index]
end

return GachaGetCardDialog
