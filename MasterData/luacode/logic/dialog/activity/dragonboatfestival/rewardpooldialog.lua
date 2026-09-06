local CStringRes = BeanManager.GetTableByName("message.cstringres")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local RewardPoolDialog = class("RewardPoolDialog", Dialog)
RewardPoolDialog.AssetBundleName = "ui/layouts.activityspringouting"
RewardPoolDialog.AssetName = "ActivitySpringOutingRewardPool"

function RewardPoolDialog:Ctor(...)
  RewardPoolDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._selectPoolIndex = 1
  self._rewardData = {}
end

function RewardPoolDialog:OnCreate()
  self._title = self:GetChild("Image/Back/Title")
  self._description = self:GetChild("Image/Back/Text1")
  self._closeBtn = self:GetChild("Image/Back/Closebtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._leftBtn = self:GetChild("LeftBtn")
  self._leftBtn:Subscribe_PointerClickEvent(self.OnLeftBtnClicked, self)
  self._rightBtn = self:GetChild("RightBtn")
  self._rightBtn:Subscribe_PointerClickEvent(self.OnRightBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._rewardFrame = GridFrame.Create(self._panel, self, true, 7, false)
  LuaNotificationCenter.AddObserver(self, self.OnSDragonBoatFestivalInfo, Common.n_SDragonBoatFestivalInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSDragonBoatFestivalWish, Common.n_SDragonBoatFestivalWish, nil)
end

function RewardPoolDialog:OnDestroy()
  if self._rewardFrame then
    self._rewardFrame:Destroy()
  end
end

function RewardPoolDialog:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._selectPoolIndex = self._bm:GetCurrentPoolID()
  self:RefreshTitleAndDescriptionTxtData()
  self:RefreshRewardData()
end

function RewardPoolDialog:RefreshTitleAndDescriptionTxtData()
  local rewardPoolData = self._bm:GetRewardPoolData()
  local titleTextID = rewardPoolData[self._selectPoolIndex].nameId
  self._title:SetText(TextManager.GetText(titleTextID))
  if not rewardPoolData[self._selectPoolIndex].isFinalPool then
    self._description:SetText(TextManager.GetText(CStringRes:GetRecorder(1817).msgTextID))
  else
    self._description:SetText(TextManager.GetText(CStringRes:GetRecorder(1818).msgTextID))
  end
end

function RewardPoolDialog:RefreshRewardData()
  self._rewardData = self._bm:GetCurrentPoolItem()[self._selectPoolIndex]
  self._leftBtn:SetActive(self._selectPoolIndex ~= self._bm:GetMinPoolID())
  self._rightBtn:SetActive(self._selectPoolIndex ~= self._bm:GetMaxPoolID())
  self._rewardFrame:ReloadAllCell()
end

function RewardPoolDialog:OnBackBtnClicked()
  self:Destroy()
end

function RewardPoolDialog:OnLeftBtnClicked()
  if self._selectPoolIndex > self._bm:GetMinPoolID() then
    local tmpTbl = self._bm:GetPoolIDs()
    local tmpIndex = table.indexof(tmpTbl, self._selectPoolIndex)
    self._selectPoolIndex = tmpTbl[tmpIndex - 1]
    self:RefreshTitleAndDescriptionTxtData()
    self:RefreshRewardData()
  end
end

function RewardPoolDialog:OnRightBtnClicked()
  if self._selectPoolIndex < self._bm:GetMaxPoolID() then
    local tmpTbl = self._bm:GetPoolIDs()
    local tmpIndex = table.indexof(tmpTbl, self._selectPoolIndex)
    self._selectPoolIndex = tmpTbl[tmpIndex + 1]
    self:RefreshTitleAndDescriptionTxtData()
    self:RefreshRewardData()
  end
end

function RewardPoolDialog:OnSDragonBoatFestivalInfo()
end

function RewardPoolDialog:OnSDragonBoatFestivalWish()
  self:RefreshTitleAndDescriptionTxtData()
  self:RefreshRewardData()
end

function RewardPoolDialog:NumberOfCell(frame, index)
  return #self._rewardData
end

function RewardPoolDialog:CellAtIndex(frame, index)
  return "activity.dragonboatfestival.rewardcell"
end

function RewardPoolDialog:DataAtIndex(frame, index)
  return self._rewardData[index]
end

return RewardPoolDialog
