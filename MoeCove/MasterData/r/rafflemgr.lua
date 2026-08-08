---@class RaffleMgr 抽卡场景动画管理类
local RaffleMgr = class("RaffleMgr")

function RaffleMgr:ctor()
	self:Init()
end

function RaffleMgr:Init()
	--抽卡结果数据
	self.raffleResultList = {}

	--抽卡显示数据
	self.raffleShowList = {}

	--艾塔人物
	self.etaRole = nil

	--动画管理器
	self.raffleController = nil

	--播放动画计数器
	self.playGetRoleCount = 0

	--需要出场的人物id列表
	self.needRoleIdList = {}

	--出场人物列表
	self.showRoleList = {}

	--是否跳过抽卡动画
	self.isSkip = false

	--是否单抽
	self.isSingle = false

	--是否完成一次抽卡
	self.isComplete = false

	--前端缓存抽卡记录数据
	self.raffleRecordData = {}

	--存储桶中间数据
	self.recordCosDataList = {}

	--当前卡池id
	self.nowPoolId = nil

	--是否跳过购买招集卷提示窗免费钻
	self.isSkipBuyRaffleTicketTipsFree = false

	--是否跳过购买招集卷提示窗付费钻
	self.isSkipBuyRaffleTicketTipsPay = false

	--是否为购买招集卷
	self.isBuyRaffleTicket = false
	--是否是简单动画 不显示
	self.isSimpleShow = nil
	---@type fun()? 简单动画完成回调
	self.simpleCallback = nil

	--抽卡指挥室场景中人物灯光
	self.sceneRoleLightObj = nil

	--角色timeline控制器
	self.timelineModel = nil

	--场景相机
	self.raffleCamera = nil

	--人物挂载节点
	self.raffleRoleRoot = nil

	--抽卡需要调用gc的当前次数
	self.needGCNowCount = 0
end

--设置抽卡结果数据
---@param resultList table 抽卡结果数据列表
function RaffleMgr:setRaffleResultList(resultList)
	if type(resultList) ~= "table" then
		return
	end
	self.playGetRoleCount = 0
	self.raffleResultList = clone(resultList)
	self.isSingle = #self.raffleResultList == 1
	self.isSkip = false
	self.needGCNowCount = self.needGCNowCount + #self.raffleResultList

	--根据sr与ssr进行标记
	self.needRoleIdList = {}
	for _, resultData in ipairs(self.raffleResultList) do
		if resultData.type == GE.RewardType.Character then
			local roleConfig = Config.GetCharacterInfo(resultData.id)
			if roleConfig.rank == GE.HeroRankStar.SR then
				resultData.isSR = true
			elseif roleConfig.rank == GE.HeroRankStar.SSR then
				resultData.isSSR = true
			end
			if not self.needRoleIdList[resultData.id] and (resultData.isSSR or (not resultData.extraType)) then
				self.needRoleIdList[resultData.id] = true
			end
		end
	end

	--挨个显示角色时使用该数据
	self.raffleShowList = self.raffleResultList
	--LuaLogger.ds("抽卡结果数据:", tablex.dump(self.raffleResultList))
end

--获取抽卡结果数据
---@return table 抽卡结果数据列表
function RaffleMgr:getRaffleResultList()
	return self.raffleResultList
end

--获取需要显示的抽卡结果数据
---@return table 抽卡显示数据列表
function RaffleMgr:getRaffleShowList()
	return self.raffleShowList
end

--设置当前卡池id
---@param poolId integer 卡池ID
function RaffleMgr:setNowPoolId(poolId)
	self.nowPoolId = poolId
end

--获取当前卡池id
function RaffleMgr:getNowPoolId()
	return self.nowPoolId
end

--跳转抽卡场景
function RaffleMgr:jumpToRaffleScene()
	ResMgr:LoadSceneAsyncLua(Config.ScenePath.ZhihuishiScene, true, function(sceneName)
		self:loadEtaRole()

		--人物root节点
		self:creatRaffleRoleRoot()

		--根据去重列表加载人物
		for roleCid, _ in pairs(self.needRoleIdList) do
			self:loadShowRole(roleCid)
		end

		self:getBackgroundAndCloudObj()
	end)
end

--返回主场景
function RaffleMgr:backToMainScene(callback)
	--LoadingMgr:SetUIQuickSwitchStart(function()
		if self.loadSceneTimer2 then
			DLuaTimer:RemoveTimer(self.loadSceneTimer2)
		end
		local asyncOperation = nil
		if not self.isSimpleShow then
			asyncOperation = UnityEngine.SceneManagement.SceneManager.UnloadSceneAsync("zhihuishi")
		else
			asyncOperation = {isDone = true}
		end


		self.loadSceneTimer2 = DLuaTimer:DoRepeatForever(0.1, function()
			if (asyncOperation.isDone) then
		
				self:setIsComplete(true)
				self:destroyShowRole()
				DLuaTimer:RemoveTimer(self.loadSceneTimer2)
				UIMgr:closeSpecificUI("RaffleAnimationPanel")
				self.raffleCamera = nil
				if callback then
					callback()
				end
				--LoadingMgr:SetUIQuickSwitchOver()
			end
		end)
	--end)


end

--加载艾塔人物
function RaffleMgr:loadEtaRole(callback, calback1)
	if not IsNull(self.raffleRoot) then
		self:initEffectCameraSize()
		if callback then
			callback()
		end
		if calback1 then
			calback1()
		end
		return
	end
	ResMgr:LoadPrefabAsync(Config.PrefabPath.RaffleAniRoot, function (obj)
        self.raffleRoot = Instantiate(obj).gameObject
		self.raffleController = self.raffleRoot:GetComponent("RaffleController")

		if not self.isSimpleShow then
			local targetScene = UnityEngine.SceneManagement.SceneManager.GetSceneByName("zhihuishi");
			UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(self.raffleRoot, targetScene);
		end
		UIMgr:popUI("RaffleAnimationPanel", nil, calback1)
		--self:playGetRoleEnterAnimation()
		--镜头特效大小初始化
		self:initEffectCameraSize()

		--获取场景相机
		self.raffleCamera = UnityEngine.GameObject.Find("RaffleCamera"):GetComponent("Camera")

		--获取人物灯光
		if not UICommonUtils.Checkobj(self.sceneRoleLightObj) then
			self.sceneRoleLightObj = UnityEngine.GameObject.Find("GaChaHeroDLight")
		end

		if callback then
			callback()
		end
	end)
end

--镜头特效大小初始化
function RaffleMgr:initEffectCameraSize()
    local CanvasScaler =  UIMgr.uiCanvas.gameObject:GetComponent("CanvasScaler")
    local screen_width = CanvasScaler.referenceResolution.x
    local screen_height = CanvasScaler.referenceResolution.y
    local kv_width = 2160
    local kv_height = 1080
    local scale_width = screen_width / kv_width
    local scale_height = screen_height / kv_height
    local scale = math.max(scale_width, scale_height)
	local needZoom = 1 / scale
    self.raffleController.effectCamera.transform.localScale = Vector3.New(1, 1, needZoom)
	self.raffleController.effectSRCamera.transform.localScale = Vector3.New(1, 1, needZoom)
end

--加载出场角色
---@param roleCid integer 角色配置ID
---@param callBack function 回调函数
function RaffleMgr:loadShowRole(roleCid, callBack)
	if UICommonUtils.Checkobj(self.showRoleList[roleCid]) then
		if callBack then
			callBack()
		end
		return
	end

	local roleConfig = Config.GetCharacterInfo(roleCid)
	local SkinConfig = Config.GetCharacterSkinInfo(roleConfig.baseSkinID)
	ResMgr:LoadGameObjectAsyncInOwner(string.format(Config.PrefabPath.RoleModelPrefab, SkinConfig.modelKey, SkinConfig.modelKey), function (roleObj)
		self.showRoleList[roleCid] = roleObj
		roleObj.transform:SetParent(self.raffleRoleRoot.transform)


		--SR及以上才加载timeline
		if roleConfig.rank < GE.HeroRankStar.SR then
			if callBack then
				callBack()
			end
			return
		end
		local roleModel = self.showRoleList[roleCid].transform:GetComponent("RoleModelController")
		roleModel:SetDefaultState(RoleAnimStateType.IdleShip)
		local timeLinePath = string.format(Config.PrefabPath.SkillTimeLinePrefab, SkinConfig.modelKey, SkinConfig.modelKey)
		ResMgr:LoadGameObjectAsyncInOwner(timeLinePath, function (obj)
			local skillTimeLineObj = obj
			if skillTimeLineObj then
				roleModel.timelineMgr = skillTimeLineObj.transform:GetComponent("TimeLineMgr")
				roleModel.timelineMgr.transform:SetParent(roleModel.roleObj.transform)
				roleModel.timelineMgr.transform.localPosition = Vector3.zero
				roleModel.timelineMgr.transform.localRotation = Quaternion.identity
				roleModel.timelineMgr.transform.localScale = Vector3.one

				for i = 0, roleModel.timelineMgr.boneEffects.Length - 1 do
					if roleModel.effectPoints.Length <= i then
						break
					end
					local boneEffect = roleModel.timelineMgr.boneEffects[i]
					boneEffect.transform:SetParent(roleModel.effectPoints[i].transform)
					boneEffect.transform.localPosition = Vector3.zero
					boneEffect.transform.localRotation = Quaternion.identity
					boneEffect.transform.localScale = Vector3.one
				end
			end
			if callBack then
				callBack()
			end
		end, roleObj)
	end, self.raffleRoleRoot)
end


--播放人物出场动画
function RaffleMgr:playGetRoleEnterAnimation()
	self.playGetRoleCount = self.playGetRoleCount + 1
	if self.playGetRoleCount > #self.raffleShowList then
		self:showAllResultData()
		return
	end
	self.raffleController.getSR:SetActive(false)
	self.raffleController.getSSR:SetActive(false)
	--镜头特效
	self.raffleController.effectCamera:SetActive(false)
	if UICommonUtils.Checkobj(self.nowRoleObj) then
		self.nowRoleObj:SetActive(false)
		self.nowRoleObj = nil
	end

	local resultData = self.raffleShowList[self.playGetRoleCount]
	--SSR和new角色出提示
	if resultData.isSSR or (not resultData.extraType) then
		UIMgr:popUICover("SSRTipsPanel", {roleId = resultData.id, closeFunc = function()			--测试展示大招timeline
			self:playRoleTimeLine(resultData, function()
				self:showWriteMask(function()
					UIMgr:popUICover("ShowCharacterPanel", {closeFunc = function()
						self:playGetRoleEnterAnimation()
					end})
				end)
			end)
		end})
		--timeline时使用动画中自带的灯光
		if UICommonUtils.Checkobj(self.sceneRoleLightObj) then
			self.sceneRoleLightObj:SetActive(false)
		end
	elseif self.isSkip and not self.isSingle then
		self:playGetRoleEnterAnimation()
	else
		local roleCid = resultData.id
		self:loadShowRole(roleCid, function()
			self:roleDisplay(resultData)
		end)
	end
end

--人物出场
---@param resultData table 抽卡结果数据
function RaffleMgr:roleDisplay(resultData)
	local roleObj = self.showRoleList[resultData.id]
	local needParent = resultData.isSSR and self.raffleController.ssrObjRoot or self.raffleController.srObjRoot
	roleObj.transform:SetParent(needParent.transform)
	self.nowRoleObj = roleObj
	roleObj.transform.localPosition = Vector3.zero
	roleObj.transform.localRotation = Vector3.zero
	local needRoot = resultData.isSSR and self.raffleController.getSSR or self.raffleController.getSR
	self.nowRoleObj:SetActive(true)

	local layer = UnityEngine.LayerMask.NameToLayer("UIRole")
	self:SetLayerRecursively(roleObj, layer)

	local light = roleObj:GetComponentsInChildren(typeof(UnityEngine.Light), true)
	if light ~= nil then
		local length = light.Length
		for i = 0, length-1 do
			---@type UnityEngine.Light
			local l = light[i]
			if l.name == "RoleLight" then
				l.cullingMask =  2 ^ layer
			end
		end
	end

	--打开场景中人物灯光
	if UICommonUtils.Checkobj(self.sceneRoleLightObj) then
		self.sceneRoleLightObj:SetActive(true)
	end

	needRoot:SetActive(true)
	self.model = roleObj.transform:GetComponent("RoleModelController")
	self.model:SetDefaultState(RoleAnimStateType.Into)
end

--播放角色获得语音
---@param resultData table 抽卡结果数据
function RaffleMgr:playRoleGetVoice(resultData, callback)
	local roleConfig = Config.GetCharacterInfo(resultData.id)
    if not roleConfig then
        return
    end
    local nowLineConfig
	local isNewRole = not resultData.extraType and true or false
    if isNewRole then
        nowLineConfig = Config.GetScriptLinesInfo(roleConfig.getLines[1])
    else
        nowLineConfig = Config.GetScriptLinesInfo(roleConfig.getLines[2])
    end
    if not nowLineConfig then
        return
    end
    if nowLineConfig.resource then--有音频
		self.nowAudioKey = UICommonUtils.Play2DVoiceByLanguage(resultData.id, nowLineConfig.resource, function()
            self.nowAudioKey = nil
			if callback then
				callback()
			end
        end)
    end
end

--播放timeline动画
---@param resultData table 抽卡结果数据
---@param callback function 回调函数
function RaffleMgr:playRoleTimeLine(resultData, callback)
	local roleCid = resultData.id
	local roleConfig = Config.GetCharacterInfo(roleCid)
    if not roleConfig then
        return
    end
	local SkinConfig = Config.GetCharacterSkinInfo(roleConfig.baseSkinID)
	if not SkinConfig then
		return
	end
	--测试特殊处理，R卡不显示timeline
	if roleConfig.rank < GE.HeroRankStar.SR then
		self.timelineModel = nil
		if callback then
			callback()
		end
		return
	end
	LuaLogger.ds("播放角色出场动画:", roleCid, SkinConfig.skillTimeline)
	local playablePath = string.format(Config.TimeLinePath.Character, SkinConfig.skillTimeline)
	ResMgr:LoadPrefabAsyncInOwner(playablePath, function(playable)
		local roleObj = self.showRoleList[roleCid]

		local needParent = self.raffleController.timeLineRoot
	
		roleObj:SetActive(true)
		roleObj.transform:SetParent(needParent.transform, false)
		roleObj.transform.localPosition = Vector3.zero
		roleObj.transform.localRotation = Vector3.zero
		local layer = UnityEngine.LayerMask.NameToLayer("UIRole")
		self:SetLayerRecursively(roleObj, layer)

		local light = roleObj:GetComponentsInChildren(typeof(UnityEngine.Light), true)
		if light ~= nil then
			local length = light.Length
			for i = 0, length-1 do
				---@type UnityEngine.Light
				local l = light[i]
				if l.name == "RoleLight" then
					l.cullingMask =  2 ^ layer
				end
			end
		end



		local roleModel = roleObj.transform:GetComponent("RoleModelController")
		self.timelineModel = roleModel
		if not playable then
			roleObj:SetActive(false)
			if callback then
				callback()
			end
			self.timelineModel = nil
			return
		end
		roleModel.timelineMgr.director.playableAsset = playable
		--导演节点初始化
		roleModel.timelineMgr:ClipListInfo()
		--轨道信息挂载 （暂无使用
		roleModel.timelineMgr:SetGenericBinding("model", roleModel.roleObj)
		-- 遍历特效节点
		local effectPoint = roleModel.timelineMgr.effectPoint.transform
		UnityEngine.RenderSettings.fog = false
		--玩家cutIn摄像机开启
		roleModel.timelineMgr.effectPoint:SetActive(true)
		roleModel.timelineMgr.cutInCamera:SetActive(true)
		roleModel:PlanarShadowEnable(false)
		--背景及云
		self:setBackgroundAndCloudVisible(false)
		--播放角色大招语音
		roleModel.timelineMgr.AudioPlay:SetCallBack(function()
			local playTime = roleModel.timelineMgr.director.duration
			self:playTimeLineAudio(SkinConfig, playTime)
		end)

		roleModel.timelineMgr.director:Play()

		local light = roleModel.timelineMgr.gameObject:GetComponentsInChildren(typeof(UnityEngine.Light), true)
		if light ~= nil then
			local length = light.Length
			for i = 0, length-1 do
				---@type UnityEngine.Light
				local l = light[i]
				if l.name == "RoleLight" then
					l.cullingMask =  2 ^ layer
				end
			end
		end

		self:setCanSkip(resultData.extraType and true or false)

		roleModel.timelineMgr:SetOverCallBack(function()
			if callback then
				callback()
			end
			for i = 0, effectPoint.childCount - 1 do
				local child = effectPoint:GetChild(i)
				child.gameObject:SetActive(false)
			end
			roleModel.timelineMgr.cutInCamera:SetActive(false)
			self:setBackgroundAndCloudVisible(true)
			UnityEngine.RenderSettings.fog = true
			roleModel:PlanarShadowEnable(true)
			roleObj:SetActive(false)
			self.timelineModel = nil

			if self.timeLineAudioTimer then
				DLuaTimer:RemoveTimer(self.timeLineAudioTimer)
				self.timeLineAudioTimer = nil
			end
			if self.timeLineAudio then
				AudioMgr:stopVoice(self.timeLineAudio)
				self.timeLineAudio = nil
			end
		end)
	end, self.raffleRoleRoot)
end

---播放角色战斗CV
function RaffleMgr:playTimeLineAudio(skinConfig, playTime)
	local audioData = skinConfig.battleSkill
	if audioData and next(audioData) then
		local nowLineId = DLuaUtil.getUnityRandomIndexLinear(audioData)
		local nowLineConfig = Config.GetScriptLinesInfo(nowLineId)
		if nowLineConfig and nowLineConfig.resource then--有音频
			if self.timeLineAudio then
				AudioMgr:stopVoice(self.timeLineAudio)
				self.timeLineAudio = nil
			end
			self.timeLineAudio = UICommonUtils.Play2DVoiceByLanguage(skinConfig.CharacterID, nowLineConfig.resource, function()
				self.timeLineAudio = nil
			end)
			if self.timeLineAudioTimer then
				DLuaTimer:RemoveTimer(self.timeLineAudioTimer)
				self.timeLineAudioTimer = nil
			end
			self.timeLineAudioTimer = DLuaTimer:DoAfter(playTime - 1, function()
				if self.timeLineAudio then
					AudioMgr:stopVoice(self.timeLineAudio, 0.5)
					self.timeLineAudio = nil
					self.timeLineAudioTimer = nil
				end
			end)
		end
	end
end

--停止当前角色语音
function RaffleMgr:stopCurrentRoleVoice()
	if self.nowAudioKey then
		AudioMgr:stopVoice(self.nowAudioKey)
		self.nowAudioKey = nil
	end
end

--最终结果展示
function RaffleMgr:showAllResultData(callback)
	if self.isSimpleShow then
		self:backToMainScene(callback)
		return
	end
	if #self.raffleResultList > 1 then
		if callback then
			callback()
		end
		UIMgr:popUICover("RaffleResultPanel")
	else
		self:backToMainScene(callback)
	end
end

--设置模型所有节点layer信息
function RaffleMgr:SetLayerRecursively(obj, layer)
    -- 设置当前对象的Layer
	if obj.layer ~= UnityEngine.LayerMask.NameToLayer("Water") then
    	obj.layer = layer
	end
    -- 遍历所有子对象
    for i = 0, obj.transform.childCount - 1 do
        local child = obj.transform:GetChild(i)
        self:SetLayerRecursively(child.gameObject, layer)  -- 递归调用
    end
end

--初始化时获取背景与云节点
function RaffleMgr:getBackgroundAndCloudObj()
	local rootObj = UnityEngine.GameObject.Find("zhihuishi")
	if rootObj then
		self.backgroundObj = rootObj.transform:Find("Background").gameObject
		self.cloudObj = rootObj.transform:Find("cloud").gameObject
	end
end

--设置背景及云的显隐
function RaffleMgr:setBackgroundAndCloudVisible(isVisible)
	if self.backgroundObj then
		self.backgroundObj:SetActive(isVisible)
	end
	if self.cloudObj then
		self.cloudObj:SetActive(isVisible)
	end
end

--显示屏幕遮罩
function RaffleMgr:showWriteMask(callback)
	local raffleAnimationPanel = UIMgr:getUIData("RaffleAnimationPanel")
	if raffleAnimationPanel then
		raffleAnimationPanel.ui.writeScreen.canvasGroup:DOFade(1, 0.3):OnComplete(function()
			if callback then
				callback()
			end
		end)
		raffleAnimationPanel.ui.writeScreen.canvasGroup.interactable = true
		raffleAnimationPanel.ui.writeScreen.canvasGroup.blocksRaycasts = true
	end
end

--隐藏屏幕遮罩
function RaffleMgr:hideWriteMask(callback)
	local raffleAnimationPanel = UIMgr:getUIData("RaffleAnimationPanel")
	if raffleAnimationPanel then
		raffleAnimationPanel.ui.writeScreen.canvasGroup:DOFade(0, 0.1):OnComplete(function()
			raffleAnimationPanel.ui.writeScreen.canvasGroup.interactable = false
			raffleAnimationPanel.ui.writeScreen.canvasGroup.blocksRaycasts = false
			if callback then
				callback()
			end
		end)
	end
end

--获取当前抽卡结果数据
---@return table? 抽卡结果数据
function RaffleMgr:getCurrentResultData()
	if self.playGetRoleCount <= 0 or self.playGetRoleCount > #self.raffleShowList then
		return nil
	end
	return self.raffleShowList[self.playGetRoleCount]
end

--再次抽卡
function RaffleMgr:raffleAgain(resultList)
	self.isSkip = false
	self.isSingle = false
	self:setRaffleResultList(resultList)
	--根据去重列表加载人物
	for roleCid, _ in pairs(self.needRoleIdList) do
		self:loadShowRole(roleCid)
	end
	local raffleAnimationPanel = UIMgr:getUIData("RaffleAnimationPanel")
	if raffleAnimationPanel then
		raffleAnimationPanel.ui:resetParams()
		raffleAnimationPanel.ui:playIdleRaffleAnimation()
	end
end

--初始化抽卡记录数据
function RaffleMgr:initRecordData()
    local gachaRecordData = Me:getGachaData().recordData
    self:getRaffleRecordCosData(gachaRecordData, function()
        self.raffleRecordData = gachaRecordData and gachaRecordData.recordList or {}
        self.raffleRecordData = tablex.icombine(self.raffleRecordData, self.recordCosDataList)
		self.recordCosDataList = {}
        --LuaLogger.ds(">>>>抽卡记录数据<<<<", tablex.dump(self.raffleRecordData))
    end)
end

--存储桶拉抽卡数据
function RaffleMgr:getRaffleRecordCosData(gachaRecordData, callback)
    local recordCosKeyList = gachaRecordData and gachaRecordData.tempUrlList or {}
    if #recordCosKeyList == 0 then
        if callback then
            callback()
        end
        return
    end
	local totalCount = #recordCosKeyList
	local checkCount = 0
	local recordCosDataMap = {}
	local maxRetryCount = 2

	local function onOneRequestFinished()
		checkCount = checkCount + 1
		if checkCount == totalCount then
			local mergeList = {}
			for i = 1, totalCount do
				local nowData = recordCosDataMap[i]
				if nowData then
					mergeList = tablex.icombine(nowData, mergeList)
				end
			end
			self.recordCosDataList = mergeList
			if callback then
				callback()
			end
		end
	end

	local function tryGetCosLog(key, urlKey, retryCount)
		SDKMgr:getUserCosLog(urlKey, function(success, data)
			if success then
				recordCosDataMap[key] = data
				onOneRequestFinished()
			else
				if retryCount < maxRetryCount then
					DLuaTimer:DoAfter(2, function()
						tryGetCosLog(key, urlKey, retryCount + 1)
					end)
				else
					LuaLogger.es("拉取抽卡记录失败, 已达到最大重试次数!", data, urlKey)
					onOneRequestFinished()
				end
			end
		end)
	end

	for key, urlKey in pairs(recordCosKeyList) do
		tryGetCosLog(key, urlKey, 0)
	end
end

--抽卡卷数量不足时补齐
function RaffleMgr:fillRaffleTicketLack(poolId, count, callBack)
	local poolConfig = Config.GetGachaPoolInfo(poolId)
    local haveCount = Me:getItemCountById(poolConfig.cost)
    if count > haveCount then
        local needFillCount = count - haveCount--补齐数量
        local freeDiamondCount = Me:getItemCountById(GE.ResourceType.FreeDiamond)---免费钻石数量
        local goodsId = poolConfig.shopID--商品id
        local goodsConfig = Config.GetShopMerchandiseInfo(goodsId)
        local goodsPrice = goodsConfig and goodsConfig.discount[3] or 0--商品单价
		local needDiamond = needFillCount * goodsPrice --钻石总消耗
		local needfreeDiamond = 0--需要消耗的免费钻石
        local needPayDiamond = 0--需要消耗的付费钻石
        if freeDiamondCount >= needDiamond then
			--免费钻石足够购买
			needfreeDiamond = needDiamond
		else
			--免费钻石不足，付费钻石补齐
			needfreeDiamond = freeDiamondCount
			needPayDiamond = needDiamond - freeDiamondCount
		end
        local payDiamondCount = Me:getItemCountById(GE.ResourceType.PayDiamond)--付费钻石数量

        --判断钻石是否足够购买
        local checkBuyOrGoShop = function()
            if needPayDiamond > payDiamondCount then
				--抽卡结果界面不能跳转商店
				-- local raffleResultPanel = UIMgr:getUIData("RaffleResultPanel")
				-- if raffleResultPanel then
					UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_CurrencyNoEnough)
				-- 	return
				-- end
                -- --钻石不足，跳转充值
                -- local jumpData = {
                --     type = MsgBoxType.OKCancel,
                --     title = LocalStrEnum.Gacha_Prompt,
                --     content = LocalStrEnum.Gacha_Prompt_ToShop,
                --     okCallback = function()
                --         UIMgr:popUI("GameShopPanel", 20003)
                --     end,
                -- }
                -- UIMgr:popUI("MsgBox", jumpData)
            else
                self:setIsBuyRaffleTicket(true)
                Me:ShopBuyReq(goodsId, needFillCount, callBack)
            end
        end

        --判断是否跳过购买提示窗免费钻
        local isSkipTips = false
		if needPayDiamond == 0 then
			isSkipTips = self:getIsSkipBuyRaffleTicketTipsFree()
		else
			isSkipTips = self:getIsSkipBuyRaffleTicketTipsPay()
		end
        if isSkipTips then
            checkBuyOrGoShop()
            return
        end

        --弹出购买提示窗
        local dataBuy = {
            type = MsgBoxType.BuyRaffleTicket,
            title = LocalStrEnum.Gacha_Prompt,
            needData = {
                itemId = poolConfig.cost,
                buyCount = needFillCount,
                freeDiamond = needfreeDiamond,
                payDiamond = needPayDiamond,
                frontTxt = LocalStrEnum.Gacha_Prompt_FrontTxt,
                andTxt = " " .. LocalStrEnum.Gacha_Prompt_AndTxt,
                middleTxt = LocalStrEnum.Gacha_Prompt_MiddleTxt,
                afterTxt = LocalStrEnum.Gacha_Prompt_AfterTxt,
            },
            okCallback = function()
                checkBuyOrGoShop()
            end,
        }
        UIMgr:popUI("MsgBoxMiddle", dataBuy)
    else
        callBack()
    end
end

--获取抽卡记录数据
function RaffleMgr:getRaffleRecordData()
	return self.raffleRecordData
end

--跳过抽卡动画
function RaffleMgr:skipRaffleAnimation(nowFinish)
	if self.isSimpleShow then
		self:PlayRoleAnimation()
		return
	end
	self.isSkip = true

	--筛选需要展示的角色
	local needShowList = {}
	for key, value in pairs(self.raffleShowList) do
		if key >= self.playGetRoleCount then
			table.insert(needShowList, value)
		end
	end
	self.raffleShowList = needShowList
	if nowFinish then
		self.playGetRoleCount = 1
	else
		self.playGetRoleCount = 0
	end
	--TODO跳过台词展示
	--跳过大招动画
	if self.timelineModel then
		self.timelineModel.timelineMgr.director:Stop()
		self.playGetRoleCount = 1
		self.timelineModel = nil
		return
	end

	self:playGetRoleEnterAnimation()
end

--设置是否可跳过
function RaffleMgr:setCanSkip(canSkip)
	local raffleAnimationPanel = UIMgr:getUIData("RaffleAnimationPanel")
	if raffleAnimationPanel then
		raffleAnimationPanel.ui.rejectInput = not canSkip
	end
end

--获取动画管理器
function RaffleMgr:getRaffleController()
	if not self.raffleController then
		return nil
	end
	return self.raffleController
end

--获取是否单抽
function RaffleMgr:getIsSingle()
	return self.isSingle
end

--设置是否完成一次抽卡
function RaffleMgr:setIsComplete(isComplete)
	self.isComplete = isComplete
	self.backgroundObj = nil
	self.cloudObj = nil
	if self.isSimpleShow then
		self:destroyShowRole()
		if not IsNull(self.raffleRoot) then
			GameObject.Destroy(self.raffleRoot)
			self.raffleRoot = nil
		end
	end

	self.isSimpleShow = nil
end

--获取是否完成一次抽卡
function RaffleMgr:getIsComplete()
	return self.isComplete
end

--设置是否跳过购买招集卷提示窗免费钻
function RaffleMgr:setIsSkipBuyRaffleTicketTipsFree(isSkip)
	self.isSkipBuyRaffleTicketTipsFree = isSkip
end

--设置是否跳过购买招集卷提示窗付费钻
function RaffleMgr:setIsSkipBuyRaffleTicketTipsPay(isSkip)
	self.isSkipBuyRaffleTicketTipsPay = isSkip
	self.isSkipBuyRaffleTicketTipsFree = isSkip
end

--获取是否跳过购买招集卷提示窗免费钻
function RaffleMgr:getIsSkipBuyRaffleTicketTipsFree()
	return self.isSkipBuyRaffleTicketTipsFree
end

--获取是否跳过购买招集卷提示窗付费钻
function RaffleMgr:getIsSkipBuyRaffleTicketTipsPay()
	return self.isSkipBuyRaffleTicketTipsPay
end

--设置是否为购买招集卷
function RaffleMgr:setIsBuyRaffleTicket(isBuy)
	self.isBuyRaffleTicket = isBuy
end

--获取是否为购买招集卷
function RaffleMgr:getIsBuyRaffleTicket()
	return self.isBuyRaffleTicket
end

--设置场景相机开关
function RaffleMgr:setSceneCameraEnabled(isOpen)
	if self.raffleCamera then
		self.raffleCamera.enabled = isOpen
	end
end

--创建人物节点
function RaffleMgr:creatRaffleRoleRoot()
	self.raffleRoleRoot = NewGameObject("RaffleRoleRoot")
	if not self.isSimpleShow then
		local targetScene = UnityEngine.SceneManagement.SceneManager.GetSceneByName("zhihuishi")
		UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(self.raffleRoleRoot, targetScene)
	end
end

--删除人物缓存
function RaffleMgr:destroyShowRole()
	for k, v in pairs(self.showRoleList) do
		GameObject.Destroy(v)
	end
	self.showRoleList = {}
	if UICommonUtils.Checkobj(self.raffleRoleRoot) then
		GameObject.Destroy(self.raffleRoleRoot)
		self.raffleRoleRoot = nil
	end
	if self.needGCNowCount >= 20 then
		LuaMgr.Instance:ClearMemory()
		self.needGCNowCount = 0
	end
end

----------------------------------------------------

function RaffleMgr:ShowResultData(callback)
	
	self.playGetRoleCount = 0
	self.isSimpleShow = true
	self.isSingle = false
	self.simpleCallback = callback

	self:creatRaffleRoleRoot()

	--根据去重列表加载人物
	for roleCid, _ in pairs(self.needRoleIdList) do
		self:loadShowRole(roleCid)
	end

	self:loadEtaRole(function()
		---@type RaffleController
		local control = self.raffleController
		control.effectCamera:SetActive(false)
		control.srEta:SetActive(false)
		control.ssrEta:SetActive(false)
		control.effectRoot:SetActive(false)
		control.getSR:SetActive(false)
		control.getSSR:SetActive(false)

		self:hideWriteMask()
		

		local uibase = UIMgr:GetUI("MainPanel")
		if uibase ~= nil then
			local cg = uibase.gameObject:GetComponent(TypeInfo.CanvasGroup)
			if cg ~= nil then
				cg.alpha = 1
			end
		end
		CoveManager.instance().mainVcamObj:SetActive(false)
	end, function()
		local raffleAnimationPanel = UIMgr:GetUI("RaffleAnimationPanel")
		if raffleAnimationPanel then
			local canvas = raffleAnimationPanel.gameObject:GetComponent(TypeInfo.Canvas)
			local layer = canvas.sortingOrder
			--UIMgr:SetRtCanvasOrder()

			local canvasGroup = raffleAnimationPanel.gameObject:GetComponent(TypeInfo.CanvasGroup)
			canvasGroup.alpha = 0
		end
		self:PlayRoleAnimation()
	end)
end


function RaffleMgr:PlayRoleAnimation()
	self.playGetRoleCount = self.playGetRoleCount  + 1
	if self.playGetRoleCount > #self.raffleResultList then
		self:showWriteMask(function()
			self:showAllResultData(function()
				UIMgr:closeSpecificUI("ShowCharacterPanel")
				UIMgr:SetRtCanvasOrder(-100)
				--UIMgr:popUI("MainPanel")
				local uibase = UIMgr:GetUI("MainPanel")
				if uibase ~= nil then
					local cg = uibase.gameObject:GetComponent(TypeInfo.CanvasGroup)
					if cg ~= nil then
						cg.alpha = 1
					end
				end
				self.raffleResultList = {}
				if self.simpleCallback ~= nil then
					self.simpleCallback()
					self.simpleCallback = nil
				end	
				self.isSimpleShow = false
				CoveManager.instance().mainVcamObj:SetActive(true)
			end)
		end)
		--UIMgr:popUIBase("MainPanel")
		return
	end
	if UICommonUtils.Checkobj(self.nowRoleObj) then
		self.nowRoleObj:SetActive(false)
		self.nowRoleObj = nil
	end

	local resultData = self.raffleResultList[self.playGetRoleCount]
	--SSR和new角色出提示
	if resultData.isSSR or (not resultData.extraType) then
		--UIMgr:closeSpecificUI("ShowCharacterPanel")
		UIMgr:popUICover("SSRTipsPanel", {roleId = resultData.id, closeFunc = function()
			--测试展示大招timeline
			self:playRoleTimeLine(resultData, function()
				self:showWriteMask(function()
					local uibase = UIMgr:GetUI("ShowCharacterPanel")
					if uibase == nil then
						UIMgr:popUICover("ShowCharacterPanel", {closeFunc = function()
							self:PlayRoleAnimation()
						end})

					else
						uibase:OnOpen({closeFunc = function()
							self:PlayRoleAnimation()
						end})
					end
				end)
			end)
		end})
	else

		self:playRoleGetVoice(resultData)
		local uibase = UIMgr:GetUI("ShowCharacterPanel")
		if uibase == nil then
			UIMgr:popUICover("ShowCharacterPanel", {closeFunc = function()
				self:PlayRoleAnimation()
			end})
		else
			uibase:OnOpen({closeFunc = function()
				self:PlayRoleAnimation()
			end})
		end
	end


end





return RaffleMgr