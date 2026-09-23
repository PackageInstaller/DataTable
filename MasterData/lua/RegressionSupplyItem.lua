local cfg, data = nil, nil
local id = nil
local sTime, eTime = 0, 0
local isGet = false
local targetTime = 0
local time, timer = 0, 0
local goodsData = nil
local curTimeIndex = 1

function SetIndex(idx)
    index = idx
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = targetTime - TimeUtil:GetTime()
        CSAPI.SetText(txtLockTime, TimeUtil:GetTimeStr(time))
        if time <= 0 then
            SetTime()
            SetState()
        end
    end
end

function Refresh(_data)
    cfg = _data
    id = cfg and cfg.id
    if cfg then
        SetTime()
        SetDesc()
        SetReward()
        SetState()
    end
end

function SetTime()
    local timeTab = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
    targetTime = 0
    if cfg.infos then
        for i, v in ipairs(cfg.infos) do
            curTimeIndex = i
            sTime, eTime = v.time[1], v.time[2]
            if v.time[2] > timeTab.hour and not CheckIsGet(i) then
                break
            end
        end
    end
end

function SetDesc()
    LanguageMgr:SetText(txtDesc, 55003, sTime .. ":00", eTime .. ":00")
end

function SetReward()
    if cfg.infos and cfg.infos[curTimeIndex] and cfg.infos[curTimeIndex].reward then
        local itemInfo = cfg.infos[curTimeIndex].reward[1]
        goodsData = GridFakeData({
            id = itemInfo[1],
            num = itemInfo[2]
        })
        local cfgItem = Cfgs.ItemInfo:GetByID(itemInfo[1])
        if cfgItem and cfgItem.icon then
            ResUtil.IconGoods:Load(icon, cfgItem.icon)
        end
        CSAPI.SetText(txtNum, itemInfo[2] .. "")
    end
end

function SetState()
    if isGet then
        CSAPI.SetGOActive(lockObj, true)
        CSAPI.SetGOActive(nolObj, false)
        LanguageMgr:SetText(txtLockTime, 55006)
        CSAPI.SetTextColorByCode(txtLockTime, "5b5954")
        return
    end
    local timeTab = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
    if sTime <= timeTab.hour and eTime > timeTab.hour then
        CSAPI.SetGOActive(lockObj, false)
        CSAPI.SetGOActive(nolObj, true)
        targetTime = TimeUtil:GetTime2(timeTab.year, timeTab.month, timeTab.day, eTime, 0, 0)
    elseif sTime > timeTab.hour then
        targetTime = TimeUtil:GetTime2(timeTab.year, timeTab.month, timeTab.day, sTime, 0, 0)
        CSAPI.SetGOActive(nolObj, false)
        CSAPI.SetGOActive(lockObj, true)
        CSAPI.SetTextColorByCode(txtLockTime, "5b5954")
    else
        CSAPI.SetGOActive(nolObj, false)
        CSAPI.SetGOActive(lockObj, true)
        LanguageMgr:SetText(txtLockTime, 55005)
        CSAPI.SetTextColorByCode(txtLockTime, "ff7781")
    end
    time = targetTime - TimeUtil:GetTime()
end

function CheckIsGet(index)
    isGet = false
    local data = RegressionMgr:GetSupplyData(id or 0)
    if data and data.gainArr and data.gainArr[index] then
        isGet = data.gainArr[index] == 1
    end
    return isGet
end

function OnClickGet()
    RegressionProto:ResupplyGain(id, curTimeIndex)
end

function OnClickItem()
    UIUtil:OpenGoodsInfo(goodsData, 3)
end
