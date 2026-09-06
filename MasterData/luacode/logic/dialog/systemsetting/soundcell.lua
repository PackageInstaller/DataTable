local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local SoundLevelTable = BeanManager.GetTableByName("setting.csoundlevel")
local SoundCell = class("SoundCell", Dialog)
SoundCell.AssetBundleName = "ui/layouts.setting"
SoundCell.AssetName = "SettingSystemSound"

function SoundCell:Ctor(...)
  SoundCell.super.Ctor(self, ...)
  self._soundToggleList = {}
end

function SoundCell:OnCreate()
  for i = 1, 4 do
    self._soundToggleList[i] = self:GetChild("ToggleGroup/Toggle" .. i)
    self._soundToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
end

function SoundCell:OnDestroy()
end

function SoundCell:RefreshCell()
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  for i, v in ipairs(self._soundToggleList) do
    if i == sysConfig[SysConfigEnum.soundEffectNum] then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

function SoundCell:OnValueChanged(index)
  if self._soundToggleList[index]:GetIsOnType() then
    local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.soundEffectNum] then
      map.typeKey = SysConfigEnum.soundEffectNum
      map.typeValue = index
      local record = SoundLevelTable:GetRecorder(2)
      local num = tonumber(record.soundLevel[index])
      if not num or num < tonumber(record.soundLevel[1]) or num > table.nums(record.soundLevel) then
        num = table.nums(record.soundLevel)
      end
      LuaAudioManager.SetCategoryVolume(tonumber(record.categoryID), tonumber(num))
    end
    if map.typeKey and map.typeValue then
      NekoData.DataManager.DM_Game:SetSystemConfig({
        [map.typeKey] = map.typeValue
      })
      local cchangesysconfig = LuaNetManager.CreateProtocol("protocol.user.cchangesysconfig")
      if cchangesysconfig then
        cchangesysconfig.configs[map.typeKey] = map.typeValue
        cchangesysconfig:Send()
      end
    end
  end
end

return SoundCell
