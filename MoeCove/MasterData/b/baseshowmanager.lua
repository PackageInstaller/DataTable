---@diagnostic disable: undefined-global
require "class"
---@class BaseShowManager:BaseClass
local BaseShowManager = class("BaseShowManager")
local BattleCore = require "BattleCore"

local scaleIndex = 1.3
local mapCubeOffsetY = 1/2 * (scaleIndex - 1)
local BattleCameraSet = Config.GetConfigInfo("BattleCameraSet")
local cameraMax = BattleCameraSet[1] / 1.3 * scaleIndex
local cameraMin = BattleCameraSet[2] / 1.3 * scaleIndex
local cameraSpace = (cameraMax - cameraMin) * BattleCameraSet[3]

---战斗表现类型对应的tips路径
local BulletDisTypeToTips = {
	[GE.BulletDisType.Miss] = Config.HitTipsPath.Miss,
	[GE.BulletDisType.Ricochet] = Config.HitTipsPath.Miss3,
	[GE.BulletDisType.Partial] = Config.HitTipsPath.Partial,
	[GE.BulletDisType.DefReduce] = Config.HitTipsPath.Partial2,
}
local hitNumShowTime = 1.5
local hitJumpInterval = 0.1
local hitJumpSpace = 28
local roleActiveColor = Color.New(0,0,0,0)

function BaseShowManager:ctor()
	self:reset()
end

function BaseShowManager:reset()
	self.levelLoaded = false
	---@type table<UnityEngine.GameObject,BattleBlock>
	self.blocksMap = {}
	self.blocksObjMap = {}
	---@type table<integer,ShowManagerHeroData>
	self.rolesMap = {}
	---@type table<UnityEngine.GameObject,ShowManagerHeroData>
	self.rolesDataMap = {}
	self._storyRoleBlockIdList = {}
	---@type BaseMap?
	self._map = nil

	self.sceneRootObj = nil
	self.backgroundObj = nil
	self.planarReflectionRendererObj = nil
	self.storyRoot = nil
	---@type UnityEngine.GameObject
	self.mainVcam = nil
	self.cameraObj = nil
	---@type UnityEngine.Camera
	self.camera = nil
	---@type ShowManagerBattleMainPanelData
	self._uiBattleMain = nil

	if self.cameraViewDistance then
		UnityEngine.PlayerPrefs.SetFloat(GE.LocalCustomDataKey.BattleCameraDistance, self.cameraViewDistance)
	else
		if UnityEngine.PlayerPrefs.HasKey(GE.LocalCustomDataKey.BattleCameraDistance) then
			self.cameraViewDistance = UnityEngine.PlayerPrefs.GetFloat(GE.LocalCustomDataKey.BattleCameraDistance)
		else
			self.cameraViewDistance = cameraMin
		end
	end
	self.cameraViewDistance = math.min(self.cameraViewDistance, cameraMax - cameraSpace)
	self.cameraViewDistance = math.max(self.cameraViewDistance, cameraMin + cameraSpace)
	self.cameraFollowBounds = Config.GetConfigInfo("cameraRange")
	self.cameraMoveBounds = { xMin = 0, xMax = 30*scaleIndex, yMin = 0, yMax = 30*scaleIndex }
	self.followTarget = nil
	self.followTargetType = GE.FollowTargetType.move
	self.cameraTweener = nil
	self._viewDistanceTweener = nil
	self._viewOrientationTweener = nil

	local CanvasScaler = UIMgr.uiCanvas.gameObject:GetComponent("CanvasScaler")
	self.screen_width = CanvasScaler.referenceResolution.x
	self.screen_height = CanvasScaler.referenceResolution.y
	self._hitTextList = {}
	self._effectTextList = {}
	self._lastMousePosition = nil
	self.smoothFollowLastTime = 0
	self.smoothFollowClearTimer = nil
	self._hiddenObstructionList = {}
	---@type table<integer, MarkData>
	self._markDataDic = {}	--敌人标记数据字典
	---@type table<integer, MarkData>
	self._waitShowMarkList = {} --等待显示的标记列表
	self.roleMoveTweenerList = {}--角色移动Tweener列表
end

------------------ 更新 ------------------

---每帧由 CameraRenderCB.lateUpdateFunc 驱动，子类可覆盖扩展
function BaseShowManager:FixedUpdate()
end


function BaseShowManager:removeAllHitTextList()
	for obj, pos in pairs(self._hitTextList) do
		self._hitTextList[obj] = nil
		PoolMgr.Free(obj)
	end
end


function BaseShowManager:removeAllEffectTextList()
	for obj, pos in pairs(self._effectTextList) do
		self._effectTextList[obj] = nil
		PoolMgr.Free(obj)
	end
end

------------------ 场景加载 ------------------

---注入地图对象，loadPVRoot / roleMoveNoPath 等方法通过此对象查询格子数据
---@param map BaseMap
function BaseShowManager:setMap(map)
	self._map = map
end

function BaseShowManager:setMapAngle(angle)
	self.mapAngle = angle * 90
end

function BaseShowManager:loadPVRoot(callback)
	ResMgr:LoadGameObjectAsync(Config.PrefabPath.StoryRoot, function (obj)
		self.storyRoot = obj

		self.cameraRoot = self.storyRoot.transform:Find("CameraRoot").gameObject
		self.cameraRotateRoot = self.cameraRoot.transform:Find("CameraRotateRoot").gameObject
		self.mainVcam = self.cameraRotateRoot.transform:Find("MainVcam").gameObject
		self.cameraObj = self.storyRoot.Find("BattleCamera").gameObject	
		if StoryMgr:getIsHomeLandStory() then
			self.cameraRoot:SetActive(false)
			self.cameraObj:SetActive(false)
			self.cameraObj = UnityEngine.GameObject.Find("GameSceneInfo/MainCamera")
		end
		self.camera = self.cameraObj:GetComponent("Camera")
		self.cameraControl = self.cameraRoot:GetComponent("BattleCameraController")
		self._cinemachineBrain = self.cameraObj:GetComponent("CinemachineBrain")
		---@type Cinemachine.CinemachineImpulseSource
		self._cinemachineImpulseSource = self.cameraObj:GetComponent("CinemachineImpulseSource")
		local CameraRenderCB = self.cameraObj:GetComponent("CameraRenderCB")
		CameraRenderCB.lateUpdateFunc = function ()
			self:FixedUpdate()
		end
		local mapRoot = self.storyRoot.Find("Map").transform
		UIMgr.SetBaseCamera(self.camera)

		for i = 0, mapRoot.childCount - 1 do
			UnityEngine.GameObject.Destroy(mapRoot:GetChild(i).gameObject)
		end
		local blocks = self._map:getBlocks()
		mapRoot.localPosition = Vector3.New(self._map.offsetX, self._map.offsetZ, self._map.offsetY)
		local newscale = self._map.ratio * scaleIndex
		ResMgr:LoadPrefabAsyncInOwner(Config.PrefabPath.BattleMapCube, function (cube)
			LuaLogger.ds("loadBattleRoot blocks", tablex.size(blocks))
			for index, block in pairs(blocks) do
				local blockObj = Instantiate(cube).gameObject
				blockObj:SetParent(mapRoot)
				--战斗中跟家园中格子Y轴有区别
				local offsetY = 1/2 * (newscale - 1)
				if StoryMgr:getIsHomeLandStory() then
					offsetY = -offsetY
				end
				blockObj.transform.localPosition = Vector3.New(block.row * newscale, offsetY, block.col * newscale)
				blockObj.name = block.id
				blockObj.transform.localScale = Vector3.New(newscale, newscale, newscale)
				self:_setBlockMat(blockObj, block.terrain)
				self.blocksObjMap[block.id] = blockObj
				self.blocksMap[blockObj] = block
				if index == #blocks then
					if (callback) then
						callback()
					end
					self:showMapBlockCidEditor(blocks)
				end
			end
			LuaLogger.ds("inittest loadBattleRoot finish")
			self.levelLoaded = true
		end, self.storyRoot.gameObject)
	end)
end

function BaseShowManager:_setBlockMat(blockObj, terrain)
	local rend = blockObj:GetComponent("Renderer")
	if rend.sharedMaterial then
		ResMgr:LoadMaterialAsyncInOwner("Material/MapCube" .. terrain .. ".mat", function(mat)
			rend.sharedMaterial = mat
		end, blockObj)
	end
end

------------------ 地块查询 ------------------

function BaseShowManager:getBlockByObj(blockObj)
	return self.blocksMap[blockObj]
end

---@return UnityEngine.GameObject?
function BaseShowManager:getBlockObj(blockId)
	return self.blocksObjMap[blockId]
end

------------------ 角色查询 ------------------

---@return ShowManagerHeroData?
function BaseShowManager:getRole(roleId)
	return self.rolesMap[roleId]
end

---获取角色控制器
---@param roleId number 角色id
---@return RoleController?
function BaseShowManager:getRoleController(roleId)
	if not self.rolesMap[roleId] then
		return nil
	end
	return self.rolesMap[roleId].controller
end

---获取角色血量ui Obj
---@param roleId number 角色id
---@return UnityEngine.GameObject?
function BaseShowManager:getRoleHpObj(roleId)
	if not self.rolesMap[roleId] then
		return nil
	end
	return self.rolesMap[roleId].hpObj
end

---获取角色skillIconObj Obj
---@param roleId number 角色id
---@return UnityEngine.GameObject?
function BaseShowManager:getRoleSkillIconObj(roleId)
	if not self.rolesMap[roleId] then
		return nil
	end
	return self.rolesMap[roleId].SkillIconObj
end

function BaseShowManager:setRoleUIActive(id, isActive)
	local hpObj = self:getRoleHpObj(id)
	UICommonUtils.Hp_SetUIRootActive(hpObj, isActive)
end

------------------ 角色特效对象管理 ------------------

---@param roleId integer
---@param buffId integer
function BaseShowManager:getRoleOffsetByBuffId(roleId, buffId)
	local role = self:getRole(roleId)
	return role.buffToOffset[buffId]
end

---@param roleId integer
---@param buffId integer
---@param offset any
function BaseShowManager:setRoleOffsetByBuffId(roleId, buffId, offset)
	local role = self:getRole(roleId)
	if not role then return end
	role.buffToOffset[buffId] = offset
end

---@param roleId integer
---@param buffId integer
function BaseShowManager:getRoleEffectObjByBuffIdIsExist(roleId, buffId)
	local role = self:getRole(roleId)
	if not role or not role.buffToeffectObj then
		return false
	end
	return role.buffToeffectObj[buffId]
end

---@param roleId integer
---@param buffId integer
---@param obj any GameObject? 先为"" 异步加载完成后再有obj
function BaseShowManager:setRoleEffectObjByBuffId(roleId, buffId, obj)
	local role = self:getRole(roleId)
	if not role then return end
	if not role.buffToeffectObj then
		role.buffToeffectObj = {}
	end
	if obj then
		role.buffToeffectObj[buffId] = obj
	else
		role.buffToeffectObj[buffId] = ""
	end
end

---@param roleId integer
---@param buffId integer
function BaseShowManager:clearRoleEffectObjByBuffId(roleId, buffId)
	local role = self:getRole(roleId)
	if not role or not role.buffToeffectObj then return end
	if not role.buffToeffectObj[buffId] == "" then
		PoolMgr.Free(role.buffToeffectObj[buffId])
	end
	role.buffToeffectObj[buffId] = nil
end

---@param roleId integer
function BaseShowManager:clearRoleEffectObjAll(roleId)
	local role = self:getRole(roleId)
	LuaLogger.ds("BaseShowManager:clearRoleEffectObjAll", tablex.dump(role.buffToeffectObj))
	if not role or not role.buffToeffectObj then return end
	for k, v in pairs(role.buffToeffectObj) do
		if v ~= "" then
			PoolMgr.Free(v)
		end
	end
end

---@param roleId integer
---@return table?
function BaseShowManager:getRoleEffectObjByRoleId(roleId)
	local role = self:getRole(roleId)
	if not role or not role.buffToeffectObj then
		return nil
	end
	return role.buffToeffectObj
end

------------------ 角色显示 ------------------

---角色出现特效
---@param camp BattleCampType 阵营
---@param blockObj UnityEngine.GameObject 格子
function BaseShowManager:doShowRoleEffect(camp, blockObj)
	if not UICommonUtils.Checkobj(blockObj) then
		return
	end
	local createEffectPath = camp == GE.BattleCampType.Enemy and Config.PrefabPath.EnemyCreateEffect or Config.PrefabPath.FriendCreateEffect
	PoolMgr:Get(createEffectPath, function (effectObj)
		effectObj.transform.position = blockObj.transform.position + Vector3.New(0, 0.5, 0)
		---@type UnityEngine.ParticleSystem
		local particle = effectObj.transform:Find("Effect"):GetComponent("ParticleSystem")
		particle:Simulate(0)
		particle:Play()
		self:_DoAfter(3, function()
			PoolMgr.FreeWithOutSetActive(effectObj)
		end)
		--出现音效
		local audioPath = string.format(Config.AudioPath.SE, "fight_act again")
		self:play2DSound(audioPath)
	end)
end

---创建角色
---@param data RoleCreateData
---@param callback function? 回调函数
---@param hpNotShow boolean? 是否不显示血条
function BaseShowManager:roleCreate(data, callback, hpNotShow)
	local f = function ()
		if (data.camp) then
			local hpData = {
				id = data.id,
				hp = data.hp,
				maxHp = data.maxHp,
				camp = data.camp,
			}
			self:showRoleHp(hpData)
		end

		local index = 0
		local maxIndex = 3
		local buffIdList = {}
		if data.buffList then
			for _, buff in ipairs(data.buffList) do
				local buffId = buff.id
				local buffConfig = Config.GetBuffInfo(buffId)
				if not string.isNullOrEmpty(buffConfig.buffIcon) then
					index = index + 1
					buffIdList[index] = buffId
				end
				if index >= maxIndex then
					break
				end
			end
		end
		---@type BuffStateReportData
		local buffReportData = {
			id = data.id,
			buffs = buffIdList,
		}
		self:refreshHeroBuffState(buffReportData)
		if hpNotShow ~= nil then
			self:showOrHideRole(data.id, data.isShow, not hpNotShow)
		else
			self:showOrHideRole(data.id, data.isShow)
		end
	end
	local clientBattleMgr
	if ClientBattleManager then
		clientBattleMgr = ClientBattleManager.getInstance()
	end
	if clientBattleMgr then
		clientBattleMgr:waitCreateRoleNum()
	end
	local storyRoleId = self._storyRoleBlockIdList[data.blockId]
	if storyRoleId and self.rolesMap[storyRoleId] then
		local heroData = self.rolesMap[storyRoleId]
		heroData.roleId = data.id
		self.rolesMap[data.id] = heroData
		self.rolesMap[storyRoleId] = nil
		self._storyRoleBlockIdList[data.blockId] = nil
		local typeIconPath = string.format(Config.SpritePath.RoleTypeIconPathSmall, data.attribute)
		ResMgr:LoadSpriteAsyncInOwner(typeIconPath, function (s)
			UICommonUtils.HP_SetShipTypeIcon(heroData.hpObj, s)
		end, heroData.hpObj)
		if (callback) then
			callback()
		end
		if clientBattleMgr then
			clientBattleMgr:completeCreateRoleNum()
		end
		f()
	else
		local blockObj = self:getBlockObj(data.blockId)
		if (data.isShowEffect ~= false) then
			self:doShowRoleEffect(data.camp or data.storyCamp, blockObj)
		end
		PoolMgr:Get(Config.PrefabPath.BattleRole, function (battleRole)
			ResMgr:LoadGameObjectAsyncInOwner(Config.PrefabPath.HPPrefab, function(hpObj)
				ResMgr:LoadGameObjectAsyncInOwner(Config.PrefabPath.SkillIconPrefab, function(skillIconObj)
					local uiroot = UIMgr:GetUIRootParent()
					hpObj.transform:SetParent(uiroot.transform, false)
					hpObj.name = data.id .. "_HPBar"
					skillIconObj.transform:SetParent(uiroot.transform, false)
					skillIconObj.name = data.id .. "_SkillTypeIcon"
					local speakRootTrans = battleRole.transform:Find("SpeakRoot").transform
					battleRole.transform.position = blockObj.transform.position
					battleRole:SetActive(true)
					---@type RoleController
					local roleController = battleRole.transform:GetComponent("RoleController")
					local rootTrans = roleController.roleRoot
					rootTrans.localPosition = Vector3.New(0, blockObj.transform.localScale.y / 2, 0)
					speakRootTrans.localPosition = Vector3.New(0, 0.85 + blockObj.transform.localScale.y / 2, 0)
					---@type ShowManagerHeroData
					local role = {
						root = battleRole,
						model = nil,
						controller = roleController,
						rootPoint = rootTrans,
						speakPoint = speakRootTrans,
						progressiveMesh = nil,
						roleId = data.id,
						hpObj = hpObj,
						SkillIconObj = skillIconObj,
						buffToeffectObj = {},
						buffToOffset = {},
						hpBarOffset = data.hpBarOffset,
						skillTypeIconOffset = data.skillTypeIconOffset,
						moveShowType = data.moveShowType,
					}
					UICommonUtils.HP_SetHpOffset(hpObj, data.hpBarOffset)
					UICommonUtils.HP_SetSkillTypeIconOffset(skillIconObj, data.skillTypeIconOffset)
					if data.attribute then
						local typeIconPath = string.format(Config.SpritePath.RoleTypeIconPathSmall, data.attribute)
						ResMgr:LoadSpriteAsyncInOwner(typeIconPath, function (s)
							UICommonUtils.HP_SetShipTypeIcon(hpObj, s)
						end, hpObj)
					end
					local delay = data.delay or 0
					self.rolesMap[data.id] = role
					local endFun = function ()
						f()
						self:_setRoleColor(role, roleActiveColor)
						self:_DoAfter(delay, function()
							if (callback) then
								callback()
							end
							if clientBattleMgr then
								clientBattleMgr:completeCreateRoleNum()
							end
						end)
					end
					---创建角色Gameobject，此时model才会被赋值
					self:_createRoleSpine(role, data.cid, data.image, data.modelRate, data.modelOffset, rootTrans, data.direction, data.roleAction, data.isNPC, endFun)
				UICommonUtils.HP_OpenSituationIcon(hpObj, self:_isAdvantageousRoleEffect(data.cid))
					UICommonUtils.HP_OpenShipTypeIcon(hpObj, true)
					if delay > 0 then
						self:setFollowTarget(nil)
						self:lookAtBlock(data.blockId, {time = 0.5})
					end
					if data.camp == GE.BattleCampType.Enemy then
						self:addRolePosMark(data.id, battleRole)
					end
				end, battleRole)
			end, battleRole)
		end)
	end
end

---通过 cid 查找对应的 BaseRole（虚方法，战斗子类覆盖）
---@param roleCid integer
---@return BaseRole?
function BaseShowManager:_findBaseRole(roleCid)
	return nil
end

---角色是否有优势特效列表（虚方法，战斗子类覆盖）
---@param roleCid integer
---@return boolean
function BaseShowManager:_isAdvantageousRoleEffect(roleCid)
	return false
end

---释放所有资源并重置状态
function BaseShowManager:clear()
	UIMgr.CleanBaseCamera()
	self:removeAllHitTextList()
	self:removeAllEffectTextList()
	for _, role in pairs(self.rolesMap) do
		DUtil.Destroy(role.hpObj)
		DUtil.Destroy(role.SkillIconObj)
		PoolMgr.Free(role.root)
	end
	for k, _ in pairs(self.rolesDataMap) do
		DUtil.Destroy(k)
	end
	if UICommonUtils.Checkobj(self.storyRoot) then
		DUtil.Destroy(self.storyRoot)
	end
	PoolMgr:Clear()
	-- UnityEngine.Resources.UnloadUnusedAssets()
	LuaMgr.Instance:ClearMemory()
	self:reset()
end

-- 家园剧情专用清理：跳过 PoolMgr:Clear()，避免卸载仍在使用的家园角色资产
function BaseShowManager:clearForHomeStory()
	UIMgr.CleanBaseCamera()
	self:removeAllHitTextList()
	self:removeAllEffectTextList()
	for _, role in pairs(self.rolesMap) do
		DUtil.Destroy(role.hpObj)
		DUtil.Destroy(role.SkillIconObj)
		-- 必须先 Free model 再 Free root，否则 Destroy(root) 会把仍在 pool 追踪中的
		-- model 子节点一并销毁，导致下次 PoolMgr:Get 返回已销毁对象（nil）
		if role.model ~= nil then
			PoolMgr.Free(role.model.gameObject)
		end
		PoolMgr.Free(role.root)
	end
	-- rolesDataMap 中的 model 对象已通过上方 PoolMgr.Free 正确归还，无需再 Destroy
	if UICommonUtils.Checkobj(self.storyRoot) then
		DUtil.Destroy(self.storyRoot)
	end
	-- 不调用 PoolMgr:Clear() 和 LuaMgr.Instance:ClearMemory()
	-- 因为家园角色的模型资产也在 pool carrier 下，清理会导致 Mesh 为 null
	self:reset()
end

---创建角色spine
---@param role ShowManagerHeroData
---@param roleCid integer 角色cid
---@param image string
---@param modelRate number
---@param modelOffset number
---@param root UnityEngine.Transform
---@param direction RoleDirectionType
---@param roleAction RoleAnimStateType
function BaseShowManager:_createRoleSpine(role, roleCid, image, modelRate, modelOffset, root, direction, roleAction, isNPC, callBack)
	local prefabPath = string.format(Config.PrefabPath.RoleModelPrefab, image, image)
	if not isNPC then
		roleAction = RoleAnimStateType.IdleShip
	end
	PoolMgr:Get(prefabPath, function(modelObj)
		modelObj.transform.parent = root
		modelObj.transform.localPosition = Vector3.up * modelOffset
		modelObj.transform.localRotation = Quaternion.Euler(0, -134, 0)
		modelObj.transform.localScale = Vector3.one * modelRate
		role.model = modelObj.transform:GetComponent("RoleModelController")
		role.controller.modelController = role.model
		role.model:TurnDirection(direction)
		role.model:SetDefaultState(roleAction)
		role.model:SetShipVisible(false, false)
		role.model:SetShipVisible(true, true)
		-- role.model:HighQualityRenderingEnable(false)
		if not StoryMgr:getIsHomeLandStory() then
			role.controller.idleEFX:SetActive(true)
		end
		role.controller.intoEFX:SetActive(false)
		modelObj:SetActive(true)

		self.rolesDataMap[modelObj] = role

		---加载大招动画相关内容（仅战斗中存在对应角色时才加载Timeline）
		local baseRole = self:_findBaseRole(roleCid)
		local skinConfig = baseRole and baseRole.skinConfig
		if skinConfig ~= nil and skinConfig.skillTimeline ~= "" then
			---加载大招动画相关内容
			if (not role.model.timelineMgr) then
				local timeLinePath = string.format(Config.PrefabPath.SkillTimeLinePrefab, image, image)
				PoolMgr:Get(timeLinePath, function(skillTimeLineObj)
					if skillTimeLineObj then
						role.model.timelineMgr = skillTimeLineObj.transform:GetComponent("TimeLineMgr")
						role.model.timelineMgr.transform:SetParent(role.model.roleObj.transform)
						role.model.timelineMgr.transform.localPosition = Vector3.zero
						role.model.timelineMgr.transform.localRotation = Quaternion.identity
						role.model.timelineMgr.transform.localScale = Vector3.one

						for i = 0, role.model.timelineMgr.boneEffects.Length - 1 do
							if role.model.effectPoints.Length <= i then
								break
							end
							local boneEffect = role.model.timelineMgr.boneEffects[i]
							boneEffect.transform:SetParent(role.model.effectPoints[i].transform)
							boneEffect.transform.localPosition = Vector3.zero
							boneEffect.transform.localRotation = Quaternion.identity
							boneEffect.transform.localScale = Vector3.one
						end
					end
				end)
			end
		end

		if (callBack) then
			callBack()
		end
	end)
end

---控制角色显隐
---@param roleId integer
---@param isShow boolean
---@param hpIsShow boolean?
function BaseShowManager:showOrHideRole(roleId, isShow, hpIsShow)
	self:_showOrHideRole(self.rolesMap[roleId], isShow, hpIsShow)
end

---@param role ShowManagerHeroData
---@param isShow boolean
---@param hpIsShow boolean?
function BaseShowManager:_showOrHideRole(role, isShow, hpIsShow)
	if not role or not UICommonUtils.Checkobj(role.root) then
		LuaLogger.ws("BaseShowManager:_showOrHideRole role is nil")
		return
	end
	if role.hpObj then
		if hpIsShow ~= nil then
			UICommonUtils.Hp_SetUIRootActive(role.hpObj, hpIsShow)
		else
			UICommonUtils.Hp_SetUIRootActive(role.hpObj, isShow)
		end
	end
	local layer = isShow and UnityEngine.LayerMask.NameToLayer("Role") or UnityEngine.LayerMask.NameToLayer("HideRole")
	role.root.layer = layer
	local childTransforms = role.root:GetComponentsInChildren(typeof(UnityEngine.Transform), true)
	for i = 0, childTransforms.Length - 1 do
		local childLayer = childTransforms[i].gameObject.layer
		if childLayer ~= UnityEngine.LayerMask.NameToLayer("Water") then
			childTransforms[i].gameObject.layer = layer
		end
	end

	if (isShow) then
		local uiLayer = UnityEngine.LayerMask.NameToLayer("Ignore Raycast")
		role.controller.uiRoot.gameObject.layer = uiLayer
		local uiChildTransforms = role.controller.uiRoot.gameObject:GetComponentsInChildren(typeof(UnityEngine.Transform), true)
		for j = 0, uiChildTransforms.Length - 1 do
			uiChildTransforms[j].gameObject.layer = uiLayer
		end
	end
end

---角色销毁
function BaseShowManager:roleRemove(data, callback)
	local role = self:getRole(data.id)
	if role and role.model ~= nil then
		PoolMgr.Free(role.model.gameObject)
		PoolMgr.Free(role.root)
		DUtil.Destroy(role.hpObj)
		DUtil.Destroy(role.SkillIconObj)
		self:clearRoleEffectObjAll(data.id)
		self.rolesMap[data.id] = nil
		self:removeRolePosMark(data.id)
	end
	if (callback) then
		callback()
	end
end

---血条显示（战斗专用，子类覆盖；剧情中无需展示血条）
function BaseShowManager:showRoleHp(data, callback)
	if callback then callback() end
end

---刷新Buff图标（战斗专用，子类覆盖；剧情中只触发 BuffBehavior 回调）
---@param data BuffStateReportData
function BaseShowManager:refreshHeroBuffState(data, callback)
	self:BuffBehavior({ id = data.id, buffs = data.buffs }, callback)
end

---Buff行为 - 基类只做基础回调，子类可覆盖以实现完整逻辑
---@param data table
---@param callback function?
function BaseShowManager:BuffBehavior(data, callback)
	if callback then
		callback()
	end
end

---@param role ShowManagerHeroData
---@param color UnityEngine.Color
function BaseShowManager:_setRoleColor(role, color, phase)
	LuaLogger.ds("BaseShowManager:_setRoleColor", color)
	local model = role.model
	if (model) then
		model:SetFillColor(color, 0)
	end
end

---@param role ShowManagerHeroData
---@param color UnityEngine.Color
function BaseShowManager:_setRoleTintColor(role, color)
	local model = role.model
	if (model) then
		model:SetColor(color)
	end
end

function BaseShowManager:_setRoleShadowHeight(role, value)
end

------------------ 角色移动 ------------------

function BaseShowManager:roleMoveNoPath(data, callback)
	if not data then return end

	local moveTime = data.moveTime or 0.5
	local nowBlock = data.nowBlock
	local newBlock = data.newBlock
	local moveAction = data.moveAction and RoleAnimStateType[data.moveAction] or RoleAnimStateType.Into
	local stopAction = data.stopAction and RoleAnimStateType[data.stopAction] or RoleAnimStateType.IdleShip
	local noTurn = data.noTurn
	local role = self:getRole(data.roleId)
	if not role then return end
	if not self._map then return end

	local model = role.model
	if (model) then
		model:SetDefaultState(moveAction)
		if not noTurn then
			local direction = self:getFaceToBlockDirection(nowBlock, newBlock, model:GetNowDirectionType())
			model:TurnDirection(direction)
		end
	end

	local blockId = self._map:blockCidToId(data.blockCid)
	local blockObj = self:getBlockObj(blockId)
	role.root.transform:DOMove(blockObj.transform.position, moveTime):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
		if (model) then
			model:SetDefaultState(stopAction)
			role.controller.idleEFX:SetActive(true)
		end
	end)
end

function BaseShowManager:roleMoveHomeLand(data, callback)
	if not data then return end

	local moveTime = data.moveTime
	local nowBlock = data.nowBlock
	local newBlock = data.newBlock
	local moveAction = data.moveAction and RoleAnimStateType[data.moveAction] or RoleAnimStateType.Walk
	local stopAction = data.stopAction and RoleAnimStateType[data.stopAction] or RoleAnimStateType.Idle
	local noTurn = data.noTurn
	local moveZ = data.moveZ
	local role = self:getRole(data.roleId)
	if not role then return end
	if not self._map then return end

	local model = role.model
	if (model) then
		model:SetDefaultState(moveAction)
		if not noTurn then
			local nowRotation = model.transform.localEulerAngles
			local direction = self:getFaceToBlockHome(nowBlock, newBlock, nowRotation.y)
			local newRotation = Vector3.New(nowRotation.x, direction, nowRotation.z)
			model.transform:DOLocalRotate(newRotation, 0.2)
		end
	end

	local blockId = self._map:blockCidToId(data.blockCid)
	local blockObj = self:getBlockObj(blockId)
	local blockPos = blockObj.transform.position
	local newPos = Vector3.New(blockPos.x, role.root.transform.position.y + moveZ, blockPos.z)
	self.roleMoveTweenerList[data.roleId] = role.root.transform:DOMove(newPos, moveTime):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
		if (model) then
			model:SetDefaultState(stopAction)
		end
		self.roleMoveTweenerList[data.roleId] = nil
	end)
end

function BaseShowManager:getFaceToBlockDirection(block, targetBlock, nowDir)
	if (nowDir and (block == targetBlock)) then
		return nowDir
	end
	local colOffset = block.col - targetBlock.col
	local rowOffset = block.row - targetBlock.row
	local isHorizontal = math.abs(colOffset) == math.max(math.abs(colOffset), math.abs(rowOffset))
	if (isHorizontal) then
		return colOffset > 0 and GE.RoleDirectionType.Down or GE.RoleDirectionType.Up
	else
		return rowOffset > 0 and GE.RoleDirectionType.Left or GE.RoleDirectionType.Right
	end
end

function BaseShowManager:getFaceToBlockHome(block, targetBlock, nowAngle)
	if nowAngle and (block == targetBlock) then
		return nowAngle
	end
	local rowDelta = targetBlock.row - block.row
	local colDelta = targetBlock.col - block.col
	local angle = math.deg(math.atan2(rowDelta, colDelta))
	if angle < 0 then
		angle = angle + 360
	end
	return angle
end

function BaseShowManager:roleTeleport(data)
	if not self._map then return end
	local blockId = self._map:blockCidToId(data.blockCid)
	local blockObj = self:getBlockObj(blockId)
	local blockPos = blockObj.transform.position

	local role = self:getRole(data.roleId)
	if not role then return end
	if self.roleMoveTweenerList[data.roleId] then
		self.roleMoveTweenerList[data.roleId]:Complete(true)
		self.roleMoveTweenerList[data.roleId] = nil
	end
	role.root.transform.position = blockPos
end

------------------ 角色攻击 ------------------

---@param data roleAttackData
---@param callback any
function BaseShowManager:roleAttack(data, callback)
	LuaLogger.ds("BaseShowManager:roleAttack", tablex.dump(data))
	local role = self:getRole(data.id)
	if role then
		local model = role.model
		if (model) then
			local animName = data.animName or "Attack"
			model:PlayAnim(RoleModelAnimEnum[animName])
			model:SetDefaultState(RoleAnimStateType.IdleShip)
		end
		if (data.effectId) then
			local pos = model.transform.position
			local rotation = model.transform.rotation
			self:playEffect(pos, data.effectId, rotation)
		end
	end

	if (callback) then
		callback()
	end
end

---命中演出（战斗专用，子类覆盖；剧情中只保留动画/特效，跳过伤害跳字）
function BaseShowManager:justHit(data, callback, isStory)
	self:_DoAfter((data and data.dmgDelay or 0) + 1, function()
		if callback then callback() end
	end)
end

------------------ 故事相机 ------------------

function BaseShowManager:changeStoryVcam(data)
	local roleCtor = self:getRoleController(data.id)
	local BattleMainPanel = UIMgr:GetUI("BattleMainPanel")
	if (roleCtor and roleCtor.storyVcam) then
		if (data.isChange) then
			local roleRotationY = roleCtor.modelController.transform.localRotation.eulerAngles.y
			roleCtor.storyVcam.transform.localRotation = Quaternion.Euler(data.offsetRot[1], roleRotationY - 180 + data.offsetRot[2], 0)
			local virtualCamera = roleCtor.storyVcam:GetComponent(TypeInfo.CinemachineVirtualCamera)
			local framingTransposer = virtualCamera:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Body)
			framingTransposer.m_TrackedObjectOffset = Vector3.New(data.offsetPos[1], data.offsetPos[2], data.offsetPos[3])
			framingTransposer.m_CameraDistance = data.distance

			self:setStoryCMTargetGroup(data.id, data.targets)
			if BattleMainPanel then
				BattleMainPanel:hideBtnList()
			end
		else
			if BattleMainPanel then
				BattleMainPanel:openBtnList()
			end
		end
		local currentPriority = self._cinemachineBrain.ActiveVirtualCamera.Priority
		local mainPriority = self.mainVcam:GetComponent(TypeInfo.CinemachineVirtualCamera).Priority
		if data.isChange then
			roleCtor.storyVcam.Priority = self._cinemachineBrain.ActiveVirtualCamera.Priority + 1
		else
			roleCtor.storyVcam.Priority = mainPriority - 1
		end
		if (data.isChange) then
			local moveType = math.random(1, 4)
			local currentRotation = roleCtor.storyVcam.transform.localRotation.eulerAngles
			local rotationOffsets = {
				[1] = Vector3.New(5, 0, 0),
				[2] = Vector3.New(-5, 0, 0),
				[3] = Vector3.New(0, 5, 0),
				[4] = Vector3.New(0, -5, 0),
			}
			local offset = rotationOffsets[moveType] or Vector3.New(0, 0, 0)
			local newRotate = Vector3.New(
				currentRotation.x + offset.x,
				currentRotation.y + offset.y,
				currentRotation.z + offset.z
			)
			roleCtor.storyVcam.transform:DOLocalRotate(newRotate, 20):SetEase(DG.Tweening.Ease.Linear)
		end
	end
end

---设置故事镜头目标组
function BaseShowManager:setStoryCMTargetGroup(roleId, targetList)
	local role = self:getRole(roleId)
	if (role and role.controller) then
		role.controller.cmTargetGroup.m_Targets = {}
		role.controller.cmTargetGroup:AddMember(role.model.transform, 1, 0)
		for _, targetId in ipairs(targetList) do
			local target = self:getRole(targetId)
			if target then
				role.controller.cmTargetGroup:AddMember(target.model.transform, 1, 0)
			end
		end
	end
end

------------------ 相机控制 ------------------

function BaseShowManager:lookAtBlock(blockId, doTweenData, callBack, callBackProgress)
	LuaLogger.ds("BaseShowManager:lookAtBlock camera", blockId, tablex.dump(doTweenData))
	local blockObj = self:getBlockObj(blockId)
	if self.cameraTweener then
		self.cameraTweener:Kill(true)
		self.cameraTweener = nil
	end
	local isTriggered = false
	if doTweenData then
		self.cameraTweener = self.cameraRoot.transform:DOMove(Vector3.New(blockObj.transform.position.x, 0.25, blockObj.transform.position.z), doTweenData.time):SetEase(DG.Tweening.Ease.InOutQuad):OnComplete(function()
			self.cameraTweener = nil
			if not isTriggered and callBack then
				isTriggered = true
				callBack()
			end
		end):OnUpdate(function()
			self:RefreshCameraMatrix()
			if callBackProgress and not isTriggered then
				local progress = self.cameraTweener.position / self.cameraTweener:Duration()
				if progress >= callBackProgress then
					isTriggered = true
					callBack()
				end
			end
		end)
	else
		self.cameraRoot.transform.position = Vector3.New(blockObj.transform.position.x, 0.25, blockObj.transform.position.z)
		self:RefreshCameraMatrix()
		if callBack then
			callBack()
		end
	end
end

function BaseShowManager:RefreshCameraMatrix()
	self._cinemachineBrain:ManualUpdate()
end

function BaseShowManager:SetCinemachineBrainBlend()
	if self._cinemachineBrain then
		self._cinemachineBrain.m_DefaultBlend = Cinemachine.CinemachineBlendDefinition.New(
			Cinemachine.CinemachineBlendDefinition.Style.EaseInOut, 0.5)
	end
end

---移动视野
function BaseShowManager:moveCamera(currentMousePos)
	if not self._lastMousePosition then
		self._lastMousePosition = currentMousePos
		return
	end
	if not UICommonUtils.Checkobj(self.cameraRotateRoot) then
		return
	end
	local lastWorldPos = self:ScreenToGroundPoint(self._lastMousePosition)
	local currentWorldPos = self:ScreenToGroundPoint(currentMousePos)
	local pos
	if lastWorldPos and currentWorldPos then
		local worldDelta = lastWorldPos - currentWorldPos
		pos = self.cameraRoot.transform.position + worldDelta
	end
	pos.x = math.max(math.min(pos.x, self.cameraMoveBounds.xMax - 1.5), self.cameraMoveBounds.xMin - 1.5)
	pos.z = math.max(math.min(pos.z, self.cameraMoveBounds.yMax - 1.5), self.cameraMoveBounds.yMin - 1.5)
	pos.y = 0.25
	self.cameraRoot.transform.position = pos
	self:RefreshCameraMatrix()
	self._lastMousePosition = currentMousePos
end

function BaseShowManager:clearLastMousePosition()
	self._lastMousePosition = nil
end

function BaseShowManager:ScreenToGroundPoint(screenPos)
	if not self.camera then return nil end
	local viewportPos = self.camera:ScreenToViewportPoint(screenPos)
	local ray = self.camera:ViewportPointToRay(viewportPos)
	local groundPlane = Plane.New(Vector3.up, 0.25)
	local _, rayEnter = groundPlane:Raycast(ray)
	local edgePos = ray:GetPoint(rayEnter)
	return edgePos
end

function BaseShowManager:setFollowTarget(target, type)
	LuaLogger.ds("BaseShowManager:setFollowTarget type", type)
	self.followTarget = target
	self.followTargetType = type or GE.FollowTargetType.Move
end

---视野缩放
---@param scaleFactor number
---@param isTween boolean
---@param tweenTime number?
function BaseShowManager:refreshViewDistance(scaleFactor, isTween, tweenTime)
	if not tweenTime then
		tweenTime = 0.3
	end
	if not UICommonUtils.Checkobj(self.mainVcam) then
		return
	end
	local iValue = self.mainVcam.transform.localPosition.z
	if (math.abs(scaleFactor) > 0) then
		local targetValue = scaleFactor + iValue
		targetValue = math.min(targetValue, cameraMax)
		targetValue = math.max(targetValue, cameraMin)
		if targetValue > iValue + 0.01 or targetValue < iValue - 0.01 then
			if self._viewDistanceTweener then
				self._viewDistanceTweener:Kill(false)
				self._viewDistanceTweener = nil
			end
			if (isTween == true) then
				self._viewDistanceTweener = self.mainVcam.transform:DOLocalMoveZ(targetValue, tweenTime)
				self._viewDistanceTweener:SetEase(DG.Tweening.Ease.Linear)
				self._viewDistanceTweener:OnComplete(function ()
					self._viewDistanceTweener:Kill(false)
					self._viewDistanceTweener = nil
				end):OnUpdate(function ()
					self:RefreshCameraMatrix()
				end)
			else
				self.mainVcam.transform.localPosition = Vector3.New(0, 0, targetValue)
				local finalTargetValue = math.min(targetValue, cameraMax - cameraSpace)
				finalTargetValue = math.max(finalTargetValue, cameraMin + cameraSpace)
				if (finalTargetValue ~= targetValue) then
					self:refreshViewDistance(finalTargetValue - targetValue, true)
				end
				self:RefreshCameraMatrix()
			end
		end
		self.cameraViewDistance = targetValue
		self.cameraControl:SetViewDistance(-targetValue)
	end
end

---视野缩放(直接根据最终值缩放)
---@param finalValue number
---@param isTween boolean
---@param tweenTime number?
function BaseShowManager:refreshViewDistanceByFinalValue(finalValue, isTween, tweenTime)
	if (not self.mainVcam) then return end
	if not tweenTime then
		tweenTime = 0.5
	end
	local targetValue
	targetValue = math.min(finalValue, -10)
	targetValue = math.max(finalValue, -50)
	if (isTween == true) then
		self.mainVcam.transform:DOLocalMoveZ(targetValue, tweenTime):SetEase(DG.Tweening.Ease.InOutQuad)
	else
		self.mainVcam.transform.localPosition = Vector3.New(0, 0, targetValue)
	end
end

---视野旋转
---@param delta number
---@param isTween boolean
---@param tweenTime number?
function BaseShowManager:refreshViewRotat(delta, isTween, tweenTime)
	if not tweenTime then
		tweenTime = 0.3
	end
	self.cameraRotateRoot.transform:Rotate(Vector3.up, delta, UnityEngine.Space.World)
	self:RefreshCameraMatrix()
end

function BaseShowManager:refreshViewRotatByFinalValue(value)
	self.cameraRotateRoot.transform.localRotation = Quaternion.Euler(self.cameraRotateRoot.transform.localRotation.eulerAngles.x, value, 0)
	self:RefreshCameraMatrix()
end

function BaseShowManager:refreshViewHeightByFinalValue(value)
	self.cameraRotateRoot.transform.localRotation = Quaternion.Euler(value, self.cameraRotateRoot.transform.localRotation.eulerAngles.y, 0)
	self:RefreshCameraMatrix()
end

function BaseShowManager:refreshViewRotationXY(Height, Rotate, tweenTime, callBack)
	if self._viewOrientationTweener then
		self._viewOrientationTweener:Kill(false)
		self._viewOrientationTweener = nil
	end
	if tweenTime then
		self:refreshViewOrientation(Height, Rotate, tweenTime, callBack)
	else
		self:refreshViewRotatByFinalValue(Rotate)
		self:refreshViewHeightByFinalValue(Height)
	end
end

---@param pitch number?
---@param yaw number?
---@param tweenTime number?
---@param callBack function?
function BaseShowManager:refreshViewOrientation(pitch, yaw, tweenTime, callBack)
	if not self.cameraRotateRoot then return end
	local defaultTween = 1
	local duration = tweenTime or defaultTween
	local currentEuler = self.cameraRotateRoot.transform.localRotation.eulerAngles
	local targetEuler = Vector3.New(pitch or currentEuler.x, yaw or currentEuler.y, 0)
	self:showFullMask(true, true)
	self._viewOrientationTweener = self.cameraRotateRoot.transform:DOLocalRotate(targetEuler, duration, DG.Tweening.RotateMode.Fast)
		:SetEase(DG.Tweening.Ease.InOutQuad)
		:OnUpdate(function()
			self:RefreshCameraMatrix()
		end)
		:OnComplete(function()
			self._viewOrientationTweener = nil
			self:RefreshCameraMatrix()
			if callBack then
				callBack()
			end
			self:showFullMask(false, true)
		end)
end

---重置相机角度
function BaseShowManager:ResetCameraAngle(isDotween)
	local defaultType = Config.GetConfigInfo("BattleCameraType")[1]
	local xAngle = defaultType[1]
	local yAngle = self.mapAngle and self.mapAngle + defaultType[2] or defaultType[2]
	if isDotween then
		self:refreshViewRotationXY(xAngle, yAngle, 1)
	else
		self:refreshViewRotationXY(xAngle, yAngle, 0)
	end
end

---显示全屏遮罩 - 基类只提供接口，子类可覆盖以控制战斗UI
function BaseShowManager:showFullMask(isShow, onlyMask)
	if (self._uiBattleMain) then
		self._uiBattleMain.ui:showFullMask(isShow)
		if (not onlyMask) then
			self._uiBattleMain.ui:showFullMaskHideGroup(not isShow)
		end
	end
end

---相机抖动数据
---@class ShakeData
---@field frequency number
---@field amplitude number
---@field entryTime number
---@field entryCurve number
---@field decayTime number
---@field decayCurve number
---@field sustainTime number


------------------ 特效 ------------------

function BaseShowManager:playEffect(pos, id, rotation, hitResult, performanceType, buffid, roleId, parentTransform, time, onLoaded)
	if id == 0 or id == "" then
		return 0
	end
	LuaLogger.ds("BaseShowManager:playEffect", pos, id)
	local effectConfig = Config.GetSoundAndEffectInfo(id)
	if not effectConfig then
		LuaLogger.ws("特效配置不存在  ", id)
		return 0
	end
	local effectName = effectConfig.effectResource
	local lastTime = effectConfig.continuousTime
	local effectPath = string.format(Config.PrefabPath.BattleEffect, effectName, effectName)
	local isLoop = effectConfig.isLoop == 1
	if isLoop then
		self:setRoleEffectObjByBuffId(roleId, buffid)
	end
	PoolMgr:Get(effectPath, function (obj)
		if (obj) then
			LuaLogger.ds("BaseShowManager:playEffect", effectPath)
			obj.transform.position = pos
			if parentTransform then
				obj.transform:SetParent(parentTransform)
			end
			if rotation then
				obj.transform.rotation = rotation
			end
			---@type UnityEngine.ParticleSystem
			local effect1 = obj.transform:Find("Effect")
			if effect1 then
				local particle = effect1:GetComponent("ParticleSystem")
				particle:Simulate(0)
				particle:Play()
			end
			local effect2 = obj.transform:Find("Effect_2")
			if (effect2) then
				local particle2 = effect2:GetComponent("ParticleSystem")
				particle2:Simulate(0)
				particle2:Play()
			end
			if onLoaded then
				onLoaded(obj)
			end
			local isLoop = effectConfig.isLoop == 1
			if isLoop then
				local role = self:getRole(roleId)
				obj:SetParent(role.model.transform)
				self:setRoleEffectObjByBuffId(roleId, buffid, obj)
			else
				self:_DoAfter(time or 2, function()
					obj:SetParent(PoolMgr.objRoot.transform)
					PoolMgr.Free(obj)
				end)
			end
		end
	end)
	local soundName = effectConfig.SoundResource
	local soundPath = string.format(Config.AudioPath.SE, soundName)
	if soundName and soundName ~= "" then
		self:_DoAfter(effectConfig.delay, function()
			self:play2DSound(soundPath)
		end)
	end
	if tablex.size(effectConfig.shakeEffect) > 0 then
		local entryData = effectConfig.shakeEntry
		local decayData = effectConfig.shakeDecay
		local sustain = effectConfig.shakeSustain
		ResMgr:LoadCurveLibraryAsyncInOwner(Config.AssetFile.CurveLibrary, function(lib)
			---@type ShakeData
			local data = {
				frequency = effectConfig.shakeEffect[1],
				amplitude = effectConfig.shakeEffect[2],
				entryCurve = lib:GetCurve(entryData[1] ~= "" and entryData[1] or "BattleDefaultShakeEntry"),
				entryTime = entryData[2] or 0.3,
				decayCurve = lib:GetCurve(decayData[1] ~= "" and decayData[1] or "BattleDefaultShakeDecay"),
				decayTime = decayData[2] or 0.3,
				sustainTime = sustain or 0.3,
			}
			self:ShakeCameraByDmg(hitResult, performanceType, data)
		end, ResMgr:GetResCarrier())
	end
	return lastTime
end


---移除所有角色
function BaseShowManager:_removeAllRole()
	self:removeAllRolePosMark()
	for _, role in pairs(self.rolesMap) do
		PoolMgr.Free(role.model.gameObject)
		PoolMgr.Free(role.root)
		DUtil.Destroy(role.hpObj)
		DUtil.Destroy(role.SkillIconObj)
		self:clearRoleEffectObjAll(role.roleId)
	end
end

---@param roleId integer
---@param roleObj UnityEngine.GameObject
function BaseShowManager:addRolePosMark(roleId, roleObj)
	if self._markDataDic[roleId] then
		return
	end
	---@type MarkData
	local markData = {
		GetHeadPosition = function()
			local rolePos = roleObj.transform.position
			rolePos.y = rolePos.y + 0.85
			return rolePos
		end,
		GetHeadIconPath = function()
			return "Sprite/homemoods/battle_img_bossicon.png"
		end,
		showInScreen = false,
	}
	if self._uiBattleMain then
		local camera = self.camera
		self._markDataDic[roleId] = markData
		self._uiBattleMain.ui:addRolePosMark(markData, camera, 1)
	else
		self._waitShowMarkList[roleId] = markData
	end
	LuaLogger.ds("BaseShowManager:showWaitAddMark 显示等待添加的标记", tablex.dump(self._markDataDic))
end

function BaseShowManager:showWaitAddMark()
	if self._uiBattleMain then
		local camera = self.camera
		for roleId, markData in pairs(self._waitShowMarkList) do
			self._markDataDic[roleId] = markData
			self._uiBattleMain.ui:addRolePosMark(markData, camera, 1)
		end
		self._waitShowMarkList = {}
	end
end

---@param roleId integer
function BaseShowManager:removeRolePosMark(roleId)
	local markData = self._markDataDic[roleId]
	if markData and self._uiBattleMain then
		self._uiBattleMain.ui:removeRolePosMark(markData)
		self._markDataDic[roleId] = nil
	end
	self._waitShowMarkList[roleId] = nil
end

function BaseShowManager:removeAllRolePosMark()
	if self._uiBattleMain then
		for _, markData in pairs(self._markDataDic) do
			self._uiBattleMain.ui:removeRolePosMark(markData)
		end
	end
	self._markDataDic = {}
	self._waitShowMarkList = {}
end

------------------ 工具方法 ------------------

function BaseShowManager:_DoAfter(time, event)
	if (time <= 0) then
		if (event and self.levelLoaded) then
			event()
		end
		return nil
	end
	return DLuaTimer:DoAfter(time/Time.timeScale, function()
		if (event and self.levelLoaded) then
			event()
		end
	end)
end

function BaseShowManager:_DoRepeat(interval, times, event)
	DLuaTimer:DoRepeat(interval, times, function ()
		if (event and self.levelLoaded) then
			event()
		end
	end)
end

function BaseShowManager:play2DSound(audioPath, volume, loopTime, callBack, track, fadeTime, fadeEase)
	local ret = LuaMain:play2DSound(audioPath, volume, loopTime, callBack, track, fadeTime, fadeEase)
	return ret
end

function BaseShowManager:play2DVoice(audioPath, volume, loopTime, callBack, track, fadeTime, fadeEase)
	local ret = LuaMain:play2DVoice(audioPath, volume, loopTime, callBack, track, fadeTime, fadeEase)
	return ret
end

--编辑器下显示地图格子cid
function BaseShowManager:showMapBlockCidEditor(blocks)
	if GV.IsEditor and StoryMgr:getIsHomeLandStory() then
		ResMgr:LoadPrefabAsyncInOwner(Config.PrefabPath.MapCubeTxt, function (cubeTxt)
			for index, block in pairs(blocks) do
				local txtObj = Instantiate(cubeTxt).gameObject
				txtObj.transform:SetParent(self.blocksObjMap[block.id].transform)
				txtObj.transform.localPosition = Vector3.up * 0.5
				txtObj.transform.localScale = Vector3.one
				txtObj:GetComponent("TextMeshPro").text = block.cid
			end
		end, self.storyRoot.gameObject)
	end
end

return BaseShowManager
