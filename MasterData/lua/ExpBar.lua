--Exp进度条类
local this = {
    isRun=false,
}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

--==============================--
--desc:设置属性
--time:2019-05-21 12:03:32
--@oldLv:增加经验前的等级
--@oldExp:增加经验前的经验
--@currentExp:当前的经验
--@expAdd:增加的经验
--@maxLv:最高的等级
--@_progressFunc:更新进度条的回调
--@_nextExpFunc:获取下一等级经验的方法
--@_refreshLvFunc:更新等级的回调
--@_refreshExpFunc:更新经验的回调
--@return 
--==============================--
function this:Begin(oldLv, oldExp,currentLv,currentExp, expAdd, maxLv,_progressFunc, _nextExpFunc,_refreshLvFunc, _refreshExpFunc)
    self.currentLv=oldLv;
	self.currentExp=oldExp;
	self.nowLv=currentLv;
    self.nowExp=currentExp;
    self.currentRunExp=expAdd;
    self.currentMaxExp=_nextExpFunc(self.currentLv);
    self.currentAddExp=expAdd;
    self.maxLv=maxLv;
    self.RefreshLv=_refreshLvFunc;
    self.setValFunc=_progressFunc;
    self.RefreshExp=_refreshExpFunc;
    self.nextExpFunc=_nextExpFunc;
    self.isRun=true;
end

--==============================--
--desc:在update方法中调用该方法
--time:2019-05-21 12:03:57
--@return 
--==============================--
function this:Update()
    if self.isRun==false then
        return
	end
	if self.currentExp <= self.currentMaxExp and self.currentRunExp <= 0 then --没升级
		self.setValFunc(self.currentExp / self.currentMaxExp);
		if self.RefreshExp then
			self.RefreshExp(self.nowExp, self.currentMaxExp, self.currentAddExp)
		end
		self.isRun = false;
	else  
		local num = math.modf(self.currentAddExp * 0.02);
		num = num == 0 and 1 or num;
		self.currentExp = self.currentExp + num;
		self.currentRunExp = self.currentRunExp - num;
		-- self.currentAddExp = self.currentAddExp - num;
		if self.currentLv < self.maxLv then --没到满级的时候
			if self.currentExp >= self.currentMaxExp then--升级了，直接读取最终提升的等级信息
				self.setValFunc(0);
				self.currentExp = 0;
				local upLv=1;--所升等级
				local isRun=true;
				while(isRun==true) do
					local lv=self.currentLv+upLv;
					local upExp=self.nextExpFunc(lv);
					if self.currentRunExp>=upExp then
						self.currentRunExp=self.currentRunExp-upExp;
						upLv=upLv+1;
					else
						isRun=false;
					end
				end
				-- self.currentRunExp=self.nowExp;
				self.currentLv = self.currentLv+upLv;
				if self.RefreshLv then
					self.RefreshLv(self.currentLv);
				end
                self.currentMaxExp = 0;--升级所需经验
                self.currentMaxExp=self.nextExpFunc(self.currentLv);
			end
			if self.RefreshExp then
				self.RefreshExp(self.currentExp, self.currentMaxExp, self.currentAddExp)
			end
			self.setValFunc(self.currentExp / self.currentMaxExp);
		else
			if self.RefreshExp then
				self.RefreshExp("MAX", "MAX", self.currentAddExp);
			end
			self.setValFunc(1);
			self.isRun = false;
		end
	end
end

return this;