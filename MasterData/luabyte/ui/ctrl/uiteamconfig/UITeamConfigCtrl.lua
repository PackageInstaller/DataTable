-- baoruichang
-- 2022/3/8 15:06:30
-- 预制体 uTeamConfigUI
local UITeamConfigCtrl = BaseClass("UITeamConfigCtrl", BaseUICtrl)
local M = UITeamConfigCtrl
local tInsert = table.insert
local tIndexof = table.indexof
local tRemovebyvalue = table.removebyvalue
local tSort = table.sort
local TeamConfigStyle = EnumConst.TeamConfigStyle
local EChapterType = ChapterConst.EChapterType
local UIHeadCtrl = require("UI.Ctrl.UITeamConfig.UIHeadCtrl")
local UIHeadView = require("UI.View.UITeamConfig.UIHeadView")
local UIFriHeadCtrl = require("UI.Ctrl.UITeamConfig.UIFriHeadCtrl")
local UIFriHeadView = require("UI.View.UITeamConfig.UIFriHeadView")
local TIPSMISSID = "TIPSMISSID"
local sfmt = string.format
local HERONUM = 9
local SKILLNUM = 2
local TEAMNUM = 4

function M:Init()
    self._view.btnClear:SetOnClick(Bind(self, self._OnBtnClearClick))
    self._view.btnStart:onClick(Bind(self, self._OnBtnStartClick))
    self._view.btnLeft:SetOnClick(Bind(self, self._OnBtnLeftClick))
    self._view.btnRight:SetOnClick(Bind(self, self._OnBtnRightClick))
    self._view.btnDevelop:SetOnClick(Bind(self, self._OnBtnDevelopClick))
    self._view.btnAssist:onClick(Bind(self, self._OnBtnAssistClick))
    self._view.btnFriRef:SetOnClick(Bind(self, self._OnFriRefClick))
    self._view.TabList:Init(0, Bind(self, self._OnClickTab))
    self._OnClickCancleHeroTemp = EventMgr:AddListener(UIMessageNames.TEAMHEROITEMCLICK, Bind(self, self._OnClickCancleHero))
    self._TempOnClickCancleFirHero = EventMgr:AddListener(UIMessageNames.TEAMHEROITEMFRICLICK, Bind(self, self._OnClickFirHero))
    self._UpdateTeamTemp = EventMgr:AddListener(UIMessageNames.UPDATETEAM, Bind(self, self._UpdateTeam))
    self._TempOnClickSkill = EventMgr:AddListener(UIMessageNames.CLICKSKILL, Bind(self, self._OnClickSkill))
    self._TempOnClickHero = EventMgr:AddListener(UIMessageNames.TEAM_CLICKHERO, Bind(self, self._OnClickHero))
    self._TempOnClickFriendHero = EventMgr:AddListener(UIMessageNames.TEAM_CLICKFRIENDHERO, Bind(self, self._OnClickFriendHero))
    self._TempOnClickNotFri = EventMgr:AddListener(UIMessageNames.TEAMCLICKNOTICEFRI, Bind(self, self._OnClickNoticeFri))

    self.gridHeros1 = self._view.HeroList
    self.gridHeros1:Init(UIHeadCtrl, UIHeadView)
    self.gridHeros2 = self._view.HeroList2
    self.gridHeros2:Init(UIFriHeadCtrl, UIFriHeadView)
    self:_InitPlayerPrefs()
end

-- 进入UI，可传参数
function M:OnEnter(isTeach, battleMissionId, teamConfigStyle)
    -- 教学
    self._isTeach = isTeach
    self._battleMissionId = battleMissionId
    self._teamConfigStyle = teamConfigStyle
    self._selectTeamIndex = GlobalTeamConfMgr:GetInstance().Mgr:GetDefaultTeamId()
    -- 当前选中编队
    self.index = 1
    self.isAssist = false
    self._view.stateAssist:SetState(self.isAssist and 2 or 1)
    self:_InitSelectHero()
    self:_InitUI()
    self:_UpdateTeam()
    self:_UpdateTipsState()
    self.timer = TimerManager:GetInstance():GetTimer(0.2, self._InitMissionUI, self, true)
    self.timer:Start()
end

-- 当跳转到其他界面，比如养成，回来之后，会调用此接口，需要刷新一下界面，因为有可能会养成刷新
function M:OnVisible()
    self:_UpdateTeam()
end

function M:_InitPlayerPrefs()
    local tempMissId = PlayerPrefTools.GetPlayerPrefsString(TIPSMISSID, "{}")
    self.tipsMissIds = Json.decode(tempMissId)
end

function M:_InitMissionUI()
    self.timer:Stop()
    self.timer = nil
    if self._teamConfigStyle ~= TeamConfigStyle.Battle then
        return
    end

    if self.mission.teamPicture.Length <= 0 then
        return
    end
    if tIndexof(self.tipsMissIds, self._battleMissionId) then
        return
    else
        UIContextMgr:GetInstance():Show(UIDefine.UIMissionTips, self.mission.teamPicture)
        tInsert(self.tipsMissIds, self._battleMissionId)
        local tempMissId = Json.encode(self.tipsMissIds)
        PlayerPrefTools.SetPlayerPrefs(TIPSMISSID, tempMissId)
    end
end

function M:_OnClickTab(idx)
    self.showHeros = {}
    -- 教学关卡
    if self._isTeach then
        idx = 0
        local adBreak = self.mission.adBreak
        for i = 0, self.mission.adHero.Length - 1 do
            local heroId = self.mission.adHero[i]
            local lv = self.mission.adLevel[i]
            local isSelect = true
            local rare = ConfigHelper.GetCfgPropByLua("hero", heroId, "rare")
            local data = {heroId=heroId, lv=lv, rare=rare, state=isSelect, isTeach=self._isTeach -- 是否是教学管卡
            }
            data.grade = adBreak[i]
            data.canAdd = false
            self.showHeros[#self.showHeros + 1] = data
        end

        self.gridHeros1:SetDataList(self.showHeros)
        return
    end

    self.index = idx + 1
    -- 显示到左侧的英雄(非好友助战)
    if not self.isAssist then
        local data = IHeroDataMgr:GetHerosByProfessinal(idx)
        local backlist = GlobalTeamConfMgr:GetInstance().Mgr:GetBlackList() or {}
        for i = 0, data.Count - 1 do
            local heroData = data[i]
            local heroId = heroData:GetHeroId()
            local isSelect = tIndexof(self.selectGridHeroId, heroId)
            local isSame = self._teamConfigStyle == TeamConfigStyle.Battle and GlobalTeamConfMgr:GetInstance().Mgr:IsSameSelf(self._selectTeamIndex, heroId)
            local tempData = {heroId=heroId, lv=heroData:GetLevel(), rare=heroData:GetHeroCfg().rare, state=isSelect, isSame=isSame, isInBacklist=table.indexof(backlist, heroId) -- 是否是黑名单，不允许选中
            }
            tempData.grade = heroData:GetBreakLevel()
            tInsert(self.showHeros, tempData)
        end

        local tempNoSelectShowHeros = {}
        local tempSelectShowHeros = {}
        local showHeroNum = GlobalTeamConfMgr:GetInstance().Mgr:GetShowHeros()
        for _, v in pairs(self.showHeros) do
            if tIndexof(self.selectId, v.heroId) then
                v.canAdd = #self.selectHeroIds < showHeroNum
                tInsert(tempSelectShowHeros, v)
            else
                tInsert(tempNoSelectShowHeros, v)
            end
        end

        tSort(tempNoSelectShowHeros, self._Sort)
        tSort(tempSelectShowHeros, self._Sort)

        for _, v in pairs(tempNoSelectShowHeros) do
            v.canAdd = #self.selectHeroIds < showHeroNum
            tInsert(tempSelectShowHeros, v)
        end

        self.gridHeros1:SetDataList(tempSelectShowHeros)
        return
    end

    local friData = self:GetFriendData(self.index)
    self:UpdateHeroList(friData)
end

-- 好友助战
function M:UpdateHeroList(data)
    self.showHeroFirends = {}

    for i = 1, #data do
        local heroData = data[i]
        local heroId = heroData.HeroId
        local isSelect = self:IsFriendsById(heroData.FriendId, heroId)
        local isSame = GlobalTeamConfMgr:GetInstance().Mgr:IsSameFri(self._selectTeamIndex, heroId)
        local rare = ConfigHelper.GetCfgPropByLua("hero", heroId, "rare")
        local tempData = {heroId=heroId, lv=heroData.Level, rare=rare, friendId=heroData.FriendId, nickName=heroData.Nickname, isFriends=heroData.IsFriends, state=isSelect, isSame=isSame, skin=heroData.Skin, awake=heroData.Awake, grade=heroData.Grade}
        self.showHeroFirends[#self.showHeroFirends + 1] = tempData
    end

    self.gridHeros2:SetDataList(self.showHeroFirends)
end

-- 是否是已经选中的助战英雄
function M:IsFriendsById(friendId, heroId)
    local FriendHero = GlobalTeamConfMgr:GetInstance().Mgr:GetFriendHeroData(self._selectTeamIndex)

    if FriendHero == nil or not FriendHero.FriendId then
        return
    end
    return FriendHero.FriendId == friendId and FriendHero.HeroData:GetHeroId() == heroId
end

function M._Sort(heroData1, heroData2)
    if heroData1.lv ~= heroData2.lv then
        return heroData1.lv > heroData2.lv
    end

    if heroData1.rare ~= heroData2.rare then
        return heroData1.rare > heroData2.rare
    end
    return heroData1.heroId > heroData2.heroId
end

-- 刷新编队
function M:_UpdateTeam()
    self:_InitHeros()
    self:_UpdataHeros()
    self:_UpdateSkills()
    self:_OnClickTab(self.index - 1)
end

-- 初始化UI
function M:_InitUI()
    local isShowFriend = GlobalTeamConfMgr:GetInstance().Mgr:IsShowFriendHero()
    local isBattle = self._teamConfigStyle == TeamConfigStyle.Battle
    self._view.btnStart.gameObject:SetActive(isBattle)
    self._view.btnAssist:SetActive(isBattle)
    self._view.friendHeroCtrl._view:SetActive(isShowFriend and isBattle and (not self._isTeach))
    -- 指挥官技能
    local showCondition = ConfigHelper.GetCfgPropByLua("functionOpen", 24, "showCondition")
    local skillState = GameHelper.CheckLockByOpenConditionIds(showCondition)
    self._view.tfRightPanel.gameObject:SetActive(isBattle and skillState)
    -- 教学关卡隐藏按钮
    self._view.tfNormalTeam.gameObject:SetActive(not self._isTeach and GlobalTeamConfMgr:GetInstance().Mgr:IsShowTeamName())
    -- 前三关不显示养成按钮
    local conditionId = ConfigHelper.GetSystemParam(267)
    local developState = GameHelper.CheckLockByOpenConditionId(conditionId)
    self._view.btnDevelop.gameObject:SetActive(not self._isTeach and developState)
    self._view.btnClear.gameObject:SetActive(not self._isTeach)
    self._view.tfTeamConfigTips.gameObject:SetActive(self._isTeach)
    self._view.tfMaskTeach.gameObject:SetActive(self._isTeach)
    self._view.tfDotGroup.gameObject:SetActive(not self._isTeach)
    if self._battleMissionId then
        self.mission = ConfigHelper.GetCfgByLua("mission", self._battleMissionId)
    end
    self:_InitTeamState(true)
    self:_InitHelperNum()
    local firOpenCondition = ConfigHelper.GetCfg("functionOpen", 29)

    for _, conditionId in pairs(firOpenCondition.openCondition) do
        local open = GameHelper.CheckLockByOpenConditionId(conditionId)
        if not open then
            self.firLockTips = ConfigHelper.GetCfgPropByLua("openCondition", conditionId, "tips")
            break
        end
    end
    self._view.tfLockFir:SetActive(self.firLockTips and true or false)

    if not self._battleMissionId or self._battleMissionId<=0 then
        return
    end

    local missionData = MissionDataMgr:GetInstance():GetMissionDataById(self._battleMissionId)
    local missionType = missionData:ChapterType()
    if UIContextMgr:GetInstance():IsShow(UIDefine.MissionOfferRewards) or missionType == EChapterType.ECT_Elite or missionType == EChapterType.ECT_Encounter then 
        self._view.tfHelperTips:SetActive(false)
    else
        self._view.tfHelperTips:SetActive(true)
    end
end

--- 提示状态
function M:_UpdateTipsState()
    -- 悬赏模式不显示
    if self._isTeach or self._teamConfigStyle ~= TeamConfigStyle.Battle or UIContextMgr:GetInstance():IsShow(UIDefine.MissionOfferRewards) then
        self._view.tfTipsGene:SetActive(false)
        self._view.tfTipsSkill:SetActive(false)
        self._view.tfTipsLevel:SetActive(false)
        return
    end

    local allGene = 0
    local allSkill = 0
    local allLevel = 0

    for _, heroId in pairs(self.selectHeroIds) do
        local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
        allGene = allGene + heroData:GetGeneStar()
        allSkill = allSkill + heroData:GetSkillLevel()
        allLevel = allLevel + heroData:GetLevel()
    end

    local FriendHero = GlobalTeamConfMgr:GetInstance().Mgr:GetFriendHeroData(self._selectTeamIndex)

    local heroNums = #self.selectHeroIds

    if FriendHero and FriendHero.FriendId then
        allGene = allGene + FriendHero.HeroData:GetGeneStar()
        allSkill = allSkill + FriendHero.HeroData:GetSkillLevel()
        allLevel = allLevel + FriendHero.HeroData:GetLevel()
        heroNums = heroNums + 1
    end

    if heroNums <= 0 then
        self._view.tfTipsGene:SetActive(false)
        self._view.tfTipsSkill:SetActive(false)
        self._view.tfTipsLevel:SetActive(false)
        return
    end

    self._view.tfTipsGene:SetActive(allGene / heroNums < self.mission.showAIStar)
    self._view.tfTipsSkill:SetActive(allSkill / heroNums < self.mission.showSkillLevel)
    self._view.tfTipsLevel:SetActive(allLevel / heroNums < self.mission.showLv)
end

function M:_UpdateSkills()
    if self._teamConfigStyle ~= TeamConfigStyle.Battle then
        return
    end

    -- 设置技能信息
    if self._isTeach then
        -- 教学模式
        -- C#表
        local skillCount = self.mission.adCMSkill and self.mission.adCMSkill.Length or 0

        for i = 1, SKILLNUM do
            local skillData = {}
            skillData.isTeach = self._isTeach

            if i <= skillCount then
                skillData.commanderSkillId = self.mission.adCMSkill[i - 1]
                skillData.heroId = nil
            end

            self._view["skill" .. (i)]:UpdateData(skillData)
        end
    else
        -- 正常模式
        local commanderSkills = GlobalTeamConfMgr:GetInstance().Mgr:GetCommanderSkills(self._selectTeamIndex)
        local CommanderSkill = IPlayerData.CommanderSkill

        for i = 1, SKILLNUM do
            local skillData = {}
            skillData.isTeach = self._isTeach

            if i <= #commanderSkills then
                if commanderSkills[i] and commanderSkills[i] > 0 then
                    local _, cRoleCommander = CommanderSkill:TryGetValue(commanderSkills[i])
                    skillData.commanderSkillId = self:_GetCommanderSkill(cRoleCommander.CmdId, cRoleCommander.Level)
                    skillData.heroId = cRoleCommander
                end
            end

            self._view["skill" .. i]:UpdateData(skillData)
        end
    end
    IRedPointMgr:ForceCheck(RedPointConst.TeamSkillRedPointChecker)
end

function M:_GetCommanderSkill(cmdId, level)
    local commanderSkills = ConfigHelper.GetCfgs("commanderSkill")

    for _, value in ipairs(commanderSkills) do
        if value.cmdID == cmdId and value.level == level then
            return value.id
        end
    end
    return 0
end

function M:_OnClickSkill()
    UIContextMgr:GetInstance():Show("TeamChangeSkills", self._selectTeamIndex)
end

function M:_CloseSkill()
end

-- 左侧选中一个英雄
function M:_OnClickHero(heroId, state)
    if self._isTeach then
        return
    end

    -- 取消选中直接处理
    if not state then
        tRemovebyvalue(self.selectHeroIds, heroId)
        self:_OnBtnEnterClick()
        self:_UpdateTipsState()
        self:_OnClickTab(self.index - 1)
        return
    end

    -- 添加英雄的时候需要判断数量
    local showHeroNum = GlobalTeamConfMgr:GetInstance().Mgr:GetShowHeros()

    if #self.selectHeroIds >= showHeroNum then
        GameHelper.TipsById(5447)
        return
    end
    if self._teamConfigStyle == TeamConfigStyle.Battle then
        if GlobalTeamConfMgr:GetInstance().Mgr:IsSameSelf(self._selectTeamIndex, heroId) then
            GameHelper.TipsById(5446)
            return
        end
    else
        if GlobalTeamConfMgr:GetInstance().Mgr:IsSameSelf(self._selectTeamIndex, heroId) then
            GlobalTeamConfMgr:GetInstance().Mgr:SetFriendHeroData(self._selectTeamIndex)
        end
    end

    tInsert(self.selectHeroIds, heroId)
    self:_OnBtnEnterClick()
    self:_UpdateTipsState()
    self:_OnClickTab(self.index - 1)
end

function M:_OnClickFriendHero(heroId, friendId, state)
    if not GlobalTeamConfMgr:GetInstance().Mgr:CanChangeFriendHelp() then
        return
    end
    if not state then
        -- 取消选中直接处理
        GlobalTeamConfMgr:GetInstance().Mgr:SetFriendHeroData(self._selectTeamIndex)
        self._view.friendHeroCtrl:UpdateItem({isFri=true})
        -- if self.isAssist then
        self:_OnClickTab(self.index - 1)
        -- end
        self:_UpdateTipsState()
        return
    end
    FriendDataMgr:GetInstance():SendRequestHeroData(heroId, friendId, Bind(self, self._LoadFriendData))
end

function M:_OnClickNoticeFri(friendId, isFriends)
    self:GetContext():RequestRecommendFriendInfo(friendId, isFriends)
end

-- 提交服务器处理
function M:_OnBtnEnterClick()
    local CRoleTeam = {}
    CRoleTeam.TeamId = self._selectTeamIndex
    CRoleTeam.HeroLength = #self.selectHeroIds
    CRoleTeam.Heroes = self.selectHeroIds
    CRoleTeam.Name = GlobalTeamConfMgr:GetInstance().Mgr:GetTeamName(self._selectTeamIndex)
    CRoleTeam.CommanderSkills = GlobalTeamConfMgr:GetInstance().Mgr:GetCommanderSkills(self._selectTeamIndex)
    CRoleTeam.FriTeams = {}
    local friend = GlobalTeamConfMgr:GetInstance().Mgr:GetFriendHeroData(self._selectTeamIndex)
    if friend then
        tInsert(CRoleTeam.FriTeams, friend)
    end
    if self._teamData then
        GlobalTeamConfMgr:GetInstance().Mgr:RequestUpdateTeam(CRoleTeam)
    else
        GlobalTeamConfMgr:GetInstance().Mgr:RequestCreateTeam(CRoleTeam)
    end
end

function M:_OnBtnClearClick()
    if self._isTeach then
        return
    end

    local tips = ConfigHelper.GetLocalString(520)
    GameHelper.Confirm(tips, function()
        local CRoleTeam = {}
        CRoleTeam.TeamId = self._selectTeamIndex
        CRoleTeam.HeroLength = 0

        if self._teamData then
            CRoleTeam.Name = self._teamData.Name
            CRoleTeam.CommanderSkills = self._teamData.CommanderSkills
        else
            CRoleTeam.Name = ConfigHelper.GetLocalString(7 + self._selectTeamIndex);
        end

        -- 清空选择的时候清除助战英雄
        GlobalTeamConfMgr:GetInstance().Mgr:SetFriendHeroData(self._selectTeamIndex)
        GlobalTeamConfMgr:GetInstance().Mgr:RequestUpdateTeam(CRoleTeam)
        self:_UpdateTipsState()
    end)
end

function M:_OnBtnStartClick()
    local GameGlobal = CS.GameX.GameGlobal

    if not self._isTeach then
        if not self._teamData or not self._teamData.Heroes or #self._teamData.Heroes <= 0 then
            GameHelper.TipsById(5230)
            return
        end
        -- 判断体力是否足够
        if EnergyMgr:GetInstance():EnergyValue() < self.mission.energyCost then
            GameHelper.TipsById(5181)
            return
        end
        if not GlobalTeamConfMgr:GetInstance().Mgr:CheckMinFighter(#self._teamData.Heroes) then
            return
        end
        local function BtnStart()
            if not self.tips and self:_ShowLevelTips() then
                return
            end
            -- 是否有自定义开战
            if GlobalTeamConfMgr:GetInstance().Mgr.EnterBattle then
                GlobalTeamConfMgr:GetInstance().Mgr:EnterBattle()
            else
                local needActiveTeam = GlobalTeamConfMgr:GetInstance().Mgr:NeedActiveTeam()
                self:GetContext():RequestActiveTeam(self._selectTeamIndex, needActiveTeam)
            end
            local idArr = {}

            for _, cmdId in ipairs(self._teamData.CommanderSkills or {}) do
                tInsert(idArr, CmderSkillMgr:GetCommanderSkillId(cmdId))
            end

            GameGlobal.commanderSkillId = idArr
        end

        local notProfession = self:_CheckProfession()
        if #notProfession > 0 then
            local function clickOk(aaa)
                BtnStart()
            end

            local function clickCancel()
            end

            local checkProfession
            for i = 1, #notProfession do
                if i == 1 then
                    checkProfession = ConfigHelper.GetLocalString(notProfession[i] + 24)
                else
                    checkProfession = checkProfession .. "," .. ConfigHelper.GetLocalString(notProfession[i] + 24)
                end
            end
            local tips = sfmt(ConfigHelper.GetLocalString(10034), checkProfession)
            CS.GameX.GameHelper.Confirm(tips, clickOk, clickCancel, 31, 5876, 5877)
            return
        else
            BtnStart()
        end
    else
        -- 教学模式
        GameGlobal.commanderSkillId = self.mission.adCMSkill
        self:GetContext():EnterBattle(self.selectHeroIds)
    end
end

function M:_OnBtnLeftClick()
    if self._isTeach then
        return
    end

    self._selectTeamIndex = self._selectTeamIndex - 1
    self:_InitTeamState()
end

function M:_OnBtnRightClick()
    if self._isTeach then
        return
    end

    self._selectTeamIndex = self._selectTeamIndex + 1
    self:_InitTeamState()
end

function M:_OnBtnDevelopClick()
    if self._isTeach then
        return
    end

    GlobalTeamConfMgr:GetInstance().Mgr:SetBattle(self._teamConfigStyle == TeamConfigStyle.Battle, self._battleMissionId)
    JumpMgr:GetInstance():Execute(68)
end

function M:_OnBtnAssistClick()
    if not GlobalTeamConfMgr:GetInstance().Mgr:IsShowFriendHero() then
        return
    end
    if self.firLockTips then
        GameHelper.TipsById(self.firLockTips)
        return
    end
    self.isAssist = not self.isAssist
    self._view.stateAssist:SetState(self.isAssist and 2 or 1)

    if self.isAssist then
        FriendDataMgr:GetInstance():SendRequestFriendHeroData(Bind(self, self._OnLoadFriendHeroCallBack, true))
    else
        self:_UpdateTeam()
    end
end

function M:TimerCallBack()
    self.refFriTimer = self.refFriTimer - 1
    self._view.labRefTimer:SetText(tostring(self.refFriTimer))

    if self.refFriTimer <= 0 and self._timer then
        self._timer:Stop()
        self._timer = nil
        self._view.labRefTimer:SetText("")
        self._view.stateFriRef:SetState(1)
    else
        self._view.labRefTimer:SetText(tostring(self.refFriTimer))
    end
end

function M:_OnFriRefClick()
    if self.refFriTimer and self.refFriTimer > 0 then
        -- GameHelper.Tips("CD中")
        return
    end

    FriendDataMgr:GetInstance():SendRequestFriendHeroData(Bind(self, self._OnLoadFriendHeroCallBack, false))
end

function M:_OnLoadFriendHeroCallBack(first, data)
    if first then
        if self.refFriTimer and self.refFriTimer > 0 then
            self._view.stateFriRef:SetState(2)
        else
            self._view.stateFriRef:SetState(1)
            self._view.labRefTimer:SetText("")
        end
    else
        self.refFriTimer = ConfigHelper.GetSystemParam(308)
        self._view.labRefTimer:SetText(tostring(self.refFriTimer))

        if self.refFriTimer > 0 then
            self._view.stateFriRef:SetState(2)
            self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
            self._timer:Start()
        else
            self._view.stateFriRef:SetState(1)
        end
    end

    self._friendHeros = data
    local friData = self:GetFriendData(self.index)
    self:UpdateHeroList(friData)
end

function M:GetFriendData(type)
    type = type - 1
    if type == 0 then
        return self._friendHeros
    end

    local tempData = {}
    for _, v in pairs(self._friendHeros) do
        local profession = ConfigHelper.GetCfgPropByLua("role", v.HeroId, "profession")

        if type == profession then
            tInsert(tempData, v)
        end
    end
    return tempData
end

-- 设置显示编队的状态
function M:_InitTeamState(isFirst)
    local teamMaxNum = GlobalTeamConfMgr:GetInstance().Mgr:GetTeamMaxNum()
    if self._selectTeamIndex <= 1 then
        self._view.btnLeft:SetActive(false)
        self._view.btnRight:SetActive(true)
    elseif self._selectTeamIndex >= teamMaxNum then
        self._view.btnLeft:SetActive(true)
        self._view.btnRight:SetActive(false)
    else
        self._view.btnLeft:SetActive(true)
        self._view.btnRight:SetActive(true)
    end

    if self._isTeach or teamMaxNum <= 1 then
        self._view.btnLeft:SetActive(false)
        self._view.btnRight:SetActive(false)
    end

    for i = 1, TEAMNUM do
        self._view["tfDot" .. i].gameObject:SetActive(self._selectTeamIndex == i)
        self._view["dot" .. i .. "_Bg"]:SetActive(i <= teamMaxNum and teamMaxNum > 1)
    end

    self._view.uiTeamItemCtrl:UpdateData(self._selectTeamIndex)
    self:_InitSelectHero()

    if not self._isTeach then
        local FriendHero = GlobalTeamConfMgr:GetInstance().Mgr:GetFriendHeroData(self._selectTeamIndex)
        self:_LoadFriendData(FriendHero, true)
    end

    if not isFirst then
        self:_InitHeros()
        self:_UpdataHeros()
        self:_UpdateSkills()
        self:_OnClickTab(self.index - 1)
    end
end

-- 设置助战次数
function M:_InitHelperNum()
    if self._teamConfigStyle ~= TeamConfigStyle.Battle or self._isTeach then
        return
    end
    -- 配置次数大于这个数的时候不显示
    local system321 = ConfigHelper.GetSystemParam(321)
    local missionData = MissionDataMgr:GetInstance():GetMissionDataById(self._battleMissionId)
    local missionType = missionData:ChapterType()
    local MissionOfferRewardsContext = UIContextMgr:GetInstance():GetContext("MissionOfferRewards")
    local missionId = MissionOfferRewardsContext:GetMissionId()
    if missionId == self._battleMissionId then -- 悬赏
        missionType = -1
    end
    self.helpAllNum = system321
    self.helpNum = system321
    if missionType == EChapterType.ECT_Main or missionType == EChapterType.ECT_Elite then -- 普通和精英
        self.helpAllNum = ConfigHelper.GetSystemParam(322)
    elseif missionType == EChapterType.ECT_Resource then -- 资源
        self.helpAllNum = ConfigHelper.GetSystemParam(323)
    elseif missionType == EChapterType.ECT_Encounter then -- 遭遇战(A,B 本)
        self.helpAllNum = ConfigHelper.GetSystemParam(325)
    elseif missionType == EChapterType.ECT_Activity then -- 活动副本
        self.helpAllNum = ConfigHelper.GetSystemParam(324)
    elseif missionType == -1 then -- 悬赏
        self.helpAllNum = ConfigHelper.GetSystemParam(326)
    end
    if self.helpAllNum >= system321 then
        self._view.helpNumState:SetState(1)
    else
        self._view.helpNumState:SetState(2)
        self:GetContext():GetHelperNum(missionType, Bind(self, self.HelperNumCallBack))
    end
end

function M:HelperNumCallBack(num)
    self.helpNum = self.helpAllNum - num
    self._view.labHelpNum:SetText(tostring(self.helpNum))
end

-- 记录选中英雄
function M:_InitSelectHero()
    self.selectId = {}
    self.selectGridHeroId = {}
    if self._isTeach then
        return
    end

    self._teamData = GlobalTeamConfMgr:GetInstance().Mgr:GetTeamById(self._selectTeamIndex)

    if self._teamData and self._teamData.Heroes then
        for i = 1, #self._teamData.Heroes do
            tInsert(self.selectId, self._teamData.Heroes[i])
            tInsert(self.selectGridHeroId, self._teamData.Heroes[i])
        end
    end

    if not self._teamData then
        local CRoleTeam = {}
        CRoleTeam.TeamId = self._selectTeamIndex
        CRoleTeam.HeroLength = 0
        CRoleTeam.Name = GlobalTeamConfMgr:GetInstance().Mgr:GetTeamName(self._selectTeamIndex)
        GlobalTeamConfMgr:GetInstance().Mgr:RequestCreateTeam(CRoleTeam)
    end
end

function M:_ShowLevelTips()
    if GlobalTeamConfMgr:GetInstance().Mgr:GetNotTips() then
        return
    end

    local levelTipCondition = ConfigHelper.GetSystemParams(252)

    if levelTipCondition.Length < 2 then
        Logger.LogError("配置表错误")
        return
    end

    if not GameHelper.CheckLockByOpenConditionId(levelTipCondition[0]) then
        return
    end

    if GameHelper.CheckLockByOpenConditionId(levelTipCondition[1]) then
        return
    end

    local showLv = self.mission.showLv
    local allLv = 0
    local heroNum = #self.selectHeroIds

    for i = 1, heroNum do
        local heroId = self.selectHeroIds[i]
        local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
        allLv = allLv + heroData:GetLevel()
    end

    local para = ConfigHelper.GetSystemParam(261)

    if allLv >= heroNum * showLv * para / 100 then
        return
    end

    self.tips = true
    UIContextMgr:GetInstance():Show(UIDefine.UIMissionLv)
    return true
end

--- 检测职业
function M:_CheckProfession()
    local jobCheck = self.mission.jobCheck
    if jobCheck.Length <= 0 then
        return {}
    end
    local needProfession = {}
    local FriendHero = GlobalTeamConfMgr:GetInstance().Mgr:GetFriendHeroData(self._selectTeamIndex)
    local friendHeroId
    if FriendHero and FriendHero.FriendId then
        friendHeroId = FriendHero.HeroData:GetHeroId()
    end
    for i = 0, jobCheck.Length - 1 do
        local checkProfession = jobCheck[i]
        local haveProfession = false
        if friendHeroId then
            local profession = ConfigHelper.GetCfgPropByLua("role", friendHeroId, "profession")
            if checkProfession == profession then
                haveProfession = true
                break
            end
        end
        for _, heroId in pairs(self.selectHeroIds) do
            local profession = ConfigHelper.GetCfgPropByLua("role", heroId, "profession")
            if checkProfession == profession then
                haveProfession = true
                break
            end
        end
        if not haveProfession then
            needProfession[#needProfession + 1] = checkProfession
        end
    end
    return needProfession
end

-- 取消选中一个英雄
function M:_OnClickCancleHero(heroId)
    if self._isTeach then
        return
    end

    tRemovebyvalue(self.selectHeroIds, heroId)
    self:_OnBtnEnterClick()
    self:_UpdateTipsState()
end

function M:_OnClickFirHero(heroId)
    if heroId then
        self:_OnClickFriendHero(nil, nil, false)
    else
        if self.isAssist then
            return
        end
        self:_OnBtnAssistClick()
    end
end

-- 初始化英雄
function M:_InitHeros()
    self.selectHeroIds = {}
    self.selectGridHeroId = {}
    -- 教学模式下
    if self._isTeach then
        local adHero = self.mission.adHero

        for i = 0, adHero.Length - 1 do
            self.selectHeroIds[i + 1] = adHero[i]
        end
    else
        self._teamData = GlobalTeamConfMgr:GetInstance().Mgr:GetTeamById(self._selectTeamIndex)

        if self._teamData and self._teamData.Heroes then
            GlobalTeamConfMgr:GetInstance().Mgr:SetDefaultTeamId(self._selectTeamIndex)

            for i = 1, #self._teamData.Heroes do
                self.selectHeroIds[i] = self._teamData.Heroes[i]
                self.selectGridHeroId[i] = self._teamData.Heroes[i]
            end
        end
    end
end

-- 刷新英雄列表
function M:_UpdataHeros()
    local heroLevel = {}
    local adCore = {}
    local adBreak = {}
    local adAwake = {}
    -- 教学模式下
    if self._isTeach then
        heroLevel = self.mission.adLevel
        adCore = self.mission.adCore
        adBreak = self.mission.adBreak
        adAwake = self.mission.adwake
    end

    for i = 1, HERONUM do
        local data = {heroId=self.selectHeroIds[i] or nil, index=i, isTeach=self._isTeach}
        data.heroId = self.selectHeroIds[i] or nil

        if data.heroId then
            if self._isTeach then
                data.level = heroLevel[i - 1]
                data.star = adCore[i - 1]
                data.grade = adBreak[i - 1]
                if adAwake ~= nil and adAwake.Length >= i then
                    data.awake = adAwake[i - 1]
                end
            else
                local heroData = IHeroDataMgr:GetMyHeroDataById(data.heroId)
                if IsNull(heroData) then
                    Logger.LogError("heroId:" .. data.heroId .. " data is nil")
                end
                data.level = heroData:GetLevel()
                data.star = heroData:GetCoreLevel()
                data.grade = heroData:GetBreakLevel()
                data.awake = heroData:GetAwakeLevel()
                data.fashion = heroData:GetFashion()
                data.skinCfg = heroData:GetSkinCfg()
            end

            data.rare = ConfigHelper.GetCfgPropByLua("hero", data.heroId, "rare")
        end

        self._view["heroItemCtr" .. i]:UpdateItem(data)
    end

    if not self._isTeach then
        local FriendHero = GlobalTeamConfMgr:GetInstance().Mgr:GetFriendHeroData(self._selectTeamIndex)
        self:_LoadFriendData(FriendHero, true)
    end
end

-- 获取助战英雄的详细数据
-- @param isOnlyRef boolean 仅仅刷新界面
function M:_LoadFriendData(FriendHero, isOnlyRef)
    local heroData = nil
    if FriendHero then
        heroData = FriendHero.HeroData
    end

    if not heroData then
        -- 没有助战英雄
        self._view.friendHeroCtrl:UpdateItem({isFri=true, self.firLockTips})
        return
    end
    if self.helpNum and self.helpNum <= 0 then
        GameHelper.TipsById(5761)
        return
    end
    local data = {index=0, isTeach=self._isTeach}
    data.heroId = heroData:GetHeroId()

    if data.heroId then
        data.level = heroData:GetLevel()
        data.star = heroData:GetCoreLevel()
        data.grade = heroData:GetBreakLevel()
        data.awake = heroData:GetAwakeLevel()
        data.fashion = heroData:GetFashion()
        data.skinCfg = heroData:GetSkinCfg()
        data.rare = ConfigHelper.GetCfgPropByLua("hero", data.heroId, "rare")
        data.isFri = true
    end

    self._view.friendHeroCtrl:UpdateItem(data)

    if isOnlyRef then
        return
    end

    GlobalTeamConfMgr:GetInstance().Mgr:SetFriendHeroData(self._selectTeamIndex, FriendHero)
    local friData = self:GetFriendData(self.index)
    if self.isAssist then
        self:UpdateHeroList(friData)
    end
    self:_UpdateTipsState()
end

function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnBack()
    if UIContextMgr:GetInstance():IsShow("TeamChangeSkills") then
        UIContextMgr:GetInstance():Close("TeamChangeSkills")
        return false
    else
        EventMgr:RemoveListener(UIMessageNames.UPDATETEAM, self._UpdateTeamTemp)
        GlobalTeamConfMgr:GetInstance().Mgr:SetFriendHeroData(self._selectTeamIndex)
        return true
    end
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.TEAMHEROITEMCLICK, self._OnClickCancleHeroTemp)
    EventMgr:RemoveListener(UIMessageNames.TEAMHEROITEMFRICLICK, self._TempOnClickCancleFirHero)
    EventMgr:RemoveListener(UIMessageNames.UPDATETEAM, self._UpdateTeamTemp)
    EventMgr:RemoveListener(UIMessageNames.CLICKSKILL, self._TempOnClickSkill)
    EventMgr:RemoveListener(UIMessageNames.TEAM_ENTERFIGHT, self._TempEnterFight)
    EventMgr:RemoveListener(UIMessageNames.TEAM_CLICKHERO, self._TempOnClickHero)
    EventMgr:RemoveListener(UIMessageNames.TEAM_CLICKFRIENDHERO, self._TempOnClickFriendHero)
    EventMgr:RemoveListener(UIMessageNames.TEAMCLICKNOTICEFRI, self._TempOnClickNotFri)

    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end

    if UIContextMgr:GetInstance():IsShow("TeamChangeSkills") then
        UIContextMgr:GetInstance():Close("TeamChangeSkills")
    end

    self._view.btnClear:RemoveOnClick()
    self._view.btnDevelop:RemoveOnClick()
    self._view.btnFriRef:RemoveOnClick()

    M.super.OnDispose(self)
end

return UITeamConfigCtrl
