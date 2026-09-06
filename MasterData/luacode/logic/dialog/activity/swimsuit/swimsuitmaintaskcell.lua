local CSwimDailyMission = BeanManager.GetTableByName("activity.cswimdailymission")
local SwimSuitMainTaskCell = class("SwimSuitMainTaskCell", Dialog)
SwimSuitMainTaskCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitMainTaskCell.AssetName = "ActivitySummerMainTaskCell"

function SwimSuitMainTaskCell:Ctor(...)
  SwimSuitMainTaskCell.super.Ctor(self, ...)
end

function SwimSuitMainTaskCell:OnCreate()
  self._name = self:GetChild("Text")
  self._gang = self:GetChild("gang")
  self._max = self:GetChild("Num2")
  self._time = self:GetChild("Num1")
  self._current = self:GetChild("Num")
  self._finishi = self:GetChild("Finish")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function SwimSuitMainTaskCell:OnDestroy()
end

function SwimSuitMainTaskCell:RefreshCell(data)
  local recorder = CSwimDailyMission:GetRecorder(data.ID)
  if recorder then
    self._landID = recorder.landID
    self._name:SetText(TextManager.GetText(recorder.descTextID))
    self._time:SetText(recorder.timePoint)
    self._current:SetText(data.value)
    if recorder.type == 3 or recorder.type == 5 then
      self._max:SetText(recorder.itemNum)
    else
      self._max:SetText(1)
    end
    self._max:SetActive(data.isFinish == 0)
    self._current:SetActive(data.isFinish == 0)
    self._gang:SetActive(data.isFinish == 0)
    self._finishi:SetActive(data.isFinish == 1)
  else
    LogErrorFormat("SwimSuitMainTaskCell", "CSwimDailyMission 找不到配置 Id = %s", tostring(data.ID))
  end
end

function SwimSuitMainTaskCell:OnCellClick()
  self._delegate:OnTaskCellClick(self._cellData.ID)
end

return SwimSuitMainTaskCell
