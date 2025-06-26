-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/memoryshowdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ShareSingleDialog = class("ShareSingleDialog", Dialog)
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
ShareSingleDialog.AssetBundleName = "ui/layouts.tujianpuzzle"
ShareSingleDialog.AssetName = "TuJianPuzzleShow"
ShareSingleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShareSingleDialog
  ((ShareSingleDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ShareSingleDialog.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("BackImage/Puzzle")
  self._share = self:GetChild("BackImage/DownloadBtn")
  self._back = self:GetChild("BackImage/CloseBtn")
  ;
  (self._share):Subscribe_PointerClickEvent(self.OnShareClick, self)
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

ShareSingleDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ShareSingleDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  self._data = data
  if not CImagePathTable:GetRecorder(data.SharePic_id) then
    local imgRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._img):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
end

ShareSingleDialog.OnShareClick = function(self, args)
  -- function num : 0_4 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("handbook.memorybookfullscreendialog")):SetData(self._data)
  self:Destroy()
end

ShareSingleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

return ShareSingleDialog

