--背景预览
-- data -> {id=CfgMenuBg的id}
function OnOpen()
    local cfg = Cfgs.CfgMenuBg:GetByID(data.id)
    local imgName=cfg.img;
    if (cfg and cfg.name) then
        ResUtil:LoadMenuBg(img, "UIs/" .. cfg.name, false,function()
            CSAPI.SetImgColor(img,255,255,255,255);
            -- local posScale = {0, 0, 1}
            -- CSAPI.SetAnchor(img, posScale[1], posScale[2], 0)
            -- CSAPI.SetScale(img, posScale[3], posScale[3], posScale[3])
        end)
    end
    -- ResUtil.MultiImg:Load(img, imgName, function()
    --     local posScale = cfg.imgPos or {0, 0, 1}
    --     CSAPI.SetAnchor(img, posScale[1], posScale[2], 0)
    --     CSAPI.SetScale(img, posScale[3], posScale[3], posScale[3])
    -- end, true)
    if data.showMask==true then
        CSAPI.SetImgColor(mask,0,0,0,255);
    else
        CSAPI.SetImgColor(mask,0,0,0,0);
    end
end

function OnClickMask()
    view:Close()
end
