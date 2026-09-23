local key = nil
local cfg = nil
local isCanGet = false
local data = nil

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Activity_SignIn, ESignCB)
    fade = ComUtil.GetCom(gameObject, "ActionFade")
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
    SetDatas()
    SetButton()
    isClick = false
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
        SetDatas()
        SetTime()
        SetButton()
        SetItems()
    end
end

-- 如果是12或者倒数12位，则额外加多2个空数据填位
function SetDatas()
    curDatas = {}
    local info = SignInMgr:GetDataByKey(key)
    local curDay = info:GetRealDay()
    datas = SignInMgr:GetDayInfos(key)

    if datas and datas[1] then
        local rewards = datas[1]:GetRewards()
        if rewards and #rewards > 0 then
            curDatas = GridUtil.GetGridObjectDatas2(rewards)
        end
    end
end

function SetTime()
    local info = SignInMgr:GetDataByKey(key)
    local cfg = Cfgs.CfgSignReward:GetByID(info.proto.id)

    if cfg then
        local startTimeStr = StringUtil:split(cfg.begTime, " ")[1]
        -- local targetTimeStr = StringUtil:split(cfg.endTime, " ")[1]
        CSAPI.SetText(txtTime,LanguageMgr:GetByID(22046) .. startTimeStr .. "~" .. cfg.endTime)
    end
end

function SetButton()
    local data = datas[1]
	local isDone = data:CheckIsDone() --已签
	local isCurDay = data:GetIsCurDay() --是否是当天
    local isEnd = data:CheckIsEnd() --已过期
    local isShow1,isShow2 = false,false
    if isDone then
        isShow2 = true
        CSAPI.LoadImg(btnGet,"UIs/SignInContinue11/btn_03_02.png",true,nil,true)
        LanguageMgr:SetText(txtGet1,1050)
        LanguageMgr:SetEnText(txtGet2,1050)
        CSAPI.SetTextColor(txtGet1,255,255,255,125)
        CSAPI.SetTextColor(txtGet2,255,255,255,125)
    elseif isEnd then
        isShow2 = true
        CSAPI.LoadImg(btnGet,"UIs/SignInContinue11/btn_03_02.png",true,nil,true)
        LanguageMgr:SetText(txtGet1,39002)
        LanguageMgr:SetEnText(txtGet2,39002)
        CSAPI.SetTextColor(txtGet1,255,255,255,125)
        CSAPI.SetTextColor(txtGet2,255,255,255,125)
    elseif isCurDay then
        isShow2 = true
        isCanGet = true
        LanguageMgr:SetText(txtGet1,10406)
        LanguageMgr:SetEnText(txtGet2,10406)    
    else
        isShow1 = true  
    end
    CSAPI.SetGOActive(state2,isShow2)
    CSAPI.SetGOActive(state1,isShow1)
end

function CheckIsEnd()
    local cfg = datas[1]:GetCfg()
    if cfg.endTime then
        local eTime = TimeUtil:GetTimeStampBySplit(cfg.begTime)
        return TimeUtil:GetTime() > eTime
    end
    return false
end

function SetItems()
    if curDatas and #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            -- local iconName = v:GetIcon()
            -- if(iconName and i ~= 5) then
            --     ResUtil.IconGoods:Load(this["icon" .. i].gameObject, iconName .. "")
            -- end
            CSAPI.SetText(this["txtName" .. i].gameObject,v:GetName())
        end
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
                activity_name = "周年签到3",
                task_id = data.proto.index,
                task_name = data.proto.index,
                item_gain = rewards
            }
            BuryingPointMgr:TrackEvents("activity_attend", taData)
        end
    end
end

function OnClickGet()
    if not isCanGet then
        return
    end
    isCanGet = false
    OnClickMask()
end

-- 点击背景
function OnClickClose()
    view:Close()
end

function OnClickItem(go)
    if curDatas and #curDatas>0 then
        for i, v in ipairs(curDatas) do
            if go.name == "item" .. i then
                UIUtil:OpenGoodsInfo(v, 3);
                break
            end
        end
    end
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
