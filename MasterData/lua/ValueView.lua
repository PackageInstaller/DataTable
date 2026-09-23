
function SetValue(value)
    local txtValue = ComUtil.GetCom(text,"TextMesh");
    txtValue.text = value .. "";

    --���÷�ת
    if(FightClient:IsFlip())then
        FuncUtil:Call(Flip,nil,10);       
    end
end

function Flip()
    CSAPI.SetScale(gameObject,-1,1,1);  
end
--function SetCrit(isCrit)
--    if(crit ~= nil)then
--        CSAPI.SetGOActive(crit,isCrit ~= nil);
--    end
--end
function SetGoodHit(isGoodHit)
    if(goodHit ~= nil)then
        CSAPI.SetGOActive(goodHit,isGoodHit);
    end
end