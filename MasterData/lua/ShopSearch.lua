--商店搜索框弹窗
local inputItem=nil;
function OnOpen()
    --创建输入框
    if inputItem==nil then
        local go=ResUtil:CreateUIGO("ShopComm/SearchInputItem",searchNode.transform)
        inputItem=ComUtil.GetLuaTable(go)   
        inputItem.Init(data);
    else
        inputItem.Init(data);
    end
end

function SetDownList(list)
    inputItem.SetDownList(list)
end

function OnClickS()
    if data.func2 then
        data.func2(inputItem.GetSelectedInfo());
    end
    Close();
end

function OnClickC()
    Close();
end

function Close()
    if not IsNil(view) then
        view:Close();
    end
end

function OnClickClose()
    Close();
end
