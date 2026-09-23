-- 选择角色
local timeSort1 = 1 -- 早到后 
local timeSort2 = 1 -- 多人插图
-- local sortLua1 = nil
-- local sortLua2 = nil
local _useRoleID = nil
local _usePanelID = nil

local curTabIndex = 1 -- 单人看板
local curID = nil -- 当前角色id或多人插图id
local isRole = true -- curID是否是角色
local isdx = false

function Awake()
    AdaptiveConfiguration.SetLuaObjUIFit("CRoleSelectView", AdaptiveScreen)

    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/CRoleItem/CRoleLittleItem", LayoutCallBack, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/CRoleDisplay/CRoleMulItem", LayoutCallBack, true)
    tlua2 = UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.Normal)

    layout3 = ComUtil.GetCom(vsv3, "UIInfinite")
    layout3:Init("UIs/CRoleDisplay/CRoleHalfBodyItem", LayoutCallBack, true)
    tlua3 = UIInfiniteUtil:AddUIInfiniteAnim(layout3, UIInfiniteAnimType.Normal)

    -- cg_btnOne = ComUtil.GetCom(btnOne, "CanvasGroup")
    -- cg_btnMore = ComUtil.GetCom(btnMore, "CanvasGroup")

    cg_btns = ComUtil.GetOrAddCom(btnS, "CanvasGroup")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.CRoleDisplayDX_Refresh, DXRefresh)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local layout = GetLayout()
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, curID, isdx)
    end
end
function ItemClickCB(_data)
    if (curID and _data:GetID() == curID) then
        return
    end
    isRole = curTabIndex == 1 -- 第一页全是角色
    curID = _data:GetID()
    -- 
    SetBtn()
    -- 
    Show(_data)
    -- 
    local layout = GetLayout()
    layout:UpdateList()
    SetNoGet()
end

function Show(_data)
    if (isdx) then
        local isUse, modelID, _v = false, curID, nil
        if (isRole) then
            local useSkin = nil
            isUse, useSkin, _v = CRoleDisplayMgr:CheckRoleIsUse(_data)
            if (isUse) then
                modelID = useSkin
            else 
                modelID = RoleMgr:GetSkinIDByRoleID(curID) 
            end
        else
            isUse, _v = CRoleDisplayMgr:CheckSkinIsUse(modelID)
        end
        if (isUse) then
            c_data:InitIndex(_v:GetIndex())
            c_data:InitRet(table.copy(_v:GetRet()))
        else
            c_data:InitDetail(slot, modelID)
        end
    else
        local modelID = isRole and RoleMgr:GetSkinIDByRoleID(curID) or curID
        if (modelID == old_c_data:GetIDs()[slot]) then
            c_data.sNewPanel["detail" .. slot] = table.copy(old_c_data.sNewPanel["detail" .. slot])
            c_data.sNewPanel.ids = table.copy(old_c_data.sNewPanel.ids)
        else
            c_data:InitDetail(slot, modelID)
        end
    end
    OnClickCRoleDisplayCB(3, false)
end

function SetClickCB(_CB)
    OnClickCRoleDisplayCB = _CB
end

function Refresh(_data, _isdx)
    isdx = _isdx
    old_c_data = CRoleDisplayMgr:GetCopyData(_data[1]) -- 缓存一份
    c_data = _data[1]
    slot = _data[2]

    if (c_data:GetTy() == 4) then
        CSAPI.SetGOActive(topBtns1, false)
        CSAPI.SetGOActive(topBtns2, true)
        CSAPI.SetGOActive(btnMore, false)
    else
        CSAPI.SetGOActive(topBtns1, not c_data:CanSelectPic())
        CSAPI.SetGOActive(topBtns2, c_data:CanSelectPic())
    end

    isRole = true
    curTabIndex = 1
    curID = nil
    local id = c_data:GetIDs()[slot]
    if (id ~= nil and id ~= 0) then
        if (id < 10000) then
            local cfg = Cfgs.CfgArchiveMultiPicture:GetByID(id)
            curTabIndex = cfg.nType == 1 and 2 or 3
            isRole = false
        end
        curID = curTabIndex == 1 and Cfgs.character:GetByID(id).role_id or id
    end

    RefreshPanel()

    -- 
    CSAPI.SetGOActive(btnCK, isdx)
    LanguageMgr:SetText(txtC1, isdx and 7087 or 1002)
end
function RefreshPanel0()
    if (curTabIndex == 1) then
        tlua1:AnimAgain()
    elseif (curTabIndex == 2) then
        tlua2:AnimAgain()
    else
        tlua3:AnimAgain()
    end
    RefreshPanel()
end

function RefreshPanel()
    SetDatas()
    SetTab()
    -- sort 
    local angle = timeSort1 == 1 and 180 or 0
    CSAPI.SetAngle(objSort, 0, 0, angle)
    -- btn 
    local lanID = curTabIndex == 1 and 7012 or 1048
    if (isdx) then
        lanID = 7090
    end
    LanguageMgr:SetText(txtS1, lanID)
    -- LanguageMgr:SetEnText(txtS2, lanID)
    --
    SetBtn()
    --
    SetNoGet()
end

function SetDatas()
    CSAPI.SetGOActive(vsv1, curTabIndex == 1)
    CSAPI.SetGOActive(vsv2, curTabIndex == 2)
    CSAPI.SetGOActive(vsv3, curTabIndex == 3)
    local sortId = 5
    if (curTabIndex ~= 1) then
        sortId = curTabIndex == 2 and 6 or 27
    end
    if (not sortLua) then
        ResUtil:CreateUIGOAsync("Sort/SortTop", sortParent, function(go)
            sortLua = ComUtil.GetLuaTable(go)
            sortLua.Init(sortId, RefreshPanel0)
        end)
    else
        sortLua.Init(sortId, RefreshPanel0)
    end

    curDatas = {}
    if (curTabIndex == 1) then
        curDatas = SortMgr:Sort(sortId, CRoleMgr:GetDatas())
        SetSelectToFirst()
        layout1:IEShowList(#curDatas)
    else
        -- 如果未获得，判断是否隐藏，不隐藏的话则要判断是否在可售时间内 
        local arr = {}
        local _arr = MulPicMgr:GetArr(true, curTabIndex - 1)
        for k, v in ipairs(_arr) do
            if (v:IsHad() or v:IsShow()) then
                table.insert(arr, v)
            end
        end
        curDatas = SortMgr:Sort(sortId, arr)
        SetSelectToFirst()
        GetLayout():IEShowList(#curDatas)
    end
    CSAPI.SetGOActive(SortNone, #curDatas <= 0)
end

function SetSelectToFirst()
    if (isdx and #curDatas > 1) then
        local firstDatas = {}
        local len = #curDatas
        for k = len, 1, -1 do
            local isUse = false
            if (curTabIndex == 1) then
                isUse = CRoleDisplayMgr:CheckRoleIsUse(curDatas[k])
            else
                isUse = CRoleDisplayMgr:CheckSkinIsUse(curDatas[k]:GetID())
            end
            if (isUse) then
                table.insert(firstDatas, curDatas[k])
                table.remove(curDatas, k)
            end
        end
        for k, v in ipairs(firstDatas) do
            table.insert(curDatas, 1, v)
        end
    end
end

function SetTab()
    if (not c_data:IsTwoRole()) then
        CSAPI.SetGOActive(normal1, curTabIndex ~= 1)
        CSAPI.SetGOActive(sel1, curTabIndex == 1)
        CSAPI.SetGOActive(normal2, curTabIndex ~= 2)
        CSAPI.SetGOActive(sel2, curTabIndex == 2)
        CSAPI.SetGOActive(normal3, curTabIndex ~= 3)
        CSAPI.SetGOActive(sel3, curTabIndex == 3)
    end
end

function SetBtn()
    local alpha = 0.3
    if (curID) then
        if (isRole) then
            alpha = 1
        else
            local _data = MulPicMgr:GetData(curID)
            if (_data:IsHad()) then
                alpha = 1
            end
        end
    end
    cg_btns.alpha = alpha
end

function SetNoGet()
    if (not isRole and curID) then
        local _data = MulPicMgr:GetData(curID)
        CSAPI.SetGOActive(objNoGet, not _data:IsHad())
        if (not _data:IsHad()) then
            CSAPI.SetText(txtNoGet, _data:GetCfg().get_txt or "")
        end
    else
        CSAPI.SetGOActive(objNoGet, false)
    end
end

function DXRefresh()
    if(gameObject.activeSelf)then 
        GetLayout():UpdateList()
    end 
end

function OnClickOne()
    if (curTabIndex == 1) then
        return
    end
    curTabIndex = 1
    RefreshPanel()
end

function OnClickMore()
    if (curTabIndex == 2) then
        return
    end
    curTabIndex = 2
    RefreshPanel()
end

function OnClickHalf()
    if (curTabIndex == 3) then
        return
    end
    curTabIndex = 3
    RefreshPanel()
end

-- 取消
function OnClickC()
    if (isdx) then
        OnClickCRoleDisplayCB(1)
    else
        local isSame = FuncUtil.TableIsSame(c_data.sNewPanel, old_c_data.sNewPanel)
        c_data.sNewPanel = old_c_data.sNewPanel -- 数据还原进入之前的
        CSAPI.SetGOActive(gameObject, false)
        OnClickCRoleDisplayCB(1, isSame)
    end
end

-- 设置
function OnClickS()
    if (cg_btns.alpha == 1) then
        local isSame = FuncUtil.TableIsSame(c_data.sNewPanel, old_c_data.sNewPanel)
        CSAPI.SetGOActive(gameObject, false)
        OnClickCRoleDisplayCB(2, isSame)
    end
end

function OnClickMask()
    OnClickC()
end

function GetLayout()
    local layout = layout1
    if (curTabIndex ~= 1) then
        layout = curTabIndex == 2 and layout2 or layout3
    end
    return layout
end

-- 清空多选
function OnClickCK()
    CRoleDisplayMgr:RemoveAll()
    LanguageMgr:ShowTips(27014)
end
