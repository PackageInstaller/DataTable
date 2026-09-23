require "LoginCommFuns"

--登录框


--控件
local inp_account = nil;
local inp_pwd = nil;
local text_accountTips = nil; --账号信息错误提示
local text_pwdTips = nil; --密码错误提示

--临时变量
local accountName = nil;
local pwd = nil;

local isSend = false

-- local serverInfo = nil;
function Awake()
	inp_account = ComUtil.GetCom(inpAccount, "InputField");
    inp_pwd = ComUtil.GetCom(inpPwd, "InputField");
    -- inp_account.characterLimit=eRegisterLen.AccMax;
    -- inp_pwd.characterLimit=eRegisterLen.PwdMax;
	text_accountTips = ComUtil.GetCom(accountTips, "Text");
	text_pwdTips = ComUtil.GetCom(pwdTips, "Text");
	CSAPI.AddInputFieldChange(inpAccount,OnAccountChange)
	CSAPI.AddInputFieldChange(inpPwd,OnPwdChange)
	if IsAccount() then
		LanguageMgr:SetText(inpAccHolder,16015,eRegisterLen.AccMin, eRegisterLen.AccMax);
	else
		LanguageMgr:SetText(inpAccHolder,16071);
	end
	
	LanguageMgr:SetText(inpPwdHolder,16015,eRegisterLen.PwdMin, eRegisterLen.PwdMax);

	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.Login_CD_Down, CountDown);

	CountDown(GetCodeCD())
end

function OnDestroy()
	eventMgr:ClearListener()
end

function OnEnable()
	PlayTween(true);
	local isAccount=IsAccount();
	if not isAccount and (GetChannelType()==ChannelType.Normal or GetChannelType()==ChannelType.TapTap) then
		CSAPI.SetGOActive(btn_editPwd, true);
	else
		CSAPI.SetGOActive(btn_editPwd, false);
	end
	if isAccount then
		accountName,pwd=GetLastAccount();
		CSAPI.SetGOActive(btn_change_login1,false);
		CSAPI.SetAnchor(btn_login,0,-280);
	else
		accountName,pwd,sid=GetLastSDKInfo();
		CSAPI.SetGOActive(btn_change_login1,true);
		CSAPI.SetAnchor(btn_login,150,-280);
	end
	inp_account.text = accountName;
	inp_pwd.text = pwd;
	CSAPI.SetGOActive(accountError,false);
	CSAPI.SetGOActive(pwdError,false);
end

function OnDisable()
	PlayTween(false)
end

function OnClickEditPwd()
	CSAPI.OpenView("SettingWindow", nil, SettingWindowType.LoginReset)
end

--登录按钮
function OnClickLogin()
    if(IsPhoneAuthCodeType())then
        Login_AuthCode()
    else
        Login_PWD();
    end
end
function Login_PWD()
	accountName = string.gsub(inp_account.text, "[%s+]", ""); --去除空格
	pwd = string.gsub(inp_pwd.text, "[%s+]", "");
	local accountIsPass, aError = ValidateAccount(accountName);
	local pwdIsPass, pError = ValidatePwd(pwd);
	if(accountIsPass and pwdIsPass) then
		EventMgr.Dispatch(EventType.Login_Click_In,{account=accountName,pwd=pwd});
		text_accountTips.text = "";
		text_pwdTips.text = "";
		return;
	end
	--UI提示刷新
	if(not accountIsPass) then
		text_accountTips.text =LanguageMgr:GetByID(aError) ;
		CSAPI.SetGOActive(accountError,true);
	else
		text_accountTips.text = "";
		CSAPI.SetGOActive(accountError,false);
	end
	
	if(not pwdIsPass) then
		text_pwdTips.text = LanguageMgr:GetByID(pError);
		CSAPI.SetGOActive(pwdError,true);
	else
		text_pwdTips.text = "";
		CSAPI.SetGOActive(pwdError,false);
	end
end


function OnPwdChange(str)
	local text=StringUtil:FilterChar(str);
	inp_pwd.text=text;
end

function OnAccountChange(str)
	local text=StringUtil:FilterChar(str);
	inp_account.text=text;
end

function OnClickRegister()
	EventMgr.Dispatch(EventType.Login_Click_RegisterBtn);
end

--注册按钮
-- function OnClickRegister()
-- 	--获取输入框内容并去除空格
-- 	accountName = string.gsub(inp_account.text, "[%s+]", "");
-- 	pwd = string.gsub(inp_pwd.text, "[%s+]", "");
	
-- 	--验证格式
-- 	local accountIsPass, accountError = ValidateAccount(accountName);
-- 	local pwdIsPass, pwdError = ValidatePwd(pwd);
--    if(accountIsPass and pwdIsPass) then
--       text_accountTips.text = ""
--       text_pwdTips.text = ""
-- 	RegisterAccount();
-- 		return;
-- 	end
	
-- 	--UI提示刷新
-- 	if(not accountIsPass) then
-- 		text_accountTips.text = LanguageMgr:GetByID(accountError);
-- 	else
-- 		text_accountTips.text = "";
-- 	end
	
-- 	if(not pwdIsPass) then
-- 		text_pwdTips.text = LanguageMgr:GetByID(pwdError);
-- 	else
-- 		text_pwdTips.text = "";
-- 	end
-- end

-- --注册逻辑
-- function RegisterAccount()
-- 	local serverInfo = GetCurrentServer();
-- 	if serverInfo.state~=ServerListState.Maintentance then
-- 		EventMgr.Dispatch(EventType.Login_Show_Mask);
-- 		NetMgr.net:Connect(serverInfo.serverIp, serverInfo.port, function()
-- 			LoginProto:RegisterAccount(accountName, pwd, RegisterSuccess);
-- 		end);
-- 	else
-- 		InitServerInfo(function() --刷新服务器状态
-- 			serverInfo =GetCurrentServer();
-- 			if serverInfo.state~=ServerListState.Maintentance then
-- 				EventMgr.Dispatch(EventType.Login_Show_Mask);
-- 				NetMgr.net:Connect(serverInfo.serverIp, serverInfo.port, function()
-- 					LoginProto:RegisterAccount(accountName, pwd, RegisterSuccess);
-- 				end);
-- 			else
-- 				ShowCurrServerNotice();
-- 			end
-- 		end);
-- 	end
--  end
 
--  --注册成功 记录用户名和密码进入游戏
--  function RegisterSuccess()
-- 	EventMgr.Dispatch(EventType.Login_Hide_Mask);		
-- 	SaveLastServerInfo(serverInfo.id);
-- 	SaveLastAccount(accountName, pwd);
-- 	LanguageMgr:ShowTips(9002);
-- 	-- OnClickClose();
-- 	EventMgr.Dispatch(EventType.Login_Click_In,{account=accountName,pwd=pwd});
-- 	 -- LoginAccount(accountName, pwd);
--  end 

--点击了关闭按钮
function OnClickClose()
	EventMgr.Dispatch(EventType.Login_Click_Return, nil);
end

function PlayTween(isShow)
	local pos=isShow==true and {0,27.8,0} or {-1136,27.8,0};
	UIUtil:DoLocalMove(bg,pos,function()
		CSAPI.SetGOActive(childNode,isShow);
	end);
end


--设置登录类型
function SetLoginType(phoneAuthCodeType)
    isPhoneAuthCodeType = phoneAuthCodeType;
end
function IsPhoneAuthCodeType()
    return isPhoneAuthCodeType;
end


function OnClickChangeLogin1()
    SetLoginType(true);

    CSAPI.SetGOActive(btn_change_login1,false);
    CSAPI.SetGOActive(pwdObj,false);

    CSAPI.SetGOActive(btn_change_login2,true);
    CSAPI.SetGOActive(authCodeObj,true);
end
function OnClickChangeLogin2()
    SetLoginType(false);

    CSAPI.SetGOActive(btn_change_login1,true);
    CSAPI.SetGOActive(pwdObj,true);

    CSAPI.SetGOActive(btn_change_login2,false);
    CSAPI.SetGOActive(authCodeObj,false);
end

--发送验证码
function OnClickSendAuth()
    accountName = string.gsub(inp_account.text, "[%s+]", ""); --去除空格
    local data = 
    {
	    cmd = "login2",
	    subcmd = "code",
        phone = accountName
    };

    ChannelWebUtil.SendToServer2(data,nil,OnCodeSend);   
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

function SetCodeBtn()
	CSAPI.LoadImg(btn_sendCode,isSend and "UIs/Login/btn_10_11.png" or "UIs/Login/btn_10_10.png",true,nil,true);
end

--验证码登录
function Login_AuthCode()
    accountName = string.gsub(inp_account.text, "[%s+]", ""); --去除空格

    if(not inp_authCode)then
    	inp_authCode = ComUtil.GetCom(authCode, "InputField");
    end
    local code = inp_authCode.text;
    local data = 
    {
	    cmd = "login2",
	    subcmd = "code_login",
        phone = accountName,
        code = code,
        game_id = gameId;
    };
    
    EventMgr.Dispatch(EventType.Login_Phone_Auth_Code,data);   
end

function GetURL()
    local serverInfo = GetCurrentServer();
end