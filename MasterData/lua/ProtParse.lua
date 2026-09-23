-- 协议解析类
-- 协议构造格式(类似protobuf) 构造： index 位置+ 数据  线性结构

-- index-value 协议
IVProto = {}
local tmpBuffer = MsgBuffer()
local buffer = MsgBuffer()

-- 拆包,包格式[长度(16bit)+协议号(16bit)+包体]
function IVProto:Decoder(data)

	buffer:Clear()
	buffer:SetData(data)
	local bufflen = buffer:ReadUInt16()
	local cmdNo = buffer:ReadUInt16()
	-- local sn = buffer:ReadUInt64()
    --LogDebugEx(bufflen, cmdNo, GMsgKey[cmdNo])
	self._hasError = false
	local data, err = self:parseArray(cmdNo , buffer)
	if err then
		--trace("解包数据出错 ： " , data)
	end

	return cmdNo, GMsgKey[cmdNo], data, sn, bufflen
end

-- 协议数据结构：
-- 包头【协议号+长度】
-- index索引位置，数据，索引位置，数据....
function IVProto:parseArray(cmdNo, buffer)

	if buffer:Size() <= 0 then
		return nil
	end

	--print(GMsgKey[cmdNo])
	local struts = GameMsg:Get(cmdNo) 
	local temp = struts[1]
	local nameArr = struts[2]
	if not temp then return nil end

	local result = {}
	local len = 1
	-- if cmdNo ~= GMsgNo.M1026 then 
		len = buffer:ReadUInt8()
	-- else 
	-- 	len = 2
	-- end

	local index = 0
	for i=1,len do
		--print("parseArray", GMsgKey[cmdNo], len, i)

		-- if cmdNo == GMsgNo.M1026 then
		-- 	index = i
		-- else
			index = buffer:ReadUInt8()+1
		-- end
		local typeV = temp[index]
		local nameV = nameArr[index]
		if typeV then
			if typeV[1] == MsgType.Normal then
				--print("parseArray ,,, ", nameV)
				result[nameV] = self:switchDecoder(typeV[2] , buffer)
			elseif typeV[1] == MsgType.List then
				local numId = typeV[2]
				local list = result[nameV]
				if not list then list = {} end 
				--继续读取结构体相关数据
				local len2 = buffer:ReadUInt16()	
				for j=1,len2 do
					--结构体number 
					list[j] = self:parseArray(numId , buffer)
				end

				result[nameV] = list					
			elseif typeV[1] == MsgType.Struts then
				result[nameV] = self:parseArray(typeV[2] , buffer)
			elseif typeV[1] == MsgType.Array then	
				-- print("decodeList", GMsgKey[cmdNo])
				result[nameV] =  self:decodeList(typeV[2] , buffer)
			elseif typeV[1] == MsgType.Map then	
				local numId = typeV[2]
				local mapKey = typeV[3]
				local list = result[nameV]
				if not list then list = {} end 
				--继续读取结构体相关数据
				local len2 = buffer:ReadUInt8()	
				for j=1,len2 do
					--结构体number 
					local temp = self:parseArray(numId , buffer)
					list[temp[mapKey]] = temp
				end

				result[nameV] = list		
			end
		else
			--LogDebugEx("解包出错： 协议号：" , cmdNo , " ， 结构体号： " , cmdNo  , "Len :" , len , "第几个:", i ,  "错误Index ： ", index )
			--LogDebugEx("数据： ", result)
			--LogTrace()
			self._hasError = true
			--return
		end
		-- DT(result, "result2 = ")
	end
	return result, self._hasError
end

-- * 解析列表数据
function IVProto:decodeList(typeId, buffer)
	--LogDebugEx("IVProto:decodeList", typeId)
	local data = {}
	local listLen = buffer:ReadUInt16()

	if typeId == MsgNo.int8 then
		for i=1,listLen do
			table.insert(data, buffer:ReadUInt8())
		end
	elseif typeId == MsgNo.int16 then
		for i=1,listLen do
			table.insert(data, buffer:ReadInt16())
		end
	elseif typeId == MsgNo.uint16 then
		for i=1,listLen do
			table.insert(data, buffer:ReadUInt16())
		end		
	elseif typeId == MsgNo.int32 then
		for i=1,listLen do
			table.insert(data, buffer:ReadInt32())
		end
	elseif typeId == MsgNo.uint32 then
		for i=1,listLen do
			table.insert(data, buffer:ReadUInt32())
		end
	elseif typeId == MsgNo.string then
		-- print(listLen)
		for i=1,listLen do
			local str = buffer:ReadString() or ""
			table.insert(data, str)	
		end	
	elseif typeId == MsgNo.float then
		for i=1,listLen do
			table.insert(data, buffer:ReadFloat())	
		end			
	elseif typeId == MsgNo.double then
		for i = 1, listLen do
			table.insert(data, buffer:ReadDouble())
		end	
	elseif typeId == MsgNo.int64 then
		for i=1,listLen do
			table.insert(data, buffer:ReadUInt64())
		end
	elseif typeId == MsgNo.json then
		--LogDebugEx("------------------",listLen)
		for i=1,listLen do
			local str = buffer:ReadString() or "{}"
			table.insert(data, table.Decode(str))	
		end	
	end
	return data
end

--根据数据基础类型,提取字段内容
function IVProto:switchDecoder(typeId , buffer)
	--LogDebugEx("IVProto:switchDecoder", typeId)
	if not buffer then return end
	if typeId == MsgNo.int8 then
		return buffer:ReadUInt8()
	elseif typeId == MsgNo.int16 then
		return buffer:ReadInt16()
	elseif typeId == MsgNo.uint16 then
		return buffer:ReadUInt16()	
	elseif typeId == MsgNo.int32 then
		return buffer:ReadInt32()
	elseif typeId == MsgNo.uint32 then
		return buffer:ReadUInt32()	
	elseif typeId == MsgNo.string then
		return buffer:ReadString()
	elseif typeId == MsgNo.float then
		return buffer:ReadFloat()
	elseif typeId == MsgNo.double then
		return buffer:ReadDouble()
	elseif typeId == MsgNo.bool then
		return buffer:ReadBool()
	elseif typeId == MsgNo.int64 then
		return buffer:ReadUInt64()
	elseif typeId == MsgNo.json then
		return table.Decode(buffer:ReadString() or "{}") 
	end
end

-- 组包,结构：长度(2字节)+协议号(2字节)+sn(8字节)+包体
function IVProto:Encoder(cmd, data, sn)
	local cmdNo = GMsgNo[cmd]
	if not cmdNo then
		DT(data, cmd.." = ")
	end
	ASSERT(cmdNo)
	sn = sn or 0
	--A-1 构造包体数据
	tmpBuffer:Clear()
	buffer:Clear()
	self:encodeArray(cmdNo , tmpBuffer , data)
	buffer:WriteUInt16(tmpBuffer:Size() + 4)
	buffer:WriteUInt16(cmdNo)
	-- buffer:WriteUInt64(sn)
	if tmpBuffer:Size() > 0 then 
		buffer:Append(tmpBuffer:GetBuffer())
	end
	return buffer:GetBuffer(), buffer:Size()
end

function IVProto:ClientEncoder(cmd, data, sn)
	local cmdNo = GMsgNo[cmd]
	if not cmdNo then
		DT(data, cmd.." = ")
	end
	ASSERT(cmdNo)
	sn = sn or 0
	--A-1 构造包体数据
	tmpBuffer:Clear()
	buffer:Clear()
	self:encodeArray(cmdNo , tmpBuffer , data)
	buffer:WriteUInt16(tmpBuffer:Size() + 4)
	buffer:WriteUInt16(cmdNo)
	-- buffer:WriteUInt64(sn)
	if tmpBuffer:Size() > 0 then 
		buffer:AppendBuffer(tmpBuffer.buffer)
	end
	return buffer
end

-- 将字符串key转化为数字key
function IVProto:FormatKey(nameArr , data)
	-- DT(data, "data")
	local num = 0
	local tmp = {}
	for k,v in ipairs(nameArr) do
		if data[v] ~= nil then
			tmp[k] = data[v]
			num = num + 1
		end
	end
	-- DT(tmp, "IVProto:FormatKey tmp")
	return tmp, num
end

function IVProto:encodeArray(cmdNo , tmpBuffer , data)
	-- LogDebug("encodeArray:%s", GMsgKey[cmdNo])
	-- DT(data, "cmdNo = "..cmdNo)
	local struts = GameMsg:Get(cmdNo)
	if not struts then
		LogError("IVProto:encodeArray %s get nil", cmdNo)
		return
	end

	local temp = struts[1]
	local nameArr = struts[2]
	-- DT(temp, "temp")
	-- DT(nameArr, "nameArr")
	if not temp then return nil end

	local len = #temp
	local data, num = self:FormatKey(nameArr, data)
	tmpBuffer:WriteUInt8(num)
	-- LogDebugEx("-----------", data, num, len)

	for i=1,len do
		-- LogDebugEx("encodeArray----", GMsgKey[cmdNo] , len, i)
		if temp[i] ~= nil and data[i] ~= nil then
			tmpBuffer:WriteUInt8(i-1)
			local typeV = temp[i]
			
			if typeV[1] == MsgType.Normal then
				--基础类型
				self:switchEncoder(typeV[2], data[i] , tmpBuffer) 
			elseif typeV[1] == MsgType.List then
				local numId = typeV[2]
				--结构体数据信息  
				local len2 = #(data[i])
				tmpBuffer:WriteUInt16(len2)
				for j=1,len2 do
					--LogDebugEx("encodeArray List = ", GMsgKey[numId], len2, j)
					--LogTable(data[i][j])
					self:encodeArray(numId , tmpBuffer , data[i][j])
				end			
			elseif typeV[1] == MsgType.Struts then
				local numId = typeV[2]
				self:encodeArray(numId , tmpBuffer , data[i])
			elseif typeV[1] == MsgType.Array then
				--LogDebugEx("``````------", typeV[1], typeV[2], data[i])
				local numId = typeV[2]
				local len3 = #(data[i])
				tmpBuffer:WriteUInt16(len3)
				for k=1,len3 do
					self:switchEncoder(numId , data[i][k] , tmpBuffer)
				end
			elseif typeV[1] == MsgType.Map then

				-- LogTable(data[i], "MapData=")
				local numId = typeV[2]
				local mapKey = typeV[3]
				local temp = {}
				for k,v in pairs(data[i]) do
					if type(v) == "table" and v[mapKey] then
						table.insert(temp, v)
					end
				end
				-- LogTable(temp, "-----")
				local len3 = #temp
				ASSERT(len3<127, "map too long")
				-- LogDebugEx("encodeArray Map = ", GMsgKey[numId], len3, j)
				tmpBuffer:WriteUInt8(len3)
				for k=1,len3 do
					-- LogTable(temp[k], "temp"..k)
					self:encodeArray(numId , tmpBuffer , temp[k])
				end
			else
				LogTrace()
				LogDebug("-------typeV[1]:%s------", typeV[1])
			end
		end
	end	
end

function IVProto:switchEncoder(typeId, data, tmpBuffer)
	-- LogDebug("IVProto:switchEncoder %s %s",typeId, data)
	if not tmpBuffer then return end
	if typeId == MsgNo.int8 then
		tmpBuffer:WriteUInt8(data)
	elseif typeId == MsgNo.int16 then
		tmpBuffer:WriteInt16(data)
	elseif typeId == MsgNo.uint16 then
		tmpBuffer:WriteUInt16(data)	
	elseif typeId == MsgNo.int32 then
		tmpBuffer:WriteInt32(data)
	elseif typeId == MsgNo.uint32 then
		tmpBuffer:WriteUInt32(data)	
	elseif typeId == MsgNo.string then
		tmpBuffer:WriteString(data)
	elseif typeId == MsgNo.float then
		tmpBuffer:WriteFloat(data)
	elseif typeId == MsgNo.double then
		tmpBuffer:WriteDouble(data)
	elseif typeId == MsgNo.bool then
		tmpBuffer:WriteBool(data)
	elseif typeId == MsgNo.int64 then
		tmpBuffer:WriteUInt64(data)
	elseif typeId == MsgNo.json then
		if type(data) == "table" then
			tmpBuffer:WriteString(table.Encode(data))
		else
			LogDebugEx("not table to call table.encode", data)
			ASSERT()
		end
	end
end
