local items={};
function Refresh(list)
    if items then
        for k,v in ipairs(items) do
            CSAPI.SetGOActive(v.gameObject,false);
        end
    end
    for k,v in ipairs(list) do
        if k<=#items then
            CSAPI.SetGOActive(items[k].gameObject,true);
            items[k].Refresh(v);
        else
            ResUtil:CreateUIGOAsync("GetWayItem/GoodsGetWayItem",this["node"..k],function(go)
                local lua=ComUtil.GetLuaTable(go);
                lua.Refresh(v);
                table.insert(items,lua);
            end);
        end
    end
end