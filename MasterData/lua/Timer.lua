--[[    --计时器
    New()    --创建对象         
    Init()   --初始化           Awake中调用
    Run()    --跑              Update中调用
    SetStop  --设置暂停或继续
]]
local this = {
	isEnd = true,
	interval = 0,
	oldTime = 0,
	curTime = 0,
	endTime = 0,
	runTime = 0,	--这一秒到下一秒已经走了多长时间：0-1
	perFunc = nil,  --每次调用
	endFunc = nil,  --结束调用
}

--==============================--
--desc:递增计算
--time:2019-07-10 03:24:07
--@_endTime:结束时间戳
--@_interval:执行间隔 nil或者0 表示每帧执行 , 1 表示1秒执行1次  , 0.22 表示0.2秒执行1次
--@_perfunc:每次执行的方法
--@_endfunc:结束时执行的方法
--@return 
--==============================--
function this:Init(_endTime, _interval, _perfunc, _endfunc)
	if(_endTime == 0 or _perfunc == nil) then
		LogError("endTime is zero // perfunc is nil")
		return
	end
	self.endTime = _endTime
	self.perFunc = _perfunc
	self.endFunc = _endfunc
	self.interval = _interval
	self.runTime = 0
	self.isEnd = false
end

--==============================--
--desc: 计算 （放在update中执行）
--time:2019-07-10 03:27:18
--@return 是否已结束
--==============================--
function this:Run()
	if(not self.isEnd) then
		if(self.interval == 0) then
			self:PerFrame()
		else
			self:Other()	
		end
		return self.isEnd
	end
end

--每帧调用
function this:PerFrame()
	self.curTime = os.time()
	if(self.curTime >= self.endTime) then
		self.isEnd = true
		self.endFunc(self.curTime)
		return
	end
	if(self.oldTime == 0) then
		self.oldTime = self.curTime
	end
	if(self.oldTime ~= self.curTime) then
		self.oldTime = self.curTime
		self.runTime = 0
	end
	self.runTime = self.runTime + Time.deltaTime
	if(self.runTime > 1) then
		self.runTime = 1
	end
	self.perFunc(self.curTime + self.runTime)
end

--规定时间调用
function this:Other()
	self.curTime = os.time()
	if(self.curTime >= self.endTime) then
		self.isEnd = true
		self.endFunc(self.curTime)
		return
	end
	self.runTime = self.runTime + Time.deltaTime
	if(self.runTime >= self.interval) then
		self.perFunc(self.curTime + self.runTime)
		self.runTime = 0
	end
end

--设置暂停或开启
function this:SetStop(b)
	self.isEnd = b
end



return this 