function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if (data[1]) then
        LanguageMgr:SetText(txtName1, data[1])
        LanguageMgr:SetEnText(txtName2, data[1])

        LanguageMgr:SetText(txtName3, data[1])
        LanguageMgr:SetEnText(txtName4, data[1])

        CSAPI.LoadImg(icon, "UIs/" .. data[2] .. ".png", true, nil, true)
        Select(false)
    else
        local cg = ComUtil.GetOrAddCom(gameObject, "CanvasGroup")
        cg.alpha = 0
    end
end

function Select(b)
    if (nodeCanvasGroup == nil) then
        nodeCanvasGroup = ComUtil.GetCom(clickNode, "CanvasGroup")
    end
    nodeCanvasGroup.alpha = b and 1 or 0.5

    --
    CSAPI.SetGOActive(arrow, b)

    --
    CSAPI.SetRTSize(line, b and 27 or 12, 4)

    -- 
    CSAPI.SetGOActive(txtName1, b)
    CSAPI.SetGOActive(txtName3, not b)

    isSelect = b
end

-- 刷新红点
function SetRed(b)
    if (b and isSelect) then
        b = false
    end
    UIUtil:SetRedPoint2("Common/Red2", red, b)
end

function OnClick()
    if (data[1]) then
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
    line = nil;
    clickNode = nil;
    icon = nil;
    txtName = nil;
    txtName2 = nil;
    mask = nil;
    childPoint = nil;
    red = nil;
    view = nil;
end
----#End#----
