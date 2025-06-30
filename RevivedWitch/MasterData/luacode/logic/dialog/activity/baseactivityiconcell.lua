-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/baseactivityiconcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CBannerAndEntrance = (BeanManager.GetTableByName)("activity.cbannerandentrance")
local BaseActivityIconCell = class("BaseActivityIconCell", Dialog)
BaseActivityIconCell.AssetBundleName = "ui/layouts.basemainhud"
BaseActivityIconCell.AssetName = "BaseActivityIcon"
BaseActivityIconCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseActivityIconCell
  ((BaseActivityIconCell.super).Ctor)(self, ...)
  self._cellData = nil
end

BaseActivityIconCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ActivityIcon")
  self._name = self:GetChild("ActivityIcon/Text")
  self._RedDot = self:GetChild("ActivityIcon/RedDot")
  self._leftTime = self:GetChild("ActivityIcon/Time")
  self._effect = self:GetChild("ActivityIcon/Effect")
  self._effectHandler = nil
  ;
  (self._icon):Subscribe_PointerClickEvent(self.OnIconClicked, self)
end

BaseActivityIconCell.OnDestroy = function(self)
  -- function num : 0_2
end

BaseActivityIconCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePath, _ENV
  self._cellData = data
  local leftTime = data.leftTime
  local leftHourNumber = leftTime / 1000 / 3600
  local leftDayNumber = leftHourNumber / 24
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._cellData).leftHourNumber = leftHourNumber
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._cellData).leftDayNumber = leftDayNumber
  local record = data.record
  local spriteRecord = CImagePath:GetRecorder(((self._cellData).record).pictureID)
  if spriteRecord then
    (self._icon):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  end
  ;
  (self._name):SetText((TextManager.GetText)(record.activityTextID))
  ;
  (self._RedDot):SetActive(data.showRedDot)
  self:RefreshTime()
  if record.effectsID > 0 then
    if self._effectHandler ~= nil then
      (self._effect):ReleaseEffect(self._effectHandler)
    end
    self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(record.effectsID))
  else
    if self._effectHandler ~= nil then
      (self._effect):ReleaseEffect(self._effectHandler)
    end
  end
end

BaseActivityIconCell.RefreshTime = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local leftTime = (self._cellData).leftTime
  local leftHourNumber = leftTime / 1000 / 3600
  local leftDayNumber = leftHourNumber / 24
  leftDayNumber = (math.floor)(leftDayNumber)
  leftHourNumber = (math.floor)(leftHourNumber)
  do
    -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

    if leftDayNumber < 1 and (self._cellData).leftHourNumber ~= leftHourNumber then
      local leftHourNumberText = (TextManager.GetText)(701627)
      leftHourNumberText = (string.gsub)(leftHourNumberText, "%$parameter1%$", leftHourNumber)
      ;
      (self._leftTime):SetText(leftHourNumberText)
    end
    if (self._cellData).leftDayNumber ~= leftDayNumber then
      local leftDayNumberText = (TextManager.GetText)(701626)
      leftDayNumberText = (string.gsub)(leftDayNumberText, "%$parameter1%$", leftDayNumber)
      ;
      (self._leftTime):SetText(leftDayNumberText)
    end
  end
end

BaseActivityIconCell.OnEvent = function(self, eventName)
  -- function num : 0_5
  self:RefreshTime()
end

BaseActivityIconCell.OnIconClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Activity):EnterActivityById((self._cellData).id)
end

return BaseActivityIconCell

