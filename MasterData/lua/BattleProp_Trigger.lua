--���»�����״̬
function UpdateActiveState(state)
    --LogError("state:" .. tostring(state));
    CSAPI.SetGOActive(effNode,state);
    if(effNode0)then
        CSAPI.SetGOActive(effNode0,not state);
    end
end

--���������Ż���
function TriggerProp()
    CSAPI.SetGOActive(triggerEffNode,false);
    CSAPI.SetGOActive(triggerEffNode,true);
    --FuncUtil:Call(CSAPI.SetGOActive,nil,500,);
end