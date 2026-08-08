---@class FormationPanel : FormationPanel_Generate
---##################### 【FormationPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【FormationPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local FormationPanel = require "FormationPanel_Generate"
local battleMgr = BattleCore:getBattleMgr()
---@type UnityEngine.Screen
local Screen = UnityEngine.Screen
---@type UnityEngine.Physics
local Physics = UnityEngine.Physics

function FormationPanel:InitLogic(data)
    self._isRoleDragStarted = false
    self._tmpRoleObj = nil
    self.sortListOn = false     --排序列表是否开启
    self.AttributeList = {}
    self.nowSortMode = 0
    self.SortBtnList = {}
    self._allRoleList = {}
    self._onMapRoles = {}
    self.AutoMode = false

    self.modeData = {}
    local canvas = self.transform:GetComponent("Canvas")
    if canvas then
        -- LuaLogger.ds("canvas", canvas)
        -- local canvasRect = canvas:GetComponent("RectTransform")
        -- self.halfWidth = canvasRect.rect.width / 2
    else
        self.halfWidth = Screen.width / 2
    end
    self.roleConfig = {}
    self.equipPanelState = 0
    self.sortingOrderList = {}  --特效sortingOrder列表
    self._initFinish = false    --初始化完成
    self.roleBoxObjList = {} --角色格子列表
    self._clientBattleMgr = ClientBattleManager.getInstance()
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self._confirmLocked = false
    self._confirmLockTime = os.time()
    self.roleDragRate = 0.6
    UIMgr:depositUI(self)
end

--function FormationPanel:StartCreating(time)
--
--end

--function FormationPanel:StartEnter(time)
--
--end

--function FormationPanel:StartRemoving(time)
--
--end

--function FormationPanel:StartExit(time)
--
--end

function FormationPanel:OnOpen(data, initiative)
    self.skillMsgPanel.skillMsgPanel:setMono(self)
    if ClientBattleManager ~= nil then
        self._clientBattleMgr = ClientBattleManager.getInstance()
    end
    battleMgr = self._clientBattleMgr:getBattleMgr()
    if initiative then
        self:bindRoleList()
        self:InitSortingOrderList()
        self._initFinish = true
    end
    ---@type integer[] 行动顺序列表
    self.MoveList = nil
    self:SortInfo()
    self:refreshRoleList()
    local levelConfig = self._clientBattleMgr:getLevelConfig()
    self.maxPerson = levelConfig.maxPerson
    self.deployLimitText.text.text = "/"..self.maxPerson
    self._clickThreshold = 30

    GuideMgr:StartGuideTrigger("FormationPanel")
    self._showMgr = self._clientBattleMgr:getShowManager()
    self._camera = self._showMgr.camera
    -- self.roleCamRT.rawImage.texture = self._showMgr.roleCameraRT
    -- self.roleCamRT.rawImage:SetNativeSize()

    local inputMgr = self._clientBattleMgr:getInputManager()
    inputMgr:setInputEvent(function()
        self:inputMouseClick()
    end)

    --模拟演习显示情报按钮
    self:setSimulatedBuffInfo(levelConfig)
    if initiative then
        self:autoDeployBySaveFormationList()
        self:initTagListData(levelConfig)
        self:setTagListData()
    end
    self.weeklyBossTagRoot.gameObject:SetActive(levelConfig.typemain == GE.LevelTypeMain.WeeklyBoss)
    self:OnSortingOrderChange()
end

function FormationPanel:Update()
    ---视野缩放
	local zoomSpeed = 2
	if Input.touchCount >= 2 then
		---双指操控
        local touch1 = Input.GetTouch(0)
        local touch2 = Input.GetTouch(1)

		if touch1.phase == TouchPhase.Began or touch2.phase == TouchPhase.Began then
			self._isInControlZoom = false  -- 确保新手势重置状态
		end

		if touch1.phase == TouchPhase.Moved or touch2.phase == TouchPhase.Moved then
			local p = touch1.position - touch2.position
			local shitDistance = p.x * p.x + p.y * p.y

			if (not self._isInControlZoom) then
				self._isInControlZoom = true
				self._tempShitDistance = shitDistance
			else
				local sub = self._tempShitDistance - shitDistance
				self._showMgr:refreshViewDistance(-sub * zoomSpeed * 0.00001, false)
				self._tempShitDistance = shitDistance
			end
		end
		if touch1.phase == TouchPhase.Ended or touch1.phase == TouchPhase.Canceled or touch2.phase == TouchPhase.Ended or touch2.phase == TouchPhase.Canceled then
			self._isInControlZoom = false
		end
		return
    else
		--鼠标滚轮控制视野缩放
        local scroll = Input.GetAxis("Mouse ScrollWheel")
		self._showMgr:refreshViewDistance(scroll * zoomSpeed, false)
    end
end

function FormationPanel:inputMouseClick()
    ---鼠标按下初始化部分数据
	if (Input.GetMouseButtonDown(0)) then
		self._isDragging = false
        ---在上阵格子上可以拖动的角色
		self._tmpDragRole = nil
		self._initialPosition = Input.mousePosition
        self._clickUI = UICommonUtils.isPointerOverUIObject()
	end
	---鼠标拖动
	if (Input.GetMouseButton(0)) then
		if (self._initialPosition and Vector3.Distance(Input.mousePosition, self._initialPosition) > self._clickThreshold) then
			self._isDragging = true
		end
	end
    if self._isDragging == true then
        self:mouseDrag(self._camera)
    end
    if Input.GetMouseButtonUp(0) then
        self:mouseBtnUp(self._camera)
        self._showMgr:clearLastMousePosition()
    end
    if Input.GetMouseButtonDown(0) then
        self:mouseBtnDown(self._camera)
    end
    self:antoChangeRoleSkill()
end

---鼠标点击事件
---@param camera UnityEngine.Camera
function FormationPanel:mouseBtnDown(camera)
    if not camera or (self._clickUI and (not UIMgr.isScenePassEvent)) then
        return
    end
    local ray, hitBlock = Physics.Raycast(camera.main:ScreenPointToRay(Input.mousePosition), nil, 9999,
        LayerMask.GetMask("Square"))
    if (hitBlock ~= nil) then
        ---点击到格子
        local hitObj = hitBlock.transform.gameObject
        local showMgr = self._clientBattleMgr:getShowManager()
        local block = showMgr:getBlockByObj(hitObj)
        if block then
            if (self._clientBattleMgr:isBlockInFormationRange(block.id)) then
                local blockRole = block:tryGetRole()
                if (blockRole) then
                    self._tmpDragRole = blockRole
                    self._dragRoleStartPos = hitObj.transform.position
                end
            end
        end
    end
end

---鼠标抬起事件
---@param camera UnityEngine.Camera
function FormationPanel:mouseBtnUp(camera)
    if camera == nil or (self._clickUI and self._isDragging == false) then
        return
    end
    local mousePos = Input.mousePosition
    local block = nil
    local roleHit = false
    if not roleHit then
        local ray, hitBlock = Physics.Raycast(camera.main:ScreenPointToRay(mousePos), nil, 9999,
            LayerMask.GetMask("Square"))
        if (hitBlock ~= nil) then
            if (UICommonUtils.isPointerOverUIObject() and (not UIMgr.isScenePassEvent)) then
                if (not self._isDragging) then
                    return
                end
            end
            local hitObj = hitBlock.transform.gameObject
            block = self._showMgr:getBlockByObj(hitObj)
        end
    end
    if block then
        self:clickBlockInFormation(block, mousePos.x)
        if ((not self._isDragging) and self._initialPosition) then
            local blockRole = block:tryGetRole()
            if not blockRole then
                self._clientBattleMgr:RemoveRoleSelectStateInFormation()
            end
        end
    else
        self:retractRoleInFormation()
        if not self._isDragging and self._initialPosition then
            if (UICommonUtils.isPointerOverUIObject() and (not UIMgr.isScenePassEvent)) then
                return
            end
            local showMgr = self._clientBattleMgr:getShowManager()
            showMgr:hideBlockInfo()
            showMgr:hideRoleInfo()
            showMgr:refreshSelectedCube()
            self._clientBattleMgr:RemoveRoleSelectStateInFormation()
        end
    end
    self:clearDragData()
end

---鼠标拖动事件
---@param camera UnityEngine.Camera
function FormationPanel:mouseDrag(camera)
    if not camera then
        return
    end
    local mousePos = Input.mousePosition
    ---@type fun(roleObj:UnityEngine.GameObject) 拖动角色的方法
    local drugRoleFunc = function (roleObj)
        local hitPoint = nil
        mousePos.z = camera.main:WorldToScreenPoint(roleObj.transform.position).z
        hitPoint = camera.main:ScreenToWorldPoint(mousePos)
        hitPoint.y = 0.5
        roleObj.transform.position = hitPoint
    end
    ---从UI上拖动出角色
    if self._uiDragging then
        ---拖动角色副本
        if self._tmpDragRoleObj then
            drugRoleFunc(self._tmpDragRoleObj)
        end
    -- end
    -- if self._uiDragging == false then
    else
        if self._tmpDragRole then
            self._clientBattleMgr:RemoveRoleSelectStateInFormation()
            if self._tmpDragRoleObj == nil then
                self:closeRoleMsg()
                ---@type CharacterSkinTable
                local skinConfig = {}
                if self._tmpDragRole.isMonster then
                    skinConfig = Config.GetCharacterSkinInfo(self._tmpDragRole.roleConfig.baseSkinID)
                else
                    skinConfig = Config.GetCharacterSkinInfo(self._tmpDragRole.serverData.equipSkin)
                end
                self:OnStartDragRoleObj(skinConfig, self._dragRoleStartPos)
                self._showMgr:roleDragOutBlock(self._tmpDragRole.id)
            end
            ---拖动角色副本
            if self._tmpDragRoleObj then
                drugRoleFunc(self._tmpDragRoleObj)
            end
        else
            -- 拖动视野
            if (self._clickUI and (not UIMgr.isScenePassEvent)) then
                return
            end
            if (not self._lastMousePosition) then
                self._lastMousePosition = mousePos
            end
            self._showMgr:moveCamera(mousePos)
            self._lastMousePosition = mousePos
        end
    end
end

---布阵中点击地块
---@param block BattleBlock 地块
function FormationPanel:clickBlockInFormation(block, mousePosX)
    local roleMgr = self._clientBattleMgr:getRoleManager()
	if self._clientBattleMgr:isBlockInFormationRange(block.id) then
		if self._tmpFormationRole or (self._tmpDragRole ~= nil and self._isDragging) then
            self:lockConfirm()
			roleMgr:createRoleOnFormationState(block, GE.BattleCampType.Friend, self._tmpFormationRole or self._tmpDragRole.cid)
			-- local formationRole = roleMgr:getRoleByCid(self._tmpFormationRole or self._tmpDragRole.cid)
			-- if formationRole then
			-- 	showMgr:cancelRoleDrag(formationRole.id)
			-- end
            GuideMgr:IsInFormationGuide()
			self:refreshRoleList()
            self:setTagListData()
		end
	else
		self:retractRoleInFormation()
	end
	if (self._tmpFormationRole == nil and not self._isDragging) then
        local blockRole = roleMgr:getRole(block.roleId)
        if (blockRole) then
            local normalSkillConfig = Config.GetSkillInfo(blockRole.roleConfig.normalSkill)
            local roleData = {
                name = blockRole.roleConfig.name,
                hp = blockRole:getAttrib(GE.AttribType.Hp),
                maxHp = blockRole:getAttrib(GE.AttribType.MaxHp),
                level = blockRole.level,
                showLevel = blockRole.showLevel,
                range = normalSkillConfig.skillRange,
                movePower = blockRole.movePower,
                torpedo = blockRole:getAttrib(GE.AttribType.Torpedo),
                armor = blockRole:getAttrib(GE.AttribType.Armor),
                evade = blockRole:getAttrib(GE.AttribType.Evade),
                bombard = blockRole:getAttrib(GE.AttribType.Bombard),
                lucky = blockRole:getAttrib(GE.AttribType.Lucky),
                airdefense = blockRole:getAttrib(GE.AttribType.AirDefense),
                isMonster = blockRole.isMonster,
                roleServerData = blockRole.serverData,
                cid = blockRole.cid,
                skillList = blockRole:getActiveSkillList(),     --.skillList
                attribute = blockRole.roleConfig.attribute,
                camp = blockRole.camp,
            }
            self:ShowRoleMsg({ pos = mousePosX, roleData = roleData })
            battleMgr:showRoleActionRange(blockRole)
            self._clientBattleMgr:showRoleActionRange(blockRole)
        else
            self._clientBattleMgr:RemoveRoleSelectStateInFormation()
            self:closeRoleMsg()
            -- self.roleMsgMask.gameObject:SetActive(false)
        end
	end
end

---布阵界面下阵角色
function FormationPanel:retractRoleInFormation()
    if self._tmpDragRole then
        local roleMgr = battleMgr:getRoleManager()
        roleMgr:removeRole(self._tmpDragRole, false, true)
        self:refreshRoleList()
        self:setTagListData()
    end
end

function FormationPanel:setUIDragging(isDrag)
	self._uiDragging = isDrag
end

---@param cid integer 角色ID
function FormationPanel:selectedFormationRole(cid)
	self._tmpFormationRole = cid
end

---初始化特效sortingOrder
function FormationPanel:InitSortingOrderList()
    local sortingOrderList = {}
    local obj = self.confirmBtn.effect.transform
    for i = 1, obj.childCount do
        local ParticleSystemRenderer = obj:GetChild(i - 1).gameObject:GetComponent("ParticleSystemRenderer")
        sortingOrderList[i] = ParticleSystemRenderer.sortingOrder
        -- print("OnSortingOrderChange InitSortingOrderList", ParticleSystemRenderer.sortingOrder)
    end
    self.sortingOrderList = sortingOrderList
end

--调整界面特效sortingOrder
function FormationPanel:OnSortingOrderChange()
    if not self._initFinish then
        return
    end
    local nowOrder = self.transform:GetComponent("Canvas").sortingOrder
    -- print("OnSortingOrderChange nowOrder", nowOrder)
    local obj = self.confirmBtn.effect.transform
    for i = 1, obj.childCount do
        local ParticleSystemRenderer = obj:GetChild(i - 1).gameObject:GetComponent("ParticleSystemRenderer")
        ParticleSystemRenderer.sortingOrder = nowOrder + self.sortingOrderList[i]
    end
end

--筛选初始化
function FormationPanel:SortInfo()
    self.AttributeList = {}
    for key, value in pairs(GE.AttributeType) do
        local temp = {
            name = key,
            id = value,
        }
        table.insert(self.AttributeList, temp)
    end
    table.sort(self.AttributeList, function(a, b)
        return a.id < b.id
    end)

    self:FillTemplateContent(self.attributeBtn, self.attributeBtnList, tablex.size(self.AttributeList), function (index, attributeBtn)
        attributeBtn:SetActive(true)
        local temp = {id = self.AttributeList[index].id, obj = attributeBtn}
        table.insert(self.SortBtnList, temp)
        --战舰类型
        local typeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, self.AttributeList[index].id)
        self:LoadSpriteAsync(typeIconPath, attributeBtn.typeIcon.image)

        attributeBtn.isSelected:SetActive(temp.id == self.nowSortMode)
        attributeBtn.scaleButton.onClick:RemoveAllListeners()
        attributeBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self.nowSortMode = self.AttributeList[index].id
            for _, v in pairs(self.SortBtnList) do
                v.obj.isSelected:SetActive(v.id == self.nowSortMode)
            end
            self:refreshRoleList()
        end)
    end)
end

--角色列表初始化
function FormationPanel:bindRoleList()
    self.roleScrollView.loopListView2:InitListView(0, function(listView, index)
        local loopListViewItem = listView:GetShownItemByItemIndex(index)
        if loopListViewItem == nil then
            loopListViewItem = listView:NewListViewItem("FormationRole")
        end
        local roleItem = loopListViewItem.gameObject
        EngineUtil.FillPeer(self.formationRole, roleItem)
        local d = self._allRoleList[index + 1]
        local roleData = tablex.copy(d.userData)
        Me:setHeroAttribute(roleData)
        local roleConfig = d.roleCfg
        ---角色配置表ID
        local roleCId = roleConfig.id
        local dragListener = roleItem.dragListener
        local normalSkillConfig = Config.GetSkillInfo(roleConfig.normalSkill)

        local skinConfig = {}
		if roleData.isMonster then
			skinConfig = Config.GetCharacterSkinInfo(roleData.roleConfig.baseSkinID)
		else
			skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
		end

        ---设置拖拽事件
        dragListener.scrollRect = self.roleScrollView.scrollRect
        dragListener.onBeginDragEvent = function(v2)
            self._dragLastV2 = v2
            ---判断当前角色是否可以被拖拽上阵
            self._curRoleCanDrag = true
            self:_checkRoleCanBeDrag(roleCId)
            if self._curRoleCanDrag == false then
                UICommonUtils.PopToast(LocalStrEnum.battleTips_001)
            end
            ---只要点击到角色框，即可关闭当前两个窗口
            self:closeRoleMsg()
            self.skillMsgPanel.skillMsgPanel:closeSkillMask()
        end
        dragListener.onDragEvent = function (v2)
            if (self._curRoleCanDrag == false) then
                return
            end

            local offsetV2 = v2 - self._dragLastV2
            if (not self._isRoleDragStarted) then
                --将角色从列表中拖出
                if (offsetV2.y > 0 and (math.abs(offsetV2.y) > (math.abs(offsetV2.x)*self.roleDragRate)) and (math.abs(offsetV2.y) < 200)) then
                    --复位scrollRect
                    if (dragListener.scrollRect and dragListener.scrollRect.normalizedPosition.x < 0) then
                        dragListener.scrollRect.normalizedPosition = Vector2(0, 1)
                    end
                    dragListener.scrollRect = nil
                    self:_onRoleStartDrag(skinConfig, roleCId)
                end
            else
                --拖动角色
                self:_onRoleDrag(v2)
            end
        end
        dragListener.onEndDragEvent = function (v2)
            self._dragLastV2 = Vector2.zero;
            self:_onRoleStopDrag(roleCId)
            dragListener.scrollRect = self.roleScrollView.scrollRect
        end

        ---设置角色头像框
        local deployed = false
        for _, role in ipairs(self._onMapRoles) do
            if (role.cid == roleConfig.id) then
                deployed = true
            end
        end
        local roleEffect = battleMgr:GetAdvantageousRoleEffectList(roleConfig.id)
        local _isAdvantageousRole = roleEffect and next(roleEffect) ~= nil
        local roleHeadBox = roleItem.roleHeadBox
        roleHeadBox.roleHeadBox:setMono(self)
        roleHeadBox.roleHeadBox:refreshUI({
            roleId = roleCId,
            isDeployed = deployed,
            isAdvantageousRole = _isAdvantageousRole,
            -- roleImgScale = 1.3,
            clickFunc = function()
                local roleUIData = {
                    name = roleConfig.name,
                    hp = roleData.hp,
                    maxHp = roleData.hp,
                    level = roleData.level,
                    showLevel = roleData.level,
                    range = normalSkillConfig.skillRange,
                    movePower = roleConfig.movePowr,
                    torpedo = roleData.torpedo,
                    armor = roleData.armor,
                    evade = roleData.evade,
                    bombard = roleData.bombard,
                    lucky = roleData.lucky,
                    airdefense = roleData.airdefense,
                    isMonster = false,
                    roleServerData = roleData,
                    cid = roleCId,
                    skillList = roleData.EquippedSkillList,
                    attribute = roleConfig.attribute,
                    camp = GE.BattleCampType.Friend,
                }
                self.skillMsgPanel.skillMsgPanel:closeSkillMask()
                self:ShowRoleMsg({ pos = Input.mousePosition.x, roleData = roleUIData })
                if deployed then
                    local roleMgr = battleMgr:getRoleManager()
                    local blockRole = roleMgr:getRoleByCid(roleCId)
                    -- LuaLogger.ds("blockRole", tablex.dump(blockRole))
                    DLuaTimer:DoAfter(0.1, function()
                        battleMgr:showRoleActionRange(blockRole)
                        self._clientBattleMgr:showRoleActionRange(blockRole)
                    end)
                end
            end
        })
        self.roleBoxObjList[roleCId] = roleItem
        roleItem:SetActive(true)

        return loopListViewItem
    end)
end

---@class FormationRoleDataList
---@field userData HeroInfo ---TODO 角色服务器数据结构待完善
---@field roleCfg CharacterTable

--刷新角色列表
function FormationPanel:refreshRoleList()
    self.roleBoxObjList = {}
    self._onMapRoles = battleMgr:getRoleManager():getRolesByCamp(GE.BattleCampType.Friend)
    local roleList = ClientData:GetRoleList()
    ---@type FormationRoleDataList[]
    local characterTable = {}
    for _,v in pairs(roleList) do
        local roleConfig = Config.GetCharacterInfo(v.id)
        if self.nowSortMode ~= GE.AttributeType.All then
            local charRestraintConfig = Config.GetCharacterRestraintInfo(roleConfig.attribute)
            local restraintType = charRestraintConfig.restraintType
            if restraintType == self.nowSortMode then
                local temp = {userData = v, roleCfg = roleConfig}
                table.insert(characterTable, temp)
            end
        else
            local temp = {userData = v, roleCfg = roleConfig}
            table.insert(characterTable, temp)
        end
    end
    self._allRoleList = tablex.toarray(characterTable, function(a, b)
        return a.userData.level > b.userData.level
            or (a.userData.level == b.userData.level and a.roleCfg.rank > b.roleCfg.rank)
            or (a.userData.level == b.userData.level and a.roleCfg.rank == b.roleCfg.rank and a.userData.star > b.userData.star)
    end)
    -- self.roleScrollView.loopListView2:SetListItemCount(0)
    self.roleScrollView.loopListView2:SetListItemCount(#self._allRoleList)
    self.roleScrollView.loopListView2:RefreshAllShownItem2()

    self:setAutoBtnView()
    local temp = {}
    for _, value in pairs(self._onMapRoles) do
        table.insert(temp, value.cid)
    end
    FormationPanel:SetMoveList(temp)
    
    self.deployNumText.text.text = #self._onMapRoles
end

function FormationPanel:_checkRoleCanBeDrag(roleCid)
    for _, role in ipairs(self._onMapRoles) do
		if (role.cid == roleCid) then
            self._curRoleCanDrag = self._clientBattleMgr:isBlockInFormationRange(role.block.id)
            break
        end
	end
end

---拖动的回调事件（并非开始拖动的回调事件）
---@param skinConfig CharacterSkinTable 角色皮肤配置表数据
---@param roleCid integer 角色配置表ID
function FormationPanel:_onRoleStartDrag(skinConfig, roleCid)
    ---创建拖动角色副本
    if (not self._tmpDragRoleObj) then
        self:OnStartDragRoleObj(skinConfig)
    end
    self._isRoleDragStarted = true
    -- self.tmpRoleRoot:SetActive(true)
    self:setUIDragging(true)
    self:selectedFormationRole(roleCid)
end

function FormationPanel:_onRoleDrag(v2)
    
end

function FormationPanel:_onRoleStopDrag(roleCid)
    self._curRoleCanDrag = nil
    if (not self._isRoleDragStarted) then
        return
    end
    if (self._tmpDragRoleObj) then
        local formationRole = battleMgr:getRoleManager():getRoleByCid(self._tmpFormationRole)
		if (formationRole) then
			self._showMgr:cancelRoleDrag(formationRole.id)
		end
        PoolMgr.Free(self._tmpDragRoleObj)
        self._tmpDragRoleObj = nil
    end
    -- self.tmpRoleRoot:SetActive(false)
    self._isRoleDragStarted = false
    self:setUIDragging(false)
end

---开始拖动角色时，创建角色副本
---@param skinConfig CharacterSkinTable 角色皮肤配置表数据
---@param startPos UnityEngine.Vector3? 开始拖动的位置
function FormationPanel:OnStartDragRoleObj(skinConfig, startPos)
    if self._isLoadObj then
        return
    end
    self._isLoadObj = true
    local image = skinConfig.modelKey
    PoolMgr:Get(string.format(Config.PrefabPath.RoleModelPrefab, image, image), function(modelObj)
        if modelObj then
            local t = modelObj.transform
            t.localScale = Vector3.one * skinConfig.modelRate
            ---@type UnityEngine.Vector3
            local pos = nil
            if startPos == nil then
                local mousePos = Input.mousePosition
                local hitPoint = self._camera.main:ScreenToWorldPoint(mousePos)
                hitPoint.y = 0.5
                pos = hitPoint
            else
                pos = startPos
            end
            t.position = pos
            self._tmpDragRoleObj = modelObj
            ---@type RoleModelController
            local modelCtr = t:GetComponent("RoleModelController")
            modelCtr:SetColor(Color.New(1, 1, 1, 1))
            modelCtr:SetDefaultState(RoleAnimStateType.Pickup)
            modelCtr:TurnDirection(GE.RoleDirectionType.Up)
            -- modelCtr:SetShadowHeight(0.5)
        end
        self._isLoadObj = false
    end)
end

---清空拖动时创建的数据
function FormationPanel:clearDragData()
    self._initialPosition = nil
    self._lastMousePosition = nil
    self._isDragging = false
    self._tmpFormationRole = nil
    self._tmpDragRole = nil
    self._dragRoleStartPos = nil
    if self._tmpDragRoleObj then
        PoolMgr.Free(self._tmpDragRoleObj)
    end
    ---@type UnityEngine.GameObject
    self._tmpDragRoleObj = nil
    self._clickUI = nil
end

--排序列表动画
function FormationPanel:sortListAnim(isOn)
    if isOn then
        self.typeListBg.canvasGroup:DOFade(0, 0.3):SetEase(DG.Tweening.Ease.OutQuart)
        self.typeListBg.rectTransform:DOSizeDelta(Vector2(0, self.typeListBg.rectTransform.sizeDelta.y), 0.5)
        self.typeSelBtn.open:SetActive(false)
        self.sortListOn = false
    else
        self.typeListBg.rectTransform:DOSizeDelta(Vector2(948, self.typeListBg.rectTransform.sizeDelta.y), 0.5)
        self.typeSelBtn.open:SetActive(true)
        self.sortListOn = true
        self.typeListBg.canvasGroup:DOFade(1, 0.3):SetEase(DG.Tweening.Ease.OutQuart)
    end
end

--设置一键上阵状态
function FormationPanel:setAutoBtnView()
    local isDeploy = false
    if (self._onMapRoles and next(self._onMapRoles)) then
        for _, value in pairs(self._onMapRoles) do
            local block = value:getShowBlock()
            if (self._clientBattleMgr:isBlockInFormationRange(block.id)) then
                isDeploy = true
                break
            end
        end
    end
    if (isDeploy) then
        self.autoDeployBtn:SetActive(false)
        self.autoClearBtn:SetActive(true)
    else
        self.autoDeployBtn:SetActive(true)
        self.autoClearBtn:SetActive(false)
    end
end

--载入编队信息
---@param teamData FormationData
function FormationPanel:LoadFormation(teamData)
    ---@type FormationInfo[]
    local temp = {}
    local formationListData = teamData.formationList
    for _, value in pairs(formationListData) do
        local roleCid = value.roleCid
        -- 判断这个角色是不是被强制上场了，如果是则跳过，不是则上场
        self._curRoleCanDrag = true
        self:_checkRoleCanBeDrag(roleCid)
        if self._curRoleCanDrag == true then
            table.insert(temp, value)
        end
    end
    local blockList = self._clientBattleMgr:getFormationRangeIdList()
    for _, value in ipairs(temp) do
        local roleCid = value.roleCid
        local blockId = blockList[value.blockIndex]
        local block = battleMgr:getBlockById(blockId)
        if block then
            self:lockConfirm()
            battleMgr:getRoleManager():createRoleOnFormationState(block, GE.BattleCampType.Friend, roleCid)
        end
    end
    self:setAutoBtnView()
    self:refreshRoleList()
end

---@param data integer[] 上阵角色的配置表ID列表
function FormationPanel:SetMoveList(data)
    self.MoveList = data
end

function FormationPanel:GetMoveList()
    return self.MoveList
end

function FormationPanel:ShowRoleMsg(data)
    self.modeData = data
    self:SetRoleMsgView()
    -- self.roleMsgMask.pointerListener.onPointerClickEvent = function ()
    --     if (not self.isDraging) then
    --         self:closeRoleMsg()
    --     end
    -- end
    local dragListener = self.roleMsgMask.dragListener
    dragListener.onBeginDragEvent = function (v2)
        self:_onStartDrag()
    end
    dragListener.onEndDragEvent = function (v2)
        self:_onStopDrag()
    end
    -- self.roleMsgMask:SetActive(true)
    self.formationRoleMsgPanel:SetActive(true)
    self:SetSkillView()
end

function FormationPanel:RefreshSkillView()
    self:refreshRoleList()
    local serverData = Me:getPlayerHero(self.modeData.roleData.cid)
    self.modeData.roleData.skillList = serverData.EquippedSkillList
    -- self.modeData.roleData.roleServerData = Me:getPlayerHero(self.modeData.roleData.roleServerData.uid)
    self:SetSkillView()
    local blockRole = battleMgr._roleMgr:getRoleByCid(self.modeData.roleData.cid)
    if (blockRole) then
        blockRole.serverData = serverData
        blockRole.skillList = serverData.EquippedSkillList
    end
end

--显示角色信息
function FormationPanel:SetRoleMsgView()
    self:play2DSound(self.btnSoundPath)
    -- self.unfoldRBtn:SetActive(self.modeData.pos > self.halfWidth)
    -- self.unfoldLBtn:SetActive(self.modeData.pos < self.halfWidth)
    -- LuaLogger.ds("self.halfWidth", self.halfWidth)
    local canvas = self.transform:GetComponent("Canvas")
    if canvas then
        local canvasRect = canvas:GetComponent("RectTransform")
        self.halfWidth = canvasRect.rect.width / 2
    end
    -- LuaLogger.ds("self.halfWidth", self.halfWidth)
    self.animator:SetTrigger("HeroInfoIn")
    if self.modeData.pos > self.halfWidth then
        self.formationRoleMsgPanel.roleInfoGroup.rectTransform.anchoredPosition = Vector2(-(self.halfWidth - self.halfWidth * 0.36) ,self.formationRoleMsgPanel.roleInfoGroup.rectTransform.anchoredPosition.y)
        self.formationRoleMsgPanel.skillPanel.rectTransform.anchoredPosition = Vector2(0 ,self.formationRoleMsgPanel.skillPanel.rectTransform.anchoredPosition.y)
    else
        self.formationRoleMsgPanel.roleInfoGroup.rectTransform.anchoredPosition = Vector2(self.halfWidth - self.halfWidth * 0.36 ,self.formationRoleMsgPanel.roleInfoGroup.rectTransform.anchoredPosition.y)
        self.formationRoleMsgPanel.skillPanel.rectTransform.anchoredPosition = Vector2(-(self.halfWidth - self.halfWidth * 0.88) ,self.formationRoleMsgPanel.skillPanel.rectTransform.anchoredPosition.y)
    end
    local roleData = self.modeData.roleData
    -- local roleConfig = role.roleConfig

    --LuaLogger.ds("roleData", tablex.dump(roleData))

    --显示详细信息
    self.formationRoleMsgPanel.nameText.text.text = roleData.name
    --self.formationRoleMsgPanel.enemyNameText.text.text = roleData.name
    -- self.attributeTxt.text.text = "舰种："..self.roleConfig.attribute
    self.formationRoleMsgPanel.hpTxt.text.text = roleData.hp
    self.formationRoleMsgPanel.enemyHpTxt.text.text = roleData.hp
    self.formationRoleMsgPanel.npcHpTxt.text.text = roleData.hp
    self.formationRoleMsgPanel.maxHpTxt.text.text = "/"..roleData.maxHp
    self.formationRoleMsgPanel.levelTxt.text.text = roleData.showLevel
    self.formationRoleMsgPanel.rangeTxt.text.text = roleData.range
    self.formationRoleMsgPanel.moveTxt.text.text = roleData.movePower

    --六维
    self.formationRoleMsgPanel.torpedoTxt.text.text = roleData.torpedo
    self.formationRoleMsgPanel.armorTxt.text.text = roleData.armor
    self.formationRoleMsgPanel.evadeTxt.text.text = roleData.evade
    self.formationRoleMsgPanel.bombardTxt.text.text = roleData.bombard
    self.formationRoleMsgPanel.luckyTxt.text.text = roleData.lucky
    self.formationRoleMsgPanel.airdefenseTxt.text.text = roleData.airdefense

    self.formationRoleMsgPanel.hpTxt:SetActive(GE.BattleCampType.Friend == roleData.camp)
    self.formationRoleMsgPanel.enemyHpTxt:SetActive(GE.BattleCampType.Enemy == roleData.camp)
    self.formationRoleMsgPanel.npcHpTxt:SetActive(GE.BattleCampType.FriendNPC == roleData.camp)

    self.formationRoleMsgPanel.friendGroup:SetActive(GE.BattleCampType.Friend == roleData.camp)
    self.formationRoleMsgPanel.enemyGroup:SetActive(GE.BattleCampType.Enemy == roleData.camp)
    self.formationRoleMsgPanel.npcGroup:SetActive(GE.BattleCampType.FriendNPC == roleData.camp)

    local function is_numeric(str)
        return tonumber(str) ~= nil
    end
    local skinConfig = {}
    if roleData.isMonster then
        local monsterConfig = Config.GetMonsterInfo(self.modeData.roleData.cid)
        skinConfig = Config.GetCharacterSkinInfo(monsterConfig.baseSkinID)
    else
        skinConfig = Config.GetCharacterSkinInfo(self.modeData.roleData.roleServerData.equipSkin) 
    end

    local resourceFolder = nil
    if is_numeric(skinConfig.resourceFolder) then
        resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
    else
        resourceFolder = skinConfig.resourceFolder
    end
    self.formationRoleMsgPanel.roleImg:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.CutRolePath, resourceFolder, skinConfig.halfimgKey), self.formationRoleMsgPanel.roleImg.image)
    --战舰类型
    local typeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, roleData.attribute)
    self:LoadSpriteAsync(typeIconPath, self.formationRoleMsgPanel.shipTypeIcon.image)
    local skills = self.modeData.roleData.skillList
    local skillIndex = 1
    for index, skillId in ipairs(skills) do
        local skillConfig = Config.GetSkillInfo(skillId)
        local box = self.formationRoleMsgPanel.skillPanel[string.format("skillBox%s", index)]
        if (skillConfig) then
            box.nameText.text.text = skillConfig.nameKey
            box.decText.text.text = skillConfig.desKey
            box.roundText.text.text = skillConfig.preCd
            box.rangeText.text.text = skillConfig.skillRange
            box.distanceText.text.text = skillConfig.effectRange[2]
            box.typeText.text.text = skillConfig.skillTypeName
            box:SetActive(true)
        else
            box:SetActive(false)
            LuaLogger.ds("FormationPanel:SetRoleMsgView no skillConfig skillId", skillId)
        end
        skillIndex = index + 1
    end
    for i = skillIndex, 3 do
        local box = self.formationRoleMsgPanel.skillPanel[string.format("skillBox%s", i)]
        box:SetActive(false)
    end
    
end

--根据角色id查找是否已经在地图内
---@param roleId integer
---@return boolean
function FormationPanel:getOnMapByRoleId(roleId)
    for _, v in pairs(self._onMapRoles) do
        if v.cid == roleId then
            return true
        end
    end
    return false
end

function FormationPanel:closeRoleMsg()
    self._clientBattleMgr:RemoveRoleSelectStateInFormation()
    self.animator:SetTrigger("HeroInfoOut")
    self.animOverCallBack:SetCallBack(function()
        self.roleMsgMask:SetActive(false)
        self.formationRoleMsgPanel:SetActive(false)
    end)
end

function FormationPanel:_onStartDrag()
    self.isDraging = true
end
function FormationPanel:_onStopDrag()
    self.isDraging = false
end

function FormationPanel:lockConfirm()
    -- self._clientBattleMgr:waitCreateRoleNum()
end

function FormationPanel:OnClose(initiative)
    self:clearDragData()
end

-- function FormationPanel:OnDestroy()
-- 	self.super:OnDestroy(self)
-- end

--function FormationPanel:OnRefresh(data)
--
--end

--[[
/Main/ConfirmBtn onClick 
--]]
function FormationPanel:confirmBtn_ScaleButton_onClick(confirmBtn)
    if self._clientBattleMgr:isCreatingRole() == true then
        return
    end
    local roleMgr = battleMgr:getRoleManager()
    self:play2DSound(self.btnSoundPath)
    self:closeRoleMsg()
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    local formationRolesCount = 0
    local onMapRoles = tablex.clone(self._onMapRoles)
    local moveList = FormationPanel:GetMoveList()
    roleMgr:SortRoleList(onMapRoles, moveList)
    local friendRolesCount = #onMapRoles
    local checkList = {}
    for _, v in ipairs(onMapRoles) do
        checkList[v.cid] = true
    end
    for _, value in ipairs(self._allRoleList) do
        local roleConfig = value.roleCfg
        if checkList[roleConfig.id] then
            formationRolesCount = formationRolesCount + 1
        end
    end

    ---上阵人数不足
    if (friendRolesCount <= 0) then
        UICommonUtils.PopToast(LocalStrEnum.Tips_CharactersNumLack)
        return
    end


    --人数不满时提示
    local battleStartFunc = function ()
        local moveList = FormationPanel:GetMoveList()
        roleMgr:setFormationRolesCount(formationRolesCount)
        roleMgr:changeRoleList(moveList)
        UIMgr:closeUI("FormationPanel")
        ---@type FormationInfo[]
        local temp = {}
        local maxCount = self._clientBattleMgr:getMaxFormationCount()
        local levelConfig = battleMgr:getLevelConfig()
        local levelType = levelConfig.typemain
        local formationRangeIdList = self._clientBattleMgr:getFormationRangeIdList()
        local passNum = 0
        local usedBlockIndexList = {}
        for _, value in ipairs(onMapRoles) do
            if passNum > maxCount then
                break
            end
            local isMonster = value.isMonster
            if not isMonster then
                passNum = passNum + 1
                local roleCid = value.cid
                local showBlock = value:getShowBlock()
                local formationBlockIndex = showBlock and tablex.indexof(formationRangeIdList, showBlock.id) or 0
                local _blockIndex = formationBlockIndex > 0 and formationBlockIndex or passNum
                if not usedBlockIndexList[_blockIndex] then
                    usedBlockIndexList[_blockIndex] = true
                else
                    _blockIndex = passNum
                end
                temp[passNum] = {
                    roleCid = roleCid,
                    blockIndex = _blockIndex,
                }
            end
        end
        self._clientBattleMgr:stopActionState()
        self._clientBattleMgr:saveFormationList(levelType, temp)
        self._clientBattleMgr:playBattleShow(function()
            self._showMgr:removeBlockTag()
            self._clientBattleMgr:endPlayBattleShow(function()
                self._clientBattleMgr:finishFormation()
            end)
        end)
    end
    if friendRolesCount < self.maxPerson and tablex.size(self._allRoleList) > self.maxPerson then
        UIMgr:popUI("MsgBox", {
            title = LocalStrEnum.PromptTitle, 
            content = LocalStrEnum.FightConfirm,
            type = MsgBoxType.OKCancel,
            okCallback = battleStartFunc,
        })
    else
        battleStartFunc()
    end

end

--[[
/Main/MoveOrderBtn onClick 
--]]
function FormationPanel:moveOrderBtn_ScaleButton_onClick(moveOrderBtn)
    self:play2DSound(self.btnSoundPath)
    self:closeRoleMsg()
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    UIMgr:popUICover("FormationMovePanel", {nowData = FormationPanel:GetMoveList(),})
end

--[[
/Main/FormationListBtn onClick 
--]]
function FormationPanel:formationListBtn_ScaleButton_onClick(formationListBtn)
    self:play2DSound(self.btnSoundPath)
    self:closeRoleMsg()
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    local roleMgr = battleMgr:getRoleManager()
    ---@type FormationInfo[]
    local temp = {}
    local onMapRoles = tablex.clone(self._onMapRoles)
    local moveList = FormationPanel:GetMoveList()
    roleMgr:SortRoleList(onMapRoles, moveList)
    local blockList = self._clientBattleMgr:getFormationRangeIdList()
    for _, role in ipairs(onMapRoles) do
        local block = role:getShowBlock()
        local formationBlockIndex = block and tablex.indexof(blockList, block.id) or 0
        if formationBlockIndex > 0 then
            table.insert(temp, {
                roleCid = role.cid,
                blockIndex = formationBlockIndex,
            })
        end
    end
    UIMgr:popUICover("FormationListPanel", {nowData = temp})
end

--[[
/Main/AutoBtn onClick 
--]]
function FormationPanel:autoBtn_ScaleButton_onClick(autoBtn)
    
end

--[[
/AttributeBtn onClick 
--]]
function FormationPanel:attributeBtn_ScaleButton_onClick(attributeBtn)

end

--[[
/FormationRole onClick 
--]]
function FormationPanel:formationRole_ScaleButton_onClick(formationRole)

end

--[[
/Main/SettingBtn onClick 
--]]
function FormationPanel:settingBtn_ScaleButton_onClick(settingBtn)
    self:play2DSound(self.btnSoundPath)
    local uiData = {
        isFormation = true
    }
    UIMgr:popUICover("BattleSetupPanel", uiData)
end

--[[
/Main/EnvironmentBtn onClick 
--]]
function FormationPanel:environmentBtn_ScaleButton_onClick(environmentBtn)

end

--[[
/Main/AutoDeployBtn onClick 
--]]
function FormationPanel:autoDeployBtn_ScaleButton_onClick(autoDeployBtn)
    if self._clientBattleMgr:isCreatingRole() == true then
        return
    end
    self:play2DSound(self.btnSoundPath)
    self:closeRoleMsg()
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    local blockList = self._clientBattleMgr:getFormationRangeIdList()
    for _, blockData in pairs(blockList) do
        local block = battleMgr:getBlockById(blockData)
        local blockRoleId = block:getTmpRoleId()
        if not blockRoleId then
            for _, roleData in ipairs(self._allRoleList) do
                local roleCid = roleData.roleCfg.id
                if not self:getOnMapByRoleId(roleCid) then
                    self:lockConfirm()
                    local role = battleMgr:getRoleManager():createRoleOnFormationState(block, GE.BattleCampType.Friend,
                        roleCid)
                    self._onMapRoles[#self._onMapRoles + 1] = role
                    break
                end
            end
        end
    end

    self:setAutoBtnView()
    self:refreshRoleList()
    self:setTagListData()
end

--[[
/Main/AutoClearBtn onClick 
--]]
function FormationPanel:autoClearBtn_ScaleButton_onClick(autoClearBtn)
    if self._clientBattleMgr:isCreatingRole() == true then
        return
    end
    self:play2DSound(self.btnSoundPath)
    self:closeRoleMsg()
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    local roleMgr = battleMgr:getRoleManager()
    if self._onMapRoles and next(self._onMapRoles) then
        for _, value in pairs(self._onMapRoles) do
            local block = value:getShowBlock()
            if self._clientBattleMgr:isBlockInFormationRange(block.id) then
                roleMgr:removeRole(value, false, true)
            end
        end
    end
    self:setAutoBtnView()
    self:refreshRoleList()
    self:setTagListData()
end

--设置技能显示
function FormationPanel:SetSkillView()
    local skillData = self.modeData.roleData.skillList
    if LuaLogger.Enabled then
        LuaLogger.ds("self.modeData.roledata", tablex.dump(self.modeData.roleData))
    end
    local isMonster = self.modeData.roleData.isMonster
    for i = 1, 3 do
        ---@type FormationPanel_Generate_skillBox_1
        local curBox = self["skillBox_"..i]
        local curSkillId = skillData[i]
        curBox.btn.scaleButton.onClick:RemoveAllListeners()
        curBox.btn.scaleButton.onClick:AddListener(function()
            local temp = {
                roleCid = self.modeData.roleData.cid,
                skillId = curSkillId,
                index = i
            }
            if curSkillId ~= 0 and curSkillId ~= nil then
                self.skillMsgPanel.skillMsgPanel:showSkillMsg(temp, isMonster)
            else
                if not isMonster then
                    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
                    UIMgr:popUICover("SkillChangePanel", temp)
                end
            end
        end)
        if curSkillId ~= 0 and curSkillId ~= nil then
            curBox.addBg:SetActive(false)
            curBox.nullBg:SetActive(true)
            curBox.isOn:SetActive(true)
            local skillConfig = Config.GetSkillInfo(curSkillId)
            curBox.passivity:SetActive(skillConfig.skillType == GE.SkillType.Passive)
            curBox.iconImg:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), curBox.iconImg.image)
        else
            local isMonster = self.modeData.roleData.isMonster
            curBox.addBg:SetActive(not isMonster)
            curBox.nullBg:SetActive(true)
            curBox.isOn:SetActive(false)
            curBox.passivity:SetActive(false)
        end
    end

    local roleConfig = {}
    local talentConfig = {}
    if isMonster then
        roleConfig = Config.GetMonsterInfo(self.modeData.roleData.cid)
        if roleConfig.talentId ~= nil and roleConfig.talentId ~= 0 then
            self.talentBox.isOn:SetActive(true)
            self.talentBox.nullBg:SetActive(true)
            talentConfig = Config.GetSkillInfo(roleConfig.talentId)
        else
            self.talentBox.isOn:SetActive(false)
            self.talentBox.nullBg:SetActive(true)
        end
    else
        roleConfig = Config.GetCharacterInfo(self.modeData.roleData.cid)
        if roleConfig.talentId[self.modeData.roleData.roleServerData.star] == nil or roleConfig.talentId[self.modeData.roleData.roleServerData.star] == 0 then
            self.talentBox.isOn:SetActive(false)
            self.talentBox.nullBg:SetActive(true)
        else
            self.talentBox.isOn:SetActive(true)
            self.talentBox.nullBg:SetActive(true)
            talentConfig = Config.GetSkillInfo(roleConfig.talentId[self.modeData.roleData.roleServerData.star])
        end
    end

    if talentConfig and next(talentConfig) then
        self.talentBox.iconImg:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, talentConfig.icon), self.talentBox.iconImg.image)
    end
    
    self.talentBox.btn.scaleButton.onClick:RemoveAllListeners()
    self.talentBox.btn.scaleButton.onClick:AddListener(function()
        local temp = {}
        if self.modeData.roleData.isMonster then
            temp = {
                skillId = roleConfig.talentId
            }
        else
            temp = {
                skillId = roleConfig.talentId[self.modeData.roleData.roleServerData.star]
            }
        end
        if temp.skillId ~= nil and temp.skillId ~= 0 then
            self.skillMsgPanel.skillMsgPanel:showSkillMsg(temp, isMonster)
        end
    end)
end

--设置模拟演习情报信息
---@param levelConfig table 关卡配置
function FormationPanel:setSimulatedBuffInfo(levelConfig)
    if levelConfig.typemain ~= GE.LevelTypeMain.Simulated then
        return
    end
    self.levelBuffBtn:SetActive(true)
    local buffConfig = levelConfig.levelSkillDes
    self.buffMsgTxt.text.text = LocalStrEnum[buffConfig.key]
end

---自动上阵存储的阵容
function FormationPanel:autoDeployBySaveFormationList()
    local levelConfig = battleMgr:getLevelConfig()
    local formationIdList = self._clientBattleMgr:getSavedFormationList(levelConfig.typemain)
    if next(formationIdList) == nil then
        return
    end
    local blockList = self._clientBattleMgr:getFormationRangeIdList()
    for _, formationData in ipairs(formationIdList) do
        local roleCid = formationData.roleCid or 0
        local formationBlockIndex = formationData.blockIndex or 0
        local blockId = blockList[formationBlockIndex]
        if roleCid > 0 and blockId and not self:getOnMapByRoleId(roleCid) and Me:getPlayerHero(roleCid) then
            local block = battleMgr:getBlockById(blockId)
            local blockRoleId = block and block:getTmpRoleId()
            if block and not blockRoleId then
                self:lockConfirm()
                battleMgr:getRoleManager():createRoleOnFormationState(block, GE.BattleCampType.Friend, roleCid)
            end
        end
    end

    self:setAutoBtnView()
    self:refreshRoleList()
end

--初始化周Boss本标签数据
---@param levelConfig PveLevelTable
function FormationPanel:initTagListData(levelConfig)
    if levelConfig.typemain == GE.LevelTypeMain.WeeklyBoss then
        self._allWeeklyBossTag = battleMgr:getAllWeeklyBossTag()
    end
end

function FormationPanel:showTotalTagAddition()
    local socreAddition = (1 + battleMgr:getweeklyBossScoreAddition()) * 100
    self.bossTagTipsTxt.text.text = LocalStrEnum.BossBattleEffectScore
    self.bossTagMsgTxt.text.text = socreAddition .."%"
end

function FormationPanel:setTagListData()
    if self._allWeeklyBossTag == nil then
        return
    end
    local passTagList = battleMgr:RefreshWeeklyBossTags()
    --生成tag格子
    self:FillTemplateContent(self.weeklyBossTagBox, self.content.gameObject, #self._allWeeklyBossTag, function (index, weeklyBossTagBox)
        local tagBox = weeklyBossTagBox.weeklyBossTagBox
        local tagId = self._allWeeklyBossTag[index]
        --初始化格子显示
        ---@type TagBoxData
        local boxData = {
            tagId = tagId,
            isActive = passTagList[tagId] ~= nil,
        }
        tagBox:setTagBoxData(boxData)
    end)
    self:showTotalTagAddition()
end

function FormationPanel:antoChangeRoleSkill()
    if Input.GetKey(KeyCode.Z) and Input.GetKeyDown(KeyCode.C) then
        LuaLogger.ds("自动更换技能")
        local roleMgr = battleMgr:getRoleManager()
        local onMapRoles = self._onMapRoles or roleMgr:getRolesByCamp(GE.BattleCampType.Friend)
        local roleCount = #onMapRoles
        ---@param role BattleRole
        local callFunc = function (role)
            local severData = role.serverData
            if severData then
                local _roleId = severData.id
                local allSkillList = Me:getHeroSkillList(_roleId)
                local changeSkillList = {}
                local cloneList = tablex.clone(allSkillList)
                for i = 1, 3 do
                    local randomIndex = math.random(1, #cloneList)
                    changeSkillList[i] = cloneList[randomIndex]
                    table.remove(cloneList, randomIndex)
                end
                local temp = {
                    roleId = _roleId,
                    skillList = changeSkillList
                }
                return temp
            end
        end
        if roleCount > 0 then
            local roleIndex = 1
            local curRole = onMapRoles[roleIndex]
            local function changeNextRoleSkill()
                local tempData = callFunc(curRole)
                if tempData then
                    Me:equipRoleSkillReq(tempData, function()
                        roleIndex = roleIndex + 1
                        if roleIndex <= roleCount then
                            curRole = onMapRoles[roleIndex]
                            changeNextRoleSkill()
                        end
                    end)
                else
                    roleIndex = roleIndex + 1
                    if roleIndex <= roleCount then
                        curRole = onMapRoles[roleIndex]
                        changeNextRoleSkill()
                    end
                end
            end
            changeNextRoleSkill()
        end
    end
end

--[[
/FormationRoleMsgPanel/RoleInfoGroup/RoleDetailBtn onClick 
--]]
function FormationPanel:roleDetailBtn_ScaleButton_onClick(roleDetailBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("RolePanel", {id = self.modeData.roleCid, configData = self.roleConfig, isJump = true})
end

--[[
/FormationRoleMsgPanel/RoleInfoGroup/CheckEquipBtn onClick 
--]]
function FormationPanel:checkEquipBtn_ScaleButton_onClick(checkEquipBtn)
    
end

--[[
/FormationRoleMsgPanel/RoleInfoGroup/SkillInfoBtn onClick 
--]]
function FormationPanel:skillInfoBtn_Button_onClick(skillInfoBtn)
    self:play2DSound(self.btnSoundPath)
    self.formationRoleMsgPanel.skillPanel:SetActive(true)
end

--[[
/FormationRoleMsgPanel/SkillPanel/SkillPanelMask onClick 
--]]
function FormationPanel:skillPanelMask_Button_onClick(skillPanelMask)
    self:play2DSound(self.btnSoundPath)
    self.formationRoleMsgPanel.skillPanel:SetActive(false)
end

--[[
/FormationRoleMsgPanel/EquipPanel/UnfoldRBtn onClick 
--]]
function FormationPanel:unfoldRBtn_ScaleButton_onClick(unfoldRBtn)
    self:play2DSound(self.btnSoundPath)
    if self.equipPanelState == 1 then
        self.formationRoleMsgPanel.equipPanel.animation:Play("RightBack")
        self.equipPanelState = 0
    else
        self.formationRoleMsgPanel.equipPanel.animation:Play("Right")
        self.equipPanelState = 1
    end
end

--[[
/FormationRoleMsgPanel/EquipPanel/UnfoldLBtn onClick 
--]]
function FormationPanel:unfoldLBtn_ScaleButton_onClick(unfoldLBtn)
    self:play2DSound(self.btnSoundPath)
    if self.equipPanelState == -1 then
        self.formationRoleMsgPanel.equipPanel.animation:Play("LeftBack")
        self.equipPanelState = 0
    else
        self.formationRoleMsgPanel.equipPanel.animation:Play("Left")
        self.equipPanelState = -1
    end
end

--[[
/FormationRoleMsgPanel/EquipPanel/WeaponBox_1 onClick 
--]]
function FormationPanel:weaponBox_1_ScaleButton_onClick(weaponBox_1)

end

--[[
/FormationRoleMsgPanel/EquipPanel/WeaponBox_2 onClick 
--]]
function FormationPanel:weaponBox_2_ScaleButton_onClick(weaponBox_2)

end

--[[
/FormationRoleMsgPanel/EquipPanel/EquipList/EquipBox_1 onClick 
--]]
function FormationPanel:equipBox_1_ScaleButton_onClick(equipBox_1)

end

--[[
/FormationRoleMsgPanel/EquipPanel/EquipList/EquipBox_2 onClick 
--]]
function FormationPanel:equipBox_2_ScaleButton_onClick(equipBox_2)

end

--[[
/FormationRoleMsgPanel/EquipPanel/EquipList/EquipBox_3 onClick 
--]]
function FormationPanel:equipBox_3_ScaleButton_onClick(equipBox_3)

end

--[[
/FormationRoleMsgPanel/EquipPanel/EquipList/EquipBox_4 onClick 
--]]
function FormationPanel:equipBox_4_ScaleButton_onClick(equipBox_4)

end

--[[
/FormationRoleMsgPanel/RoleInfoGroup/RoleInfoBg/SkillInfoBtn onClick 
--]]
function FormationPanel:skillInfoBtn_ScaleButton_onClick(skillInfoBtn)

end

--[[
/FormationRoleMsgPanel/RoleInfoGroup/SkillMsgBtn onClick 
--]]
function FormationPanel:skillMsgBtn_ScaleButton_onClick(skillMsgBtn)

    
end

--[[
/FormationRoleMsgPanel/RoleInfoGroup/SkillList/SkillBox_1/Btn onClick 
--]]
function FormationPanel:btn_ScaleButton_onClick(btn)

end

--[[
/SkillMsgPanel/SkillMsgBg/EquipBtn onClick 
--]]
function FormationPanel:equipBtn_ScaleButton_onClick(equipBtn)

end

--[[
/SkillMsgPanel/SkillMsgBg/UnEquipBtn onClick 
--]]
function FormationPanel:unEquipBtn_ScaleButton_onClick(unEquipBtn)

end

--[[
/SkillMsgPanel/SkillMsgBg/ChangeBtn onClick 
--]]
function FormationPanel:changeBtn_ScaleButton_onClick(changeBtn)

end

--[[
/FormationRoleMsgPanel/RoleInfoGroup/TimeLineTestBtn onClick 
--]]
function FormationPanel:timeLineTestBtn_ScaleButton_onClick(timeLineTestBtn)
    
end

--[[
/Main/RestrictionInfo onClick 
--]]
function FormationPanel:restrictionInfo_Button_onClick(restrictionInfo)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("BattleRestrictionPanel")
end

--[[
/Main/TopGroup/AdjustRoot/LevelBuffBtn onClick 
--]]
function FormationPanel:levelBuffBtn_ScaleButton_onClick(levelBuffBtn)
    if self.buffMsgBg.canvasGroup.alpha == 1 then
        self.buffMsgBg.canvasGroup:DOFade(0, 0.2)
    else
        self.buffMsgBg.canvasGroup:DOFade(1, 0.2)
    end
end

--[[
/Main/BottomBg/AdjustRoot/TypeSelBtn onClick 
--]]
function FormationPanel:typeSelBtn_ScaleButton_onClick(typeSelBtn)
    self:play2DSound(self.btnSoundPath)
    self:closeRoleMsg()
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    self:sortListAnim(self.sortListOn)
end

return FormationPanel
