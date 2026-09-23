local curDatas = {}
local layout = nil
--time
local refreshTime = 0
local time = 0
local timer = 0
local timeTab = nil
function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/Activity7/AnniversaryItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function OnInit()
    UIUtil:AddTop2("AnniversaryView",gameObject,OnClickBack)
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = refreshTime - TimeUtil:GetTime()
        if time <= 0 then
            SetTime()
            SetItems()
        end
    end
end

function OnOpen()
    RefreshPanel()
end

function RefreshPanel()
    SetDatas()
    SetTime()
    SetItems()
end

function SetDatas()
    if #curDatas < 1 then
        local _cfgs = Cfgs.CfgAnniversary:GetAll()
        if _cfgs then
            for k, _cfg in pairs(_cfgs) do
                table.insert(curDatas,_cfg)
            end
        end
        if #curDatas>0 then
            table.sort(curDatas,function (a,b)
                local s1 = GetTimeState(a)
                local s2 = GetTimeState(b)
                if s1 ~= s2 then
                    return s1 < s2
                else
                    return a.id < b.id
                end
            end)
        end
    end
end

function GetTimeState(cfg)
    if cfg and cfg.sTime and cfg.eTime then
        local sTime = TimeUtil:GetTimeStampBySplit(cfg.sTime)
        local eTime = TimeUtil:GetTimeStampBySplit(cfg.eTime)
        if sTime >= TimeUtil:GetTime() then
            return 2 --未开启
        elseif eTime < TimeUtil:GetTime() then
            return 3 --结束
        end
    end
    return 1 --开启
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

function SetItems()
    layout:IEShowList(#curDatas)
end

function OnClickBack()
    view:Close()
end