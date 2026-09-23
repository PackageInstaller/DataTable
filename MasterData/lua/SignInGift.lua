local key = nil
local targetTime = 0
local cfg = nil
local data = nil
function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Activity_SignIn, ESignCB)

    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/SignInContinue7/SignInGiftItem", LayoutCallBack, true)

    fade = ComUtil.GetCom(gameObject, "ActionFade")
end

function Update()
    if targetTime > 0 then
        local tab = TimeUtil:GetTimeTab(targetTime - TimeUtil:GetTime())
        local hour = tab[2] % 24
        LanguageMgr:SetText(txtTime2, 13020, tab[1]," ".. hour .. ":" .. tab[3] .. ":" .. tab[4])
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
    ReleaseCSComRefs()
end

function Refresh(_data,_elseData)
    data = _data
    if data then
        key = SignInMgr:GetDataKeyById(data:GetID())
        cfg = data:GetCfg()
        local info = SignInMgr:GetDataByKey(key)
        if info and not info:CheckIsDone() then
            EventMgr.Dispatch(EventType.Activity_Click)
        end
        SetDatas()
        SetTime()
    end
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
    -- if(isClick) then return end
    local _key = SignInMgr:GetDataKey(proto.id, proto.index)
    if (key ~= _key) then
        return
    end
    if proto.isOk == false then
        EventMgr.Dispatch(EventType.Acitivty_List_Pop)
        return
    end
    SignInMgr:AddCacheRecord(key)

    -- CSAPI.SetGOActive(mask, false)
    -- layout:UpdateList()
    SetDatas()
    isClick = false
end

function SetTime()
    local _data = ActivityMgr:GetOperateActive(cfg.id)
    if _data and _data.sTime and _data.eTime then
        local tab1 = TimeUtil:GetTimeHMS(_data.sTime,"%Y/%m/%d %H:%M")
        local tab2 = TimeUtil:GetTimeHMS(_data.eTime,"%Y/%m/%d %H:%M")

        CSAPI.SetText(txtTime,tab1.." - " .. tab2)
    end
end

function PlayFade(isFade, cb)
    local star = isFade and 1 or 0
    local target = isFade and 0 or 1
    if not IsNil(fade) then
        fade:Play(star, target, 200, 0, function()
            if cb then
                cb()
            end
        end)
    end
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
                activity_name = "中秋签到",
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

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    hsv = nil;
    mask = nil;
    view = nil;
end
----#End#----
