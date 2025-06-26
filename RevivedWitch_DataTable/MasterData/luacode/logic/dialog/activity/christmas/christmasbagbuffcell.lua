-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmasbagbuffcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ChristmasBagBuffCell = class("ChristmasBagBuffCell", Dialog)
ChristmasBagBuffCell.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasBagBuffCell.AssetName = "ActivityChristmasBagCell"
ChristmasBagBuffCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChristmasBagBuffCell
  ((ChristmasBagBuffCell.super).Ctor)(self, ...)
end

ChristmasBagBuffCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Image")
  self._name = self:GetChild("Text")
  self._select = self:GetChild("Check")
  self._unlock = self:GetChild("Buttom")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ChristmasBagBuffCell.OnDestroy = function(self)
  -- function num : 0_2
end

ChristmasBagBuffCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  (self._name):SetText((data.item):GetName())
  local imageRecord = nil
  if data.unlock then
    (self._unlock):SetActive(true)
    if not CImagePathTable:GetRecorder((data.record).imagex) then
      imageRecord = DataCommon.DefaultImageAsset
      ;
      (self._unlock):SetActive(false)
      if not CImagePathTable:GetRecorder((data.record).imagey) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._select):SetActive(data.itemId == (self._delegate)._selectBuffItemId)
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
  end
end

ChristmasBagBuffCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._delegate):SelectedCell((self._cellData).itemId)
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (self._cellData).item})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

ChristmasBagBuffCell.OnEvent = function(self, eventName)
  -- function num : 0_5
  if (self._cellData).itemId ~= (self._delegate)._selectBuffItemId then
    (self._select):SetActive(eventName ~= "SetItemSelectedState")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return ChristmasBagBuffCell

