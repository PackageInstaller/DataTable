--数据类型
MsgType = {}
MsgType.Normal	= 0 -- 普通类型
MsgType.Struts	= 1 -- 结构体
MsgType.List	= 2 -- 结构体数组
MsgType.Array	= 3 -- 普通类型数组
MsgType.Map		= 4 -- 普通类型数组

MsgNo = {}
MsgNo.bool		= "bool";         -- 1个字节长度
MsgNo.string	= "string";       -- 格式:长度(2字节)+内容
MsgNo.int8		= "byte";         -- 1个字节长度(值>=0)
MsgNo.int16		= "short";        -- 2个字节长度
MsgNo.uint16	= "ushort";       -- 2个字节长度(值>=0)
MsgNo.int32		= "int";          -- 4个字节长度
MsgNo.uint32	= "uint";         -- 4个字节长度(值>=0)
MsgNo.int64		= "long";         -- 8个字节长度(值>=0)
MsgNo.float		= "float";        -- 4个字节长度
MsgNo.double	= "double";       -- 8个字节长度
MsgNo.json		= "json";         -- json字符串

function GameMsg:Get(cmdNo)
	local cmd = GMsgKey[cmdNo]
	-- LogDebugEx("GameMsg:Get",cmd)
	return GameMsg.map[cmd]
end

function GameMsg:Init()
	for k,v in pairs(self.map) do
		for i,sType in ipairs(v[1]) do
			-- print(k, i)
			-- DT(v[1][i])
			local n = string.find(sType, "|")
			if n == nil then 
				v[1][i] = {MsgType.Normal, sType}
			else
				v[1][i] = SplipLine(sType, "|")
				--DT(v)
				if v[1][i][1] == "array" then
					v[1][i][1] = MsgType.Array
					--v[1][i][2] = tonumber(v[1][i][2])
				elseif v[1][i][1] == "list" then
					v[1][i][1] = MsgType.List
					v[1][i][2] = GMsgNo[v[1][i][2]]
				elseif v[1][i][1] == "struts" then	
					v[1][i][1] = MsgType.Struts
					v[1][i][2] = GMsgNo[v[1][i][2]]
				elseif v[1][i][1] == "map" then	
					v[1][i][1] = MsgType.Map
					v[1][i][2] = GMsgNo[v[1][i][2]]	
					v[1][i][3] = v[1][i][3]
				else
					LogDebugEx(k, i)
					DT(v[1][i])
					ASSERT()
				end
			end
		end
	end
end

-- GMsgNo.M1029 = 1029
-- GameMsg.map[GMsgNo.M1029] = {
-- 	{"I32","I16","I8","I64","B","S","F32","struts|1","list|1","array|I8"},
-- 	{"num32" ,"num16" ,"num8" ,"num64" ,"boo" ,"str" ,"flo" ,"strc" ,"strca" ,"arr"}
-- }

-- GMsgNo.Item = 1029
-- GMsgKey[1029]="Item"		-- 测试协议
-- GameMsg.map["Item"] = {
-- 	{"int32","int16"},
-- 	{"id" ,"num"}
-- }

-- GMsgNo.ItemList = 1030
-- GMsgKey[1030]="ItemList"		-- 测试协议
-- GameMsg.map["ItemList"] = {
-- 	{"list|Item"},
-- 	{"data" }
-- }

GameMsg:Init()
-- MsgBuffer = oo.class(Buffer)

-- DT(GameMsg.map)
-- ASSERT()
local t = {}
t.num32 = 322222
t.num16 = 1616
t.num8 = 100
t.num64 = 6400000000
t.boo = true
t.flo = 1.5
t.str = "aaa中文bbbb"
t.arr = {2,3,4,5,6}
t.strc = {x=1 , y=100}
t.strca = {
	{x=1 , y=100}, 
	{x=1 , y=100},
	{x=1 , y=100}
}

--DT(t)
-- print("--------------------------------")
-- t1 = GameApp:GetTickCount()
-- local msg = IVProto:Encoder("Test", t)
-- for i=1,100000 do
-- 	local msg = IVProto:Encoder("Test", t)
-- end

-- t2 = GameApp:GetTickCount()
-- print("length = ", #msg)

-- for i=1,100000 do
-- 	local cmdNo, data, bufflen = IVProto:Decoder(msg)
-- end
-- t3 = GameApp:GetTickCount()
-- local cmdNo, data, bufflen = IVProto:Decoder(msg)
-- DT(data)
-- print("333333333333333333333333333", cmdNo, data, bufflen)
-- print("IV协议耗时", t2 - t1, t3 - t2)

-- print("--------------------------------")
-- t1 = GameApp:GetTickCount()
-- local msg = Json.Encode(t)
-- for i=1,100000 do
-- 	local msg = Json.Encode(t)
-- end

-- t2 = GameApp:GetTickCount()
-- print("length = ", #msg)

-- for i=1,100000 do
-- 	local t = Json.Decode(msg)
-- end
-- t3 = GameApp:GetTickCount()
-- print("--------------------------------")
-- -- DT(data)
-- print("Json耗时", t2 - t1, t3 - t2)
-- ASSERT()


-- -- 测试map类型
-- local t = {}
-- for i=1,10 do
-- 	t[1000 + i] = {type = 1000 + i, param = "index_"..i}
-- end

-- local msg = IVProto:Encoder("SystemProto:TestMap", {map=t})
-- print("length = ", #msg)
-- local cmdNo, data, bufflen = IVProto:Decoder(msg)
-- DT(data,"SystemProto:TestMap = ")
-- print("333333333333333333333333333", cmdNo, data, bufflen)

-- ASSERT()