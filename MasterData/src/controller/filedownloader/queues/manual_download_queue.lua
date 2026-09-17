local manual_download_queue = class("manual_download_queue")
local var_0_1 = table
local var_0_2 = math.min

function manual_download_queue:ctor()
	self._list = {}
	self._hash = {}
	self._filetags = {}
end

function manual_download_queue:find(arg_2_1)
	return self._hash[arg_2_1.filename]
end

function manual_download_queue:insert(...)
	local var_3_0 = {
		...
	}

	if #var_3_0 == 1 then
		var_0_1.insert(self._list, var_3_0[1])

		self._hash[var_3_0[1].filename] = #self._list
	elseif #var_3_0 == 2 then
		local var_3_1 = var_0_2(#self._list + 1, var_3_0[1])

		var_0_1.insert(self._list, var_3_1, var_3_0[2])

		for iter_3_0 = var_3_1, #self._list do
			self._hash[self._list[iter_3_0].filename] = iter_3_0
		end
	end
end

function manual_download_queue:add(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = self:count()
	local var_4_1 = self:find(arg_4_1)

	if var_4_1 then
		arg_4_2 = arg_4_2 or var_4_0
		arg_4_2 = var_0_2(arg_4_2, var_4_0)

		self:move(var_4_1, arg_4_2)
	else
		arg_4_2 = arg_4_2 or var_4_0 + 1

		self:insert(arg_4_2, arg_4_1)
	end

	self._filetags[arg_4_1.filename] = arg_4_3
end

function manual_download_queue:removeFromIndex(arg_5_1)
	local var_5_0 = var_0_1.remove(self._list, arg_5_1)

	if var_5_0 then
		self._hash[var_5_0.filename] = nil

		for iter_5_0 = arg_5_1, #self._list do
			self._hash[self._list[iter_5_0].filename] = iter_5_0
		end

		self._filetags[var_5_0.filename] = nil
	end

	return var_5_0
end

function manual_download_queue:removeFromEnd()
	if self._list[#self._list] then
		self._hash[self._list[#self._list].filename] = nil
		self._filetags[self._list[#self._list].filename] = nil
		self._list[#self._list] = nil
	end

	return self._list[#self._list]
end

function manual_download_queue:remove(arg_7_1)
	if arg_7_1 then
		return self:removeFromIndex(arg_7_1)
	else
		return self:removeFromEnd()
	end
end

local function var_0_4(arg_8_0, arg_8_1, arg_8_2)
	while arg_8_1 < arg_8_2 do
		arg_8_0[arg_8_1], arg_8_0[arg_8_2] = arg_8_0[arg_8_2], arg_8_0[arg_8_1]
		arg_8_1 = arg_8_1 + 1
		arg_8_2 = arg_8_2 - 1
	end
end

function manual_download_queue:move(arg_9_1, arg_9_2)
	if arg_9_1 == arg_9_2 then
		return
	end

	if arg_9_1 < arg_9_2 then
		var_0_4(self._list, arg_9_1 + 1, arg_9_2)
	else
		var_0_4(self._list, arg_9_1, arg_9_2 - 1)
	end

	var_0_4(self._list, arg_9_1, arg_9_2)

	for iter_9_0 = arg_9_1, arg_9_2 do
		self._hash[self._list[iter_9_0].filename] = iter_9_0
	end
end

function manual_download_queue:clear()
	self._hash = {}
	self._list = {}
	self._filetags = {}
end

function manual_download_queue:count()
	return #self._list
end

function manual_download_queue:query(arg_12_1)
	return self._list[arg_12_1]
end

function manual_download_queue:queryAll()
	return self._list
end

local function var_0_5(arg_14_0, arg_14_1)
	if arg_14_0.filtertype == "include" then
		return arg_14_1 and arg_14_0.filters[arg_14_1]
	elseif arg_14_0.filtertype == "besides" then
		return not arg_14_1 or not arg_14_0.filters[arg_14_1]
	end

	return false
end

function manual_download_queue:queryWithFilter(arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(self._list) do
		if var_0_5(arg_15_1, self._filetags[iter_15_1.filename]) then
			var_0_1.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

function manual_download_queue:clearWithFilter(arg_16_1)
	while self._list[1] do
		local var_16_0

		if var_0_5(arg_16_1, self._filetags[self._list[1].filename]) then
			self:remove(1)
		else
			var_16_0 = 1 + 1
		end
	end
end

function manual_download_queue:onFileDownloadComplete(arg_17_1)
	if not self._hash[arg_17_1] then
		return
	end

	self:remove(self._hash[arg_17_1])
end

return manual_download_queue
