-- filter的某一项，当前全部筛选数据
function Refresh(data, _elseData)
    elseData = _elseData
    title = data[1]
    cfgName = data[2]
    curSelectDatas = elseData and elseData[cfgName]
    -- title
    CSAPI.SetText(txtTitle, LanguageMgr:GetByID(tonumber(title)))
    SetItems()
end

function SetItems()
    --初始化全部按钮
    local cfgs = FilterEnums(cfgName)
    local isSet=cfgName=="CfgSkinSeriesEnum";
    CSAPI.SetGOActive(layout1,isSet);
    CSAPI.SetGOActive(layout2,not isSet);
    items = items or {}
    SetAllBtnState();
    if isSet then
        ItemUtil.AddItems("ShopSkinPage/SkinFilterSetItem", items, cfgs, layout1, ItemClickCB, 0.7, curSelectDatas)
    else
        ItemUtil.AddItems("ShopSkinPage/SkinFilterBtn", items, cfgs, layout3, ItemClickCB, 1, curSelectDatas)
    end
end

function SetAllBtnState()
    local isAll=false;
    if curSelectDatas==nil or (curSelectDatas~=nil and curSelectDatas[1]==0) then
        isAll=true
    end
    CSAPI.SetGOActive(imgOn,isAll)
    CSAPI.SetTextColorByCode(txtAll,isAll and "1f1f1f" or "bebebe");
end

function OnClickAll()
    --修改状态
    SetAllBtnState()
    ItemClickCB(0)
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
