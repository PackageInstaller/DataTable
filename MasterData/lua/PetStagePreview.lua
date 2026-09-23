--宠物阶段奖励预览
local items={};
function Show(_d,x,y)
    local infos={};
    if _d then
        infos=GridUtil.GetGridObjectDatas2(_d)
    end
    ItemUtil.AddItems("Pet/PetStagePreviewGrid", items, infos, root, nil, 1);
    if x and y then
        CSAPI.SetAnchor(root,x+60,y+140);
    end
    CSAPI.SetGOActive(gameObject,true);
end

function Hide()
    if IsNil(gameObject) then
        do return end
    end
    CSAPI.SetGOActive(gameObject,false);
end

function OnClickMask()
    Hide()
end