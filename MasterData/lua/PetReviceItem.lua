--宠物奖励物体
local data=nil;
local grids=nil;
local reviceGrid=nil;
function Awake()
    if grids==nil then
        grids={};
        for i=1,3 do
            local go=ResUtil:CreateUIGO("Pet/PetBookGrid",this["node"..i].transform);
            local lua=ComUtil.GetLuaTable(go);
            lua.InitNull();
            table.insert(grids,lua);
        end
    end
    local go=ResUtil:CreateUIGO("Pet/PetReviceGrid",node4.transform);
    reviceGrid=ComUtil.GetLuaTable(go);
end

--_d:PetArchiveRewardInfo
function Refresh(_d)
    if IsNil(grids) or IsNil(reviceGrid) then
        do return end
    end
    data=_d;
    if _d then
        local ids=_d:GetArchiveList();
        for i=1,3 do
            local item=nil;
            local goods=nil;
            if ids and #ids>=i then
                item=ids[i]
            end
            if item then
                grids[i].Refresh(item,{isPre=item:IsLock()});
                grids[i].SetClickCB(OnClickItem);
            else
                grids[i].SetClickCB(OnClickItem);
            end
        end
        reviceGrid.Refresh(_d);
        reviceGrid.SetClickCB(OnClickRevice);
    end
end

function OnClickRevice()
    if data and data:GetState()==2 then
        SummerProto:GainBestiaryReward(data:GetID())
    end
end

function OnClickItem(lua)
    if lua and lua.data then
        EventMgr.Dispatch(EventType.PetActivity_Click_BookItem,lua.data:GetID());
    end
end