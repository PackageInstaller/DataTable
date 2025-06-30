local bitpc={}
function bitpc.__andBit(left,right)
	return (left==1 and right==1) and 1 or 0

end
function bitpc.__orBit(left,right)
	return (left==1 or right ==1) and 1 or 0
end
function bitpc.__xorBit(left,right)
	return (left+right) ==1 and 1 or 0
end
function bitpc.__base(left,right,op)
	if left <right then
		left,right= right,left
	end
	local res =0
	local shift =1
	while left ~=0 do
		local ra = left % 2
		local rb = right % 2
		res =shift * op(ra,rb)+res
		shift =shift *2
		left = math.modf(left/2)
		right = math.modf(right/2)
	end
	return res
end
function bitpc.andOp(left,right)
	return bitpc.__base(left,right,bitpc.__andBit)
end
function bitpc.xorOp(left,right)
	return bitpc.__base(left,right,bitpc.__xorBit)
end
function bitpc.orOp(left,right)
	return bitpc.__base(left,right,bitpc.__orBit)
end
function bitpc.notOp(left)
	return left >0 and -(left+1) or -left-1
end
function bitpc.lShiftOp(left,num)
	return left *(2^num)
end
function bitpc.rShiftOp(left,num)
	return math.floor(left/(2^num))
end

local function encodeBase64(source_str)
	local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	local s64 = ''
	local str = source_str

	while #str > 0 do
	local bytes_num = 0
	local buf = 0

	for byte_cnt=1,3 do
	buf = (buf * 256)
	if #str > 0 then
	buf = buf + string.byte(str, 1, 1)
	str = string.sub(str, 2)
	bytes_num = bytes_num + 1
	end
	end

	for group_cnt=1,(bytes_num+1) do
	local b64char = math.fmod(math.floor(buf/262144), 64) + 1
	s64 = s64 .. string.sub(b64chars, b64char, b64char)
	buf = buf * 64
	end

	for fill_cnt=1,(3-bytes_num) do
	s64 = s64 .. '='
	end
	end

	return s64
end

local function decodeBase64(str64)
	local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	local temp={}
	for i=1,64 do
	    temp[string.sub(b64chars,i,i)] = i
	end
	temp['=']=0
	local str=""
	for i=1,#str64,4 do
	if i>#str64 then
	   break
	end
	local data = 0
	local str_count=0
	  for j=0,3 do
	     local str1=string.sub(str64,i+j,i+j)
	     if not temp[str1] then
	      return
	     end
	     if temp[str1] < 1 then
	      data = data * 64
	     else
	      data = data * 64 + temp[str1]-1
	      str_count = str_count + 1
	     end
	  end
	   for j=16,0,-8 do
	       if str_count > 0 then
	          str=str..string.char(math.floor(data/math.pow(2,j)))
	          data=math.mod(data,math.pow(2,j))
	          str_count = str_count - 1
	       end
    	end
	end

	local last = tonumber(string.byte(str, string.len(str), string.len(str)))
	if last == 0 then
	str = string.sub(str, 1, string.len(str) - 1)
	end
	return str
end
JM={}
function JM.encrypt(key,text)
	local function KSA(key)
		local keyLen = string.len(key)
		local schedule = {}
		local keyByte = {}
		for i = 0, 255 do
			schedule[i] = i
		end
		for i = 1, keyLen do
			keyByte[i - 1] = string.byte(key, i, i)
		end
		local j = 0
		for i = 0, 255 do
			j = (j + schedule[i] + keyByte[i % keyLen]) % 256
			schedule[i], schedule[j] = schedule[j], schedule[i]
		end
		return schedule
	end
	local function PRGA(schedule, textLen)
		local i = 0
		local j = 0
		local k = {}
		for n = 1, textLen do
			i = (i + 1) % 256
			j = (j + schedule[i]) % 256
			schedule[i], schedule[j] = schedule[j], schedule[i]
			k[n] = schedule[(schedule[i] + schedule[j]) % 256]
		end
		return k
	end
	local function output(schedule, text)
		local len = string.len(text)
		local c = nil
		local res = {}
		for i = 1, len do
			c = string.byte(text, i, i)
			res[i] = string.char(bitpc.xorOp(schedule[i], c))
		end
		return table.concat(res)
	end
	local textLen = string.len(text)
	local schedule = KSA(key)
	local k = PRGA(schedule, textLen)
	return encodeBase64(output(k, text))
end