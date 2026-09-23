function Awake()
    animator = ComUtil.GetComInChildren(gameObject,"Animator");
end

function ApplyAtk()
    FuncUtil:Call(PlayAni,nil,1000,"atk");
    FuncUtil:Call(CSAPI.SetGOActive,nil,300,atkEff,true);
    FuncUtil:Call(CSAPI.SetGOActive,nil,1000,atkEff,false);    

    FuncUtil:Call(CSAPI.SetGOActive,nil,300,warningEff,false);
end

function ApplyWarning()
    PlayAni("warning");
    CSAPI.SetGOActive(warningEff,true);
end

function PlayAni(aniName)
    if(not IsNil(animator))then
        animator:Play(aniName);
    end
end