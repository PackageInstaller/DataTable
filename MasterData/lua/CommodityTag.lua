local animator=nil;
local pos={
    {0,0},
    {5,0},
    {11,0},
}
local child=nil;
local data=nil;
function Awake()
    animator=ComUtil.GetCom(gameObject,"Animator");
end

function OnDestroy()
    animator=nil
end

function Refresh(_d,_elseData)
    if _d then
        local isIngron=data and data.type==_d.type or false;
        data=_d;
        if isIngron~=true then
            if child~=nil then
                CSAPI.RemoveGO(child.gameObject)
                child=nil;
            end
            local goName="CommodityTagItem3";
            local idx=3;
            local height=42;
            if data.type==1 or data.type==7 then
                goName="CommodityTagItem1"
                height=50;
                idx=1;
            elseif data.type==3 then
                goName="CommodityTagItem2";
                height=50;
                idx=2;
            end
            CSAPI.SetAnchor(tagNode,pos[idx][1],pos[idx][2]);
            CSAPI.SetRTSize(gameObject,174,height)
            local go=ResUtil:CreateUIGO("ShopComm/"..goName,tagNode.transform);
            child=ComUtil.GetLuaTable(go);
        end
        child.Refresh(_d,_elseData);
    end
end
