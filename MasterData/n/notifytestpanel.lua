---@class NotifyTestPanel : NotifyTestPanel_Generate
---##################### 【NotifyTestPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【NotifyTestPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local NotifyTestPanel = require "NotifyTestPanel_Generate"
local NotificationMgr = require "NotificationMgr"
local isIos = UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer
local isAndroid = UnityEngine.Application.platform == UnityEngine.RuntimePlatform.Android

function NotifyTestPanel:InitLogic(data)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content.transform)
    --通过弹窗启动app预留信息打印
    if isAndroid then
        self.androidStartListener.result.text.text = NotificationMgr:GetAppStartIntent()
    elseif isIos then
        self.IosStartListener.ResultIos.text.text = NotificationMgr:GetAppStartIntent()
    end
    --各种回调
    if isAndroid then
        NotificationMgr:InitReceivedHandler()
        NotificationMgr:SetReceivedHandler(function (str)
            print("通知触发回调")
            print(str)
        end)
    elseif isIos then
        --ios初始化检查权限回调
        local func = function(is_true, error_code, device_code)
            print(is_true)
            print(error_code)
            print(device_code)
        end
        NotificationMgr:SetIosCheckPermissionListener(func)
    end
end

--function NotifyTestPanel:StartCreating(time)
--
--end

--function NotifyTestPanel:StartEnter(time)
--
--end

--function NotifyTestPanel:StartRemoving(time)
--
--end

--function NotifyTestPanel:StartExit(time)
--
--end

--function NotifyTestPanel:OnOpen(data, initiative)
--
--end

--function NotifyTestPanel:OnClose(initiative)
--
--end

--function NotifyTestPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function NotifyTestPanel:OnRefresh(data)
--
--end

--[[ 创建安卓渠道
/Scroll View/Viewport/Content/AndroidChannel/ChannelBtn/CreateChannelBtn onClick 
--]]
function NotifyTestPanel:createChannelBtn_Button_onClick(createChannelBtn)
    local channel = self.channel.input.tMP_InputField.text
    local channelName = self.name.input.tMP_InputField.text
    local importance = self.importance.input.tMP_InputField.text
    local desc = self.desc.input.tMP_InputField.text
    local canBypassDnd = self.canBypassDnd.input.tMP_InputField.text == "true"
    local canShowBadge = self.canShowBadge.input.tMP_InputField.text == "true"
    local channel_config = {
        channel_id = channel,
        name = channelName,
        importance = tonumber(importance) or 3,
        desc = desc,
        canBypassDnd = canBypassDnd,
        canShowBadge = canShowBadge,
    }
    NotificationMgr:CreateChannel(channel_config)
end

--[[  创建通知
/Scroll View/Viewport/Content/AndroidNotification/NotifyBtn/CreateNotifyBtn onClick 
--]]
function NotifyTestPanel:createNotifyBtn_Button_onClick(createNotifyBtn)
    local Color = UnityEngine.Color
    local color = nil
    local title = self.title.input.tMP_InputField.text
    local text = self.text.input.tMP_InputField.text
    --延迟多少秒
    local seconds = self.dateTime.input.tMP_InputField.text
    local autocancel = (self.autocancel.input.tMP_InputField.text == "true") and true or false --默认false
    local small_icon = self.small_icon.input.tMP_InputField.text
    local large_icon = self.large_icon.input.tMP_InputField.text
    local intentdata = self.intentdata.input.tMP_InputField.text
    local colorTemp = self.color.input.tMP_InputField.text
    if colorTemp ~= "" then
        color = Color[colorTemp] or nil
    end
    local channel2 = self.channel2.input.tMP_InputField.text
    local specificId = self.specificId.input.tMP_InputField.text
    local notify_config = {
        title = title,
        text = text,
        time = tonumber(seconds),
        autocancel = autocancel,
        small_icon = small_icon,
        big_icon = large_icon,
        intentdata = intentdata,
        color = color,
    }
    NotificationMgr:CreateNotification(notify_config, channel2, specificId)
end

--[[    取消具体通知
/Scroll View/Viewport/Content/AndroidFunc/DeleteNotifyById/DeleteNotifyById onClick 
--]]
function NotifyTestPanel:deleteNotifyById_Button_onClick(deleteNotifyById)
    local id = self.deleteId.input.tMP_InputField.text
    if id and tonumber(id) then
        NotificationMgr:CancelNotificationById(id)
    end
end

--[[    取消所有通知
/Scroll View/Viewport/Content/AndroidFunc/DeleteAllNotify/DeleteAllNotifyBtn onClick 
--]]
function NotifyTestPanel:deleteAllNotifyBtn_Button_onClick(deleteAllNotifyBtn)
    NotificationMgr:ClearAllNotifications()
end

--[[    ios检测初始化
/Scroll View/Viewport/Content/IosCheckPermission/IosBtn/IosBtn onClick 
--]]
function NotifyTestPanel:iosBtn_Button_onClick(iosBtn)
    if isIos then
        NotificationMgr:IosCheckPermission()
    end
end

--[[    ios创建渠道
/Scroll View/Viewport/Content/IosNotification/IosCreateBtn/IosCreateBtn onClick 
--]]
function NotifyTestPanel:iosCreateBtn_Button_onClick(iosCreateBtn)
    if isIos then
        local seconds = tonumber(self.dateTimeIos.input.tMP_InputField.text)
        local now = os.time() + seconds
        local targetTime = os.time() + 4*3600
        local year = os.date("%Y",targetTime)
        local month = os.date("%m",targetTime)
        local day = os.date("%d",targetTime)
        local hour = os.date("%H",targetTime)
        local minute = os.date("%M",targetTime)
        local second = os.date("%S",targetTime)
        local dateTime = NotifyManager.GenerateDateTime(year, month, day, hour, minute, second)
        local title = self.titleIos.input.tMP_InputField.text
        local text = self.textIos.input.tMP_InputField.text
        local showInForeground = self.showInForeground.input.tMP_InputField.text == "true"
        local identifier = self.specificIdIos.input.tMP_InputField.text
        local intentdata = self.intentdataIos.input.tMP_InputField.text
        local notify_config = {
            title = title,
            text = text,
            dateTime = dateTime,
            showInForeground = showInForeground,
            identifier = identifier,
            intentdata = intentdata,
        }
        NotificationMgr:CreateNotificationIos(notify_config)
    end
end

return NotifyTestPanel
