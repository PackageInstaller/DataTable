local TableFrame = require("framework.ui.frame.table.tableframe")
local TalentShowCell = class("TalentShowCell", Dialog)
TalentShowCell.AssetBundleName = "ui/layouts.basecharacterinfo"
TalentShowCell.AssetName = "BaseCharacterInfoTalentCell"

function TalentShowCell:Ctor(...)
  TalentShowCell.super.Ctor(self, ...)
  self._data = {}
end

function TalentShowCell:OnCreate()
  self._field = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._field, self, false, false)
end

function TalentShowCell:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function TalentShowCell:RefreshCell(data)
  self._data = {}
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(data.roleKey)
  local talentPage = role:GetTalentPage()
  if data.lineIndex == role:GetTalentRow() and data.pageIndex == talentPage then
    for i, v in ipairs(data.records) do
      local flag = false
      for _, p in ipairs(role:GetTalentInRowList()) do
        if i == p then
          flag = true
          break
        end
      end
      local temp = {}
      if flag then
        temp.can = false
        temp.lock = false
        temp.pos = -1
      else
        temp.can = true
        temp.lock = true
        temp.pos = i
      end
      temp.record = v
      temp.roleKey = data.roleKey
      temp.pageIndex = data.pageIndex
      temp.lineIndex = data.lineIndex
      table.insert(self._data, temp)
    end
  elseif talentPage > data.pageIndex or data.pageIndex == talentPage and data.lineIndex < role:GetTalentRow() then
    for i, v in ipairs(data.records) do
      local temp = {}
      temp.can = false
      temp.lock = false
      temp.record = v
      temp.roleKey = data.roleKey
      temp.pos = -1
      temp.pageIndex = data.pageIndex
      temp.lineIndex = data.lineIndex
      table.insert(self._data, temp)
    end
  else
    for i, v in ipairs(data.records) do
      local temp = {}
      temp.can = false
      temp.lock = true
      temp.record = v
      temp.roleKey = data.roleKey
      temp.pos = -1
      temp.pageIndex = data.pageIndex
      temp.lineIndex = data.lineIndex
      table.insert(self._data, temp)
    end
  end
  self._frame:ReloadAllCell()
end

function TalentShowCell:NumberOfCell(frame)
  return #self._data
end

function TalentShowCell:CellAtIndex(frame, index)
  return "character.talentshowcellcell"
end

function TalentShowCell:DataAtIndex(frame, index)
  return self._data[index]
end

return TalentShowCell
