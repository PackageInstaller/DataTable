-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/fpscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local FpsCell = class("FpsCell", Dialog)
FpsCell.AssetBundleName = "ui/layouts.setting"
FpsCell.AssetName = "SettingSystemFPS"
FpsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FpsCell
  ((FpsCell.super).Ctor)(self, ...)
  self._fpsToggleList = {}
end

FpsCell.OnCreate = function(self)
  -- function num : 0_1
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (self._fpsToggleList)[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
      ;
      ((self._fpsToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
end

FpsCell.OnDestroy = function(self)
  -- function num : 0_2
end

FpsCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local value = ((NekoData.BehaviorManager).BM_Game):GetTheValueOfFPS()
  if value == 30 then
    ((self._fpsToggleList)[1]):SetIsOnType(true)
    ;
    ((self._fpsToggleList)[2]):SetIsOnType(false)
  else
    if value == 60 then
      ((self._fpsToggleList)[1]):SetIsOnType(false)
      ;
      ((self._fpsToggleList)[2]):SetIsOnType(true)
    end
  end
end

FpsCell.OnValueChanged = function(self, index)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._fpsToggleList)[index]):GetIsOnType() then
    if index == 1 then
      ((NekoData.BehaviorManager).BM_Game):SetTheValueOfFPS(30)
    else
      if index == 2 then
        ((NekoData.BehaviorManager).BM_Game):SetTheValueOfFPS(60)
      end
    end
  end
end

return FpsCell

