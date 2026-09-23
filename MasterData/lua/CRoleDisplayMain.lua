local curTab = nil
local isAnim = true
local oldRandom
local oldUsing

function Awake()
    mTab = ComUtil.GetCom(tabs, "CTab")
    mTab:AddSelChangedCallBack(OnTabChanged)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.CRoleDisplayMain_Refresh, RefreshPanel)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.CRoleDisplayDX_Refresh, RefreshPanel)
    UIUtil:AddTop2("CRoleDisplayMain", gameObject, Level, function()
        Level(true)
    end, {})
end

function Level(isHome)
    CSAPI.SetGOActive(mask, true)

    CRoleDisplayMgr:SetRandon(oldRandom, oldUsing)

    local isSame = false
    if (FuncUtil.TableIsSame(c_panelRet, CRoleDisplayMgr:GetPanelRet()) and
        FuncUtil.TableIsSame(c_datas, CRoleDisplayMgr:GetDatas())) then
        isSame = true -- 数据无改动
    end
    local func = function()
        if (isHome) then
            UIUtil:ToHome()
        else
            view:Close()
        end
    end
    if (not isSame) then
        local panels = {}
        for k, v in pairs(c_datas) do
            panels[v:GetIndex()] = v:GetRet()
        end
        PlayerProto:SetNewPanel(panels, c_panelRet.setting, c_panelRet.random, c_panelRet.using, func)
    else
        func()
    end
    CRoleDisplayMgr:ClearCopyData()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnTabChanged(index)
    curTab = index
    c_panelRet.setting = curTab
    if (curTab == 0) then
        -- c_panelRet.random = 0
        SetDown()
    end
end

function OnOpen()
    -- 使用复制的数据 
    c_datas = CRoleDisplayMgr:GetCopyDatas()
    c_panelRet = CRoleDisplayMgr:GetCopyPanelRet()
    RefreshPanel()

    isAnim = false

    oldRandom = c_panelRet.random
    oldUsing = c_panelRet.using
end

function RefreshPanel()
    SetItems()
    SetDown()
end

function SetItems()
    -- items
    items = items or {}
    local n = 0
    for k = 1, 6 do
        local data = c_datas[k]
        local item = items[k]
        local parent = k == 6 and grids2 or grids1
        if (item) then
            item.Refresh(data)
            n = n + 1
            ItemsAnim(n)
        else
            ResUtil:CreateUIGOAsync("CRoleDisplay/CRoleDisplayMainItemConta", parent, function(go)
                item = ComUtil.GetLuaTable(go)
                item.Refresh(data, isAnim)
                table.insert(items, item)
                n = n + 1
                ItemsAnim(n)
            end)
        end
    end
end

function ItemsAnim(n)
    if (isAnim and n >= 6) then
        -- 1-5
        for k = 1, 5 do
            UIUtil:SetPObjMove(items[k].node, 100, 0, 0, 0, 0, 0, nil, 400, 40 * (k - 1) + 1)
            UIUtil:SetObjFade(items[k].node, 0, 1, nil, 200, 40 * (k - 1) + 1, 0)
        end
        -- 6
        -- isAnim传入子
    end
end

function SetDown()
    -- 轮换设置 
    if (not curTab) then
        curTab = c_panelRet.setting or 0
        mTab.selIndex = curTab
    end
    -- 随机 
    sjIndex = c_panelRet.random or 0
    CSAPI.SetGOActive(objSJNormal, sjIndex == 0)
    CSAPI.SetGOActive(objSJSel, sjIndex == 1)
    CSAPI.SetGOActive(randomMask, sjIndex == 1)
end

function OnClickSJ()
    if (sjIndex == 0) then
        -- 先判断是否已有设置好的随机看板
        local b, idx = CRoleDisplayMgr:CheckCanRandom()
        if (not b) then
            LanguageMgr:ShowTips(27007)
            return
        end
        c_panelRet.using = idx
        LanguageMgr:ShowTips(27005)
    else
        LanguageMgr:ShowTips(27006)
        c_panelRet.using = CRoleDisplayMgr:GetUsefulUsing()
    end
    sjIndex = sjIndex == 0 and 1 or 0
    CSAPI.SetGOActive(objSJNormal, sjIndex == 0)
    CSAPI.SetGOActive(objSJSel, sjIndex == 1)
    CSAPI.SetGOActive(randomMask, sjIndex == 1)
    c_panelRet.random = sjIndex
    if (sjIndex == 1 and curTab == 0) then
        mTab.selIndex = 1
    end
    --
    SetItems()
    -- 触发保存
    ToSave()
end

function OnViewOpened(viewKey)
    if (viewKey == "CRoleDisplay" and gameObject ~= nil) then
        CSAPI.SetScale(gameObject, 0, 0, 0)
    end
end
function OnViewClosed(viewKey)
    if (viewKey == "CRoleDisplay" and gameObject ~= nil) then
        CSAPI.SetScale(gameObject, 1, 1, 1)
    end
end

---返回虚拟键公共接口
function OnClickVirtualkeysClose()
    Level()
end

-- 更多设置
function OnClickSet()
    CSAPI.OpenView("CRoleDisplaySet")
end

function ToSave()
    -- local isSame = false
    -- if (FuncUtil.TableIsSame(c_panelRet, CRoleDisplayMgr:GetPanelRet()) and
    --     FuncUtil.TableIsSame(c_datas, CRoleDisplayMgr:GetDatas())) then
    --     isSame = true -- 数据无改动
    -- end
    -- if (not isSame) then
    --     local panels = {}
    --     for k, v in pairs(c_datas) do
    --         panels[v:GetIndex()] = v:GetRet()
    --     end
    --     PlayerProto:SetNewPanel(panels, c_panelRet.setting, c_panelRet.random, c_panelRet.using)
    -- end
    CRoleDisplayMgr:SetRandon(c_panelRet.random, c_panelRet.using)
    SetItems()
end

-- 编辑
function OnClickBJ()
    CSAPI.OpenView("CRoleDisplayS")
end
