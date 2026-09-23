local girds={};
local closeFunc=nil;

function OnOpen()
    --创建奖励格子
    ItemUtil.AddItems("FesDream/FesDreamResultGrid",girds,data[1],Content)
    closeFunc=data.closeCallBack or nil;
end

function OnClickClose()
    if closeFunc~=nil then
        closeFunc();
    end
    if not IsNil(gameObject) and not IsNil(view) then
        view:Close();
    end
end