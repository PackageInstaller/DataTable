local EventListCell = class("EventListCell", Dialog)
local CSRChallengeEvent = BeanManager.GetTableByName("activity.csrchallengeevent")
EventListCell.AssetBundleName = "ui/layouts.activitysummer2"
EventListCell.AssetName = "ActivitySummer2Event"

function EventListCell:Ctor(...)
  EventListCell.super.Ctor(self, ...)
end

function EventListCell:OnCreate()
  self._titleTxt = self:GetChild("DetailBack/TopBack/Txt")
  self._detailTxt = self:GetChild("DetailBack/Detail/Txt")
  self._tokenTxt = self:GetChild("DetailBack/DownBack/Txt")
  self._selectImg = self:GetChild("DetailBack/Select")
  self._detailBack = self:GetChild("DetailBack")
  self._detailBack:Subscribe_PointerClickEvent(function()
    self._delegate:OnSelectEvent(self._cellData)
  end, self)
end

function EventListCell:RefreshCell(data)
  local cfg = CSRChallengeEvent:GetRecorder(data)
  self._titleTxt:SetText(TextManager.GetText(cfg.nameID))
  self._detailTxt:SetText(TextManager.GetText(cfg.descriptionID))
  self._tokenTxt:SetText(cfg.pointNum)
  local absPointNum = math.abs(cfg.pointNum)
  if cfg.pointNum > 0 then
    self._tokenTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2166, {absPointNum}))
  elseif cfg.pointNum < 0 then
    self._tokenTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2165, {absPointNum}))
  end
end

function EventListCell:OnDestroy()
end

function EventListCell:OnEvent(eventName, arg)
  if eventName == "Select" then
    self._selectImg:SetActive(arg == self._cellData)
  end
end

return EventListCell
