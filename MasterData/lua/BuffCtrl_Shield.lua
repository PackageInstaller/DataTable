
function HitShield()
    SetHitShieldState(true);
    FuncUtil:Call(SetHitShieldState,nil,500,false);
end

function SetHitShieldState(state)
    CSAPI.SetGOActive(hitNode,state);
end

function DecayShield()
    SetDecayShieldState(true);
    FuncUtil:Call(SetDecayShieldState,nil,500,false);
end

function SetDecayShieldState(state)
    CSAPI.SetGOActive(decayNode,state);
end