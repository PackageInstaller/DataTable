-- 卡牌工具
RoleTool = {}
local this = RoleTool

-- 升到最大等级需要的经验(真实需要经验)
function this.GetExpForMaxLv(cardData)
    if (cardData == nil) then
        return 0
    end
    local lv = cardData:GetLv()
    local max = cardData:GetMaxLv()
    if (lv >= max) then
        return 0
    end
    local maxExp = -cardData:GetEXP()
    for i = lv, (max - 1) do
        maxExp = maxExp + this.GetExpByLv(i)
    end
    return maxExp > 0 and maxExp or 0
end

-- 升到指定等级需要的经验(真实需要经验)
function this.GetExpForLv(curExp, curlv, tolv)
    if (curlv >= tolv) then
        return 0
    end
    local maxExp = -curExp
    for i = curlv, (tolv - 1) do
        maxExp = maxExp + this.GetExpByLv(i)
    end
    return maxExp > 0 and maxExp or 0
end

-- 等级经验
function this.GetExpByLv(lv)
    if (lv == nil or lv == 0) then
        return 0
    end
    local cfg = Cfgs.CardLevel:GetByID(lv)
    return cfg and cfg.exp or 0
end

-- 卡牌最大等级 
function this.GetMaxLv()
    local cfg = Cfgs.CardLevel:GetAll()
    return #cfg
end

-- 卡牌最大突破等级
function this:GetMaxBreakLv()
    local cfg = Cfgs.CardBreak:GetAll()
    return #cfg
end

-- =========================立绘、live2d--------------------------------------------------------------------------------
-- 混合
-- function this.LoadImgByID(_imgGo, _modelId, _posType, _callBack)
--     if (_modelId < 10000) then
--         this.LoadMulImg(_imgGo, _modelId, _posType, _callBack)
--     else 
--         this.LoadImg(_imgGo, _modelId, _posType, _callBack)
--     end 
-- end

-- 混合加载（无语言表情的不可调用，直接用this.LoadImg）
function this.AddRole(_parent, _playCB, _endCB, _needClick)
    if (_parent == nil) then
        return
    end
    local go = ResUtil:CreateUIGO("Common/RoleSpineItem0", _parent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Init(_playCB, _endCB, _needClick, false)
    return lua
end

-- -- 仅加载 img（含表情）
-- function this.AddImg(_parent, _playCB, _endCB, _needClick)
--     if (_parent == nil) then
--         return
--     end
--     local go = ResUtil:CreateUIGO("Common/CardImgItem", _parent.transform)
--     local lua = ComUtil.GetLuaTable(go)
--     lua.Init(_playCB, _endCB, _needClick)
--     return lua
-- end

-- -- 仅加载l2d
-- function this.AddLive2D(_parent, _playCB, _endCB, _needClick)
--     if (_parent == nil) then
--         return
--     end
--     local go = ResUtil:CreateUIGO("Common/CardLive2DItem", _parent.transform)
--     local lua = ComUtil.GetLuaTable(go)
--     lua.Init(_playCB, _endCB, _needClick)
--     return lua
-- end

-- 仅加载图片（只有立绘）
function this.LoadImg(_imgGo, _modelId, _posType, _callBack)
    if (_modelId == nil or _imgGo == nil) then
        LogError("nil")
        return
    end
    local pos, scale, img, l2dName = this.GetImgPosScale(_modelId, _posType)
    ResUtil.ImgCharacter:Load(_imgGo, img, function(go)
        CSAPI.SetAnchor(_imgGo, pos.x, pos.y, pos.z)
        CSAPI.SetScale(_imgGo, scale, scale, 1)
        if (_callBack) then
            _callBack(go)
        end
    end)
    -- 添加和谐 
    SetHX(_imgGo, _modelId, _posType, pos, scale)
end

-- 和谐预制体
function SetHX(_imgGo, _modelId, _posType, pos, scale)
    if (not _imgGo or not _modelId) then
        return
    end
    local hxObj = _imgGo.transform:Find("_hxObj")
    if (hxObj) then
        CSAPI.RemoveGO(hxObj.gameObject)
    end
    local isHX = false
    local _cfg = _modelId < 10000 and Cfgs.CfgArchiveMultiPicture:GetByID(_modelId) or Cfgs.character:GetByID(_modelId)
    if (_cfg and _cfg.hxact and CSAPI.CheckFHX() ~= nil and not CSAPI.CheckFHX()) then
        local path = "SpineHX/" .. _modelId .. "/" .. _modelId
        CSAPI.CreateGOAsync(path, 0, 0, 0, _imgGo.gameObject, function(go)
            if(go~=nil)then
                go.name = "_hxObj"
                local offset = _posType or {0, 0, 1}
                CSAPI.SetAnchor(go, offset[1] - pos.x, offset[2] - pos.y)
                CSAPI.SetScale(go, offset[3] / scale, offset[3] / scale, 1)
            end 
        end)
    end
end

-- 立绘配置表信息   
function this.GetImgPosScale(modelId, posType, isL2d)
    local pos, scale, img, l2dName = nil, 1, nil, nil
    local cfg = Cfgs.character:GetByID(modelId)
    if (cfg) then
        local _pos = isL2d and cfg.l2dPos or cfg.imgPos
        local offset = posType or {0, 0, 1}
        pos = UnityEngine.Vector3(_pos[1] + offset[1], _pos[2] + offset[2], 0)
        scale = _pos[3] * offset[3]
        img = cfg.img
        l2dName = cfg.l2dName
    else
        LogError("角色模型表不存在id：" .. tostring(modelId))
    end
    return pos, scale, img, l2dName
end

-- =========================多人插图--------------------------------------------------------------------------------

-- --添加多人插图
-- function this.AddMulIcon(_parent, _playCB, _endCB, _needClick)
--     if (_parent == nil) then
--         return
--     end
--     local go = ResUtil:CreateUIGO("Common/MulIconItem", _parent.transform)
--     local lua = ComUtil.GetLuaTable(go)
--     lua.Init(_playCB, _endCB, _needClick)
--     return lua
-- end

-- 混合加载（无语言表情的不可调用，直接用this.LoadImg）
function this.AddMulRole(_parent, _playCB, _endCB, _needClick)
    if (_parent == nil) then
        return
    end
    local go = ResUtil:CreateUIGO("Common/RoleSpineItem0", _parent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Init(_playCB, _endCB, _needClick, true)
    return lua
end

-- -- 仅加载 img（含表情）
-- function this.AddMulImg(_parent, _playCB, _endCB)
--     if (_parent == nil) then
--         return
--     end
--     local go = ResUtil:CreateUIGO("Common/MulImgItem", _parent.transform)
--     local lua = ComUtil.GetLuaTable(go)
--     lua.Init(_playCB, _endCB)
--     return lua
-- end

-- -- 仅加载l2d
-- function this.AddMulLive2D(_parent, _playCB, _endCB)
--     if (_parent == nil) then
--         return
--     end
--     local go = ResUtil:CreateUIGO("Common/MulLive2DItem", _parent.transform)
--     local lua = ComUtil.GetLuaTable(go)
--     lua.Init(_playCB, _endCB)
--     return lua
-- end

-- 仅加载图片（只有立绘）
function this.LoadMulImg(_imgGo, _modelId, _posType, _callBack)
    if (_modelId == nil or _imgGo == nil) then
        LogError("nil")
        return
    end
    local pos, scale, img, l2dName = this.GetMulImgPosScale(_modelId, _posType)
    local rate = 1 -- UIUtil:GetSceneRate({2240, 1080})
    scale = scale * rate
    ResUtil.MultiImg:Load(_imgGo, img, function(go)
        CSAPI.SetAnchor(_imgGo, pos.x, pos.y, pos.z)
        CSAPI.SetScale(_imgGo, scale, scale, 1)
        if (_callBack) then
            _callBack(go)
        end
    end)
end

-- 立绘配置表信息   
function this.GetMulImgPosScale(modelId, posType, isL2d)
    local pos, scale, img, l2dName = nil, 1, nil, nil
    local cfg = Cfgs.CfgArchiveMultiPicture:GetByID(modelId)
    if (cfg) then
        local _pos = isL2d and cfg.l2dPos or cfg.imgPos
        local offset = posType or {0, 0, 1}
        pos = UnityEngine.Vector3(_pos[1] + offset[1], _pos[2] + offset[2], 0)
        scale = _pos[3] * offset[3]
        img = cfg.img
        l2dName = cfg.l2dName
    else
        LogError("多人插图表不存在id：" + tostring(modelId))
    end
    return pos, scale, img, l2dName
end

-- 爱相随立绘配置表信息   
function this.GetMulImgPosScale2(modelId, posType, isL2d)
    local pos, scale, img, l2dName = nil, 1, nil, nil
    local cfg = Cfgs.CfgDateCG:GetByID(modelId)
    if (cfg) then
        local _pos = isL2d and cfg.l2dPos or cfg.imgPos
        local offset = posType or {0, 0, 1}
        pos = UnityEngine.Vector3(_pos[1] + offset[1], _pos[2] + offset[2], 0)
        scale = _pos[3] * offset[3]
        img = cfg.img
        l2dName = cfg.l2dName
    else
        LogError("多人插图表不存在id：" + tostring(modelId))
    end
    return pos, scale, img, l2dName
end

-- =========================end--------------------------------------------------------------------------------

-- 属性str
function this.GetStatusValueStr(_key, _num)
    if (_key == "career") then
        local strs = StringUtil:split(LanguageMgr:GetByID(1089), ",") or {}
        return strs[math.floor(_num)]
    elseif (_key == "maxhp" or _key == "defense" or _key == "attack" or _key == "speed" or _key == "sp") then
        return math.modf(_num) .. ""
    elseif (_key == "nStep" or _key == "nJump") then
        if (_num == 0) then
            return "0"
        end
        return _num > 0 and "+" .. math.modf(_num) .. "" or math.modf(_num) .. ""
    elseif (_key == "nMoveType") then
        return Cfgs.CfgMoveEnum:GetByID(_num).sName or ""
    else
        local str = string.match(_num * 100, "%d+");
        return str .. "%"
    end
end

-- 28001：SP（同步率）
-- 28012：SP（同步）
-- 28013：NP（能量值）
-- 28014：NP（能量）
-- 封装技能消耗的显示
function this.GetSPStr(cfg)
    local num = 0
    local str = ""
    local _spStr = LanguageMgr:GetByID(28012) or "SP"
    local _npStr = LanguageMgr:GetByID(28014) or "NP"
    if cfg.sp and cfg.sp > 0 then
        str = _spStr .. "  -" .. cfg.sp
        num = cfg.sp
    elseif cfg.np and cfg.np > 0 then
        str = _npStr .. "  -" .. cfg.np
        num = cfg.np
    end
    return str, num
end

-- 封装技能消耗的显示
function this.GetNPStr(cfg)
    local num = 0
    local _spStr = LanguageMgr:GetByID(28012) or "SP"
    local _npStr = LanguageMgr:GetByID(28014) or "NP"
    local str = _npStr
    if cfg.sp and cfg.sp > 0 then
        str = _spStr
        num = cfg.sp
    elseif cfg.np and cfg.np > 0 then
        str = _npStr
        num = cfg.np
    end
    return str, num
end

-- 优先度：战斗中>远征中>冷却中>训练中>演习中（表示演习编队中）>军演中（军演编队中)>助战中
function this.GetStateStr(_cardData)
    local index = nil
    if (_cardData:GetType() == RoleCardType.card) then
        local cid = _cardData:GetID()
        if TeamMgr:GetCardIsDuplicate(cid) then
            index = 1
        elseif (MenuMgr:CheckSystemIsOpen("Matrix") and _cardData:IsInExpedition()) then
            index = 2
            -- elseif(MenuMgr:CheckSystemIsOpen("CoolView") and CoolMgr:CheckIsIn(cid)) then
            -- 	index = 3
        elseif (MenuMgr:CheckSystemIsOpen("special4", OpenViewType.special) and RoleSkillMgr:CheckIsIn(cid)) then
            index = 4
            -- 演习、pvp 本次不开放 rui/20220608
            -- elseif(MenuMgr:CheckSystemIsOpen("special5", OpenViewType.special) and(TeamMgr:CheckIsInTeam(cid, eTeamType.PracticeAttack) or TeamMgr:CheckIsInTeam(cid, eTeamType.PracticeDefine))) then
            -- index = 5
            -- elseif (MenuMgr:CheckSystemIsOpen("special6", OpenViewType.special) and
            --     TeamMgr:CheckIsInTeam(cid, eTeamType.RealPracticeAttack)) then
            --     index = 6
            -- elseif (MenuMgr:CheckSystemIsOpen("PlayerView") and TeamMgr:CheckIsInTeam(cid, eTeamType.Assistance)) then
            -- index = 7
        end
    end
    return index
end

-- 限制等级
function this.GetLimitLv(coreLv, quality)
    local cfg = Cfgs.CfgCardCoreLv:GetByID(quality)
    return cfg.infos[coreLv].limitLv
end

-- 下一限制等级
function this.GetNextLimitLv(_cardData)
    local coreLv = _cardData:GetCoreLv() + 1
    local cfg = Cfgs.CfgCardCoreLv:GetByID(_cardData:GetQuality())
    return cfg.infos[coreLv].limitLv
end

-- 核心升级消耗碎片数量
function this.GetCoreUpgrateCostNum(_cardData)
    local coreCfg = Cfgs.CfgCardCoreLv:GetByID(_cardData:GetQuality())
    local lvCfg = coreCfg.infos[_cardData:GetCoreLv()]
    return lvCfg.costNum or 0
end

-- 核心升级的额外素材
function this.GetCoreUpgrateElseCost(_cardData)
    local coreCfg = Cfgs.CfgCardCoreLv:GetByID(_cardData:GetQuality())
    local lvCfg = coreCfg.infos[_cardData:GetCoreLv()]
    local nClass = _cardData:GetCamp()
    for i, v in ipairs(lvCfg.costArr) do
        if (v[1] == nClass) then
            return v[2]
        end
    end
    return nil
end

-- 是否已是最大跃升等级
function this.IsMaxBreakLevel(_cardData)
    return _cardData:GetBreakLevel() >= #CardBreak and true or false
end

-- 获取卡牌的最大突破等级
function this.GetMaxCoreLv(quality)
    local coreCfg = Cfgs.CfgCardCoreLv:GetByID(quality)
    return #coreCfg.infos
end

-- 是否最大突破等级
function this.IsMaxCoreLv(_cardData)
    return _cardData:GetCoreLv() >= this.GetMaxCoreLv(_cardData:GetQuality()) and true or false
end

-- 主天赋升级消耗碎片数量
function this.GetTalentUpgrateCostNum(_cardData, _skillData)
    local quality = _cardData:GetQuality()
    local taletCfg = Cfgs.CfgMainTalentSkillUpgrade:GetByID(quality)
    local cfg = Cfgs.skill:GetByID(_skillData.id)
    local lvCfg = taletCfg.infos[cfg.lv]
    return lvCfg.costNum or 0
end

-- 主天赋升级的额外素材
function this.GetTalentUpgrateElseCost(_cardData, _skillData)
    local quality = _cardData:GetQuality()
    local taletCfg = Cfgs.CfgMainTalentSkillUpgrade:GetByID(quality)
    local cfg = Cfgs.skill:GetByID(_skillData.id)
    local lvCfg = taletCfg.infos[cfg.lv]
    local nClass = _cardData:GetCamp()
    for i, v in ipairs(lvCfg.costArr) do
        if (v[1] == nClass) then
            return v[2]
        end
    end
    return nil
end

function this.GetSkillColor(icon_bg_type)
    local iconColors = {"ffffff", "57bd7e", "39a9ff", "cf83f3", "ffb847", "ff4747"}
    return iconColors[icon_bg_type] or "ffffff"
end

-- 新卡：同调，形态切换， 解限
function this.GetNewCardData1(oldCardData, newCardCfgID)
    -- 形态切换、同调 --等级继承，技能、被动技能继承等级，副天赋继承主体，变更皮肤
    local cardCfg = Cfgs.CardData:GetByID(newCardCfgID)
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
    newInfo.cfgid = newCardCfgID
    newInfo.skills = newSkillDatas
    return CharacterCardsData(newInfo, false)
end

-- 新卡：召唤
function this.GetNewCardData2(oldCardData, monsterCfgID)
    -- 召唤 --等级继承，技能、被动技能不继承(到怪物表拿数据)、无副天赋
    local cardCfg = Cfgs.MonsterData:GetByID(monsterCfgID)
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
    -- 重新封装
    local newInfo = {}
    local key = string.format("%s_%s", cardCfg.numerical, oldCardData:GetLv())
    local _cfg = Cfgs.MonsterNumerical:GetByKey(key)
    newInfo = table.copy(_cfg)
    newInfo.cfgid = monsterCfgID
    newInfo.skills = newSkillDatas
    newInfo.break_level = 1
    newInfo.intensify_level = 1
    newInfo.skin_a = oldCardData:GetData().skin_a
    local monsterCardsData = require "MonsterCardsData"
    return MonsterCardsData(newInfo)
end

-- 技能id获取怪物id （必须是召唤技能）
function this.GetMonsterIDBySkillID(skillID)
    local cfg = Cfgs.skill:GetByID(skillID)
    local arg = Cfgs.SkillEffect:GetByID(cfg.DoSkill[1]).arg
    local strs = StringUtil:split(arg, ",")
    return tonumber(strs[1])
end

-- -- 获取卡牌id（机神、同调、形切）
-- function this.GetTwoCfgID(baseCfgID)
--     local cfg = Cfgs.CardData:GetByID(baseCfgID)
--     if (cfg.fit_result) then
--         return cfg.fit_result
--     elseif (cfg.tTransfo) then
--         return cfg.tTransfo[1]
--     elseif (cfg.summon) then
--         local cardCfg = Cfgs.MonsterData:GetByID(cfg.summon)
--         return cardCfg.card_id
--     end
--     return nil
-- end

-- 获取绑定的skin_a
function this.GetBDSkin_a(baseCfgID, curModeId)
    local skin_a = nil
    local elseCfgID = GCalHelp:GetElseCfgID(baseCfgID)
    if (elseCfgID) then
        local cfg = Cfgs.CardData:GetByID(baseCfgID)
        local elseCfg = Cfgs.CardData:GetByID(elseCfgID)
        if (cfg.skin and elseCfg.skin) then
            for k, v in ipairs(cfg.skin) do
                if (v == curModeId) then
                    skin_a = elseCfg.skin[k]
                    break
                end
            end
            if (not skin_a) then
                skin_a = elseCfg.model
            end
        end
    end
    return skin_a
end

-- 卡牌当前的机神、形切、同调的皮肤
function this.GetElseSkin(cardData)
    local skin_a = cardData:GetData().skin_a
    if (skin_a == nil or skin_a == 0) then
        local cfgid = nil
        if (cardData:GetID() == g_InitRoleId[1] or cardData:GetID() == g_InitRoleId[2]) then
            --主角要读取真实数据
            local specialSkillData = cardData:GetSpecialSkill()[1]
            local cfg = this.GetRoleCfgBySkillID(specialSkillData.id)
            cfgid = cfg.id
        else
            cfgid = GCalHelp:GetElseCfgID(cardData:GetCfgID())
        end
        if (cfgid) then
            local cfg = Cfgs.CardData:GetByID(cfgid)
            skin_a = cfg.model
        else
            skin_a = cardData:GetCfg().model
        end
    end
    return skin_a
end

-- 通过怪物技能id获取卡牌表
function this.GetRoleCfgBySkillID(skillID)
    local monsterID = RoleTool.GetMonsterIDBySkillID(skillID)
    local monsterCfg = Cfgs.MonsterData:GetByID(monsterID)
    return Cfgs.CardData:GetByID(monsterCfg.card_id)
end

function this.SetWeapon(cardData, objWeapon, imgWeapon, txtWeaponLv)
    if (not cardData) then
        CSAPI.SetGOActive(objWeapon, false)
        return
    end
    local isHaveWeapon, isUnLock = cardData:HaveWeapon()
    CSAPI.SetGOActive(objWeapon, isHaveWeapon)
    if (isHaveWeapon) then
        local alpha = isUnLock and 1 or 0.3
        CSAPI.SetGOAlpha(objWeapon, alpha)
        local weaponLv = cardData:GetWeaponLv()
        local cfg = Cfgs.CfgCardWeapon:GetByID(cardData:GetCfgID())
        local childCfg = cfg.infos[weaponLv + 1]
        ResUtil.RoleWeapon:Load(imgWeapon, childCfg.icon)
        CSAPI.SetText(txtWeaponLv, weaponLv .. "")
    end
end

-- 保存spine状态(只保存非默认):模型id，切换角色索引，切换idle索引
function this.SaveSpineState(_spineState)
    local spineState = _spineState or {}
    local isSame = FuncUtil.TableIsSame(spineState, this.spineState)
    if (not isSame) then
        this.spineState = spineState
        FileUtil.SaveToFile("spinestate.txt", this.spineState)
    end
end

-- 获取spine保存的状态
function this.GetSpineState(curModelId)
    if (not this.spineState) then
        this.spineState = FileUtil.LoadByPath("spinestate.txt")
        if (not this.spineState) then
            FileUtil.SaveToFile("spinestate.txt", {})
            this.spineState = {}
        end
    end
    if (this.spineState[1] ~= curModelId) then
        if (this.spineState[1] ~= nil) then
            FileUtil.SaveToFile("spinestate.txt", {})
        end
        this.spineState = {}
    end
    return table.copy(this.spineState)
end

function this.GetCorrectID(cfgID)
    if (cfgID == 71013 or cfgID == 71023) then
        return PlayerClient:GetSex() == 1 and 71013 or 71023
    end
    return cfgID
end

return this
