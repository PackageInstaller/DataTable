local sectionData = nil
local openInfo = nil
local groupDatas = nil
local resetTime= 0
local timer = 0
local isOpen = false

function Awake()
    SetSelect(false)
end

function Update()
    if (resetTime > 0 and Time.time> timer) then
        timer = Time.time + 1
        local timeTab = TimeUtil:GetDiffHMS(resetTime, TimeUtil:GetTime())
        LanguageMgr:SetText(txtTime,isOpen and 51009 or 51008, GetTimeStr(timeTab))
    end
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    CSAPI.SetGOActive(selImg,b)
    if b then
        UIUtil:SetNewPoint(newParent,false)
    end
end

function Refresh(_data,_elseData)
    sectionData = _data
    openInfo = _elseData
    if sectionData then
        groupDatas = DungeonMgr:GetDungeonGroupDatas(sectionData:GetID())
        SetLock()
        SetName()
        SetIcon()
        SetTime()
        SetNew()
    end
end

function SetName()
    CSAPI.SetText(txtName,sectionData:GetName())
end

function SetIcon()
    local iconName = sectionData:GetIcon()
    if iconName ~= nil and iconName ~= "" then
        ResUtil.TrialsPage:Load(icon,iconName)
    end
end

function SetTime()
    CSAPI.SetGOActive(timeObj,resetTime>0)
end

function SetLock()
    if openInfo then
        local _isOpen,_sTime,_eTime = openInfo:IsSectionOpen(sectionData:GetID())
        isOpen = _isOpen
        resetTime = _isOpen and _eTime or _sTime
        if resetTime < TimeUtil:GetTime() then
            resetTime = 0
        end
    end
    CSAPI.SetGOActive(lockObj,not isOpen)
end

function SetNew()
    local newInfo = FileUtil.LoadByPath("TotalBattle_New.txt") or {}
    local isNew = false
    if isOpen then
        if newInfo[sectionData:GetID()] and newInfo[sectionData:GetID()].resetTime then
            if TimeUtil:GetTime() > newInfo[sectionData:GetID()].resetTime then --超过关闭时间
                isNew =true
                newInfo[sectionData:GetID()] = {
                    resetTime = resetTime
                }
                FileUtil.SaveToFile("TotalBattle_New.txt",newInfo)
            end
        else
            isNew =true
            newInfo[sectionData:GetID()] = {
                resetTime = resetTime
            }
            FileUtil.SaveToFile("TotalBattle_New.txt",newInfo)
        end
    end
    UIUtil:SetNewPoint(newParent,isNew)
end

function GetData()
    return sectionData
end

function GetCfgs()
    local cfgs = {}
    if groupDatas and #groupDatas > 0 then
        for i, v in ipairs(groupDatas) do
            local _cfgs = v:GetDungeonCfgs()
            if _cfgs and _cfgs[1] then
                table.insert(cfgs,_cfgs[1])
            end
        end
    end
    return cfgs
end

function GetGroupData(_cfg)
    local id = _cfg and _cfg.id or 0
    if id > 0 and groupDatas and #groupDatas >0 then
        for i, v in ipairs(groupDatas) do
            local ids = v:GetDungeonGroups()
            if ids and #ids >0 then
                for k, m in ipairs(ids) do
                    if m == id then
                        return v
                    end
                end
            end
        end
    end
end

function GetTimeStr(timeTab)
    local str = ""
    if timeTab.hour > 0 or timeTab.day > 0 then
        local day = timeTab.day > 0 and timeTab.day .. LanguageMgr:GetByID(11010) or ""
        local hour = timeTab.hour > 0 and timeTab.hour .. LanguageMgr:GetByID(11009) or ""
        str = day .. hour
    elseif  timeTab.minute > 0 then
        str =  timeTab.minute .. LanguageMgr:GetByID(11011)
    elseif timeTab.second > 0 then
        str = LanguageMgr:GetByID(51016)
    end
    return str
end

function IsOpen()
    return isOpen
end

function OnClick()
    if not isOpen then
        if resetTime > 0 then
            local timeTab = TimeUtil:GetDiffHMS(resetTime, TimeUtil:GetTime())
            Tips.ShowTips(LanguageMgr:GetByID(isOpen and 51009 or 51008, GetTimeStr(timeTab)))    
        end
        return
    end
    if cb then
        cb(this)
    end
end