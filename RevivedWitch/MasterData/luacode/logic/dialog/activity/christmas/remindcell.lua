-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/remindcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local RemindCell = class("RemindCell", Dialog)
RemindCell.AssetBundleName = "ui/layouts.activitychristmas"
RemindCell.AssetName = "ActivityChristmasRemindCell"
RemindCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RemindCell
  ((RemindCell.super).Ctor)(self, ...)
end

RemindCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Trunk")
  self._text = self:GetChild("_Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

RemindCell.OnDestroy = function(self)
  -- function num : 0_2
end

RemindCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((data.record).photoid) then
    local record = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(record.assetBundle, record.assetName)
  ;
  (self._text):SetText((TextManager.GetText)((data.record).textid))
end

RemindCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : CInterfaceFunction, _ENV
  local record = CInterfaceFunction:GetRecorder(((self._cellData).record).puppetAllphy)
  if record then
    local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
    if dialog then
      dialog:SetDialogLibraryId(record.sectionID, false, (dialog.DialogType).Christmas)
    end
  else
    do
      LogErrorFormat("RemindCell", "record with id %s is not exist in cinterfacefunction", ((self._cellData).record).puppetAllphy)
    end
  end
end

return RemindCell

