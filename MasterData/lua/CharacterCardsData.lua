-- 角色卡牌数据
-- data:协议数据
-- curData:卡牌当前属性
local this = oo.class(GridDataBase);

-- 设置角色物品信息
function this:Init(characterData, isRealCard)
    if characterData then
        self.haloInfos = nil
        self.data = characterData;
        self:InitCfg(self.data.cfgid);
        if (self.cfg) then
            local modelId = self:GetSkinID()
            self:InitModel(modelId)
        end
        -- 是否是自己的真实获得的卡牌
        if (isRealCard ~= nil) then
            self.isRealCard = isRealCard
        end
        -- 总战力
        -- self:GetTotalProperty()
        -- 能否跃升突破
        self:CheckRed()
        -- 解禁数据 
        if (self.data.open_cards and #self.data.open_cards > 0) then
            RoleSkinMgr:AddRoleJieJinSkin(self.cfg.role_id, self.data.open_cards)
        end
        if (self.data.open_mechas and #self.data.open_mechas > 0) then
            RoleSkinMgr:AddMechaJieJinSkin(self.cfg.add_role_id, self.data.open_mechas)
        end
    end
end
-- 初始化配置
function this:InitCfg(cfgid)
    if (cfgid == nil) then
        LogError("初始化物品配置失败！无效配置idCGD");
    end

    -- if (self.cfg == nil) then
    self.cfg = Cfgs.CardData:GetByID(cfgid); -- 持有引用
    -- end
end

-- 初始化模型配置
function this:InitModel(modelId)
    if (modelId == nil) then
        LogError("该表id模型为空：" .. self.cfg.id)
        return
    end
    self.cfgModel = Cfgs.character:GetByID(modelId);
end

function this:GetIconLoader()
    return ResUtil.RoleCard;
end

function this:GetClassType()
    return "CharacterCardsData"
end
--------------------------------------通用数据获取----------------------------------------
-- 物品类型
function this:GetItemType()
    return ITEM_TYPE.CARD
end

-- 表ID
function this:GetCfgID()
    return self.data and self.data.cfgid or -1;
end

-- 获取id
function this:GetID()
    if (self.data and self.data.cid) then
        return self.data.cid
    else
        return self:GetCfgID()
    end
end
-- 获取数据
function this:GetData()
    return self.data;
end
-- 获取配置
function this:GetCfg()
    return self.cfg;
end
-- 获取类型
function this:GetType()
    return self.cfg and self.cfg.card_type or 1
end

-- 获取名称
function this:GetName()
    return self.cfg and self.cfg.name or ""
    -- return self.data and self.data.name or self.cfg.name
end

-- 获取名称
function this:GetEnName()
    return self.cfg and self.cfg.nameEng or ""
end

-- 获取数量 
function this:GetCount()
    return self.data and self.data.num or 1;
end
-- 获取等级
function this:GetLv()
    return self.data and self.data.level or 1;
end
-- 获取品质 
function this:GetQuality()
    local quality = self.cfg and self.cfg.quality or 1;
    return quality > 6 and 6 or quality
end
-- --星级()
-- function this:GetStar()
-- 	local quality = self.cfg and self.cfg.quality or 1;
-- 	return quality --> 5 and 5 or quality
-- end

-- 获取图标
function this:GetIcon()
    if (self.cfgModel) then
        return self.cfgModel.icon;
    end
    return nil;
end

-- 列表 图
function this:Card_head()
    if (self.cfgModel) then
        return self.cfgModel.Card_head
    end
    return nil
end

-- 矩形
function this:GetSmallImg()
    if (self.cfgModel) then
        return self.cfgModel.List_head
    end
    return nil
end

-- 立绘
function this:GetDrawImg()
    if (self.cfgModel) then
        return self.cfgModel.img
    end
    return nil
end

-- 圆形头像
function this:GetCircleHead()
    if (self.cfgModel) then
        return self.cfgModel.circleHead
    end
    return nil
end

-- 返回是否是新卡牌
function this:IsNew()
    return self.data and self.data.is_new == true or false;
end

function this:SetIsNew(b)
    self.data.is_new = b
end

-- 排序用
function this:IsNewNum()
    return self:IsNew() and 1 or 0
end

-- 返回获得次数
function this:GetQuantity()
    return self.data and self.data.get_cnt or 0;
end

-- 获取模型配置
function this:GetModelCfg()
    return self.cfgModel;
end

-- 返回合体方向 state:-1:表示没有合体行为, 1:表示横向合体,2表示纵向合体,3表示横向&纵向合体
function this:GetFitDirection()
    local state = -1;
    if self.fitState == nil then
        if (self.cfg.fit_result) then -- 可以合体
            local result = Cfgs.MonsterData:GetByID(self.cfg.fit_result);
            if result == nil then
                LogError("没有找到怪物合体结果！");
                return state;
            end
            if result.grids == nil then
                LogError("没有找到怪物合体后的站位信息！");
                return state;
            end
            local cfgFormation = Cfgs.MonsterFormation:GetByID(result.grids);
            local hasRow = false;
            local hasCol = false;
            if (cfgFormation) then
                for _, v in ipairs(cfgFormation.coordinate) do
                    if (v[1] ~= 0) then
                        hasRow = true;
                    end
                    if (v[2] ~= 0) then
                        hasCol = true;
                    end
                end
            else
                LogError("MonsterFormation找不到占位数据" .. result.grids);
            end
            if hasRow and hasCol then
                state = 3;
            elseif hasRow and hasCol == false then
                state = 1;
            elseif hasRow == false and hasCol then
                state = 2;
            end
        end
    else
        state = self.fitState;
    end
    return state;
end

function this:GetGrids()
    return self.cfg.grids or nil;
end

-- 返回上阵的cost值
function this:GetCost()
    return self.cfg.fight_cost or 0;
end

-- 核心类型 12345 全能、机装、同调、特殊
function this:GetMainType()
    return self.cfg and self.cfg.main_type or nil
end

function this:GetDesc()
    return self.cfg and self.cfg.desc or ""
end

-- 返回所属角色ID
function this:GetRoleID()
    return self.cfg and self.cfg.role_id or nil;
end

-- 卡牌角色
function this:GetCRoleData()
    if (self:GetRoleID()) then
        if (self.isRealCard) then
            return CRoleMgr:GetData(self:GetRoleID())
        else
            local maxLv = self:GetCRoleLv()
            return CRoleMgr:GetFakeData(self:GetRoleID(), {
                lv = maxLv
            })
        end
    end
    return nil
end

-- 是否含有限时皮肤
function this:CheckLimitSkin()
    if (self:GetRoleID()) then
        return RoleSkinMgr:IsHadLimitSkin(self:GetRoleID())
    end
    return false
end

-- 当前使用的皮肤是否使用l2d
function this:GetSkinIsL2d()
    if (self:IsBaseCard()) then
        return self:GetSkinIsL2dBase()
    else
        return self:GetSkinIsL2dElse()
    end
end

function this:GetSkinIsL2dBase()
    if (self.data and self.data.skinIsl2d ~= nil) then
        return self.data.skinIsl2d == BoolType.Yes
    end
    return false
end
function this:GetSkinIsL2dElse()
    if (self.data and self.data.skinIsl2d_a ~= nil) then
        return self.data.skinIsl2d_a == BoolType.Yes
    end
    return false
end

-- 当前使用的皮肤
function this:GetSkinID()
    if (self:IsBaseCard()) then
        return self:GetSkinIDBase()
    else
        return self:GetSkinIDElse()
    end
end

function this:GetSkinIDBase()
    if (self.data and self.data.skin ~= nil and self.data.skin ~= 0) then
        return self.data.skin
    end
    return self.cfg.model
end
-- 不要用原卡数据直接调用（用这个RoleTool.GetElseSkin()）
function this:GetSkinIDElse()
    if (self.data and self.data.skin_a ~= nil and self.data.skin_a ~= 0) then
        return self.data.skin_a
    end
    return self.cfg.model
end

-- 返回角色标示
function this:GetRoleTag()
    return self.cfg and self.cfg.role_tag or nil;
end

--------------------------------------角色当前属性获取----------------------------------------
-- 获取方式: 如 攻击力=self.curData.attack
function this:GetCurData()
    if (not self.curData) then
        self:GetTotalProperty()
    end
    return self.curData
end

-- 获取某个属性 (key对应卡牌表的key）  是否取整默认为true
function this:GetCurDataByKey(key, integer)
    if (self:GetCurData()) then
        return (integer and integer == true) and math.modf(self.curData[key]) or self.curData[key]
    end
    return nil
end

-- 获取阵营 小队
function this:GetCamp()
    return self.cfg.nClass or 1
end

-- 定位列表
function this:GetPosEnum()
    return self.cfg.pos_enum
end

-- 入手顺序
function this:GetAcquireTime()
    return self.data and self.data.ctime or 0
end

-- 好感度
function this:GetFavorability()
    if (self:GetRoleID()) then
        local cRoleData = CRoleMgr:GetData(self:GetRoleID())
        return cRoleData and cRoleData:GetLv() or 1
    else
        return 1
    end
end

-- 是否过热
function this:IsOverHot()
    return self:GetHot() >= self:GetCurDataByKey("hot")
end

-- 当前血量
function this:GetHp()
    return self.data and self.data.hp or 0
end

-- 当前热值
function this:GetHot()
    return self.data and self.data.cur_hot or 0;
end

-- 当前上锁状态 1:锁 0：未锁
function this:IsLock()
    local isLock = false;
    if self.data and self.data.lock then
        isLock = self.data.lock == eLockState.Yes;
    end
    return isLock;
end

function this:GetLockNum()
    return self.data and self.data.lock or 0
end

-- 军演时缓存的性能
function this:GetDataPerformance()
    return self.data.performance or 0
end

-- 计算装备属性
function this:GetEquipSkillPoint()
    local list = {};
    local equips = self:GetEquips();
    if equips then
        for k, v in ipairs(equips) do
            local skills = v:GetSkills()
            skills = skills or {}
            local param = {
                cfgid = v:GetCfgID(), -- 装备的配置id
                level = v:GetLv(), -- 装备等级
                --  randSkillType = v:GetSkillType(), --随机技能类型
                --  randSkillValue = v:GetRandSkillValue(), --随机技能值
                skills = skills
            }
            table.insert(list, param);
        end
    end
    return GEquipCalculator:CalEquipPropertys(list, CSAPI.IsADVRegional(3));
end

-- 基础属性（不包含装备天赋）
function this:GetBaseProperty()
    local baseData = GCardCalculator:CalLvlPropertys(self:GetCfgID(), self:GetLv(), self:GetIntensifyLevel(),
        self:GetBreakLevel(), false, self:GetCoreLv(), nil, true)
    return baseData
end

-- 计算卡牌的最终属性
function this:GetTotalProperty()
    local equips = self:GetEquipSkillPoint()
    local haloInfo = self.data and self.data.haloInfo or nil;
    self.curData = GCardCalculator:CalPropertys(self:GetCfgID(), self:GetLv(), self:GetIntensifyLevel(),
        self:GetBreakLevel(), equips, self.data.skills, self:GetDeputyTalent().use, false, self:GetCoreLv(), haloInfo,
        self:GetWeaponLv())

    self.fighting = self.curData.performance or 0
    return self.curData
end

-- 性能
function this:GetProperty()
    if (self.fighting == nil) then
        self:GetTotalProperty()
    end
    return self.fighting
end

-- --占格图标
-- function this:GetGridsImg()
-- 	return self.cfg and self.cfg.gridsIcon or ""
-- end
-- 返回合体对象，cfgid数组
function this:GetUnite()
    return self.cfg and self.cfg.unite or nil;
end

-- 判断合体对象中是否包含该ID
function this:IsInUnite(cfgID)
    local uniteIDs = self:GetUnite();
    if uniteIDs then
        for k, v in ipairs(uniteIDs) do
            if v == cfgID then
                return true;
            end
        end
    end
    return false;
end

-- 返回当前装备IDS
function this:GetEquipIds()
    return self.data and self.data.equip_ids or nil;
end

-- 添加当前装备id
function this:AddEquipId(slot, id)
    if self.data and id and slot then
        self.fighting = nil;
        self.data.equip_ids = self.data.equip_ids or {};
        self.data.equip_ids[slot] = id
    end
end

-- 移除装备ID
function this:RemoveEquipId(id)
    if self.data and self.data.equip_ids and id then
        for k, v in pairs(self.data.equip_ids) do
            if v == id then
                self.fighting = nil;
                self.data.equip_ids[k] = nil;
            end
        end
    end
end

-- 返回当前装备
function this:GetEquips()
    local equips = nil;
    if self.data.equips then
        equips = equips or {};
        for k, v in pairs(self.data.equips) do
            local equip = EquipData(v);
            table.insert(equips, equip);
        end
    elseif self.data.equip_ids then
        equips = equips or {};
        for k, v in pairs(self.data.equip_ids) do
            local equip = EquipMgr:GetEquip(v);
            if equip then
                table.insert(equips, equip);
            end
        end
    end
    return equips;
end

-- 根据位置返回当前装备
function this:GetEquipBySlot(slotType)
    if self.data.equips then
        for k, v in pairs(self.data.equips) do
            local equip = EquipData(v);
            if equip and equip:GetSlot() == slotType then
                return equip;
            end
        end
    elseif self.data.equip_ids then
        for k, v in pairs(self.data.equip_ids) do
            local equip = EquipMgr:GetEquip(v);
            if equip and equip:GetSlot() == slotType then
                return equip;
            end
        end
    end
    return nil;
end

-- ----------------------------------------状态记录--------------------------------------
-- --是否被选中
-- function this:GetIsSelect()
-- 	return(self.isSelect == nil) and false or self.isSelect
-- end
-- function this:SetIsSelect(b)
-- 	b = b == nil and false or b
-- 	self.isSelect = b
-- end
-- --素材数量
-- function this:GetSelectCount()
-- 	return self.isSelect == true and self:GetCount() or 0
-- end
----------------------------------------技能相关-----------------------
function this:GetSkillByID(_skillID)
    if (self.data) then
        for i, v in pairs(self.data.skills) do
            if (v.id == _skillID) then
                return v
            end
        end
    end
    return nil
end

-- 不传入参数时获取普通技能（不包括特殊技能）
function this:GetSkills(_type)
    _type = _type == nil and SkillMainType.CardNormal or _type
    return self:GetSkillByType(_type)
end

-- 获取技能：普通技能+特性技能
function this:GetSkillsForShow()
    local newSkillDatas = {}
    local skillsDatas = self:GetSkills()
    local passiveData = self:GetSkills(SkillMainType.CardTalent)
    for i, v in ipairs(skillsDatas) do
        table.insert(newSkillDatas, v)
    end
    if (passiveData and #passiveData > 0) then
        table.insert(newSkillDatas, passiveData[1])
    end
    return newSkillDatas
end

-- 副天赋  {had,use}
function this:GetDeputyTalent()
    return self.data.sub_talent or {}
end

-- 特殊技能
function this:GetSpecialSkill()
    return self:GetSkillByType(SkillMainType.CardSpecial)
end

-- overload
function this:GetOverLoadSkill()
    if (self.data and self.data.skills) then
        for i, v in pairs(self.data.skills) do
            if (v.type == SkillMainType.CardNormal) then
                local cfg = Cfgs.skill:GetByID(v.id)
                -- if(cfg.type == SkillType.OverLoad) then
                if (cfg.upgrade_type == 4) then

                    return v
                end
            end
        end
    end
    return nil
end

--[[	-- 技能类型
SkillMainType = {}
SkillMainType.CardNormal = 1 -- 卡牌一般技能
SkillMainType.CardTalent = 2 -- 卡牌天赋技能
SkillMainType.CardSpecial = 3 -- 卡牌特殊技能
SkillMainType.CardSubTalent = 4 -- 卡牌副天赋技能
SkillMainType.Equip = 5 -- 装备技能
]]
function this:GetSkillByType(_type)
    local datas = {}
    if (self.data and self.data.skills) then
        for i, v in pairs(self.data.skills) do
            if (v.type == _type) then
                if (_type == SkillMainType.CardNormal) then
                    local cfg = Cfgs.skill:GetByID(v.id)
                    -- if(cfg.type ~= SkillType.OverLoad) then
                    if (cfg.upgrade_type ~= 4) then
                        table.insert(datas, v)
                    end
                else
                    table.insert(datas, v)
                end
            end
        end
    end
    if (#datas > 1) then
        table.sort(datas, function(a, b)
            return a.id < b.id
        end)
    end
    return datas
end

-- 通过组获取技能
function this:GetSkillByGroup(group)
    if (self.data and self.data.skills) then
        for i, v in pairs(self.data.skills) do
            local cfg = Cfgs.skill:GetByID(v.id)
            if (cfg.group == group) then
                return v
            end
        end
    end
    return nil
end

----------------------------------------等级相关-----------------------
-- 当前最大等级（限制等级）
function this:GetMaxLv()
    return self:GetCurData() and self:GetCurData().max_level or RoleTool.GetMaxLv()
end

-- 最大跃升解锁的上限等级
function this:GetBreakLimitLv()
    if (not self.break_limitLv) then
        local cfg = CfgCardBreakLimitLv[#CfgCardBreakLimitLv]
        self.break_limitLv = cfg.MaxLv
    end
    return self.break_limitLv
end

-- 最大突破解锁的等级上限
function this:GetCoreLimitLv()
    if (not self.core_limitLv) then
        local cfg = Cfgs.CfgCardCoreLv:GetByID(self:GetQuality())
        self.core_limitLv = cfg.infos[#cfg.infos].limitLv
    end
    return self.core_limitLv
end

-- 当前等级已有经验
function this:GetEXP()
    return self.data and self.data.exp or 0
end

-- 升级时提供的经验
function this:GetMaterialExp()
    return self.cfg and self.cfg.material_exp or 0
end

----------------------------------------强化相关-----------------------
-- 当前强化等级
function this:GetIntensifyLevel()
    return self.data.intensify_level or 1
end
-- --最大强化等级
-- function this:GetIntensifyMaxLevel()
-- 	return CardIntensify and #CardIntensify or 0
-- end
-- --当前强化已有经验
-- function this:GetIntensifyExp()
-- 	return self.data and self.data.intensify_exp or 0
-- end
-- --强化时提供的经验
-- function this:GetDecomposeExp()
-- 	return self.cfg and self.cfg.decompose_exp or 0
-- end
----------------------------------------突破相关-----------------------
-- 当前跃升等级（百级之内控制等级用）
function this:GetBreakLevel()
    return self.data and self.data.break_level or 1
end
-- 最大跃升等级
function this:GetBreakMaxlevel()
    return CardBreak and #CardBreak or 0
end

--[[--下一突破等级
function this:GetNextBreakLevel()
	local nextLv =(self:GetBreakLevel() + 1)
	return nextLv > self:GetBreakMaxlevel() and self:GetBreakMaxlevel() or nextLv
end

--突破模板
function this:GetBreakID()
	return self.cfg and self.cfg.break_id or nil
end

--当前突破材料
function this:GetBreakMaterials()
	if(self:IsMaxBreakLevel()) then
		return self:IsMaxBreakLevel() and nil or {}
	else
		local breakID = self:GetBreakID()
		if(breakID and Cfgs.CardBreakMaterial) then
			return Cfgs.CardBreakMaterial:GetByID(breakID).materials
		end
	end
	return nil
end

--突破金钱
function this:GetBreakMoney()
	local breakID = self:GetBreakID()
	if(breakID and Cfgs.CardBreakMaterial) then
		return Cfgs.CardBreakMaterial:GetByID(breakID).gold
	end
	return 0
end
]]
function this:GetAssistData()
    local assistData = nil;
    if self.data and self.data.assist then
        assistData = self.data.assist;
    end
    return assistData;
end

-- 分解时能否自动选择
function this:SetCanAntoDelete(b)
    self.canAutoDelete = b
    return self.canAutoDelete
end
function this:GetCanAntoDelete(b)
    return self.canAutoDelete ~= nil and self.canAutoDelete or false
end

-- 在关卡队伍
function this:IsFighting()
    return TeamMgr:GetCardIsDuplicate(self:GetID())
end

-- 是否是队长
function this:IsLeader()
    if (self.isLeader == nil) then
        local cfgID = RoleMgr:GetCurrSexCardCfgId()
        self.isLeader = self:GetCfgID() == cfgID
    end
    return self.isLeader
end

function this:LeaderSortNum()
    return self:IsLeader() and 2 or 1
end

-- 开始自然恢复热值的时间
function this:GetTAHot()
    if (self:GetData().mix_data) then
        return self:GetData().mix_data.tAHot
    end
    return nil
end

-- 卡牌角色好友度等级 （近好友的数据用）
function this:GetCRoleLv()
    if (self:GetData() and self:GetData().role) then
        return self:GetData().role.lv
    end
    return 100
end

-- 天赋是否已开启（跃升）
function this:CheckTalentIsOpen()
    local breakLv = self:GetBreakLevel()
    if (breakLv < 2) then
        local tips = LanguageMgr:GetTips(3005, 2)
        tips = string.format(tips, 2)
        return false, tips
    end
    return true, ""
end

-- 混合数据
function this:GetMixData()
    return self.data and self.data.mix_data or nil
end

-- 核心等级（突破,100级之后用）
function this:GetCoreLv()
    return self.data.mix_data and self.data.mix_data.cl or 1
end

-- 设置核心等级
function this:SetCoreLv(lv)
    self.data.mix_data = self.data.mix_data or {}
    self.data.mix_data.cl = lv

    self:GetTotalProperty()
end

-- 是否在远征中
function this:IsInExpedition()
    if (self.data.mix_data) then
        return self.data.mix_data.inExp == 1
    end
    return false
end

-- 是基础卡
function this:IsBaseCard()
    if (self:GetCfg().base_card) then
        return true
    end
    return false
end

-- 是自己真实获得的卡牌（不是假数据、助战、满级假卡）
-- function this:SetRealCard()
--     self.isRealCard = true
-- end
function this:CheckIsRealCard()
    return self.isRealCard
end

-- 满级假卡 
function this:SetMaxFakeCard()
    self.isMaxFakeCard = true
end
function this:CheckIsMaxFakeCard()
    return self.isMaxFakeCard == true and true or false
end

-- 根据突破等级获取副天赋技能id 
function this:GetTalentIDByBreakLV(breakLV)
    breakLV = breakLV or self:GetBreakLevel()
    local subTfSkills = self:GetCfg().subTfSkills
    local id = subTfSkills and subTfSkills[1] or nil
    local allDatas = id and Cfgs.CfgSubTalentSkillPool:GetByID(id) or nil
    return allDatas and allDatas.ids[breakLV - 1].id or nil
end

--------------------------------------跃升突破红点------------------------------------------------
function this:RoleCardRed()
    if (self:IsPassiveRed() or self:IsRed()) then
        return true
    end
    return false
end

-- 特性能否升级+未查看（进入查看后外面的红点要没）
function this:IsPassiveRed()
    if (self.passiveRed and not RoleMgr:CheckPassiveRedIsLook(self:GetID() .. "")) then
        return true
    end
    return false
end

-- 近升级突破跃升
function this:IsRed()
    return self.isRed
end

-- 检查红点 (登录、卡牌更新、物品更新都要刷新一次)
-- 跃升突破红点 ： 可跃升突破,材料够，未查看
function this:CheckRed()
    self.isRed = false

    -- 是否可跃升突破
    self:CheckCanBreak()

    -- 材料是否足够 
    self:CheckBreakEnough()

    -- 查看
    self:CheckIsLook()

    if (self.red_canbreak and self.red_breakEnough and self.isLook == false) then
        self.isRed = true
    end
end

-- 背包物品更新
function this:GoodsUpdate()
    -- 材料是否足够
    if (self.red_canbreak and self.isLook == false) then
        self:CheckBreakEnough()
        self.isRed = self.red_breakEnough
    end
end

-- 能否升级或突破
function this:CheckCanBreak()
    self.red_canbreak = false
    if (not self:CheckIsRealCard()) then
        return
    end
    if (not MenuMgr:CheckModelOpen(OpenViewType.special, "special1")) then
        return
    end
    local curLv = self:GetLv()
    local maxLv = self:GetMaxLv()
    local break_limitLv = self:GetBreakLimitLv()
    -- local core_limitLv = self:GetCoreLimitLv()
    local isMax = curLv >= break_limitLv -- core_limitLv 屏蔽 
    if (isMax or curLv < maxLv) then
        self.red_canbreak = false
    else
        self.red_canbreak = true
    end
    return self.red_canbreak
end

-- 是否够材料
function this:CheckBreakEnough()
    self.red_breakEnough = false
    if (not self:CheckIsRealCard()) then
        return
    end
    if (self.red_canbreak) then
        local curLv = self:GetLv()
        local break_limitLv = self:GetBreakLimitLv()
        if (curLv < break_limitLv) then
            -- 跃升
            self.red_breakEnough = self:CheckEnough1()
        else
            -- 突破 
            self.red_breakEnough = self:CheckEnough2()
        end
    end
    return self.red_breakEnough
end

-- 是否够材料跃升
function this:CheckEnough1()
    local breakLv = self:GetBreakLevel()
    local materialCfg = nil
    if (breakLv >= 5) then
        local matCfg2 = Cfgs.CardBreakMaterial2:GetByID(self:GetQuality())
        materialCfg = matCfg2.infos[breakLv]
    else
        local useBreakId = GCardCalculator:CalUseBreakId(self:GetCfg().break_id, breakLv)
        materialCfg = Cfgs.CardBreakMaterial:GetByID(useBreakId)
    end
    if materialCfg == nil then
        return false
    end
    if (materialCfg.gold and materialCfg.gold > PlayerClient:GetGold()) then
        return false
    else
        if (materialCfg.materials) then
            for i, v in ipairs(materialCfg.materials) do
                local goodsData = BagMgr:GetData(v[1])
                local curNum = goodsData and goodsData:GetCount() or 0
                local needNum = v[2]
                if (curNum < needNum) then
                    return false
                end
            end
        end
    end
    return true
end
-- 是否够材料突破
function this:CheckEnough2()
    -- mat 
    local goodsData1 = BagMgr:GetFakeData(self:GetCfg().coreItemId)
    local num1 = RoleTool.GetCoreUpgrateCostNum(self)
    local isEnough1 = goodsData1:GetCount() >= num1
    if (isEnough1) then
        return true
    end
    -- mat2 
    local cost = RoleTool.GetCoreUpgrateElseCost(self)
    local goodsData2 = cost ~= nil and BagMgr:GetFakeData(cost[1]) or nil
    local isEnough2 = cost ~= nil and goodsData2:GetCount() >= cost[2] or false
    return isEnough2
end

-- 检查是否已查看 跃升或者突破后要将已查看改成未查看
function this:CheckIsLook()
    if (self.isLook == nil) then
        self.oldBreakLv = self:GetBreakLevel()
        self.oldCoreLv = self:GetCoreLv()
        self.isLook = false
    elseif (self.isLook) then
        if (self.oldBreakLv ~= self:GetBreakLevel() or self.oldCoreLv ~= self:GetCoreLv()) then
            self.oldBreakLv = self:GetBreakLevel()
            self.oldCoreLv = self:GetCoreLv()
            self.isLook = false
        end
    end
    return self.isLook
end

-- 查看角色
function this:IsLook()
    if (self.isRed) then
        self.isLook = true
        self.isRed = false
        RoleMgr:CheckRed()
    end
end

-- 普通技能能否升级
function this:CheckNormalSkillUP(skillId)
    local isOpen = MenuMgr:CheckModelOpen(OpenViewType.special, "special4")
    if (not isOpen) then
        return false
    end
    local cfg = Cfgs.skill:GetByID(skillId)
    if (cfg == nil or cfg.next_id == nil) then
        return false
    end
    local expCfg = Cfgs.CardSkillExp:GetByID(self:GetQuality())
    local materialCfg = expCfg.arr[cfg.lv]
    local mats = materialCfg and materialCfg.costs or {}
    for i, v in ipairs(mats) do
        local goodsData = BagMgr:GetFakeData(v[1])
        if (goodsData:GetCount() < v[2]) then
            return false
        end
    end
    return true
end

function this:LookPassive()
    if (self.passiveRed and not RoleMgr:CheckPassiveRedIsLook(self:GetID() .. "")) then
        RoleMgr:SetPassiveRedIsLook(self:GetID() .. "", 1)
    end
end
-- 特性技能能否升级
-- 非登录时：未满足变成满足，设置未查看
function this:CheckPassiveUp0(isLogin)
    self:CheckPassiveUp()
    if (not isLogin) then
        if (self.passiveRed and self.old_passiveRed ~= nil and self.old_passiveRed == false and
            RoleMgr:CheckPassiveRedIsLook(self:GetID() .. "") and not CSAPI.IsViewOpen("RoleCenter")) then
            RoleMgr:SetPassiveRedIsLook(self:GetID() .. "", 0) -- 设置为未看
        end
    end
    self.old_passiveRed = self.passiveRed
end

-- 特性技能能否升级
function this:CheckPassiveUp()
    self.passiveRed = false
    local isOpen = MenuMgr:CheckModelOpen(OpenViewType.special, "special4")
    if (not isOpen) then
        return false
    end
    local passiveDatas = self:GetSkills(SkillMainType.CardTalent)
    if (passiveDatas and #passiveDatas > 0) then
        local passiveData = passiveDatas[1]
        local cfg = Cfgs.skill:GetByID(passiveData.id)
        if (cfg.next_id == nil) then
            return false
        end
        if (not self:GetCfg().coreItemId) then
            return false
        end
        local count1 = BagMgr:GetCount(self:GetCfg().coreItemId)
        local num1 = RoleTool.GetTalentUpgrateCostNum(self, passiveData)
        if (count1 >= num1) then
            self.passiveRed = true
            return true
        end

        local cost = RoleTool.GetTalentUpgrateElseCost(self, passiveData)
        if (cost) then
            local count2 = BagMgr:GetCount(cost[1])
            if (count2 >= cost[2]) then
                self.passiveRed = true
                return true
            end
        end
    end
    return false
end

-- 特性技能能否升级（只检查碎片）
function this:CheckPassiveUpOnlyChip()
    local isOpen = MenuMgr:CheckModelOpen(OpenViewType.special, "special4")
    if (not isOpen) then
        return false
    end
    local passiveDatas = self:GetSkills(SkillMainType.CardTalent)
    if (passiveDatas and #passiveDatas > 0) then
        local passiveData = passiveDatas[1]
        local cfg = Cfgs.skill:GetByID(passiveData.id)
        if (cfg.next_id == nil) then
            return false
        end
        if (not self:GetCfg().coreItemId) then
            return false
        end
        local count1 = BagMgr:GetCount(self:GetCfg().coreItemId)
        local num1 = RoleTool.GetTalentUpgrateCostNum(self, passiveData)
        if (count1 >= num1) then
            return true
        end
    end
    return false
end

-- 特性技能能升到几级 (只检查碎片)
function this:PassiveCanUpTo()
    local passiveDatas = self:GetSkills(SkillMainType.CardTalent)
    local passiveData = passiveDatas[1]
    local cfg = Cfgs.skill:GetByID(passiveData.id)
    local lv1, lv2 = cfg.lv, cfg.lv
    if (self:CheckPassiveUpOnlyChip()) then
        local count = BagMgr:GetCount(self:GetCfg().coreItemId)
        local num = RoleTool.GetTalentUpgrateCostNum(self, {
            id = cfg.id
        })
        while count >= num and cfg.next_id ~= nil do
            cfg = Cfgs.skill:GetByID(cfg.next_id)
            num = RoleTool.GetTalentUpgrateCostNum(self, {
                id = cfg.id
            })
            if (count >= num) then
                lv2 = cfg.lv
                count = count - num
            end
        end
    end
    return lv1, lv2
end

--主天赋id
function this:GetPassiveID()
    local passiveDatas = self:GetSkills(SkillMainType.CardTalent)
    if (passiveDatas and #passiveDatas > 0) then
        return passiveDatas[1].id
    end
    return nil 
end

-- 天赋能否升级
function this:CheckTalnetUp(talentId)
    local isOpen = MenuMgr:CheckModelOpen(OpenViewType.special, "special20")
    if (not isOpen) then
        return false
    end
    local cfg = Cfgs.CfgSubTalentSkill:GetByID(talentId)
    if (cfg.next_id == nil) then
        return false
    end
    local expCfg = Cfgs.CfgSubTalentMaterial:GetByID(cfg.costId)
    local materialCfg = expCfg.costs
    local mats = expCfg and expCfg.costs or {}
    for i, v in ipairs(mats) do
        local bagCount = BagMgr:GetCount(v[1])
        if (bagCount < v[2]) then
            return false
        end
    end
    return true
end

-- 是否是助战卡牌
function this:SupportSortNum()
    local teamData = TeamMgr:GetTeamData(eTeamType.Assistance)
    for k, v in pairs(teamData.data) do
        if (v.cid == self:GetID()) then
            return 1
        end
    end
    return 0
end

-- 额外（机神，同调，形切） 是否与皮肤
function this:CheckHadSkins()
    if (self.cfg.breakModels ~= nil or self.cfg.skin ~= nil) then
        return true
    end
    return false
end

function this:GetCardCfg()
    return self.cfg
end

-----------------------------------新增种族、类型、体型
-- 种族
function this:GetRace()
    return self.cfg and self.cfg.tRace or nil;
end

-- 作战类型
function this:GetStyleType()
    return self.cfg and self.cfg.tType or nil;
end

-- 体型
function this:GetBodyType()
    return self.cfg and self.cfg.tBody or nil;
end

-----------------------------------光环改动新增
-- 返回光环配置表
function this:GetHaloCfg()
    if self.data and self.data.haloInfo then
        local haloCfg = Cfgs.cfgHalo:GetByID(self.data.haloInfo.cfgid);
        return haloCfg
    elseif self.cfg and self.cfg.halo then
        local haloCfg = Cfgs.cfgHalo:GetByID(self.cfg.halo[1]);
        return haloCfg
    end
    return nil
end

function this:InitHaloInfo()
    self.haloInfos = nil;
    if self.data and self.data.haloInfo and next(self.data.haloInfo) then
        local info = HaloData.New();
        info:SetData(self.data.haloInfo);
        self.haloInfos = info;
    elseif self.cfg and self.cfg.halo then
        -- 封装默认的
        local info = HaloData.New();
        info:SetData({
            cfgid = self.cfg.halo[1],
            cid = self:GetID(),
            level = 1,
            exp = 0,
            equips = {}
        });
        self.haloInfos = info;
    end
end

-- 返回光环信息
function this:GetHaloInfo()
    if self.haloInfos == nil then
        self:InitHaloInfo();
    end
    return self.haloInfos;
end

function this:GetCurCoordPos()
    local curHalo = self:GetHaloInfo();
    return curHalo and curHalo:GetCurCoordPos() or nil;
end

function this:GetCurCoordIcon()
    local curHalo = self:GetHaloInfo();
    return curHalo and curHalo:GetCurCoordIcon() or nil;
end

-- 更新等级
function this:SetWeaponLv(lv)
    if (self:GetData().mix_data) then
        self:GetData().mix_data.weaponLv = lv
    end
end

-- 设置假的专武等级
function this:SetFakeWeaponLv(lv)
    if (not self:GetData().mix_data) then
        self:GetData().mix_data = {}
    end
    self:GetData().mix_data.weaponLv = lv
end

-- 阵容假的推荐id
function this:SetFakePoolTeamID(id)
    self._poolTeamID = id
end
function this:GetFakePoolTeamID()
    return self._poolTeamID
end

-- 专武等级
function this:GetWeaponLv()
    if (self:GetData().mix_data) then
        return self:GetData().mix_data.weaponLv or 0
    end
    return 0
end

-- 是否有专武,是否已解锁
function this:HaveWeapon()
    local isUnLock = false
    if (self.isHaveWeapon == nil) then
        local cfg = Cfgs.CfgCardWeapon:GetByID(self:GetCfgID())
        if (cfg and cfg.is_open) then
            self.isHaveWeapon = true
            isUnLock = self:GetLv() >= cfg.open_card_lv
        else
            self.isHaveWeapon = false
        end
    elseif (self.isHaveWeapon) then
        local cfg = Cfgs.CfgCardWeapon:GetByID(self:GetCfgID())
        isUnLock = self:GetLv() >= cfg.open_card_lv
    end
    return self.isHaveWeapon, isUnLock
end

-- 被修改的技能，附加的技能
function this:GetWeaponSkill()
    local isHaveWeapon, isUnLock = self:HaveWeapon()
    if (isHaveWeapon and isUnLock) then
        local weaponLv = self:GetWeaponLv()
        local cfg = Cfgs.CfgCardWeapon:GetByID(self:GetCfgID())
        local childCfg = cfg.infos[weaponLv + 1]
        local add = childCfg.skills and childCfg.skills[1] or nil
        return childCfg.skill_group, add
    end
    return nil, nil
end

--有专武：1  无：0
function this:GetZWSortNum()
    if(not self._zwSortNum)then 
        local isHaveWeapon = self:HaveWeapon()
        if(isHaveWeapon)then 
            self._zwSortNum = 1
        else 
            self._zwSortNum = 0
        end 
    end 
    return self._zwSortNum
end

-- 光环有多个等级：2  无：0
function this:GetHaloSortNum()
    if(not self._sortHaloNum)then 
        local info = self:GetHaloInfo()
        if(info and #info:GetCfg().infos>1)then 
            self._sortHaloNum = 2
        else 
            self._sortHaloNum = 0
        end 
    end 
    return self._sortHaloNum
end

return this;
