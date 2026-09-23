local grid=nil;
local goods=nil;

function SetIndex(_index)
    index = _index
end

function Refresh(_data,_isReset)
    this.data = _data
    goods=this.data and this.data.goods or nil;
    local masNum=this.data and this.data.num or 0;
    if grid then
        grid.Refresh(goods);
        grid.SetClickState(false);
        grid.SetCountText()
    else
        ResUtil:CreateUIGOAsync("Grid/GridItem",gridNode,function(go)
            grid=ComUtil.GetLuaTable(go);
            grid.Refresh(goods);
            grid.SetCountText()
            grid.SetClickState(false);
        end)
    end
    -- select,sel
    local num=goods and goods:GetCount() or 0
    CSAPI.SetText(txtSel, num>=masNum and (num .. "/"..masNum) or string.format("<color=#E38089>%s</color>/%s",num,masNum))
end

-- 加载框
function LoadFrame(lvQuality)
    if lvQuality then
        local frame = GridFrame[lvQuality];
        ResUtil.IconGoods:Load(bg, frame);
    else
        ResUtil.IconGoods:Load(bg, GridFrame[1]);
    end
end

-- 加载图标
function LoadIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil);
    if (iconName) then
        ResUtil.IconGoods:Load(icon, iconName .. "")
    end
end

function OnClick()
    if goods~=nil then
        local needNum=goods:GetCount()<this.data.num and this.data.num-goods:GetCount() or nil;
        CSAPI.OpenView("GoodsFullInfo",{data=goods,needNum=needNum});
    end
end
