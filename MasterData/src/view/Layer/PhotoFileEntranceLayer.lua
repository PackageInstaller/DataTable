PhotoFileEntranceLayer = class("PhotoFileEntranceLayer", function()
	return cc.Layer:create()
end)

local photofile_all_data = require("data.photofile_all_data")

function PhotoFileEntranceLayer.create(arg_2_0)
	local var_2_0 = PhotoFileEntranceLayer.new()

	var_2_0:init()

	return var_2_0
end

local var_0_1 = {
	"college",
	"ai",
	"army",
	"foundation",
	"killer"
}

function PhotoFileEntranceLayer.fullScreen(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:setContentSize(GameDisplay.getScreenSize())
	arg_3_1:setPositionY(arg_3_1:getPositionY() - GameDisplay.fix_y)
	arg_3_2:setPositionY(GameDisplay.getUiScreenSize().height / 2)
end

function PhotoFileEntranceLayer:init()
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PhotoFile_entrance.json" or "PhotoFile_entrance.ExportJson")

	self:addChild(self.rootlayer)

	self.bg = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	local var_4_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self.image_bottom = var_4_0

	global_window_open_action(var_4_0)
	self.bg:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(var_4_0, function()
			LayerManager:removePopLayer()
		end)
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			-- block empty
		end
	end)
	self:getBtn()
	self:setBtn()
	self:fullScreen(self.bg, var_4_0)
end

function PhotoFileEntranceLayer:getBtn()
	self.btnTable = {}

	for iter_8_0 = 1, #photofile_all_data do
		self.btnTable[iter_8_0] = ccui.Helper:seekWidgetByName(self.rootlayer, "Image" .. iter_8_0)
	end
end

function PhotoFileEntranceLayer:setBtn()
	for iter_9_0 = 1, #self.btnTable do
		self.btnTable[iter_9_0]:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 == ccui.TouchEventType.began then
				local var_10_0 = arg_10_0:convertToNodeSpace((arg_10_0:getTouchBeganPosition()))

				if var_10_0.y < -var_10_0.x + 92 then
					return
				end

				if var_10_0.y < var_10_0.x - 92 then
					return
				end

				if var_10_0.y > var_10_0.x + 92 then
					return
				end

				if var_10_0.y > -var_10_0.x + 276 then
					return
				end

				arg_10_0:setScale(1.2)
			elseif arg_10_1 == ccui.TouchEventType.canceled then
				self:stopAllActions()
				arg_10_0:setScale(1)
			elseif arg_10_1 == ccui.TouchEventType.ended then
				arg_10_0:setScale(1)
			end

			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_10_1 = arg_10_0:convertToNodeSpace((arg_10_0:getTouchBeganPosition()))

			if var_10_1.y < -var_10_1.x + 92 then
				return
			end

			if var_10_1.y < var_10_1.x - 92 then
				return
			end

			if var_10_1.y > var_10_1.x + 92 then
				return
			end

			if var_10_1.y > -var_10_1.x + 276 then
				return
			end

			LayerManager:pushInLayer("PhotoFileLayer", {
				dataId = iter_9_0,
				roleType = var_0_1[iter_9_0]
			})
		end)
	end
end

function PhotoFileEntranceLayer:exit()
	global_window_close_action(self.image_bottom, function()
		LayerManager:removePopLayer()
	end)
end
