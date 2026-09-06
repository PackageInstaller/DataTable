local TableFrame = require("framework.ui.frame.table.tableframe")
local CEventCollectBonus = BeanManager.GetTableByName("activity.ceventcollectbonus")
local CStarryMirrorCollect = BeanManager.GetTableByName("dungeonselect.cstarrymirrorcollect")
local Item = require("logic.manager.experimental.types.item")
local AccumulateRewardDialog = class("AccumulateRewardDialog", Dialog)
AccumulateRewardDialog.AssetBundleName = "ui/layouts.activitystar2"
AccumulateRewardDialog.AssetName = "ActivityStar1Account"

function AccumulateRewardDialog:Ctor(...)
  AccumulateRewardDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._mainRewardItemList = {}
  self._recorder = CEventCollectBonus:GetRecorder(DataCommon.AccumulateRewards.StarMirageCopy)
  for i, v in ipairs(self._recorder.exhibititemid) do
    table.insert(self._mainRewardItemList, Item.Create(v))
  end
  self._dataList = {}
end

function AccumulateRewardDialog:OnCreate()
  self._title = self:GetChild("BackImage/Title")
  self._icon = self:GetChild("BackImage/StarImg")
  self._describe = self:GetChild("BackImage/DetailTxt")
  self._getReward_title = self:GetChild("BackImage/CurrentStarTxt")
  self._getReward_title:SetText(TextManager.GetText(1900878))
  self._getReward_num = self:GetChild("BackImage/CurrentStarTxt/CurrentStarNum")
  self._getProgress_title = self:GetChild("BackImage/StageTxt")
  self._getProgress_title:SetText(TextManager.GetText(1900880))
  self._getProgress_num = self:GetChild("BackImage/StageTxt/StageNum")
  self._timeTxt = self:GetChild("BackImage/TimeTxt")
  self._getBtn = self:GetChild("BackImage/GetBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self:GetChild("BackImage/Tips"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2116))
  self._panel = self:GetChild("BackImage/Frame")
  self._mainRewardItems = {}
  for i = 1, 3 do
    self._mainRewardItems[i] = {}
    self._mainRewardItems[i].cell = self:GetChild("BackImage/Reward/ItemCell" .. i)
    self._mainRewardItems[i].frame = self:GetChild("BackImage/Reward/ItemCell" .. i .. "/_BackGround/Frame")
    self._mainRewardItems[i].icon = self:GetChild("BackImage/Reward/ItemCell" .. i .. "/_BackGround/Icon")
    self._mainRewardItems[i].cell:Subscribe_PointerClickEvent(function()
      self:OnMainRewardClicked(i)
    end)
  end
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._timeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2117, self._recorder.endtime))
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.OnSRefreshActivityRewards, Common.n_RefreshActivityRewards, nil)
end

function AccumulateRewardDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
end

local function GetGotNum(self)
  local num = 0
  for i, v in ipairs(self._dataList) do
    if v.status == 2 then
      num = num + 1
    end
  end
  return num
end

local function RefreshProgressShow(self)
  local num = 0
  local totalNum = 0
  local curStage
  for i, v in ipairs(self._dataList) do
    if v.status == 2 then
      num = num + 1
    elseif not curStage and v.status == 0 then
      curStage = i
    end
    totalNum = totalNum + 1
  end
  curStage = curStage or totalNum
  local str = TextManager.GetText(1900881)
  str = string.gsub(str, "%$parameter1%$", num)
  str = string.gsub(str, "%$parameter2%$", totalNum)
  self._getProgress_num:SetText(str)
  str = TextManager.GetText(1900879)
  local record = CStarryMirrorCollect:GetRecorder(self._dataList[curStage].stageId)
  str = string.gsub(str, "%$parameter1%$", NekoData.BehaviorManager.BM_Activity:GetAccumulatePointsByActivityId(DataCommon.Activities.StarMirageCopy, record.collecttype))
  str = string.gsub(str, "%$parameter2%$", record.collectrequirenum)
  self._getReward_num:SetText(str)
end

local function FirstCanGetIndex(self)
  for i, v in ipairs(self._dataList) do
    if v.status == 1 then
      return i
    end
  end
end

function AccumulateRewardDialog:OnSRefreshActivityRewards(notification)
  if notification.userInfo.activityID == DataCommon.Activities.StarMirageCopy then
    local lastPos = self._frame:GetCurrentPosition()
    self._dataList = NekoData.BehaviorManager.BM_Activity:GetAccumulateRewardListByActivityId(notification.userInfo.activityID)
    RefreshProgressShow(self)
    self._frame:ReloadAllCell()
    if lastPos then
      self._frame:MoveToAssignedPos(lastPos)
    end
    local firstCanGetIndex = FirstCanGetIndex(self)
    self._getBtn:SetInteractable(firstCanGetIndex ~= nil)
  end
end

function AccumulateRewardDialog:Init()
  self._title:SetText(TextManager.GetText(self._recorder.titletxtid))
  local item = Item.Create(self._recorder.collectitemid)
  local image = item:GetIcon()
  self._icon:SetSprite(image.assetBundle, image.assetName)
  self._describe:SetText(TextManager.GetText(self._recorder.sloganextid))
  for i, v in ipairs(self._mainRewardItemList) do
    image = v:GetIcon()
    self._mainRewardItems[i].icon:SetSprite(image.assetBundle, image.assetName)
    image = v:GetPinJiImage()
    self._mainRewardItems[i].frame:SetSprite(image.assetBundle, image.assetName)
  end
  self._dataList = NekoData.BehaviorManager.BM_Activity:GetAccumulateRewardListByActivityId(DataCommon.Activities.StarMirageCopy)
  RefreshProgressShow(self)
  local firstCanGetIndex = FirstCanGetIndex(self)
  self._getBtn:SetInteractable(firstCanGetIndex ~= nil)
  self._frame:ReloadAllCell()
  if firstCanGetIndex then
    self._frame:MoveTopToIndex(firstCanGetIndex)
  else
    self._frame:MoveToTop()
  end
end

function AccumulateRewardDialog:OnGetBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceiveallpointsaward")
  protocol.activityID = DataCommon.Activities.StarMirageCopy
  protocol:Send()
end

function AccumulateRewardDialog:OnBackBtnClicked()
  self:Destroy()
end

function AccumulateRewardDialog:OnMainRewardClicked(index)
  local item = self._mainRewardItemList[index]
  if item then
    local cell = self._mainRewardItems[index].cell
    local width, height = cell:GetRectSize()
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = item})
      tipsDialog:SetTipsPosition(width, height, cell:GetLocalPointInUiRootPanel())
    end
  end
end

function AccumulateRewardDialog:NumberOfCell(frame)
  return #self._dataList
end

function AccumulateRewardDialog:CellAtIndex(frame, index)
  return "activity.starmirage1.accumulaterewardcell"
end

function AccumulateRewardDialog:DataAtIndex(frame, index)
  return self._dataList[index]
end

return AccumulateRewardDialog
