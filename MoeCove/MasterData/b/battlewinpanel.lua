---@class BattleWinPanel : BattleWinPanel_Generate
---##################### 【BattleWinPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BattleWinPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local BattleWinPanel = require "BattleWinPanel_Generate"
local BattleCore = require "BattleCore"
local Random = require "Random"
---@type BattleManager
local battleMgr = nil

function BattleWinPanel:InitLogic(data)
    self._battleData = nil
    self.roleDataboxList = {}
    self.roleDataValueList = {}
    self.nowShowSpineObj = nil
    self.defaultTime = 0.3
end

--function BattleWinPanel:StartCreating(time)
--
--end

--function BattleWinPanel:StartEnter(time)
--
--end

--function BattleWinPanel:StartRemoving(time)
--
--end

--function BattleWinPanel:StartExit(time)
--
--end

function BattleWinPanel:OnOpen(data, initiative)
    self.mask.button.enabled = false
    battleMgr = BattleCore:getBattleMgr()
    if initiative then
        self._battleData = data
        self.levelConfig = Config.GetPveLevelInfo(data.levelId)
        self:refreshPanel(self._battleData)
        --测试版本不显示数据统计
        if self.levelConfig.type ~= GE.LevelType.Story then
            -- self._orderReport = cjson.decode(self._battleData.orderReport)
            -- self:refreshDataPanel(self._battleData, self._orderReport)
            -- self:refreshReportPanel(self._orderReport.simpleReport)
        end
        --获胜音效
        self:playWinSE()
    end
    self:SetUIVolume()
end

---@param data BattleResultResp
function BattleWinPanel:refreshPanel(data)
    local levelConfig = self.levelConfig
    self.normalType:SetActive(levelConfig.typemain ~= GE.LevelTypeMain.WeeklyBoss)
    self.weeklyBossType:SetActive(levelConfig.typemain == GE.LevelTypeMain.WeeklyBoss)
    if levelConfig.typemain == GE.LevelTypeMain.WeeklyBoss then
        self:setWeeklyBossTypeData(data)
    else
        self:setNormalTypeData(data)
    end

    --弹窗及角色展示界面流程处理
    self:showToastAndRole()

    --角色评论(目前不使用)
    -- self:setRoleCommentData(data)
    -- self:DoAfter(self.defaultTime * 3, function()
    --     self:showRoleComments()
    -- end)
    --角色显示及战斗完成对话
    self:showRoleAndVoice(data)
end

--弹窗及角色
function BattleWinPanel:showToastAndRole()
    self:DoAfter(0.5 + (self.defaultTime * 3), function()
        if self.showCharacterData then
            self.effect_Ui_ZhanDouWanCheng_GengXing:SetActive(false)
            self.effect_Ui_ZhanDouWanCheng2:SetActive(false)
            UIMgr:popUICover("ShowCharacterPanel", {resultData = self.showCharacterData, closeFunc = function()
                self.effect_Ui_ZhanDouWanCheng_GengXing:SetActive(true)
                self.effect_Ui_ZhanDouWanCheng2:SetActive(true)
                UIMgr:endDepositToast(GE.DepositToastType.Battle)
                self.mask.button.enabled = true
            end})
        else
            UIMgr:endDepositToast(GE.DepositToastType.Battle)
            self.mask.button.enabled = true
        end
    end)
end

--显示通用战斗结算信息
function BattleWinPanel:setNormalTypeData(data)
    local levelConfig = self.levelConfig
    local audioPath = string.format(Config.AudioPath.SE, "click_back")
    if levelConfig.triggerID1 == 1000001 then
        for i = 1, 3 do
            self["start"..i]:SetActive(false)
            self["star_"..i]:SetActive(false)
        end
    else
        --星级
        for i = 1, 3 do
            self:DoAfter(0.5 + (self.defaultTime * i), function()
                if UICommonUtils.Checkobj(self["start"..i]) then
                    self["start"..i]:SetActive(data.star >= i)
                    if data.star >= i then
                         self:play2DSound(audioPath)
                    end
                end
            end)
            self["star_"..i]:SetActive(true)
        end
    end
    --母港经验等级
    
    self.levelText.text.text = Me:getUserLevel()
    self.addExpText.text.text = "EXP+"..levelConfig.userExp
    local levelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.user, Me:getUserLevel())
    local nowExp = Me:getUserEXP() - levelData.exp_sum
    --等级已满特殊显示
    if levelData.max_level == Me:getUserLevel() and Me:getUserEXP() >= levelData.exp_sum then
        self.nowExpText.text.text = "已达上限"
        self.expSlider.slider.value = 0
    else
        self.nowExpText.text.text = nowExp.."/"..levelData.exp
        self.expSlider.slider.value = (nowExp - levelConfig.userExp) / levelData.exp
        self.expSlider.slider:DOValue(nowExp / levelData.exp, 1)
    end

    --TODO星级通关条件
    local eventMgr = battleMgr:getBattleEventManager()
    local deductIdList = eventMgr:getDeductStarIdList()
    self.levelTarget1.desText.text.text = levelConfig.victoryDesKey
    for i = 2, 3 do
        self["levelTarget"..i].desText.text.text = levelConfig["starDesKey"..(i - 1)]
        self["levelTarget"..i].notClear:SetActive(false)
        self["levelTarget"..i].clear:SetActive(true)
        local targetId = levelConfig["triggerID"..(i - 1)]
        for _, deductId in pairs(deductIdList) do
            if deductId == targetId then
                self["levelTarget"..i].notClear:SetActive(true)
                self["levelTarget"..i].clear:SetActive(false)
                break
            end
        end
    end

    

    --成就奖励
    local achieveRewardList = data.achieveRewardList and clone(data.achieveRewardList) or {}
    for _, rewardData in ipairs(achieveRewardList) do
        rewardData.tipsTextColor = Color.NewFromStr("ff5912")
        rewardData.tipsText = LocalStrEnum.PveChallengeRewardTag
        rewardData.isFrist = true
    end
    --首通奖励
    local fristDrop = data.fristDrop and clone(data.fristDrop) or {}
    for _, rewardData in ipairs(fristDrop) do
        rewardData.isFrist = true
    end
    --额外奖励
    local extraRewardList = data.extraRewardList and clone(data.extraRewardList) or {}
    for _, rewardData in ipairs(extraRewardList) do
        rewardData.tipsText = LocalStrEnum.PveExtraRewardTag
        rewardData.isFrist = true
    end

    --奖励整合
    local newRewardList = tablex.combine(achieveRewardList or {}, data.rewardList or {})
    --需要额外显示的奖励不合并
    newRewardList = tablex.combine(extraRewardList, newRewardList)
    newRewardList = tablex.combine(fristDrop, newRewardList)

    self:FillTemplateContent(self.customBox, self.rewardList, #newRewardList, function(index, itemObj)
        local customBox = itemObj.customBox
        local rewardData = newRewardList[index]
        --[[if rewardData.extraType == GE.ItemPropType.CharToken then
            local roleConfig = Config.GetCharacterInfo(rewardData.id)
            rewardData.type = GE.RewardType.ItemProp
            rewardData.id = roleConfig.getPatch[1][2]
            rewardData.num = roleConfig.getPatch[1][3]
        end

        if rewardData.type == GE.RewardType.ItemProp then
            local itemConfig = Config.GetItemInfo(rewardData.id)
            data.id = rewardData.id
            data.itemNum = rewardData.num
            data.itemType = GE.ItemTypeIndex.item
        elseif rewardData.type == GE.RewardType.Equipment then
            local equipData = Me:getEquipDataByid(rewardData.id)
            local equipConfig = Config.GetEquipmentInfo(equipData.cid)
            data.id = equipData.cid
            data.star = equipData.star
            data.isLock = equipData.isLock
            data.itemNum = "Lv."..equipData.level
            data.itemType = GE.ItemTypeIndex.equip
            data.rid = rewardData.id
            data.CanLock = true
        elseif rewardData.type == GE.RewardType.Weapon then
            local weaponData = Me:getWeaponDataById(rewardData.id)
            local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
            data.id = weaponData.cid
            data.isLock = weaponData.isLock
            data.itemNum = "Lv."..weaponData.level
            data.itemType = GE.ItemTypeIndex.weapon
            data.rid = rewardData.id
            data.CanLock = true
        elseif rewardData.type == GE.RewardType.Character then
            local roleConfig = Config.GetCharacterInfo(rewardData.id)
            data.itemType = GE.ItemTypeIndex.Character
        end

        --处理特殊掉落角标
        if rewardData.isFrist then
            data.isFrist = true
        end
        ]]
        customBox:setMono(self)
        customBox:SetUIData(rewardData, {tipsText = rewardData.tipsText, tipsTextColor = rewardData.tipsTextColor})
        if rewardData.type == GE.RewardType.Character then
            self.showCharacterData = rewardData
        end
    end)
end

--显示危境攻坚战斗结算信息
function BattleWinPanel:setWeeklyBossTypeData(data)
    for i = 1, 3 do
        self["star_"..i]:SetActive(false)
    end
    local levelConfig = self.levelConfig
    local bossCfg = Me:getWeeklyBossLevelConfigByLevelId(levelConfig.id)
    local bossActivity = Me:getBossActivityData()
    local bossLevelData = bossActivity.bossLevelMap[bossCfg.id] or {}
    --积分倍率
    local totalAddition = battleMgr:getweeklyBossScoreAddition() + 1
    local passTagList = battleMgr:RefreshWeeklyBossTags()
    local ptcTxt = string.format("积分倍率:%s%%", tostring(totalAddition * 100))
    self.tagPctTxt.text.text = ptcTxt
    --词条列表
    self:FillTemplateContent(self.weeklyBossTagBox, self.taglist, #bossLevelData.tagList or 0, function (index,weeklyBossTagBox)
        local tagBox = weeklyBossTagBox.weeklyBossTagBox
        local tagId = bossLevelData.tagList[index]
        --初始化格子显示
        local boxData = {
            tagId = tagId,
            isSelected = false,
            isActive = passTagList[tagId] ~= nil,
        }
        tagBox:setTagBoxData(boxData)
    end)
    --本次伤害
    local allDamage = battleMgr:getFriendCampAllDamageValue()
    self.allDamageTxt.text.text = allDamage or 0
    --本次积分
    local nowScore = allDamage * totalAddition
    self.allScoreTxt.text.text = math.floor(nowScore)
    local nowPeriodScore = bossLevelData.nowScore or 0
    self.scoreAnim:SetActive(nowScore > (nowPeriodScore or 0))
    --最高积分
    self.topScoreTxt.text.text = nowPeriodScore or 0
end

---@param data BattleResultResp
--角色显示及战斗完成对话
function BattleWinPanel:showRoleAndVoice(data)
    --随机一位参战角色
    local seed = DLuaUtil.GetGreenwichTime()
    local random = Random:new(seed)
    local roleWeightMain = {}
    if data.rolesDataList then
        for _, battleRoleData in pairs(data.rolesDataList) do
            table.insert(roleWeightMain, {index = battleRoleData.cid, weight = 1})
        end
    else
        local roleList = ClientData:GetRoleList()
        for id, _ in pairs(roleList) do
            table.insert(roleWeightMain, {index = id, weight = 1})
        end
    end
	
	local roleId = DLuaUtil.getRandomIndexLinear(roleWeightMain, random)
    local battleRoleManager = battleMgr:getRoleManager()
    local battleRole = battleRoleManager:getRoleByCid(roleId)
    --根据角色类型显示立绘或spine
    local skinConfig = nil
    if battleRole then
        if battleRole.isMonster then
            local monsterConfig = Config.GetMonsterInfo(battleRole.cid)
            skinConfig = Config.GetCharacterSkinInfo(monsterConfig.baseSkinID)
        else
            local roleServerData = battleRole.serverData
            skinConfig = Config.GetCharacterSkinInfo(roleServerData.equipSkin)
        end
    end
    if not skinConfig then
        skinConfig = Config.GetCharacterSkinInfo(1000601)
    end
    local skinId = skinConfig.id

    UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, skinId, function(spineObject)
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
             GameObject.Destroy(self.nowShowSpineObj)
        end
        self.nowShowSpineObj = spineObject
    end)
    local nowPos = self.roleSpeak.rectTransform.anchoredPosition
    self.showCharacter.rectTransform.anchoredPosition = Vector2(nowPos.x - 300, self.showCharacter.rectTransform.anchoredPosition.y)

    --根据战斗星级显示文字及语音
    local lineWeightMain = {}
    local startLine = {}
    if data.star == 3 then
        startLine = skinConfig.battleWinPerfect
    else
        startLine = skinConfig.battleWin
    end
	for _, lineData in pairs(startLine) do
		table.insert(lineWeightMain, {index = lineData[1], weight = lineData[2]})
	end
	if not next(lineWeightMain)then
		self.roleSpeak:SetActive(false)
		return
	end
	local voiceId = DLuaUtil.getRandomIndexLinear(lineWeightMain, random)
	local nowLineConfig = Config.GetScriptLinesInfo(voiceId)
	if not nowLineConfig then
        self.roleSpeak:SetActive(false)
		return
    else
        self.roleSpeak:SetActive(true)
	end
    self:DoAfter(0.5, function()
        UICommonUtils.Play2DVoiceByLanguage(skinConfig.CharacterID, nowLineConfig.resource,nil, self.gameObject)
    end)
    self.speakText.text.text = nowLineConfig.line
end

--角色评论功能
function BattleWinPanel:setRoleCommentData(data)
    local maxRoleCount = 3
    self.commentDataList = {}
    local roleList = ClientData:GetRoleList()
    if roleList then
        local role = next(roleList)
        if role then
            table.insert(self.commentDataList, {id = role, content = ""})
        end
    end
    local needRoleCount = math.min(#self.commentDataList, maxRoleCount)
    for i = 1, needRoleCount do
        local needData = {
            subdomain = {
                type = "post_battle",
                level_id = tostring(data.levelId)
            },
            role_id = self.commentDataList[i].id
        }
        SDKMgr:getRoleCommentContent(needData, function(success, commentData)
            if success then
                self.commentDataList[i].content = commentData.data.dialogue_text
            else
                LuaLogger.ds("<color=#FF0000>角色评论数据获取失败!</color>")
            end
        end)
    end
    --LuaLogger.ds(">>>>commentDataList<<<<<", tablex.dump(self.commentDataList))
    if #self.commentDataList == 0 then
        return
    end
    self.commentBoxObjList = {}
    self:FillTemplateContent(self.commentBox, self.commentBoxList, needRoleCount, function(index, commentBox)
        local roleId = self.commentDataList[index].id
        local iconPath = string.format(Config.SpritePath.IconRolePath, roleId, "character_"..roleId)
        self:LoadSpriteAsync(iconPath, commentBox.headIcon.image)
        commentBox.canvasGroup.alpha = 0
        table.insert(self.commentBoxObjList, commentBox)
    end)
end

--显示角色评论
function BattleWinPanel:showRoleComments()
    local canGo = true
    for key, commentBox in pairs(self.commentBoxObjList) do
        if not UICommonUtils.Checkobj(commentBox) then
            canGo = false
            break
        end
        if self.commentDataList[key].content == "" then
            commentBox:SetActive(false)
        else
            commentBox.commentText.text.text = self.commentDataList[key].content
        end
        commentBox.transform.localScale = Vector3.New(1, 0, 1)
        commentBox.commentBg.transform.localScale = Vector3.New(0, 1, 1)
    end
    if canGo then
        self:commentRecursion(1)
    end
end

--评论显示递归逻辑
function BattleWinPanel:commentRecursion(nowCount)
    local commentBox = self.commentBoxObjList[nowCount]
    local maxRoleCount = #self.commentBoxObjList
    commentBox.transform:DOScaleY(1, 0.3):OnComplete(function()
        commentBox.canvasGroup:DOFade(1, 0.2)
        commentBox.commentBg.transform:DOScaleX(1, 0.2):OnComplete(function()
            nowCount = nowCount + 1
            if nowCount <= maxRoleCount then
                self:commentRecursion(nowCount)
            end
        end)
    end):OnUpdate(function()
        UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.commentBoxList.transform)
    end)
end

function BattleWinPanel:refreshDataPanel(data, orderReport)
    --print("statisticData",tablex.dump(orderReport.statistic))
    local roleDataLength = 0
    if data.rolesDataList then
        roleDataLength = #data.rolesDataList
    end

    if roleDataLength == 0 then
        return
    end
    --参战人员
    self:FillTemplateContent(self.dataBox, self.dataContent, #data.rolesDataList, function (index, dataBox)
        local roleData = data.rolesDataList[index]
        if LuaLogger.Enabled then
            --LuaLogger.ds(">>>>>>!!!!!<<<<<<", tablex.dump(roleData))
        end
        -- local roleConfig = Config.GetCharacterInfo(roleData.id)
        local dataId = 10000 + tonumber(roleData.id)
        local statisticData = orderReport.statistic[tostring(dataId)]

        --角色头像格式设置
        local roleServerData = Me:getPlayerHero(roleData.cid)

        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        local skinConfig = {}
        skinConfig = Config.GetCharacterSkinInfo(roleServerData.equipSkin)
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end
        local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
        dataBox.roleBox.roleImg:SetActive(true)
        self:LoadSpriteAsync(iconPath, dataBox.roleBox.roleImg.image)

        dataBox.roleBox.levelText.text.text = roleData.level
        local farmePath = string.format(Config.SpritePath.RankFrameSmall, roleServerData.rank)
        self:LoadSpriteAsync(farmePath, dataBox.roleBox.frameImg.image)
        local starPath = string.format(Config.SpritePath.RoleSStarIcon, roleServerData.star)
        self:LoadSpriteAsync(starPath, dataBox.roleBox.starImg.image)

        local dmgValue = 0
        local takeDmgValue = 0
        local cureValue = 0
        --print("statisticData id:",roleData.id,dataId)
        --print("statisticData data:",statisticData, orderReport.statistic)
        if (statisticData) then
            --print("statisticData Damage:",statisticData[GE.BattleStatisticType.Damage])
            --print("statisticData TakeDamage:",statisticData[GE.BattleStatisticType.TakeDamage])
            --print("statisticData Repair:",statisticData[GE.BattleStatisticType.Repair])
            dmgValue = 1.0*(statisticData[tostring(GE.BattleStatisticType.Damage)] or 0)
            takeDmgValue = 1.0*(statisticData[tostring(GE.BattleStatisticType.TakeDamage)] or 0)
            cureValue = 1.0*(statisticData[tostring(GE.BattleStatisticType.Repair)] or 0)
        end

        table.insert(self.roleDataboxList, dataBox)
        self.roleDataValueList[index] ={
            dmgValue = dmgValue,
            takeDmgValue = takeDmgValue,
            cureValue = cureValue,
        }
        self.roleDataValueList.allDmgValue = (self.roleDataValueList.allDmgValue or 0) + dmgValue
        self.roleDataValueList.allTakeDmgValue = (self.roleDataValueList.allTakeDmgValue or 0) + takeDmgValue
        self.roleDataValueList.allCureValue = (self.roleDataValueList.allCureValue or 0) + cureValue
    end)

    for index, dataBox in pairs(self.roleDataboxList) do
        local dmgValue = self.roleDataValueList[index].dmgValue
        local takeDmgValue = self.roleDataValueList[index].takeDmgValue
        local cureValue = self.roleDataValueList[index].cureValue
        dataBox.dmgSlider.slider.value = dmgValue / self.roleDataValueList.allDmgValue
        dataBox.takeDmgSlider.slider.value = takeDmgValue / self.roleDataValueList.allTakeDmgValue
        dataBox.cureSlider.slider.value = cureValue / self.roleDataValueList.allCureValue
        dataBox.dmgNumText.text.text = dmgValue
        dataBox.takeDmgNumText.text.text = takeDmgValue
        dataBox.cureNumText.text.text = cureValue
        dataBox.dmgPerText.text.text = math.floor((dmgValue / self.roleDataValueList.allDmgValue * 100) + 0.5).."%"
        dataBox.takeDmgPerText.text.text = math.floor((takeDmgValue / self.roleDataValueList.allTakeDmgValue * 100) + 0.5).."%"
        dataBox.curePerText.text.text = math.floor((cureValue / self.roleDataValueList.allCureValue * 100) + 0.5).."%"
        dataBox:SetActive(true)
    end
end

function BattleWinPanel:refreshReportPanel(simpleReport)
    print("simpleReportData",tablex.dump(simpleReport))
    local battleRoleManager = battleMgr:getRoleManager()
    local roundList = tablex.toarray(simpleReport)
    table.sort(roundList, function(a, b)
        return a.round < b.round
    end)
    --LuaLogger.ds(">>>>roundList<<<<<", tablex.dump(roundList))
    self:FillTemplateContent(self.battleReportPanel.reportRoundBox, self.battleReportPanel.reportContent, #roundList, function (index, roundBox)
        local roundData = roundList[index]
        roundBox.roundText.text.text = string.format("第%s回合", roundData.round)
        local reportList = tablex.toarray(roundData.reportList)
        self:FillTemplateContent(self.battleReportPanel.reportBox, roundBox.ourGroup, #reportList, function (index1, reportBox)
            local defeatList = reportList[index1].defeatList
            self:FillTemplateContent(self.battleReportPanel.reportRoleBox, reportBox.roleContent, 1, function (index2, roleBox)
                local battleRole = battleRoleManager:getRole(reportList[index1].roleId, true)
                local skinConfig = {}
                local roleRank = 1
                if battleRole.isMonster then
                    local monsterConfig = Config.GetMonsterInfo(battleRole.cid)
                    skinConfig = Config.GetCharacterSkinInfo(monsterConfig.baseSkinID)
                    roleRank = monsterConfig.rank
                else
                    local roleServerData = Me:getPlayerHero(battleRole.cid)
                    skinConfig = Config.GetCharacterSkinInfo(roleServerData.equipSkin)
                    roleRank = roleServerData.rank
                end
                local function is_numeric(str)
                    return tonumber(str) ~= nil
                end
                local resourceFolder = nil
                if is_numeric(skinConfig.resourceFolder) then
                    resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
                else
                    resourceFolder = skinConfig.resourceFolder
                end
                local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
                roleBox.roleImg:SetActive(true)
                self:LoadSpriteAsync(iconPath, roleBox.roleImg.image)
                local farmePath = string.format(Config.SpritePath.RoleFrameLittle, roleRank)
                self:LoadSpriteAsync(farmePath, roleBox.rankImg.image)
                roleBox:SetActive(true)
            end)
            self:FillTemplateContent(self.battleReportPanel.reportRoleBox, reportBox.defeatContent, #defeatList, function (index2, roleBox)
                local defeatRole = battleRoleManager:getRole(defeatList[index2], true)
                local defeatconfig = Config.GetMonsterInfo(defeatRole.cid)
                local iconPath = string.format(Config.SpritePath.IconRolePath, defeatRole.cid, defeatconfig.imgKey)
                roleBox.roleImg:SetActive(true)
                self:LoadSpriteAsync(iconPath, roleBox.roleImg.image)
                local farmePath = string.format(Config.SpritePath.RoleFrameLittle, defeatconfig.rank)
                self:LoadSpriteAsync(farmePath, roleBox.rankImg.image)
                roleBox:SetActive(true)
                roleBox.defeat:SetActive(true)
            end)
            reportBox:SetActive(true)
        end)
        local monsterReportList = tablex.toarray(roundData.monsterReportList)
        self:FillTemplateContent(self.battleReportPanel.reportBox, roundBox.enemyGroup, #monsterReportList, function (index1, reportBox)
            local defeatList = monsterReportList[index1].defeatList
            self:FillTemplateContent(self.battleReportPanel.reportRoleBox, reportBox.roleContent, 1, function (index2, roleBox)
                local defeatRole = battleRoleManager:getRole(monsterReportList[index1].roleId, true)
                local defeatconfig = Config.GetMonsterInfo(defeatRole.cid)
                local iconPath = string.format(Config.SpritePath.IconRolePath, defeatRole.cid, defeatconfig.imgKey)
                roleBox.roleImg:SetActive(true)
                self:LoadSpriteAsync(iconPath, roleBox.roleImg.image)
                local farmePath = string.format(Config.SpritePath.RoleFrameLittle, defeatconfig.rank)
                self:LoadSpriteAsync(farmePath, roleBox.rankImg.image)
                roleBox:SetActive(true)
                roleBox.defeat:SetActive(true)
                roleBox:SetActive(true)
            end)
            self:FillTemplateContent(self.battleReportPanel.reportRoleBox, reportBox.defeatContent, #defeatList, function (index2, roleBox)
                local battleRole = battleRoleManager:getRole(defeatList[index2], true)
                local roleServerData = Me:getPlayerHero(battleRole.cid)
                local function is_numeric(str)
                    return tonumber(str) ~= nil
                end
                local skinConfig = {}
                skinConfig = Config.GetCharacterSkinInfo(roleServerData.equipSkin)
                local resourceFolder = nil
                if is_numeric(skinConfig.resourceFolder) then
                    resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
                else
                    resourceFolder = skinConfig.resourceFolder
                end
                local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
                roleBox.roleImg:SetActive(true)
                self:LoadSpriteAsync(iconPath, roleBox.roleImg.image)
                local farmePath = string.format(Config.SpritePath.RoleFrameLittle, roleServerData.rank)
                self:LoadSpriteAsync(farmePath, roleBox.rankImg.image)
                roleBox:SetActive(true)
                roleBox.defeat:SetActive(true)
            end)
            reportBox:SetActive(true)
        end)
        roundBox:SetActive(true)
    end)
end

--刷新格子信息
---@param customBox UnityEngine.GameObject  通用格子
---@param customData table  通用格子的信息
---@param typeIndex integer 通用格子的类型
---@param rewardId integer  通用格子的ID
function BattleWinPanel:refreshBoxStata(customBox, customData, typeIndex, rewardId)
    local data = {
        id = rewardId,
        type = typeIndex,
        num = 1,
    }
    customBox:setMono(self)
    customBox:SetUIData(data)
end

---@param data CustomMsgData
function BattleWinPanel:OpenCustomMsgPanel(data)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

--退出逻辑
function BattleWinPanel:CloseToChangeState()
    local cfg = battleMgr:getLevelConfig()
    local nowLevelId = cfg.id
    battleMgr:clear()
    LoadingMgr:SetLoadingStart(function()
        if nowLevelId == 10102 then
            StateMgr:ChangeToState(GameFlowState.GameState)
        elseif nowLevelId > 10102 then
            StateMgr:BackLastState()--正常逻辑
        else
            Me:setNowSelectLevel(nowLevelId + 1)
            StateMgr:ChangeToState(GameFlowState.BattleState)
        end
    end, nil, nil, "BattleWinPanel")
end

--结算后剧情判断(该位置目前只支持avg剧情)
function BattleWinPanel:CheckStoryAfterBattle()
    local levelCfg = battleMgr:getLevelConfig()
    if levelCfg.storyOver ~= 0 then
        local storyConfig = Config.GetStoryArraryInfo(levelCfg.storyOver)
        if storyConfig.type == 2 then
            LoadingMgr:SetUIQuickSwitchStart(function()
                UIMgr:popUI("StoryPanel", {
                    storyName = storyConfig.storyArrary[1],
                    callBack = function()
                        self:CloseToChangeState()
                    end,
                    openFinishFunc = function()
						LoadingMgr:SetUIQuickSwitchOver()
					end
                })
            end)
        else
            self:CloseToChangeState()
        end
    else
        self:CloseToChangeState()
    end

end

--设置相机的后处理
function BattleWinPanel:SetUIVolume()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--获胜音效
function BattleWinPanel:playWinSE()
    AudioMgr:StopCurrBgm(0.3)
    local audioPath = string.format(Config.AudioPath.SE, "Victory_s")
    self:play2DSound(audioPath)
end

--function BattleWinPanel:OnClose(initiative)
--
--end

--function BattleWinPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function BattleWinPanel:OnRefresh(data)
--
--end

--[[
/StatisticsBtn onClick 
--]]
function BattleWinPanel:statisticsBtn_ScaleButton_onClick(statisticsBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.levelConfig.type ~= GE.LevelType.Story then
        self.dataStatisticsPanel:SetActive(true)
    end
end

--[[
/SkillPanelBg/NextBtn onClick 
--]]
function BattleWinPanel:nextBtn_ScaleButton_onClick(nextBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    battleMgr:clear()
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "BattleWinPanel2")
end

--[[
/DataStatisticsPanel/DataStatisticsBox/DataToggle onValueChanged 
--]]
function BattleWinPanel:dataToggle_Toggle_onValueChanged(dataToggle,isOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not isOn then
        return
    end
    self.battleDataPanel:SetActive(true)
    self.battleReportPanel:SetActive(false)
    self.dataToggle.toggle.interactable = false
    self.reportToggle.toggle.interactable = true
    self.reportToggle.toggle.isOn = false
end

--[[
/DataStatisticsPanel/DataStatisticsBox/ReportToggle onValueChanged 
--]]
function BattleWinPanel:reportToggle_Toggle_onValueChanged(reportToggle,isOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not isOn then
        return
    end
    self.battleDataPanel:SetActive(false)
    self.battleReportPanel:SetActive(true)
    self.dataToggle.toggle.interactable = true
    self.reportToggle.toggle.interactable = false
    self.dataToggle.toggle.isOn = false
    UICommonUtils.RefreshLayoutGroup(self.battleReportPanel.reportContent)
end

--[[
/DataStatisticsPanel/DataStatisticsBox/TitleBg/CloseDataBtn onClick 
--]]
function BattleWinPanel:closeDataBtn_ScaleButton_onClick(closeDataBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.dataStatisticsPanel.animOverCallBack:SetCallBack(function()
        self.dataStatisticsPanel:SetActive(false)
    end)
    self.dataStatisticsPanel.animation:Play("DataOut")
end

--[[
/DataStatisticsPanel/mask2 onClick 
--]]
function BattleWinPanel:mask2_Button_onClick(mask2)
    self.dataStatisticsPanel.animOverCallBack:SetCallBack(function()
        self.dataStatisticsPanel:SetActive(false)
    end)
    self.dataStatisticsPanel.animation:Play("DataOut")
end

--[[
/mask onClick 
--]]
function BattleWinPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self.animator.enabled = true
    self.mask.button.enabled = false
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        self.effect_Ui_ZhanDouWanCheng_GengXing:SetActive(false)
        self.effect_Ui_ZhanDouWanCheng2:SetActive(false)
        self:CheckStoryAfterBattle()
    end)
end

return BattleWinPanel
