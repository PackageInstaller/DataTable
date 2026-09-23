local info = nil
local curDatas = {}
local items,items2 =nil,nil
local cfg = nil
local jumpState = 1
--time
local refreshTime = 0
local time = 0
local timer = 0
local timeTab = nil

function OnInit()
    UIUtil:AddTop2("SummaryNewYear",topObj,OnClickBack)
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = refreshTime - TimeUtil:GetTime()
        if time <= 0 then
            RefreshPanel()
        end
    end
end

function OnOpen()
    SetDatas()
    RefreshPanel()
end

function RefreshPanel()
    SetTime()
    SetItems()
end

function SetDatas()
    local cfgs = Cfgs.CfgSummary:GetAll()
    if cfgs then
        for k, v in ipairs(cfgs) do
             if v.type == eSummaryType.NewYear then
                cfg = v
                break
             end
        end
    end
    if cfg and cfg.infos and #cfg.infos > 0 then
        for i, v in ipairs(cfg.infos) do
            local isEnd = TimeUtil:GetTimeStampBySplit(v.eTime) <= TimeUtil:GetTime()
            if not isEnd then
                table.insert(curDatas,v)
            end
        end
    end
end

function SetTime()
    if #curDatas > 0 and timeTab == nil then
        local _time = 0
        timeTab = {}
        for i, v in ipairs(curDatas) do
            if v.sTime and v.eTime then
                _time = TimeUtil:GetTimeStampBySplit(v.sTime)
                if _time > TimeUtil:GetTime() then
                    table.insert(timeTab,_time)
                end
                _time = TimeUtil:GetTimeStampBySplit(v.eTime)
                if _time > TimeUtil:GetTime() then
                    table.insert(timeTab,_time)
                end              
            end
        end
        if #timeTab>0 then
            table.sort(timeTab,function (a,b)
                return a < b
            end)
        end
    end
    if timeTab and #timeTab > 0 and refreshTime <= TimeUtil:GetTime() then
        refreshTime = table.remove(timeTab,1)
        time = refreshTime - TimeUtil:GetTime()
    end
end

function GetStr(i)
    return i < 10 and "0" .. i or i
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Summary1/SummaryNewYearItem",items,curDatas,itemParent)
end

function OnClickBack()
    view:Close()
end