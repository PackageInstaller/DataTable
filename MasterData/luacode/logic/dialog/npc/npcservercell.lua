local NpcServiceAll = BeanManager.GetTableByName("npc.cserviceall")
local NpcServerCell = class("NpcServerCell", Dialog)
NpcServerCell.AssetBundleName = "ui/layouts.dramadialog"
NpcServerCell.AssetName = "DramaSelectionCell"

function NpcServerCell:Ctor(...)
  NpcServerCell.super.Ctor(self, ...)
end

function NpcServerCell:OnCreate()
  self._text = self:GetChild("Select1/_Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function NpcServerCell:OnDestroy()
end

function NpcServerCell:RefreshCell(data)
  self._data = data
  local service = NpcServiceAll:GetRecorder(data.serverID)
  self._text:SetText(service.severStr)
end

function NpcServerCell:OnCellClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.npc.cnpcservice")
  csend.npcId = self._data.npcID
  csend.serviceId = self._data.serverID
  csend:Send()
end

return NpcServerCell
