--用户注册框
--控件
local inp_account = nil;
local inp_pwd = nil;
local text_accountTips = nil; --账号信息错误提示
local text_pwdTips = nil; --密码错误提示
local delayTime=0;--延迟时间
local text_validTips=nil;
local text_repwdTips=nil;
--临时变量
local accountName = nil;
local pwd = nil;
local repwd=nil;
local validCode=nil;
local isAgree=false;
local isSend=false;
function Awake()
	inp_account = ComUtil.GetCom(inpAccount, "InputField");
   inp_pwd = ComUtil.GetCom(inpPwd, "InputField");
   inp_rePwd=ComUtil.GetCom(inpRePwd,"InputField");
   inp_code=ComUtil.GetCom(inpCode,"InputField");
   inp_account.characterLimit=eRegisterLen.AccMax;
   inp_pwd.characterLimit=eRegisterLen.PwdMax;
	text_accountTips = ComUtil.GetCom(accountTips, "Text");
	text_pwdTips = ComUtil.GetCom(pwdTips, "Text");
	text_repwdTips=ComUtil.GetCom(rePwdTips,"Text");
	text_validTips=ComUtil.GetCom(validCodeError,"Text");
	CSAPI.AddInputFieldChange(inpAccount,OnAccountChange)
	CSAPI.AddInputFieldChange(inpPwd,OnPwdChange)
	CSAPI.AddInputFieldChange(inpRePwd,OnRePwdChange)
	CSAPI.AddInputFieldChange(inpCode,OnCodeChange)
	isAgree=GetAgree();
	-- CSAPI.SetGOActive(tick,isAgree);
	CSAPI.SetText(inpPwdHolder, string.format(LanguageMgr:GetByID(16056), eRegisterLen.PwdMin, eRegisterLen.PwdMax));
	BuryingPointMgr:BuryingPoint("before_login", "10018");
end

function OnEnable()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Login_CD_Down, CountDown);
	Refresh();
	PlayTween(true);
end

function OnDisable()
	PlayTween(false)
	eventMgr:ClearListener();
	-- SetAgree(isAgree);
end

function Refresh()
	CountDown(GetCodeCD())
	inp_account.text = "";
	inp_pwd.text = "";
	inp_rePwd.text="";
	inp_code.text="";
	CSAPI.SetGOActive(accountError,false);
	CSAPI.SetGOActive(pwdError,false);
	CSAPI.SetGOActive(rePwdError,false);
	CSAPI.SetGOActive(validError,false);
	if IsAccount() then
		CSAPI.SetText(inpAccHolder, string.format(LanguageMgr:GetByID(16056), eRegisterLen.AccMin, eRegisterLen.AccMax));
		CSAPI.SetGOActive(pwdObj2,false);
		CSAPI.SetGOActive(validObj,false);
	else
		CSAPI.SetText(inpAccHolder, LanguageMgr:GetByID(16071));
		CSAPI.SetGOActive(pwdObj2,true);
		CSAPI.SetGOActive(validObj,true);
	end
end

function CountDown(_time)
	delayTime=_time
	if delayTime>0 then
		CSAPI.SetText(txt_btn2,LanguageMgr:GetByID(16070,math.floor(delayTime)));
		if isSend==false then
			isSend=true;
			SetCodeBtn();
		end
	else
		CSAPI.SetText(txt_btn2,LanguageMgr:GetByID(16066));
		isSend=false;
		SetCodeBtn();
	end
end

function CheckAccount()
	accountName = string.gsub(inp_account.text, "[%s+]", "");
	local accountIsPass, _error = ValidateAccount(accountName);
	if accountIsPass then
		text_accountTips.text = ""
		CSAPI.SetGOActive(accountError,false);
		return true;
	else
		text_accountTips.text = LanguageMgr:GetByID(_error);
		CSAPI.SetGOActive(accountError,true);
		return false;
	end
end

function OnClickBack()
	EventMgr.Dispatch(EventType.Login_Switch_LoginView);
end

function OnClickRegister()
	accountIsPass=CheckAccount();
	--获取输入框内容并去除空格
	pwd = string.gsub(inp_pwd.text, "[%s+]", "");
	repwd = string.gsub(inp_rePwd.text, "[%s+]", "");
	validCode=string.gsub(inp_code.text,"[%s+]", "");
	--验证格式
	local pwdIsPass, _pwdError = ValidatePwd(pwd);
	local validIsPass,_validError=ValidateCode(validCode);
	-- if isAgree~=true then
	if GetAgree()~=true then
		Tips.ShowTips(LanguageMgr:GetTips(9004));
		return;
	end
   if(accountIsPass and pwdIsPass and (((IsAccount()==false and validIsPass and pwd==repwd ))or(IsAccount()==true))) then
		-- text_accountTips.text = ""
		text_pwdTips.text = ""
		text_repwdTips.text="";
		text_validTips.text=""
		RegisterAccount();
		return;
	end
	
	if(not pwdIsPass) then
		text_pwdTips.text = LanguageMgr:GetByID(_pwdError);
		CSAPI.SetGOActive(pwdError,true);
	else
		text_pwdTips.text = "";
		CSAPI.SetGOActive(pwdError,false);
	end

	if(pwd~=repwd) then
		text_repwdTips.text=LanguageMgr:GetByID(16068);
		CSAPI.SetGOActive(rePwdError,true);
	else
		text_repwdTips.text=""
		CSAPI.SetGOActive(rePwdError,false);
	end

	if(not validIsPass) then
		-- Log(_validError);
		text_validTips.text = LanguageMgr:GetByID(_validError);
		CSAPI.SetGOActive(validError,true);
	else
		text_validTips.text = "";
		CSAPI.SetGOActive(validError,false);
	end	
end

function OnClickBack()
	EventMgr.Dispatch(EventType.Login_Click_HasUserBtn, nil);
	CSAPI.SetGOActive(gameObject, false);
end
--注册逻辑
function RegisterAccount()
	local serverInfo = GetCurrentServer();
	if IsAccount() then
		if serverInfo.state~=ServerListState.Maintentance then
			EventMgr.Dispatch(EventType.Login_Show_Mask);
			local serverIp,serverPort =GetLoginIpInfo(serverInfo);
			serverPort = serverPort or serverInfo.port;
			NetMgr.net:Connect(serverIp, serverPort, function()
				LoginProto:RegisterAccount(accountName, pwd, RegisterSuccess);
			end);
		else
			InitServerInfo(function() --刷新服务器状态
				serverInfo =GetCurrentServer();
				local serverIp,serverPort =GetLoginIpInfo(serverInfo);
				serverPort = serverPort or serverInfo.port;
				if serverInfo.state~=ServerListState.Maintentance then
					EventMgr.Dispatch(EventType.Login_Show_Mask);
					NetMgr.net:Connect(serverIp, serverPort, function()
						LoginProto:RegisterAccount(accountName, pwd, RegisterSuccess);
					end);
				else
					ShowCurrServerNotice();
				end
			end);
		end
	elseif serverInfo then --注册SDK
		if serverInfo.is_open_white==1 then --验证白名单
			SignWhite(accountName,function(proto)
				ChannelWebUtil.SendToServer2({cmd=SendCMD.Reg,subcmd=SendSubCMD.Reg,phone=accountName,code=validCode,password=pwd},nil,ValidCodeCall);
			end)
		else
			ChannelWebUtil.SendToServer2({cmd=SendCMD.Reg,subcmd=SendSubCMD.Reg,phone=accountName,code=validCode,password=pwd},nil,ValidCodeCall);
		end
	end
end

function ValidCodeCall(json)
	EventMgr.Dispatch(EventType.Login_Hide_Mask)
	if json.code==ResultCode.Normal then
		CSAPI.SetGOActive(accountError,false);
		CSAPI.SetGOActive(pwdError,false);
		CSAPI.SetGOActive(rePwdError,false);
		CSAPI.SetGOActive(validError,false);
		RegisterSuccess();
	else
		CSAPI.SetGOActive(accountError,false);
		CSAPI.SetGOActive(pwdError,false);
		CSAPI.SetGOActive(rePwdError,false);
		CSAPI.SetGOActive(validError,false);
		Tips.ShowTips(json.msg)
		-- text_validTips.text = json.msg;
	end
end

--注册成功 记录用户名和密码进入游戏
function RegisterSuccess()
	EventMgr.Dispatch(EventType.Login_Hide_Mask);		
	SaveLastServerInfo(serverInfo.id);
	BuryingPointMgr:BuryingPoint("before_login", "10019");
	if IsAccount() then
		SaveLastAccount(accountName, pwd);
	--else --手机注册（官方SDK）
		
	end
   	Tips.ShowTips(LanguageMgr:GetTips(9002));
	EventMgr.Dispatch(EventType.Login_Click_In,{account=accountName,pwd=pwd});
end 

function OnClickSendCode()
	if delayTime<=0 and CheckAccount() then
		local info=GetCurrentServer();
		if info == nil then
			Tips.ShowTips(LanguageMgr:GetTips(1008));
			return;
		end
		if info.is_open_white then
			SignWhite(accountName,function()
				ChannelWebUtil.SendToServer2({cmd=SendCMD.Code,subcmd=SendSubCMD.Code,phone=accountName},nil,OnCodeSend);
				end)
		else
			--发送协议到服务器获取验证码
			ChannelWebUtil.SendToServer2({cmd=SendCMD.Code,subcmd=SendSubCMD.Code,phone=accountName},nil,OnCodeSend);
		end
	end
end

function OnCodeSend(json)
	EventMgr.Dispatch(EventType.Login_Hide_Mask)
	if json.code==ResultCode.Normal then
		--启用CD
		StartCodeCD(60);
		LanguageMgr:ShowTips(9007)
	else
		local dialogdata = {
			content = json.msg,
		}
		CSAPI.OpenView("Prompt", dialogdata)
		-- EventMgr.Dispatch(EventType.Login_Hide_Mask);
	end
end

function SetCodeBtn()
	CSAPI.LoadImg(btn_sendCode,isSend and "UIs/Login/btn_10_11.png" or "UIs/Login/btn_10_10.png",true,nil,true);
end

--点击了关闭按钮
-- function OnClickClose()
-- 	EventMgr.Dispatch(EventType.Login_Click_Return, nil);
-- end

function PlayTween(isShow)
	-- local pos=isShow==true and {0,27.8,0} or {-1136,27.8,0};
	-- UIUtil:DoLocalMove(bg,pos,function()
		CSAPI.SetGOActive(childNode,isShow);
	-- end);
end

function OnClickUserTips(go)
	local type=1;
	if go.name=="txt_userTips" then
		type=1;
	else
		type=2;
	end
	CSAPI.OpenView("LoginAgreement",nil,type);
end

function OnClickAgree(go)
	isAgree=not isAgree;
	CSAPI.SetGOActive(tick,isAgree);
	SetAgree(isAgree);
	-- SendToClean();
end

--登陆
function OnClickLogin()
	EventMgr.Dispatch(EventType.Login_Click_HasUserBtn);
end

function OnPwdChange(str)
	local text=StringUtil:FilterChar(str);
	inp_pwd.text=text;
end

function OnAccountChange(str)
	local text=StringUtil:FilterChar(str);
	inp_account.text=text;
end

function OnRePwdChange(str)
	local text=StringUtil:FilterChar(str);
	inp_rePwd.text=text;
end

function OnCodeChange(str)
	local text=StringUtil:FilterChar(str);
	inp_code.text=text;
end