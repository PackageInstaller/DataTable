-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildlogoselectdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGuildHead = (BeanManager.GetTableByName)("guild.cguildhead")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local GuildLogoSelectDialog = class("GuildLogoSelectDialog", Dialog)
GuildLogoSelectDialog.AssetBundleName = "ui/layouts.guild"
GuildLogoSelectDialog.AssetName = "GuildLogo"
GuildLogoSelectDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildLogoSelectDialog
  ((GuildLogoSelectDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._selectData = nil
  self._delegate = nil
  self._data = {}
end

GuildLogoSelectDialog.OnCreate = function(self)
  -- function num : 0_1
  self._logo = self:GetChild("Back/Logo")
  self._name = self:GetChild("Back/Name")
  self._panel = self:GetChild("Back/Frame")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

GuildLogoSelectDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GuildLogoSelectDialog.Init = function(self, delegate, index)
  -- function num : 0_3 , upvalues : GridFrame, CGuildHead, _ENV
  self._data = {}
  self._delegate = delegate
  self._frame = (GridFrame.Create)(self._panel, self, true, 3)
  local allId = (CGuildHead:GetAllIds())
  -- DECOMPILER ERROR at PC13: Overwrote pending register: R4 in 'AssignReg'

  local recorder, temp = .end, nil
  for i,v in ipairs(allId) do
    recorder = CGuildHead:GetRecorder(v)
    ;
    (table.insert)(self._data, recorder)
  end
  ;
  (table.sort)(self._data, function(a, b)
    -- function num : 0_3_0
    do return a.SortId < b.SortId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._frame):ReloadAllCell()
  self:OnCellClicked(CGuildHead:GetRecorder(index))
end

GuildLogoSelectDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

GuildLogoSelectDialog.OnCellClicked = function(self, data)
  -- function num : 0_5 , upvalues : CGuildHead, CImagePath, _ENV
  self._selectData = data
  local recorder = CGuildHead:GetRecorder(data.id)
  if not CImagePath:GetRecorder(recorder.BigUiId) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._logo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(data.NameId))
  ;
  (self._frame):FireEvent("Select", data.id)
end

GuildLogoSelectDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_6
  (self._delegate):SetHead(self._selectData)
  self:Destroy()
end

GuildLogoSelectDialog.GetAvatarId = function(self)
  -- function num : 0_7
  return (self._delegate)._avatarId
end

GuildLogoSelectDialog.NumberOfCell = function(self, frame)
  -- function num : 0_8
  return #self._data
end

GuildLogoSelectDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "guild.guildlogocell"
end

GuildLogoSelectDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._data)[index]
end

return GuildLogoSelectDialog

