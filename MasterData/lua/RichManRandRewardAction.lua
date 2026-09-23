local this = oo.class(RichManActionBase)

function this:Enter(playerCtrl)
    -- LogError("RichManRandRewardAction------------------------------>Enter");
    self:SetState(1);
    -- 弹出随机奖励，等待玩家关闭弹窗
    -- LogError("随机奖励事件,等待玩家关闭界面完继续执行剩余逻辑----------->");
	local activityData=RichManMgr:GetCurData();
	RichManUtil.HandleRewardEvent(activityData,self.data,function(rewards)
		RichManUtil.SendDiceNumEvent(activityData,self.data.nDiceNum,self.data.sDiceNum,rewards);
		self:SetState(2);
	end)
end

function this:Update(playerCtrl)
    if RichManActionBase:Update(playerCtrl) then
        do
            return
        end
    end
    self.done = self:GetState() == 2;
end

return this;
