local DM_SkinList = class("DM_SkinList")

function DM_SkinList:Ctor()
  self._data = NekoData.Data.skinlist
  self._data.skinlist = {}
  self._data.taskstate = {}
  self._data.totalskinNum = 0
  self._data.currentNum = 0
end

function DM_SkinList:Clear()
  while self._data.skinlist[#self._data.skinlist] do
    table.remove(self._data.skinlist, #self._data.skinlist)
  end
  while self._data.taskstate[#self._data.taskstate] do
    table.remove(self._data.taskstate, #self._data.taskstate)
  end
  self._data.totalskinNum = 0
  self._data.currentNum = 0
end

function DM_SkinList:OnSGetSkinOverview(protocol)
  self._data.totalskinNum = 0
  self._data.currentNum = 0
  local str = ""
  for k, v in pairs(protocol.skins) do
    if v == 1 then
      self._data.currentNum = self._data.currentNum + 1
      str = str .. tostring(k) .. "," .. tostring(v) .. ";"
    end
    self._data.totalskinNum = self._data.totalskinNum + 1
    self._data.skinlist[k] = v
  end
end

function DM_SkinList:OnSAddOverviewSkin(protocol)
  if table.contain(self._data.skinlist, protocol.skinId) then
    LogErrorFormat("DM_SkinList", "SAddOverviewSkin Repeat Unlock %s", protocol.skinId)
    return
  end
  LogInfoFormat("DM_SkinList", "UnLock%d", protocol.skinId)
  self._data.skinlist[protocol.skinId] = 1
  self._data.currentNum = self._data.currentNum + 1
end

function DM_SkinList:OnSRefreshSkinCollectTask(protocol)
  local str = ""
  for k, v in ipairs(protocol.tasks) do
    str = str .. tostring(k) .. "," .. tostring(v) .. ";"
    self._data.taskstate[k] = v
  end
  LogInfoFormat("DM_SkinList", "OnSGetSkinOverview:%s", str)
end

return DM_SkinList
