local timer = 0
local targetTime = 0
local curDatas = nil
local layout = nil
local info = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/RegressionActivity3/RegressionMissionItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    eventMgr = ViewEvent.New();
    
end

function OnEnable()
    eventMgr:AddListener(EventType.Mission_List, function(_data)
        if gameObject.activeSelf == false then
            return
        end
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
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function OnDisable()
    eventMgr:ClearListener()
end

function Update()
    if targetTime > 0 and Time.time > timer then
        timer = Time.time + 1
        local tab = TimeUtil:GetDiffHMS(targetTime, TimeUtil:GetTime())
        tab.day = tab.day < 10 and "0" .. tab.day or tab.day
        tab.hour = tab.hour < 10 and "0" .. tab.hour or tab.hour
        tab.minute = tab.minute < 10 and "0" .. tab.minute or tab.minute
        tab.second = tab.second < 10 and "0" .. tab.second or tab.second
        LanguageMgr:SetText(txtTime,22031,tab.day,tab.hour,tab.minute,tab.second)
    end
end

function Refresh(_info)
    info = _info
    if info then
        targetTime = RegressionMgr:GetActivityEndTime(info.type)
        RefreshPanel()    
    end
end

-- 刷新下方数据
function RefreshPanel()
    curDatas = MissionMgr:GetActivityDatas(eTaskType.RegressionTask, info.activityId) or {}
    if #curDatas < 1 then --没任务获取就刷新界面
        EventMgr.Dispatch(EventType.Update_Everyday)
        return
    end
    tlua:AnimAgain()
    layout:IEShowList(#curDatas)
end

function OnClickJump()
    if info and info.infos and info.infos[1] then
        JumpMgr:Jump(info.infos[1].jumpId)
    end
end