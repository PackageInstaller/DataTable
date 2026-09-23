local this = oo.class(RichManActionBase)

function this:Enter(playerCtrl)
	--判断是否获得特殊奖励，如果有则播放奖励并等待玩家响应
	local activityData=RichManMgr:GetCurData();
	if activityData~=nil then
		local tipsTask=activityData:GetCurrTask()
		local cnt=self.data.throwCnt or activityData:GetThrowCnt()+1;
		if tipsTask and tipsTask[2]>=cnt then
			RichManUtil.HandleRewardEvent(activityData,self.data,function(rewards)
				RichManUtil.SendDiceNumEvent(activityData,self.data.nDiceNum,self.data.sDiceNum,rewards);
				self:SetState(2);
			end)
		else
			self:SetState(2);
		end
	else
		self:SetState(2);
	end
end

function this:Update(playerCtrl)
    if RichManActionBase:Update(playerCtrl) then
        do
            return
        end
    end
	if self:GetState()==2 and self.isState2First~=true then
		EventMgr.Dispatch(EventType.RichMan_Map_Update,{mapId=self.data.proto.mapId,action=self});
		self.isState2First=true;
	end
	self.done=self.state==3;
end

return this;
