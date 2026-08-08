--ThinkingAnalytics
local ThinkingAnalytics = class("ThinkingAnalytics")
-- local lx_json_decode = lx.json_decode
-- local lx_json_encode = lx.json_encode
local Dictionary_string_object = System.Collections.Generic.Dictionary_string_object
function ThinkingAnalytics:ctor()
	-- self._locationInfo = nil
	self._notification_list = {}
	self._ip = ""
end
	--------------------------------------------------------------------------------
	--接口
	--------------------------------------------------------------------------------

	
	-- function ThinkingAnalytics:test(name, table1)
	-- 	log.print_r(table1,"原始数据")
	-- 	local result = lx_json_encode(table1)
	-- 	log.print_r(result,"转Json后的数据")
	-- end

	--初始化api
	--@param {prefab}	gameobject	挂有埋点cs的gameobject
	function ThinkingAnalytics:init(prefab)
		local api = prefab:GetComponent("TDAnalytics")
		if api then
			print("初始化成功")
			self._ThinkingAnalytics_api = api
			if not GV.IsEditor then
				self._ThinkingAnalytics_api.EnableAutoTrackNoCrash()
				-- Bugly 合规版：用数数设备 id / 机型，便于和埋点对账
				-- https://bugly.qq.com/docs/user-guide/advance-features-android/
				local deviceId = self:get_device_id()
				if deviceId and deviceId ~= "" then
					BuglyAgent.SetDeviceId(deviceId)
				end
				local props = self:getPresetProperties()
				if props and props.DeviceModel and props.DeviceModel ~= "" then
					BuglyAgent.SetDeviceModel(props.DeviceModel)
				end
			end
			-- self._locationInfo = prefab:GetComponent("LocationInfo")
		end
	end

	--track事件
	--@param {name}			string	埋点事件名
	--@param {properties}	table	埋点属性properties table
	function ThinkingAnalytics:track(name, properties)
		if not self._ThinkingAnalytics_api then
			return
		end
		if not GV.GlobalConfig.WriteShuShuLog then
			return
		end
		--封装属性
		local dic = Dictionary_string_object.New()
		if next(properties) then
			for key, value in pairs(properties) do
				dic:Add(tostring(key), value)
			end
		end
		self._ThinkingAnalytics_api.Track(name, dic)
	end

	--首次track事件
	--@param {name}			string	埋点事件名
	--@param {properties}	table	埋点属性properties table
	function ThinkingAnalytics:track_onlyonce(name, properties)
		if not self._ThinkingAnalytics_api then
			return
		end
		--封装属性
		local dic = Dictionary_string_object.New()
		--首次track事件需要 INT_PROPERTY = 0
		properties.INT_PROPERTY = 0
		if next(properties) then
			for key, value in pairs(properties) do
				dic:Add(tostring(key), value)
			end
		end
		self._ThinkingAnalytics_api.Track(name, dic)
	end

	--设置用户普通属性
	--@param {properties}	table	属性properties table
	--key为用户属性名 value为值
	function ThinkingAnalytics:UserSet(properties)
		-- if not self._ThinkingAnalytics_api then
		-- 	return
		-- end
		-- --封装属性
		-- local dic = Dictionary_string_object.New()
		-- if next(properties) then
		-- 	for key, value in pairs(properties) do
		-- 		--若为对象组（table里套table）
		-- 		if type(value) == "table" then
		-- 			local list = List_Dictionary_string_object.New()
		-- 			for _, row in pairs(value) do
		-- 				local child_dic = Dictionary_string_object.New()
		-- 				for k, v in pairs(row) do
		-- 					child_dic:Add(k, v)
		-- 				end
		-- 				list:Add(child_dic)
		-- 			end
		-- 			dic:Add(key, list)
		-- 		else
		-- 			dic:Add(key, value)
		-- 		end
		-- 	end
		-- end
		-- --log.print_r(dic)
		-- self._ThinkingAnalytics_api.UserSet(dic)
	end

	--设置用户账号 ID
	function ThinkingAnalytics:login()
		if not self._ThinkingAnalytics_api then
			return
		end
		self._ThinkingAnalytics_api.Logout()	--清除id
		-- local user_info = gamecore.user:get_user_info_data() --todo
		local user_info = Me.uid
		self._ThinkingAnalytics_api.Login(tostring(user_info))	--记录id
	end

	--设置访客id
	--@param {identify_id}	string	访客id
	function ThinkingAnalytics:set_identify_id(identify_id)
		if not self._ThinkingAnalytics_api then
			return
		end
		--设置访客id
		self._ThinkingAnalytics_api.Identify(identify_id)
	end

	--获得设备id
	--@return 	string	设备id
	function ThinkingAnalytics:get_device_id()
		if not self._ThinkingAnalytics_api then
			return
		end
		--返回设备id
		return self._ThinkingAnalytics_api.GetDeviceId()
	end

	function ThinkingAnalytics:getPresetProperties()
		if not self._ThinkingAnalytics_api then
			return
		end
		--返回设备id
		return self._ThinkingAnalytics_api.GetPresetProperties()
	end

	function ThinkingAnalytics:getLocationInfo()
		return GameObject.Find("LuaManager"):GetComponent("LocationInfo")
	end

	--------------------------------------------------------------------------------

return ThinkingAnalytics
