-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/roleskinlist/roleskinlistrewardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RoleSkinListRewardCell = class("RoleSkinListRewardCell", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
RoleSkinListRewardCell.AssetBundleName = "ui/layouts.baseshop"
RoleSkinListRewardCell.AssetName = "FashionShopListRewardCell"
RoleSkinListRewardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleSkinListRewardCell
  ((RoleSkinListRewardCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

RoleSkinListRewardCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Back/Txt1")
  self._commitBtn = self:GetChild("Back/GetBtn")
  self._commitBtn_text = self:GetChild("Back/GetBtn/_Text")
  self._difficultyTxt = self:GetChild("Back/Difficulty")
  self._itemCell = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

      (self._itemCell)[i] = {}
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._itemCell)[i]).cell = self:GetChild("Back/ItemFrame/ItemCell" .. i)
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._itemCell)[i]).icon = self:GetChild("Back/ItemFrame/ItemCell" .. i .. "/_BackGround/Icon")
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._itemCell)[i]).frame = self:GetChild("Back/ItemFrame/ItemCell" .. i .. "/_BackGround/Frame")
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._itemCell)[i]).count = self:GetChild("Back/ItemFrame/ItemCell" .. i .. "/_Count")
      ;
      (((self._itemCell)[i]).cell):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnItemClicked(i)
  end
)
    end
  end
  self._itemPanel = self:GetChild("Back/ItemFrame")
  ;
  (self._commitBtn):Subscribe_PointerClickEvent(self.OnCommitClick, self)
end

RoleSkinListRewardCell.OnDestroy = function(self)
  -- function num : 0_2
end

RoleSkinListRewardCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._name):SetText((TextManager.GetText)((data.recorder).bonusnameId))
  ;
  (self._commitBtn):SetInteractable(data.state == 1)
  if data.state == 2 then
    (self._commitBtn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1900))
  else
    (self._commitBtn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1899))
  end
  self._itemList = data.items
  for i = 1, 3 do
    local item = ((self._itemList)[i]).value
    local image = item:GetIcon()
    ;
    (((self._itemCell)[i]).icon):SetSprite(image.assetBundle, image.assetName)
    image = item:GetPinJiImage()
    ;
    (((self._itemCell)[i]).frame):SetSprite(image.assetBundle, image.assetName)
    ;
    (((self._itemCell)[i]).count):SetText((NumberManager.GetShowNumber)(item:GetCount()))
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self._itemCell)[i]).item = item
  end
  local conditions = (data.recorder).conditions
  local current = ((NekoData.BehaviorManager).BM_SkinList):GetCurrentSkinNum()
  if conditions < current then
    current = conditions
  end
  ;
  (self._difficultyTxt):SetText(tostring(current) .. "/" .. tostring(conditions))
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

RoleSkinListRewardCell.OnCommitClick = function(self)
  -- function num : 0_4
  if (self._cellData).state == 1 then
    (self._delegate):OnCommitClick(((self._cellData).recorder).id)
  end
end

RoleSkinListRewardCell.OnItemClicked = function(self, index)
  -- function num : 0_5 , upvalues : _ENV
  local width, height = (((self._itemCell)[index]).cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = ((self._itemCell)[index]).item})
    tipsDialog:SetTipsPosition(width, height, (((self._itemCell)[index]).cell):GetLocalPointInUiRootPanel())
  end
end

return RoleSkinListRewardCell

