-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/oldplayerbenefits/rewardprogresscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local RewardProgressCell = class("RewardProgressCell", Dialog)
RewardProgressCell.AssetBundleName = "ui/layouts.welfare"
RewardProgressCell.AssetName = "WelfareFeedbackCell"
local taskName = {2223, 2222, 2224}
RewardProgressCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RewardProgressCell
  ((RewardProgressCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

RewardProgressCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, GridFrame
  self._doneBtn = self:GetChild("DoneBtn")
  self._doneBtn_Text = self:GetChild("DoneBtn/_Text")
  self._getBtn = self:GetChild("GetBtn")
  self._getBtn_Text = self:GetChild("GetBtn/_Text")
  self._title = self:GetChild("Title")
  ;
  (self._doneBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2220))
  ;
  (self._getBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2221))
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
  self._num = self:GetChild("ProgressBack/Num/Num")
  self._progress = self:GetChild("ProgressBack/Progress")
  self._numMax = self:GetChild("ProgressBack/Num/NumMax")
  self._panel = self:GetChild("Frame")
  self._frame = (GridFrame.Create)(self._panel, self, false, 1, false)
end

RewardProgressCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

RewardProgressCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, taskName
  self._rewardID = (data.cfg).id
  ;
  (self._progress):SetFillAmount(data.process)
  ;
  (self._getBtn):SetActive(not data.isDone)
  ;
  (self._getBtn):SetInteractable(data.hasReward)
  ;
  (self._doneBtn):SetActive(data.isDone)
  ;
  (self._num):SetText(data.cur)
  ;
  (self._numMax):SetText((data.cfg).target)
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(taskName[(data.cfg).targetType], {(data.cfg).target}))
  self.awardItemData = data.awardItemData
  ;
  (self._frame):ReloadAllCell()
end

RewardProgressCell.OnGetBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Welfare):HasCanReceiveOldPlayerWelfareByRewardID(self._rewardID) then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceiveoldplayerwelfare")
    if protocol then
      LogInfoFormat("RewardProgressCell", "GetReward:%s", self._rewardID)
      protocol.awardIndex = self._rewardID
      protocol:Send()
    end
  end
end

RewardProgressCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "welfare.oldplayerbenefits.rewarditemcell"
end

RewardProgressCell.NumberOfCell = function(self, frame, index)
  -- function num : 0_6
  return #self.awardItemData
end

RewardProgressCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self.awardItemData)[index]
end

return RewardProgressCell

