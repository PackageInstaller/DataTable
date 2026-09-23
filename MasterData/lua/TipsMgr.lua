-- 服务器错误信息处理类
local this = {
	tipsMaxCount = 3, -- 飘字最大显示个数
	disConnectError = { -- 需要断开链接的信息key
		"accExist", "accNotExist", "accLenErr", "pwdLenErr", "sqlFail",
		"pwdErr", "relogin", "svrBusy", "loadDataErr"
	},
	authenError={ --身份验证错误信息
		"accRegisterLimit",
	},
	funHandles = {}, -- 特殊处理函数
}

--副本已结束
this.funHandles.sDuplicateOver = function()
	Log("战斗已结束，清理副本数据！！！");
	-- DungeonMgr:SetCurrFightId();
	DungeonMgr:ClearGettingBattleData();
	DungeonMgr:SetDungeonOver();
	-- BattleMgr:Reset();
	-- FriendMgr:ClearAssistData();
	-- TeamMgr:ClearFightTeamData();
	-- CSAPI.OpenView("Section");
	
	return true -- return true 不再弹出提示, false 则还会处理提示
end

--战斗中满背包提示
this.funHandles.itemSignFull=function(data)
	if FightClient and FightClient:IsFightting() then--是否处于战斗中
		-- LogError("Add_ItemSignFull_In_Fightting")
		EventMgr.AddListener(EventType.Fight_Over_Panel_Show,this.OnFightOver);	
		this.delayTips=this.delayTips or {};
		table.insert(this.delayTips,data);
		return true;	
	end
	return false;
end


--战斗结束时
function this.OnFightOver()
	-- LogError("TipsMgr:OnFightOver-------------------->")
	if this.delayTips~=nil and #this.delayTips>0 then
		for k, v in ipairs(this.delayTips) do
			this:ShowMsg(v);
		end
		this.delayTips=nil;
	end
	EventMgr.RemoveListener(EventType.Fight_Over_Panel_Show,this.OnFightOver);	
end

-- function this:AddListener(strId, fun)
	
-- end

-- 处理消息
function this:HandleMsg(data)
	
	if this.funHandles[data.strId] and this.funHandles[data.strId](data) then
		return
	end
	this:ShowMsg(data);
end

--展示消息
function this:ShowMsg(data)
	if data then
		local tipsData = TipsData.New()
		tipsData:InitCfg(data.strId)
		tipsData:SetParam(data.args)
		self:CheckDisConnect(tipsData)
		local index = tipsData:GetShowType()
		-- 需要跳转的提示处理
		if index == 1 then
			self:ShowTips(tipsData)
		elseif index == 2 then
		elseif index == 3 then
			self:ShowPrompt(tipsData)
		elseif index == 4 then
			self:ShowDialog(tipsData)
		elseif index == 5 then
		elseif index == 6 then
		elseif index == 7 then
			-- 跳转类型    
			CSAPI.OpenView("LoadDialog", {
				content = tipsData:GetContent(),
				okCallBack = function()
					EventMgr.Dispatch(EventType.RewardPanel_Post_Close);
					JumpMgr:Jump(tonumber(tipsData:GetArg1()));
				end
			})
		elseif index == 8 then --关闭游戏
			ClientProto:Offline()
			MgrCenter:Clear()
			EventMgr.Dispatch(EventType.Login_Quit, nil,true);	
			CSAPI.OpenView("LoadPrompt", {content = tipsData:GetContent(), okCallBack = function()
				if CSAPI.IsADV() or CSAPI.IsDomestic() then
					if CSAPI.IsChannel() then --渠道注销
						EventMgr.Dispatch(EventType.Login_SDK_LogoutCommand, nil,true);
					end
					ShiryuSDK.Logout();
					CSAPI.UnityQuit();
				else
					CSAPI.Quit();
				end
			end})
			do return end;
		elseif index==9 then --注销账号
			self:CheckAuthenError(tipsData);
			if LoginProto:IsOnline()~=true then --还没完成登录流程，中断
				NetMgr.net:Disconnect();
				MgrCenter:Clear()
				CSAPI.OpenView("LoadPrompt", {content = tipsData:GetContent()})
				do return end;
			end
			ClientProto:Offline()
			MgrCenter:Clear()
			EventMgr.Dispatch(EventType.Login_Quit, nil,true);	
			-- NetMgr.net:Disconnect();
			CSAPI.OpenView("LoadPrompt", {content = tipsData:GetContent(), okCallBack = function()
				if CSAPI.IsChannel() then --渠道注销
					EventMgr.Dispatch(EventType.Login_SDK_LogoutCommand, nil,true);
				end
				if CSAPI.IsADV() or CSAPI.IsDomestic()then
					ShiryuSDK.Logout()
				else
					LoginProto:Logout()
				end
			end})
			do return end;
		end
		self:DebugLog(data)
		if tipsData:GetFunType() == TipsFunType.Login then --处理登录失败的情况
			EventMgr.Dispatch(EventType.Login_Fial);
		end
	else
		LogError("收到服务器传来的空数据！！")
	end
end

-- 更新飘字队列
function this:ShowTips(tipsData) Tips.ShowTips(tipsData:GetContent()) end

-- 带确认取消的弹窗
function this:ShowDialog(tipsData)
	CSAPI.OpenView("LoadDialog", {content = tipsData:GetContent()})
end

-- 带确认的弹窗
function this:ShowPrompt(tipsData)
	CSAPI.OpenView("LoadPrompt", {content = tipsData:GetContent()})
end

-- 打印服务器传递的debug信息
function this:DebugLog(data)
	Log("收到服务器传来的消息：protoID:" .. tostring(data.opId) .. "触发的操作：" .. tostring(data.opName))
end

-- 检测是否需要断开网络连接
function this:CheckDisConnect(tipsData)
	local key = tipsData:GetKey()
	if key then
		for _, v in ipairs(self.disConnectError) do
			if key == v then
				EventMgr.Dispatch(EventType.Net_Tips_Disconnect)
				NetMgr.net:Disconnect()
				return
			end
		end
	end
end

function this:CheckAuthenError(tipsData)
	local key = tipsData:GetKey()
	if key then
		for _, v in ipairs(self.authenError) do
			if key == v then
				EventMgr.Dispatch(EventType.Authentication_Close)
				EventMgr.Dispatch(EventType.Login_Hide_Mask);
				return
			end
		end
	end
end

--------------------------------每日提醒记录--------------------------------------
function this:SaveDailyTips(key,b)
	if key == nil or key == "" then
		return
	end
    local info = FileUtil.LoadByPath("DailyTips.txt") or {}
    info[key] = b and TimeUtil:GetTime() or nil
    FileUtil.SaveToFile("DailyTips.txt",info)
end 

function this:IsShowDailyTips(key)
	if key == nil or key == "" then
		return true
	end
    local info = FileUtil.LoadByPath("DailyTips.txt")
    if not info or not info[key] then
        return true
    end
    local tab1 = TimeUtil:GetTimeHMS(info[key])
    local tab2 = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
    if tab2.day - tab1.day > 1 then --超过一天
        return true
    elseif tab2.day - tab1.day > 0 then --在前后一天
        if tab1.hour < g_ActivityDiffDayTime then --前一次记录在每日刷新前
            return true
        elseif tab2.hour >= g_ActivityDiffDayTime then --当前在每日刷新后
            return true
        end
    elseif tab1.hour < g_ActivityDiffDayTime and tab2.hour >= g_ActivityDiffDayTime then --在同一天但在每日刷新前后
        return true
    end
    return false
end

return this
