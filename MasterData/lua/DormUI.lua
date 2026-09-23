local talkEndTime = nil
local eventEndTime = nil
local plNextTime = 1

function Clear()
    talkEndTime = nil
    eventEndTime = nil
    plNextTime = nil

    CSAPI.SetGOActive(talk, false)
    CSAPI.SetGOActive(gift, false)
    CSAPI.SetGOActive(btnClothes, false)
    CSAPI.SetGOActive(eventFace, false)
    CSAPI.SetGOActive(plFace, false)
end

function Awake()
    local scene = SceneMgr:GetCurrScene()
    outlineBar = ComUtil.GetCom(Slider, "OutlineBar")
    fc_go = ComUtil.GetCom(gameObject, "FacingCamera")
end

function Init(_goCamera)
    fc_go:SetCamera(_goCamera)
    isInit = true
end

function OnEnable()
    if(not isInit and DormMgr:GetDormGround()) then 
        Init(DormMgr:GetDormGround().GetCamera().gameObject)
    end 
end

-- function Change(_dormRole)
-- 	Clear()
-- 	Refresh(_dormRole)
-- end

function Refresh(_cRoleInfo)
    cRoleInfo = _cRoleInfo

    if (not cRoleInfo) then
        return
    end
    -- CSAPI.AddUISceneElement(gameObject, cRoleInfo.gameObject, goCamera)

    SetEvent()
    SetPL()
end

function Update()
    if (talkEndTime and Time.time > talkEndTime) then
        talkEndTime = nil
        CSAPI.SetGOActive(talk, false)
        CSAPI.SetGOActive(btnClothes, false)
        CSAPI.SetGOActive(event, true)
    end

    if (not cRoleInfo) then
        return
    end

    if (eventEndTime and Time.time > eventEndTime) then
        eventEndTime = nil
        SetEvent()
    end
    if (plNextTime and Time.time > plNextTime) then
        plNextTime = Time.time + 1
        SetPL()
    end
end

function SetEvent()
    eventStart = false
    -- eventface
    e_id, e_story, e_start = cRoleInfo:GetEvent()
    e_start = e_start ~= nil and e_start or 0
    if (e_id ~= nil) then
        if (TimeUtil:GetTime() >= e_start) then
            eventStart = true -- 到点才显示
            return
        else
            eventEndTime = Time.time + (e_start - TimeUtil:GetTime())
        end
        local cfg = Cfgs.CfgRoleDormitoryEvents:GetByID(e_id)
        CSAPI.LoadImg(eventFace, string.format("UIs/Dorm/%s.png", cfg.icon), true, nil, true)
    end
    CSAPI.SetGOActive(eventFace, eventStart)
end

function SetPL()
    local pl = cRoleInfo:GetCurRealTv()
    if (oldPl and oldPl == pl) then
        return
    end
    oldPl = pl

    faceName = nil
    -- local nextTime, pl = cRoleInfo:GetPLChangeTime()
    -- plNextTime = nextTime

    if (pl <= 10) then
        faceName = "UIs/Dorm/event_5.png"
    elseif (pl <= 50) then
        faceName = "UIs/Dorm/event_4.png"
    end
    CSAPI.SetGOActive(plFace, faceName ~= nil)
    if (faceName ~= nil) then
        CSAPI.LoadImg(plFace, faceName, true, nil, true)
    end
end

-- 气泡
function AddBubble(desc, timer)
    talkEndTime = Time.time + timer
    CSAPI.SetText(txtTalk, desc)
    CSAPI.SetGOActive(talk, desc ~= "" and true or false)
    CSAPI.SetGOActive(event, false)
end

-- 送礼(优先度比换装高)
function InGift(b)
    CSAPI.SetGOActive(talkObj, not b)
    CSAPI.SetGOActive(event, not b)
    CSAPI.SetGOActive(gift, b)
    -- CSAPI.SetGOActive(btnClothes, not b)
    if (b) then
        SetGift()
    end
end

function SetGift()
    -- lv
    local lv = cRoleInfo:GetLv()
    CSAPI.SetText(txtLv, lv .. "")
    -- bar
    local curExp, maxExp = cRoleInfo:GetExp()
    local num = 1
    if (curExp < maxExp) then
        num = curExp / maxExp
    end
    outlineBar:SetProgress(num)
end

-- 换装
function OnClickClothes()
    -- local roomData = DormMgr:GetCurRoomData()
    local cRoleID = cRoleInfo:GetID()
    -- CSAPI.OpenView("DormDress", {roomData:GetID(), cRoleID, CloseDress})
    -- cRoleInfo.ChangeAction(DormRoleActionType.Await)
    -- if(changeClothes) then
    -- 	changeClothes(cRoleID)
    -- end
    EventMgr.Dispatch(EventType.Dorm_Change_Clothes)
end

-- function CloseDress()
-- 	cRoleInfo.ChangeAction(DormRoleActionType.idle)
-- end
function OnClickFace1()
    if (e_id ~= nil and eventStart) then
        if (e_story) then
            CSAPI.OpenView("Plot", {
                storyID = id,
                playCallBack = PlayCallBack
            })
        else
            local curRoomData = self:GetCurRoomData()
            DormProto:TakeEvent(curRoomData:GetID(), cRoleInfo:GetID())
        end
    end
end

-- 播放剧情后，发送协议
function PlayCallBack()
    local curRoomData = self:GetCurRoomData()
    DormProto:TakeEvent(curRoomData:GetID(), cRoleInfo:GetID())
end

-- 偏移（某些动作需要做中心偏移）
function SetCenterOffset(posArr)
    -- CSAPI.SetLocalPos(center, posArr[1], posArr[2], posArr[3])
    if (not uiSceneElement) then
        uiSceneElement = ComUtil.GetCom(gameObject, "UISceneElement")
    end
    uiSceneElement:SetOffset(posArr[1], posArr[2], posArr[3])
end

function SetBtnCloths(b)
    -- CSAPI.SetGOActive(btnClothes, b) --tood 功能整改，隐藏
end

