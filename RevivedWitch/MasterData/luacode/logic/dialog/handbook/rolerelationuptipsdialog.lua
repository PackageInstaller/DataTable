-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/rolerelationuptipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local RoleRelationUpTipsDialog = class("RoleRelationUpTipsDialog", Dialog)
RoleRelationUpTipsDialog.AssetBundleName = "ui/layouts.tujian"
RoleRelationUpTipsDialog.AssetName = "CharBookRelationTips"
RoleRelationUpTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleRelationUpTipsDialog
  ((RoleRelationUpTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

RoleRelationUpTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._value = self:GetChild("Tips/Text")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBackBtnClicked, Common.n_GlobalPointerWillDown, nil)
end

RoleRelationUpTipsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

RoleRelationUpTipsDialog.SetData = function(self, data)
  -- function num : 0_3
  (self._value):SetText(data)
end

RoleRelationUpTipsDialog.OnBackBtnClicked = function(self, args)
  -- function num : 0_4
  self:Destroy()
end

return RoleRelationUpTipsDialog

