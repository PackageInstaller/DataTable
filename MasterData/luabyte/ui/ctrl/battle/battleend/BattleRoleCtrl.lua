local M = BaseClass('BattleRoleCtrl')
local tInsert = table.insert

-- isMop: false/nil 为非扫荡模式
function M:Refresh(type, mission, isMop)
    local role = {}
    if isMop then --扫荡
        local team = IHeroDataMgr:GetActiveTeamHeros()
        for i = 0, team.Length - 1 do tInsert(role, team[i]) end
    else --常规战斗
        local heroDatas = IBattle.context.battleData:GetDeployHero()
        local len = heroDatas and heroDatas.Length or 0
        for i = 0, len - 1, 1 do tInsert(role, heroDatas[i]) end
    end

    local length = #role
    if (length <= 0) then return end

    local random = math.random(1, length)
    local selectHeroData = role[random]
    local heroId = selectHeroData:GetHeroId()
    local heroSkinId = selectHeroData:GetSkinId()

    if IsNull(selectHeroData) then return end --容错处理 不知道为啥可能会获取不到英雄

    if selectHeroData:GetFashion() > 0 then--有皮肤
        self.view.uiState:SetState(1)
        self.view.image:SetImageWhole(selectHeroData:GetSkinId(), RoleType.ERT_Hero,4)
    else
        if selectHeroData:IsAwake() then
            self.view.uiState:SetState(2)
            self.view.awake:SetImageWhole(heroId, RoleType.ERT_Hero, 3)
        else   
            self.view.uiState:SetState(1)
            self.view.image:SetImageWhole(heroId, RoleType.ERT_Hero,1)
        end
    end
    local person = ConfigHelper.GetCfg("heroPersona", heroSkinId)
    local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    local breaklevel = 0

    if (heroData ~= nil and heroData:IsHave() and heroData:GetRoleStudioHeroData() ~= nil) then
        breaklevel = heroData:GetBreakLevel()
    end

    local index = 0
    for i, v in ipairs(person and person.victoryVoiceLimit or {}) do
        if breaklevel >= v then index = i end
    end

    if index == 0 then return end --没有对应语音和文本的话直接跳

    random = math.random(1, index)
    if (not person or #person.victoryWords < random) then
        heroId = length > 0 and role[random]:GetHeroId() or 0
        local errorStr = "胜利语音配置有问题：英雄id：%d, 随机语音：%d, 语音文本有：%d条, 音频有：%d条"
        local error = string.format(errorStr, heroId, random, #person.victoryWords, #person.victoryVoice)
        Logger.LogError(error)
    else
        self.view.text:SetText(person.victoryWords[random])
        GameHelper.PlayAudioById(person.victoryVoice[random])
    end
end

function M:OnDispose()
    if self.view then
        self.view:OnDispose()
        self.view = nil
    end
end

return M
