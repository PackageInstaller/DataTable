local this = {}

--设置从当前物体的面向到目标物体的面向
function this.SetAngle(currGo,targetGo)
	if not IsNil(currGo) and not IsNil(targetGo) then
		local pos=targetGo.transform.position;
		local pos2=currGo.transform.position;
		CSAPI.FaceToTarget(currGo,pos.x,pos2.y,pos.z);
	end
end

--发送骰子数量变更事件
function this.SendDiceNumEvent(activityData,currNDiceNum,currSDiceNum,rewards)
	if activityData~=nil and currNDiceNum and currSDiceNum and rewards~=nil then
		local nDice=activityData:GetNormalDice():GetID()
    	local sDice=activityData:GetSpecialDice():GetID()
		local nDiceNum=currNDiceNum;
		local sDiceNum=currSDiceNum;
		for i, v in ipairs(rewards) do
			if nDice==v.id then
				nDiceNum=nDiceNum+v.num
			end
			if sDice==v.id then
				sDiceNum=sDiceNum+v.num
			end
		end
		if nDiceNum~=currNDiceNum or sDiceNum~=sDiceNum then
			EventMgr.Dispatch(EventType.RichMan_Dice_Refresh,{nDiceNum=nDiceNum,sDiceNum=sDiceNum})
		end
	end
end

--处理奖励事件
function this.HandleRewardEvent(activityData,actionData,func)
	if activityData==nil or actionData==nil then
		if func~=nil then
			func();
		end
		do return end;
	end
	local proto = actionData.proto -- 获取奖励数据
    local rewards = nil;
	-- LogError(proto);
    if proto ~= nil and proto.rewards ~= nil then
		-- LogError(actionData.gridInfo:GetTempID().."\t"..actionData.gridInfo:GetSort())
        for i, v in ipairs(proto.rewards) do
            if v.mapId == actionData.gridInfo:GetTempID() then -- 当前地图的当前格子
                for _, val in ipairs(v.info) do
                    if val.sort == actionData.gridInfo:GetSort() then -- 当前这一步的奖励
                        rewards = val.rewards;
						break;
                    end
                end
            end
        end
    end
	-- LogError("当前奖励信息："..table.tostring(rewards))
	-- LogError(actionData)
	if actionData.isAuto==true then --自动则记录等待完毕再一起展示
		-- RichManMgr:RecordAutoReward(rewards);
		if func~=nil then
			func(rewards);
		end
	elseif rewards~=nil then
		UIUtil:OpenReward({
			rewards,
			closeCallBack = function()
				if func~=nil then
					func(rewards);
				end
			end
		});
	elseif func~=nil then
		func(rewards);
	end
end

return this;