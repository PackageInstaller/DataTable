local auto_download_queue = class("auto_download_queue")
local var_0_1 = table

function auto_download_queue:ctor()
	self._list = {}
	self._hash = {}
	self._filesize = {}
	self._totalsize = 0
	self._downloadedsize = 0
end

function auto_download_queue:insert(arg_2_1)
	var_0_1.insert(self._list, arg_2_1)

	self._hash[arg_2_1.filename] = #self._list
	self._filesize[arg_2_1.filename] = arg_2_1.size
	self._totalsize = self._totalsize + arg_2_1.size
end

function auto_download_queue:add(arg_3_1)
	self:insert(arg_3_1)
end

function auto_download_queue:removeFromEnd()
	local var_4_0

	repeat
		var_4_0 = self._list[#self._list]
		self._list[#self._list] = nil
	until var_4_0 ~= 0

	if var_4_0 then
		self._hash[var_4_0.filename] = nil
	end

	return var_4_0
end

function auto_download_queue:remove()
	return self:removeFromEnd()
end

function auto_download_queue:delete(arg_6_1)
	self._list[self._hash[arg_6_1]] = 0
	self._hash[arg_6_1] = nil
end

function auto_download_queue:count()
	return #self._list
end

function auto_download_queue:query(arg_8_1)
	return self._list[arg_8_1]
end

function auto_download_queue:queryAll()
	return self._list
end

function auto_download_queue:getTotalSize()
	return self._totalsize
end

function auto_download_queue:getDownloadedSize()
	return self._downloadedsize
end

function auto_download_queue:clear()
	self._list = {}
	self._hash = {}
	self._filesize = {}
	self._totalsize = 0
	self._downloadedsize = 0
end

function auto_download_queue:onFileDownloadComplete(arg_13_1)
	if not self._filesize[arg_13_1] then
		return
	end

	self._downloadedsize = self._downloadedsize + self._filesize[arg_13_1]
	self._filesize[arg_13_1] = nil

	if self._hash[arg_13_1] then
		self:delete(arg_13_1)
	end
end

return auto_download_queue
