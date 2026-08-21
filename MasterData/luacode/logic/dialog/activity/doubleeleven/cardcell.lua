-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/doubleeleven/cardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CardCell = class("CardCell", Dialog)
CardCell.AssetBundleName = "ui/layouts.activityeleven"
CardCell.AssetName = "ActivityElevenTicketCellItem"
CardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CardCell
  ((CardCell.super).Ctor)(self, ...)
  self._item = nil
  self._isGoldCard = false
  self._cardBackCanClick = true
end

CardCell.OnCreate = function(self)
  -- function num : 0_1
  self._cardBack = self:GetChild("Back")
  self._cardTxt = self:GetChild("Txt")
  self._itemCell = self:GetChild("Panel/ItemCell")
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemCount = self:GetChild("Panel/ItemCell/_Count")
  ;
  (self._cardBack):Subscribe_PointerClickEvent(self.OnCellBackClicked, self)
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

CardCell.OnDestroy = function(self)
  -- function num : 0_2
end

CardCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._data = data
  self._item = data.item
  self._index = data.index
  self._state = data.state
  if self._state == "HaveGoldCard" then
    self._cardBackCanClick = false
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._data).state = "ToFace"
    ;
    (self:GetRootWindow()):SetAnimatorTrigger("HaveGoldCard")
  else
    if self._state == "HaveNormalCard" then
      self._cardBackCanClick = false
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._data).state = "ToFace"
      ;
      (self:GetRootWindow()):SetAnimatorTrigger("HaveNormalCard")
    else
      if self._state == "ToBack" then
        self._cardBackCanClick = true
        ;
        (self._cardBack):SetActive(true)
      else
        if self._state == "ToFace" then
          self._cardBackCanClick = false
          ;
          (self._cardBack):SetActive(false)
          ;
          (self._cardTxt):SetText((self._item):GetName())
          ;
          (self._itemCount):SetText((NumberManager.GetShowNumber)((self._item):GetCount()))
          ;
          (self._itemIcon):SetSprite(((self._item):GetIcon()).assetBundle, ((self._item):GetIcon()).assetName)
          ;
          (self._itemFrame):SetSprite(((self._item):GetPinJiImage()).assetBundle, ((self._item):GetPinJiImage()).assetName)
        end
      end
    end
  end
end

CardCell.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_4
  if stateName == "HaveGoldCard" then
    self:RefreshCell(self._data)
    ;
    (self._delegate):OnOpenCardAnimationEnd()
    ;
    (self._delegate):OnOneGoldCardToFace()
  else
    if stateName == "HaveNormalCard" then
      self:RefreshCell(self._data)
      ;
      (self._delegate):OnOpenCardAnimationEnd()
    else
      if stateName == "ClearCard" then
        self:RefreshCell(self._data)
        ;
        (self._delegate):OnClearCardAnimationEnd()
      end
    end
  end
end

CardCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "ClearAllCard" then
    self._cardBackCanClick = false
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._data).state = "ToBack"
    ;
    (self._cardBack):SetActive(true)
    ;
    (self:GetRootWindow()):PlayAnimation("ClearCard")
  else
    if eventName == "RefreshOneCell" and self._index == arg.index then
      self:RefreshCell((arg.data)[arg.index])
    end
  end
end

CardCell.OnCellBackClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DoubleElevenActivityID)):GetIsOpen() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100410)
    return 
  end
  if self._cardBackCanClick == false then
    return 
  end
  LogInfo("CardCell", "The Card " .. self._index .. " Clicked.")
  ;
  (self._delegate):OnOneCardClicked(self._index)
end

CardCell.OnItemCellClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._item})
  end
end

return CardCell

