local runTime = false
-- local timer = 0
local t = 0.5

function Awake()
    acObj = ComUtil.GetCom(gameObject, "ActionUIMoveTo")
    fill = ComUtil.GetCom(bar, "Image")
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Scene_Load, OnSceneLoad)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if (runTime) then
        -- timer = timer - Time.deltaTime
        -- if (timer < 0) then
        --     timer = t
        SetTime()
        -- end
    end
end

-- 强制退出
function ForceClose(_cb)
    local x, y, z = CSAPI.GetAnchor(gameObject)
    runTime = false
    acObj:PlayByTime(0, y, 0, t, function()
        view:Close()
        if (_cb) then
            _cb()
        end
    end)
end

-- 邀请tips
function Close()
    local x, y, z = CSAPI.GetAnchor(gameObject)
    acObj:PlayByTime(0, y, 0, t, function()
        view:Close()
        if (cb) then
            cb(index)
        end
    end)
end

function Refresh(_index, _data, _cb)
    index = _index
    data = _data
    cb = _cb

    friendData = FriendMgr:GetData(data.uid)
    -- lv 
    CSAPI.SetText(txtLv, friendData:GetLv() .. "")
    -- name
    CSAPI.SetText(txtName, friendData:GetName())
    --
    UIUtil:AddHeadByID(hfParent, 1, friendData.icon_frame, friendData.icon_id, friendData.sel_card_ix)
    -- 
    UIUtil:AddTitleByID(titleParent, 1, friendData.icon_title)
    -- time
    local baseTime = data.invite_time + ExerciseRMgr:GetPPTimer()
    needTime = baseTime - TimeUtil:GetTime()
    SetTime()
end

function SetTime()
    needTime = needTime - Time.deltaTime
    needTime = needTime <= 0 and 0 or needTime
    runTime = needTime > 0
    -- CSAPI.SetText(txtTime2, math.floor(needTime) .. "s")
    fill.fillAmount = needTime / ExerciseRMgr:GetPPTimer()
    if (runTime == false) then
        Close()
    end
end

function GetIndex()
    return index
end

-- 向上移动
function SetMoveUp(y)
    local x = CSAPI.GetAnchor(gameObject)
    acObj:PlayByTime(x, y, 0, t)
end

-- 拒绝
function OnClick1()
    if (data) then
        runTime = false
        ArmyProto:BeInviteRet({{
            uid = data.uid,
            is_receive = false
        }})
        Close()
        ExerciseFriendTool:BeInviteRet(data.uid)
    end
end

-- 接受
function OnClick2()
    -- -- 是否已编队
    if (not ExerciseRMgr:CheckCanAgree()) then
        LanguageMgr:ShowTips(33023)
        return
    end
    if (data) then
        runTime = false
        ArmyProto:BeInviteRet({{
            uid = data.uid,
            is_receive = true
        }})
        Close()
    end
end

function OnSceneLoad(sceneName)
    if(sceneName and sceneName~="MajorCity")then 
        OnClick1()
    end 
end
