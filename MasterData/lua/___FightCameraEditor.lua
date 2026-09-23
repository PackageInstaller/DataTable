--编辑器调整

local resArr = 
{
"robot1/robot1",
"robot1/robot2",
"robot3/robot3",
"robot4/robot4",
"blood_warlock/blood_warlock",
"double_guns/double_guns",
"ice_butterfly/ice_butterfly",
"nicole_Isabel/nicole_Isabel",
"norah_zero/norah_zero",
"poseidon/poseidon",
"Robilita_Albera/Robilita_Albera",
"summon_robot1/summon_robot1",
"summon_robot2/summon_robot2",
"tina_Gibson/tina_Gibson",
"tina_GibsonS/tina_GibsonS"
 };

function Awake()
    local grids = FightGroundMgr:GetAllGrids();
    for _,grid in pairs(grids)do
        if(not grid.IsHold())then
            local x,y,z = grid.x,0,grid.y;
            local res = resArr[CSAPI.RandomInt(1,#resArr)];
            local go = CSAPI.CreateGO("Characters/" .. res,x,y,z);
            if(x > 0)then
                CSAPI.SetAngle(go,0,180,0);
            end
        end
    end
end
