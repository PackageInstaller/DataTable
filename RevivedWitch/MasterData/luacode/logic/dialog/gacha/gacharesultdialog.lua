-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gacharesultdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CardPool = (BeanManager.GetTableByName)("item.ccardpool")
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local cvarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local Equip = require("logic.manager.experimental.types.equip")
local MaxColumnNums = 5
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CDrawCardDef = (LuaNetManager.GetProtocolDef)("protocol.card.cdrawcard")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local GachaResultDialog = class("GachaResultDialog", Dialog)
GachaResultDialog.AssetBundleName = "ui/layouts.gacha"
GachaResultDialog.AssetName = "GachaResultNew"
GachaResultDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaResultDialog
  ((GachaResultDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._tenDrawGuide = false
  self._moneyList = {}
end

GachaResultDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV, CDrawCardDef
  self._cellPanel = self:GetChild("CellPanel")
  self._cellPanelTwo = self:GetChild("CellPanel2")
  self._frameOnePanel = self:GetChild("FrameOne")
  self._frameTenPanel = self:GetChild("FrameTen")
  self._equipPanel = self:GetChild("EquipFrame")
  self._width = (self._equipPanel):GetRectSize()
  self._anchoredx = (self._equipPanel):GetAnchoredPosition()
  self._againBtn = self:GetChild("Effect/AgainBtn")
  self._exitBtn = self:GetChild("Effect/ExitBtn")
  self._exitBtnText = self:GetChild("Effect/ExitBtn/_Text")
  self._exitGuideBtn = self:GetChild("Effect/ExitBtn2")
  self._exitGuideBtnText = self:GetChild("Effect/ExitBtn2/_Text")
  self._tenDrawGuide_DetailBtn = self:GetChild("Effect/DetailBtn")
  self._restTimes = self:GetChild("GachaNum")
  self._moneyPanel = self:GetChild("TopFrame")
  self._share = self:GetChild("ShareBtn")
  self._shareAward = {icon = self:GetChild("ShareBtn/Item"), num = self:GetChild("ShareBtn/Num"), back = self:GetChild("ShareBtn/TextBack"), txt = self:GetChild("ShareBtn/Text")}
  self._qrcode = self:GetChild("Code")
  self._logo = self:GetChild("Logo")
  ;
  (self._restTimes):SetActive(false)
  self._moneyFrame = (TableFrame.Create)(self._moneyPanel, self, false, false, true)
  local dialog = (DialogManager.GetDialog)("gacha.gachamaindialog")
  if dialog and dialog:GetDrawType() ~= CDrawCardDef.TYPE_CHARGE_TEN then
    (self._againBtn):SetActive(true)
    ;
    (self._exitBtn):SetActive(true)
    ;
    (self._exitGuideBtn):SetActive(false)
  else
    ;
    (self._againBtn):SetActive(false)
    ;
    (self._exitBtn):SetActive(false)
    ;
    (self._exitGuideBtn):SetActive(true)
  end
  ;
  (self._againBtn):Subscribe_PointerClickEvent(self.OnAgainBtnClicked, self)
  ;
  (self._exitBtn):Subscribe_PointerClickEvent(self.OnExitBtnClicked, self)
  ;
  (self._exitGuideBtn):Subscribe_PointerClickEvent(self.OnExitGuideBtnClicked, self)
  ;
  (self._share):Subscribe_PointerClickEvent(self.OnShareClick, self)
  ;
  (self._tenDrawGuide_DetailBtn):Subscribe_PointerClickEvent(self.OnDetailBtnClicked, self)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(3)
  ;
  (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
  ;
  ((NekoData.BehaviorManager).BM_ItemAccountShow):AddShowDialogDataFromCache((DataCommon.ShowDialogType).UniqueEquipUnlock)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RevertCanShare, Common.n_ShareResultDialogClosed, nil)
end

GachaResultDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._moneyFrame):Destroy()
  if self._equipFrame then
    (self._equipFrame):Destroy()
  end
  if self._frameOne then
    (self._frameOne):Destroy()
  end
  if self._frameTen then
    (self._frameTen):Destroy()
  end
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
  do
    if not (DialogManager.GetDialog)("gacha.gachamaindialog") then
      local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
      if sceneController then
        sceneController:SetCameraAnimatorState(0)
      end
    end
    do
      if self._otherItemsFromMail then
        local dialog = (DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")
        if dialog then
          dialog:LoadData({items = self._otherItemsFromMail})
        end
      end
      if self._shareTimer then
        (GameTimer.RemoveTask)(self._shareTimer)
        self._shareTimer = nil
      end
      ;
      (UIBackManager.SetUIBackShow)(false)
    end
  end
end

GachaResultDialog.RevertCanShare = function(self)
  -- function num : 0_3
  self._sharing = false
end

GachaResultDialog.SetDrawCardType = function(self, type)
  -- function num : 0_4 , upvalues : _ENV
  self._drawCardType = type
  if self._drawCardType and self._drawCardType == (DataCommon.DrawCardType).Equip then
    (self._share):SetActive(false)
  end
end

GachaResultDialog.SetOtherWayGetCard = function(self, otherWayGet)
  -- function num : 0_5 , upvalues : _ENV, CstringCfg
  if otherWayGet then
    local str = (TextManager.GetText)((CstringCfg:GetRecorder(1400)).msgTextID)
    ;
    (self._exitBtnText):SetText(str)
    ;
    (self._exitGuideBtnText):SetText(str)
  end
end

GachaResultDialog.SetTenDrawGuide = function(self)
  -- function num : 0_6
  self._tenDrawGuide = true
  ;
  (self._tenDrawGuide_DetailBtn):SetActive(true)
end

local ChangeCellPosition = function(self)
  -- function num : 0_7 , upvalues : MaxColumnNums
  local num = #self._itemList
  local cellPanelWidth = nil
  if num < MaxColumnNums then
    cellPanelWidth = self._width / MaxColumnNums * num
  else
    cellPanelWidth = self._width
  end
  local cellPanelHeight = (self._equipFrame):GetTotalLength()
  if self._height < cellPanelHeight then
    cellPanelHeight = self._height
  end
  ;
  (self._equipPanel):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  ;
  (self._equipPanel):SetAnchoredPosition(self._anchoredx, self._anchoredy)
  ;
  (self._equipFrame):ReloadAllCell()
end

local ShowMoneyPanel = function(self)
  -- function num : 0_8 , upvalues : _ENV, CardPool
  local dialog = (DialogManager.GetDialog)("gacha.gachamaindialog")
  if dialog then
    local selectedPoolId = ((dialog._cardPoolList)[dialog._selectedPoolIndex]).id
    local record = CardPool:GetRecorder(selectedPoolId)
    for i,v in ipairs(record.currencyShow) do
      (table.insert)(self._moneyList, v)
    end
    ;
    (self._moneyFrame):ReloadAllCell()
  end
end

GachaResultDialog.SetData = function(self, cardList, otherItemsFromMail)
  -- function num : 0_9 , upvalues : _ENV, ItemTypeEnum, Item, UniqueEquip, Equip, GridFrame, MaxColumnNums, ChangeCellPosition, ShowMoneyPanel, Role, CardPool, CstringCfg
  if self._drawCardType and self._drawCardType == (DataCommon.DrawCardType).Equip then
    (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
    self._itemList = {}
    for i,v in ipairs(cardList) do
      local itemtype = (v.item).itemtype
      local id = (v.item).id
      local gain = (v.item).gain
      local bagtype = (v.item).bagtype
      local itemInfo = {}
      if gain == 1 then
        if itemtype == ItemTypeEnum.BASEITEM then
          local item = (Item.Create)(id)
          if item:IsUniqueEquip() then
            itemInfo.item = (UniqueEquip.Create)(id)
            itemInfo.type = "UniqueEquip"
          else
            itemInfo.item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(bagtype, id)
            itemInfo.type = "Item"
          end
        else
          do
            if itemtype == ItemTypeEnum.EQUIP then
              itemInfo.item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(id)
              itemInfo.type = "Equip"
            end
            if itemtype == ItemTypeEnum.BASEITEM then
              local item = (Item.Create)(id)
              if item:IsUniqueEquip() then
                itemInfo.item = (UniqueEquip.Create)(id)
                itemInfo.type = "UniqueEquip"
              else
                itemInfo.item = item
                itemInfo.type = "Item"
                ;
                (itemInfo.item):InitWithItemInfo(v.item)
              end
            else
              do
                do
                  if itemtype == ItemTypeEnum.EQUIP then
                    itemInfo.item = (Equip.Create)(id)
                    ;
                    (itemInfo.item):InitWithItemInfo(v.item)
                    itemInfo.type = "Equip"
                  end
                  itemInfo.num = (v.item).number
                  ;
                  (table.insert)(self._itemList, itemInfo)
                  -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
    if not self._equipFrame then
      self._equipFrame = (GridFrame.Create)(self._equipPanel, self, true, MaxColumnNums, true)
    end
    ;
    (self._equipFrame):ReloadAllCell()
    ChangeCellPosition(self)
    ShowMoneyPanel(self)
  else
    self._list = cardList
    self._roleList = {}
    self._haveURRole = false
    warn("card list: ", #cardList)
    for k,v in pairs(self._list) do
      local role = (Role.Create)(v.cardId)
      ;
      (table.insert)(self._roleList, {role = role, keyTag = k, isNew = v.isNew == 1})
      if not self._haveURRole and role and role:GetRarityId() == 4 then
        self._haveURRole = true
      end
    end
    if cardList and #cardList > 0 then
      if #cardList > 1 then
        if self._frameOne then
          (self._frameOne):Destroy()
          self._frameOne = nil
        end
        local len = #cardList == 2 and 1 or 5
        self._frameTen = (GridFrame.Create)(self._frameTenPanel, self, true, len, false)
        ;
        (self._frameTen):ReloadAllCell()
      else
        if self._frameTen then
          (self._frameTen):Destroy()
          self._frameTen = nil
        end
        self._frameOne = (GridFrame.Create)(self._frameOnePanel, self, true, 1, false)
        ;
        (self._frameOne):ReloadAllCell()
      end
      ;
      (self._share):SetActive((#cardList > 2 and ((NekoData.BehaviorManager).BM_Gacha):IsCanShare()))
      self._gameTimerID = (GameTimer.AddTask)(1, -1, function()
    -- function num : 0_9_0 , upvalues : _ENV
    (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  end
)
    else
      (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
    end
    if self._tenDrawGuide then
      (self._restTimes):SetActive(true)
      local totalTimes = ((NekoData.BehaviorManager).BM_Gacha):GetDrawTotalTimes()
      local restTimes = totalTimes - ((NekoData.BehaviorManager).BM_Gacha):GetDrawTimes()
      if restTimes < 5 then
        (self._restTimes):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1278, {restTimes, ((NekoData.BehaviorManager).BM_Gacha):GetDrawTotalTimes()}))
      else
        do
          do
            if restTimes == totalTimes - 1 then
              local str = ((NekoData.BehaviorManager).BM_Message):GetString(1292)
              ;
              ((NekoData.BehaviorManager).BM_Message):AddConfirmTip(str)
            end
            ;
            (self._restTimes):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1277, {restTimes, ((NekoData.BehaviorManager).BM_Gacha):GetDrawTotalTimes()}))
            local dialog = ((DialogManager.GetDialog)("gacha.gachamaindialog"))
            do
              local str = nil
              if dialog then
                local selectedPoolId = ((dialog._cardPoolList)[dialog._selectedPoolIndex]).id
                local record = CardPool:GetRecorder(selectedPoolId)
                local baoDiNums = ((NekoData.BehaviorManager).BM_Gacha):GetBaoDiNum()
                if record.waterLevelType == 1 then
                  if baoDiNums > 1 then
                    str = (TextManager.GetText)((CstringCfg:GetRecorder(1293)).msgTextID)
                    str = (string.gsub)(str, "%$parameter1%$", tostring(baoDiNums))
                  elseif baoDiNums == 1 then
                    str = (TextManager.GetText)((CstringCfg:GetRecorder(1296)).msgTextID)
                  end
                elseif record.waterLevelType == 2 then
                  if baoDiNums > 1 then
                    str = (TextManager.GetText)((CstringCfg:GetRecorder(1294)).msgTextID)
                    str = (string.gsub)(str, "%$parameter1%$", tostring(baoDiNums))
                  elseif baoDiNums == 1 then
                    str = (TextManager.GetText)((CstringCfg:GetRecorder(1297)).msgTextID)
                  end
                elseif record.waterLevelType == 3 then
                  if baoDiNums > 1 then
                    str = (TextManager.GetText)((CstringCfg:GetRecorder(1295)).msgTextID)
                    str = (string.gsub)(str, "%$parameter1%$", tostring(baoDiNums))
                  elseif baoDiNums == 1 then
                    str = (TextManager.GetText)((CstringCfg:GetRecorder(1298)).msgTextID)
                  end
                end
                for i,v in ipairs(record.currencyShow) do
                  (table.insert)(self._moneyList, R15_PC458)
                end
                ;
                (self._moneyFrame):ReloadAllCell()
              end
              if str then
                (self._restTimes):SetText(str)
              end
              self._otherItemsFromMail = otherItemsFromMail
              self:RefreshShare()
              -- DECOMPILER ERROR: 25 unprocessed JMP targets
            end
          end
        end
      end
    end
  end
end

GachaResultDialog.RefreshShare = function(self, state)
  -- function num : 0_10 , upvalues : _ENV, Item
  if not state then
    state = ((NekoData.BehaviorManager).BM_Gacha):GetShareState()
  end
  if state == 1 then
    ((self._shareAward).icon):SetActive(true)
    ;
    ((self._shareAward).num):SetActive(true)
    ;
    ((self._shareAward).back):SetActive(true)
    ;
    ((self._shareAward).txt):SetActive(true)
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
    do
      ;
      ((self._shareAward).icon):SetActive(false)
      ;
      ((self._shareAward).num):SetActive(false)
      ;
      ((self._shareAward).back):SetActive(false)
      ;
      ((self._shareAward).txt):SetActive(false)
    end
  end
end

GachaResultDialog.OnAgainBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV, CDrawCardDef
  local dialog = (DialogManager.GetDialog)("gacha.gachamaindialog")
  if dialog and dialog:GetSelectedPool() then
    if not self._tenDrawGuide then
      local pool = dialog:GetSelectedPool()
      if dialog:GetDrawType() and dialog:GetDrawType() == CDrawCardDef.TYPE_ONE then
        dialog:OnOneBtnClick()
      end
      if dialog:GetDrawType() and dialog:GetDrawType() == CDrawCardDef.TYPE_TEN then
        dialog:OnFiveBtnClick()
      end
    else
      do
        if ((NekoData.BehaviorManager).BM_Gacha):GetDrawTotalTimes() - ((NekoData.BehaviorManager).BM_Gacha):GetDrawTimes() > 0 then
          if self._haveURRole then
            ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(54, {}, function()
    -- function num : 0_11_0 , upvalues : dialog
    dialog:OnTenDrawGuideBtnClick()
  end
, {}, nil, {})
          else
            dialog:OnTenDrawGuideBtnClick()
          end
        else
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100173)
        end
      end
    end
  end
end

local SureTenDrawGuide = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.card.csuredrawtencard")
  csend:Send()
  ;
  (DialogManager.DestroySingletonDialog)("gacha.gachamoviedialog")
  self:Destroy()
end

GachaResultDialog.OnExitBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV, SureTenDrawGuide
  if self._tenDrawGuide then
    if ((NekoData.BehaviorManager).BM_Gacha):GetDrawTotalTimes() - ((NekoData.BehaviorManager).BM_Gacha):GetDrawTimes() > 0 then
      if not self._haveURRole then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(99, {}, function()
    -- function num : 0_13_0 , upvalues : SureTenDrawGuide, self
    SureTenDrawGuide(self)
  end
, {}, nil, {})
      else
        ;
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(27, {}, function()
    -- function num : 0_13_1 , upvalues : SureTenDrawGuide, self
    SureTenDrawGuide(self)
  end
, {}, nil, {})
      end
    else
      SureTenDrawGuide(self)
    end
  else
    local convertItems = ((NekoData.BehaviorManager).BM_Gacha):GetConvertItems()
    do
      do
        if convertItems and #convertItems ~= 0 then
          local dialog = (DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")
          if dialog then
            dialog:LoadData({items = convertItems})
          end
          ;
          ((NekoData.BehaviorManager).BM_Gacha):ClearConvertItems()
        end
        ;
        (DialogManager.DestroySingletonDialog)("gacha.gachamoviedialog")
        self:Destroy()
        local csend = (LuaNetManager.CreateProtocol)("protocol.card.crefreshcardui")
        csend:Send()
      end
    end
  end
end

GachaResultDialog.OnExitGuideBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("gacha.gachamoviedialog")
  local convertItems = ((NekoData.BehaviorManager).BM_Gacha):GetConvertItems()
  do
    if convertItems and #convertItems ~= 0 then
      local dialog = (DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")
      if dialog then
        dialog:LoadData({items = convertItems})
      end
      ;
      ((NekoData.BehaviorManager).BM_Gacha):ClearConvertItems()
    end
    local csend = (LuaNetManager.CreateProtocol)("protocol.card.crefreshcardui")
    csend:Send()
    self:Destroy()
  end
end

local set_visibility = function(self, visible)
  -- function num : 0_15 , upvalues : _ENV, CDrawCardDef
  (self._qrcode):SetActive(visible)
  ;
  (self._logo):SetActive(visible)
  ;
  (self._moneyPanel):SetActive(not visible)
  ;
  (self._share):SetActive(not visible)
  ;
  (self._restTimes):SetActive((not visible and self._tenDrawGuide))
  ;
  (self._tenDrawGuide_DetailBtn):SetActive((not visible and self._tenDrawGuide))
  ;
  ((DialogManager.GetGroup)("ClickEffect")):SetObjectActive(not visible)
  local dialog = (DialogManager.GetDialog)("gacha.gachamaindialog")
  if dialog and dialog:GetDrawType() ~= CDrawCardDef.TYPE_CHARGE_TEN then
    (self._againBtn):SetActive(not visible)
    ;
    (self._exitBtn):SetActive(not visible)
    ;
    (self._exitGuideBtn):SetActive(false)
  else
    (self._againBtn):SetActive(false)
    ;
    (self._exitBtn):SetActive(false)
    ;
    (self._exitGuideBtn):SetActive(not visible)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

GachaResultDialog.OnShareClick = function(self)
  -- function num : 0_16 , upvalues : set_visibility, _ENV, cimagepath
  if self._sharing then
    return 
  end
  self._sharing = true
  set_visibility(self, true)
  ;
  (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
  local qrCodeID = ((NekoData.BehaviorManager).BM_Gacha):GetShareQRCodeID()
  if qrCodeID == -1 then
    (self._qrcode):SetActive(false)
  else
    local img = cimagepath:GetRecorder(qrCodeID)
    ;
    (self._qrcode):SetSprite(img.assetBundle, img.assetName)
  end
  do
    if self._frameTen then
      (self._frameTen):FireEvent("hidenew")
    end
    if self._frameOne then
      (self._frameOne):FireEvent("hidenew")
    end
    self._runner = ((self:GetRootWindow()):GetUIObject()):AddComponent(typeof(((CS.PixelNeko).Tools).ScreenShot))
    ;
    (self._runner):StartCoroutine((xLuaUtil.cs_generator)(function()
    -- function num : 0_16_0 , upvalues : _ENV, self, set_visibility
    (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(0.25))
    local plat = (((CS.PixelNeko).LuaManager).GetSystemType)()
    local systemType = require("protocols.bean.protocol.common.systemtype")
    local getTextureCount = 0
    if plat == systemType.IOS then
      local path = ((((CS.PixelNeko).Tools).ScreenShotHelper).CaptureToFile)((os.time)() .. ".png")
      do
        self._shareTimer = (GameTimer.AddTask)(0.2, 0.1, function()
      -- function num : 0_16_0_0 , upvalues : getTextureCount, _ENV, path, set_visibility, self
      getTextureCount = getTextureCount + 1
      local texture = ((((CS.PixelNeko).Tools).ExternalImageLoaderHelper).GetTexture)(path)
      if texture or DataCommon.GetTextureCount <= getTextureCount then
        set_visibility(self, false)
        LogInfoFormat("GachaResultDialog", "--- getTextureCount = %s, texture = %s, GetTextureCount = %s ---", getTextureCount, texture, DataCommon.GetTextureCount)
        ;
        ((DialogManager.CreateSingletonDialog)("gacha.share.gachashareresultdialog")):SetData(self._list, texture)
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
      -- function num : 0_16_0_1 , upvalues : set_visibility, self, _ENV, texture
      set_visibility(self, false)
      ;
      ((DialogManager.CreateSingletonDialog)("gacha.share.gachashareresultdialog")):SetData(self._list, texture)
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

GachaResultDialog.OnDetailBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (DialogManager.CreateSingletonChildDialog)("gacha.firstgachadetaildialog", self._dialogName, self:GetRootWindow())
end

GachaResultDialog.NumberOfCell = function(self, frame)
  -- function num : 0_18 , upvalues : _ENV
  if frame == self._moneyFrame then
    return #self._moneyList
  else
    if frame == self._frameTen then
      return (math.ceil)(#self._roleList / 2)
    else
      if frame == self._frameOne then
        return #self._roleList
      else
        if frame == self._equipFrame then
          return #self._itemList
        end
      end
    end
  end
end

local cellList = {"gacha.gacharesultcell.r", "gacha.gacharesultcell.sr", "gacha.gacharesultcell.ssr", "gacha.gacharesultcell.ur", "gacha.gacharesultcell.ex"}
GachaResultDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_19 , upvalues : cellList, _ENV
  if frame == self._moneyFrame then
    return "gacha.moneycell"
  else
    if frame == self._frameOne then
      local rarity = (((self._roleList)[index]).role):GetRarityId()
      local cell = cellList[rarity]
      if cell then
        return cell
      else
        LogError("角色品级不是1，2，3, 4, 5")
      end
    else
      do
        if frame == self._frameTen then
          if #self._roleList == 2 then
            return "gacha.gacharesultcell.first"
          else
            return "gacha.gacharesultcell.twocell"
          end
        else
          if frame == self._equipFrame then
            return "gacha.gacharesultitemcell"
          end
        end
      end
    end
  end
end

GachaResultDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_20
  if frame == self._moneyFrame then
    return (self._moneyList)[index]
  else
    if frame == self._frameOne then
      return (self._roleList)[index]
    else
      if frame == self._frameTen then
        return {(self._roleList)[2 * index - 1], (self._roleList)[2 * index]}
      else
        if frame == self._equipFrame then
          return (self._itemList)[index]
        end
      end
    end
  end
end

GachaResultDialog.CheckRoleInfo = function(self, keyTag)
  -- function num : 0_21 , upvalues : _ENV, CheckOtherRoleInfoDialog
  LogInfo("展示角色详情界面")
  local index = nil
  local roleIdList = {}
  local cfgIdList = {}
  for i,v in ipairs(self._roleList) do
    if not index and v.keyTag == keyTag then
      index = i
    end
    ;
    (table.insert)(roleIdList, (v.role):GetId())
    ;
    (table.insert)(cfgIdList, 1)
  end
  ;
  ((DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")):Init({roleIdList = roleIdList, cfgIdList = cfgIdList, index = index}, (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo, (CheckOtherRoleInfoDialog.TagType).GachaResult)
end

return GachaResultDialog

