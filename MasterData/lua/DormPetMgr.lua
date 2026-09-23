local DormPetInfo = require "DormPetInfo"
local this = MgrRegister("DormPetMgr")

function this:Init()
    self:Clear()
    DormProto:DormPetInfo()
end

function this:Clear()
    self.datas = {}
end

function this:DormPetInfoRet(info)
    local dic = {}
    for k, v in pairs(info) do
        dic[v.id] = v
    end
    local cfgs = Cfgs.CfgDormPet:GetAll()
    for k, v in pairs(cfgs) do
        local info = DormPetInfo.New()
        info:InitData({
            id = v.id,
            data = dic[v.id]
        }, true)
        self.datas[v.id] = info
    end
end

function this:GetData(id)
    return self.datas[id]
end

function this:GetDatas()
    return self.datas
end

-- 数组(已拥有的)
function this:GetArr(id)
    local arr = {}
    for i, v in pairs(self.datas) do
        if (v:IsHad()) then
            if(id==nil or id==v:GetData().build_id)then 
                table.insert(arr, v)
            end 
        end
    end
    return arr
end

-- 假数据
function this:GetFakeData(_id, _data)
    local cfg = Cfgs.CfgDormPet:GetByID(_id)
    if (cfg) then
        local info = DormPetInfo.New()
        info:InitData({
            id = _id,
            data = _data or {}
        }, false)
        return info
    end
    return nil
end

function this:GetComforts(id)
    local comfort = 0
    local arr = self:GetArr()
    for i, v in ipairs(arr) do
        if (v:GetData().build_id == id) then
            comfort = comfort + v:GetCfg().comfort
        end
    end
    return comfort
end

return this
