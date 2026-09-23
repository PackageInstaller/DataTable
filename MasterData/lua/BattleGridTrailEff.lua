--格子拖尾特效

function Awake()
    if(moveNode)then
        moveEff = ComUtil.GetComInChildren(moveNode,"ParticleCtrl");
    end
    if(idleNode)then
        idleEff = ComUtil.GetComInChildren(idleNode,"ParticleCtrl");
    end
    --PlayMove();
end

function PlayMove()
    if(moveEff)then
        moveEff:Play(true);
    end
    if(idleEff)then
        idleEff:Stop(true);
    end
end

function PlayIdle()
    if(moveEff)then
        moveEff:Stop(true);
    end
    if(idleEff)then
        idleEff:Play(true);
    end
end
function Stop()
    if(moveEff)then
        moveEff:Stop(true);
    end
    if(idleEff)then
        idleEff:Stop(true);
    end
end