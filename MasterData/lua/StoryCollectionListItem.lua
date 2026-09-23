local isOpen,lockStr = false,""
local isPlot = false
local cfgDungeon = nil
local data = nil
function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

--groupData 
function Refresh(_data)
    data = _data
    if data then
        cfgDungeon = data:GetFirstDungeonCfg()
        isPlot = cfgDungeon and cfgDungeon.sub_type == DungeonFlagType.Story
        SetIcon()
        SetName()
        SetLock()
        SetDungeon()
    end
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName and iconName ~= "" then
        ResUtil.StoryCollectionImg:Load(icon,data:GetGroup() .. "/" .. iconName)
    end
end

function SetName()
    CSAPI.SetText(txtName,data:GetName())
end

function SetLock()
    if cfgDungeon.openTime then
        local sTime = TimeUtil:GetTimeStampBySplit(cfgDungeon.openTime)
        isOpen = sTime <= TimeUtil:GetTime()
        lockStr = LanguageMgr:GetByID(51008,cfgDungeon.openTime)
    end
    if isOpen then
        isOpen,lockStr = data:IsOpen()
    end
    CSAPI.SetGOActive(lockObj,not isOpen)
    CSAPI.SetText(txtLock,lockStr)
end

function SetDungeon()
    CSAPI.SetGOActive(dungeonImg,not isPlot)
end

function OnClick()
    if not isOpen then
        Tips.ShowTips(lockStr)
        return
    end
    if cb then
        cb(this)
    end
end

function GetID()
    return data and data:GetID()
end

function IsPlot()
    return isPlot
end