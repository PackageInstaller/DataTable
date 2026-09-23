local this = {};
this.csGetCom = CS.ComUtil.GetCom;
this.GetComs = CS.ComUtil.GetComs;
this.GetComInChildren = CS.ComUtil.GetComInChildren;
this.GetComsInChildren = CS.ComUtil.GetComsInChildren;
this.GetComInParent = CS.ComUtil.GetComInParent;
this.GetComsInParent = CS.ComUtil.GetComsInParent;
this.AddCom = CS.ComUtil.AddCom;
this.GetOrAddCom = CS.ComUtil.GetOrAddCom

function this.GetCom(go,comName)
    --LogError("GetCom: go=" .. go.name .. ",com=" .. comName);
    return this.csGetCom(go,comName);
end

local luaTables = {};

function this.FixLuaTables()
    if(luaTables)then
        for k,v in pairs(luaTables)do
            if(k and IsNil(k))then
                luaTables[k] = nil;
            end
        end
    end
end

--获取Lua表
function this.GetLuaTable(gameObject)
    local luaTable = luaTables[gameObject];
    if(luaTable)then
        return luaTable;
    end

    local mono = this.GetCom(gameObject,"XLuaMono");
    if(mono)then
        luaTable = mono.luaTable;
        luaTables[gameObject] = luaTable;
    end
    return luaTable;
end
--获取Lua表
function this.GetLuaTableInChildren(gameObject)
    local mono = this.GetComInChildren(gameObject,"XLuaMono");
    if(mono ~= nil)then
        return mono.luaTable;
    end
    return nil;
end
--获取Lua表
function this.GetLuaTableInParent(gameObject)
    local mono = this.GetComInParent(gameObject,"XLuaMono");
    if(mono ~= nil)then
        return mono.luaTable;
    end
    return nil;
end
return this;