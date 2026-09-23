--装备背包加锁
local this={};
local root=nil;
local data=nil;
local selectList={}; --选中状态的列表
local originList={}; --源列表的列表
local onceMax=300;
function this.SetData(_root,_data)
    root=_root;
    data=_data;
end

function this.Refresh()
    local list = EquipMgr:GetAllEquipArr(nil, true);
    if list then
        this.CleanCache();
        for k,v in ipairs(list) do
            if v:IsLock()==true then
                table.insert(selectList,v);
            end
        end
        originList=list;
    end
    root.Refresh(list);
end

-- function this.GetScreenDataType()
--     return EquipViewKey.Bag;
-- end

function this.GetElseData(data)
    local isSelect=false;
    if selectList then
        for k, v in ipairs(selectList) do
            if v:GetID() == data:GetID() then
                isSelect = true;
                break;
            end
        end
    end
    return {isClick=true,isSelectLock = isSelect,selectType=1,hideLock=true,showNew=true, removeFunc = nil};
end

function this.OnClickGrid(tab)
    if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function()
			tab.SetNewState(tab.data:IsNew());
		end);
    end
    local key=-1;
    for k,v in ipairs(selectList) do
        if v:GetID()==tab.data:GetID() then
            key=k;
            break;
        end
    end
    if key==-1 then
        table.insert(selectList,tab.data);
    else
        table.remove(selectList,key);
    end
    root.UpdateCell(tab.index);
end

function this.OnClickReturn()
    this.CleanCache()
    root.ChangeLayout(BagMgr:GetSelChildTabIndex(),EquipBagType.Normal,BagType.Equipped);
end

function this.OnClickLock()
    local infos=this.GetChangeList();
    if infos==nil or (infos and #infos<=0) then
        EventMgr.Dispatch(EventType.Equip_SetLock_Ret)
        do return end
    end
    -- LogError(#infos);
    if #infos>=onceMax then --筛选出状态变更的内容，超过onceMax个则分段发送，每次间隔250毫秒
        local round= math.ceil(#infos/onceMax)
        local index=1;
        FuncUtil:Timer(function()
            local list={};
            for i=index,#infos do
                if #list>=onceMax then
                    break;
                end
                table.insert(list,infos[i]);
                index=index+1;
            end
            -- LogError("发送到"..tostring(index).."的所有数据")
            -- LogError(list)
            EquipProto:SetLock(list);
        end,nil,0,250,round);   
    else
        EquipProto:SetLock(infos)
    end
end

function this.GetChangeList()
    local infos={};
    local max=#originList>=#selectList and #originList or #selectList
    for k,v in ipairs(originList) do
        local has=false;
        for _,val in ipairs(selectList) do
            if v:GetID()==val:GetID() then
                has=true;
                break;
            end
        end
        if v:IsLock()~=has then
            table.insert(infos,{sid=v:GetID(),lock=has==true and 1 or 0});
        end
    end
    return infos;
end

function this.CleanCache()
    selectList={};
    originList={};
end

return this;