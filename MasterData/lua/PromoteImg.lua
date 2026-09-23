local data=nil;
local click=nil;
function Refresh(_data,_click)
    data=_data;
    click=_click;
    if data~=nil then
        -- ResUtil.StorePromote:Load(gameObject,data:GetImg());
        ResUtil:LoadBigImg(gameObject, string.format("UIs/ShopPromote/%s", data:GetImg()), true,function()
            CSAPI.SetImgColor(gameObject,255,255,255,255);
        end);
        -- CSAPI.LoadImg(gameObject,string.format("UIs/ShopPromote/%s.png",data.img),true,function()
        --     CSAPI.SetImgColor(gameObject,255,255,255,255);
        -- end,true);
    end
end

function OnClick()
    -- if jumpId then
    --     JumpMgr:Jump(jumpId);
    -- end
    if click then
        if data then
            click(data:GetJumpInfo());
        else
            click();
        end
    end
end