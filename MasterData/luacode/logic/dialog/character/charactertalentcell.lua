local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CharacterTalentCell = class("CharacterTalentCell", Dialog)
CharacterTalentCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterTalentCell.AssetName = "BaseCharacterInfoTalent"
local TianFuPageCount = 5

function CharacterTalentCell:Ctor(...)
  CharacterTalentCell.super.Ctor(self, ...)
  self._data = {}
  self._which = 1
end

function CharacterTalentCell:OnCreate()
  self._tianfuBtn = {}
  for i = 1, TianFuPageCount do
    self._tianfuBtn[i] = self:GetChild("BtnArea/GroupBtn" .. i)
  end
  self._empty = self:GetChild("Empty")
  self._unLockCondition = self:GetChild("Empty/Text")
  self._field = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._field, self, true, true, true)
  for i = 1, TianFuPageCount do
    self._tianfuBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnTianfuBtnClicked(i)
    end, self)
  end
  LuaNotificationCenter.AddObserver(self, self.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
end

function CharacterTalentCell:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function CharacterTalentCell:RefreshCell(data)
  self._roleKey = data:GetRoleId()
  self:OnTianfuBtnClicked(self._which)
end

function CharacterTalentCell:Refresh()
  self._data = {}
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._roleKey)
  local breakLv = role:GetBreakLv()
  if self._which <= breakLv + 1 then
    self._empty:SetActive(false)
    self._field:SetActive(true)
    local t = role:GetXPageTalentRecord(self._which)
    for i, v in ipairs(t) do
      local temp = {}
      temp.pageIndex = self._which
      temp.roleKey = self._roleKey
      temp.lineIndex = i
      temp.records = v
      table.insert(self._data, temp)
    end
    self._frame:ReloadAllCell()
    self._frame:MoveToTop()
  else
    self._empty:SetActive(true)
    self._field:SetActive(false)
    local base = 1093
    local str = TextManager.GetText(CStringRes:GetRecorder(base + self._which - 1).msgTextID)
    self._unLockCondition:SetText(str)
  end
end

function CharacterTalentCell:NumberOfCell(frame)
  return #self._data
end

function CharacterTalentCell:CellAtIndex(frame, index)
  return "character.talentshowcell"
end

function CharacterTalentCell:DataAtIndex(frame, index)
  return self._data[index]
end

function CharacterTalentCell:OnTianfuBtnClicked(i)
  self._which = i
  self:Refresh()
  for j = 1, TianFuPageCount do
    self._tianfuBtn[j]:SetSelected(false)
  end
  self._tianfuBtn[i]:SetSelected(true)
end

function CharacterTalentCell:OnRoleInfoChange(notification)
  if notification.userInfo.name == "sunlocktalent" then
    DialogManager.DestroySingletonDialog("character.charactertalentcanunlockdialog")
    self:OnTianfuBtnClicked(self._which)
  end
end

return CharacterTalentCell
