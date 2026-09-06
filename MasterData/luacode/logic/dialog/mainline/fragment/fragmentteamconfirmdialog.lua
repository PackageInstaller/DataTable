local TableFrame = require("framework.ui.frame.table.tableframe")
local FragmentTeamConfirmDialog = class("FragmentTeamConfirmDialog", Dialog)
FragmentTeamConfirmDialog.AssetBundleName = "ui/layouts.fragment"
FragmentTeamConfirmDialog.AssetName = "FragmentTeamConfirm"

function FragmentTeamConfirmDialog:Ctor(...)
  FragmentTeamConfirmDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

function FragmentTeamConfirmDialog:OnCreate()
  self._frameUI = self:GetChild("CellFrame")
  self._frame = TableFrame.Create(self._frameUI, self, false, false)
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
end

function FragmentTeamConfirmDialog:OnDestroy()
  self._frame:Destroy()
end

function FragmentTeamConfirmDialog:SetData(data, index)
  if #self._data > 0 then
    LogError("FragmentTeamConfirmDialog", "Team data already exists!")
  end
  self._data = {}
  for i, v in ipairs(data) do
    if v ~= -1 then
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(v)
      table.insert(self._data, role)
    end
  end
  self.index = index
  self._frame:ReloadAllCell()
end

function FragmentTeamConfirmDialog:OnBackBtnClicked()
  self:Destroy()
end

function FragmentTeamConfirmDialog:OnConfirmBtnClick()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
  if csend then
    csend.battleType = csend.SHATTERED
    csend.id = self.index
    csend.lineupID = 0
    local temp = {}
    if self._data[1] then
      temp[1] = self._data[1]:GetRoleId()
    end
    if self._data[2] then
      temp[2] = self._data[2]:GetRoleId()
    end
    if self._data[3] then
      temp[3] = self._data[3]:GetRoleId()
    end
    csend.lineup = temp
    csend:Send()
  end
  self:Destroy()
end

function FragmentTeamConfirmDialog:NumberOfCell(frame, index)
  return #self._data
end

function FragmentTeamConfirmDialog:CellAtIndex(frame, index)
  return "mainline.fragment.teamrecordcharcell"
end

function FragmentTeamConfirmDialog:DataAtIndex(frame, index)
  return self._data[index]
end

return FragmentTeamConfirmDialog
