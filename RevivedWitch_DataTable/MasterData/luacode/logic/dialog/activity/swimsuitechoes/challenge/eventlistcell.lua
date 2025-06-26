-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/challenge/eventlistcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EventListCell = class("EventListCell", Dialog)
local CSRChallengeEvent = (BeanManager.GetTableByName)("activity.csrchallengeevent")
EventListCell.AssetBundleName = "ui/layouts.activitysummer2"
EventListCell.AssetName = "ActivitySummer2Event"
EventListCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EventListCell
  ((EventListCell.super).Ctor)(self, ...)
end

EventListCell.OnCreate = function(self)
  -- function num : 0_1
  self._titleTxt = self:GetChild("DetailBack/TopBack/Txt")
  self._detailTxt = self:GetChild("DetailBack/Detail/Txt")
  self._tokenTxt = self:GetChild("DetailBack/DownBack/Txt")
  self._selectImg = self:GetChild("DetailBack/Select")
  self._detailBack = self:GetChild("DetailBack")
  ;
  (self._detailBack):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    (self._delegate):OnSelectEvent(self._cellData)
  end
, self)
end

EventListCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : CSRChallengeEvent, _ENV
  local cfg = CSRChallengeEvent:GetRecorder(data)
  ;
  (self._titleTxt):SetText((TextManager.GetText)(cfg.nameID))
  ;
  (self._detailTxt):SetText((TextManager.GetText)(cfg.descriptionID))
  ;
  (self._tokenTxt):SetText(cfg.pointNum)
  local absPointNum = (math.abs)(cfg.pointNum)
  if cfg.pointNum > 0 then
    (self._tokenTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2166, {absPointNum}))
  else
    if cfg.pointNum < 0 then
      (self._tokenTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2165, {absPointNum}))
    end
  end
end

EventListCell.OnDestroy = function(self)
  -- function num : 0_3
end

EventListCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_4
  if arg ~= self._cellData then
    (self._selectImg):SetActive(eventName ~= "Select")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return EventListCell

