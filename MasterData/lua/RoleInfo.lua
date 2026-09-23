local colors = {"ffffff", "12f6b2", "30baf7", "956dfd", "ffc146", "ffffff"}
local timer = nil
local isFirst = true
isHideQuestionItem = true -- 外部调用

local abMemorys = {}
local abMemorys_ignore = nil
local needToCheckMove = false
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName1)
    CSAPI.AddEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot, ShareView_NoticeTheNextFrameScreenshot)
    CSAPI.AddEventListener(EventType.ShareView_NoticeScreenshotCompleted, ShareView_NoticeScreenshotCompleted)
    recordBeginTime = CSAPI.GetRealTime()
    -- 立绘
    cardIconItem = RoleTool.AddRole(iconParent, nil, nil, false)

    UIUtil:AddQuestionItem("RoleInfo", gameObject, questionP)
    ShareBtnOpenState();
end

function OnEnable()
    CSAPI.PlayUISound("ui_popup_open")
end
---截图前一帧通知
function ShareView_NoticeTheNextFrameScreenshot(Data)
    CSAPI.SetGOActive(ShareBtn, false)
    CSAPI.SetGOActive(btnEquipDetail, false)
    CSAPI.SetGOActive(btnLv, false)
    CSAPI.SetGOActive(btnAttributeDetail, false)
end
---截图完成通知
function ShareView_NoticeScreenshotCompleted(Data)
    ShareBtnOpenState();
    CSAPI.SetGOActive(btnEquipDetail, true)
    SetBtnLv()
    CSAPI.SetGOActive(btnAttributeDetail, true)
end
function ShareBtnOpenState()
    CSAPI.SetGOActive(ShareBtn, CSAPI.IsSharePicture())
end
function OnClickShareBtn()
    CSAPI.OpenView("ShareView", {
        LocationSource = 3
    })
end
function OnDisable()
    -- if (openSetting) then -- and (openSetting == RoleInfoOpenType.LookSelf or openSetting == RoleInfoOpenType.LookOther)) then
    CSAPI.PlayUISound("ui_cosmetic_adjustment")
    -- end
end
function OnDestroy()
    CSAPI.RemoveEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot, ShareView_NoticeTheNextFrameScreenshot)
    CSAPI.RemoveEventListener(EventType.ShareView_NoticeScreenshotCompleted, ShareView_NoticeScreenshotCompleted)
    RecordMgr:Save(RecordMode.View, recordBeginTime, "ui_id=" .. RecordViews.RoleInfo)

    eventMgr:ClearListener()

    -- 停止上一段语音
    RoleAudioPlayMgr:StopSound()
    -- ABMgr:ReleaseABAllWithViewName("RoleInfo")
    -- ABMgr:ClearRecordsWithViewName("RoleInfo")
    RoleABMgr:CheckRemoveAB("RoleInfo")

end

function Update()
    if (timer and Time.time > timer) then
        OpenAnim(false)
    end
    if (needToCheckMove) then
        luaTextMove:CheckMove(txtName1)
        needToCheckMove = false
    end
end

function OpenAnim(b)
    CSAPI.SetGOActive(mask, b)
    CSAPI.SetGOActive(anim_open, b)
    timer = b and Time.time + 0.7 or nil
    if (b) then
        isFirst = true
    end
end

function OnInit()
    topLua = UIUtil:AddTop2("RoleInfo", gameObject, function()
        view:Close()
    end, nil, {})

    -- 事件监听
    eventMgr = ViewEvent.New()
    -- 切换卡牌
    eventMgr:AddListener(EventType.Role_Card_ChangeResult, function(_data)
        RoleAudioPlayMgr:StopSound()
        cardData = _data
        ChangeRole()
    end)
    -- 更换装备 --改为监听 RoleEquip 界面的关闭
    eventMgr:AddListener(EventType.Equip_Change, function()
        OpenAnim(true)
        RefreshPanel()
    end)

    -- 卸载装备
    eventMgr:AddListener(EventType.Equip_Down_Ret, RefreshPanel)

    -- 卡牌刷新
    eventMgr:AddListener(EventType.Card_Update, RefreshPanel)
    eventMgr:AddListener(EventType.Role_Tag_Update, SetTag)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    -- 红点刷新
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
    eventMgr:AddListener(EventType.Menu_PopupPack, function()
        PopupPackMgr:CheckByCondition({7})
    end)
    -- 使用礼物回调
    eventMgr:AddListener(EventType.Dorm_UseGiftRet, SetMatrix)
    eventMgr:AddListener(EventType.Guide_RoleInfo_220040, Guide_220040)
    eventMgr:AddListener(EventType.Guide_RoleInfo_230070, Guide_230070)
end

-- 降低 DC
function OnViewOpened(viewKey)
    local cfg = Cfgs.view:GetByID(viewKey)
    if (cfg and not cfg.is_window) then
        CSAPI.SetScale(gameObject, 0, 0, 0)
    end
end
function OnViewClosed(viewKey)
    local cfg = Cfgs.view:GetByID(viewKey)
    if (cfg and not cfg.is_window) then
        CSAPI.SetScale(gameObject, 1, 1, 1)
    end
    -- if (viewKey == "RoleEquip" or viewKey == "RoleCenter") then
    if (viewKey == "RoleCenter") then
        OpenAnim(true)
        RefreshPanel()
    end
end

function OnOpen()
    -- openSetting = openSetting == nil and RoleInfoOpenType.LookSelf or openSetting --todo 
    cardData = data

    OpenAnim(true)
    RefreshPanel()
end

function RefreshPanel()
    baseData = cardData:GetBaseProperty()
    curStatusData = cardData:GetTotalProperty()
    isRealCard = cardData:CheckIsRealCard()
    isFighting = cardData:IsFighting()

    SetBtns()
    SetRole()
    SetTag()
    SetName()
    SetTeam()
    SetStar()
    SetLv()
    SetBuff()
    SetSpecialSkill()
    SetPosEnum()
    SetStatus()
    SetProperty()
    SetEquip()
    SetSkills()
    SetTalent()
    SetMatrix()
    CheckNew()
    SetBreak()
    SetRed()

    if (isRealCard) then
        EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "RoleInfo"); -- 引导用
    end

    cardData:SetIsNew(false) -- 已查看,这不是新卡了

    SetChangeBtn()
    SetWeapon()
    SetPoolTeam()
end

function SetRed()
    local isRed = false
    if (isRealCard and cardData:IsRed()) then
        isRed = true
    end
    UIUtil:SetRedPoint2("Common/Red2", btnLv, isRed, 63, 20, 0)
end

function SetBreak()
    local breakLv = cardData:GetBreakLevel()
    CSAPI.SetGOActive(imgBreakBG, breakLv > 1)
    if (breakLv > 1) then
        ResUtil.RoleCard_BG:Load(imgBreak, "img_1_0" .. (breakLv - 1))
    end
end

function CheckNew()
    if (isRealCard) then
        if (cardData:IsNew()) then
            PlayerProto:SetCardInfo(cardData:GetID(), false)
        end
    end
end

-- 滑动换人
function ChangeRole()
    local x1 = 0
    local x2 = isNext and -400 or 400
    UIUtil:SetObjFade(left, 1, 0, nil, 300, 0, 1)
    UIUtil:SetObjFade(iconNode, 1, 0, nil, 300, 0, 1)
    UIUtil:SetPObjMove(iconNode, x1, x2, 0, 0, 0, 0, function()
        RefreshPanel()
        UIUtil:SetObjFade(left, 0, 1, nil, 300, 0, 0)
        UIUtil:SetObjFade(iconNode, 0, 1, nil, 300, 0, 0)
        UIUtil:SetPObjMove(iconNode, -x2, x1, 0, 0, 0, 0, nil, 300, 1)
    end, 300, 0)
end

function SetRole()
    -- CSAPI.SetGOActive(iconParent, false)
    -- RoleTool.LoadImg(img, cardData:GetSkinID(), LoadImgType.RoleInfo, function()
    --     CSAPI.SetGOActive(iconParent, true)
    --     if (isFirst) then
    --         isFirst = false
    --         UIUtil:SetObjFade(iconNode, 0, 1, nil, 300, 1, 0)
    --         UIUtil:SetPObjMove(iconNode, 400, 0, 0, 0, 0, 0, nil, 300, 1)
    --     end
    -- end)

    CSAPI.SetGOActive(iconParent, false)

    -- ABMgr:RecordABWithModelIDInto("RoleInfo",cardData:GetSkinID())
    -- ABMgr:ReleaseABAutoWithViewName("RoleInfo")
    RoleABMgr:ChangeByIDs("RoleInfo", {cardData:GetSkinID()})
    cardIconItem.Refresh(cardData:GetSkinID(), LoadImgType.RoleInfo, function(go)
        CSAPI.SetGOActive(iconParent, true)
        if (isFirst) then
            isFirst = false
            if (iconNode ~= nil) then
                UIUtil:SetObjFade(iconNode, 0, 1, nil, 300, 1, 0)
                UIUtil:SetPObjMove(iconNode, 400, 0, 0, 0, 0, 0, nil, 300, 1)
            end
        end
    end, cardData:GetSkinIsL2d())
end

-- tag
function SetTag()
    local tag = cardData:GetData().tag
    if (tag and tag ~= 0) then
        CSAPI.SetGOActive(txtTap, false)
        CSAPI.SetGOActive(imgTag, true)
        ResUtil.AttributeIcon:Load(imgTag, tostring(tag))
    else
        CSAPI.SetGOActive(imgTag, false)
        CSAPI.SetGOActive(txtTap, true)
    end
end

-- 设置名称
function SetName()
    needToCheckMove = false
    CSAPI.SetText(txtName1, cardData:GetName())
    needToCheckMove = true
    CSAPI.SetText(txtName2, cardData:GetEnName())
    -- bg
    local quality = cardData:GetQuality()
    local iconName = quality == 6 and "img_4_02.png" or "img_4_01.png"
    CSAPI.LoadImg(imgName, "UIs/Role/" .. iconName, true, nil, true)
    CSAPI.SetImgColorByCode(imgName, colors[quality])
end

-- 小队
function SetTeam()
    local teamCfg = Cfgs.CfgTeamEnum:GetByID(cardData:GetCamp())
    local iconName = teamCfg.details
    ResUtil:LoadBigImgByExtend(imgTeam1, "Team/" .. iconName .. "/bg.png")
    ResUtil:LoadBigImgByExtend(imgTeam2, "Team/" .. iconName .. "/bg1.png")
end

function SetStar()
    local quality = cardData:GetQuality()
    -- bg 
    local iconName = quality == 6 and "img_5_02.png" or "img_5_01.png"
    CSAPI.LoadImg(imgStarBg, "UIs/Role/" .. iconName, true, nil, true)
    CSAPI.SetImgColorByCode(imgStarBg, colors[quality])
    local width = 302 - (6 - quality) * 31
    width = width < 156 and 156 or width
    CSAPI.SetRTSize(imgStarBg, width, 126)
    -- star
    ResUtil.RoleCard_BG:Load(imgStar, "img_01_0" .. quality)
end

function SetLv()
    if (not expBar) then
        expBar = ComUtil.GetCom(exp, "OutlineBar")
    end
    -- if (not cg_btnLv) then
    --     cg_btnLv = ComUtil.GetCom(btnLv, "CanvasGroup")
    -- end

    SetBtnLv()

    CSAPI.SetText(txtLv1, cardData:GetLv() .. "")
    CSAPI.SetText(txtLv2, "/" .. cardData:GetMaxLv())
    if (isMax) then
        expBar:SetProgress(1)
        CSAPI.SetText(txtExp, "<color=#929296>-/-</color>")
        -- cg_btnLv.alpha = 0.3
    else
        local cur = cardData:GetEXP()
        local max = RoleTool.GetExpByLv(cardData:GetLv())
        expBar:SetProgress(cur / max)
        CSAPI.SetText(txtExp, string.format("%s/<color=#929296>%s</color>", cur, max))
        -- cg_btnLv.alpha = 1
    end
end

function SetBtnLv()
    local curLv = cardData:GetLv()
    local maxLv = cardData:GetBreakLimitLv() -- cardData:GetCoreLimitLv() 屏蔽
    local isMax = curLv >= maxLv
    if (isRealCard and not isMax) then
        CSAPI.SetGOActive(btnLv, true)
    else
        CSAPI.SetGOActive(btnLv, false)
    end
end

-- 光环
function SetBuff()
    -- grid
    local haloInfo = cardData:GetHaloInfo();
    if haloInfo ~= nil then
        if isRealCard then
            CSAPI.SetGOActive(btnHalo, haloInfo:GetMaxLv() > 1);
        else
            CSAPI.SetGOActive(btnHalo, false);
        end
        haloInfo:LoadIcon(imgGrid);
        CSAPI.SetText(txtHaloLv, haloInfo:GetLv() < 10 and "0" .. haloInfo:GetLv() or tostring(haloInfo:GetLv()));
        local attrDatas = HaloUtil.CountHaloAddtion(haloInfo, cardData, nil, nil, nil, nil);
        for k, v in ipairs(attrDatas) do
            if v.cfg then
                CSAPI.SetText(this["txtBuff" .. k], v.cfg.sName)
                CSAPI.SetText(this["txtBuffNum" .. k], "+" .. tostring(v.addtive));
            end
        end
        CSAPI.SetGOActive(buffDown, #attrDatas >= 3);
    else
        CSAPI.SetGOActive(btnHalo, false);
    end
end

function SetSpecialSkill()
    -- PlayerClient:IsPassNewPlayerFight() --已去除
    local _data = cardData:GetSpecialSkill()[1]
    CSAPI.SetGOActive(btnSpecialSkill, _data ~= nil)
    local type = nil
    if (_data) then
        type = RoleSkillMgr:GetSpecialSkillType(_data.id)
        local str1Id = type + 4023
        local str2Id = type + 4026
        LanguageMgr:SetText(txtSpecialSkill1, str1Id)
        LanguageMgr:SetText(txtSpecialSkill2, str2Id)
        -- CSAPI.SetGOActive(speciallLock, false)
        local iconName = "f_btn_11_9"
        if (type == SpecialSkillType.Summon) then
            iconName = "f_btn_11_5"
        elseif (type == SpecialSkillType.Fit) then
            iconName = "f_btn_11_7"
        end
        CSAPI.LoadImg(speciallIcon, "UIs/Role/" .. iconName .. ".png", true, nil, true)
    end

    -- 同调对象
    CSAPI.SetGOActive(imgTT, type and type == SpecialSkillType.Fit)
    if (type and type == SpecialSkillType.Fit) then
        local str1 = LanguageMgr:GetByID(4053)
        str1 = str1 .. ":"
        local _cfg = cardData.isMonster and cardData:GetCardCfg() or cardData:GetCfg()
        local _data, str2 = RoleUniteUtil:GetStrs(_cfg)
        CSAPI.SetText(txtTT1, str1)
        CSAPI.SetText(txtTT2, str2[1])
    end
    -- red
    -- local isRed = false
    -- local twoCardID = GCalHelp:GetElseCfgID(cardData:GetCfgID())
    -- if (twoCardID and _data and not isFighting and RoleSkinMgr:CheckIsNewAdd(twoCardID)) then
    --     isRed = true
    -- end
    -- UIUtil:SetRedPoint(btnSpecialSkill, isRed, 119.4, 22.5, 0)
end

-- 角色定位
function SetPosEnum()
    local enums = {}
    local _nums = cardData:GetCfg().pos_enum
    if (_nums) then
        for i, v in ipairs(_nums) do
            local cfg = Cfgs.CfgRolePosEnum:GetByID(v)
            table.insert(enums, cfg)
        end
        local len = #enums
        if (len > 0) then
            local childCount = posEnumGrids.transform.childCount
            local origin = posEnumGrids.transform:GetChild(0).gameObject
            for i, v in ipairs(enums) do
                if (i <= childCount) then
                    local _tran = posEnumGrids.transform:GetChild(i - 1)
                    CSAPI.SetGOActive(_tran.gameObject, true)
                    ResUtil.RolePos:Load(_tran:GetChild(0).gameObject, v.icon)
                    CSAPI.SetText(_tran:GetChild(1).gameObject, v.sName)
                else
                    local go = CSAPI.CloneGO(origin, posEnumGrids.transform)
                    ResUtil.RolePos:Load(go.transform:GetChild(0).gameObject, v.icon)
                    CSAPI.SetText(go.transform:GetChild(1).gameObject, v.sName)
                end
            end
            for i = len + 1, childCount do
                CSAPI.SetGOActive(posEnumGrids.transform:GetChild(i - 1).gameObject, false)
            end
        end
    end
    CSAPI.SetGOActive(posEnumGrids, #enums > 0)
end

-- 属性  
function SetStatus()
    -- 属性条
    statusItems = statusItems or {}
    statusDatas = {}
    for i, v in ipairs(g_RoleAttributeList) do
        if (i > 4) then
            break
        end
        local cfg = Cfgs.CfgCardPropertyEnum:GetByID(v)
        local key = cfg.sFieldName
        local _data = {}
        _data.id = v
        local val1 = baseData[key]
        local val2 = curStatusData[key]
        -- 1
        _data.val1 = GetBaseValue(key)
        -- 2
        if (val2 > val1) then
            _data.val2 = "+" .. RoleTool.GetStatusValueStr(key, val2 - val1)
        else
            _data.val2 = nil
        end
        _data.nobg = true
        table.insert(statusDatas, _data)
    end
    ItemUtil.AddItems("AttributeNew2/AttributeItem6", statusItems, statusDatas, statusGrids)
end
-- 当前未加成属性值
function GetBaseValue(_key)
    local num = baseData[_key]
    if (num) then
        return RoleTool.GetStatusValueStr(_key, num)
    end
    return ""
end

-- 性能
function SetProperty()
    CSAPI.SetText(txtProperty2, cardData:GetProperty() .. "")
end

function SetEquip()
    CSAPI.SetGOActive(equipGrids, false)
    if (openSetting and openSetting == RoleInfoOpenType.LookNoGet) then
        CSAPI.SetGOActive(equip, false)
        return
    end
    if (isRealCard) then
        local isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.special, "special3")
        CSAPI.SetGOActive(equipLock, not isOpen)
        CSAPI.SetText(txtEquipLock, lockStr)
        if (not isOpen) then
            return
        end
    end
    -- 连锁阵线
    local b = TrialsMgr:IsEquipLock(data:GetID())
    if (b) then
        CSAPI.SetGOActive(equipLock, true)
        CSAPI.SetText(txtEquipLock, LanguageMgr:GetByID(37100))
        return
    end
    -- 
    local equipCoreSetting = isRealCard and EquipCoreSetting.Role or EquipCoreSetting.Search
    if (not equipCore) then
        ResUtil:CreateUIGOAsync("EquipCore/EquipCore", equip, function(go)
            equipCore = ComUtil.GetLuaTable(go)
            equipCore.Init({
                card = cardData
            }, equipCoreSetting)
        end)
    else
        equipCore.Init({
            card = cardData
        }, equipCoreSetting)
    end

    -- local b = cardData:CheckIsMaxFakeCard()
    -- CSAPI.SetGOActive(equip, not b)
    -- if (b) then
    --     return
    -- end
    -- if (isRealCard) then
    --     for i = 1, 5 do
    --         local isEmpty = cardData:GetEquipBySlot(i) == nil
    --         local _imgName = isEmpty and "btn_5_02.png" or "btn_5_03.png"
    --         CSAPI.LoadImg(this["objEquipGrid" .. i], "UIs/Role/" .. _imgName, true, nil, true)
    --     end
    -- else
    --     CSAPI.SetGOActive(equipGrids, false)
    --     if (not equipCore) then
    --         ResUtil:CreateUIGOAsync("EquipCore/EquipCore", equip, function(go)
    --             equipCore = ComUtil.GetLuaTable(go)
    --             equipCore.Init({
    --                 card = cardData
    --             })
    --         end)
    --     else
    --         equipCore.Init({
    --             card = cardData
    --         })
    --     end
    -- end
end

-- 技能
function SetSkills()
    newSkillDatas = cardData:GetSkillsForShow()
    local ids = {}
    for k, v in ipairs(newSkillDatas) do
        table.insert(ids, v.id)
    end
    skillItems = skillItems or {}
    ItemUtil.AddItems("Role/RoleInfoSkillItem1", skillItems, ids, skillGrids, ClickSkillItemCB, 1, nil, CheckSkillsRed)

    -- 
    skillIsOpen, skillLockStr = MenuMgr:CheckModelOpen(OpenViewType.special, "special4")
    CSAPI.SetGOActive(skillLock, not skillIsOpen)
end
function ClickSkillItemCB(index)
    CSAPI.OpenView("RoleSkillInfoView", {newSkillDatas[index], cardData}, 1)
end
function CheckSkillsRed()
    if (not isRealCard) then
        return
    end
    for k, v in ipairs(skillItems) do
        local isRed = false
        if (k == 4) then
            isRed = cardData:CheckPassiveUp()
        else
            isRed = cardData:CheckNormalSkillUP(v.cfgID)
        end
        UIUtil:SetRedPoint(v.clickNode, isRed, 51.5, 57.3, 0)
    end
    -- local item = skillItems[4]
    -- if (item) then
    --     local isRed = cardData:CheckPassiveUp()
    --     UIUtil:SetRedPoint(item.clickNode, isRed, 51.5, 57.3, 0)
    -- end
end

function SetTalent()
    talentDatas = GetTalentData()
    talentItems = talentItems or {}
    ItemUtil.AddItems("Role/RoleInfoTalentItem1", talentItems, talentDatas, talentGrids, ClickTalentItemCB, 1, cardData,
        CheckTalentRed)
    -- 
    talentIsOpen, talentLockStr = MenuMgr:CheckModelOpen(OpenViewType.special, "special20")
    CSAPI.SetGOActive(talentLock, not talentIsOpen)
end
function CheckTalentRed()
    if (not isRealCard) then
        return
    end
    for k, v in ipairs(talentItems) do
        local isRed = false
        if (v.data.isOpen and v.data.id) then
            isRed = cardData:CheckTalnetUp(v.data.id)
        end
        UIUtil:SetRedPoint(v.clickNode, isRed, 33.3, 33.3, 0)
    end
end
-- 封装天赋数据
function GetTalentData()
    local _talentDatas = {}
    local breakLv = cardData:GetBreakLevel()
    local use = cardData:GetDeputyTalent().use or {}
    local count = cardData:CheckIsMaxFakeCard() and 4 or 3
    for i = 1, count do
        local _data = {}
        _data.isOpen = breakLv > i
        _data.id = nil
        if (_data.isOpen and use[i] ~= 0) then
            _data.id = use[i]
        end
        table.insert(_talentDatas, _data)
    end
    return _talentDatas
end
function ClickTalentItemCB(index)
    local _data = talentDatas[index]
    if (_data.isOpen and _data.id) then
        CSAPI.OpenView("RoleSkillInfoView", {talentDatas[index], cardData}, 2)
    else
        if (isRealCard) then
            if (CheckIsFighting()) then
                return
            end
        else
            return
        end
        if (not talentIsOpen) then
            Tips.ShowTips(talentLockStr)
            return
        end
        CSAPI.OpenView("RoleCenter", {cardData}, "talent")
    end
end

function SetMatrix()
    -- skill
    local cRoleData = cardData:GetCRoleData()
    local cfgSkill = cRoleData ~= nil and cRoleData:GetAbilityCfg() or nil
    CSAPI.SetGOActive(btnMatrixSkill, cfgSkill ~= nil)
    if (cfgSkill) then
        ResUtil.CRoleSkill:Load(imgMatrixSkill, cfgSkill.icon)
    end
    -- lv 
    local str = cRoleData ~= nil and (cRoleData:GetLv() .. "") or "-"
    CSAPI.SetText(txtLove, str)
end

-- 非自己的卡需要隐藏一些入口按钮
function SetBtns()
    CSAPI.SetGOActive(btnLv, isRealCard)
    CSAPI.SetGOActive(btnTalentDetail, isRealCard)
    CSAPI.SetGOActive(topBtns, isRealCard)
    CSAPI.SetGOActive(dragBg, isRealCard)

    if (isRealCard) then
        local isShow = true
        local cRoleData = CRoleMgr:GetData(cardData:GetRoleID())
        if (not cRoleData or not cRoleData:IsShowInAltas()) then
            isShow = false
        end
        CSAPI.SetGOActive(btnLove, isShow)
    end

    isHideQuestionItem = not isRealCard

    -- 战斗中时
    if (openSetting and openSetting == 10) then
        topLua.SetHomeActive(false)
    else
        topLua.SetHomeActive(not isFighting)
    end
    CSAPI.SetGOActive(btnDirll, not isFighting)
    CSAPI.SetGOActive(questionP, not isFighting)
    CSAPI.SetGOActive(btnApparel, not isFighting)
    -- red 
    if (btnApparel.activeSelf) then
        local isRed = RoleSkinMgr:CheckIsNewAdd(cardData:GetCfgID())
        UIUtil:SetRedPoint2("Common/Red2", btnApparel, isRed, 58, 26, 0)
        local isLimitSkin = false
        if (not isRed) then
            isLimitSkin = cardData:CheckLimitSkin()
        end
        UIUtil:SetRedPoint2("Common/Red4", btnApparel, isLimitSkin, 57, 26, 0)
    end
end

-------------------------------------------------------------------------------------------------------------------------
local holdDownTime = 0
local holdTime = 0.1
local startPosX = 0

function OnPressDown(isDrag, clickTime)
    holdDownTime = Time.unscaledTime
    startPosX = CS.UnityEngine.Input.mousePosition.x
end

function OnPressUp(isDrag, clickTime)
    if Time.unscaledTime - holdDownTime >= holdTime then
        local len = CS.UnityEngine.Input.mousePosition.x - startPosX
        if (math.abs(len) > 100) then
            if (len > 0) then
                isNext = false -- 图片左移
                EventMgr.Dispatch(EventType.Role_Card_Change, false)
            else
                isNext = true
                EventMgr.Dispatch(EventType.Role_Card_Change, true)
            end
        end
    end
end

function CheckIsFighting()
    if (isFighting) then
        LanguageMgr:ShowTips(1003)
        return true
    end
    return false
end

-------------------------------------------------------------------------------------------------------------------------
-- 服装
function OnClickApparel()
    if (not cardData.isMonster) then
        CSAPI.PlayUISound("ui_generic_tab_2") -- todo 
        CSAPI.OpenView("RoleApparel", cardData)
    end
    -- 
    RoleSkinMgr:SetIsNewAdd(cardData:GetCfgID())
    UIUtil:SetRedPoint(btnApparel, false, 58.3, 26.2, 0)
end

-- 训练
function OnClickDirll()
    CSAPI.PlayUISound("ui_generic_tab_2")
    CSAPI.OpenView("FightDirll", cardData)
end

-- -- 分享
-- function OnClickShare()
--     CSAPI.PlayUISound("ui_generic_tab_2")
--     Log("无ui")
-- end

-- -- 放大
-- function OnClickAmplification()
--     CSAPI.OpenView("RoleInfoAmplification", {cardData:GetRoleID(), cardData:GetSkinID(), false}, LoadImgType.RoleInfo)
-- end

-- 图鉴
function OnClickLove()
    -- 图鉴系统是否已解锁
    local b, str = MenuMgr:CheckModelOpen(OpenViewType.main, "ArchiveView")
    if (b) then
        local _data = CRoleMgr:GetData(cardData:GetRoleID())
        local op = isFighting and 1 or 3
        CSAPI.OpenView("ArchiveRole", _data, op)
    else
        Tips.ShowTips(str)
    end
end

-- 标签
function OnClickTag()
    if (isRealCard) then
        CSAPI.PlayUISound("ui_generic_tab_2")
        CSAPI.OpenView("RoleInfoTag", cardData)
    end
end

-- 升级
function OnClickUp()
    if (CheckIsFighting()) then
        return
    end
    -- CSAPI.OpenView("RoleCenter", {cardData}, "up")
    -- if (cg_btnLv.alpha == 1) then
    CSAPI.OpenView("RoleUpBreak", cardData)
    -- end
end

-- 点击特殊技能
function OnClickSpecialSkill()
    CSAPI.PlayUISound("ui_generic_tab_2")
    local _data = cardData:GetSpecialSkill()[1]
    if (_data) then
        if (not PlayerClient:IsPassNewPlayerFight()) then
            LanguageMgr:ShowTips(1006)
            return
        else
            CSAPI.OpenView("RoleInfoFussion", {cardData, _data, isRealCard, isFighting}, openSetting)
        end
    end
end

-- 属性展开
function OnClickAttributeDetail()
    CSAPI.OpenView("AttributeInfoTView", cardData)
end

-- 装备界面
function OnClickEquip()
    if (not isRealCard) then
        return
    end
    if (CheckIsFighting()) then
        return
    end
    CSAPI.OpenView("RoleEquip", {
        card = cardData
    })
    -- LogError("TODO")
end

-- 装备属性
function OnClickEquipDetail()
    -- LogError("TODO")
    CSAPI.OpenView("RoleEquippedInfo", cardData)
end

-- 技能
function OnClickSkillDetail()
    if (not isRealCard) then
        return
    end
    if (not skillIsOpen) then
        Tips.ShowTips(skillLockStr)
        return
    end
    if (CheckIsFighting()) then
        return
    end
    CSAPI.OpenView("RoleCenter", {cardData, newSkillDatas[1].id}, "skill")
end

-- 天赋界面
function OnClickTalentDetail()
    if (not isRealCard) then
        return
    end
    if (not talentIsOpen) then
        Tips.ShowTips(talentLockStr)
        return
    end
    if (CheckIsFighting()) then
        return
    end
    CSAPI.OpenView("RoleCenter", {cardData}, "talent")
end

local RoleMatrixSkillInfoLua = nil;
-- 基建技能
function OnClickMatrixSkill()
    if (not cardData:GetCRoleData()) then
        return
    end
    ResUtil:CreateUIGOAsync("Role/RoleMatrixSkillInfo", gameObject, function(go)
        local lua = ComUtil.GetLuaTable(go)
        RoleMatrixSkillInfoLua = lua;
        lua.Refresh(cardData:GetCRoleData())
    end)
end

-- 换角色、机神---------------------------------------------------------------------------------------------------------------------

function SetChangeBtn()
    local b = false
    if ((cardData:GetCfg().changeCardIds ~= nil and #cardData:GetCfg().changeCardIds > 0) or
        (cardData:GetCfg().allTcSkills ~= nil and #cardData:GetCfg().allTcSkills > 0)) then
        b = true
    end
    CSAPI.SetGOActive(btnJieJin, b)
end

-- 解禁
function OnClickJieJin()
    CSAPI.OpenView("RoleJieJin", cardData)
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if RoleMatrixSkillInfoLua and RoleMatrixSkillInfoLua.OnClickMask then
        RoleMatrixSkillInfoLua.OnClickMask()
        RoleMatrixSkillInfoLua = nil
    else
        if topLua.OnClickBack then
            topLua.OnClickBack();
        end
    end
end

function OnClickFeel()
    if (not isRealCard) then
        return
    end
    if (CheckIsFighting()) then
        return
    end
    if (cardData:GetCRoleData()) then
        if (cardData:GetCRoleData():GetLv() >= 100) then
            LanguageMgr:ShowTips(21033)
        else
            CSAPI.OpenView("DormGift", {
                data = cardData:GetCRoleData()
            })
        end
    end
end

-- 点击光环
function OnClickHalo()
    -- 打开光环主界面
    CSAPI.OpenView("HaloMain", cardData);
end

function OnClickEquipLock()
    local isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.special, "special3")
    if (not isOpen) then
        Tips.ShowTips(lockStr)
        return
    end
    -- 连锁阵线
    local b = TrialsMgr:IsEquipLock(data:GetID())
    if (b) then
        local dialogdata = {}
        dialogdata.content = LanguageMgr:GetTips(76003)
        dialogdata.okCallBack = function()
            JumpMgr:Jump(20001)
        end
        dialogdata.okText = LanguageMgr:GetByID(56008)
        CSAPI.OpenView("Dialog", dialogdata)
    end
end

function Guide_220040(isDo)
    CSAPI.SetGOActive(btnGuide_220040, isDo)
end

function Guide_230070(isDo)
    CSAPI.SetGOActive(btnGuide_230070, isDo)
end

-- 专武
function SetWeapon()
    isHaveWeapon, isUnLock = cardData:HaveWeapon()
    CSAPI.SetGOActive(objWeapon, isHaveWeapon)
    if (isHaveWeapon) then
        -- local alpha = isUnLock and 1 or 0.3
        -- CSAPI.SetGOAlpha(objWeapon, alpha)
        CSAPI.SetGrey(objWeapon, not isUnLock, true)
        local weaponLv = cardData:GetWeaponLv()
        local cfg = Cfgs.CfgCardWeapon:GetByID(cardData:GetCfgID())
        local childCfg = cfg.infos[weaponLv + 1]
        ResUtil.RoleWeapon:Load(imgWeapon, childCfg.icon)
        CSAPI.SetText(txtWeaponLv, weaponLv .. "")
        -- CSAPI.SetText(txtWeaponName, cfg.weaponname)
    end
end

function OnClickWeapon()
    if (isRealCard) then
        if (isUnLock) then
            CSAPI.OpenView("RoleWeapon", cardData)
        else
            LanguageMgr:ShowTips(77006)
        end
    end
end

-- 阵容推荐
function SetPoolTeam()
    local b = cardData:CheckIsMaxFakeCard()
    local id = cardData:GetFakePoolTeamID()
    if (not b or not id) then
        CSAPI.SetGOActive(objPoolTeam, false)
        return
    end
    local cfg = Cfgs.CfgCardPoolTeam:GetByID(id)
    CSAPI.SetGOActive(objPoolTeam, cfg ~= nil)
    if (cfg ~= nil) then
        if (not poolTeam) then
            ResUtil:CreateUIGOAsync("Role/RoleInfoPoolTeam", objPoolTeam, function(go)
                poolTeam = ComUtil.GetLuaTable(go)
                poolTeam.Refresh(id)
            end)
        else
            poolTeam.Refresh(id)
        end
    end
end
