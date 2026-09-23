-- 模拟
local curTeamIndex = 0
local runTime = false
local timer = 0
local needTime = 0
local nextTime = 0
local isEnd = false -- 赛季结束

local nextDayTime = nil
local nextDayTimer = nil

function Awake()
    timeBase = TimeBase.New()
    timeBase2 = TimeBase.New()

    nextDayTime = GCalHelp:GetNextActiveZeroTime()
    nextDayTimer = Time.time

    zf_slider = ComUtil.GetCom(zfSlider, "Slider")
end

function OnInit()
    UIUtil:AddTop2("ExerciseLView", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Exercise_Enemy_Info, EEnemyInfo) -- 查看对手
    eventMgr:AddListener(EventType.Exercise_Update, function()
        RefreshSelf()
        CheckTips()
    end) -- SetCount) -- 刷新自己的信息
    eventMgr:AddListener(EventType.Exercise_Enemy_Update, function()
        SetRefreshCnt()
        SetEnemyItems()
        SetContent()
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed) -- 加载之后再显示奖励面板
    eventMgr:AddListener(EventType.Bag_Update, SetXz)
    eventMgr:AddListener(EventType.ExerciseL_BuyCount, SetCount)
    -- eventMgr:AddListener(EventType.Exercise_Role_Panel, SetHead)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    timeBase:Update()
    timeBase2:Update()

    -- -- 刷新次数 
    -- if (Time.time > nextDayTimer) then
    --     nextDayTimer = Time.time + 1
    --     if (GCalHelp:GetNextActiveZeroTime() > nextDayTime) then
    --         nextDayTime = CalHelp:GetNextActiveZeroTime()
    --         ExerciseMgr:GetPracticeInfo(true, false)
    --     end
    -- end
end

function OnOpen()
    RefreshSelf()
    -- 敌人
    SetEnemy() -- 请求数据
end

-- 更新数据再提示，否则会出现数据返回的延迟错误 
function CheckTips()
    -- 赛季第一次进入 
    if (ExerciseMgr:IsNewSeason()) then
        ExerciseMgr:SetNewSeason()
        FuncUtil:Call(function()
            LanguageMgr:ShowTips(33001) -- 赛季已刷新，玩家积分排名已重置
        end, nil, 1)
    end
    -- 次数刷新了
    if (ExerciseMgr:IsNewJoinCnt()) then
        ExerciseMgr:SetNewJoinCnt()
        FuncUtil:Call(function()
            LanguageMgr:ShowTips(33002) -- 挑战次数已刷新
        end, nil, 2)
    end
end

function RefreshSelf()
    -- 赛季时间
    timeBase:Run(ExerciseMgr:GetEndTime(), SetTime)
    -- 段位
    SetGrade()
    -- 排名
    SetPM()
    -- 积分
    SetZF()
    -- 勋章
    SetXz()
    -- 模拟次数
    SetCount()
    -- 刷新次数
    SetRefreshCnt()

    SetMaxRank()
    SetHead()
    --SetContent()
end

function SetPM()
    local str = ExerciseMgr:GetRankStr()
    if (str == "--") then
        str = LanguageMgr:GetByID(33072)
    else
        str = LanguageMgr:GetByID(33060, str)
    end
    CSAPI.SetText(txtPm, str)
end

function SetXz()
    CSAPI.SetText(txtXz, PlayerClient:GetCoin(g_ArmyCoinId) .. "")
end

-- 段位图标
function SetGrade()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(ExerciseMgr:GetRankLevel())
    CSAPI.SetGOActive(imgGrade, cfg.icon ~= nil)
    if (cfg.icon) then
        ResUtil.ExerciseGrade:Load(imgGrade, cfg.icon, true)
    end
    CSAPI.SetText(txtGrade, cfg.name)
end

function SetZF()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(ExerciseMgr:GetRankLevel())
    -- cur
    -- CSAPI.SetText(txtZf2, ExerciseMgr:GetScore() .. "")
    -- next
    local cur, max = ExerciseMgr:GetScore(), 1
    if (cfg.nScore) then
        max = cfg.nScore
    else
        max = cur
    end

    local nextCfg = Cfgs.CfgPracticeRankLevel:GetByID(cfg.id + 1)
    if (nextCfg == nil) then
        cur, max = "--", "--"
        -- CSAPI.SetText(txtNextZf2, "--")
        zf_slider.value = 1
    else
        -- CSAPI.SetText(txtNextZf2, (max - cur) .. "")
        zf_slider.value = cur / max or 1
    end
    local str = string.format("%s/<color=#ffc146>%s</color>", cur, max)
    CSAPI.SetText(txtZf, str)
    -- 

end

function SetCount()
    cnt, maxCnt = ExerciseMgr:GetJoinCnt()
    CSAPI.SetText(txtCount2, "<color=#ffc146>" .. cnt .. "</color>/" .. maxCnt)
    -- 下次刷新时间
    timeBase2:Run(ExerciseMgr:GetNextTime(), SetTime2)
end

function SetEnemy()
    -- 刷新次数
    -- SetRefreshCnt()
    -- 次数信息,请求敌人数据
    ExerciseMgr:GetPracticeInfo(true, true)
end

-- 赛季时间
function SetTime(_needTime)
    CSAPI.SetText(txtTime, TimeUtil:GetTimeStr3(_needTime))
    if (_needTime <= 0) then
        isEnd = true
        -- LanguageMgr:ShowTips(33018)
        local str = LanguageMgr:GetTips(33018)
        UIUtil:OpenDialog(str)
        EventMgr.Dispatch(EventType.Exercise_End)
        view:Close()
    end
end

-- 回复时间
function SetTime2(_needTime)
    CSAPI.SetText(txtCount3, TimeUtil:GetTimeStr8(_needTime)) -- 33008 g_ArmyPracticeJoinCntFlushCnt
    if (_needTime <= 0) then
        ArmyProto:GetSelfPracticeInfo(function()
            -- 弹出提示 
            LanguageMgr:ShowTips(33002)
            ExerciseMgr:SetNewJoinCnt()
        end)
    end
end

-- 刷新对手次数
function SetRefreshCnt()
    local cnt, maxCnt = ExerciseMgr:GetFlushCnt()
    local curCnt = (maxCnt - cnt) < 0 and 0 or (maxCnt - cnt)
    CSAPI.SetText(txtRefresh, "<color=#ffc146>" .. curCnt .. "</color>/" .. maxCnt)
end

-- 对手
function SetEnemyItems()
    enemyItems = enemyItems or {}
    local datas = ExerciseMgr:GetEnemy()
    table.sort(datas, function(a, b)
        if (a:GetRank() == 0 and b:GetRank() ~= 0) then
            return false
        elseif (a:GetRank() ~= 0 and b:GetRank() == 0) then
            return true
        end
        return a:GetRank() < b:GetRank()
    end)
    ItemUtil.AddItems("ExerciseL/ExerciseLItem", enemyItems, datas, enemyGrids, ItemClickCB, 1, nil, ItemAnims)
end

function ItemAnims()
    if (isFirst) then
        return
    end
    isFirst = 1
    for i, v in ipairs(enemyItems) do
        local delay = (i - 1) * 20
        UIUtil:SetObjFade(v.clickNode, 0, 1, nil, 300, delay)
        local y1 = i * 20
        UIUtil:SetPObjMove(v.clickNode, 0, 0, -y1, 0, 0, 0, nil, 200, delay)
    end
end

function ItemClickCB(data)
    if (cnt <= 0) then
        local _num1, _num2 = ExerciseMgr:GetCanBuy()
        if (_num1 < _num2) then
            CSAPI.OpenView("ExerciseLBuy")
        else
            LanguageMgr:ShowTips(33007)
        end
        return
    end
    ExerciseMgr:GetPracticeOtherTeam(data:GetID(), data:GetIsRobot())
end

-- 避免loading界面与RewardPanel冲突  todo 
function OnViewClosed(viewKey)
    -- 是否是新段位，新排名,获得积分币
    if (viewKey == "Loading") then
        local newChangeData = ExerciseMgr:GetNewChange()
        if (newChangeData[1] > 0 or newChangeData[2]) then
            CSAPI.OpenView("ExerciseLChange", newChangeData)
        elseif (newChangeData[3] > 0) then
            local data = {
                id = g_ArmyCoinId,
                type = RandRewardType.ITEM,
                num = newChangeData[3]
            }
            UIUtil:OpenReward({{data}})
        end
    end
end

-- 查看对手卡牌
function EEnemyInfo(proto)
    if (proto) then
        --刷新敌人 
        SetEnemyItems()
        --打开vs界面
        CSAPI.OpenView("ExerciseVsView", proto)
    end
end

-- 防御部署
function OnClickDeffense()
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.PracticeDefine,
        canEmpty = false,
        is2D = true
    }, TeamOpenSetting.PVPMirror)
end

-- 防御部署
function OnClickAttack()
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.PracticeAttack,
        canEmpty = false,
        is2D = true
    }, TeamOpenSetting.PVPMirror)
end

-- 排行榜
function OnClickRank()
    if (not isFirst) then
        isFirst = 1
        ExerciseMgr:ClearRankData()
    end
    UIUtil:OpenRankView(1,{{id = eRankId.Exercise,title = LanguageMgr:GetByID(33003),desc1 = LanguageMgr:GetByID(33001)}})
    -- CSAPI.OpenView("RankView")
end

-- 刷新对手
function OnClickRefresh()
    ExerciseMgr:FlushPracticeObj()
end

-- 跳转商店
function OnClickShop()
    CSAPI.OpenView("ShopView", 904)
end

-- 购买模拟次数
function OnClickAdd()
    -- 已满
    if (cnt >= maxCnt) then
        LanguageMgr:ShowTips(33004)
        return
    end
    -- 已购买次数 
    local buyCount, max = ExerciseMgr:GetCanBuy()
    if (buyCount >= max) then
        LanguageMgr:ShowTips(33005)
        return
    end
    CSAPI.OpenView("ExerciseLBuy")
end

-- 排名奖励
function OnClickReward()
    CSAPI.OpenView("ExerciseLRankReward")
end

---------------------------------------------------------------------

-- 历史最高排名
function SetMaxRank()
    local max_rank = ExerciseMgr:GetMaxRank()
    if (max_rank == 0) then
        LanguageMgr:SetText(txtMaxRank2, 33072)
    else
        LanguageMgr:SetText(txtMaxRank2, 33060, max_rank)
    end
end

-- 头像 （立绘的独立的）
function SetHead()
    -- UIUtil:AddHeadByID(headParent, 1, PlayerClient:GetHeadFrame(), ExerciseMgr:GetRolePanel(), PlayerClient:GetSex())
    UIUtil:AddHeadFrame(headParent, 1)
end

-- 挑战历史信息
function SetContent()
    local infos = ExerciseMgr:GetFightBaseLogs()
    local str = ""
    local ni = LanguageMgr:GetByID(33067)
    local len = #infos
    for k = len, 1, -1 do
        local v = infos[k]
        local _str = ""
        if (not v[3]) then
            _str = "<color=#c3c3c8>" .. LanguageMgr:GetByID(33064, ni, v[2]) .. "</color>"
        else
            _str = "<color=#ff7781>" .. LanguageMgr:GetByID(33064, v[2], ni) .. "</color>"
        end
        str = str == "" and _str or str .. "\n" .. _str
    end
    CSAPI.SetText(txtContent, str)
end

-- 重置立绘
function OnClickImgReset()
    UIUtil:OpenDialog(LanguageMgr:GetTips(33021), function()
        ArmyProto:SetRolePanel()
    end)
end

-- 更换立绘
function OnClickImgSelect()
    CSAPI.OpenView("CRoleDisplayPVP",ExerciseMgr:GetInfo())
end

-- 历史挑战
function OnClickHistory()
    CSAPI.OpenView("ExerciseLHistory")
end

function OnClickHead()
    CSAPI.OpenView("HeadFramePanel",nil,3)
end