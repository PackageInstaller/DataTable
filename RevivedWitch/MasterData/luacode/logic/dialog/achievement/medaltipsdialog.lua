-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/medaltipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CAchievementBagConfig = (BeanManager.GetTableByName)("mission.cachievebadgeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local TableFrame = require("framework.ui.frame.table.tableframe")
local MedalTipsDialog = class("MedalTipsDialog", Dialog)
MedalTipsDialog.AssetBundleName = "ui/layouts.bag"
MedalTipsDialog.AssetName = "ItemTipsAchievementMedal"
MedalTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MedalTipsDialog
  ((MedalTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

MedalTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._back = self:GetChild("Back")
  self._icon = self:GetChild("Back/Medal")
  self._detail = self:GetChild("Back/Frame/Detail")
  self._getTime = self:GetChild("Back/Frame/Time")
  self._name = self:GetChild("Back/ItemName")
  self._leftArrow = self:GetChild("Back/Left")
  self._rightArrow = self:GetChild("Back/Right")
  self._dotPanel = self:GetChild("Back/DotFrame")
  self._width = (self._dotPanel):GetDeltaSize()
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnArrowClick(-1)
  end
)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnArrowClick(1)
  end
)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

MedalTipsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._dotFrame then
    (self._dotFrame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

MedalTipsDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : TableFrame, _ENV
  self._data = data
  local totalNum = #(data.recorder).badgeIDList
  ;
  (self._leftArrow):SetActive(totalNum > 1)
  ;
  (self._rightArrow):SetActive(totalNum > 1)
  if totalNum > 1 then
    self._dotFrame = (TableFrame.Create)(self._dotPanel, self, false, false)
    ;
    (self._dotFrame):ReloadAllCell()
    local totalLength = (self._dotFrame):GetTotalLength()
    ;
    (self._dotPanel):SetDeltaSize(totalLength, self._height)
  end
  local getLen = #data.getList
  if getLen > 0 then
    for i,v in ipairs((data.recorder).badgeIDList) do
      if v == ((data.getList)[getLen]).id then
        self._curShowIndex = i
        self:RefreshByIndex(i)
        break
      end
    end
  else
    self._curShowIndex = 1
    self:RefreshByIndex(1)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

MedalTipsDialog.OnArrowClick = function(self, value)
  -- function num : 0_4
  self._curShowIndex = self._curShowIndex + value
  if self._curShowIndex <= 0 then
    self._curShowIndex = #((self._data).recorder).badgeIDList
  end
  if #((self._data).recorder).badgeIDList < self._curShowIndex then
    self._curShowIndex = 1
  end
  self:RefreshByIndex(self._curShowIndex)
end

MedalTipsDialog.RefreshByIndex = function(self, index)
  -- function num : 0_5 , upvalues : CAchievementBagConfig, CImagePathTable, _ENV
  local id = (((self._data).recorder).badgeIDList)[index]
  local record = CAchievementBagConfig:GetRecorder(id)
  if not CImagePathTable:GetRecorder(record.imageID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._detail):SetText((TextManager.GetText)(record.descriptionTextID))
  local getTime = nil
  for i,v in ipairs((self._data).getList) do
    if v.id == id then
      getTime = v.time
      break
    end
  end
  do
    if getTime then
      (self._getTime):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1356, {(os.date)("%Y", getTime // 1000), (os.date)("%m", getTime // 1000), (os.date)("%d", getTime // 1000)}))
    else
      ;
      (self._getTime):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1355))
    end
    ;
    (self._name):SetText((TextManager.GetText)(record.nameTextID))
    if self._dotFrame then
      (self._dotFrame):FireEvent("Switch", index)
    end
  end
end

MedalTipsDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_6
  return #((self._data).recorder).badgeIDList
end

MedalTipsDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "achievement.medaltipsdotcell"
end

MedalTipsDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return index
end

MedalTipsDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_9 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

MedalTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

return MedalTipsDialog

