local cfg = nil
local data = nil
local sectionData = nil
local multiUpdateTime = 0
local isMultiUpdate = false
local isDoubleOpen = false
local multiNum = 0
--限时多倍
local isUnLimit = false
local multiLimitNum = 0
local limitTime = 0
local limitTimer = 0
local isLimitDouble = false --限时多倍
--vip限时多倍
local vipEndTime = 0
local vipTime = 0
local vipTimer = 0

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, OnDailyDataUpdate)
    eventMgr:AddListener(EventType.Dungeon_Double_Update, OnDailyDataUpdate)

    ShowMask(false)
    ShowDesc(false)
end

function OnDailyDataUpdate()
    ShowDoublePanel()
end

function Update()

    if isMultiUpdate or not sectionData then
        return
    end
    
    if multiUpdateTime and TimeUtil:GetTime() >= multiUpdateTime then
        isMultiUpdate = true
        PlayerProto:SectionMultiInfo()
    end

    if isLimitDouble and limitTime>0 and limitTimer < Time.time then
        limitTimer = Time.time + 1
        limitTime = DungeonUtil.GetDropAddTime(sectionData:GetID())
        if limitTime > 60 then
            local tab = TimeUtil:GetTimeTab(limitTime)
            LanguageMgr:SetText(txtDouble2,15129,tab[1],tab[2],tab[3]) 
        else
            LanguageMgr:SetText(txtDouble2,15129,0,0,1) 
        end
        if limitTime <= 0 then
            ShowDoublePanel()
            EventMgr.Dispatch(EventType.Section_Daily_Double_Update)
        end
    end

    if vipTime > 0 and vipTimer < Time.time then
        vipTimer = Time.time + 1
        vipTime = vipEndTime - TimeUtil:GetTime()
        if vipTime <= 0 then
            ShowDoublePanel()
        end
    end
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        ShowDoublePanel()
    end
end

function ShowDoublePanel()
    multiUpdateTime = DungeonMgr:GetMultiUpdateTime()
    if multiUpdateTime and TimeUtil:GetTime() < multiUpdateTime then
        isMultiUpdate = false
    end

    -- double		
    local hasMulti = DungeonUtil.HasMultiDesc(sectionData:GetID());
    CSAPI.SetGOActive(gameObject,hasMulti)
    if not hasMulti then
        return
    end

    multiLimitNum,_,isUnLimit,isLimitDouble = DungeonUtil.GetDropAdd(sectionData:GetID())
    CSAPI.SetGOActive(double1,not isLimitDouble)
    CSAPI.SetGOActive(double2,isLimitDouble)

    if isLimitDouble then
        limitTime = DungeonUtil.GetDropAddTime(sectionData:GetID())
        return
    end

    local dStr = DungeonUtil.GetMultiDesc(sectionData:GetID())
    CSAPI.SetText(txtDouble, dStr);

    multiNum,_,vipEndTime = DungeonUtil.GetMultiNum(sectionData:GetID())
    vipTime = vipEndTime> 0 and vipEndTime - TimeUtil:GetTime() or 0

    CSAPI.SetGOActive(btnMask, multiNum <= 0)
    if (multiNum > 0) then
        local doubleState = LoadDoubleState(sectionData:GetID())
        if (doubleState) then
            isDoubleOpen = doubleState.type == 1
        end
    else
        isDoubleOpen = false
    end
    SetDoubleState()
end

-- 设置双倍状态
function SetDoubleState()   
    CSAPI.SetGOActive(close,not isDoubleOpen)
    CSAPI.SetGOActive(open,isDoubleOpen)
    DungeonMgr:SetMultiReward(isDoubleOpen)
    SaveDoubleState(sectionData:GetID(), isDoubleOpen and 1 or 0)
end

-- 保存副本双倍状态
function SaveDoubleState(_id, _type)
    if (_id > 0) then
        local _data = LoadDoubleState(_id) or {}
        _data.id = _id
        _data.type = _type
        FileUtil.SaveToFile("doubleState_" .. _id .. ".txt", _data)
    end
end

-- 读取副本双倍状态
function LoadDoubleState(_id)
    return FileUtil.LoadByPath("doubleState_" .. _id .. ".txt")
end

function ShowDouble(b)
    isDoubleOpen = b
    SetDoubleState()
end

function IsDouble()
    return isDoubleOpen
end

function IsLimitDouble()
    return isLimitDouble
end

function GetMultiNum()
    return multiNum
end

function OnClickDouble()
    isDoubleOpen = not isDoubleOpen
    if multiNum < 1 then
        LanguageMgr:ShowTips(8016)
        isDoubleOpen = false
    end
    SetDoubleState()
end

function ShowDesc(b)
    isDescOpen = true
    CSAPI.SetGOActive(descObj,b)
    CSAPI.SetGOActive(descObj2,b)
    if b then
        if isLimitDouble then
            CSAPI.SetGOActive(descObj, false)
            local limit = isUnLimit and "∞" or multiLimitNum..""
            LanguageMgr:SetText(txtDesc2,15130,limit)
        else
            CSAPI.SetGOActive(descObj2, false)
            CSAPI.SetText(txtDesc,string.format("%s\n%s",LanguageMgr:GetByID(15098),vipTime > 0 and DungeonUtil.GetVipMultiDesc(sectionData:GetID()) or ""))
        end
    end
end

function ShowMask(b)
    CSAPI.SetGOActive(doubleMask,b)
end

function OnClickDesc()
    ShowMask(true)
    ShowDesc(true)
end

function OnClickBack()
    ShowMask(false)
    ShowDesc(false)
end

function SetPos(x,y)
    CSAPI.SetAnchor(doubleObj,x,y)
end

function SetTextColor(code1,code2,code3,code4)
    if code1 and code1~="" then
        CSAPI.SetTextColorByCode(txt_double,code1)
    end
    if code2 and code2~="" then
        CSAPI.SetTextColorByCode(txtDouble,code2)
    end
    if code3 and code3~="" then
        CSAPI.SetImgColorByCode(line,code3)
    end
    if code4 and code4~="" then
        local dStr = DungeonUtil.GetMultiDesc(sectionData:GetID())
        dStr= StringUtil:StrReplace(dStr,"FFC146",code4)
        CSAPI.SetText(txtDouble, dStr);
    end
end

function SetButtonImg(openName,closeName)
    if openName and openName ~= "" then
        CSAPI.LoadImg(open,"UIs/DungeonInfo/" .. openName .. ".png",true)
    end
    if closeName and closeName ~= "" then
        CSAPI.LoadImg(close,"UIs/DungeonInfo/" .. closeName .. ".png",true)
    end
end