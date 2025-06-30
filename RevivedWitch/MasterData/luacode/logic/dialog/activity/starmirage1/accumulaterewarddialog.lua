-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1/accumulaterewarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CEventCollectBonus = (BeanManager.GetTableByName)("activity.ceventcollectbonus")
local CStarryMirrorCollect = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorcollect")
local Item = require("logic.manager.experimental.types.item")
local AccumulateRewardDialog = class("AccumulateRewardDialog", Dialog)
AccumulateRewardDialog.AssetBundleName = "ui/layouts.activitystar2"
AccumulateRewardDialog.AssetName = "ActivityStar1Account"
AccumulateRewardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AccumulateRewardDialog, CEventCollectBonus, _ENV, Item
  ((AccumulateRewardDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._mainRewardItemList = {}
  self._recorder = CEventCollectBonus:GetRecorder((DataCommon.AccumulateRewards).StarMirageCopy)
  for i,v in ipairs((self._recorder).exhibititemid) do
    (table.insert)(self._mainRewardItemList, (Item.Create)(v))
  end
  self._dataList = {}
end

AccumulateRewardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._title = self:GetChild("BackImage/Title")
  self._icon = self:GetChild("BackImage/StarImg")
  self._describe = self:GetChild("BackImage/DetailTxt")
  self._getReward_title = self:GetChild("BackImage/CurrentStarTxt")
  ;
  (self._getReward_title):SetText((TextManager.GetText)(1900878))
  self._getReward_num = self:GetChild("BackImage/CurrentStarTxt/CurrentStarNum")
  self._getProgress_title = self:GetChild("BackImage/StageTxt")
  ;
  (self._getProgress_title):SetText((TextManager.GetText)(1900880))
  self._getProgress_num = self:GetChild("BackImage/StageTxt/StageNum")
  self._timeTxt = self:GetChild("BackImage/TimeTxt")
  self._getBtn = self:GetChild("BackImage/GetBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  ;
  (self:GetChild("BackImage/Tips")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2116))
  self._panel = self:GetChild("BackImage/Frame")
  self._mainRewardItems = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

      (self._mainRewardItems)[i] = {}
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._mainRewardItems)[i]).cell = self:GetChild("BackImage/Reward/ItemCell" .. R9_PC83)
      -- DECOMPILER ERROR at PC94: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._mainRewardItems)[i]).frame = self:GetChild("BackImage/Reward/ItemCell" .. R9_PC83 .. "/_BackGround/Frame")
      -- DECOMPILER ERROR at PC99: Overwrote pending register: R9 in 'AssignReg'

      -- DECOMPILER ERROR at PC103: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._mainRewardItems)[i]).icon = self:GetChild("BackImage/Reward/ItemCell" .. R9_PC83 .. "/_BackGround/Icon")
      ;
      (((self._mainRewardItems)[i]).cell):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnMainRewardClicked(i)
  end
)
    end
  end
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._timeTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2117, (self._recorder).endtime))
  self:Init()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSRefreshActivityRewards, Common.n_RefreshActivityRewards, nil)
end

AccumulateRewardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
end

local GetGotNum = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local num = 0
  for i,v in ipairs(self._dataList) do
    if v.status == 2 then
      num = num + 1
    end
  end
  return num
end

local RefreshProgressShow = function(self)
  -- function num : 0_4 , upvalues : _ENV, CStarryMirrorCollect
  local num = 0
  local totalNum = 0
  local curStage = nil
  for i,v in ipairs(self._dataList) do
    if v.status == 2 then
      num = num + 1
    else
      if not curStage and v.status == 0 then
        curStage = i
      end
    end
    totalNum = totalNum + 1
  end
  if not curStage then
    curStage = totalNum
  end
  local str = (TextManager.GetText)(1900881)
  str = (string.gsub)(str, "%$parameter1%$", num)
  str = (string.gsub)(str, "%$parameter2%$", totalNum)
  ;
  (self._getProgress_num):SetText(str)
  str = (TextManager.GetText)(1900879)
  local record = CStarryMirrorCollect:GetRecorder(((self._dataList)[curStage]).stageId)
  str = (string.gsub)(str, "%$parameter1%$", ((NekoData.BehaviorManager).BM_Activity):GetAccumulatePointsByActivityId((DataCommon.Activities).StarMirageCopy, record.collecttype))
  str = (string.gsub)(str, "%$parameter2%$", record.collectrequirenum)
  ;
  (self._getReward_num):SetText(str)
end

local FirstCanGetIndex = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for i,v in ipairs(self._dataList) do
    if v.status == 1 then
      return i
    end
  end
end

AccumulateRewardDialog.OnSRefreshActivityRewards = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV, RefreshProgressShow, FirstCanGetIndex
  if (notification.userInfo).activityID == (DataCommon.Activities).StarMirageCopy then
    local lastPos = (self._frame):GetCurrentPosition()
    self._dataList = ((NekoData.BehaviorManager).BM_Activity):GetAccumulateRewardListByActivityId((notification.userInfo).activityID)
    RefreshProgressShow(self)
    ;
    (self._frame):ReloadAllCell()
    if lastPos then
      (self._frame):MoveToAssignedPos(lastPos)
    end
    local firstCanGetIndex = FirstCanGetIndex(self)
    ;
    (self._getBtn):SetInteractable(firstCanGetIndex ~= nil)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

AccumulateRewardDialog.Init = function(self)
  -- function num : 0_7 , upvalues : _ENV, Item, RefreshProgressShow, FirstCanGetIndex
  (self._title):SetText((TextManager.GetText)((self._recorder).titletxtid))
  local item = (Item.Create)((self._recorder).collectitemid)
  local image = item:GetIcon()
  ;
  (self._icon):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._describe):SetText((TextManager.GetText)((self._recorder).sloganextid))
  for i,v in ipairs(self._mainRewardItemList) do
    image = v:GetIcon()
    ;
    (((self._mainRewardItems)[i]).icon):SetSprite(image.assetBundle, image.assetName)
    image = v:GetPinJiImage()
    ;
    (((self._mainRewardItems)[i]).frame):SetSprite(image.assetBundle, image.assetName)
  end
  self._dataList = ((NekoData.BehaviorManager).BM_Activity):GetAccumulateRewardListByActivityId((DataCommon.Activities).StarMirageCopy)
  RefreshProgressShow(self)
  local firstCanGetIndex = FirstCanGetIndex(self)
  ;
  (self._getBtn):SetInteractable(firstCanGetIndex ~= nil)
  ;
  (self._frame):ReloadAllCell()
  if firstCanGetIndex then
    (self._frame):MoveTopToIndex(firstCanGetIndex)
  else
    (self._frame):MoveToTop()
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

AccumulateRewardDialog.OnGetBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceiveallpointsaward")
  protocol.activityID = (DataCommon.Activities).StarMirageCopy
  protocol:Send()
end

AccumulateRewardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

AccumulateRewardDialog.OnMainRewardClicked = function(self, index)
  -- function num : 0_10 , upvalues : _ENV
  local item = (self._mainRewardItemList)[index]
  if item then
    local cell = ((self._mainRewardItems)[index]).cell
    local width, height = cell:GetRectSize()
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = item})
      tipsDialog:SetTipsPosition(width, height, cell:GetLocalPointInUiRootPanel())
    end
  end
end

AccumulateRewardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_11
  return #self._dataList
end

AccumulateRewardDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_12
  return "activity.starmirage1.accumulaterewardcell"
end

AccumulateRewardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_13
  return (self._dataList)[index]
end

return AccumulateRewardDialog

