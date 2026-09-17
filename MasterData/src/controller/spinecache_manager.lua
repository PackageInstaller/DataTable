local spinecachedata = class("spinecachedata")

function spinecachedata:ctor(arg_1_1, arg_1_2, arg_1_3)
	self.data = arg_1_3 and sp.SkeletonData:create(arg_1_1, arg_1_2, 1, arg_1_3) or sp.SkeletonData:create(arg_1_1, arg_1_2, 1)
	self.referencecount = 0
end

function spinecachedata:retain(arg_2_1)
	arg_2_1 = arg_2_1 or 1
	self.referencecount = self.referencecount + arg_2_1
end

function spinecachedata:release(arg_3_1)
	arg_3_1 = arg_3_1 or 1

	assert(arg_3_1 <= self.referencecount, "spinecache referencecount should greater than 0")

	self.referencecount = self.referencecount - arg_3_1
end

function spinecachedata:getReferenceCount()
	return self.referencecount
end

function spinecachedata:getData()
	return self.data
end

function spinecachedata:collect()
	self.data:collect()
end

local var_0_1 = {}
local var_0_2 = {}

local function var_0_3(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		if type(arg_7_1) == "table" then
			return arg_7_0 .. arg_7_1.attachmentName .. arg_7_1.fileName
		else
			return arg_7_0 .. arg_7_1
		end
	elseif arg_7_2 then
		return arg_7_0 .. arg_7_2
	else
		return arg_7_0
	end
end

local function var_0_4(arg_8_0, arg_8_1, arg_8_2)
	return (spinecachedata.new(arg_8_0, arg_8_1, arg_8_2))
end

function var_0_1.addSpineData(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = var_0_3(arg_9_1, arg_9_3, arg_9_4)

	if var_0_2[var_9_0] then
		return var_0_2[var_9_0]
	else
		var_0_2[var_9_0] = var_0_4(arg_9_1, arg_9_2, arg_9_3)

		return var_0_2[var_9_0]
	end
end

function var_0_1.removeSpineDataForKey(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not arg_10_1 then
		return
	end

	local var_10_0 = var_0_3(arg_10_1, arg_10_3)

	if var_0_2[var_10_0] and var_0_2[var_10_0]:getReferenceCount() == 0 then
		var_0_2[var_10_0]:collect()

		var_0_2[var_10_0] = nil
	end
end

function var_0_1.collectUnusedSpineCache(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(var_0_2) do
		if iter_11_1:getReferenceCount() == 0 then
			var_0_2[iter_11_0]:collect()

			var_0_2[iter_11_0] = nil
		end
	end
end

function var_0_1.loadSpineDataSync(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if not arg_12_1 then
		if arg_12_4 then
			arg_12_4()
		end

		return
	end

	local var_12_0 = var_0_3(arg_12_1, arg_12_3)

	if var_0_2[var_12_0] then
		if arg_12_4 then
			arg_12_4(var_0_2[var_12_0])
		end

		return
	end

	local function var_12_1()
		var_0_2[var_12_0] = var_0_2[var_12_0] or var_0_4(arg_12_1, arg_12_2, arg_12_3)

		if arg_12_4 then
			arg_12_4(var_0_2[var_12_0])
		end
	end

	local var_12_2 = sp.SkeletonData.getTextureFromAtlas(arg_12_2)
	local var_12_3 = #var_12_2
	local var_12_4 = 0

	for iter_12_0, iter_12_1 in pairs(var_12_2) do
		cc.Director:getInstance():getTextureCache():addImageAsync(iter_12_1, function()
			var_12_4 = var_12_4 + 1

			if var_12_4 >= var_12_3 then
				var_12_1()
			end
		end)
	end
end

function var_0_1:releaseSpineCacheTextures(arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_1 then
		return
	end

	self:removeSpineDataForKey(arg_15_1, arg_15_2, arg_15_3)

	for iter_15_0, iter_15_1 in pairs((sp.SkeletonData.getTextureFromAtlas(arg_15_2))) do
		cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_15_1)
	end
end

local var_0_5
local var_0_6

function var_0_1:removeShowGirlSpineCache(arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_1 then
		return
	end

	if arg_16_1 == var_0_5 then
		return
	end

	if arg_16_1 == var_0_6 then
		return
	end

	self:releaseSpineCacheTextures(arg_16_1, arg_16_2, arg_16_3)
end

function var_0_1.setNotRemoveShowGirlSpine(arg_17_0, arg_17_1)
	var_0_5 = arg_17_1
end

function var_0_1.setNotRemoveBGSpine(arg_18_0, arg_18_1)
	var_0_6 = arg_18_1
end

return var_0_1
