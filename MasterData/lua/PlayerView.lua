local elseData = nil
local fade = nil
local isAnim = false
local outBar = nil
local headItem = nil
local badgeItems = {}

function Awake()
    LanguageMgr:SetText(Placeholder, 8002, g_SignMaxLen)

    input_Sign = ComUtil.GetCom(inputSign, "InputField")

    fade = ComUtil.GetCom(gameObject, "ActionFade")

    outBar = ComUtil.GetCom(exp, "OutlineBar")
end

function OnInit()
    UIUtil:AddTop2("PlayerView", gameObject, OnClickClose)
    eventMgr = ViewEvent.New()
    -- 请求信息返回
    eventMgr:AddListener(EventType.Player_Info, EPlayerInfo)
    eventMgr:AddListener(EventType.Role_Card_Support, SetSupport)
    eventMgr:AddListener(EventType.Player_Select_Card, SetRole)
    eventMgr:AddListener(EventType.View_Lua_Opened,OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed)
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
    eventMgr:AddListener(EventType.Badge_Sort_Update, SetBadge)
    eventMgr:AddListener(EventType.Player_EditName,OnNameChange)
    eventMgr:AddListener(EventType.Player_SexOrName_Change,OnSexOrNameChange)
    -- CSAPI.AddInputFieldChange(inputSign, InputChange)
    -- CSAPI.AddInputFieldCallBack(inputSign, InputCB)
end

function OnViewOpened(viewKey)
    if viewKey == "RoleListSelectView" then
        CSAPI.SetGOActive(gameObject, false)
    end
end

function OnViewClosed(viewKey)
    if viewKey == "RoleListSelectView" then
        CSAPI.SetGOActive(gameObject, true)
    end
end

function OnNameChange()
    CSAPI.SetText(txtName, PlayerClient:GetName() .. "")
    -- LanguageMgr:ShowTips(30002)
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        ShiryuSDK.OnRoleInfoUpdate();
    end
end

function OnSexOrNameChange()
    FuncUtil:Call(function ()
        LanguageMgr:ShowTips(30002)
    end,this,200)
    SetSupport()
    SetHeadFrame()
end

function OnOpen()
    PlayerMgr:PlrPaneInfo()
    SetRole()
    SetPanel()
    -- isAnim = true
    -- fade:Play(0, 1, 150, 0, function()
    --     isAnim = false
    -- end)
end

function SetPanel()
    local timeStr = TimeUtil:GetTimeStr2(PlayerClient:GetCreateTime(), false)
    LanguageMgr:SetText(txtCTime, 8009, timeStr)
    -- name
    CSAPI.SetText(txtName, PlayerClient:GetName() .. "")
    -- uid
    CSAPI.SetText(txtUID, PlayerClient:GetUid() .. "")
    -- qm
    -- SetSign()
    -- support
    SetSupport()
    -- lv
    SetLv()

    SetHeadFrame()

    SetTitle()

    SetBadge()

    SetRed()
end

-- 设置等级
function SetLv()
    -- lv	
    local curLv = PlayerClient:GetLv()
    local maxLv = PlayerClient:GetMaxLv()
    CSAPI.SetText(txtLv1, string.format("%d", curLv))
    CSAPI.SetText(txtLv2, "/" .. maxLv)

    -- exp
    if curLv == maxLv then
        LanguageMgr:SetText(txtExp1,34004)
        CSAPI.SetText(txtExp2, "/" .. LanguageMgr:GetByID(34004))
        return
    end

    local curExp = PlayerClient:GetExp()
    local maxExp = GetMaxExp(curLv)
    CSAPI.SetText(txtExp1, curExp .. "")
    CSAPI.SetText(txtExp2, "/" .. maxExp)

    outBar:SetProgress(curExp / maxExp)
end

function GetMaxExp(lv)
    local cfg = Cfgs.CfgPlrUpgrade:GetByID(lv)
    return cfg and cfg.nNextExp or 0
end

function SetRed()
    local _pData = RedPointMgr:GetData(RedPointType.HeadFrame)
    local _pData2 = RedPointMgr:GetData(RedPointType.Head)
    local _pData3 = RedPointMgr:GetData(RedPointType.Title)
    local _pData4 = RedPointMgr:GetData(RedPointType.Face)
    local _isRed = false 
    if(_pData ~= nil or _pData2 ~= nil or _pData3 ~= nil or _pData4 ~= nil) then 
        _isRed = true 
    end 
    UIUtil:SetRedPoint2("Common/Red2", iconNode, _isRed, 89, 91, 0)

    local _pData3 = RedPointMgr:GetData(RedPointType.Badge)
    local _isRed2 = false 
    if _pData3 ~= nil then
        _isRed2 = true
    end
    UIUtil:SetRedPoint2("Common/Red2", badgeRed, _isRed2)
end

-- 玩家信息返回
function EPlayerInfo(proto)
    local pData = proto.info
    -- 队员收集
    local cur, max = CRoleMgr:GetCount()
    CSAPI.SetText(txtDysj2, cur .. "/" .. max)
    -- 最高段位
    -- local cfgExercise = Cfgs.CfgPracticeRankLevel:GetByID(pData.max_rank_level or 0)
    -- local zgdwRate = cfgExercise and cfgExercise.name or "--"
    -- CSAPI.SetText(txtZgdw2, zgdwRate .. "")
    -- 剧情进度
    local max_dup = pData.max_dup or 0
    local mDungeonCfg = Cfgs.MainLine:GetByID(max_dup)
    CSAPI.SetText(txtJqjd2, mDungeonCfg and mDungeonCfg.chapterID or "")
    -- local mDungeonCfg = DungeonMgr:GetMainLineOpenDungeon()
    -- CSAPI.SetText(txtJqjd2, mDungeonCfg and mDungeonCfg.chapterID or "")
    -- 基地等级
    local buildLv = pData.build_control_lv or 0
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtJddj2, lvStr .. buildLv)
    -- local bulidData = MatrixMgr:GetMainBuilding()
    -- CSAPI.SetText(txtJddj2, "LV." .. bulidData:GetLv())
    -- 爬塔进度
    -- local max_tower = pData.max_tower or 0
    -- local tDungeonCfg = Cfgs.MainLine:GetByID(max_tower)
    -- CSAPI.SetText(txtPtjd2, tDungeonCfg and tDungeonCfg.name or "")
end

function SetRole()
    -- role
    -- local cfgModel = Cfgs.character:GetByID(PlayerClient:GetIconId())
    -- if cfgModel and cfgModel.icon then
    --     ResUtil.RoleCard:Load(role, cfgModel.icon, true)
    --     CSAPI.SetScale(role, 0.87, 0.87)
    -- end

    -- RoleTool.LoadImg(role, PlayerClient:GetIconId(), LoadImgType.Main)
end

function SetHeadFrame()
    UIUtil:AddHeadFrame(headParent, 1)
end

function SetTitle()
    UIUtil:AddTitle(titleParent,0.8)
end

function SetBadge()
    local badgeDatas = BadgeMgr:GetSortArr()
    for i = 1, (g_BadgeMax or 6) do
        if i <= #badgeItems then
            badgeItems[i].Refresh(badgeDatas[i])
        else
            ResUtil:CreateUIGOAsync("Badge/BadgeGridItem",badgeParent,function (go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetIndex(i)
                lua.SetClickCB(OnBadgeClickCB)
                lua.Refresh(badgeDatas[i])
                lua.SetScale(0.6)
                badgeItems[i] = lua
            end)
        end
    end
end

function OnBadgeClickCB(item)
    CSAPI.OpenView("BadgeView",item.index or 0)
end

function OnClickBadge()
    CSAPI.OpenView("BadgeView",1)
end

-- -- 设置签名
-- function SetSign(_str)
--     local str = ""
--     if (_str) then
--         str = _str
--     else
--         str = PlayerClient:GetSign()
--     end
--     str = MsgParser:getString(str) -- 屏蔽字体用***代替
--     input_Sign.text = str
-- end

-- function InputChange(_str)
--     _str = StringUtil:SetStringByLen(_str, g_SignMaxLen, "")
--     _str = StringUtil:FilterChar(_str)
--     SetSign(_str)
-- end

-- function InputCB(_str)
--     _str = StringUtil:SetStringByLen(_str, g_SignMaxLen, "")
--     _str = StringUtil:FilterChar(_str)
--     SetSign(_str)

--     -- 修改签名
--     local str = input_Sign.text
--     if (str ~= PlayerClient:GetSign()) then
--         PlayerMgr:Sign(str)
--     end
-- end

--------------------------------支援-------------------------------------
-- 协战信息
function SetSupport()
    teamData = TeamMgr:GetTeamData(eTeamType.Assistance)
    -- typeList = {};
    supportList = supportList or {};
    for i = 1, 3 do
        local cardData = nil
        if teamData and teamData.data[i] then
            cardData = teamData.data[i]:GetCard()
        end
        if (supportList[i]) then
            supportList[i].Refresh(cardData)
        else
            ResUtil:CreateUIGOAsync("Player/PlayerSupportItem", supportGrid, function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.Refresh(cardData)
                supportList[i] = lua;
            end)
        end
    end
end

function OnClickCopy()
    LanguageMgr:ShowTips(6011)
    UnityEngine.GUIUtility.systemCopyBuffer = PlayerClient:GetUid() .. ""
end

function OnClickName()
    -- LanguageMgr:ShowTips(30001)
    CSAPI.OpenView("InfoCorrBox")
end

function OnClickClose()
    if isAnim then
        return
    end
    isAnim = true
    fade:Play(1, 0, 150, 0, function()
        view:Close()
        isAnim = false
    end)
end

function OnClickIcon()
    CSAPI.OpenView("HeadFramePanel")
end

function OnClickSex()
    -- if BagMgr:GetCount(25501) > 0 then
        CSAPI.OpenView("PlayerSex")
    -- else
    --     Tips.ShowTips("不足")
    -- end
end

function OnDestroy()
    eventMgr:ClearListener()
    -- CSAPI.RemoveInputFieldChange(inputSign, InputChange)
    -- CSAPI.RemoveInputFieldCallBack(inputSign, InputCB)
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    iconNode = nil;
    iconParent = nil;
    role = nil;
    icon = nil;
    btnPlayerView = nil;
    txtLv = nil;
    txtName = nil;
    fillLv = nil;
    txtUID = nil;
    upBtn = nil;
    txtAbility1 = nil;
    txtAbility2 = nil;
    inputSign = nil;
    Placeholder = nil;
    inputDesc = nil;
    txtTitle1 = nil;
    txtTitle2 = nil;
    txtCjsl1 = nil;
    txtCjsl2 = nil;
    txtCjcs1 = nil;
    txtCjcs2 = nil;
    txtJstj1 = nil;
    txtJstj2 = nil;
    txtJstj3 = nil;
    txtYxcs1 = nil;
    txtYxcs2 = nil;
    txtZgpm1 = nil;
    txtZgpm2 = nil;
    txtYxsl1 = nil;
    txtYxsl2 = nil;
    txtSupport1 = nil;
    supportGrid = nil;
    maskFade = nil;
    view = nil;
end
----#End#----
