--宠物气泡
local items={};
function Show(cfgs)
    if cfgs then
        CSAPI.SetGOActive(gameObject,true);
        ItemUtil.AddItems("Pet/PetEmojiIconItem", items, cfgs, root)
    else
        Hide();
    end
end

function Hide()
    if IsNil(gameObject) then
        do return end
    end
    CSAPI.SetGOActive(gameObject,false);
end