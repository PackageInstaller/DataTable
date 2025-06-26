-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gachamoviedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CardInfoTypeEnum = (LuaNetManager.GetBeanDef)("protocol.card.cardinfo")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Role = require("logic.manager.experimental.types.role")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local GachaMovieDialog = class("GachaMovieDialog", Dialog)
GachaMovieDialog.AssetBundleName = "ui/layouts.gacha"
GachaMovieDialog.AssetName = "GachaMovie"
GachaMovieDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaMovieDialog, _ENV
  ((GachaMovieDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._cards = {}
  self._tenDrawGuide = false
  self._stage = 0
  self._stage1Clicked = false
  self._startTime = (os.time)()
  self._hasClicked = false
  self._movieEndSpeed = 1
  self._originalEndSpeed = 1
  self._currentMovieEndIndex = 1
end

GachaMovieDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : AnimatorStaticFunctions, _ENV
  self._blackBack = self:GetChild("ImageBlack")
  self._movie = self:GetChild("Image")
  self._movieEnd = self:GetChild("ImageEnd")
  self._effect1 = self:GetChild("Effect1")
  self._effect2 = self:GetChild("Effect2")
  self._skipButton = self:GetChild("SkipBtn")
  self._animator = (AnimatorStaticFunctions.Get)((self:GetRootWindow())._uiObject)
  ;
  (self._skipButton):Subscribe_PointerClickEvent(self.OnSkipButtonClick, self)
  ;
  (self._movie):Subscribe_VideoPlayEndEvent(self.OnVideoPlayEnd, self)
  ;
  (self._effect1):SetActive(false)
  ;
  (self._effect2):SetActive(false)
  ;
  (self._movieEnd):SetActive(true)
  ;
  (LuaAudioManager.PlayBGM)(186, true)
end

GachaMovieDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaAudioManager.PlayBGM)(((NekoData.BehaviorManager).BM_Game):GetMainCityBgmID())
end

GachaMovieDialog.AddNewModal = function(self, dialog)
  -- function num : 0_3
end

GachaMovieDialog.SetTenDrawGuide = function(self)
  -- function num : 0_4
  self._tenDrawGuide = true
end

GachaMovieDialog.SetData = function(self, cards, drawCardType)
  -- function num : 0_5 , upvalues : _ENV, CardInfoTypeEnum, Role, ItemTypeEnum, Item, Equip
  self._stage1Clicked = false
  self._startTime = (os.time)()
  self._stage = 1
  while (self._cards)[#self._cards] do
    (table.remove)(self._cards, #self._cards)
  end
  self._cards = cards
  self._drawCardType = drawCardType
  self._haveUniqueEquip = false
  local hasEX = false
  local hasUR = false
  local hasSSR = false
  if not self._drawCardType or self._drawCardType == (DataCommon.DrawCardType).Role then
    for i,v in ipairs(self._cards) do
      local role = nil
      if not self._tenDrawGuide then
        if v.cardtype == CardInfoTypeEnum.ROLE then
          role = (Role.Create)(v.cardId)
        end
        if not role then
          LogErrorFormat("GachaMovieDialog", "role id %s received from server is wrong", v.cardId)
        end
      else
        role = (Role.Create)(v.cardId)
        if not role then
          LogErrorFormat("GachaMovieDialog", "role id %s received from server is wrong", v.cardId)
        end
      end
      if role then
        if role:GetRarityId() == 5 then
          hasEX = true
          break
        else
          if role:GetRarityId() == 4 then
            hasUR = true
          else
            if role:GetRarityId() == 3 then
              hasSSR = true
            end
          end
        end
      end
    end
  else
    do
      if self._drawCardType == (DataCommon.DrawCardType).Equip then
        for i,v in ipairs(self._cards) do
          if v.cardtype == CardInfoTypeEnum.ITEM then
            local itemtype = (v.item).itemtype
            local id = (v.item).id
            if itemtype == ItemTypeEnum.BASEITEM then
              local item = (Item.Create)(id)
              if item:IsUniqueEquip() then
                hasUR = true
                self._haveUniqueEquip = true
                break
              end
            else
              do
                if itemtype == ItemTypeEnum.EQUIP then
                  local equipItem = nil
                  if (v.item).gain == 1 then
                    equipItem = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(id)
                  else
                    equipItem = (Equip.Create)(id)
                    LogErrorFormat("GachaMovieDialog", "equip(id: %s) not gain.", id)
                  end
                  local pinJi = equipItem:GetPinJiID()
                  if pinJi == 5 then
                    hasSSR = true
                  end
                end
                do
                  do
                    LogErrorFormat("GachaMovieDialog", "card type: %s is wrong", v.cardtype)
                    -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
        end
      end
      local videoId = 4
      if hasEX then
        videoId = 8
      else
        if hasUR then
          videoId = 7
        else
          if hasSSR then
            videoId = 6
          else
            videoId = 5
          end
        end
      end
      ;
      (self._movie):SetFileById(videoId)
      ;
      (self._movie):PlayVideoWithLoading()
      ;
      (self._movieEnd):SetLoop(true)
      ;
      (self._movieEnd):SetFileById(9)
      ;
      (self._movieEnd):Prepare()
    end
  end
end

GachaMovieDialog.OnSkipButtonClick = function(self)
  -- function num : 0_6
  if self._stage == 1 then
    (self._movie):StopVideo()
    ;
    (self._movie):SetActive(false)
  else
  end
  if self._stage == 2 then
    self._stage = 3
    ;
    (self._movieEnd):PlayVideo()
    ;
    (self._skipButton):SetActive(false)
    self:DisplayCards()
  end
end

GachaMovieDialog.OnVideoPlayEnd = function(self)
  -- function num : 0_7
  if self._stage == 1 then
    self._stage = 3
    ;
    (self._movie):SetActive(false)
    ;
    (self._movieEnd):PlayVideo()
    ;
    (self._skipButton):SetActive(false)
    self:DisplayCards()
  else
  end
  if self._stage == 3 then
  end
end

GachaMovieDialog.DisplayCards = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("gacha.gacharesultdialog")
  if #self._cards > 0 then
    if not self._drawCardType or self._drawCardType == (DataCommon.DrawCardType).Role then
      local dialog = (DialogManager.CreateSingletonDialog)("gacha.gachagetcarddialog")
      if self._tenDrawGuide then
        dialog:SetTenDrawGuide()
      end
      dialog:SetData(self._cards)
    else
      do
        if self._drawCardType == (DataCommon.DrawCardType).Equip then
          if self._haveUniqueEquip then
            ((DialogManager.CreateSingletonDialog)("gacha.gachagetequipdialog")):SetData(self._cards)
          else
            local resultDialog = (DialogManager.CreateSingletonDialog)("gacha.gacharesultdialog")
            resultDialog:SetDrawCardType(self._drawCardType)
            resultDialog:SetData(self._cards)
            self:VideoFadeOut()
          end
        end
      end
    end
  end
end

GachaMovieDialog.DisplaySpecialCard = function(self, roles, items)
  -- function num : 0_9 , upvalues : _ENV
  (self._movie):StopVideo()
  ;
  (self._movie):SetActive(false)
  ;
  (self._skipButton):SetActive(false)
  ;
  (self._movieEnd):SetActive(true)
  ;
  (self._movieEnd):SetFileById(9)
  ;
  (self._movieEnd):PlayVideo()
  local dialog = (DialogManager.CreateSingletonDialog)("gacha.gachagetcarddialog")
  dialog:SetOtherWayGetCard()
  dialog:SetData(roles, items)
end

GachaMovieDialog.VideoFadeOut = function(self)
  -- function num : 0_10
  (self._animator):SetFloat("Blend", 2)
  ;
  (self._blackBack):SetActive(false)
end

GachaMovieDialog.PlayEnd = function(self)
  -- function num : 0_11
end

return GachaMovieDialog

