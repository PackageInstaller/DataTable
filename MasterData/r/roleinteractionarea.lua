---@class RoleInteractionArea : RoleInteractionArea_Generate
---##################### 【RoleInteractionArea Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RoleInteractionArea Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RoleInteractionArea = require "RoleInteractionArea_Generate"
local Random = require "Random"

function RoleInteractionArea:InitLogic(data)
    self.canClick = false   --是否可以点击

    self.clickArea = nil --点击区域

    self.spineStateData = {} --spine状态数据

    self.spineBaseData = { --spine基础数据
        BaseAction = "idle_action",
        BaseEmote = "idle",  
        Effect = "effect",
        Action = "idle_action",
        Emote = "idle",
    }

    self.mouseDownPosition = nil --鼠标按下位置

    self.mouseNowPosition = nil --鼠标当前位置

    self.isDragging = false --是否正在拖拽

    self.progressTrackList = {} --进度动作轨道列表

    self.changeActionTimerList = {} --台词中动作变化定时器列表

    self.isActionListMode = false --是否为动作列表模式

    self.needResetAction = false --是否需要重置角色动作

    self.isOldMode = false --是否为旧版点击模式

    self.nowActionCfg = nil --当前动作配置

    self.lastActionCfg = nil --上次动作配置

    self.needIntoAnim = false --是否需要播放进入动画

    self.intoFinishCallBack = nil --进入动画播放完成回调

    self.roleCid = 0 --角色cid

    self.userIdleTimer = nil --用户挂机计时器

    self.idleTime = 0 --挂机时间

    self.userIdleDialogList = {} --挂机台词列表

    self.nowLineId = nil --当前台词id

    self.needInterruptDialog = false --是否需要触发打断对话的特殊对话
end

-- 初始化互动角色
function RoleInteractionArea:initRole()
    local seed = DLuaUtil.GetGreenwichTime()
    self.random = Random:new(seed)
    self:SetUpdateInterval(0)
    local skinConfig = Config.GetCharacterSkinInfo(ClientData:GetPosterData().SkinId)
    self.roleCid = skinConfig.CharacterID

    --根据配置信息显示spine或图片
    self.skinImg:SetActive(false)
    self.spineRoot:SetActive(skinConfig.spineKey and true or false)
    if UICommonUtils.Checkobj(self.nowPosterSpine) then
        GameObject.Destroy(self.nowPosterSpine)
    end
    self.nowPosterSpine = nil
    if skinConfig.spineKey and skinConfig.spineKey ~= "" then
        local prefabPath = string.format(Config.PrefabPath.RoleSpine, skinConfig.spineKey, skinConfig.spineKey)
        ResMgr:LoadGameObjectAsync(prefabPath, function (obj)
            self.nowPosterSpine = obj
            local spineObject = self.nowPosterSpine
            spineObject:SetParent(self.spineRoot.transform)

            local objSpine = spineObject:GetComponent("SkeletonGraphic")
            local objSpineAnim = spineObject:GetComponent("SkeletonAnimation")
            local spineAnimation = spineObject:GetComponent("SetSpineAnimation")
            if self.needIntoAnim then
                self:playIntoAnimation(objSpine, objSpineAnim, spineAnimation)
            else
                self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, self.spineBaseData.BaseAction, true)
            end
            self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Emote, self.spineBaseData.BaseEmote, true)
			if spineAnimation:CheckAnimationExist(self.spineBaseData.Effect) then
                self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Effect, self.spineBaseData.Effect, true)
            end
            --测试版整体调低物理效果
            objSpine.PhysicsPositionInheritanceFactor = Vector2.New(0.4, 0.4)

            self:initSpineState()
        end)
    else
        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end
        self:LoadSpriteAsync(string.format(Config.SpritePath.PortraitRolePath, resourceFolder, skinConfig.imgKey), function (s)
            self.skinImg.image.sprite = s
            self.skinImg.image:SetNativeSize()
            self.skinImg:SetActive(true)
            --赋值点击组件
            self:doDialogAndActionOld(self.skinImg.button)

            --图片没有进入动画，所以直接调用回调函数
            if self.intoFinishCallBack then
                self:setNeedIntoAnimation(false)
                self.intoFinishCallBack()
                self.intoFinishCallBack = nil
            end
        end)
    end

    --初始化adjustRoot位置和大小
    local rootTransform =  UIMgr:GetUICanvasRoot():GetComponent("RectTransform")
    local screen_width = rootTransform.rect.width
    local screen_height = rootTransform.rect.height
    self.adjustRoot.transform.sizeDelta = Vector2.New(screen_width, screen_height)
    self.adjustRoot.rectTransform.anchoredPosition = Vector2.New(0, - skinConfig.spineOffset[2])
end

--初始化播放Into动画
function RoleInteractionArea:playIntoAnimation(objSpine, objSpineAnim, spineAnimation)
    local intoName = "into"
    if spineAnimation:CheckAnimationExist(intoName) then
        self.skipMask:SetActive(true)
        self:setNeedIntoAnimation(false)
        self:setClickEnabled(false)
        objSpine.PhysicsPositionInheritanceFactor = Vector2.zero
        self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, intoName, false)
        local defaultTime = objSpine.Skeleton.Data:FindAnimation(intoName).Duration
        self:addSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, self.spineBaseData.BaseAction, true, defaultTime)
        self.intoAnifinishTimer = DLuaTimer:DoAfter(defaultTime, function()
            self:intoAnimationFinish(objSpine)
            self.intoAnifinishTimer = nil
        end)
    else
        self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, self.spineBaseData.BaseAction, true)
        if self.intoFinishCallBack then
            self.intoFinishCallBack()
            self.intoFinishCallBack = nil
        end
        self.skipMask:SetActive(false)
        self.skipBtn:SetActive(false)
    end
end

--初始化spine状态
function RoleInteractionArea:initSpineState()
    if not self.nowPosterSpine then
        return
    end
    if self.nowPosterSpine.transform:Find("ClickBtn") then--旧版基础点击
        self.isOldMode = true
        self.nowPosterSpine.transform:Find("ClickBtn").gameObject:SetActive(true)
        self:doDialogAndActionOld(self.nowPosterSpine.transform:Find("ClickBtn"):GetComponent("Button"))
    else--部位点击初始化
        self.isOldMode = false
        self.spineStateData = {}
        self.skinActionConfigMap = Config.GetSkinActionInfoBySkinId(ClientData:GetPosterData().SkinId)
        if not self.skinActionConfigMap then
            return
        end
        --LuaLogger.ds(">>>>>>skinActionConfigMap<<<<<<<",tablex.dump(self.skinActionConfigMap))
        for _, skinActionConfig in pairs(self.skinActionConfigMap) do
            if skinActionConfig.type == GE.SkinActionType.Base then--基础类型
                self.spineStateData[skinActionConfig.type] = skinActionConfig.id
            end
        end
        self.spineStateData[GE.SkinActionType.HoldChange] = 0--变身状态
        self.spineStateData[GE.SkinActionType.PartChange] = {}--插槽类型
        local clickArea = self.nowPosterSpine.transform:Find("RoleClickArea")
        if clickArea then
            clickArea.gameObject:SetActive(true)
        end
    end
    --判断是否需要加载挂机逻辑(目前仅主界面办公室模式启用)
    local mainPanel = UIMgr:getUIData("MainPanel")
    if mainPanel and mainPanel.ui.nowMode == mainPanel.ui.modeList.office then
		self:resetUserIdleData()
	end

    self.canClick = true
end

--初始化玩家挂机语音互动
function RoleInteractionArea:resetUserIdleData()
    self:resetIdleTime()
    if self.userIdleTimer then
        DLuaTimer:RemoveTimer(self.userIdleTimer)
        self.userIdleTimer = nil
    end
    local linesConfigGroup = Config.GetHomeScreenLinesInfoBySkinId(ClientData:GetPosterData().SkinId)
    self.userIdleDialogList = {}
    for _, lineConfig in pairs(linesConfigGroup or {}) do
        if lineConfig.specialConditions and lineConfig.specialConditions[1] == 1 then
            table.insert(self.userIdleDialogList, lineConfig)
        end
    end
    self.userIdleTimer = DLuaTimer:DoRepeatForever(1, function()
        self.idleTime = self.idleTime + 1
        for _, lineConfig in pairs(self.userIdleDialogList) do
            if self.idleTime >= lineConfig.specialConditions[2] then
                for _, actionConfig in pairs(self.skinActionConfigMap or {}) do
                    if actionConfig.triggerType == 40 then--挂机触发
                        self:checkTriggerType(actionConfig.triggerType, true)
                        self:resetIdleTime()
                        return
                    end
                end
            end
        end
		--LuaLogger.ds(">>>>>>userIdleTimer<<<<<<<", self.idleTime)
	end)
end

--移除玩家挂机语音互动
function RoleInteractionArea:clearUserIdleData()
    self:resetIdleTime()
    if self.userIdleTimer then
        DLuaTimer:RemoveTimer(self.userIdleTimer)
        self.userIdleTimer = nil
    end
end

function RoleInteractionArea:Update()
    if self.nowAudioKey then
        local dbValue = AudioMgr:getNowVoiceDB(self.nowAudioKey)
        local nowObj = self.nowPosterSpine
        if UICommonUtils.Checkobj(nowObj) then
            local abjSpineAnim = self.nowPosterSpine:GetComponent("SkeletonAnimation")
            --获取当前播放的表情名称
            local newTrack = GE.RoleSpineActionType.Emote
            if abjSpineAnim.AnimationState:GetTrack(newTrack) then
                self.nowName = abjSpineAnim.AnimationState:GetTrack(newTrack).Animation.Name
                if dbValue <= -140 then
                    local nowName = abjSpineAnim.AnimationState:GetTrack(newTrack).Animation.Name
                    if string.find(nowName, "_talk") then
                        local poseName = string.gsub(nowName, "_talk", "")
                        self:setSpineAnimation(abjSpineAnim, newTrack, poseName, true)
                    end
                elseif dbValue > -130 then
                    local nowName = abjSpineAnim.AnimationState:GetTrack(newTrack).Animation.Name
                    if not string.find(nowName, "_talk") then
                        local newName = nowName.."_talk"
                        self:setSpineAnimation(abjSpineAnim, newTrack, newName, true)
                    end
                end
            end
        end
    end

    if not self.canClick then
        return
    end
    if self.intoAnifinishTimer then
        return
    end
    if Input.GetMouseButtonDown(0) then
        self:resetIdleTime()
        if self:isPointerOverUIObject() then
            return
        end
        self.clickArea = self:checkClickArea()
        self.mouseDownPosition = Input.mousePosition
        --检测当前对话是否有会被点击打断的特殊对话
        self:checkInterruptDialog()
    end
    if Input.GetMouseButton(0) then
        self:onDragResult()
    end
    if Input.GetMouseButtonUp(0) then
        self:onClickResult()
    end
end

--确认点击区域
function RoleInteractionArea:checkClickArea()
    local UICamera = UIMgr.uiCamera
    local mousePos = Input.mousePosition
    mousePos.z = 10 --设置鼠标位置的Z轴
    local worldPos = UICamera:ScreenToWorldPoint(mousePos)
    local collidersArray = UnityEngine.Physics2D.OverlapPointAll(worldPos)
    local collidersTable = {}

    for i = 0, collidersArray.Length - 1 do
        collidersTable[#collidersTable + 1] = collidersArray[i]
    end
    local clickArea = nil
    if next(collidersTable) then
        if #collidersTable == 1 then
            clickArea = collidersTable[1].gameObject.name
        end
        for _, collider in pairs(collidersTable) do
            local hitObj = collider.gameObject
            local name = hitObj.name
            if name ~= "all" then
                clickArea = name
                break
            end
        end
    else
        clickArea = nil
    end
    return clickArea
end

--检测是否有打断对话
function RoleInteractionArea:checkInterruptDialog()
    if self.nowLineId then
        self.needInterruptDialog = false
        local linesConfigGroup = Config.GetHomeScreenLinesInfoBySkinId(ClientData:GetPosterData().SkinId)
        local interruptDialogList = {}
        for _, lineConfig in pairs(linesConfigGroup or {}) do
            if lineConfig.specialConditions and lineConfig.specialConditions[1] == 2 then
                table.insert(interruptDialogList, lineConfig)
            end
        end
        for _, lineConfig in pairs(interruptDialogList) do
            if self.nowLineId == lineConfig.specialConditions[2] then
                for _, actionConfig in pairs(self.skinActionConfigMap) do
                    if actionConfig.triggerType == 41 then--打断对话触发
                        self.needInterruptDialog = true
                        return
                    end
                end
            end
        end
    end
end

--处理拖拽结果
function RoleInteractionArea:onDragResult()
    if (not self.clickArea) then--没有点击区域
        return
    end
    self.mouseNowPosition = Input.mousePosition

    --计算位置差值
    local deltaX = self.mouseNowPosition.x - self.mouseDownPosition.x
    local deltaY = self.mouseNowPosition.y - self.mouseDownPosition.y
    local distance = math.sqrt(deltaX * deltaX + deltaY * deltaY)
    --LuaLogger.ds(">>>>>>distance<<<<<<<",distance)
    if distance < 5 then--拖拽距离过短不处理
        return
    end

    if not self.isDragging then--初始化拖拽
        self:checkTriggerType(21)   --触发类型为拖拽
    end

    --扇形范围限制
    if self:sectorRangeLimit(deltaX, deltaY) then
        return
    end

    self.isDragging = true
    self:doSpineProgress()
end

--扇形范围限制
-- directionAngle: 可拖动中心方向角度（基于transform.rotation.z），单位：度，nil时自动取rotation.z，默认0
-- sectorAngle:    可拖动扇形范围总角度，单位：度，nil或<=0或>=360则不限制方向
function RoleInteractionArea:sectorRangeLimit(deltaX, deltaY)
    if not self.nowActionCfg then
        return false
    end
    if self.nowActionCfg.interactType ~= 3 then
        return false
    end
    local nowParameter = self.nowActionCfg.parameter or {}
    local directionAngle = nowParameter and nowParameter[1] and nowParameter[1][3] or nil
    local sectorAngle = nowParameter and nowParameter[1] and nowParameter[1][4] or nil
    if sectorAngle and sectorAngle > 0 and sectorAngle < 360 then
        --中心方向：优先用参数1，否则取transform.rotation.z，再默认0
        local centerAngle = directionAngle
        if centerAngle == nil then
            local rot = self.transform and self.transform.rotation
            centerAngle = rot and rot.z or 0
        end

        --计算当前拖动方向角度（度），atan2标准：右=0°，上=90°，左=±180°，下=-90°
        local dragAngle = math.atan2(deltaY, deltaX) * 180 / math.pi

        --计算与中心方向的差值，归一化到[-180, 180]
        local diff = dragAngle - centerAngle
        diff = diff - math.floor((diff + 180) / 360) * 360

        --超出扇形范围则不处理拖拽
        if math.abs(diff) > sectorAngle * 0.5 then
            return true
        end
    end

    return false
end

--处理点击结果
function RoleInteractionArea:onClickResult()
    if self.isDragging then
        self.isDragging = false
        self:resetSpineProgress()
        return
    end
    if (not self.clickArea) or self.clickArea ~= self:checkClickArea() then--点击区域发生变化
        self.clickArea = nil
        return
    end

    if self.needInterruptDialog then
        self:checkTriggerType(41, true)--触发打断对话的特殊对话
        self.needInterruptDialog = false
    else
        self:checkTriggerType(10)   --触发类型为点击
    end
end

--根据触发类型处理不同表现
function RoleInteractionArea:checkTriggerType(triggerType, canAllArea)
    --如果有变身状态则使用其数据，否则使用基础状态数据
    local skinActionId = 0
    if self.spineStateData[GE.SkinActionType.HoldChange] ~= skinActionId then
        skinActionId = self.spineStateData[GE.SkinActionType.HoldChange]
    else
        skinActionId = self.spineStateData[GE.SkinActionType.Base]
    end
    local skinActionConfig = self.skinActionConfigMap[skinActionId]
    if not skinActionConfig then
        return
    end
    local changeParameter = skinActionConfig.changeParameter
    for _, data in pairs(changeParameter) do
        local skinActionId = data[2]
        local newActionConfig = self.skinActionConfigMap[skinActionId]
        if canAllArea then
            if newActionConfig.triggerType == triggerType then
                --根据类型处理不同表现
                self:doSkinAction(newActionConfig)
            end
        else
            if newActionConfig.area == self.clickArea then
                if newActionConfig.triggerType == triggerType then
                    --根据类型处理不同表现
                    self:doSkinAction(newActionConfig)
                end
            end
        end
    end
end

--执行皮肤动作
---@param newActionConfig SkinActionTable
function RoleInteractionArea:doSkinAction(newActionConfig)
    self.partOpen = GE.SkinPartChangeState.Close
    self.needResetAction = false
    self.nowActionCfg = newActionConfig
    local nowActionId = self.nowActionCfg.id
    local nowActionType = self.nowActionCfg.type
    local spineStateData = self.spineStateData[nowActionType]
    if nowActionType == GE.SkinActionType.Base then--基础类型
        spineStateData = nowActionId
        --进入基础状态时清除变身状态
        self.spineStateData[GE.SkinActionType.HoldChange] = 0
        self.isActionListMode = false
    elseif nowActionType == GE.SkinActionType.HoldChange then--变身状态
        --self:clearAction()
        self:stopSpineAction()
        self.spineStateData[nowActionType] = nowActionId
        self.isActionListMode = true
    elseif nowActionType == GE.SkinActionType.PartChange then--插槽类型
        local partTrack = newActionConfig.parameter[1][1]
        if spineStateData[partTrack] == nowActionId then
            self.partOpen = GE.SkinPartChangeState.Close
            spineStateData[partTrack] = nil
        elseif not spineStateData[partTrack] then
            self.partOpen = GE.SkinPartChangeState.Open
            spineStateData[partTrack] = nowActionId
        elseif spineStateData[partTrack] and (spineStateData[partTrack] ~= nowActionId) then
            self.partOpen = GE.SkinPartChangeState.Change
            spineStateData[partTrack] = nowActionId
        end
    elseif nowActionType == GE.SkinActionType.ChangeToBase then--自动切换回基础状态
        self.spineStateData[GE.SkinActionType.HoldChange] = 0
        self.isActionListMode = false
        self.needResetAction = true
    end
    if newActionConfig.interactType == 1 then--插槽部位替换
        self:doSpinePart(newActionConfig.parameter)
    elseif newActionConfig.interactType == 2 then--动作+台词
        local needId = newActionConfig.parameter[1]
        self:getDialogList(needId, newActionConfig.area)
        self:doDialog(newActionConfig.interactType)
    elseif newActionConfig.interactType == 3 then--控制进度动作
        self:initSpineProgress(newActionConfig)
    elseif newActionConfig.interactType == 4 then--动作替换
        self:doSpineAction(nil, newActionConfig.parameter)
    elseif newActionConfig.interactType == 5 then--插槽部位+台词
        local needId = newActionConfig.parameter[1][2]
        self:getDialogList(needId, newActionConfig.area)
        self:doDialog(newActionConfig.interactType)
    elseif newActionConfig.interactType == 6 then--指定动作+台词(指定HomeScreenLines表ID)
        local needLineId = newActionConfig.parameter[1]
        self.nowDialogList = {{index = needLineId, weight = 100}}
        self:doDialog(newActionConfig.interactType)
    end

    self.lastActionCfg = newActionConfig
end

--显示台词
---@param actionType? integer 互动类型
function RoleInteractionArea:doDialog(actionType)
    --LuaLogger.ds(">>>>>>nowDialogList<<<<<<<",tablex.dump(self.nowDialogList))
    if next(self.nowDialogList) then
        if self.nowAudioKey then
            AudioMgr:stopVoice(self.nowAudioKey)
            self.nowAudioKey = nil
            self.nowLineId = nil
        end
        if self.dialogBoxTimer then
            DLuaTimer:RemoveTimer(self.dialogBoxTimer)
            self:setDialogActive(false)
            self.dialogBoxTimer = nil
        end
        local screenLineId = DLuaUtil.getRandomIndexLinear(self.nowDialogList, self.random)
        local screenLineConfig = Config.GetHomeScreenLinesInfo(screenLineId)
        local nowLineConfig = Config.GetScriptLinesInfo(screenLineConfig.lineId)
        if nowLineConfig then
            if nowLineConfig.resource then--有音频
                self.nowLineId = nowLineConfig.id
                self.nowAudioKey = UICommonUtils.Play2DVoiceByLanguage(self.roleCid, nowLineConfig.resource, function()
                    self.dialogBoxTimer = DLuaTimer:DoAfter(1, function()
                        self:setDialogActive(false)
                        self.dialogBoxTimer = nil
                        self.changeActionList = {}
                        self:stopSpineAction()
                    end)
                    self.nowAudioKey = nil
                    self.nowLineId = nil
                end, self.gameObject)
            else--无音频
                local needTime = #nowLineConfig.line / 3
                self.dialogBoxTimer = DLuaTimer:DoAfter(needTime, function()
                    self:setDialogActive(false)
                    self.dialogBoxTimer = nil
                    self.changeActionList = {}
                    self:stopSpineAction()
                end)
            end
            --检测并设置文本配置中人物动作和表情修改
            local words = self:checkActionInDoDialog(nowLineConfig.line)
            self:setDialogActive(true)
            self.dialogText.text.text = words
            self.dialogArrow:SetActive(self:checkDialogTextOverFlow())
        end

        -- 触发动作
        if actionType and self.nowPosterSpine then
            local needActionId = screenLineConfig.actId
            if actionType == 2 or actionType == 6 then
                self:doSpineAction(needActionId)
            elseif actionType == 5 then
                self:doSpinePart(nil, needActionId)
            end
        end
    else
        if actionType == 5 then--需要台词但部分状态无台词插槽
            self:doSpinePart(nil, self.nowPartActionId)
        end
    end
end

--执行spine动作
---@param actionId? number
---@param needList? table
function RoleInteractionArea:doSpineAction(actionId, needList)
    --表情动作双轨道
    local nowObj = self.nowPosterSpine
    if not UICommonUtils.Checkobj(nowObj) then
        return
    end
    local actionList = {}
    if actionId and actionId ~= 0 then
        actionList = Config.GetActionDesignInfoByGroupId(actionId)
    end
    if needList then
        for _, needData in ipairs(needList) do
            local actionType = needData[1]
            local resourceName = needData[2]
            local newActConfig = {
                resource = resourceName,
                basicType = actionType,
                actType = 2,
            }
            table.insert(actionList, newActConfig)
        end
    end

    local spineAnimation = nowObj:GetComponent("SetSpineAnimation")
    local objSpine = nowObj:GetComponent("SkeletonGraphic")
    local objSpineAnim = nowObj:GetComponent("SkeletonAnimation")

    --若不存在动作则直接返回
    for _, actionData in pairs(actionList) do
        local actionName = actionData.resource
        if not spineAnimation:CheckAnimationExist(actionName) then
            return
        end
    end

    --设置默认动作
    local setSpineBaseDataFunc = function(actionType, name)
        local actionKey, emoteKey
        --基础状态参数修改未来若有需求，将在基础状态id修改时改变赋值
        -- if self.nowActionCfg.type == GE.SkinActionType.Base then
        --     actionKey = "BaseAction"
        --     emoteKey = "BaseEmote"
        if self.nowActionCfg.type == GE.SkinActionType.HoldChange then
            actionKey = "Action"
            emoteKey = "Emote"
        end
        if actionType == GE.RoleSpineActionType.Action and actionKey then
            self.spineBaseData[actionKey] = name
        elseif actionType == GE.RoleSpineActionType.Emote and emoteKey then
            local newName = string.gsub(name, "_talk", "")
            self.spineBaseData[emoteKey] = newName
        end
    end

    --首先分出表情与动作
    local poseList = {}
    local emoteList = {}
    for _, actionConfig in pairs(actionList) do
        setSpineBaseDataFunc(actionConfig.basicType, actionConfig.resource)
        if actionConfig.basicType == GE.RoleSpineActionType.Emote then
            table.insert(emoteList, actionConfig)
        elseif actionConfig.basicType == GE.RoleSpineActionType.Action then
            --先将需要拼接的动作拆分放入列表
            local lastEndName = ""
            local newBeginName = ""

            local newName = actionConfig.resource
            newBeginName = string.gsub(newName, "_idle", "_begin")
            local nowName = objSpineAnim.AnimationState:GetTrack(actionConfig.basicType).Animation.Name
            lastEndName = string.gsub(nowName, "_idle", "_end")

            local newActConfig = {
                basicType = GE.RoleSpineActionType.Action,
                actType = 2,
            }

            if lastEndName ~= nowName and spineAnimation:CheckAnimationExist(lastEndName) then
                newActConfig.resource = lastEndName
                table.insert(poseList, clone(newActConfig))
            end

            if newBeginName ~= newName and spineAnimation:CheckAnimationExist(newBeginName) then
                newActConfig.resource = newBeginName
                table.insert(poseList, clone(newActConfig))
            end

            table.insert(poseList, actionConfig)
        end
    end

    --动作轨道
    local actionTime = 0
    local changeFinishtime = 0
    for k, poseConfig in pairs(poseList) do
        local setTrack = poseConfig.basicType
        local poseName = poseConfig.resource
        local isLoop = poseConfig.actType == 1

        if k == 1 then
            actionTime = objSpine.Skeleton.Data:FindAnimation(poseName).Duration
            self:setSpineAnimation(objSpineAnim, setTrack, poseName, isLoop)
        else
            local defaultTime = objSpine.Skeleton.Data:FindAnimation(poseList[k - 1].resource).Duration
            self:addSpineAnimation(objSpineAnim, setTrack, poseName, isLoop, defaultTime)
            changeFinishtime = changeFinishtime + defaultTime
            actionTime = actionTime + defaultTime
        end
    end

    if self.actionListModeTimer then
        DLuaTimer:RemoveTimer(self.actionListModeTimer)
        self.actionListModeTimer = nil
        self.canClick = true
    end
    if changeFinishtime > 0 then
        self.canClick = false
        self.actionListModeTimer = DLuaTimer:DoAfter(changeFinishtime, function()
            self.canClick = true
            self.actionListModeTimer = nil
        end)
    end
    if self.needResetAction then
        if self.needResetActionTimer then
            DLuaTimer:RemoveTimer(self.needResetActionTimer)
            self.needResetActionTimer = nil
        end
        self.canClick = false
        self.needResetActionTimer = DLuaTimer:DoAfter(actionTime, function()
            self:stopSpineAction()
            self.canClick = true
            self.needResetActionTimer = nil
        end)
    end

    --表情轨道
    if next(emoteList) then
        for k, emoteConfig in pairs(emoteList) do
            local setTrack = emoteConfig.basicType
            local emoteName = emoteConfig.resource
            local isLoop = emoteConfig.actType == 1

            if k == 1 then
                self:setSpineAnimation(objSpineAnim, setTrack, emoteName, isLoop)
            else
                local defaultTime = objSpine.Skeleton.Data:FindAnimation(emoteList[k - 1].resource).Duration
                self:addSpineAnimation(objSpineAnim, setTrack, emoteName, true, defaultTime)
            end
        end
    else
        objSpineAnim.AnimationState:ClearTrack(GE.RoleSpineActionType.Emote)
    end
    --LuaLogger.ds(">>>>>>doSpineAction poseList<<<<<<<",tablex.dump(poseList))
    --LuaLogger.ds(">>>>>>doSpineAction emoteList<<<<<<<",tablex.dump(emoteList))
end

--检测并设置文本配置中人物动作和表情修改
function RoleInteractionArea:checkActionInDoDialog(words)
    if next(self.changeActionTimerList) then
        for _, timer in pairs(self.changeActionTimerList) do
            DLuaTimer:RemoveTimer(timer)
        end
    end
    --检测
    self.changeActionList = {}
    local pos = 1
    local actionPattern = GE.StoryTextRegex.ActionAndTime
    for i = 1, #words do
        local startPos, endPos = string.find(words, actionPattern, pos)
        if not startPos then break end

        -- 取出匹配的子串
        local matchedStr = string.sub(words, startPos, endPos)
        -- 提取配置部分
        local actionGroup, delayTime = string.match(matchedStr, actionPattern)

        table.insert(self.changeActionList, {
            action = tonumber(actionGroup),
            delay = tonumber(delayTime),
        })
        -- 更新起始搜索位置
        pos = endPos + 1
    end
    --LuaLogger.ds(">>>>>>changeActionList<<<<<<<",tablex.dump(self.changeActionList))
    --设置
    if not self.isOldMode then
        if next(self.changeActionList) then
            for i, data in pairs(self.changeActionList) do
                self.changeActionTimerList[i] = DLuaTimer:DoAfter(data.delay, function()
                    self:doSpineAction(data.action)
                end)
            end
        end
    end
    --返回处理后的文本
    words = string.gsub(words, actionPattern, "")
    return words
end

--替换spine部位
---@param partConfig? table
---@param actionId? integer 
function RoleInteractionArea:doSpinePart(partConfig, actionId)
    --插槽轨道
    local nowObj = self.nowPosterSpine
    if not UICommonUtils.Checkobj(nowObj) then
        return
    end

    local actionList = {}
    if partConfig then
        for _, needData in ipairs(partConfig) do
            local actionType = needData[1]
            local resourceName = needData[2]
            local newActConfig = {
                resource = resourceName,
                basicType = actionType,
            }
            table.insert(actionList, newActConfig)
        end
    end
    if actionId then
        actionList = Config.GetActionDesignInfoByGroupId(actionId)
    end
    --LuaLogger.ds(">>>>>>doSpinePart actionList<<<<<<<",tablex.dump(actionList))
    local objSpine = nowObj:GetComponent("SkeletonGraphic")
    local objSpineAnim = nowObj:GetComponent("SkeletonAnimation")
    local spineAnimation = nowObj:GetComponent("SetSpineAnimation")

    for k, poseConfig in pairs(actionList) do
        local setTrack = poseConfig.basicType
        local poseName = poseConfig.resource
        local isLoop = true
        local newName = ""
        if self.partOpen == GE.SkinPartChangeState.Open then
            newName = string.gsub(poseName, "idle", "begin")
            if spineAnimation:CheckAnimationExist(newName) then
                self:setSpineAnimation(objSpineAnim, setTrack, newName, false)
                local defaultTime = objSpine.Skeleton.Data:FindAnimation(newName).Duration
                self:addSpineAnimation(objSpineAnim, setTrack, poseName, isLoop, defaultTime)
            else
                self:setSpineAnimation(objSpineAnim, setTrack, poseName, isLoop)
            end
        elseif self.partOpen == GE.SkinPartChangeState.Change then
            local currentAnimation = objSpineAnim.AnimationState:GetTrack(setTrack)
            if currentAnimation then
                local nowName = currentAnimation.Animation.Name
                local needStr1 = string.gsub(nowName, "_idle", "")
                local needStr2 = string.gsub(poseName, "_idle", "")
                local newName = needStr1.."to"..needStr2
                if spineAnimation:CheckAnimationExist(newName) then
                    self:setSpineAnimation(objSpineAnim, setTrack, newName, false)
                    local defaultTime = objSpine.Skeleton.Data:FindAnimation(newName).Duration
                    self:addSpineAnimation(objSpineAnim, setTrack, poseName, isLoop, defaultTime)
                else
                    self:setSpineAnimation(objSpineAnim, setTrack, poseName, isLoop)
                end
            end
        elseif self.partOpen == GE.SkinPartChangeState.Close then
            newName = string.gsub(poseName, "idle", "end")
            if spineAnimation:CheckAnimationExist(newName) then
                local endEntry = self:setSpineAnimation(objSpineAnim, setTrack, newName, false)
                endEntry.Complete = endEntry.Complete + function()
                    -- 动画播放完毕后清空轨道动画，淡出时间为动画时长
                    objSpineAnim.AnimationState:SetEmptyAnimation(setTrack, 0.1)
                end
            else
                if objSpineAnim.AnimationState:GetTrack(setTrack) then
                    objSpineAnim.AnimationState:SetEmptyAnimation(setTrack, 0.1)
                end
            end
        end
    end
end

--初始化spine进度动作
---@param newActionConfig SkinActionTable
function RoleInteractionArea:initSpineProgress(newActionConfig)
    --进度轨道
    local nowObj = self.nowPosterSpine
    if not UICommonUtils.Checkobj(nowObj) then
        return
    end

    local actionList = newActionConfig.parameter
    local objSpineAnim = nowObj:GetComponent("SkeletonAnimation")

    for k, poseConfig in pairs(actionList) do
        local setTrack = poseConfig[1]
        local poseName = poseConfig[2]
        self.progressTrackList[setTrack] = self:setSpineAnimation(objSpineAnim, setTrack, poseName, false)
        self.progressTrackList[setTrack].TimeScale = 0
    end
end

--控制spine进度动作
function RoleInteractionArea:doSpineProgress()
    for key, progressTrack in pairs(self.progressTrackList) do
        local maxTime = progressTrack.AnimationEnd
        local deltaX = self.mouseNowPosition.x - self.mouseDownPosition.x
        local deltaY = self.mouseNowPosition.y - self.mouseDownPosition.y
        local distance = math.sqrt(deltaX * deltaX + deltaY * deltaY)
        local progress = distance / 100
        progressTrack.TrackTime = maxTime * progress
    end
end

--重置spine进度动作
function RoleInteractionArea:resetSpineProgress()
    local nowObj = self.nowPosterSpine
    if not UICommonUtils.Checkobj(nowObj) then
        return
    end
    --TODO: 进度动作需要根据不同结束类型处理
    local objSpineAnim = nowObj:GetComponent("SkeletonAnimation")
    for track, _ in pairs(self.progressTrackList) do
        if objSpineAnim.AnimationState:GetTrack(track) then
            objSpineAnim.AnimationState:SetEmptyAnimation(track, 0.1)
        end
    end
end

--角色点击显示动作台词(老)
function RoleInteractionArea:doDialogAndActionOld(clickBtn)
    clickBtn.onClick:RemoveAllListeners()
    clickBtn.onClick:AddListener(function ()
        if not self.canClick then
            return
        end
        if next(self.nowDialogList) then
            if self.nowAudioKey then
                AudioMgr:stopVoice(self.nowAudioKey)
                self.nowAudioKey = nil
                self.nowLineId = nil
            end
            if self.dialogBoxTimer then
                DLuaTimer:RemoveTimer(self.dialogBoxTimer)
                self:setDialogActive(false)
                self.dialogBoxTimer = nil
            end
            local screenLineId = DLuaUtil.getRandomIndexLinear(self.nowDialogList, self.random)
            local screenLineConfig = Config.GetHomeScreenLinesInfo(screenLineId)
            local nowLineConfig = Config.GetScriptLinesInfo(screenLineConfig.lineId)
            if nowLineConfig.resource then--有音频
                self.nowLineId = nowLineConfig.id
                self.nowAudioKey = UICommonUtils.Play2DVoiceByLanguage(self.roleCid, nowLineConfig.resource, function()
                    self.dialogBoxTimer = DLuaTimer:DoAfter(1, function()
                        self:setDialogActive(false)
                        self.dialogBoxTimer = nil
                    end)
                    self.nowAudioKey = nil
                    self.nowLineId = nil
                    self:stopSpineActionOld()
                end, self.gameObject)
                --测试版只接入嘴型动作
                if self.nowPosterSpine then
                    local objSpineAnim = self.nowPosterSpine:GetComponent("SkeletonAnimation")
                    self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Emote, "idle_talk", true)
                    self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, "idle_action", true)
                end  
            else--无音频
                local needTime = #nowLineConfig.line / 3
                self.dialogBoxTimer = DLuaTimer:DoAfter(needTime, function()
                    self:setDialogActive(false)
                    self.dialogBoxTimer = nil
                end)
            end
            self:setDialogActive(true)
            self.dialogText.text.text = nowLineConfig.line
        end
        self.dialogArrow:SetActive(self:checkDialogTextOverFlow())
    end)

    self:getDialogList(ClientData:GetPosterData().SkinId)
end

--获取所需对话
---@param skinId integer 皮肤ID
---@param partName? string 部位名称
function RoleInteractionArea:getDialogList(skinId, partName)
    local needPart = (partName == "all") and "" or (partName or "")
    local linesConfigGroup = Config.GetHomeScreenLinesInfoBySkinId(skinId)
    self.nowDialogList = {}
    for _, linesConfig in pairs(linesConfigGroup or {}) do
        if linesConfig.pointArea == needPart then
            --条件筛选
            local canPlay = true
            if linesConfig.specialConditions and next(linesConfig.specialConditions) then
                canPlay = self:checkNormalRule(linesConfig)
            end
            --特殊筛选
            canPlay = canPlay and self:checkSpicalRule(linesConfig)
            if canPlay then
                table.insert(self.nowDialogList, {index = linesConfig.id, weight = linesConfig.weight})
            end
        end
    end
end

--处理条件筛选方法
function RoleInteractionArea:checkNormalRule(lineConfig)
    if not lineConfig.specialConditions or not next(lineConfig.specialConditions) then
        return true
    end
    local condType = lineConfig.specialConditions[1]
    local condValue = lineConfig.specialConditions[2]
    if condType == 1 or condType == 2 then
        return false--该类型已在其他逻辑中处理，无需在此处理

    elseif condType == 4 then--对应插槽状态类型才可播放
        local nowPartState = self.partOpen
        self.nowPartActionId = lineConfig.actId
        if condValue ~= nowPartState then
            return false
        end
    end
    return true
end

--处理特殊条件筛选方法
function RoleInteractionArea:checkSpicalRule(lineConfig)
    --出现时段筛选
    if tablex.next(lineConfig.time) then
        local now = os.date("*t", os.time())
        local hour = now.hour
        for key, timePeriod in pairs(lineConfig.time) do
            local startTime = timePeriod[1]
            local endTime = timePeriod[2]
            if startTime <= hour and hour < endTime then
                return true
            end
        end
        return false
    end
    --好感度筛选
    if lineConfig.affectionLevel ~= 0 then
        local roleData = Me:getPlayerHero(self.roleCid)
        local maxClaimedLevel = 0
        if roleData and roleData.affectionRewardList then
            for _, level in pairs(roleData.affectionRewardList) do
                if level > maxClaimedLevel then
                    maxClaimedLevel = level
                end
            end
        end
        if maxClaimedLevel >= lineConfig.affectionLevel then
            return true
        else
            return false
        end
    end
    return true
end

--设置对话框位置
function RoleInteractionArea:setDialogBoxPosition(needObj)
    self.dialogBox.transform.position = needObj.transform.position
end

--停止spine动画
function RoleInteractionArea:stopSpineAction()
    if self.nowPosterSpine and UICommonUtils.Checkobj(self.nowPosterSpine) then
        local objSpine = self.nowPosterSpine:GetComponent("SkeletonGraphic")
        local objSpineAnim = self.nowPosterSpine:GetComponent("SkeletonAnimation")
        local spineAnimation = self.nowPosterSpine:GetComponent("SetSpineAnimation")
        --如果有变身状态则使用其数据，否则使用基础状态数据
        local skinActionId = 0
        if self.spineStateData[GE.SkinActionType.HoldChange] ~= skinActionId then
            skinActionId = self.spineStateData[GE.SkinActionType.HoldChange]
            if not self.skinActionConfigMap then
                return
            end
            local skinActionConfig = self.skinActionConfigMap[skinActionId]
            if not skinActionConfig then
                return
            end
            local actionName, emoteName
            actionName = self.spineBaseData.Action
            emoteName = self.spineBaseData.Emote
            if actionName then
                local currentAnimation = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Action)
                if currentAnimation then
                    if currentAnimation.Animation.Name ~= actionName then
                        local newName = string.gsub(currentAnimation.Animation.Name, "idle", "end")
                        if spineAnimation:CheckAnimationExist(newName) then
                            self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, newName, false)
                            local defaultTime = objSpine.Skeleton.Data:FindAnimation(newName).Duration
                            self:addSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, actionName, true, defaultTime)
                        else
                            self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, actionName, true)
                        end
                    end
                end
            end
            if emoteName then
                self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Emote, emoteName, true)
            else
                self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Emote, self.spineBaseData.BaseEmote, true)
            end
        else
            self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Emote, self.spineBaseData.BaseEmote, true)
            local currentAnimation = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Action)
            if currentAnimation then
                if currentAnimation.Animation.Name ~= self.spineBaseData.BaseAction then
                    local newName = string.gsub(currentAnimation.Animation.Name, "idle", "end")
                    if spineAnimation:CheckAnimationExist(newName) and newName ~= currentAnimation.Animation.Name then
                       self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, newName, false)
                       local defaultTime = objSpine.Skeleton.Data:FindAnimation(newName).Duration
                       self:addSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, self.spineBaseData.BaseAction, true, defaultTime)
                    else
                        self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, self.spineBaseData.BaseAction, true)
                    end
                end
            end
        end
    end
end

--停止spine动画(旧版)
function RoleInteractionArea:stopSpineActionOld()
    if self.nowPosterSpine and UICommonUtils.Checkobj(self.nowPosterSpine) then
        local objSpineAnim = self.nowPosterSpine:GetComponent("SkeletonAnimation")
        self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Emote, self.spineBaseData.BaseEmote, true)
        local currentAnimation = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Action)
        if currentAnimation then
            if currentAnimation.Animation.Name ~= self.spineBaseData.BaseAction then
                self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, self.spineBaseData.BaseAction, true)
            end
        end
    end
end

--判断文字框知否超过显示范围
---@return boolean
function RoleInteractionArea:checkDialogTextOverFlow()
    local textHeight = self.dialogText.text.preferredHeight
    if textHeight > 140 then
        return true
    else
        return false
    end
end

--设置图片位置
function RoleInteractionArea:setImagePosition(newX, newY)
    self.skinImg.rectTransform.anchoredPosition = Vector2.New(newX, newY)
end

--设置spine位置
function RoleInteractionArea:setSpineScale(newX, newY)
    self.spineRoot.rectTransform.localScale = Vector3.New(newX, newY, 1)
end

--设置点击屏蔽
function RoleInteractionArea:setClickEnabled(enabled)
    self.canClick = enabled
end

--设置是否需要Into动画
function RoleInteractionArea:setNeedIntoAnimation(needInto)
    self.needIntoAnim = needInto
end

--设置Into动画完成回调
function RoleInteractionArea:setIntoFinishCallBack(callback)
    self.intoFinishCallBack = callback
end

--置空当前语音文字动作
function RoleInteractionArea:clearAction()
    if self.nowAudioKey then
        AudioMgr:stopVoice(self.nowAudioKey)
        self.nowAudioKey = nil
        self.nowLineId = nil
    end
    if self.dialogBoxTimer then
        DLuaTimer:RemoveTimer(self.dialogBoxTimer)
        self:setDialogActive(false)
        self.dialogBoxTimer = nil
    end
    if next(self.changeActionTimerList) then
        for _, timer in pairs(self.changeActionTimerList) do
            DLuaTimer:RemoveTimer(timer)
        end
        self.changeActionTimerList = {}
    end
    if self.intoAnifinishTimer then
        DLuaTimer:RemoveTimer(self.intoAnifinishTimer)
        self.intoAnifinishTimer = nil
    end
    if self.isOldMode then
        self:stopSpineActionOld()
    else
        self:stopSpineAction()
    end
end

--判断是否点击在ui上
function RoleInteractionArea:isPointerOverUIObject()
	if (not EventSystem.current) then
		return false
	end
	local eventDataCurrentPosition = UnityEngine.EventSystems.PointerEventData(EventSystem.current)
	eventDataCurrentPosition.position = Input.mousePosition
	local results = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	EventSystem.current:RaycastAll(eventDataCurrentPosition, results)
    for i = 0, results.Count - 1 do
		local hit = results[i]
        if hit.gameObject:GetComponent("Button") or hit.gameObject:GetComponent("ScaleButton") then
            return true
        end
	end
    local panelName = UIMgr:getCurUIName()
    if panelName ~= "MainPanel" then
        return true
    end
    --引导状态下也屏蔽点击
    if GuideMgr:GetGuideOnCurrPanel() == true then
        return true
    end
end

--跳过into动画
function RoleInteractionArea:skipIntoAnimation()
    if self.nowPosterSpine and UICommonUtils.Checkobj(self.nowPosterSpine) then
        if self.intoAnifinishTimer then
            DLuaTimer:RemoveTimer(self.intoAnifinishTimer)
            self.intoAnifinishTimer = nil
        end
        local objSpine = self.nowPosterSpine:GetComponent("SkeletonGraphic")
        local objSpineAnim = self.nowPosterSpine:GetComponent("SkeletonAnimation")
        self:setSpineAnimation(objSpineAnim, GE.RoleSpineActionType.Action, self.spineBaseData.BaseAction, true)
        self:intoAnimationFinish(objSpine)
    end
end

--into动画完成方法
function RoleInteractionArea:intoAnimationFinish(objSpine)
    if self.intoFinishCallBack then
        self.intoFinishCallBack()
        self.intoFinishCallBack = nil
    end
    self:setClickEnabled(true)
    self.skipMask:SetActive(false)
    self.skipBtn:SetActive(false)
    if objSpine then
        objSpine.PhysicsPositionInheritanceFactor = Vector2.New(0.4, 0.4)
    end
end

--重置挂机时间
function RoleInteractionArea:resetIdleTime()
    self.idleTime = 0
end

--设置看板娘文字格子显隐
function RoleInteractionArea:setDialogActive(active)
    if UICommonUtils.Checkobj(self.dialogBox) then
		self.dialogBox:SetActive(active)
	end
end

-- function RoleInteractionArea:OnDestroy()
-- 	self.super:OnDestroy(self)
-- end

--[[
/AdjustRoot/SkipBtn onClick 
--]]
function RoleInteractionArea:skipBtn_ScaleButton_onClick(skipBtn)
    self:skipIntoAnimation()
end

--[[
/AdjustRoot/SkipMask onClick 
--]]
function RoleInteractionArea:skipMask_Button_onClick(skipMask)
    self.skipMask:SetActive(false)
    self.skipBtn:SetActive(true)
end

--设置spine动画
---@param objSpineAnim SkeletonAnimation
---@param needTrack integer
---@param newName string
---@param isLoop boolean
function RoleInteractionArea:setSpineAnimation(objSpineAnim, needTrack, newName, isLoop)
    -- if needTrack == GE.RoleSpineActionType.Action then
    --     self.canClick = false
    -- end
    return objSpineAnim.AnimationState:SetAnimation(needTrack, newName, isLoop)
end

--追加spine动画
---@param objSpineAnim SkeletonAnimation
---@param needTrack integer
---@param newName string
---@param isLoop boolean
---@param delay number
function RoleInteractionArea:addSpineAnimation(objSpineAnim, needTrack, newName, isLoop, delay)
    return objSpineAnim.AnimationState:AddAnimation(needTrack, newName, isLoop, delay)
end

return RoleInteractionArea
