local var_0_0 = ccui.ImageView.create
local var_0_1 = ccui.ImageView.loadTexture
local download_node_utils = require("controller.filedownloader.download_node_utils")

local function var_0_3(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	var_0_1(arg_1_0, arg_1_1)

	if arg_1_0.afterLoadSuccess then
		arg_1_0:afterLoadSuccess(arg_1_1)
	end
end

local function var_0_4(arg_2_0)
	download_node_utils:addDownloadInterface(arg_2_0, "ImageView")

	arg_2_0.onDownloadComplete = var_0_3

	arg_2_0:initDownload()
end

function ccui.ImageView.create(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 then
		local var_3_0 = var_0_0(arg_3_0, arg_3_1, arg_3_2 or ccui.TextureResType.localType)

		var_3_0:setDownloadEnabled(false)

		return var_3_0
	end

	if arg_3_2 == ccui.TextureResType.plistType then
		return var_0_0(arg_3_0, arg_3_1, arg_3_2)
	else
		local var_3_1 = var_0_0(arg_3_0)

		var_0_4(var_3_1)

		if arg_3_1 then
			var_3_1:checkResource(arg_3_1)
		end

		return var_3_1
	end
end

function ccui.ImageView:loadTexture(arg_4_1, arg_4_2)
	if not self:isDownloadEnabled() then
		var_0_1(self, arg_4_1, arg_4_2 or ccui.TextureResType.localType)

		return
	end

	if arg_4_2 == ccui.TextureResType.plistType then
		var_0_1(self, arg_4_1, arg_4_2)
	else
		if not self._havedownloadapi then
			var_0_4(self)
		end

		if arg_4_1 then
			self:checkResource(arg_4_1)
		end
	end
end
