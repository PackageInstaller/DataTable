local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local StoryDetailDialog = class("StoryDetailDialog", Dialog)
StoryDetailDialog.AssetBundleName = "ui/layouts.tujian"
StoryDetailDialog.AssetName = "CharStoryDetail"

function StoryDetailDialog:Ctor(...)
  StoryDetailDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function StoryDetailDialog:OnCreate()
  self._closeBtn = self:GetChild("BackBtn")
  self._title = self:GetChild("BackImage/Title")
  self._heartInfo = {}
  for i = 1, 5 do
    self._heartInfo[i] = {}
    self._heartInfo[i].back = self:GetChild("BackImage/Lock/Heart" .. i .. "Back")
    self._heartInfo[i].light = self:GetChild("BackImage/Lock/Heart" .. i)
  end
  self._unlockCondition = self:GetChild("BackImage/Lock/Detail")
  self._detailPanel = self:GetChild("BackImage/Frame/Detail")
  self._initLocal_posX, self._initLocal_posY, self._initLocal_posZ = self._detailPanel:GetLocalPosition()
  self._width, self._height = self._detailPanel:GetRectSize()
  self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY, self._detailOffsetMaxX, self._detailOffsetMaxY = self._detailPanel:GetAnchorAndOffset()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
end

function StoryDetailDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function StoryDetailDialog:SetData(data, maxHeartNum)
  self._data = data
  local id = data.reward.rewardId
  self._title:SetText(TextManager.GetText(data.bookRecord.titleTextID[id]))
  local record = CFavourExp:GetRecorder(data.reward.favourLv)
  local curHeartNum = record.heartnum / 10
  local integer, decimal = math.modf(curHeartNum)
  for i, v in ipairs(self._heartInfo) do
    if maxHeartNum < i then
      v.back:SetActive(false)
      v.light:SetActive(false)
    elseif curHeartNum > i - 1 and i > curHeartNum then
      v.light:SetFillAmount(decimal)
    elseif i <= curHeartNum then
      v.light:SetFillAmount(1)
    else
      v.light:SetFillAmount(0)
    end
  end
  self._unlockCondition:SetText(string.gsub(TextManager.GetText(502721), "%$parameter1%$", data.reward.favourLv))
  self._detailPanel:SetText(TextManager.GetText(self._data.bookRecord.backStoryTextID[self._data.reward.rewardId]))
  local _, textHeight = self._detailPanel:GetPreferredSize()
  if textHeight > self._height then
    local delta = textHeight - self._height
    self._detailPanel:SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY - delta, self._detailOffsetMaxX, self._detailOffsetMaxY)
    self._detailPanel:SetLocalPosition(self._initLocal_posX, self._initLocal_posY - delta / 2, self._initLocal_posZ)
    self._slideFrame = SingletonSlideFrame.Create(self._detailPanel, true, self._initLocal_posY - delta / 2, self._initLocal_posY + delta / 2)
  else
    self._detailPanel:SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY, self._detailOffsetMaxX, self._detailOffsetMaxY)
    self._detailPanel:SetLocalPosition(self._initLocal_posX, self._initLocal_posY, self._initLocal_posZ)
  end
end

function StoryDetailDialog:OnBackBtnClicked()
  self:Destroy()
end

function StoryDetailDialog:OnScreenPixelChanged()
  self._screenPixelChanged = true
end

function StoryDetailDialog:OnUpdate()
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    if self._slideFrame then
      self._slideFrame:Destroy()
      self._slideFrame = nil
    end
    local _, textHeight = self._detailPanel:GetPreferredSize()
    if textHeight > self._height then
      local delta = textHeight - self._height
      self._detailPanel:SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY - delta, self._detailOffsetMaxX, self._detailOffsetMaxY)
      self._detailPanel:SetLocalPosition(self._initLocal_posX, self._initLocal_posY, self._initLocal_posZ)
      self._slideFrame = SingletonSlideFrame.Create(self._detailPanel, true, self._initLocal_posY, self._initLocal_posY + delta)
    else
      self._detailPanel:SetAnchorAndOffset(self._detailAnchorMinX, self._detailAnchorMinY, self._detailAnchorMaxX, self._detailAnchorMaxY, self._detailOffsetMinX, self._detailOffsetMinY, self._detailOffsetMaxX, self._detailOffsetMaxY)
      self._detailPanel:SetLocalPosition(self._initLocal_posX, self._initLocal_posY, self._initLocal_posZ)
    end
  end
end

return StoryDetailDialog
