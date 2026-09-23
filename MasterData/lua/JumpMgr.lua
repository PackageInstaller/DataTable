-- 跳转管理
local this = MgrRegister("JumpMgr")

-- id = 40001
function this:Jump(id)
    local cfg = Cfgs.CfgJump:GetByID(id)
    if (cfg and cfg.sName) then
        local func = self:GetFunc(self:GetName(cfg.sName))
        -- Log(cfg);
        if (func) then
            func(cfg)
        end
    else
        print("跳转id不存在:" .. tostring(id))
    end
end

function this:GetName(sName)
    local cfgView = Cfgs.view:GetByKey(sName)
    if cfgView and cfgView.jumpType then
        if cfgView.jumpType == 1 then
            return "DungeonActivity"
        end
    end
    return sName
end

function this:GetFunc(sName)
    if (self.funcs == nil) then
        self.funcs = {}
        self.funcs["Menu"] = self.Menu
        self.funcs["Dungeon"] = self.Dungeon
        self.funcs["DungeonTower"] = self.Dungeon
        self.funcs["DungeonActivity"] = self.DungeonActivity
        self.funcs["ShopView"] = self.Shop
        self.funcs["Section"] = self.Section
        self.funcs["SignInContinue"] = self.SignInContinue
        -- self.funcs["MatrixCompound"] = self.MatrixCompound
        -- self.funcs["MatrixTrading"] = self.MatrixTrading
        self.funcs["SettingView"] = self.Setting
        self.funcs["Matrix"] = self.Matrix
        self.funcs["Dorm"] = self.Dorm
        self.funcs["ActivityListView"] = self.ActivityListView
        self.funcs["SpeicalJump"] = self.SpeicalJump
        self.funcs["AchievementView"] = self.Achievement
        self.funcs["RegressionList"] = self.RegressionList
        self.funcs["LovePlusView"] = self.LovePlus
        self.funcs["TWWeb"] = self.TWWeb
        self.funcs["ColosseumView"] = self.ColosseumView
        self.funcs["BuffBattle"] = self.BuffBattle
        self.funcs["AnniversaryList"] = self.AnniversaryList
        self.funcs["AnniversaryList2"] = self.AnniversaryList
        self.funcs["AnniversaryList3"] = self.AnniversaryList
        self.funcs["AnniversaryList4"] = self.AnniversaryList
        self.funcs["RogueMap"] = self.RogueMap
        self.funcs["MultTeamBattleMain"] = self.MultTeamBattle
        self.funcs["CollaborationMain"] = self.CollaborationMain
        self.funcs["MenuBuyPanel"] = self.MenuBuyPanel
        self.funcs["LuckyGachaMain"] = self.LuckyGachaMain
        self.funcs["SkinRebate"] = self.SkinRebate
        self.funcs["RiddleMain"] = self.RiddleMain
        self.funcs["RichMan"] = self.RichMan
        self.funcs["Prompt"] = self.Prompt
        self.funcs["SpringFestivalMenu"] = self.Activity 
        self.funcs["PuzzleActivity"]=self.Puzzle
        self.funcs["RoleInfo"]=self.RoleInfo
        self.funcs["StoryCollection"]=self.StoryCollection
        self.funcs["StoryActivityView"]=self.StoryActivityView
        self.funcs["VirtualCataclysm"] = self.VirtualCataclysm
        self.funcs["PeriodicBossView"]=self.PeriodicBoss
    end
    if (self.funcs[sName]) then
        return self.funcs[sName]
    else
        return self.Normal
    end
end

function this.TWWeb()
    ShiryuSDK.ShowActivityUI(function()
        EventMgr.Dispatch(EventType.Menu_WebView_Enabled) -- 主界面的问卷调查
    end)
end

function this.Menu()
    CSAPI.CloseAllOpenned()
end

-- 跳转到链接
function this.SpeicalJump(cfg)
    if (cfg.page) then
        UnityEngine.Application.OpenURL(cfg.page)
    end
end

-- 是否关闭所有上级界面
function this.CheckClose(cfg)
    if cfg.closeAll == 1 then
        CSAPI.CloseAllOpenned();
    end
end

-- 直接打开
function this.Normal(cfg)
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, nil, tonumber(cfg.page))
end

function this.ColosseumView(cfg)
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, nil, tonumber(cfg.page))
    --
    if (CSAPI.IsViewOpen("ColosseumMissionView")) then
        CSAPI.CloseView("ColosseumMissionView")
    end
end

-- 设置类型或分页
function this.SetPage(cfg)
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, nil, tonumber(cfg.page))
end

function this.Dorm(cfg)
    local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "Dorm")
    if (not isOpen) then
        -- LanguageMgr:ShowTips(2310)
        Tips.ShowTips(str)
    else
        if (cfg.page == "DormRoom") then
            this.CheckClose(cfg);
            CSAPI.OpenView(cfg.page)
        else
            LogError("该跳转要特殊处理！" .. cfg.page)
        end
    end
end

-- 打开基地各界面
function this.Matrix(cfg)
    local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "Matrix")
    if (not isOpen) then
        --LanguageMgr:ShowTips(2310)
        Tips.ShowTips(str)
    else
        local detailView = CSAPI.GetView("DungeonDetail")
        if (detailView) then
            local lua = ComUtil.GetLuaTable(detailView)
            lua.view:Close()
        end
        if (not cfg.page) then
            local scene = SceneMgr:GetCurrScene()
            if (scene.key ~= "Matrix") then
                SceneLoader:Load("Matrix")
            end
            return
        end
        if (cfg.page == "MatrixCreate") then
            this.CheckClose(cfg);
            CSAPI.OpenView("MatrixCreate")
            return
        end

        -- 基地已开启
        local buildType = MatrixMgr:GetBuildingTypeByViewName(cfg.page)
        local buildingData = buildType and MatrixMgr:GetBuildingDataByType(buildType) or nil
        if (buildingData) then
            -- 建筑已建造
            if (buildType == BuildsType.Compound) then
                this.CheckClose(cfg);
                CSAPI.OpenView(cfg.page, buildingData, cfg.val1) -- 合成界面要调整到指定物品
            elseif (buildType == BuildsType.TradingCenter) then
                this.CheckClose(cfg);
                CSAPI.OpenView(cfg.page)
            else
                this.CheckClose(cfg);
                CSAPI.OpenView(cfg.page, buildingData)
            end
        else
            LanguageMgr:ShowTips(2311)
        end
    end
end

function this.RichMan(cfg)
    local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "RichManMain")
    if (not isOpen) then
        Tips.ShowTips(str)
    else
        local scene = SceneMgr:GetCurrScene()
        local targetSceneCfg = RichManMgr:GetCurSceneCfg();
        if targetSceneCfg ~= nil then
            if scene.id ~= targetSceneCfg.id  then
                SceneLoader:Load(targetSceneCfg.key)
            else
                CSAPI.CloseAllOpenned();
            end
        else
            -- 没有活动信息！
            LanguageMgr:ShowTips(24017)
            do
                return
            end
        end
        if cfg.page ~= nil and cfg.page~="RichManMain" then
            CSAPI.OpenView(cfg.page);
        end
    end
end

function this.MelodyDarling(cfg)
    CSAPI.OpenView(cfg.sName, cfg.val1)
end

-- function this.MatrixCompound(cfg)
--     MatrixMgr:OpenCompoundPanel(cfg.val1)
-- end

-- function this.MatrixTrading(cfg)
--     MatrixMgr:OpenTradingCenter()
-- end

function this.ActivityListView(cfg)
    this.CheckClose(cfg);
    local state, tips = this.ActivityListViewState(cfg)
    if state == JumpModuleState.Normal then
        CSAPI.OpenView("ActivityListView", {
            id = cfg.val3
        }, cfg.page)
    else
        FuncUtil:Call(function()
            Tips.ShowTips(tips)
        end, nil, 100)
    end
end

function this.SignInContinue(cfg)
    -- if(SignInMgr:SignInIsOpen()) then
    -- 	local _key = SignInMgr:GetDataKey(cfg.val1, cfg.val2)
    -- 	CSAPI.OpenView(cfg.sName, {key = _key})
    -- else
    -- 	LogError("签到未开启,配置错误")
    -- end
    this.CheckClose(cfg);
    local _key = SignInMgr:GetDataKey(cfg.val1, cfg.val2)
    SignInMgr:OpenSignIn(cfg.val3, _key)
end

-- 副本类型/主线、每日
function this.Section(cfg)
    local state, _str = this.SectionState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        local jumpData = {
            type = tonumber(cfg.page),
            group = cfg.val1,
            id = cfg.val2,
            isJump = true
        }
        CSAPI.OpenView(cfg.sName, jumpData);
        if cfg.id == 30003 then
            EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "JumpToPVP")
        end
    else
        FuncUtil:Call(function()
            Tips.ShowTips(_str)
        end, nil, 100)
    end
end

-- 章节/关卡
function this.Dungeon(cfg)
    local state, lockStr = this.DungeonState(cfg);
    if state == JumpModuleState.Normal then
        local detailView = CSAPI.GetView("DungeonDetail") -- 爬塔跳转
        if (detailView) then
            local lua = ComUtil.GetLuaTable(detailView)
            lua.view:Close()
        end
        local sweepView = CSAPI.GetView("SweepView") -- 扫荡跳转
        if (sweepView) then
            local lua = ComUtil.GetLuaTable(sweepView)
            lua.view:Close()
        end
        this.CheckClose(cfg);
        if cfg.val2 == 1 or cfg.val2 == 2 then
            DungeonMgr:SetDungeonHardLv(cfg.val1, cfg.val2);
        end
        CSAPI.OpenView(cfg.sName, {
            id = cfg.val1,
            itemId = cfg.val3,
            state = DungeonOpenType.Jump
        }, nil)
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

function this.DungeonActivity(cfg)
    local state, lockStr = this.DungeonActivityState(cfg);
    if state == JumpModuleState.Normal then
        if CSAPI.IsViewOpen("MissionActivity") then
            local viewGO = CSAPI.GetView("MissionActivity")
            ComUtil.GetLuaTable(viewGO).Close()
        end
        local sectionData = DungeonMgr:GetSectionData(cfg.val1)
        if sectionData then
            local viewName = cfg.sName
            if viewName == "DungeonActivity" and cfg.page then
                viewName = viewName .. cfg.page
            end
            if sectionData:GetType() == SectionActivityType.BattleField then
                if cfg.val2 == 2 then
                    this.CheckClose(cfg);
                    CSAPI.OpenView("BattleFieldBoss")
                else
                    this.CheckClose(cfg);
                    CSAPI.OpenView(viewName, {
                        id = cfg.val1
                    })
                end
            else
                this.CheckClose(cfg);
                CSAPI.OpenView(viewName, {
                    id = cfg.val1,
                    type = cfg.val2,
                    itemId = cfg.val3
                }, nil)
            end
        else
            if (cfg.sName == "RogueView" or cfg.sName == "RogueSView") then
                local page = cfg.page ~= nil and tonumber(cfg.page) or nil
                CSAPI.OpenView("RogueMain")
                CSAPI.OpenView(cfg.sName, cfg.val1, page)
            else
                CSAPI.OpenView(cfg.sName)
            end
            -- LogError("缺少跳转的章节数据!跳转id:" .. cfg.id)
        end
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

-- 商店
function this.Shop(cfg)
    local state, lockStr = this.ShopState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        local page = ShopMgr:GetPageByID(cfg.val1);
        if cfg.val1 and cfg.val1 ~= 0 and cfg.val2 == nil and cfg.val3 == nil and page ~= nil and page:IsHide() then -- 打开单个商店
            CSAPI.OpenView(cfg.sName, cfg.val1);
        else
            if cfg.val5 then
                local cId = tonumber(cfg.val5);
                local comm = ShopMgr:GetFixedCommodity(cId);
                if comm and comm:GetNowTimeCanBuy() then
                    if comm:IsOver() then -- 售罄
                        LanguageMgr:ShowTips(15125);
                        do
                            return
                        end
                    elseif comm:GetType() == CommodityItemType.Skin then -- 皮肤购买界面不打开商店
                        ShopCommFunc.OpenBuyConfrim(cfg.val2, cfg.val3, cId)
                        -- do
                        --     return
                        -- end
                    end
                else
                    LanguageMgr:ShowTips(15007);
                    do
                        return
                    end
                end
            end
            CSAPI.OpenView(cfg.sName, nil, {
                [1] = cfg.val1,
                [2] = cfg.val2,
                [3] = cfg.val5
            }); -- val5是要打开购买界面的商品名称
        end
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

function this.LuckyGachaMain(cfg)
    local state, lockStr = this.LuckyGachaMainState(cfg);
    if state == JumpModuleState.Normal then
        CSAPI.OpenView(cfg.sName, cfg.val1);
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

function this.Setting(cfg)
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, nil, tonumber(cfg.page))
end

function this.Achievement(cfg)
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, nil, {
        group = cfg.val1,
        itemId = cfg.val2
    })
end

function this.RegressionList(cfg)
    local state, lockStr = this.RegressionState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName, {
            group = cfg.val1,
            id = cfg.val2
        })
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

function this.LovePlus(cfg)
    local state, lockStr = this.LovePlusState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName, {
            id = cfg.page
        }, {
            type = cfg.val1,
            id = cfg.val2
        })
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

function this.BuffBattle(cfg)
    local state, lockStr = this.BuffBattleState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName, {
            id = cfg.val1
        })
    end
end

function this.AnniversaryList(cfg)
    local viewName = cfg.sName
    if cfg.page == 3 then
        viewName = "AnniversaryList2"
    end
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, {
        group = cfg.page,
        jumpId = cfg.val1
    })
end

function this.RogueMap(cfg)
    local state, lockStr = this.RogueMapState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName,{id = cfg.val1})
        if cfg.val1 and (cfg.val2 or cfg.val3) then
        if RogueMapMgr:GetFightId() then
            RogueMapMgr:ApplyEnter(RogueMapMgr:GetFightId())  
            else
            local path1, path2 = DungeonUtil.GetViewPath(cfg.val1)
            CSAPI.OpenView(path2, {
                group = cfg.val1,
                groupId = cfg.val2,
                itemId = cfg.val3
            })
        end
    end
end
end

function this.MultTeamBattle(cfg)
    local state, lockStr = this.MultTeamBattleState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName, {
            id = cfg.val1
        })
    else
        Tips.ShowTips(lockStr)
    end
end

function this.CollaborationMain(cfg)
    local state, lockStr = this.CollaborationMainState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName)
    end
end

function this.SkinRebate(cfg)
    local state, lockStr = this.SkinRebateState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName, cfg.val1)
    elseif state == JumpModuleState.Close then
        Tips.ShowTips(lockStr)
    end
end

function this.RiddleMain(cfg)
    local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "RiddleMain")
    if isOpen then
        CSAPI.OpenView(cfg.sName, nil, cfg.val1);
    else
        Tips.ShowTips(str)
    end
end

function this.Prompt(cfg)
    if cfg.val1 then
        local data = {}
        data.content = LanguageMgr:GetByID(cfg.val1)
        data.title = cfg.val2 and LanguageMgr:GetByID(cfg.val2)
        CSAPI.OpenView(cfg.sName,data)
    end
end

function this.Activity(cfg)
    local state, lockStr = this.ActivityState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName, cfg.val1)
    else
        Tips.ShowTips(lockStr)
    end
end

function this.Puzzle(cfg)
    local state, lockStr = this.PuzzleState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName, cfg.val1)
    else
        Tips.ShowTips(lockStr)
    end
end

function this.StoryCollection(cfg)
    local state, lockStr = this.StoryCollectionState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName)
        if cfg.val1 then
            CSAPI.OpenView("StoryCollection",{id = cfg.val1})
            if cfg.val2 then
                CSAPI.OpenView("StoryCollectionList",{id = cfg.val1,itemId = cfg.id})
            end
        end
    else
        Tips.ShowTips(lockStr)
    end
end

function this.StoryActivityView(cfg)
    local state, lockStr = this.StoryActivityState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        if cfg.page and cfg.page ~= "1" then
            CSAPI.OpenView(cfg.sName .. cfg.page,cfg.val1)
        else
            CSAPI.OpenView(cfg.sName,cfg.val1)
        end
    else
        Tips.ShowTips(lockStr)
    end
end

function this.RoleInfo(cfg)
    if cfg.val1 then
        local isExist, cardData = RoleMgr:CheckCfgIdExist(cfg.val1)   
        if isExist then
            CSAPI.OpenView("RoleInfo", cardData)
        else 
            LanguageMgr:ShowTips(77007)
        end
    end 
end

function this.VirtualCataclysm(cfg)
    local state, lockStr = this.VirtualCataclysmState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView("VirtualCataclysmMenu", {
            id = cfg.val1,
            itemId = cfg.page
        })
    else
        Tips.ShowTips(lockStr)
    end
end

function this.PeriodicBoss(cfg)
    local state,lockStr = this.DungeonActivityState(cfg)
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName,{id = cfg.val1,itemId = cfg.val2})
    else
        Tips.ShowTips(lockStr)
    end
end

-- 返回获取跳转状态的方法名
function this:GetStateFunc(sName)
    if (self.stateFuncs == nil) then
        self.stateFuncs = {}
        self.stateFuncs["Dungeon"] = self.DungeonState
        self.stateFuncs["DungeonTower"] = self.DungeonState
        self.stateFuncs["DungeonActivity1"] = self.DungeonActivityState
        self.stateFuncs["DungeonPlot"] = self.DungeonActivityState
        self.stateFuncs["DungeonActivity2"] = self.DungeonActivityState
        self.stateFuncs["BattleField"] = self.DungeonActivityState
        self.stateFuncs["ShopView"] = self.ShopState
        self.stateFuncs["Section"] = self.SectionState
        self.stateFuncs["SignInContinue"] = self.SignInContinueState
        self.stateFuncs["ActivityListView"] = self.ActivityListViewState
        self.stateFuncs["RegressionList"] = self.RegressionState
        self.stateFuncs["BuffBattle"] = self.BuffBattleState
        self.stateFuncs["RogueMap"] = self.RogueMapState
        self.stateFuncs["MultTeamBattleMain"] = self.MultTeamBattleState
        self.stateFuncs["CollaborationMain"] = self.CollaborationMainState
        self.stateFuncs["LuckyGachaMain"] = self.LuckyGachaMainState
        self.stateFuncs["SkinRebateState"] = self.SkinRebateState
        self.stateFuncs["ActivityState"] = self.ActivityState
        self.stateFuncs["PuzzleState"] = self.PuzzleState
        self.stateFuncs["StoryCollectionState"] = self.StoryCollectionState      
        self.stateFuncs["VirtualCataclysmState"] = self.VirtualCataclysmState  
    end
    if (self.stateFuncs[sName]) then
        return self.stateFuncs[sName]
    else
        return self.ModuleState
    end
end

-- 返回传入的id的跳转状态
function this:GetJumpState(id)
    local type = JumpModuleState.Normal;
    local lockStr = "";
    local cfg = Cfgs.CfgJump:GetByID(id)
    if (cfg and cfg.sName) then
        if cfg.act then -- 检查活动开启状态
            local isOpen = DungeonMgr:IsActiveOpen(cfg.act);
            if isOpen ~= true then
                return JumpModuleState.Close;
            end
        end
        local func = self:GetStateFunc(cfg.sName)
        -- Log(cfg);
        if (func) then
            type, lockStr = func(cfg)
        end
    else
        print("跳转id不存在:" .. tostring(id))
    end
    return type, lockStr;
end

function this.PuzzleState(cfg)
    local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "PuzzleActivity")
    if isOpen then
        local info=PuzzleMgr:GetData(tonumber(cfg.val1));
        local begTime=nil;
        local endTime=nil;
        if info then
            begTime = info:GetBeginTime() and TimeUtil:GetTimeStampBySplit(info:GetBeginTime()) or nil;
            endTime = info:GetEndTime() and TimeUtil:GetTimeStampBySplit(info:GetEndTime()) or nil;
        end
        local curTime = TimeUtil:GetTime()
        local isShow = false
        local tips=LanguageMgr:GetTips(24003);
        if (begTime == nil and endTime == nil) then
            isShow = false
        elseif (not isShow and (begTime == nil or curTime > begTime)) then
            if (endTime == nil or curTime < endTime) then
                isShow = true
                tips=nil;
            end
        end
        return isShow==true and JumpModuleState.Normal or JumpModuleState.Close,tips
    end
    return isOpen==true and JumpModuleState.Normal or JumpModuleState.Lock,str
end

function this.DungeonState(cfg)
    if cfg.val2 == 1 or cfg.val2 == 2 then -- 主线
        local sectionData = DungeonMgr:GetSectionData(cfg.val1)
        local isOpen, tips = sectionData:GetOpen()
        if not isOpen then
            return JumpModuleState.Close, tips;
        end
        local cfgs = sectionData:GetDungeonCfgs(cfg.val2);
        local isOpen = false;
        local tips = nil;
        if cfg.val3 and cfg.val3 > 0 then
            if cfgs then
                isOpen, tips = DungeonMgr:IsDungeonOpen(cfg.val3);
            end
            if isOpen then
                return JumpModuleState.Normal;
            else
                return JumpModuleState.Close, tips;
            end
        else
            return JumpModuleState.Normal;
        end
    elseif cfg.val2 == 3 then -- 活动
        if cfg.val3 then
            local isOpen, tips = DungeonMgr:IsDungeonOpen(cfg.val3);
            if isOpen then
                return JumpModuleState.Normal;
            else
                return JumpModuleState.Close, tips;
            end
        end
        return JumpModuleState.Normal;
    else -- 每日
        local sectionData = DungeonMgr:GetSectionData(cfg.val1);
        if sectionData then
            local isOpen, tips = sectionData:GetOpen()
            if not isOpen then
                return JumpModuleState.Close, tips;
            end
        end
        return JumpModuleState.Normal
    end
end

function this.DungeonActivityState(cfg)
    local sectionData = DungeonMgr:GetSectionData(cfg.val1);
    if sectionData then
        local isOpen, _lockStr = sectionData:GetOpen()
        local openInfo = sectionData:GetOpenInfo()
        if isOpen and openInfo then
            if string.match(cfg.sName, "DungeonActivity") then
                if not openInfo:IsOpen() then
                    isOpen = false
                    _lockStr = LanguageMgr:GetTips(24003)
                end
            else
                if not openInfo:IsDungeonOpen() then
                    isOpen = false
                    _lockStr = LanguageMgr:GetTips(24003)
                end
            end
        end
        if not isOpen then -- 章节开启检测
            return JumpModuleState.Close, _lockStr
        end

        if sectionData:GetType() == SectionActivityType.GlobalBoss then
            if GlobalBossMgr:IsClose() then
                return JumpModuleState.Close, GlobalBossMgr:GetCloseDesc()
            end
        end

        if cfg.val3 then
            isOpen, _lockStr = DungeonMgr:IsDungeonOpen(cfg.val3)
            if not isOpen then -- 关卡开启检测
                return JumpModuleState.Close, _lockStr
            end
        end
    elseif cfg.val5 then
        local _cfg = Cfgs.CfgActiveEntry:GetByID(cfg.val5)
        if _cfg and _cfg.begTime and _cfg.endTime then
            local sTime = TimeUtil:GetTimeStampBySplit(_cfg.begTime)
            local eTime = TimeUtil:GetTimeStampBySplit(_cfg.endTime)
            if sTime < TimeUtil:GetTime() and eTime >= TimeUtil:GetTime() then
                return JumpModuleState.Normal
            else
                return JumpModuleState.Close, LanguageMgr:GetTips(24003)
            end
        end
    end
    return JumpModuleState.Normal
end

function this.ShopState(cfg)
    local isUnLock, lockStr = MenuMgr:CheckModelOpen(OpenViewType.main, cfg.sName)
    if isUnLock then
        -- 模块开启，判定指定商店是否在开启时间
        local shopId, pageId = cfg.val1, cfg.val2;
        if shopId then
            local page = ShopMgr:GetPageByID(shopId)
            local state = JumpModuleState.Normal;
            local lockStr = nil;
            if page == nil or (page ~= nil and next(page) == nil) then -- 有数据则已经开启
                state = JumpModuleState.Lock
                lockStr = LanguageMgr:GetTips(15121)
            elseif page and next(page) and (pageId ~= nil and not page:GetChildPageIsOpen(nil,pageId)) then
                state = JumpModuleState.Lock
                lockStr = LanguageMgr:GetTips(15121)
            end
            return state, lockStr
        else
            return JumpModuleState.Normal;
        end
    else
        return JumpModuleState.Lock, lockStr;
    end
end

function this.SectionState(cfg)
    local sectionData = DungeonMgr:GetSectionData(cfg.val1);
    if sectionData then
        local _isOpen, _str = sectionData:GetOpen()
        if not _isOpen then
            return JumpModuleState.Close, _str;
        end
    end
    if cfg.val2 then -- 有具体关卡
        local _isOpen, _str = DungeonMgr:IsDungeonOpen(cfg.val2)
        if not _isOpen then
            return JumpModuleState.Close, _str;
        end
    end
    return JumpModuleState.Normal;
end

function this.ActivityListViewState(cfg)
    if cfg.val3 and not ActivityMgr:CheckIsOpen(cfg.val3) then
        return JumpModuleState.Close, LanguageMgr:GetTips(24003)
    end
    return JumpModuleState.Normal;
end

function this.SignInContinueState(cfg)
    return JumpModuleState.Normal;
end

function this.ModuleState(cfg)
    local isUnLock, lockStr = MenuMgr:CheckModelOpen(OpenViewType.main, cfg.sName)
    if isUnLock then
        return JumpModuleState.Normal;
    else
        return JumpModuleState.Lock, lockStr;
    end
end

function this.RegressionState(cfg)
    local isOpen, type = RegressionMgr:IsHuiGui()
    if RegressionMgr:GetTime() <= 0 then
        return JumpModuleState.Lock, LanguageMgr:GetTips(38002);
    end
    if isOpen then
        if cfg.val1 == nil then
            return JumpModuleState.Normal;
        end
        if type == cfg.val1 then
            if cfg.val2 == nil then
                return JumpModuleState.Normal;
            end
            local _cfg = Cfgs.CfgReturningActivity:GetByID(cfg.val1)
            if _cfg and _cfg.infos and #_cfg.infos > 0 then
                for i, info in ipairs(_cfg.infos) do
                    if info.index == cfg.val2 then
                        if not info.IsHide and RegressionMgr:GetActivityEndTime(info.type) > TimeUtil:GetTime() then -- 超过持续时间不显示
                            return JumpModuleState.Normal;
                        else
                            return JumpModuleState.Lock, LanguageMgr:GetTips(38003);
                        end
                    end
                end
            end
        else
            return JumpModuleState.Lock, LanguageMgr:GetTips(38004);
        end
    else
        return JumpModuleState.Lock, LanguageMgr:GetTips(38002);
    end
end

function this.LovePlusState(cfg)
    return JumpModuleState.Normal
end

function this.BuffBattleState(cfg)
    return JumpModuleState.Normal
end

function this.RogueMapState(cfg)
    if cfg.val1 then
        local sectionData = DungeonMgr:GetSectionData(cfg.val1)
        if sectionData then
            local isOpen, lockStr = sectionData:GetOpen()
            if not isOpen then
                Tips.ShowTips(lockStr)
                return JumpModuleState.Close
            end
        end
    end
    return JumpModuleState.Normal
end

function this.MultTeamBattleState(cfg)
    if cfg.val1 then
        local sectionData = DungeonMgr:GetSectionData(cfg.val1)
        if sectionData then
            local isOpen, lockStr = sectionData:GetOpen()
            if not isOpen then
                return JumpModuleState.Close,lockStr
            end
        end
    end
    return JumpModuleState.Normal,""
end

function this.CollaborationMainState(cfg)
    local activityInfo = CollaborationMgr:GetCurrInfo()
    if activityInfo ~= nil and activityInfo:IsOpen() then
        return JumpModuleState.Normal
    else
        Tips.ShowTips(LanguageMgr:GetTips(24003))
        return JumpModuleState.Close
    end
end

function this.LuckyGachaMainState(cfg)
    local activityInfo = nil;
    if cfg and cfg.sName == "LuckyGachaMain" then
        local isUnLock, lockStr = MenuMgr:CheckModelOpen(OpenViewType.main, cfg.sName);
        if isUnLock ~= true then
            return JumpModuleState.Lock, lockStr
        end
        -- 获取扭蛋机对应的两种掉落类型的活动数据
        activityInfo = ItemPoolActivityMgr:GetPoolInfoByType(ItemPoolType.LuckyGacha);
    end
    if activityInfo then
        return JumpModuleState.Normal;
    else
        return JumpModuleState.Close, LanguageMgr:GetTips(24003);
    end
end

function this.SkinRebateState(cfg)
    local isOpen = ActivityMgr:IsOpenByType(ActivityListType.SkinRebate)
    if isOpen then
        return JumpModuleState.Normal
    else
        return JumpModuleState.Close, LanguageMgr:GetTips(24003)
    end
end

function this.ActivityState(cfg)
    if cfg.val1 then
        local alData = ActivityMgr:GetALData(cfg.val1)
        local isOpen = alData and alData:IsOpen()
        if isOpen then
            return JumpModuleState.Normal
        else
            return JumpModuleState.Close, LanguageMgr:GetTips(24003)
        end
    else
        LogError("跳转失败，跳转表未在val1填下活动id")
        return JumpModuleState.Close,LanguageMgr:GetTips(24003)
    end
end

function this.StoryCollectionState(cfg)
    if cfg.val1 then
        local sectionData = DungeonMgr:GetSectionData(cfg.val1)
        local isOpen = sectionData and sectionData:IsOpen()
        if isOpen then
            if cfg.val2 then
                isOpen = DungeonMgr:IsDungeonOpen(cfg.val2)
                if isOpen then
                    return JumpModuleState.Normal
                else
                    return JumpModuleState.Close, LanguageMgr:GetTips(24003)
                end
            else
                return JumpModuleState.Normal
            end
        else
            return JumpModuleState.Close, LanguageMgr:GetTips(24003)
        end
    end
    return JumpModuleState.Normal
end

function this.StoryActivityState(cfg)
    if cfg.val1 then
        local sectionData = DungeonMgr:GetSectionData(cfg.val1)
        if sectionData and sectionData:GetOpen() then
            return JumpModuleState.Normal
        else
            return JumpModuleState.Close, LanguageMgr:GetTips(24003)
        end
    end
    return JumpModuleState.Normal
end

function this.VirtualCataclysmState(cfg)
    if cfg.val1 then
        local sectionData = DungeonMgr:GetSectionData(cfg.val1)
        if sectionData and sectionData:GetOpen() then
            return JumpModuleState.Normal
        else
            return JumpModuleState.Close, LanguageMgr:GetTips(24003)
        end
    end
    return JumpModuleState.Normal
end

-- 是否禁止跳转
function this.IsDisableJump(viewKey, jumpID)
    if viewKey and jumpID then
        local cfg = Cfgs.view:GetByKey(viewKey);
        if cfg and cfg.jump_chose then
            for k, v in ipairs(cfg.jump_chose) do
                if jumpID == v or v == -1 then -- (-1代表跳转全部屏蔽)
                    return true;
                end
            end
        end
    end
    return false;
end

function this.Init()
    EventMgr.RemoveListener(EventType.View_Lua_Opened, this.OnViewOpen);
    EventMgr.RemoveListener(EventType.View_Lua_Closed, this.OnViewClose)
    this.openList = {};
    EventMgr.AddListener(EventType.View_Lua_Opened, this.OnViewOpen);
    EventMgr.AddListener(EventType.View_Lua_Closed, this.OnViewClose)
end

function this.OnViewOpen(event)
    table.insert(this.openList, event);
end

function this.OnViewClose(event)
    if #this.openList > 0 then
        local index = 0;
        for i = #this.openList, 1, -1 do
            if this.openList[i] == event then
                index = i;
                break
            end
        end
        if index ~= 0 then
            table.remove(this.openList, index);
        end
    end
end

function this:GetLastViewKey()
    if this.openList and #this.openList > 0 then
        return this.openList[#this.openList];
    end
end

-- 能否跳转 bool,desc
function this:CheckCanJump(id)
    local cfg = Cfgs.CfgJump:GetByID(id)
    if (cfg) then
        if (cfg.sName == "Section") then
            local state, _str = this.SectionState(cfg)
            if (state == JumpModuleState.Normal) then
                return true, ""
            else
                return false, _str
            end
        else
            return MenuMgr:CheckModelOpen(OpenViewType.main, cfg.sName)
        end
    end
    -- return false, "跳转界面不存在"
    return false, LanguageMgr:GetTips(1052);
end

-- 付费弹窗
function this.MenuBuyPanel(cfg)
    local isOpen, str = MenuBuyMgr:CheckMenuBuyIsOpen()
    if (not isOpen) then
        Tips.ShowTips(str)
        return
    end
    if (cfg.page) then
        local page = tonumber(cfg.page)
        if (MenuBuyMgr:CheckIsInTime(page)) then
            if (MenuBuyMgr:CheckIsEnd(page)) then
                LanguageMgr:ShowTips(1055)
            else
                this.CheckClose(cfg)
                CSAPI.OpenView(cfg.sName, nil, page)
            end
        else
            LanguageMgr:ShowTips(24003)
        end
    end
end

this.Init();

return this
