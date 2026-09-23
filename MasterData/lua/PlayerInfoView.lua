local fade = nil
local isAnim = false
local isFirst = false
local badgeItems = {}

function Awake()
    fade = ComUtil.GetCom(gameObject, "ActionFade")

    UIUtil:AddTop2("PlayerInfoView", gameObject, OnClickClose)
end

-- 玩家信息
function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Player_Info, OnPlayerInfoSet)
end

function OnDisable()
    eventMgr:ClearListener()
end

--[[	
{
____["exp"]:310,
____["name"]:"hun006",
____["sign"]:"",
____["info"]:
________{
____________sPlrPaneInfo
________},
____["uid"]:526,
____["level"]:100
}
--]]
function OnPlayerInfoSet(_data)
    if isFirst then
        return
    end
    isFirst = true
    if _data  then
		Show(_data)
		CSAPI.SetGOActive(startAction,true)
		CSAPI.SetGOActive(node, true)
        -- isAnim= true
        -- fade:Play(0, 1, 100, 0,function ()
		-- 	isAnim = false
		-- end)		
    end
end

function Show(_data)
    -- LogError(_data)
    local info = _data.info
    -- icon
    -- if data and data.iconName then
    --     ResUtil.RoleCard:Load(role, data.iconName, true)
    --     CSAPI.SetScale(role, 0.87, 0.87)
    --     -- RoleTool.LoadImg(role, info.icon_id, LoadImgType.Main)
    -- end

    -- name
    CSAPI.SetText(txtName, _data.name)

    -- lv
    local level = _data.level or 1
    CSAPI.SetText(txtLv1, level .. "")
    CSAPI.SetText(txtLv2, "/" .. PlayerClient:GetMaxLv())

    -- uid
    CSAPI.SetText(txtUID, _data.uid .. "")

    -- sign 
    -- local signStr = _data.sign
    -- local alpha = 255
    -- if signStr == "" then
    --     signStr = LanguageMgr:GetByID(27010)
    --     alpha = 76
    -- end
    -- SetSign(signStr)
    -- CSAPI.SetTextColor(txtSign,255,255,255,alpha)

    -- 创建时间
    local c_time = info.c_time or 0
    local time = TimeUtil:GetTimeStr2(c_time, false) or 0
    LanguageMgr:SetText(txtCTime,8009,time)

    -- 队员收集
    local role_num = info.role_num or 0
    local _, max = CRoleMgr:GetCount()
    -- local CfgCardRole = Cfgs.CfgCardRole:GetAll()
    -- local maxCnt = 0
    -- for k, v in pairs(CfgCardRole) do
    --     if v.bShowInAltas then
    --         maxCnt = maxCnt + 1
    --     end
    -- end
    CSAPI.SetText(txtDysj2,role_num .."/"..max)
    -- 最高段位
    -- local cfgExercise = Cfgs.CfgPracticeRankLevel:GetByID(info.max_rank_level)
    -- local zgdwRate = cfgExercise and cfgExercise.name or ""
    -- CSAPI.SetText(txtZgdw2, zgdwRate .. "")
    -- 剧情进度
    local max_dup = info.max_dup or 0
    local mDungeonCfg = Cfgs.MainLine:GetByID(max_dup)
    CSAPI.SetText(txtJqjd2, mDungeonCfg and mDungeonCfg.chapterID or "")
    -- 基地等级
    local buildLv = info.build_control_lv or 0
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtJddj2, lvStr.. buildLv)

    -- 爬塔进度
    -- local max_tower = info.max_tower or 0
    -- local tDungeonCfg = Cfgs.MainLine:GetByID(max_tower)
    -- CSAPI.SetGOActive(ptjdImg,not (tDungeonCfg and tDungeonCfg.name))
    -- CSAPI.SetText(txtPtjd2, tDungeonCfg and tDungeonCfg.name or "")
    SetHeadFrame(info.icon_frame or 1,info.icon_id)

    if _data.badgedPos and #_data.badgedPos > 0 then
        local datas = {}
        for i, v in ipairs(_data.badgedPos) do
            local data = BadgeData.New()
            data:Init(Cfgs.CfgBadge:GetByID(v.sid))
            datas[v.num] = data
        end
        SetBadge(datas)
    end

    UIUtil:AddTitleByID(titleParent,0.8,info.icon_title)
end

function OnOpen()
    if data then
        CSAPI.SetGOActive(node, false)
        FriendMgr:FriendPaneInfo(data.uid)
        if data.supports then
            SetSupports(data.supports)
        end
    end
end

function SetSign(str)
    str = MsgParser:getString(str) -- 屏蔽字体用***代替
    -- CSAPI.SetText(txtSign, str)
end

function SetHeadFrame(_id,_icon_id)
    UIUtil:AddHeadByID(headParent,1,_id, _icon_id)
end

function SetBadge(_datas)
    if #badgeItems > 0 then
        for i, v in ipairs(badgeItems) do
            CSAPI.SetGOActive(v.gameObject,false)
        end
    end
    if _datas then
        for i = 1, (g_BadgeMax or 6) do
            if i <= #badgeItems then
                badgeItems[i].Refresh(_datas[i],true)
                CSAPI.SetGOAlpha(badgeItems[i].gameObject, 1)
            else
                ResUtil:CreateUIGOAsync("Badge/BadgeGridItem",badgeParent,function (go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(_datas[i],true)
                    lua.SetScale(0.6)
                    CSAPI.SetGOAlpha(go, 1)
                    badgeItems[i] = lua
                end)
            end
        end    
    end
end

-- 协战
function SetSupports(datas)
    for i = 1, #datas do
        local cardData = nil
        if datas[i].card_info then
            cardData = CharacterCardsData(datas[i].card_info)
            cardData.fighting = math.floor(datas[i].card_info.performance)
        end
        ResUtil:CreateUIGOAsync("Player/PlayerSupportItem", supportGrid, function(go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(cardData)
            lua.SetClick(false)
        end)
    end
end

function OnClickClose()
	if isAnim then
		return 
	end
	isAnim = true
	CSAPI.SetGOActive(endAction,true)
	fade:Play(1,0,100,0,function ()
		view:Close()
		isAnim = false
	end)
end

function OnClickCopy()
    LanguageMgr:ShowTips(6011)
    UnityEngine.GUIUtility.systemCopyBuffer = "#" .. data.uid
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
    titleObj = nil;
    txt_title1 = nil;
    icon = nil;
    txtLv2 = nil;
    txtName = nil;
    txtSign = nil;
    txtCjsj1 = nil;
    txtCjsj2 = nil;
    txtGqjd1 = nil;
    txtGqjd2 = nil;
    txtCjcs1 = nil;
    txtCjcs2 = nil;
    txtYzcs1 = nil;
    txtYzcs2 = nil;
    txtJssc1 = nil;
    txtJssc2 = nil;
    txtJssc3 = nil;
    txtYxcs1 = nil;
    txtYxcs2 = nil;
    txtYxsl1 = nil;
    txtYxsl2 = nil;
    view = nil;
end
----#End#----
