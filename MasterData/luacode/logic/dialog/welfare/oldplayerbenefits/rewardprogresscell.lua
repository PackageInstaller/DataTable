local GridFrame = require("framework.ui.frame.grid.gridframe")
local RewardProgressCell = class("RewardProgressCell", Dialog)
RewardProgressCell.AssetBundleName = "ui/layouts.welfare"
RewardProgressCell.AssetName = "WelfareFeedbackCell"
local taskName = {
  2223,
  2222,
  2224
}

function RewardProgressCell:Ctor(...)
  RewardProgressCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function RewardProgressCell:OnCreate()
  self._doneBtn = self:GetChild("DoneBtn")
  self._doneBtn_Text = self:GetChild("DoneBtn/_Text")
  self._getBtn = self:GetChild("GetBtn")
  self._getBtn_Text = self:GetChild("GetBtn/_Text")
  self._title = self:GetChild("Title")
  self._doneBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2220))
  self._getBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2221))
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
  self._num = self:GetChild("ProgressBack/Num/Num")
  self._progress = self:GetChild("ProgressBack/Progress")
  self._numMax = self:GetChild("ProgressBack/Num/NumMax")
  self._panel = self:GetChild("Frame")
  self._frame = GridFrame.Create(self._panel, self, false, 1, false)
end

function RewardProgressCell:OnDestroy()
  self._frame:Destroy()
end

function RewardProgressCell:RefreshCell(data)
  self._rewardID = data.cfg.id
  self._progress:SetFillAmount(data.process)
  self._getBtn:SetActive(not data.isDone)
  self._getBtn:SetInteractable(data.hasReward)
  self._doneBtn:SetActive(data.isDone)
  self._num:SetText(data.cur)
  self._numMax:SetText(data.cfg.target)
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(taskName[data.cfg.targetType], {
    data.cfg.target
  }))
  self.awardItemData = data.awardItemData
  self._frame:ReloadAllCell()
end

function RewardProgressCell:OnGetBtnClick()
  if NekoData.BehaviorManager.BM_Welfare:HasCanReceiveOldPlayerWelfareByRewardID(self._rewardID) then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceiveoldplayerwelfare")
    if protocol then
      LogInfoFormat("RewardProgressCell", "GetReward:%s", self._rewardID)
      protocol.awardIndex = self._rewardID
      protocol:Send()
    end
  end
end

function RewardProgressCell:CellAtIndex(frame, index)
  return "welfare.oldplayerbenefits.rewarditemcell"
end

function RewardProgressCell:NumberOfCell(frame, index)
  return #self.awardItemData
end

function RewardProgressCell:DataAtIndex(frame, index)
  return self.awardItemData[index]
end

return RewardProgressCell
