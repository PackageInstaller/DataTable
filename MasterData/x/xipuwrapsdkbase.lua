local _M = class("XipuWrapSdkBase")
local cjson = require("cjson")

function _M:_loginSuccessCallback(userInfo)
    local tb = { -- xipuLoginParams.sign, xipuLoginParams.openid, xipuLoginParams.timestamp
        sign = userInfo.sign,
        openid = userInfo.openid,
        timestamp = userInfo.timestamp,
    }

    LuaLogger.ds("XipuWrapSdkBase1", self.loginCallbackTemp)
    --if not self.loginCallbackTemp then
    --    return
    --end

    local loginSuccess = tb.openid ~= "error"
    local loginData
    if loginSuccess then
        loginData = {
            uuid = tb.openid,
            token = cjson.encode(tb),
        }
    else
        loginData = {
            error = GE.PassportErrorCode.CommonLoginFailed,
        }
    end

    LuaLogger.ds("XipuWrapSdkBase2", loginSuccess, tablex.dump(loginData))

    if self.loginCallbackTemp then
        self.loginCallbackTemp(loginSuccess, loginData)
    end

    -- 目前如果登录后，用切换账号或者sdk端的退出登录，这时候不经过WinSDK的登录按钮登录（也就是不会调用本类的_M:Login）
    -- 那么更换账号登录后，前端实际传给服务端的仍然是上次的账号信息，就导致登录的是切换前的账号，所以这里注释了掉了，保留并用之前的回调（没有什么特殊逻辑）
    --self.loginCallbackTemp = nil
end

--function _M:_loginFailedCallback(errMsg)
--	if not self.loginCallbackTemp then
--		return
--	end
--
--	self.loginCallbackTemp(false, {
--		loginType = GE.LoginType.XipuWrap,
--		sdkErrorCode = nil,
--		sdkErrorMsg = errMsg,
--	})
--	self.loginCallbackTemp = nil
--end

function _M:ctor()
    LuaLogger.ds("XipuWrapSdk ctor")

    local xipuSdkHandler = GameMain.Instance.gameObject:GetComponent(typeof(XipuSdkHandler));
    if not xipuSdkHandler then
        xipuSdkHandler = GameMain.Instance.gameObject:AddComponent(typeof(XipuSdkHandler));
    end

    self.xipuSdkHandler = xipuSdkHandler

    --self:init()

    xipuSdkHandler.OnLoginSuccess = function (userInfo)
        self:_loginSuccessCallback(userInfo)
    end

    --xipuSdkHandler.OnLoginFailed = function (err)
    --	self:_loginFailedCallback(err.errMsg)
    --end

    xipuSdkHandler.OnLogoutSuccess = function ()
        if self.logoutCallback then
            self.logoutCallback()
        end

        self.logoutCallback = nil
        if GameFlowFSM:getCurrentStateId() ~= GameFlowState.LoginState then
            --LuaLogger.ds("XipuWrapSdkBase", "changeToLoginState")
            StateMgr:ChangeToState(GameFlowState.LoginState)
        else
            if self.beLogoutCallback then
                self.beLogoutCallback()
            end
        end
    end

    xipuSdkHandler.OnExit = function ()
        return 0 -- 返回0表示sdk会执行退出逻辑
    end

    --if Application.platform == UnityEngine.RuntimePlatform.Android then
    --	
    --end

    LuaLogger.ds("QuickWrapSdk ctor end")
end

function _M:Login(callBack)
    LuaLogger.ws("Set xipu Login callback", callBack)
    self.loginCallbackTemp = callBack
    self:checkSDKInit(function(success)
        if success then
            DXipuSdk.Instance:Login()
        end
    end)
end

function _M:onCpServerLoginResult(result)
    if result == 0 then
        DXipuSdk.Instance:ShowBallMenu()
    end
end

function _M:Logout(callBack)
    self.logoutCallback = callBack
    DXipuSdk.Instance:Logout()
end

function _M:setBeLogout(callBack)
    self.beLogoutCallback = callBack
end

-- 有初始化成功与否概念的需要加这个函数
function _M:isInited()
    return true -- self.xipuSdkHandler.sdkInitSuccess
end

--function _M:init() -- 暂时没有被调用 C#里调用了
--	if self.xipuSdkHandler.sdkInitSuccess then
--		return
--	end
--
--	local loaderId = UIMgr:startLoad(1)
--
--	self.xipuSdkHandler.OnInitSuccess = function ()
--		self.inited = true
--		LuaLogger.ds("sdk init success")
--		UIMgr:endLoad(loaderId)
--	end
--
--	self.xipuSdkHandler.OnInitFailed = function (err)
--		LuaLogger.es(err.errMsg)
--		--UICommonUtils.PopPromptBox("SDK初始化失败")
--		UIMgr:endLoad(loaderId)
--	end
--	
--	quicksdk.QuickSDK.getInstance():reInit();
--end

function _M:checkSDKInit(callBack) -- 暂时没有被调用
    if self:isInited() then
        callBack(true)
        return
    end

    local loaderId = UIMgr:startLoad(1)

    self.xipuSdkHandler.OnInitSuccess = function ()
        self.inited = true
        LuaLogger.ds("sdk init success")
        UIMgr:endLoad(loaderId)
        callBack(true)
    end

    self.xipuSdkHandler.OnInitFailed = function (err)
        LuaLogger.es(err.errMsg)
        --UICommonUtils.PopPromptBox("SDK初始化失败")
        UIMgr:endLoad(loaderId)
        callBack(false)
    end
end

function _M.GenSdkRoleDataFromData(data)
    local gameRoleInfo = DXipuSdk.XipuRoleInfo.New()
    gameRoleInfo.serverId = data.serverID;
    gameRoleInfo.serverName = data.serverName;
    gameRoleInfo.roleId = data.gameRoleID;
    gameRoleInfo.roleName = data.gameRoleName;
    gameRoleInfo.roleLevel = data.gameRoleLevel;
    gameRoleInfo.vipLevel = data.vipLevel;
    gameRoleInfo.remainder = data.gameRoleBalance;
    return gameRoleInfo
end

function _M:createRole(data)
    --LuaLogger.ds("createRole", tablex.dump(data))
    DXipuSdk.Instance:CreateRole(self.GenSdkRoleDataFromData(data)); -- 创建角色
end

function _M:enterGame(data)
    --LuaLogger.ds("enterGame", tablex.dump(data))
    DXipuSdk.Instance:LoginRole(self.GenSdkRoleDataFromData(data)); -- 进入游戏
end

function _M:updateRole(data)
    --LuaLogger.ds("updateRole", tablex.dump(data))
    DXipuSdk.Instance:UpgradeRole(self.GenSdkRoleDataFromData(data)); -- 角色升级
end

function _M:canLargePay(data)
    LuaLogger.ds("canLargePay func", DXipuSdk.Instance.CanLargePay, DXipuSdk.Instance.Pay)

    if DXipuSdk.Instance.CanLargePay then
        local can = DXipuSdk.Instance:CanLargePay()
        print("xipu largePay", can)
        return can == 1
    end

    if Application.platform == UnityEngine.RuntimePlatform.Android then
        return true
    elseif Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
        return false
    end
    return false
end

return _M