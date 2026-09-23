local items={};
function OnOpen()
    Refresh();
end

function Refresh()
    local index=1;
    local list={};
    if data then
        if data:HasSpecial() then
            table.insert(list,{icon="img_07_03",lID=18140});
        end
        if data:HasModel() then
            table.insert(list,{icon="img_07_04",lID=18139});
        end
        local hadL2d=data:HadLive2D();
        if hadL2d~=nil then
            local iconName=nil;
            local lID=0;
            if hadL2d==1 then
                iconName="img_07_02";
                lID=18136;
            elseif hadL2d==2 then
                iconName="img_07_06";
                lID=18137;
            elseif hadL2d==3 then
                iconName="img_07_05";
                lID=18138;
            end
            table.insert(list,{icon=iconName,lID=lID});
        end
    end
    ItemUtil.AddItems("ShopComm/SkinTagDescItem",items,list,layout);
end

function OnClickAnyWay()
    if not IsNil(view) then
        view:Close();
    end
end