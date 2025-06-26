-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/resolveequipcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ResolveEquipCell = class("ResolveEquipCell", Dialog)
ResolveEquipCell.AssetBundleName = "ui/layouts.equip"
ResolveEquipCell.AssetName = "EquipResolveCell"
ResolveEquipCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResolveEquipCell
  ((ResolveEquipCell.super).Ctor)(self, ...)
end

ResolveEquipCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("Panel/Frame")
  self._icon = self:GetChild("Panel/Icon")
  self._strengthenLv = self:GetChild("Panel/Level/Num")
  self._select = self:GetChild("Panel/Select")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnCellLongPress, self)
end

ResolveEquipCell.OnDestroy = function(self)
  -- function num : 0_2
end

ResolveEquipCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  if not data then
    (self:GetChild("Panel/Level")):SetActive(false)
    local imageRecord = CImagePathTable:GetRecorder(10374)
    ;
    (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = DataCommon.NullImageAsset
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self:SetSelectState(false)
    return 
  end
  do
    ;
    (self:GetChild("Panel/Level")):SetActive(true)
    local record = data:GetPinJiImage()
    ;
    (self._frame):SetSprite(record.assetBundle, record.assetName)
    record = data:GetIcon()
    ;
    (self._icon):SetSprite(record.assetBundle, record.assetName)
    local strengthenLv = data:GetStrengthenLevel()
    if strengthenLv == 0 then
      (self._strengthenLv):SetActive(false)
    else
      ;
      (self._strengthenLv):SetActive(true)
      ;
      (self._strengthenLv):SetText(tostring(strengthenLv))
    end
    if (self._delegate):IsInResolveEquips(data) then
      self:SetSelectState(true)
    else
      self:SetSelectState(false)
    end
  end
end

ResolveEquipCell.SetSelectState = function(self, bSelect)
  -- function num : 0_4
  self._bSelectState = bSelect
  ;
  (self._select):SetActive(bSelect)
end

ResolveEquipCell.OnCellClicked = function(self)
  -- function num : 0_5
  if not self._cellData then
    return 
  end
  self:SetSelectState(not self._bSelectState)
  ;
  (self._delegate):OnSelectEquipsChange(self._cellData, self._bSelectState)
end

ResolveEquipCell.OnCellLongPress = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not self._cellData then
    return 
  end
  local tipsDialog = nil
  local width, height = (self:GetRootWindow()):GetRectSize()
  tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
  if tipsDialog then
    tipsDialog:Init((self._cellData):GetKey())
    tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_6_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
  end
end

ResolveEquipCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7
  if self._cellData and eventName == "ChooseResolveEquip" then
    if (self._delegate):IsInResolveEquips(self._cellData) then
      self:SetSelectState(true)
    else
      self:SetSelectState(false)
    end
  end
end

return ResolveEquipCell

