local curDatas
local layout = nil
local tlua = nil
local refreshTime = 0
local time, timer = 0, 0

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Mission3/MissionScoreItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, function(_data)
        if not _data then
            RefreshPanel()
            return
        end

        local rewards = _data[2]
        RefreshPanel()
        if (#rewards > 0) then
            UIUtil:OpenReward({rewards})
        end
    end);

    eventMgr:AddListener(EventType.Mission_ReSet, function()
        view:Close() -- 任务重置，关闭界面
    end)

    CSAPI.SetGOActive(clickMask, false)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data,{isGetAll = data.isGetAll})
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = refreshTime - TimeUtil:GetTime()
        local tab = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime, 37069, tab[1], tab[2],tab[3])
        if time < 0 then
            OnClickClose()
        end
    end
end

function OnOpen()
    if data then
        AnimStart()
        tlua:AnimAgain()
        RefreshPanel()
    end
end

function RefreshPanel()
    SetDatas()
    SetTime()
    SetItems()
end

function SetDatas()
    curDatas = MissionMgr:GetActivityDatas(data.type, data.group)
end

function SetTime()
    refreshTime = data.time or 0
    time = refreshTime - TimeUtil:GetTime()
    if time <= 0 then
        CSAPI.SetText(txtTime, "")
    end
end

function SetItems()
    layout:IEShowList(#curDatas, AnimEnd)
end

function OnClickClose()
    view:Close()
end

function AnimStart()
    CSAPI.SetGOActive(clickMask, true)
end

function AnimEnd()
    CSAPI.SetGOActive(clickMask, false)
end
