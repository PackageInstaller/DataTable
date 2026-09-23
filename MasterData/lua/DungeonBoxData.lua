local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(info)
    self.cfg = Cfgs.CfgSectionStarReward:GetByID(info.id)
    self.indexs = info.indexs
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetIndexs()
    return self.indexs
end

function this:GetArr()
    return self.cfg and self.cfg.arr
end

--获取排序好的数据 starNum：当前章节星数
function this:GetInfos(starNum)
    starNum = starNum or 0
    local infos = {}
    local indexs = self:GetIndexs()
    local arr = self:GetArr()
    if arr then
        for i = 1, #arr do
            local _info = arr[i]
            if _info then
                local data = {
                    info = _info,
                    isGet = indexs and indexs[i] ~= nil,
                    isReach = starNum >= _info.starNum
                }
                table.insert(infos,data)
            end
        end
        table.sort(infos,function (a,b)
            if a.isGet == b.isGet then
                if a.isReach == b.isReach then
                    return a.info.index < b.info.index
                else
                    return a.isReach
                end
            else
                return not a.isGet
            end
        end)
    end
    return infos
end

function this:GetInfo(index)
    local arr = self:GetArr()
    return arr and arr[index]
end

--获取当前阶段 会超过最大阶段
function this:GetStage()
    local cur,max = 1,0
    max = self:GetArr() and #self:GetArr() or 0
    if self.indexs and #self.indexs >0 then
        for k, v in ipairs(self.indexs) do
            if v ~= nil and cur <= max then
                cur = cur + 1
            end
        end
    end
    return cur,max
end

--当前阶段信息
function this:GetCurrInfo()
    local cur,max = self:GetStage()
    if cur > max then
        cur = max
    end
    return self:GetInfo(cur)
end

--获取当前阶段所需星星数
function this:GetStarNum()
    local info = self:GetCurrInfo()
    return info and info.starNum or 0
end

--获取最终阶段所需星星数
function this:GetMaxStarNum()
    local arr = self:GetArr()
    if arr and #arr > 0 then
        return arr[#arr].starNum
    end
    return 0
end



return this