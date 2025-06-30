
--
-- <代码文件解释说明>
--

---@class UINameEditCtrl
---@field model UINameEditModel
local UINameEditCtrl = BaseClass("UINameEditCtrl",UIBaseCtrl)
local this = UINameEditCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UINameEdit)
end

function this:SendChangeNameRequest(name)
    PublicRequest.SendRequest(
        PROTOCOL.ChangeNameReq,
        {name = name},
        function(response)
            Game.Scene.Player:ChangeName(response.name)
            DataManager:GetInstance():Broadcast(DataMessageNames.ON_NAME_CHANGED)
            self.CloseSelf()
        end
    )
end

return this
