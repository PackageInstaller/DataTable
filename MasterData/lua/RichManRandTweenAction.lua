local this = oo.class(RichManActionBase)

function this:Enter(playerCtrl)
    -- 执行播放骰子动画
	self:SetState(1);
   	EventMgr.Dispatch(EventType.RichMan_PlayRand_Begin,{point=self.data.point,isFixed=self.data.isFixed})
	self.func=function ()
		self:SetState(2);--播放完毕
		EventMgr.RemoveListener(EventType.RichMan_PlayRand_Over,self.func);
	end
	EventMgr.AddListener(EventType.RichMan_PlayRand_Over, self.func)
end

function this:Update(playerCtrl)
    if RichManActionBase:Update(playerCtrl) then
        do
            return
        end
    end
	self.done=self:GetState()==2;
end

return this;
