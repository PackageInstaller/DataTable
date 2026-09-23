local gridItem=nil;
function Awake()
    local go = ResUtil:CreateUIGO("Grid/GridItem", gridNode.transform)
	gridItem = ComUtil.GetLuaTable(go)
end

--data:{id=v,num=num,rNum=rNum}
function Refresh(data)
    --创建格子
    if data then
        local goods=BagMgr:GetFakeData(data.id)
        if gridItem~=nil then
            gridItem.Refresh(goods);
            gridItem.SetCount();
            gridItem.SetClickCB(GridClickFunc.OpenInfoSmiple);
        end
        CSAPI.SetText(txtNum,string.format("%s/%s",data.rNum,data.num));
        CSAPI.SetGOActive(over,data.num<=data.rNum);
    end
end
