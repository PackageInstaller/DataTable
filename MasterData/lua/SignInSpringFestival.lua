local key = nil
local targetTime = 0
local cfg = nil
local data = nil

function Awake()

    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/SignInContinue17/SignInSpringFestivalItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        local info = SignInMgr:GetDataByKey(key)
        local isCuyDayDone = info:CheckIsDone()
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data, {isShowNextDay = isCuyDayDone,isFillStart = isFillStart,infoData = info})
    end
end

function OnItemClickCB(item)
    if not isFillOpen or not isFillStart then
        return
    end

    local info = SignInMgr:GetDataByKey(key)
	if info:GetFillNum() <= 0 then
		LanguageMgr:ShowTips(74002)
		return
	end

	local dialogData = {}
    dialogData.content = LanguageMgr:GetTips(74001,item.GetCostName() .. "x" .. item.GetCostNum()) .. (info:IsShowFillNum()
	and "\n" .. LanguageMgr:GetTips(74003,info:GetFillNum()) or "")
    dialogData.okCallBack = function()
		ClientProto:AddSign(info:GetID(),item.data:GetIndex())
	end
    CSAPI.OpenView("Dialog",dialogData)
end

function OnEnable()
    eventMgr:AddListener(EventType.Activity_SignIn, ESignCB)
end

-- 签到回调
function ESignCB(proto)
    local _key = SignInMgr:GetDataKey(proto.id, proto.index)
    if (key ~= _key) then
        return
    end
    if proto.isOk == false then
        EventMgr.Dispatch(EventType.Acitivty_List_Pop)
        return
    end
    SignInMgr:AddCacheRecord(key)
    SetDatas()
    -- SetFill()
    isClick = false
end

function OnDisable()
    eventMgr:ClearListener()
end

function Refresh(_data,_elseData)
    data = _data
    if data then
        key = SignInMgr:GetDataKeyById(data:GetID())
        cfg = data:GetCfg()
        local info = SignInMgr:GetDataByKey(key)
        if not info then
            LogError("缺少签到数据！！！")
            return
        end
        if info and not info:CheckIsDone() then
            EventMgr.Dispatch(EventType.Activity_Click)
        end
        SetDatas()
        SetTime()
        -- SetFill()
    end
end

-- 如果是12或者倒数12位，则额外加多2个空数据填位
function SetDatas()
    curDatas = {}
    local info = SignInMgr:GetDataByKey(key)
    isFillStart= info:CheckIsFillStart()
    isFillOpen = info:CheckIsFillOpen()
    local curDay = info:GetRealDay()
    datas = SignInMgr:GetDayInfos(key)

    for i, v in ipairs(datas) do
        table.insert(curDatas, v)
    end

    layout:IEShowList(#curDatas, nil, curDay)
end



function SetTime()
    local info = SignInMgr:GetDataByKey(key)
    local cfg = Cfgs.CfgSignReward:GetByID(info.proto.id)

    if cfg then
        local startTimeStr = StringUtil:split(cfg.begTime, " ")[1]
        -- local targetTimeStr = StringUtil:split(cfg.endTime, " ")[1]
        CSAPI.SetText(txtTime,LanguageMgr:GetByID(22046) .. startTimeStr .. "~" .. cfg.endTime)
        -- targetTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
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
                activity_name = "新春签到",
                task_id = data.proto.index,
                task_name = data.proto.index,
                item_gain = rewards
            }
            BuryingPointMgr:TrackEvents("activity_attend", taData)
        end
    end
end

function SetFill()
    CSAPI.SetGOActive(fillObj, isFillOpen)
    if isFillOpen then
        local info = SignInMgr:GetDataByKey(key)
        CSAPI.SetText(txtFillNum,info:GetFillNum() .. "")
        CSAPI.SetText(txtFillTime,LanguageMgr:GetByID(310002) .. TimeUtil:GetTimeStr2(info:GetFillStartTime(),true))
    end
end

-- 点击背景
function OnClickClose()
    view:Close()
end
