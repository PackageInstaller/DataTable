local cfg = nil
local items1 = nil
local items2 = nil
local datas1 = nil
local datas2 = nil
local currItem = nil
local selData = nil
local isHideNew = false

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    cfg = _data
    selData = _elseData and _elseData.selData
    isHideNew= _elseData and _elseData.isHideNew
    if cfg then
        SetBG()
        SetPos()
        SetItems()
    end
end

function SetBG()
    local bgName = cfg.icon
    if bgName ~= nil and bgName ~= "" then
        ResUtil.BadgeBg:Load(bg, bgName)
    end
end

function SetPos()
    local pos = cfg.pos
    if pos then
        pos[1] = pos[1] or 1
        pos[2] = pos[2] or 1
        CSAPI.SetAnchor(gameObject, 19 + (pos[1] - 1) * 586, -19 + (pos[2] - 1) * -163)
    end
end

function SetItems()
    local size = cfg.size
    local w, h = size[1] > 1 and size[1] * 562 + 20 * (size[1] - 1) or 562,
        size[2] > 1 and size[2] * 142 + 20 * (size[2] - 1) or 142
    CSAPI.SetRTSize(gameObject, w, h)
    local _datas = BadgeMgr:GetArr(cfg.id) or {}
    items1 = items1 or {}
    if size[2] == 1 then
        CSAPI.SetAnchor(grid1, 64 + w / 2, -72)
        datas1 = _datas
        ItemUtil.AddItems("Badge/BadgeGridItem", items1, datas1, grid1, OnItemClick, 1, isHideNew, OnLoadSuccse)
    else
        if cfg.lines and cfg.lines == 3 then
            datas1 = _datas
            ItemUtil.AddItems("Badge/BadgeGridItem", items1, datas1, grid3, OnItemClick, 1, isHideNew, OnLoadSuccse)
        else
            CSAPI.SetAnchor(grid1, 64 + w / 2, -95)
            CSAPI.SetAnchor(grid2, 64 + w / 2, -206)
            datas1 = {}
            datas2 = {}
            items2 = items2 or {}
            if #_datas > 0 then
                for i, v in ipairs(_datas) do
                    if i <= math.ceil(#_datas / 2) then
                        table.insert(datas1, v)
                    else
                        table.insert(datas2, v)
                    end
                end
            end
            ItemUtil.AddItems("Badge/BadgeGridItem", items1, datas1, grid1, OnItemClick, 1, isHideNew, OnLoadSuccse)
            ItemUtil.AddItems("Badge/BadgeGridItem", items2, datas2, grid2, OnItemClick, 1, isHideNew, OnLoadSuccse)
        end
    end
end

function OnLoadSuccse()
    local isFind = false
    if items1 and #items1 > 0 then
        for i, v in ipairs(items1) do
            v.SetScale(0.6, 0.68)
            local _data = v.GetData()
            if _data and selData and not isFind then
                if _data:GetType() then
                    local _datas2 = BadgeMgr:GetArrByType(_data:GetType()) or {}
                    if #_datas2 > 0 then
                        for k, m in ipairs(_datas2) do
                            if selData:GetID() == m:GetID() then
                                v.OnClick()
                                isFind = true
                            end
                        end
                    end    
                elseif _data:GetID() == selData:GetID() then
                    v.OnClick()
                    isFind = true
                end
            end
        end
    end
    if items2 and #items2 > 0 then
        for i, v in ipairs(items2) do
            v.SetScale(0.6, 0.68)
            local _data = v.GetData()
            if _data and selData and not isFind then
                if _data:GetType() then
                    local _datas2 = BadgeMgr:GetArrByType(_data:GetType()) or {}
                    if #_datas2 > 0 then
                        for k, m in ipairs(_datas2) do
                            if selData:GetID() == m:GetID() then
                                v.OnClick()
                                isFind = true
                            end
                        end
                    end    
                elseif _data:GetID() == selData:GetID() then
                    v.OnClick()
                    isFind = true
                end
            end
        end
    end
end

function HasData(_id)
    local _datas = BadgeMgr:GetArr(cfg.id) or {}
    if #_datas > 0 then
        for i, v in ipairs(_datas) do
            if v:GetType() then
                local _datas2 = BadgeMgr:GetArrByType(v:GetType()) or {}
                if #_datas2 > 0 then
                    for k, m in ipairs(_datas2) do
                        if _id == v:GetID() then
                            return true
                        end
                    end
                end
            else
                if _id == v:GetID() then
                    return true
                end
            end
        end
    end
    return false
end

function GetPosIndex()
    if cfg.pos and cfg.pos[2] then
        return cfg.pos[2]
    end
    return 1
end

function OnItemClick(item)
    if cb then
        cb(item)
    end
end

function OnClickReplace()
    local _datas = BadgeMgr:GetArr(cfg.id)
    local ids = {}
    if #_datas > 0 then
        for i, v in ipairs(_datas) do
            if v:IsGet() then
                table.insert(ids, v:GetID())
            end
        end
    end
    if #ids > 0 then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(36001)
        dialogData.okCallBack = function()
            BadgeMgr:UpdateSorts(ids)
            EventMgr.Dispatch(EventType.Badge_Data_Update)
        end
        CSAPI.OpenView("Dialog",dialogData)
    else
        LanguageMgr:ShowTips(36002)
    end
end
--------------------------------anim--------------------------------

function PlayEnterAnim()
    local pos = cfg.pos
    local _index = pos and pos[2] or 1
    UIUtil:SetObjFade(gameObject,0,1,nil,300,(_index - 1) * 100)
end
