local DormPuzzleRewardItemCtrl = BaseClass("DormPuzzleRewardItemCtrl")
local M = DormPuzzleRewardItemCtrl

function M:__init(view)
    self._view = view
    self._view.Btn.transform:onClick(Bind(self, self.OnClickItem))
    self.activityId = DormPuzzleActivityDataMgr:GetInstance().activityId
end

function M:OnClickItem(go)
    if not self.data.canReward and not self.data.isReward then
        EventMgr:Broadcast(UIMessageNames.DORM_PUZZLE_CLICKREWARD, self.data.cfg.groupChildId)
        if self._view.rewardChildId > 3 then
            GameHelper.TipsById(1315)
        else
            GameHelper.TipsById(1314)
        end 
    end

    if self.data.canReward and not self.data.isReward then
        self._view.Animator:Play("Reward")
        ActivityDataMgr:GetInstance():SendCommonReward(self.activityId, {self._view.rewardChildId}, Bind(self, self.RewardCallback))
    end
end

function M:RewardCallback(data)
    GameHelper.ShowGetItems(data)
    EventMgr:Broadcast(UIMessageNames.ACTIVITY_COMMON_REWARD, data)
    self.data.canReward = false
    self.data.isReward = true
    self._view.State:SetState(3)
    IRedPointMgr:ForceCheck(RedPointConst.DormPuzzleRedPointChecker)
end 

function M:UpdateData(data)
    self.data = data
    self._view.Text:SetText(self.data.activeNum.."/"..#self.data.cfg.groupChildId)
    if self.data.isReward then
        self._view.State:SetState(3)
    else 
        if self.data.canReward then
            self._view.State:SetState(2)
        else
            self._view.State:SetState(1)
        end
    end 
end 

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormPuzzleRewardItemCtrl
