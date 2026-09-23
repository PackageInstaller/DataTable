local this = {}
--大富翁地图数据
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg = Cfgs.cfgMonopolyGrid:GetByID(cfgId);
		self.gridsInfo={};
		self.maxGridNum=0;
		self.maxStepNum=0;
        if self.cfg == nil then
            LogError("大富翁活动表：cfgMonopolyGrid中未找到ID：" .. tostring(cfgId) .. "对应的数据");
        end
		--初始化格子信息
		for k, v in ipairs(self.cfg.infos) do
            local gridInfo = RichManGridInfo.New();
            gridInfo:InitCfg(self.cfg.id, v.index);
            table.insert(self.gridsInfo, gridInfo);
            if v.pos > self.maxGridNum then
                self.maxGridNum = v.pos;
            end
            if v.sort > self.maxStepNum then
                self.maxStepNum = v.sort;
            end
        end
        table.sort(self.gridsInfo, function(a, b)
            return a:GetSort() < b:GetSort()
        end)
    end
end

function this:GetID()
	return self.cfg and self.cfg.id or nil
end

--返回指定index的格子信息
function this:GetGridInfoByID(index)
	if self.gridsInfo and index then
		for i, v in ipairs(self.gridsInfo) do
			if v:GetID()==index then
				return v;
			end
		end
	end
end

-- 获取指定 sort 的格子
function this:GetGridBySort(sort)
	if not sort or not self.gridsInfo or #self.gridsInfo == 0 then
		return nil
	end
	for _, v in ipairs(self.gridsInfo) do
		if v:GetSort() == sort then
			return v
		end
	end
end

-- 获取指定 sort 的下一个格子（循环）
function this:GetNextGridBySort(sort)
	if not sort or not self.gridsInfo or #self.gridsInfo == 0 then
		return nil
	end
	local nextSort = sort == self:GetMaxStepNum() and 1 or sort + 1
	for _, v in ipairs(self.gridsInfo) do
		if v:GetSort() == nextSort then
			return v
		end
	end
end

--返回当前的格子模板
function this:GetGridsInfo()
	return self.gridsInfo;
end

--返回格子数量
function this:GetAllGridsNum()
	return self.maxGridNum or 0;
end

--单圈完成的最大步数
function this:GetMaxStepNum()
	return self.maxStepNum or 0;
end

return this;