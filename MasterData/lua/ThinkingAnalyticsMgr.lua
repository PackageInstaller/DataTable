ThinkingAnalyticsMgr = {}
local this = ThinkingAnalyticsMgr

local isOpen = false
local appId,url = nil,nil
local isEnableLog = false
local isInited = false

TAType = {
	Normal = 1, --普通事件
	First = 2, --首次
	Update = 3, --可更新
	OverWritable = 4, --可重写
}

TAUserType = {
	Normal = 1, --正常
	Once = 2, --一次
}

function this:Init()
	-- isOpen = isOpen and (not CSAPI.IsPCPlatform()) or false
	-- local _appId,_url = "960faaceaf8946689f84fcac8b328bc3","https://shushu-receiver.megagamelog.com"
	-- if(self.mgr == nil) then
	-- 	--local go = UnityEngine.GameObject("ThinkingAnalyticsMgr")
	-- 	--self.mgr = go:AddComponent(typeof(CS.TAMgr));
	-- 	self.mgr = CS.TAMgr.ins;
	-- 	if isOpen then		
	-- 		if CSAPI.GetPublishType() == 1 then  --主干
	-- 			self.mgr:Init(_appId,_url)
	-- 		else --s分支
	-- 			self.mgr:Init(_appId,_url)
	-- 		end
	-- 		self:EnableAutoTrack() -- 开启自动采集
	-- 		self:ClearStateEvents() -- 清理缓存
	-- 		isInited = true
	-- 	end
	-- end	

	-- if isEnableLog then
	-- 	appId,url = _appId,_url
	-- end
	-- return self.mgr
end

function this:Clear()
	-- if isOpen then
	-- 	-- self:Flush()
	-- 	-- self:ClearStateEvents()
	-- 	self:LogOut()
	-- 	isInited = false
	-- end
	-- if(self.mgr) then
	-- 	self.mgr:Clear()
	-- end
	-- self.mgr = nil
end

--获取游客id
function this:GetDistinctId()
	-- return self.mgr:GetDistinctId()
end

--登录数数
function this:Login(accountID)
	-- self.mgr:Login(accountID)
end

--登出数数
function this:Logout()
	-- self.mgr:Logout()
	-- self:ClearStateEvents()
end

--立即上报
function this:Flush()
	-- self.mgr:Flush()
end

--校准时间
function this:CalibrateTime()
	-- self.mgr:CalibrateTime() 
end

--发送事件 --_datas结构：字典 type类型为可更新或可重写时需要提供_eventId
function this:TrackEvents(_eventName, _datas, _type, _eventId, isNoRefresh)
	-- if(_eventName == nil or _eventName == "") then
	-- 	return;
	-- end
	-- _eventName = _eventName .. ""
	
	-- _type = _type or TAType.Normal

	-- if _type > 2 and (_eventId == nil or _eventId == "") then
	-- 	LogError("缺少指定的事件id")
	-- 	return;
	-- end

	-- if isOpen and isInited then
	-- 	if not isNoRefresh then
	-- 		self:RefreshDatas()
	-- 	end
	-- 	self.mgr:TrackEvent(_eventName, _datas, _type, _eventId)
	-- 	if isEnableLog then
	-- 		LogError("数数事件上报：appId:"..appId..",url:"..url..",eventName:".. _eventName..",type:".. _type)
	-- 		if _eventId then
	-- 			LogError("eventId:" .. _eventId)
	-- 		end
	-- 		LogError("datas:")
	-- 		LogError(_datas)
	-- 	end
	-- end
end

--刷新缓存数据
function this:RefreshDatas()
	-- if isOpen and isInited then
	-- 	local datas = {}
	-- 	datas.level = PlayerClient:GetLv()
	-- 	datas.exp = PlayerClient:GetExp()
	-- 	datas.uid =PlayerClient:GetID()
	-- 	datas.role_id =PlayerClient:GetUid()
	-- 	datas.role_name = PlayerClient:GetName()
	-- 	datas.gold = PlayerClient:GetGold()
	-- 	datas.diamond = PlayerClient:GetDiamond()
	-- 	datas.max_battle_id = DungeonMgr:GetMaxDungeonID()
	-- 	datas.channel = CSAPI.GetChannelType()
	-- 	datas.ADID = CSAPI.GetADID()
	-- 	self:TrackStateEvents(datas)
	-- end
end

--获取预置属性内容
-- "#carrier": "中国电信",
-- "#os": "iOS",
-- "#device_id": "A8B1C00B-A6AC-4856-8538-0FBC642C1BAD",
-- "#screen_height": 2264,
-- "#bundle_id": "com.sw.thinkingdatademo",
-- "#manufacturer": "Apple",
-- "#device_model": "iPhone7",
-- "#screen_width": 1080,
-- "#system_language": "zh",
-- "#os_version": "10",
-- "#network_type": "WIFI",
-- "#zone_offset": 8,
-- "#app_version":"1.0.0"
function this:GetpresetProperty(key)
	-- if key == nil or key == "" or not isOpen then
	-- 	return
	-- end
	-- return self.mgr:GetpresetProperty("#" .. key)
end

---------------------------------------静态公共事件-----------------------------------------
--添加静态公共事件到数数缓存
function this:TrackStateEvent(_eventName, _Value)
	-- if(_eventName == nil or _eventName == "") then
	-- 	return;
	-- end
	-- _eventName = _eventName .. ""
	-- if isOpen then
	-- 	self.mgr:SetSuperProperties(_eventName, _Value)
	-- end
end

--添加静态公共事件到数数缓存 --字典结构
function this:TrackStateEvents(_datas)
	-- if(_datas) then
	-- 	for i, v in pairs(_datas) do
	-- 		self:TrackStateEvent(i, v)
	-- 	end
	-- end
end

--删除数数缓存中静态公共事件
function this:DeleteStateEvent(_eventName)
	-- if(_eventName == nil or _eventName == "") then
	-- 	return;
	-- end
	-- _eventName = _eventName .. ""
	-- self.mgr:UnsetSuperProperty(_eventName)
end

--清空数数缓存中静态公共事件
function this:ClearStateEvents()
	-- self.mgr:ClearSuperProperty()
end

---------------------------------------动态公共事件-----------------------------------------
--添加动态公共事件到数数缓存
function this:TrackDynamicEvent(_eventName, _datas)
	-- if(_eventName == nil or _eventName == "") then
	-- 	return;
	-- end
	-- _eventName = _eventName .. ""
	-- self.mgr:SetDynamicSuperProperties(_eventName, _datas)
end

-----------------------------------------记录时长--------------------------------
--开始记录
function this:TimeEventStart(_eventName)
	-- self.mgr:TimeEvent(_eventName)
end

--结束记录
function this:TimeEventEnd(_eventName)
	-- self:TrackEvents(_eventName)
end
-----------------------------------------自动采集--------------------------------
--开启自动采集
function this:EnableAutoTrack()
	-- self.mgr:EnableAllAutoTrack()
end
-----------------------------------------用户属性--------------------------------

--初始化用户属性
-- function this:InitUser()
	-- local userData = {}
	-- self.mgr:GetpresetProperty()
-- end

--设置用户属性 
function this:SetUser(_datas, _type)
	-- _type = _type or TAUserType.Normal
	
	-- self.mgr:SetUser(_datas, _type)
end

--上传用户数值型属性 --可加减
function this:UserAdd(_eventName, _addNum)
	-- if(_eventName == nil or _eventName == "") then
	-- 	return;
	-- end
	-- _eventName = _eventName .. ""
	-- self.mgr:UserAdd(_eventName, _addNum)
end

--重置用户属性 --字符串组
function this:UserUnset(_strs)
	-- self.mgr:UserUnset(_strs)
end

--删除用户
function this:DeleteUser()
	-- self.mgr:DeleteUser()
end

return this 