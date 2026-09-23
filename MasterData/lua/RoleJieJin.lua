-- 解禁
local RoleJieJinItemData = require "RoleJieJinItemData"
local MechaJieJinItemData = require "MechaJieJinItemData"
local tabIndex, curIndex1, curIndex2 = nil, nil, nil
local isLive2D = false

function Awake()
    -- top
    local top = UIUtil:AddTop2("RoleJieJin", gameObject, function()
        view:Close()
    end, nil, {})
    top.SetHomeActive(false)

    -- icon
    cardIconItem = RoleTool.AddRole(item1, nil, nil, false)

    -- tab
    mTab = ComUtil.GetComInChildren(tabs, "CTab")
    mTab:AddSelChangedCallBack(OnTabChanged)

    -- 角色
    layout1 = ComUtil.GetCom(hsv1, "UISV")
    layout1:Init("UIs/RoleSkinComm/RoleJieJinItem", LayoutCallBack, true)
    layout1:AddOnValueChangeFunc(OnValueChange)
    svUtil1 = SVCenterDrag.New()

    -- 机神
    layout2 = ComUtil.GetCom(hsv2, "UISV")
    layout2:Init("UIs/RoleSkinComm/MechaJieJinItem", LayoutCallBack, true)
    layout2:AddOnValueChangeFunc(OnValueChange)
    svUtil2 = SVCenterDrag.New()

    -- event 
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Card_Update, function()
        InitDatas()
        RefreshPanel()
    end)

    cg_btnSure = ComUtil.GetCom(btnSure, "CanvasGroup")

    CSAPI.SetGOActive(mask, true)
end
function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index)
    item.Refresh(_data)
    item.SetIndex(index)
    item.SetClickCB(OnClickItem)
    item.SetSelect(index == curIndex)
end
function OnClickItem(index)
    layout:MoveToCenter(index)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    cardData = data
    InitDatas()

    mTab.selIndex = 0
end
-- 页签
function OnTabChanged(index)
    if (tabIndex and tabIndex == index) then
        return
    end
    tabIndex = index
    RefreshPanel()
end

function InitDatas()
    -- role
    roleDatas = {}
    local _open_cards = cardData:GetData().open_cards or {} -- 可用 
    local open_cards = {}
    for k, v in pairs(_open_cards) do
        open_cards[v.id] = 1
    end
    local changeCardIds = cardData:GetCfg().changeCardIds or {}
    for k, v in ipairs(changeCardIds) do
        local _data = RoleJieJinItemData.New()
        local isOpen = open_cards[v[1]] ~= nil
        local isUse = v[1] == cardData:GetCfgID()
        _data:Init(v, isOpen, isUse)
        table.insert(roleDatas, _data)
        if (isUse) then
            curIndex1 = k
        end
    end
    svUtil1:Init(layout1, #roleDatas, {274, 422}, 7, 0.1, 0.5)
    -- mecha
    mechaDatas = {}
    local _open_mechas = cardData:GetData().open_mechas or {} -- 可用 
    local open_mechas = {}
    for k, v in pairs(_open_mechas) do
        open_mechas[v.id] = 1
    end
    local allTcSkills = cardData:GetCfg().allTcSkills or {}
    local useSkillData = cardData:GetSpecialSkill()[1]
    for k, v in ipairs(allTcSkills) do
        local _data = MechaJieJinItemData.New()
        local isOpen = open_mechas[v[1]] ~= nil
        local isUse = useSkillData.id == v[1]
        _data:Init(v, isOpen, isUse)
        table.insert(mechaDatas, _data)
        if (isUse) then
            curIndex2 = k
        end
    end
    svUtil2:Init(layout2, #mechaDatas, {274, 422}, 7, 0.1, 0.5)
end

function RefreshPanel()
    curDatas = tabIndex == 0 and roleDatas or mechaDatas
    curIndex = tabIndex == 0 and curIndex1 or curIndex2
    curData = curDatas[curIndex]
    svUtil = tabIndex == 0 and svUtil1 or svUtil2
    layout = tabIndex == 0 and layout1 or layout2
    curModeId = curData:GetModelID()

    -- right
    CSAPI.SetGOActive(hsv1, tabIndex == 0)
    CSAPI.SetGOActive(hsv2, tabIndex ~= 0)
    -- role 
    SetRole()
    -- layout
    SetLayout()
    -- skill
    SetSkills()
    -- down 
    SetDown()
end

function SetLayout()
    if (not this["SetLayout" .. tabIndex]) then
        this["SetLayout" .. tabIndex] = 1
        CSAPI.SetGOActive(mask, true)
        layout:IEShowList(#curDatas, FirstCB, curIndex)
    else
        layout:UpdateList()
    end
end

function FirstCB()
    CSAPI.SetGOActive(mask, false)
    OnValueChange()
end

function SetRole()
    cardIconItem.Refresh(curModeId, LoadImgType.RoleInfo)
end

function SetSkills()
    newCardData = nil
    if (tabIndex == 0) then
        newCardData = RoleTool.GetNewCardData1(cardData, curData:GetCfgID())
    else
        newCardData = RoleTool.GetNewCardData2(cardData, curData:GetMonsterCfgID())
    end

    local newSkillDatas = newCardData:GetSkillsForShow()
    local ids = {}
    for k, v in ipairs(newSkillDatas) do
        table.insert(ids, v.id)
    end
    skillItems = skillItems or {}
    ItemUtil.AddItems("Role/RoleInfoSkillItem1", skillItems, ids, skillGrids, ClickSkillItemCB)

end
function ClickSkillItemCB(index)
    local newSkillDatas = newCardData:GetSkillsForShow()
    CSAPI.OpenView("RoleSkillInfoView", {newSkillDatas[index], newCardData}, 1)
end

function SetDown()
    -- desc
    local isOpen, lockStr = curData:CheckIsOpen()
    CSAPI.SetText(txt_desc, lockStr)
    -- btn 
    local lanID = 1001
    local alpha = 1
    if (not isOpen or curData:CheckIsUse()) then
        alpha = 0.3
        if (isOpen) then
            lanID = tabIndex == 0 and 4087 or 4088
        end
    end
    CSAPI.SetGOActive(btnImg1, alpha == 1)
    CSAPI.SetGOActive(btnImg2, alpha ~= 1)
    LanguageMgr:SetText(txtSure1, lanID)
    LanguageMgr:SetEnText(txtSure2, lanID)
    cg_btnSure.alpha = alpha
end

--------------------------------------------------------------

function OnValueChange()
    local index = layout:GetCurIndex()
    if index + 1 ~= curIndex then
        local item = layout:GetItemLua(curIndex)
        if item then
            item.SetSelect(false)
        end
        lastIdx = curIndex
        curIndex = index + 1
        if (tabIndex == 0) then
            curIndex1 = curIndex
        else
            curIndex2 = curIndex
        end
        local item = layout:GetItemLua(curIndex)
        if (item) then
            item.SetSelect(true);
        end
        if curIndex < lastIdx then
            PlayMoveTween(true)
        else
            PlayMoveTween()
        end
        SetArrow()
    end
    svUtil:Update()
end

function SetArrow()
    local _arrow1 = tabIndex == 0 and arrow1 or arrow11
    local _arrow2 = tabIndex == 0 and arrow2 or arrow22
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
        RefreshPanel()
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
    CSAPI.OpenView("RoleInfoAmplification", {curModeId, isLive2D}, LoadImgType.RoleInfo)
end

-- 替换
function OnClickSure()
    if (cg_btnSure.alpha ~= 1) then
        return
    end
    local _data = tabIndex == 0 and roleDatas[curIndex] or mechaDatas[curIndex2]
    if (tabIndex == 0) then
        PlayerProto:ChangeCardCfgId(cardData:GetID(), _data:GetCfgID())
    else
        local oldSkillData = cardData:GetSpecialSkill()[1]
        PlayerProto:ChangeCardTcSkill(cardData:GetID(), oldSkillData.id, _data:GetSkillID())
    end
end
