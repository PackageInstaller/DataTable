local this={};

--创建并显示格子信息
function this.CreateGrids(teamData, grids,parent, cb,openSetting)
    for i=1,6 do
        local data=nil;
        if teamData then
            data=teamData:GetItemByIndex(i);
        end
        if i>#grids then
            ResUtil:CreateUIGOAsync("TeamConfirm/TeamConfirmGrid",parent,function(go)
                local lua=ComUtil.GetLuaTable(go);
                lua.Refresh(data,i,openSetting);
                lua.SetCB(cb);
                table.insert(grids,lua);
            end);
        else
            lua=grids[i]
            lua.Refresh(data,i,openSetting);
            lua.SetCB(cb);
        end
        -- for k,v in ipairs(grids) do --设置层级
        --     v.transform:SetSiblingIndex(#grids-k);
        -- end
    end
end

--返回强制上阵中推荐上阵的卡牌ID cfgId:卡牌配置ID
function this.GetBetterCards(bIsNpc,cfgId)
    local cid=nil;
    local grids=nil;
    if bIsNpc==false then
        local cards=RoleMgr:GetCardsByCfgID(cfgId);
        if cards then
            table.sort(cards,function(a,b)
                return a:GetProperty()>b:GetProperty();
            end);
            cid=cards[1]:GetID();
            grids=cards[1]:GetGrids();
        end
    else
        cid=cfgId;
        local cfg=Cfgs.MonsterData:GetByID(cfgId);
        if cfg then
            grids=cfg.grids;
        end
    end
    return cid,grids;
end


return this;