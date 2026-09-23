local TableSign	= {}
TableSign.Begin	= 1
TableSign.End	= 2
TableSign.Alter	= 3
----------------------------------------------
-- 战斗记录
FightLog = oo.class()
function FightLog:Init()
	self:Clean()
	self.allLog = {}
	self.index = 0
end

function FightLog:Destroy()
    for k,v in pairs(self) do
        self[k] = nil
    end
end

function FightLog:Clean()
	LogDebug("---------FightLog:Clean()-------------")
	-- LogTrace()
	-- LogTable(self, "self.log on Clean")

	if DEBUG and self.log then
		local log = self:Get()
		if not table.empty(log) then
			table.insert(self.allLog, log)
			if CSAPI then
				CSAPI.SaveToFile("FightLog.txt", table.Encode(self.allLog));
			end
		end
	end

	self.log		= {}
	self.currtable 	= {}
	self.logStack	= {}
	self.keyStack	= {}
end

function FightLog:Add(log)
	self.index = self.index + 1
	log.index = self.index
	table.insert(self.log, log)
end

function FightLog:Start(key)
	local log = {tableSign = TableSign.Begin, type = "item", key = key}
	self:Add(log)
end

function FightLog:End(key)
	local log = {tableSign = TableSign.End, type = "item", key = key}
	self:Add(log)
end

function FightLog:StartEvent(key)
	local log = {tableSign = TableSign.Begin, type = "event", key = key}
	self:Add(log)
end

function FightLog:EndEvent(key)
	local log = {tableSign = TableSign.End, type = "event", key = key}
	self:Add(log)
end

function FightLog:StartSub(key)
	local log = {tableSign = TableSign.Begin, type =  "sub", key = key}
	self:Add(log)
end

function FightLog:EndSub(key)
	local log = {tableSign = TableSign.End, type =  "sub", key = key}
	self:Add(log)
end

function FightLog:Alter(key, val)
	local log = {tableSign = TableSign.Alter, val = val, key = key}
	self:Add(log)
end

function FightLog:Get()
	--LogTable(self.log)
	local log = {}
	self.currtable = log
	for i,v in ipairs(self.log) do
		--LogTable(v, i.."=")
		if v.tableSign == TableSign.Begin then
			self:Push()
		elseif v.tableSign == TableSign.End then
			local t = self:Pop()
			if v.type == "sub" then
				local len = #self.currtable
				local last = self.currtable[len] or self.currtable
				if #t > 0 then
					last[v.key] = t
				else
					if len > 0 then
						local size = table.size(self.currtable[len])
						if size <= 1 and last.api then
							-- 这是个空的api日志,没有任何操作,直接去掉
							--LogTable(self.currtable[len], "这个小于一个 =")
							self.currtable[len] = nil
						end
					end
				end
			elseif v.type == "item" then
				if #t > 0 then
					table.insert(self.currtable, t)
				end
			end

		elseif v.tableSign == TableSign.Alter then
			local len = #self.currtable
			local last = self.currtable[len] or self.currtable
			last[v.key] = v.val
		else
			table.insert(self.currtable, v)
		end
	end

	return log
end

function FightLog:GetAndClean()
	local log = self:Get()
	-- LogTrace()
	-- LogTable(self.log, "ff9977 self.log=")
	-- LogTable(log, "GetAndClean ff9977 log=")
	if g_FightMgr then
		local card = g_FightMgr.currTurn
		-- if not card then return end
		if card and not table.empty(log) then
			table.insert(card.tmpPrintLog, log)
		end
	end
	self:Clean()
	return log
end

function FightLog:Push()
	if self.currtable then
		table.insert(self.logStack, self.currtable)
	end

	self.currtable = {}
	-- LogTable(self.currtable)
end

function FightLog:Pop()
	local currtable = self.currtable
	local len = #self.logStack
	if  len > 0 then 
		self.currtable = self.logStack[len]
		-- LogTable(self.currtable, "FightLog:Pop()")
		self.logStack[len] = nil
	end
	-- LogTable(currtable, "FightLog:Pop()")
	return currtable
end

-- local log = FightLog()

-- log:Add({a= "a"})
-- log:Add({b= "a"})
-- log:Add({c= "a"})
-- log:StartSub("crit")
-- log:Add({ra = "a"})
-- log:Add({rb = "a"})
-- log:StartSub("die")
-- log:Add({da = "a"})
-- log:Add({db = "a"})
-- log:Add({dc = "a"})
-- log:EndSub("die")
-- log:Add({rc = "a"})
-- log:EndSub("crit")
-- log:Alter("team", 100)
-- log:Add({d= "a"})
-- log:Add({e= "a"})
-- log:Add({f= "a"})

-- LogDebug("-------------------------")
-- local t = log:Get()
-- LogTable(t)
-- LogTable(t[3].crit)
