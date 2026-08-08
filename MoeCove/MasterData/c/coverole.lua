require "class"
local CoveBase = require("CoveBase")

---@class CoveRole:CoveBase
local CoveRole = class("CoveRole", CoveBase)
local CoveRoleSM = require "CoveRoleSM"

local function IsRoleControllerValid(role)
	return role ~= nil and role._roleCont ~= nil and not IsNull(role._roleCont)
end

local function IsRoleAgentValid(role)
	return IsRoleControllerValid(role) and role._roleCont.agent ~= nil and not IsNull(role._roleCont.agent)
end

function CoveRole:ctor(data)
	self.data = data
	self.isCreate = false
	self.id = data.roleData.id
	---@type CoveRoleType
	self.coveRoleType = data.coveRoleType
	self.homeWorkIndex = data.homeWorkIndex --工作角色索引
	self.isEnterSwinRoom = data.isEnterSwinRoom
	
	---@type CoveRoleManager
	self._roleMgr = data.mgr
	self._roomMgr = data.roomMgr
	self._roleObj = nil
	self._model = nil
	self._room = data.room
	self._pathInfo = nil
	self._pathIndex = 1
	self._progressiveMesh = nil --LOD工具
	self.isPreRole = data.isPreRole --是否为上次登陆的角色
	self.preCreateTime = data.preCreateTime --角色出现前置时间
	self.lifeTime = data.lifeTime --角色持续时间
	self.createTimeStamp = data.preCreateTime--os.time() + data.preCreateTime
	self.roomStayStamp = nil  --单个房间游荡时间  -1则不切换房间
	self.beforeBehavior = "idle" --之前角色行为
	self.behavior = "idle" --当前角色行为
	self._roleRotateTimer = nil
	self._pointEffectTimer = nil
	self.modelObj = nil
	self._eventBtn = nil			--事件按钮
	self._eventScaleBtn = nil		--事件按钮组件
	self._clickEmote = nil		--互动表情spine
	self.clickMenuPoint = nil	--角色点击菜单基准点位
	self.coveType = CoveType.Player
	self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
	self.focusState = false --角色聚焦状态
	self.isSwimsuitSkin = false -- 当前是否为泳装模型（用于 ChangeSkinNormalToSwin/ChangeSkinSwinToNormal 防重入）
	self.m_coveRoleSO  = CoveRoleSM:new(self)
	self.curCoveRoleMoodType = nil
	
	self:SetCoveRoleActionState(CoveRoleActionState.IDLE)
	if self.lifeTime ~= -1 then
		self.lifeEndStamp = data.lifeTime--os.time() + data.lifeTime + data.preCreateTime
	else
		self.lifeEndStamp = -1
	end


	local serverData = Me:getPlayerHero(self.id)
	local skinConfig = Config.GetCharacterSkinInfo(serverData.equipSkin)
	self.skinCfg = skinConfig
	self.characterCfg = Config.GetCharacterInfo(self.id)
	---@type function 
	self.forceToActionCallBack = nil


	LuaLogger.ds("创建cove角色 id:" .. self.id)
end

function CoveRole:generatePath()
	if self._room == nil then
		return
	end
	self._room:onPathUseEnd(self._pathInfo)

	self._pathInfo = self._room:getRandomPath(self.id, self.data.homeWorkIndex)
	if self._pathInfo == nil then
		LuaLogger.ds("当前房间此为止被使用 重新随机一个位置 roomId,roleId,homeWorkIndex:",self._room.id,self.id,self.data.homeWorkIndex)
		self._pathInfo = self._room:getRandomPathWithOutCondition(self.id, self.data.homeWorkIndex)
	end

	self._pathIndex = 1
end

--角色在场景中实时的状态 ，用于判断是否可以点击
function CoveRole:SetCoveRoleActionState(coveRoleActionState)

	self.m_CoveRoleActionState = coveRoleActionState
end


function CoveRole:createRole(completeFun)
	self.isCreate = true
	self:generatePath()
	if not self._pathInfo then
		LuaLogger.e("createRole Error not _pathInfo :"..self.id)
		return
	end
	self._room:setRole(self)

	PoolMgr:Get(Config.PrefabPath.CoveRole , function (roleObj)
		self._roleObj = roleObj
		self._roleCont = self._roleObj:GetComponent("CoveRoleController")
		DUtil.AutoCleanDelegate(self._roleObj)
		self._roleCont:SetRoleId(self.id)
		if self.coveRoleType == CoveRoleType.HomeWork or self.isPreRole then
			--工作角色和上次登录的角色直接生成至房间
			local pointData = self._roomMgr:getPointInfo(self._pathInfo.way[self._pathIndex])
			if pointData.target then
				if self.data.isCreateInRoom == true then
					self._roleCont:SetPositionImm(pointData.target.position)

					---巡逻的人特殊处理
					local room = self:getRoom()
					if room ~= nil then
						local roomId = room.id
						local roomCfg = Config.GetConstructionInfo(roomId)
						if roomCfg ~= nil and roomCfg.workLocation == 99  then
							self:SetCoveModelState(1)
						end
					end
					--self._pathIndex = self._pathIndex + 1
				else
					local disappearPoint = self._roleMgr._coveMgr:getDisappearPoint()
					self._roleCont:SetPositionImm(disappearPoint[0].position)
				end
			end
		else
			local pos;
			if self.data.isCreateInRoom == true then

				local pointData = self._roomMgr:getPointInfo(self._pathInfo.way[self._pathIndex])
				if pointData.target then
					pos = pointData.target
					--self._pathIndex = self._pathIndex + 1
				else
					--非工作角色从出生点生成，前往房间
					pos = self._roleMgr._coveMgr:getSpawnPoint()
				end
			else
				local disappearPoint = self._roleMgr._coveMgr:getDisappearPoint()
				pos = disappearPoint[0]
			end
			self._roleCont:SetPositionImm(pos.position)
		end
		local serverData = Me:getPlayerHero(self.id)
		local skinConfig = Config.GetCharacterSkinInfo(serverData.equipSkin)
		self.skinCfg = skinConfig

		local uicanvas = roleObj.transform:Find("UIRoot/UICanvas")

		local role_ui = roleObj.transform:Find("UIRoot/UICanvas/Role_UI")
		local scale = role_ui:Find("scale")
		self._eventBtn = scale:Find("EventBtnP/EventBtn")
		self._eventBtnP = scale:Find("EventBtnP")
		self._clickEmote = scale:Find("InteractionEmoteP/InteractionEmote")
		self._clickEmoteP = scale:Find("InteractionEmoteP")
		self.m_homeMoodRoot = scale:Find("homeMoodRootP/homeMoodRoot")
		self.m_homeMoodRootP = scale:Find("homeMoodRootP")
		---用代码将默认打开的关掉
		if self.m_homeMoodRoot then self.m_homeMoodRoot.gameObject:SetActive(false) end
		
		self.m_homeMoodCanvasGroup = self.m_homeMoodRoot:GetComponent(TypeInfo.CanvasGroup)
		self.m_homeMoodIconGo = scale:Find("homeMoodRootP/homeMoodRoot/moodIcon")

		if self.m_homeMoodIconGo then
			self.m_homeMoodIconImage = self.m_homeMoodIconGo:GetComponent(TypeInfo.Image)
		end

		---@type UnityEngine.Transform
		self.interactiveDialogueRootP = scale:Find("interactiveDialogueRootP")
		self.interactiveDialogueRoot = scale:Find("interactiveDialogueRootP/interactiveDialogueRoot")
		---@type TMPro.TextMeshProUGUI
		self.interactiveDialogueText = self.interactiveDialogueRootP:Find("interactiveDialogueRoot/dialogueText"):GetComponent(TypeInfo.TextMeshProUGUI)
		self.clickMenuPoint = roleObj.transform:Find("ClickMenuPoint").gameObject

		self.m_workRoot = scale:Find("workRootP/workRoot")
		self.m_workRootP = scale:Find("workRootP")


		--转ui层
		local uiroot = UIMgr:GetUICoveRoleParent()
		role_ui.transform:SetParent(uiroot.transform, false)
		--改名
		local name = "CoveRole" .. self:GetID()
		role_ui.name = "CoveRole" .. self:GetID()
		local key = name

		local get = {
			staticPos = function(data)
				return uicanvas.position
			end
		}
		local data = {}
		setmetatable(data, {
			__index = function(t, k)
				local getter = get[k]
				if getter then
					local value = getter(t)
					return value
				end
				return nil 
			end
		})

		data.uiObj = role_ui.gameObject
		data.isRes = false
		data.isShow = true
		data.updateLayer = true
		self.uiCanvas = uicanvas
		self.role_uiObj = role_ui.gameObject
		
		local buildMgr = CoveManager.instance()._buildingMgr
		buildMgr.buildingBtnList[key] = data	--ui预制
		local isShow = buildMgr.isShowUI
		if not isShow then
			data.uiObj:SetActive(false)
			data.isShow = false
		end


		--所有角色事件ui列表父节点 用于暂时隐藏ui 不影响原有模块显隐逻辑
		self.roleUIListparent = {
			[1] = self.m_workRootP,
			[2] = self._eventBtnP,
			[3] = self._clickEmoteP,
			[4] = self.m_homeMoodRootP,
			[5] = self.interactiveDialogueRootP,
		}

		---@type UnityEngine.GameObject[]
		self.forbiddenDialogueObjs = {
			self._eventBtn.gameObject, self._clickEmote.gameObject, self.m_homeMoodRoot.gameObject
		}

		--TODO: 这里需要根据事件信息切换显示状态 or 隐藏
		if serverData.affectionEvent == 0 then
			self._eventBtn.gameObject:SetActive(false)
		else
			self._eventBtn.gameObject:SetActive(true)
		end

		if self._eventBtn then
			self._eventScaleBtn = self._eventBtn:GetComponent(TypeInfo.ScaleButton)
			self._eventScaleBtn.onClick:RemoveAllListeners()
			self._eventScaleBtn.onClick:AddListener(function()
				LuaMain:play2DSound(self.btnSoundPath)
				UIMgr:popUICover("AffectionEventPanel", {id = self.id, mode = 1, eventId = serverData.affectionEvent})
			end)
		end



		PoolMgr:Get(string.format(Config.PrefabPath.RoleModelPrefab, skinConfig.modelKey, skinConfig.modelKey) , function (modelObj)
			modelObj.transform.parent = self._roleCont.roleRoot.transform
			modelObj.transform.localPosition = Vector3.zero
			modelObj.transform.localRotation = Quaternion.identity
			modelObj.transform.localScale = Vector3.one * self.skinCfg.modelRate
			self._model = modelObj.transform:GetComponent("RoleModelController")
			-- self._model:SetShadowHeight(1.8)
			--self:SetDefaultState(RoleAnimStateType.Idle)
			

			-- self._model:SetOutlineType(false)
			-- role.model:TurnDirection(direction)
			modelObj:SetActive(true)
			self.modelObj = modelObj
			self._model:FadeIn()
			
			self._roleCont:SetAgentPriority(math.random(1, 100))
			self.modelLoadFinish = true

			local model = modelObj.transform:Find("model")
			self.animOverCallBack = nil
			if model ~= nil then
				---@type AnimOverCallBack
				self.animOverCallBack = model:GetComponent(TypeInfo.AnimOverCallBack)
				if not IsNull(self.animOverCallBack) then
					self.animOverCallBack:SetCallBackOfName(BindCallback_NoParams(self, self.OnAnimOverCallBack))
				end
			end

			self:OnModelLoadFinish()
			self:doIdleBehavior()
			if completeFun then
				completeFun()
			end
			-- ( 0.7, function()
			-- 	if self.coveRoleType == CoveRoleType.HomeWork then
			-- 		self:doBehavior('tour')
			-- 	elseif self.coveRoleType == CoveRoleType.Dispatch then
			-- 		self:doBehavior('dispatch')
			-- 	elseif self.isPreRole then
			-- 		self:doBehavior('tour')
			-- 	else
			-- 		self:doBehavior('gotoRoom')
			-- 	end
			-- end)
		end)
	end)
end

function CoveRole:OnModelLoadFinish()

	CoveBase.OnModelLoadFinish(self)
	self._roleObj.name = "CoveRole_" .. self:GetID() .. "_" .. self:GetUID()
	local isInBattle = self:IsInBattle()
	LuaLogger.ds(" 加载CoveRole完成 检测是否战斗 id:" .. self:GetID() .. "  isBattle:" .. tostring(isInBattle))
	self:CreateEffect(3000)
	self:SetEffectActive(3000, false)
	if self:IsInBattle() then
		self:GotoBattle()
	end
end

-- 执行行为
-- function CoveRole:doBehavior(name)

-- 	local behaviorName = tostring(name)
-- 	if behaviorName == self.behavior then
-- 		return
-- 	end

-- 	self.beforeBehavior = self.behavior
-- 	self.behavior = behaviorName
-- 	-- if behaviorName == "idle" then
-- 	-- 	self:idleBehavior()
-- 	-- elseif behaviorName == "gotoRoom" then
-- 	-- 	self:gotoRoomBehavior()
-- 	-- elseif behaviorName == "tour" then
-- 	-- 	self:tourBehavior()
-- 	-- elseif behaviorName == "leavePort" then
-- 	-- 	self:leavePortBehavior()
-- 	-- elseif behaviorName == "dispatch" then
-- 	-- 	self:dispatchBehavior()
-- 	-- elseif behaviorName == "clickShow" then
-- 	-- 	self:clickShowBehavior()
-- 	-- end
-- 	LuaLogger.es("behaviorName == " ,behaviorName)
-- 	if behaviorName == "idle" then
-- 		self.m_coveRoleSO.machine:idle()
-- 	elseif behaviorName == "gotoRoom" then
-- 		self.m_coveRoleSO.machine:gotoRoom()
-- 		--self:gotoRoomBehavior()
-- 	elseif behaviorName == "tour" then
-- 		--self:tourBehavior()
-- 		LuaLogger.es("behaviorName 2   == " ,behaviorName)
-- 		self.m_coveRoleSO.machine:tour()
-- 	elseif behaviorName == "leavePort" then

-- 		self.m_coveRoleSO.machine:leavePort()
-- 		-- self:leavePortBehavior()
-- 	elseif behaviorName == "dispatch" then
-- 		self.m_coveRoleSO.machine:dispatch()
-- 		--self:dispatchBehavior()
-- 	elseif behaviorName == "clickShow" then
-- 		self:clickShowBehavior()

-- 		LuaLogger.es("clickShowBehavior ======")
-- 	end
-- end


---开始角色散步的循环

-- 随机时间待机行为
function CoveRole:doIdleBehavior()
	if (not self._model) then
		return
	end
	self.m_behaviorState = "idle"
	self:SetDefaultState(self:GetIdleStateVal())
	self:SetCoveRoleActionState(CoveRoleActionState.IDLE)
end

---角色前往指定房间行为，过程中不计算房间时间
-- function CoveRole:gotoRoomBehavior(...)
-- 	if (not self._model or not self._room or not self._pathInfo) then
-- 		return
-- 	end
-- 	local pointData = self._roomMgr:getPointInfo(self._pathInfo.way[self._pathIndex])
-- 	if not pointData.target then
-- 		return
-- 	end
-- 	self._pathIndex = self._pathIndex + 1
-- 	self:SetDefaultState(self._pathInfo.moveMode)
-- 	self:changeSpeedWithState()
-- 	self:SetTaregt(pointData.target.position, function()
-- 		self:doBehavior('tour')
-- 	end)
-- end

-- function CoveRole:tourBehavior()
-- 	if (not self._model or not self._room) then
-- 		return
-- 	end
-- 	if self.coveRoleType == CoveRoleType.HomeWork then
-- 		self.roomStayStamp = -1
-- 	else	
-- 		self.roomStayStamp = os.time() + self._room:randomStayTime()
-- 	end
-- 	self:doTourLogic()
-- end

----当前走路相关的状态 Begin
function CoveRole:DoWalkBehavior(isNeedRandomTime,completeFun)
	self:SetCoveRoleActionState(CoveRoleActionState.WALK)
	self.m_behaviorState = "dowalk"
	self.m_complete = completeFun
	self:StartDoWalk(isNeedRandomTime,completeFun)

end

function CoveRole:StartDoWalk(isNeedRandomTime,completeFun)

  if (not self._model or not self._room) then
		return
	end
	if isNeedRandomTime then
		if self.coveRoleType == CoveRoleType.HomeWork then
			self.roomStayStamp = -1
		else

			self.roomStayStamp = os.time() + self._room:randomStayTime()
		end
	end
	
	self:doWalkLogic(completeFun)
end

function CoveRole:doWalkLogic(completeFun)

	if not self._pathInfo then
		return
	end

	if self._pathIndex > #self._pathInfo.way then
		self:generatePath()
	end
	local pointData = self._roomMgr:getPointInfo(self._pathInfo.way[self._pathIndex])
	if not pointData.target then
		return
	end

	self:SetDefaultState(self:GetMoveStateVal())
	self:changeSpeedWithState()

	self.callPointEndbackFun = function()
		if self._pathInfo == nil or self._pathIndex > #self._pathInfo.way then
			-- LuaLogger.es("callPointEndbackFun ==222=====",completeFun)
			if completeFun ~= nil then
				-- LuaLogger.es("callPointEndbackFun ==333=====",completeFun)
				completeFun()
			end
		else
			local pointData = self._roomMgr:getPointInfo(self._pathInfo.way[self._pathIndex])
			if pointData.effectList and tablex.size(pointData.effectList) > 0 then
				-- 到达目标点（有特效），根据 statusShow[2] 决定是否关闭心情显示
				-- statusShow[2] == 1: 到达后关闭
				-- statusShow[2] == 2: 持续显示
				if self.data and self.data.activateCfg and tablex.size(self.data.activateCfg.statusShow) > 0 then
					if self.data.activateCfg.statusShow[2] == 1 then
						self:HideHomeMood()
					end
					-- 如果是 2，则持续显示，不关闭
				end
				
				self:doWalkPointEffect(pointData.effectList,completeFun,pointData.target.position)
			else
				if self._pathIndex <= #self._pathInfo.way then
					
					local pointData = self._roomMgr:getPointInfo(self._pathInfo.way[self._pathIndex])
					self._pathIndex = self._pathIndex + 1
					self:SetTargetForPatrol(pointData.target.position,self.callPointEndbackFun,false,false)
				end
			end
		end
	end

	self._pathIndex = self._pathIndex + 1
	self:SetTargetForPatrol(pointData.target.position,self.callPointEndbackFun,true,true)

end


function CoveRole:SetTargetForPatrol(position,callback,isFirstIn,isAddReached)




	if isFirstIn then

		self._roleCont:RemoveIntervalReached()
		self._roleCont:ClearCurrentTarget()
		self._roleCont:ClearTriggerPath()

		---巡逻的人特殊处理
		local room = self:getRoom()
		if room ~= nil then
			local roomId = room.id
			local roomCfg = Config.GetConstructionInfo(roomId)
			if roomCfg ~= nil and roomCfg.workLocation == 99  then
				isAddReached = false  
			end
		end

		local battleMgr = CoveBattleMgr.instance()
		if battleMgr:IsBattle() then
			if battleMgr:IsBattleCharacter(self:GetUID()) then
				isAddReached = false  
			end
		end

		--如果当前是海上巡逻 ，不走中间的停止行为
		if self._pathInfo ~= nil and self._pathInfo.id == 99 then
			isAddReached = false
		end
		--TODO 巡逻的时候不能点击播放动作

		if isAddReached then
			self._roleCont.triggerSystem.intervalMeter = math.random(20, 30)
			self._roleCont:AddIntervalReached(function(distance,percentValue)

				if self._model:HasTrigger("Walk_sp") then
					
					self:SetCoveRoleActionState(CoveRoleActionState.WALK_SP)

					--LuaLogger.es("已经走了 distance = " ..distance..",percentValue = "..percentValue)
					self:StopMove()
					self:SetDefaultState(self:GetIdleStateVal())
				DLuaTimer:DoAfter( 0.5, function()
					if not IsRoleAgentValid(self) then return end
					self._roleCont.agent.enabled = false
					self:setNavMeshObstacle(true)
					self._model:PlayAnimAndGetLength("Walk_sp", function(walkSpDuration)
						if walkSpDuration <= 0 then walkSpDuration = 1 end
						
						DLuaTimer:DoAfter(walkSpDuration, function()
							
							self:setNavMeshObstacle(false)
							if not IsRoleControllerValid(self) then return end
							self._roleCont:WaitAgentOnNavMesh(function()
								if IsRoleAgentValid(self) then
									self._roleCont.agent.enabled = true
									self:SetCoveRoleActionState(CoveRoleActionState.WALK)
									self:SetMoveing(true)
									self:SetDefaultState(self:GetMoveStateVal())
									self._roleCont:ResumeCurrentTarget()
								end
								
							end)
						end)
					end)
				end)
				end
				
			end)
		end
		self:MoveTo_Direct(position, callback)
	else
		self:SetDefaultState(self:GetMoveStateVal())
		self:SetMoveing(true)
		self._roleCont:AppendPath(position,callback)
	end

end


function CoveRole:SetTargetForChangeRoom(position,callback,isAddIntervalReached)

	self._roleCont:RemoveIntervalReached()
	self._roleCont:ClearCurrentTarget()
	self._roleCont:ClearTriggerPath()

	if self:IsInBattle() then
		isAddIntervalReached = false
	end
	if self.coveModelState == 1 then
		isAddIntervalReached = false
	end
	local room = self:getRoom()
	if room ~= nil then
		local roomId = room.id
		local roomCfg = Config.GetConstructionInfo(roomId)
		if roomCfg ~= nil and roomCfg.workLocation == 99  then
			isAddIntervalReached = false  
		end
	end
	--LuaLogger.es("已经走了111111 distance = ")
	--如果当前是海上巡逻 ，不走中间的停止行为
	if self._pathInfo ~= nil and self._pathInfo.id == 99 then
		isAddIntervalReached = false
	end

	if  isAddIntervalReached then
		self._roleCont.triggerSystem.intervalMeter = math.random(8, 15)
		self._roleCont:AddIntervalReached(function(distance,percentValue)
			if percentValue < 0.9 then
				
				--LuaLogger.es("已经走了2222222 distance = " ..distance..",percentValue = "..percentValue)
				if self._model:HasTrigger("Walk_sp") then
					
					self:SetCoveRoleActionState(CoveRoleActionState.WALK_SP)
					self:StopMove()
					self:SetDefaultState(self:GetIdleStateVal())
				DLuaTimer:DoAfter( 0.5, function()
					if not IsRoleAgentValid(self) then return end
					self._roleCont.agent.enabled = false
					self:setNavMeshObstacle(true)

					self._model:PlayAnimAndGetLength("Walk_sp", function(walkSpDuration)
						if walkSpDuration <= 0 then walkSpDuration = 1 end
						DLuaTimer:DoAfter(walkSpDuration, function()
							
							self:setNavMeshObstacle(false)
							if not IsRoleControllerValid(self) then return end
							self._roleCont:WaitAgentOnNavMesh(function()
								if IsRoleAgentValid(self) then
									self._roleCont.agent.enabled = true
									self:SetCoveRoleActionState(CoveRoleActionState.WALK_CHANGE_ROOM)
									self:SetDefaultState(self:GetMoveStateVal())
									self:SetMoveing(true)
									self._roleCont:ResumeCurrentTarget()
								end
							end)
						end)
					end)
				end)
				end
			end
			
		end)
	end
	

	self:MoveTo_Direct(position, callback)


end

function CoveRole:doWalkPointEffect(effectList,completeFun,pointPosition)
	local effect = self:randomEffect(effectList)
	--LuaLogger.e(tablex.dump(effect))
	if not effect then
		return
	end
	local roleAngle = effect[2]
	local rotateDt = effect[3]
	local stateType = effect[4]
	local stateDt = math.random(effect[5][1], effect[5][2])
	local interactItemId = effect[6]
	local param = effect[7]

	self:SetCoveRoleActionState(CoveRoleActionState.POINT_EFFECT)

	--TODO effect[6] --场景互动逻辑
	self._roleCont:SetDirection(roleAngle, rotateDt)

	if self._roleRotateTimer ~= nil then
		DLuaTimer:RemoveTimer(self._roleRotateTimer)
		self._roleRotateTimer = nil
	end
	self._roleRotateTimer = DLuaTimer:DoAfter(rotateDt, function ()
		if self.destroyed then
			return
		end
		self:SetCurrentAction(nil)
		local animInfo = RoleModelAllAnimType[stateType]
		if not animInfo then
			LuaLogger.e("animInfo nil ".. self.id..","..stateType)
			if completeFun ~= nil then
				completeFun()
			end
			return
		end


		local callback = function()
			if self.destroyed then
				return
			end
		self.currentAction = nil
		self:setNavMeshObstacle(false)
		if not IsRoleControllerValid(self) then return end
		self._roleCont:WaitAgentOnNavMesh(function()
			if IsRoleAgentValid(self) then
				self._roleCont.agent.enabled = true
				self:SetCoveRoleActionState(CoveRoleActionState.IDLE)
				if completeFun ~= nil then
					completeFun()
				end
			end
		end)
		end
		if (animInfo.type == 1) then
			self:SetDefaultState(animInfo.value)
		elseif (animInfo.type == 2) then
			self._model:PlayAnim(animInfo.value)
		elseif animInfo.type == 3 then
			self._roleCont.agent.enabled = false
			self:setNavMeshObstacle(true)
			---@type CoveActionBase?
			local action = self:GetOrCreateAction(animInfo.state)
			if action == nil then
				callback()
				return
			end
			if action:IsRuning() then
				action:Exit()
				self.currentAction = nil
			end
			self:SetCurrentAction(action)
			action:SetCompleteCallback(callback)
			action:Begin(interactItemId,  param, stateDt)
			return
		end
		--todofly 测试

		
		-- stateDt = 10
		if stateDt == -1 then
			stateDt = self._model:GetNowAnimationPlayTime()
		end
		self._roleCont.agent.enabled = false
		self:setNavMeshObstacle(true)



		--LuaLogger.es("2333333333 ".. self.id..","..stateDt)
		if self._pointEffectTimer ~= nil then
			DLuaTimer:RemoveTimer(self._pointEffectTimer)
			self._pointEffectTimer = nil
		end
		self._pointEffectTimer = DLuaTimer:DoAfter(stateDt, callback)
	end)
end

---随机角色点位特殊表现
function CoveRole:randomEffect(effectList)
	if #effectList == 1 then
		return effectList[1].effect
	end
	local randomList = {}
	local totalWight = 0
	for i = 1, #effectList do
		local effect = effectList[i]
		local wight = effect.effect[1]
		for _, v in pairs(effect.upList) do
			if v == self.id then
				wight = wight + Config.GetConfigInfo("actionWeightRise")
			end
		end
		for _, v in pairs(effect.lowList) do
			if v == self.id then
				wight = wight - Config.GetConfigInfo("actionWeightDecrease")
			end
		end
		totalWight = totalWight + wight
		local data = {
			effect = effect,
			wight = wight
		}
		table.insert(randomList, data)
	end
	local compareWight = math.random(1, totalWight)
	local index = 1
	while totalWight > 0 do
		totalWight = totalWight - randomList[index].wight
		if totalWight < compareWight then
			return randomList[index].effect.effect
		end
		index = index + 1
	end
end



function CoveRole:doChangeRoomBehaivior(completeFun)

	---LuaLogger.es("==================>>>>>>>>>11111")
	self.m_behaviorState = "doChangeRoom"

	self.m_complete = completeFun


	self.m_behaviorSecondState = nil

	self.m_behaviorSecondState = nil

	self.m_behaviorState = "doChangeRoom"
	self.m_complete = completeFun

	self:generatePath()
	self._pathIndex = 1
	local pointId = self._pathInfo.way[self._pathIndex]


	local pointData = self._roomMgr:getPointInfo(pointId)
	if not pointData.target then
		return
	end

	--self._pathIndex = self._pathIndex + 1
	if self._pathIndex > #self._pathInfo.way then
		self:generatePath()
	end

	self:SetCoveRoleActionState(CoveRoleActionState.WALK_CHANGE_ROOM)

	self:SetDefaultState(self:GetMoveStateVal())


	self:changeSpeedWithState()

	self:SetTargetForChangeRoom(pointData.target.position,function()
		self.m_behaviorSecondState = nil
		self:SetCoveRoleActionState(CoveRoleActionState.IDLE)
		if completeFun ~= nil then
			completeFun()
		end
	end,true)


end

function CoveRole:DoRemoveRoleBehavior(completeFun)
	self.m_behaviorState = "doremoveRole"
	self.m_complete = completeFun
	if self._pathInfo == nil or self._pathIndex > #self._pathInfo.way then
		self:generatePath()
	end
	--local pointId = self._pathInfo.way[self._pathIndex]
	--local roomId = self._roomMgr:GetRoomId(pointId)

	if (not self._model) then
		return
	end
	if self:getRoom() ~= nil then
		self._room:onPathUseEnd(self._pathInfo)
	end

	self:clearShowTimer()


	if self._pathInfo ~= nil then
		self:SetDefaultState(self:GetMoveStateVal())
	end
	self:changeSpeedWithState()

	local disappearPoint = self._roleMgr._coveMgr:getDisappearPoint()
	self:SetCoveRoleActionState(CoveRoleActionState.REMOVE_FROM_ROOM)
	self:SetTargetForChangeRoom(disappearPoint[0].position,function()
		self._model:FadeOut()
		DLuaTimer:DoAfter( 0.7, function()
			if completeFun ~= nil then
				completeFun()
			end
		end)
	end,false)
end

function CoveRole:DoAppearToDestinationBehavior(completeFun,updateStateFun)

	if (not self._model) then
		return
	end

	if self._pathInfo == nil then
		LuaLogger.es(" 路径错误 id:" .. self:GetID())
		return
	end

	self.m_behaviorState = "doAppearToDest"
	self.m_complete = completeFun

	self._pathIndex = self._pathIndex + 1
	if self._pathIndex > #self._pathInfo.way then
		self:generatePath()
	end

	local pointId = self._pathInfo.way[self._pathIndex]
	local pointData = self._roomMgr:getPointInfo(pointId)
	if not pointData.target then
		return
	end

	self:SetDefaultState(self:GetMoveStateVal())
	self:changeSpeedWithState()
	self:SetCoveRoleActionState(CoveRoleActionState.ADD_TO_ROOM)
	self:SetTargetForChangeRoom(pointData.target.position,function()
		self.m_behaviorSecondState = nil
		if completeFun ~= nil then
			completeFun()
		end
	end,false)

end


--工作其实就是在对应的room 中转圈圈
function CoveRole:DoWorkBehavior(completeFun)
	self.m_behaviorState = "doWork"
	self.m_complete = completeFun
	--LuaLogger.es("CoveRole:DoWorkBehavior ======1")
	self:doWalkLogic(completeFun)
end

----当前走路相关的状态 end



----角色点击行为展示 Begin
function CoveRole:DoRoleClickShow()
	self:clickShowBehavior()
	self:ShowHeorInfo()
end

--判断当前角色是否能交互
function CoveRole:RoleCanTouch()
	local battleMgr = CoveBattleMgr.instance()
	if battleMgr:IsBattle() then
		if battleMgr:IsBattleCharacter(self:GetUID()) then
			return false
		end
	end

	---巡逻的人特殊处理
	local room = self:getRoom()
	if room ~= nil then
		local roomId = room.id
		local roomCfg = Config.GetConstructionInfo(roomId)
		if roomCfg ~= nil and roomCfg.workLocation == 99  then
			return false 
		end
	end

	-- local state = self._model.anim:GetInteger("defaultState");
	-- --LuaLogger.es("aniStateInfo   state ==",state)
	-- --动作屏蔽
	-- if state == RoleAnimStateType.Drink or state == RoleAnimStateType.Sit or state == RoleAnimStateType.Eat then
	-- 	return false
	-- end

	if self.m_CoveRoleActionState == CoveRoleActionState.WALK_SP or  
		self.m_CoveRoleActionState == CoveRoleActionState.POINT_EFFECT or 
		self.m_CoveRoleActionState == CoveRoleActionState.REMOVE_FROM_ROOM then
		LuaLogger.ds("当前人物状态不能点击m_CoveRoleActionState = "..self.m_CoveRoleActionState)
		return

	end

	return true
end

--点击后待机状态
function CoveRole:clickShowBehavior()
	if (not self._model) then
		LuaLogger.e("_model is nil")
		return
	end

	--聚焦状态
	self.focusState = true
	self.curRoleAngle = self._roleObj.transform.localEulerAngles.y
	--self:HideHomeMood()

	
	self:SetTaregt(self._roleObj.transform.position, function()
		self._roleCont.agent.enabled = false
		self:setNavMeshObstacle(true)
		self._roleCont:SetDirection(-45, 0.2, function()
			--待机动作

			self:SetDefaultState(self:GetIdleStateVal())
			
		end)
	end)
end

--获取当前角色聚焦状态
function CoveRole:getFocusState()
	return self.focusState
end

--退出聚焦模式
function CoveRole:exitFocusBehavior()
	--聚焦状态
	self.focusState = false
	self:homwTouchRecover()
end

--家园角色点击互动
---@param CB function 点击行为完成回调
function CoveRole:touchBehavior(CB)
	local touchInfo = self:randmHomeTouch()
	if not touchInfo then
		self:homwTouchRecover()
		return
	end
	local animInfo = RoleModelAllAnimType[touchInfo.actionResource]
	if not animInfo then
		LuaLogger.e("animInfo nil ".. self.id..","..touchInfo.actionResource)
		self._roleCont:SetDirection(self.curRoleAngle, 0.2, function()
			self:homwTouchRecover()
		end)
		return
	end
	--播放语音
	local nowLineConfig = Config.GetScriptLinesInfo(touchInfo.voiceResource)
	if nowLineConfig and nowLineConfig.resource then
		UICommonUtils.Play2DVoiceByLanguage(self.id, nowLineConfig.resource)
	end

	
	--表情spine
	local emoteName = touchInfo.bubbleResource
	self._roleMgr._coveMgr:showClickMenuEmote(emoteName)
	--动作
	if (animInfo.type == 2) then
		self._model:PlayAnim(animInfo.value, function()
			--动作结束回调
			-- self:exitFocusBehavior()
			if CB then
				CB()
			end
		end)
	end
end

--随机家园点击表现
function CoveRole:randmHomeTouch()
	local allCfg = Config.GetAllConfig("HomeTouchTable")
	local randomDataList = {}
	for _, touchCfg in pairs(allCfg) do
		if touchCfg.character == self.id then
			local weight = touchCfg.basicWeight
			for _, weightCfg in pairs(touchCfg.dynamicWeight) do
				--好感度
				if weightCfg[1] == 1 then
					local roleSeverData = Me:getPlayerHero(self.id)
					if roleSeverData then
						if weightCfg[2][1] == 1 then
							--大于等于
							if roleSeverData.affectionLevel >= weightCfg[2][2] then
								if weightCfg[3] == 0 then
									weight = weight - weightCfg[4]
								elseif weightCfg[3] == 1 then
									weight = weight + weightCfg[4]
								end
							end
						elseif weightCfg[2][1] == 2 then
							--小于
							if roleSeverData.affectionLevel < weightCfg[2][2] then
								if weightCfg[3] == 0 then
									weight = weight - weightCfg[4]
								elseif weightCfg[3] == 1 then
									weight = weight + weightCfg[4]
								end
							end
						end
					end
				end
			end
			table.insert(randomDataList, {cfg = touchCfg, weight = weight})
		end
	end
	--LuaLogger.e(tablex.dump(randomDataList))
	return self:randomByWeight(randomDataList)
end

function CoveRole:randomByWeight(randomList)
    local totalWeight = 0
    for _, v in pairs(randomList) do
        totalWeight = totalWeight + v.weight
    end
    local compareWight = math.random(1, totalWeight)
    local index = 1
    while totalWeight > 0 do
        totalWeight = totalWeight - randomList[index].weight
        if totalWeight < compareWight then
            return randomList[index].cfg
        end
        index = index + 1
    end


    return nil
end


function CoveRole:setNavMeshObstacle(bool)
	if IsNull(self._roleCont) then
		return
	end
	self._roleCont.navMeshObstacle.enabled = bool
end

--家园点击后状态恢复
function CoveRole:homwTouchRecover()

	--LuaLogger.es("homwTouchRecover =====",self.m_behaviorState )
	self:setNavMeshObstacle(false)
	if not IsRoleControllerValid(self) then return end
	self._roleCont:WaitAgentOnNavMesh(function()
		if IsRoleAgentValid(self) then
			self._roleCont.agent.enabled = true
			if self.m_behaviorState == "idle" then
				self:doIdleBehavior()
			elseif self.m_behaviorState == "dowalk" then
				self:doWalkLogic(self.m_complete)
			elseif self.m_behaviorState == "doremoveRole" then
				self:DoRemoveRoleBehavior(self.m_complete)
			elseif self.m_behaviorState == "doChangeRoom" then
				self:doChangeRoomBehaivior(self.m_complete)
			elseif self.m_behaviorState == "doAppearToDest" then
				self:DoAppearToDestinationBehavior(self.m_complete)
			elseif self.m_behaviorState == "doWork" then
				self:DoWorkBehavior(self.m_complete)
			end
			self._clickEmote.gameObject:SetActive(false)
		end
	end)
end


----角色点击行为展示 End




function CoveRole:changeSpeedWithState()

	local battleMgr = CoveBattleMgr.instance()
	if battleMgr:IsBattle() then
		if battleMgr:IsBattleCharacter(self:GetUID()) then
			if self.coveModelState == 0 then
				self.moveSpeed = Config.GetConfigInfo("homeRunSpeed")
				self._roleCont:SetSpeed(self.moveSpeed)

			elseif self.coveModelState == 1 then
				local characterCfg = Config.GetCharacterInfo(self.id)
				self.moveSpeed = characterCfg.homeFightSpeed
				self._roleCont:SetSpeed(self.moveSpeed)
			end
			return
		end
	end
	if self.coveModelState == 1 then
		self.moveSpeed = Config.GetConfigInfo("homeIntoSpeed")
		self._roleCont:SetSpeed(self.moveSpeed)
		return
	end


	if not self._pathInfo or not self._roleCont then
		return
	end

	
	if self._pathInfo.moveMode == RoleAnimStateType.Run then
		self.moveSpeed = Config.GetConfigInfo("homeRunSpeed")
		--self._roleCont:SetSpeed(self.moveSpeed)
	elseif self._pathInfo.moveMode == RoleAnimStateType.Walk then
		self.moveSpeed = Config.GetConfigInfo("homeWallkSpeed")
		--self._roleCont:SetSpeed(self.moveSpeed)
	elseif self._pathInfo.moveMode == RoleAnimStateType.Into then
		self.moveSpeed = Config.GetConfigInfo("homeWallkSpeed")
		--self._roleCont:SetSpeed(self.moveSpeed)
	end

	if self.moveSpeed ~= nil then
		self.moveSpeed =  self.moveSpeed * (1 + (math.random() * 0.4) - 0.2)
		self._roleCont:SetSpeed(self.moveSpeed)
	end
	---todoflyTest   
	---self._roleCont:SetSpeed(20)
end

---角色生命周期是否结束
function CoveRole:isLifeEnd()
	return self.behavior == "leavePort"
end

function CoveRole:isInTour()
	return self.behavior == "tour"
end

function CoveRole:getRoom()
	return self._room
end

function CoveRole:setRoom(room)

	LuaLogger.ds(" 设置房间 id:" .. self:GetID() .. "room ~= nil" .. tostring(room ~= nil))
	if room == self._room then
		self:generatePath()
		return
	end
	if self._room ~= nil then
		self._room:removeRole(self)
		self._room:onPathUseEnd(self._pathInfo)
	end
	self._room = room
	if room == nil then
		return
	end
	self._room:setRole(self)
	self:generatePath()
end


function CoveRole:clearShowTimer()
	if self._roleRotateTimer then
		DLuaTimer:RemoveTimer(self._roleRotateTimer)
		self._roleRotateTimer = nil
	end
	if self._pointEffectTimer then
		DLuaTimer:RemoveTimer(self._pointEffectTimer)
		self._pointEffectTimer = nil
	end
end

function CoveRole:clearSelf()
	self:Destroy()
	self:clearShowTimer()
	if self:getRoom() ~= nil then
		self._room:onPathUseEnd(self._pathInfo)
	end

	local key = "CoveRole" .. self:GetID()
	local buildMgr = CoveManager.instance()._buildingMgr
	if buildMgr ~= nil and buildMgr.buildingBtnList ~= nil then
		buildMgr.buildingBtnList[key] = nil
	end
	if self.role_uiObj ~= nil then
		self.role_uiObj.name = "Role_UI"
		self.role_uiObj.transform:SetParent(self.uiCanvas.transform, false)
		self.role_uiObj = nil
	end
	self.curCoveRoleMoodType = nil
	self = nil
end

--暂时隐藏其他ui事件 父节点
--@param list table 需要显示的ui列表
function CoveRole:tempHideOtherRoleUI(list)
	for k, v in pairs(self.roleUIListparent) do
		v.gameObject:SetActive(tablex.contains(list, k))
	end
end

--显示所有ui 父节点
function CoveRole:ShowAllRoleUI()
	for k, v in pairs(self.roleUIListparent) do
		v.gameObject:SetActive(true)
	end
end

--刷新事件相关
function CoveRole:refreshEventMsg()
	--获取当前角色的事件信息，更新显示
	--self.id
	--TODO: 控制气泡显示
	local serverData = Me:getPlayerHero(self.id)
	if not self._eventBtn then
		return
	end
	if not serverData then
		self._eventBtn.gameObject:SetActive(false)
		return
	end
	if self._eventBtn then
		if serverData.affectionEvent == 0 then
			self._eventBtn.gameObject:SetActive(false)
		else
			self._eventBtn.gameObject:SetActive(true)
			self:CloseDialogue()
		end
		if not self._eventScaleBtn then
			self._eventScaleBtn = self._eventBtn:GetComponent(TypeInfo.ScaleButton)
		end
		self._eventScaleBtn.onClick:RemoveAllListeners()
		self._eventScaleBtn.onClick:AddListener(function()
			LuaMain:play2DSound(self.btnSoundPath)
			UIMgr:popUICover("AffectionEventPanel", {id = self.id, mode = 1, eventId = serverData.affectionEvent})
		end)
	end
	--控制气泡内容
	--控制事件按钮后续执行事件
end

function CoveRole:ShowHeorInfo()
	if not LuaLogger.Enabled then
		return
	end
	local serverData = Me:getPlayerHero(self.id)
	if serverData == nil or serverData.id ~= self.id then
		LuaLogger.ds("===>>> 获取英雄数据错误 id:" .. tostring(self.id))
		return
	end

	local str = "===>>> id:" .. tostring(self.id) .. "  行为信息 \n"
	if serverData.homelandActionInfo == nil then
		return
	end
	str = str .. "当前行为:" .. tostring(serverData.homelandActionInfo.actionId) .. " 上一次行为:" .. tostring(serverData.homelandActionInfo.lastActionId) .. "\n"
	str = str .. "资源信息\n"

	if serverData.attributeValList ~= nil then
		for i = 1, #serverData.attributeValList do
			local v = serverData.attributeValList[i]
			str = str .. "type:" .. tostring(v.type) .. "   val:" .. tostring(v.val) .."\n"
		end
	else
		str = str .. "无"
	end

	LuaLogger.ds(str)
end

function CoveRole:ChangeSkinNormalToSwin(isPlayFadeOut)
	if self.isSwimsuitSkin then	
		LuaLogger.ds("ChangeSkinNormalToSwin 已是泳装，无需二次替换 id = ",self.id)
		return -- 已是泳装，无需二次替换
	end
	LuaLogger.ds("ChangeSkinNormalToSwin 换泳装 id = ",self.id)
	local createPanelNewModel = function()
		
		local serverData = Me:getPlayerHero(self.id)
		local skinConfig = Config.GetCharacterSkinInfo(serverData.equipSkin)

		self.skinCfg = skinConfig
		local path = string.format(Config.PrefabPath.RoleModelPrefab, skinConfig.swimsuitModel, skinConfig.swimsuitModel)

		PoolMgr:Get(path, function (modelObj)
			if modelObj == nil or IsNull(modelObj) then
				LuaLogger.ds("加载模型失败 id:" .. self:GetID() .. " path:" .. path)
				return
			end
			if self.modelObj then
				self:OnModelDestroy()
				PoolMgr.Free(self.modelObj)
				self.modelObj = nil
			end
			modelObj.transform.parent = self._roleCont.roleRoot.transform
			modelObj.transform.localPosition = Vector3.zero
			modelObj.transform.localRotation = Quaternion.identity
			modelObj.transform.localScale = Vector3.one* self.skinCfg.modelRate
			self._model = modelObj.transform:GetComponent("RoleModelController")
			modelObj:SetActive(true)
			self.modelObj = modelObj
			self._model:FadeIn()
			if self.m_currentState ~= nil then
				self:SetDefaultState(self.m_currentState)
			else
				self:SetDefaultState(RoleAnimStateType.Walk)
			end
			self.isSwimsuitSkin = true -- 切换成功后标记为泳装
		end)

	end
	if isPlayFadeOut then
		if self._model then
			self._model:FadeOut()
		end
		DLuaTimer:DoAfter(1,function()
			createPanelNewModel()
		end)

	else
		createPanelNewModel()
	end
	
end


function CoveRole:ChangeSkinSwinToNormal(isPlayFadeOut)
	if not self.isSwimsuitSkin then
		LuaLogger.ds("ChangeSkinSwinToNormal 已是常服，无需二次替换 id = ",self.id)
		return -- 已是常服，无需二次替换
	end
	LuaLogger.ds("ChangeSkinSwinToNormal 换常服 id = ",self.id)
	local createPanelNewModel = function()
		

		local serverData = Me:getPlayerHero(self.id)
		local skinConfig = Config.GetCharacterSkinInfo(serverData.equipSkin)

		self.skinCfg = skinConfig
		
		PoolMgr:Get(string.format(Config.PrefabPath.RoleModelPrefab, skinConfig.modelKey, skinConfig.modelKey) , function (modelObj)
			
			if self.modelObj then
				self:OnModelDestroy()
				PoolMgr.Free(self.modelObj)
				self.modelObj = nil
			end
			modelObj.transform.parent = self._roleCont.roleRoot.transform
			modelObj.transform.localPosition = Vector3.zero
			modelObj.transform.localRotation = Quaternion.identity
			modelObj.transform.localScale = Vector3.one * self.skinCfg.modelRate

			self._model = modelObj.transform:GetComponent("RoleModelController")
			modelObj:SetActive(true)
			self.modelObj = modelObj
			self._model:FadeIn()
			if self.m_currentState ~= nil then
				self:SetDefaultState(self.m_currentState)
			else
				self:SetDefaultState(self:GetMoveStateVal())
			end
			self.isSwimsuitSkin = false -- 切换成功后标记为常服
		end)
	end

	if isPlayFadeOut then
		if self._model then
			self._model:FadeOut()
		end
		DLuaTimer:DoAfter(1,function()
			createPanelNewModel()
		end)
	else
		createPanelNewModel()
	end
	
end


function CoveRole:GotoBattle()

	LuaLogger.ds("CoveRole 开始战斗 id:" .. self:GetID())

	local fightInfo = CoveBattleMgr.instance():GetSaveFightingInfo(self)
	if fightInfo == nil then
		LuaLogger.ds("为找到角色战斗信息 id:" .. tostring(self:GetID()))
		return
	end
	if self:getRoom() ~= nil then
		self._room:onPathUseEnd(self._pathInfo)
	end
	local newRoom = self._roleMgr._coveMgr:getRoomMgr():getRoomWithRoomId(self.id, 111)
	self:setRoom(nil)
	self._pathIndex = 0
	self._pathInfo = nil
	if self.currentAction ~= nil then
		self.currentAction:Exit()
		self.currentAction = nil
	end

	self:clearShowTimer()
	self:StopMove()

	self:HideHomeMood()
	self:HideWorkState()
	self:changeSpeedWithState()
	self:SetDefaultState(self:GetMoveStateVal())

	local agent = self._roleCont.agent
	if agent ~= nil and agent.enabled == false then
		agent.enabled = true
		self:setNavMeshObstacle(false)
	end

	local characterCfg = Config.GetCharacterInfo(self.id)
	self.maxHp = characterCfg.homeFightHp
	self.maxMp = characterCfg.homeFightMp

	local hp = fightInfo.hp or self.maxHp
	local mp = fightInfo.mp or self.maxMp
	self:SetResourceVal(HeroAttributeType.Hp, hp)
	self:SetResourceVal(HeroAttributeType.Mp, mp)

	self:SetAttackRange(characterCfg.homeFightRange)
	self.skillCtrl:ResetSkill(characterCfg.homeFightAtk)
	self:CreateEffect(1107)
	self:SetEffectActive(1107, false)

	if fightInfo.pos ~= nil then
		local fightPoint, fightDir = fightInfo.pos, fightInfo.defDir
		local pos = Vector3.New(fightPoint.x / 100, fightPoint.y / 100, fightPoint.z / 100) 
		self._roleCont:SetPositionImm(pos)
		--self._roleCont:SetDirection(fightDir / 100, 0.5, nil)
	end

	if fightInfo.stateType == 1 then
		self:SetCoveModelState(1)
	end
	---启动行为树
	---@type CoveBattleRoleAI
	self.aiTree = require('CoveBattleRoleAI'):new(self)
	self:SetEnableUpdate(true)
end


function CoveRole:SetCoveModelState(val)
	CoveBase.SetCoveModelState(self, val)
	self:changeSpeedWithState()
	if val == 1 and self:IsInBattle() then
		self:HideHomeMood()
	end
end


function CoveRole:GetIdleStateVal()
	if self.coveModelState == 0 then
		return RoleAnimStateType.Idle
	elseif self.coveModelState == 1 then
		return RoleAnimStateType.Into
	end
	return RoleAnimStateType.Idle
end

function CoveRole:GetMoveStateVal()
	if self.coveModelState == 0 then
		if self:IsInBattle() then
			return RoleAnimStateType.Run
		else
			if self._pathInfo ~= nil then
				if self._pathInfo.moveMode == RoleAnimStateType.Run then
					return RoleAnimStateType.Run
				elseif self._pathInfo.moveMode == RoleAnimStateType.Walk then
					return RoleAnimStateType.Walk
				else
					return RoleAnimStateType.Walk
				end
			else
				return RoleAnimStateType.Walk
			end
			
		end
	elseif self.coveModelState == 1 then
		return RoleAnimStateType.Into
	end
	return RoleAnimStateType.Walk
end

function CoveRole:CanExitRoom()
	return not self.isExitRoom
end


function CoveRole:GotoExitRoom()
	self.isExitRoom = true
end


function CoveRole:GetEnemyAwayDis()
	if self.characterCfg == nil then
		return 0
	end
	return self.characterCfg.enemyAway
end


function CoveRole:GetFriendAwayDis()
	if self.characterCfg == nil then
		return 0
	end
	return self.characterCfg.partnerAway
end

function CoveRole:CanBuji()
	if not self:IsAllReady(CovePlayerReadyType.Bujiing) then
		return false
	end
	local hp = self:GetResourceVal(HeroAttributeType.Hp)
	local mp = self:GetResourceVal(HeroAttributeType.Mp)
	return (hp <= 0 or mp <= 10)
end


function CoveRole:GotoBuji()
	self.attackTarget = nil
	self.buji1 = true
	self:SetReady(CovePlayerReadyType.Bujiing, true)
	self:StopMove()
	self:ForceToActionId(1000, function()
		self:OnBujiFinished()
	end)
end



function CoveRole:GotoSuodi()
	if self.coveModelState == 0 then
		self:ShowHomeMood(CoveRoleMoodType.Mood_Surprise)
	else
		self:HideHomeMood()
	end
	CoveBase.GotoSuodi(self)
end

function CoveRole:CanCheckAttackPoint()
	if not self:IsAllReady(CovePlayerReadyType.CheckAttackPoint) then
		return false
	end
	if self.coveModelState == 1 then
		return false
	end
	local pos = CoveBattleMgr.instance():GetNearestFightPoint(self:GetType(), self:GetPosition())
	if pos == nil then
		return false
	end
	return true
end


function CoveRole:GotoAttackPoint()
	local pos = CoveBattleMgr.instance():GetNearestFightPoint(self:GetType(), self:GetPosition())
	if pos == nil then
		self:SetReady(CovePlayerReadyType.CheckAttackPoint, false)
		return
	end
	self:SetReady(CovePlayerReadyType.CheckAttackPoint, true)
	
	self:ShowHomeMood(CoveRoleMoodType.Mood_Surprise)
	self:MoveTo(pos, function()
		self.coveModelState = 1
		self:SetCoveModelState(1)
		self:SetReady(CovePlayerReadyType.CheckAttackPoint, false)
	end)
end

function CoveRole:OnBujiFinished()
	self:SetReady(CovePlayerReadyType.Bujiing, false)
	self:SetResourceVal(HeroAttributeType.Hp, self.maxHp)
	self:SetResourceVal(HeroAttributeType.Mp, self.maxMp)

	self.buji1 = false
	self:SetReady(CovePlayerReadyType.Bujiing, false)
	self:SetDefaultState(self:GetIdleStateVal())
end

function CoveRole:CanBeAttacked()
	local canAttack = CoveBase.CanBeAttacked(self)
	if not canAttack then
		return false
	end
	if self.buji1 then
		return false
	end
	if self.coveModelState == 0 then
		return false
	end
	return true
end

function CoveRole:GotoAttack()
	CoveBase.GotoAttack(self)
	CoveBattleMgr.instance():SetBattleIsFight()
end

---获取攻击对象
---@return CoveBase
function CoveRole:SearchAttackTarget()
	local forceTarget = CoveBattleMgr.instance():GetForceAttackTarget()
	if forceTarget ~= nil and forceTarget:CanBeAttacked() then
		return forceTarget
	end

	return CoveBase.SearchAttackTarget(self)
end



---@param actionId integer 强制移动到某个行为
function CoveRole:ForceToActionId(actionId, callback)

	local v = {
		heroId = self:GetID(),
		actionId = actionId
	}
	self.forceToActionCallBack = callback
	---@type CoveRoleManager
	local coveRoleMgr = self._roleMgr

	local roleStateData = coveRoleMgr:getRoleDataWithId2(v.heroId)
	roleStateData.serverActionInfo = v
	local activateCfg = Config.GetHomeActivateCfg(v.actionId)
	local lastRoomId = 10099

	local newRoomId = activateCfg.param
	self.data.blackboard.changeRoomData = {lastRoomId = lastRoomId,newRoomId = newRoomId}
	--LuaLogger.ds(" ReportHeroHomeActionCompletedReq v.actionId   newRoomId    lastRoomId =====",v.actionId,newRoomId,lastRoomId)
	--这边多加一个判断 ，是否房间已经改变
	if newRoomId ~= lastRoomId then
		local newRoom = coveRoleMgr._coveMgr:getRoomMgr():getRoomWithRoomId(self.id,newRoomId)--self._coveMgr:getRoomMgr():getRandomRoom(role.id, lastRoomId)
		if newRoom then
			self.data.homeWorkIndex = coveRoleMgr:GetWomeWorkPos(newRoomId)
			self:setRoom(newRoom)
			self:clearShowTimer()
			--LuaLogger.ds("role.data.homeWorkIndex ====",role.data.homeWorkIndex,lastRoomId,newRoomId)
			self.data.blackboard.changeRoomData = {lastRoomId = lastRoomId,newRoomId = newRoomId}
			coveRoleMgr.m_coveWalkManager:PushToWalkChangeRoom(self)
		end
	end
end



function CoveRole:CanGameOver()
	return not CoveBattleMgr.instance():IsBattle()
end

function CoveRole:GotoGameOver()
	self:SetEnableUpdate(false)
	LuaLogger.ds("执行战斗结束" .. self:GetID())
	if self.effects ~= nil then
		for k, v in pairs(self.effects) do
			if k ~= 3000 then
				PoolMgr.Free(v)
				self.effects[k] = nil
			end
		end
	end
	self.forceToActionCallBack = nil
	
	if self.data.isBattleRole then
		self.data.isNeedToRemove = true
		local roleStateData = self._roleMgr:getRoleDataWithId(self:GetID(), true)

		--如果角色已经标记为移除了 ，走移除逻辑
		roleStateData.isNeedToRemove = true
	end
	self:DeleteAllWaitTime()
	self:ClearAiTreeVal()
	self:changeSpeedWithState()
	self:setRoom(nil)
	self._roleMgr:ReturnRoleFromStateComplete(self)
end

function CoveRole:ClearAiTreeVal()
	CoveBase.ClearAiTreeVal(self)
	self.buji1 = nil

end

function CoveRole:SetTaregt(position, callback)
	--LuaLogger.es(string.format(" lua 设置行走点 id:%s  pos:  x:%s y:%s z:%s ", self:GetID(), position.x, position.y, position.z))

	self:SetDefaultState(self:GetMoveStateVal())
	self._roleCont:RemoveIntervalReached()
	self._roleCont:ClearCurrentTarget()
	self._roleCont:ClearTriggerPath()
	self._roleCont:MoveTo(position, callback,false)
end



function CoveRole:ShowHomeMood(coveRoleMoodType)
	if self.m_homeMoodRoot then
		if self.curCoveRoleMoodType == coveRoleMoodType then
			return
		end
		self.m_homeMoodRoot.gameObject:SetActive(true)
		self:CloseDialogue()
		self.m_homeMoodCanvasGroup.alpha = 0
		
		if self.m_homeMoodIconImage then
			ResMgr:LoadSpriteAsyncInOwner(string.format(Config.SpritePath.HomeMoodsPath, coveRoleMoodType), function (s)
				self.m_homeMoodIconImage.sprite = s
			end, self.m_homeMoodIconImage.gameObject)
		end
		if self.homeMoodCanvasTweener then self.homeMoodCanvasTweener:Kill() end
		self.homeMoodCanvasTweener = self.m_homeMoodCanvasGroup:DOFade(1, 1)

		self.curCoveRoleMoodType = coveRoleMoodType
	end
end

function CoveRole:HideHomeMood()
	if self.m_homeMoodRoot then
		if self.homeMoodCanvasTweener then self.homeMoodCanvasTweener:Kill() end
		self.homeMoodCanvasTweener = self.m_homeMoodCanvasGroup:DOFade(0, 1):OnComplete(function()
			self.m_homeMoodRoot.gameObject:SetActive(false)
		end)
	end
	self.curCoveRoleMoodType = nil
end

function CoveRole:ShowInWorkState()
	if self.m_workRoot then
		self.m_workRoot.gameObject:SetActive(true)
	end
end


function CoveRole:HideWorkState()
	if self.m_workRoot then
		self.m_workRoot.gameObject:SetActive(false)
	end
end

function CoveRole:CanInteractiveDialogue()
	if self:IsInBattle() then
		return false
	end
	if not self.modelLoadFinish then
		return false
	end
	if self.destroyed then
		return false
	end

	if self.interactiveDialogueOverTime ~= nil and self.interactiveDialogueOverTime > Time.time then
		return false
	end

	for k, v in pairs(self.forbiddenDialogueObjs) do
		if v.activeSelf then
			return false
		end
	end
	return true
end


---开启交互对话
---@param actionType int
function CoveRole:InteractiveDialogue(actionType)
	local canActive = self:CanInteractiveDialogue()
	if not canActive then
		return
	end
	if not self.modelLoadFinish then
		return
	end
	
	local cfgs = Config.GetHomeInteractiveDialogueTable(actionType)
	if cfgs == nil or #cfgs == 0 then
		return
	end

	local id, cfg = CoveManager.instance():getConfigsRandomId(cfgs, function(cfg)
		local funId = cfg.unlockId
		if funId ~= 0 and funId ~= nil then
			local isOpen = (UICommonUtils.CheckFunctionOpen(funId)) ~= GE.FunctionOpenState.Lock
			if not isOpen then
				return false
			end
		end
		if cfg.characters ~= nil and #cfg.characters ~= 0 then
			local index = tablex.indexof(cfg.characters, self.id)
			if index == -1 then
				return false
			end
		end
		return true
	end)

	if cfg == nil then
		return
	end
	self.interactiveDialogueRoot.gameObject:SetActive(true)
	self.interactiveDialogueText.text = cfg.dialogue


	local coveMgr = CoveManager.instance()
	local intervalTime = coveMgr.interactiveDialogueCfg.intervalTime
	local t = coveMgr._random:range(intervalTime[1], intervalTime[2])
	self.interactiveDialogueOverTime = Time.time + t
	local showTime = coveMgr.interactiveDialogueCfg.showTime
	local t = coveMgr._random:range(showTime[1], showTime[2])

	self:AddTimeWait(t, function()
		if self.destroyed then
			return
		end
		self.interactiveDialogueRoot.gameObject:SetActive(false)
	end)
end

function CoveRole:CloseDialogue()
	self.interactiveDialogueRoot.gameObject:SetActive(false)
end

function CoveRole:SetTitleActive(isActive)
	--改名
	local key = "CoveRole" .. self:GetID()
	local coveMgr = CoveManager.instance()
	local btn = coveMgr._buildingMgr.buildingBtnList[key]
	if btn ~= nil then
		btn.isShow = isActive
	end
end

return CoveRole