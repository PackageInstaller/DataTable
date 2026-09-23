-- local stagGrid=nil;
local grids={}
function Refresh(_d)
    if _d then
        CSAPI.SetText(txtTitle,LanguageMgr:GetByID(61023,_d.index));
        CSAPI.SetText(txtDesc,LanguageMgr:GetByID(61024)..tostring(_d.nCount));
        local rData={};
        if _d.jAwardId then
            -- local info=_d.jAwardId[1];
            -- rData=GridUtil.RandRewardConvertToGridObjectData({id=info[1],num=info[2],type=info[3]})
            rData=GridUtil.GetGridObjectDatas2(_d.jAwardId);
        end
        ItemUtil.AddItems("Grid/GridItem", grids, rData, gridNode, GridClickFunc.OpenInfoSmiple, 0.5)
        -- if stagGrid==nil then
        --     ResUtil:CreateUIGOAsync("Grid/GridItem",gridNode,function(go)
        --         stagGrid=ComUtil.GetLuaTable(go)
        --         stagGrid.Refresh(rData);
        --         stagGrid.LoadIconByLoader(ResUtil.IconGoods,_d.sIcon);
        --         CSAPI.SetScale(go,0.5,0.5);
        --         stagGrid.SetClickCB(GridClickFunc.OpenInfoSmiple);
        --     end)
        -- else
        --     stagGrid.Refresh(rData);
        --     stagGrid.LoadIconByLoader(ResUtil.IconGoods,_d.sIcon);
        -- end
    end
end