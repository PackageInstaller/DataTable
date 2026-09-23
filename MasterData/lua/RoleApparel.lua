local curIndex = nil
local isLive2D = true
local isFirst1 = false
-- local countDown = 0.46
-- local isFirst2 = true
local svUtil = nil
local isExist = true -- 卡牌是否已获得
local isLimitSkin, limitTime = false, nil
local timer = nil
local memorys = {}

function Awake()
    top = UIUtil:AddTop2("RoleApparel", gameObject, function()
        view:Close()
        if (openSetting and openSetting == 2 and data[2] ~= nil) then
            data[2]()
        end
    end, nil, {})

    cardIconItem = RoleTool.AddRole(item1, nil, nil, false)

    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/RoleSkinComm/SkinInfoItem2", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange)

    svUtil = SVCenterDrag.New()

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Card_Update, function()
        RefreshSkinInfo()
        useIndex = GetBaseIndex() -- 当前使用的
        RefreshPanel()
    end)
    -- eventMgr:AddListener(EventType.Card_Skin_Get, function()
    --     layout:UpdateList()
    --     RefreshPanel()
    -- end)
    -- eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh,SetASMRInfo)
    -- eventMgr:AddListener(EventType.Shop_Buy_Ret,SetASMRInfo)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    CSAPI.SetGOActive(mask, true)
end
-- 其它界面关闭
function OnViewClosed(viewKey)
    if (viewKey == "ShopView") then
        layout:UpdateList()
        local b = curDatas[curIndex]:CanShowL2d()
        RefreshPanel(b)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
    -- ABMgr:ReleaseABAllWithViewName("RoleApparel")
    -- ABMgr:RefreshProtectABList("RoleApparel",{})
    -- ABMgr:ClearRecordsWithViewName("RoleApparel")
    RoleABMgr:CheckRemoveAB("RoleApparel")
end

-- function Update()
--     if isFirst2 then
--         countDown = countDown - Time.deltaTime
--         if countDown <= 0 then
--             isFirst2 = false
--             CSAPI.SetGOActive(mask, false)
--         end
--     end
-- end

-- data => CharacterCardsData
function RefreshSkinInfo()
    -- 如果不是基础卡那么要更新皮肤数据(因为是临时数据)
    if (not cardData:IsBaseCard()) then
        local baseCardData = RoleMgr:GetData(cardData:GetID())
        cardData:GetData().skin_a = baseCardData:GetData().skin_a
        cardData:GetData().skinIsl2d_a = baseCardData:GetData().skinIsl2d_a
    end
end

function OnOpen()
    if (openSetting and openSetting == 2) then
        CSAPI.SetScale(arrow1, 0, 0, 0)
        CSAPI.SetScale(arrow2, 0, 0, 0)
        top.SetHomeActive(false)
        UIUtil:ShowSkin(data[1])
        InitLimitSkin()
    else
        cardData = data
        -- isMonster = openSetting
        InitSkinData()
    end
    RefreshPanel()
end

function Update()
    if (isLimitSkin and timer and Time.time >= timer) then
        timer = Time.time + 1
        local need = limitTime - TimeUtil:GetTime()
        local timeData = TimeUtil:GetTimeTab(need)
        LanguageMgr:SetText(txtLimitTime, 18127, timeData[1], timeData[2], timeData[3])
        if (need <= 0) then
            timer = nil
            SetBtn()
        end
    end
end

-- 限时皮肤领取 data: {模型表id,cb}
function InitLimitSkin()
    local modelID = data[1]
    local caracterCfg = Cfgs.character:GetByID(modelID)
    isExist, cardData = RoleMgr:CheckCfgIdExist(caracterCfg.card_id)
    if (not cardData) then
        cardData = RoleMgr:GetFakeData(caracterCfg.card_id)
    end
    curDatas = {} -- 仅展示当前解锁的限时皮肤
    table.insert(curDatas, RoleSkinMgr:GetRoleSkinInfo(caracterCfg.role_id, modelID))

    useIndex = GetBaseIndex() -- 当前使用的
    curIndex = 1
    -- items 
    svUtil:Init(layout, #curDatas, {274, 422}, 7, 0.1, 0.5)
    layout:IEShowList(#curDatas, FirstCB, curIndex)
end

-- data : CharacterCardsData
function InitSkinData()
    curDatas = {}
    local _curDatas = {}
    local cardCfgID = cardData:GetCfgID()
    -- if (isMonster) then
    --     cardCfgID = cardData:GetCfg().card_id
    -- end
    local infos = RoleSkinMgr:GetDatas(cardData:GetRoleID(), true)
    for i, v in pairs(infos) do
        if (v:IsThisCard(cardCfgID)) then
            table.insert(_curDatas, v)
        end
    end
    -- 非突破皮肤，未获得且不在出售时间内，要隐藏 
    for k, v in ipairs(_curDatas) do
        if (v:CheckCanUse()) then
            table.insert(curDatas, v)
        else
            if (not v:CheckIsNotBreakType() or v:IsInSell()) then
                table.insert(curDatas, v)
            end
        end
    end
    table.sort(curDatas, function(a, b)
        if (a:GetIndex() == b:GetIndex()) then
            return a:GetSkinID() < b:GetSkinID()
        else
            return a:GetIndex() < b:GetIndex()
        end
    end)
    useIndex = GetBaseIndex() -- 当前使用的
    isLive2D = cardData:GetSkinIsL2d()
    curIndex = curIndex ~= nil and curIndex or useIndex -- 当前点中的
    -- items 
    svUtil:Init(layout, #curDatas, {274, 422}, 7, 0.1, 0.5)
    layout:IEShowList(#curDatas, FirstCB, curIndex)
end

-- 第几个
function GetBaseIndex()
    local curSkinID = cardData:GetSkinID()
    for i, v in ipairs(curDatas) do
        if (v:GetSkinID() == curSkinID) then
            return i
        end
    end
    return 1
end

function FirstCB()
    if (not isFirst1) then
        isFirst1 = true
        CSAPI.SetGOActive(mask, false)
        OnValueChange()
    end
end

function RefreshPanel(isCheck)
    curModeId = curDatas[curIndex]:GetSkinID()
    cfgModel = Cfgs.character:GetByID(curModeId) 

    -- if #ABMgr:GetProtectABListByViewName("RoleApparel") == 0 then
    --     ABMgr:RefreshProtectABList("RoleApparel" ,ABMgr:GetABNameArrayWithID(curModeId))
    -- end
    -- ABMgr:RecordABWithModelIDInto("RoleApparel" ,curModeId)

    if (isCheck) then
        isLive2D = false
        if (curDatas[curIndex]:ToShowL2d()) then
            isLive2D = true
        end
        -- 如果是当前选择并且没选择l2d
        if (isLive2D and useIndex == curIndex and not cardData:GetSkinIsL2d()) then
            isLive2D = false
        end
        -- 记忆
        if (memorys[curModeId]~=nil) then
            isLive2D = memorys[curModeId]
        end
    end
    -- desc
    CSAPI.SetText(txt_desc, cfgModel.model_desc)
    -- l2d btn
    SetL2dBtn()
    -- role 
    SetImg()
    -- btn
    SetBtn()

    SetArrow()

    SetASMRInfo()

    SetLimitSkin()
end

function SetLimitSkin()
    isLimitSkin, limitTime = curDatas[curIndex]:IsLimitSkin()
    CSAPI.SetGOActive(txtLimit1, isLimitSkin)
    CSAPI.SetGOActive(txtLimit2, not isExist)
    timer = isLimitSkin and Time.time or nil
end

function SetArrow()
    if curIndex <= 1 then
        CSAPI.SetGOAlpha(arrow1, 0.48)
        CSAPI.SetGOAlpha(arrow2, 1)
    elseif curIndex == #curDatas then
        CSAPI.SetGOAlpha(arrow1, 1)
        CSAPI.SetGOAlpha(arrow2, 0.48)
    else
        CSAPI.SetGOAlpha(arrow1, 1)
        CSAPI.SetGOAlpha(arrow2, 1)
    end
end

-- l2d开关  data:IsHX() and cfgModel.shopImg or 
function SetL2dBtn()
    local b = cfgModel.l2dName ~= nil
    if (curDatas[curIndex]:IsHX()) then
        b = false -- 和谐中 
    end

    if (not b and isLive2D) then
        isLive2D = false
    end

    CSAPI.SetGOActive(btnL2D, b)
    if (b) then
        local name = "UIs/RoleSkinComm/btn_03_03.png"
        if isLive2D then
            name = "UIs/RoleSkinComm/btn_03_02.png"
        end
        CSAPI.LoadImg(l2dState, name, true, nil, true)
    end

end

-- role
function SetImg()
    RoleABMgr:ChangeByIDs("RoleApparel", {curModeId})
    -- CSAPI.SetGOActive(iconParent, false)
    -- cardIconItem.Refresh(curModeId, LoadImgType.RoleInfo, function(go)
    --     CSAPI.SetGOActive(iconParent, true)
    -- end, isLive2D)
    cardIconItem.Refresh(curModeId, LoadImgType.RoleInfo, nil, isLive2D, curDatas[curIndex]:IsHX())
    memorys[curModeId] = isLive2D
end

function SetBtn()
    local is1, lanId, tips, isShow = true, 18128, "", true -- 黄色，替换,提示,显示按钮
    -- 皮肤是否可用
    canUse = curDatas[curIndex]:CheckCanUse()
    jumId = nil
    if (canUse) then
        if (isExist) then
            -- 可用  已用/未用
            if (useIndex == curIndex) then
                local isL2d = cardData:GetSkinIsL2d()
                if (isL2d == isLive2D) then
                    is1, lanId = false, 18085
                end
            end
        else
            is1, lanId = false, 18131
        end
    else
        -- 不可用 突破解锁/其他跳转途径
        tips = cfgModel.get_txt
        if (curDatas[curIndex].type == CardSkinType.Break) then
            isShow = false
        else
            local getCondition = curDatas[curIndex]:GetCfg().getCondition
            if (getCondition) then
                is1, lanId = false, 18038
                jumId = getCondition[1]
            else
                -- 无跳转
                isShow = false
            end
        end
    end
    --
    if (lanId == 18131) then -- 未获得角色
        CSAPI.SetGOActive(txtNoGet, true)
        CSAPI.SetGOActive(btnSure, false)
    else
        CSAPI.SetGOActive(txtNoGet, false)
        CSAPI.SetGOActive(btnSure, isShow)
        if (isShow) then
            CSAPI.SetGOActive(btnImg1, is1)
            CSAPI.SetGOActive(btnImg2, not is1)
            LanguageMgr:SetText(txtSure1, lanId)
            LanguageMgr:SetEnText(txtSure2, lanId)
        end
    end
    --
    CSAPI.SetText(txt_tips, tips)
end

-- 更换
function OnClickSure()
    if (not isExist) then
        return -- 卡牌未获得
    end
    if (canUse) then
        -- if (cardData:IsBaseCard()) then
        --     RoleSkinMgr:UseSkin(cardData:GetID(), curModeId, cardData:GetSkinIDElse(), isLive2D)
        -- else
        --     RoleSkinMgr:UseSkin(cardData:GetID(), cardData:GetSkinIDBase(), curDatas[curIndex]:GetSkinID(),
        --         cardData:GetSkinIsL2dBase(), isLive2D)
        -- end
        local isLimitSkin, limitTime = curDatas[curIndex]:IsLimitSkin()
        if (isLimitSkin and (limitTime - TimeUtil:GetTime() <= 0)) then
            LanguageMgr:ShowTips(1054)
            return
        end
        -- 改为按绑定关系切换
        local skin_a = RoleTool.GetBDSkin_a(cardData:GetCfgID(), curModeId)
        RoleSkinMgr:UseSkin(cardData:GetID(), curModeId, skin_a, isLive2D, isLive2D)
        --ABMgr:RefreshProtectABList("RoleApparel",{})
        
    elseif (jumId) then
        -- local dialogdata = {}l
        -- local str = LanguageMgr:GetTips(3007, itemCfg.name, curDatas[curIndex]:GetCfg().key,
        --     curDatas[curIndex]:GetCfg().desc)
        -- dialogdata.content = str
        -- dialogdata.okCallBack = function()
        --     ShopProto:Buy(shopCfg.id, TimeUtil:GetTime(), 1, nil, RefreshPanel)
        -- end
        -- CSAPI.OpenView("Dialog", dialogdata)
        JumpMgr:Jump(jumId)
    end
end

--------------------------------------------------------------
function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index)
    item.Refresh(_data)
    item.SetIndex(index)
    item.SetClickCB(OnClickItem)
    -- item.SetIsUse(index == useIndex)
    item.SetSelect(index == curIndex)
end

function OnValueChange()
    local index = layout:GetCurIndex()
    if index + 1 ~= curIndex then
        local item = layout:GetItemLua(curIndex)
        if item then
            item.SetSelect(false)
        end
        lastIdx = curIndex
        curIndex = index + 1
        local item = layout:GetItemLua(curIndex)
        if (item) then
            item.SetSelect(true)
        end
        -- if not isFirst2 then
        --     FuncUtil:Call(function()
        if curIndex < lastIdx then
            PlayMoveTween(true)
        else
            PlayMoveTween()
        end
        --     end, nil, 1)
        -- end
        SetArrow()
    end
    svUtil:Update()
end

function OnClickItem(index)
    layout:MoveToCenter(index)
end

-- -- 播放立绘移动动画 isRTL:是否从右到左
-- function PlayMoveTween(isRTL)
--     local x1 = 0
--     local x2 = isRTL and 400 or -400
--     UIUtil:SetObjFade(iconNode, 1, 0, nil, 300, 0, 1)
--     UIUtil:SetPObjMove(iconNode, x1, x2, 0, 0, 0, 0, function()
--         RefreshPanel()
--         UIUtil:SetObjFade(iconNode, 0, 1, nil, 300, 100, 0)
--         UIUtil:SetPObjMove(iconNode, -x2, x1, 0, 0, 0, 0, nil, 300, 100)
--     end, 300, 0)
-- end

-- 播放立绘移动动画 isRTL:是否从右到左
function PlayMoveTween(isRTL)
    local x1 = 0
    local x2 = isRTL and 400 or -400
    if (isLive2D) then
        UIUtil:SetObjFade(item1, 1, 0, nil, 1, 299, 1)
    else
        UIUtil:SetObjFade(item1, 1, 0, nil, 300, 1, 1)
    end
    UIUtil:SetPObjMove(item1, x1, x2, 0, 0, 0, 0, function()
        RefreshPanel(true)
        if (isLive2D) then
            UIUtil:SetObjFade(item1, 0, 1, nil, 1, 1, 0)
        else
            UIUtil:SetObjFade(item1, 0, 1, nil, 300, 1, 0)
        end
        UIUtil:SetPObjMove(item1, -x2, x1, 0, 0, 0, 0, nil, 300, 1)
    end, 301, 1)
end

-------------------------------------------------------放大
-- 放大
function OnClickSearch()
    CSAPI.OpenView("RoleInfoAmplification", {curModeId, isLive2D, nil, nil, true}, LoadImgType.RoleInfo)
end

-- 动态开关
function OnClickKey()
    isLive2D = not isLive2D
    SetImg()
    SetL2dBtn()
    SetBtn()
end

function OnClickL2D()
    if (not isLive2D and curDatas[curIndex]:CheckIsBreakType() and not curDatas[curIndex]:CanShowL2d()) then
        LanguageMgr:ShowTips(3015)
        return
    end

    isLive2D = not isLive2D
    RefreshPanel()
end

function SetASMRInfo()
    local b, sIcon = IsShowASMRBtn()
    CSAPI.SetGOActive(btnASMR, b)
    if (not b) then
        return
    end
    ResUtil.ASMRShop:Load(asmrIcon, sIcon)

    comm = nil
    bindComm = nil
    --
    comm = ShopCommFunc.GetSkinCommodity(curModeId)
    local bindID = nil
    if comm then
        bindID = comm:GetBundlingID()
        if bindID then -- 初始化绑定物品信息
            bindComm = ShopMgr:GetFixedCommodity(bindID)
            if bindComm then
                local isLock = bindComm:GetBuySum() <= 0
                -- 加载图标
                -- ResUtil.ASMRShop:Load(asmrIcon, bindComm:GetIcon())
                -- CSAPI.SetGOActive(asmrLock, isLock)
                CSAPI.SetAnchor(asmrDisk, isLock and 0 or 72, 0)
            end
        end
    end
end

function IsShowASMRBtn()
    local cfg = Cfgs.character:GetByID(curModeId)
    if (cfg.shopId) then
        local cfg2 = Cfgs.CfgCommodity:GetByID(cfg.shopId)
        if (cfg2 and cfg2.bundlingID ~= nil) then
            local cfg3 = Cfgs.CfgCommodity:GetByID(cfg2.bundlingID)
            return true, cfg3.sIcon
        end
    end
    return false
end

function OnClickASMR()
    if bindComm and comm then
        local isLock = bindComm:GetBuySum() <= 0
        if isLock then -- 根据绑定类型做逻辑
            -- if comm:GetBundlingType() == ShopCommBindType.Show then -- 点击弹出购买窗口
            --     local pageData = ShopMgr:GetPageByID(bindComm:GetShopID());
            --      ShopCommFunc.OpenPayView(bindComm, pageData);
            -- else
            --     OnClickBuy();
            -- end
            JumpMgr:Jump(140201)
        end
    else -- 弹出跳转确认窗口
        local dialogdata = {
            content = LanguageMgr:GetTips(46003),
            okCallBack = function()
                JumpMgr:Jump(80003);
            end
        }
        CSAPI.OpenView("Dialog", dialogdata);
    end
end

-- 购买
function OnClickBuy()
    if comm then
        local cost = comm:GetRealPrice(shopPriceKey)[1];
        if cost == nil or cost.id ~= -1 then
            CSAPI.OpenView("ShopSkinBuy", comm, shopPriceKey);
        else
            ShopCommFunc.HandlePayLogic(comm, 1,  nil, OnSuccess, shopPriceKey);
        end
    end
end
