-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/charactertalentcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CharacterTalentCell = class("CharacterTalentCell", Dialog)
CharacterTalentCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterTalentCell.AssetName = "BaseCharacterInfoTalent"
local TianFuPageCount = 5
CharacterTalentCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterTalentCell
  ((CharacterTalentCell.super).Ctor)(self, ...)
  self._data = {}
  self._which = 1
end

CharacterTalentCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TianFuPageCount, TableFrame, _ENV
  self._tianfuBtn = {}
  for i = 1, TianFuPageCount do
    do
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

      (self._tianfuBtn)[i] = self:GetChild("BtnArea/GroupBtn" .. i)
    end
  end
  self._empty = self:GetChild("Empty")
  self._unLockCondition = self:GetChild("Empty/Text")
  self._field = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._field, self, true, true, true)
  for i = 1, TianFuPageCount do
    ((self._tianfuBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnTianfuBtnClicked(i)
  end
, self)
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
end

CharacterTalentCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

CharacterTalentCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._roleKey = data:GetRoleId()
  self:OnTianfuBtnClicked(self._which)
end

CharacterTalentCell.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._data = {}
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(self._roleKey)
  local breakLv = role:GetBreakLv()
  if self._which <= breakLv + 1 then
    (self._empty):SetActive(false)
    ;
    (self._field):SetActive(true)
    local t = role:GetXPageTalentRecord(self._which)
    for i,v in ipairs(t) do
      local temp = {}
      temp.pageIndex = self._which
      temp.roleKey = self._roleKey
      temp.lineIndex = i
      temp.records = v
      ;
      (table.insert)(self._data, temp)
    end
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  else
    do
      ;
      (self._empty):SetActive(true)
      ;
      (self._field):SetActive(false)
      local base = 1093
      local str = (TextManager.GetText)((CStringRes:GetRecorder(base + self._which - 1)).msgTextID)
      ;
      (self._unLockCondition):SetText(str)
    end
  end
end

CharacterTalentCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

CharacterTalentCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "character.talentshowcell"
end

CharacterTalentCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

CharacterTalentCell.OnTianfuBtnClicked = function(self, i)
  -- function num : 0_8 , upvalues : TianFuPageCount
  self._which = i
  self:Refresh()
  for j = 1, TianFuPageCount do
    ((self._tianfuBtn)[j]):SetSelected(false)
  end
  ;
  ((self._tianfuBtn)[i]):SetSelected(true)
end

CharacterTalentCell.OnRoleInfoChange = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV
  if (notification.userInfo).name == "sunlocktalent" then
    (DialogManager.DestroySingletonDialog)("character.charactertalentcanunlockdialog")
    self:OnTianfuBtnClicked(self._which)
  end
end

return CharacterTalentCell

