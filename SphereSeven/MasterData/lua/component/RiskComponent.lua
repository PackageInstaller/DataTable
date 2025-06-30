---
--喵呢大冒险
---
local RiskComponent = BaseClass("RiskComponent", Component)
local base = Component
local this = RiskComponent

local homeSceneRoot = "Root"
local rootPath = "Scene/Common/CatRiskRoot.prefab"

function this.Awake(self)
    base.Awake(self)
    -- const：可更换地图次数1，投骰子最大次数5，恢复次数间隔60min
    self.RiskHint = Game.Scene:GetComponent("HintComponent").Risk
    self.maxChangeMapTimes =  Z_SysConf[1003].Value
    self.maxTimes = Z_SysConf[1001].Value -- 最大可投次数
    self.timeDelay =  Z_SysConf[1002].Value
    self.RiskHint:SetCount(0)
    self.DiceNum = 1
    --local date  = string.split(TimeUtil.Message," ")
    --date = string.gsub(date[1],"/","-")
    --date = self:GetWeekNum(date)
    -- 服务器请求 
    self.data = {
        ["mapId"] = 0,
        ["remainMapTime"] = 0,
        ["remainTime"] = 0, -- 可以投骰子次数
        ["endDate"] = 0, -- 剩余时间
        ["playerId"] = 0,
        ["skin"] = 0, -- 皮肤0 默认 1皮肤
        ["playerPos"] = 0,
        ["rewardInfoList"] = ClientData:GetInstance().RewardInfoList, -- 地图奖励
    }

    ---- 开始计时
    self.timer = TimerManager:GetInstance():GetTimer(1, self.Timing , self)
    self.timer:Start()
end

-- 获取服务器数据
function this.CoLoadData(self)
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil, Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_LuckCatInfo, {});
    if info.Error == ErrorCode.ERR_Success then
        self.data.mapId = info.CurrentMap
        self.data.remainTime = self.maxTimes - info.MoveNum
        self.data.remainMapTime = self.maxChangeMapTimes - info.NewMapNum
        self.data.endDate = info.NextTime
        self.data.playerId = info.CatId
        self.data.playerPos = info.CurrentStep
        self.data.skin = info.SkinId
        self.RiskHint:SetCount( self.data.remainTime)
    else
        Logger.LogError(info.Error)
    end
    return coroutine.yieldbreak(info)
end

-- 打开大冒险
function this.Open(self)
    coroutine.start(function ()
        --self.rootGo = GameObjectPool:GetInstance():CoGetGameObjectAsync(rootPath)
        --self.rootGo.transform:SetParent(CS.UnityEngine.GameObject.Find(homeSceneRoot).transform, false)
        --self.camera = self.rootGo.transform:Find("Camera"):GetComponent(typeof(Camera))
        --self.mapRoot = self.rootGo.transform:Find("MapRoot")
        --self.playerRoot = self.rootGo.transform:Find("PlayerRoot")
        --self:HideScene()
        --self:LoadScene(self.data.mapId)
        
        --Mode 1 桌面打开 2 猫腻更换地图打开 3 猫腻更换人物打开
        UIManager:GetInstance():OpenWindow(UIWindowNames.RiskEnter,{Mode = 1})
    end)
end

function this.Close(self)
    --self:UnloadScene()
    --GameObjectPool:GetInstance():RecycleGameObject(rootPath, self.rootGo)
    --self.camera = nil
    --self.mapRoot = nil
    --self.playerRoot = nil
    --self.rootGo = nil
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIRisk)
end

------------------------------ 场景 ------------------------------
-- 加载场景
function this.LoadScene(self, id)
    self.riskConfig = table.filter(Z_CatRisk, function (k, v)
        return v["MapId"] ~= id
    end)
    self.mapConfig = Z_CatRiskMap[id]
    self.scenePath = "Scene/"..self.mapConfig["Name"].."/Scene.prefab"
    self.scene = GameObjectPool:GetInstance():CoGetGameObjectAsync(self.scenePath)
    self.scene.transform:SetParent(self.mapRoot, false)
    -- TODO:加载角色
    
    self:ShowScene()
end

-- 卸载场景
function this.UnloadScene(self)
    assert(self.scenePath)
    assert(self.scene)
    GameObjectPool:GetInstance():RecycleGameObject(self.scenePath, self.scene)
    -- TODO:卸载角色
    
    self.riskConfig = nil
    self.mapConfig = nil
    self.scenePath = nil
    self.scene = nil
end

-- 切换场景
function this.ChangeScene(self, id, IsRefresh, callback)
    if self.data.mapId == id then
        if callback ~= nil then
            callback()
        end
        if IsRefresh  then
            return 
        end
    end
    local reqData={}
    reqData.MapId = id --要进入的地图配置id (Z_CatMap)
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil, Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_LuckCatEntryMap, reqData);
    if info.Error == ErrorCode.ERR_Success then
        
        self.data.mapId = info.CurrentMap
        self.data.remainMapTime = self.maxChangeMapTimes - info.NewMapNum
        self.data.playerPos = info.CurrentStep
        self.data.rewardInfoList = info.RewardInfoList
        ClientData:GetInstance():SetRewardInfoList(info.RewardInfoList)
        local date = self:OnDateTime(1)
        --TODO 可以加上服务器ID
        ClientData:GetInstance():SetUpdateMap(date.."/"..ClientData:GetInstance().login_server_id)
        if callback ~= nil then
            callback()
        end
    else
        --info.Error==360016 -- 大冒险功能出错
        --        ==360017 --  切换地图次数不够

        Logger.LogError("Error: OuterOpcode.Name2Code.ETModel_C2G_CatRisk")
    end
   
end

-- 显示场景
function this.ShowScene(self)
    if self.camera then
        self.camera.enabled = true
    end
end

-- 隐藏场景
function this.HideScene(self)
    if self.camera then
        self.camera.enabled = false
    end
end

------------------------------ 玩家 ------------------------------
function this.ChangePlayer(self, id, skinId, callback)
    local reqData={}
    reqData.Id = id
    reqData.Skin  = skinId
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_LuckCatChooseId,reqData )
    if info.Error == ErrorCode.ERR_Success then
        --成功返回 id更新
        self.data.playerId = id
        self.data.skin = skinId
        if callback ~= nil then
            callback()
        end
        local wnd = UIManager:GetInstance():GetWindow(UIWindowNames.UIRisk)
        if wnd ~= nil and wnd.Active then
            wnd.View:changeSkin()
        end
    else
        --info.Error==360016 -- 大冒险功能出错
        --        ==360021 -- id未解锁
    end
end

-- 摇色子
function this.Play(self,mode,func)
    -- 服务器请求，返回点数，奖励
    -- 播放动画，人物移动，获得奖励
    local reqData={}
    reqData.DiceType = mode    --色子类型  0三角 1九角
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_LuckCatMove,reqData )
    if info.Error == ErrorCode.ERR_Success then
        --成功返回
        self.data.playerPos = self.data.playerPos + info.Step --info.CurrentStep 
        self.data.remainTime =  self.maxTimes - info.MoveNum
        self.RiskHint:AddCount(-1)
        self.DiceNum =  info.Step
        self.data.endDate = info.NextTime
        if(func~=nil) then func(info) end
    --CurrentStep = 2;//走完后所在格子
    --MoveNum = 3; //已经行动次数
    --NextTime = 4;//更新行动次数剩余秒
    --RewardInfoList = 5;//获得的奖励内容
    else
        if(func~=nil) then func(nil) end
        --info.Error==360016 -- 大冒险功能出错
        --        ==360018 -- 行动次数不够
        --        ==360019 -- 地图配置错误Z_CatMap
        --        ==360020 --  地图格子配置错误Z_CatMapCell
    end
    --DataManager:GetInstance():Broadcast(DataMessageNames.ON_RISK_PLAY_POS);

end

-- 奖励记录
function this.RewardsRecord(self, func)
    local reqData={}
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_LuckCatRewards,reqData )
    if info.Error == ErrorCode.ERR_Success then
        --成功返回
        local list = {}
        for i = 1, 7 do
            table.insert(list,info["RewardInfoList" .. i])
        end
        if func ~= nil  then
            func(list)
        end
    --RewardInfoList1 = 1;//周1
    --RewardInfoList2 = 2;//周2
    --RewardInfoList3 = 3;//周3
    --RewardInfoList4 = 4;//周4
    --RewardInfoList5 = 5;//周5
    --RewardInfoList6 = 6;//周6
    --RewardInfoList7 = 7;//周天
    else
        --info.Error==360016 -- 大冒险功能出错
    end

end



------------------------------ 其他 ------------------------------
-- 0点更新
function this.ZeroUpdate(self)
    -- TODO每周缓存地图
    local date  = string.split(TimeUtil.Message," ")
    date = string.gsub(date[1],"/","-") 
    if self:GetWeekNum(date) == 1 then
        self:ChangeScene(self.data.mapId,false,function ()
        end) -- 缓存地图
    end
    if self.data.remainMapTime < self.maxChangeMapTimes then
        self.data.remainMapTime = self.remainMapTime + 1
        local wnd = UIManager:GetInstance():GetWindow(UIWindowNames.UIRisk)
        if wnd ~= nil and wnd.Active then
            wnd.View:RefreshMapTime()
        end
    end
end

-- 计时
function this.Timing(self)
    if self.data.endDate == nil or self.data.endDate <= 0 then
        self.data.endDate = 0
        local wnd = UIManager:GetInstance():GetWindow(UIWindowNames.UIRisk)
        if wnd ~= nil and wnd.Active then
            wnd.View:RefreshTime(self.data.remainTime, self.data.endDate)
        end
        local wnd = UIManager:GetInstance():GetWindow(UIWindowNames.RiskEnter)
        if wnd ~= nil and wnd.Active then
            wnd.View:RefreshTime(self.data.remainTime, self.data.endDate)
        end
        return
    end
    self.data.endDate = self.data.endDate - 1
    if self.data.endDate <= 0 then
        if self.data.remainTime < self.maxTimes then
            --self.data.remainTime = self.data.remainTime + 1
            self.RiskHint:AddCount(1)
        end
        self.data.endDate = self.timeDelay
    end
    local wnd = UIManager:GetInstance():GetWindow(UIWindowNames.UIRisk)
    if wnd ~= nil and wnd.Active then
        wnd.View:RefreshTime(self.data.remainTime, self.data.endDate)
    end
    local wnd = UIManager:GetInstance():GetWindow(UIWindowNames.RiskEnter)
    if wnd ~= nil and wnd.Active then
        wnd.View:RefreshTime(self.data.remainTime, self.data.endDate)
    end
end

function this.ConvertTimeForm(second)
    if second < 0 then second = 0 end
    local tb = {}
    tb.hour    = math.fmod(math.floor(second/3600), 24)
    tb.minute  = math.fmod(math.floor(second/60), 60)
    tb.second  = math.floor(math.fmod(second, 60))
    return tb
end

function this.GetWeekNum(self,strDate)
    local ymd = string.split(strDate,"-")
    local  t = os.time({year=tostring(ymd[3]),month=tostring(ymd[1]),day=tostring(ymd[2])})
    local weekNum = TimeUtil.ServerDate("*t",t).wday  -1
    if weekNum == 0 then
        weekNum = 7
    end
    return weekNum
end

-- 算出周几的日期 --step 周几
function this.OnDateTime(self,step)
    local date = string.split(TimeUtil.Message," ")
    local date1 = string.split(date[1],"/")
    local date2 = date1[1] .."-" .. date1[2] .. "-".. date1[3]
    local week =  self:GetWeekNum(date2)
    step =  step - week
    local cur_time = os.time{year = date1[3],month = date1[1],day = date1[2]}
    local new_time = cur_time + 86400*step
    local new_day = TimeUtil.ServerDate("*t",new_time)
    local day = string.format("%04d-%02d-%02d", new_day.year,new_day.month, new_day.day)
    print(day)
    return day
end


function this.Dispose(self)
    self.timer:Stop()
end

return this