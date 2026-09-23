local currType = SettingWindowType.Main
local lastType = SettingWindowType.Main
local isBack = true
local delayTime = 0
local ids = {14040,14041,14042,14044,14044,14044,16094}
local inp_code1,inp_code2,inp_pwd,inp_rePwd,inp_account
local logStr = ""
local accountName = ""

function Awake()
    inp_code1 = ComUtil.GetCom(codeInput1, "InputField");
    inp_code2 = ComUtil.GetCom(codeInput2, "InputField");
    inp_pwd = ComUtil.GetCom(resetInput1, "InputField");
    inp_rePwd = ComUtil.GetCom(resetInput2, "InputField");
    inp_account = ComUtil.GetCom(accountInput, "InputField");
	CSAPI.AddInputFieldChange(resetInput1,OnPwdChange)
	CSAPI.AddInputFieldChange(resetInput2,OnRePwdChange)
	CSAPI.AddInputFieldChange(codeInput1,OnCodeChange1)
    CSAPI.AddInputFieldChange(codeInput2,OnCodeChange2)
    CSAPI.AddInputFieldChange(accountInput,OnAccountChange)
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Login_CD_Down2, CountDown);
    eventMgr:AddListener(EventType.Setting_Window_Logout_Agree, OnAgreeMent);
    eventMgr:AddListener(EventType.Login_SDK_DelAccount_CallBack, OnDelAccount);
end

function OnDelAccount(info)
    if info == nil then
        LogError("无注销账号信息返回！")
        return
    end
    local _data = Json.Decode(info)
    if _data.enabled == "true" or _data.enabled == true then
        -- logStr = LanguageMgr:GetTips(1016).. " " .. _data.voucher_no
        logStr = LanguageMgr:GetTips(1016)
        ShowPanel(SettingWindowType.Success)
    else
        logStr = LanguageMgr:GetTips(1017)
        ShowPanel(SettingWindowType.Log)
    end
end

function OnDisable()
    eventMgr:ClearListener()
end

function OnOpen()
    if openSetting then
        isBack = false
    end

    accountName = data or GetLastSDKInfo()
    ShowPanel(openSetting)
end

function ShowPanel(type)
    type = type or currType
    lastType = currType
    currType = type

    CSAPI.SetGOActive(main, type == SettingWindowType.Main)
    CSAPI.SetGOActive(code, type == SettingWindowType.LogoutCode)
    CSAPI.SetGOActive(reset, type == SettingWindowType.Reset or type == SettingWindowType.LoginReset)
    CSAPI.SetGOActive(account, type == SettingWindowType.Account)
    
    SetBG()
    SetTitle()
    SetDesc()
    SetBtn()
    CountDown(GetCodeCD2())
    SetLog()
end

function SetBG()
    if currType == SettingWindowType.Reset then
        CSAPI.SetRTSize(bg,1196,653)
        CSAPI.SetAnchor(bg,0,323)
        CSAPI.SetAnchor(layout,0,130)
        CSAPI.SetGOActive(accountObj, false)
        CSAPI.SetAnchor(resetImg,0,-175)
    elseif currType == SettingWindowType.LoginReset then
        CSAPI.SetAnchor(bg,0,388)
        CSAPI.SetRTSize(bg,1196,782)
        CSAPI.SetAnchor(layout,0,196)
        CSAPI.SetGOActive(accountObj, true)
        CSAPI.SetAnchor(resetImg,0,-240)
    else
        CSAPI.SetRTSize(bg,1196,560)
        CSAPI.SetAnchor(bg,0,323)
    end
end

function SetTitle()
    if currType == SettingWindowType.Log then
        LanguageMgr:SetText(txtTitle,ids[lastType])
    else
        LanguageMgr:SetText(txtTitle,ids[currType])
    end
end

function SetDesc()
    local str = string.sub(accountName,#accountName - 3,#accountName)
    if currType == SettingWindowType.LoginReset then
        LanguageMgr:SetText(txtDesc1, 16104)
    else
        LanguageMgr:SetText(txtDesc1, 16093, str .. "")
    end
    LanguageMgr:SetText(txtDesc2, 16093, str .. "")
end

function SetBtn()
    CSAPI.SetGOActive(btnReset, CSAPI.GetChannelType() ~= ChannelType.BliBli)

    local isNoActive = currType == SettingWindowType.Main or currType == SettingWindowType.Account 
    CSAPI.SetGOActive(btnSure,not isNoActive) 
    if currType == SettingWindowType.Reset then
        CSAPI.SetAnchor(btnSure,0,-243)
    elseif currType == SettingWindowType.LoginReset then
        CSAPI.SetAnchor(btnSure,0,-301)
    else
        CSAPI.SetAnchor(btnSure,0, -135)
    end
    

    CSAPI.SetGOActive(btnBack, currType == SettingWindowType.Account)
end

function SetLog()
    if currType == SettingWindowType.Log or currType == SettingWindowType.Success then
        CSAPI.SetText(txtLog, logStr)
    else
        CSAPI.SetText(txtLog, "")
    end
end

----------------------------------------主界面----------------------------------------
function OnClickReset()
    if not IsAccount() then
        ShowPanel(SettingWindowType.Reset)
    else
        LogError("请用官网SDK启动游戏！！！")
    end
end

function OnClickAccount()
    ShowPanel(SettingWindowType.Account)
end

function OnClickQuit()
    local tips = {}
	tips.content = LanguageMgr:GetTips(7000)
	tips.okCallBack = function()
        if CSAPI.IsADV() or CSAPI.IsDomestic() then
            Logout();
        else
            if CSAPI.IsChannel() then
                EventMgr.Dispatch(EventType.Login_SDK_LogoutCommand, nil, true);
            else
                Logout();
            end
        end
	end
	CSAPI.OpenView("Dialog", tips)	
end

function Logout()
    StartCodeCD2(0) --重置cd
    SaveLastSDKAccount()
	Tips.ClearMisionTips() --清除任务tips		
	PlayerClient:Exit();
	FightClient:Reset();
end

function CountDown(_time)
	delayTime=_time
	if delayTime>0 then
		CSAPI.SetText(txt_send1,LanguageMgr:GetByID(16070,math.floor(delayTime)));
        CSAPI.SetText(txt_send2,LanguageMgr:GetByID(16070,math.floor(delayTime)));
		if isSend==false then
			isSend=true;
			SetCodeBtn();
		end
	else
		CSAPI.SetText(txt_send1,LanguageMgr:GetByID(16066));
        CSAPI.SetText(txt_send2,LanguageMgr:GetByID(16066));
		isSend=false;
		SetCodeBtn();
	end
end

function SetCodeBtn()
	CSAPI.LoadImg(btnSend1,isSend and "UIs/Setting/btn_10_11.png" or "UIs/Setting/btn_10_10.png",true,nil,true);
    CSAPI.LoadImg(btnSend2,isSend and "UIs/Setting/btn_10_11.png" or "UIs/Setting/btn_10_10.png",true,nil,true);
end
----------------------------------------重置密码----------------------------------------
function OnClickSend1()
    if delayTime>0 then
        return
    end

    if currType == SettingWindowType.LoginReset then
        accountName = inp_account.text
    end
    --发送协议到服务器获取验证码
    ChannelWebUtil.SendToServer2({cmd=SendCMD.Change,subcmd=SendSubCMD.Code,phone=accountName},nil,OnCodeSend1);
end

function OnCodeSend1(json)
	if json.code==ResultCode.Normal then
		--启用CD
        StartCodeCD2(60);
		LanguageMgr:ShowTips(9007)
	else
		logStr = json.msg or ""
        ShowPanel(SettingWindowType.Log)
		-- EventMgr.Dispatch(EventType.Login_Hide_Mask);
	end
end

function OnPwdChange(str)
    local text=StringUtil:FilterChar(str);
	inp_pwd.text=text;
end

function OnRePwdChange(str)
    local text=StringUtil:FilterChar(str);
	inp_rePwd.text=text;
end

function OnCodeChange1(str)
    local text=StringUtil:FilterChar(str);
	inp_code1.text=text;
end

function OnAccountChange(str)
    local text=StringUtil:FilterChar(str);
	inp_account.text=text;
end

function OnResetEnter()
    --获取输入框内容并去除空格
	local pwd = string.gsub(inp_pwd.text, "[%s+]", "");
	local repwd = string.gsub(inp_rePwd.text, "[%s+]", "");
	local validCode=string.gsub(inp_code1.text,"[%s+]", "");
	--验证格式
	local pwdIsPass, _pwdError = ValidatePwd(pwd);
	local validIsPass,_validError= ValidateCode(validCode);
	
    if pwdIsPass and validIsPass and pwd == repwd then
        ChannelWebUtil.SendToServer2({cmd=SendCMD.Change,subcmd=SendSubCMD.Change,phone=accountName,password=pwd,code=validCode},nil,OnSendReset);
        return
    end

    if pwd ~= repwd then
        logStr = LanguageMgr:GetByID(16068);
    end

    if not pwdIsPass then
        logStr = LanguageMgr:GetByID(_pwdError);
    end

    if not validIsPass then
        logStr = LanguageMgr:GetByID(_validError);
    end

    ShowPanel(SettingWindowType.Log)
end

function OnResetEnter2()
    --获取输入框内容并去除空格
    local acc = string.gsub(inp_account.text, "[%s+]", "");
	local pwd = string.gsub(inp_pwd.text, "[%s+]", "");
	local repwd = string.gsub(inp_rePwd.text, "[%s+]", "");
	local validCode=string.gsub(inp_code1.text,"[%s+]", "");
	--验证格式
    local accIsPass, _accError = ValidateAccount(acc)
	local pwdIsPass, _pwdError = ValidatePwd(pwd);
	local validIsPass,_validError= ValidateCode(validCode);
	
    if accIsPass and pwdIsPass and validIsPass and pwd == repwd then
        ChannelWebUtil.SendToServer2({cmd=SendCMD.Change,subcmd=SendSubCMD.Change,phone=acc,password=pwd,code=validCode},nil,OnSendReset);
        return
    end

    if pwd ~= repwd then
        logStr = LanguageMgr:GetByID(16068);
    end

    if not pwdIsPass then
        logStr = LanguageMgr:GetByID(_pwdError);
    end

    if not validIsPass then
        logStr = LanguageMgr:GetByID(_validError);
    end

    if not accIsPass then
        logStr = LanguageMgr:GetByID(_accError);
    end

    ShowPanel(SettingWindowType.Log)
end

function OnSendReset(json)
    if json.code==ResultCode.Normal then
        logStr = LanguageMgr:GetTips(7006)
        ShowPanel(SettingWindowType.Success)
	else
		logStr = json.msg or ""
        ShowPanel(SettingWindowType.Log)
	end
end

----------------------------------------主线账号----------------------------------------

function OnAgreeMent()
    if not IsAccount() then
        ShowPanel(SettingWindowType.LogoutCode)
    else
        LogError("请用官网SDK启动游戏！！！")
    end
end

function OnClickLogout()
    if CSAPI.GetChannelType() == ChannelType.BliBli then
        local info = {
            name = PlayerClient:GetName(),
            channel = CSAPI.GetChannelName(),
            lv = PlayerClient:GetLv(),
            time = TimeUtil:GetTimeHMS(TimeUtil:GetTime(),"%Y.%m.%d")
        }
        EventMgr.Dispatch(EventType.Login_SDK_DelAccount, info, true)
    else
        CSAPI.OpenView("LoginAgreement",LanguageMgr:GetByID(16098),4,function (go)
            local lua =ComUtil.GetLuaTable(go)
            lua.isClose = true
        end);
    end
end

function OnClickSend2()
    if delayTime>0 then
        return
    end
    --发送协议到服务器获取验证码
    ChannelWebUtil.SendToServer2({phone=accountName},ChannelWebUtil.Extends.DelAccountMsg,OnCodeSend2);
end

function OnCodeSend2(json)
	if json.code==ResultCode.Normal then
        StartCodeCD2(60);
		LanguageMgr:ShowTips(9007)
	else
        logStr = json.msg or ""
        ShowPanel(SettingWindowType.Log)
	end
end

function OnCodeChange2(str)
    local text=StringUtil:FilterChar(str);
	inp_code2.text=text;
end

function OnLogOutEnter()
    --获取输入框内容并去除空格
	local validCode=string.gsub(inp_code2.text,"[%s+]", "");
	--验证格式
	local validIsPass,_validError= ValidateCode(validCode);
	
    if validIsPass then
        ChannelWebUtil.SendToServer2({game_id="1", phone=accountName,code=validCode},ChannelWebUtil.Extends.DelAccount,OnSendLogout);
        return
    end

    if not validIsPass then
        logStr = LanguageMgr:GetByID(_validError);
    end

    ShowPanel(SettingWindowType.Log)
end

function OnSendLogout(json)
    if json.code==ResultCode.Normal then
        logStr = LanguageMgr:GetByID(16099, g_AccountCancelTime)
        ShowPanel(SettingWindowType.Success)
	else
		logStr = json.msg or ""
        ShowPanel(SettingWindowType.Log)
	end
end

---------------------------------------------------------------------------------------


function OnClickSure()
    if currType == SettingWindowType.Reset then
        OnResetEnter()
    elseif currType == SettingWindowType.LoginReset then
        OnResetEnter2()
    elseif currType == SettingWindowType.LogoutCode then
        OnLogOutEnter()
    elseif currType == SettingWindowType.Success then
        if lastType~= SettingWindowType.LoginReset then
            Logout()
        else
            CloseWindow()
        end
    elseif currType == SettingWindowType.Log then
        ShowPanel(lastType)
    end
end

function OnClickBack()
    ShowPanel(SettingWindowType.Main)
end

function OnClickClose()
    if isBack then
        if currType == SettingWindowType.Log then
            ShowPanel(lastType)
            return
        elseif currType == SettingWindowType.Success and lastType~= SettingWindowType.LoginReset then
            Logout()
        elseif currType ~= SettingWindowType.Main and currType ~= SettingWindowType.Account then
            ShowPanel(SettingWindowType.Main)
            inp_code1.text = ""
            inp_code2.text = ""
            inp_pwd.text = ""
            inp_rePwd.text = ""
            return  
        end
    end
    CloseWindow()
end

function CloseWindow()
    EventMgr.Dispatch(EventType.Login_Hide_Mask)
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if btnBack.gameObject.activeInHierarchy==true and OnClickBack then
        OnClickBack();
    else
        OnClickClose();
    end
end