local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local FpsCell = class("FpsCell", Dialog)
FpsCell.AssetBundleName = "ui/layouts.setting"
FpsCell.AssetName = "SettingSystemFPS"

function FpsCell:Ctor(...)
  FpsCell.super.Ctor(self, ...)
  self._fpsToggleList = {}
end

function FpsCell:OnCreate()
  for i = 1, 2 do
    self._fpsToggleList[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
    self._fpsToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
end

function FpsCell:OnDestroy()
end

function FpsCell:RefreshCell()
  local value = NekoData.BehaviorManager.BM_Game:GetTheValueOfFPS()
  if value == 30 then
    self._fpsToggleList[1]:SetIsOnType(true)
    self._fpsToggleList[2]:SetIsOnType(false)
  elseif value == 60 then
    self._fpsToggleList[1]:SetIsOnType(false)
    self._fpsToggleList[2]:SetIsOnType(true)
  end
end

function FpsCell:OnValueChanged(index)
  if self._fpsToggleList[index]:GetIsOnType() then
    if index == 1 then
      NekoData.BehaviorManager.BM_Game:SetTheValueOfFPS(30)
    elseif index == 2 then
      NekoData.BehaviorManager.BM_Game:SetTheValueOfFPS(60)
    end
  end
end

return FpsCell
