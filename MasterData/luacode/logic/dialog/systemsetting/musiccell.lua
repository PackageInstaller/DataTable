local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local SoundLevelTable = BeanManager.GetTableByName("setting.csoundlevel")
local MusicCell = class("MusicCell", Dialog)
MusicCell.AssetBundleName = "ui/layouts.setting"
MusicCell.AssetName = "SettingSystemMusic"

function MusicCell:Ctor(...)
  MusicCell.super.Ctor(self, ...)
  self._musicToggleList = {}
end

function MusicCell:OnCreate()
  for i = 1, 4 do
    self._musicToggleList[i] = self:GetChild("ToggleGroup/Toggle" .. i)
    self._musicToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
end

function MusicCell:OnDestroy()
end

function MusicCell:RefreshCell()
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  for i, v in ipairs(self._musicToggleList) do
    if i == sysConfig[SysConfigEnum.musicNum] then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

function MusicCell:OnValueChanged(index)
  if self._musicToggleList[index]:GetIsOnType() then
    local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.musicNum] then
      map.typeKey = SysConfigEnum.musicNum
      map.typeValue = index
      local record = SoundLevelTable:GetRecorder(1)
      local num = tonumber(record.soundLevel[index])
      if not num or num > table.nums(record.soundLevel) then
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

return MusicCell
