local data = nil
local isOpen = false
local lockTips = ""

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if data then
        isOpen, lockTips = data:IsOpen()
        SetLock()
        SetTitle()
        SetPos()
        SetLine()
        if isOpen then
            SetName()
            SetIcon()
        end
    end
end

function SetLock()
    CSAPI.SetGOActive(unLockObj, isOpen)
    CSAPI.SetGOActive(lockObj, not isOpen)
    -- CSAPI.SetGOAlpha(txtObj,isOpen and 1 or 0.4)
end

function SetTitle()
    CSAPI.SetText(txtTitle, data:GetTitle())
end

function SetPos()
    local pos = data:GetPos()
    if pos then
        CSAPI.SetAnchor(gameObject, (pos[2] - 1) * 490, (pos[1] - 1) * -279)
    end
end

function SetName()
    CSAPI.SetText(txtName, data:GetName())
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName and iconName ~= "" then
        ResUtil.LovePlus:Load(icon, data:GetGroup() .. "/" .. iconName)
    end
end

function SetLine()
    local lastId = data:GetLastId()
    CSAPI.SetGOActive(lineObj, lastId and lastId > 0)
    if lastId and lastId > 0 then
        local lastData = LovePlusMgr:GetStoryListData(lastId, data:GetGroup())
        if lastData then
            local lastPos = lastData:GetPos()
            local pos = data:GetPos()
            if lastPos[1] > pos[1] then
                LogError("上一节点错误,当前节点行数不可小于上一节点行数！！！id:" .. data:GetID())
                return
            end
            CSAPI.SetGOActive(line1, pos[1] - lastPos[1] == 0 and lastPos[2] ~= pos[2])
            CSAPI.SetGOActive(line2, pos[1] - lastPos[1] ~= 0 and lastPos[2] ~= pos[2])
            CSAPI.SetGOActive(line3, lastPos[2] == pos[2])
            if lastPos[2] ~= pos[2] then -- 不同列
                if pos[1] - lastPos[1] == 0 then -- 同行
                    local h = 0
                    local w = (pos[2] - lastPos[2]) * 48 + (pos[2] - lastPos[2] - 1) * 442
                    CSAPI.SetRTSize(line1, w, 4)
                else -- 不同行
                    local h = (pos[1] - lastPos[1]) * 279 - 117.5
                    local w = (pos[2] - lastPos[2]) * (48 + 221) + (pos[2] - lastPos[2] - 1) * 221
                    CSAPI.SetRTSize(line2, w, h)
                end
            end
        end
    end
end

function GetData()
    return data
end

function OnClick()
    if not isOpen then
        return
    end
    if cb then
        cb(this)
    end
end
