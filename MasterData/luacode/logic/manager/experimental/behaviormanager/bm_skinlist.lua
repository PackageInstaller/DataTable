local BM_SkinList = class("BM_SkinList")
local CSkinItem = BeanManager.GetTableByName("item.cskinitem")
local RoleSkin = require("logic.manager.experimental.types.roleskin")

function BM_SkinList:Ctor()
  self._data = NekoData.Data.skinlist
end

function BM_SkinList:GetSkinList()
  return self._data.skinlist
end

function BM_SkinList:GetCurrentSkinNum()
  return self._data.currentNum
end

function BM_SkinList:GetSkinCollectTask()
  return self._data.taskstate
end

function BM_SkinList:IsUnLockSkin(id)
  return self._data.skinlist[id] == 1
end

function BM_SkinList:IsUnLockSkinByItemId(id)
  local skinIDCfg = CSkinItem:GetRecorder(id)
  local skinItem = RoleSkin.Create(skinIDCfg.Skinid)
  return self:IsUnLockSkin(skinItem:GetSkinId())
end

function BM_SkinList:IsHasBoxReddot()
  for k, v in pairs(self._data.taskstate) do
    if v == 1 then
      return true
    end
  end
  return
end

function BM_SkinList:GetProcessStr()
  return tostring(self._data.currentNum) .. "/" .. tostring(self._data.totalskinNum)
end

return BM_SkinList
