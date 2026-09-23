local isSet = false 

function Awake()
    UIUtil:AddTop2("MerryChristmas", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Menu_Christmas, OnOpen)

    bgm = CSAPI.StopBGM()
    CSAPI.PlayBGM("Merry_Christmas_Music_01")
end

function OnDestroy()
    EventMgr.Dispatch(EventType.Replay_BGM)
    eventMgr:ClearListener()
end

function Update()
    if (endTime and TimeUtil:GetTime() >= endTime) then
        endTime = nil
        OnOpen()
    end
end

function OnOpen()
    SetObj()
    OperateActiveProto:GetChristmasGiftData(function()
        mainCfg = MerryChristmasMgr:GetMainCfg()
        if (not mainCfg) then
            Log("赛季已结束")
            view:Close()
            return
        end
        -- 
        local begTime, _endTime = MerryChristmasMgr:GetActivityTime()
        endTime = _endTime
        --
        RefreshPanel()
    end)
end

function SetObj()
    if(not isSet)then 
        isSet = true 
        local num = CSAPI.RandomInt(1, 3)
        local imgName = "img_03_0"..num
        CSAPI.LoadImg(Obj,"UIs/MerryChristmas/" .. imgName .. ".png",true,nil,true)
    end 
end

function RefreshPanel()
    CSAPI.SetText(txtTime, mainCfg.showTime)
    -- 
    SetGridItem()
    -- 
    cnt = MerryChristmasMgr:GetRemainCnt() or 0
    LanguageMgr:SetText(txtStart, 78002, cnt)
    -- 
    local maxScore = MerryChristmasMgr:GetMaxScore() or 0
    LanguageMgr:SetText(txtScore, 78001, maxScore)
end

function SetGridItem()
    rewardData = nil
    local rID, isGet = MerryChristmasMgr:GetCurReward()
    rID = rID<=0 and 1 or rID
    local _cfg = Cfgs.CfgChristReward:GetByID(rID)
    CSAPI.SetGOActive(imgReward, _cfg.rewards ~= nil)
    if (_cfg.rewards) then
        rewardData = BagMgr:GetFakeData(_cfg.rewards[1][1], _cfg.rewards[1][2])
        ResUtil.IconGoods:Load(imgReward, rewardData:GetIcon())
    end
    CSAPI.SetGOActive(maskR, isGet)
end

-- 排行榜
function OnClickSort()
    local sectionData = DungeonMgr:GetSectionData(22001)
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

function OnClickReward()
    if (rewardData) then
        local tab = {
            data = rewardData
        }
        GridClickFunc.OpenInfoSmiple(tab)
    end
end

function OnClickRewards()
    CSAPI.OpenView("SignInNReward", {"CfgChristReward", MerryChristmasMgr:GetCnt()})
end

function OnClickStart()
    --if (cnt > 0) then
    CSAPI.OpenView("MerryChristmasPlay")
    --end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
