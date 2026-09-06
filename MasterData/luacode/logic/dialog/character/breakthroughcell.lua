local CSkillShow_Role = BeanManager.GetTableByName("skill.cskillshow_role")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BreakThroughCell = class("BreakThroughCell", Dialog)
BreakThroughCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BreakThroughCell.AssetName = "BaseCharacterInfoBreak"

function BreakThroughCell:Ctor(...)
  BreakThroughCell.super.Ctor(self, ...)
  self._breakItemList = {}
end

function BreakThroughCell:OnCreate()
  self._curLevel = self:GetChild("Up/LeftPanel/LevelNum")
  self._curMaxLevel = self:GetChild("Up/LeftPanel/LevelMax")
  self._curLevelPoint = self:GetChild("Up/LeftPanel/LevelPoint")
  self._rightPanel = self:GetChild("Up/RightPanel")
  self._nextLevel = self:GetChild("Up/RightPanel/LevelNum")
  self._nextMaxLevel = self:GetChild("Up/RightPanel/LevelMax")
  self._nextLevelPoint = self:GetChild("Up/RightPanel/LevelPoint")
  self._curMaxLv = self:GetChild("Up/LevelMax/Txt2")
  self._nextMaxLv = self:GetChild("Up/LevelMax/Txt3")
  self._curCost = self:GetChild("Up/Cost/Txt2")
  self._bottom = self:GetChild("Bottom")
  self._itemPanel = self:GetChild("Bottom/CostItem/Item")
  self._needLevel = self:GetChild("Bottom/CostItem/Txt2")
  self._needSoul = self:GetChild("Bottom/Cost/Txt2")
  self._restSoul = self:GetChild("Bottom/Cost/Txt4")
  self._breakBtn = self:GetChild("Bottom/Cost/CommonButton2")
  self._maxTxt = self:GetChild("Up/MaxTxt")
  self._breakPoint = self:GetChild("Up/Point/BreakPoint")
  self._skillPanel = self:GetChild("Up/Lock")
  self._skillPanel:SetActive(false)
  self._label = self:GetChild("Up/Lock/Txt1")
  self._skillName = self:GetChild("Up/Lock/Txt2")
  self._frame = TableFrame.Create(self._itemPanel, self, false)
  self._frame:SetMargin(15, 0)
  self._breakBtn:Subscribe_PointerClickEvent(self.OnBreakBtnPointerClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnRoleBreakUp, Common.n_RoleInfoChange, nil)
end

function BreakThroughCell:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

local function CheckBreakLevel(self, rank, breakLv, passiveSkillList)
  if breakLv == 1 then
    if rank == 3 then
      self._skillPanel:SetActive(true)
      local str = TextManager.GetText(CStringRes:GetRecorder(1076).msgTextID)
      self._label:SetText(str)
      if passiveSkillList[1] then
        local show = CSkillShow_Role:GetRecorder(passiveSkillList[1].id)
        self._skillName:SetText(TextManager.GetText(show.nameTextID))
      else
        LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 1st passiveskill is empty")
      end
      return
    end
  elseif breakLv == 2 then
    if rank == 2 then
      self._skillPanel:SetActive(true)
      local str = TextManager.GetText(CStringRes:GetRecorder(1076).msgTextID)
      self._label:SetText(str)
      if passiveSkillList[1] then
        local show = CSkillShow_Role:GetRecorder(passiveSkillList[1].id)
        if not show then
          LogErrorFormat("BreakThroughCell", "--------- skillId = %s ------", passiveSkillList[1].id)
        end
        self._skillName:SetText(TextManager.GetText(show.nameTextID))
      else
        LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 1st passiveskill is empty")
      end
      return
    end
    if rank == 3 then
      self._skillPanel:SetActive(true)
      local str = TextManager.GetText(CStringRes:GetRecorder(1076).msgTextID)
      self._label:SetText(str)
      if passiveSkillList[2] then
        local show = CSkillShow_Role:GetRecorder(passiveSkillList[2].id)
        self._skillName:SetText(TextManager.GetText(show.nameTextID))
      else
        LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 2nd passiveskill is empty")
      end
      return
    end
  elseif breakLv == 4 then
    if rank == 1 then
      self._skillPanel:SetActive(true)
      local str = TextManager.GetText(CStringRes:GetRecorder(1076).msgTextID)
      self._label:SetText(str)
      if passiveSkillList[1] then
        local show = CSkillShow_Role:GetRecorder(passiveSkillList[1].id)
        self._skillName:SetText(TextManager.GetText(show.nameTextID))
      else
        LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 1st passiveskill is empty")
      end
      return
    end
    if rank == 2 then
      self._skillPanel:SetActive(true)
      local str = TextManager.GetText(CStringRes:GetRecorder(1076).msgTextID)
      self._label:SetText(str)
      if passiveSkillList[2] then
        local show = CSkillShow_Role:GetRecorder(passiveSkillList[2].id)
      else
        LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 2nd passiveskill is empty")
      end
      return
    end
    if rank == 3 then
      self._skillPanel:SetActive(true)
      local str = TextManager.GetText(CStringRes:GetRecorder(1076).msgTextID)
      self._label:SetText(str)
      if passiveSkillList[3] then
        local show = CSkillShow_Role:GetRecorder(passiveSkillList[3].id)
        self._skillName:SetText(TextManager.GetText(show.nameTextID))
      else
        LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 3th passiveskill is empty")
      end
      return
    end
  end
  self._skillPanel:SetActive(false)
end

function BreakThroughCell:RefreshCell(data)
  self._role = data
  local str = tostring(data:GetLevel())
  if data:GetLevel() < data:GetMaxLevel() then
    str = "<color=#ff0000ff>" .. str .. "</color>"
  end
  self._curLevel:SetText(str)
  self._curMaxLevel:SetText(data:GetMaxLevelIgnorePlayerLv())
  self._curMaxLv:SetText(data:GetMaxLevelIgnorePlayerLv())
  str = ""
  for i = 1, data:GetBreakLv() do
    str = str .. "1"
  end
  for i = 1, data:GetMaxBreakLv() - data:GetBreakLv() do
    str = str .. "0"
  end
  self._breakPoint:SetText(str)
  while self._breakItemList[#self._breakItemList] do
    table.remove(self._breakItemList, #self._breakItemList)
  end
  self._nextLevel:SetText(data:GetLevel())
  if data:GetNextBreakLv() and data:GetBreakLv() < data:GetNextBreakLv() then
    self._maxTxt:SetActive(false)
    self._bottom:SetActive(true)
    self._nextMaxLevel:SetText(data:GetNextBreakMaxLevel())
    self._nextMaxLv:SetText(data:GetNextBreakMaxLevel())
    self._breakItemList = self._role:GetBreakItemList()
    self._needSoul:SetNumber(self._role:GetBreakSoul())
    self._needLevel:SetText(data:GetMaxLevelIgnorePlayerLv())
  else
    self._nextMaxLevel:SetText(data:GetMaxLevelIgnorePlayerLv())
    self._bottom:SetActive(false)
  end
  local str
  self._mana = NekoData.BehaviorManager.BM_Currency:GetMoney()
  if self._mana > 10000 then
    str = tostring(math.floor(self._mana * 10 / 1000) / 10)
    str = str .. "k"
  else
    str = tostring(self._mana)
  end
  self._frame:ReloadAllCell()
  self._restSoul:SetText(str)
  local tag = false
  for i, v in ipairs(self._breakItemList) do
    local count = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v.itemId)
    if count >= v.itemNum then
      tag = true
    else
      tag = false
    end
  end
  if data:GetLevel() == data:GetMaxLevel() and tag and data:GetNextBreakLv() and data:GetBreakLv() < data:GetNextBreakLv() then
    self._breakBtn:SetInteractable(true)
  else
    self._breakBtn:SetInteractable(false)
  end
  CheckBreakLevel(self, data:GetRarityId(), data:GetNextBreakLv(), data:GetPassiveSkillList())
end

function BreakThroughCell:OnBreakBtnPointerClick()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(8, nil, function()
    local CRoleBreak = LuaNetManager.CreateProtocol("protocol.login.crolebreak")
    if CRoleBreak then
      local key = self._role:GetRoleId()
      CRoleBreak.roleId = key
      CRoleBreak:Send()
    end
  end, {}, nil, {})
end

function BreakThroughCell:NumberOfCell(frame)
  return #self._breakItemList
end

function BreakThroughCell:CellAtIndex(frame)
  return "character.breakitemcell"
end

function BreakThroughCell:DataAtIndex(frame, index)
  return self._breakItemList[index]
end

function BreakThroughCell:OnRoleBreakUp(notification)
  if notification.userInfo.name == "sroleupdatebreaklv" then
    CheckBreakLevel(self, self._role:GetRarityId(), self._role:GetNextBreakLv(), self._role:GetPassiveSkillList())
  end
end

return BreakThroughCell
