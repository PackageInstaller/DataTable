function Awake()
    UIUtil:SetPerfectScale(AdaptiveScreen) -- 适配大小
end

function OnClickMask()
    view:Close();
end

function OnClickOK()
    view:Close();
end