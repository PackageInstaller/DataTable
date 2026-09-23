--调整受击角色

function Awake()
    FuncUtil:Call(ApplyFix,nil,1);
    --ApplyFix();
end

function ApplyFix()
    local fa = FightActionMgr.curr;

    if(fa == nil or fa:GetType() ~= FightActionType.Skill)then
        return;
    end
   
    local targets = fa:GetTargetCharacters();

    if(targets == nil)then
        return;
    end
   
    for _,target in pairs(targets)do
        local  go = target.gameObject;        
        local targetOriginPos = target.GetOriginPos();
        local x,y,z = targetOriginPos[1],targetOriginPos[2],targetOriginPos[3];--CSAPI.GetPos(go);
         
       

        go.transform:SetParent(transform);    

        if(fix_x)then
            x = 0;

            CSAPI.SetPos(go,x,y,z);
        elseif(fix_z)then
            z = 0;

            CSAPI.SetPos(go,x,y,z);
        elseif(fix_none)then
            CSAPI.SetPos(go,x,y,z);
        else           

            CSAPI.SetLocalPos(go,0,0,0);
        end
        
        --LogError(target.GetModelName() .. "x:" .. x);
            
--        if(not target.IsEnemy())then
--            CSAPI.SetWorldAngle(go,0,180,0);
--        end  
    end
end
