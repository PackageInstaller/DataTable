-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/firtstrechargetip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FirtstRechargeTip = class("FirtstRechargeTip", Dialog)
FirtstRechargeTip.AssetBundleName = "ui/layouts.welfare"
FirtstRechargeTip.AssetName = "FirstRechargeTips"
FirtstRechargeTip.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FirtstRechargeTip
  ((FirtstRechargeTip.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

FirtstRechargeTip.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.AddObserver)(self, self.OnBackBtnClicked, Common.n_GlobalPointerWillDown, nil)
end

FirtstRechargeTip.OnDestroy = function(self)
  -- function num : 0_2
end

FirtstRechargeTip.RefreshTabCell = function(self)
  -- function num : 0_3
end

FirtstRechargeTip.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return FirtstRechargeTip

