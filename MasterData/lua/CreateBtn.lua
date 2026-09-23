-- 建造栏
--local colorNames = {"3b8eff", "a845c5", "ffc146"}

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    -- icon
    local icon2 = data:GetCfg().icon2
    CSAPI.SetGOActive(icon, icon2 ~= nil)
    if (icon2) then
        ResUtil.Create:Load(icon, icon2)
        --CSAPI.LoadImg(icon, "UIs/Create/" .. icon2 .. ".png", true, nil, true)
    end
    SetSelect(false)

    -- 
    SetTips()

    SetRed()
end

-- tips 
function SetTips()
    local poolType = data:GetCfg().poolType
    CSAPI.SetGOActive(tips, poolType ~= nil)
    if (poolType) then
        local cfg = Cfgs.CfgPoolType:GetByID(poolType)
        CSAPI.LoadImg(imgTips, "UIs/Create/" .. cfg.icon .. ".png", true, nil, true) -- todo 
        StringUtil:SetColorByName(txtTips, cfg.sName, cfg.colorName or "ffffff")-- colorNames[poolType])
    end
end

function SetRed()
    local isRed = false
    local conditions = data:GetCfg().conditions
    if (conditions and 1003==data:GetCfg().id) then
        local _isOpen, lockStr = MenuMgr:CheckConditionIsOK(conditions)
        isRed = _isOpen
    end
    UIUtil:SetRedPoint(clickNode, isRed, 105, 41.6, 0)
end

function SetSelect(b)
    CSAPI.SetGOActive(select, b)
end

function OnClick()
    if (cb) then
        cb(index)
    end
end
function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    icon = nil;
    select = nil;
    view = nil;
end
----#End#----
