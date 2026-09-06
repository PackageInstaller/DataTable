local TableFrame = require("framework.ui.frame.table.tableframe")
local Skill = require("logic.manager.experimental.types.skill")
local NewCharSkillChangeDialog = class("NewCharSkillChangeDialog", Dialog)
NewCharSkillChangeDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
NewCharSkillChangeDialog.AssetName = "CharSkillChange"
local needSkillNum = 2
local BottomToTop = 2

function NewCharSkillChangeDialog:Ctor(...)
  NewCharSkillChangeDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._data = {}
  self._checkSkillList = {}
end

function NewCharSkillChangeDialog:OnCreate()
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._hasChooseNum = self:GetChild("Choose/Num")
  self._needChooseNum = self:GetChild("Choose/NumMax")
  self._field = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._field, self, true, true, true)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._needChooseNum:SetText(needSkillNum)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshWitchSkills, Common.n_RefreshWitchSkills, nil)
end

function NewCharSkillChangeDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function NewCharSkillChangeDialog:Init(roleKey)
  self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
  self._checkSkillList = self._role:GetSelectActiveSkillList()
  self._data = self._role:GetActiveSkillList()
  self._ifReloadAllCell = true
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  self._ifReloadAllCell = false
  self._hasChooseNum:SetText(tostring(#self._checkSkillList))
end

function NewCharSkillChangeDialog:GetIfReloadAllCell()
  return self._ifReloadAllCell
end

function NewCharSkillChangeDialog:NumberOfCell(frame, index)
  return #self._data
end

function NewCharSkillChangeDialog:CellAtIndex(frame, index)
  return "character.newcharskillchangecell"
end

function NewCharSkillChangeDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function NewCharSkillChangeDialog:OnBackBtnClicked()
  self:Destroy()
end

function NewCharSkillChangeDialog:OnCurPosChange(frame, proportion)
  if frame == self._frame then
    local width, height = self._field:GetRectSize()
    local total = self._frame:GetTotalLength()
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollValue(proportion)
    if height < total then
      self._scrollBar:SetScrollSize(height / total)
    else
      self._scrollBar:SetScrollSize(1)
    end
  end
end

function NewCharSkillChangeDialog:OnSkillCheck(skillItemId, ifSelect)
  if not self._ifReloadAllCell then
    local index
    local haveSkill = false
    for i, id in ipairs(self._checkSkillList) do
      if id == skillItemId then
        if not ifSelect then
          index = i
          break
        end
        haveSkill = true
        break
      end
    end
    if index then
      table.remove(self._checkSkillList, index)
      self._frame:FireEvent("InteractiveState", true)
    elseif #self._checkSkillList < needSkillNum and not haveSkill then
      table.insert(self._checkSkillList, skillItemId)
    end
    if #self._checkSkillList == needSkillNum then
      self._confirmBtn:SetInteractable(true)
      self._frame:FireEvent("InteractiveState", false)
    else
      self._confirmBtn:SetInteractable(false)
    end
  end
  self._hasChooseNum:SetText(tostring(#self._checkSkillList))
end

function NewCharSkillChangeDialog:OnConfirmBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.skill.cselectwitchskills")
  csend.skillItemIds = self._checkSkillList
  csend:Send()
end

function NewCharSkillChangeDialog:OnRefreshWitchSkills()
  self:Destroy()
end

function NewCharSkillChangeDialog:GetCheckSkillList()
  return self._checkSkillList
end

return NewCharSkillChangeDialog
