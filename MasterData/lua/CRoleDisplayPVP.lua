-- 先选角色，再调整参数
local slot = 1 -- 槽位的某个孔
local lIndex = 1 -- 左侧栏index
local lIsShow = false
local _CRoleSelectView = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/CRoleDisplay/CRoleDisplayItem", LayoutCallBack, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    cardIconItem = RoleTool.AddRole(iconParent)
    mulIconItem = RoleTool.AddMulRole(iconParent)

    cg_btnBC = ComUtil.GetCom(btnBC, "CanvasGroup") -- 保存
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = lDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, lIndex, data.role_panel_id)
    end
end

function ItemClickCB(index)
    if (lIndex and lIndex == index) then
        return
    end
    lIndex = index
    layout:UpdateList()
    SetData()
    RefreshPanel()
end

function OnDestroy()
    RoleABMgr:CheckRemoveAB("CRoleDisplayPVP")
end

function OnOpen()
    local modelID = data.role_panel_id
    local live2d = data.live2d == BoolType.Yes
    c_data = CRoleDisplayMgr:CreateDisplayData(modelID, live2d)

    SetLeft()
    RefreshPanel()
end

function SetLeft()
    local modelID = c_data:GetIDs()[slot]
    lIsShow = true
    if (modelID < 10000) then
        lIsShow = false
    end
    CSAPI.SetGOActive(left, lIsShow)
    if (lIsShow) then
        lDatas = {}
        local cRole = CRoleMgr:GetCRoleByModelID(modelID)
        lDatas = cRole:GetAllSkinsArr(true)
        for k, v in ipairs(lDatas) do
            if (v:GetSkinID() == modelID) then
                lIndex = k
                break
            end
        end
        layout:IEShowList(#lDatas)
    end
end

function SetData()
    local skinInfo = lDatas[lIndex]
    local modelID = skinInfo:GetSkinID()
    local live2d = false
    if (skinInfo:CheckCanUse() and skinInfo:GetL2dName() ~= nil) then
        live2d = true
    end
    c_data = CRoleDisplayMgr:CreateDisplayData(modelID, live2d)
end

function RefreshPanel()
    SetGet()
    SetMiddle()
    SetBtns()
end

function SetGet()
    local isCanUse = c_data:GetCanUse(slot)
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
    local detail = c_data:GetDetail(slot)
    local id = c_data:GetIDs()[1]
    CSAPI.SetGOActive(cardIconItem.gameObject, id >= 10000)
    CSAPI.SetGOActive(mulIconItem.gameObject, id < 10000)
    if (id > 10000) then
        cardIconItem.Refresh(c_data:GetIDs()[1], LoadImgType.Main, nil, detail.live2d, c_data:IsShowShowImg(slot))
    else 
        mulIconItem.Refresh(c_data:GetIDs()[1], LoadImgType.Main, nil, detail.live2d, c_data:IsShowShowImg(slot))
    end
    
    RoleABMgr:ChangeByIDs("CRoleDisplayPVP", c_data:GetIDs())
end

function SetBtns()
    -- 保存
    local alpha = 1
    local id = c_data:GetIDs()[slot]
    local live2d = c_data:GetDetail(slot).live2d
    local _live2d = data.live2d == BoolType.Yes
    if (not c_data:GetCanUse(slot) or (id == data.role_panel_id and live2d == _live2d)) then
        alpha = 0.3
    end
    cg_btnBC.alpha = alpha
end

-- 选人
function OpenSelectRole(_slot)
    _slot = _slot or slot
    CSAPI.SetAnchor(AdaptiveScreen, 0, 10000, 0)
    if (not _CRoleSelectView) then
        ResUtil:CreateUIGOAsync("CRoleDisplay/CRoleSelectView", gameObject, function(go)
            _CRoleSelectView = ComUtil.GetLuaTable(go)
            _CRoleSelectView.SetClickCB(OnClickCRoleDisplayCB)
            _CRoleSelectView.Refresh({c_data, _slot})
        end)
    else
        CSAPI.SetGOActive(_CRoleSelectView.gameObject, true)
        _CRoleSelectView.Refresh({c_data, _slot})
    end
end

-- 1，2，3:取消，设置，点选
function OnClickCRoleDisplayCB(type, isSame)
    if (type == 1) then
        -- 取消
        view:Close()
        return
    end
    if (type ~= 3) then
        CSAPI.SetAnchor(AdaptiveScreen, 0, 0, 0)
    end
    if (not isSame) then
        SetLeft()
        RefreshPanel()
    end
end

-----------------------------------------------------------------------------------------------
-- 动态开关
function OnClickL2D()
    if (not c_data:CanShowL2d(slot)) then
        LanguageMgr:ShowTips(3015)
        return
    end
    --
    c_data:GetDetail(slot).live2d = not c_data:GetDetail(slot).live2d
    SetBtns()
    SetMiddle()
end

-- 取消
function OnClickQX()
    view:Close()
end

-- 切换
function OnClickQH()
    OpenSelectRole()
end

-- 保存
function OnClickBC()
    if (cg_btnBC.alpha ~= 1) then
        return
    end
    local _type = c_data:GetDetail(slot).live2d and 2 or 1
    ArmyProto:SetRolePanel(c_data:GetIDs()[slot], _type)
    view:Close()
end

---返回虚拟键公共接口
function OnClickVirtualkeysClose()
    OnClickQX()
end
