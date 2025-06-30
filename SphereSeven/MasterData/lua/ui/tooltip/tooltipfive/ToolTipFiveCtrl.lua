local ToolTipFiveCtrl = BaseClass("ToolTipFiveCtrl",UIBaseCtrl)
this = ToolTipFiveCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipFive);
end

return this