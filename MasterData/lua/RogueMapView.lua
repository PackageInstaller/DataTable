local sectionData = nil
local openInfo = nil
function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRed)
    eventMgr:AddListener(EventType.RogueMap_Update,OnPanelRefresh)
end

function OnPanelRefresh()
    SetAssist()
    SetNum()
end

function OnInit()
    UIUtil:AddTop2("RogueMap", topParent, OnClickBack);
end

function OnOpen()
    sectionData =DungeonMgr:GetSectionData(data and data.id)
    if sectionData then
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
    end
    SetLeft()
    SetRight()
    if RogueMapMgr:CheckRollCountRed() then
        UIUtil:SetRedPoint(redParent2,true)
        RedPointMgr:SetDayRedToday(RedPointDayOnceType.RogueMap)
        RogueMapMgr:CheckRedPointData()
    end
end

function SetLeft()
    SetTime()
    SetAssist()
    SetRed()
end

function SetTime()
    if openInfo then
        local strs = openInfo:GetTimeStrs()
        local str = LanguageMgr:GetByID(22021) .. strs[1] .. " " .. strs[2] .. "-" .. strs[3] .. " " .. strs[4]
        CSAPI.SetText(txtTime, str)
    end
end

function SetAssist()
    local requireMax = RogueMapMgr:GetGlobal("dailyRequestNum") or 0
    CSAPI.SetText(txtAssist," " .. math.floor(requireMax - RogueMapMgr:GetRequireNum()))
end

function SetRed()
    UIUtil:SetRedPoint(redParent,RogueMapMgr:IsRewardRed() or RogueMapMgr:IsAssistNew())
end

function SetRight()
    SetNum()
end

function SetNum()
    local num = RogueMapMgr:GetRollNum()
    CSAPI.SetText(txtNum, " ".. num)
end


function OnClickBack()
    view:Close()
end

function OnClickAssist()
    if isRequire then
        return
    end
    isRequire = true
    -- 消息超时提示
    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "rogueMap_assist_open",
        time = 5000,
        timeOutCallBack = function()
            isRequire = false
            LanguageMgr:ShowTips(1008)
        end
    });
    FightProto:RogueMapSupportList(sectionData:GetID(),OnAssistCallBack)
end

function OnAssistCallBack()
    EventMgr.Dispatch(EventType.Net_Msg_Getted, "rogueMap_assist_open")
    isRequire = false
    CSAPI.OpenView("RogueMapAssist",{id = sectionData:GetID()})
end

function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = sectionData:GetTaskType(),
        group = sectionData:GetID(),
    })
end

function OnClickShop()
    if sectionData:GetExploreId() then
        CSAPI.OpenView("SpecialExploration", sectionData:GetExploreId());
    else
        CSAPI.OpenView("ShopView", openInfo:GetShopID())
    end
end

function OnClickRank()
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

function OnClickDungeon()
    UIUtil:SetRedPoint(redParent2,false)
    if RogueMapMgr:GetFightId() then
        -- local dialogData = {}
        -- dialogData.content = LanguageMgr:GetTips(50007)
        -- dialogData.okCallBack = function()
            RogueMapMgr:ApplyEnter(RogueMapMgr:GetFightId())
        -- end
        -- CSAPI.OpenView("Dialog", dialogData)
    else
        CSAPI.OpenView("RogueMapList",{group = sectionData:GetID()})
    end
end
    
