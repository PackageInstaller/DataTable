local UIFightSoulMainCtrl = BaseClass("UIFightSoulMainCtrl",UIBaseCtrl);
local this = UIFightSoulMainCtrl;
local base = UIBaseCtrl

function this.CloseSelf()
   UIManager:GetInstance():DestroyWindowNoRecycle(UIWindowNames.UIFightSoulMain);
end

return this
