local key = nil
local isDone = false
local targetTime = 0
local info = nil
local layout = nil
local timer = 0

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Activity_SignIn, ESignCB)

    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/RegressionActivity1/RegressionSignItem", LayoutCallBack, true)
end

function Update()
    if targetTime > 0 and Time.time > timer then
        timer = Time.time + 1
        local tab = TimeUtil:GetDiffHMS(targetTime, TimeUtil:GetTime())
        tab.day = tab.day < 10 and "0" .. tab.day or tab.day
        tab.hour = tab.hour < 10 and "0" .. tab.hour or tab.hour
        tab.minute = tab.minute < 10 and "0" .. tab.minute or tab.minute
        tab.second = tab.second < 10 and "0" .. tab.second or tab.second
        LanguageMgr:SetText(txtTime,60201,tab.day,tab.hour,tab.minute,tab.second)
    end
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        local info = SignInMgr:GetDataByKey(key)
        local isCuyDayDone = info:CheckIsDone()
        lua.Refresh(_data, isCuyDayDone)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(_info)
    info = _info
    if info and info.activityId then
        isDone,key = SignInMgr:CheckIsDone(info.activityId)
        targetTime = RegressionMgr:GetActivityEndTime(info.type)
    end
    CSAPI.SetGOActive(mask,not isDone)
    SetDatas()
    -- if not isDone then
    --     SignInMgr:AddCacheRecord(key)
    -- end
end

-- 如果是12或者倒数12位，则额外加多2个空数据填位
function SetDatas()
    curDatas = {}
    local info = SignInMgr:GetDataByKey(key)
    local curDay = info:GetRealDay()
    datas = SignInMgr:GetDayInfos(key)
    for i, v in ipairs(datas) do
        table.insert(curDatas, v)
    end

    layout:IEShowList(#curDatas, nil, curDay)
end

-- 签到回调
function ESignCB(proto)
    if proto.isOk == false then
        return
    end
    SignInMgr:AddCacheRecord(key)
    -- if(isClick) then return end
    local _key = SignInMgr:GetDataKey(proto.id, proto.index)
    if (key ~= _key) then
        return
    end
    CSAPI.SetGOActive(mask, false)
    -- layout:UpdateList()
    SetDatas()
    isClick = false
    -- ActivityMgr:SetListData(ActivityListType.SignInCommon, {
    --     key = _key
    -- })
end

-- 自动签到
function OnClickMask()
    if (not isClick) then
        isClick = true
        local data = SignInMgr:GetDataByKey(key)
        ClientProto:AddSign(data:GetID())

        if (data) then
            local rewards = {}
            for i, info in pairs(data:GetRewardCfg().infos) do
                if (i == data:GetIndex()) then
                    for k, m in pairs(info.rewards) do
                        table.insert(rewards, {
                            id = m[1],
                            num = m[2]
                        })
                    end
                end
            end

            local taData = {
                reson = "领取活动奖励",
                activity_name = "回归签到",
                task_id = data.proto.index,
                task_name = data.proto.index,
                item_gain = rewards
            }
            BuryingPointMgr:TrackEvents("activity_attend", taData)
        end
    end
end

-- 点击背景
function OnClickClose()
    view:Close()
end

