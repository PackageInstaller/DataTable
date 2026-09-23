-- 选择角色
local BGSelectData = require("BGSelectData")

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    -- layout:AddBarAnim(0.4, false)
    layout:Init("UIs/CRoleDisplay/BGSelectItem", LayoutCallBack, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)

    btnS_cg = ComUtil.GetCom(btnS, "CanvasGroup")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Bag_Update, RefreshPanel)
end
function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, c_data:GetBG(), old_c_data:GetBG())
    end
end

function ItemClickCB(_data)
    if (c_data:GetBG() ~= _data:GetID()) then
        c_data:GetRet().bg = _data:GetID()
        OnClickBGSelectViewCB(3, false)
        layout:UpdateList()
        SetBtn(_data)
    end
end

function SetClickCB(_CB)
    OnClickBGSelectViewCB = _CB
end

function Refresh(_data)
    old_c_data = CRoleDisplayMgr:GetCopyData(_data) -- 缓存一份
    c_data = _data
    RefreshPanel()
end

function RefreshPanel()
    InitData()
    SetBtn()
end

function InitData()
    curDatas = {}
    local cfgs = Cfgs.CfgMenuBg:GetAll()
    for k, v in pairs(cfgs) do
        local _data = BGSelectData.New()
        _data:Init(v)
        table.insert(curDatas, _data)
    end
    table.sort(curDatas, function(a, b)
        if (a:GetSortIndex() == b:GetSortIndex()) then
            return a:GetID() < b:GetID()
        else
            return a:GetSortIndex() < b:GetSortIndex()
        end
    end)
    layout:IEShowList(#curDatas)
end

function SetBtn(_data)
    local curData = _data or GetCurData()
    local lanID = curData:IsGet() and "7012" or "7039"
    LanguageMgr:SetText(txtS1, lanID)
    LanguageMgr:SetEnText(txtS2, lanID)
    local alpha = 1
    if (not curData:IsGet() and curData:GetCfg().jumpID == nil) then
        alpha = 0.5
    end
    btnS_cg.alpha = alpha
end

function GetCurData()
    for k, v in pairs(curDatas) do
        if (v:GetID() == c_data:GetBG()) then
            return v
        end
    end
end

function OnClickC()
    local isSame = c_data:GetBG() == old_c_data:GetBG()
    c_data:GetRet().bg = old_c_data:GetBG() -- 数据还原进入之前的
    CSAPI.SetGOActive(gameObject, false)
    OnClickBGSelectViewCB(1, isSame)
end

function OnClickS()
    if (btnS_cg.alpha == 1) then
        local curData = GetCurData()
        if (curData:IsGet()) then
            local isSame = c_data:GetBG() == old_c_data:GetBG()
            CSAPI.SetGOActive(gameObject, false)
            OnClickBGSelectViewCB(2, isSame)
        else
            if (curData:GetCfg().jumpID) then
                JumpMgr:Jump(curData:GetCfg().jumpID)
            end
        end
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if OnClickC then
        OnClickC()
    end
end

