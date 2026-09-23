-- 先选角色，再调整参数
local slot = 1 -- 槽位的某个孔
local lIndex = 1 -- 左侧栏index
local lIsShow = false
local _CRoleSelectView = nil
local _BGSelectView = nil
local isdx = false -- 是否是多选（前5个槽位改成多选）
local oldRoleIDs = {}

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/CRoleDisplay/CRoleDisplayItem", LayoutCallBack, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    cardIconItem1 = RoleTool.AddRole(iconParent1)
    --mulIconItem1 = RoleTool.AddMulRole(iconParent1)
    cardIconItem2 = RoleTool.AddRole(iconParent2)

    cg_btnBC = ComUtil.GetCom(btnBC, "CanvasGroup") -- 保存
    -- slider
    InitSlider()
    -- 
    uiHandle = ComUtil.GetCom(movePoint, "UIHandle")
    uiHandle:InitParm(1, 1, g_CardLookScale[1], g_CardLookScale[2])
    uiHandle:SetSliderCB(SetSliderValue)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.CRoleDisplayDX_Refresh, DXRefresh)
end

function OnDestroy()
    eventMgr:ClearListener()
    MoveBG(false)
    CSAPI.RemoveSliderCallBack(AdjustSlider, SliderCB1)
    CSAPI.RemoveSliderCallBack(dobSlider1, SliderCB1)
    CSAPI.RemoveSliderCallBack(dobSlider2, SliderCB2)
    RoleABMgr:CheckRemoveAB("CRoleDisplay")
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = lDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, lIndex, data:GetIDs()[slot], isdx)
    end
end

function ItemClickCB(index)
    if (lIndex and lIndex == index) then
        return
    end
    lIndex = index
    -- id
    c_data:GetRet().ids[slot] = lDatas[lIndex]:GetSkinID()
    -- l2d 
    local l2d = false
    if (c_data:CanShowL2d(slot)) then
        l2d = true
    end
    c_data:GetDetail(slot).live2d = l2d
    -- 
    layout:UpdateList()
    RefreshPanel()
end

function InitSlider()
    dob_Slider0 = ComUtil.GetCom(AdjustSlider, "Slider")
    dob_Slider1 = ComUtil.GetCom(dobSlider1, "Slider")
    dob_Slider2 = ComUtil.GetCom(dobSlider2, "Slider")
    dob_Slider0.minValue = g_CardLookScale[1]
    dob_Slider0.maxValue = g_CardLookScale[2]
    dob_Slider1.minValue = g_CardLookScale[1]
    dob_Slider1.maxValue = g_CardLookScale[2]
    dob_Slider2.minValue = g_CardLookScale[1]
    dob_Slider2.maxValue = g_CardLookScale[2]
    CSAPI.SetText(txtAdjustSlider3, math.floor(g_CardLookScale[1] * 100) / 100 .. "")
    CSAPI.SetText(txtAdjustSlider2, math.floor(g_CardLookScale[2] * 100) / 100 .. "")
    CSAPI.SetText(dobSlider11, math.floor(g_CardLookScale[1] * 100) / 100 .. "")
    CSAPI.SetText(dobSlider12, math.floor(g_CardLookScale[2] * 100) / 100 .. "")
    CSAPI.SetText(dobSlider21, math.floor(g_CardLookScale[1] * 100) / 100 .. "")
    CSAPI.SetText(dobSlider22, math.floor(g_CardLookScale[2] * 100) / 100 .. "")
    CSAPI.AddSliderCallBack(AdjustSlider, SliderCB1)
    CSAPI.AddSliderCallBack(dobSlider1, SliderCB1)
    CSAPI.AddSliderCallBack(dobSlider2, SliderCB2)
end

function OnOpen()
    isdx = false
    if (data.index <= 5 and data.sNewPanel.ty == 1) then
        isdx = true
    end
    --
    slot = openSetting -- 当前槽位的某个孔
    c_data = CRoleDisplayMgr:GetCopyData(data) -- 使用复制的数据

    --
    local selectModelID = c_data:GetIDs()[slot]
    if (selectModelID == 0) then
        -- 如果是双人并且另外一个已有人
        if (c_data:IsTwoRole() and c_data:CheckIsEntity()) then
            RefreshPanel0()
        end
        -- 打开选人
        CSAPI.SetAnchor(AdaptiveScreen, 0, 10000, 0)
        OpenSelectRole()
    else
        -- 直接展示
        RefreshPanel0()
        -- if (isdx) then
        --     OpenSelectRole()
        -- end
    end
    -- bg 
    SetBG()
    --  
    MoveBG(true)

    -- 
    LanguageMgr:SetText(txtQX, isdx and 7089 or 1002)
    LanguageMgr:SetText(txtBC, isdx and 7088 or 7002)
end

-- 将bg移动到主界面的bg下
function MoveBG(isMove)
    if (isMove) then
        local menuGO = CSAPI.GetView("Menu")
        local menuLua = menuGO and ComUtil.GetLuaTable(menuGO) or nil
        if (menuLua) then
            CSAPI.SetParent(bg, menuLua.bg)
        end
    else
        CSAPI.RemoveGO(bg)
    end
end

function RefreshPanel0()
    SetLeft()
    RefreshPanel()
end
function SetLeft()
    local selectModelID = c_data:GetIDs()[slot]
    lIsShow = true
    if (selectModelID < 10000) then
        lIsShow = false
    end
    CSAPI.SetGOActive(left, lIsShow)
    lDatas = nil
    if (lIsShow) then
        -- lDatas
        lDatas = {}
        local info = CRoleMgr:GetCRoleByModelID(selectModelID)
        if (not info) then
            LogError("找不到模型：" .. selectModelID ..
                         "的角色数据(不是旧数据与表不匹配就是表没配或配错了)")
            return
        end
        lDatas = info:GetAllSkinsArr(true)
        for k, v in ipairs(lDatas) do
            if (v:GetSkinID() == selectModelID) then
                lIndex = k
                break
            end
        end
        layout:IEShowList(#lDatas)
    end
end
function SetBG()
    local cfg = Cfgs.CfgMenuBg:GetByID(c_data:GetBG())
    if (cfg and cfg.name) then
        ResUtil:LoadMenuBg(bg, "UIs/" .. cfg.name, false, function()
            CSAPI.SetScale(bg, 1.05, 1.05, 1)
        end)
    end
    --
    ResUtil.BGIcon:Load(imgBg, cfg.icon)
    CSAPI.SetText(txtBgName, cfg.sName)
end

function RefreshPanel()
    SetGet()
    SetMiddle()
    SetDobs()
    SetSliders()
    SetBtns()
    SetHandle()
end

function SetGet()
    local isCanUse, str = c_data:GetCanUse(slot), ""
    if (lIsShow and not isCanUse) then
        CSAPI.SetText(txtNoGet, lDatas[lIndex]:GetCfg().get_txt)
        CSAPI.SetGOActive(objNoGet, true)
    else
        CSAPI.SetGOActive(objNoGet, false)
    end
end

function SetMiddle()
    -- btnL2D
    local hadL2D = c_data:ShowBtnL2D(slot)
    CSAPI.SetGOActive(btnL2D, hadL2D)
    if (hadL2D) then
        local detail = c_data:GetDetail(slot)
        CSAPI.SetGOActive(allOn, detail.live2d)
        CSAPI.SetGOActive(allOff, not detail.live2d)
    end
    -- items 
    SetItem(1, c_data:GetIDs()[1], cardIconItem1, iconParent1, c_data)
    -- SetItem(1, c_data:GetIDs()[1], mulIconItem1, false, iconParent1)
    SetItem(2, c_data:GetIDs()[2], cardIconItem2, iconParent2, c_data)
    -- 
    local top = iconParent2
    if (c_data:GetDetail(1) and c_data:GetDetail(1).top) then
        top = iconParent1
    end
    top.transform:SetAsLastSibling()

    RoleABMgr:ChangeByIDs("CRoleDisplay", c_data:GetIDs())
end
function SetItem(slot, id, item, iconParent, curDisplayData)
    if (id and id ~= 0) then
        if (oldRoleIDs[slot] ~= id) then
            item.ClearCache()
        end
        oldRoleIDs[slot] = id
        --
        CSAPI.SetGOActive(item.gameObject, true)
        local detail = curDisplayData:GetDetail(slot)
        CSAPI.SetAnchor(iconParent, detail.x, detail.y, 0)
        CSAPI.SetScale(iconParent, detail.scale, detail.scale, 1)
        item.Refresh(id, LoadImgType.Main, nil, detail.live2d, curDisplayData:IsShowShowImg(slot))
    else
        item.ClearCache()
        CSAPI.SetGOActive(item.gameObject, false)
    end
end

function SetDobs()
    CSAPI.SetGOActive(slider0, not c_data:IsTwoRole())
    CSAPI.SetGOActive(dob, c_data:IsTwoRole())
    if (c_data:IsTwoRole()) then
        SetDob(1)
        SetDob(2)
    end
end
function SetDob(_slot)
    local id = c_data:GetIDs()[_slot] or 0
    CSAPI.SetGOActive(this["dobEmpty" .. _slot], id == 0)
    CSAPI.SetGOActive(this["dobEntity" .. _slot], id ~= 0)
    if (id ~= 0) then
        -- icon 
        local cfg = Cfgs.character:GetByID(id)
        local detail = c_data:GetDetail(_slot)
        ResUtil.RoleCard:Load(this["dobIcon" .. _slot], cfg.icon)
        CSAPI.SetText(this["dobName" .. _slot], cfg.key)
        CSAPI.SetGOActive(this["dobTop" .. _slot], detail.top)
        CSAPI.SetGOActive(this["dobDown" .. _slot], not detail.top)
        CSAPI.SetGOActive(this["select" .. _slot], slot == _slot)
    end
end

function SetSliders()
    if (c_data:IsTwoRole()) then
        dob_Slider1.value = c_data:GetDetail(1).scale
        dob_Slider2.value = c_data:GetDetail(2).scale
    else
        dob_Slider0.value = c_data:GetDetail(1).scale
    end
end

function SetBtns()
    if (isdx) then
        local alpha = 0.3
        local id = c_data:GetIDs()[1]
        if (id and id ~= 0) then
            local b = true
            if (id > 10000) then
                -- 长度未满；当前角色有皮肤在用 时true
                -- if (lDatas) then
                --     local skinID = lDatas[lIndex]:GetSkinID()
                --     local skinData = RoleSkinMgr:GetSkinInfoByModelID(skinID)
                --     if (skinData and skinData:CheckCanUse()) then
                --         local info = CRoleMgr:GetCRoleByModelID(skinID)
                --         isUse = CRoleDisplayMgr:CheckRoleIsUse(info)
                --         if (isUse or CRoleDisplayMgr:CheckCanAdd()) then
                --             b = true
                --         end
                --     end
                -- end
                -- 改 长度未满，当前皮肤在用 时true
                if (lDatas) then
                    local skinID = lDatas[lIndex]:GetSkinID()
                    local skinData = RoleSkinMgr:GetSkinInfoByModelID(skinID)
                    if (not skinData or not skinData:CheckCanUse()) then
                        b = false
                    end
                else
                    b = false
                end
            else
                local mulData = MulPicMgr:GetData(id)
                if (not mulData or not mulData:IsHad()) then
                    b = false
                end
            end
            alpha = b and 1 or 0.3
        end
        cg_btnBC.alpha = alpha
    else
        -- 保存
        local alpha = 1
        local ids = c_data:GetIDs()
        for k, v in ipairs(ids) do
            if (v ~= 0 and not c_data:GetCanUse(k)) then
                alpha = 0.3
                break
            end
        end
        cg_btnBC.alpha = alpha
    end
end

-- -- 动态切换
-- function OnClickL2D()
--     if (slot == 1) then
--         c_data:GetDetail(1).live2d = not c_data:GetDetail(1).live2d
--     else
--         c_data:GetDetail(2).live2d = not c_data:GetDetail(2).live2d
--     end
--     SetMiddle()
-- end

-- 重置当前
function OnClickCZ()
    if (slot == 1) then
        c_data:GetDetail(1).x = 0
        c_data:GetDetail(1).y = 0
        c_data:GetDetail(1).scale = 1
    else
        c_data:GetDetail(2).x = 0
        c_data:GetDetail(2).y = 0
        c_data:GetDetail(2).scale = 1
    end
    SetMiddle()
    SetSliders()
end

-- 选人
function OpenSelectRole(_slot)
    _slot = _slot or slot
    -- CSAPI.SetAnchor(AdaptiveScreen, 0, 10000, 0)
    ShowRight(false)
    if (not _CRoleSelectView) then
        ResUtil:CreateUIGOAsync("CRoleDisplay/CRoleSelectView", gameObject, function(go)
            _CRoleSelectView = ComUtil.GetLuaTable(go)
            _CRoleSelectView.SetClickCB(OnClickCRoleDisplayCB)
            _CRoleSelectView.Refresh({c_data, _slot}, isdx)
        end)
    else
        CSAPI.SetGOActive(_CRoleSelectView.gameObject, true)
        _CRoleSelectView.Refresh({c_data, _slot}, isdx)
    end
end

-- 1，2，3:取消，设置，点选
function OnClickCRoleDisplayCB(type, isSame)
    if (isdx and type == 1) then
        CRoleDisplayMgr:SetCopyUsing2()
        view:Close()
        return
    end
    CSAPI.SetAnchor(AdaptiveScreen, 0, 0, 0)
    if (type == 1) then
        -- 取消
        if (c_data:CheckIsEntity()) then
            if (c_data:IsTwoRole() and c_data:GetIDs()[slot] == 0) then
                if (isSame) then
                    if (slot == 2) then
                        OnClickDob1()
                    else
                        OnClickDob2()
                    end
                else
                    slot = slot == 2 and 1 or 2
                end
            end
        else
            view:Close()
            return
        end
    end
    if (type ~= 3) then
        -- CSAPI.SetAnchor(AdaptiveScreen, 0, 0, 0)
        ShowRight(true)
    end
    if (not isSame) then
        RefreshPanel0()
    end
end

-- 更换背景
function OnClickChangeBG()
    -- CSAPI.SetAnchor(AdaptiveScreen, 0, 10000, 0)
    ShowRight(false)
    if (not _BGSelectView) then
        ResUtil:CreateUIGOAsync("CRoleDisplay/BGSelectView", gameObject, function(go)
            _BGSelectView = ComUtil.GetLuaTable(go)
            _BGSelectView.SetClickCB(OnClickBGSelectViewCB)
            _BGSelectView.Refresh(c_data)
        end)
    else
        CSAPI.SetGOActive(_BGSelectView.gameObject, true)
        _BGSelectView.Refresh(c_data)
    end
    -- CSAPI.OpenView("BGSelectView", function(id, isBack)
    --     SetBG(id)
    --     if (isBack) then
    --         CSAPI.SetAnchor(AdaptiveScreen, 0, 0, 0)
    --     end
    -- end)
end

-- 1，2，3:取消，设置，点选
function OnClickBGSelectViewCB(type, isSame)
    if (type ~= 3) then
        -- CSAPI.SetAnchor(AdaptiveScreen, 0, 0, 0)
        ShowRight(true)
    end
    if (not isSame) then
        SetBG()
    end
end

function ShowRight(b)
    CSAPI.SetGOActive(roleMask, not b)
    CSAPI.SetGOActive(right, b)
end

-----------------------------------------------------------------------------------------------
-- 重置位置
-- function InitHandlePos()
--     for k = 1, 2 do
--         CSAPI.SetAnchor(this["iconParent" .. k], 0, 0, 0)
--         CSAPI.SetScale(this["iconParent" .. k], 1, 1, 1)
--     end
-- end

-- 将修改保存到detail
function ChangeToDetail()
    local ids = c_data:GetIDs()
    for k, v in ipairs(ids) do
        if (v ~= 0) then
            local iconParent = this["iconParent" .. k]
            local x, y = CSAPI.GetAnchor(iconParent)
            local scale = CSAPI.GetScale(iconParent)
            local detail = c_data.sNewPanel["detail" .. k]
            detail.x = FuncUtil.Round2Num(x)
            detail.y = FuncUtil.Round2Num(y)
            detail.scale = FuncUtil.Round2Num(scale)
            c_data.sNewPanel["detail" .. k] = detail
        end
    end
end

function GetSliderBySlot()
    if (c_data:IsTwoRole()) then
        if (slot == 1) then
            return dob_Slider1, dobSlider1
        else
            return dob_Slider2, dobSlider2
        end
    else
        return dob_Slider0, AdjustSlider
    end
end

-- 设置那个可控
function SetHandle()
    local iconParent = this["iconParent" .. slot]
    uiHandle:Init(iconParent)
end

-- 鼠标或者手势放大缩小
function SetSliderValue()
    local slider, sliderGO = GetSliderBySlot()
    CSAPI.RemoveSliderCallBack(sliderGO, this["SliderCB" .. slot])
    local scale = CSAPI.GetScale(this["iconParent" .. slot])
    slider.value = scale
    CSAPI.AddSliderCallBack(sliderGO, this["SliderCB" .. slot])
end

function SliderCB1(num)
    CSAPI.SetScale(iconParent1, num, num, 1)
end
function SliderCB2(num)
    CSAPI.SetScale(iconParent2, num, num, 1)
end

-- 多选的刷新
function DXRefresh()
    if (lIsShow) then
        layout:UpdateList()
    end
    SetBtns()
end

-----------------------------------------------------------------------------------------------
-- 动态开关
function OnClickL2D()
    if (not c_data:CanShowL2d(slot)) then
        LanguageMgr:ShowTips(3015)
        return
    end
    --
    if (slot == 1) then
        c_data:GetDetail(1).live2d = not c_data:GetDetail(1).live2d
    else
        c_data:GetDetail(2).live2d = not c_data:GetDetail(2).live2d
    end
    SetMiddle()
end

-- 取消
function OnClickQX()
    if (isdx) then
        OnClickQH()
    else
        ChangeToDetail()
        local isSame = FuncUtil.TableIsSame(data, c_data)
        if (isSame) then
            view:Close()
        else
            local str = LanguageMgr:GetTips(27004)
            UIUtil:OpenDialog(str, function()
                view:Close()
            end)
        end
    end
end

-- 切换
function OnClickQH()
    ChangeToDetail()
    OpenSelectRole()
end

-- 保存
function OnClickBC()
    if (cg_btnBC.alpha ~= 1) then
        if (isdx) then
            LanguageMgr:ShowTips(27016)
        end
        return
    end
    if (isdx) then
        ChangeToDetail()
        -- OpenSelectRole()
        local skinID = lIsShow and lDatas[lIndex]:GetSkinID() or c_data:GetIDs()[1]
        local isUse, v = CRoleDisplayMgr:CheckSkinIsUse(skinID)
        if (isUse) then
            c_data:GetRet().idx = v:GetIdx() -- 更新索引
            CRoleDisplayMgr:RefreshData(c_data) -- 仅修改GetRet
        else
            local toIndex = nil
            if (not CRoleDisplayMgr:CheckCanAdd()) then
                toIndex = data:GetIndex()
            end
            CRoleDisplayMgr:UseOrRemove(false, skinID, c_data, toIndex)
        end
        LanguageMgr:ShowTips(27017)
    else
        ChangeToDetail()
        local isSame = FuncUtil.TableIsSame(data, c_data)
        if (not isSame) then
            if (data:GetTy() == 2 or data:GetTy() == 3) then
                CRoleDisplayMgr:SetCRoleDisplayS()
            end
            if (data:GetTy() ~= 1) then
                PlayerProto:SetRandomPanel(c_data:GetRet())
            else
                data:InitRet(c_data:GetRet())
                EventMgr.Dispatch(EventType.CRoleDisplayMain_Refresh)
            end
        end
        view:Close()
    end
end

function OnClickTop1()
    ChangeToDetail()
    local id = c_data:GetIDs()[2]
    if (not c_data:GetDetail(1).top and id ~= nil and id ~= 0) then
        c_data:GetDetail(1).top = true
        c_data:GetDetail(2).top = false
        c_data:GetDetail(2).live2d = false
        RefreshPanel()
    end
end

function OnClickTop2()
    ChangeToDetail()
    local id = c_data:GetIDs()[1]
    if (not c_data:GetDetail(2).top and id ~= nil and id ~= 0) then
        c_data:GetDetail(2).top = true
        c_data:GetDetail(1).top = false
        c_data:GetDetail(1).live2d = false
        RefreshPanel()
    end
end

function OnClickDob1()
    if (slot == 1) then
        return
    end
    ChangeToDetail()
    if (dobEmpty1.activeSelf) then
        OpenSelectRole(1)
    else
        slot = 1
        RefreshPanel0()
    end
end

function OnClickDob2()
    if (slot == 2) then
        return
    end
    ChangeToDetail()
    if (dobEmpty2.activeSelf) then
        OpenSelectRole(2)
    else
        slot = 2
        RefreshPanel0()
    end
end

---返回虚拟键公共接口
function OnClickVirtualkeysClose()
    OnClickQX()
end
