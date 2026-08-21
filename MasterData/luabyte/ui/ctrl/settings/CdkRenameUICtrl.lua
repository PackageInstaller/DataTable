local CdkRenameUICtrl = BaseClass("CdkRenameUICtrl", require("UI.Ctrl.Common.RenameUICtrl"))
local M = CdkRenameUICtrl
local MessageId = Proto.MessageId

function M:Init()
    self:SetTitle(418)
    self:SetContentDefault(663)
    self:SetCharacterLimit(192)
    -- self:SetContentType(4)
end

function M:OnConfirmInput(inputStr)
    -- 测试功能用
    if inputStr == "recab" then
        CS.LebianSDKHelper.SendRecordAssetBundleListToServer()
        return
    end
    -- ---------

    if inputStr == "OpenSRDebugger" then 
        CS.UnityEngine.PlayerPrefs.SetInt("OpenSRDebugger",1)
        GameHelper.Tips("开启SRDebuger")
        return 
    end

    if inputStr == "CloseLog" then 
        CS.Debuger.EnableLog = false 
        return 
    end
    
    if inputStr == "OpenLog" then 
        CS.Debuger.EnableLog = true
        return 
    end
    if string.startswith( inputStr , "pay") then 
        -- pay_order_goodsId_price
        local arr = string.split(inputStr,"_")
        if #arr >= 2 then 
            local payId = tonumber(arr[2])
            SDKHelper.Pay(payId,function(isOk)
                if isOk then 
                    GameHelper.Tips("OK")
                else
                    GameHelper.Tips("Fail")
                end
                
            end)
        end
        return 
    end
   
    

    local request = {}
    request.CDKey = inputStr
    if self._responseUseCdk then 
        NetPack:UnRegistResponse(MessageId.ResponseUseCdk, self._responseUseCdk)
    end
    self._responseUseCdk = NetPack:RegistResponse(MessageId.ResponseUseCdk, Bind(self, self.OnResponseUseCdk))

    NetPack:SendMessage(MessageId.RequestUseCdk, request)
end

function M:OnResponseUseCdk(messageId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseUseCdk, self._responseUseCdk)
    self._responseUseCdk = nil
    if result ~= 0 then
        Logger.LogError("ResponseUseCdk Error")
        return
    end
    GameHelper.ShowGetItemsByItems(msg.Data, nil)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:OnClose()
end

return CdkRenameUICtrl
