-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/clickeffect/gmhideuicell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local GMHideUICell = class("GMHideUICell", Dialog)
GMHideUICell.AssetBundleName = "ui/layouts.gm"
GMHideUICell.AssetName = "GMHideUICell"
GMHideUICell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GMHideUICell
  ((GMHideUICell.super).Ctor)(self, ...)
end

GMHideUICell.OnCreate = function(self)
  -- function num : 0_1
  self._toggle = self:GetChild("_Toggle_0")
  self._text = self:GetChild("_Toggle_0/Label")
  ;
  (self._toggle):Subscribe_ValueChangedEvent(self.OnValueChanged, self)
end

GMHideUICell.OnDestroy = function(self)
  -- function num : 0_2
end

GMHideUICell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  (self._toggle):SetIsOnType(data.display)
  ;
  (self._text):SetText((TextManager.GetText)((CStringRes:GetRecorder((data.record).uIname)).msgTextID))
end

GMHideUICell.OnValueChanged = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local isOn = (self._toggle):GetIsOnType()
  if isOn ~= (self._cellData).display then
    ((NekoData.BehaviorManager).BM_Game):SetGMHideUIInfo((self._delegate)._tab, ((self._cellData).record).id, isOn)
  end
end

return GMHideUICell

