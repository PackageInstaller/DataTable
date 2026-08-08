---@class LoginUI : LoginUI_Generate
---##################### 【LoginUI Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LoginUI Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local LoginUI = class("LoginUI", require("LoginUI_Generate"))
local NotificationMgr = require("NotificationMgr")

local connectServerFunc
local poploginFunc
local _bindPhoneData
local canChangeServer = GV.GlobalConfig.CanChangeServer --是否能换服务器

local function _sendOpenGame(callback)
    local cjson = require "cjson"
    local url = string.format("%s/9/log/data", SDKMgr.datalogip)

    if url then
        local reqbody = cjson.encode({
            event_type = 2,
            platid = UnityEngine.Application.platform:ToInt(),
            device = NativeInfoLua.GetDeviceID(),
            device_info = NativeInfoLua.GetDeviceDetail(),
            channel = UpdateManager.Instance.Code5,
        })

        local dict = {}
        local loaderTime = 1
        local timeout = 20000 --20秒超时时间，由于第三方身份证验证可能比较慢，之前5秒不够
        HttpUtil.HttpRequest(url, reqbody, timeout, dict, function(respcode, responseJson)
            LuaLogger.ds(respcode, responseJson)
            local success = respcode == 200
            local response
            if responseJson and success then
                response = cjson.decode(responseJson)
                if response.error then
                    success = false
                end
            elseif respcode == 404 then
                response = {error = GE.PassportErrorCode.ServerConnectFailed}
            else
                response = {error = GE.PassportErrorCode.ResponseError}
            end

            callback(success, response)
        end)
    end
end

--初始化本地变量float
local function _checkDefaultFloat(key, defaultValue)
    if not UnityEngine.PlayerPrefs.HasKey(key) then
        UnityEngine.PlayerPrefs.SetFloat(key, defaultValue)
    end
end

--初始化本地变量int
local function _checkDefaultInt(key, defaultValue)
    if not UnityEngine.PlayerPrefs.HasKey(key) then
        UnityEngine.PlayerPrefs.SetInt(key, defaultValue)
    end
end

--初始化本地变量string
local function _checkDefaultString(key, defaultValue)
    if not UnityEngine.PlayerPrefs.HasKey(key) then
        UnityEngine.PlayerPrefs.SetString(key, defaultValue)
    end
end

function LoginUI:_adjustUI()
    -- if GlobalInfo.AdjustedUI then
    --     return
    -- end
    if self.isAdjustedUI then
        return
    end

    -- if not AutoAdjustCanvasRoot.Inst then
    --     return
    -- end

    print("LoginUI _adjustUI")
    --异性屏适配初始化
    local maxAdjustValue = PlayerPrefs.GetFloat(GE.LocalCustomDataKey.MaxAdjustValue) or 0
    UIMgr.SetMaxAdjustValue(maxAdjustValue)
    UIMgr:AdjustUI()
    -- local canvasAdjustValue = 0
    -- -- if (UnityEngine.PlayerPrefs.HasKey("CanvasAdjustValue")) then
    -- --     canvasAdjustValue = UnityEngine.PlayerPrefs.GetFloat("CanvasAdjustValue")
    -- -- else
    --     local screen = UnityEngine.Screen
    --     local designValue = 16.0 / 9.0
    --     local maxAdjustValue = 21.0 / 9.0
    --     local minAdjustValue = 4.0 / 3.0
    --     local currentValue = (screen.width / screen.height)
    --     if (currentValue > maxAdjustValue) then
    --         canvasAdjustValue = (maxAdjustValue - designValue)/(currentValue - designValue)
    --     elseif (currentValue < minAdjustValue) then
    --         canvasAdjustValue = (minAdjustValue - designValue)/(currentValue - designValue)
    --     else
    --         canvasAdjustValue = 0
    --     end
    --     UnityEngine.PlayerPrefs.SetFloat("CanvasAdjustValue", canvasAdjustValue)
    --     LuaLogger.ds("CanvasAdjustValue", canvasAdjustValue,currentValue,maxAdjustValue,minAdjustValue)
    -- -- end
    -- local adjustValue = 0
    -- -- if (UnityEngine.PlayerPrefs.HasKey("ScreenAdjustValue")) then
    -- --     adjustValue = UnityEngine.PlayerPrefs.GetFloat("ScreenAdjustValue")
    -- -- else
    --     -- local screen = UnityEngine.Screen
    --     local safeArea = screen.safeArea
    --     -- local designValue = 16.0 / 9.0
    --     if ((screen.width / screen.height) == designValue) then
    --         adjustValue = 0
    --     else
    --         adjustValue = (((screen.width - (screen.width - safeArea.width) * 2) / screen.height) - designValue) / (currentValue - designValue)
    --         adjustValue = 1 - math.min((adjustValue + canvasAdjustValue), 1)
    --         UnityEngine.PlayerPrefs.SetFloat("ScreenAdjustValue", adjustValue)
    --     end
    -- -- end
    -- LuaLogger.ds("ScreenAdjustValue", adjustValue)

    -- local uiAdjustValue = PlayerPrefs.GetFloat(GE.LocalCustomDataKey.UIAdjustValue) or 0
    -- UIMgr.SetMaxAdjustValue(canvasAdjustValue)
    -- UIMgr.SetCanvasRootPadding(uiAdjustValue)
    -- self.adjustRoot.autoAdjustCanvasRoot:SetPercent(adjustValue)
    -- self.adjustRoot.autoAdjustCanvasRoot:SetVerticalPadding()
    -- AutoAdjustCanvasRoot.Inst:SetPercent(adjustValue)
	-- AutoAdjustCanvasRoot.Inst:SetVerticalPadding()
    -- GlobalInfo.AdjustedUI = true
    self.isAdjustedUI = true
    --音乐音效大小初始化
    _checkDefaultInt(GE.LocalCustomDataKey.BGMIsOn, 1) --背景音乐开关
    _checkDefaultInt(GE.LocalCustomDataKey.SEIsOn, 1) --音效开关
    _checkDefaultInt(GE.LocalCustomDataKey.CVIsOn, 1) --语音开关
    _checkDefaultInt(GE.LocalCustomDataKey.AllIsOn, 1) --全局音量开关
    _checkDefaultFloat(GE.LocalCustomDataKey.BGMValue, 1) --背景音乐音量
    _checkDefaultFloat(GE.LocalCustomDataKey.SEValue, 1) --音效音量
    _checkDefaultFloat(GE.LocalCustomDataKey.CVValue, 1) --语音音量
    _checkDefaultFloat(GE.LocalCustomDataKey.AllValue, 1) --全局音量
    _checkDefaultInt(GE.LocalCustomDataKey.TimeLineIsOn, 1) --战斗大招特写开关
    _checkDefaultInt(GE.LocalCustomDataKey.CameraIsOn, 1)   --战斗切镜特写开关

    local bGMIsOn = UnityEngine.PlayerPrefs.GetInt(GE.LocalCustomDataKey.BGMIsOn)
    local sEIsOn = UnityEngine.PlayerPrefs.GetInt(GE.LocalCustomDataKey.SEIsOn)
    local cVIsOn = UnityEngine.PlayerPrefs.GetInt(GE.LocalCustomDataKey.CVIsOn)
    local allIsOn = UnityEngine.PlayerPrefs.GetInt(GE.LocalCustomDataKey.AllIsOn)
    local bGMValue = UnityEngine.PlayerPrefs.GetFloat(GE.LocalCustomDataKey.BGMValue)
    local sEValue = UnityEngine.PlayerPrefs.GetFloat(GE.LocalCustomDataKey.SEValue)
    local cVValue = UnityEngine.PlayerPrefs.GetFloat(GE.LocalCustomDataKey.CVValue)
    local allValue = UnityEngine.PlayerPrefs.GetFloat(GE.LocalCustomDataKey.AllValue)

    AudioMgr:setBGMVolume(bGMValue or 0)
    AudioMgr:setSEVolume(sEValue or 0)
    AudioMgr:setCVVolume(cVValue or 0)
    AudioMgr:setMasterVolume(allValue or 0)
    AudioMgr:SetBGMMute(bGMIsOn == 0)
    AudioMgr:SetSEMute(sEIsOn == 0)
    AudioMgr:SetVoiceMute(cVIsOn == 0)
    AudioMgr:SetMasterMute(allIsOn == 0)
end

local function _adjustUIForIOS()
    if not GV.IsIOSLogic or GlobalInfo.AdjustedUIForIOS then
        return
    end

    if not AutoAdjustCanvasRoot.Inst then
        return
    end

    if SDKMgr.iosCanvasPercent then
        local upBg = GameObject.New("canvas_up_bg")
        local downBg = GameObject.New("canvas_down_bg")

        local designWidth = UIMgr.DesignWidth
        local designHeight = UIMgr.DesignHeight

        local function setBgObj(obj, up)
            obj:SetParent(UIMgr.uiCanvas.gameObject.transform)
            local rectTrans = obj:GetOrAddComponent(TypeInfo.RectTransform)
            rectTrans.sizeDelta = Vector2.New(designWidth, designHeight / 2)
            obj.transform.localScale = Vector3.one
            local image = obj:GetOrAddComponent(TypeInfo.Image)
            if up then
                obj.transform:SetSiblingIndex(0)
                image.color = Color.NewFromStr("323748")
                rectTrans.anchoredPosition = Vector2.New(0, designHeight / 2)
            else
                obj.transform:SetSiblingIndex(0)
                image.color = Color.NewFromStr("1B1E26")
                rectTrans.anchoredPosition = Vector2.New(0, -designHeight / 2)
            end
        end

        setBgObj(upBg, true)
        setBgObj(downBg)

        AutoAdjustCanvasRoot.Inst:SetPercent(SDKMgr.iosCanvasPercent)
        AutoAdjustCanvasRoot.Inst:SetVerticalPadding()
    end

    GlobalInfo.AdjustedUIForIOS = true
end

function LoginUI:InitLogic()
    UIMgr.uiCamera.enabled = true
    self.msgEventHandler = {
        {GameMsgType.SetProtoAgreementCheck, self.SetProtoAgreementCheck},
    }
    self:autoChangeKvSize()
    -- Standalone = true
    if not GV.LogGameOpen and not Standalone then
        if (GV.GlobalConfig.IsInternalFormal() or GV.GlobalConfig.IsChannelTest()) and SDKMgr:isUserProtocolAgreed() then
        else
            local function gameOpenCallback(success)
                if success then
                    GV.LogGameOpen = true
                else
                    _sendOpenGame(gameOpenCallback)
                end
            end
            --todo:uncomment
            --_sendOpenGame(gameOpenCallback)
        end
    end
    --公告按钮
    self.noiteBtn:SetActive(true)
    --拉取公告数据
    ClientData:NoticeDataReq()

    if not GV.GlobalConfig.IsInternalFormal() and not GV.GlobalConfig.IsChannelTest() then
        if not DAdManager.Instance:IsAnyRewardAdLoaded() then
            GV.AdLogic.PreloadRewardAd()
        end 
    end
    
    local accountText
	local passwordText
    
    local loginData = SDKMgr:getLastLoginData()
	local lastAccount, lastPassword = loginData.account, loginData.password

    if not GV.IsServer then
        if lastAccount == "" or  lastAccount == nil then
            lastAccount = self:GenerateRandomPhoneNumber()
        end
        if lastPassword == "" or  lastPassword == nil then
            lastPassword = "123456"
        end
    end
	local accountInputField = GameObject.Find("AccountInputField")
    if accountInputField then
    	accountText = accountInputField:GetComponent(typeof(UnityEngine.UI.InputField))
        accountText.text = lastAccount
    end

    local passportInputField = GameObject.Find("PassportInputField")
    if passportInputField then
    	passwordText = passportInputField:GetComponent(typeof(UnityEngine.UI.InputField))
        passwordText.text = lastPassword
    end

    local standaloneCheck = self.standaloneCheck
    standaloneCheck.toggle.onValueChanged:AddListener(function (isOn)
        Standalone = isOn

        UnityEngine.PlayerPrefs.SetInt("Standalone", Standalone and 1 or 0)
    end)
    standaloneCheck.toggle.isOn = Standalone

    self.guideSkipToggle.toggle.isOn = false
    if not GV.IsServer then
        GV.SkipUsrGuide = false
        if GV.GlobalConfig.ShowMainPanelTestBtn then
            GV.SkipUsrGuide = self.guideSkipToggle.toggle.isOn
        end

        Standalone = false
        if GV.GlobalConfig.ShowMainPanelTestBtn then
            Standalone = UnityEngine.PlayerPrefs.GetInt("Standalone", 0) == 1
        end
        self.localDevToggle.toggle.isOn = Standalone
    end
    --GV.SkipUsrGuide = true
    -- self.beginGameBtn:SetActive(false)

    GlobalInfo.VersionStr = string.format("%d.%d.%d.%d.%d.%d", UpdateManager.Instance.Code1, UpdateManager.Instance.Code2, UpdateManager.Instance.Code3, UpdateManager.Instance.Code4, UpdateManager.Instance.Code5, UpdateManager.Instance.Code6)
    if EngineGlobal.patch and EngineGlobal.patch ~= "" then
        GlobalInfo.VersionStr = string.format("%s.%d.%d.%d.%d", EngineGlobal.patch, UpdateManager.Instance.Code3, UpdateManager.Instance.Code4, UpdateManager.Instance.Code5, UpdateManager.Instance.Code6)
    end
    --显示专用
    local versionDis = string.format("%d.%d.%d.%d.%d", UpdateManager.Instance.Code1, UpdateManager.Instance.Code2, UpdateManager.Instance.Code3, UpdateManager.Instance.Code4, UpdateManager.Instance.Code6)
    if EngineGlobal.patch and EngineGlobal.patch ~= "" then
        versionDis = string.format("%s.%d.%d.%d", EngineGlobal.patch, UpdateManager.Instance.Code3, UpdateManager.Instance.Code4, UpdateManager.Instance.Code6)
    end
    local showVersionStr = "游戏版本号:"..GlobalInfo.VersionStr
    local code5 = UpdateManager.Instance.Code5
--[[    if code5 >= 100000 then
        code5 = code5 - 100000
        showVersionStr = string.format("%d.%d.%d.%d.%d.%d", UpdateManager.Instance.Code1, UpdateManager.Instance.Code2, UpdateManager.Instance.Code3, UpdateManager.Instance.Code4, code5, UpdateManager.Instance.Code6)
    end]]
    local mode = EngineGlobal.mode
    if mode ~= "release" then
        showVersionStr = mode .. " " .. showVersionStr
    else
        if EngineGlobal.isAudit then
            showVersionStr = "审核 " .. showVersionStr
        end
    end
    if Application.platform ~= UnityEngine.RuntimePlatform.Android  and Application.platform ~= UnityEngine.RuntimePlatform.IPhonePlayer then
        if GV.GlobalConfig.VersionForTest then
            GlobalInfo.VersionStr = GV.GlobalConfig.VersionForTest
            showVersionStr = GV.GlobalConfig.VersionForTest
        end
    end
    self.version.text.text = showVersionStr

    poploginFunc = function ()

        if self.localDevToggle.toggle.isOn then
            GlobalInfo.DevPanel = true
            local loginData = SDKMgr:getLastLoginData()
            local lastAccount, lastPassword = loginData.account, loginData.password

            if not GV.IsServer then
                if lastAccount == "" or  lastAccount == nil then
                    lastAccount = self:GenerateRandomPhoneNumber()
                end
                if lastPassword == "" or  lastPassword == nil then
                    lastPassword = "123456"
                end
                self.account.inputField.text = lastAccount
                self.passport.inputField.text = lastPassword

            end

            self:showUIByMode()
        else
            SDKMgr:PopLogin()
        end
    end

    
    
    --------------------- DevPanel ---------------------
	--登录按钮
    local loginBtn = GameObject.Find("LoginBtn")
    if loginBtn then
        local button = loginBtn:GetComponent(TypeInfo.ScaleButton)
        -- button.onClick:AddListener(function()
        --     poploginFunc()
        --     UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        -- end)
    end

    --注册按钮
    -- local registerBtn = GameObject.Find("RegisterBtn")
    local registerBtn = self.registerBtn
    if registerBtn then
        local button = registerBtn:GetComponent(TypeInfo.ScaleButton)
        --TODO: 这里要换成打开注册界面 UIname: LoginEnrollPanel
        connectServerFunc = function ()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self:doLogin(function ()
                --暂时屏蔽选服界面
                if canChangeServer then
                    UIMgr:popUI("ServerListUI")
                end
            end)
        end

        button.onClick:AddListener(connectServerFunc)
    end

    local simDataField = GameObject.Find("SimDataField"):GetComponent(TypeInfo.InputField)
    local simFileField = GameObject.Find("SimFileField"):GetComponent(TypeInfo.InputField)
    -- 写入模拟玩家数据按钮
    local testBtn = GameObject.Find("WriteBtn")
    if testBtn then
        local button = testBtn:GetComponent(typeof(UnityEngine.UI.Button))
        button.onClick:AddListener(function ()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            --UIMgr:popUI("TestUI")
            local simPlayerTb
            if simDataField.text ~= "" then
                local content = "return " .. simDataField.text
                simPlayerTb = loadstring(content)()
            elseif simFileField.text ~= "" then
                simPlayerTb = require(simFileField.text)
            end
            
            -- accountText.text
            if simPlayerTb then
                require "GameGlobal".ReplaceSimData(accountText.text, simPlayerTb)
            end
        
            -- local http = require"socket/http"
            -- local ltn12 = require"ltn12"
            -- local url = "http://192.168.199.162:8001/abc"
            -- local HTTP_Verb = "POST"
        
            -- local result, respcode, respheaders, respstatus = http.request {
            --     method = HTTP_Verb,
            --     url = url,
            --     source = ltn12.source.string("hello"),
            -- }
        
        end)
    end
    
    -- 读取数据按钮
    local testBtn = GameObject.Find("ReadBtn")
    if testBtn then
        local button = testBtn:GetComponent(typeof(UnityEngine.UI.Button))
        button.onClick:AddListener(function ()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            local playerInfo = require "GameGlobal".GetSimPlayer(accountText.text, simDataField.text) -- simDataField.text用来获取本地的uid(1,2,3)
            UnityEngine.GUIUtility.systemCopyBuffer = tablex.dump(playerInfo)
            simDataField.text = tablex.dump(playerInfo)
        end)
    end

    local function prepareToConnectServer()
        loginBtn:SetActive(false)
        registerBtn:SetActive(true)
        
        if GlobalInfo.DirectLogin then
            connectServerFunc()
        end
    end

    local function setLoginBtn()
        loginBtn:SetActive(true)
        registerBtn:SetActive(false)
    end
    --------------------- DevPanel ---------------------

    setLoginBtn()
    --todo:uncomment
    --self.deleteAccountBtn:SetActive(false)

    SDKMgr:LoginSuccessCallBack(function()
        -- if self.firstLogin then
        --     self.firstLogin = false
        --todo:uncomment
        --self.deleteAccountBtn:SetActive(SDKMgr:isShowDeleteAccount())

        if SDKMgr:getChannel() == GE.Channel.Quick_HuaWei then
            self.deleteAccountBtn.text.text.text = "注销账号"
        end
        
        -- self.beginGameBtn:SetActive(true)

        RequireDbg("NetMidw")
        RequireDbg("NetManager2")
        RequireDbg("LoginNetManager")
        RequireDbg("GameNetManager")

        LoginNetHandler = require "LoginNetManager":new("LoginNetHandler")
        LoginNetHandler.OpenPb("login.pb")
        LoginNetHandler.MsgFilter = require ("UICommonUtils").IsRetOk

        GameNetHandler = require "GameNetManager":new("GameNetHandler")
        GameNetHandler.OpenPb("user.pb")
        GameNetHandler.MsgFilter = require ("UICommonUtils").IsRetOk
        -- 未成年因不满足进入游戏条件，打开SelectUserPanel前在ClientData注册通知消息前就可能被发送此消息，为避免出现No callback for 389:user.None18OvertimeNtf，注册一个空的
        GameNetHandler:RegisterMsgDealer("user.None18OvertimeNtf", function ()
            LuaLogger.ds("xxx")
        end)
        GameNetHandler:addProtoesToRmvOnDisconnect({"user.TimeReq", "user.EnterSceneReq", {protoName = "user.LoginGateReq", callback = true}})
        LoginNetHandler:addProtoesToRmvOnDisconnect({
            {protoName = "login.ChallengeReq", callback = true},
            {protoName = "login.KeyReq", callback = true},
            {protoName = "login.VerifySecretReq", callback = true},
            {protoName = "login.LoginAuthReq", callback = true},
            {protoName = "login.ZoneListReq", callback = true},
            {protoName = "login.LoginZoneReq", callback = true},
        })

        GlobalInfo.account = SDKMgr.account
        ---@type DPlayerPrefs
        AccountPrefs = require "DPlayerPrefs":new(SDKMgr:getSaveID())
        LuaLogger.ds("LoginAccount", SDKMgr:getSaveID())

        if GlobalInfo.DevPanel then
            prepareToConnectServer()
        else
            self:doLogin(function (data)
                LuaLogger.ds("showBindPhone doLogin callback", data.phone)
                self:checkBindWhenLoginSuccess(data)
            end)
        end
        -- self:TestLuaProtobuf1()
        -- self:TestLuaProtobuf2()
        -- self:TestPBC()
    end)
    SDKMgr:FastLoginSuccessCallBack(function()
        -- prepareToConnectServer()
    end)
    SDKMgr:RegisterSuccessCallBack(function()
        LuaLogger.ds("RegisterSuccessCallBack")
    end)
    SDKMgr:QuickRegisterSuccessCallBack(function(account, password)
        
    end)
    SDKMgr:SwtichAccountCallBack(function()
        setLoginBtn()
    end)
    --退出登录回调
    SDKMgr:SetLogoutCallBack(function ()
        --todo:uncomment
        --self.deleteAccountBtn:SetActive(false)
        if LoginNetHandler then
            LoginNetHandler:Disconnect()
        end

        GlobalInfo.AntiAddictionCantLogin = nil
        self.currServerName.text.text = ""
        GlobalInfo.CurrZone = nil
        poploginFunc()
    end)
    --修改密码成功回调
    SDKMgr:ChangePasswordCallBack(function()
        
    end)
    -- self.firstLogin = true
    self.currServerName.text.text = ""
    -- self.devPanel = GameObject.Find("DevPanel")
    -- self.formalPanel = GameObject.Find("FormalPanel")
    --点击选服tips
    self.changeServerBtn.text:SetActive(canChangeServer)
    self:showUIByMode()

    GlobalInfo.LoginType = GE.LoginType.Official

    if not GlobalInfo.DevPanel then
        self:autoLogin()
    end

    --右上角适龄提示
    local longPressListener = self.ageAdaptBtn.clickLongPressListener
    longPressListener.onLongpress = function ()
        local nowLocalServerTest = GV.GlobalConfig.LocalServerTest
        UnityEngine.PlayerPrefs.SetInt(GE.LocalCustomDataKey.LocalServerTest, nowLocalServerTest and 0 or 1)
        UnityEngine.SceneManagement.SceneManager.LoadSceneAsync("ReStart",UnityEngine.SceneManagement.LoadSceneMode.Additive)
    end

    ClientData:sendGameOpenLogMessage(Config.GameStageStr.Login)

    self.repairBtn:SetActive(false)


     --公告 - 渠道包（所有）入口隐藏公告按钮
     --self.noiteBtn:SetActive(false)
end

function LoginUI:GenerateRandomPhoneNumber()
    -- 中国大陆手机号码前缀（示例，实际可扩展）
    local prefixes = {"13", "15", "17", "18", "19"}
    -- 随机选择前缀
    local prefix = prefixes[math.random(1, #prefixes)]
    -- 生成剩余8位随机数字
    local suffix = ""
    for i = 1, 8 do
        suffix = suffix .. math.random(0, 9)
    end
    -- 拼接前缀和后缀
    return prefix .. suffix
end

function LoginUI:TestLuaProtobuf1()
    Debugger.Log("11111111111111111111111111111111111")
    local pb = require "pb"
    -- local protoc = require "protoc"
    local serpent = require "serpent"
    local data = 
    {
        name = "ilse",
        age = 18,
        contacts = 
        {
            { name = "alice", phonenumber = 12312341234 },
            { name = "bob", phonenumber = 45645674567 }
        },
        phoneMap =
        {
            [666] = { name = "haha", phonenumber = 666666 },
            [999] = { name = "haha", phonenumber = 999999 }
        },
        myPhone = 
        { 
            name = "me", 
            phonenumber = 666666666 
        },
        myInfo =
        {
            aid = 1,
            id = 1,
            borntime = 1
        },
        res =
        {
            -- ret = 0,
            -- info = "0"
        }
    }

    local bytes = assert(pb.encode("user.Person", data))
    print(pb.tohex(bytes))

    local data2 = assert(pb.decode("user.Person", bytes))
    print(serpent.block(data2))

    for k, v in pairs(data2.phoneMap) do
        print(type(k))
    end

end

function LoginUI:TestLuaProtobuf2()
    Debugger.Log("22222222222222222222222222222222222")
    local pb = require "pb"
    -- local protoc = require "protoc"
    local serpent = require "serpent"
    local data = {}
    data.hasCatList = {}
    data.hasCatMap = {}
    for i = 1, 3 do
        local randomLevel = math.random(5, 100)
        table.insert(data.hasCatList, { id = i, cid = i, level = randomLevel, exp = 20, skillLevel = 1,})
        data.hasCatMap[i * 1000] = { id = i, cid = i, level = randomLevel, exp = 20, skillLevel = 1,}
    end

    local bytes = assert(pb.encode("user.ChangeHasCatListResp", data))
    print(pb.tohex(bytes))

    local data2 = assert(pb.decode("user.ChangeHasCatListResp", bytes))
    print(serpent.block(data2))
end

function LoginUI:TestPBC()
    Debugger.Log("3333333333333333333333333333")
    local protobuf = require "protobuf"
    local buffer = DFileUtil.ReadFile("user.pb")
    protobuf.register(buffer)
    local data = 
    {
        ret = 666,
        info = "haha"
    }
    local bytes = protobuf.encode("user.ErrorReason", data)
    local data2 = protobuf.decode("user.ErrorReason", bytes)
    print(tablex.dump(data2))
end

function LoginUI:dealFailInLogin()
    UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, LocalStrEnum.LoginFailedText, function ()
        poploginFunc()
    end)
end

function LoginUI:doLogin(callback)
    local continueFunc = function()
        LoginNetHandler:doLogin(function (result, phone)
            print("LoginUI:doLogin result", tablex.dump(result))
            if result == true then
                print("LoginUI:doLogin phone", phone)
                _bindPhoneData = {phone = phone}
                LoginNetHandler:reqZoneList(function(zones)   
                    GlobalInfo.zones = zones
    
                    if not zones then
                        self:dealFailInLogin()
                        --UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, LocalStrEnum.ServerIsBeingMaintainedText)
                        return
                    end
                    
                    local zone = SDKMgr:getLastLoginZone()
                    local zone1 = zones[1]
                    if not zone then
                        zone = zone1
                    elseif Standalone or (not Standalone and zone.name == "SimServer") or zone.name ~= zone1.name then
                        local findLastLoginZone
                        for i, v in ipairs(zones) do
                            if v.name == zone.name and v.id == zone.id then
                                findLastLoginZone = v
                                break
                            end
                        end
    
                        if not findLastLoginZone then
                            zone = zone1
                        end
                    end
    
                    LuaLogger.ds("zone", tablex.dump(zone))
                    self.currServerName.text.text = zone.name
                    GlobalInfo.CurrZone = zone
    
                    if callback then
                        callback(_bindPhoneData)
                    end
    
                    if GlobalInfo.DirectLogin then
                        LoginNetHandler:LoginZoneFlow(zone)
                    end
                end)
            elseif istable(result) then
                if result.ret == GE.LoginErrorCode.NormalFailed then
                    self:dealFailInLogin()
                else
                    local banStr = ""
                    if result.ret == GE.LoginErrorCode.BanIp then
                        banStr = LocalStrEnum.LoginBanIp
                    elseif result.ret == GE.LoginErrorCode.BanDevice then
                        banStr = LocalStrEnum.LoginBanDevice
                    elseif result.ret == GE.LoginErrorCode.BanAccount then
                        banStr = LocalStrEnum.LoginBanAccount
                    end
    
                    if result.ban_end_stamp and result.ban_end_stamp ~= 0 then
                        banStr = banStr .. "\n" .. string.format(LocalStrEnum.LoginBanRemoveTime, luautil.getCommonDatetime(result.ban_end_stamp, true))
                    end
    
                    UICommonUtils.PopPromptBox(banStr, function ()
                        Application.Quit()
                    end)
                end
            else
                self:dealFailInLogin()
            end
        end)
    end
    --检测是否需要实名认证
	if SDKMgr:GetIsNeedAuth() then
		LuaLogger.ds("我需要实名！")
		UIMgr:popUICover("WinSDK", {funcType = GE.SDKFuncType.Auth, continueFunc = continueFunc})
		return
    else
        continueFunc()
    end
end

function LoginUI:showUIByMode()
    self.devPanel:SetActive(GlobalInfo.DevPanel)
    self.formalPanel:SetActive(not GlobalInfo.DevPanel)
    self.editorMode:SetActive(GV.IsEditor and GV.GlobalConfig.ShowMainPanelTestBtn)
    self.notifyTestBtn:SetActive(GV.GlobalConfig.ShowMainPanelTestBtn)
    self.changeServerBtn:SetActive(GV.GlobalConfig.ShowMainPanelTestBtn)
    self.toggleFormalPanel:SetActive(GV.GlobalConfig.ShowMainPanelTestBtn)
    self.deleteAccountBtn:SetActive(GV.GlobalConfig.ShowMainPanelTestBtn)

    self.guideSkipToggle:SetActive(GV.GlobalConfig.ShowMainPanelTestBtn)
    self.localDevToggle:SetActive(GV.GlobalConfig.ShowMainPanelTestBtn)

end

function LoginUI:autoLogin()
    local loginData = SDKMgr:getLastLoginData()
    local getAccountFunc = function ()
        -- LuaLogger.ds(lastAccount, lastPassword)
        SDKMgr.IsAutoLogin = true
        SDKMgr:doLogin(loginData, function( bSuccess, data )
            if not bSuccess then
                if data.error == GE.PassportErrorCode.AccountNotExist then
                    poploginFunc()
                else
                    UICommonUtils.DealSDKError(data, LocalStrEnum.PromptTitle, nil, poploginFunc)
                end
            else
                SDKMgr:doLoginSuccess(data)
                LuaLogger.ds("login passport success!", data.account)
            end
            -- 要放在最后面
            SDKMgr.IsAutoLogin = false
        end)
    end
    
    -- LuaLogger.ds("LastLoginData", tablex.dump(loginData))
    if loginData.loginType ~= nil then
        getAccountFunc()
    else
        poploginFunc()
    end
end

function LoginUI:OnOpen(data, initiative)
    -- self:RefreshNewZone()
    if not initiative then
        if GlobalInfo.CurrZone then
            self.currServerName.text.text = GlobalInfo.CurrZone.name
        end
        
        return
    else
        DUtil.SendGameStageLogMessage(2, "登录界面");
    end

    local protoAgreementCheck = UnityEngine.PlayerPrefs.GetInt("ProtoAgreementCheck", 0) == 1
    self.protoAgreementCheck.toggle.isOn = protoAgreementCheck
end

--动态调整KV大小，适配
function LoginUI:autoChangeKvSize()
    local CanvasScaler =  UIMgr.uiCanvas.gameObject:GetComponent("CanvasScaler")
    local screen_width = CanvasScaler.referenceResolution.x
    local screen_height = CanvasScaler.referenceResolution.y
    local kv_width = self.kvBg.rectTransform.rect.width
    local kv_height = self.kvBg.rectTransform.rect.height
    local scale_width = screen_width / kv_width
    local scale_height = screen_height / kv_height
    -- Debugger.LogError("scale_width={0} scale_height={1}", scale_width, scale_height)
    -- local scale = math.max(scale_width, scale_height)
    -- 目前上下黑边的处理方式，只以宽度为准
    local scale = scale_width
    self.kvBg.rectTransform.localScale = Vector3.New(scale, scale, 1)
end

function LoginUI:OnDestroy()
    --print("LoginUI destroy", debug.traceback())
    self:releasTimmer()
    self.super:OnDestroy(self)
end

function LoginUI:RefreshNewZone()
    local setting
    local default_show
    if GV.GlobalConfig.IsInternalFormal() then
        local ServerLocal = require("ServerLocal")
        setting = clone(ServerLocal.internal_server)
        default_show = ServerLocal.internal_defailt_show
    else
        local ServerLocal = require("ServerLocal")
        setting = clone(ServerLocal.abroad_server)
        default_show = ServerLocal.abroad_defailt_show
    end
    self:releasTimmer()
    if not setting then
        self.newZone.gameObject:SetActive(false)
        return
    end
    for _, v in pairs(setting) do
        if v.open_gmt_time then
            v.open_gmt_time = luautil.getStampByDateStr(v.open_gmt_time)
        end
    end
    local function showLeftTime(extra, time)
        local leftTime = string.format("%s %s %s", extra, LocalStrEnum.UI_LoginPanel_NewServerLeftTime, DLuaUtil.SecondsToTimeStr7(time))
        self.newZone.text.text = leftTime
    end
    local curr = DLuaUtil.GetGreenwichTime()
    self.newZone.gameObject:SetActive(true)
    for _, data in pairs(setting) do
        if curr < data.open_gmt_time then
            local leftTime = data.open_gmt_time - curr
            showLeftTime(data.extra_txt, leftTime)
            local ti = DTimer.TimerInfo.New()
            ti.Left = 1
            ti.Interval = 1
            ti.MaxRepeatNum = leftTime + 1
            ti.CombMode = true
            local currRepeatNum = 0
            ti.OnComp = function(repeatNum)
                leftTime = leftTime - (repeatNum - currRepeatNum)
                currRepeatNum = repeatNum
                if leftTime  >= 0 then
                    showLeftTime(data.extra_txt, leftTime)
                else
                    self:RefreshNewZone()
                end
            end
            self.newZoneTimmer = ti
            DTimer.Instance:StartTimer(self.newZoneTimmer)
            return
        end
    end
    self.newZone.text.text = default_show or ""

end

function LoginUI:releasTimmer()
    if self.newZoneTimmer then
        DTimer.Instance:RemoveTimer(self.newZoneTimmer)
    end
end

function LoginUI:Update()
    self:_adjustUI()
    _adjustUIForIOS()
    
    if not GV.GlobalConfig.LocalServerTest then
        return
    end
    
    if Input.GetKeyDown(KeyCode.LeftAlt) and Input.GetKeyDown(KeyCode.RightAlt) then
        GlobalInfo.DirectLogin = true
        if GlobalInfo.DevPanel then
            poploginFunc()
        else
            self:beginGameBtn_Button_onClick()
        end
    end
end

--[[
/FormalPanel/changeServerBtn onClick 
--]]
function LoginUI:changeServerBtn_Button_onClick(changeServerBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not SDKMgr:isloginIn() then
        return 
    end
    --暂时取消选服
    if canChangeServer then
        UIMgr:popUICover("ServerListUI")  
    end
end

function LoginUI:checkBindWhenLoginSuccess(data)
    LuaLogger.ds("showBindPhone checkBindWhenLoginSuccess", data.phone)
    if SDKMgr.loginType == GE.LoginType.TapTap and not data.phone then
        self:showBindPhonePanel()
    else
        return true
    end
end

function LoginUI:tryStartLoginFlow(data)
    LuaLogger.ds(debug.traceback())
    LuaLogger.ds("showBindPhone tryStartLoginFlow", data.phone)
    if not self:checkBindWhenLoginSuccess(data) then
        LuaLogger.ds("checkBindWhenLoginSuccess")
        return
    end

    if GlobalInfo.AntiAddictionCantLogin then
        UICommonUtils.PopPromptBox("防沉迷中，无法进入游戏！", function ()
            if GlobalInfo.AntiAddictionCantLogin == 9002 then
                SDKMgr:startAntiAddiction()
            end
        end)
        return
    end
    
    LoginNetHandler:LoginZoneFlow(GlobalInfo.CurrZone)
end

--[[
/FormalPanel/beginGameBtn onClick 全图登录按钮
--]]
function LoginUI:beginGameBtn_Button_onClick(beginGameBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --自动登录期间不进行登录操作
    if SDKMgr.IsAutoLogin then
        return
    end
    --未登录则唤出登录界面
    if not SDKMgr:isloginIn() then
        poploginFunc()
    else
        if LoginNetHandler then
            if (self.protoAgreementCheck.toggle.isOn == false) then
                self:openAgreementMsgBox()
                return
            else
                UnityEngine.PlayerPrefs.SetInt("ProtoAgreementCheck", 1)
            end
            -- local SE = string.format(Config.table.AudioConfigTable.SE, 5)
            -- self:play2DSound(SE)
            if GlobalInfo.CurrZone and LoginNetHandler.Netstate == NetHandler2.NetState2.Connected then
                self:tryStartLoginFlow(_bindPhoneData)
            else
                self:doLogin(function (data)
                    if GlobalInfo.CurrZone then
                        self:tryStartLoginFlow(data)
                    end
                end)
            end
        end
    end
end

--[[
/ToggleFormalPanel onClick 
--]]
function LoginUI:toggleFormalPanel_Button_onClick(toggleFormalPanel)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if GlobalInfo.DevMode then
        GlobalInfo.DevPanel = not GlobalInfo.DevPanel
        self:showUIByMode()
        -- RoomMgr:SetDevMode(true)
    end
end
 
--[[
/FormalPanel/ageAdaptBtn onClick 右上角适龄提示
--]]
function LoginUI:ageAdaptBtn_Button_onClick(ageAdaptBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUICover("AgeTips")
end

--[[
/PlotEditorBtn onClick 
--]]
function LoginUI:plotEditorBtn_Button_onClick(plotEditorBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    -- if not tonumber(self.nowStoryID) then
    --     UICommonUtils.PopToast("请输入需要加载的故事ID！")
    --     return
    -- end
    GV.StoryEditorFileName = string.gsub(self.nowStoryID, "\r\n", "")
    --UICommonUtils.CheckOrCreatStoryFileById(nowId)

    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "LoginUI")
end

--[[
/RoleSpineBtn onClick 
--]]
function LoginUI:roleSpineBtn_Button_onClick(roleSpineBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUI("ShowRoleSpinePanel")
end

--[[
/FormalPanel/deleteAccountBtn onClick 
--]]
function LoginUI:deleteAccountBtn_Button_onClick(deleteAccountBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not SDKMgr:isloginIn() then
        return
    end
    
    local function doDeleteAccount()
        LoginNetHandler:SendWaitMessage("login.DeleteAccountReq", {}, function (data)
            LuaLogger.ds("login.DeleteAccountReq back", tablex.dump(data))

            local content
            if data and data.ret == 0 then
                if SDKMgr:getLoginType() == GE.LoginType.Official then
                    content = LocalStrEnum.DeleteAccountSuccess
                else
                    content = LocalStrEnum.DeleteAccountSuccessChannel
                end
                
                SDKMgr:doLogout()
            else
                content = LocalStrEnum.DeleteAccountFailed
            end

            UICommonUtils.PopPromptBox(content)
        end)
    end

    local promptStr = LocalStrEnum.ConfirmDeleteAccount
    if SDKMgr:getChannel() == GE.Channel.Quick_HuaWei then
        promptStr = "注销账号将删除该注册账号以及对应的角色数据，确定删除当前账号吗？"
    end
    
    UICommonUtils.PopPromptOkCancelBox(promptStr, function()
        if LoginNetHandler.Netstate == NetHandler2.NetState2.Connected then
            doDeleteAccount()
        else
            self:doLogin(function ()
                doDeleteAccount()
            end)
        end
    end)
end

function LoginUI:showBindPhonePanel()
    -- self.formalRegister:SetActive(true)
    -- self.formalRegister.protoAgreementCheck.protoAgreementPart.toggle.isOn = false
    --todo 调用winsdk
end

function LoginUI:SetProtoAgreementCheck()
    self.protoAgreementCheck.toggle.isOn = true
end

function LoginUI:openAgreementMsgBox()
    UIMgr:popUI("MsgBox", {
        title = LocalStrEnum.MasgboxAgreementTitle, 
        type = MsgBoxType.Agreement,
        okCallback = function()
            self.protoAgreementCheck.toggle.isOn = true
            UnityEngine.PlayerPrefs.SetInt("ProtoAgreementCheck", 1)
        end,
        userpotocolUrl = "https://www.moecove.com/agreement.html",
        policyUrl = "https://www.moecove.com/privacy.html",
        confirmText = LocalStrEnum.MsgboxConfirm2,
        cancelText = LocalStrEnum.MsgboxCancel2,
    })
end

--[[
/PlotEditorBtn/PlotIDInputField onEndEdit 
--]]
function LoginUI:plotIDInputField_InputField_onEndEdit(plotIDInputField,content)
    --if tonumber(plotIDInputField.inputField.text) then
        self.nowStoryID = plotIDInputField.inputField.text
    --else
        --plotIDInputField.inputField.text = ""
        --UICommonUtils.PopToast("请输入纯数字ID！")
    --end
end

local _contents = {"操作超时", "手机号不正确", "验证码不正确", "验证码校验不正确", "绑定失败"}
_contents[0] = "绑定成功"

--[[
/FormalPanel/changeAccountBtn onClick 左下角切换账号按钮
--]]
function LoginUI:changeAccountBtn_ScaleButton_onClick(changeAccountBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --登录状态下切换账号提示
    if SDKMgr:isloginIn() then
        UICommonUtils.PopPromptOkCancelBox(LocalStrEnum.ConfirmLogoutAccount, function()
            SDKMgr:doLogout()
            poploginFunc()
        end)
    else
        poploginFunc()
    end

end

--[[
/FormalPanel/NoiteBtn onClick 
--]]
function LoginUI:noiteBtn_ScaleButton_onClick(noiteBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUICover("NoticePanel")
end

--[[
/FormalPanel/PrivacyBtn onClick 隐私政策
--]]
function LoginUI:privacyBtn_ScaleButton_onClick(privacyBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Application.OpenURL("https://www.moecove.com/privacy.html")
end

--[[
/NotifyTestBtn onClick 推送功能测试按钮
--]]
function LoginUI:notifyTestBtn_Button_onClick(notifyTestBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    -- local Color = UnityEngine.Color
	-- 	-- local UILoader = gamecore.UILoader
	-- 	-- local age_reminder = UILoader:createInstance("age_reminder")
	-- 	-- age_reminder:show()
	-- 	local notify = Unity.Notifications.Android
	-- 	local Importance = notify.Importance
	-- 	local channel_config = {
	-- 		channel_id = "mby",
	-- 		name = "猫",
	-- 		importance = Importance.Default,
	-- 		desc = "descdesc"
	-- 	}
	-- 	NotificationMgr:CreateChannel(channel_config)
    --     local now = os.time()
    --     local targetTime = os.time() + 4*3600
    --     local year = os.date("%Y",targetTime)
    --     local month = os.date("%m",targetTime)
    --     local day = os.date("%d",targetTime)
    --     local hour = os.date("%H",targetTime)
    --     local minute = os.date("%M",targetTime)
    --     local second = os.date("%S",targetTime)
    --     local DateTime = NotifyManager.GenerateDateTime(year, month, day, hour, minute, second)
	-- 	local notify_config = {
	-- 		title = "title",
	-- 		text = "desc",
	-- 		dateTime = DateTime,
	-- 		autocancel = false,
	-- 		small_icon = "",
	-- 		big_icon = "",
	-- 		intentdata = "sss.json",
	-- 		color = Color.red,
	-- 	}
	-- 	NotificationMgr:CreateNotification(notify_config, "12")
	-- 	NotificationMgr:SetReceivedListener(function(str)
	-- 		print('触发')
	-- 	end)
	-- 	NotificationMgr:SetCheckAppStartListener(function(str)
	-- 		print('启动')
	-- 	end)
	-- 	--ios
	-- 	NotificationMgr:SetIosCheckPermissionListener(function(granted, error, token)
	-- 		print(granted)
	-- 		print(error)
	-- 		print(token)
	-- 	end)
    --     local targetTime = os.time() + 4*1
    --     local year = os.date("%Y",targetTime)
    --     local month = os.date("%m",targetTime)
    --     local day = os.date("%d",targetTime)
    --     local hour = os.date("%H",targetTime)
    --     local minute = os.date("%M",targetTime)
    --     local second = os.date("%S",targetTime)
    --     local DateTime = NotifyManager.GenerateDateTime(year, month, day, hour, minute, second)
	-- 	local data = {
	-- 		title = "titleIos",
	-- 		text = "这是内容",
	-- 		subtitle = "这是次级内容",
	-- 		-- dateTime = System.DateTime.Now:AddSeconds(4),
    --         dateTime = DateTime,
	-- 		showInForeground = true,
	-- 		repeats = false
	-- 	}
	-- 	NotificationMgr:CreateNotificationIos(data)
        --测试界面
        UIMgr:popUI("NotifyTestPanel")
end

--[[
/AvgEditorBtn onClick 
--]]
function LoginUI:avgEditorBtn_Button_onClick(avgEditorBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not tonumber(self.nowAvgID) then
        UICommonUtils.PopToast("请输入需要加载的故事ID！")
        return
    end
    GV.isAvgEditor = true
    UIMgr:popUICover("StoryPanel", {storyName = "avg_"..self.nowAvgID, callBack = function()
        UIMgr:showUI(self)
        GV.isAvgEditor = false
    end})
    UIMgr:hideUI(self)
end

--[[
/AvgEditorBtn/AvgIDInputField onEndEdit 
--]]
function LoginUI:avgIDInputField_InputField_onEndEdit(avgIDInputField,content)
    if tonumber(avgIDInputField.inputField.text) then
        self.nowAvgID = avgIDInputField.inputField.text
    else
        avgIDInputField.inputField.text = ""
        UICommonUtils.PopToast("请输入纯数字ID！")
    end
end

--[[
/DevPanel/RegisterBtn onClick 
--]]
function LoginUI:registerBtn_ScaleButton_onClick(registerBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
end

--[[
/DevPanel/LoginBtn onClick 
--]]
function LoginUI:loginBtn_ScaleButton_onClick(loginBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local loginData = {loginType = GE.LoginType.Official}
       
    local account = self.account.inputField.text
	local password = self.passport.inputField.text
    loginData.account = account
    loginData.password = password

    SDKMgr:doLogin(loginData, function(bSuccess, data) -- data中的数据如果是Firebase登录的话数据在dealFirebaseLoginCallback中处理
        if bSuccess == false then
            UICommonUtils.DealSDKError(data, LocalStrEnum.PromptTitle, nil, poploginFunc)
        else
            SDKMgr:doLoginSuccess(data)
            GlobalInfo.DevPanel = false
            self:showUIByMode()
            --connectServerFunc()
            self:doLogin(function (data)
                LuaLogger.ds("showBindPhone doLogin callback", data.phone)
                self:checkBindWhenLoginSuccess(data)
            end)
        end
    end)

end

--[[  点击备案号 
/FormalPanel/tips/tips2 onClick 
--]]
function LoginUI:tips2_Button_onClick(tips2)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Application.OpenURL("https://beian.miit.gov.cn/")
end

--[[
/DevPanel/StandaloneCheck onValueChanged 
--]]
function LoginUI:standaloneCheck_Toggle_onValueChanged(standaloneCheck,isOn)
    
end

--[[
/GuideSkipToggle onValueChanged 
--]]
function LoginUI:guideSkipToggle_Toggle_onValueChanged(guideSkipToggle,isOn)
    GV.SkipUsrGuide = isOn
end

--[[
/AdjustRoot/RightPanel/RepairBtn onClick  本地资源修复
--]]
function LoginUI:repairBtn_ScaleButton_onClick(repairBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --测试代码 随机删除文件
    UpdateManager.Instance.RandomDeletePhysicalFiles(5, true, false)
    UICommonUtils.PopOkBox(LocalStrEnum.RepairTipsTitle, LocalStrEnum.RepairTipsDesc, function ()
        --设置强制检测本地文件状态 用于在热更版本检测前执行一次本地文件校验
        UnityEngine.PlayerPrefs.SetInt("ForceCheckLocalFile", 1)
        UpdateManager.Instance.FixedLocalFile()
        UnityEngine.SceneManagement.SceneManager.LoadSceneAsync("ReStart",UnityEngine.SceneManagement.LoadSceneMode.Additive)
    end)
end

--[[
/LocalDevToggle onValueChanged 
--]]
function LoginUI:localDevToggle_Toggle_onValueChanged(localDevToggle,isOn)
    Standalone = isOn
    UnityEngine.PlayerPrefs.SetInt("Standalone", Standalone and 1 or 0)
    self.standaloneCheck.toggle.isOn = Standalone
end

--[[
/DevPanel/maskBtn onClick 
--]]
function LoginUI:maskBtn_Button_onClick(maskBtn)
    GlobalInfo.DevPanel = false
    self:showUIByMode()
end

--[[
/FormalPanel/ProtoAgreementCheck onValueChanged 
--]]
function LoginUI:protoAgreementCheck_Toggle_onValueChanged(protoAgreementCheck,isOn)
    UnityEngine.PlayerPrefs.SetInt("ProtoAgreementCheck", isOn and 1 or 0)
end

--[[
/FormalPanel/ProtoAgreementCheck/agreement1Btn onClick 
--]]
function LoginUI:agreement1Btn_Button_onClick(agreement1Btn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Application.OpenURL("https://www.moecove.com/agreement.html")
end

--[[
/FormalPanel/ProtoAgreementCheck/agreement2Btn onClick 
--]]
function LoginUI:agreement2Btn_Button_onClick(agreement2Btn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Application.OpenURL("https://www.moecove.com/privacy.html")
end

--[[
/AdjustRoot/RightPanel/HelperBtn onClick 
--]]
function LoginUI:helperBtn_ScaleButton_onClick(helperBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Application.OpenURL("https://support-chat.moecove.com/?app_id=db1a92473ce14c3fb2517e29e02ae9c6 ")
end

return LoginUI
