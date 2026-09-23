local layout1,layout2
local tlua1,tlua2
local group = 0
local curDatas2,curDatas
local isHad = false

function Awake()
    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/Mission/AnniversaryMissionItem2", LayoutCallBack1, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/Mission/AnniversaryMissionItem1", LayoutCallBack2, true)
    tlua2 = UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.Normal)
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end
function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas2[index]
        lua.Refresh(_data,group)
    end
end

function OnInit()
    UIUtil:AddTop2("AnniversaryMission", gameObject, function()
        view:Close()
    end)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, function(_data)
        if (not _data) then
            RefreshPanel()
            return
        end
        local rewards = _data[2]
        RefreshPanel()
        if (#rewards > 0) then
            UIUtil:OpenReward({rewards})
        end
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

--data:AnniversaryData  
function OnOpen()
    if data then
        local info = data:GetMissionInfo()
        group = info and info[2]
        RefreshPanel()
    end
end

function RefreshPanel()
    SetTitle()
    SetLeft()
    SetRight()
end

function SetTitle()
    CSAPI.SetText(txtCur,"x" .. MissionMgr:GetAnniversaryInfo(group))
end

function SetLeft()
    curDatas2 = {}
    local cfg = Cfgs.CfgAnniversaryStarReward:GetByID(group)
    if cfg and cfg.infos then
        for k, v in pairs(cfg.infos) do
            table.insert(curDatas2,v)
        end
    end
    if #curDatas2 > 0 then
        local score = MissionMgr:GetAnniversaryInfo(group) or 0
        table.sort(curDatas2,function (a,b)
            local isGet1 = score >= (a.star or 0)
            local isGet2 = score >= (b.star or 0)
            if isGet1 == isGet2 then
                return a.index< b.index
            else
                return not isGet1
            end
        end)
    end
    tlua2:AnimAgain()
    layout2:IEShowList(#curDatas2)
end

function SetRight()
    curDatas = MissionMgr:GetActivityDatas(eTaskType.AnniversaryMission,group)
    tlua1:AnimAgain()
    CSAPI.SetGOActive(mask,true)
    layout1:IEShowList(#curDatas,function ()
        CSAPI.SetGOActive(mask,false)
    end)

    isHad = false
    for i, v in ipairs(curDatas) do
        local get = v:IsGet()
        local finish = v:IsFinish()
        if (not get and finish) then
            isHad = true
            break
        end
    end
    CSAPI.SetGOAlpha(btnGetAll,isHad and 1 or 0.5)
end

function OnClickGetAll()
    if (isHad) then
        TaskProto:GetRewardByType(eTaskType.AnniversaryMission,group)
    end
end