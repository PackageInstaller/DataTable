local var_0_0 = {}
local var_0_1 = {
	TwisteggLayer = {
		"TwistEgg.plist",
		"spine/ui/twist/fangkuai.json",
		"spine/ui/twist/fangkuai.atlas",
		"spine/ui/twist/fangkuai.png",
		"spine/ui/twist/twist.json",
		"spine/ui/twist/twist.atlas",
		"spine/ui/twist/twist.png",
		"spine/ui/twist/twist2.png",
		"spine/ui/twist/twist3.png",
		"spine/ui/twist/twist4.png",
		"spine/ui/twist/twist5.png"
	},
	AITwistLayer = {
		"TwistEgg.plist",
		"spine/ui/twist/fangkuai.json",
		"spine/ui/twist/fangkuai.atlas",
		"spine/ui/twist/fangkuai.png",
		"spine/ui/twist/twist.json",
		"spine/ui/twist/twist.atlas",
		"spine/ui/twist/twist.png",
		"spine/ui/twist/twist2.png",
		"spine/ui/twist/twist3.png",
		"spine/ui/twist/twist4.png",
		"spine/ui/twist/twist5.png"
	},
	SkinTwisteggLayer = {
		"TwistEgg.plist",
		"spine/ui/twist/fangkuai.json",
		"spine/ui/twist/fangkuai.atlas",
		"spine/ui/twist/fangkuai.png",
		"spine/ui/twist/twist.json",
		"spine/ui/twist/twist.atlas",
		"spine/ui/twist/twist.png",
		"spine/ui/twist/twist2.png",
		"spine/ui/twist/twist3.png",
		"spine/ui/twist/twist4.png",
		"spine/ui/twist/twist5.png"
	},
	ActivityWideWakeLayer = {
		"ActivityWideWakeLayer.plist",
		"MarketLayer.plist",
		"TwistEgg.plist",
		"spine/ui/twist/fangkuai.json",
		"spine/ui/twist/fangkuai.atlas",
		"spine/ui/twist/fangkuai.png",
		"spine/ui/twist/twist.atlas",
		"spine/ui/twist/twist.json",
		"spine/ui/twist/twist.png",
		"spine/ui/twist/twist2.png",
		"spine/ui/twist/twist3.png",
		"spine/ui/twist/twist4.png",
		"spine/ui/twist/twist5.png"
	},
	DormitoryLayer = {
		"Dormitory.plist"
	},
	PhotoMemoryLayer = {
		"Photo0.plist",
		"Photo1.plist"
	},
	PhotoFileLayer = {
		"Photo0.plist",
		"Photo1.plist"
	},
	PhotoGoodsLayer = {
		"Photo0.plist",
		"Photo1.plist"
	}
}

function var_0_0.getLoadTexturesNum(arg_1_0, arg_1_1)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in ipairs(var_0_1[arg_1_1]) do
		if not iter_1_1:find(".json") and not iter_1_1:find(".atlas") then
			var_1_0 = var_1_0 + 1
		end
	end

	return var_1_0
end

function var_0_0.getLoadTexturesList(arg_2_0, arg_2_1)
	return var_0_1[arg_2_1]
end

function var_0_0.removeCachedTextured(arg_3_0, arg_3_1)
	if config._DEBUG then
		for iter_3_0, iter_3_1 in pairs(var_0_1[arg_3_1]) do
			if iter_3_1:find(".png") then
				cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_3_1)
			end
		end
	else
		for iter_3_2, iter_3_3 in pairs(var_0_1[arg_3_1]) do
			if iter_3_3:find(".png") then
				cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_3_3)
			elseif iter_3_3:find(".plist") then
				cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(iter_3_3)
				cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_3_3:match("(.+).plist") .. ".png")
			end
		end
	end
end

function var_0_0.startLoad(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = var_0_0:getLoadTexturesNum(arg_4_1)
	local var_4_1 = var_4_0
	local var_4_2
	local var_4_3 = false

	var_4_2 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_5_0)
		if var_4_3 and var_4_0 <= 0 then
			if arg_4_3 then
				arg_4_3()
			end

			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_4_2)

			var_4_2 = nil
		end

		if arg_4_2 then
			arg_4_2(var_4_0 / var_4_1)
		end
	end, 0.1, false)

	;(function()
		var_4_3 = true

		if config._DEBUG then
			var_4_0 = 0
		else
			for iter_6_0, iter_6_1 in pairs((var_0_0:getLoadTexturesList(arg_4_1))) do
				local var_6_0

				if iter_6_1:find(".png") then
					var_6_0 = iter_6_1
				elseif iter_6_1:find(".plist") then
					var_6_0 = iter_6_1:match("(.+).plist") .. ".png"
				end

				cc.Director:getInstance():getTextureCache():addImageAsync(var_6_0, function()
					if iter_6_1:find(".plist") then
						cc.SpriteFrameCache:getInstance():addSpriteFrames(iter_6_1)
					end

					var_4_0 = var_4_0 - 1
				end)
			end
		end
	end)()
end

local file_check_manager = require("controller.filedownloader.file_check_manager")

function var_0_0:startLoadingTextures(arg_8_1, arg_8_2)
	self._layername = arg_8_1
	self._finishhandler = arg_8_2
	self._downloadlist = {}

	if config._DEBUG then
		self:loadingTextures()

		return
	end

	local var_8_0, var_8_1 = file_check_manager:checkFileNeedDownloadByList(self:generateTextureList(var_0_1[arg_8_1]))

	if var_8_0 then
		self:startDownload(var_8_1)
	else
		self:loadingTextures()
	end
end

function var_0_0.unregisterLoadingInfo(arg_9_0)
	arg_9_0._layername = nil
	arg_9_0._finishhandler = nil
	arg_9_0._downloadlist = {}
end

function var_0_0.generateTextureList(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if iter_10_1:find(".plist") then
			local var_10_1 = iter_10_1:match("(.+).plist")

			table.insert(var_10_0, "ui/" .. iter_10_1)
			table.insert(var_10_0, "ui/" .. var_10_1 .. ".png")
		else
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_0:startDownload(arg_11_1)
	self._downloadlist = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		self._downloadlist[iter_11_1.filename] = true
	end

	require("controller.filedownloader.download_manager"):insertDownloadTasks(arg_11_1)
end

function var_0_0:onDownloadComplete(arg_12_1)
	if self._downloadlist[arg_12_1] then
		self._downloadlist[arg_12_1] = nil

		if not next(self._downloadlist) then
			self:loadingTextures()
		end
	end
end

function var_0_0:loadingTextures()
	local var_13_0 = self:getLoadTexturesNum(self._layername)
	local var_13_1

	var_13_1 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_14_0)
		if var_13_0 <= 0 then
			if self._finishhandler then
				self._finishhandler()
			end

			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_13_1)

			var_13_1 = nil
		end
	end, 0.1, false)

	local var_13_2 = self:getLoadTexturesList(self._layername)

	if config._DEBUG then
		local var_13_3 = 0

		for iter_13_0, iter_13_1 in ipairs(var_13_2) do
			if iter_13_1:find(".png") then
				var_13_3 = var_13_3 + 1

				cc.Director:getInstance():getTextureCache():addImageAsync(iter_13_1, function()
					var_13_0 = var_13_0 - 1
				end)
			end
		end

		var_13_0 = var_13_3
	else
		for iter_13_2, iter_13_3 in pairs(var_13_2) do
			local var_13_4

			if iter_13_3:find(".png") then
				var_13_4 = iter_13_3
			elseif iter_13_3:find(".plist") then
				var_13_4 = iter_13_3:match("(.+).plist") .. ".png"
			end

			if var_13_4 then
				cc.Director:getInstance():getTextureCache():addImageAsync(var_13_4, function()
					if iter_13_3:find(".plist") then
						cc.SpriteFrameCache:getInstance():addSpriteFrames(iter_13_3)
					end

					var_13_0 = var_13_0 - 1
				end)
			end
		end
	end
end

return var_0_0
