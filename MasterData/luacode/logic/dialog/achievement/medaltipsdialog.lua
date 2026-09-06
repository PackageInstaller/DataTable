local UIManager = CS.PixelNeko.UI.UIManager
local CAchievementBagConfig = BeanManager.GetTableByName("mission.cachievebadgeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TableFrame = require("framework.ui.frame.table.tableframe")
local MedalTipsDialog = class("MedalTipsDialog", Dialog)
MedalTipsDialog.AssetBundleName = "ui/layouts.bag"
MedalTipsDialog.AssetName = "ItemTipsAchievementMedal"

function MedalTipsDialog:Ctor(...)
  MedalTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function MedalTipsDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._icon = self:GetChild("Back/Medal")
  self._detail = self:GetChild("Back/Frame/Detail")
  self._getTime = self:GetChild("Back/Frame/Time")
  self._name = self:GetChild("Back/ItemName")
  self._leftArrow = self:GetChild("Back/Left")
  self._rightArrow = self:GetChild("Back/Right")
  self._dotPanel = self:GetChild("Back/DotFrame")
  self._width, self._height = self._dotPanel:GetDeltaSize()
  self._leftArrow:Subscribe_PointerClickEvent(function()
    self:OnArrowClick(-1)
  end)
  self._rightArrow:Subscribe_PointerClickEvent(function()
    self:OnArrowClick(1)
  end)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function MedalTipsDialog:OnDestroy()
  if self._dotFrame then
    self._dotFrame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function MedalTipsDialog:SetData(data)
  self._data = data
  local totalNum = #data.recorder.badgeIDList
  self._leftArrow:SetActive(1 < totalNum)
  self._rightArrow:SetActive(1 < totalNum)
  if 1 < totalNum then
    self._dotFrame = TableFrame.Create(self._dotPanel, self, false, false)
    self._dotFrame:ReloadAllCell()
    local totalLength = self._dotFrame:GetTotalLength()
    self._dotPanel:SetDeltaSize(totalLength, self._height)
  end
  local getLen = #data.getList
  if 0 < getLen then
    for i, v in ipairs(data.recorder.badgeIDList) do
      if v == data.getList[getLen].id then
        self._curShowIndex = i
        self:RefreshByIndex(i)
        break
      end
    end
  else
    self._curShowIndex = 1
    self:RefreshByIndex(1)
  end
end

function MedalTipsDialog:OnArrowClick(value)
  self._curShowIndex = self._curShowIndex + value
  if self._curShowIndex <= 0 then
    self._curShowIndex = #self._data.recorder.badgeIDList
  end
  if self._curShowIndex > #self._data.recorder.badgeIDList then
    self._curShowIndex = 1
  end
  self:RefreshByIndex(self._curShowIndex)
end

function MedalTipsDialog:RefreshByIndex(index)
  local id = self._data.recorder.badgeIDList[index]
  local record = CAchievementBagConfig:GetRecorder(id)
  local imageRecord = CImagePathTable:GetRecorder(record.imageID) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._detail:SetText(TextManager.GetText(record.descriptionTextID))
  local getTime
  for i, v in ipairs(self._data.getList) do
    if v.id == id then
      getTime = v.time
      break
    end
  end
  if getTime then
    self._getTime:SetText(NekoData.BehaviorManager.BM_Message:GetString(1356, {
      os.date("%Y", getTime // 1000),
      os.date("%m", getTime // 1000),
      os.date("%d", getTime // 1000)
    }))
  else
    self._getTime:SetText(NekoData.BehaviorManager.BM_Message:GetString(1355))
  end
  self._name:SetText(TextManager.GetText(record.nameTextID))
  if self._dotFrame then
    self._dotFrame:FireEvent("Switch", index)
  end
end

function MedalTipsDialog:NumberOfCell(frame, index)
  return #self._data.recorder.badgeIDList
end

function MedalTipsDialog:CellAtIndex(frame, index)
  return "achievement.medaltipsdotcell"
end

function MedalTipsDialog:DataAtIndex(frame, index)
  return index
end

function MedalTipsDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function MedalTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

return MedalTipsDialog
