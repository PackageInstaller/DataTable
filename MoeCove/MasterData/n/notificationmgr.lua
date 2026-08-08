---@class NotificationMgr
local NotificationMgr = class("NotificationMgr")
local isIos = UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer
local isAndroid = UnityEngine.Application.platform == UnityEngine.RuntimePlatform.Android
function NotificationMgr:ctor()
	self._notification_list = {}
end

--外部接口

--获取app启动时预留信息
--@return {str} 自定义内容(创建通知时的参数)
function NotificationMgr:GetAppStartIntent()
	if isAndroid then
		return NotifyManager.CheckAppStartIntentAndroid()
	elseif isIos then
		return NotifyManager.CheckAppStartIntentIos()
	end
end

--清除所有通知
function NotificationMgr:ClearAllNotifications()
	if isAndroid then
		NotifyManager.CancelNotificationAll()
	elseif isIos then
		NotifyManager.RemoveAllDeliveredNotifications()
		NotifyManager.RemoveAllScheduledNotifications()
	end
end

--根据id删除通知 id int
function NotificationMgr:CancelNotificationById(id)
	if isAndroid then
		NotifyManager.CancelNotificationById(id)
	elseif isIos then
		--ios需要转成str
		NotifyManager.RemoveDeliveredNotification(tostring(id))
		NotifyManager.RemoveScheduledNotification(tostring(id))
	end
end

--------------------------------------------------------------------------------
--#region android
--------------------------------------------------------------------------------

--初始化推送渠道
--@param {str} channel_id 渠道id
--@param {str} name		渠道名称
--@param {Unity.Notifications.Android.importance} importance	推送通知重要性 0 2 3 4
--@param {str} desc		渠道描述
--@param {bool} canBypassDnd		是否越过系统免打扰
--@param {bool} canShowBadge		是否显示为徽章
function NotificationMgr:CreateChannel(data)
	NotifyManager.CreateChannel(
		data.channel_id,
		data.name,
		data.importance,
		data.desc,
		data.canBypassDnd,
		data.canShowBadge
	)
end

--初始化通知触发回调
function NotificationMgr:InitReceivedHandler()
	NotifyManager.InitReceivedHandler()
end

--设置通知触发监听
function NotificationMgr:SetReceivedHandler(func)
	NotifyManager.receivedCallback = func
end

--获取channel_id
--@return {str} 渠道id
function NotificationMgr:GetChannel()
	return self._channel_id
end

--创建通知(通过修改dateTime达到延迟效果) 例 System.DateTime.Now:AddSeconds(3)
-- data = {
-- 	--@param {str} title 		通知标题
-- --@param {str} text			通知内容	
-- --@param {int} time		延迟几秒
-- --@param {bool} autocancel	是否自动取消通知（点击通知后，自动删除）
-- --@param {str} small_icon	通知左上角小图标
-- --@param {str} big_icon		通知右上角大图标
-- --@param {str} intentdata	通知传递的信息
-- --@param {color} color		通知左上角小图标背景颜色
-- --@param {int} specific_id	指定通知id
-- }

--@param {str} channel_id	通知所附属的渠道
-- 只有添加MobileNotification设置管理图片或手动添加到“res/drawable”文件夹的图标才能用于通知。
-- 注意，并非所有设备都支持彩色图标。
-- 小图标必须至少为48x48px，并且只由透明背景上的白色像素组成。
-- 大图标必须不小于192x192px，并且可以包含颜色。
--@return {int} 通知id 返回0就代表使用的是指定id
function NotificationMgr:CreateNotification(data, channel_id, specific_id)
	local notification_id = NotifyManager.CreateAndroidNotification(
		data.title,
		data.text,
		data.time,
		data.autocancel,
		data.small_icon,
		data.big_icon,
		data.intentdata,
		data.color,
		specific_id,
		channel_id
	)
	return notification_id
end

--#endregion
--------------------------------------------------------------------------------
--#region ios
--------------------------------------------------------------------------------

--ios获取权限监听
function NotificationMgr:SetIosCheckPermissionListener(func)
	--是否同意弹窗:bool 错误代码:str DeviceToken:str
	NotifyManager.iosPermissionCallBack = func
end

--ios初始化弹窗权限
--projectsetting中已设置app启动时初始化 这里可不调用
function NotificationMgr:IosCheckPermission()
	NotifyManager.IosCheckPermission()
end

--ios创建通知(通过修改dateTime达到延迟效果) 例 System.DateTime.Now:AddSeconds(3)
--@param {str} title 		通知标题
--@param {str} text			通知内容	
--@param {dateTime} dateTime		发送时间 通过NotifyManager.GenerateDateTime生成
--@param {bool} showInForeground	应用处于前台时是否应显示通知
--@param {str} identifier	指定通知id
--@param {str} intentdata	自定义字段
--@return {int} 通知id
function NotificationMgr:CreateNotificationIos(data)
	local timaspan = NotifyManager.GenerateTimeSpan(data.dateTime)
	local trigger = NotifyManager.CreateTriggerIos(timaspan, data.repeats)
	NotifyManager.CreateNotificationIos(
		data.title,
		data.text,
		trigger,
		data.showInForeground,
		data.identifier,
		data.intentdata
	)
	return data.identifier
end

-------------------------------------------------------------------------------

return NotificationMgr
