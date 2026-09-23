local data = nil
local rankType = 0
local currDatas = nil
local layout = nil
local intervalTime = 0 -- 刷新间隔
local rankTime, rankTimer = 0, 0
local cfg = nil
local myItems = nil
local isShowAssistSkil = false
local max = 100
local teamCheckName = nil
local teamCheckRank = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Rank/RankItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if lua then
        local _data = currDatas[index]
        lua.SetClickCB(OnItemClickCB)
        lua.SetIndex(index)
        lua.Refresh(_data, {
            cfg = data.cfg,
            desc1 = data.desc1,
            desc2 = data.desc2
        })
        -- 请求更多数据
        if (index ~= max and index == #currDatas and intervalTime < TimeUtil:GetTime()) then
            AddNextRankList()
            intervalTime = TimeUtil:GetTime() + 0.1
        end
    end
end

function AddNextRankList()
    RankMgr:AddNextRankList(rankType)
end

function OnItemClickCB(item)
    TryShowTeamCheck(item.index,item.GetName())
end



function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Activity_Rank_Update, UpdateCardsPanel)
end

-- 数据刷新回调
function UpdateCardsPanel()
    currDatas = RankMgr:GetRankInfos(rankType)
    layout:IEShowList(#currDatas, nil, 0)
    SetMyRank()
    if rankTime <= 0 then
        rankTime = RankMgr:GetRankTime(rankType)
        rankTimer = 0
    end
end

function OnDisable()
    eventMgr:ClearListener();
end

function Update()
    if rankTime > 0 and Time.time > rankTimer then
        rankTimer = Time.time + 1
        if rankType then
            rankTime = RankMgr:GetRankTime(rankType)
            if rankTime <= 0 then
                RankMgr:ClearRankData(rankType)
                RankMgr:RefreshRankList(rankType)
            end
        end
    end
end

function Refresh(_data)
    data = _data
    if data then
        rankType = data.cfg and data.cfg.id
        isShowAssistSkil = data.cfg and data.cfg.isAssistSkill
        max = data.cfg and data.cfg.rankNum or g_ExploringRankRule
        RankMgr:ClearRankData(rankType)
        rankTime = RankMgr:GetRankTime(rankType)
        rankTimer = 0
        RefreshPanel()
        tlua:AnimAgain()
    end
end

function RefreshPanel()
    ShowList()
end

function ShowList()
    currDatas = RankMgr:GetRankInfos(rankType)
    if #currDatas <= 0 then
        RankMgr:GetRank(1, rankType)
    else
        layout:IEShowList(#currDatas)
        -- 自己数据
        SetMyRank()
    end
end

function SetMyRank()
    local _info = RankMgr:GetMyRank(rankType)
    myItems = myItems or {}
    ItemUtil.AddItems("Rank/RankItem", myItems, {_info}, itemParent, OnItemClickCB2, 1, {
        isSelf = true,
        cfg = data.cfg,
        desc1 = data.desc1,
        desc2 = data.desc2
    })
end

function OnItemClickCB2(item)
    local info = RankMgr:GetMyRank(rankType)
    TryShowTeamCheck(nil,PlayerClient:GetName(),info:GetRank())
end

function TryShowTeamCheck(index,name,rank)
    teamCheckName = name
    teamCheckRank = rank
    if rankType == eRankId.GlobalBoss then
        if index == nil then
            index = rank
        end
        FightProto:GetGlobalBossRankTeam(index, OnTeamCheckOpen)
    else
        PlayerProto:GetRankTeamInfo(rankType, index, OnTeamCheckOpen)
    end
end

function OnTeamCheckOpen(proto)
    if proto ~= nil then
        proto.name = teamCheckName
        proto.rankType = rankType
        if teamCheckRank then
            proto.rankIdx = teamCheckRank
        end
        CSAPI.OpenView(isShowAssistSkil and "RankTeamCheck2" or "RankTeamCheck", proto)
    end
end

function OnClickReturn()
    view:Close()
end
