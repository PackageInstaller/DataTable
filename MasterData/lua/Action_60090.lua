
function OnComplete()
    local target = GetTarget();
    if(not target)then
        return;
    end
    local targetCharacter = ComUtil.GetLuaTableInParent(target);
    if(not targetCharacter)then
        return;
    end
    local modelLua = targetCharacter.modelLua;
    local eff = modelLua and modelLua.Cast5Effect
    if(eff)then        
        CSAPI.SetGOActive(eff,active ~= nil);
    end
end


function GetTarget()
    if(not action)then
        action = ComUtil.GetCom(gameObject,"ActionBase");
    end
    if(not action)then
        return nil;
    end
    return action.target;
end