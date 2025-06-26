-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/mainlinefloorequipcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MainLineFloorEquipCell = class("MainLineFloorEquipCell", Dialog)
MainLineFloorEquipCell.AssetBundleName = "ui/layouts.basecharacterinfo"
MainLineFloorEquipCell.AssetName = "BaseCharacterInfoEquipCell"
MainLineFloorEquipCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainLineFloorEquipCell
  ((MainLineFloorEquipCell.super).Ctor)(self, ...)
end

MainLineFloorEquipCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("BackGround/Frame")
  self._icon = self:GetChild("BackGround/Icon")
  self._select = self:GetChild("BackGround/Select")
  self._back = self:GetChild("EquipBack")
  self._check = self:GetChild("Check")
  ;
  (self._check):SetActive(false)
  ;
  (self._select):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

MainLineFloorEquipCell.OnDestroy = function(self)
  -- function num : 0_2
end

MainLineFloorEquipCell.RefreshCell = function(self, equip)
  -- function num : 0_3
  if equip.get then
    (self._check):SetActive(true)
  else
    ;
    (self._check):SetActive(false)
  end
  if equip.item then
    self._equip = equip.item
  else
    self._equip = equip
  end
  local record = nil
  record = (self._equip):GetPinJiImage()
  ;
  (self._frame):SetSprite(record.assetBundle, record.assetName)
  record = (self._equip):GetIcon()
  ;
  (self._icon):SetSprite(record.assetBundle, record.assetName)
end

MainLineFloorEquipCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._select):SetActive(true)
  local tipsDialog = nil
  local width, height = (self:GetRootWindow()):GetRectSize()
  if (self._equip):IsGained() then
    tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
    if tipsDialog then
      tipsDialog:Init((self._equip):GetKey())
      tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
    end
  else
    tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
    if tipsDialog then
      tipsDialog:Init((self._equip):GetID())
      tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_1 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
    end
  end
end

MainLineFloorEquipCell.SetSelect = function(self, flag)
  -- function num : 0_5
  (self._select):SetActive(flag)
end

return MainLineFloorEquipCell

