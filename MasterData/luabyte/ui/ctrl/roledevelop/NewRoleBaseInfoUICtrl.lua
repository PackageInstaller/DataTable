-- 角色养成主界面中的属性面板
local NewRoleBaseInfoUICtrl = BaseClass("NewRoleBaseInfoUICtrl", UIBaseComponent)
local M = NewRoleBaseInfoUICtrl
local CRoleAttr = CS.GameBase.CRoleAttr
local EAttributeType = EnumConst.EAttributeType
local ATTRIBUTENUM = 8
local tInsert = table.insert
local sfmt = string.format

-- 构造函数 相当于mono的 awake , 一般的变量可在此处声明
function M:__init()
    -- 声明变量
    self._nextBreak = nil -- 下一个突破的配置
    self._curCore = nil -- 当前核心配置
    self._heroLevel = 0
    self.m_heroId = 0
    self.m_idList = nil
    self.m_index = 0
    self._view.btnLv:onClick(Bind(self, self._ClickLvUp))
    self._view.infoBtn:onClick(Bind(self, self.OnClickInfo))
    self.tabSpecialty = {self._view.UIHeroSpecialtyCtrl}
    self.system187 = ConfigHelper.GetSystemParams(187) -- 达到最高突破等级后等级上限增加值
end

function M:SetInfo(heroData, upgradeFun)
    self._heroData = heroData
    self._upgradeFun = upgradeFun
    self._allBreaks = CS.GameBase.JHeroBreak.GetBreaks(self._heroData:GetHeroId())
    self:UpdateState()
    self:_SetBaseInfo()
    self._view.infoBtn:SetActive(false)
end

-- 更新状态
function M:UpdateState()
    self._nextBreak = CS.GameBase.JHeroBreak.GetBreak(self._heroData:GetHeroId(), self._heroData:GetBreakLevel() + 1)
    self._heroLevel = self._heroData:GetLevel()
    local curCores = ConfigHelper.GetCfgsByLua("heroCore", {heroId=self._heroData:GetHeroId(), coreLevel=self._heroData:GetCoreLevel()})

    if curCores.Length == 0 then
        self._curCore = nil
    else
        self._curCore = curCores[0]
    end

    local stars = self._heroData:GetGenesStars()
    local geneStars = {}
    self.curGeneStars = {}
    local geneIdx = 0

    if stars ~= nil then
        for i = 0, stars.Length - 1 do
            if stars[i] > 0 then
                geneIdx = geneIdx + 1
                local heroAi = ConfigHelper.GetCfgsByLua("heroAi", {heroId=self._heroData:GetHeroId(), slot=i + 1})

                geneStars = ConfigHelper.GetCfgsByLua("heroAiStar", {aiType=heroAi[1].aiType})

                for index, value in ipairs(geneStars) do
                    if value.star == stars[i] then
                        tInsert(self.curGeneStars, value)
                    end
                end
            end
        end
    end

    local limit = self:_CountLimitLv(self._nextBreak)
    self._view.limitLv:SetText("/" .. tostring(limit))
    -- 能升级或突破
    if self:CanAddLv() then
        self._view.btnLv:SetActive(true)
        self._view.tfLvUp:SetActive(true)
    else
        self._view.btnLv:SetActive(false)
        self._view.tfLvUp:SetActive(false)
    end
    self:_SetAttribute()
end

-- 计算突破需要的等级
function M:_CountLimitLv(nextBreak)
    if nextBreak == nil then
        local addLv = ConfigHelper.GetSystemParams(187)
        return self._heroData:GetHeroBreak().needLevel + addLv[self._heroData:GetHeroCfg().rare - 1]
    end
    return nextBreak.needLevel
end

-- 能否显示加号(突破或者升级)
function M:CanAddLv()
    if self._nextBreak then
        return true
    end
    self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self._heroData:GetHeroId())
    local addLv = self.system187[self._heroData:GetHeroCfg().rare - 1]
    local favorUpLv = self.rshd.upLevel
    self._curBreak = CS.GameBase.JHeroBreak.GetBreak(self._heroData:GetHeroId(), self._heroData:GetBreakLevel())
    return self._heroLevel < self._curBreak.needLevel + addLv + favorUpLv
end

-- 基础信息
function M:_SetBaseInfo()
    local specialty = self._heroData:GetHeroCfg().specialty
    for i = 0, specialty.Length - 1 do
        local UIHeroSpecialtyCtrl = self.tabSpecialty[i + 1]
        local data = {}
        data.specialty = specialty[i]
        data.icon = "UI/SpritePics/develop/ui_develop_type_" .. (sfmt("%02d", specialty[i] - 120000))

        if not UIHeroSpecialtyCtrl then
            UIHeroSpecialtyCtrl = self._view.UIHeroSpecialtyCtrl:Instantiate()
            tInsert(self.tabSpecialty, UIHeroSpecialtyCtrl)
        end
        UIHeroSpecialtyCtrl:UpdateData(data)
        UIHeroSpecialtyCtrl:SetActive(true)
    end
    for i = specialty.Length + 1, #self.tabSpecialty do
        self.tabSpecialty[i]:SetActive(false)
    end
end

-- 升级 突破 觉醒
function M:_ClickLvUp(go)
    if self._upgradeFun then
        self._upgradeFun()
    end
end

-- 点击详情
function M:OnClickInfo(go)
    UIContextMgr:GetInstance():Show("RolePreviewPop", self._heroData)
end

-- 刷新属性
function M:_SetAttribute()
    local heroCfg = self._heroData:GetHeroCfg()
    local roleCfg = self._heroData:GetRoleCfg()
    local breakLv = self._heroData:GetBreakLevel()
    self._view.chName:SetText(heroCfg.name)
    self._view.curLv:SetText(tostring(self._heroLevel))
    self._view.proImg:SetPic("UI/SpritePics/profession/ui_icon_profession_0" .. roleCfg.profession)
    self._view.rareImg:SetPic("UI/SpritePics/develop/ui_develop_icon_" .. heroCfg.rare)
    if not IsNull(self._view.upRedPoint) then
        self._view.upRedPoint:SetParam(0, self._heroData:GetHeroId())
        self._view.upRedPoint:Check()
    end

    local dataId = {EAttributeType.EAT_MaxHP, -- 生命
    EAttributeType.EAT_Damage, -- 攻击
    EAttributeType.EAT_DamageDef, -- 物理防御
    EAttributeType.EAT_MagicDef, -- 魔法防御
    -- EAttributeType.EAT_Idle, --攻击间隔
    EAttributeType.EAT_MaxArmor, -- 护盾
    EAttributeType.EAT_Block, -- 阻挡
    EAttributeType.EAT_Summon -- 部署物资
    }
    -- local datas = {}

    for i = 1, ATTRIBUTENUM - 1 do
        local data = {}
        -- tInsert(datas, data)
        data.num = self._heroData:GetDevelopAttribute(dataId[i], self._heroLevel, breakLv)
        local attribute = ConfigHelper.GetCfgByLua("attribute", dataId[i])
        data.icon = attribute.icon
        data.desc = attribute.name
        self._view["Attr" .. i]:UpdateData(data)
    end

    -- 攻击速度
    do
        local data = {}
        data.num = self:GetAttackSpeed(heroCfg)
        data.icon = "UI/SpritePics/develop/ui_develop_icon_interval"
        data.desc = 100006
        self._view.Attr8:UpdateData(data)
    end
end

-- 获取攻击速度
function M:GetAttackSpeed(heroCfg)
    local cur = CRoleAttr(heroCfg, self._heroLevel)
    -- 设置攻速
    local sys15 = ConfigHelper.GetSystemParams(15)
    local sys17 = ConfigHelper.GetSystemParams(17)
    local atkspeed = cur[EAttributeType.EAT_Idle]

    if atkspeed <= sys15[0] then
        return ConfigHelper.GetLocalString(sys17[0])
    elseif atkspeed <= sys15[1] then
        return ConfigHelper.GetLocalString(sys17[1])
    elseif atkspeed <= sys15[2] then
        return ConfigHelper.GetLocalString(sys17[2])
    elseif atkspeed <= sys15[3] then
        return ConfigHelper.GetLocalString(sys17[3])
    else
        return ConfigHelper.GetLocalString(sys17[4])
    end
end

function M:OnDestroy()
    for _, value in ipairs(self.tabSpecialty) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end

    M.super.OnDestroy(self)
end

return NewRoleBaseInfoUICtrl
