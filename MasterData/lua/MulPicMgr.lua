-- 多人插图 管理器 
-- local MulPicSortUtil = require "MulPicSortUtil"
local MulPicInfo = require "MulPicInfo"
local this = MgrRegister("MulPicMgr")

function this:Init()
    self:SetSortDatas()
    self:InitDatas()
end

function this:InitDatas()
    self.datas = {}
    local cfgs = Cfgs.CfgArchiveMultiPicture:GetAll()
    for k, v in pairs(cfgs) do
        local info = MulPicInfo.New()
        info:InitData(v)
        self.datas[v.id] = info
    end
end

function this:Clear()
    self.datas = {}
end

-- 字典（包含没获得的）
function this:GetDatas()
    return self.datas
end

function this:GetData(id)
    return self.datas and self.datas[id]
end

-- 列表（包含不可用,默认true）;nType 0:全部 1:多人插图 2:半身像
function this:GetArr(_isContain, _nType)
    local isContain = _isContain == nil and true or _isContain
    local nType = _nType or 0
    local arr = {}
    local datas = self:GetDatas()
    for k, v in pairs(datas) do
        if (nType == 0 or v:GetType() == nType) then
            if (isContain) then
                table.insert(arr, v)
            else
                if (v:IsHad()) then
                    table.insert(arr, v)
                end
            end
        end
    end
    if (#arr > 1) then
        table.sort(arr, function(a, b)
            return a:GetSort() < b:GetSort()
        end)
    end
    return arr
end

-- -- 已排序并且可用
-- function this:GetCanUseSortArr()
--     return MulPicSortUtil:SortByCondition(self:GetArr(false))
-- end

function this:SetSortDatas()
    self.curFiltrateType = {
        ["ThemeType"] = {0}
    }
end

-- 筛选方式
function this:SGetCurFiltrateType(value)
    if (value) then
        self.curFiltrateType = value
    end
    return self.curFiltrateType
end

return this
