local cardData=nil;
local targetPos=nil;
local leftItem=nil;
local rightItem=nil;

function OnOpen()
    if data then
        cardData=data.card;
        targetPos=data.targetPos;
        CreatePosObj(leftItem,iconObj,cardData:GetCurCoordPos(),cardData)
        CreatePosObj(rightItem,iconObj2,targetPos:GetCoord(),cardData)
    end
end

function CreatePosObj(com,parent,coord,card)
    if leftItem==nil then
        ResUtil:CreateUIGOAsync("Halo/HaloRangItem",parent,function(go)
            com=ComUtil.GetLuaTable(go)
            com.Refresh(coord,card);
        end)
    else
        com.Refresh(coord,card);
    end
end

function OnClickCancel()
    if not IsNil(gameObject) and not IsNil(view) then
        view:Close()
    end
end

function OnClickS()
    local curHaloInfo=cardData:GetHaloInfo();
    if cardData and curHaloInfo:GetCurCoord():GetID()~=targetPos:GetID() and curHaloInfo:GetLv()>= targetPos:GetLockLv() then
        --切换光环
        HaloProto:HaloChange(cardData:GetID(),targetPos:GetID());
    end
    if not IsNil(gameObject) and not IsNil(view) then
        view:Close()
    end
end
