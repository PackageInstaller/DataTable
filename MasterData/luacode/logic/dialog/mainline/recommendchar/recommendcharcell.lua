local CBattleTypeCfg = BeanManager.GetTableByName("role.cbattletypecfg")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local RecommendCharCell = class("RecommendCharCell", Dialog)
RecommendCharCell.AssetBundleName = "ui/layouts.mainline"
RecommendCharCell.AssetName = "RecommendCharCell"

function RecommendCharCell:Ctor(...)
  RecommendCharCell.super.Ctor(self, ...)
  self._rolesId = {}
  self._index = 0
end

function RecommendCharCell:OnCreate()
  self._title = self:GetChild("Title")
  self._rolePanel = self:GetChild("Frame")
  self._roleFrame = GridFrame.Create(self._rolePanel, self, true, 3, false)
  self._x, self._ox, self._y, self._oy = self._rolePanel:GetSize()
  self._rootX, self._rootOX, self._rooty, self._rootOY = self:GetRootWindow():GetSize()
end

function RecommendCharCell:OnDestroy()
  self._roleFrame:Destroy()
end

function RecommendCharCell:RefreshCell(data)
  self._index = data.index
  local recorder = CBattleTypeCfg:GetRecorder(data.typeid)
  if recorder then
    self._title:SetText(TextManager.GetText(recorder.typenameTextID))
  else
    self._title:SetText("")
  end
  self._rolesId = data.roleids
  self._roleFrame:ReloadAllCell()
  local totallength = self._roleFrame:GetTotalLength()
  self._rolePanel:SetSize(self._x, self._ox, 0, totallength)
  self:GetRootWindow():SetSize(self._rootX, self._rootOX, 0, self._rootOY + (totallength - self._oy))
  self._roleFrame:ReloadAllCell()
end

function RecommendCharCell:OnCellClicked(data)
  self._delegate:OnCellClicked(self._index, data)
end

function RecommendCharCell:CellAtIndex(frame, index)
  return "mainline.recommendchar.recommendcharcharactercell"
end

function RecommendCharCell:DataAtIndex(frame, index)
  return self._rolesId[index]
end

function RecommendCharCell:NumberOfCell(frame)
  return #self._rolesId
end

function RecommendCharCell:OnEvent(eventName, arg)
  if self._cellData and eventName == "SetSelectedRole" then
    self._roleFrame:FireEvent("SetSelectedRole", arg)
  end
end

return RecommendCharCell
