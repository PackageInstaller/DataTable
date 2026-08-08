---@diagnostic disable: undefined-global
require "class"
---@class BattleInputManager:BaseClass
local BattleInputManager = class("BattleInputManager")
local BattleCore = require "BattleCore"

function BattleInputManager:ctor()
    BattleCore.ds("BattleInputManager:ctor")
    ---@type BattleManager
    self._battleMgr = nil
    self._clickThreshold = 30
    self._isDragging = false
    self._initialPosition = nil
    self._lastMousePosition = nil
    self._pointDownOnUI = nil
    self._isRotating = false
    self._lastRotatingMousePosition = nil
    self._isInControlZoom = false
    self._lastZoomDistance = nil

    self._canInput = false  -- 是否允许输入
    self._canClick = false  -- 是否可以点击
    ---@type BattleShowManager
    self._showMgr = nil  -- 显示管理器
end

---初始化输入管理器
---@param battleMgr BattleManager 战斗管理器
---@param clientBattleMgr ClientBattleManager 客户端战斗管理器
function BattleInputManager:init(battleMgr, clientBattleMgr)
    self._canDrag = true  -- 是否可以拖动
    self._canZoomCamera = true  -- 是否可以旋转和缩放相机
    self._battleMgr = battleMgr
    self._clientBattleMgr = clientBattleMgr
end

---设置显示管理器
---@param showMgr BattleShowManager 显示管理器
function BattleInputManager:SetShowManager(showMgr)
    self._showMgr = showMgr
    self._mouseClickEvent = nil
end

function BattleInputManager:update()
    self:EditorSpecialVictory()
    self:EditorSpecialDefeat()
    if not self._canInput then
        return
    end

    if self:shouldSkipUpdate() then
        return
    end

    local camera = self._showMgr.camera
    if not camera then
        return
    end

    -- 处理视野缩放
    self:handleZoom()

    if self._mouseClickEvent then
        -- 处理鼠标输入
        self._mouseClickEvent()
    end

    -- 处理视野旋转
    self:handleRotation()
end

function BattleInputManager:battleMouseInput()
    if Input.touchCount >= 2 then
        return
    end
    -- local inputDownStart = false
    -- local inputDown = false
    -- local inputUp = false
    -- if Input.touchCount >= 1 then
    --     local touch1 = Input.GetTouch(0)
    --     inputDownStart = touch1.phase == TouchPhase.Began
    --     inputDown = touch1.phase == TouchPhase.Moved or touch1.phase == TouchPhase.Stationary
    --     inputUp = touch1.phase == TouchPhase.Ended or touch1.phase == TouchPhase.Canceled
    -- else
    --     inputDownStart = Input.GetMouseButtonDown(0)
    --     inputDown = Input.GetMouseButton(0)
    --     inputUp = Input.GetMouseButtonUp(0)
    -- end

    --按下
	if Input.GetMouseButtonDown(0) then
		-- 真机:只记录触摸ID,不保存触摸对象
		self._touchId = Input.touchCount > 0 and Input.GetTouch(0).fingerId or -1
		self.mouseDownPosition = Input.touchCount > 0 and Input.GetTouch(0).position or UnityEngine.Input.mousePosition
        --处理鼠标按下事件
        self:onMouseButtonDown(self.mouseDownPosition)
	end

    -- 处理鼠标拖动事件
    if Input.GetMouseButton(0) and self.mouseDownPosition then
        self:onMouseButton()
    end

    local camera = self._showMgr.camera
    -- 处理鼠标抬起事件
    if Input.GetMouseButtonUp(0) then
        self:onMouseButtonUp(camera)
        self._showMgr:clearLastMousePosition()
        self._touchId = nil  -- 清空触摸ID
        self.mouseDownPosition = nil
    end
end

function BattleInputManager:setBattleInputMouseClick()
    self:setInputEvent(function ()
        self:battleMouseInput()
    end)
end

---@param event function 鼠标点击事件
function BattleInputManager:setInputEvent(event)
    if type(event) == "function" then
        self._mouseClickEvent = event
    else
        BattleCore.ws("BattleInputManager:setInputEvent - event is not a function")
    end
end

---检查当前是否应该跳过输入处理
---@return boolean 是否应该跳过
function BattleInputManager:shouldSkipUpdate()
    if not self._showMgr then
        return true
    end

    -- 如果处于故事模式状态
    if self._battleMgr._storyMgr and (self._battleMgr._battleState == GE.BattleState.PlayStory) then
        self._battleMgr._storyMgr:update()
        return true
    end

    return false
end

---处理视野缩放
function BattleInputManager:handleZoom()
    if self._canZoomCamera == false then
        return
    end

    local showMgr = self._showMgr
    local zoomSpeed = 2

    if Input.touchCount >= 2 then
        -- 双指操控
        local touch1 = Input.GetTouch(0)
        local touch2 = Input.GetTouch(1)

        if touch1.phase == TouchPhase.Began or touch2.phase == TouchPhase.Began then
            self._isInControlZoom = false
            self._lastZoomDistance = nil
            return  -- 等待下一次帧更新再开始计算
        end

        if touch1.phase == TouchPhase.Moved or touch2.phase == TouchPhase.Moved then
            local currentDistance = UnityEngine.Vector2.Distance(touch1.position, touch2.position)

            if not self._isInControlZoom then
                -- 初始化缩放状态
                self._isInControlZoom = true
                self._lastZoomDistance = currentDistance
            else
                -- 计算距离变化并应用缩放
                local distanceDelta = currentDistance - self._lastZoomDistance
                showMgr:refreshViewDistance(distanceDelta * zoomSpeed * 0.01, false)
                self._lastZoomDistance = currentDistance
            end
        end

        -- 检查是否有手指结束或取消
        if touch1.phase == TouchPhase.Ended or touch1.phase == TouchPhase.Canceled or 
           touch2.phase == TouchPhase.Ended or touch2.phase == TouchPhase.Canceled then
            self._isInControlZoom = false
            self._lastZoomDistance = nil
            self:resetMouseState()
        end
        return
    else
        -- 如果没有双指触摸，重置状态
        self._isInControlZoom = false
        self._lastZoomDistance = nil

        -- 鼠标滚轮控制视野缩放
        local scroll = Input.GetAxis("Mouse ScrollWheel")
        showMgr:refreshViewDistance(scroll * zoomSpeed, false)
    end
end

---处理鼠标按下事件
---@param position UnityEngine.Vector2 按下位置，由battleMouseInput统一传入
function BattleInputManager:onMouseButtonDown(position)
    self._isDragging = false
    self._initialPosition = position

    -- 检查是否点击在UI上
    if UICommonUtils.isPointerOverUIObject() and not UIMgr.isScenePassEvent then
        self._pointDownOnUI = true
    end
end

---处理鼠标按住事件
function BattleInputManager:onMouseButton()
    -- 修复:实时获取当前位置

    ---@type UnityEngine.Vector2?
    local currentMousePosition = nil
    if GV.IsEditor then
        currentMousePosition = UnityEngine.Input.mousePosition
    else
        -- 真机:根据保存的touchId查找对应的触摸
        if Input.touchCount > 0 and self._touchId then
            for i = 0, Input.touchCount - 1 do
                local touch = Input.GetTouch(i)
                if touch.fingerId == self._touchId then
                    currentMousePosition = touch.position
                    break
                end
            end
        end
    end
    if not currentMousePosition then
        return
    end
    if self._initialPosition then
        local vx = currentMousePosition.x - self._initialPosition.x
        local vy = currentMousePosition.y - self._initialPosition.y
        ---@type UnityEngine.Vector2
        local v2 = Vector2.New(vx, vy)
        if Vector2.Magnitude(v2) > self._clickThreshold then
            self._isDragging = true
        end
    end

    if self._isDragging then
        if self._canDrag == false then
            return
        end

        -- 拖动视野
        if UICommonUtils.isPointerOverUIObject() and not UIMgr.isScenePassEvent then
            -- 检测到UI，不处理拖动
            return
        end

        if not self._lastMousePosition then
            self._lastMousePosition = currentMousePosition
        end

        self._showMgr:moveCamera(currentMousePosition)
        self._lastMousePosition = currentMousePosition
    end
end

---处理鼠标抬起事件
---@param camera UnityEngine.Camera 相机
function BattleInputManager:onMouseButtonUp(camera)
    if self._pointDownOnUI or (UICommonUtils.isPointerOverUIObject() and not UIMgr.isScenePassEvent) then
        self:resetMouseState()
        return
    end

    -- 如果在拖动后松开鼠标，不处理点击
    if self._canClick and not self._isDragging and self._initialPosition then
        local block = self:getRaycastBlock(camera)
        if block then
            self:OnClickBlock(block)
        elseif self._battleMgr._roleMgr:getLockRole() == nil then
            local chooseBattleState = self._battleMgr:getChooseTargetState()
            if not chooseBattleState then
                if UICommonUtils.isPointerOverUIObject() and not UIMgr.isScenePassEvent then
                    -- 重置变量
                    self:resetMouseState()
                    return
                end

                -- 点击空白
                self._battleMgr._lastSelectedRole = nil
                self._battleMgr._lastSelectRoleID = nil
                self._showMgr:hideBlockInfo()
                self._showMgr:hideRoleInfo()
                self._showMgr:refreshSelectedCube()

                if not chooseBattleState and self._battleMgr._battleState ~= GE.BattleState.Formation then
                    self._battleMgr:resetAndStopActionState(true)
                    self._clientBattleMgr:resetAndStopActionState(true)
                else
                    self._battleMgr:stopActionState()
                    self._battleMgr:setSelectRole(nil)
                    self._battleMgr:setBeforeBackTranceSelectRoleId(-1)
                    self._clientBattleMgr:stopActionState()
                end
            end
        end
    end

    -- 重置变量
    self:resetMouseState()
end

---重置鼠标状态变量
function BattleInputManager:resetMouseState()
    self._initialPosition = nil
    self._lastMousePosition = nil
    self._isDragging = false
    self._pointDownOnUI = nil
end

---处理视野旋转
function BattleInputManager:handleRotation()
    if self._canZoomCamera == false then
        return
    end
    local rotationSpeed = 10.0

    if Input.GetMouseButtonDown(2) then
        self._isRotating = true
        self._lastRotatingMousePosition = Input.mousePosition
    end

    if Input.GetMouseButtonUp(2) then
        self._isRotating = false
        self._lastRotatingMousePosition = nil
    end

    if self._isRotating and self._lastRotatingMousePosition then
        local delta = {
            x = Input.mousePosition.x - self._lastRotatingMousePosition.x, 
            y = Input.mousePosition.y - self._lastRotatingMousePosition.y
        }
        self._showMgr:refreshViewRotat(delta.x * rotationSpeed * Time.deltaTime, true)
        self._lastRotatingMousePosition = Input.mousePosition
    end
end

---获取射线检测到的地块
---@param camera UnityEngine.Camera 相机
---@return BattleBlock|nil 地块
function BattleInputManager:getRaycastBlock(camera)
    --射线先判定是否点击到角色，再判定是否点击到格子
    local block = nil
    local roleHit = false
    local selectedRole = self._battleMgr:getSelectedRole()

    if not selectedRole then
        local ray, hitRole = UnityEngine.Physics.Raycast(camera.main:ScreenPointToRay(Input.mousePosition), nil, 9999, LayerMask.GetMask("Role"))
        if hitRole ~= nil then
            roleHit = true
            if UICommonUtils.isPointerOverUIObject() and not UIMgr.isScenePassEvent then
                if not self._isDragging then
                    return nil
                end
            end

            local roleObj = hitRole.transform.gameObject
            local role = self._showMgr:getBattleRoleByObj(roleObj)
            if role then
                block = role.block
            end
        end
    end

    if not roleHit then
        local ray, hitBlock = UnityEngine.Physics.Raycast(camera.main:ScreenPointToRay(Input.mousePosition), nil, 9999, LayerMask.GetMask("Square"))
        if hitBlock ~= nil then
            if UICommonUtils.isPointerOverUIObject() and not UIMgr.isScenePassEvent then
                if not self._isDragging then
                    return nil
                end
            end

            local hitObj = hitBlock.transform.gameObject
            block = self._showMgr:getBlockByObj(hitObj)
        end
    end

    return block
end

---点击地块
---@param block BattleBlock 点中的地块
function BattleInputManager:clickBlock(block)
    local map = self._battleMgr:getMap()
    local roleMgr = self._battleMgr:getRoleManager()
    local selectRole = self._battleMgr:getSelectedRole()
	--判断格子是否在当前地图有效范围内
	if (map:getBlockId(block.col, block.row) == -1) then
		return
	end
	BattleCore.ds("clickBlock pos", block.col, block.row, block.cid, block.id)
	local tData =  block.terrainCfgData
	-- LuaLogger.ds("clickBlock terrain", tData.name)
	
    self._showMgr:showBlockInfo(tData)
    self._showMgr:refreshSelectedCube(block.id)

	local blockRole = block:tryGetRole()
	
	local roleLockMode = roleMgr:getLockRole() ~= nil

	-- if (blockRole and not roleLockMode) then
    if (blockRole) then
		local lockRole = roleMgr:getLockRole()
        if blockRole ~= selectRole then
            local canDoAction = self._clientBattleMgr:checkRoleCanDoAction()
            if (canDoAction == true and roleMgr:isCanAction(blockRole)) then
                if (UIMgr:getCurrentUIName() == "BattleRoleMsgPanel") then
                    UIMgr:closeUI("BattleRoleMsgPanel")
                end
                --选中可动角色
                self._battleMgr:refreshRoleActionState(blockRole, true)
            else
                --判断是否再移动模式
                if (not roleLockMode or self._battleMgr:getActionType() ~= GE.RoleActionType.OnlyMove) then
                    self._battleMgr:showRoleActionRange(blockRole)
                    self._clientBattleMgr:showRoleActionRange(blockRole)
                end

                if (UIMgr:getCurrentUIName() == "BattleRoleMsgPanel") then
                    UIMgr:replaceUI("BattleRoleMsgPanel", { role = blockRole })
                else
                    UIMgr:popUI("BattleRoleMsgPanel", { role = blockRole })
                end
            end

            self:logBattleRoleInfo(blockRole)

		elseif lockRole and lockRole.id == blockRole.id
			and (self._battleMgr._lastSelectedRole ~= blockRole or not self._battleMgr:getIsActionState()) then
			-- 再行动/再移动锁定期间查看其他角色后点回锁定角色，恢复行动状态
			if (UIMgr:getCurrentUIName() == "BattleRoleMsgPanel") then
				UIMgr:closeUI("BattleRoleMsgPanel")
			end
			local actionType = self._battleMgr:getActionType() or GE.RoleActionType.Normal
			local movePowType = self._battleMgr:getMoveType()
			self._battleMgr:refreshRoleActionType(blockRole, actionType, movePowType)
			self._clientBattleMgr:refreshRoleActionState(blockRole, actionType)
        elseif blockRole == self._battleMgr._lastSelectedRole then
            if (UIMgr:getCurrentUIName() == "BattleRoleMsgPanel") then
                UIMgr:closeUI("BattleRoleMsgPanel")
            else
                self._isOpenRoleMsgPanel = true
                UIMgr:popUI("BattleRoleMsgPanel", { role = blockRole })
            end
        end
		self._battleMgr._lastSelectedRole = blockRole
	else
		self._battleMgr._lastSelectRoleID = nil
		self._battleMgr._lastSelectedRole = nil
        self._battleMgr:setBeforeBackTranceSelectRoleId(-1)
        if (UIMgr:getCurrentUIName() == "BattleRoleMsgPanel") then
            UIMgr:closeUI("BattleRoleMsgPanel")
        end
        local isActionState = self._battleMgr:getIsActionState()
        local moveRangeIdList = self._battleMgr:getMoveRangeIdList()
		if (not blockRole and isActionState and selectRole and tablex.any(moveRangeIdList, function(i) return i.blockId == block.id end)) then
			selectRole:preMove(block)
			self._clientBattleMgr:uiEnterActionState()
		elseif (not roleLockMode) then
			self._battleMgr:resetAndStopActionState(true)
            self._clientBattleMgr:resetAndStopActionState(true)
			self._showMgr:hideRoleInfo()
		end
	end
end

function BattleInputManager:OnClickBlock(block)
    if block then
        local r = self._battleMgr:clickBlock(block)
        if r == GE.ClickBlockResultType.SelectBlock then
            self:clickBlock(block)
        else
            if (UIMgr:getCurrentUIName() == "BattleRoleMsgPanel") then
                UIMgr:closeUI("BattleRoleMsgPanel")
            end
        end
    end
end

function BattleInputManager:EditorSpecialVictory()
    if GV.IsEditor == false then
        return
    end
    if Input.GetKey(KeyCode.Z) and Input.GetKeyDown(KeyCode.V) then
        local eventMgr = self._battleMgr:getBattleEventManager()
        eventMgr:doEventResult({
            {type = GE.EventResult.DoResultBattleIsOver, finlvl = 1}
        })
        self._battleMgr:SetIsUseGMToWinBattle(true)
        self._battleMgr:checkWinLose()
    end
end

function BattleInputManager:EditorSpecialDefeat()
    if GV.IsEditor == false then
        return
    end
    if Input.GetKey(KeyCode.Z) and Input.GetKeyDown(KeyCode.D) then
        local eventMgr = self._battleMgr:getBattleEventManager()
        eventMgr:doEventResult({
            {type = GE.EventResult.DoResultBattleIsOver, finlvl = 0}
        })
        self._battleMgr:checkWinLose()
    end
end

---打印角色信息
---@param blockRole BattleRole
function BattleInputManager:logBattleRoleInfo(blockRole)
    if LuaLogger.Enabled == true then
        local rolePrintData = {
            name = blockRole.roleConfig.name,
            hp = blockRole:getAttrib(GE.AttribType.Hp),                         --血量
            bombard = blockRole:getAttrib(GE.AttribType.Bombard),               --炮击
            torpedo = blockRole:getAttrib(GE.AttribType.Torpedo),               --雷击
            armor = blockRole:getAttrib(GE.AttribType.Armor),                   --装甲
            evade = blockRole:getAttrib(GE.AttribType.Evade),                   --机动
            airdefense = blockRole:getAttrib(GE.AttribType.AirDefense),         --防空
            lucky = blockRole:getAttrib(GE.AttribType.Lucky),                   --幸运
            camp = blockRole.camp,
            buff = {}
        }
        for _, buff in ipairs(blockRole.buffController._buffsList) do
            table.insert(rolePrintData.buff, buff.id)
        end
        BattleCore.ds("角色信息：", tablex.dump(rolePrintData))
        BattleCore.ds("免疫列表Effect：", tablex.dump(blockRole:getImmuneList(GE.SkillAffixType.ImmuneEffect)))
        BattleCore.ds("免疫列表Trigger：",
            tablex.dump(blockRole:getImmuneList(GE.SkillAffixType.ImmuneEffectTrigger)))
        BattleCore.ds("免疫列表Buff：", tablex.dump(blockRole:getImmuneList(GE.SkillAffixType.ImmuneBuff)))
    end
end

---清理资源
function BattleInputManager:clear()
    self._isDragging = nil
    self._initialPosition = nil
    self._lastMousePosition = nil
    self._pointDownOnUI = nil
    self._lastRotatingMousePosition = nil
    self._isRotating = nil
    self._isInControlZoom = false
    self._lastZoomDistance = nil
    self._canInput = nil
    self._canClick = nil
    self._canDrag = nil
    self._canZoomCamera = nil
    -- self._battleMgr = nil
    self._showMgr = nil
    self._isOpenRoleMsgPanel = nil
end

--- 设置是否允许输入
---@param canInput boolean 是否允许输入
function BattleInputManager:SetCanInput(canInput)
    self._canInput = canInput
end

---设置是否可以点击（用于战斗流程中屏蔽点击事件）
---@param canClick boolean 是否可以点击
function BattleInputManager:SetCanClick(canClick)
    self._canClick = canClick
end

--- 设置是否可以拖动（用于战斗流程中屏蔽拖动事件）
---@param canDrag boolean 是否可以拖动
function BattleInputManager:SetCanDrag(canDrag)
    self._canDrag = canDrag
end

--- 设置是否可以缩放相机（用于战斗流程中屏蔽缩放事件）
---@param canZoom boolean 是否可以缩放
function BattleInputManager:SetCanZoomCamera(canZoom)
    self._canZoomCamera = canZoom
end

return BattleInputManager