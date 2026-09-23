function OnOpen()
    optionDatas = data[1] --数据  {{desc = "xxx"},{desc = "xxx"}...}
    cb = data[2]          --选中回调
    posGO = data[3]       --位置参照
    --  
    local pos = CSAPI.csGetPos(posGO)
    local p2 = transform:InverseTransformPoint(UnityEngine.Vector3(pos[0], pos[1], pos[2]))
    CSAPI.SetAnchor(node, p2.x, p2.y, 0)
    --  
    items = items or {}
    ItemUtil.AddItems("TeamConfirm/RogueSTeamDownListItem", items, optionDatas, bg, ItemClickCB)
end

function ItemClickCB(index)
    if (cb) then
        cb(index)
    end
    view:Close()
end


function OnClickMask()
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
