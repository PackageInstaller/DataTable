-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitmaintaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSwimDailyMission = (BeanManager.GetTableByName)("activity.cswimdailymission")
local SwimSuitMainTaskCell = class("SwimSuitMainTaskCell", Dialog)
SwimSuitMainTaskCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitMainTaskCell.AssetName = "ActivitySummerMainTaskCell"
SwimSuitMainTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitMainTaskCell
  ((SwimSuitMainTaskCell.super).Ctor)(self, ...)
end

SwimSuitMainTaskCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Text")
  self._gang = self:GetChild("gang")
  self._max = self:GetChild("Num2")
  self._time = self:GetChild("Num1")
  self._current = self:GetChild("Num")
  self._finishi = self:GetChild("Finish")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

SwimSuitMainTaskCell.OnDestroy = function(self)
  -- function num : 0_2
end

SwimSuitMainTaskCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CSwimDailyMission, _ENV
  local recorder = CSwimDailyMission:GetRecorder(data.ID)
  self._landID = recorder.landID
  if recorder then
    (self._name):SetText((TextManager.GetText)(recorder.descTextID))
    ;
    (self._time):SetText(recorder.timePoint)
    ;
    (self._current):SetText(data.value)
    if recorder.type == 3 then
      (self._max):SetText(recorder.itemNum)
    else
      ;
      (self._max):SetText(1)
    end
    ;
    (self._max):SetActive(data.isFinish == 0)
    ;
    (self._current):SetActive(data.isFinish == 0)
    ;
    (self._gang):SetActive(data.isFinish == 0)
    ;
    (self._finishi):SetActive(data.isFinish == 1)
  else
    LogErrorFormat("SwimSuitMainTaskCell", "CSwimDailyMission 找不到配置 Id = %s", tostring(data.ID))
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

SwimSuitMainTaskCell.OnCellClick = function(self)
  -- function num : 0_4
  (self._delegate):OnTaskCellClick((self._cellData).ID)
end

return SwimSuitMainTaskCell

