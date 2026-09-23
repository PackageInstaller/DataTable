-- local minScale = 0.9
-- local len = 0

-- function Awake()
--     dc_clickNode = ComUtil.GetCom(clickNode, "DragCallLua")
--     cg_clickNode = ComUtil.GetCom(clickNode, "CanvasGroup")
-- end

function SetIndex(_index)
    index = _index
    --CSAPI.SetAnchor(gameObject, 137 + (index - 1) * 118, 0, 0) -- 位置 
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    data = _data

    -- len = _elseData[4]
    -- if (index == 1) then
    --     transform:SetSiblingIndex(0)
    -- elseif (index == len) then
    --     transform:SetSiblingIndex(1)
    -- end

    -- if (data.isFake) then
    --     cg_clickNode.alpha = 0
    --     return
    -- end

    cfgModel = Cfgs.character:GetByID(data:GetSkinID())

    -- local isUse = _elseData[1] == index
    -- isSelect = _elseData[2] == index
    -- dc_clickNode:SetScrollRect(_elseData[3])
    local isCanUse = data:CheckCanUse()

    --cg_clickNode.alpha = isSelect and 1 or 0.5

    -- name
    CSAPI.SetText(txtName1, cfgModel.key)
    CSAPI.SetText(txtName2, cfgModel.englishName or "")
    --CSAPI.SetGOActive(objUse, isUse)
    --SetSelect(isSelect)
    CSAPI.SetGOActive(objLock, not isCanUse)
    CSAPI.SetGOActive(objL2D, data:GetCfg().l2dName ~= nil)
    SetIcon()
end

function SetIcon(model)
    if (cfgModel.Card_head) then
        ResUtil.CardIcon:Load(icon, cfgModel.Card_head)
    end
end

-- function SetContentX(x)
--     if (not data.isFake) then
--         x = math.abs(x + CSAPI.GetAnchor(gameObject) - 255)
--         -- 转换大小  0是1  +-118是0.9 
--         scale = 1 - x / 1180
--         -- scale = scale < 0.9 and 0.9 or scale
--         CSAPI.SetScale(clickNode, scale, scale, 1)
--         -- cg_clickNode.alpha = scale >= 0.95 and 1 or 0.5
--         if (scale > 0.95) then
--             transform:SetSiblingIndex(len - 1)
--         elseif (scale > 0.85) then
--             transform:SetSiblingIndex(len - 2)
--         end
--     end
-- end

function OnClick()
    --if (not data.isFake) then
        cb(index)
    --end
end

-- function OnEndDrag()
--     if (not data.isFake) then
--         cb()
--     end
-- end

function SetIsUse(b)
    CSAPI.SetGOActive(objUse, b)
end

function SetSelect(b)
    CSAPI.SetGOActive(select, b)
    SetAlpha(b and 1 or 0.5);
end


function SetAlpha(val)
    CSAPI.SetGOAlpha(clickNode,val);
end

--根据X轴距离设置大小
function SetScale(s)
    CSAPI.SetScale(clickNode,s,s,s);
end

function GetPos()
    local pos={100000,100000,0};
    local x,y,z=CSAPI.GetPos(clickNode);
    pos={x,y,z}
    return pos;
end

function SetSibling(index)
    index=index or 0;
    if index==-1 then
        transform:SetAsLastSibling();
    else
        transform:SetSiblingIndex(index);
    end
end