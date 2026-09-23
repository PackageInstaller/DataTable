-- filter的某一项，当前全部筛选数据
function Refresh(data, _elseData)
    elseData = _elseData
    title = data[1]
    cfgName = data[2]

    curSelectDatas = elseData[cfgName]
    -- title
    CSAPI.SetText(txtTitle, LanguageMgr:GetByID(tonumber(title)))
    SetItems()
end

function SetItems()
    -- all
    local str = LanguageMgr:GetByID(3025)
    local allData = {
        id = 0,
        sName = str
    }
    if (not allItem) then
        ResUtil:CreateUIGOAsync("Sort/SortPanelItem3", allParent, function(go)
            allItem = ComUtil.GetLuaTable(go)
            allItem.SetClickCB(ItemClickCB)
            allItem.Refresh(allData, curSelectDatas)
        end)
    else
        allItem.Refresh(allData, curSelectDatas)
    end
    -- list
    local cfgs = FilterEnums(cfgName)

    items = items or {}
    ItemUtil.AddItems("Sort/SortPanelItem3", items, cfgs, gameObject, ItemClickCB, 1, curSelectDatas)
end

function FilterEnums(cfgName)
    if cfgName==nil then
        return {};
    end
    local cfgs={};
    if cfgName=="CfgSkinSeriesEnum" then
        --筛选皮肤系列下是否存在上线的皮肤
        cfgs=ShopMgr:GetSkinFilterSets(4);
    else
        local _cfgs = Cfgs[cfgName]:GetAll() --适应字典
        for k, v in pairs(_cfgs) do
            table.insert(cfgs,v)
        end
    end
    table.sort(cfgs, function(a, b)
        return a.id < b.id
    end)
    return cfgs;
end

function ItemClickCB(id)
    if (id == 0) then
        curSelectDatas = {0}
    else
        if (curSelectDatas[1] == 0) then
            curSelectDatas = {id}
        else
            local isIn = false
            for k, v in ipairs(curSelectDatas) do
                if (id == v) then
                    isIn = true
                    table.remove(curSelectDatas, k)
                    break
                end
            end
            if (not isIn) then
                table.insert(curSelectDatas, id)
            end 
        end
    end
    if(#curSelectDatas<=0) then 
        curSelectDatas = {0}
    end
    SetItems()

    elseData[cfgName] = curSelectDatas
end
