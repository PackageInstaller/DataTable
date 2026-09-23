
function Awake()
    FightClient:SetPlaySpeed(1,true);
end

function OnDestroy()
    FightClient:SetPlaySpeed();
end