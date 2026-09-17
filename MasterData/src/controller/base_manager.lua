local BaseManager = class("BaseManager")
local var_0_1 = require("controller/layer_notification_manager"):getInstance()
local var_0_2 = {}

function BaseManager:ctor()
	self.layer = nil
end

function BaseManager:getInstance()
	var_0_2[self.__cname] = var_0_2[self.__cname] or self.new()

	return var_0_2[self.__cname]
end

function BaseManager:layerOnEnter(arg_3_1)
	self.layer = self.layer or arg_3_1
end

function BaseManager:layerOnExit()
	if self.layer then
		var_0_1:removeManagerNotification(self)

		self.layer = nil
	end
end

function BaseManager:registerNotification(arg_5_1, arg_5_2)
	var_0_1:registerNotification(arg_5_1, {
		manager = self,
		callBack = function(arg_6_0)
			if self.layer then
				arg_5_2(arg_6_0)
			end
		end
	})
end

function BaseManager:registerStaticNotification(arg_7_1, arg_7_2)
	var_0_1:registerStaticNotification(arg_7_1, {
		manager = self,
		callBack = function(arg_8_0)
			arg_7_2(arg_8_0)
		end
	})
end

return BaseManager
