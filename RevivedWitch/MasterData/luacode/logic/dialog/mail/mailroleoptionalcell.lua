-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mail/mailroleoptionalcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MailRoleOptionalCell = class("MailRoleOptionalCell", Dialog)
MailRoleOptionalCell.AssetBundleName = "ui/layouts.mail"
MailRoleOptionalCell.AssetName = "MailRoleOptionalCell"
MailRoleOptionalCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MailRoleOptionalCell
  ((MailRoleOptionalCell.super).Ctor)(self, ...)
end

MailRoleOptionalCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("Cell/Frame")
  self._photo = self:GetChild("Cell/Photo")
  self._element = self:GetChild("Cell/Element")
  self._job = self:GetChild("Cell/Job")
  self._name = self:GetChild("Name")
  self._checkBorder = self:GetChild("Cell/Check")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnClick, self)
  ;
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnLongPress, self)
end

MailRoleOptionalCell.OnDestroy = function(self)
  -- function num : 0_2
end

MailRoleOptionalCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._role = data.role
  self._index = data.index
  local image = (self._role):GetSmallRarityFrameRecord()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  image = (self._role):GetShapeLittleHeadImageRecord()
  ;
  (self._photo):SetSprite(image.assetBundle, image.assetName)
  image = (self._role):GetElementImageRecord()
  ;
  (self._element):SetSprite(image.assetBundle, image.assetName)
  image = (self._role):GetVocationImageRecord()
  ;
  (self._job):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._name):SetText((self._role):GetRoleName())
  ;
  (self._checkBorder):SetActive((self._delegate)._selectIndex == self._index)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

MailRoleOptionalCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_4
  if arg ~= self._index then
    (self._checkBorder):SetActive(eventName ~= "ChangeSelected")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

MailRoleOptionalCell.OnClick = function(self)
  -- function num : 0_5
  (self._delegate):OnCellClick(self._index)
end

MailRoleOptionalCell.OnLongPress = function(self)
  -- function num : 0_6
  (self._delegate):OnCellLongPress(self._index)
end

return MailRoleOptionalCell

