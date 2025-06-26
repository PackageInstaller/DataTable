-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/talentshowcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TalentShowCell = class("TalentShowCell", Dialog)
TalentShowCell.AssetBundleName = "ui/layouts.basecharacterinfo"
TalentShowCell.AssetName = "BaseCharacterInfoTalentCell"
TalentShowCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TalentShowCell
  ((TalentShowCell.super).Ctor)(self, ...)
  self._data = {}
end

TalentShowCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._field = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._field, self, false, false)
end

TalentShowCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
  end
end

TalentShowCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._data = {}
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(data.roleKey)
  local talentPage = role:GetTalentPage()
  if data.lineIndex == role:GetTalentRow() and data.pageIndex == talentPage then
    for i,v in ipairs(data.records) do
      local flag = false
      for _,p in ipairs(role:GetTalentInRowList()) do
        if i == p then
          flag = true
          break
        end
      end
      do
        do
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
          ;
          (table.insert)(self._data, temp)
          -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  else
    if data.pageIndex < talentPage or data.pageIndex == talentPage and data.lineIndex < role:GetTalentRow() then
      for i,v in ipairs(data.records) do
        local temp = {}
        temp.can = false
        temp.lock = false
        temp.record = v
        temp.roleKey = data.roleKey
        temp.pos = -1
        temp.pageIndex = data.pageIndex
        temp.lineIndex = data.lineIndex
        ;
        (table.insert)(self._data, temp)
      end
    else
      do
        for i,v in ipairs(data.records) do
          local temp = {}
          temp.can = false
          temp.lock = true
          temp.record = v
          temp.roleKey = data.roleKey
          temp.pos = -1
          temp.pageIndex = data.pageIndex
          temp.lineIndex = data.lineIndex
          ;
          (table.insert)(self._data, temp)
        end
        do
          ;
          (self._frame):ReloadAllCell()
        end
      end
    end
  end
end

TalentShowCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

TalentShowCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "character.talentshowcellcell"
end

TalentShowCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

return TalentShowCell

