function Awake()
    ab = ComUtil.GetCom(node, "ActionBase")
end

function OnEnable()
    PlayAniAction()
end

-- 启动动画
function PlayAniAction()
    CSAPI.SetScale(frame, 0, 0, 0);
    ab:ToPlay()

    FuncUtil:Call(OnAniActionComplete, nil, 1000);
end

function OnAniActionComplete()
    CSAPI.SetScale(frame, 1, 1, 1);
end
