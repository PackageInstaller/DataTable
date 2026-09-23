require "LoginCommFuns"
LoginProto = {
	onSuccess = nil,
	onRegister = nil,
	ip,
	port,
};

--查询账号
function LoginProto:SendQueryAccount(msg, relogin, queryFunc,successFunc)
	self.relogin = relogin
	msg.account=tostring(msg.account);
	local proto = {"ClientProto:QueryAccount", msg};
	self.account=msg.account;
	msg.SvnVersion = g_svnVersion
	self.onSuccess = successFunc;
	self.onQuerySuccess=queryFunc;
	NetMgr.net:Send(proto);
end

--响应：查询账号
function LoginProto:QueryAccount(proto)
	Log("查询账号响应：==================")
	Log(proto);
	if CSAPI.IsADV() or CSAPI.IsDomestic() then
		if proto and proto["uid"]~=nil then
			CSAPI.UnityClientVersion(proto["uid"]);
		end
	end
	self.vosQueryAccount = proto;

	-- local locken=agreenLoken.."_"..proto.uid;
	-- local agreeVal = PlayerPrefs.GetInt(agreenLoken.."_"..proto.uid);
	-- if agreeVal==nil or agreeVal~=1 then
	-- 	CSAPI.OpenView("LoginAgreement");
	-- else
	if self.onQuerySuccess then
		self.onQuerySuccess();
		self.onQuerySuccess=nil;
	end
	LoginProto:SendLogin();			
	-- end
end

function LoginProto:SendLogin()
	local proto = self.vosQueryAccount;
	if proto == nil then
		LogError("登陆流程出错！请重新登陆！");
		return
	end
	-- local locken=agreenLoken.."_"..proto.uid;
	-- PlayerPrefs.SetInt(locken,1); --记录用户协议阅读情况
	if proto.is_anti_addiction and proto.is_anti_addiction == 1 and self.relogin ~= true then--开启防沉迷
		if proto.anti_addiction == nil or(proto.anti_addiction ~= nil and(proto.anti_addiction.name == nil or proto.anti_addiction.number == nil)) then
			--未注册实名验证
			EventMgr.Dispatch(EventType.Login_Hide_Mask);
			CSAPI.OpenView("Authentication", {call = function()
				EventMgr.Dispatch(EventType.Login_Show_Mask);
				LoginProto:SendPreLoginGame(proto) --关闭回调
			end});
		else
			self:SetPI(proto.anti_addiction.pi); --缓存PI
			-- local accType=GCalHelp:CalAccType(proto.anti_addiction.number);
			-- local content=nil
			-- if accType==AccType.Kid then --儿童
			-- 	content=StringConstant.Anthen_Tips;
			-- elseif accType==AccType.Youth then--青少年
			-- 	content=StringConstant.Anthen_Tips;
			-- elseif accType==AccType.Guest then--游客
			-- 	content=StringConstant.Anthen_Tips2;
			-- end
			-- if content then
			-- 	Tips.ShowTips(content);
			-- end
			LoginProto:SendPreLoginGame(proto)
		end
	else
		LoginProto:SendPreLoginGame(proto)
	end
	self.relogin = nil;
end

--预登陆 返回逻辑服务器信息
function LoginProto:SendPreLoginGame(msg)
	msg.distinctId=ThinkingAnalyticsMgr:GetDistinctId();
	local proto = {"ClientProto:PreLoginGame", msg};
	NetMgr.net:Send(proto);
end


--响应：预登陆
function LoginProto:PreLoginGame(proto)
	Log("预登陆响应：==================")
	self.vosPreLoginGame = proto;
	if LoginProto:VerifyUID()==true then
		LogError("VerifyUID触发1")
		return;
	end
	NetMgr.net:Disconnect();
	if proto.is_ok then
		self.ip = proto.ip
		self.port = proto.port
		local ClientCommonData=
		{
			ClientVersion=_G.g_ver_name,
			ClientPlatform=platform,
			UID=tostring(uid),
			TITLE="预登陆成功打点",
		};
		BuryingPointMgr:TrackEvents(ShiryuEventName.Unity_Client_CommonData,ClientCommonData)
		NetMgr.net:Connect(proto.ip, proto.port, LoginProto.OnConnectGameServer);
	else
		EventMgr.Dispatch(EventType.Login_Hide_Mask);
		if proto.strId and proto.args then	
			TipsMgr:HandleMsg({strId = proto.strId, args = proto.args});			
			local ClientCommonData=
			{
				ClientVersion=_G.g_ver_name,
				ClientPlatform=platform,
				UID=tostring(uid),
				TITLE="预登陆失败打点",
				DES=tostring(proto.args),
			};
			BuryingPointMgr:TrackEvents(ShiryuEventName.Unity_Client_CommonData,ClientCommonData)
		end
	end
end
---验证中台UID
function LoginProto:VerifyUID()
	if CSAPI.IsADV() or CSAPI.IsDomestic() then
		if self.vosPreLoginGame and self.vosPreLoginGame.center_web_uid and self.vosPreLoginGame.center_web_uid~="" then
			if tostring(ShiryuSDK.ShiryuLogin.uid)~=tostring(self.vosPreLoginGame.center_web_uid) then
				--LogError("数据中台UID异常:"..ShiryuSDK.ShiryuLogin.uid.."self.vosPreLoginGame.center_web_uid:"..self.vosPreLoginGame.center_web_uid)
				Temtable={}
				Temtable.GameUID=tostring(PlayerClient:GetID());---用户uid
				Temtable.SDK_center_web_uid=ShiryuSDK.ShiryuLogin.uid;---SDK给的中台id
				Temtable.Server_center_web_uid=self.vosPreLoginGame.center_web_uid;---服务端给的中台id
				Temtable.Server_third_part_id=self.vosPreLoginGame.third_part_id;---第三方id
				local LoginProtoPreLoginGameStr=table.tostring(Temtable,true);
				BuryingPointMgr:TrackEvents(ShiryuEventName.Unity_center_web_uid_GotoVerify, { LoginProtoPreLoginGameData=LoginProtoPreLoginGameStr,})
				ShiryuSDK.Logout();
				return true ;
			end
		elseif self.vosPreLoginGame==nil then
			LogError("vosPreLoginGame返回数据空")
			Temtable={}
			Temtable.GameUID=tostring(PlayerClient:GetID());---用户uid
			Temtable.SDK_center_web_uid=ShiryuSDK.ShiryuLogin.uid;---SDK给的中台id
			Temtable.Server_center_web_uid="";---服务端给的中台id
			Temtable.Server_third_part_id="";---第三方id
			local LoginProtoPreLoginGameStr=table.tostring(Temtable,true);
			BuryingPointMgr:TrackEvents(ShiryuEventName.Unity_center_web_uid_GotoVerify, { LoginProtoPreLoginGameData=LoginProtoPreLoginGameStr,})
			ShiryuSDK.Logout();
			return true ;
		end
	end

	return false;
end

--连接到游戏逻辑服
function LoginProto:OnConnectGameServer()
	Log("OnConnectGameServer：==================")
	if LoginProto:VerifyUID()==true then
		LogError("VerifyUID触发2")
		return;
	end
	--机型信息
	local isEmulator = CSAPI.CheckEmulator()
	local lv, _score = SettingMgr:GetMobieLv()
	local lvStrs = {"低端", "中端", "高端"}

	local _brand = StringUtil:split(UnityEngine.SystemInfo.deviceModel, " ")
	local phoneInfo = {
		phone_logo = _brand[1],
		phone_model = UnityEngine.SystemInfo.deviceName,
		phone_px = CSAPI.GetMainCanvasSize() [0] .. "X" .. CSAPI.GetMainCanvasSize() [1],
		phone_cpu = UnityEngine.SystemInfo.processorType,
		phone_sys = tostring(UnityEngine.SystemInfo.deviceType),
		phone_gpu = UnityEngine.SystemInfo.graphicsDeviceName,
		phone_mem = tostring(UnityEngine.SystemInfo.systemMemorySize),
		--
		emulator = isEmulator and "是模拟器" or "不是模拟器",
		score = _score.."",
		mobielv = lvStrs[lv]
	}
	
	local msg =
	{
		uid = LoginProto.vosQueryAccount.uid,
		key = LoginProto.vosPreLoginGame.key,
		device = phoneInfo
	}
	LoginProto:SendLoginGame(msg);
end

--登录游戏逻辑服
function LoginProto:SendLoginGame(msg)	
	msg.SvnVersion = g_svnVersion
	msg.distinctId=ThinkingAnalyticsMgr:GetDistinctId();
	 if CSAPI.IsADV() or CSAPI.IsDomestic() then
		---注释部分海外相关
		msg.ziLongUserInfo={}
		msg.ziLongUserInfo.operators=ShiryuSDK.ShiryuLogin.channelExts.operators;--运营商
		msg.ziLongUserInfo.langue=ShiryuSDK.ShiryuLogin.channelExts.lang;--选择语言
		msg.ziLongUserInfo.device=ShiryuSDK.ShiryuLogin.channelExts.deviceId;--设备id
		msg.ziLongUserInfo.gameChannel=ShiryuSDK.ShiryuLogin.channelExts.channelId;--gameChannel
		msg.centerWebUid=ShiryuSDK.ShiryuLogin.uid;
		msg.centerWebInfo=ShiryuSDK.ShiryuLogin.channelExts;
		 local SendLoginGamestr=table.tostring(msg,true);
		BuryingPointMgr:TrackEvents(ShiryuEventName.Unity_LoginProto_SendLoginGame, { LoginGamesStr=SendLoginGamestr,})
	end
	local proto = {"ClientProto:LoginGame", msg};
	print("GM------------------------------------------:"..table.tostring(proto))
	NetMgr.net:Send(proto);

end

function LoginProto:LoginGame(proto)
	self.isOnline=true;
	--不管是重连还是登陆，都要查询一次订单信息
	-- SDKPayMgr:SearchPayReward();
	if PlayerClient:IsEnterHall() then
		---Log("已经进入过大厅--------")
	else
		Log("显示正常--------首次登录")
		ClientProto:ClearLoginData();
	end
	if(self.logined) and PlayerClient:IsEnterHall() then
	---if(self.logined) then
		Log("重新登录游戏成功==================")
		if CSAPI.IsADV() or CSAPI.IsDomestic() then
			ShiryuSDK.OnRoleOnline()
		end
		EventMgr.Dispatch(EventType.Relogin_Success, nil, true);
		--马上通知
        ClientProto:InitFinish(true,true);
		--重登时，刷新商店物品
        -- ShopProto:GetShopInfos();
		ShopProto:GetShopOpenTime(true);
		ShopProto:GetShopCommodity();
		return;
	end
	self.logined = 1;
	local serverInfo = GetCurrentServer();
	EventMgr.Dispatch(EventType.Login_Server, serverInfo.serverName, true);
	Log("登录游戏逻辑服响应：==================")
	Log(proto);	
	--self.vosLoginGame = proto;  
	-- TacticsMgr:Init();
	PlayerClient:SetInfo(proto);
	if CSAPI.IsADV() then CSAPI.SetGameUID(PlayerClient:GetUid()) end
	PlayerProto:GetLifeBuff();
	EquipProto:GetEquips()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Init_Equip_Finish, function()
		self:OnEquipInitFinish();
	end);
end

function LoginProto:OnEquipInitFinish()
	eventMgr:ClearListener();
	ShopProto:GetShopOpenTime();
	ShopProto:GetShopCommodity();
	-- ShopProto:GetShopInfos();
	-- eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Init_Plot_Data, function()
		self:OnPlotInit();
	end);
	PlotMgr:Init();
	
	MgrCenter:Init()  --统一调用
	
	--数数校准时间
	ThinkingAnalyticsMgr:CalibrateTime()

	GuildProto:GuildInfo();
	-- if proto.guild_id ~=nil then--获取公会信息		
	-- end
	ClientProto:InitFinish(); --初始化完成协议
	local channelType=CSAPI.GetChannelType();
	if self.vosQueryAccount.is_anti_addiction==1 and channelType==ChannelType.Normal or channelType==ChannelType.TapTap then --开启防沉迷
		local signData={
			pid=self:GetPI(),
			account=self.account,
			login="1",
		}
		-- LogError(self:GetPI())
		--上报登录事件
		ChannelWebUtil.SendToServer2(signData,ChannelWebUtil.Extends.AuthenLogin,function(json)
			--发送协议给服务器
			Log("上报登录："..tostring(json.isOk));
		end);
	end
	if not CSAPI.IsPCPlatform() then --非PC才上传信息
		local account=string.format("%s_%s",CSAPI.GetChannelStr(),PlayerClient:GetAccount());
		--上传热云登录事件
		ReYunSDK:SetLoginEvent(account,serverInfo.id,{channelType=CSAPI.GetChannelName()});
	end
	EventMgr.Dispatch(EventType.Login_Enter_Game, {
        uid = PlayerClient:GetUid(),
        name = PlayerClient:GetName()
    }, true);
	BuryingPointMgr:BuryingPoint("before_login", "10022");
end

--接收完剧情信息之后
function LoginProto:OnPlotInit()
	eventMgr:ClearListener();
	if self.onSuccess then
		self.onSuccess();
		self.onSuccess = nil;
	end
	local accountName, pwd = GetLastAccount();
	EventMgr.Dispatch(EventType.Login_Success, accountName or "无效账号", true);
end

function LoginProto:PlrUpdate(proto)
	Log("逻辑服属性更新：==================")
	Log(proto);	
	PlayerClient:UpdateInfo(proto);
end

--注册
function LoginProto:RegisterAccount(account, pwd, func)
	local proto = {"ClientProto:RegisterAcc", {account = account, pwd = pwd}};
	self.onRegister = func;
	NetMgr.net:Send(proto);
end

--注册成功
function LoginProto:RegisterAccRet(proto)
	if self.onRegister then
		self.onRegister();
		self.onRegister = nil;
	end
end

-- 发送心跳
function LoginProto:SendHeartbeat()
	local proto = {"ClientProto:Heartbeat", {}};
	self.onRegister = func;
	NetMgr.net:Send(proto);
end

-- 心跳回复
function LoginProto:Heartbeat(proto)
end

function LoginProto:GetIpPort()
	return self.ip, self.port
end

--注销
function LoginProto:Logout()
	ThinkingAnalyticsMgr:Logout();
	ClientProto:Offline()
	self.isOnline=false;
	self.logined = nil
	local channelType=CSAPI.GetChannelType();
	if (self.vosQueryAccount and self.vosQueryAccount.is_anti_addiction==1) and (channelType==ChannelType.Normal or channelType==ChannelType.TapTap)  then
		local signData={
			pid=self:GetPI(),
			account=self.account,
			login="2",
		}
		--上报注销事件
		ChannelWebUtil.SendToServer2(signData,ChannelWebUtil.Extends.AuthenLogin,function(json)
			--发送协议给服务器
			Log("上报注销："..tostring(json.isOk));
		end);
		--清理快速登录的缓存
		SetPhoneLoginKey();
	end
	local cfgLaucher = Cfgs.launcher:GetByID(1)
	-- NetMgr.net:Disconnect();
	g_FightMgr = nil;
	EventMgr.Dispatch(EventType.Scene_Load, cfgLaucher.first_scene_key)
end

--排队提示
function LoginProto:WaitingLogin(proto)
	EventMgr.Dispatch(EventType.Login_Wait_Begin,proto);
end

--结束等待，可以登录
function LoginProto:WaitingLoginOk()
	EventMgr.Dispatch(EventType.Login_Wait_Over);
end

function LoginProto:WaitingLoginUpdate(proto)
	EventMgr.Dispatch(EventType.Login_wait_Update,proto);
end

function LoginProto:IsOnline()
	return self.isOnline;
end

--设置防沉迷pi字段
function LoginProto:SetPI(pi)
	self.pi=pi;
end

function LoginProto:GetPI()
	return self.pi;
end

function LoginProto:Clear()
	self.isOnline=false;
	self.vosQueryAccount=nil;
	self.vosPreLoginGame=nil;
	self.pi=nil;
end