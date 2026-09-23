local itemName = "PlayerAbility/AbilityItem"
local isShow = false
local curSelectID = 0
local elseData = nil
local isCanClick = true
local isNoEnough = true -- 升级
local skillInfoPanel = nil
local lItems = {}

local lines = {}
local intervalTime = 0
local dotIntervalTime = 10
local dotPool = {}

local top=nil;
---是否移动平台
local IsMobileplatform=false;
--inpt
local Input=UnityEngine.Input
local KeyCode=UnityEngine.KeyCode

function Awake()
    CSAPI.Getplatform();
    IsMobileplatform=CSAPI.IsMobileplatform;
    CSAPI.SetGOActive(right, false)
    local iconName = Cfgs.ItemInfo:GetByID(g_ResetAbilityCost[1][1]).icon
    if (iconName) then
        ResUtil.IconGoods:Load(imgReset, iconName)
    end
end

function OnInit()
    top=UIUtil:AddTop2("PlayerAbility", topNode, OnClickBack, OnClickHome, {})
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Player_Ability_Refresh, RefreshPanel)
    -- EventMgr.Dispatch(EventType.Matrix_View_Show_Changed, false)
    eventMgr:AddListener(EventType.Player_Ability_Add, OnSkillAdd)
    eventMgr:AddListener(EventType.Player_Ability_CanClick, OnItemClick)
end

function OnDisable()
    eventMgr:ClearListener();
    --EventMgr.Dispatch(EventType.Matrix_View_Show_Changed, true)
end

---判断检测是否按了返回键
function CheckVirtualkeys()
    --仅仅安卓或者苹果平台生效
    if IsMobileplatform then
        if(Input.GetKeyDown(KeyCode.Escape))then
            --  OnVirtualkey()   调关闭
            if CSAPI.IsBeginnerGuidance()==false then
                if isShow then
                    OnClickReturn()
                else
                    if  top.OnClickBack then
                        top.OnClickBack();
                    end
                end
            end

        end
    end
end
function Update()
    CheckVirtualkeys()
    if intervalTime > 0 then
        intervalTime = intervalTime - (Time.deltaTime * 1000)
    else
        PlayDotAction(1)
        intervalTime = 3500
    end
end

function OnOpen()
    CSAPI.PlayUISound("ui_hints_error")
    RefreshPanel()
    CSAPI.OpenView("AbilityInfoView")
end

function RefreshPanel()
    local count = PlayerClient:GetCoin(g_AbilityCoinId)
    CSAPI.SetText(txtSkill2, count .. "")
    SetMiddle()
    SetInfo()
end

function OnSkillAdd()
    if curSelectItem then
        if not curSelectItem.IsSkill() then
            CSAPI.PlayUISound("ui_battle_victory_settlement")
        end
        curSelectItem.AddSkill()
    end
end

function SetMiddle()
    mItems = mItems or {}
    lItems = lItems or {}
    lines = lines or {}
    local arr = PlayerAbilityMgr:GetArr(true)
    for i = #arr + 1, #mItems do
        CSAPI.SetGOActive(mItems[i].gameObject, false)
    end
    for i, v in ipairs(arr) do
        if (i <= #mItems) then
            CSAPI.SetGOActive(mItems[i].gameObject, true)
            mItems[i].Refresh(v, curSelectID)
            mItems[i].SetLineColor()
        else
            ResUtil:CreateUIGOAsync(itemName, Contentm, function(go)
                local rect = ComUtil.GetCom(go, "RectTransform")
                local item = ComUtil.GetLuaTable(go)
                rect.anchorMax = UnityEngine.Vector2(0, 0.5)
                rect.anchorMin = UnityEngine.Vector2(0, 0.5)
                item.SetClickCB(ItemClickCB)
                item.Refresh(v, curSelectID)
                item.SetPos()
                lines = item.SetLine(lineParent, lines)
                table.insert(mItems, item)
            end)
        end
    end
    SetComtentmHeight(arr[#arr]:GetCfg().pos[2])
end

function SetComtentmHeight(lastY)
    local len = PlayerAbilityMgr:GetHeight(lastY)
    CSAPI.SetRectSize(Contentm, len, 0)
end

function ItemClickCB(_item)
    if isCanClick then
        curSelectID = _item.data:GetID()

        local _data = {
            Contentm = Contentm,
            item = _item
        }
        EventMgr.Dispatch(EventType.Player_AbilityInfo_ViewPos, _data)
        EventMgr.Dispatch(EventType.Player_AbilityInfo_ViewActive, true)

        local itemData = _item.data
        if (curSelectItem) then
            curSelectItem.SetSelect(false)
        end
        curSelectItem = _item
        curSelectItem.SetSelect(true)

        isShow = true
        SetInfo()
    end
end

function SetInfo()
    if (not isShow) then
        EventMgr.Dispatch(EventType.Player_AbilityInfo_ViewActive, false)
        CSAPI.SetScriptEnable(sv, "ScrollRect", true)
        CSAPI.SetGOActive(clickMask, false)
        if curSelectItem then
            curSelectItem.SetSelect(false)
        end
        return
    end
    CSAPI.SetGOActive(clickMask, true)
    EventMgr.Dispatch(EventType.Player_AbilityInfo_ViewActive, true)
    CSAPI.SetScriptEnable(sv, "ScrollRect", false)
    local curData = curSelectItem and curSelectItem.data or nil
    EventMgr.Dispatch(EventType.Player_AbilityInfo_Refresh, curData)
end

------------------------------------------点移动--------------------------------------------

-- 点动画
function PlayDotAction(id)
    local item = mItems[id]
    if item then
        FuncUtil:Call(function()
            if (gameObject) then
                isFirst = true
                item.PlayDotAction(this)
            end
        end, nil, isFirst and dotIntervalTime or 0)
    end
end

function GetDot()
    if (#dotPool > 0) then
        local go = dotPool[1]
        table.remove(dotPool, 1)
        CSAPI.SetGOActive(go, true)
        return go
    end
    return ResUtil:CreateUIGO("PlayerAbility/PlayerAbilityDot")
end

function RecycleDot(go)
    dotPool = dotPool or {}
    CSAPI.SetGOActive(go, false)
    table.insert(dotPool, go)
end

---------------------------------------------------------------------------

function OnClickReset()
    if (not PlayerAbilityMgr:CheckCanReset()) then
        Tips.ShowTips(LanguageMgr:GetByID(9007))
    else
        local str1 = "XXX"
        local str2 = "XXX"
        local CostValue=0;
        if (g_ResetAbilityCost) then
            local cost = g_ResetAbilityCost[1]
            local cfg = Cfgs.ItemInfo:GetByID(cost[1])
            CostValue=cost[2];
            str1 = StringUtil:SetColor(cost[2], "orange")
            str2 = StringUtil:SetColor(cfg.name, "orange")
        end
        local dialogData = {}
        dialogData.content = PlayerAbilityMgr:IsFreeReset() and LanguageMgr:GetByID(9013) or string.format(LanguageMgr:GetByID(9008), str1, str2)
        dialogData.okCallBack = function()
            if CSAPI.IsADVRegional(3) and not PlayerAbilityMgr:IsFreeReset() then
                CSAPI.ADVJPTitle(CostValue,function()
                    CSAPI.PlayUISound("ui_page_battle_start")
                    AbilityProto:ResetAbility()
                end)
            else
                CSAPI.PlayUISound("ui_page_battle_start")
                AbilityProto:ResetAbility()
            end
        end
        CSAPI.OpenView("Dialog", dialogData)
    end
end

-- 升级
function OnClickUp()
    local curData = curSelectItem and curSelectItem.data or nil
    if (curData and curData:GetIsLock()) then
        PlayerAbilityMgr:ShowTips(curData)
    else
        local isSkill = curData:GetCfg().type == AbilityType.SkillGroup
        if (isSkill) then
            local skills, isMax = curData:GetSkills()
            if (not isMax) then
                local group = TacticsMgr:GetDataByID(curData:GetCfg().active_id)
                AbilityProto:SkillGroupUpgrade(group:GetCfgID())
            end
        end
    end
end

function OnClickReturn()
    isShow = false
    SetInfo()
end

function OnClickBack()
    view:Close()
end

function OnClickHome()
    UIUtil:ToHome()
end

function OnItemClick(isCan)
    isCanClick = isCan

    local sr = ComUtil.GetComInChildren(node, "ScrollRect");
    if (sr) then
        sr.enabled = isCan;
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
    uiLayer = nil;
    Contentm = nil;
    txtSkill1 = nil;
    txtSkill2 = nil;
    txtReset1 = nil;
    txtReset2 = nil;
    right = nil;
    entity = nil;
    lvObj = nil;
    txt1 = nil;
    txt2 = nil;
    txtLv1 = nil;
    txtLv2 = nil;
    txtName = nil;
    txtDesc = nil;
    skillObj = nil;
    btnUp = nil;
    txtUp1 = nil;
    txtUp2 = nil;
    txtNum1 = nil;
    txtNum2 = nil;
    clickMask = nil;
    topNode = nil;
    view = nil;
end
----#End#----
