local this = oo.class(RichManActionBase)

function this:Enter(playerCtrl)
	self:SetState(1);
	self.isReward=false;
	CSAPI.OpenView("RichManRandEvent",{gridInfo=self.data.gridInfo,func=function()
		self:SetState(2);
	end});
end

function this:Update(playerCtrl)
    if RichManActionBase:Update(playerCtrl) then
        do
            return
        end
    end
	--播放老虎机效果
	if self:GetState()==2 and self.isReward~=true then
		--播放奖励信息
		local activityData=RichManMgr:GetCurData();
		RichManUtil.HandleRewardEvent(activityData,self.data,function(rewards)
			RichManUtil.SendDiceNumEvent(activityData,self.data.nDiceNum,self.data.sDiceNum,rewards);
			self:SetState(3);
		end)
		self.isReward=true;
	end
	--更新UI
	self.done=self:GetState()==3;
end

return this;
