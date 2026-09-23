local openInfo = nil
local info = nil
local lastBGM = nil
local isLoading = false
local sectionData = nil
local cfgVirCat = nil
local stageIDs = {380006,380008}
--time
local time,timer =0,0

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Bag_Update, SetNum)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.Scene_Load_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
    eventMgr:AddListener(EventType.VirtualCataclysm_Panel_Update, OnPanelUpdate)
end

function OnViewClosed(viewKey)
    if viewKey == "Plot" or viewKey == "ShopView" then
        FuncUtil:Call(function()
            if gameObject then
                CSAPI.PlayBGM(info.bgm, 1)
            end
        end, this, 200)
    end
end

function OnLoadComplete()
    if isLoading then
        FuncUtil:Call(function()
            if gameObject then
                lastBGM = CSAPI.PlayBGM(info.bgm, 1)
            end
        end, nil, 200)
    end
end

function OnPanelUpdate()
    SetEnterState()
end

function OnInit()
    UIUtil:AddTop2("VirtualCataclysmMenu", topParent, OnClickReturn);
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = openInfo:GetEndTime() - TimeUtil:GetTime()
        local tab = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime,330002,tab[1],tab[2],tab[3])
        if time <= 0 then
            LanguageMgr:ShowTips(24001)
            UIUtil:ToHome()
        end
    end
end

function OnOpen()
    SetBGScale()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        info = sectionData:GetInfo()
        cfgVirCat = Cfgs.CfgVirtualCataclysm:GetByID(sectionData:GetInfoContent("VirCatId"))
        SetTime()
        SetNum()
        SetRed()
        SetEnterState()
        SetJump()
    end

    if openSetting and openSetting.isDungeonOver then -- 战斗完返回
        isLoading = true
    end
    lastBGM = CSAPI.PlayBGM(info.bgm, 1000)
end

function SetBGScale()
    local size = CSAPI.GetSizeOffset()
    CSAPI.SetScale(bgObj, size, size, size)
end

function SetNum()
    CSAPI.SetText(txtNum, BagMgr:GetCount(cfgVirCat.goodsId) .. "")
    local goodsData = GoodsData({id = cfgVirCat.goodsId})
    if goodsData:GetIcon() then
        goodsData:GetIconLoader():Load(icon,goodsData:GetIcon() .. "_1")
    end
end

function SetRed()
    UIUtil:SetRedPoint(redParent1,MissionMgr:CheckRed2(sectionData:GetTaskType(),sectionData:GetID()))
    if sectionData:GetExploreId() then
        local exData = ExplorationMgr:GetExData(sectionData:GetExploreId())
        local isRed = exData and exData:HasRevice() or false
        UIUtil:SetRedPoint(redParent2, isRed)
    end
    UIUtil:SetRedPoint(redParent3,VirCatMgr:CheckRewardRed())
end

function SetEnterState()
    local stage = VirCatMgr:GetStage() or 1
    LanguageMgr:SetText(txtState,stageIDs[stage])
end

function SetTime()
    if sectionData then
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if openInfo then
            time = openInfo:GetEndTime() - TimeUtil:GetTime()
        end
    end
end

function SetJump()
    if data.itemId then
        OnClickEnter()
    end
end

function OnClickRank()
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = sectionData:GetTaskType(),
        group = cfgVirCat.taskType,
        title = LanguageMgr:GetByID(6021)
    })
end

function OnClickShop()
    if sectionData:GetExploreId() then
        CSAPI.OpenView("SpecialExploration", sectionData:GetExploreId());
    else
        CSAPI.OpenView("ShopView", cfgVirCat.shopID)
    end
end

function OnClickEnter()
    if not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    
    if not VirCatMgr:IsActive() then
        return
    end

    local viewName= "VirtualCataclysmView" .. (VirCatMgr:GetStage() == 1 and "" or "2") 
    CSAPI.OpenView(viewName, {id = sectionData:GetID(),itemId = data.itemId})
end

function OnClickReturn()
    view:Close()
end

function OnDestroy()
    if not FightClient:IsFightting() then -- 不在战斗中关闭界面时重播bgm
        FuncUtil:Call(function()
            if lastBGM ~= nil then
                CSAPI.ReplayBGM(lastBGM)
            else
                EventMgr.Dispatch(EventType.Replay_BGM, 50);
            end
        end, this, 300)
    end
    eventMgr:ClearListener()
end