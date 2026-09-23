-- 多人插图预览
-- data ->CfgArchiveMultiPicture 的 id

--[[
function OnOpen()
    local cfg = Cfgs.CfgArchiveMultiPicture:GetByID(data.id)
    if cfg==nil then
        LogError(string.format("未在配置表CfgArchiveMultiPicture中找到id为%s的配置",data.id));
        do return end;
    end
    local imgName=cfg.img;
    if openSetting==1 then
        imgName=cfg.img_replace or cfg.img;
    end
    ResUtil.MultiImg:Load(img, imgName, function()
        local posScale = cfg.imgPos or {0, 0, 1}
        CSAPI.SetAnchor(img, posScale[1], posScale[2], 0)
        CSAPI.SetScale(img, posScale[3], posScale[3], posScale[3])
    end, true)
    if data.showMask==true then
        CSAPI.SetImgColor(mask,0,0,0,255);
    else
        CSAPI.SetImgColor(mask,0,0,0,0);
    end
    --
    UIUtil:SetLiveBroadcast(img)
end
]]

function Awake()
    cardIconItem = RoleTool.AddRole(iconParent)
end

function OnOpen()
    cardIconItem.Refresh(data.id, LoadImgType.Main, nil, false, openSetting==1)
    if data.showMask==true then
        CSAPI.SetImgColor(mask,0,0,0,255);
    else
        CSAPI.SetImgColor(mask,0,0,0,0);
    end
end 

function OnClickMask()
    view:Close()
end
