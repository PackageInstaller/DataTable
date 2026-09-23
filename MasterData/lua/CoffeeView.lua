function Awake()
    UIUtil:AddTop2("CoffeeView", gameObject, function()
        view:Close()
    end, nil, {})
    CSAPI.SetGOActive(bg, false)
    CSAPI.SetGOActive(AdaptiveScreen, false)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Menu_Coffee, RefreshPanel)

    bgm = CSAPI.StopBGM()
    CSAPI.PlayBGM("cafe_music_01")
end

function OnDestroy()
    EventMgr.Dispatch(EventType.Replay_BGM)
    eventMgr:ClearListener()
end

function OnOpen()
    local id = CoffeeMgr:GetID()
    if (id) then
        OperateActiveProto:GetMaidCoffeeData(id, RefreshPanel)
    end
end

function RefreshPanel()
    CSAPI.SetGOActive(bg, true)
    CSAPI.SetGOActive(AdaptiveScreen, true)
    mainCfg = CoffeeMgr:GetCurCfg()
    if (not mainCfg) then
        view:Close()
        return
    end
    -- 菜品
    SetItems()
    -- 奖励次数
    local cnt = CoffeeMgr:GetRemainCnt() or 0
    LanguageMgr:SetText(txtStart, 78002, cnt)
    -- 奖励 
    SetGridItem()
    -- 时间 
    CSAPI.SetText(txtTime, mainCfg.showTime)
    -- 立绘(按天数轮换)
    SetRole()
    -- 排行榜
    LanguageMgr:SetText(txtSort, 78001, CoffeeMgr:GetMaxScore())
end

function SetRole()
    local day = CoffeeMgr:GetDay()
    day = ((day - 1) % 7) + 1
    local imgName = "img_06_0" .. day
    ResUtil.Coffee:Load(Character, imgName)
end

function SetItems()
    local cfgs = Cfgs.CfgFood:GetAll()
    items = items or {}
    ItemUtil.AddItems("Coffee/CoffeeItem", items, cfgs, Content)
end

function SetGridItem()
    rewardData = nil
    local rID, isGet = CoffeeMgr:GetCurReward()
    local _cfg = Cfgs.CfgCoffeeReward:GetByID(rID)
    CSAPI.SetGOActive(imgReward, _cfg.rewards ~= nil)
    if (_cfg.rewards) then
        rewardData = BagMgr:GetFakeData(_cfg.rewards[1][1], _cfg.rewards[1][2])
        ResUtil.IconGoods:Load(imgReward, rewardData:GetIcon())
        -- if rewardItem == nil then
        --     ResUtil:CreateUIGOAsync("Grid/GridItem", itemParent, function(go)
        --         local _lua = ComUtil.GetLuaTable(go)
        --         _lua.Refresh(_data)
        --         _lua.SetClickCB(GridClickFunc.OpenInfoSmiple)
        --         rewardItem = _lua
        --     end)
        -- else
        --     rewardItem.Refresh(_data)
        -- end
    end
    CSAPI.SetGOActive(sweeplight, not isGet)
    CSAPI.SetGOActive(maskR, isGet)
end

function OnClickReward()
    if (rewardData) then
        local tab = {
            data = rewardData
        }
        GridClickFunc.OpenInfoSmiple(tab)
    end
end

function OnClickStart()
    CSAPI.OpenView("CoffeePlayView")
end

function OnClickRewards()
    CSAPI.OpenView("SignInNReward", {"CfgCoffeeReward", CoffeeMgr:GetCnt()})
end

-- 排行榜
function OnClickSort()
    local sectionData = DungeonMgr:GetSectionData(19001)
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
