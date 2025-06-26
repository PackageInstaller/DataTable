-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/timeline/timelineblackdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TimelineBlackDialog = class("TimelineBlackDialog", Dialog)
TimelineBlackDialog.AssetBundleName = "ui/layouts.dramadialog"
TimelineBlackDialog.AssetName = "DramaBlackNarrator"
TimelineBlackDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TimelineBlackDialog
  ((TimelineBlackDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TimelineBlackDialog.SetData = function(self, value)
  -- function num : 0_1 , upvalues : _ENV
  local param = (string.split)(value, ";")
  if #param == 1 then
    if tonumber(value) then
      (self:GetRootWindow()):SetAnimatorInteger("curtainStyle", tonumber(value))
    else
      if value == "unscale" then
        ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self:GetRootWindow())._uiObject)
      end
    end
  else
    if #param == 2 then
      (self:GetRootWindow()):SetAnimatorInteger("curtainStyle", tonumber(param[1]))
      if param[2] == "unscale" then
        ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self:GetRootWindow())._uiObject)
      end
    else
      ;
      (self:GetRootWindow()):SetAnimatorInteger("curtainStyle", tonumber(value))
    end
  end
end

TimelineBlackDialog.OnCreate = function(self)
  -- function num : 0_2
  (self:GetRootWindow()):Subscribe_StateEnterEvent(self.OnAnimatorStateEnter, self)
end

TimelineBlackDialog.OnAnimatorStateEnter = function(self, handle, stateName, normalizedTime)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("timeline.timelineblackdialog")
end

TimelineBlackDialog.AddNewModal = function(self)
  -- function num : 0_4
end

return TimelineBlackDialog

