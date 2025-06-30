-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/equipsuittipdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipSuit = (BeanManager.GetTableByName)("equip.cequipsuit")
local UIManager = ((CS.PixelNeko).UI).UIManager
local EquipSuitTipDialog = class("EquipSuitTipDialog", Dialog)
EquipSuitTipDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
EquipSuitTipDialog.AssetName = "EquipSuitTips"
EquipSuitTipDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipSuitTipDialog
  ((EquipSuitTipDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

EquipSuitTipDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._back = self:GetChild("Back")
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

EquipSuitTipDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

EquipSuitTipDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CEquipSuit
  self._downDataList = {}
  for k,v in ipairs(data) do
    local suitId = v.suitId
    local skillIds = v.skillIds
    local suitRecorder = CEquipSuit:GetRecorder(suitId)
    local temp = {}
    temp.tag = "SuitInfo"
    temp.suitName = suitRecorder.suitName
    temp.suitImg = suitRecorder.suitImg
    ;
    (table.insert)(self._downDataList, temp)
    local skillIDs = suitRecorder.suitSkillID
    for i,v in ipairs(skillIDs) do
      if v ~= 0 then
        temp = {}
        temp.tag = "SuitSkill"
        temp.count = i
        temp.skillID = v
        for i,skillId in ipairs(skillIds) do
          if temp.skillID == skillId then
            temp.takeEffect = true
          end
        end
        ;
        (table.insert)(self._downDataList, temp)
      end
    end
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

EquipSuitTipDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._downDataList
end

EquipSuitTipDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if ((self._downDataList)[index]).tag == "SuitInfo" then
    return "character.equipsuittipssuitinfocell"
  else
    if ((self._downDataList)[index]).tag == "SuitSkill" then
      return "character.equipsuittipssuitskillcell"
    end
  end
end

EquipSuitTipDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._downDataList)[index]
end

EquipSuitTipDialog.ShouldLengthChange = function(self)
  -- function num : 0_7
  return true
end

EquipSuitTipDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  local x = (((args.userInfo).eventData).position).x
  local y = (((args.userInfo).eventData).position).y
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, x, y) then
    self:OnBackBtnClicked()
  end
end

EquipSuitTipDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

return EquipSuitTipDialog

