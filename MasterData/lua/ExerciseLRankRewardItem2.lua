function Refresh(_reward, _isGet)
    local data = BagMgr:GetFakeData(_reward[1])
    if (not item) then
        ResUtil:CreateUIGOAsync("Grid/GridItem", node, function(go)
            item = ComUtil.GetLuaTable(go)
            item.Refresh(data)
            item.SetCount(_reward[2])
            item.SetClickCB(GridRewardGridFunc)
        end)
    else
        item.Refresh(data)
        item.SetCount(_reward[2])
    end
    CSAPI.SetGOActive(imgGet, _isGet)
end
