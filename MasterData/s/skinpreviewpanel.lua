---@class SkinPreviewPanel : SkinPreviewPanel_Generate
---##################### 【SkinPreviewPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkinPreviewPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class SkinPreviewPanel : SkinPreviewPanel_Generate
---##################### 【SkinPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkinPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkinPreviewPanel = require "SkinPreviewPanel_Generate"
local Screen = UnityEngine.Screen

function SkinPreviewPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
	}
    self.customBackPanel.customBackPanel:OverrideBackFunc(BindCallback_NoParams(self, self.OnCustomBackCloseBtnClick))

    self.nowMode = 1    --1立绘模式 2小人模式 3获得模式
    self.skinId = nil
    self.scroll_pos = 0
    self.pos = {}
    self.distance = 0
    self.skinBoxList = {}

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

    ---@type  DTimer.TimerInfo?
    self.yieldTimer = nil

    self.rt = nil
end

--function SkinPreviewPanel:StartCreating(time)
--
--end

--function SkinPreviewPanel:StartEnter(time)
--
--end

--function SkinPreviewPanel:StartRemoving(time)
--
--end

--function SkinPreviewPanel:StartExit(time)
--
--end

function SkinPreviewPanel:OnOpen(data, initiative)
    self:SetUpdateInterval(0)  --设置Update函数的调用间隔，0为每帧调用，单位为秒
    --TODO: 先开预加载，把当前角色的所有模型都加载出来
    --默认模式为立绘模式，小人模式进来直接从池子拿模型，就不会卡了！
    --if initiative then
    self.skinId = data.skinId
    self.goodsId = data.goodsId

    if data.nowMode == true then
        self.nowMode = 3
        self.curSkinIndex = 1
    end
    self.skinList = data.skinList
    self.callback = data.callback
    self:SetView()

    self:UpdateSkinView(self.skinId, true)

    self:UpdateSkinInfo()
    --end 
    --LoadingMgr:SetUISwitchOver()
end

function SkinPreviewPanel:SetView()
    self:ModleInfo()
    self:ModeChange()
    self:resetRenderTexture()
end

function SkinPreviewPanel:Update()
    self:RotateObj()
end

--模式切换
function SkinPreviewPanel:ModeChange()

    if self.nowMode == 1 then --立绘模式
        --导航栏
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.SkinPanel, self)
        self.skinMode.canvasGroup.alpha = 1
        self.modelMode.canvasGroup.alpha = 0
        self.skinMode.canvasGroup.blocksRaycasts = true
        self.modelMode.canvasGroup.blocksRaycasts = false
        if self.model then
            self:setAnim(self.nowSkinConfig, 1) 
        end
    elseif self.nowMode == 2 then
        --导航栏
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.SkinPanel_Action, self)
        self.skinMode.canvasGroup.alpha = 0
        self.modelMode.canvasGroup.alpha = 1
        self.skinMode.canvasGroup.blocksRaycasts = false
        self.modelMode.canvasGroup.blocksRaycasts = true
    elseif self.nowMode == 3 then
          --导航栏
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.SkinPanel, self)
        self.skinMode.canvasGroup.alpha = 1
        self.modelMode.canvasGroup.alpha = 0
        self.skinMode.canvasGroup.blocksRaycasts = false
        self.modelMode.canvasGroup.blocksRaycasts = false
        self.infoRoot.gameObject:SetActive(false)
        self.skipBtn.gameObject:SetActive(true)
        --播放动画
    end
    self.customBackPanel.gameObject:SetActive(self.nowMode ~= 3)
    self.skipBtn.gameObject:SetActive(false)
    self.changeModeBtn:SetActive(self.nowMode ~= 3)
    self.showBtn:SetActive(self.nowMode == 1)
    self.getRoot:SetActive(self.nowMode == 3)
    self.currentRotationY = 180
    self.camPoint.transform.rotation = Quaternion.Euler(0, self.currentRotationY, 0)
end

--切换皮肤
function SkinPreviewPanel:UpdateSkinView(skinId, isRefresh)

    local skinCfg = Config.GetCharacterSkinInfo(skinId)
    --LuaLogger.ds("切换皮肤", debug.traceback())
    if skinCfg == nil then
       return 
    end
    if skinCfg.id == self.nowSelectSkinId and not isRefresh then
        return
    end
    self.nowSelectSkinId = skinId
    self.roleId = skinCfg.CharacterID
    local roleData = Me:getPlayerHero(self.roleId)

    local roleConfig = Config.GetCharacterInfo(skinCfg.CharacterID)

    UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, self.nowSelectSkinId, function(spineObject)
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
            GameObject.Destroy(self.nowShowSpineObj)
        end
        self.nowShowSpineObj = spineObject

        ---@type UnityEngine.GameObject
        local cnm = spineObject

        ---@type Spine.Unity.SkeletonGraphic
        local skeletonGraphic = cnm:GetComponent(TypeInfo.SkeletonGraphic)
        ---@type Spine.Unity.SkeletonAnimation
        local skeletonAnimation = cnm:GetComponent(TypeInfo.SkeletonAnimation)

        if self.nowMode == 3 then
            local into = skeletonGraphic.Skeleton.Data:FindAnimation("into")
            if into ~= nil then
                skeletonAnimation.AnimationState:SetAnimation(0, "into", false)
               
                skeletonAnimation.AnimationState:AddAnimation(0, "idle", true, 0)
                self:PlayGetAniamtor(into.Duration)
            else
                self:PlayGetAniamtor()
            end
        else
            skeletonAnimation.AnimationState:AddAnimation(0, "idle", true, 0)
        end
    end)

    --策划要求和预览界面一样x轴变为0
    self.showCharacter.rectTransform.anchoredPosition = Vector2(0, skinCfg.imgOffset[2])
    self.showCharacter.rectTransform.anchoredPosition = Vector2(0, skinCfg.spineOffset[2])

    local skinState = Me:getSkinData(skinCfg.id)

    if self.nowObj ~= nil then
        if self.nowObj.name == skinCfg.modelKey then
            return
        end
        PoolMgr.Free(self.nowObj)
    end

    for _, value in pairs(self.waterCollisionObjs) do
        PoolMgr.Free(value)
    end

    PoolMgr:Get(string.format(Config.PrefabPath.RoleModelPrefab, skinCfg.modelKey, skinCfg.modelKey),function(obj)
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

        --添加水面碰撞效果
        for i = 0, self.model.footPoints.Length - 1 do
        -- for _, value in pairs(self.model.footPoints) do
            local value = self.model.footPoints[i]
            if value then
                PoolMgr:Get(Config.PrefabPath.WaterCollision,function(collisionObj)
                    print("skinpanel WaterCollision",collisionObj)
                    collisionObj:SetParent(value.transform)
                    collisionObj.transform.localPosition = Vector3.zero
                    collisionObj.transform.localRotation = Quaternion.Euler(0, 0, 0)
                    collisionObj.transform.localScale = Vector3.one
                    table.insert(self.waterCollisionObjs, collisionObj)
                end)
            end
        end
    end)
    self:AnimListInfo(skinCfg)
end

--初始化模型模式
function SkinPreviewPanel:ModleInfo()
    -- local skinList = Config.GetCharacterSkinInfoByCharacterID(self.roleId)
    -- for _, value in pairs(skinList) do
    --     local objPath = string.format(Config.PrefabPath.RoleModelPrefab, value.modelKey, value.modelKey)
    --     PoolMgr:Preload(objPath, 1)
    -- end
    local layer = UnityEngine.LayerMask.NameToLayer("Water")
	self.showBg.layer = layer
	local childTransforms = self.showBg:GetComponentsInChildren(typeof(UnityEngine.Transform), true)
	for i = 0, childTransforms.Length - 1 do
		childTransforms[i].gameObject.layer = layer
	end
    self.planarReflectionRenderer.planarReflectionController:RecalculateBounds()
end

--设置模型所有节点layer信息
function SkinPreviewPanel:SetLayerRecursively(obj, layer)
    -- 设置当前对象的Layer
    obj.layer = layer

    -- 遍历所有子对象
    for i = 0, obj.transform.childCount - 1 do
        local child = obj.transform:GetChild(i)
        self:SetLayerRecursively(child.gameObject, layer)  -- 递归调用
    end
end

--旋转模型
function SkinPreviewPanel:RotateObj()
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

function SkinPreviewPanel:HandleTouch(touch)
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
function SkinPreviewPanel:AnimListInfo(SkinConfig)
    self:FillTemplateContent(self.animBox, self.animList, tablex.size(SkinConfig.actionShow), function(index, animBox)
        local temp = {
            obj = animBox,
            index = index,
        }
        table.insert(self.skinAnimObjList, temp)
        animBox.canvasGroup.alpha = 0
        DLuaTimer:DoAfter(index * 0.015, function()
            animBox.canvasGroup:DOFade(1, 0.2)
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
    end)

    self:setAnim(SkinConfig, 1) 
end

--设置动画
--SkinConfig 皮肤配置
--index 选中的动作索引
function SkinPreviewPanel:setAnim(SkinConfig, index)
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
function SkinPreviewPanel:updateAnimSelection()
    for _, value in pairs(self.skinAnimObjList) do
        value.obj.isSelect:SetActive(value.index == self.nowSelectSKinIndex)
    end
end

function SkinPreviewPanel:resetRenderTexture()
    -- if not self.rt then
    --     self.rt = UnityEngine.RenderTexture(Screen.width, Screen.height, 24)
    -- end
    if not self.rt then
        local binder = self.gameObject:GetOrAddComponent(TypeInfo.RenderTextureBindCamera)
        self.rt = binder:CreateRenderTexture(self.objCamera.camera, Screen.width, Screen.height, "SkinPreviewPanel", true, true, false, true)
    end
    -- self.objCamera.camera.targetTexture = self.rt
    self.animObj.rawImage.texture = self.rt
end

--function SkinPreviewPanel:OnClose(initiative)
--
--end

function SkinPreviewPanel:OnDestroy()
	--self.super:OnDestroy(self)
    -- if self.nowObj ~= nil then
    --     PoolMgr.Free(self.nowObj)
    -- end
    -- if self.rt then
    --     self.rt:Release()
    -- end
    self.super:OnDestroy(self)
end

function SkinPreviewPanel:UpdateSkinInfo()
    self.infoView:SetActive(true)
    local skinCfg = Config.GetCharacterSkinInfo(self.skinId)
    local heroCfg = Config.GetCharacterInfo(skinCfg.CharacterID)
    self.heroNameText.text.text = heroCfg.name
    self.skinNameText.text.text = skinCfg.skinName
    self.describeText.text.text = skinCfg.skinDesc

    self.get_heroNameText.text.text = heroCfg.name
    self.get_heroSkinInfo.get_skinNameText.text.text = skinCfg.skinName
    self.get_skinDescribeText.text.text = skinCfg.skinDesc

    --写入标签
    self:FillTemplateContent(self.tagPrefab, self.tagGroup, tablex.size(skinCfg.skinSign), function(index, tagBox)
            tagBox:SetActive(false)
            tagBox:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.SkinTagBgPath, skinCfg.skinSign[index]), tagBox.image)
            tagBox.nameText.text.text = LocalStrEnum["skinSign_"..skinCfg.skinSign[index]]
        end)

    local isUnlock = false
    if self.goodsId ~= nil and self.goodsId ~= 0 then
        isUnlock = Me:CheckGoodsUnlock(self.goodsId)
    end
    local isOwn = Me:getSkinData(self.skinId) ~= nil
    ---写入价格
    if isUnlock and (not isOwn) then
   
        local goodsCfg = Config.GetShopMerchandiseInfo(self.goodsId)
        local picId, picNum, picRate = Me:GetShopItemPic(self.goodsId)

        local picItemCfg = Config.GetItemInfo(picId)
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, picItemCfg.icon), self.picImg.image)
        self.picText.text.text = tostring(picNum)

        self.discountText.gameObject:SetActive(picRate ~= 0)
        if picRate ~= 0 then
            self.discountText.text.text = tostring(goodsCfg.price[3])
        end
        self.buyBtn.gameObject:SetActive(true)
    else
        self.buyBtn.gameObject:SetActive(false)
    end

    local state = 0 ---0 为拥有角色 1未穿戴 2 已穿戴
    local heroInfo = Me:getPlayerHero(skinCfg.CharacterID)
    if heroInfo == nil then
       state = 0
    else
        if heroInfo.equipSkin == self.skinId then
            state = 2
        else
            state = 1 
        end
    end

    self.putOnBtn.gameObject:SetActive(state == 1)
    self.useingBtn.gameObject:SetActive(state == 2)
    self.noActiveBtn.gameObject:SetActive(state == 0)
end

--function SkinPreviewPanel:OnRefresh(data)
--
--end

--[[
/SkinMode/ShowBtn onClick 
--]]
function SkinPreviewPanel:showBtn_ScaleButton_onClick(showBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("SkinViewPanel",  {skinId = self.nowSelectSkinId})
end

--[[
/MsgView/ChangeBtn onClick 
--]]
function SkinPreviewPanel:changeBtn_ScaleButton_onClick(changeBtn)
    self:play2DSound(self.btnSoundPath)
    local roleData = Me:getPlayerHero(self.roleId)
    if self.nowSelectSkinId == roleData.equipSkin then
        UICommonUtils.PopToast("当前皮肤已穿戴")
        return
    end
    Me:equipSkinReq({roleId = self.roleId, skinId = self.nowSelectSkinId}, function()
        self:SetView()
        UICommonUtils.PopToast("更换成功")
        self:UpdateSkinView(self.nowSkinConfig, true)
        -- 通知角色界面刷新
        GameMsgMgr:sendEvent(GameMsgType.HeroSkinChange)
    end)
end

--[[
/ChangeModeBtn onClick 
--]]
function SkinPreviewPanel:changeModeBtn_ScaleButton_onClick(changeModeBtn)
    self:play2DSound(self.btnSoundPath)
    if self.nowMode == 1 then
        self.nowMode = 2
    elseif self.nowMode == 2 then
        self.nowMode = 1
    end
    self:ModeChange()
end

--[[
/infoRoot/infoBtn onClick 
--]]
function SkinPreviewPanel:infoBtn_ScaleButton_onClick(infoBtn)

    local isActive = self.infoView.activeSelf
    self.infoView:SetActive(not isActive)
end

--[[
/infoRoot/infoView/buyBtn onClick 
--]]
function SkinPreviewPanel:buyBtn_ScaleButton_onClick(buyBtn)
    Me:BuyItem(self.goodsId, 1)
end

--[[
/getRoot/skipBtn onClick 
--]]
function SkinPreviewPanel:skipBtn_ScaleButton_onClick(skipBtn)

    if self.nowShowSpineObj == nil then
       return 
    end
    ---@type UnityEngine.GameObject
    local cnm = self.nowShowSpineObj

    ---@type Spine.Unity.SkeletonAnimation
    local skeletonAnimation = cnm:GetComponent(TypeInfo.SkeletonAnimation)
    skeletonAnimation.AnimationState:SetAnimation(0, "idle", true)
    self:PlayGetAniamtor()

end

--[[
/getRoot/putOnBtn onClick 
--]]
function SkinPreviewPanel:putOnBtn_ScaleButton_onClick(putOnBtn)

    self:play2DSound(self.btnSoundPath)
    local roleData = Me:getPlayerHero(self.roleId)
    if self.nowSelectSkinId == roleData.equipSkin then
        UICommonUtils.PopToast("当前皮肤已穿戴")
        return
    end
    Me:equipSkinReq({roleId = self.roleId, skinId = self.nowSelectSkinId}, function()
        UICommonUtils.PopToast("更换成功")
        -- 通知角色界面刷新
        self:UpdateSkinInfo()
        GameMsgMgr:sendEvent(GameMsgType.HeroSkinChange)
    end)
end

function SkinPreviewPanel:OnCustomBackCloseBtnClick()

    if self.skinList == nil or self.curSkinIndex >= #self.skinList then
        self:OnCustomBackCBtnClick()
        if self.callback ~= nil then
            self.callback()            
        end
        return
    end

    self.curSkinIndex = self.curSkinIndex + 1
    self.skinId = self.skinList[self.curSkinIndex]
    self:SetView()
    self:UpdateSkinView(self.skinId)
    self:UpdateSkinInfo()
end

function SkinPreviewPanel:OnCustomBackCBtnClick()
    self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
        LoadingMgr:SetUISwitchStart(function()
            UIMgr:closeSpecificUI(self)
            self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
            --目前没有特殊返回， LoadingMgr:SetUISwitchOver()会重复调用所以此处无需调用

            LoadingMgr:SetUISwitchOver(function()
            end)
        end)
        --清空返回方法
    self.customBackPanel.customBackPanel:ClearBackFunc()
end

---播放获得动画的anima
---@param duration number? 延时
function SkinPreviewPanel:PlayGetAniamtor(duration)
    self.getRoot:SetActive(false)
    self.skipBtn.gameObject:SetActive(true)
    self.stateInfo:SetActive(false)
    self.get_heroNameText.gameObject:SetActive(false)
    self.get_skinDescribeText.gameObject:SetActive(false)
    if self.yieldTimer ~= nil then
        self.yieldTimer:Stop()
        self.yieldTimer = nil
    end
    local fun = function ()
        self.getRoot:SetActive(true)
    
        ---@type UnityEngine.Animation
        local anima = self.get_heroSkinInfo.gameObject:GetComponent(TypeInfo.Animation)
        anima:Play("heroSkinClip")
        local time = anima:GetClip("heroSkinClip").length
        self.yieldTimer = nil
        self.yieldTimer = DLuaTimer:DoAfter(time, function()
            self.get_skinDescribeText.gameObject:SetActive(true)
            self.stateInfo:SetActive(true)
            self.get_heroNameText.gameObject:SetActive(true)
            self.get_skinDescribeText.gameObject:SetActive(true)
            self.yieldTimer = nil
        end)
        self.skipBtn.gameObject:SetActive(false)
        self.customBackPanel.gameObject:SetActive(true)
    end
    if duration == nil or duration <= 0 then
        fun()
        return
    end
    self.yieldTimer = DLuaTimer:DoAfter(duration, fun)
    --self.yieldTimer.RealTime = false
end

return SkinPreviewPanel
