local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CTowerDungeonType = BeanManager.GetTableByName("dungeonselect.ctowerdungeontype")
local TowerChallengeDetailTips = class("TowerChallengeDetailTips", Dialog)
TowerChallengeDetailTips.AssetBundleName = "ui/layouts.mainline"
TowerChallengeDetailTips.AssetName = "TowerDetail"

function TowerChallengeDetailTips:Ctor(...)
  TowerChallengeDetailTips.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function TowerChallengeDetailTips:OnCreate()
  self._title = self:GetChild("Back/Title")
  self._detailTxt = self:GetChild("Back/Text1")
  self._confirmTxt = self:GetChild("Back/Text3")
  self._cellArea = self:GetChild("Back/Frame")
  self._cellFrame = TableFrame.Create(self._cellArea, self, false, true)
  self._cancelBtn = self:GetChild("Back/CancelButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn = self:GetChild("Back/ConfirmButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function TowerChallengeDetailTips:OnDestroy()
  self._cellFrame:Destroy()
end

function TowerChallengeDetailTips:SetData(id)
  self._id = id
  self._itemList = {}
  local record = CTowerDungeonType:GetRecorder(id)
  for _, v in pairs(record.sureDropItems) do
    table.insert(self._itemList, {id = v, state = "Normal"})
  end
  for _, v in pairs(record.mayDropItems) do
    table.insert(self._itemList, {id = v, state = "Chance"})
  end
  self._title:SetText(TextManager.GetText(record.nameTextID))
  self._detailTxt:SetText(TextManager.GetText(record.describeTextID))
  local str = TextManager.GetText(CStringRes:GetRecorder(1214).msgTextID)
  str = string.gsub(str, "%$parameter1%$", TextManager.GetText(record.nameTextID))
  self._confirmTxt:SetText(str)
  self._cellFrame:ReloadAllCell()
end

function TowerChallengeDetailTips:NumberOfCell(frame)
  return #self._itemList
end

function TowerChallengeDetailTips:CellAtIndex(frame, index)
  return "tower.towerchallengedetailcell"
end

function TowerChallengeDetailTips:DataAtIndex(frame, index)
  local data = {}
  data.id = self._itemList[index].id
  data.state = self._itemList[index].state
  return data
end

function TowerChallengeDetailTips:OnItemCellClick(itemid)
  self._cellFrame:FireEvent("ChangeSelectItem", itemid)
end

function TowerChallengeDetailTips:OnConfirmBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.battle.cstarttowerexplore")
  if protocol then
    protocol.tower = self._id
    protocol:Send()
  end
  self:Destroy()
end

function TowerChallengeDetailTips:OnBackBtnClicked()
  self:Destroy()
end

return TowerChallengeDetailTips
