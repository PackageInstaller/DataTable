local CardInfoTypeEnum = LuaNetManager.GetBeanDef("protocol.card.cardinfo")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Role = require("logic.manager.experimental.types.role")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local CRoleItemTable = BeanManager.GetTableByName("item.croleitem")
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local GachaMovieDialog = class("GachaMovieDialog", Dialog)
GachaMovieDialog.AssetBundleName = "ui/layouts.gacha"
GachaMovieDialog.AssetName = "GachaMovie"

function GachaMovieDialog:Ctor(...)
  GachaMovieDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._cards = {}
  self._tenDrawGuide = false
  self._stage = 0
  self._stage1Clicked = false
  self._startTime = os.time()
  self._hasClicked = false
  self._movieEndSpeed = 1
  self._originalEndSpeed = 1
  self._currentMovieEndIndex = 1
end

function GachaMovieDialog:OnCreate()
  self._blackBack = self:GetChild("ImageBlack")
  self._movie = self:GetChild("Image")
  self._movieEnd = self:GetChild("ImageEnd")
  self._effect1 = self:GetChild("Effect1")
  self._effect2 = self:GetChild("Effect2")
  self._skipButton = self:GetChild("SkipBtn")
  self._animator = AnimatorStaticFunctions.Get(self:GetRootWindow()._uiObject)
  self._skipButton:Subscribe_PointerClickEvent(self.OnSkipButtonClick, self)
  self._movie:Subscribe_VideoPlayEndEvent(self.OnVideoPlayEnd, self)
  self._effect1:SetActive(false)
  self._effect2:SetActive(false)
  self._movieEnd:SetActive(true)
  LuaAudioManager.PlayBGM(186, true)
  LogInfoFormat("GachaMovieDialog", "oncreate  ")
end

function GachaMovieDialog:OnDestroy()
  LuaAudioManager.PlayBGM(NekoData.BehaviorManager.BM_Game:GetMainCityBgmID())
end

function GachaMovieDialog:AddNewModal(dialog)
end

function GachaMovieDialog:SetTenDrawGuide()
  self._tenDrawGuide = true
end

function GachaMovieDialog:SetData(cards, drawCardType)
  LogInfoFormat("GachaMovieDialog", "=====SetData 000")
  self._stage1Clicked = false
  self._startTime = os.time()
  self._stage = 1
  self._cards = {}
  self._cards = cards
  self._drawCardType = drawCardType
  self._haveUniqueEquip = false
  local hasEX = false
  local hasUR = false
  local hasSSR = false
  if not self._drawCardType or self._drawCardType == DataCommon.DrawCardType.Role then
    for i, v in ipairs(self._cards) do
      local role
      if not self._tenDrawGuide then
        if v.cardtype == CardInfoTypeEnum.ROLE then
          role = Role.Create(v.cardId)
        end
        if not role then
          LogErrorFormat("GachaMovieDialog", "role id %s received from server is wrong", v.cardId)
        end
      else
        role = Role.Create(v.cardId)
        if not role then
          LogErrorFormat("GachaMovieDialog", "role id %s received from server is wrong", v.cardId)
        end
      end
      if role then
        if role:GetRarityId() == 5 then
          hasEX = true
          break
        elseif role:GetRarityId() == 4 then
          hasUR = true
        elseif role:GetRarityId() == 3 then
          hasSSR = true
        end
      end
    end
  elseif self._drawCardType == DataCommon.DrawCardType.Equip then
    for i, v in ipairs(self._cards) do
      if v.cardtype == CardInfoTypeEnum.ITEM then
        local itemtype = v.item.itemtype
        local id = v.item.id
        if itemtype == ItemTypeEnum.BASEITEM then
          local item = Item.Create(id)
          if item:IsUniqueEquip() then
            hasUR = true
            self._haveUniqueEquip = true
            break
          end
        elseif itemtype == ItemTypeEnum.EQUIP then
          local equipItem
          if v.item.gain == 1 then
            equipItem = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(id)
          else
            equipItem = Equip.Create(id)
            LogErrorFormat("GachaMovieDialog", "equip(id: %s) not gain.", id)
          end
          local pinJi = equipItem:GetPinJiID()
          if pinJi == 5 then
            hasSSR = true
          end
        end
      else
        LogErrorFormat("GachaMovieDialog", "card type: %s is wrong", v.cardtype)
      end
    end
  end
  local videoId = 4
  if hasEX then
    videoId = 8
  elseif hasUR then
    videoId = 7
  elseif hasSSR then
    videoId = 6
  else
    videoId = 5
  end
  LogInfoFormat("GachaMovieDialog", "=====SetData 111")
  self._movie:SetFileById(videoId)
  LogInfoFormat("GachaMovieDialog", "=====SetData 111 aaa")
  self._movie:Prepare()
  LogInfoFormat("GachaMovieDialog", "=====SetData 111 bbb")
  self._movie:PlayVideo()
  LogInfoFormat("GachaMovieDialog", "=====SetData 111 ccc")
  LogInfoFormat("GachaMovieDialog", "=====SetData 222")
  self._movieEnd:SetLoop(true)
  self._movieEnd:SetFileById(9)
  self._movieEnd:Prepare()
  LogInfoFormat("GachaMovieDialog", "=====SetData 333")
end

function GachaMovieDialog:OnSkipButtonClick()
  LogInfoFormat("GachaMovieDialog", "=====OnSkipButtonClick")
  if self._stage == 1 then
    self._movie:StopVideo()
    self._movie:SetActive(false)
  elseif self._stage == 2 then
  end
  self._stage = 3
  self._movieEnd:PlayVideo()
  self._skipButton:SetActive(false)
  self:DisplayCards()
end

function GachaMovieDialog:OnVideoPlayEnd()
  LogInfoFormat("GachaMovieDialog", "=====OnVideoPlayEnd stage is " .. self._stage)
  if self._stage == 1 then
    self._stage = 3
    self._movie:SetActive(false)
    self._movieEnd:PlayVideo()
    self._skipButton:SetActive(false)
    self:DisplayCards()
  elseif self._stage == 3 then
  end
end

function GachaMovieDialog:DisplayCards()
  DialogManager.DestroySingletonDialog("gacha.gacharesultdialog")
  if #self._cards > 0 then
    if not self._drawCardType or self._drawCardType == DataCommon.DrawCardType.Role then
      local dialog = DialogManager.CreateSingletonDialog("gacha.gachagetcarddialog")
      if self._tenDrawGuide then
        dialog:SetTenDrawGuide()
      end
      dialog:SetData(self._cards)
    elseif self._drawCardType == DataCommon.DrawCardType.Equip then
      if self._haveUniqueEquip then
        DialogManager.CreateSingletonDialog("gacha.gachagetequipdialog"):SetData(self._cards)
      else
        local resultDialog = DialogManager.CreateSingletonDialog("gacha.gacharesultdialog")
        resultDialog:SetDrawCardType(self._drawCardType)
        resultDialog:SetData(self._cards)
        self:VideoFadeOut()
      end
    end
  end
end

function GachaMovieDialog:DisplaySpecialCard(roles, items)
  LogInfoFormat("GachaMovieDialog", "=====DisplaySpecialCard")
  self._movie:StopVideo()
  self._movie:SetActive(false)
  self._skipButton:SetActive(false)
  self._movieEnd:SetActive(true)
  self._movieEnd:SetFileById(9)
  self._movieEnd:PlayVideo()
  local dialog = DialogManager.CreateSingletonDialog("gacha.gachagetcarddialog")
  dialog:SetOtherWayGetCard()
  dialog:SetData(roles, items)
end

function GachaMovieDialog:VideoFadeOut()
  self._animator:SetFloat("Blend", 2)
  self._blackBack:SetActive(false)
end

function GachaMovieDialog:PlayEnd()
end

return GachaMovieDialog
