-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/npc/npcservercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NpcServiceAll = (BeanManager.GetTableByName)("npc.cserviceall")
local NpcServerCell = class("NpcServerCell", Dialog)
NpcServerCell.AssetBundleName = "ui/layouts.dramadialog"
NpcServerCell.AssetName = "DramaSelectionCell"
NpcServerCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NpcServerCell
  ((NpcServerCell.super).Ctor)(self, ...)
end

NpcServerCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Select1/_Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

NpcServerCell.OnDestroy = function(self)
  -- function num : 0_2
end

NpcServerCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : NpcServiceAll
  self._data = data
  local service = NpcServiceAll:GetRecorder(data.serverID)
  ;
  (self._text):SetText(service.severStr)
end

NpcServerCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.npc.cnpcservice")
  csend.npcId = (self._data).npcID
  csend.serviceId = (self._data).serverID
  csend:Send()
end

return NpcServerCell

