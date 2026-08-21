---@class UserGuidePanel : UserGuidePanel_Generate
---##################### 【UserGuidePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【UserGuidePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local UserGuidePanel = require "UserGuidePanel_Generate"
local BattleCore = require "BattleCore"

function UserGuidePanel:InitLogic(data)
    --完成后记录id
    self.recordId = 0

    --选取框动画时间
    self.doAreaAniTime = 0.3

    self.needArea = nil

    self.needBtn = nil

    self.stepInfo = {}

    self.guideData = {}
end

--执行一步UI引导
function UserGuidePanel:doUserGuide(stepInfo, guideData)
    LuaLogger.ds("<color=#00FF0D>引导 => 步骤id ="..stepInfo.id .."</color>")
    self.stepInfo = stepInfo
    self.guideData = guideData
    self.haloBtn:SetActive(false)
    self.boxBtn:SetActive(false)
    self.transparentAreaHole:SetActive(false)
    self.transparentAreaBox:SetActive(false)
    self.sliderFinger:SetActive(false)
    if self.textTweener ~= nil then
		self.textTweener:Complete(true)
        self.textTweener = nil
	end

    --根据完成方式设置引导形式
    self.recordId = stepInfo.Record
    local completeType = stepInfo.Complete
    local operateData = stepInfo.Button
    if completeType == 1 then--点击任意位置
        self:setDialogData(stepInfo)
    elseif completeType == 2 then-- 点击对应按钮
        local buttonData = stepInfo.Button
        local panelName = buttonData[1]
        local buttonName = buttonData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local fields = {}
            local uiNodeObj = needPanel.ui
            local pattern = string.format("([^%s]+)", ".")
            string.gsub(buttonName, pattern, function(c) fields[#fields+1] = c end)
            for i, field in ipairs(fields) do
                uiNodeObj = uiNodeObj[field]
            end
            self:checkPanelInitAnim(needPanel, function()
                if panelName == "MainPanel" and buttonName == "homeBtn" then--主界面如果已经在家园了则直接完成此步
                    local needPanel = UIMgr:getUIData(panelName)
                    if needPanel then
                        if not needPanel.ui.homeBtn.activeSelf then
                            self:doSetNextGuide()
                            GuideMgr:StartGuideTrigger()
                            return
                        end
                    end
                end
                self:specialSetting(stepInfo, needPanel)
                self:setTipsArea(stepInfo, uiNodeObj.transform.position)
                self:guideClickNormalBtn(uiNodeObj.name)
            end)
        end
    elseif completeType == 4 then--播放剧情
        UIMgr:popUI("StoryPanel", {storyName = stepInfo.StoryId, callBackAfter = function ()
            --下一步逻辑
            self:doSetNextGuide()
            GuideMgr:StartGuideTrigger()
        end})
    elseif completeType == 5 then--点击战斗内地图格子
        local battleMgr = BattleCore:getBattleMgr()
        local showMgr = battleMgr:getShowManager()
        local blockData = battleMgr:getBlockByCid(operateData[1])
        local blockObj = showMgr:getBlockObj(blockData.id)
        local needPos = blockObj.transform.position + Vector3.New(0, 0.65, 0)
        local UICamera = UIMgr.uiCamera
        local sreenPoint = showMgr.cameraObj:GetComponent(typeof(UnityEngine.Camera)):WorldToScreenPoint(needPos)
        local _,screenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(
            self.guideMask.rectTransform, Vector2.New(sreenPoint.x, sreenPoint.y), UICamera, nil)
        self:setTipsArea(stepInfo, screenPos)
        self:guideClickBattleBlock(blockData, blockObj)
    elseif completeType == 7 then--关闭自动打开的界面
        local needData = {}
        local panelName = operateData[1]
        local panelPrame = operateData[2]
        needData.closeFunc = function()
            --下一步逻辑
            self:doSetNextGuide()
            GuideMgr:StartGuideTrigger()
        end
        if panelName == "InstructionsPanel" then--通用玩法提示界面
            needData.tabId = panelPrame
            UIMgr:popUICover(panelName, needData)
        else
            UIMgr:popUI(panelName, needData)
        end
    elseif completeType == 8 then--布阵拖动角色
        self:formationDragRole(stepInfo)
        self:setDialogData(stepInfo)
    elseif completeType == 9 then--点击海图章节按钮
        local panelName = operateData[1]
        local pointName = operateData[2]
        local chapetrId = tonumber(string.match(pointName, "%d+"))
        local chapterConfig = Config.GetChapterInfo(chapetrId)
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel and chapterConfig then
            local needPos = needPanel.ui.pointSeedObjList[chapterConfig.Coordinate[1]].obj.transform.position
            self:setTipsArea(stepInfo, needPos)
            self:guideClickNormalBtn("btn")
        end
    elseif completeType == 10 then--点击关卡按钮
        local panelName = operateData[1]
        local pointId = operateData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local UICamera = UIMgr.uiCamera
            local needObj = SeaMapMgr.seaMapBoxList[pointId].obj
            local pointpos = needObj.transform.position
            local sreenPoint = SeaMapMgr.camera:WorldToScreenPoint(pointpos)
            local _,screenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(
            self.guideMask.rectTransform, Vector2.New(sreenPoint.x, sreenPoint.y), UICamera, nil)
            self:setTipsArea(stepInfo, screenPos)
            self:guideClickLevelMapBtn(needObj)
        end
    elseif completeType == 11 then--点击船坞内角色
        local panelName = operateData[1]
        local roleId = operateData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local needObj = nil
            local roleIndex = 0
            for _, value in pairs(needPanel.ui.roleBoxList) do
                if value.roleData.config.id == roleId then
                    roleIndex = value.index
                    break
                end
            end
            needPanel.ui.roleList.loopGridView:MovePanelToItemByIndex(roleIndex - 1, 0)
            DLuaTimer:DoAfter(0.1, function()
                needObj = needPanel.ui.roleList.loopGridView:GetShownItemByItemIndex(roleIndex - 1)
                self:checkPanelInitAnim(needPanel, function()
                    self:setTipsArea(stepInfo, needObj.transform.position)
                    self:guideClickDockRoleBtn(roleId)
                end)
            end)
        end
    elseif completeType == 12 then--点击通用返回按钮
        local buttonData = stepInfo.Button
        local panelName = buttonData[1]
        local buttonName = buttonData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local uiNodeObj = needPanel.ui.customBackPanel.customBackPanel[buttonName]
            self:checkPanelInitAnim(needPanel, function()
                self:setTipsArea(stepInfo, uiNodeObj.transform.position)
                self:guideClickNormalBtn(uiNodeObj.name)
            end)
        end
    elseif completeType == 13 then--点击天赋树界面天赋按钮
        local panelName = operateData[1]
        local talentId = operateData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local needObj = nil
            for _, value in pairs(needPanel.ui.objList) do
                if value.config.id == talentId then
                    needObj = value.obj
                    break
                end
            end
            self:checkPanelInitAnim(needPanel, function()
                self:setTipsArea(stepInfo, needObj.transform.position)
                self:guideClickSkillTreeBtn(talentId)
            end)
        end
    elseif completeType == 14 then--点击派遣界面章节按钮
        local panelName = operateData[1]
        local chapterId = operateData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local needObj = needPanel.ui.chapterNodeList[chapterId]
            self:setTipsArea(stepInfo, needObj.transform.position)
            self:guideClickDispatchChapterBtn(chapterId)
        end
    elseif completeType == 15 then--点击家园功能建筑按钮
        local panelName = operateData[1]
        local buildingId = operateData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local coveManager = CoveManager.instance()
            coveManager:setCameraMoveable(false)
            coveManager:setCameraPositionByFuncId(buildingId)
            self:setTipsArea(stepInfo, Vector3.New(0,0,0))
            self:guideClickCoveBuildingBtn(buildingId)
        end
    elseif completeType == 16 then  --点击进入家园 播放入场动画
        self:doSetNextGuide()
        local finishFunc = function()
            GuideMgr:StartGuideTrigger()
        end
        local coveManager = CoveManager.instance()
        coveManager:PlayInAni(finishFunc)
    elseif completeType == 17 then--点击家园建筑部署人物头像格子(HomeFuncPanel)
        local panelName = operateData[1]
        local roleId = operateData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local needObj = nil
            local clickFunc = nil
            local roleIndex = 0
            for index, value in pairs(needPanel.ui.showRoleList) do
                if value.roleId == roleId then
                    roleIndex = index
                    clickFunc = value.clickFunc
                    break
                end
            end
            needPanel.ui.roleLoopList.loopGridView:MovePanelToItemByIndex(roleIndex, 0)
            for key, boxObj in pairs(needPanel.ui.roleHeadBoxList) do
                if key == roleIndex then
                    needObj = boxObj.roleMask
                    break
                end
            end
            self:checkPanelInitAnim(needPanel, function()
                self:setTipsArea(stepInfo, needObj.transform.position)
                self:guideClickHomeFuncRoleBtn(clickFunc)
            end)
        end
    elseif completeType == 18 then--定位到对应家园建筑(可点击任意位置触发下一步)
        local panelName = operateData[1]
        local buildingId = operateData[2]
        local isTeleport = operateData[3] and true or false
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local coveManager = CoveManager.instance()
            coveManager:setCameraMoveable(false)
            if isTeleport then
                coveManager:setCameraPositionByFuncId(buildingId)
                self:setDialogData(stepInfo)
            else
                self.maskBg:SetActive(false)
                coveManager:setCameraPositionByFuncId11(buildingId, function()
                    self.maskBg:SetActive(true)
                    self:setDialogData(stepInfo)
                end)
            end
        end
    elseif completeType == 19 then--点击船坞内好感度格子
        local panelName = operateData[1]
        local needindex = operateData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local needObj = nil
            for index, obj in pairs(needPanel.ui.affectionBoxList) do
                if index == needindex then
                    needObj = obj.affectionBg
                    break
                end
            end
            self:checkPanelInitAnim(needPanel, function()
                self:setTipsArea(stepInfo, needObj.transform.position)
                self:guideClickDockAffectionBtn(needindex)
            end)
        end
    elseif completeType == 20 then--点击武器制造蓝图格子
        local panelName = operateData[1]
        local blueprintId = operateData[2]
        local needIndex = 0
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local needObj = nil
            for index, obj in pairs(needPanel.ui.BlueprintBoxObjList) do
                if obj.proData.id == blueprintId then
                    needObj = obj.obj.boxBg
                    needIndex = obj.index
                    break
                end
            end
            self:checkPanelInitAnim(needPanel, function()
                self:setTipsArea(stepInfo, needObj.transform.position)
                self:guideClickBlueprintBtn(needIndex)
            end)
        end
    elseif completeType == 21 or completeType == 24 then--点击家园散步(巡逻)部署位置格子(HomeWalkPanel、HomePatrolPanel)
        local panelName = operateData[1]
        local needIndex = operateData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local needObj = nil
            for index, value in pairs(needPanel.ui.walkBoxList) do
                if value.index == needIndex then
                    needObj = value.obj.btn
                    break
                end
            end
            self:checkPanelInitAnim(needPanel, function()
                self:setTipsArea(stepInfo, needObj.transform.position)
                self:guideClickHomeWalkEditBtn(panelName)
            end)
        end
    elseif completeType == 23 then--家园镜头追踪到对应人物
        local roleId = operateData[1]
        self:doSetNextGuide()
        local finishFunc = function()
            GuideMgr:StartGuideTrigger()
        end
        local coveManager = CoveManager.instance()
        coveManager:setCameraPositionByHeroId(roleId, finishFunc)
    elseif completeType == 22 or completeType == 25 then--点击家园散步(巡逻)部署角色格子(HomeWalkPanel、HomePatrolPanel)
        local panelName = operateData[1]
        local needIndex = operateData[2]
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            local needObj = nil
            local roleBoxObj = nil
            local roleId = 0
            for index, value in pairs(needPanel.ui.roleObjList) do
                if value.index == needIndex then
                    needObj = value.obj.btn
                    roleBoxObj = value.obj
                    roleId = value.data.config.id
                    break
                end
            end
            needPanel.ui.roleList.loopGridView:MovePanelToItemByIndex(needIndex - 1, 0)
            self:checkPanelInitAnim(needPanel, function()
                self:setTipsArea(stepInfo, needObj.transform.position)
                self:guideClickHomeWalkRoleBtn(roleId, roleBoxObj, panelName)
            end)
        end
    elseif completeType == 26 then--播放家园演出剧情
        local idNumber = stepInfo.StoryId and tonumber(stepInfo.StoryId) or 0
        StoryMgr:playHomeStory(idNumber, function()
            --下一步逻辑
            self:doSetNextGuide()
            GuideMgr:StartGuideTrigger()
        end)
    end
    local hideList = {
        4,7,16,26
    }
    --界面显隐
    self.gameObject:SetActive(not tablex.contains(hideList, completeType))
    self.everywhereBtn:SetActive(completeType == 1 or completeType == 18)

    --等待10s后打开跳过一步引导按钮
    self.skipStepBtn:SetActive(false)
    if self.showSkipBtnTimer then
        DLuaTimer:RemoveTimer(self.showSkipBtnTimer)
        self.showSkipBtnTimer = nil
    end
    self.showSkipBtnTimer = DLuaTimer:DoAfter(10, function()
        if UICommonUtils.Checkobj(self.skipStepBtn) then
            self.skipStepBtn:SetActive(true)
        end
    end)
end

function UserGuidePanel:setTipsArea(stepInfo, showPos)
    local completeType = stepInfo.Complete
    local boxType = stepInfo.PromptBox
    local needAppear = stepInfo.BoxAppear == 1
    local width = stepInfo.ButtonSize[1]
    local hight = stepInfo.ButtonSize[2]
    local offset = stepInfo.ButtonPos
    local needPrompt = stepInfo.Prompt
    local showBtn, showArea
    self.haloBtn:SetActive(boxType == 1)
    self.boxBtn:SetActive(boxType == 2)
    self.transparentAreaHole:SetActive(boxType == 1)
    self.transparentAreaBox:SetActive(boxType == 2)
    if boxType == 1 then--圆形
        showBtn = "haloBtn"
        showArea = "transparentAreaHole"
    elseif boxType == 2 then--方形
        showBtn = "boxBtn"
        showArea = "transparentAreaBox"
    end

    if completeType == 5 or completeType == 10 or completeType == 15 then
        self[showArea].transform.localPosition = showPos
        self[showBtn].transform.localPosition = showPos
        self.sliderFinger.transform.localPosition = showPos
    else
        self[showArea].transform.position = showPos
        self[showBtn].transform.position = showPos
        self.sliderFinger.transform.position = showPos
    end

    --按钮大小初始化
    self["boxBtn"].rectTransform.sizeDelta = Vector2.New(445,200)
    self["haloBtn"].rectTransform.sizeDelta = Vector2.New(214,214)
    self["transparentAreaHole"].rectTransform.sizeDelta = Vector2.New(191,191)
    self["transparentAreaBox"].rectTransform.sizeDelta = Vector2.New(445,200)

    if needAppear then
        self[showArea].transform.localScale = Vector3.New(4, 4, 1)
        self[showBtn].transform.localScale = Vector3.New(4, 4, 1)

        self[showArea].transform:DOScale(Vector3.New(1, 1, 1), self.doAreaAniTime)
        self[showBtn].transform:DOScale(Vector3.New(1, 1, 1), self.doAreaAniTime)
    else
        self[showArea].transform.localScale = Vector3.New(1, 1, 1)
        self[showBtn].transform.localScale = Vector3.New(1, 1, 1)
    end
    --长宽
    self[showArea].rectTransform.sizeDelta = Vector2.New(
        self[showArea].rectTransform.sizeDelta.x + width,
        self[showArea].rectTransform.sizeDelta.y + hight
    )
    self[showBtn].rectTransform.sizeDelta = Vector2.New(
        self[showBtn].rectTransform.sizeDelta.x + width,
        self[showBtn].rectTransform.sizeDelta.y + hight
    )
    --位置偏移
    local anchPos = self[showArea].rectTransform.anchoredPosition
    self[showArea].rectTransform.anchoredPosition = Vector2.New(
        anchPos.x + offset[1],
        anchPos.y + offset[2]
    )
    anchPos = self[showBtn].rectTransform.anchoredPosition
    self[showBtn].rectTransform.anchoredPosition = Vector2.New(
        anchPos.x + offset[1],
        anchPos.y + offset[2]
    )
    anchPos = self.sliderFinger.rectTransform.anchoredPosition
    self.sliderFinger.rectTransform.anchoredPosition = Vector2.New(
        anchPos.x + offset[1],
        anchPos.y + offset[2]
    )

    self[showArea]:SetActive(true)
    self[showBtn]:SetActive(true)
    self.sliderFinger:SetActive(needPrompt[1] == 1)
    self.sliderFinger.transform.localRotation = Quaternion.Euler(0, 0, needPrompt[2] or 0)

    self.needArea = self[showArea]
    self.needBtn = self[showBtn]

    self:setDialogData(stepInfo)
end

function UserGuidePanel:setDialogData(stepInfo)
    local dialogKey = stepInfo.DialogKey
    local dialogPos = stepInfo.DialogPos
    --TODO先根据文字多少确定大小，再显示
    self.tipsBigText.text.text = ""
    self.clickMask:SetActive(stepInfo.DialogNpc ~= 0)
    local delayTime = #string.gsub(LocalStrEnum[dialogKey], "<[^>]+>", "") / 3 * 0.05
    self.textTweener = self.tipsBigText.text:DoTextMesh(LocalStrEnum[dialogKey], delayTime, function()
        self.clickMask:SetActive(false)
        self.textTweener = nil
    end)
    self.tipsSmallText.text.text = LocalStrEnum[dialogKey]

    self.tipsBg.rectTransform.anchoredPosition = Vector2.New(dialogPos[1], dialogPos[2])

    self.tipsBg.canvasGroup:DOFade(1, self.doAreaAniTime*2)
    self.tipsBigBox:SetActive(stepInfo.DialogNpc ~= 0)
    self.tipsSmallBox:SetActive(stepInfo.DialogNpc == 0)
    if stepInfo.DialogNpc ~= 0 then
        --引导角色半身像
        local guideRoleBg = string.format(Config.SpritePath.GuideRoleIcon, stepInfo.DialogNpc)
        ResMgr:LoadSpriteAsyncInOwner(guideRoleBg, function (s)
            self.charSpine.image.sprite = s
        end, self.gameObject)

        --根据偏移位置设置角色显示左右
        local needPos
        local dialogPosX = dialogPos[1]
        if dialogPosX > 0 then
            needPos = self.charSpine.rectTransform.anchoredPosition
            self.charSpine.rectTransform.anchoredPosition = Vector2.New(math.abs(needPos.x), needPos.y)
            needPos = self.tipsBigText.rectTransform.anchoredPosition
            self.tipsBigText.rectTransform.anchoredPosition = Vector2.New(- math.abs(needPos.x), needPos.y)
        else
            needPos = self.charSpine.rectTransform.anchoredPosition
            self.charSpine.rectTransform.anchoredPosition = Vector2.New(- math.abs(needPos.x), needPos.y)
            needPos = self.tipsBigText.rectTransform.anchoredPosition
            self.tipsBigText.rectTransform.anchoredPosition = Vector2.New(math.abs(needPos.x), needPos.y)
        end

    end
end

--界面动画处理方法
function UserGuidePanel:checkPanelInitAnim(needPanel, callBack)
    --没有进入动画特殊处理
    local specialPanelList = {
        ["TechnologyTreePagePanel"] = true,
        ["DispatchMainPanel"] = true,
        ["MaterialLevelPanel"] = true,
        ["RaffleMainPanel"] = true,
        ["GenRoleFragPanel"] = true,
        ["CombatIntelligenctPanel"] = true,
        ["ProsperityPanel"] = true,
    }
    for panelName, _ in pairs(specialPanelList) do
        if needPanel.tbData.id == panelName then
            callBack()
            return
        end
    end
    --进入动画在界面子节点特殊处理(animation模式)
    local childAnimPanelList = {
        ["EquipPanel"] = {{childName = "equipMode", animName = "EquipInit"},
                {childName = "weaponMode", animName = "WeaponIn"}},
    }
    for panelName, childDataList in pairs(childAnimPanelList) do
        if needPanel.tbData.id == panelName then
            for _, childData in pairs(childDataList) do
                local animation = needPanel.ui[childData.childName].animation
                if animation:IsPlaying(childData.animName) then
                    needPanel.ui[childData.childName].animOverCallBack:SetCallBackOfGuide(function()
                        callBack()
                    end)
                    return
                end
            end
            callBack()
            return
        end
    end

    --进入动画在界面子节点特殊处理(animator模式)
    local childAnimPanelList2 = {
        ["MainPanel"] = {childName = "mainMode"},
    }
    for panelName, childData in pairs(childAnimPanelList2) do
        if needPanel.tbData.id == panelName then
            local animator = needPanel.ui[childData.childName].animator
            local aniStateInfo = animator:GetCurrentAnimatorStateInfo(0)
            if aniStateInfo.normalizedTime < 1 then
                needPanel.ui[childData.childName].animOverCallBack:SetCallBackOfGuide(function()
                    callBack()
                end)
            else
                callBack()
            end
            return
        end
    end

    if needPanel.ui.animOverCallBack then--有动画则在动画播完后显示引导
        local aniStateInfo = needPanel.ui.animator:GetCurrentAnimatorStateInfo(0)
        if aniStateInfo.normalizedTime < 1 then
            needPanel.ui.animOverCallBack:SetCallBackOfGuide(function()
                callBack()
            end)
        else
            callBack()
        end
    else
        callBack()
    end
end

--触发布阵拖动角色
function UserGuidePanel:formationDragRole(stepInfo)
    local buttonData = stepInfo.Button
    local offset = stepInfo.ButtonPos
    local roleCid = buttonData[1]
    local blockId = buttonData[2]
    self["boxBtn"].rectTransform.sizeDelta = Vector2.New(220,240)
    self["haloBtn"].rectTransform.sizeDelta = Vector2.New(234,234)
    self["transparentAreaHole"].rectTransform.sizeDelta = Vector2.New(211,211)
    self["transparentAreaBox"].rectTransform.sizeDelta = Vector2.New(220,240)
    local needPanel = UIMgr:getUIData("FormationPanel")
    if needPanel then
        local roleDataList = needPanel.ui._allRoleList
        local battleMgr = BattleCore:getBattleMgr()
        local needIndex = 0
        for index, value in pairs(roleDataList) do
            if value.roleCfg.id == roleCid then
                needIndex = index
                break
            end
        end
        needPanel.ui.roleScrollView.loopListView2:MovePanelToItemIndex(needIndex - 1, 0)
        local setPosFunc = function()
            needPanel.ui.roleScrollView.loopListView2:RefreshAllShownItem2()
            local boxPos = needPanel.ui.roleBoxObjList[roleCid].transform.position
            self["boxBtn"].transform.position = boxPos
            self["transparentAreaBox"].transform.position = boxPos

            local showMgr = battleMgr:getShowManager()
            local blockData = battleMgr:getBlockByCid(blockId)
            local blockObj = showMgr:getBlockObj(blockData.id)
            local needPos = blockObj.transform.position + Vector3.New(0, 0.5, 0)
            local UICamera = UIMgr.uiCamera
            local sreenPoint = showMgr.cameraObj:GetComponent(typeof(UnityEngine.Camera)):WorldToScreenPoint(needPos)
            local _,screenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(
                self.guideMask.rectTransform, Vector2.New(sreenPoint.x, sreenPoint.y), UICamera, nil)
            self["haloBtn"].transform.localPosition = screenPos
            self["transparentAreaHole"].transform.localPosition = screenPos

            self.arrowLine:SetActive(true)
            local boxLpos = self["boxBtn"].transform.localPosition
            self.arrowLine.transform.localPosition = Vector3.New((boxLpos.x + screenPos.x)/2,(boxLpos.y + screenPos.y)/2, 0)
            local distance = Vector2.Distance(boxLpos, screenPos)   -- 计算两点之间的距离
            local needArrowCount = math.ceil(distance / 125)
            self:FillTemplateContent(self.arrow, self.arrowLine, needArrowCount, function(index, arrow)
                arrow:SetActive(false)
                arrow.animation:get_Item("ArrowBlink").time = 0.9 * index
                arrow:SetActive(true)
            end)
            local dir = screenPos - boxLpos  -- 计算方向向量
            local angle = math.deg(math.atan2(dir.y, dir.x))  -- 计算角度，转成度数
            self.arrowLine.transform.rotation = Quaternion.Euler(0, 0, angle)  -- 设置旋转角度

            self["boxBtn"]:SetActive(true)
            self["haloBtn"]:SetActive(true)
            self["transparentAreaHole"]:SetActive(true)
            self["transparentAreaBox"]:SetActive(true)

            --手指动画
            self.sliderFinger:SetActive(true)
            self.sliderFinger.transform.localPosition = boxLpos

            --位置偏移
            local anchPos = self["boxBtn"].rectTransform.anchoredPosition
            self["boxBtn"].rectTransform.anchoredPosition = Vector2.New(
                anchPos.x + offset[1],
                anchPos.y + offset[2]
            )
            anchPos = self["transparentAreaBox"].rectTransform.anchoredPosition
            self["transparentAreaBox"].rectTransform.anchoredPosition = Vector2.New(
                anchPos.x + offset[1],
                anchPos.y + offset[2]
            )
            anchPos = self.sliderFinger.rectTransform.anchoredPosition
            self.sliderFinger.rectTransform.anchoredPosition = Vector2.New(
                anchPos.x + offset[1],
                anchPos.y + offset[2]
            )
        end
        local dragRoleFunc = function()
            self["boxBtn"].dragListener.onBeginDragEvent = needPanel.ui.roleBoxObjList[roleCid].dragListener.onBeginDragEvent + function()
                local showMgr = battleMgr:getShowManager()
                local blockData = battleMgr:getBlockByCid(blockId)
                local blockObj = showMgr:getBlockObj(blockData.id)
                local needPos = blockObj.transform.position + Vector3.New(0, 0.5, 0)
                local UICamera = UIMgr.uiCamera
                local sreenPoint = showMgr.cameraObj:GetComponent(typeof(UnityEngine.Camera)):WorldToScreenPoint(needPos)
                local _,screenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(
                    self.guideMask.rectTransform, Vector2.New(sreenPoint.x, sreenPoint.y), UICamera, nil)
                self.sliderFinger.transform.localPosition = screenPos
                --设置可拖动范围比值
                needPanel.ui.roleDragRate = 0.2
            end
            self["boxBtn"].dragListener.onDragEvent = needPanel.ui.roleBoxObjList[roleCid].dragListener.onDragEvent
            self["boxBtn"].dragListener.onEndDragEvent = needPanel.ui.roleBoxObjList[roleCid].dragListener.onEndDragEvent + function()
                --恢复可拖动范围比值
                needPanel.ui.roleDragRate = 0.6
            end
        end
        self:checkPanelInitAnim(needPanel, function()
            setPosFunc()
            dragRoleFunc()
        end)
    end
end

--触发点击普通按钮
function UserGuidePanel:guideClickNormalBtn(objName)
    local panelName = self.stepInfo.Button[1]
    self.needBtn.uIRaycastClick.objName = objName
    --特殊处理部分普通点击逻辑
    if self.stepInfo.id == 10120 or self.stepInfo.id == 10220 or self.stepInfo.id == 10280 then
        self.needBtn.uIRaycastClick.callBackBefore = function()
            --下一步逻辑
            self:doSetNextGuide()
            GuideMgr:StartGuideTrigger()
        end
    elseif objName == "ConfirmBtn" and panelName == "FormationPanel" then
        self.needBtn.uIRaycastClick.shouldExecuteClick = function()
            local needPanel = UIMgr:getUIData(panelName)
            return needPanel.ui._confirmLocked
        end
        self.needBtn.uIRaycastClick.callBack = function()
            --下一步逻辑
            self:doSetNextGuide()
            GuideMgr:StartGuideTrigger()
        end
    elseif (objName == "HomeBtn" and panelName == "MainPanel")
    or (objName == "DifficultyBtn" and panelName == "SeaMapPanel") then
        self.needBtn.uIRaycastClick.callBack = function()
            --下一步逻辑
            self:doSetNextGuide()
        end
    else
        self.needBtn.uIRaycastClick.callBack = function()
            --下一步逻辑
            self:doSetNextGuide()
            GuideMgr:StartGuideTrigger()
        end
    end
end

--触发点击战斗内地图格子
function UserGuidePanel:guideClickBattleBlock(blockData, blockObj)
    local clientBattleMgr = ClientBattleManager.getInstance()
    local inputMgr = clientBattleMgr:getInputManager()
    inputMgr:SetCanZoomCamera(false)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        inputMgr:OnClickBlock(blockData)
        inputMgr:SetCanZoomCamera(true)
        --下一步逻辑
        self:doSetNextGuide()
        GuideMgr:StartGuideTrigger()
    end
end

--触发点击主线关卡格子
function UserGuidePanel:guideClickLevelMapBtn(needObj)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        SeaMapMgr:ClickLevelPoint(needObj)
        --下一步逻辑
        self:doSetNextGuide()
        GuideMgr:StartGuideTrigger()
    end
end

--触发点击船坞角色格子
function UserGuidePanel:guideClickDockRoleBtn(roleId)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        local needPanel = UIMgr:getUIData("DockRolePanel")
        if needPanel then
            needPanel.ui:SelectRoleBox(roleId)
        end
        --下一步逻辑
        self:doSetNextGuide()
        GuideMgr:StartGuideTrigger()
    end
end

--触发点击船坞好感度格子
function UserGuidePanel:guideClickDockAffectionBtn(index)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        local needPanel = UIMgr:getUIData("DockRolePanel")
        if needPanel then
            needPanel.ui:clickAffectionBox(index)
        end
        --下一步逻辑
        self:doSetNextGuide()
        GuideMgr:StartGuideTrigger()
    end
end

--触发点击武器制造蓝图格子
function UserGuidePanel:guideClickBlueprintBtn(index)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        local needPanel = UIMgr:getUIData("HomeWeaponProPanel")
        if needPanel then
            needPanel.ui:clickBlueprintBtn(index)
        end
        --下一步逻辑
        self:doSetNextGuide()
        GuideMgr:StartGuideTrigger()
    end
end

--触发点击天赋树天赋格子
function UserGuidePanel:guideClickSkillTreeBtn(talentId)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        local needPanel = UIMgr:getUIData("SkillTreePanel")
        if needPanel then
            needPanel.ui:SetNowSelect(talentId)
        end
        --下一步逻辑
        self:doSetNextGuide()
        GuideMgr:StartGuideTrigger()
    end
end

--触发点击家园功能建筑按钮
function UserGuidePanel:guideClickCoveBuildingBtn(buildingId)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        local coveManager = CoveManager.instance()
        local buildMgr = coveManager:getBuildingMgr()
        buildMgr:OnClickBtn(buildingId)
        --下一步逻辑
        self:doSetNextGuide()
        GuideMgr:StartGuideTrigger()
    end
end

--触发点击家园功能建筑角色头像格子
function UserGuidePanel:guideClickHomeFuncRoleBtn(clickFunc)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        if clickFunc then
            clickFunc()
        end
        --下一步逻辑
        self:doSetNextGuide()
        GuideMgr:StartGuideTrigger()
    end
end

--触发点击派遣章节界面章节按钮
function UserGuidePanel:guideClickDispatchChapterBtn(chapterId)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        local needPanel = UIMgr:getUIData("DispatchMainPanel")
        if needPanel then
            needPanel.ui:openDetailPanel(chapterId)
        end
        --下一步逻辑
        self:doSetNextGuide()
    end
end

--触发点击家园散步(巡逻)部署角色格子
function UserGuidePanel:guideClickHomeWalkRoleBtn(roleId, roleBoxObj, panelName)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            needPanel.ui:clickCustomRoleBox(roleId, roleBoxObj)
        end
        --下一步逻辑
        self:doSetNextGuide()
        GuideMgr:StartGuideTrigger()
    end
end

--触发点击家园散步(巡逻)部署位置格子
function UserGuidePanel:guideClickHomeWalkEditBtn(panelName)
    self.needBtn.uIRaycastClick.objName = self.needArea.name
    self.needBtn.uIRaycastClick.callBack = function()
        local needPanel = UIMgr:getUIData(panelName)
        if needPanel then
            needPanel.ui:clickEditBtn()
        end
        --下一步逻辑
        self:doSetNextGuide()
        GuideMgr:StartGuideTrigger()
    end
end

--特殊步骤处理
---@param stepInfo GuideStepTable
---@param needPanel UnityEngine.GameObject
function UserGuidePanel:specialSetting(stepInfo, needPanel)
    if stepInfo.id == 20120 then--危险范围强制打开按钮
        needPanel.ui.dangerRangeCloseBtn:SetActive(false)
        needPanel.ui.dangerRangeBtn:SetActive(true)
    elseif stepInfo.id == 10240 then--设置抽卡消耗显示
        needPanel.ui.raffleOneTxt.text.text = LocalStrEnum.Gacha_Prompt_Free
        needPanel.ui.raffleOneBtn.needNumTxt.text.text = "0"
        needPanel.ui.raffleOneBtn.needNumTxt.text.color = Color.NewFromStr("FFFFFF")
        needPanel.ui.raffleOneBtn.xTxt.text.color = Color.NewFromStr("FFFFFF")
    end
end

--设置下一步引导数据
function UserGuidePanel:doSetNextGuide()
    local guideMainCfg = nil
    if self.recordId ~= 0 then
        guideMainCfg = Config.GetGuideMainInfo(self.recordId)
        local data = {
			guideType = guideMainCfg.Group,
			guideId = self.recordId,
		}
		Me:changeGuideIDReq(data)
    else
        guideMainCfg = Config.GetGuideMainInfo(self.guideData.guideId)
    end

    --引导埋点
    ClientData:sendGuideLogMessage(guideMainCfg.Group, guideMainCfg.id, self.stepInfo.id)

    GuideMgr:SetNextStepData(guideMainCfg.Group)

    self.gameObject:SetActive(false)
    self.tipsBg.canvasGroup.alpha = 0
    self.skipStepBtn:SetActive(false)
    if self.showSkipBtnTimer then
        DLuaTimer:RemoveTimer(self.showSkipBtnTimer)
        self.showSkipBtnTimer = nil
    end
end

--function UserGuidePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/GuideMask/EverywhereBtn onClick 
--]]
function UserGuidePanel:everywhereBtn_Button_onClick(everywhereBtn)
    --下一步逻辑
    self:doSetNextGuide()
    GuideMgr:StartGuideTrigger()
end

--[[
/SkipStepBtn onClick 
--]]
function UserGuidePanel:skipStepBtn_ScaleButton_onClick(skipStepBtn)
    --跳过当前引导步骤
    UICommonUtils.PopToast("跳过步骤id:"..GuideMgr:GetNowStepId())
    self:doSetNextGuide()
    GuideMgr:StartGuideTrigger()
end

--[[
/ClickMask onClick 
--]]
function UserGuidePanel:clickMask_Button_onClick(clickMask)
    if self.textTweener ~= nil then
		self.textTweener:Complete(true)
        self.textTweener = nil
	end
end

return UserGuidePanel
