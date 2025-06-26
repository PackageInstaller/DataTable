-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/dragonboatfestival/rewardpooldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local RewardPoolDialog = class("RewardPoolDialog", Dialog)
RewardPoolDialog.AssetBundleName = "ui/layouts.activityspringouting"
RewardPoolDialog.AssetName = "ActivitySpringOutingRewardPool"
RewardPoolDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RewardPoolDialog
  ((RewardPoolDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._selectPoolIndex = 1
  self._rewardData = {}
end

RewardPoolDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._title = self:GetChild("Image/Back/Title")
  self._description = self:GetChild("Image/Back/Text1")
  self._closeBtn = self:GetChild("Image/Back/Closebtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._leftBtn = self:GetChild("LeftBtn")
  ;
  (self._leftBtn):Subscribe_PointerClickEvent(self.OnLeftBtnClicked, self)
  self._rightBtn = self:GetChild("RightBtn")
  ;
  (self._rightBtn):Subscribe_PointerClickEvent(self.OnRightBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._rewardFrame = (GridFrame.Create)(self._panel, self, true, 7, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSDragonBoatFestivalInfo, Common.n_SDragonBoatFestivalInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSDragonBoatFestivalWish, Common.n_SDragonBoatFestivalWish, nil)
end

RewardPoolDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._rewardFrame then
    (self._rewardFrame):Destroy()
  end
end

RewardPoolDialog.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._selectPoolIndex = (self._bm):GetCurrentPoolID()
  self:RefreshTitleAndDescriptionTxtData()
  self:RefreshRewardData()
end

RewardPoolDialog.RefreshTitleAndDescriptionTxtData = function(self)
  -- function num : 0_4 , upvalues : _ENV, CStringRes
  local rewardPoolData = (self._bm):GetRewardPoolData()
  local titleTextID = (rewardPoolData[self._selectPoolIndex]).nameId
  ;
  (self._title):SetText((TextManager.GetText)(titleTextID))
  if not (rewardPoolData[self._selectPoolIndex]).isFinalPool then
    (self._description):SetText((TextManager.GetText)((CStringRes:GetRecorder(1817)).msgTextID))
  else
    ;
    (self._description):SetText((TextManager.GetText)((CStringRes:GetRecorder(1818)).msgTextID))
  end
end

RewardPoolDialog.RefreshRewardData = function(self)
  -- function num : 0_5
  self._rewardData = ((self._bm):GetCurrentPoolItem())[self._selectPoolIndex]
  ;
  (self._leftBtn):SetActive(self._selectPoolIndex ~= (self._bm):GetMinPoolID())
  ;
  (self._rightBtn):SetActive(self._selectPoolIndex ~= (self._bm):GetMaxPoolID())
  ;
  (self._rewardFrame):ReloadAllCell()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

RewardPoolDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

RewardPoolDialog.OnLeftBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if (self._bm):GetMinPoolID() < self._selectPoolIndex then
    local tmpTbl = (self._bm):GetPoolIDs()
    local tmpIndex = (table.indexof)(tmpTbl, self._selectPoolIndex)
    self._selectPoolIndex = tmpTbl[tmpIndex - 1]
    self:RefreshTitleAndDescriptionTxtData()
    self:RefreshRewardData()
  end
end

RewardPoolDialog.OnRightBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._selectPoolIndex < (self._bm):GetMaxPoolID() then
    local tmpTbl = (self._bm):GetPoolIDs()
    local tmpIndex = (table.indexof)(tmpTbl, self._selectPoolIndex)
    self._selectPoolIndex = tmpTbl[tmpIndex + 1]
    self:RefreshTitleAndDescriptionTxtData()
    self:RefreshRewardData()
  end
end

RewardPoolDialog.OnSDragonBoatFestivalInfo = function(self)
  -- function num : 0_9
end

RewardPoolDialog.OnSDragonBoatFestivalWish = function(self)
  -- function num : 0_10
  self:RefreshTitleAndDescriptionTxtData()
  self:RefreshRewardData()
end

RewardPoolDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_11
  return #self._rewardData
end

RewardPoolDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_12
  return "activity.dragonboatfestival.rewardcell"
end

RewardPoolDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_13
  return (self._rewardData)[index]
end

return RewardPoolDialog

