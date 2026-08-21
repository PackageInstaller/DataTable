---@class SkinPanel : SkinPanel_Generate
---##################### 【SkinPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkinPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkinPanel = require "SkinPanel_Generate"
local Screen = UnityEngine.Screen

function SkinPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
	}
    self.nowMode = 1    --1立绘模式 2小人模式
    self.roleId = nil
    self.scroll_pos = 0
    self.pos = {}
    self.distance = 0
    self.skinBoxList = {}
    self.selectedSkinIndex = nil
    self.targetScrollbarValue = nil
    self.isDrag = false
    self.canRun = false

    self.nowSelectSkinId = nil
    self.isMove = false
    self.nowObj = nil

    --旋转模型
    self.minX = 0
    self.maxX = Screen.width / 1.45
    self.minY = Screen.height / 4.5
    self.maxY = Screen.height
    self.startTouchPosition = nil
    self.currentRotationY = 0

    self.nowSelectSKinIndex = nil        --当前选中的动作索引
    self.skinAnimObjList = {}

    self.nowSkinConfig = {}
    self.nowShowSpineObj = nil

    --水面碰撞
    self.waterCollisionObjs = {}
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")

    self.rt = nil

    -- 从 DockRole 等界面切入时，需等主视觉与右侧列表图标都就绪后再结束 UISwitch
    self._waitingUISwitch = false
    self._initialVisualReady = false
    self._initialListReady = false
    self._pendingListIconCount = 0
    self._pendingModelSkinConfig = nil
    self._modelPreloaded = false
    self._loadingModelKey = nil
    self._deferredFreeObjs = {}
    self._deferredFreeToken = nil

    self._scaleNormal = Vector3.one
    self._scaleSelected = Vector3.New(1.15, 1.15, 1)
end

--function SkinPanel:StartCreating(time)
--
--end

--function SkinPanel:StartEnter(time)
--
--end

--function SkinPanel:StartRemoving(time)
--
--end

--function SkinPanel:StartExit(time)
--
--end

function SkinPanel:OnOpen(data, initiative)
    self:SetUpdateInterval(0)  --设置Update函数的调用间隔，0为每帧调用，单位为秒
    -- 从 SkinView 等全屏子界面返回时不要重建列表，否则会重新选中穿戴皮肤，丢掉预览中的选中
    if not initiative then
        self._waitingUISwitch = false
        self.canRun = true
        self:ModeChange()
        self:RefreshEquipStatus()
        -- 全屏隐藏再显示后 SkeletonGraphic 常会失效，按当前预览皮肤重挂立绘
        self:RestoreShowCharacterVisual()
        return
    end

    --默认模式为立绘模式；全量模型预加载改到转场结束后再做，避免切入卡顿
    self.roleId = data.roleID
    self._waitingUISwitch = true
    self._initialVisualReady = false
    self._initialListReady = false
    self._pendingListIconCount = 0
    self._pendingModelSkinConfig = nil
    self._modelPreloaded = false
    self._loadingModelKey = nil
    self._deferredFreeObjs = {}
    self._deferredFreeToken = nil
    self.canRun = false
    self:SetView()
end

--- 恢复当前选中皮肤的立绘/spine（从 SkinView 返回时用）
function SkinPanel:RestoreShowCharacterVisual()
    local skinId = self.nowSelectSkinId
    if not skinId then
        return
    end
    UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, skinId, function(spineObject)
        if not self:CheckSelfHasNotBeDestory() then
            if UICommonUtils.Checkobj(spineObject) then
                GameObject.Destroy(spineObject)
            end
            return
        end
        if UICommonUtils.Checkobj(self.nowShowSpineObj) and self.nowShowSpineObj ~= spineObject then
            GameObject.Destroy(self.nowShowSpineObj)
        end
        self.nowShowSpineObj = spineObject
    end)
end

function SkinPanel:SetView()
    self:SetSkinView()
    self:SetupShowBgLayer()
    self:ModeChange()
    -- RenderTexture 延后到主视觉就绪、揭开转场前再创建，避免与开屏加载同帧抢占
end

--- 转场遮罩下等待初始主视觉 + 右侧皮肤列表图标都就绪后再揭开
function SkinPanel:TryFinishUISwitch()
    if not self._waitingUISwitch then
        return
    end
    if not self._initialVisualReady or not self._initialListReady then
        return
    end
    self._waitingUISwitch = false
    self:resetRenderTexture()
    -- 揭开瞬间不要 Preload 模型：Preload 内部 Get 后立刻 Free，会与 SwitchOut 叠在一起卡顿
    LoadingMgr:SetUISwitchOver(function()
        -- SwitchOut 播完后再确保当前皮肤模型已加载（pending 可能已清空，需用 nowSkinConfig 兜底）
        self:EnsureSkinModelLoaded()
    end)
    self:DoAfter(0.2, function()
        self.canRun = true
    end)
end

function SkinPanel:MarkInitialVisualReady()
    if not self._waitingUISwitch then
        return
    end
    self._initialVisualReady = true
    self:TryFinishUISwitch()
end

function SkinPanel:MarkInitialListReady()
    if not self._waitingUISwitch then
        return
    end
    self._initialListReady = true
    self:TryFinishUISwitch()
end

function SkinPanel:OnListIconLoaded()
    if not self._waitingUISwitch or self._initialListReady then
        return
    end
    self._pendingListIconCount = self._pendingListIconCount - 1
    if self._pendingListIconCount <= 0 then
        self:MarkInitialListReady()
    end
end

--初始化皮肤模式（右侧吸附滚动列表 / snap scroll）
function SkinPanel:SetSkinView()
    self.pos = {}
    self.skinBoxList = {}
    self.selectedSkinIndex = nil

    local skinList = Config.GetCharacterSkinInfoByCharacterID(self.roleId)
    self.isHasCountTxt.text.text = tablex.size(ClientData:getSkinDataByRoleId(self.roleId)).."/"..tablex.size(skinList)
    local totalSkinCount = tablex.size(skinList)
    if totalSkinCount <= 0 then
        self:MarkInitialListReady()
        self:MarkInitialVisualReady()
        return
    end

    local roleData = Me:getPlayerHero(self.roleId)
    self._pendingListIconCount = totalSkinCount
    local createdSkinCount = 0
    self:FillTemplateContent(self.customSkinBox, self.content, totalSkinCount, function(index, customSkinBox)
        -- 转场遮罩期间直接显示，避免揭开时格子还在淡入导致“未加载完”的感觉
        if self._waitingUISwitch then
            customSkinBox.btn.canvasGroup.alpha = 1
        else
            customSkinBox.btn.canvasGroup.alpha = 0
            self:DoAfter(index * 0.015, function()
                customSkinBox.btn.canvasGroup:DOFade(1, 0.2)
            end)
        end
        customSkinBox:SetActive(true)
        local skinConfig = skinList[index]
        local skinState = Me:getSkinData(skinConfig.id)
        local resourceFolder = skinConfig.resourceFolder
        if tonumber(resourceFolder) ~= nil then
            resourceFolder = tostring(math.floor(tonumber(resourceFolder)))
        end
        customSkinBox.isLock:SetActive(skinState == nil)
        customSkinBox.isEquip:SetActive(roleData.equipSkin == skinConfig.id)
        customSkinBox.isSelect:SetActive(false)
        customSkinBox.roleIconImg:SetActive(true)
        customSkinBox.transform.localScale = self._scaleNormal
        self:LoadSpriteAsync(string.format(Config.SpritePath.CutRolePath, resourceFolder, skinConfig.halfimgKey), customSkinBox.roleIconImg.image, function()
            self:OnListIconLoaded()
        end)
        customSkinBox.btn.scaleButton.onClick:RemoveAllListeners()
        customSkinBox.btn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            if self.canRun == false then
                return
            end
            self:SkinBoxOnClick(index)
        end)

        self.skinBoxList[index] = {
            obj = customSkinBox,
            config = skinConfig
        }

        createdSkinCount = createdSkinCount + 1
        if createdSkinCount == totalSkinCount then
            if totalSkinCount <= 1 then
                self.distance = 1
                self.pos[1] = 0
            else
                self.distance = 1 / (totalSkinCount - 1)
                for i = 1, totalSkinCount do
                    self.pos[i] = self.distance * (i - 1)
                end
            end

            local equipIndex = 1
            for i = 1, totalSkinCount do
                if self.skinBoxList[i].config.id == roleData.equipSkin then
                    equipIndex = i
                    break
                end
            end

            self.scroll_pos = self.pos[equipIndex]
            self.bar.scrollbar.value = self.pos[equipIndex]
            self.targetScrollbarValue = self.pos[equipIndex]
            self:SetSelectedSkinIndex(equipIndex, false)
            self:UpdateSkinView(self.skinBoxList[equipIndex].config)
        end
    end)
end

--- 根据滚动值计算最近吸附格子索引
function SkinPanel:GetSnapIndexFromScroll(scrollValue)
    local count = #self.skinBoxList
    if count <= 1 then
        return 1
    end
    local idx = math.floor(scrollValue / self.distance + 0.5) + 1
    if idx < 1 then
        return 1
    elseif idx > count then
        return count
    end
    return idx
end

--- 更新选中态（仅动旧/新两项）；triggerView 为 true 时才刷新皮肤内容
function SkinPanel:SetSelectedSkinIndex(index, triggerView)
    if not index or not self.skinBoxList[index] then
        return
    end
    local prev = self.selectedSkinIndex
    if prev == index then
        if triggerView then
            self:UpdateSkinView(self.skinBoxList[index].config)
        end
        return
    end

    if prev and self.skinBoxList[prev] then
        self.skinBoxList[prev].obj.isSelect:SetActive(false)
    end
    self.selectedSkinIndex = index
    self.skinBoxList[index].obj.isSelect:SetActive(true)

    if triggerView then
        self:UpdateSkinView(self.skinBoxList[index].config)
    end
end

--- 刷新格子缩放：选中项放大，其余恢复；必须扫全表，否则快跳选中时旧项会卡在放大态
function SkinPanel:UpdateSkinBoxScales()
    local selected = self.selectedSkinIndex
    local count = #self.skinBoxList
    for i = 1, count do
        local skinBox = self.skinBoxList[i]
        local target = (i == selected) and self._scaleSelected or self._scaleNormal
        local cur = skinBox.obj.transform.localScale
        if math.abs(cur.x - target.x) > 0.005 then
            skinBox.obj.transform.localScale = Vector3.Lerp(cur, target, 0.18)
        elseif cur.x ~= target.x then
            skinBox.obj.transform.localScale = target
        end
    end
end

-- 吸附滚动列表：拖拽松手吸附到最近格子，再切换皮肤
function SkinPanel:SelectList()
    if not self.canRun or #self.skinBoxList <= 0 then
        return
    end

    if Input.GetMouseButtonDown(0) then
        self.isDrag = true
    end

    if Input.GetMouseButtonUp(0) and self.isDrag then
        self.isDrag = false
        self.scroll_pos = self.bar.scrollbar.value
        local snapIndex = self:GetSnapIndexFromScroll(self.scroll_pos)
        self.targetScrollbarValue = self.pos[snapIndex]
        -- 松手时才真正切换皮肤，拖拽过程只做高亮预览，避免拖动中反复加载
        self:SetSelectedSkinIndex(snapIndex, true)
    end

    if self.isDrag then
        self.scroll_pos = self.bar.scrollbar.value
        -- 拖拽中仅更新选中框，不触发 UpdateSkinView
        local previewIndex = self:GetSnapIndexFromScroll(self.scroll_pos)
        self:SetSelectedSkinIndex(previewIndex, false)
    else
        if self.targetScrollbarValue then
            local cur = self.bar.scrollbar.value
            local target = self.targetScrollbarValue
            if math.abs(cur - target) < 0.001 then
                self.bar.scrollbar.value = target
                self.scroll_pos = target
            else
                local nextVal = Mathf.Lerp(cur, target, 0.18)
                self.bar.scrollbar.value = nextVal
                self.scroll_pos = nextVal
            end
        end
    end

    self:UpdateSkinBoxScales()
end

--点击选中皮肤格子
function SkinPanel:SkinBoxOnClick(index)
    if not index or not self.pos[index] then
        self.canRun = true
        return
    end
    self.isDrag = false
    self.scroll_pos = self.pos[index]
    self.targetScrollbarValue = self.pos[index]
    self:SetSelectedSkinIndex(index, true)
    self.canRun = true
end

--切换皮肤
function SkinPanel:UpdateSkinView(SkinConfig, isRefresh)
    local isSameSkin = (SkinConfig.id == self.nowSelectSkinId)
    if isSameSkin and not isRefresh then
        return
    end
    self.nowSelectSkinId = SkinConfig.id
    self.nowSkinConfig = SkinConfig
    local roleData = Me:getPlayerHero(self.roleId)

    local roleConfig = Config.GetCharacterInfo(SkinConfig.CharacterID)
    self.nameTxt.text.text = roleConfig.name
    self.skinNameTxt.text.text = SkinConfig.skinName

    self:FillTemplateContent(self.tagBox, self.tagList, tablex.size(SkinConfig.skinSign), function(index, tagBox)
        tagBox:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkinTagBgPath, SkinConfig.skinSign[index]), tagBox.image)
        tagBox.tagTxt.text.text = LocalStrEnum["skinSign_"..SkinConfig.skinSign[index]]
    end)

    -- 只有在切换到不同皮肤时才重新加载spine，避免闪烁
    if not isSameSkin or not isRefresh then
        UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, self.nowSelectSkinId, function(spineObject)
            if UICommonUtils.Checkobj(self.nowShowSpineObj) then
                GameObject.Destroy(self.nowShowSpineObj)
            end
            self.nowShowSpineObj = spineObject
            -- 首次切入：主视觉就绪后再揭开转场，避免露出空立绘/未完成界面
            self:MarkInitialVisualReady()
        end)
    elseif self._waitingUISwitch then
        self:MarkInitialVisualReady()
    end

    self.skinMsgTxt.text.text = SkinConfig.skinDesc
    local skinState = Me:getSkinData(SkinConfig.id)

    self.changeBtn:SetActive(skinState ~= nil and self.nowSelectSkinId ~= roleData.equipSkin)
    self.isNull:SetActive(skinState == nil)
    self.isEquip:SetActive(self.nowSelectSkinId == roleData.equipSkin)
    self.nullTxt.text.text = SkinConfig.SkinNotObtainedDes

    -- 立绘模式不立刻 Free/Get 3D 模型与动画列表，避免首次点选时与 spine 同帧抢主线程
    self._pendingModelSkinConfig = SkinConfig

    if self.nowMode == 2 then
        if self.nowObj and self.nowObj.name ~= SkinConfig.modelKey then
            self:ReleaseSkinModelDeferred()
        end
        self:EnsureSkinModelLoaded()
        self:DoAfter(0.05, function()
            if self:CheckSelfHasNotBeDestory() and self.nowSelectSkinId == SkinConfig.id then
                self:AnimListInfo(SkinConfig)
            end
        end)
    else
        -- 立绘下若已持有其它皮肤模型，延后回收；真正加载推迟到进小人模式 / 转场结束
        if self.nowObj and self.nowObj.name ~= SkinConfig.modelKey then
            self:ReleaseSkinModelDeferred()
        end
    end
end

--- 安全归还池对象：先脱离本界面父节点，再 Free。
--- PoolMgr.Free 不会改父节点；若仍挂在 SkinPanel 下，随后 UI Destroy 会把池内实例一起毁掉，
--- 重开时 RequestAsync 取到已销毁对象就会报 require obj faild。
function SkinPanel:SafeFreePoolObj(obj)
    if not obj or IsNull(obj) then
        return
    end
    local tr = obj.transform
    if tr then
        tr:SetParent(nil, false)
    end
    PoolMgr.Free(obj)
end

--- 延后回收旧模型，避免与立绘加载同帧卡顿；关闭界面时由 OnClose 兜底 Free
function SkinPanel:ReleaseSkinModelDeferred()
    local oldObj = self.nowObj
    local oldWater = self.waterCollisionObjs
    self.nowObj = nil
    self.model = nil
    self.waterCollisionObjs = {}
    if not oldObj and (not oldWater or #oldWater == 0) then
        return
    end
    self._deferredFreeObjs = self._deferredFreeObjs or {}
    if oldWater then
        for _, value in pairs(oldWater) do
            self._deferredFreeObjs[#self._deferredFreeObjs + 1] = value
        end
    end
    if oldObj then
        self._deferredFreeObjs[#self._deferredFreeObjs + 1] = oldObj
    end
    local freeToken = {}
    self._deferredFreeToken = freeToken
    self:DoAfter(0.03, function()
        if self._deferredFreeToken ~= freeToken then
            return
        end
        local list = self._deferredFreeObjs
        self._deferredFreeObjs = {}
        if not list then
            return
        end
        for _, value in ipairs(list) do
            self:SafeFreePoolObj(value)
        end
    end)
end

--- 立即归还皮肤相关池对象（关闭面板前必须调用，否则会随 UI Destroy 弄脏对象池）
function SkinPanel:ReleaseSkinPoolObjects()
    self._deferredFreeToken = nil
    local deferred = self._deferredFreeObjs
    self._deferredFreeObjs = {}

    -- 先回收挂在模型脚底上的水面碰撞，再回收模型本身
    if self.waterCollisionObjs then
        for _, value in pairs(self.waterCollisionObjs) do
            self:SafeFreePoolObj(value)
        end
    end
    self.waterCollisionObjs = {}

    if deferred then
        for _, value in ipairs(deferred) do
            self:SafeFreePoolObj(value)
        end
    end

    self:SafeFreePoolObj(self.nowObj)
    self.nowObj = nil
    self.model = nil

    if UICommonUtils.Checkobj(self.nowShowSpineObj) then
        GameObject.Destroy(self.nowShowSpineObj)
    end
    self.nowShowSpineObj = nil

    self._loadingModelKey = nil
    self._pendingModelSkinConfig = nil
    self._modelPreloaded = false
end

--- 确保当前皮肤 3D 模型已加载（pending 被转场回调清空时，用 nowSkinConfig 兜底）
function SkinPanel:EnsureSkinModelLoaded()
    local cfg = self._pendingModelSkinConfig or self.nowSkinConfig
    if type(cfg) ~= "table" or not cfg.modelKey then
        return
    end
    if self.nowObj and not IsNull(self.nowObj) and self.nowObj.name == cfg.modelKey then
        self._pendingModelSkinConfig = nil
        return
    end
    if self._loadingModelKey == cfg.modelKey then
        return
    end
    self._pendingModelSkinConfig = nil
    self:LoadSkinModel(cfg)
end

--- 加载皮肤 3D 模型（含水面碰撞）
function SkinPanel:LoadSkinModel(SkinConfig)
    if not SkinConfig then
        return
    end
    if self.nowObj ~= nil then
        if self.nowObj.name == SkinConfig.modelKey then
            self._loadingModelKey = nil
            return
        end
        if self.waterCollisionObjs then
            for _, value in pairs(self.waterCollisionObjs) do
                self:SafeFreePoolObj(value)
            end
            self.waterCollisionObjs = {}
        end
        self:SafeFreePoolObj(self.nowObj)
        self.nowObj = nil
        self.model = nil
    end

    self._loadingModelKey = SkinConfig.modelKey
    PoolMgr:Get(string.format(Config.PrefabPath.RoleModelPrefab, SkinConfig.modelKey, SkinConfig.modelKey), function(obj)
        if self._loadingModelKey == SkinConfig.modelKey then
            self._loadingModelKey = nil
        end
        if not self:CheckSelfHasNotBeDestory() or IsNull(obj) then
            self:SafeFreePoolObj(obj)
            return
        end
        -- 加载期间已切到别的皮肤，回收本次实例
        if self.nowSelectSkinId ~= SkinConfig.id then
            self:SafeFreePoolObj(obj)
            return
        end
        obj:SetParent(self.rolePoint.transform)
        self.currentRotationY = 180
        self.rolePoint.transform.rotation = Quaternion.Euler(0, self.currentRotationY, 0)
        self.nowObj = obj
        obj.transform.localPosition = Vector3.down * 2
        obj.transform.localRotation = Vector3.zero
        obj.transform.localScale = Vector3.New(100, 100, 100)
        self:SetLayerRecursively(obj, UnityEngine.LayerMask.NameToLayer("UIRole"))
        self.model = obj.transform:GetComponent("RoleModelController")
        self.model:ClearCamera()
        self.model:SetEmotionLookAt(self.objCamera)
        self.model:PlanarShadowEnable(false)

        --添加水面碰撞效果
        for i = 0, self.model.footPoints.Length - 1 do
            local value = self.model.footPoints[i]
            if value then
                PoolMgr:Get(Config.PrefabPath.WaterCollision, function(collisionObj)
                    if not self:CheckSelfHasNotBeDestory() or IsNull(collisionObj) then
                        self:SafeFreePoolObj(collisionObj)
                        return
                    end
                    if self.nowSelectSkinId ~= SkinConfig.id or IsNull(value) then
                        self:SafeFreePoolObj(collisionObj)
                        return
                    end
                    collisionObj:SetParent(value.transform)
                    collisionObj.transform.localPosition = Vector3.zero
                    collisionObj.transform.localRotation = Quaternion.Euler(0, 0, 0)
                    collisionObj.transform.localScale = Vector3.one
                    table.insert(self.waterCollisionObjs, collisionObj)
                end)
            end
        end

        -- 小人/立绘都需要在模型就绪后设默认动作，否则动作列表点击无效
        self.nowSelectSKinIndex = nil
        self:setAnim(SkinConfig, 1)
    end)
end

function SkinPanel:LoadPendingSkinModel()
    self:EnsureSkinModelLoaded()
end

function SkinPanel:Update()
    self:SelectList()
    self:RotateObj()
end

--模式切换
function SkinPanel:ModeChange()
    if self.nowMode == 1 then --立绘模式
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.SkinPanel, self)
        self.skinMode.canvasGroup.alpha = 1
        self.modelMode.canvasGroup.alpha = 0
        self.skinMode.canvasGroup.blocksRaycasts = true
        self.modelMode.canvasGroup.blocksRaycasts = false
        if self.model then
            self:setAnim(self.nowSkinConfig, 1)
        end
    elseif self.nowMode == 2 then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.SkinPanel_Action, self)
        self.skinMode.canvasGroup.alpha = 0
        self.modelMode.canvasGroup.alpha = 1
        self.skinMode.canvasGroup.blocksRaycasts = false
        self.modelMode.canvasGroup.blocksRaycasts = true
        -- pending 可能已被转场回调清空，这里用 nowSkinConfig 兜底确保能出小人
        if self.nowSkinConfig and self.nowSkinConfig.modelKey and not self._pendingModelSkinConfig then
            self._pendingModelSkinConfig = self.nowSkinConfig
        end
        self:EnsureSkinModelLoaded()
        if self.nowSkinConfig and self.nowSkinConfig.actionShow then
            self:AnimListInfo(self.nowSkinConfig)
        end
        -- 首次进入小人模式再错帧预加载其余皮肤，避开开屏 SwitchOut
        if not self._modelPreloaded then
            self._modelPreloaded = true
            self:DoAfter(0.3, function()
                if self:CheckSelfHasNotBeDestory() then
                    self:PreloadRoleModels()
                end
            end)
        end
    end
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
        LoadingMgr:SetUISwitchStart(function()
            UIMgr:closeSpecificUI(self)
            self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
        end)
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)
    self.showBtn:SetActive(self.nowMode == 1)
    -- CamPoint 仅小人模式需要（相机/模型预览），立绘模式保持关闭
    self.camPoint:SetActive(self.nowMode == 2)
    self.currentRotationY = 180
    if self.nowMode == 2 then
        self.camPoint.transform.rotation = Quaternion.Euler(0, self.currentRotationY, 0)
    end
end

-- 水面反射层设置（轻量，开屏即可）
function SkinPanel:SetupShowBgLayer()
    local layer = UnityEngine.LayerMask.NameToLayer("Water")
	self.showBg.layer = layer
	local childTransforms = self.showBg:GetComponentsInChildren(typeof(UnityEngine.Transform), true)
	for i = 0, childTransforms.Length - 1 do
		childTransforms[i].gameObject.layer = layer
	end
    self.planarReflectionRenderer.planarReflectionController:RecalculateBounds()
end

-- 错帧预加载其余皮肤模型（跳过当前已持有的），避免同一帧批量 Get+Free
function SkinPanel:PreloadRoleModels()
    local skinList = Config.GetCharacterSkinInfoByCharacterID(self.roleId)
    local paths = {}
    local skipKey = nil
    if self.nowObj then
        skipKey = self.nowObj.name
    elseif self.nowSkinConfig and self.nowSkinConfig.modelKey then
        skipKey = self.nowSkinConfig.modelKey
    end
    for _, value in pairs(skinList) do
        if value.modelKey ~= skipKey then
            paths[#paths + 1] = string.format(Config.PrefabPath.RoleModelPrefab, value.modelKey, value.modelKey)
        end
    end

    local index = 1
    local function preloadNext()
        if not self:CheckSelfHasNotBeDestory() then
            return
        end
        if index > #paths then
            return
        end
        local path = paths[index]
        index = index + 1
        PoolMgr:Preload(path, 1, function()
            self:DoAfter(0.05, preloadNext)
        end)
    end
    preloadNext()
end

--初始化模型模式（兼容旧调用）
function SkinPanel:ModleInfo()
    self:SetupShowBgLayer()
    self:PreloadRoleModels()
end

-- 轻量级刷新装备状态，只更新UI不重新加载资源
function SkinPanel:RefreshEquipStatus()
    local roleData = Me:getPlayerHero(self.roleId)
    -- 更新皮肤列表中的装备状态标记
    for i = 1, #self.skinBoxList do
        local skinBox = self.skinBoxList[i]
        skinBox.obj.isEquip:SetActive(roleData.equipSkin == skinBox.config.id)
    end
    -- 更新底部按钮状态
    local skinState = Me:getSkinData(self.nowSelectSkinId)
    self.changeBtn:SetActive(skinState ~= nil and self.nowSelectSkinId ~= roleData.equipSkin)
    self.isNull:SetActive(skinState == nil)
    self.isEquip:SetActive(self.nowSelectSkinId == roleData.equipSkin)
end

--设置模型所有节点layer信息
function SkinPanel:SetLayerRecursively(obj, layer)
    -- 设置当前对象的Layer
    obj.layer = layer

    -- 遍历所有子对象
    for i = 0, obj.transform.childCount - 1 do
        local child = obj.transform:GetChild(i)
        self:SetLayerRecursively(child.gameObject, layer)  -- 递归调用
    end
end

--旋转模型
function SkinPanel:RotateObj()
    if self.nowMode == 1 then
        return
    end

    local isTouching = false
    if Input.touchCount > 0 then
        local touch = Input.GetTouch(0)
        isTouching = true
        self:HandleTouch(touch)
    elseif Input.GetMouseButton(0) then
        isTouching = true
        local mousePosition = Input.mousePosition
        local touch = {
            phase = Input.GetMouseButtonDown(0) and TouchPhase.Began or
                    Input.GetMouseButtonUp(0) and TouchPhase.Ended or
                    TouchPhase.Moved,
            position = mousePosition
        }
        self:HandleTouch(touch)
    end

    if not isTouching then
        self.startTouchPosition = nil
    end
end

function SkinPanel:HandleTouch(touch)
    local function clamp(value, min, max)
        if value < min then
            return min
        elseif value > max then
            return max
        else
            return value
        end
    end

    if touch.phase == TouchPhase.Began then
        self.startTouchPosition = touch.position.x
    elseif touch.phase == TouchPhase.Moved and self.startTouchPosition then
        local deltaX = touch.position.x - self.startTouchPosition
        if touch.position.x >= self.minX and touch.position.x <= self.maxX and
            touch.position.y >= self.minY and touch.position.y <= self.maxY then
            self.currentRotationY = self.currentRotationY + deltaX * 0.2
            self.camPoint.transform.rotation = Quaternion.Euler(0, self.currentRotationY, 0)
        end 
        self.startTouchPosition = touch.position.x
    elseif touch.phase == TouchPhase.Ended then
        self.startTouchPosition = nil
    end
end

--初始化动画列表
function SkinPanel:AnimListInfo(SkinConfig)
    self.skinAnimObjList = {}  -- 切换皮肤时清空旧列表，避免累积
    local totalAnimCount = tablex.size(SkinConfig.actionShow)
    local createdAnimCount = 0
    self:FillTemplateContent(self.animBox, self.animList, totalAnimCount, function(index, animBox)
        local temp = {
            obj = animBox,
            index = index,
        }
        table.insert(self.skinAnimObjList, temp)
        animBox.canvasGroup.alpha = 0
        self:DoAfter(index * 0.015, function()
            if UICommonUtils.Checkobj(animBox) then
                animBox.canvasGroup:DOFade(1, 0.2)
            end
        end)
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkinAnimIconPath, SkinConfig.actionShow[index][2]), function (s)
            animBox.animIcon.image.sprite = s
            animBox.animIcon.canvasGroup:DOFade(1, 0.2)
        end)
        animBox.animNameTxt.text.text = LocalStrEnum["animName_"..SkinConfig.actionShow[index][2]]
        animBox.scaleButton.onClick:RemoveAllListeners()
        animBox.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self:setAnim(SkinConfig, index) 
        end)

        createdAnimCount = createdAnimCount + 1
        if createdAnimCount == totalAnimCount then
            -- 所有动画格子创建完毕后再设置默认动画
            self:setAnim(SkinConfig, 1)
        end
    end)
end

--设置动画
--SkinConfig 皮肤配置
--index 选中的动作索引
function SkinPanel:setAnim(SkinConfig, index)
    if index == self.nowSelectSKinIndex then
        return
    end

    self.nowSelectSKinIndex = index
    self.nowSkinConfig = SkinConfig
    local actionType, actionName, backType = unpack(SkinConfig.actionShow[index])

    --根据配置查找需要返回的动画
    if self.model then
        if actionType == 1 then
            self.model:PlayAnim(RoleModelAnimEnum[actionName], function()
                --self.nowSelectSKinIndex = 2
                self.nowSelectSKinIndex = nil
                self:updateAnimSelection()
            end)
            if self.model then
                if backType == 1 then
                    self.model:SetDefaultState(RoleAnimStateType.Idle)
                else
                    self.model:SetDefaultState(RoleAnimStateType.IdleShip)
                end
            end
        elseif actionType == 2 then
            self.model:SetDefaultState(RoleAnimStateType[actionName])
        end
        self:updateAnimSelection()
    end
end

--更新动画选中状态
function SkinPanel:updateAnimSelection()
    for _, value in pairs(self.skinAnimObjList) do
        value.obj.isSelect:SetActive(value.index == self.nowSelectSKinIndex)
    end
end

function SkinPanel:resetRenderTexture()
    -- if not self.rt then
    --     self.rt = UnityEngine.RenderTexture(Screen.width, Screen.height, 24)
    -- end

    if not self.rt then
        local binder = self.gameObject:GetOrAddComponent(TypeInfo.RenderTextureBindCamera)
        self.rt = binder:CreateRenderTexture(self.objCamera.camera, Screen.width, Screen.height, "SkinPanel", true, true, false, true)
    end
    self.animObj.rawImage.texture = self.rt
    -- local rt = self.objCamera.camera.targetTexture
    -- rt:Release()
    -- rt.width = Screen.width
    -- rt.height = Screen.height
    -- rt:Create()
end

function SkinPanel:OnClose(initiative)
    -- 关闭前必须归还池对象，避免随 UI Destroy 弄脏 PoolManager，重开时报 require obj faild
    self:ReleaseSkinPoolObjects()
end

function SkinPanel:OnDestroy()
    self:ReleaseSkinPoolObjects()
    self.super:OnDestroy(self)
end

--function SkinPanel:OnRefresh(data)
--
--end

--[[
/SkinMode/ShowBtn onClick 
--]]
function SkinPanel:showBtn_ScaleButton_onClick(showBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("SkinViewPanel",  {skinId = self.nowSelectSkinId})
end

--[[
/MsgView/ChangeBtn onClick 
--]]
function SkinPanel:changeBtn_ScaleButton_onClick(changeBtn)
    self:play2DSound(self.btnSoundPath)
    local roleData = Me:getPlayerHero(self.roleId)
    if self.nowSelectSkinId == roleData.equipSkin then
        UICommonUtils.PopToast("当前皮肤已穿戴")
        return
    end
    Me:equipSkinReq({roleId = self.roleId, skinId = self.nowSelectSkinId}, function()
        -- 使用轻量级刷新，只更新装备状态，不重新加载spine，避免闪烁
        self:RefreshEquipStatus()
        UICommonUtils.PopToast("更换成功")
        -- 通知角色界面刷新
        GameMsgMgr:sendEvent(GameMsgType.HeroSkinChange)
    end)
end

--[[
/ChangeModeBtn onClick 
--]]
function SkinPanel:changeModeBtn_ScaleButton_onClick(changeModeBtn)
    self:play2DSound(self.btnSoundPath)
    if self.nowMode == 1 then
        self.nowMode = 2
    elseif self.nowMode == 2 then
        self.nowMode = 1
    end
    self:ModeChange()
end

return SkinPanel
