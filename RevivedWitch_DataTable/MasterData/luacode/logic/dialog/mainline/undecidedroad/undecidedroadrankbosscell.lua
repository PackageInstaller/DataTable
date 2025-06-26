-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadrankbosscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UndecidedRoadRankBossCell = class("UndecidedRoadRankBossCell", Dialog)
UndecidedRoadRankBossCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRankBossCell.AssetName = "ActivityRoadRankBossCell"
local TableFrame = require("framework.ui.frame.table.tableframe")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
UndecidedRoadRankBossCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadRankBossCell
  ((UndecidedRoadRankBossCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

UndecidedRoadRankBossCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Boss")
  self._name = self:GetChild("Text")
  self._select = self:GetChild("Select")
  self._title = self:GetChild("Difficulty/Txt")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

UndecidedRoadRankBossCell.OnDestroy = function(self)
  -- function num : 0_2
end

UndecidedRoadRankBossCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : cimagepath, _ENV
  local image = cimagepath:GetRecorder((self._cellData).image)
  ;
  (self._img):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._name):SetText((self._cellData).name)
  ;
  (self._select):SetActive((self._cellData).id == (self._delegate)._selectDayId)
  if (self._cellData).id == 1 then
    (self._title):SetText((TextManager.GetText)(1901007))
  else
    (self._title):SetText((TextManager.GetText)(1901008) .. " " .. (self._cellData).id - 1)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UndecidedRoadRankBossCell.OnCellClicked = function(self)
  -- function num : 0_4
  if not self._cellData then
    return 
  end
  ;
  (self._delegate):OnSelectBossCell(self._cellData)
end

UndecidedRoadRankBossCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if self._cellData and eventName == "ChooseBossRush" then
    if (self._cellData).id == arg then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
  end
end

return UndecidedRoadRankBossCell

