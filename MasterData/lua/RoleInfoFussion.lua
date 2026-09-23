local colors = {"ffffff", "12f6b2", "30baf7", "956dfd", "ffc146", "ffffff"}
local timer = nil
local isFirst = true

local needToCheckMove = false
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName1)
    -- recordBeginTime = CSAPI.GetRealTime()
    -- 立绘
    cardIconItem = RoleTool.AddRole(iconParent, nil, nil, false)
end

function OnEnable()
    CSAPI.PlayUISound("ui_popup_open")
end

function OnDisable()
    -- if (openSetting and (openSetting == RoleInfoOpenType.LookSelf or openSetting == RoleInfoOpenType.LookOther)) then
    CSAPI.PlayUISound("ui_cosmetic_adjustment")
    -- end
end
function OnDestroy()
    -- RecordMgr:Save(RecordMode.View, recordBeginTime, "ui_id=" .. RecordViews.RoleInfo)

    eventMgr:ClearListener()

    -- 停止上一段语音
    RoleAudioPlayMgr:StopSound()
    RoleABMgr:CheckRemoveAB("RoleInfoFussion")
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

    isFirst = true
end

function OnInit()
    topLua = UIUtil:AddTop2("RoleInfoFussion", gameObject, function()
        view:Close()
    end, nil, {})

    -- 事件监听
    eventMgr = ViewEvent.New()
    -- -- 切换卡牌
    -- eventMgr:AddListener(EventType.Role_Card_ChangeResult, function(_data)
    --     RoleAudioPlayMgr:StopSound()
    --     cardData = _data
    --     ChangeRole()
    -- end)
    -- 更换装备 --改为监听 RoleEquip 节目的关闭
    -- eventMgr:AddListener(EventType.Equip_Change,SetEquip)

    -- 卡牌刷新
    eventMgr:AddListener(EventType.Card_Update, OnOpen)
    -- eventMgr:AddListener(EventType.Role_Tag_Update, SetTag)
    -- eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    -- eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

-- -- 降低 DC
-- function OnViewOpened(viewKey)
--     local cfg = Cfgs.view:GetByID(viewKey)
--     if (cfg and not cfg.is_window) then
--         CSAPI.SetScale(gameObject, 0, 0, 0)
--     end
-- end
-- function OnViewClosed(viewKey)
--     local cfg = Cfgs.view:GetByID(viewKey)
--     if (cfg and not cfg.is_window) then
--         CSAPI.SetScale(gameObject, 1, 1, 1)
--     end
--     if (viewKey == "RoleEquip" or viewKey == "RoleCenter") then
--         RefreshPanel()
--         OpenAnim(true)
--     end
-- end

function OnOpen()
    oldCardData = data[1]
    skillData = data[2]
    cardIsReal = data[3] -- 基础卡是否是自己已获得的卡
    isFighting = data[4] -- 基础是否战斗中

    cfg = Cfgs.skill:GetByID(skillData.id)
    isFighting = oldCardData:IsFighting()

    InitData()
    RefreshPanel()
    OpenAnim(true)
end

-- 封装数据
function InitData()
    local career = 1
    -- 形态切换、同调 --等级继承，技能、被动技能继承等级，副天赋继承主体，变更皮肤
    if (cfg.type == SkillType.Transform or cfg.type == SkillType.Unite) then
        local cardId = cfg.type == SkillType.Transform and oldCardData:GetCardCfg().tTransfo[1] or
                           oldCardData:GetCardCfg().fit_result
        local cardCfg = Cfgs.CardData:GetByID(cardId)
        -- 普通技能需要重新封装
        local newSkillDatas = {}
        local curSkillsID = cardCfg.jcSkills
        local skills = oldCardData:GetSkills()
        for i, v in ipairs(skills) do
            local cfg = Cfgs.skill:GetByID(v.id)
            table.insert(newSkillDatas, {
                id = curSkillsID[i] + (cfg.lv - 1),
                exp = 0,
                type = SkillMainType.CardNormal
            })
        end
        -- 被动技能
        local sSkillID = cardCfg.tfSkills and cardCfg.tfSkills[1] or nil
        if (sSkillID) then
            local skillsDatas = oldCardData:GetSkills(SkillMainType.CardTalent)
            if (#skillsDatas > 0) then
                local id = skillsDatas and skillsDatas[1].id or nil
                if (id) then
                    local cfg = Cfgs.skill:GetByID(id)
                    sSkillID = sSkillID + (cfg.lv - 1)
                    table.insert(newSkillDatas, {
                        id = sSkillID,
                        exp = 0,
                        type = SkillMainType.CardTalent
                    })
                end
            end
        end
        -- 副天赋
        -- 重新封装
        local newInfo = {}
        newInfo = table.copy(oldCardData:GetData())
        newInfo.cfgid = cardId
        newInfo.skills = newSkillDatas
        cardData = CharacterCardsData(newInfo)
        career = cardCfg.career
    else
        -- 召唤 --等级继承，技能、被动技能不继承(到怪物表拿数据)、无副天赋
        local cardId = RoleTool.GetMonsterIDBySkillID(skillData.id)
        local cardCfg = Cfgs.MonsterData:GetByID(cardId)
        -- 普通技能需要重新封装
        local newSkillDatas = {}
        local curSkillsID = cardCfg.jcSkills
        for i, v in ipairs(curSkillsID) do
            table.insert(newSkillDatas, {
                id = curSkillsID[i],
                exp = 0,
                type = SkillMainType.CardNormal
            })
        end
        -- 被动技能
        local sSkillID = cardCfg.tfSkills and cardCfg.tfSkills[1] or nil
        table.insert(newSkillDatas, {
            id = sSkillID,
            exp = 0,
            type = SkillMainType.CardTalent
        })

        -- -- 重新封装
        -- local newInfo = {}
        -- local key = string.format("%s_%s", cardCfg.numerical, oldCardData:GetLv())
        -- LogError(key)
        -- local _cfg = Cfgs.MonsterNumerical:GetByKey(key)
        -- newInfo = table.copy(_cfg)
        -- newInfo.cfgid = cardId
        -- newInfo.skills = newSkillDatas
        -- newInfo.break_level = 1
        -- newInfo.intensify_level = 1
        -- local monsterCardsData = require "MonsterCardsData"
        -- cardData = MonsterCardsData(newInfo)
        cardData = RoleTool.GetNewCardData2(oldCardData, cardId)
    end
end

function RefreshPanel()
    baseData = cardData:GetBaseProperty()
    curStatusData = cardData:GetTotalProperty()
    isRealCard = false -- cardData:CheckIsRealCard()

    SetBtns()
    SetRole()
    -- SetTag() 
    SetName()
    SetTeam()
    SetStar()
    SetLv()
    SetBuff()
    -- SetSpecialSkill()
    SetPosEnum()
    SetStatus()
    SetProperty()
    -- SetEquip()
    SetSkills()
    SetTalent()
    -- SetMatrix()
    -- CheckNew()
    SetBreak()

    SetTips()
end

function SetBreak()
    local breakLv = cardData:GetBreakLevel()
    CSAPI.SetGOActive(imgBreakBG, breakLv > 1)
    if (breakLv > 1) then
        ResUtil.RoleCard_BG:Load(imgBreak, "img_1_0" .. (breakLv - 1))
    end
end

-- function CheckNew()
--     if (isRealCard) then
--         if (cardData:IsNew()) then
--             PlayerProto:SetCardInfo(data:GetID(), false)
--         end
--     end
-- end

-- 滑动换人
-- function ChangeRole()
--     local x1 = 0
--     local x2 = isNext and -400 or 400
--     UIUtil:SetObjFade(left, 1, 0, nil, 300, 0, 1)
--     UIUtil:SetObjFade(iconNode, 1, 0, nil, 300, 0, 1)
--     UIUtil:SetPObjMove(iconNode, x1, x2, 0, 0, 0, 0, function()
--         RefreshPanel()
--         UIUtil:SetObjFade(left, 0, 1, nil, 300, 0, 0)
--         UIUtil:SetObjFade(iconNode, 0, 1, nil, 300, 0, 0)
--         UIUtil:SetPObjMove(iconNode, -x2, x1, 0, 0, 0, 0, nil, 300, 1)
--     end, 300, 0)
-- end

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
    --
    RoleABMgr:ChangeByIDs("RoleInfoFussion", {cardData:GetSkinID()})
end

-- tag
-- function SetTag()
--     local tag = cardData:GetData().tag
--     if (tag and tag ~= 0) then
--         CSAPI.SetGOActive(txtTap, false)
--         CSAPI.SetGOActive(imgTag, true)
--         local iconName = string.format("UIs/AttributeNew2/%s.png", tag)
--         CSAPI.LoadImg(imgTag, iconName, true, nil, true)
--     else
--         CSAPI.SetGOActive(imgTag, false)
--         CSAPI.SetGOActive(txtTap, true)
--     end
-- end

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

    local curLv = oldCardData:GetLv() -- cardData:GetLv()
    local maxLv = oldCardData:GetMaxLv() -- cardData:GetMaxLv()
    local isMax = curLv >= maxLv

    CSAPI.SetText(txtLv1, curLv .. "")
    CSAPI.SetText(txtLv2, "/" .. maxLv)
    if (isMax) then
        expBar:SetProgress(1)
        CSAPI.SetText(txtExp1, "<color=#929296>-/-</color>")
        -- cg_btnLv.alpha = 0.3
    else
        local cur = oldCardData:GetEXP() --  cardData:GetEXP()
        local max = RoleTool.GetExpByLv(oldCardData:GetLv()) -- RoleTool.GetExpByLv(cardData:GetLv())
        expBar:SetProgress(cur / max)
        CSAPI.SetText(txtExp1, string.format("%s/<color=#929296>%s</color>", cur, max))
        -- cg_btnLv.alpha = 1
    end
end

-- 光环
function SetBuff()
    CSAPI.SetGOActive(buff, cfg.type ~= SkillType.Summon)
    if (cfg.type == SkillType.Summon) then
        CSAPI.SetGOActive(buff,false);
        return
    end
    CSAPI.SetGOActive(buff,true);
    local haloInfo=cardData:GetHaloInfo();
    if haloInfo~=nil then
        if isRealCard then
            CSAPI.SetGOActive(btnHalo,haloInfo:GetMaxLv()>1);
        else
            CSAPI.SetGOActive(btnHalo,false);
        end
        haloInfo:LoadIcon(imgGrid);
        CSAPI.SetText(txtHaloLv, haloInfo:GetLv()<10 and "0" .. haloInfo:GetLv() or tostring(haloInfo:GetLv()));
        local attrDatas = HaloUtil.CountHaloAddtion(haloInfo, cardData, nil, nil, nil, nil);
        for k, v in ipairs(attrDatas) do
            if v.cfg then
                CSAPI.SetText(this["txtBuff" .. k], v.cfg.sName)
                CSAPI.SetText(this["txtBuffNum" .. k], "+" .. tostring(v.addtive));
            end
        end
        CSAPI.SetGOActive(buffDown, #attrDatas >= 3);
    else
        CSAPI.SetGOActive(btnHalo,false);
    end
    local scale = cfg.type == SkillType.Summon and 1.1 or 1.5
    CSAPI.SetScale(imgGrid, scale, scale, scale)
end

-- function SetSpecialSkill()
--     -- PlayerClient:IsPassNewPlayerFight() --已去除
--     local _data = cardData:GetSpecialSkill()[1]
--     CSAPI.SetGOActive(btnSpecialSkill, _data ~= nil)
--     if (_data) then
--         local type = RoleSkillMgr:GetSpecialSkillType(_data.id)
--         local str1Id = type + 4023
--         local str2Id = type + 4026
--         LanguageMgr:SetText(txtSpecialSkill1, str1Id)
--         LanguageMgr:SetText(txtSpecialSkill2, str2Id)
--         -- CSAPI.SetGOActive(speciallLock, false)
--         local iconName = "f_btn_11_9"
--         if (type == SpecialSkillType.Summon) then
--             iconName = "f_btn_11_5"
--         elseif (type == SpecialSkillType.Fit) then
--             iconName = "f_btn_11_7"
--         end
--         CSAPI.LoadImg(speciallIcon, "UIs/Role/" .. iconName .. ".png", true, nil, true)
--     end
-- end

-- 角色定位
function SetPosEnum()
    local enums = {}
    local _nums = cardData:GetCardCfg().pos_enum
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

-- function SetEquip()
--     CSAPI.SetGOActive(equip, isRealCard)
--     if (not isRealCard) then
--         return
--     end

--     -- local b = cardData:CheckIsMaxFakeCard()
--     -- CSAPI.SetGOActive(equip, not b)
--     -- if (b) then
--     --     return
--     -- end
--     if (isRealCard) then
--         for i = 1, 5 do
--             local isEmpty = cardData:GetEquipBySlot(i) == nil
--             local _imgName = isEmpty and "btn_5_02.png" or "btn_5_03.png"
--             CSAPI.LoadImg(this["objEquipGrid" .. i], "UIs/Role/" .. _imgName, true, nil, true)
--         end
--         -- else
--         --     CSAPI.SetGOActive(equipGrids, false)
--         --     if (not equipCore) then
--         --         ResUtil:CreateUIGOAsync("EquipCore/EquipCore", equip, function(go)
--         --             equipCore = ComUtil.GetLuaTable(go)
--         --             equipCore.Init({
--         --                 card = cardData
--         --             })
--         --         end)
--         --     else
--         --         equipCore.Init({
--         --             card = cardData
--         --         })
--         --     end
--     end
-- end

-- 技能
function SetSkills()
    newSkillDatas = cardData:GetSkillsForShow()
    local ids = {}
    for k, v in ipairs(newSkillDatas) do
        table.insert(ids, v.id)
    end
    skillItems = skillItems or {}
    ItemUtil.AddItems("Role/RoleInfoSkillItem1", skillItems, ids, skillGrids, ClickSkillItemCB)
end
function ClickSkillItemCB(index)
    CSAPI.OpenView("RoleSkillInfoView", {newSkillDatas[index], cardData}, 1)
end

function SetTalent()
    CSAPI.SetGOActive(talent, cfg.type ~= SkillType.Summon)
    if (cfg.type ~= SkillType.Summon) then
        talentDatas = GetTalentData()
        talentItems = talentItems or {}
        ItemUtil.AddItems("Role/RoleInfoTalentItem1", talentItems, talentDatas, talentGrids, ClickTalentItemCB, 1,
            cardData)
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
    if (_data.isOpen) then
        if (_data.id) then
            CSAPI.OpenView("RoleSkillInfoView", {talentDatas[index], cardData}, 2)
        else
            if (isRealCard) then
                CSAPI.OpenView("RoleCenter", {cardData}, "talent")
            else
                LanguageMgr:ShowTips(3011)
            end
        end
    else
        if (isRealCard) then
            CSAPI.OpenView("RoleCenter", {cardData}, "talent")
        else
            LanguageMgr:ShowTips(3011)
        end
    end
end

-- function SetMatrix()
--     -- skill
--     local cRoleData = cardData:GetCRoleData()
--     local cfgSkill = cRoleData ~= nil and cRoleData:GetAbilityCurCfg() or nil
--     CSAPI.SetGOActive(btnMatrixSkill, cfgSkill ~= nil)
--     if (cfgSkill) then
--         ResUtil.CRoleSkill:Load(imgSkill, cfgSkill.icon)
--     end
--     -- lv 
--     local str = cRoleData ~= nil and (cRoleData:GetLv() .. "") or "-"
--     CSAPI.SetText(txtLove, str)
-- end

-- 非自己的卡需要隐藏一些入口按钮
function SetBtns()
    -- CSAPI.SetGOActive(btnLv, isRealCard)
    CSAPI.SetGOActive(btnTalentDetail, isRealCard)
    CSAPI.SetGOActive(topBtns, cardIsReal)
    CSAPI.SetGOActive(dragBg, isRealCard)

    -- if (isRealCard) then
    --     local isShow = true
    --     local cRoleData = CRoleMgr:GetData(cardData:GetRoleID())
    --     if (not cRoleData or not cRoleData:IsShowInAltas()) then
    --         isShow = false
    --     end
    --     CSAPI.SetGOActive(btnLove, isShow)
    -- end
    -- 战斗中时
    if (openSetting ~= nil and openSetting == 10) then
        topLua.SetHomeActive(false)
    else
        topLua.SetHomeActive(not isFighting)
    end
    -- -- 皮肤
    -- local b = false
    -- if (cardIsReal and not isFighting) then
    --     b = cardData:CheckHadSkins()
    -- end
    -- CSAPI.SetGOActive(btnApparel, b)

    -- -- red
    -- local isRed = false
    -- local twoCardID = RoleTool.GetTwoCfgID(oldCardData:GetCfgID())
    -- if (RoleSkinMgr:CheckIsNewAdd(twoCardID)) then
    --     isRed = true
    -- end
    -- UIUtil:SetRedPoint(btnApparel, isRed, 58.3, 26.2, 0)
end

function SetTips()
    -- desc
    local strID = 4101
    if (cfg.type ~= SkillType.Summon) then
        strID = cfg.type == SkillType.Unite and 4102 or 4103
    end
    LanguageMgr:SetText(txtTips2, strID)
    -- 同调
    CSAPI.SetGOActive(objFit, cfg.type == SkillType.Unite)
    local height = cfg.type == SkillType.Unite and 92 or 240
    CSAPI.SetRTSize(sv, 511, height)

    if (cfg.type == SkillType.Unite) then
        if (not layoutAuto) then
            layoutAuto = ComUtil.GetCom(labelObj, "LayoutAuto")
        end
        local _cfg = oldCardData.isMonster and oldCardData:GetCardCfg() or oldCardData:GetCardCfg()
        local strs = RoleUniteUtil:GetStrs(_cfg)
        if (#strs > 0) then
            labelGos = labelGos or {}
            if (#labelGos < 1) then
                table.insert(labelGos, label.gameObject)
            end
            for i = 1, #strs do
                local go = nil
                if (labelGos[i]) then
                    go = labelGos[i]
                else
                    go = CSAPI.CloneGO(labelGos[1], labelObj.transform)
                    table.insert(labelGos, go)
                end
                CSAPI.SetGOActive(go, true)
                local text = ComUtil.GetComInChildren(go, "Text")
                text.text = strs[i]
            end
            if (#strs < #labelGos) then
                for i = #strs + 1, #labelGos do
                    CSAPI.SetGOActive(labelGos[i], false)
                end
            end

            layoutAuto:Refresh()
        end
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

-------------------------------------------------------------------------------------------------------------------------
-- -- 服装
-- function OnClickApparel()
--     -- if (not cardData.isMonster) then
--     CSAPI.PlayUISound("ui_generic_tab_2")
--     CSAPI.OpenView("RoleApparel", cardData, cardData.isMonster)
--     -- end
--     --
--     local twoCardID = RoleTool.GetTwoCfgID(oldCardData:GetCfgID())
--     RoleSkinMgr:SetIsNewAdd(twoCardID)
--     UIUtil:SetRedPoint(btnApparel, false, 58.3, 26.2, 0)
-- end

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
        CSAPI.OpenView("ArchiveRole", _data)
    else
        Tips.ShowTips(str)
    end
end

-- -- 标签
-- function OnClickTag()
--     CSAPI.PlayUISound("ui_generic_tab_2")
--     CSAPI.OpenView("RoleInfoTag", cardData)
-- end

-- -- 升级
-- function OnClickUp()
--     if (cardData:IsFighting()) then
--         LanguageMgr:ShowTips(1003)
--         return
--     end
--     CSAPI.OpenView("RoleCenter", {cardData}, "up")
-- end

-- -- 点击特殊技能
-- function OnClickSpecialSkill()
--     CSAPI.PlayUISound("ui_generic_tab_2")
--     local _data = cardData:GetSpecialSkill()[1]
--     if (_data) then
--         if (not PlayerClient:IsPassNewPlayerFight()) then
--             LanguageMgr:ShowTips(1006)
--             return
--         else
--             CSAPI.OpenView("RoleInfoFussion", {cardData, _data})
--         end
--     end
-- end

-- 属性展开
function OnClickAttributeDetail()
    CSAPI.OpenView("AttributeInfoTView", cardData)
end

-- -- 装备界面
-- function OnClickEquip()
--     if (not isRealCard) then
--         return
--     end
--     CSAPI.OpenView("RoleEquip", {card=cardData})
--     -- LogError("TODO")
-- end

-- -- 装备属性
-- function OnClickEquipDetail()
--     -- LogError("TODO")
--     CSAPI.OpenView("RoleEquippedInfo", cardData)
-- end

-- -- 天赋界面
-- function OnClickTalentDetail()
--     if (cardData:IsFighting()) then
--         LanguageMgr:ShowTips(1003)
--         return
--     end

--     CSAPI.OpenView("RoleCenter", {cardData}, "talent")
-- end

-- 基建技能
function OnClickMatrixSkill()
    -- todo 
end
