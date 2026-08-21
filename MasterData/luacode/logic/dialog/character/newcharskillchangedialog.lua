-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newcharskillchangedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Skill = require("logic.manager.experimental.types.skill")
local NewCharSkillChangeDialog = class("NewCharSkillChangeDialog", Dialog)
NewCharSkillChangeDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
NewCharSkillChangeDialog.AssetName = "CharSkillChange"
local needSkillNum = 2
local BottomToTop = 2
NewCharSkillChangeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewCharSkillChangeDialog
  ((NewCharSkillChangeDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._data = {}
  self._checkSkillList = {}
end

NewCharSkillChangeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, needSkillNum, _ENV
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._hasChooseNum = self:GetChild("Choose/Num")
  self._needChooseNum = self:GetChild("Choose/NumMax")
  self._field = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._field, self, true, true, true)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._needChooseNum):SetText(needSkillNum)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshWitchSkills, Common.n_RefreshWitchSkills, nil)
end

NewCharSkillChangeDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

NewCharSkillChangeDialog.Init = function(self, roleKey)
  -- function num : 0_3 , upvalues : _ENV
  self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
  self._checkSkillList = (self._role):GetSelectActiveSkillList()
  self._data = (self._role):GetActiveSkillList()
  self._ifReloadAllCell = true
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  self._ifReloadAllCell = false
  ;
  (self._hasChooseNum):SetText(tostring(#self._checkSkillList))
end

NewCharSkillChangeDialog.GetIfReloadAllCell = function(self)
  -- function num : 0_4
  return self._ifReloadAllCell
end

NewCharSkillChangeDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_5
  return #self._data
end

NewCharSkillChangeDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "character.newcharskillchangecell"
end

NewCharSkillChangeDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

NewCharSkillChangeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

NewCharSkillChangeDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_9
  if frame == self._frame then
    local width, height = (self._field):GetRectSize()
    local total = (self._frame):GetTotalLength()
    ;
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollValue(proportion)
    if height < total then
      (self._scrollBar):SetScrollSize(height / total)
    else
      ;
      (self._scrollBar):SetScrollSize(1)
    end
  end
end

NewCharSkillChangeDialog.OnSkillCheck = function(self, skillItemId, ifSelect)
  -- function num : 0_10 , upvalues : _ENV, needSkillNum
  if not self._ifReloadAllCell then
    local index = nil
    local haveSkill = false
    for i,id in ipairs(self._checkSkillList) do
      if id == skillItemId then
        if not ifSelect then
          index = i
          break
        end
        haveSkill = true
        break
      end
    end
    do
      do
        if index then
          (table.remove)(self._checkSkillList, index)
          ;
          (self._frame):FireEvent("InteractiveState", true)
        else
          if #self._checkSkillList < needSkillNum and not haveSkill then
            (table.insert)(self._checkSkillList, skillItemId)
          end
        end
        if #self._checkSkillList == needSkillNum then
          (self._confirmBtn):SetInteractable(true)
          ;
          (self._frame):FireEvent("InteractiveState", false)
        else
          ;
          (self._confirmBtn):SetInteractable(false)
        end
        ;
        (self._hasChooseNum):SetText(tostring(#self._checkSkillList))
      end
    end
  end
end

NewCharSkillChangeDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.skill.cselectwitchskills")
  csend.skillItemIds = self._checkSkillList
  csend:Send()
end

NewCharSkillChangeDialog.OnRefreshWitchSkills = function(self)
  -- function num : 0_12
  self:Destroy()
end

NewCharSkillChangeDialog.GetCheckSkillList = function(self)
  -- function num : 0_13
  return self._checkSkillList
end

return NewCharSkillChangeDialog

