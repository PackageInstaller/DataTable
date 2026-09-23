local timer = nil
local freeCnt, freeTimer = 0, nil

function Awake()
    UIUtil:AddTop2("ColosseumView", gameObject, function()
        view:Close()
    end, nil, {})

    CSAPI.SetGOActive(AdaptiveScreen, false)

    -- 事件监听
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Colosseum_Refresh_Time, function()
        UIUtil:ToHome()
    end)
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
    eventMgr:AddListener(EventType.Bag_Update, SetBtn)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if (timer and Time.time >= timer) then
        timer = Time.time + 1
        SetTimes()
    end
    if (freeTimer and TimeUtil:GetTime() > freeTimer) then
        freeTimer = nil
        OnOpen()
    end
end

function OnOpen()
    -- 请求数据
    local oldSeason = ColosseumMgr:GetSeasonID()
    AbattoirProto:GetSeasonData(function()
        CSAPI.SetGOActive(AdaptiveScreen, true)
        RefreshPanel()
        -- 处理跳转
        if (data) then
            local cfgDungeon = Cfgs.MainLine:GetByID(data)
            if (oldSeason and oldSeason == ColosseumMgr:GetSeasonID()) then
                if (cfgDungeon.modeType == 1) then
                    local isBuy = ColosseumMgr:CheckIsBuy(1)
                    if (isBuy) then
                        OnClickZX()
                    else
                        ToGuid()
                    end
                else
                    local isBuy = ColosseumMgr:CheckIsBuy(2)
                    if (isBuy) then
                        OnClickSJ()
                    else
                        ToGuid()
                    end
                end
            else
                Log("赛季已结束，已开启下一轮新的赛季")
            end
            data = nil
        else
            ToGuid()
        end
    end)
end

function ToGuid()
    EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "ColosseumMain")
end

function RefreshPanel()
    seasonData = ColosseumMgr:GetSeasonData()
    -- btn
    SetBtn()
    -- zx
    SetDetail1("ZX", ColosseumMgr:GetScoreData(1))
    -- sj
    SetSJ()
    SetDetail1("SJ", ColosseumMgr:GetScoreData(2))
    -- time
    InitTimes()
    -- 
    LanguageMgr:SetText(txtTime1, 64004, seasonData.id)
    -- red 
    SetRed()
    --
    SetFree()
end

function SetBtn()
    local goodsId = ColosseumMgr:GetGoodsID()
    if (goodsId) then
        local cfg = Cfgs.ItemInfo:GetByID(goodsId)
        ResUtil.IconGoods:Load(moneyIcon, cfg.icon .. "_1")
        CSAPI.SetText(txtMoney, BagMgr:GetCount(goodsId) .. "")
    end
end

function SetFree()
    freeCnt, freeTimer = ColosseumMgr:GetFreeInfo()
    if (CSAPI.IsViewOpen("ColosseumReward")) then
        CSAPI.OpenView("ColosseumReward")
    end
end

function SetRed()
    local isRed = ColosseumMgr:IsMissionRed()
    UIUtil:SetRedPoint(btnGift, isRed, 89, 24, 0)
    --
    local isRed2 = ColosseumMgr:IsRewardRed()
    UIUtil:SetRedPoint(btnSJ, isRed2, 773, 172, 0)
end

function SetSJ()
    local isBuy = ColosseumMgr:CheckIsBuy(2)
    CSAPI.SetGOActive(maskSJ, isBuy)
    if (isBuy) then
        LanguageMgr:SetText(txtSJ, 64013, ColosseumMgr:GetRandomCurIdx2())
    end
    --
    local cur, max = ColosseumMgr:GetFreeCnt()
    LanguageMgr:SetText(txtFree, 64040, cur, max)
end

function SetDetail1(str, sScoreData)
    CSAPI.SetText(this["txtStar" .. str], sScoreData ~= nil and "x" .. sScoreData.starNum or "x0")
    LanguageMgr:SetText(this["txtHH1" .. str], 64005, sScoreData ~= nil and sScoreData.maxLv .. "" or "0")
    LanguageMgr:SetText(this["txtHH2" .. str], 64006, sScoreData ~= nil and sScoreData.maxHardLv .. "" or "0")
end

function InitTimes()
    local curTime = TimeUtil:GetTime()
    refreshTimeZX = 0
    if (seasonData.selectRefreshTime and seasonData.selectRefreshTime > curTime) then
        refreshTimeZX = seasonData.selectRefreshTime
    end
    -- 
    refreshTimeSJ = 0
    if (seasonData.randRefreshTime and seasonData.randRefreshTime > curTime) then
        refreshTimeSJ = seasonData.randRefreshTime
    end
    --
    endTime = 0
    if (seasonData.endTime and seasonData.endTime > curTime) then
        endTime = seasonData.endTime
    end
    --
    SetTimes()
    timer = Time.time
end

function SetTimes()
    local curTime = TimeUtil:GetTime()
    CSAPI.SetText(txtTimeZX, TimeUtil:GetTimeStr3(refreshTimeZX - curTime))
    CSAPI.SetText(txtTimeSJ, TimeUtil:GetTimeStr3(refreshTimeSJ - curTime))
    local endTimeData = TimeUtil:GetTimeTab(endTime - curTime)
    local h = endTimeData[2] < 10 and "0" .. endTimeData[2] or endTimeData[2]
    local m = endTimeData[3] < 10 and "0" .. endTimeData[3] or endTimeData[3]
    LanguageMgr:SetText(txtTime2, 64027, endTimeData[1], h, m)
end

function OnViewClosed(viewKey)
    if (gameObject ~= nil and (viewKey == "ColosseumM" or viewKey == "ColosseumMRandom")) then
        EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "ColosseumView")
    end
end

-- 排名
function OnClickPM()
    local sectionData = ColosseumMgr:GetSectionData()
    UIUtil:OpenRankView(sectionData:GetRankView(), sectionData:GetRankListInfo())
end

function OnClickGift()
    CSAPI.OpenView("ColosseumMissionView")
end
function OnClickZX()
    local isBuy = ColosseumMgr:CheckIsBuy(1)
    if (isBuy) then
        CSAPI.OpenView("ColosseumM", data, 1)
    else
        local cfg = Cfgs.cfgColosseum:GetByID(seasonData.id)
        if (cfg.cost) then
            CSAPI.OpenView("ColosseumBuy", {seasonData.id, RefreshPanel}, 1)
        else
            AbattoirProto:StartMod(1, 1, BuyCB)
        end
    end
end

function BuyCB(proto)
    CSAPI.OpenView("ColosseumM", nil, 1)
    RefreshPanel()
end

function OnClickSJ()
    local isBuy = ColosseumMgr:CheckIsBuy(2)
    if (isBuy) then
        CSAPI.OpenView("ColosseumMRandom", data, 2)
    else
        -- 
        RemoveTeam()
        --
        CSAPI.OpenView("ColosseumBuy", {seasonData.id, RefreshPanel}, 2)
    end
end

function RemoveTeam()
    local teamData = TeamMgr:GetTeamData(ColosseumMgr:GetTeamIndex(2))
    teamData:ClearCard()
    PlayerProto:SaveTeamList({teamData})
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end

function OnClickShop()
    local cfg = Cfgs.cfgColosseum:GetByID(seasonData.id)
    if(cfg.shopId)then 
        CSAPI.OpenView("ShopView", cfg.shopId)
    end
end
