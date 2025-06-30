
local ToolTipAddFriendCtrl = BaseClass("ToolTipThirdCtrl",ToolTipAddFriendCtrl)
local this = ToolTipAddFriendCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipAddFriend);
end

return this
