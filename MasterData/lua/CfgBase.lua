local CfgBase = {}

--配置数据
CfgBase.datas_ID = nil
--配置key到id的映射表
CfgBase.datas_Key = nil
--分组
CfgBase.groups = nil

function CfgBase:New()
    self.__index = self.__index or self
    local ins = {}
    setmetatable(ins, self)
    return ins
end

--初始化
function CfgBase:Init(datas)
    self.myDatas = datas;
    self:TryInit(); 
end
function CfgBase:TryInit()
    if(not self.inited)then
        self:InitDatas(self.myDatas);
        self.inited = 1;
    end
end
function CfgBase:InitDatas(datas)
    self.datas_ID = {}
    self.datas_Key = {}
    self.groups = {}

    for i, v in pairs(datas) do
        if(v.id and v.key)then
            self.datas_ID[v.id] = v
            self.datas_Key[v.key] = v

            local groupId = v.group
            if (groupId ~= nil and groupId >= 0) then
                local groupTab = self.groups[groupId]
                if (groupTab == nil) then
                    groupTab = {}
                    self.groups[groupId] = groupTab
                end

                local insertIx = 0
                for i = 1, #groupTab, 1 do
                    local tmpV = groupTab[i]
                    if v.id > tmpV.id then
                        insertIx = i
                    else
                        break
                    end
                end

                table.insert(groupTab, insertIx + 1, v)
            end
        else
            --ASSERT(v.id, 'not id')
            --ASSERT(v.key, 'not key')
        end
    end

    self.isInit = true
end

function CfgBase:IsInit()
    return self.isInit
end

--根据id获取
function CfgBase:GetByID(id)
    self:TryInit();
    if (id ~= nil) then
        return self.datas_ID[id]
    end
    return nil
end
--根据key获取
function CfgBase:GetByKey(key)
    self:TryInit();
    if (key ~= nil) then
        return self.datas_Key[key]
    end
    return nil
end
--获取一组
--groupID：分组id
function CfgBase:GetGroup(groupId)
    self:TryInit();
    return self.groups[groupId]
end
--获取全部
function CfgBase:GetAll()
    self:TryInit();
    return self.datas_ID
end

return CfgBase
