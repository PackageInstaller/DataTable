local data = nil
local timer, time = 0, 0
local isSelf = false
local hpSlider = nil
local grids = nil
local isTimeOut = false

function Awake()
    hpSlider = ComUtil.GetCom(slider, "Slider")
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = data:GetEndTime() - TimeUtil:GetTime()
        CSAPI.SetText(txtTime,TimeUtil:GetTimeStr(time))
        if time <= 0 then
            SetTime()
        end
    end
end

function SetIndex(idx)
    index = idx
end

function Refresh(_data, _elseData)
    data = _data
    isSelf = _elseData
    if data then
        SetPlayerName()
        SetIcon()
        SetDungeon()
        SetSupport()
        SetHp()
        SetRewards()
        SetTime()
        SetBtn()
        SetRed()
    end
end

function SetPlayerName()
    CSAPI.SetGOActive(playerObj, not isSelf)
    if not isSelf then
        CSAPI.SetText(txtPlayerName, data:GetName())
    end
end

function SetIcon()
    local iconName = data:GetBossIcon()
    if iconName and iconName ~= "" then
        ResUtil.RogueMapBoss:Load(icon, iconName)
    end
end

function SetDungeon()
    CSAPI.SetText(txtName, data:GetDungeonName())
    CSAPI.SetText(txtLevel, LanguageMgr:GetByID(37030) .. data:GetLv())
end

function SetSupport()
    CSAPI.SetGOActive(global, data:GetType() == eDupSupportType.All)
    CSAPI.SetGOActive(friend, data:GetType() == eDupSupportType.Friend)
end

function SetHp()
    local cur, max = data:GetHP()
    hpSlider.value = cur / max
    CSAPI.SetText(txtCur, cur .. "")
    CSAPI.SetText(txtMax, "/" .. max)
    if isSelf then
        CSAPI.SetGOActive(txt_finish,data:IsFinish())
        CSAPI.SetGOActive(txtMax,not data:IsFinish())
        hpSlider.value = data:IsFinish() and 1 or hpSlider.value
    else
        CSAPI.SetGOActive(txt_finish,false)
        CSAPI.SetGOActive(txtMax,true)
    end
end

function SetRewards()
    grids = grids and grids or {}
    for i, v in ipairs(grids) do
        CSAPI.SetGOActive(v.gameObject, false)
    end
    local rewards = data:GetRewards()
    local item, go = nil, nil
    for i = 1, 2 do
        if (i <= #grids) then
            item = grids[i]
            CSAPI.SetGOActive(item.gameObject, true)
        else
            go, item = ResUtil:CreateRewardGrid(gridNode.transform)
            CSAPI.SetScale(go, 0.8, 0.8, 1)
            table.insert(grids, item)
        end
        local _data = i <= #rewards and rewards[i] or nil
        if (_data) then
            local result, clickCB = GridFakeData(_data)
            item.Refresh(result)
            item.SetClickCB(clickCB)
            item.SetCount(_data.num)
        else
            item.Refresh(nil, {
                plus = false
            })
            item.SetClickCB(nil)
        end
    end
end

function SetTime()
    CSAPI.SetGOActive(timeObj,not data:IsFinish())
    isTimeOut = TimeUtil:GetTime() > data:GetEndTime() or data:IsFinish()
    if not isTimeOut then
        time = data:GetEndTime() - TimeUtil:GetTime()
    else
        CSAPI.SetText(txtTime,"00:00:00")
    end
end

function SetBtn()
    CSAPI.SetGOActive(btnEnter,not isSelf)
    CSAPI.SetGOActive(btnGet, isSelf and data:IsFinish())
    CSAPI.SetGOActive(btnCancel, isSelf and not data:IsFinish())
end

function SetRed()
    local isRed = false
    if not isSelf and data:GetType() == eDupSupportType.Friend then
        isRed = data:GetStartTime() > RogueMapMgr:GetFriendTime()
    end
    UIUtil:SetRedPoint(redParent, isRed)
end

function CheckTimeOut()
    if isTimeOut then
        LanguageMgr:ShowTips(50006)
        if not isSelf then
            EventMgr.Dispatch(EventType.RogueMap_Assist_Need_Update)
        end
        return true
    end
end

function OnClickEnter()
    if CheckTimeOut() then
        return
    end

    CSAPI.OpenView("TeamConfirm", { -- 正常上阵
        dungeonId = data:GetDungeonId(),
        teamNum = 1,
        isNotAssist = true,
        assistData = data
    }, TeamConfirmOpenType.RogueMapAssist)
end

function OnClickGet()
    FightProto:RogueMapRequireGainReward(1,data:GetIndex(),OnRewardCallBack)
end

function OnRewardCallBack(proto)
    if proto and proto.s_ixs then
        for i, v in ipairs(proto.s_ixs) do
            RogueMapMgr:RemoveSupportData(v)        
        end
    end
    RogueMapMgr:SetRewardRed(false)
    RedPointMgr:ApplyRefresh()
    EventMgr.Dispatch(EventType.RogueMap_Assist_Refresh)
end

function OnClickCancel()
    FightProto:RogueMapSupportCancel(data:GetIndex(),OnCanelCallBack)
end

function OnCanelCallBack(proto)
    if proto and proto.s_ix then
        RogueMapMgr:RemoveSupportData(proto.s_ix)
    end
    EventMgr.Dispatch(EventType.RogueMap_Assist_Refresh)
end


