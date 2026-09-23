-- 皮肤 data : RoleSkinInfo
function Awake()
    image_node = ComUtil.GetCom(node, "Image")
end

function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

-- _data：CRoleInfo  
function Refresh(_data, _elseData)
    data = _data
    elseData = _elseData or {}
    isSelect = elseData.isSelect == nil and false and elseData.isSelect -- 默认不选中 
    isRayCast = elseData.isRayCast == nil and true or elseData.isRayCast -- 默认可点

    -- 
    SetClick(isRayCast)
    -- select
    CSAPI.SetGOActive(select, isSelect)
    -- icon
    SetIcon(data:GetBaseIcon())
end


function SetClick(b)
    image_node.raycastTarget = b
end

function OnClick()
    if (cb) then
        cb(index)
    end
end

function SetIcon(_iconName)
    if (_iconName) then
        ResUtil.RoleCard:Load(icon, _iconName)
    end
end

