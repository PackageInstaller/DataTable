-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/toweritips.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TowerITips = class("TowerITips", Dialog)
TowerITips.AssetBundleName = "ui/layouts.mainline"
TowerITips.AssetName = "TowerDetailTips"
TowerITips.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerITips
  ((TowerITips.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

TowerITips.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

TowerITips.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerITips.OnDialogClicked = function(self, args)
  -- function num : 0_3 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

TowerITips.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return TowerITips

