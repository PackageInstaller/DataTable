local this = MgrRegister("HaloMgr")

function this:Init()
    self:Clear()
end

--hasEquips:是否包含已穿戴的装备，filters:装备Tag筛选，types:装备属性筛选
function this:GetEquips(hasEquips,filters,types)
    local list={};
    if self.equips then
        for k, v in pairs(self.equips) do
            list=list or {};
            local canAdd=true;
            local _type=v:GetType();
            if filters==nil or (filters and (filters[v:GetTypeTag()]~=nil or filters[-1]~=nil)) then
                canAdd=true;
            elseif (filters~=nil and next(filters)) then
                canAdd=false;
            end
            if canAdd and (types==nil or (types and (types[_type])~=nil)) then
                canAdd=true;
            elseif canAdd and (types~=nil and next(types)) then
                canAdd=false;
            end
            if canAdd and hasEquips~=true then
                canAdd=v:IsEquipped()==0
            end
            if canAdd then
                table.insert(list,v);
            end
        end
    end
    return list;
end

function this:GetEquip(cid)
    if self.equips and cid and self.equips[cid] then
       return self.equips[cid]
    end
end

function this:UpdateEquips(proto)
    if proto and proto.infos and next(proto.infos) then
        for k, v in ipairs(proto.infos) do
            self:UpdateEquip(v);
        end
        if proto.is_finish then
            --抛光环装备更新事件
            EventMgr.Dispatch(EventType.Halo_Equip_Update)
        end
    end
end


function this:Remove(sid)
    if self.equips and self.equips[sid] then
        self.equips[sid]=nil;
    end
end

function this:Clear()
    self.equips=nil;
end

return this;