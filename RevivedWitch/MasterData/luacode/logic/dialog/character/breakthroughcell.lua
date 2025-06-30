-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/breakthroughcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BreakThroughCell = class("BreakThroughCell", Dialog)
BreakThroughCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BreakThroughCell.AssetName = "BaseCharacterInfoBreak"
BreakThroughCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BreakThroughCell
  ((BreakThroughCell.super).Ctor)(self, ...)
  self._breakItemList = {}
end

BreakThroughCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
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
  ;
  (self._skillPanel):SetActive(false)
  self._label = self:GetChild("Up/Lock/Txt1")
  self._skillName = self:GetChild("Up/Lock/Txt2")
  self._frame = (TableFrame.Create)(self._itemPanel, self, false)
  ;
  (self._frame):SetMargin(15, 0)
  ;
  (self._breakBtn):Subscribe_PointerClickEvent(self.OnBreakBtnPointerClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleBreakUp, Common.n_RoleInfoChange, nil)
end

BreakThroughCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

local CheckBreakLevel = function(self, rank, breakLv, passiveSkillList)
  -- function num : 0_3 , upvalues : _ENV, CStringRes, CSkillShow_Role
  -- DECOMPILER ERROR at PC7: Unhandled construct in 'MakeBoolean' P1

  if breakLv == 1 and rank == 3 then
    (self._skillPanel):SetActive(true)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1076)).msgTextID)
    ;
    (self._label):SetText(str)
    if passiveSkillList[1] then
      local show = CSkillShow_Role:GetRecorder((passiveSkillList[1]).id)
      ;
      (self._skillName):SetText((TextManager.GetText)(show.nameTextID))
    else
      do
        do
          LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 1st passiveskill is empty")
          do return  end
          if breakLv == 2 then
            if rank == 2 then
              (self._skillPanel):SetActive(true)
              local str = (TextManager.GetText)((CStringRes:GetRecorder(1076)).msgTextID)
              ;
              (self._label):SetText(str)
              if passiveSkillList[1] then
                local show = CSkillShow_Role:GetRecorder((passiveSkillList[1]).id)
                if not show then
                  LogErrorFormat("BreakThroughCell", "--------- skillId = %s ------", (passiveSkillList[1]).id)
                end
                ;
                (self._skillName):SetText((TextManager.GetText)(show.nameTextID))
              else
                do
                  do
                    LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 1st passiveskill is empty")
                    do return  end
                    if rank == 3 then
                      (self._skillPanel):SetActive(true)
                      local str = (TextManager.GetText)((CStringRes:GetRecorder(1076)).msgTextID)
                      ;
                      (self._label):SetText(str)
                      if passiveSkillList[2] then
                        local show = CSkillShow_Role:GetRecorder((passiveSkillList[2]).id)
                        ;
                        (self._skillName):SetText((TextManager.GetText)(show.nameTextID))
                      else
                        do
                          do
                            LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 2nd passiveskill is empty")
                            do return  end
                            if breakLv == 4 then
                              if rank == 1 then
                                (self._skillPanel):SetActive(true)
                                local str = (TextManager.GetText)((CStringRes:GetRecorder(1076)).msgTextID)
                                ;
                                (self._label):SetText(str)
                                if passiveSkillList[1] then
                                  local show = CSkillShow_Role:GetRecorder((passiveSkillList[1]).id)
                                  ;
                                  (self._skillName):SetText((TextManager.GetText)(show.nameTextID))
                                else
                                  do
                                    do
                                      LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 1st passiveskill is empty")
                                      do return  end
                                      if rank == 2 then
                                        (self._skillPanel):SetActive(true)
                                        local str = (TextManager.GetText)((CStringRes:GetRecorder(1076)).msgTextID)
                                        ;
                                        (self._label):SetText(str)
                                        if passiveSkillList[2] then
                                          local show = CSkillShow_Role:GetRecorder((passiveSkillList[2]).id)
                                        else
                                          do
                                            do
                                              LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 2nd passiveskill is empty")
                                              do return  end
                                              if rank == 3 then
                                                (self._skillPanel):SetActive(true)
                                                local str = (TextManager.GetText)((CStringRes:GetRecorder(1076)).msgTextID)
                                                ;
                                                (self._label):SetText(str)
                                                if passiveSkillList[3] then
                                                  local show = CSkillShow_Role:GetRecorder((passiveSkillList[3]).id)
                                                  ;
                                                  (self._skillName):SetText((TextManager.GetText)(show.nameTextID))
                                                else
                                                  do
                                                    do
                                                      LogWarning("BreakThroughCell", "rank " .. rank .. ", breakLv " .. breakLv .. ", 3th passiveskill is empty")
                                                      do return  end
                                                      ;
                                                      (self._skillPanel):SetActive(false)
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BreakThroughCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, CheckBreakLevel
  self._role = data
  local str = tostring(data:GetLevel())
  if data:GetLevel() < data:GetMaxLevel() then
    str = "<color=#ff0000ff>" .. str .. "</color>"
  end
  ;
  (self._curLevel):SetText(str)
  ;
  (self._curMaxLevel):SetText(data:GetMaxLevelIgnorePlayerLv())
  ;
  (self._curMaxLv):SetText(data:GetMaxLevelIgnorePlayerLv())
  str = ""
  for i = 1, data:GetBreakLv() do
    str = str .. "1"
  end
  for i = 1, data:GetMaxBreakLv() - data:GetBreakLv() do
    str = str .. "0"
  end
  ;
  (self._breakPoint):SetText(str)
  while (self._breakItemList)[#self._breakItemList] do
    (table.remove)(self._breakItemList, #self._breakItemList)
  end
  ;
  (self._nextLevel):SetText(data:GetLevel())
  if data:GetNextBreakLv() and data:GetBreakLv() < data:GetNextBreakLv() then
    (self._maxTxt):SetActive(false)
    ;
    (self._bottom):SetActive(true)
    ;
    (self._nextMaxLevel):SetText(data:GetNextBreakMaxLevel())
    ;
    (self._nextMaxLv):SetText(data:GetNextBreakMaxLevel())
    self._breakItemList = (self._role):GetBreakItemList()
    ;
    (self._needSoul):SetNumber((self._role):GetBreakSoul())
    ;
    (self._needLevel):SetText(data:GetMaxLevelIgnorePlayerLv())
  else
    ;
    (self._nextMaxLevel):SetText(data:GetMaxLevelIgnorePlayerLv())
    ;
    (self._bottom):SetActive(false)
  end
  local str = nil
  self._mana = ((NekoData.BehaviorManager).BM_Currency):GetMoney()
  if self._mana > 10000 then
    str = tostring((math.floor)(self._mana * 10 / 1000) / 10)
    str = str .. "k"
  else
    str = tostring(self._mana)
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._restSoul):SetText(str)
  local tag = false
  for i,v in ipairs(self._breakItemList) do
    local count = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v.itemId)
    if v.itemNum <= count then
      tag = true
    else
      tag = false
    end
  end
  if data:GetLevel() == data:GetMaxLevel() and tag and data:GetNextBreakLv() and data:GetBreakLv() < data:GetNextBreakLv() then
    (self._breakBtn):SetInteractable(true)
  else
    ;
    (self._breakBtn):SetInteractable(false)
  end
  CheckBreakLevel(self, data:GetRarityId(), data:GetNextBreakLv(), data:GetPassiveSkillList())
end

BreakThroughCell.OnBreakBtnPointerClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(8, nil, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    local CRoleBreak = (LuaNetManager.CreateProtocol)("protocol.login.crolebreak")
    if CRoleBreak then
      local key = (self._role):GetRoleId()
      CRoleBreak.roleId = key
      CRoleBreak:Send()
    end
  end
, {}, nil, {})
end

BreakThroughCell.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._breakItemList
end

BreakThroughCell.CellAtIndex = function(self, frame)
  -- function num : 0_7
  return "character.breakitemcell"
end

BreakThroughCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._breakItemList)[index]
end

BreakThroughCell.OnRoleBreakUp = function(self, notification)
  -- function num : 0_9 , upvalues : CheckBreakLevel
  if (notification.userInfo).name == "sroleupdatebreaklv" then
    CheckBreakLevel(self, (self._role):GetRarityId(), (self._role):GetNextBreakLv(), (self._role):GetPassiveSkillList())
  end
end

return BreakThroughCell

