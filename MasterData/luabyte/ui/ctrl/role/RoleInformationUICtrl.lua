local M = BaseClass("RoleInformationUICtrl", BaseUICtrl)
local skillTypes = { [0] = 909, [1] = 910, [2] = 911, [3] = 912 }
local JBattleLevel = CS.GameBase.JBattleLevel
local tInsert = table.insert

function M:Init()
    self.m_intType = 0
    self.m_itemlist = {}
    self.m_heroData = nil
    self._view.closeBtn:onClick(Bind(self, self.Close))
end

function M:OnEnter(list, idx, _type, isHeroAtlas)
    self.m_intType = _type
    self.m_isHeroAtlas = isHeroAtlas
    self.m_heroData = self:_GetHeroData(list[idx])
    self._view.baseInfo:SetHeroList(list, list[idx])
    self._view.baseInfo:SetInfo(self.m_heroData, nil, self.m_intType)
    self:_InitRightPanel()
end

function M:OnDispose()
    for _, view in ipairs(self.m_itemlist) do
        view:OnDispose()
    end
    self.m_rsHeroAdvanced = nil
    self.m_rsHeroLevelup = nil
    self.m_isHeroAtlas = nil
    self.m_heroData = nil
    self.m_itemlist = nil
    self.m_intType = nil
    M.super.OnDispose(self)
end

function M:_GetHeroData(heroId)
    local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    if not heroData then
        heroData = IHeroDataMgr:GetHeroDataById(heroId)
    end
    return heroData
end

function M:_InitRightPanel()
    self._view.skillContent:ClearChildren(3)
    local heroId = self.m_heroData:GetHeroId()
    if self.m_intType == 2 then
        self:_InitMaxNormalSkill()
        self:_InitMaxBattleSkill()
        -- 是否是图鉴进来的
        if self.m_isHeroAtlas and not self.m_heroData:IsAwake() then
            self._view.node_normal:SetActive(true)
            self._view.node_awake:SetActive(false)
            if IHeroDataMgr:HasHero(heroId) then
                self._view.img_normal:SetHeroDrawing(heroId, 1)
                self._view.img_normalBg:SetHeroDrawing(heroId, 1)
            else
                self._view.img_normal:SetHeroDrawing(heroId, 1)
                self._view.img_normalBg:SetHeroDrawing(heroId, 1)
            end
        else
            self._view.node_normal:SetActive(false)
            self._view.node_awake:SetActive(true)
            self._view.img_awake:SetHeroDrawing(heroId, 3)
            self._view.img_awakeBg:SetHeroDrawing(heroId, 3)
        end
    else
        self:_InitNormalSkill()
        self:_InitBattleSkill()
        local awaken = self.m_heroData:GetHeroBreak().awaken
        self._view.node_normal:SetActive(awaken == 0)
        self._view.node_awake:SetActive(awaken >= 1)
        self._view.img_normal:SetHeroDrawing(self.m_heroData:GetHeroId(), 1)
        self._view.img_awake:SetHeroDrawing(self.m_heroData:GetHeroId(), 3)
        self._view.img_normalBg:SetHeroDrawing(self.m_heroData:GetHeroId(), 1)
        self._view.img_awakeBg:SetHeroDrawing(self.m_heroData:GetHeroId(), 3)
    end

    if self._view.baseInfo:IsUpLvActive() then
        self._view.txt_costTitle:SetText(82)
    elseif self._view.baseInfo:IsBreakActive() then
        self._view.txt_costTitle:SetText(664)
    elseif self._view.baseInfo:IsAwakeActive() then
        self._view.txt_costTitle:SetText(665)
    end
end

-- 基础技能
function M:_InitNormalSkill()
    local heroBreak = self.m_heroData:GetHeroBreak()
    self:_SetNormalItem(heroBreak)
end

-- 战斗技能
function M:_InitBattleSkill()
    local skillLevel = self.m_heroData:GetSkillLevel()
    local battleleveldata = JBattleLevel.GetHeroBattleByLv(self.m_heroData:GetSkinId(), skillLevel)
    local dataList = {}

    for i = 0, battleleveldata.Count - 1, 1 do
        tInsert(dataList, battleleveldata[i])
    end

    self:SetBattleItem(dataList)
end

function M:_InitMaxNormalSkill()
    local heroBreak = CS.GameBase.JHeroBreak.GetMaxBreakLevel(self.m_heroData:GetHeroId())
    self:_SetNormalItem(heroBreak)
end

function M:_InitMaxBattleSkill()
    local battleleveldata = JBattleLevel.GetHeroBattleByLv(self.m_heroData:GetSkinId())
    local maxDataList, maxSkillLv = {}, 0

    for i = 0, battleleveldata.Count - 1, 1 do
        local battlelevel = battleleveldata[i]
        -- 拿到最大技能组
        if battlelevel.skillLevel > maxSkillLv then
            maxSkillLv = battlelevel.skillLevel
            maxDataList = {}
            tInsert(maxDataList, battlelevel)
        elseif battlelevel.skillLevel == maxSkillLv then
            tInsert(maxDataList, battlelevel)
        end
    end

    self:SetBattleItem(maxDataList)
end

function M:_SetNormalItem(heroBreak)
    local role = self.m_heroData:GetRoleCfg()
    local hero = self.m_heroData:GetHeroCfg()
    local skillCfg = ConfigHelper.GetCfgByLua("skill", role.attack)
    local titleView = self:_SetSkillTitle(493, 5314)
    local nodeEndLine

    -- 普通技能
    if skillCfg then
        titleView:SetActive(true)
        local skillView = self:_SetSkillItem(91, false, false, skillCfg.skillname, skillCfg.skilldescribe)
        skillView.img_skillIcon:SetSkillIcon(skillCfg.id)
        nodeEndLine = skillView.node_line
    end

    if nodeEndLine then
        nodeEndLine:SetActive(true)
    end
end

function M:SetBattleItem(dataDic)
    local titleView = self:_SetSkillTitle(491, 5313)
    local nodeEndLine

    for _, cfg in ipairs(dataDic) do
        if cfg.grade > 1 then
            titleView:SetActive(true)
            local isCost, isAdv = cfg.skillCost ~= 0, cfg.skillUpType == 1
            local skillView = self:_SetSkillItem(skillTypes[cfg.skillType], isCost, isAdv, cfg.skillName, cfg.skillDesc)
            skillView.img_skillIcon:SetBattleLevelIcon(cfg.id)
            skillView.txt_costNum:SetText(tostring(cfg.skillCost))
            nodeEndLine = skillView.node_line
        end
    end

    if nodeEndLine then
        nodeEndLine:SetActive(true)
    end
end

-- 点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:_SetSkillTitle(chTxt, enTxt)
    local titleView = self._view.skillTitle:Instantiate()
    titleView:SetActive(false)
    titleView.chTitle:SetText(chTxt)
    titleView.enTitle:SetText(enTxt)
    tInsert(self.m_itemlist, titleView)
    return titleView
end

function M:_SetSkillItem(typeId, isCost, isAdv, name, desc)
    local skillView = self._view.skillItem:Instantiate()
    skillView:SetActive(true)
    local emojiTxt = skillView.txt_skillDesc
    emojiTxt:SetText(desc)
    skillView.node_cost:SetActive(isCost)
    skillView.txt_skillName:SetText(name)
    skillView.img_advence:SetActive(isAdv) -- 前两个固定不显示
    skillView.txt_skillType:SetText(typeId)
    emojiTxt:SetOnClick(Bind(self, self.OnClickHrefWord, emojiTxt))
    tInsert(self.m_itemlist, skillView)
    return skillView
end

-- 超链接文本点击
function M:OnClickHrefWord(emojiTxt, hrefName, centerX, centerY)
    local alignDir = Vector2.New(-0.5, 0) -- 以点击文字的锚点，左侧居中
    local tipsPivot = Vector2.New(1, 0.5) -- tips以右侧居中点对齐alignDir
    local worldPos = Vector3.New(centerX, centerY, 0)
    emojiTxt:ShowHrefWordTips(hrefName, worldPos, alignDir, tipsPivot)
end

return M
