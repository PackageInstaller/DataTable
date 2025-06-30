--[[
-- added by wsh @ 2017-12-01
-- UILogin控制层
--]]

local UISsLoginCtrl = BaseClass("UISsLoginCtrl", UIBaseCtrl)

local function isLegal(name, password)
    --if name == "" or password == "" then
    --    UIUtil.ToolTipFourth(LangUtil.GetSysLang(1003)) --("账号或密码不能为空")
    --    return false
    --end
    --if string.len(name) > 20 or string.len(name) < 1 then
    --    Logger.LogError("name length err!")
    --    return false;
    --end
    --if string.len(password) > 20 or string.len(password) < 1 then
    --    Logger.LogError("password length err!")
    --    return false;
    --end
    ---- 检测是否有汉字
    --for i=1, string.len(name) do
    --    local curByte = string.byte(name, i)
    --    if curByte > 127 then
    --        UIUtil.ToolTipThird(LangUtil.GetSysLang(9),LangUtil.GetSysLang(1004));--"错误"，账号不合法
    --        return false;
    --    end;
    --end
    return true;
end

-- 注册--丢弃
local function Register(self, username,password)
    --if not isLegal(username, password) then return end
    --Game.Scene:GetComponent("SessionComponent"):Register(username, password, function ()
    --    ClientData:GetInstance():SetAccountInfo(username, password)
    --    UIUtil.ToolTipFourth(LangUtil.GetSysLang(1005)) --"注册成功"
    --end, function (errorCode)
    --    UIUtil.ToolTipFourth(LangUtil.GetServerError(errorCode))
    --end)
end

-- 请求服务器状态
local function ServerUpdate(self)
    coroutine.start(function ()
        local session = Game.Scene:GetComponent("SessionComponent")
        session:ServerState(ClientData:GetInstance().uid, function (msg)
            self.model:OnServersStateChanged(msg)
        end)
    end)
end

-- 登录
local function Login(self, uid, password, username, callback, onFail)
    if not isLegal(uid, password) then return end
    Game.Scene:GetComponent("SessionComponent"):Login(uid, password, username, function (msg)
        self.model:OnLoginAccountServerSucceed(msg)
        -- if self.timer ~= nil then
        --     self.timer:Stop()
        --     self.timer = nil
        -- end
        -- self.timer = TimerManager:GetInstance():GetTimer(11, ServerUpdate, self)
        -- self.timer:Start()
        --self:EnterGameTest(msg.ServerInfoList[1])
        
        if callback ~= nil then callback() end
    end, function (errorCode)
        if onFail ~= nil then onFail(errorCode) end
        if Game.Scene:GetComponent("SessionComponent").forceOffLine ~= 1 then -- 被挤下线不提示
            UIUtil.ToolTipFourth(LangUtil.GetServerError(errorCode))
        end
    end)
end

-- 老版本登录
local function OldLogin(self, username, password, callback)
    if not isLegal(username, password) then return end
    Game.Scene:GetComponent("SessionComponent"):OldLogin(username, password, function (msg)
        self.model:OnLoginAccountServerSucceed(msg)
        if callback ~= nil then
            callback()
        end
    end, function (errorCode)
        UIUtil.ToolTipFourth(LangUtil.GetServerError(errorCode))
    end)
end

-- 反复登入游戏测试
local function EnterGameTest(self, gateServer, onEnter, onError)
    if gateServer == nil or string.IsNullOrEmpty(gateServer.IP) or gateServer.Port == nil then
        if onError ~= nil then onError() end
        return
    end
    local gateAddress = gateServer.IP..":"..gateServer.Port
    local mainUiId = ClientData:GetInstance():GetMainUiId()
    if mainUiId == 0 then
        Game.Scene:GetComponent("SoundComponent"):PlayTitleSound(1001)
    else
        Game.Scene:GetComponent("SoundComponent"):PlayTitleSound(mainUiId)
    end
    ClientData:GetInstance():SetServerAddress(gateAddress)
    Game.Scene:GetComponent("SessionComponent"):EnterGame(gateAddress, function ()
        Game.Scene.Session:ActiveLoad(LangUtil.GetSysLang(1006), LoadMode.Cat, "SsLogin")
        Game.Scene:GetComponent("SessionComponent"):ExitGame()
    end, function(errorCode)
        if onError ~= nil then onError(errorCode) end
        self:EnterGameTest(gateServer, onEnter, onError)
    end)
end

-- 登录游戏
local function EnterGame(self, gateServer, onEnter, onError)
    if gateServer == nil or string.IsNullOrEmpty(gateServer.IP) or gateServer.Port == nil then
        if onError ~= nil then onError() end
        return
    end
    local gateAddress = gateServer.IP..":"..gateServer.Port
    local mainUiId = ClientData:GetInstance():GetMainUiId()
    if self.enterVoice then
        if mainUiId == 0 then
            Game.Scene:GetComponent("SoundComponent"):PlayTitleSound(1001)
        else
            Game.Scene:GetComponent("SoundComponent"):PlayTitleSound(mainUiId)
        end
    end
    ClientData:GetInstance():SetServerAddress(gateAddress)
    Game.Scene:GetComponent("SessionComponent"):EnterGame(gateAddress, function ()
        Game.Scene.Session:ActiveLoad(LangUtil.GetSysLang(1006), LoadMode.Cat, "SsLogin")
        Game.Scene:GetComponent("SessionComponent"):InitGameData(function ()
            if self.timer ~= nil then
                self.timer:Stop()
                self.timer = nil
            end
            --新手引导
            local cd = ClientData:GetInstance()
            if cd~=nil and cd.guide and CS.Game.Instance.settings.guideEnabled then
                local guide = Game.Scene:GetComponent("GuideComponent")--攻击教程
                local GuideSept = table.first(guide.GuideList, function(v)
                    return v.Id == BattleGuideId -- 新手战斗
                end)
                local GuideSept1 = table.first(guide.GuideList, function(v)
                    return v.Id == 2001 -- 抽卡
                end)
                if GuideSept ~= nil and GuideSept["Step"] < BattleGuideEndStep and GuideSept1 == nil  then
                    if GuideSept["Step"] < 3 then
                        Game.Scene.SceneComponent:SwitchScene(SceneConfig.HomeScene) --数据接收完毕 进入大厅
                    elseif GuideSept["Step"] >= 3 and GuideSept["Step"] <= 6 then
                        guide:CheckStart(0, 4)
                        guide:SwitchBattleScene()
                    elseif GuideSept["Step"] > 6 then
                        guide:CheckStart(0, 6)
                        guide:SwitchBattleScene()
                    end
                else
                    Game.Scene.SceneComponent:SwitchScene(SceneConfig.HomeScene) --数据接收完毕 进入大厅
                end
            else
                Game.Scene.SceneComponent:SwitchScene(SceneConfig.HomeScene) --数据接收完毕 进入大厅 
            end
            Game.Scene.Session:DeActiveLoad(LoadMode.Cat, "SsLogin")
            if onEnter ~= nil then onEnter() end
        end, function(errorCode)
            Game.Scene.Session:DeActiveLoad(LoadMode.Cat, "SsLogin")
            if onError ~= nil then onError(errorCode) end
        end)
    end, function(errorCode)
        if onError ~= nil then onError(errorCode) end
    end)
end

UISsLoginCtrl.Login = Login
UISsLoginCtrl.EnterGame = EnterGame
UISsLoginCtrl.Register = Register
UISsLoginCtrl.OldLogin = OldLogin
UISsLoginCtrl.EnterGameTest = EnterGameTest

return UISsLoginCtrl