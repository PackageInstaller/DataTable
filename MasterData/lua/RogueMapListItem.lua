local isSel = false
local data = nil
local groupDatas = nil
local isOpen = false
local lockStr = ""

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    isSel = b

end

function Refresh(_data)
    data = _data
    if data then
        groupDatas = RogueMapMgr:GetArr(data:GetID())
        isOpen, lockStr = data:GetOpen()
        SetTitle()
        SetIcon()
        SetNum()
        SetLock()
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle, data:GetName())
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName ~= nil and iconName ~= "" then
        ResUtil.TrialsPage:Load(icon,iconName)
    end
end

function SetNum()
    local cur,max = 0,0
    if groupDatas and #groupDatas > 0 then
        for i, v in ipairs(groupDatas) do
            if v:IsPass() then
                cur = cur + 1
            end
            max = max + 1
        end
    end
    CSAPI.SetText(txtNum1,cur .. "")
    CSAPI.SetText(txtNum2,"/" .. max)
end

function SetLock()
    CSAPI.SetGOActive(lockObj, not isOpen)
end

function GetCfgs()
    local cfgs = {}
    if groupDatas and #groupDatas > 0 then
        for _, v in ipairs(groupDatas) do
            table.insert(cfgs, v:GetCfg())
        end
    end
    return cfgs
end

function GetCfg(index1,index2)
    local cfg = nil
    if groupDatas and groupDatas[index1] then
        local ids = groupDatas[index1]:GetDungeonGroups()
        if ids and ids[index2] then
            cfg = Cfgs.MainLine:GetByID(ids[index2])
        end
    end
    return cfg
end

function GetGroupCfg(index1)
    return (groupDatas and groupDatas[index1]) and groupDatas[index1]:GetCfg() or nil
end

--获取副本当前可进行难度和难度上限
function GetMaxLv(index)
    local max = 0
    if groupDatas and groupDatas[index] then
        local ids = groupDatas[index]:GetDungeonGroups()
        if ids and #ids > 0 then
            max = #ids
        end
    end
    return max
end

function OnClick()
    if cb then
        cb(this)
    end
end
