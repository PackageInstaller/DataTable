---@class SeaMapMgr 海图管理类
local SeaMapMgr = class("SeaMapMgr")

function SeaMapMgr:ctor()
	---@type UnityEngine.Transform
	self.seaMapRoot = nil
	---@type UnityEngine.Transform
	self.cameraRoot = nil
	---@type UnityEngine.Transform
	self.cameraRotateRoot = nil
	---@type UnityEngine.GameObject
	self.cameraObj = nil
	---@type UnityEngine.Camera
	self.camera = nil

	---@type boolean
	self._isDragging = false
	---@type Vector3
	self._initialPosition = nil
	---@type Vector3
	self._lastMousePosition = nil
	---@type number
	self._clickThreshold = 30

	---@type UnityEngine.GameObject
	self.seaMapBg = nil --海图地图
	---@type table
	self.seaMapBoxList = {}
	---@type table
	self.levelBoxList = nil
	---@type Vector3
	self.PlayerPoint = nil

	---@type UnityEngine.GameObject
	self.model = nil
	---@type boolean
	self.isMove = false
	---@type UnityEngine.GameObject
	self.nowOpenObj = nil --当前可战斗的最后一个的关卡预制体
	--self:reset()
	---@type number
	self.nowMaterialDeepType = nil

	---@type UnityEngine.GameObject
	self.MapPoint = nil
	self.seaMapBoxDifficultList = {}
	self.ChapterConfig = {}
	self.ChapterDifficultConfig = {}
	self.nowSelectLevel = nil
	self.nowChapterId = 0       --当前章节ID
	self.nowChapterDifficultId = 0 --当前章节困难
	self.nowMode = 1            --当前模式 1 普通模式 2 困难模式
	self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
	self.lastMode = nil         --上次进入的模式
	self.lastChapterId = nil    --上次进入的章节ID
	self.nowWeeklyBossIndex = 1 --当前周常boss索引

	---@type table  key=终点关卡ID, value={lineRenderer, startPoint, endPoint}
	self._lineRendererMap = {}
	---@type table  key=起点关卡ID, value=list of {lineRenderer, startPoint, endPoint}
	self._lineRendererStartMap = {}
	---@type table  正在播放的线条绘制动画列表
	self._lineAnimList = {}
	---@type number 连接线两端的缩进比例（0~0.5），0.1 = 从两端各缩进 10% 的线段长度，可外部赋值调整
	self.pointLineOffset = 0.2
	---@type number 画线动画完成后，ObjIsOn/UIRoot 延迟显示的秒数
	self.nodeShowDelay = 0.3
	---@type boolean 是否正在播放开图动画（期间禁止点击和拖拽）
	self._isPlayingAnim = false
	---@type UnityEngine.GameObject 当前章节的地形模型（池化对象，Close时需归还）
	self.seaMapObj = nil
end

--- 将 SeaMapMgr 创建的所有池化对象归还到对象池
--- 必须在 GameObject.Destroy(seaMapRoot) 之前调用，否则对象被直接销毁而绕过池
function SeaMapMgr:FreeAllPooledObjects()
	-- 先归还连接线（节点归还后其 Transform 引用可能失效，且已销毁的 LineRenderer 在 Lua 中仍可能为真值）
	if self._lineRendererMap then
		local freedSet = {}
		for _, entry in pairs(self._lineRendererMap) do
			local lineRenderer = entry and entry.lineRenderer
			if lineRenderer and not IsNull(lineRenderer) then
				local go = lineRenderer.gameObject
				if go and not IsNull(go) and not freedSet[go] then
					freedSet[go] = true
					PoolMgr.Free(go)
				end
			end
		end
	end
	-- 归还普通关卡节点（其子节点雕像随之进入池）
	if self.seaMapBoxList then
		for _, value in pairs(self.seaMapBoxList) do
			if value.obj and not IsNull(value.obj) then
				PoolMgr.Free(value.obj)
			end
		end
	end
	-- 归还困难关卡节点
	if self.seaMapBoxDifficultList then
		for _, value in pairs(self.seaMapBoxDifficultList) do
			if value.obj and not IsNull(value.obj) then
				PoolMgr.Free(value.obj)
			end
		end
	end
	-- 归还地形模型
	if self.seaMapObj and not IsNull(self.seaMapObj) then
		PoolMgr.Free(self.seaMapObj)
		self.seaMapObj = nil
	end
	self._lineRendererMap = {}
	self._lineRendererStartMap = {}
end

function SeaMapMgr:Clear()
	self:reset()
	self.isClose = true
end

---实例化
---@return SeaMapMgr
function SeaMapMgr:instance()
	if (self._instance == nil) then
		self._instance = self:new()
	end
	return self._instance
end

function SeaMapMgr:reset()
	self.seaMapRoot = nil
	self.cameraRoot = nil
	self.cameraRotateRoot = nil
	self.cameraObj = nil
	self.camera = nil

	self._isDragging = false
	self._initialPosition = nil
	self._lastMousePosition = nil
	self._clickThreshold = 30

	self.seaMapBg = nil --海图地图
	self.seaMapBoxList = {}
	self.seaMapBoxDifficultList = {}
	self.levelBoxList = nil
	self.levelBoxDifficultList = nil
	self.PlayerPoint = nil
	self.MapPoint = nil

	self.model = nil
	self.isMove = false
	self.nowOpenObj = nil --当前可战斗的最后一个的关卡预制体
	self.ChapterConfig = {}
	self.ChapterDifficultConfig = {}

	self.nowChapterId = 0       --当前章节ID
	self.nowChapterDifficultId = 0 --当前章节困难
	self.nowSelectLevel = nil
	self.nowMode = 1            --当前模式 1 普通模式 2 困难模式
	self._lineRendererMap = {}
	self._lineRendererStartMap = {}
	self._lineAnimList = {}
	self.pointLineOffset = 0.2 --线段两边缩短的间距
	self.nodeShowDelay = 0.3 --延迟显示模型和UI
	self._isPlayingAnim = false
	self.seaMapObj = nil
end

function SeaMapMgr:setLastMode(mode)
	self.lastMode = mode
end

function SeaMapMgr:getLastMode()
	return self.lastMode
end

function SeaMapMgr:resetLastMode()
	self.lastMode = nil
	self.lastChapterId = nil
end

function SeaMapMgr:InitUiPos()
	self.isClose = false
	self.seaMapRoot = GameObject.Find("SeaMapRoot")
	self.nowChapterId = ClientData:GetNowSelectChatperId()
	if self:getLastMode() ~= nil and self.nowChapterId == self.lastChapterId then
		self.nowMode = self:getLastMode()
	end

	if self.seaMapRoot then
		self.cameraObj = self.seaMapRoot.Find("SeaMapCamera").gameObject
		self.camera = self.cameraObj:GetComponent("Camera")
		UIMgr.SetBaseCamera(self.camera)
		self.levelBoxList = self.seaMapRoot.Find("LevelBoxList")
		self.levelBoxDifficultList = self.seaMapRoot.Find("LevelBoxDifficultList")
		self.PlayerPoint = self.seaMapRoot.Find("PlayerPoint").gameObject
		self.MapPoint = self.seaMapRoot.Find("MapPoint").gameObject
		self:CreateMap()
		--self:CreateRole()--需求更改，不生成角色
	end
end

--- 地图连线前置关卡是否已通过（ChapterTable.PveLevel 第 6 项）
---@param config table
---@return boolean
function SeaMapMgr:_isLevelLastOpen(config)
	if config[6] == 0 then
		return true
	end
	return Me:getLevelIsPassed(config[6])
end

--- 是否为章节入口节点（地图无前置连线，不参与开图动画）
---@param config table
---@return boolean
function SeaMapMgr:_isChapterEntryNode(config)
	return config[6] == 0
end

--- 当前模式下是否需要在开图动画前隐藏该节点
---@param levelId number
---@param config table
---@param modeIndex number
---@return boolean
function SeaMapMgr:_willHideForUnlockAnim(levelId, config, modeIndex)
	if self.nowMode ~= modeIndex then
		return false
	end
	-- 章节入口节点无前置连线，直接显示，不播放出现动画
	if self:_isChapterEntryNode(config) then
		return false
	end
	return Me:getLevelIsUnLock(levelId)
		and self:_isLevelLastOpen(config)
		and not Me:getLevelDataByid(levelId)
		and not MyPrefs:GetBool("SeaMapAnim_" .. tostring(levelId))
end

--- 关卡节点是否应在地图上可见
---@param levelId number
---@param config table
---@param modeIndex number
---@return boolean
function SeaMapMgr:_shouldShowLevelNode(levelId, config, modeIndex)
	if not Me:getLevelIsUnLock(levelId) or not self:_isLevelLastOpen(config) then
		return false
	end
	if self:_willHideForUnlockAnim(levelId, config, modeIndex) then
		return false
	end
	return true
end

--- 批量更新指定模式关卡节点的显隐
---@param boxList table
---@param modeIndex number
function SeaMapMgr:_updateLevelNodeVisibility(boxList, modeIndex)
	if not boxList then
		return
	end
	for levelId, value in pairs(boxList) do
		if value.obj then
			value.obj:SetActive(self:_shouldShowLevelNode(levelId, value.config, modeIndex))
		end
	end
end

--- 开图动画失败时的兜底：直接显示节点
---@param levelId number
---@param modeIndex number|nil
function SeaMapMgr:_showLevelNodeFallback(levelId, modeIndex)
	modeIndex = modeIndex or self.nowMode
	local boxList = modeIndex == 2 and self.seaMapBoxDifficultList or self.seaMapBoxList
	local value = boxList and boxList[levelId]
	if not value or not value.obj then
		return
	end
	if Me:getLevelIsUnLock(levelId) and self:_isLevelLastOpen(value.config) then
		value.obj:SetActive(true)
		local objPoint = value.obj.transform:Find("ObjPoint")
		if objPoint then
			objPoint.gameObject:SetActive(true)
		end
	end
end

--- 等待线段就绪后播放开图动画；失败则兜底显示节点
---@param retryCount number
---@param duration number|nil
---@param onComplete function|nil
function SeaMapMgr:_tryPlayNewUnlockedLevelAnims(retryCount, duration, onComplete)
	local modeIndex = self.nowMode
	local boxList = modeIndex == 2 and self.seaMapBoxDifficultList or self.seaMapBoxList
	if not boxList then
		if onComplete then onComplete() end
		return
	end

	local newLevelIds = {}
	for levelId, value in pairs(boxList) do
		if value.obj and self:_willHideForUnlockAnim(levelId, value.config, modeIndex) then
			table.insert(newLevelIds, levelId)
		end
	end

	if #newLevelIds == 0 then
		self:_updateLevelNodeVisibility(boxList, modeIndex)
		if onComplete then onComplete() end
		return
	end

	local allReady = true
	for _, levelId in ipairs(newLevelIds) do
		if not self._lineRendererMap[levelId] then
			allReady = false
			break
		end
	end

	if not allReady and retryCount < 15 then
		DLuaTimer:DoAfter(0.2, function()
			self:_tryPlayNewUnlockedLevelAnims(retryCount + 1, duration, onComplete)
		end)
		return
	end

	if not allReady then
		for _, levelId in ipairs(newLevelIds) do
			self:_showLevelNodeFallback(levelId, modeIndex)
			MyPrefs:SetBool("SeaMapAnim_" .. tostring(levelId), true)
		end
		if onComplete then onComplete() end
		return
	end

	self:PlayLevelLineAnimQueue(newLevelIds, duration, function()
		self:_updateLevelNodeVisibility(boxList, modeIndex)
		if onComplete then onComplete() end
	end)
end

---刷新地图显示
---重新获取最新数据并刷新节点的显示状态，供外部调用
function SeaMapMgr:Refresh()
	-- 更新普通模式节点的显隐状态（仅当前模式预隐藏开图动画节点）
	if self.seaMapBoxList and next(self.seaMapBoxList) then
		self:_updateLevelNodeVisibility(self.seaMapBoxList, 1)
		self:setBoxView(1)
	end

	-- 更新困难模式节点的显隐状态
	if self.seaMapBoxDifficultList and next(self.seaMapBoxDifficultList) then
		self:_updateLevelNodeVisibility(self.seaMapBoxDifficultList, 2)
		self:setBoxView(2)
	end

	self:FindLastLevel(self.nowMode)
	-- setBoxView 内部 LoadGameObjectAsync 是异步的，等线段就绪后再播放开图动画
	DLuaTimer:DoAfter(0.5, function()
		self:_tryPlayNewUnlockedLevelAnims(0)
	end)
end

--地图生成
function SeaMapMgr:CreateMap()
	local rootTransform = UIMgr:GetUICanvasRoot():GetComponent("RectTransform")
	local screen_width = rootTransform.rect.width
	local screen_height = rootTransform.rect.height

	-- 参考分辨率，1920x1080 下预设是最合适的
	local refWidth, refHeight = 1920, 1080
	-- 使用宽高缩放的平均比例来适配横向边界
	local scaleX = screen_width / refWidth
	local scaleY = screen_height / refHeight
	local scale = (scaleX + scaleY) * 0.5
	--TODO: 现在普通和困难都是这个字段
	self.nowChapterId = ClientData:GetNowSelectChatperId()
	self.ChapterConfig = Config.GetChapterInfo(self.nowChapterId)


	self.lastChapterId = self.nowChapterId
	-- 生成对应的地图，设置初始位置
	ResMgr:LoadGameObjectAsyncInOwner(string.format(Config.PrefabPath.SeaMapModePath, self.ChapterConfig.mapTemplate),
		function(seaMap)
			local seaMapObj = seaMap
			self.seaMapObj = seaMapObj -- 保存引用，供 FreeAllPooledObjects 归还到池
			seaMapObj.transform:SetParent(self.MapPoint.transform)
			seaMapObj.transform.localPosition = Vector3.zero
			seaMapObj.transform.localRotation = Quaternion.Euler(-90, 0, 0)
			seaMapObj.transform.localScale = Vector3.one
			seaMapObj:SetActive(true)
			--地表材质挂载
			self.seaMapBg = self.seaMapRoot.Find("GroundImg"):GetComponent("MeshRenderer")
			ResMgr:LoadMaterialAsyncInOwner(string.format(Config.MaterialPath.SeaMapBgPath, self.ChapterConfig.MapBG),
				function(mat)
					self.seaMapBg.material = mat
				end, self.seaMapBg.gameObject)
		end, self.MapPoint.gameObject)
	local origBoundary = Config.SeaMapBoundary[self.ChapterConfig and self.ChapterConfig.mapTemplate] or
	Config.SeaMapBoundary[2]

	self.mapBoundary = {
		left = origBoundary.left * scale,
		right = origBoundary.right * scale,
	}
	--初始化地图边界位置
	self.MapPoint.transform.localPosition = Vector3.New(self.mapBoundary.left, 0, 0) -- 获取该模式的左边缘 这个位置根据最后一个可以进行的关卡位置进行改变

	--生成关卡节点
	if self.ChapterConfig.Type == GE.ChapterType.MainDifficult then
		self:CreateDiffcultMap()
	else
		self:CreateStoryMap()
	end

	self.levelBoxList:SetActive(self.nowMode == 1)       --如果是普通模式则显示普通节点
	self.levelBoxDifficultList:SetActive(self.nowMode == 2) --如果是困难模式则显示困难节点
	self:setLastMode(self.nowMode)
end

---创建普通地图
function SeaMapMgr:CreateStoryMap()
	local levelList = self.ChapterConfig.PveLevel
	self.seaMapBoxList = {}
	for key, value in pairs(levelList) do
		ResMgr:LoadGameObjectAsyncInOwner(Config.PrefabPath.SeaMapBox, function(seaMapBox)
			local seaMapBoxObj = seaMapBox
			seaMapBoxObj.transform:SetParent(self.levelBoxList.transform)
			seaMapBoxObj.name = value[1]
			seaMapBoxObj.transform.localPosition = Vector3.New(value[2][1], 0, value[2][2])
			seaMapBoxObj.gameObject:GetComponent("PointEvent").EventId = value[1]
			seaMapBoxObj:SetActive(self:_shouldShowLevelNode(value[1], value, 1))
			local temp = {
				obj = seaMapBoxObj,
				config = value,
			}
			self.seaMapBoxList[value[1]] = temp
			if tablex.size(self.seaMapBoxList) == tablex.size(levelList) then
				self:setBoxView(1)
				--先功能解锁再引导
				local unWatchList = UICommonUtils.GetUnwatchedLevelList()
				if tablex.size(unWatchList) > 0 then
					UIMgr:popUICover("FunctionOpenTips", {
						finishCallback = function()
							GuideMgr:StartGuideTrigger("LevelMapPanel")
						end,
						type = { 1 }
					})
				else
					GuideMgr:StartGuideTrigger("LevelMapPanel")
				end
			end
		end, self.levelBoxList.gameObject)
	end
end

--创建困难地图（如果有
function SeaMapMgr:CreateDiffcultMap()
	--生成对应难度的地图
	self.nowChapterDifficultId = self.ChapterConfig.id
	self.ChapterDifficultConfig = Config.GetChapterInfo(self.nowChapterDifficultId)

	--生成地图节点
	self.seaMapBoxDifficultList = {}
	for key, value in pairs(self.ChapterDifficultConfig.PveLevel) do
		ResMgr:LoadGameObjectAsyncInOwner(Config.PrefabPath.SeaMapBox, function(seaMapBox)
			local seaMapBoxObj = seaMapBox
			seaMapBoxObj.transform:SetParent(self.levelBoxDifficultList.transform)
			seaMapBoxObj.name = value[1]
			seaMapBoxObj.transform.localPosition = Vector3.New(value[2][1], 0, value[2][2])
			seaMapBoxObj.gameObject:GetComponent("PointEvent").EventId = value[1]
			seaMapBoxObj:SetActive(self:_shouldShowLevelNode(value[1], value, 2))
			local temp = {
				obj = seaMapBoxObj,
				config = value,
			}
			self.seaMapBoxDifficultList[value[1]] = temp
			if tablex.size(self.seaMapBoxDifficultList) == tablex.size(self.ChapterDifficultConfig.PveLevel) then
				self:setBoxView(2)
				local unWatchList = UICommonUtils.GetUnwatchedLevelList()
				if tablex.size(unWatchList) > 0 then
					UIMgr:popUICover("FunctionOpenTips", {
						finishCallback = function()
							GuideMgr:StartGuideTrigger("LevelMapPanel")
						end,
						type = { 1 }
					})
				else
					GuideMgr:StartGuideTrigger("LevelMapPanel")
				end
			end
		end, self.levelBoxDifficultList.gameObject)
	end
end

--普通困难切换
---@param modeIndex number 模式索引 1 普通模式 2 困难模式
function SeaMapMgr:ModeChange(modeIndex)
	if modeIndex == self.nowMode then
		return
	end
	self.nowMode = modeIndex
	self:SetNodeSelectState(nil, self.nowMode)
	if self.levelBoxList then
		self.levelBoxList:SetActive(self.nowMode == 1) --如果是普通模式则显示普通节点
	end

	if self.levelBoxDifficultList then
		self.levelBoxDifficultList:SetActive(self.nowMode == 2) --如果是困难模式则显示困难节点
	end
	self:FindLastLevel(self.nowMode)
	self:setLastMode(self.nowMode)
	local boxList = self.nowMode == 2 and self.seaMapBoxDifficultList or self.seaMapBoxList
	if boxList then
		self:_updateLevelNodeVisibility(boxList, self.nowMode)
	end
	DLuaTimer:DoAfter(0.5, function()
		self:_tryPlayNewUnlockedLevelAnims(0)
	end)
	-- local matPath = nil
	-- if self.nowMode == 1 then
	-- 	matPath = self.ChapterConfig.MapBG
	-- elseif self.nowMode == 2 then
	-- 	matPath = self.ChapterDifficultConfig.MapBG
	-- end
	-- AssetManager.Instance:LoadMaterialAsync(string.format(Config.MaterialPath.SeaMapBgPath, matPath), function(mat)
	-- 	self.seaMapBg.material = mat
	-- end)
end

--设置关卡节点状态
---@param modeIndex number 模式索引 1 普通模式 2 困难模式
function SeaMapMgr:setBoxView(modeIndex)
	--根据模式，设置对应的节点显示
	local boxList, boxParent, config, isNormalMode, starList
	if modeIndex == 2 then
		boxList = self.seaMapBoxDifficultList
		boxParent = self.levelBoxDifficultList
		config = self.ChapterDifficultConfig
		isNormalMode = false
	elseif modeIndex == 1 then
		boxList = self.seaMapBoxList
		boxParent = self.levelBoxList
		config = self.ChapterConfig
		isNormalMode = true
	end

	for _, value in pairs(boxList) do
		local levelConfig = Config.GetPveLevelInfo(value.config[1])
		local levelData = Me:getLevelDataByid(value.config[1])

		local seaMapBoxObj = value.obj.transform
		local _asyncLoading = false
		local ObjPoint = seaMapBoxObj:Find("ObjPoint")
		local uiRoot = ObjPoint:Find("UIRoot")
		local uiCanvas = uiRoot:Find("UICanvas")

		local battleLevel = uiCanvas:Find("BattleLevel")
		local storyLevel = uiCanvas:Find("StoryLevel")
		local nameBg = uiCanvas:Find("NameBg")
		local Effect = seaMapBoxObj:Find("Effect")
		local HardEffect = seaMapBoxObj:Find("HardEffect")
		local OnceEffect = seaMapBoxObj:Find("OnceEffect")
		local OnceFinishEffect = seaMapBoxObj:Find("OnceFinishEffect")
		local OnceFinishEffectHard = seaMapBoxObj:Find("OnceFinishEffectHard")
		local OpenEffect = seaMapBoxObj:Find("OpenEffect")

		local simplePanel = battleLevel:Find("SimplePanel")
		local DifficultyPanel = battleLevel:Find("DifficultyPanel")

		simplePanel.gameObject:SetActive(isNormalMode)
		DifficultyPanel.gameObject:SetActive(not isNormalMode)

		local panel = isNormalMode and simplePanel or DifficultyPanel
		local specialPoint = panel:Find("SpecialPoint")

		battleLevel.gameObject:SetActive(levelConfig.type ~= GE.LevelType.Story and
		value.config[4] ~= GE.LevelPointType.Once)
		storyLevel.gameObject:SetActive(levelConfig.type == GE.LevelType.Story and
		value.config[4] ~= GE.LevelPointType.Once)
		Effect.gameObject:SetActive(value.config[4] ~= GE.LevelPointType.Once)

		if levelConfig.type ~= GE.LevelType.Story then
			if next(levelConfig.achieve) ~= nil then
				specialPoint.gameObject:SetActive(true)
			else
				specialPoint.gameObject:SetActive(false)
			end
			starList = panel:Find("StarList")
			local levelName = panel:Find("levelName"):GetComponent(TypeInfo.TextMeshProUGUI)
			starList.gameObject:SetActive(levelConfig.type == GE.LevelType.Battle and levelConfig.baseStar > 0)
			levelName.text = levelConfig.title
			nameBg.gameObject:SetActive(value.config[4] ~= GE.LevelPointType.Once)
			levelName.gameObject:SetActive(value.config[4] ~= GE.LevelPointType.Once)

			--节点星星和隐藏奖励的显示
			if levelData then
				for i = 1, 3 do
					local isOn = starList:Find("star" .. i):Find("isOn")
					isOn.gameObject:SetActive(i <= levelData.star)
				end
				local specialPointIsOn = panel:Find("SpecialPoint"):Find("isOn")
				specialPointIsOn.gameObject:SetActive(levelData.achieveList and
				tablex.size(levelData.achieveList) == tablex.size(levelConfig.achieve))
			end

			--节点雕像 --根据完成状态切换动画即可
			if value.config[4] ~= GE.LevelPointType.Once then
				local objName = value.config[3]
				local objPath = string.format(Config.PrefabPath.SeaMapObjPath, objName)
				-- 检查模型是否已存在，避免 Refresh() 重复调用时重复加载导致内存堆积
				local parentPointCheck = ObjPoint:Find("ObjIsOn")
				local existingModel = parentPointCheck and parentPointCheck:Find(objName)
				if existingModel then
					-- 模型已存在，仅更新动画状态
					local rmCtrl = existingModel.gameObject:GetComponent("RoleModelController")
					if rmCtrl then
						if levelData and levelData.state == GE.LevelStateType.Finish then
							rmCtrl:SetDefaultState(RoleAnimStateType.Zhanbai)
						else
							rmCtrl:SetDefaultState(RoleAnimStateType.Idle)
						end
					end
				else
					_asyncLoading = true
					ResMgr:LoadGameObjectAsyncInOwner(objPath, function(LevelStatuePrefab)
						local ObjLevelStatue = LevelStatuePrefab
						if ObjLevelStatue then
							ObjLevelStatue.name = objName
							local parentPoint = ObjPoint:Find("ObjIsOn")
							local rmCtrl = ObjLevelStatue:GetComponent("RoleModelController")
							--获取动画组件 根据状态播放不同动画
							if rmCtrl then
								if levelData and levelData.state == GE.LevelStateType.Finish then
									rmCtrl:SetDefaultState(RoleAnimStateType.Zhanbai)
								else
									rmCtrl:SetDefaultState(RoleAnimStateType.Idle)
								end
							end
							ObjLevelStatue.transform:SetParent(parentPoint)
							ObjLevelStatue.transform.localScale = Vector3.one
							ObjLevelStatue.transform.localPosition = Vector3.zero
							ObjLevelStatue.transform.localRotation = Quaternion.Euler(0, 0, 0)
							ObjPoint.gameObject:SetActive(true)
						end
					end, seaMapBoxObj.gameObject)
				end
			end
		else
			local levelName = storyLevel:Find("levelName"):GetComponent(TypeInfo.TextMeshProUGUI)
			levelName.text = levelConfig.title
			nameBg.gameObject:SetActive(false)
		end

		if value.config[4] == GE.LevelPointType.Once then
			local panelOnce = isNormalMode and simplePanel or DifficultyPanel
			local starList = panelOnce:Find("StarList")
			nameBg.gameObject:SetActive(false)
			starList.gameObject:SetActive(false)

			if modeIndex == 2 then
				OnceFinishEffectHard.gameObject:SetActive(true)
				OnceEffect.gameObject:SetActive(false)
			else
				if levelData and levelData.state == GE.LevelStateType.Finish then
					OnceFinishEffect.gameObject:SetActive(true)
					OnceEffect.gameObject:SetActive(false)
				else
					OnceFinishEffect.gameObject:SetActive(false)
					OnceEffect.gameObject:SetActive(true)
				end
			end
		end

		if modeIndex == 2 and levelConfig.type == GE.LevelType.Story then
			OnceFinishEffect.gameObject:SetActive(true)
			OnceEffect.gameObject:SetActive(false)
			storyLevel.gameObject:SetActive(false)
			Effect.gameObject:SetActive(false)
		end

		local lastOpen = value.config[6] == 0
		if value.config[6] ~= 0 then
			lastOpen = Me:getLevelIsPassed(value.config[6])
		end

		local levelFinished = Me:getLevelIsPassed(value.config[1])
		if lastOpen and levelFinished then
			--画线逻辑
			local nextLevelList = {}
			for _, levelValue in pairs(value.config[5]) do
				table.insert(nextLevelList, boxList[levelValue])
			end

			if next(nextLevelList) then
				local lineType = isNormalMode and Config.DegreeOfDifficulty.PointLineSimple or
				Config.DegreeOfDifficulty.PointLineDifficulty
				local PointLinePrefabPath = string.format(Config.PrefabPath.SeaMapObjPath, lineType)
				for _, nextLevelValue in pairs(nextLevelList) do
					-- 检查线条是否已存在，避免 Refresh() 重复调用时重复创建导致内存堆积
					if self._lineRendererMap[nextLevelValue.config[1]] then
						-- 线条已存在，仅更新激活状态
						local existingEntry = self._lineRendererMap[nextLevelValue.config[1]]
						local lineOn = Me:getLevelIsUnLock(nextLevelValue.config[1])
						if existingEntry.lineRenderer and existingEntry.lineRenderer.gameObject then
							existingEntry.lineRenderer.gameObject:SetActive(lineOn)
						end
					else
						ResMgr:LoadGameObjectAsyncInOwner(PointLinePrefabPath, function(PointLinePrefab)
							local ObjPointLine = PointLinePrefab
							if ObjPointLine then
								ObjPointLine.name = lineType .. value.config[1] .. "_" .. nextLevelValue.config[1]
								ObjPointLine.transform:SetParent(boxParent.transform)
								ObjPointLine.transform.localScale = Vector3.one
								ObjPointLine.transform.localPosition = Vector3.New(0, 0.05, 0)
								ObjPointLine.transform.localRotation = Quaternion.Euler(0, 0, 0)

								local lineRenderer = ObjPointLine.gameObject:GetComponent("LineRenderer")
								local currPos = Vector3.New(value.config[2][1], 0, value.config[2][2])
								local nextPos = Vector3.New(nextLevelValue.config[2][1], 0, nextLevelValue.config[2][2])
								local direction = nextPos - currPos
								local normaliedDirection = direction.normalized
								local offsetDist = direction.magnitude * self.pointLineOffset
								local startPoint = currPos + normaliedDirection * offsetDist
								local endPoint = nextPos - normaliedDirection * offsetDist
								lineRenderer:SetPosition(0, startPoint)
								lineRenderer:SetPosition(1, endPoint)
								-- 存储终点节点元数据，供播放完成后显示特效使用
								local nextLevelConfig = Config.GetPveLevelInfo(nextLevelValue.config[1])
								local endEntry = {
									lineRenderer    = lineRenderer,
									startPoint      = startPoint,
									endPoint        = endPoint,
									endObjTransform = nextLevelValue.obj.transform,
									endLevelId      = nextLevelValue.config[1],
									endIsNormalMode = isNormalMode,
									endIsOnce       = nextLevelValue.config[4] == GE.LevelPointType.Once,
									endIsStory      = nextLevelConfig.type == GE.LevelType.Story,
									endOpenEffect   = nextLevelValue.obj.transform:Find("OpenEffect"),
								}
								-- 以终点关卡ID为key存储，供PlayNewLevelLineAnim使用
								self._lineRendererMap[nextLevelValue.config[1]] = endEntry
								-- 以起点关卡ID为key存储，供PlayLevelStartLineAnim使用
								local startKey = value.config[1]
								if not self._lineRendererStartMap[startKey] then
									self._lineRendererStartMap[startKey] = {}
								end
								table.insert(self._lineRendererStartMap[startKey], endEntry)
								local lineOn = Me:getLevelIsUnLock(nextLevelValue.config[1])
								ObjPointLine:SetActive(lineOn)
							end
						end, boxParent.gameObject)
					end
				end
			end
		end
		if not _asyncLoading then
			ObjPoint.gameObject:SetActive(true)
		end
	end

	self:FindLastLevel(self.nowMode) --查找当前章节最后一个可打的关卡
end

--查找当前章节最后一个可打的关卡
---@param modeIndex number 模式索引 1 普通模式 2 困难模式
function SeaMapMgr:FindLastLevel(modeIndex)
	modeIndex = modeIndex or 1
	local ChapterConfig, levelList, boxList
	if modeIndex == 2 then
		ChapterConfig = self.ChapterDifficultConfig
		levelList = ChapterConfig.PveLevel
		boxList = self.seaMapBoxDifficultList
	else
		ChapterConfig = self.ChapterConfig
		levelList = ChapterConfig.PveLevel
		boxList = self.seaMapBoxList
	end

	local lastLevelId = nil
	for i = tablex.size(levelList), 1, -1 do
		local levelId = levelList[i][1]
		local levelType = levelList[i][4]
		local lastId = levelList[i][6]
		if modeIndex == 2 then
			if levelList[i][4] ~= GE.LevelPointType.Once then
				local lastOpen = lastId == 0
				if lastId ~= 0 then
					lastOpen = Me:getLevelIsPassed(lastId)
					if lastOpen and Me:getLevelIsUnLock(levelId) then
						lastLevelId = levelId
						break
					end
				end
			end
		else
			if Me:getLevelIsUnLock(levelId) then
				lastLevelId = levelId
				break
			end
		end
	end

	if lastLevelId and boxList[lastLevelId] then
		self.nowOpenObj = boxList[lastLevelId].obj.gameObject
		self:SetNodeSelectState(lastLevelId, modeIndex)
	else
		self.nowOpenObj = nil
		self:SetNodeSelectState(nil, modeIndex)
	end

	-- 将镜头位置移动到最后一个可打的关卡位置 不能超过最大和最小位置
	if self.nowOpenObj then
		local targetPosX = -self.nowOpenObj.transform.localPosition.x
		-- 优先使用已经计算好的适配边界，否则退回到 Config 中原始预设
		local rightBoundary = (self.mapBoundary and self.mapBoundary.right) or
		Config.SeaMapBoundary[self.ChapterConfig.mapTemplate].right
		local leftBoundary = (self.mapBoundary and self.mapBoundary.left) or
		Config.SeaMapBoundary[self.ChapterConfig.mapTemplate].left

		-- Clamp the new X position within the boundaries
		targetPosX = math.max(rightBoundary, math.min(targetPosX, leftBoundary))

		self.MapPoint.transform.localPosition = Vector3.New(targetPosX, self.MapPoint.transform.localPosition.y,
			self.MapPoint.transform.localPosition.z)
	end
end

--设置唯一选中节点（全量清空后只点亮目标）
---@param levelId number|nil 目标关卡ID，nil表示清空选中
---@param modeIndex number 模式索引 1 普通模式 2 困难模式
function SeaMapMgr:SetNodeSelectState(levelId, modeIndex)
	local function clearSelectByList(boxList)
		if not boxList then
			return
		end
		for _, value in pairs(boxList) do
			if value and value.obj then
				local isSelect = value.obj.transform:Find("ObjPoint/UIRoot/UICanvas/IsSelect")
				if isSelect then
					isSelect.gameObject:SetActive(false)
				end
			end
		end
	end

	clearSelectByList(self.seaMapBoxList)
	clearSelectByList(self.seaMapBoxDifficultList)

	if not levelId then
		return
	end

	local targetList = modeIndex == 2 and self.seaMapBoxDifficultList or self.seaMapBoxList
	if targetList and targetList[levelId] and targetList[levelId].obj then
		local isSelect = targetList[levelId].obj.transform:Find("ObjPoint/UIRoot/UICanvas/IsSelect")
		if isSelect then
			isSelect.gameObject:SetActive(true)
		end
	end
end

------------------------------------角色相关停用保留---------------------------------------------
--角色生成
function SeaMapMgr:CreateRole()
	ResMgr:LoadGameObjectAsyncInOwner(
	string.format(Config.PrefabPath.RoleModelPrefab, "character_10005", "character_10005"), function(modelObj)
		local obj = modelObj
		obj.transform:SetParent(self.PlayerPoint.transform)
		obj.transform.localPosition = Vector3.zero
		obj.transform.localRotation = Vector3.zero
		obj.transform.localScale = Vector3.New(0.8, 0.8, 0.8)

		obj.gameObject:GetComponent("CapsuleCollider").enabled = false

		self.model = obj.transform:GetComponent("RoleModelController")
		-- self.model:SetShadowHeight(0)
		obj:SetActive(true)
	end, self.PlayerPoint.gameObject)
	--TODO: 找到最后一个可以打的关卡节点

	local nowChatperId = ClientData:GetNowSelectChatperId()
	local ChapterConfig = Config.GetChapterInfo(nowChatperId)
	local levelList = ChapterConfig.PveLevel
	local nowSelectLevelId = ClientData:GetNowSelectLevelId()
	local isJumped = false
	--优先跳转
	for i = tablex.size(levelList), 1, -1 do
		if levelList[i][1] == nowSelectLevelId and Me:getLevelIsUnLock(nowSelectLevelId) then
			local EndPos = Vector3.New(levelList[i][2][1], 0, levelList[i][2][2])
			local direction = EndPos - self.PlayerPoint.transform.localPosition
			local directionNormal = direction.normalized
			self.PlayerPoint.transform.localPosition = Vector3.New(EndPos.x - directionNormal.x * 0.5,
				self.PlayerPoint.transform.localPosition.y, EndPos.z - directionNormal.z * 0.5)
			isJumped = true
			break
		end
	end
	--其次找到最后一个可以打的关卡
	if not isJumped then
		for i = tablex.size(levelList), 1, -1 do
			if Me:getLevelIsUnLock(levelList[i][1]) then
				local EndPos = Vector3.New(levelList[i][2][1], 0, levelList[i][2][2])
				local direction = EndPos - self.PlayerPoint.transform.localPosition
				local directionNormal = direction.normalized
				self.PlayerPoint.transform.localPosition = Vector3.New(EndPos.x - directionNormal.x * 0.5,
					self.PlayerPoint.transform.localPosition.y, EndPos.z - directionNormal.z * 0.5)
				break
			end
		end
	end
	self.PlayerPoint.transform.localRotation = Vector3.New(0, 180, 0)
	--角色生成完毕后清空跳转关卡ID
	if nowSelectLevelId then
		ClientData:SetNowSelectLevelId(nil)
	end
end

--设置角色移动
function SeaMapMgr:SetRoleMove(EndPos, levelId)
	self.isMove = true
	local speed = 0.45
	self.model:SetDefaultState(RoleAnimStateType.Run)

	local direction = EndPos - self.PlayerPoint.transform.localPosition
	local directionNormal = direction.normalized
	local targetRotation = Quaternion.LookRotation(direction).eulerAngles
	targetRotation.x = self.PlayerPoint.transform.localEulerAngles.x
	targetRotation.z = self.PlayerPoint.transform.localEulerAngles.z
	self.PlayerPoint.transform:DOLocalRotate(targetRotation, speed, DG.Tweening.RotateMode.Fast)
	local newEndPos = Vector3.New(EndPos.x - directionNormal.x * 0.5, self.PlayerPoint.transform.localPosition.y,
		EndPos.z - directionNormal.z * 0.5)
	if math.abs(newEndPos.x - self.PlayerPoint.transform.localPosition.x) < 0.05 and math.abs(newEndPos.z - self.PlayerPoint.transform.localPosition.z) < 0.05 then
		self.model:SetDefaultState(RoleAnimStateType.Idle)
		self.isMove = false
		local LevelMapPanel = UIMgr:getUIData("LevelMapPanel")
		if LevelMapPanel then
			LevelMapPanel.ui:SetDetailsByType(levelId)
		end
		return
	end
	--移动
	local path = { self.PlayerPoint.transform.localPosition, newEndPos }
	self.PlayerPoint.transform:DOLocalPath(path, 1, DG.Tweening.PathType.CatmullRom):SetEase(DG.Tweening.Ease.Linear)
		:OnComplete(function()
			self.model:SetDefaultState(RoleAnimStateType.Idle)
			self.isMove = false
			local LevelMapPanel = UIMgr:getUIData("LevelMapPanel")
			if LevelMapPanel then
				LevelMapPanel.ui:SetDetailsByType(levelId)
			end
		end)
end

--判断是否点击在UI上
function SeaMapMgr:isPointerOverUIObject()
	local eventDataCurrentPosition = UnityEngine.EventSystems.PointerEventData(EventSystem.current)
	eventDataCurrentPosition.position = Input.mousePosition
	local results = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	if EventSystem.current then
		EventSystem.current:RaycastAll(eventDataCurrentPosition, results)
	end
	return results.Count > 0
end

--贝塞尔测试
function SeaMapMgr:BezierCurveTest()
	local path = { self._startPoint, self._controlPoint, self._endPoint }
	self.Player.transform:DOLocalPath(path, 2, DG.Tweening.PathType.CatmullRom):SetEase(DG.Tweening.Ease.OutCubic)
		:OnComplete(function()
			LuaLogger.ds("那确实值得庆祝一下了！！！！！")
		end)
end

function SeaMapMgr:Update()
	if self.isClose then
		return
	end
	--LuaLogger.ds("SeaMapMgr:Update")

	-- 驱动线条绘制动画
	if self._lineAnimList and #self._lineAnimList > 0 then
		local i = 1
		while i <= #self._lineAnimList do
			local anim = self._lineAnimList[i]
			anim.elapsed = anim.elapsed + Time.deltaTime
			local t = math.min(anim.elapsed / anim.duration, 1)
			-- smoothstep 缓动：先快后慢
			local st = t * t * (3 - 2 * t)
			local currentEnd = Vector3.Lerp(anim.startPoint, anim.endPoint, st)
			anim.lineRenderer:SetPosition(1, currentEnd)
			if t >= 1 then
				if anim.onComplete then anim.onComplete() end
				table.remove(self._lineAnimList, i)
			else
				i = i + 1
			end
		end
	end

	-- 动画播放期间禁止一切点击和拖拽
	if self._isPlayingAnim then
		self._lastMousePosition = nil
		self._isDragging = false
		self._initialPosition = nil
		return
	end

	-- 多指触摸时重置拖拽状态，防止触摸索引重排导致 mousePosition 跳变闪屏
	if Input.touchCount > 1 then
		self._lastMousePosition = nil
		self._isDragging = false
		self._initialPosition = nil
		return
	end

	if Input.GetMouseButton(0) then
		if self._initialPosition and (UnityEngine.Vector3.Distance(Input.mousePosition, self._initialPosition) > 30) then
			self._isDragging = true
		end

		if self._isDragging and self.MapPoint then
			if not self._lastMousePosition then
				self._lastMousePosition = Input.mousePosition
			end

			local delta = Input.mousePosition.x - self._lastMousePosition.x
			local speed = 0.004 --移动速度
			local newX = self.MapPoint.transform.localPosition.x + delta * speed
			-- 使用适配后的边界（若不存在则回退到 Config）
			local rightBoundary = (self.mapBoundary and self.mapBoundary.right) or
			Config.SeaMapBoundary[self.ChapterConfig.mapTemplate].right                                                                        --左侧边界
			local leftBoundary = (self.mapBoundary and self.mapBoundary.left) or
			Config.SeaMapBoundary[self.ChapterConfig.mapTemplate].left                                                                         --右侧边界

			newX = math.max(rightBoundary, math.min(newX, leftBoundary))

			self.MapPoint.transform.localPosition = Vector3.New(newX, self.MapPoint.transform.localPosition.y,
				self.MapPoint.transform.localPosition.z)
			self._lastMousePosition = Input.mousePosition
		end
	end

	if Input.GetMouseButtonDown(0) then
		if (self:isPointerOverUIObject()) then
			return
		end

		if self.camera ~= nil then
			self._initialPosition = Input.mousePosition
		end
	end

	if Input.GetMouseButtonUp(0) then
		if self.isMove then
			return
		end

		if self.camera then
			if not self._isDragging and self._initialPosition and self.camera and self.camera.main then
				local ray = self.camera.main:ScreenPointToRay(Input.mousePosition)
				local _, hit = UnityEngine.Physics.Raycast(ray, nil)

				if (hit ~= nil) then
					self.hitObj = hit.transform.gameObject
					self:ClickLevelPoint(self.hitObj)
				end
			end
		end

		self._initialPosition = nil
		self._lastMousePosition = nil
		self._isDragging = false
	end
end

-- 点击方法
function SeaMapMgr:ClickLevelPoint(pointObj)
	if pointObj.tag ~= "SeaMapPlayer" then
		if pointObj.tag == "SeaReward" then
			local BoxState = pointObj:GetComponent("PointEvent")
			local LevelId = BoxState:GetEventId()
			local levelData = Me:getLevelDataByid(LevelId)
			local levelConfig = Config.GetPveLevelInfo(LevelId)

			if self.nowMode == 2 and self.seaMapBoxDifficultList[LevelId].config[4] == GE.LevelPointType.Once then --困难模式的一次性关卡无法点击
				return
			end

			if self.nowMode == 2 and levelConfig.type == GE.LevelType.Story then --困难模式的剧情关卡无法点击
				return
			end

			if self.nowMode == 1 and levelData and levelData.state == GE.LevelStateType.Finish and self.seaMapBoxList[LevelId].config[4] == GE.LevelPointType.Once then
				--一次性关卡
				return
			end
			--选中改去判断最新关卡
			--local isSelect = pointObj.transform:Find("ObjPoint/UIRoot/UICanvas/IsSelect")
			--isSelect.transform.gameObject:SetActive(true)
			self.nowSelectLevel = LevelId
			-- self:SetNodeSelectState(LevelId, self.nowMode)
			LuaMain:play2DSound(self.btnSoundPath)
			local LevelMapPanel = UIMgr:getUIData("LevelMapPanel")
			if LevelMapPanel then
				LevelMapPanel.ui:SetDetailsByType(LevelId)
			end
		end
	end
end

function SeaMapMgr:ClearSelect()
	self:SetNodeSelectState(nil, self.nowMode)
	self.nowSelectLevel = nil
end

--设置当前材料关卡细分类型
---@param deepType number 细分类型
function SeaMapMgr:setNowMaterialDeepType(deepType)
	self.nowMaterialDeepType = deepType
end

--获取当前材料关卡细分类型
function SeaMapMgr:getNowMaterialDeepType()
	return self.nowMaterialDeepType
end

--获取当前周长boss索引
function SeaMapMgr:getNowWeeklyBossIndex()
	return self.nowWeeklyBossIndex
end

--设置当前周长boss索引
---@param index number 索引
function SeaMapMgr:setNowWeeklyBossIndex(index)
	self.nowWeeklyBossIndex = index
end

--- 显示终点节点的持久特效（根据节点类型和完成状态决定）
---@param lineData table 线段数据
function SeaMapMgr:_showEndNodeEffects(lineData)
	local t = lineData.endObjTransform
	if not t then return end
	if lineData.endIsNormalMode then
		if lineData.endIsOnce then
			local levelData = Me:getLevelDataByid(lineData.endLevelId)
			if levelData and levelData.state == GE.LevelStateType.Finish then
				local ef = t:Find("OnceFinishEffect")
				if ef then ef.gameObject:SetActive(true) end
			else
				local ef = t:Find("OnceEffect")
				if ef then ef.gameObject:SetActive(true) end
			end
		elseif not lineData.endIsStory then
			local ef = t:Find("Effect")
			if ef then ef.gameObject:SetActive(true) end
		end
	else
		if lineData.endIsOnce then
			local ef = t:Find("OnceFinishEffectHard")
			if ef then ef.gameObject:SetActive(true) end
		elseif not lineData.endIsStory then
			local ef = t:Find("HardEffect")
			if ef then ef.gameObject:SetActive(true) end
		end
	end
end

--- 将地图镜头平滑移动到指定节点的位置（内部辅助方法）
---@param nodeTransform UnityEngine.Transform 目标节点的 Transform
---@param duration      number|nil            移动时长（秒），默认 0.5
---@param onComplete    function|nil          移动完成回调
function SeaMapMgr:_moveCameraToNode(nodeTransform, duration, onComplete)
	if not nodeTransform or not self.MapPoint then return end
	local targetPosX    = -nodeTransform.localPosition.x
	local rightBoundary = (self.mapBoundary and self.mapBoundary.right) or
	Config.SeaMapBoundary[self.ChapterConfig.mapTemplate].right
	local leftBoundary  = (self.mapBoundary and self.mapBoundary.left) or
	Config.SeaMapBoundary[self.ChapterConfig.mapTemplate].left
	targetPosX          = math.max(rightBoundary, math.min(targetPosX, leftBoundary))
	local targetPos     = Vector3.New(targetPosX, self.MapPoint.transform.localPosition.y,
		self.MapPoint.transform.localPosition.z)
	-- 若镜头已在目标位置附近则跳过 tween，直接触发回调
	if math.abs(self.MapPoint.transform.localPosition.x - targetPosX) < 0.5 then
		if onComplete then onComplete() end
		return
	end
	self.MapPoint.transform:DOLocalMove(targetPos, duration or 0.5):SetEase(DG.Tweening.Ease.OutCubic):OnComplete(function()
		if onComplete then onComplete() end
	end)
end

--- 驱动一条 LineRenderer 从 startPoint 动态绘制到 endPoint
---@param lineRenderer UnityEngine.LineRenderer
---@param startPoint   UnityEngine.Vector3
---@param endPoint     UnityEngine.Vector3
---@param duration     number  动画时长（秒），默认 0.5
---@param onComplete   function|nil  完成回调
function SeaMapMgr:PlayLineDrawAnim(lineRenderer, startPoint, endPoint, duration, onComplete)
	if not lineRenderer then return end
	duration = duration or 0.5
	lineRenderer.positionCount = 2
	lineRenderer:SetPosition(0, startPoint)
	lineRenderer:SetPosition(1, startPoint) -- 终点先归位到起点，视觉上线段长度为0
	table.insert(self._lineAnimList, {
		lineRenderer = lineRenderer,
		startPoint   = startPoint,
		endPoint     = endPoint,
		duration     = duration,
		elapsed      = 0,
		onComplete   = onComplete,
	})
end

--- 播放指定关卡对应的连接线绘制动画（该关卡作为线段终点）
--- 适用于展示「最新开放关卡」：找到以 levelId 为终点的线段，从起点动态画至终点
---@param levelId    number    最新开放的关卡ID
---@param duration   number|nil 动画时长（秒），默认 0.5
---@param onComplete function|nil 动画完成回调
function SeaMapMgr:PlayNewLevelLineAnim(levelId, duration, onComplete)
	local lineData = self._lineRendererMap[levelId]
	if not lineData then
		LuaLogger.ds("SeaMapMgr:PlayNewLevelLineAnim - 未找到关卡对应线段, levelId=" .. tostring(levelId))
		return
	end
	self._isPlayingAnim = true
	-- 确保对应线段对象处于激活状态
	local lr = lineData.lineRenderer
	if lr and lr.gameObject then
		lr.gameObject:SetActive(false) -- 先隐藏线段，等镜头移动到位后再显示并播放动画
	end
	if lineData.endOpenEffect then
		lineData.endOpenEffect.gameObject:SetActive(false)
	end
	if lineData.endObjTransform then
		lineData.endObjTransform.gameObject:SetActive(false)
	end
	-- 播放前将镜头平滑移动到终点节点位置，到达后再开始线段动画
	self:_moveCameraToNode(lineData.endObjTransform, 0.5, function()
		lr.gameObject:SetActive(true)
		-- 镜头到位后隐藏整个终点节点及 OpenEffect
		self:PlayLineDrawAnim(lr, lineData.startPoint, lineData.endPoint, duration or 0.5, function()
			-- 动画完成后显示节点（ObjPoint 保持隐藏），同时显示 OpenEffect
			if lineData.endObjTransform then
				lineData.endObjTransform.gameObject:SetActive(true)
				local objPoint = lineData.endObjTransform:Find("ObjPoint")
				if objPoint then objPoint.gameObject:SetActive(false) end
			end
			if lineData.endOpenEffect then
				lineData.endOpenEffect.gameObject:SetActive(true)
			end
			-- 延迟 nodeShowDelay 秒后显示 ObjPoint 及持久特效
			DLuaTimer:DoAfter(self.nodeShowDelay, function()
				if lineData.endObjTransform then
					local objPoint = lineData.endObjTransform:Find("ObjPoint")
					if objPoint then objPoint.gameObject:SetActive(true) end
				end
				self:_showEndNodeEffects(lineData)
				self._isPlayingAnim = false
				if onComplete then onComplete() end
			end)
		end)
	end)
end

--- 播放以指定关卡为起点的所有连接线绘制动画
--- 找到所有以 levelId 为起点的线段，逐条从起点动态画至终点
--- 若存在多条出发线，每条动画独立播放；onComplete 在最后一条完成时触发
---@param levelId    number       起点关卡ID
---@param duration   number|nil   每条线的动画时长（秒），默认 0.5
---@param onComplete function|nil 全部线段动画完成后的回调
function SeaMapMgr:PlayLevelStartLineAnim(levelId, duration, onComplete)
	local lineList = self._lineRendererStartMap[levelId]
	if not lineList or #lineList == 0 then
		LuaLogger.ds("SeaMapMgr:PlayLevelStartLineAnim - 未找到关卡对应的出发线段, levelId=" .. tostring(levelId))
		return
	end
	self._isPlayingAnim = true
	local total = #lineList
	local finishedCount = 0
	-- 播放前将镜头平滑移动到第一条线的终点节点位置，到达后再开始线段动画
	self:_moveCameraToNode(lineList[1].endObjTransform, 0.5, function()
		for _, lineData in ipairs(lineList) do
			local lr = lineData.lineRenderer
			if lr and lr.gameObject then
				lr.gameObject:SetActive(true)
			end
			-- 镜头到位后隐藏终点 OpenEffect 及整个节点
			if lineData.endOpenEffect then
				lineData.endOpenEffect.gameObject:SetActive(false)
			end
			if lineData.endObjTransform then
				lineData.endObjTransform.gameObject:SetActive(false)
			end
			self:PlayLineDrawAnim(lr, lineData.startPoint, lineData.endPoint, duration or 0.5, function()
				-- 动画完成后显示节点（ObjPoint 保持隐藏），同时显示 OpenEffect
				if lineData.endObjTransform then
					lineData.endObjTransform.gameObject:SetActive(true)
					local objPoint = lineData.endObjTransform:Find("ObjPoint")
					if objPoint then objPoint.gameObject:SetActive(false) end
				end
				if lineData.endOpenEffect then
					lineData.endOpenEffect.gameObject:SetActive(true)
				end
				-- 延迟 nodeShowDelay 秒后显示 ObjPoint 及持久特效
				DLuaTimer:DoAfter(self.nodeShowDelay, function()
					if lineData.endObjTransform then
						local objPoint = lineData.endObjTransform:Find("ObjPoint")
						if objPoint then objPoint.gameObject:SetActive(true) end
					end
					self:_showEndNodeEffects(lineData)
					finishedCount = finishedCount + 1
					if finishedCount >= total then
						self._isPlayingAnim = false
						if onComplete then onComplete() end
					end
				end)
			end)
		end
	end)
end

--- 批量播放多个新开放关卡的连接线动画（以终点关卡ID列表为输入）
--- 先隐藏所有关卡节点和对应线段，再依次串行播放，全部完成后触发 onComplete
---@param levelIdList  table        终点关卡ID列表，例如 {10101, 10102}
---@param duration     number|nil   每条线的动画时长（秒），默认 0.5
---@param onComplete   function|nil 全部动画完成后的回调
function SeaMapMgr:PlayLevelLineAnimQueue(levelIdList, duration, onComplete)
	if not levelIdList or #levelIdList == 0 then
		if onComplete then onComplete() end
		return
	end
	self._isPlayingAnim = true

	-- 第一步：批量隐藏所有待播放的节点和线段
	for _, levelId in ipairs(levelIdList) do
		local lineData = self._lineRendererMap[levelId]
		if lineData then
			if lineData.lineRenderer and lineData.lineRenderer.gameObject then
				lineData.lineRenderer.gameObject:SetActive(false)
			end
			if lineData.endOpenEffect then
				lineData.endOpenEffect.gameObject:SetActive(false)
			end
			if lineData.endObjTransform then
				lineData.endObjTransform.gameObject:SetActive(false)
			end
		end
	end

	-- 第二步：串行逐个播放（递归推进）
	local index = 1
	local function playNext()
		if index > #levelIdList then
			self._isPlayingAnim = false
			if onComplete then onComplete() end
			return
		end
		local levelId = levelIdList[index]
		index = index + 1
		local lineData = self._lineRendererMap[levelId]
		if not lineData then
			LuaLogger.ds("SeaMapMgr:PlayLevelLineAnimQueue - 未找到关卡线段, levelId=" .. tostring(levelId))
			self:_showLevelNodeFallback(levelId)
			MyPrefs:SetBool("SeaMapAnim_" .. tostring(levelId), true)
			playNext()
			return
		end
		local lr = lineData.lineRenderer
		-- 移动镜头后播放画线，完成后推进下一条
		self:_moveCameraToNode(lineData.endObjTransform, 0.5, function()
			if lr and lr.gameObject then lr.gameObject:SetActive(true) end
			self:PlayLineDrawAnim(lr, lineData.startPoint, lineData.endPoint, duration or 0.5, function()
				-- 动画完成后显示节点（ObjPoint 保持隐藏），同时显示 OpenEffect
				if lineData.endObjTransform then
					lineData.endObjTransform.gameObject:SetActive(true)
					local objPoint = lineData.endObjTransform:Find("ObjPoint")
					if objPoint then objPoint.gameObject:SetActive(false) end
				end
				if lineData.endOpenEffect then
					lineData.endOpenEffect.gameObject:SetActive(true)
				end
				-- 延迟 nodeShowDelay 秒后显示 ObjPoint 及持久特效
				DLuaTimer:DoAfter(self.nodeShowDelay, function()
					if lineData.endObjTransform then
						local objPoint = lineData.endObjTransform:Find("ObjPoint")
						if objPoint then objPoint.gameObject:SetActive(true) end
					end
					self:_showEndNodeEffects(lineData)
					-- 持久化记录：标记该关卡的开图动画已播放，后续不再重复
					MyPrefs:SetBool("SeaMapAnim_" .. tostring(levelId), true)
					playNext()
				end)
			end)
		end)
	end
	playNext()
end

--- 自动检测并播放当前模式下所有「已解锁但无服务器数据」节点的连接线动画
--- 无服务器数据即 Me:getLevelDataByid 返回 nil，视为新开放的关卡
---@param duration     number|nil   每条线的动画时长（秒），默认 0.5
---@param onComplete   function|nil 全部动画完成后的回调
function SeaMapMgr:PlayNewUnlockedLevelAnims(duration, onComplete)
	self:_tryPlayNewUnlockedLevelAnims(0, duration, onComplete)
end

return SeaMapMgr
