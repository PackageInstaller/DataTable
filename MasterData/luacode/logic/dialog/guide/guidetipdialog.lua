-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guide/guidetipdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideTipDialog = class("GuideTipDialog", Dialog)
GuideTipDialog.Ctor = function(self)
  -- function num : 0_0
end

GuideTipDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("")
end

GuideTipDialog.SetTip = function(self, id)
  -- function num : 0_2 , upvalues : _ENV
  local word = (TextManager.GetText)(id)
end

return GuideTipDialog

