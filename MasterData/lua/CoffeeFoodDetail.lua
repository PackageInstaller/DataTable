-- data {cfg,target}
function OnOpen()
    CSAPI.SetText(txtName, data[1].name)
    CSAPI.SetText(txtDesc, data[1].desc)
    local x1, y1, z1 = CSAPI.GetPos(data[2])
    CSAPI.SetPos(node, x1, y1, z1)
    --
    local x, y, z = CSAPI.GetAnchor(node)
    local size = CSAPI.GetMainCanvasSize()
    local _x = (x + 225) > size[0] / 2 and (size[0] / 2 - 225) or x
    CSAPI.SetAnchor(node, _x, y, z)
end

function OnClickMask()
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
