local items = {}
local cfgLists = {}
local cfgs = {}
local infos = {}
local timer,time= 0,0

function Awake()
    AdaptiveConfiguration.SetLuaObjUIFit("SpecialGuide",gameObject)
    InitCfgs()
end

function InitCfgs()
    local _cfgs = Cfgs.SpecialGuide:GetAll()
    if _cfgs then
        for _, cfg in pairs(_cfgs) do
            if cfg.viewName then
                cfgLists[cfg.viewName] = cfgLists[cfg.viewName] or {}
                table.insert(cfgLists[cfg.viewName],cfg)
            end
            cfgs[cfg.id] = cfg
        end
    end
end

function Update()
    for k, v in pairs(infos) do
        Show(k)
    end
end

function OnDestroy()
    AdaptiveConfiguration.RemoveLuaUIFit("SpecialGuide")
end

function Refresh(viewName,type,datas)
    type = type or SpecialGuideType.Start
    if type == SpecialGuideType.StopAll then
        StopAll()
        return
    end
    local cfgs = cfgLists[viewName]
    if cfgs and #cfgs > 0 then
        local need,max =0,0
        for _, cfg in ipairs(cfgs) do
            if cfg.info then
                need,max = 0,0
                for k, v in pairs(cfg.info) do
                    if datas and datas[k] and CheckIsPass(v,datas[k]) then
                        need = need + 1
                    end
                    max = max + 1
                end
                if need == max and cfg.id then
                    TryPlay(cfg.id,type)
                end
            elseif cfg.id then
                TryPlay(cfg.id,type)
            end
        end
    end
end

function CheckIsPass(v,index)
    if tostring(type(v)) == "table" and #v > 0 then --在区间内
        return v[1] <= index and index <= v[2]
    elseif tostring(type(v)) == "number" then
        return v == index
    end
end

function TryPlay(id,type)
    if type == SpecialGuideType.Start then
        Start(id)
    elseif type == SpecialGuideType.Stop then
        Stop(id)
    elseif type == SpecialGuideType.Finish then
        Finish(id)
    elseif type == SpecialGuideType.FinishOrRefresh then
        FinishOrRefresh(id)
    end
end

function Start(id)
    local cfg = cfgs[id]
    if cfg == nil or cfg.time == nil then
        return
    end
    if infos[id] and infos[id].isShow then
        return
    end

    local time = cfg.time + TimeUtil:GetTime()
    if SpecialGuideMgr:IsShow(id) then --已经显示
        time = TimeUtil:GetTime() - 1
    elseif cfg.font and cfg.font ~= SpecialGuideMgr:GetCurShow() then --判断前置
        return
    end
    infos[id] = {
        time = time,
        cfg = cfg,
    }
end


function StopAll()
    for k, v in pairs(infos) do
        if items[v] then
            CSAPI.SetGOActive(items[v].gameObject,false)
        end
    end
    infos = {}
end

function Stop(id)
    if infos[id] and items[id] then 
        CSAPI.SetGOActive(items[id].gameObject,false)
    end
    infos[id] = nil
end

function Show(id)
    if not cfgs[id] then
        return
    end
    if infos[id] and not infos[id].isShow and TimeUtil:GetTime() > infos[id].time then
        infos[id].isShow = true
        if items[id] then
            CSAPI.SetGOActive(items[id].gameObject, true)
            items[id].Refresh(cfgs[id])
        elseif cfgs[id].name then
            local go = ResUtil:CreateUIGO("SpecialGuide/" .. cfgs[id].name,guideParent.transform)
            if not IsNil(go) then
                local lua = ComUtil.GetLuaTable(go)
                if lua and lua.Refresh then
                    lua.Refresh(cfgs[id])
                end
                items[id] = lua
            end
        end
        SpecialGuideMgr:SetShow(id,true)
    end
end

function FinishOrRefresh(id)
    if infos[id] then
        if infos[id].isShow then
            Finish(id)
        else --刷新
            Start(id)
        end
    end
end

function Finish(id)
    if infos[id] then
        if infos[id].isShow then
            SpecialGuideMgr:SetCurShow(id)
            SpecialGuideMgr:SetShow(id,false)
        end
        Stop(id)
    end
end
