local openInfo = nil
local info = nil
local lastBGM = nil
local isLoading = false
local top = nil
local sectionData = nil
local redPath = nil
-- 时间
local dTime = 0 -- 选关
local sTime = 0 -- 商店
local mTime = 0 -- 任务
local timer = 0

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Mission_List, function()
        SetRed(MissionMgr:CheckRed2(sectionData:GetTaskType(),sectionData:GetID()))
    end)
    eventMgr:AddListener(EventType.Bag_Update, function()
        CSAPI.SetText(txtNum, BagMgr:GetCount(info.goodsId) .. "")
        SetExploreRed()
    end)

    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.Scene_Load_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetExploreRed)

    if not IsNil(endImg) then
        CSAPI.SetGOActive(endImg, false)
    end

    if not IsNil(timeObj3) then
        CSAPI.SetGOActive(timeObj3, false)
    end

    if not IsNil(timeObj2) then
        CSAPI.SetGOActive(timeObj2, false)
    end
end

function OnViewClosed(viewKey)
    if viewKey == "Plot" or viewKey == "ShopView" then
        FuncUtil:Call(function()
            if gameObject then
                CSAPI.PlayBGM(info.bgm, 1)
            end
        end, this, 200)
    end
end

function OnLoadComplete()
    if isLoading then
        FuncUtil:Call(function()
            if gameObject then
                lastBGM = CSAPI.PlayBGM(info.bgm, 1)
            end
        end, nil, 200)
    end
end

function Update()
    if openInfo and not openInfo:IsOpen() then
        openInfo = nil
        LanguageMgr:ShowTips(24001)
        UIUtil:ToHome()
        return
    end
    UpdateTime()
end

function OnOpen()
    SetTitleEffect()
    SetBGScale()
    SetBGSex()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        info = sectionData:GetInfo()
        SetTime()
        SetNum()
        SetSpecial()
        SetRed(MissionMgr:CheckRed2(sectionData:GetTaskType(),sectionData:GetID()))
        SetExploreRed()
        if top == nil then
            top = UIUtil:AddTop2(info.view, topParent, OnClickReturn);
        end
    end

    if openSetting and openSetting.isDungeonOver then -- 战斗完返回
        isLoading = true
    end
    lastBGM = CSAPI.PlayBGM(info.bgm, 1000)
end

function SetTitleEffect()
    if jpTitle and not IsNil(jpTitle.gameObject) then
        CSAPI.SetGOActive(jpTitle,CSAPI.IsADVRegional(3))
        CSAPI.SetGOActive(title,not CSAPI.IsADVRegional(3))
    end
end

function SetBGScale()
    local size = CSAPI.GetMainCanvasSize()
    local offset1, offset2 = size[0] / 1920, size[1] / 1080
    local offset = offset1 > offset2 and offset1 or offset2
    local child = bg.transform:GetChild(0)
    if child then
        CSAPI.SetScale(child.gameObject, offset, offset, offset)
    end

    if offset1 > offset2 then
        CSAPI.SetRTSize(bg, size[0], 1080 * offset)
    elseif offset1 < offset2 then
        CSAPI.SetRTSize(bg, 1920 * offset, size[1])
    end
end

function SetNum()
    CSAPI.SetText(txtNum, BagMgr:GetCount(info.goodsId) .. "")
end

function SetRed(b)
    if redPath == nil then
        redPath = sectionData and sectionData:GetRedPath() or "Common/Red2"
    end
    if not IsNil(redParent) then
        UIUtil:SetRedPoint2(redPath, redParent, b, 0, 0)
    else
        CSAPI.SetGOActive(redAnim, b)
    end
end

function SetExploreRed()
    if sectionData:GetExploreId() then
        if redPath == nil then
            redPath = sectionData and sectionData:GetRedPath() or "Common/Red2"
        end
        local exData = ExplorationMgr:GetExData(sectionData:GetExploreId())
        local isRed = exData and exData:HasRevice() or false
        if redAnim2 then
            CSAPI.SetGOActive(redAnim2, isRed)
        else
            UIUtil:SetRedPoint2(redPath, redParent2, isRed, 0, 0)
        end
    end
end

function SetSpecial()
    if info.view == "DungeonActivity1" then
        FuncUtil:Call(function()
            if gameObject then
                CSAPI.SetGOActive(effObj, true)
            end
        end, nil, 300)
        CSAPI.SetText(txtHard, LanguageMgr:GetTips(24007, openInfo:GetOpenCfg().hardBegTime))
    end
end

function SetBGSex()
    if bgWoman and not IsNil(bgWoman.gameObject) then
        CSAPI.SetGOActive(bgWoman,PlayerClient:GetSex() == 2)
    end
    if bgMan and not IsNil(bgMan.gameObject) then
        CSAPI.SetGOActive(bgMan,PlayerClient:GetSex() == 1)
    end
end

---------------------------------------------时间---------------------------------------------
function SetTime()
    if sectionData then
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if openInfo then
            SetViewTime()
            SetDungeonTime()
            SetShopTime()
            SetMissionTime()
        end
    end
end

function SetViewTime()
    if openInfo:IsDungeonOpen() then
        local strs = openInfo:GetTimeStrs()
        local str = LanguageMgr:GetByID(22021) .. strs[1] .. " " .. strs[2] .. "-" .. strs[3] .. " " .. strs[4]
        CSAPI.SetText(txtTime, str)
    else
        local str = openInfo:GetCloseTimeStr()
        CSAPI.SetText(txtTime, str)
    end
end

function SetDungeonTime()
    if TimeUtil:GetTime() < openInfo:GetDungeonEndTime() then
        dTime = openInfo:GetDungeonEndTime() - TimeUtil:GetTime()
        if dTime <= 0 and not IsNil(endImg) and not IsNil(txtTime2) and not IsNil(timeObj2) then
            CSAPI.SetGOActive(timeObj2, true)
            CSAPI.SetGOActive(endImg, true)
            LanguageMgr:SetText(txtTime2, 39002)
        end
    elseif not IsNil(endImg) and not IsNil(txtTime2) and not IsNil(timeObj2) then
        CSAPI.SetGOActive(timeObj2, true)
        CSAPI.SetGOActive(endImg, true)
        LanguageMgr:SetText(txtTime2, 39002)
    end
end

function SetShopTime()
    if dTime <= 0 then
        sTime = openInfo:GetEndTime() - TimeUtil:GetTime()
        if not IsNil(timeObj3) then
            CSAPI.SetGOActive(timeObj3, sTime > 0)
        end
    end
end

function SetMissionTime()
    if TimeUtil:GetTime() < openInfo:GetEndTime() then
        mTime = openInfo:GetEndTime() - TimeUtil:GetTime()
    end
end

function UpdateTime()
    if Time.time > timer then
        timer = Time.time + 1
        UpdateDungeonTime()
        UpdateShopTime()
        UpdateMissionTime()
    end
end

function UpdateDungeonTime()
    if dTime > 0 then
        dTime = openInfo:GetDungeonEndTime() - TimeUtil:GetTime()
        -- SetTxtTime(txtTime2,dTime)
        if dTime <= 0 and not IsNil(endImg) and not IsNil(txtTime2) and not IsNil(timeObj2) then
            CSAPI.SetGOActive(timeObj2, true)
            CSAPI.SetGOActive(endImg, true)
            LanguageMgr:SetText(txtTime2, 39002)
            SetShopTime()
        end
    end
end

function UpdateShopTime()
    if sTime > 0 then
        sTime = openInfo:GetEndTime() - TimeUtil:GetTime()
        SetTxtTime(txtTime3, sTime)
    end
end

function UpdateMissionTime()
    if mTime > 0 then
        mTime = openInfo:GetEndTime() - TimeUtil:GetTime()
        SetTxtTime(txtTime4, mTime)
    end
end

function SetTxtTime(go, time)
    if IsNil(go) or time <= 0 then
        return
    end
    local tab = TimeUtil:GetTimeTab(time)
    if tab[1] > 0 then
        LanguageMgr:SetText(go, 22073, tab[1], tab[2] .. ":" .. tab[3] .. ":" .. tab[4])
    else
        CSAPI.SetTextColorByCode(go, "ff7166")
        if tab[2] > 0 or tab[3] > 0 then
            LanguageMgr:SetText(go, 22074, tab[2] .. ":" .. tab[3] .. ":" .. tab[4])
        else
            LanguageMgr:SetText(go, 22074, LanguageMgr:GetByID(51016))
        end
    end
end

---------------------------------------------点击---------------------------------------------
function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = info.taskType,
        group = data.id,
        title = LanguageMgr:GetByID(6021)
    })
end

function OnClickShop()
    if sectionData:GetExploreId() then
        CSAPI.OpenView("SpecialExploration", sectionData:GetExploreId());
    else
        CSAPI.OpenView("ShopView", openInfo:GetShopID())
    end
end

function OnClickExploration()
    local exData = ExplorationMgr:GetExData(sectionData:GetExploreId())
    if exData and exData:IsOpen() then
        CSAPI.OpenView("SpecialExploration", sectionData:GetExploreId());
    else
        LanguageMgr:ShowTips(24003)
    end
end

function OnClickDungeon()
    if not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    if data then
        CSAPI.OpenView(info.childView, {
            id = data.id
        })
    end
end

function OnClickReturn()
    view:Close()
end

function OnDestroy()
    if not FightClient:IsFightting() then -- 不在战斗中关闭界面时重播bgm
        FuncUtil:Call(function()
            if lastBGM ~= nil then
                CSAPI.ReplayBGM(lastBGM)
            else
                EventMgr.Dispatch(EventType.Replay_BGM, 50);
            end
        end, this, 300)
    end

    eventMgr:ClearListener()
end
