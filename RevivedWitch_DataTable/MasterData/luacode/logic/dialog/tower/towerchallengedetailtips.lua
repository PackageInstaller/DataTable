-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towerchallengedetailtips.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CTowerDungeonType = (BeanManager.GetTableByName)("dungeonselect.ctowerdungeontype")
local TowerChallengeDetailTips = class("TowerChallengeDetailTips", Dialog)
TowerChallengeDetailTips.AssetBundleName = "ui/layouts.mainline"
TowerChallengeDetailTips.AssetName = "TowerDetail"
TowerChallengeDetailTips.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerChallengeDetailTips
  ((TowerChallengeDetailTips.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

TowerChallengeDetailTips.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._title = self:GetChild("Back/Title")
  self._detailTxt = self:GetChild("Back/Text1")
  self._confirmTxt = self:GetChild("Back/Text3")
  self._cellArea = self:GetChild("Back/Frame")
  self._cellFrame = (TableFrame.Create)(self._cellArea, self, false, true)
  self._cancelBtn = self:GetChild("Back/CancelButton")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn = self:GetChild("Back/ConfirmButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

TowerChallengeDetailTips.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

TowerChallengeDetailTips.SetData = function(self, id)
  -- function num : 0_3 , upvalues : CTowerDungeonType, _ENV, CStringRes
  self._id = id
  self._itemList = {}
  local record = CTowerDungeonType:GetRecorder(id)
  for _,v in pairs(record.sureDropItems) do
    (table.insert)(self._itemList, {id = v, state = "Normal"})
  end
  for _,v in pairs(record.mayDropItems) do
    (table.insert)(self._itemList, {id = v, state = "Chance"})
  end
  ;
  (self._title):SetText((TextManager.GetText)(record.nameTextID))
  ;
  (self._detailTxt):SetText((TextManager.GetText)(record.describeTextID))
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1214)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", (TextManager.GetText)(record.nameTextID))
  ;
  (self._confirmTxt):SetText(str)
  ;
  (self._cellFrame):ReloadAllCell()
end

TowerChallengeDetailTips.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._itemList
end

TowerChallengeDetailTips.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "tower.towerchallengedetailcell"
end

TowerChallengeDetailTips.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  local data = {}
  data.id = ((self._itemList)[index]).id
  data.state = ((self._itemList)[index]).state
  return data
end

TowerChallengeDetailTips.OnItemCellClick = function(self, itemid)
  -- function num : 0_7
  (self._cellFrame):FireEvent("ChangeSelectItem", itemid)
end

TowerChallengeDetailTips.OnConfirmBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.battle.cstarttowerexplore")
  if protocol then
    protocol.tower = self._id
    protocol:Send()
  end
  self:Destroy()
end

TowerChallengeDetailTips.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

return TowerChallengeDetailTips

