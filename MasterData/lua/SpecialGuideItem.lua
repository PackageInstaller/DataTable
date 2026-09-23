local cfg = nil
function Refresh(_data)
    cfg = _data
    if cfg then
        PlayAniAction()
    end
end

--启动动画
function PlayAniAction()
    CSAPI.SetScale(frame,0,0,0);
    -- CSAPI.ApplyAction(node,"action_guide");

    FuncUtil:Call(OnAniActionComplete,nil,700);
end

function OnAniActionComplete()
    CSAPI.SetScale(frame,1,1,1);
end