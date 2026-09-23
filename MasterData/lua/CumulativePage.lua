local items={};
function Refresh(list,elseData)
    if list==nil or #list==0 then
        do return end
    end
    --创建子物体
    if #list<8 then
        for i=#list,8 do
            CSAPI.SetGOActive(this["arrow"..i],false);
        end
    end
    for i, v in ipairs(list) do
        local isSP=(elseData and elseData.activityData) and elseData.activityData:IsOverRewards(v:GetID()) or false;
        local s=isSP and 1.1 or 0.94;
        CSAPI.SetScale(this["node"..i],s,s,s);
        if i<#items then
            CSAPI.SetGOActive(items[i].gameObject,true);
            items[i].Refresh(v,elseData);
        else
            ResUtil:CreateUIGOAsync("CumulativeSpending/CumulativeCommItem", this["node"..i], function(go)
                local lua = ComUtil.GetLuaTable(go);
                table.insert(items,lua);
                lua.Refresh(v,elseData);
            end);
        end
    end
    for i=#list+1, #items do
        CSAPI.SetGOActive(items[i].gameObject,false);
    end
    CSAPI.SetGOActive(arrow8,(elseData and elseData.totalCount>this.index));
end

function SetIndex(i)
    this.index=i;
end

function SetClickCB(func)
end