-- 2. 线性同余法产生均匀型伪随机数需要注意什么？
-- 2.1）种子数是在计算时随机给出的。比如C语言中用srand(time(NULL))函数进行随机数种子初始化。
-- 2.2）决定伪随机数质量的是其余的三个参数，即a,b,m决定生成伪随机数的质量（质量指的是伪随机数序列的周期性）
-- 2.3）一般b不为0。如果b为零，线性同余法变成了乘同余法，也是最常用的均匀型伪随机数发生器。
-- 3. 高性能线性同余法参数取值要求？
-- 3.1）一般选取方法：乘数a满足a=4p+1；增量b满足b=2q+1。其中p，q为正整数。 PS:不要问我为什么，我只是搬运工，没有深入研究过这个问题。
-- 3.2）m值得话最好是选择大的，因为m值直接影响伪随机数序列的周期长短。记得Java中是取得32位2进制数吧。
-- 3.3）a和b的值越大，产生的伪随机数越均匀
-- 3.4）a和m如果互质，产生随机数效果比不互质好。

-- 公式 
-- f(0) = seed
-- f(n) = (a*f(n-1)+b) mod m

-- 可用素数
-- 99985159 99985217 99985219 99985241 99985267 99985271 99985273 
-- 99985297 99985321 99985337 99985339 99985351 99985397 99985409 
-- 99985423 99985427 99985441 99985463 99985489 99985547 99985549 
-- 99985559 99985573 99985579 99985603 99985637 99985651 99985661 
-- 99985663 99985673 99985681 99985693 99985709 99985723 99985727 
-- 99985777 99985799 99985811 99985843 99985849 99985883 99985927 
-- 99985973 99985987 99986011 99986023 99986039 99986053 99986063

Random = oo.class()
function Random:Init(seed)
	LogDebugEx("初始化随机种子", seed)
	self.arrSeed = {}
	self.arrFormula = {}
	self.nSeedNum = 13

	self.seed = seed
	self.count = 0

	-- for i=1,self.nSeedNum do
	-- 	self.arrSeed[i] = self:RandInit(1000000)
	-- 	self.arrFormula[i] = {self:RandInit(10000)*4+1, self:RandInit(1000000)*2+1}
	-- end
	-- LogTable(self.arrSeed)
	-- LogTable(self.arrFormula)

	-- for i=1,1000 do
	-- 	print(self:Rand(5))
	-- end
	-- ASSERT()
end

function Random:Destroy()
    for k,v in pairs(self) do
        self[k] = nil
    end
end
-- function Random:RandInit(m)
-- 	-- self.seed = seed
-- 	self.count = self.count + 1
-- 	m = math.floor(m)

-- 	self.seed = (401 * self.seed + 104789) % 99985651
-- 	LogDebug(string.format("Random:Rand[%s] = [%s] Mod(%s):%s ", self.count, self.seed, m, self.seed % m))
-- 	return self.seed % m
-- end

-- function Random:Rand(m)

-- 	local index = self:RandInit(1000000) % self.nSeedNum + 1
-- 	self.count = self.count + 1
-- 	m = math.floor(m)

-- 	self.arrSeed[index] = (self.arrFormula[index][1] * self.arrSeed[index] + self.arrFormula[index][2]) % 99985651
-- 	LogDebug(string.format("Random:Rand[%s] = [%s] Mod(%s):%s ", self.count, self.arrSeed[index], m, self.arrSeed[index] % m))
-- 	return self.arrSeed[index] % m
-- end

-- [0,m) 
function Random:Rand(m)
	self.count = self.count + 1
	m = math.floor(m)
	-- LogTrace()
	-- self.seed = (82101 * self.seed + 104789) % 99985651
	-- print("Random------", math.floor(82101 * self.seed), math.floor(82101 * self.seed + 12345), math.floor(82101 * self.seed + 12345) % 2147483647)
	-- lua支持的最大整数2^53-1 = 1463726,7894162465
	-- 注:math.floor(a * seed + b), a过大会越界, 导致前后端不一致, 要控制(a * seed + b)比lua支持的最大整数小
	self.seed = math.floor(82101 * self.seed + 12345) % 2147483647 -- 种子最大2^31-1
	-- if self.seed < 0 then self.seed = -self.seed end
	LogDebug(string.format("Random:Rand[%s] = [%s] Mod(%s):%s ", self.count, self.seed, m, self.seed % m))
	return self.seed % m
end


--[a,b]
function Random:RandEx(a, b)
	a = math.floor(a)
	local r = self:Rand(b-a+1)
	return r+a
end

-- local count = {0,0,0,0}
-- rand = Random(os.time())
-- for i=1,100 do
-- 	local n = rand:RandEx(1,4)
-- 	-- local n = math.random(1,4)
-- 	-- print(i,"===========",n)
-- 	-- if n== 1 then
-- 		count[n] = count[n]+1
-- 	-- end
-- end
-- -- LogDebug(count)
-- LogTable(count)
-- ASSERT()
