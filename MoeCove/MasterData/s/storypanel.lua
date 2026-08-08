---@class StoryPanel : StoryPanel_Generate
---##################### 【StoryPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【StoryPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local StoryPanel = require "StoryPanel_Generate"
local Screen = UnityEngine.Screen
local md5Lua = require "md5Lua"
local utf8util = require "utf8util"

function StoryPanel:InitLogic(data)
    self.spineList = {}

    self.headSpineList = {}

    self.effectList = {}

    self.cgSpineList = {}

    self.backGroundList = {}

    self.sprictIndex = 1

    self.nowSettingNum = 0

    self.isJump = false

    self.jumpIndex = 1

    self.isNext = true

    self.ueseBackgroundNum = 1

    self.stopTalkActionTimerList = {}

    self.stopTalkCallbackList = {}

    self.dialogueLogList = {}

    self.autoPlay = false

    self.isHide = false

    self.isNarrationMode = false

    self.isTelephonyMode = false

    self.isSilent = false

    self.doActionTimerList = {}

    self.canAutoClick = true

    self.sEKeyList = {}

    self.nowMoveTimesMap = {}

    self.notMove = false

    self.nowLogMessageIndex = 0

    self.needStopOutsideBGM = false

    self.needKeepOutsideBGM = false

    self.needKeepInsideBGM = false

    self.lastBGMData = nil

    self.needLoadingMask = false
end

--function StoryPanel:StartCreating(time)
--
--end

--function StoryPanel:StartEnter(time)
--
--end

--function StoryPanel:StartRemoving(time)
--
--end

--function StoryPanel:StartExit(time)
--
--end

function StoryPanel:OnOpen(data, initiative)
    -- self.originRenderScale = QualitySettingsMgr:GetURPRenderScale()
    -- QualitySettingsMgr:SetURPRenderScale(1)
    if initiative then
        self.nowStoryName = data.storyName
        self.callBack = data.callBack
        self.callBackAfter = data.callBackAfter
        self.openFinishFunc = data.openFinishFunc
        self.needEndLoading = data.needEndLoading
        self:InitPanel()
    end
    LoadingMgr:SetUISwitchOver()
end

function StoryPanel:InitPanel()
    --self.storyData = require("story_avg_test")
    if GV.isAvgEditor and GV.IsEditor then
        local name = self.nowStoryName
		local fileName = string.format("%s.lua", name)
		local path = string.format(Config.StoryLuaPath, fileName)
		local file = io.open(path, "r")
		if not file then
			return nil
		end
		self.storyData = loadstring(file:read("*a"))()
		file:close()
    else
        self.storyData = require(self.nowStoryName)
    end
    self.fastForwardBtn:SetActive(GV.isAvgEditor and GV.IsEditor)
    
    --初始化自动播放UI动画
    self.round.animator.speed = 0

    --初始化界面Canvas,配合特效显示
    self.storyCharacter.canvas.sortingLayerName = "UI"
    self.storyCG.canvas.sortingLayerName = "UI"
    self.storyUIGroup.canvas.sortingLayerName = "UI"
    self.screenDynamic.canvas.sortingLayerName = "UI"
    self.storyBtnGroup.canvas.sortingLayerName = "UI"
    self.storyCurtain.canvas.sortingLayerName = "UI"

    --初始化背景适配
    self:initBackgroundSize()
    --初始化RenderTexture
    self:initRenderTexture(function()
        self:_CreatSettingData()
    end)
end

--处理提前准备的内容
function StoryPanel:_CreatSettingData()
    local settingData = {}
    local function checkAddRoleSpine(roleId)
        if not settingData[roleId] then
            settingData[roleId] = {}
            settingData[roleId] = {
                type = GE.InitAvgScriptType.CreateSpine,
                resId = roleId,
            }
        end
    end
    local function checkAddHeadSpine(roleId)
        if not settingData[roleId.."Head"] then
            settingData[roleId.."Head"] = {}
            settingData[roleId.."Head"] = {
                type = GE.InitAvgScriptType.CreateHeadSpine,
                resId = roleId,
            }
        end
    end
    local function checkAddEffect(name)
        if not settingData[name] then
            settingData[name] = {
                type = GE.InitAvgScriptType.CreateEffect,
            }
        end
    end
    local function checkAddCGSpine(name)
        if not settingData[name] then
            settingData[name] = {
                type = GE.InitAvgScriptType.CreateCGSpine,
            }
        end
    end
    local function checkAddBGM(BGMData)
        local name = BGMData.title
        if not name then
            return
        end
        local bgmSource = BGMData.left
        if not settingData[name] then
            settingData[name] = {
                type = GE.InitAvgScriptType.CreateBGM,
                source = bgmSource,
            }
        end
    end
    local function setStopBGMData(BGMData)
        if not self.needKeepOutsideBGM then
            self.needStopOutsideBGM = true
        end
        self.lastBGMData = BGMData
    end
    local function setKeepBGMData(scriptIndex, maxIndex)
        if scriptIndex == 1 then
            self.needKeepOutsideBGM = true
        elseif scriptIndex == maxIndex then
            self.needKeepInsideBGM = true
        end
    end
    local function checkAddBackGround(name)
        if not settingData[name] then
            settingData[name] = {
                type = GE.InitAvgScriptType.CreateBackGround,
            }
        end
        if not self.needLoadingMask then
            self.needLoadingMask = true
            self.storyCurtain.canvasGroup.alpha = 1
        end
    end

    for key, value in pairs(self.storyData) do
        --预加载处理
        if value.type == GE.StoryScriptType.DoTalk
        or value.type == GE.StoryScriptType.ComeOnStage
        or value.type == GE.StoryScriptType.DoSilent then
            if value.left and value.left ~= "" then
                checkAddRoleSpine(value.left)
            end
            if value.center and value.center ~= "" then
                checkAddRoleSpine(value.center)
            end
            if value.right and value.right ~= "" then
                checkAddRoleSpine(value.right)
            end
        elseif value.type == GE.StoryScriptType.DoTelephony then
            if value.showCharacter and value.showCharacter ~= "" then
                checkAddHeadSpine(value.showCharacter)
            end
        elseif value.type == GE.StoryScriptType.ShowEffect then
            checkAddEffect(value.title)
        elseif value.type == GE.StoryScriptType.ShowCG then
            checkAddCGSpine(value.title)
        elseif value.type == GE.StoryScriptType.ChangeBGM then
            checkAddBGM(value)
            setStopBGMData(value)
        elseif value.type == GE.StoryScriptType.KeepBGM then
            setKeepBGMData(key, tablex.size(self.storyData))
        elseif value.type == GE.StoryScriptType.ChangeBackGround then
            checkAddBackGround(value.title)
        end
        --和谐文字处理
        if GV.IsCensoredMode then
            if value.titleCensored then
                value.title = value.titleCensored
            end
            if value.contentCensored then
                value.content = value.contentCensored
            end
        end
    end

    local totalSettingNum = tablex.size(settingData)
    if totalSettingNum == 0 then
        self:_PlayStory()
        return
    end
    for k, v in pairs(settingData) do
        if v.type == GE.InitAvgScriptType.CreateSpine then
            local storyResConfig = Config.GetStoryResourceInfo(v.resId)
            if not storyResConfig then
                UICommonUtils.PopToast("StoryResource表中未找到资源！")
                return
            end
            local resPath = ""
            if storyResConfig.camp == GE.StoryResourceCamp.Role then
                resPath = Config.PrefabPath.RoleSpine
            elseif storyResConfig.camp == GE.StoryResourceCamp.Enemy then
                resPath = Config.PrefabPath.RoleSpine
            elseif storyResConfig.camp == GE.StoryResourceCamp.NPC then
                resPath = Config.PrefabPath.RoleSpine
            end
            local prefabPath = string.format(resPath, storyResConfig.name, storyResConfig.name)
            self:LoadInstantiatePrefab(prefabPath, function (obj)
                local spineObject = obj
                spineObject:SetParent(self.roleSpineRoot.transform)
                self.spineList[v.resId] = spineObject

                --剧情关闭spine物理效果
                local objSpine = spineObject:GetComponent("SkeletonGraphic")
                objSpine.PhysicsPositionInheritanceFactor = Vector2.zero

                self.nowSettingNum = self.nowSettingNum + 1
                self:_CheckSettingDataComplete(totalSettingNum)
            end)
        elseif v.type == GE.InitAvgScriptType.CreateHeadSpine then
            local storyResConfig = Config.GetStoryResourceInfo(v.resId)
            if not storyResConfig then
                UICommonUtils.PopToast("StoryResource表中未找到资源！")
                return
            end
            local resPath = ""
            if storyResConfig.camp == GE.StoryResourceCamp.Role then
                resPath = Config.PrefabPath.RoleSpine
            elseif storyResConfig.camp == GE.StoryResourceCamp.Enemy then
                resPath = Config.PrefabPath.RoleSpine
            elseif storyResConfig.camp == GE.StoryResourceCamp.NPC then
                resPath = Config.PrefabPath.RoleSpine
            end
            local prefabPath = string.format(resPath, storyResConfig.name, storyResConfig.name)
            self:LoadInstantiatePrefab(prefabPath, function (obj)
                local spineObject = obj
                spineObject:SetParent(self.haedSpineRoot.transform)
                self.headSpineList[v.resId] = spineObject

                --剧情关闭spine物理效果
                local objSpine = spineObject:GetComponent("SkeletonGraphic")
                objSpine.PhysicsPositionInheritanceFactor = Vector2.zero

                self.nowSettingNum = self.nowSettingNum + 1
                self:_CheckSettingDataComplete(totalSettingNum)
            end)
        elseif v.type == GE.InitAvgScriptType.CreateEffect then
            local prefabPath = string.format(Config.PrefabPath.StoryEffect, k)
            self:LoadInstantiatePrefab(prefabPath, function (obj)
                local effectObject = obj
                effectObject:SetParent(self.effectRoot.transform)
                effectObject:SetActive(false)
                self.effectList[k] = effectObject

                self.nowSettingNum = self.nowSettingNum + 1
                self:_CheckSettingDataComplete(totalSettingNum)
            end)
        elseif v.type == GE.InitAvgScriptType.CreateCGSpine then
            local prefabPath = string.format(Config.PrefabPath.SceneSpine, k, k)
            self:LoadInstantiatePrefab(prefabPath, function (obj)
                local spineObject = obj
                spineObject:SetParent(self.cGSpineRoot.transform)
                self.cgSpineList[k] = spineObject

                --剧情关闭spine物理效果
                local objSpine = spineObject:GetComponent("SkeletonGraphic")
                objSpine.PhysicsPositionInheritanceFactor = Vector2.zero

                self.nowSettingNum = self.nowSettingNum + 1
                self:_CheckSettingDataComplete(totalSettingNum)
            end)
        elseif v.type == GE.InitAvgScriptType.CreateBackGround then
            local backgroundName = k
            local BgPathPattern = Config.SpritePath.AVGScene
            local BackGroundPath = string.format(BgPathPattern, backgroundName, backgroundName)
            self:LoadSpriteAsync(BackGroundPath, function(sprite)
                self.backGroundList[backgroundName] = sprite

                self.nowSettingNum = self.nowSettingNum + 1
                self:_CheckSettingDataComplete(totalSettingNum)
            end)
        elseif v.type == GE.InitAvgScriptType.CreateBGM then
            local BGMName = k
            local BGMPath = Config.AudioPath.BGM
            local BGMSource = v.source
            if BGMSource then
                self.nowSettingNum = self.nowSettingNum + 1
                self:_CheckSettingDataComplete(totalSettingNum)
            else
                local musicPath = string.format(BGMPath, BGMName)
                AudioMgr:preloadAudio(musicPath, LuaMain.gameObject, function ()
                    self.nowSettingNum = self.nowSettingNum + 1
                    self:_CheckSettingDataComplete(totalSettingNum)
                end)
            end
        end
    end
end

--判断预加载是否完成，完成则开始播放
function StoryPanel:_CheckSettingDataComplete(totalSettingNum)
    if self.nowSettingNum == totalSettingNum then
        if self.needStopOutsideBGM then
            AudioMgr:StopCurrBgm(0.5)
        end
        if self.openFinishFunc then
            self.openFinishFunc()
        end
        DLuaTimer:DoAfter(0.5, function()
            self.storyCurtain.image.raycastTarget = false
            self.storyBtnGroup.canvasGroup.alpha = 1
            self.storyBtnGroup.canvasGroup.interactable = true
            self:_PlayStory()
        end)
    end
end

---@class StoryLogData
---@field title string 标题
---@field content string 内容

--播放剧情
function StoryPanel:_PlayStory()
    local storyScript = self.storyData
    local nowNode = storyScript[self.sprictIndex]
    if not nowNode then
        --剧情退出埋点(播放完成)
        self:recordStoryLog(71, 0)
        ----------------------
        self:_EndStory()
        return
    end

    --self:recordStoryLog(70, 1)

    --关闭幕布
    if self:_CloseCurtain() then
        return
    end

    --LuaLogger.ds("!!!!!!^^^^^!!!!!!", tablex.dump(nowNode))
    if nowNode.type == GE.StoryScriptType.DoTalk or nowNode.type == GE.StoryScriptType.DoSilent
        or nowNode.type == GE.StoryScriptType.DoNotMoveTalk then
        self.isSilent = nowNode.type == GE.StoryScriptType.DoSilent
        self.notMove = nowNode.type == GE.StoryScriptType.DoNotMoveTalk
        local standardTime = self.storyCharacter.canvasGroup.alpha == 0 and 0.2 or 0
        self.storyCharacter.canvasGroup:DOFade(1, standardTime / 4)
        self.storyUIGroup.canvasGroup:DOFade(1, standardTime):SetEase(DG.Tweening.Ease.OutQuart)
        self:_DoTalk(nowNode)
        table.insert(self.dialogueLogList, {
            title = nowNode.title,
            content = nowNode.content,
            voice = nowNode.voice,
        })
    elseif nowNode.type == GE.StoryScriptType.ShowChoice then
        self:_DoChoice()
    elseif nowNode.type == GE.StoryScriptType.EndChoice then
        self:_DoEndChoice(nowNode)
    elseif nowNode.type == GE.StoryScriptType.ChangeBackGround then
        self.nowBackground = nowNode.title
        self.nowBackgroundID = self.sprictIndex
        self.storyBg:SetActive(true)
        self:_DoChangeBackGround(nowNode)
    elseif nowNode.type == GE.StoryScriptType.ChangeBGM then
        self.nowBGM = nowNode.title
        self.nowBGMID = self.sprictIndex
        self:_DoPlayMusic(nowNode)
    elseif nowNode.type == GE.StoryScriptType.ScreenShake then
        self:_DoScreenShake(nowNode)
    elseif nowNode.type == GE.StoryScriptType.ShowPicture then
        self:_DoShowPicture(nowNode)
    elseif nowNode.type == GE.StoryScriptType.HidePicture then
        self:_DoHidePicture()
    elseif nowNode.type == GE.StoryScriptType.DoNarration then
        local standardTime = self.storyCharacter.canvasGroup.alpha == 0 and 0.2 or 0
        self.storyUIGroup.canvasGroup:DOFade(1, standardTime):SetEase(DG.Tweening.Ease.OutQuart)
        self:_DoNarration(nowNode)
        table.insert(self.dialogueLogList, {
            title = "",
            content = nowNode.content,
        })
    elseif nowNode.type == GE.StoryScriptType.ShowEffect then
        self:_DoShowEffect(nowNode)
    elseif nowNode.type == GE.StoryScriptType.RemoveEffect then
        self:_DoRemoveEffect(nowNode)
    elseif nowNode.type == GE.StoryScriptType.RoleMove then
        self:_DoRoleMove(nowNode)
    elseif nowNode.type == GE.StoryScriptType.DoTelephony then
        local standardTime = self.storyCharacter.canvasGroup.alpha == 0 and 0.2 or 0
        self.storyUIGroup.canvasGroup:DOFade(1, standardTime):SetEase(DG.Tweening.Ease.OutQuart)
        self:_DoTelephony(nowNode)
        table.insert(self.dialogueLogList, {
            title = nowNode.title,
            content = nowNode.content,
            voice = nowNode.voice,
        })
    elseif nowNode.type == GE.StoryScriptType.DoWait then
        self:_DoWait(nowNode)
    elseif nowNode.type == GE.StoryScriptType.DoCurtain then
        self:_DoCurtain(nowNode)
    elseif nowNode.type == GE.StoryScriptType.SoundEffect then
        self:_DoSoundEffect(nowNode)
    elseif nowNode.type == GE.StoryScriptType.DoPauseBGM then
        self:_DoPauseBGM(nowNode)
    elseif nowNode.type == GE.StoryScriptType.DoResumBGM then
        self:_DoResumBGM(nowNode)
    elseif nowNode.type == GE.StoryScriptType.ComeOnStage then
        self:_DoComeOnStage(nowNode)
    elseif nowNode.type == GE.StoryScriptType.ScreenFlicker then
        self:_DoScreenFlicker(nowNode)
    elseif nowNode.type == GE.StoryScriptType.RoleClear then
        self:_DoRoleClear()
    elseif nowNode.type == GE.StoryScriptType.ShowCG then
        self:_DoShowCG(nowNode)
    elseif nowNode.type == GE.StoryScriptType.HideCG then
        self:_DoHideCG(nowNode)
    elseif nowNode.type == GE.StoryScriptType.CGAction then
        self:_DoCGAction(nowNode)
    elseif nowNode.type == GE.StoryScriptType.HideUI then
        self:_DoHideUI(nowNode)
    elseif nowNode.type == GE.StoryScriptType.RoleSlot then
        self:_DoRoleSlot(nowNode)
    elseif nowNode.type == GE.StoryScriptType.BackGroundAction then
        self:_DoBackGroundAction(nowNode)
    elseif nowNode.type == GE.StoryScriptType.KeepBGM then
        self:_DoKeepBGM()
    end

end

function StoryPanel:_DoChangeBackGround(nowNode)
    local changeType = nowNode.left or 1
    local needCharacter = nowNode.center and true or false
    local standardTime = changeType == 4 and 0 or 0.2
    local fadeTime = nowNode.showCharacter and tonumber(nowNode.showCharacter) or 1
    self.doNextBtn.button.interactable = false
    if not needCharacter then
        self.storyCharacter.canvasGroup:DOFade(0, standardTime / 4)
    end
    self.storyUIGroup.canvasGroup:DOFade(0, standardTime):OnComplete(function()
        local backgroundName = nowNode.title
        local nowBackgroundObj = self["background"..self.ueseBackgroundNum]
        nowBackgroundObj.image.sprite = self.backGroundList[backgroundName]
        nowBackgroundObj.image:SetNativeSize()
        self.ueseBackgroundNum = self.ueseBackgroundNum + 1
        if self.ueseBackgroundNum == 3 then
            self.ueseBackgroundNum = 1
        end
        local lastBackgroundObj = self["background"..self.ueseBackgroundNum]
        lastBackgroundObj.transform:SetSiblingIndex(0)
        nowBackgroundObj.transform:SetSiblingIndex(1)
        --设置当前背景所需位置大小
        local initPosScale = nowNode.content and loadstring("return " .. nowNode.content)() or {0, 0, 1}--x,y,scale
        nowBackgroundObj.rectTransform.anchoredPosition = Vector2.New(initPosScale[1], initPosScale[2])
        nowBackgroundObj.rectTransform.localScale = Vector3.New(initPosScale[3], initPosScale[3], 1)

        if changeType == 1 or changeType == 4 then--普通切换或快速切换
            lastBackgroundObj.image:DOFade(0, fadeTime)
            nowBackgroundObj.image:DOFade(1, fadeTime)
        elseif changeType == 2 or changeType == 3 then--左右切换
            local movetoRight = changeType == 2
            local movePosX = self:_CalculateBackgroundMovePosition(lastBackgroundObj, nowBackgroundObj, movetoRight)
            local nowRect = nowBackgroundObj.rectTransform
            nowRect.anchoredPosition = Vector2.New(nowRect.anchoredPosition.x + movePosX, nowRect.anchoredPosition.y)
            nowBackgroundObj.image:DOFade(1, 0)
            nowRect:DOAnchorPosX(initPosScale[1], fadeTime):SetEase(DG.Tweening.Ease.OutCubic)
            lastBackgroundObj.rectTransform:DOAnchorPosX(-movePosX, fadeTime):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
                lastBackgroundObj.image:DOFade(0, 0)
            end)
        end
    end)
    self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(fadeTime + standardTime, function()
        --重置上一张背景位置大小
        self["background"..self.ueseBackgroundNum].rectTransform.anchoredPosition = Vector2.zero
        self["background"..self.ueseBackgroundNum].rectTransform.localScale = Vector3.one

        self.doNextBtn.button.interactable = true
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
    end)
    --如果有背景则在首次背景加载完成后关闭幕布
    if self.needLoadingMask then
        self.storyCurtain.canvasGroup:DOFade(0, 0.5):SetEase(DG.Tweening.Ease.OutCubic)
        self.needLoadingMask = false
    end
end

--根据位置偏移与缩放计算背景所需移动位置
function StoryPanel:_CalculateBackgroundMovePosition(lastBackgroundObj, nowBackgroundObj, moveToRight)
    local lastPosX = lastBackgroundObj.rectTransform.anchoredPosition.x
    local lastScale = lastBackgroundObj.rectTransform.localScale
    local lastWidth = lastBackgroundObj.rectTransform.sizeDelta.x * lastScale.x
    local nowPosX = nowBackgroundObj.rectTransform.anchoredPosition.x
    local nowScale = nowBackgroundObj.rectTransform.localScale
    local nowWidth = nowBackgroundObj.rectTransform.sizeDelta.x * nowScale.x

    local moveX = 0
    if moveToRight then
        moveX = (lastPosX - nowPosX) + (lastWidth + nowWidth) / 2
    else
        moveX = (lastPosX - nowPosX) - (lastWidth + nowWidth) / 2
    end
    return moveX
end

function StoryPanel:_DoPlayMusic(nowNode, notNext)
    local fadeTime = nowNode.showCharacter and tonumber(nowNode.showCharacter)
    local BGMName = nowNode.title
    local BGMPath = Config.AudioPath.BGM
    local BGMSource = nowNode.left
    if BGMSource == 1 then
        BGMPath = Config.AudioPath.StorySE
    elseif BGMSource == 2 then
        BGMPath = Config.AudioPath.SE
    end
    if BGMName then--有配置名称则为播放bgm
        local musicPath = string.format(BGMPath, BGMName)
        if fadeTime then
            self:LuaPlayBgmFade(musicPath, true, nil, fadeTime)
        else
            self:LuaPlayBgm(musicPath, true, nil)
        end
    else--否则为停止当前bgm
        if fadeTime then
            AudioMgr:StopCurrBgm(fadeTime)
        else
            AudioMgr:StopCurrBgm(0)
        end
    end

    if notNext then
        return
    end
    self.sprictIndex = self.sprictIndex + 1
    self:_PlayStory()
end

--显示画中画
function StoryPanel:_DoShowPicture(nowNode)
    local picturePath = Config.SpritePath.AVGPicture
    self.doNextBtn.button.interactable = false
    self.pictureFadeTime = nowNode.showCharacter or 0.5
    local iconPath = string.format(picturePath, nowNode.title)
    self:LoadSpriteAsync(iconPath, function(sprite)
        self.storyItem.image.sprite = sprite
        self.storyItem.image:SetNativeSize()
        self.storyItem.canvasGroup:DOFade(1, self.pictureFadeTime)

        self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(self.pictureFadeTime, function()
            self.doNextBtn.button.interactable = true
            self.sprictIndex = self.sprictIndex + 1
            self:_PlayStory()
        end)
    end)
end

--隐藏画中画
function StoryPanel:_DoHidePicture()
    self.doNextBtn.button.interactable = false
    self.storyItem.canvasGroup:DOFade(0, self.pictureFadeTime)
    self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(self.pictureFadeTime, function()
        self.doNextBtn.button.interactable = true
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
    end)
end

function StoryPanel:_DoTalk(data)
    if self.isNarrationMode == true then
        self.isNarrationMode = false
        self.storyCharacter.canvasGroup:DOFade(1, 0)
        self.storyWords:SetActive(true)
        self.storyNarration:SetActive(false)
        for _, narrationBox in pairs(self.narrationObjList) do
            narrationBox.narrationTxt.text.uneditedText = ""
        end
    end
    if self.isTelephonyMode then
        self.isTelephonyMode = false
        self.storyWords:SetActive(true)
        self.messageWords:SetActive(false)
        if UICommonUtils.Checkobj(self.nowTelephonySpine) then
            self.nowTelephonySpine:SetParent(self.haedSpineRoot.transform)
        end
    end

    --对话文字处理
    if not data.content or data.content == "" then
        self.wordsText.text.uneditedText = ""
        self.isNext = true
        self.text_tweener = nil
    else
        local charName = data.title
        self.nameText:SetActive(charName and true or false)
        self.cutOffLine:SetActive(charName and true or false)
        local delayTime = self:_GetTextPlayTime(data.content)
        self.nameText.text.text = self:_SetStoryRichText(self.nameText, charName)

        data.content = self:_SetStoryRichText(self.wordsText, data.content)
        self.charWord = data.content

        self.doNextIcon:SetActive(false)
        self:_DoShowText(self.wordsText, data, delayTime)
    end

    self:_RemoveStopTalkTimer()
    self:_ShowCharacterSpine(data)
end

--文字显示
function StoryPanel:_DoShowText(textObj, nowNode, delayTime)
    local textType = nowNode.type
    local words = nowNode.content
    self.isNext = false
    --暂停标记处理
    words = self:_CheckPauseInDoText(words)
    --确认动作切换
    words = self:_CheckActionInDoText(words)

    self.text_tweener = textObj.text:DoTextMesh(words, delayTime,
    function()
        self.isNext = true
        if self.autoPlay then
            self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(delayTime + 1, function()
                if self.autoPlay then
                    self.sprictIndex = self.sprictIndex + 1
                    self:_PlayStory()
                end
            end)
        end
        self.text_tweener = nil
        if textType == GE.StoryScriptType.DoTalk or textType == GE.StoryScriptType.DoSilent then
            self.doNextIcon:SetActive(true)
        elseif textType == GE.StoryScriptType.DoNarration then
            self.nowNarrationIndex = self.nowNarrationIndex + 1
        elseif textType == GE.StoryScriptType.DoTelephony then
            self.doNextMessageIcon:SetActive(true)
        end
        self.pauseTime = 0
        self.pauseList = {}
        self.changeActionList = {}
        --剧情内容埋点(自然完成)
        self:recordStoryLog(70, GE.StoryContentFinishType.NormalClick)
        ----------------------
    end):OnUpdate(function()
        local visibleCharacters = textObj.text.maxVisibleCharacters
        --文字暂停
        if next(self.pauseList) then
            for i = #self.pauseList, 1, -1 do
                if visibleCharacters >= self.pauseList[i].visibleCount then
                    self.pauseTime = self.pauseList[i].time
                    self.text_tweener:Pause()
                    table.remove(self.pauseList, i)
                end
            end
        end
        --修改动作
        if next(self.changeActionList) then
            for key, data in pairs(self.changeActionList) do
                if visibleCharacters >= data.visibleCount and not data.isChanged then
                    data.isChanged = true
                    self:_ChangeActionInDoText(data.action)
                end
            end
        end
    end):OnPause(function()
        for name, spineObj in pairs(self.spineList) do
            local objSpineAnim = spineObj:GetComponent("SkeletonAnimation")
            if objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote) then
                objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote).TimeScale = 0
            end
        end
        if next(self.stopTalkActionTimerList) then
            for name, timer in pairs(self.stopTalkActionTimerList) do
                timer:SetPause(true)
            end
        end
        self.doNextBtn.image.raycastTarget = false
        self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(self.pauseTime, function()
            if not self.text_tweener then
                self.doNextBtn.image.raycastTarget = true
                return
            end
            self.text_tweener:Play()
            for name, spineObj in pairs(self.spineList) do
                local objSpineAnim = spineObj:GetComponent("SkeletonAnimation")
                if objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote) then
                    objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote).TimeScale = 1
                end
            end
            if next(self.stopTalkActionTimerList) then
                for name, timer in pairs(self.stopTalkActionTimerList) do
                    timer:SetPause(false)
                end
            end
            self.doNextBtn.image.raycastTarget = true
        end)
    end)

    --语音
    if nowNode.voice then
        if self.nowVoiceKeyList then
            for _, key in pairs(self.nowVoiceKeyList) do
                AudioMgr:stopVoice(key)
            end
            self.nowVoiceKeyList = nil
        end
        self.nowVoiceKeyList = {}
        for idStr in string.gmatch(tostring(nowNode.voice), "[^-]+") do
            local voiceId = tonumber(idStr)
            if voiceId then
                local nowLineConfig = Config.GetScriptLinesInfo(voiceId)
                if nowLineConfig and nowLineConfig.resource then
                    local key = UICommonUtils.Play2DVoiceByLanguage(nowLineConfig.CharacterID, nowLineConfig.resource, nil, self.gameObject)
                    if key then
                        table.insert(self.nowVoiceKeyList, key)
                    end
                end
            end
        end
    end
end

function StoryPanel:_CountVisibleCharacters(words)
    if not words or words == "" then
        return 0
    end

    local visibleCount = 0
    local inRichTextTag = false
    for _, code in utf8util.codes(words) do
        if code == string.byte("<") then
            inRichTextTag = true
        elseif code == string.byte(">") and inRichTextTag then
            inRichTextTag = false
        elseif not inRichTextTag then
            visibleCount = visibleCount + 1
        end
    end

    return visibleCount
end

function StoryPanel:_GetTypewriterVisibleCount(words, endPos)
    if not endPos or endPos <= 0 then
        return 0
    end

    local checkText = string.sub(words, 1, endPos)
    for _, needPattern in pairs(GE.StoryTextRegex) do
        checkText = string.gsub(checkText, needPattern, "")
    end

    return self:_CountVisibleCharacters(checkText)
end

--检测文本配置中文字停顿
function StoryPanel:_CheckPauseInDoText(words)
    self.pauseList = {}
    local pos = 1
    local pausePattern = GE.StoryTextRegex.Pause
    for i = 1, #words do
        local startPos, endPos = string.find(words, pausePattern, pos)
        if not startPos then break end

        -- 取出匹配的子串
        local matchedStr = string.sub(words, startPos, endPos)
        -- 提取配置部分
        local pauseTime = string.match(matchedStr, pausePattern)

        table.insert(self.pauseList, {
            visibleCount = self:_GetTypewriterVisibleCount(words, startPos - 1),
            time = tonumber(pauseTime),
        })
        -- 更新起始搜索位置
        pos = endPos + 1
    end
    words = string.gsub(words, pausePattern, "")
    return words
end

--检测文本配置中人物动作和表情修改
function StoryPanel:_CheckActionInDoText(words)
    self.changeActionList = {}
    local pos = 1
    local actionPattern = GE.StoryTextRegex.Action
    for i = 1, #words do
        local startPos, endPos = string.find(words, actionPattern, pos)
        if not startPos then break end

        -- 取出匹配的子串
        local matchedStr = string.sub(words, startPos, endPos)
        -- 提取配置部分
        local actionGroup = string.match(matchedStr, actionPattern)

        table.insert(self.changeActionList, {
            visibleCount = self:_GetTypewriterVisibleCount(words, startPos - 1),
            action = actionGroup,
            isChanged = false,
        })
        -- 更新起始搜索位置
        pos = endPos + 1
    end
    words = string.gsub(words, actionPattern, "")
    return words
end

--根据文本配置修改人物动作和表情
function StoryPanel:_ChangeActionInDoText(actionGroup)
    local actionGroupList = {}
    string.gsub(actionGroup,'[^'.."-"..']+',function ( w )
        table.insert(actionGroupList, w)
    end)
    for _, groupId in pairs(actionGroupList) do
        local actionConfigList = Config.GetActionInfoByGroup(groupId)
        if actionConfigList then
            local nowRoleObj = self.spineList[actionConfigList[1].character]
            local ggParentName = nowRoleObj.transform.parent.transform.parent.transform.parent.name
            local isShow = ggParentName == self.canvasShow.name
            self:_SetCharacterSpine(nowRoleObj, isShow, actionConfigList, true)
        end
    end
end

function StoryPanel:_ShowCharacterSpine(data)
    local showCharacter = data.showCharacter or ""
    local leftSpineName = data.left
    local centerSpineName = data.center
    local rightSpineName = data.right

    --处理动作表情配置
    local leftAction = {}
    local centerAction = {}
    local rightAction = {}
    local actionGroupList = {}
    local actionGroup = data.action or ""
    string.gsub(actionGroup,'[^'.."-"..']+',function ( w )
        table.insert(actionGroupList, w)
    end)
    for _, groupId in pairs(actionGroupList) do
        local actionConfigList = Config.GetActionInfoByGroup(groupId)
        if actionConfigList[1].character == data.left then
            leftAction = actionConfigList
        end
        if actionConfigList[1].character == data.center then
            centerAction = actionConfigList
        end
        if actionConfigList[1].character == data.right then
            rightAction = actionConfigList
        end
    end

    --根据配置处理角色偏移和缩放
    self:_SetRoleResOffset(leftSpineName, centerSpineName, rightSpineName)

    --左
    if leftSpineName then
        self.nowLeftObj = self.spineList[leftSpineName]
        local isShow = string.find(showCharacter, leftSpineName)
        self:_RoleChangePlace(self.nowLeftObj, self.characterLeft)
        self:_SetCharacterSpine(self.nowLeftObj, isShow, leftAction)
        self:_SetSpineIsShow(self.leftOffset, isShow)
    else
        self.nowLeftObj = nil
    end

    --右
    if rightSpineName then
        self.nowRightObj = self.spineList[rightSpineName]
        local isShow = string.find(showCharacter, rightSpineName)
        self:_RoleChangePlace(self.nowRightObj, self.characterRight)
        self:_SetCharacterSpine(self.nowRightObj, isShow, rightAction)
        self:_SetSpineIsShow(self.rightOffset, isShow)
    else
        self.nowRightObj = nil
    end

    --中
    if centerSpineName then
        self.nowCenterObj = self.spineList[centerSpineName]
        local isShow = string.find(showCharacter, centerSpineName)
        self:_RoleChangePlace(self.nowCenterObj, self.characterMiddle)
        self:_SetCharacterSpine(self.nowCenterObj, isShow, centerAction)
        self:_SetSpineIsShow(self.middleOffset, isShow)
    else
        self.nowCenterObj = nil
    end

    --spine回收
    for name, spineObj in pairs(self.spineList) do
        if name ~= leftSpineName and name ~= rightSpineName and name ~= centerSpineName then
            spineObj:SetParent(self.roleSpineRoot.transform)
        end
    end

    --根据缩放设置角色的层级关系
    self:_SetRoleSiblingIndexByScale()
end

--角色在场时换位表现为移动
function StoryPanel:_RoleChangePlace(nowObj, newParentObj)
    if nowObj.transform.parent.gameObject.name == newParentObj.name then
        self:_SetRoleDefaultLocation()
        return
    end
    if nowObj.transform.parent.gameObject.name ~= self.roleSpineRoot.name then
        self.doNextBtn.button.interactable = false
        local nowPos = nowObj.transform.parent.transform.position
        nowObj:SetParent(newParentObj.transform)
        nowObj.transform.position = nowPos
        local objRect = nowObj:GetComponent("RectTransform")
        objRect:DOAnchorPos(Vector2.zero, 0.5):OnComplete(function()
            self.doNextBtn.button.interactable = true
            self:_SetRoleDefaultLocation()
        end)
    else
        self:_SetRoleDefaultLocation()
        nowObj:SetParent(newParentObj.transform)
    end
end

--人物距离根据出场人数变化
function StoryPanel:_SetRoleDefaultLocation()
    local nowNode = self.storyData[self.sprictIndex]
    local leftSpineName = nowNode.left
    local centerSpineName = nowNode.center
    local rightSpineName = nowNode.right

    local moveTime = 0.5
    local leftCharPos = self.characterLeft.transform.localPosition
    local rightCharPos = self.characterRight.transform.localPosition
    if centerSpineName and (leftSpineName or rightSpineName) then
        if self.characterLeft.rectTransform.anchoredPosition.x + 450 == 0 then
            if self.notMove then
                self.notMove = false
                self.characterLeft.rectTransform.anchoredPosition = Vector2.New(-650, leftCharPos.y)
                self.characterRight.rectTransform.anchoredPosition = Vector2.New(650, leftCharPos.y)
                return
            end
            self.doNextBtn.button.interactable = false
            self.characterLeft.rectTransform:DOAnchorPos(Vector2.New(-650, leftCharPos.y), moveTime)
            self.characterRight.rectTransform:DOAnchorPos(Vector2.New(650, leftCharPos.y), moveTime):OnComplete(function()
                self.doNextBtn.button.interactable = true
            end)
        end
    else
        if self.characterLeft.rectTransform.anchoredPosition.x + 650 == 0 then
            if self.notMove then
                self.notMove = false
                self.characterLeft.rectTransform.anchoredPosition = Vector2.New(-450, leftCharPos.y)
                self.characterRight.rectTransform.anchoredPosition = Vector2.New(450, leftCharPos.y)
                return
            end
            self.doNextBtn.button.interactable = false
            self.characterLeft.rectTransform:DOAnchorPos(Vector2.New(-450, leftCharPos.y), moveTime)
            self.characterRight.rectTransform:DOAnchorPos(Vector2.New(450, leftCharPos.y), moveTime):OnComplete(function()
                self.doNextBtn.button.interactable = true
            end)
        end
    end
end

function StoryPanel:_SetCharacterSpine(nowObj, isShow, actionList, dontStopTalk)
    --表情动作双轨道
    if not UICommonUtils.Checkobj(nowObj) then
        return
    end
    
    local spineAnimation = nowObj:GetComponent("SetSpineAnimation")
    local objSpine = nowObj:GetComponent("SkeletonGraphic")
    local objSpineAnim = nowObj:GetComponent("SkeletonAnimation")

    --首先分出表情与动作
    local poseList = {}
    local emoteList = {}
    for _, actionConfig in pairs(actionList) do
        if actionConfig.basicType == GE.RoleSpineActionType.Emote then
            table.insert(emoteList, actionConfig)
        elseif actionConfig.basicType == GE.RoleSpineActionType.Action then
            --先将需要拼接的动作拆分放入列表
            local nameBreakList = {}
            local lastEndName = ""
            local newBeginName = ""
            string.gsub(actionConfig.resource,'[^'.."_"..']+',function ( w )
                table.insert(nameBreakList, w)
            end)
            if #nameBreakList > 1 then
                newBeginName = nameBreakList[1].."_begin"
            end

            local lastNameBreak = {}
            local currentActionTrack = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Action)
            local currentAnimName = (currentActionTrack ~= nil and currentActionTrack.Animation ~= nil) and currentActionTrack.Animation.Name or ""
            string.gsub(currentAnimName,'[^'.."_"..']+',function ( w )
                table.insert(lastNameBreak, w)
            end)
            if #lastNameBreak > 1 then
                lastEndName = lastNameBreak[1].."_end"
            end

            local newActConfig = {
                basicType = GE.RoleSpineActionType.Action,
                actType = 2,
            }

            --相同动作则不做修改
            local isLoop = actionConfig.actType == 1
            if (self[nowObj.name .. "PoseNow"] == actionConfig.resource and not isLoop)
             or (self[nowObj.name .. "PoseNow"] ~= actionConfig.resource) then
                if lastEndName ~= "" and spineAnimation:CheckAnimationExist(lastEndName) then
                    newActConfig.resource = lastEndName
                    table.insert(poseList, clone(newActConfig))
                end

                if newBeginName ~= "" and spineAnimation:CheckAnimationExist(newBeginName) then
                    newActConfig.resource = newBeginName
                    table.insert(poseList, clone(newActConfig))
                end

                table.insert(poseList, actionConfig)
            end
        end
    end

    --动作轨道
    for k, poseConfig in pairs(poseList) do
        local setTrack = poseConfig.basicType
        local poseName = poseConfig.resource
        local isLoop = poseConfig.actType == 1

        if k == 1 then
            objSpineAnim.AnimationState:SetAnimation(setTrack, poseName, isLoop)
        else
            local defaultTime = objSpine.Skeleton.Data:FindAnimation(self[nowObj.name .. "PoseNow"]).Duration
            objSpineAnim.AnimationState:AddAnimation(setTrack, poseName, isLoop, defaultTime)
        end

        self[nowObj.name .. "PoseNow"] = poseName
    end

    --无配置表情但处于显示状态角色延续上一个表情
    if isShow and (not next(emoteList)) and (not self.isSilent) then
        local needActionName = ""
        if string.find(self[nowObj.name .. "EmoteNow"], "talk") then
            needActionName = self[nowObj.name .. "EmoteNow"]
        else
            needActionName = self[nowObj.name .. "EmoteNow"].."_talk"
        end
        table.insert(emoteList, {
            basicType = GE.RoleSpineActionType.Emote,
            resource = needActionName,
            actType = 1,
        })
    elseif self[nowObj.name .. "EmoteNow"] then
        local idleEmote = string.gsub(self[nowObj.name .. "EmoteNow"], "_talk", "")
        objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, idleEmote, true)
    end

    --表情轨道
    for k, emoteConfig in pairs(emoteList) do
        local setTrack = emoteConfig.basicType
        local emoteName = emoteConfig.resource
        local isLoop = emoteConfig.actType == 1

        --如果不是突出显示的角色则过滤说话表情，将其改为无嘴型表情
        if (not isShow) or self.isSilent then
            local nameBreakList = {}
            string.gsub(emoteName,'[^'.."_"..']+',function ( w )
                table.insert(nameBreakList, w)
            end)
            if #nameBreakList > 1 then
                emoteName = nameBreakList[1]
            end
        end

        if k == 1 then
            objSpineAnim.AnimationState:SetAnimation(setTrack, emoteName, isLoop)
        else
            local defaultTime = objSpine.Skeleton.Data:FindAnimation(self[nowObj.name .. "EmoteNow"]).Duration
            objSpineAnim.AnimationState:AddAnimation(setTrack, emoteName, true, defaultTime)
        end

        self[nowObj.name .. "EmoteNow"] = emoteName
    end

    --TODO需要与ShowRoleSpinePanel正式版逻辑相同
    if next(emoteList) and not dontStopTalk then
        local runningTime = self:_GetTextPlayTime(self.charWord, 0.1)
        self.stopTalkActionTimerList[nowObj.name] = DLuaTimer:DoAfter(runningTime, function()
            if not objSpineAnim then
                return
            end
            local emoteTrack = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote)
            local nowEmoteName = (emoteTrack ~= nil and emoteTrack.Animation ~= nil) and emoteTrack.Animation.Name or ""
            if nowEmoteName == "" then return end
            local nameBreakList = {}
            local newEomteName = ""
            string.gsub(nowEmoteName,'[^'.."_"..']+',function ( w )
                table.insert(nameBreakList, w)
            end)
            if #nameBreakList > 1 then
                newEomteName = nameBreakList[1]
            end
            if newEomteName ~= "" and nowEmoteName ~= newEomteName and spineAnimation:CheckAnimationExist(newEomteName) then
                objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, newEomteName, true)
            end
        end)
        self.stopTalkCallbackList[nowObj.name] = function()
            local nowEmoteName = self[nowObj.name .. "EmoteNow"]
            local nameBreakList = {}
            local newEomteName = ""
            string.gsub(nowEmoteName,'[^'.."_"..']+',function ( w )
                table.insert(nameBreakList, w)
            end)
            if #nameBreakList > 1 then
                newEomteName = nameBreakList[1]
            end
            if newEomteName ~= "" and nowEmoteName ~= newEomteName and spineAnimation:CheckAnimationExist(newEomteName) then
                objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, newEomteName, true)
            end
        end
    end
end

--设置对话角色正常或灰态
function StoryPanel:_SetSpineIsShow(offsetObj, isShow)
    if isShow then
        offsetObj.transform:SetParent(self.canvasShow, false)
    else
        offsetObj.transform:SetParent(self.canvasHide, false)
    end
end

--对话选项
function StoryPanel:_DoChoice()
    self.isNext = false
    local storyScript = self.storyData
    local endChoiceId = 0
    for i = self.sprictIndex, #storyScript do
        if storyScript[i].type == GE.StoryScriptType.EndChoice then
            endChoiceId = tonumber(storyScript[i].showCharacter)
            break
        end
    end
    local choiceData = {}
    for i = self.sprictIndex, endChoiceId do
        if storyScript[i].type == GE.StoryScriptType.ShowChoice then
            table.insert(choiceData, storyScript[i])
        end
    end
    self.selectWords:SetActive(true)
    self:FillTemplateContent(self.selectBox, self.selectWords, #choiceData, function(index, selectBox)
        local nowNode = choiceData[index]
        selectBox.selectText.text.text = self:_SetStoryRichText(selectBox.selectText, nowNode.title)

        selectBox.scaleButton.onClick:RemoveAllListeners()
        selectBox.scaleButton.onClick:AddListener(function()
            table.insert(self.dialogueLogList, {
                title = Me and Me.name or "{PlayerName}",
                content = nowNode.title,
            })

            self.sprictIndex = tonumber(nowNode.showCharacter)
            self:_PlayStory()
            self.selectWords:SetActive(false)
        end)
    end)
end

--选项内容结束
function StoryPanel:_DoEndChoice(nowNode)
    self.sprictIndex = tonumber(nowNode.showCharacter)
    self:_PlayStory()
end

--剧情镜头动作
function StoryPanel:_DoScreenShake(nowNode)
    self.doNextBtn.image.raycastTarget = false
    local amplitude = nowNode.title or 10
    local needTime = nowNode.showCharacter and tonumber(nowNode.showCharacter) or 1
    local needWait = nowNode.left and true or false

    --self.storyScreen.transform:DOShakePosition(needTime, Vector3.New(20, 5, 0), 80)
    self.storyScreen.transform:DOPunchPosition(Vector3.New(amplitude, amplitude/3, 0), needTime, 50, 1)

    if needWait then
        self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(needTime, function()
            self.doNextBtn.image.raycastTarget = true
            self.sprictIndex = self.sprictIndex + 1
            self:_PlayStory()
        end)
    else
        self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(needTime, function()
            self.doNextBtn.image.raycastTarget = true
        end)
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
    end
end

--旁白
function StoryPanel:_DoNarration(nowNode)
    local narrationShowFunc = function()
        if self.nowNarrationIndex > #self.narrationObjList then
            for _, narrationBox in pairs(self.narrationObjList) do
                narrationBox.narrationTxt.text.uneditedText = ""
            end
            self.nowNarrationIndex = 1
        end

        local isRuby = false
        local narrationBox = self.narrationObjList[self.nowNarrationIndex]
        nowNode.content, isRuby = self:_SetStoryRichText(narrationBox.narrationTxt, nowNode.content)
        local charWord = nowNode.content
        if isRuby then
            narrationBox.rectTransform.sizeDelta = Vector2.New(1300, 70)
        end
        local wardsNum = #string.gsub(charWord, "<[^>]+>", "") / 3
        local delayTime = self:_GetTextPlayTime(charWord)
        self.isNext = false
        narrationBox.narrationTxt.rectTransform.sizeDelta = Vector2.New(42 * wardsNum, 50)
        self:_DoShowText(narrationBox.narrationTxt, nowNode, delayTime)
    end

    if self.isNarrationMode == false then
        self.isNarrationMode = true
        self:_InitStoryNarration(nowNode, narrationShowFunc)
    else
        narrationShowFunc()
    end
end

--初始化旁白界面
function StoryPanel:_InitStoryNarration(nowNode, callBack)
    self.storyCharacter.canvasGroup:DOFade(0, 0)
    self.storyWords:SetActive(false)
    self.storyNarration:SetActive(true)

    local narrationScript = {}
    local storyScript = self.storyData
    for i = self.sprictIndex, #storyScript do
        if storyScript[i].type == GE.StoryScriptType.DoNarration then
            table.insert(narrationScript, storyScript[i])
        elseif storyScript[i].type == GE.StoryScriptType.DoTalk or storyScript[i].type == GE.StoryScriptType.DoWait then
            break
        end
    end
    self.nowNarrationIndex = 1
    self.narrationObjList = {}
    local needBoxNum = math.min(#narrationScript, 7)
    self:FillTemplateContent(self.narrationBox, self.narrationBoxList, needBoxNum, function(index, narrationBox)
        local alignmentType = nowNode.title and tonumber(nowNode.title) or 0
        narrationBox.narrationTxt.transform.anchorMax = Vector2.New(alignmentType, 0.5)
        narrationBox.narrationTxt.transform.anchorMin = Vector2.New(alignmentType, 0.5)
        narrationBox.narrationTxt.transform.pivot = Vector2.New(alignmentType, 0.5)
        narrationBox.narrationTxt.transform.anchoredPosition  = Vector2.zero
        self.narrationObjList[index] = narrationBox
        if index == needBoxNum and callBack then
            callBack()
        end
    end)
    local needMask = nowNode.showCharacter and false or true
    self.narrationMask:SetActive(needMask)
end

--显示特效
function StoryPanel:_DoShowEffect(nowNode)
    local effectName = nowNode.title
    local needTime = nowNode.showCharacter
    local changeLayer = nowNode.left or 0
    local effectObj = self.effectList[effectName]
    if not UICommonUtils.Checkobj(effectObj) then
        return
    end

    --修改特效层级
    if changeLayer ~= 0 then
        local obj = effectObj.transform:Find("Effect")
        for i = 1, obj.childCount do
            local ParticleSystemRenderer = obj:GetChild(i - 1).gameObject:GetComponent("ParticleSystemRenderer")
            ParticleSystemRenderer.sortingOrder = ParticleSystemRenderer.sortingOrder + changeLayer
        end
    end

    --特殊特效处理
    if effectName == "Effect_UI_MoHu" then
        local blueIntensity = nowNode.content or 3
        local setStoryUIBlur = effectObj:GetComponent("SetStoryUIBlur")
        setStoryUIBlur.blurSize = blueIntensity
    end

    if needTime then
        local standardTime = 0.2
        self.doNextBtn.button.interactable = false
        self.storyUIGroup.canvasGroup:DOFade(0, standardTime):OnComplete(function()
            self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(needTime, function()
                self.doNextBtn.button.interactable = true
                self.sprictIndex = self.sprictIndex + 1
                self:_PlayStory()
            end)
            effectObj:SetActive(true)
        end)
    else
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
        effectObj:SetActive(true)
    end
end

--移除特效
function StoryPanel:_DoRemoveEffect(nowNode)
    local effectName = nowNode.title
    local effectObj = self.effectList[effectName]
    if not UICommonUtils.Checkobj(effectObj) then
        return
    end
    local removeEffectFunc = function()
        effectObj:SetActive(false)
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
    end
    --特殊特效处理
    if effectName == "Effect_UI_DianYinXiaoGuo" then
        local animation = effectObj:GetComponent("Animation")
        animation:Play("MovieHide")
        self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(1, function()
            removeEffectFunc()
        end)
    else
        removeEffectFunc()
    end

    
end

--角色运动
function StoryPanel:_DoRoleMove(nowNode)
    self.doNextBtn.image.raycastTarget = false
    local moveType = tonumber(nowNode.title)
    local moveCharacter = tonumber(nowNode.showCharacter)
    local moveRange = tonumber(nowNode.content)
    local moveTime = tonumber(nowNode.action) or 0.2
    local roleObj = self.spineList[moveCharacter]
    local needWait = nowNode.left and true or false
    if moveType == 1 then--上下运动
        self.nowMoveTimesMap[roleObj.name] = 0
        local needTimes = tonumber(nowNode.center) or 1
        self:_RoleNodFunc(roleObj, moveRange, moveTime, needTimes)
        moveTime = moveTime * needTimes
    elseif moveType == 2 then--左右运动
        self.nowMoveTimesMap[roleObj.name] = 0
        moveTime = tonumber(nowNode.action) or 0.1
        local needTimes = tonumber(nowNode.center) or 1
        self:_RoleShakeHeadFunc(roleObj, moveRange, moveTime, needTimes)
        moveTime = moveTime * needTimes
    elseif moveType == 3 then--平移运动
        local nowPos = roleObj.transform.position
        roleObj.transform:DOMoveX(nowPos.x + moveRange, moveTime):SetEase(DG.Tweening.Ease.InOutSine)
    elseif moveType == 4 then--特写放大
        local moveX = tonumber(nowNode.center) or 0
        local moveY = tonumber(nowNode.right) or 0
        local newScale = tonumber(nowNode.content) or 1
        local nowPos = roleObj.transform.localPosition
        roleObj.transform:DOLocalMove(Vector3.New(nowPos.x + moveX, nowPos.y + moveY, 0), moveTime):SetEase(DG.Tweening.Ease.InOutSine)
        roleObj.transform:DOScale(Vector3.New(newScale, newScale, 1), moveTime):OnComplete(function()
            --根据缩放设置角色的层级关系
            self:_SetRoleSiblingIndexByScale()
        end)
    elseif moveType == 0 then--状态恢复
        --时间
        roleObj.transform:DOLocalMove(Vector3.zero, moveTime)
        roleObj.transform:DOScale(Vector3.one, moveTime)
    end

    if needWait then
        self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(moveTime, function()
            self.doNextBtn.image.raycastTarget = true
            self.sprictIndex = self.sprictIndex + 1
            self:_PlayStory()
        end)
    else
        self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(moveTime, function()
            self.doNextBtn.image.raycastTarget = true
        end)
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
    end
end

function StoryPanel:_RoleNodFunc(roleObj, moveRange, moveTime, needTimes)
    local nowPos = roleObj.transform.position
    roleObj.transform:DOPunchPosition(Vector3.New(nowPos.x, moveRange, 0), moveTime, 1, 1):OnComplete(function()
        self.nowMoveTimesMap[roleObj.name] = self.nowMoveTimesMap[roleObj.name] + 1
        if self.nowMoveTimesMap[roleObj.name] < needTimes then
            self:_RoleNodFunc(roleObj, moveRange, moveTime, needTimes)
        else
            roleObj.transform.position = nowPos
        end
    end)
end

function StoryPanel:_RoleShakeHeadFunc(roleObj, moveRange, moveTime, needTimes)
    local nowPos = roleObj.transform.localPosition
    roleObj.transform:DOLocalMove(Vector3.New(nowPos.x - moveRange, nowPos.y, 0), moveTime):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
        roleObj.transform:DOLocalMove(Vector3.New(nowPos.x + moveRange, nowPos.y, 0), moveTime * 1.5):SetEase(DG.Tweening.Ease.OutSine):OnComplete(function()
            self.nowMoveTimesMap[roleObj.name] = self.nowMoveTimesMap[roleObj.name] + 1
            if self.nowMoveTimesMap[roleObj.name] < needTimes then
                roleObj.transform:DOLocalMove(nowPos, moveTime):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
                    self:_RoleShakeHeadFunc(roleObj, moveRange, moveTime, needTimes)
                end)
            else
                roleObj.transform:DOLocalMove(nowPos, moveTime):SetEase(DG.Tweening.Ease.Linear)
            end
        end)
    end)
end

--根据角色放大缩小设置排序层级
function StoryPanel:_SetRoleSiblingIndexByScale()
    local checkIsShowFunc = function(spineObj)
        if not spineObj then
            return false
        end
        local objParent = spineObj.transform.parent
        return objParent.name == self.canvasShow.name
    end
    local sortList = {
        {
            size = self.nowLeftObj and self.nowLeftObj.transform.localScale.x or 1,
            spineRoot = self.leftOffset,
            isShow = checkIsShowFunc(self.leftOffset),
        },
        {
            size = self.nowCenterObj and self.nowCenterObj.transform.localScale.x or 1,
            spineRoot = self.middleOffset,
            isShow = checkIsShowFunc(self.middleOffset),
        },
        {
            size = self.nowRightObj and self.nowRightObj.transform.localScale.x or 1,
            spineRoot = self.rightOffset,
            isShow = checkIsShowFunc(self.rightOffset),
        },
    }

    for i, item in pairs(sortList) do
        if item.isShow then
            sortList[i].rawRoot = self.characterRawShow
        else
            sortList[i].rawRoot = self.characterRawHide
        end
    end

    table.sort(sortList, function(a, b)
        if a.size ~= b.size then
            return a.size > b.size  -- size 大的排前面
        else
            -- size 相等时，isShow 为 true 的排前面
            return (a.isShow == true and b.isShow == false)
        end
    end)

    -- 排序完成后，统一调整层级，越靠前的元素层级越高
    local count = #sortList
    for i, item in ipairs(sortList) do
        item.spineRoot.transform:SetAsFirstSibling()
        if i == 1 and item.size >= 1 then
            item.rawRoot.transform:SetAsLastSibling()
        elseif i == count and item.size < 1 then
            item.rawRoot.transform:SetAsFirstSibling()
        end
    end
end

--通讯
function StoryPanel:_DoTelephony(nowNode)
    if self.isTelephonyMode == false then
        self.isTelephonyMode = true
        self.messageWords:SetActive(true)
        self.storyWords:SetActive(false)
        self:_SetSpineIsShow(self.leftOffset, false)
        self:_SetSpineIsShow(self.middleOffset, false)
        self:_SetSpineIsShow(self.rightOffset, false)
    end

    --对话
    local charName = nowNode.title
    local delayTime = self:_GetTextPlayTime(nowNode.content)
    nowNode.content = self:_SetStoryRichText(self.messageWordsText, nowNode.content)
    self.doNextMessageIcon:SetActive(false)
    self.isNext = false
    self.messageNameText.text.text = self:_SetStoryRichText(self.messageNameText, charName)
    self:_DoShowText(self.messageWordsText, nowNode, delayTime)

    --显示spine
    local showHeadName = nowNode.showCharacter
    self:_SetMessageWordsPos(showHeadName ~= nil)
    if not showHeadName then
        self.storyRoleHead:SetActive(false)
        return
    else
        self.storyRoleHead:SetActive(true)
    end
    if self.headSpineList[showHeadName].transform.parent.gameObject.name ~= self.headRoot.name then
        if UICommonUtils.Checkobj(self.nowTelephonySpine) then
            self.nowTelephonySpine:SetParent(self.haedSpineRoot.transform)
        end
    end
    self.nowTelephonySpine = self.headSpineList[showHeadName]
    self.nowTelephonySpine:SetParent(self.headRoot.transform)
    local headPointPos = self.nowTelephonySpine.transform:Find("HeadPoint").transform.localPosition
    self.nowTelephonySpine.transform.localPosition = Vector3.New(-headPointPos.x, -headPointPos.y, 0)

    --表情动作
    self:_RemoveStopTalkTimer()
    local spineAnimation = self.nowTelephonySpine:GetComponent("SetSpineAnimation")
    local objSpineAnim = self.nowTelephonySpine:GetComponent("SkeletonAnimation")

    local actionName = nowNode.action and string.find(nowNode.action, "action") and nowNode.action
    local nowActionName = ""
    local currentAnimation = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Action)
    if currentAnimation then
        nowActionName = currentAnimation.Animation.Name
        if actionName and nowActionName ~= actionName then
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Action, actionName, true)
        end
    else
        nowActionName = actionName or "idle_action"
        objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Action, nowActionName, true)
    end

    local emoteName = nowNode.action
    local nowEmoteName = "idle_talk"
    currentAnimation = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote)
    if currentAnimation then
        local currentAnimationName = currentAnimation.Animation.Name
        nowEmoteName = string.find(currentAnimationName, "_talk") and currentAnimationName or currentAnimationName.."_talk"
    end
    nowEmoteName = emoteName or nowEmoteName
    objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, nowEmoteName, true)

    self.stopTalkActionTimerList[self.nowTelephonySpine.name.."Head"] = DLuaTimer:DoAfter(delayTime * 4, function()
        if not objSpineAnim then
            return
        end
        local emoteTrack = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote)
        local nowEmoteName = (emoteTrack ~= nil and emoteTrack.Animation ~= nil) and emoteTrack.Animation.Name or ""
        if nowEmoteName == "" then return end
        local nameBreakList = {}
        local newEomteName = ""
        string.gsub(nowEmoteName,'[^'.."_"..']+',function ( w )
            table.insert(nameBreakList, w)
        end)
        if #nameBreakList > 1 then
            newEomteName = nameBreakList[1]
        end
        if newEomteName ~= "" and nowEmoteName ~= newEomteName and spineAnimation:CheckAnimationExist(newEomteName) then
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, newEomteName, true)
        end
    end)
    self.stopTalkCallbackList[self.nowTelephonySpine.name.."Head"] = function()
        local headSpineAnim = self.nowTelephonySpine:GetComponent("SkeletonAnimation")
        local emoteTrack = headSpineAnim and headSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote)
        local nowEmoteName = (emoteTrack ~= nil and emoteTrack.Animation ~= nil) and emoteTrack.Animation.Name or ""
        if nowEmoteName == "" then return end
        local nameBreakList = {}
        local newEomteName = ""
        string.gsub(nowEmoteName,'[^'.."_"..']+',function ( w )
            table.insert(nameBreakList, w)
        end)
        if #nameBreakList > 1 then
            newEomteName = nameBreakList[1]
        end
        if newEomteName ~= "" and nowEmoteName ~= newEomteName and spineAnimation:CheckAnimationExist(newEomteName) then
            headSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, newEomteName, true)
        end
    end
end

--根据是否显示通信头像设置对话界面位置
function StoryPanel:_SetMessageWordsPos(isShowHead)
    if isShowHead then
        self.messageNameText.rectTransform.anchoredPosition = Vector2.New(-405, self.messageNameText.rectTransform.anchoredPosition.y)
        self.messageWordsText.rectTransform.anchoredPosition = Vector2.New(106.5, self.messageWordsText.rectTransform.anchoredPosition.y)
        self.messageWordsText.rectTransform.sizeDelta = Vector2.New(1022, self.messageWordsText.rectTransform.sizeDelta.y)
        self.msgCutOffLine.rectTransform.anchoredPosition = Vector2.New( 131.4, self.msgCutOffLine.rectTransform.anchoredPosition.y)
        self.msgCutOffLine.rectTransform.sizeDelta = Vector2.New(1129, self.msgCutOffLine.rectTransform.sizeDelta.y)
    else
        self.messageNameText.rectTransform.anchoredPosition = Vector2.New(-662.5, self.messageNameText.rectTransform.anchoredPosition.y)
        self.messageWordsText.rectTransform.anchoredPosition = Vector2.New(-7.5, self.messageWordsText.rectTransform.anchoredPosition.y)
        self.messageWordsText.rectTransform.sizeDelta = Vector2.New(1306, self.messageWordsText.rectTransform.sizeDelta.y)
        self.msgCutOffLine.rectTransform.anchoredPosition = Vector2.New(0, self.msgCutOffLine.rectTransform.anchoredPosition.y)
        self.msgCutOffLine.rectTransform.sizeDelta = Vector2.New(1391, self.msgCutOffLine.rectTransform.sizeDelta.y)
    end
end

--等待
function StoryPanel:_DoWait(nowNode)
    self.doNextBtn.button.interactable = false
    local delayTime = tonumber(nowNode.title)
    self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(delayTime, function()
        self.doNextBtn.button.interactable = true
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
    end)

    if self.isNarrationMode == true then
        self.isNarrationMode = false
        for _, narrationBox in pairs(self.narrationObjList) do
            narrationBox.narrationTxt.text.uneditedText = ""
        end
    end
end

--幕布
function StoryPanel:_DoCurtain(nowNode)
    self.doNextBtn.button.interactable = false
    self.curtainTime = nowNode.showCharacter or 0.5
    self.closeCurtainIndex = tonumber(nowNode.title)
    self.storyCurtain.canvasGroup:DOFade(1, self.curtainTime):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
    end)
end

--关闭幕布
function StoryPanel:_CloseCurtain()
    if self.closeCurtainIndex ~= self.sprictIndex then
        return false
    end
    self.storyCurtain.canvasGroup:DOFade(0, self.curtainTime):SetEase(DG.Tweening.Ease.InQuart):OnComplete(function()
        self.doNextBtn.button.interactable = true
        self.closeCurtainIndex = nil
        self:_PlayStory()
    end)
    return true
end

--音效
function StoryPanel:_DoSoundEffect(nowNode)
    local SEName = nowNode.title
    local playCount = nowNode.showCharacter or 1
    local SESource = nowNode.left or 1
    local SEPath = Config.AudioPath.StorySE
    if SESource == 2 then
        SEPath = Config.AudioPath.SE
    end
    local SEPath = string.format(SEPath, SEName)
    if playCount >= 1 then
        self.sEKeyList[SEPath] = self:play2DSound(SEPath, nil, playCount, function()
            self.sEKeyList[SEPath] = nil
        end)
    else
        if self.sEKeyList[SEPath] then
            AudioMgr:stopSE(self.sEKeyList[SEPath])
            self.sEKeyList[SEPath] = nil
        end
    end
    self.sprictIndex = self.sprictIndex + 1
    self:_PlayStory()
end

--音乐暂停
function StoryPanel:_DoPauseBGM(nowNode)
    local fadeTime = nowNode.showCharacter
    AudioMgr:pauseBGM(fadeTime)
    self.sprictIndex = self.sprictIndex + 1
    self:_PlayStory()
end

--音乐恢复
function StoryPanel:_DoResumBGM(nowNode)
    local fadeTime = nowNode.showCharacter
    AudioMgr:resumBGM(fadeTime)
    self.sprictIndex = self.sprictIndex + 1
    self:_PlayStory()
end

--角色登场
function StoryPanel:_DoComeOnStage(nowNode)
    self.doNextBtn.button.interactable = false
    local moveType = nowNode.title
    local needTime = nowNode.showCharacter or 1
    local leftSpineName = nowNode.left or ""
    local centerSpineName = nowNode.center or ""
    local rightSpineName = nowNode.right or ""
    local initPosScaleList = nowNode.content and loadstring("return " .. nowNode.content)() or {}

    --处理动作表情配置
    local leftAction = {}
    local centerAction = {}
    local rightAction = {}
    local actionGroupList = {}
    local actionGroup = nowNode.action or ""
    string.gsub(actionGroup,'[^'.."-"..']+',function ( w )
        table.insert(actionGroupList, w)
    end)
    for _, groupId in pairs(actionGroupList) do
        local actionConfigList = Config.GetActionInfoByGroup(groupId)
        if actionConfigList[1].character == nowNode.left then
            leftAction = actionConfigList
        end
        if actionConfigList[1].character == nowNode.center then
            centerAction = actionConfigList
        end
        if actionConfigList[1].character == nowNode.right then
            rightAction = actionConfigList
        end
    end

    --根据配置处理角色偏移和缩放
    self:_SetRoleResOffset(leftSpineName, centerSpineName, rightSpineName)
    --设置角色距离
    self:_SetRoleDefaultLocation()

    local goNextNum = 0

    local function EndOnStageFun()
        --根据缩放设置角色的层级关系
        self:_SetRoleSiblingIndexByScale()

        goNextNum = goNextNum + 1
        if goNextNum == 1 then
            self.doNextBtn.button.interactable = true
            self.sprictIndex = self.sprictIndex + 1
            self:_PlayStory()
        end
    end

    if self._ani_tweener then
        self._ani_tweener:Kill(false)
        self._ani_tweener = nil
    end

    local showIndex = 0
    local function DoComeOnMove(nowObj)
        showIndex = showIndex + 1
        local objRect = nowObj:GetComponent("RectTransform")
        local initPosX, initPosY = 0, 0
        local initPosScale = initPosScaleList[showIndex] or {0, 0, 1}--x,y,scale
        objRect.localScale = Vector3.New(initPosScale[3], initPosScale[3], 1)
        if moveType == 1 or moveType == 3 then--平移登场
            if moveType == 1 then
                initPosX = objRect.anchoredPosition.x - (Screen.width + 300) + initPosScale[1]
            else
                initPosX = objRect.anchoredPosition.x + (Screen.width + 300) + initPosScale[1]
            end
            initPosY = objRect.anchoredPosition.y + initPosScale[2]
            local endPos = Vector2.New(initPosScale[1], initPosScale[2])
            objRect:DOAnchorPos(endPos, needTime):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
                EndOnStageFun()
            end)
        elseif moveType == 2 then--渐显登场
            local myRT = nowObj:GetComponent("SkeletonGraphicRenderTexture_Custom")
            myRT.color = Color.New(1,1,1,0)
            myRT.enabled = true
            self._ani_tweener = DOTween.Sequence()
            self._ani_tweener:Append(
                DG.Tweening.DOVirtual.Float(0, 1, needTime, function(v)
                    myRT.color = Color.New(1,1,1,v)
                end):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
                    myRT.enabled = false
                    EndOnStageFun()
                end)
            )
            initPosX = objRect.anchoredPosition.x + initPosScale[1]
            initPosY = objRect.anchoredPosition.y + initPosScale[2]
        end
        objRect.anchoredPosition = Vector2.New(initPosX, initPosY)
    end

    --左
    if leftSpineName and leftSpineName ~= "" then
        if UICommonUtils.Checkobj(self.nowLeftObj) then
            self.nowLeftObj:SetParent(self.roleSpineRoot.transform)
        end
        self.nowLeftObj = self.spineList[leftSpineName]
        self.nowLeftObj:SetParent(self.characterLeft.transform)

        self:_ComeOnStageAction(self.nowLeftObj, leftAction)
        self:_SetSpineIsShow(self.leftOffset, true)
        DoComeOnMove(self.nowLeftObj)
    end

    --中
    if centerSpineName and centerSpineName ~= "" then
        if UICommonUtils.Checkobj(self.nowCenterObj) then
            self.nowCenterObj:SetParent(self.roleSpineRoot.transform)
        end
        self.nowCenterObj = self.spineList[centerSpineName]
        self.nowCenterObj:SetParent(self.characterMiddle.transform)

        self:_ComeOnStageAction(self.nowCenterObj, centerAction)
        self:_SetSpineIsShow(self.middleOffset, true)
        DoComeOnMove(self.nowCenterObj)
    end

    --右
    if rightSpineName and rightSpineName ~= "" then
        if UICommonUtils.Checkobj(self.nowRightObj) then
            self.nowRightObj:SetParent(self.roleSpineRoot.transform)
        end
        self.nowRightObj = self.spineList[rightSpineName]
        self.nowRightObj:SetParent(self.characterRight.transform)

        self:_ComeOnStageAction(self.nowRightObj, rightAction)
        self:_SetSpineIsShow(self.rightOffset, true)
        DoComeOnMove(self.nowRightObj)
    end

    self.storyCharacter.canvasGroup.alpha = 1
end

--角色登场表情动作
function StoryPanel:_ComeOnStageAction(nowObj, actionList)
    local objSpineAnim = nowObj:GetComponent("SkeletonAnimation")

    for _, actionConfig in pairs(actionList) do
        if actionConfig.basicType == GE.RoleSpineActionType.Emote then
            local nameBreakList = {}
            local emoteName = actionConfig.resource
            string.gsub(emoteName,'[^'.."_"..']+',function ( w )
                table.insert(nameBreakList, w)
            end)
            if #nameBreakList > 1 then
                emoteName = nameBreakList[1]
            end
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, emoteName, true)
            self[nowObj.name .. "EmoteNow"] = emoteName
        elseif actionConfig.basicType == GE.RoleSpineActionType.Action then
            local poseName = actionConfig.resource
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Action, poseName, true)
            self[nowObj.name .. "PoseNow"] = poseName
        end
    end
end

--根据配置处理角色偏移和缩放
function StoryPanel:_SetRoleResOffset(leftName, centerName, rightName)
    local storyResConfig
    local offset, scale
    if leftName and leftName ~= "" then
        storyResConfig = Config.GetStoryResourceInfo(leftName)
        offset = storyResConfig.offset
        scale = storyResConfig.scale
        self.leftOffset.rectTransform.anchoredPosition = Vector2.New(offset[1], offset[2])
        self.characterLeft.transform.localScale = Vector3.New(scale, scale, 1)
    end
    if rightName and rightName ~= "" then
        storyResConfig = Config.GetStoryResourceInfo(rightName)
        offset = storyResConfig.offset
        scale = storyResConfig.scale
        self.rightOffset.rectTransform.anchoredPosition = Vector2.New(offset[1], offset[2])
        self.characterRight.transform.localScale = Vector3.New(scale, scale, 1)
    end
    if centerName and centerName ~= "" then
        storyResConfig = Config.GetStoryResourceInfo(centerName)
        offset = storyResConfig.offset
        scale = storyResConfig.scale
        self.middleOffset.rectTransform.anchoredPosition = Vector2.New(offset[1], offset[2])
        self.characterMiddle.transform.localScale = Vector3.New(scale, scale, 1)
    end
end

--屏幕闪烁
function StoryPanel:_DoScreenFlicker(nowNode)
    local standardTime = nowNode.left or 1
    local showTime = nowNode.center or 0.01
    self.doNextBtn.button.interactable = false
    self.storyUIGroup.canvasGroup:DOFade(0, standardTime/2)
    self.nowFlickerTimes = 0
    local needTimes = nowNode.showCharacter or 1
    local backgroundName = nowNode.title or "scene_white"--默认为白色屏闪
    local BgPathPattern = Config.SpritePath.AVGScene
    local BackGroundPath = string.format(BgPathPattern, backgroundName, backgroundName)
    self:LoadSpriteAsync(BackGroundPath, function(sprite)
        self.screenDynamic.image.sprite = sprite
        self:_FlickerFunc(standardTime/2, showTime, needTimes)
    end)
end

function StoryPanel:_FlickerFunc(doTime, showTime, needTimes)
    self.screenDynamic.canvasGroup:DOFade(1, doTime):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
        self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(showTime, function()
            self.screenDynamic.canvasGroup:DOFade(0, doTime):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
                self.nowFlickerTimes = self.nowFlickerTimes + 1
                if self.nowFlickerTimes < needTimes then
                    self:_FlickerFunc(doTime, showTime, needTimes)
                else
                    self.doNextBtn.button.interactable = true
                    self.sprictIndex = self.sprictIndex + 1
                    self:_PlayStory()
                end
            end)
        end)
    end)
end

--立绘清屏
function StoryPanel:_DoRoleClear()
    for _, spineObj in pairs(self.spineList) do
        spineObj:SetParent(self.roleSpineRoot.transform)
        spineObj.transform.localScale = Vector3.one
        local objSpineAnim = spineObj:GetComponent("SkeletonAnimation")
        if objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote) then
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, "idle", true)
            self[spineObj.name .. "EmoteNow"] = "idle"
        end
        if objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Action) then
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Action, "idle_action", true)
            self[spineObj.name .. "PoseNow"] = "idle_action"
        end
    end
    self.sprictIndex = self.sprictIndex + 1
    self:_PlayStory()
end

--显示CG
function StoryPanel:_DoShowCG(nowNode)
    self.doNextBtn.button.interactable = false
    local cgAction = nowNode.left
    local cgEmote = nowNode.center
    local cgAtionFunc = function(spineObj)
        local objSpineAnim = spineObj:GetComponent("SkeletonAnimation")
        if cgAction then
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Action, cgAction, true)
        end
        if cgEmote then
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, cgEmote, true)
        end
    end
    local cgName = nowNode.title
    local spineObj = self.cgSpineList[cgName]
    if spineObj.transform.parent.gameObject.name == self.storyCG.name then--如果已在展示则只修改动作或表情
        cgAtionFunc(spineObj)
        self.doNextBtn.button.interactable = true
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
        return
    end
    local curtainTime = nowNode.showCharacter or 1
    local curtainColor = (nowNode.action == 1) and "FFFFFF" or (nowNode.action or "000000")
    local initPosScale = nowNode.content and loadstring("return " .. nowNode.content)() or {0, 0, 1}--x,y,scale
    self.storyCurtain.image.color = Color.NewFromStr(curtainColor)
    self.storyCurtain.canvasGroup:DOFade(1, curtainTime):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
        local objRect = spineObj:GetComponent("RectTransform")
        spineObj:SetParent(self.storyCG.transform)
        objRect.anchoredPosition = Vector2.New(initPosScale[1], initPosScale[2])
        objRect.localScale = Vector3.New(initPosScale[3], initPosScale[3], 1)
        cgAtionFunc(spineObj)
        self.storyUIGroup.canvasGroup.alpha = 0
        self.storyCurtain.canvasGroup:DOFade(0, curtainTime):SetEase(DG.Tweening.Ease.InQuart):OnComplete(function()
            self.storyCurtain.image.color = Color.NewFromStr("000000")
            self.doNextBtn.button.interactable = true
            self.sprictIndex = self.sprictIndex + 1
            self:_PlayStory()
        end)
    end)
end

--隐藏CG
function StoryPanel:_DoHideCG(nowNode)
    self.doNextBtn.button.interactable = false
    local cgName = nowNode.title
    local spineObj = self.cgSpineList[cgName]
    local curtainTime = nowNode.showCharacter or 1
    local curtainColor = (nowNode.action == 1) and "FFFFFF" or (nowNode.action or "000000")
    self.storyCurtain.image.color = Color.NewFromStr(curtainColor)
    self.storyCurtain.canvasGroup:DOFade(1, curtainTime):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
        spineObj:SetParent(self.cGSpineRoot.transform)
        self.storyUIGroup.canvasGroup.alpha = 0
        self.storyCurtain.canvasGroup:DOFade(0, curtainTime):SetEase(DG.Tweening.Ease.InQuart):OnComplete(function()
            self.storyCurtain.image.color = Color.NewFromStr("000000")
            self.doNextBtn.button.interactable = true
            self.sprictIndex = self.sprictIndex + 1
            self:_PlayStory()
        end)
    end)
end

--CG运动
function StoryPanel:_DoCGAction(nowNode)
    self.doNextBtn.button.interactable = false
    local cgName = nowNode.title
    local needTime = nowNode.showCharacter or 1
    local spineObj = self.cgSpineList[cgName]
    local objRect = spineObj:GetComponent("RectTransform")
    local initPosScale = nowNode.content and loadstring("return " .. nowNode.content)() or {0, 0, 1}--x,y,scale
    local endPos = Vector2.New(initPosScale[1], initPosScale[2])
    objRect:DOAnchorPos(endPos, needTime):SetEase(DG.Tweening.Ease.Linear)
    objRect:DOScale(Vector3.New(initPosScale[3], initPosScale[3], 1), needTime):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
        self.doNextBtn.button.interactable = true
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
    end)
end

--隐藏UI
function StoryPanel:_DoHideUI(nowNode)
    self.doNextBtn.button.interactable = false
    local autoNext = (not nowNode.title) and true or false
    local fadeTime = nowNode.showCharacter or 0.2
    self.storyUIGroup.canvasGroup:DOFade(0, fadeTime):OnComplete(function()
        self.doNextBtn.button.interactable = true
        if autoNext then
            self.sprictIndex = self.sprictIndex + 1
            self:_PlayStory()
        end
    end)
end

--换装开关
function StoryPanel:_DoRoleSlot(nowNode)
    self.doNextBtn.image.raycastTarget = false
    local poseName = nowNode.title
    local needCharacter = nowNode.showCharacter
    local needWait = nowNode.left and true or false
    local isTween = nowNode.center and true or false
    local nowObj = self.spineList[needCharacter]
    local objSpine = nowObj:GetComponent("SkeletonGraphic")
    local objSpineAnim = nowObj:GetComponent("SkeletonAnimation")
    local spineAnimation = nowObj:GetComponent("SetSpineAnimation")
    local isLoop = true
    local newName = ""
    local partOpen = true
    local newTrack = 0
    local defaultTime = 0.1
    for i = GE.RoleSpineActionType.Emote + 1, 5 do--目前先支持最多三个插槽，既5轨道
        local nowEntry = objSpineAnim.AnimationState:GetTrack(i)
        if nowEntry then
            local nowName = nowEntry.Animation.Name
            if nowName == poseName then
                newTrack = i
                partOpen = false
                break
            end
        end
        if not nowEntry and newTrack == 0 then
            newTrack = i
        end
    end

    if partOpen then
        newName = string.gsub(poseName, "idle", "begin")
        if spineAnimation:CheckAnimationExist(newName) and isTween then
            objSpineAnim.AnimationState:SetAnimation(newTrack, newName, false)
            defaultTime = objSpine.Skeleton.Data:FindAnimation(newName).Duration
            objSpineAnim.AnimationState:AddAnimation(newTrack, poseName, isLoop, defaultTime)
        else
            objSpineAnim.AnimationState:SetAnimation(newTrack, poseName, isLoop)
        end
    else
        newName = string.gsub(poseName, "idle", "end")
        if spineAnimation:CheckAnimationExist(newName) and isTween then
            local endEntry = objSpineAnim.AnimationState:SetAnimation(newTrack, newName, false)
            endEntry.Complete = endEntry.Complete + function()
                -- 动画播放完毕后清空轨道动画，淡出时间为动画时长
            objSpineAnim.AnimationState:SetEmptyAnimation(newTrack, 0.1)
            end
            defaultTime = objSpine.Skeleton.Data:FindAnimation(newName).Duration
        else
            if objSpineAnim.AnimationState:GetTrack(newTrack) then
                objSpineAnim.AnimationState:SetEmptyAnimation(newTrack, 0.1)
            end
        end
    end
    if needWait then
        self.doActionTimerList[self.sprictIndex] = DLuaTimer:DoAfter(defaultTime, function()
            self.doNextBtn.image.raycastTarget = true
            self.sprictIndex = self.sprictIndex + 1
            self:_PlayStory()
        end)
    else
        self.doNextBtn.image.raycastTarget = true
        self.sprictIndex = self.sprictIndex + 1
        self:_PlayStory()
    end
end

--场景运动
function StoryPanel:_DoBackGroundAction(nowNode)
    self.doNextBtn.button.interactable = false
    local needShowUI = nowNode.title ~= nil
    local needTime = nowNode.showCharacter or 1
    local nowBgNum = self.ueseBackgroundNum + 1
    if nowBgNum == 3 then
        nowBgNum = 1
    end
    local bgActionFunc = function()
        local nowBgObj = self["background"..nowBgNum]
        local objRect = nowBgObj.rectTransform
        local initPosScale = nowNode.content and loadstring("return " .. nowNode.content)() or {0, 0, 1}--x,y,scale
        local endPos = Vector2.New(initPosScale[1], initPosScale[2])
        objRect:DOAnchorPos(endPos, needTime):SetEase(DG.Tweening.Ease.Linear)
        objRect:DOScale(Vector3.New(initPosScale[3], initPosScale[3], 1), needTime):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
            self.doNextBtn.button.interactable = true
            self.sprictIndex = self.sprictIndex + 1
            self:_PlayStory()
        end)
    end
    if needShowUI then
        bgActionFunc()
    else
        local fadeTime = 0.2
        self.storyCharacter.canvasGroup:DOFade(0, fadeTime)
        self.storyUIGroup.canvasGroup:DOFade(0, fadeTime):OnComplete(function()
            bgActionFunc()
        end)
    end

end

--沿用BGM
function StoryPanel:_DoKeepBGM()
    self.sprictIndex = self.sprictIndex + 1
    self:_PlayStory()
end

--处理富文本
function StoryPanel:_SetStoryRichText(showObj, dialogue)
    if not dialogue then
        return "", false
    end
    --转译RubyText
    local isRuby = string.find(dialogue, "</ruby>")
    showObj.text.uneditedText = dialogue
    dialogue = showObj.text.text
    showObj.text.uneditedText = ""
    showObj.text.text = ""
    --替换玩家姓名
    dialogue = string.gsub(dialogue, "{PlayerName}", Me and Me.name or "{PlayerName}")
    return dialogue, isRuby
end

--判断文字播放时间
function StoryPanel:_GetTextPlayTime(text, playRate)
    local realText = text
    for _, pattern in pairs(GE.StoryTextRegex) do
        realText = string.gsub(realText, pattern, "")
    end
    local playTime = self:_CountVisibleCharacters(realText) * (playRate or 0.05)
    --LuaLogger.ds(">>>>>playTime<<<<<", playTime)
    return playTime
end

--移除界面Timer
function StoryPanel:_RemovePanelTimer()
    if next(self.doActionTimerList) then
        for name, timer in pairs(self.doActionTimerList) do
            DLuaTimer:RemoveTimer(timer)
        end
    end
end

--移除停止对话Timer
function StoryPanel:_RemoveStopTalkTimer()
    if next(self.stopTalkActionTimerList) then
        for name, timer in pairs(self.stopTalkActionTimerList) do
            DLuaTimer:RemoveTimer(timer)
        end
    end
end

--停止说话表情
function StoryPanel:_StopRoleTalk()
    self:_RemoveStopTalkTimer()
    for _, endFunc in pairs(self.stopTalkCallbackList) do
        endFunc()
    end
    self.stopTalkCallbackList = {}
end

--自动播放动画
function StoryPanel:_AutoPlayAnimation(isAuto)
    local autoValue = isAuto and 1 or 0
    local autoScale = isAuto and -1 or 1
    self.round.animator.speed = autoValue
    self.autoChange.transform:DOScale(Vector3.New(0,1,1), 0.15):OnComplete(function()
        self.unAuto.canvasGroup.alpha = 1 - autoValue
        self.doAuto.canvasGroup.alpha = autoValue
        self.autoChange.transform:DOScale(Vector3.New(autoScale,1,1), 0.15):OnComplete(function()
            self.canAutoClick = true
        end)
    end)
end

--节点Canvas开关
function StoryPanel:_CanvasSwitch(isAuto)
    self.storyCharacter.canvas.overrideSorting = isAuto
    self.storyCG.canvas.overrideSorting = isAuto
    self.storyUIGroup.canvas.overrideSorting = isAuto
    self.screenDynamic.canvas.overrideSorting = isAuto
    self.storyBtnGroup.canvas.overrideSorting = isAuto
    self.storyCurtain.canvas.overrideSorting = isAuto
    self.effectRoot:SetActive(isAuto)
end

--UI显示开关
function StoryPanel:_UIShowSwitch(isShow)
    self.storyUIGroup:SetActive(isShow)
    self.storyBtnGroup:SetActive(isShow)
end

--初始化背景适配
function StoryPanel:initBackgroundSize()
    local rootTransform =  UIMgr:GetUICanvasRoot():GetComponent("RectTransform")
    local screen_width = rootTransform.rect.width
    local screen_height = rootTransform.rect.height
    local kv_width = 2160
    local kv_height = 1080
    local scale_width = screen_width / kv_width
    local scale_height = screen_height / kv_height
    local scale = math.max(scale_width, scale_height)
    self.storyBg.rectTransform.localScale = Vector3.New(scale, scale, 1)
    self.storyCG.rectTransform.localScale = Vector3.New(scale, scale, 1)
end

--初始化RenderTexture
function StoryPanel:initRenderTexture(callBack)
    local rootTransform =  UIMgr:GetUICanvasRoot():GetComponent("RectTransform")
    local screen_width = rootTransform.rect.width
    local screen_height = rootTransform.rect.height

    if not self.rtRoleShow then
        local binder = self.characterRawShow:GetOrAddComponent(TypeInfo.RenderTextureBindCamera)
        self.rtRoleShow = binder:CreateRenderTexture(self.roleCameraShow.camera, screen_width, screen_height, "StoryPanel_characterRawShow", true, false, false, true, true)
    end
    if not self.rtRoleHide then
        local binder = self.characterRawHide:GetOrAddComponent(TypeInfo.RenderTextureBindCamera)
        self.rtRoleHide = binder:CreateRenderTexture(self.roleCameraHide.camera, screen_width, screen_height, "StoryPanel_characterRawHide", true, false, false, true, true)
    end
    self.characterRawShow.rawImage.texture = self.rtRoleShow
    self.characterRawHide.rawImage.texture = self.rtRoleHide

    self:LoadInstantiatePrefab(Config.PrefabPath.StoryRoleCanvas, function (obj)
        self.storyRoleCanvas = obj
        self.canvasShow = self.storyRoleCanvas.transform:Find("CanvasShow")
        self.canvasHide = self.storyRoleCanvas.transform:Find("CanvasHide")

        self.canvasShow:GetComponent("Canvas").worldCamera = self.roleCameraShow.camera
        self.canvasHide:GetComponent("Canvas").worldCamera = self.roleCameraHide.camera

        local screenSize = Vector2.New(screen_width, screen_height)
        self.leftOffset.transform:SetParent(self.canvasShow)
        self.leftOffset.transform.localPosition = Vector3.zero
        self.leftOffset.transform.localScale = Vector3.one
        self.leftOffset.transform.sizeDelta = screenSize
        self.middleOffset.transform:SetParent(self.canvasShow)
        self.middleOffset.transform.localPosition = Vector3.zero
        self.middleOffset.transform.localScale = Vector3.one
        self.middleOffset.transform.sizeDelta = screenSize
        self.rightOffset.transform:SetParent(self.canvasShow)
        self.rightOffset.transform.localPosition = Vector3.zero
        self.rightOffset.transform.localScale = Vector3.one
        self.rightOffset.transform.sizeDelta = screenSize
        if callBack then
            callBack()
        end
    end)
end

function StoryPanel:_EndStory()
    if (not self.needKeepInsideBGM) and self.lastBGMData then
        AudioMgr:StopCurrBgm(0.5)
    end
    if self.sEKeyList then
        for _, sEKey in pairs(self.sEKeyList) do
            AudioMgr:stopSE(sEKey)
        end
    end
    if self.nowVoiceKeyList then
        for _, key in pairs(self.nowVoiceKeyList) do
            AudioMgr:stopVoice(key)
        end
        self.nowVoiceKeyList = nil
    end

    self:_RemovePanelTimer()
    self:_RemoveStopTalkTimer()

    if self.callBack then
        self.callBack()
    end

    local endFunc = function()
        UIMgr:closeSpecificUI(self)
        if self.callBackAfter then
            self.callBackAfter()
        end
    end

    if self.needEndLoading then
        LoadingMgr:SetUIQuickSwitchStart(function()
            endFunc()
        end)
    else
        endFunc()
    end
    --检测是否需要引导
    GuideMgr:SetAfterGuideStoryName(self.nowStoryName)
    GuideMgr:StartGuideAVGTrigger()
end

---------------------------剧情埋点------------------------------
function StoryPanel:recordStoryLog(recordType, actionType)
    if GV.isAvgEditor and GV.IsEditor then
        return
    end
    local nowNode = self.storyData[self.sprictIndex] or self.storyData[self.sprictIndex - 1]
    local needData = {
        event_type = recordType,
        storyName = self.nowStoryName,
        dialogId = nowNode.id,
    }

    --判断是否为对话相关类型的内容
    local checkIsDialogue = function(nowNode)
        if nowNode.type ~= GE.StoryScriptType.DoTalk and
           nowNode.type ~= GE.StoryScriptType.DoSilent and
           nowNode.type ~= GE.StoryScriptType.DoNarration and
           nowNode.type ~= GE.StoryScriptType.DoTelephony then
            return false
        else
            return true
        end
    end

    if recordType == 70 then--对话完成记录
        --只记录对话相关类型的内容
        if not checkIsDialogue(nowNode) then
            return
        end
        --剔除重复记录
        if self.nowLogMessageIndex == self.sprictIndex then
            return
        else
            self.nowLogMessageIndex = self.sprictIndex
        end

        needData.type = nowNode.type
        if self.autoPlay then
            needData.actionType = GE.StoryContentFinishType.AutoPlay
        else
            needData.actionType = actionType
        end
        if nowNode.content and type(nowNode.content) == "string" then
            local md5Hash = md5Lua.sumhexa(nowNode.content)
            needData.dialogMd5 = md5Hash:sub(1, 8)
        end
    elseif recordType == 71 then--剧情完成记录
        local allDialogueCount = 0
        for _, node in pairs(self.storyData) do
            if checkIsDialogue(node) then
                allDialogueCount = allDialogueCount + 1
            end
        end
        needData.count = allDialogueCount
        needData.isSkip = actionType
    end
    ClientData:sendAvgLogMessage(needData)
    --LuaLogger.ds(">>>>>>>needData<<<<<<<", tablex.dump(needData))
end
---------------------------END------------------------------

function StoryPanel:OnClose(initiative)
    -- if(self.originRenderScale ~= nil) then
    --     QualitySettingsMgr:SetURPRenderScale(self.originRenderScale)    
    -- end
end

function StoryPanel:OnDestroy()
	--self.super:OnDestroy(self)
    -- if self.rtRoleShow then
    --     self.rtRoleShow:Release()
    -- end
    -- if self.rtRoleHide then
    --     self.rtRoleHide:Release()
    -- end
    DUtil.Destroy(self.storyRoleCanvas)
    self.super:OnDestroy(self)
end

--function StoryPanel:OnRefresh(data)
--
--end

-------------------------------外部编辑器调用-------------------------------
function StoryPanel:SetTalkCharName(name)
    self.nameText.text.text = name
end

function StoryPanel:SetTalkWords(words)
    self.wordsText.text.uneditedText = words
end

function StoryPanel:SetCharSpine(pos, name)
    local prefabPath = string.format(Config.PrefabPath.CatSpine, name)
    self:LoadInstantiatePrefab(prefabPath, function (obj)
        local spineObject = obj
        spineObject:SetParent(self.storyCharacter.transform)
        spineObject:SetActive(false)
    end)
end

function StoryPanel:ReloadScript(newID)
    self.sprictIndex = 1
    self.nowSettingNum = 0
    self.nowStoryID = newID
    self:InitPanel()
end

function StoryPanel:FastForwardByIndex(index)
    if self.fastForwardTimer then
        return
    end
    self.jumpIndex = index
    self.fastForwardTimer = DLuaTimer:DoRepeatForever(0.1, function()
        if self.text_tweener ~= nil  then
            self.text_tweener:Complete(true)
        end
        if self.sprictIndex < self.jumpIndex and self.doNextBtn.button.interactable then
            self:doNextBtn_Button_onClick()
        elseif self.sprictIndex >= self.jumpIndex then
            self.doNextBtn.button.interactable = false
            DLuaTimer:RemoveTimer(self.fastForwardTimer)
            self.fastForwardTimer = nil
            self.doNextBtn.button.interactable = true
        end
    end)
end

function StoryPanel:EditorPlayStory()
    if self.isNext then
        self.sprictIndex = self.sprictIndex + 1
        local storyScript = self.storyData.storyScript
        local nowNode = storyScript[self.sprictIndex]
        if not nowNode then
            self.sprictIndex = self.sprictIndex - 1
            UICommonUtils.PopToast("已到达剧情末尾！")
            return
        end
        self:_StopRoleTalk()
        self:_PlayStory()
    else
        if self.text_tweener ~= nil then
			self.text_tweener:Complete(true)
		end
    end
end

function StoryPanel:GetCharSpine(name)
    return self.spineList[name]
end

-------------------------------END----------------------------------

--[[
/DoNextBtn onClick 
--]]
function StoryPanel:doNextBtn_Button_onClick(doNextBtn)
    if self.isHide then
        self:_UIShowSwitch(true)
        self.isHide = false
        return
    end
    if self.isNext then
        self.sprictIndex = self.sprictIndex + 1
        self:_StopRoleTalk()
        self:_PlayStory()
    else
        if self.text_tweener ~= nil then
            --剧情内容埋点(加速完成)
            self:recordStoryLog(70, GE.StoryContentFinishType.QuickClick)
            ----------------------
			self.text_tweener:Complete(true)
		end
    end
end

--[[
/SkipBtn onClick 
--]]
function StoryPanel:skipBtn_ScaleButton_onClick(skipBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)

    skipBtn.scaleButton.interactable = false

    --剧情退出埋点(跳过)
    self:recordStoryLog(71, 1)
    ----------------------

    self.autoPlay = false
    if self.text_tweener ~= nil then
		self.text_tweener:Complete(true)
	end
    self:_EndStory()
    if self.needKeepInsideBGM then
        self:_DoPlayMusic(self.lastBGMData, true)
    end
end

--[[
/HideBtn onClick 
--]]
function StoryPanel:hideBtn_ScaleButton_onClick(hideBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:_UIShowSwitch(false)
    self.isHide = true
    if self.autoPlay then
        self.autoPlay = false
        self.doNextBtn.button.enabled = true
        self:_AutoPlayAnimation(self.autoPlay)
    end
end

--[[
/LogBtn onClick 
--]]
function StoryPanel:logBtn_ScaleButton_onClick(logBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:_CanvasSwitch(false)
    self:_UIShowSwitch(false)
    if self.autoPlay then
        self.autoPlay = false
        self:_AutoPlayAnimation(self.autoPlay)
        self.doNextBtn.button.enabled = true
    end
    UIMgr:popUICover("StoryLogPanel",{dialogueLog = self.dialogueLogList,closeCallback = function()
        self:_UIShowSwitch(true)
        self:_CanvasSwitch(true)
    end})
end

--[[
/AutoBtn onClick 
--]]
function StoryPanel:autoBtn_ScaleButton_onClick(autoBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not self.canAutoClick then
        return
    end
    self.canAutoClick = false
    self.autoPlay = not self.autoPlay
    if self.autoPlay then
        self.doNextBtn.button.enabled = false
        self:_RemovePanelTimer()
        self.doNextBtn.button.interactable = true
        if self.text_tweener ~= nil then
            self.text_tweener:Complete(true) 
        elseif not self.isNext then
            --为false时等待
        else
            self.sprictIndex = self.sprictIndex + 1
            self:_StopRoleTalk()
            self:_PlayStory()
        end
    else
        self.doNextBtn.button.enabled = true
    end
    self:_AutoPlayAnimation(self.autoPlay)
end

--[[
/FastForwardBtn onClick 
--]]
function StoryPanel:fastForwardBtn_ScaleButton_onClick(fastForwardBtn)
    if GV.IsEditor then
        self:FastForwardByIndex(tonumber(self.forwardInputField.inputField.text))
    end
end

--[[
/FastForwardBtn/ForwardInputField onEndEdit 
--]]
function StoryPanel:forwardInputField_InputField_onEndEdit(forwardInputField,content)
    if GV.IsEditor then
        local num = tonumber(forwardInputField.inputField.text)
        if not num or num < 1 then
            forwardInputField.inputField.text = ""
            UICommonUtils.PopToast("请输入正确的数字！")
            return
        end
    end
end

return StoryPanel
