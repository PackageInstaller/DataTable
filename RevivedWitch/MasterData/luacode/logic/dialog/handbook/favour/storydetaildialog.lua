-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/storydetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFavourExp = (BeanManager.GetTableByName)("role.cfavourexp")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local StoryDetailDialog = class("StoryDetailDialog", Dialog)
StoryDetailDialog.AssetBundleName = "ui/layouts.tujian"
StoryDetailDialog.AssetName = "CharStoryDetail"
StoryDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : StoryDetailDialog
  ((StoryDetailDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

StoryDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._closeBtn = self:GetChild("BackBtn")
  self._title = self:GetChild("BackImage/Title")
  self._heartInfo = {}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

    (self._heartInfo)[i] = {}
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._heartInfo)[i]).back = self:GetChild("BackImage/Lock/Heart" .. i .. "Back")
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._heartInfo)[i]).light = self:GetChild("BackImage/Lock/Heart" .. i)
  end
  self._unlockCondition = self:GetChild("BackImage/Lock/Detail")
  self._detailPanel = self:GetChild("BackImage/Frame/Detail")
  self._initLocal_posX = (self._detailPanel):GetLocalPosition()
  self._width = (self._detailPanel):GetRectSize()
  self._detailAnchorMinX = (self._detailPanel):GetAnchorAndOffset()
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
end

StoryDetailDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

StoryDetailDialog.SetData = function(self, data, maxHeartNum)
  -- function num : 0_3 , upvalues : _ENV, CFavourExp, SingletonSlideFrame
  self._data = data
  local id = (data.reward).rewardId
  ;
  (self._title):SetText((TextManager.GetText)(((data.bookRecord).titleTextID)[id]))
  local record = CFavourExp:GetRecorder((data.reward).favourLv)
  local curHeartNum = record.heartnum / 10
  local integer, decimal = (math.modf)(curHeartNum)
  for i,v in ipairs(self._heartInfo) do
    if maxHeartNum < i then
      (v.back):SetActive(false)
      ;
      (v.light):SetActive(false)
    else
      if i - 1 < curHeartNum and curHeartNum < i then
        (v.light):SetFillAmount(decimal)
      else
        if i <= curHeartNum then
          (v.light):SetFillAmount(1)
        else
          ;
          (v.light):SetFillAmount(0)
        end
      end
    end
  end
  ;
  (self._unlockCondition):SetText((string.gsub)((TextManager.GetText)(502721), "%$parameter1%$", (data.reward).favourLv))
  ;
  (self._detailPanel):SetText((TextManager.GetText)((((self._data).bookRecord).backStoryTextID)[((self._data).reward).rewardId]))
  local _, textHeight = (self._detailPanel):GetPreferredSize()
  if self._height < textHeight then
    local delta = textHeight - self._height
    ;
    (self._detailPanel):SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY - delta, self._detailOffsetMaxX, self._detailOffsetMaxY)
    ;
    (self._detailPanel):SetLocalPosition(self._initLocal_posX, self._initLocal_posY - delta / 2, self._initLocal_posZ)
    self._slideFrame = (SingletonSlideFrame.Create)(self._detailPanel, true, self._initLocal_posY - delta / 2, self._initLocal_posY + delta / 2)
  else
    do
      ;
      (self._detailPanel):SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY, self._detailOffsetMaxX, self._detailOffsetMaxY)
      ;
      (self._detailPanel):SetLocalPosition(self._initLocal_posX, self._initLocal_posY, self._initLocal_posZ)
    end
  end
end

StoryDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

StoryDetailDialog.OnScreenPixelChanged = function(self)
  -- function num : 0_5
  self._screenPixelChanged = true
end

StoryDetailDialog.OnUpdate = function(self)
  -- function num : 0_6 , upvalues : SingletonSlideFrame
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    if self._slideFrame then
      (self._slideFrame):Destroy()
      self._slideFrame = nil
    end
    local _, textHeight = (self._detailPanel):GetPreferredSize()
    if self._height < textHeight then
      local delta = textHeight - self._height
      ;
      (self._detailPanel):SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY - delta, self._detailOffsetMaxX, self._detailOffsetMaxY)
      ;
      (self._detailPanel):SetLocalPosition(self._initLocal_posX, self._initLocal_posY, self._initLocal_posZ)
      self._slideFrame = (SingletonSlideFrame.Create)(self._detailPanel, true, self._initLocal_posY, self._initLocal_posY + delta)
    else
      do
        ;
        (self._detailPanel):SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY, self._detailOffsetMaxX, self._detailOffsetMaxY)
        ;
        (self._detailPanel):SetLocalPosition(self._initLocal_posX, self._initLocal_posY, self._initLocal_posZ)
      end
    end
  end
end

return StoryDetailDialog

