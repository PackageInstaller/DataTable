require "class"
---@class BattleStoryManager
local BattleStoryManager = class("BattleStoryManager")
local BattleCore = require "BattleCore"

function BattleStoryManager:ctor()
	BattleCore.ds("BattleStoryManager ctor")
	self._map = nil					--BattleMap
	self._showMgr = nil				--BattleShowManager
	self._nowCutId = 1				--当前cut ID
	self._scriptData = {}			--当前加载的故事脚本文件
	self._scenarioData = {}			--故事脚本数据
	self._isEditorMode = false		--是否编辑器模式
	self._selectAreaObj = nil		--编辑器下选中的地图格子
	self._autoPlay = false			--是否自动播放
	self:clearNowPlayCut()			--当前正在播放的cut
	self.roleBlockIdList = {}		--人物当前位置列表
	self._endCallbackFunc = nil		--剧情播放完成后的外部传入回调
	self._nowStoryId = 0			--当前故事id(对应StoryArrary表)
	self._storyArrayIndex = 1		--当前故事段落id(多端剧情衔接使用)
	self._isBattleDialogMode = false--是否战中演出模式
	self.dialogRoleList = {}		--战中创建的角色列表
	self.mapId = 0					--当前剧情使用的地图ID
	self.storySceneEffectList = {}	--场景特效列表
	self.roleSpeakAutoList = {}		--正在自动播放对话的角色列表
	self.canSkip = true				--是否可以跳过剧情
end

function BattleStoryManager:clear()
	UIMgr:closeSpecificUI("BattleStoryPanel")
	UIMgr:closeSpecificUI("BattleStoryEditorPanel")
	self._map = nil
	self._showMgr = nil
	self._nowCutId = 1
	self._scriptData = {}
	self._scenarioData = {}
	self._isEditorMode = false
	self._selectAreaObj = nil
	self._autoPlay = false
	self:clearNowPlayCut()
	self.roleBlockIdList = {}
	self._endCallbackFunc = nil
	self._nowStoryId = 0
	self._storyArrayIndex = 1
	self._isBattleDialogMode = false
	self.dialogRoleList = {}
	self.mapId = 0
	self:clearSceneEffect()
	self.roleSpeakAutoList = {}
	self.canSkip = true
end

--重播或直接播放下段剧情使用的重置方法
function BattleStoryManager:replay()
	UIMgr:closeSpecificUI("BattleStoryPanel")
	UIMgr:closeSpecificUI("BattleStoryEditorPanel")
	self._map = nil
	self._showMgr = nil
	self._nowCutId = 1
	self._scriptData = {}
	self._scenarioData = {}
	self._isEditorMode = false
	self._selectAreaObj = nil
	self._autoPlay = false
	self:clearNowPlayCut()
	self.roleBlockIdList = {}
	self._isBattleDialogMode = false
	self.dialogRoleList = {}
	self.mapId = 0
	self:clearSceneEffect()
	self.roleSpeakAutoList = {}
end

--置空当前cut内容
function BattleStoryManager:clearNowPlayCut()
	if self.nowPlayCut then
		DLuaTimer:RemoveTimer(self.nowPlayCut)
		self.nowPlayCut = nil
	end
end

--删除场景特效
function BattleStoryManager:clearSceneEffect()
	for _, effectObj in pairs(self.storySceneEffectList) do
		if UICommonUtils.Checkobj(effectObj) then
			PoolMgr.Free(effectObj)
		end
	end
	self.storySceneEffectList = {}
end

---实例化
---@return BattleStoryManager BattleStoryManager
function BattleStoryManager.instance()
	if (BattleStoryManager._instance == nil) then
		BattleStoryManager._instance = BattleStoryManager:new()
	end
	return BattleStoryManager._instance
end

--Update方法
function BattleStoryManager:update()

	self:upDateMouseFunc()
end

---重置管理器数据
function BattleStoryManager:resetManager()

end

--设置演出初始化数据
function BattleStoryManager:initStoryData()
	--处理剧情脚本数据
	self:setBattleStoryData(true)
	self._autoPlay = false
end

--加载剧情文件
function BattleStoryManager:initStoryLua(isEditorMode)
	if isEditorMode then
		local name = GV.StoryEditorFileName
		local fileName = string.format("%s.lua", name)
		local path = string.format(Config.StoryLuaPath, fileName)
		local file = io.open(path, "r")
		if not file then
			return nil
		end
		self._scriptData = loadstring(file:read("*a"))()
		file:close()
	else
		local storyConfig = Config.GetStoryArraryInfo(self._nowStoryId)
		local name = storyConfig.storyArrary[self._storyArrayIndex]
		self._scriptData = require(name)
		self.canSkip = storyConfig.canNotSkip ~= 1
	end
	for key, singleData in pairs(self._scriptData) do
		--和谐文字处理
        if GV.IsCensoredMode and (singleData.actType == GE.BattleStoryAction.RoleSpeak
		 or singleData.actType == GE.BattleStoryAction.RoleSpeakAuto) then
            for key, value in pairs(singleData) do
				if string.find(key, "Censored") then
					local needKey = string.gsub(key, "Censored", "")
					singleData[needKey] = value
				end
			end
        end
	end
end

--处理剧情脚本数据
function BattleStoryManager:setBattleStoryData(needPlay)
	local initData = {}
	local needData = {}
	self.roleIdList = {}
	self.nowInitNum = 1--地图算一步
	self.initDoPlay = needPlay or false

	for _, v in pairs(self._scriptData) do
		if v.cutId == 0 then--初始化类型单独挑出
			table.insert(initData, v)
		else
			if not needData[v.cutId] then
				needData[v.cutId] = {}
			end
			table.insert(needData[v.cutId], v)
		end
	end

	self._scenarioData = needData

	self.initResNumber = tablex.size(initData)
	for _, data in pairs(initData) do
		if data.actType == GE.BattleStoryAction.InitRole then
			--创建角色
			table.insert(self.roleIdList, data.target)
			self:initCreatRole(data)
		elseif data.actType == GE.BattleStoryAction.InitCamera then
			--初始化相机
			self:initCamera(data)
		elseif data.actType == GE.BattleStoryAction.InitSceneEffect then
			--初始化场景特效
			self:initSceneEffect(data)
		end
	end
end

--播放OneCut演出
function BattleStoryManager:DoPlayOneCut()
	if self.nowPlayCut then
		return
	end
	local cutData = self._scenarioData[self._nowCutId]
	table.sort(cutData, function (a, b)
		return a.id < b.id
	end)
	local setDelayTime = nil
	local delayTimeList = {}
	if not cutData then
		--TODO剧情结束
		return
	end

	self:hideShowBubbles(cutData)

	BattleCore.ds("^^^^cutData^^^^", tablex.dump(cutData))

	local isSpeak = false
	for _, actionData in pairs(cutData) do
		if actionData.actType == GE.BattleStoryAction.RoleMove then
			table.insert(delayTimeList, self:doRoleMove(actionData))
		elseif actionData.actType == GE.BattleStoryAction.RoleTurn then
			table.insert(delayTimeList, self:doRoleTurn(actionData))
		elseif actionData.actType == GE.BattleStoryAction.RoleAction then
			table.insert(delayTimeList, self:doRoleAction(actionData))
		elseif actionData.actType == GE.BattleStoryAction.RoleSpeak then
			table.insert(delayTimeList, self:doRoleSpeak(actionData))
			isSpeak = true
		elseif actionData.actType == GE.BattleStoryAction.RoleSpeakAuto then
			table.insert(delayTimeList, self:doRoleSpeakAuto(actionData))
		elseif actionData.actType == GE.BattleStoryAction.RoleEmote then
			table.insert(delayTimeList, self:doRoleEmoteBubbles(actionData))
		elseif actionData.actType == GE.BattleStoryAction.CameraMove then
			table.insert(delayTimeList, self:doCameraMove(actionData))
		elseif actionData.actType == GE.BattleStoryAction.CameraZoom then
			table.insert(delayTimeList, self:doCameraZoom(actionData))
		elseif actionData.actType == GE.BattleStoryAction.Wait then
			setDelayTime = self:doWaitTime(actionData)
		elseif actionData.actType == GE.BattleStoryAction.SetBGM then
			table.insert(delayTimeList, self:doSetBGM(actionData))
		elseif actionData.actType == GE.BattleStoryAction.PlaySE then
			table.insert(delayTimeList, self:doPlaySE(actionData))
		elseif actionData.actType == GE.BattleStoryAction.GalStory then
			self:doPlayAVG(actionData)
			return
		elseif actionData.actType == GE.BattleStoryAction.RoleVisible then
			table.insert(delayTimeList, self:doRoleVisible(actionData))
		elseif actionData.actType == GE.BattleStoryAction.RoleAttack then
			table.insert(delayTimeList, self:doRoleAttack(actionData))
		elseif actionData.actType == GE.BattleStoryAction.ShowEffect then
			table.insert(delayTimeList, self:doShowEffect(actionData))
		elseif actionData.actType == GE.BattleStoryAction.ChangeCamera then
			table.insert(delayTimeList, self:doChangeCamera(actionData))
		elseif actionData.actType == GE.BattleStoryAction.Curtain then
			table.insert(delayTimeList, self:doCurtain(actionData))
		elseif actionData.actType == GE.BattleStoryAction.RoleTeleport then
			table.insert(delayTimeList, self:doRoleTeleport(actionData))
		elseif actionData.actType == GE.BattleStoryAction.HomeLandBuildingLVUp then
			table.insert(delayTimeList, self:doHomeLandBuildingLVUp(actionData))
		elseif actionData.actType == GE.BattleStoryAction.HomelandCameraMove then
			self:doHomeLandCameraMove(actionData)--移动家园原本的相机,为剧情结束后出现在特殊位置做准备
		elseif actionData.actType == GE.BattleStoryAction.EndStory then
			self:doEndPerformance(actionData)
			--TODO剧情结束
			return
		end
	end
	--设置onecut的播放时长
	table.sort(delayTimeList, function(a, b)
		return a > b
	end)
	local needDelayTime = delayTimeList[1]
	if setDelayTime then
		needDelayTime = setDelayTime
	end

	--根据时常播放下一cut剧情
	self._nowCutId = self._nowCutId + 1
	if not self._autoPlay and isSpeak then
		return
	end
	self.nowPlayCut = DLuaTimer:DoAfter(needDelayTime, function()
		self.nowPlayCut = nil
		self:DoPlayOneCut()
	end)
end

--自动播放(播放或停止)
function BattleStoryManager:ChangeAutoPlay()
	if self._autoPlay then
		self._autoPlay = false
	else
		self._autoPlay = true
		self:DoPlayOneCut()
	end
end

--资源初始化完成后再播放
function BattleStoryManager:startScreenPlay()
	--根据是否编辑模式区别打开方式
	if self:getEditorMode() then
		UIMgr:popUICover("BattleStoryPanel", {roleIdList = self.roleIdList, openFunc = function()
			if self.initDoPlay then
				self:DoPlayOneCut()
			end
		end})
	else
		UIMgr:popUI("BattleStoryPanel", {roleIdList = self.roleIdList, openFunc = function()
			if self.initDoPlay then
				self:DoPlayOneCut()
			end
		end})
	end
	
end

----------------场景定义-------------------
--创建场景
function BattleStoryManager:initCreatMap(storyId, callBack, checkIsLoadedMapId)
	self._battleMgr = BattleCore:getBattleMgr()
	local clientBattleMgr = ClientBattleManager.getInstance()
	self._showMgr = clientBattleMgr:getShowManager()
	self._map = self._battleMgr:getMap()
	self._showMgr:setMap(self._map)

	--加载剧情文件
	self:setNowStoryId(storyId)
	self:initStoryLua(self:getEditorMode())

	self.mapId = self._scriptData[1].target
	if checkIsLoadedMapId and self.mapId == checkIsLoadedMapId then
		self._map:initPVMap(self.mapId, callBack)
		return
	end
	local mapConfig = Config.GetBattleMapInfo(self.mapId)
	local mapPath = string.format(Config.ScenePath.BattleMapScene, mapConfig.resource,mapConfig.resource)
	ResMgr:LoadSceneAsyncLua(mapPath, false, function(sceneName)
        print("_initBattle LoadSceneAsync",sceneName)
		LoadingMgr:UpdateProgress(1)
		self._map:initPVMap(self.mapId, callBack)
    end)
end

--独立家园剧情初始化：直接注入 showMgr 与 map，不依赖战斗框架
---@param showMgr BaseShowManager
---@param map BaseMap
---@param storyId integer
---@param callBack function
function BattleStoryManager:initHomestory(showMgr, map, storyId, callBack)
	self._showMgr = showMgr
	self._map = map
	showMgr:setMap(map)

	self:setNowStoryId(storyId)
	self:initStoryLua(self:getEditorMode())

	self.mapId = self._scriptData[1].target
	self._map:initPVMap(self.mapId, callBack)
end

--创建角色
function BattleStoryManager:initCreatRole(data)
	local roleId = data.target--角色cid
	local blockCid = tonumber(data.parameter1)--位置格子cid
	local creatDir = tonumber(data.parameter2)--角色朝向
	local roleAction = data.parameter3 and RoleAnimStateType[data.parameter3] or RoleAnimStateType.IdleShip--角色动作
	local isShow = true
	if data.parameter4 then
		isShow = data.parameter4 == 1
	end
	local storyResConfig = Config.GetStoryResourceInfo(roleId)
	local skinConfig = Config.GetCharacterSkinInfo(storyResConfig.model)
	local modelKey = skinConfig.modelKey
	if data.parameter5 then
		modelKey = data.parameter5
	end
	local blockData = self._map:getBlockByCid(blockCid)
	if not blockData then
		return
	end
	---@type RoleCreateData
	local roleData = {
		cid = roleId,
		id = roleId,
		blockId = blockData.id,
		image = modelKey,--皮肤改为直接加载对应资源
		modelRate = skinConfig.modelRate,
		modelOffset = skinConfig.modelOffset,
		hpBarOffset = skinConfig.hpBarOffset,
		direction = creatDir,
		delay = 0,
		roleAction = roleAction,
		isShow = isShow,
		storyCamp = storyResConfig.camp,
		isNPC = StoryMgr:getIsHomeLandStory(),
		moveShowType = skinConfig.moveShowType,
		isShowEffect = false,
	}
	self._showMgr:roleCreate(roleData, function()
		-- self._showMgr:showOrHideRole(roleId, isShow)
		self._showMgr:setRoleUIActive(roleId, false)
		self.roleBlockIdList[roleId] = blockData.id
		if not self:getDialogMode() then
			self.nowInitNum = self.nowInitNum + 1
			if self.nowInitNum >= self.initResNumber then
				self:startScreenPlay()
			end
		else
			self.dialogRoleList[roleId]	= true
		end
	end, true)
end

--相机初始化
function BattleStoryManager:initCamera(data)
	local blockCid = tonumber(data.parameter1)--位置格子cid
	local zoomDistance = -tonumber(data.parameter2)--缩放率
	local mapAngle = data.parameter3 and tonumber(data.parameter3) or 0--地图角度

	local moveblock = self._map:getBlockByCid(blockCid)
	self._showMgr:lookAtBlock(moveblock.id, false)
	self._showMgr:refreshViewDistanceByFinalValue(zoomDistance, false)

	self._showMgr:setMapAngle(mapAngle)
	self._showMgr:ResetCameraAngle(false)

	if StoryMgr:getIsHomeLandStory() then
		self._showMgr.cameraRoot:SetActive(true)
	end

	self.nowInitNum = self.nowInitNum + 1
	if self.nowInitNum >= self.initResNumber then
		self:startScreenPlay()
	end
end

--场景特效初始化
function BattleStoryManager:initSceneEffect(data)
	local effectList = loadstring("return " .. data.parameter1)()
	for _, effectId in pairs(effectList) do
		local effectConfig = Config.GetSoundAndEffectInfo(effectId)
		if effectConfig then
			local prefabPath = string.format(Config.PrefabPath.BattleEffect, effectConfig.effectResource, effectConfig.effectResource)
			PoolMgr:Get(prefabPath, function (obj)
				local effectObj = obj
				effectObj.transform:SetParent(self._showMgr.cameraRoot.transform, false)
				effectObj.transform.localScale = Vector3.one
				effectObj.name = effectConfig.effectResource
				table.insert(self.storySceneEffectList,effectObj)

				self.nowInitNum = self.nowInitNum + 1
				if self.nowInitNum >= self.initResNumber then
					self:startScreenPlay()
				end
			end)
		end
	end
end

---------------可使用的演出方法---------------
--角色说话
function BattleStoryManager:doRoleSpeak(data)
	local words = data.parameter4--对话内容

	local BattleStoryPanel = UIMgr:getUIData("BattleStoryPanel")
	if BattleStoryPanel then
		BattleStoryPanel.ui:doSpeakBubblesData(data)
	end

	return #words / 3 * 0.05 + 1
end

--角色对话(自动播放下一cut)
function BattleStoryManager:doRoleSpeakAuto(data)
	local words = data.parameter4--对话内容
	local waitTime = data.parameter7--自动播放等待时间

	local BattleStoryPanel = UIMgr:getUIData("BattleStoryPanel")
	if BattleStoryPanel then
		BattleStoryPanel.ui:doSpeakBubblesData(data)
	end

	return waitTime or #words / 3 * 0.05 + 1
end

--角色移动
function BattleStoryManager:doRoleMove(data)
	local roleId = data.target--角色cid
	local nowBlockCid = tonumber(data.parameter1)--起始格子cid
	local moveBlockCid = tonumber(data.parameter2)--移动格子cid
	local moveAction = data.parameter3--移动动作
	local stopAction = data.parameter4--停止动作
	local noTurn = data.parameter6 and true or false--是否不转向
	local moveZ = data.parameter7 and tonumber(data.parameter7) or 0--移动Z轴偏移
	local nowBlock
	if nowBlockCid then
		nowBlock = self._map:getBlockByCid(nowBlockCid)
	else
		nowBlock = self._map:getBlockById(self.roleBlockIdList[roleId])
	end
	local newBlock = self._map:getBlockByCid(moveBlockCid)

	--根据格子行列数计算距离
	local distance = math.sqrt((newBlock.col - nowBlock.col)^2 + (newBlock.row - nowBlock.row)^2)
	local moveTime = 0
	if StoryMgr:getIsHomeLandStory() then
		local newscale = self._showMgr.blocksObjMap[1].transform.localScale.x	--动态读取地图格子scale
		distance = distance * newscale
		local speed = 0.6
		moveTime = distance / speed
	else
		moveTime = data.parameter5 or (distance * 0.8)--移动时间
	end
	--LuaLogger.ds("^^^^^^distance^^^^^^^", distance, moveTime)

	local data = {
		roleId = roleId,
		blockCid = moveBlockCid,
		moveTime = moveTime,
		nowBlock = nowBlock,
		newBlock = newBlock,
		moveAction = moveAction,
		stopAction = stopAction,
		noTurn = noTurn,
		moveZ = moveZ,
	}
	if StoryMgr:getIsHomeLandStory() then
		self._showMgr:roleMoveHomeLand(data)
	else
		self._showMgr:roleMoveNoPath(data)
	end
	self.roleBlockIdList[roleId] = newBlock.id
	return moveTime
end

--角色转向
function BattleStoryManager:doRoleTurn(data)
	local roleId = data.target
	local creatDir = data.parameter1 and tonumber(data.parameter1)--角色朝向
	local roleAngle = data.parameter2 and tonumber(data.parameter2)--角色角度
	local role = self._showMgr:getRole(roleId)
	if role then
		if creatDir then
			role.model:TurnDirection(creatDir)
		elseif roleAngle then
			local nowRotation = role.model.transform.localEulerAngles
			local changeRotationY = roleAngle - nowRotation.y
			local rotatingTime = math.max(0.3, math.abs(changeRotationY) / 360)
			rotatingTime = math.min(0.5, rotatingTime)
			local newRotation = Vector3.New(nowRotation.x, roleAngle, nowRotation.z)
			role.model.transform:DOLocalRotate(newRotation, rotatingTime)
		end
	end

	return 1
end

--角色动作
function BattleStoryManager:doRoleAction(data)
	local roleId = data.target
	local times = data.parameter1 or 1
	local animName = data.parameter2
	local animType = data.parameter3
	local role = self._showMgr:getRole(roleId)
	local model = role.model

	if (model) then
		if animType == 1 then--修改持续性动作
			model:SetDefaultState(RoleAnimStateType[animName])
			return 0.5
		else--次数播放动作
			local playAnimName = RoleModelAnimEnum[animName]
			model:PlayAnim(playAnimName)
			local animtime = model:GetAnimationPlayTime(playAnimName)
			if times > 1 then
				for i = 1, times - 1 do
					DLuaTimer:DoAfter(animtime * i, function ()
						model:PlayAnim(playAnimName)
					end)
				end
			end
			return animtime * times
		end
	end
end

--相机移动
function BattleStoryManager:doCameraMove(data)
	local moveBlockCid = tonumber(data.parameter1)--位置格子cid
	local moveTime = data.parameter2 and tonumber(data.parameter2) or 1--移动时间
	local moveRoleCid = data.parameter3--目标角色cid
	local needBlockId = 0
	if moveRoleCid then
		needBlockId = self.roleBlockIdList[moveRoleCid]
	else
		needBlockId = self._map:getBlockByCid(moveBlockCid).id
	end
	local data = {
		time = moveTime,
	}
	self._showMgr:lookAtBlock(needBlockId, data)

	return moveTime
end

--镜头缩放
function BattleStoryManager:doCameraZoom(data)
	local zoomDistance = -tonumber(data.parameter1)--缩放率
	local zoomTime = data.parameter2 and tonumber(data.parameter2) or 1--缩放时间
	self._showMgr:refreshViewDistanceByFinalValue(zoomDistance, true, zoomTime)

	return zoomTime
end

--手动等待时间
function BattleStoryManager:doWaitTime(data)
	local waitTime = tonumber(data.parameter1)--等待时间
	return waitTime
end

--角色表情气泡
function BattleStoryManager:doRoleEmoteBubbles(data)
	local data = {
		roleId = data.target,
		emoteName = data.parameter1,
	}
	local BattleStoryPanel = UIMgr:getUIData("BattleStoryPanel")
	if BattleStoryPanel then
		return BattleStoryPanel.ui:doSpeakEmoteData(data)
	end

	return 1.5
end

--切换bgm
function BattleStoryManager:doSetBGM(data)
	local name = data.parameter1
	local fadeTime = data.parameter2
	if name == "stop" then
		AudioMgr:StopCurrBgm(fadeTime)
	else
		local musicPath = string.format("Audio/BGM/%s.mp3", name)
		self:LuaPlayBgmFade(musicPath, true, nil, fadeTime)
	end

	return 0.5
end

--播放音效
function BattleStoryManager:doPlaySE(data)
	local name = data.parameter1
	local times = data.parameter2
	local SE = string.format(Config.table.AudioConfigTable.SE, name)
    self:play2DSound(SE, nil, times)

	return 0.5
end

--插入Avg剧情
function BattleStoryManager:doPlayAVG(data)
	local avgId = data.target
	UIMgr:popUI("StoryPanel", {storyName = "avg_"..avgId, callBack = function()
		self._nowCutId = self._nowCutId + 1
		self.nowPlayCut = nil
		self:DoPlayOneCut()
	end, callBackAfter = function()
		LoadingMgr:SetUIQuickSwitchOver()
	end, needEndLoading = true})
end

--角色显隐
function BattleStoryManager:doRoleVisible(data)
	local roleId = data.target
	local isShow = data.parameter1 == 1
	if isShow then
		local roleCamp = GE.BattleCampType.Enemy
		local storyResConfig = Config.GetStoryResourceInfo(roleId)
		if storyResConfig then
			roleCamp = storyResConfig.camp
		end
		local blockObj = self._showMgr:getBlockObj(self.roleBlockIdList[roleId])
		self._showMgr:doShowRoleEffect(roleCamp, blockObj)
	end
	self._showMgr:showOrHideRole(roleId, isShow, false)
	if data.parameter1 == 3 then--移除角色
		self._showMgr:roleRemove({id = roleId})
		self.roleBlockIdList[roleId] = nil
		if self:getDialogMode() then
			self.dialogRoleList[roleId]	= nil
		end
	end

	return 0.5
end

--角色攻击
function BattleStoryManager:doRoleAttack(data)
	local delayTime = 2
	local roleId = data.target
	local roleSkillId = data.parameter1 or 1
	local targetId = data.parameter2

	--攻击
	local storyResConfig = Config.GetStoryResourceInfo(roleId)
	local skinConfig = Config.GetCharacterSkinInfo(storyResConfig.model)
	local attackData = {
		id = roleId,
		animName = skinConfig["skillAct"..roleSkillId],
		effectName = skinConfig["skillActEff"..roleSkillId],
	}
	self._showMgr:roleAttack(attackData)
	--子弹
	local bulletData = {
		index = 1,
		roleId = roleId,
		targetRoleId = targetId,
		blockId = self.roleBlockIdList[roleId],
		targetBlockId = self.roleBlockIdList[targetId],
		-- bulletName = "bullet2",--skinConfig["skillHitEff"..roleSkillId][1],
		-- speed = 1,
		-- curve = Vector3.New(0, 0.5, 0),
		shootEffect = 1077,
		hitEffect = 1081,
		hitResult = {
			dmg = 100,
			isCrit = false, 		 -- 是否暴击
			restraintCorrect = 1,  	-- 克制系数
			type = GE.BulletHitType.Hit  -- 受击类型
		},
		dmgDelay = 0,
		-- focus = 0.5
	}
	self._showMgr:justHit(bulletData, function()
		--受击
		local role = self._showMgr:getRole(targetId)
		local model = role.model
		model:PlayAnim(RoleModelAnimEnum.Hit)
		--受击特效
		local pos = model.transform.position + Vector3(0,0.3,0)
		self._showMgr:playEffect(pos, 1074)
	end, true)

	return delayTime
end

--特效演出
function BattleStoryManager:doShowEffect(data)
	local blockCid = data.target
	local effectId = data.parameter1
	local delayTime = data.parameter2 or 2
	local cameraShake = data.parameter3 and loadstring("return " .. data.parameter3)()
	local blockId = self._map:blockCidToId(blockCid)

	local blockObj = self._showMgr:getBlockObj(blockId)
	if blockObj then
		self._showMgr:playEffect(blockObj.transform.position, effectId)
	end

	--镜头震动
	if UICommonUtils.Checkobj(self._showMgr.mainVcam) and cameraShake then
		local shakeTime = cameraShake[1]
		local shakeOffset = cameraShake[2]
		local shakeTimes = cameraShake[3]
		self._showMgr.mainVcam.transform:DOShakePosition(shakeTime, Vector3.New(shakeOffset, shakeOffset, 0), shakeTimes):OnComplete(function()
            self._showMgr.mainVcam.transform.localPosition = Vector3.New(0, 0, self._showMgr.mainVcam.transform.localPosition.z)
        end)
	end

	return delayTime
end

--切换相机
function BattleStoryManager:doChangeCamera(data)
	local needData = {
		id = data.target,
		isChange = data.parameter1 == 1,
		targets = data.parameter2 and loadstring("return " .. data.parameter2)() or {},
		offsetRot = data.parameter3 and loadstring("return " .. data.parameter3)() or {10,0},
		offsetPos = data.parameter4 and loadstring("return " .. data.parameter4)() or {0,0.5,0},
		distance = data.parameter5 or 2,
	}
	self._showMgr:changeStoryVcam(needData)

	return 5
end

--幕布
function BattleStoryManager:doCurtain(data)
	local isShow = data.parameter1 == 1
	local BattleStoryPanel = UIMgr:getUIData("BattleStoryPanel")
	if BattleStoryPanel then
		local needCanvasGroup = BattleStoryPanel.ui.curtain.canvasGroup
		if isShow then
			needCanvasGroup.blocksRaycasts = true
			needCanvasGroup:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.OutQuart)
		else
			needCanvasGroup:DOFade(0, 0.5):SetEase(DG.Tweening.Ease.InQuart):OnComplete(function()
				needCanvasGroup.blocksRaycasts = false
			end)
		end
	end

	return 0.5
end

--角色瞬移
function BattleStoryManager:doRoleTeleport(data)
	local roleId = data.target
	local moveBlockCid = tonumber(data.parameter1)--移动格子cid
	local newBlock = self._map:getBlockByCid(moveBlockCid)
	local data = {
		roleId = roleId,
		blockCid = moveBlockCid,
	}
	self._showMgr:roleTeleport(data)
	self.roleBlockIdList[roleId] = newBlock.id

	return 0.5
end

--播放家园建筑升级动画
function BattleStoryManager:doHomeLandBuildingLVUp(data)
	local delayTime = 2
	local buildingId = data.parameter1--建筑id
	local dontshowLvUp = data.parameter2 and true or false--是否需要显示升级面板
	GameMsgMgr:sendEvent(GameMsgType.BulidingLvChange, buildingId)
    GameMsgMgr:sendEvent(GameMsgType.RefreshHomeFuncPanel)
	if not dontshowLvUp then
		StoryMgr:setNeedShowHomeLvUpPanel(true)
	end
	StoryMgr:setHomeLvUpSkipCallback(nil)
	return delayTime
end

--移动家园原本的相机
function BattleStoryManager:doHomeLandCameraMove(data)
	local buildingId = data.parameter1--建筑id
	local coveManager = CoveManager.instance()
    coveManager:setCameraPositionByFuncId(buildingId)
end

--结束演出
function BattleStoryManager:doEndPerformance(data)
	local BattleStoryPanel = UIMgr:getUIData("BattleStoryPanel")
	if BattleStoryPanel then
    	self:clearNowPlayCut()
		BattleStoryPanel.ui:doEndStory(data)
	end
end

--------------战中对话相关方法--------------

function BattleStoryManager:initDialogMode(storyId)
	self:setNowStoryId(storyId)
	self:initStoryLua()
	self:changeDataToBattle()
	self:setBattleDialogData()
	DLuaTimer:DoAfter(0.5, function()
		self:DoPlayOneCut()
	end)
end

function BattleStoryManager:changeDataToBattle()
	self._battleMgr = BattleCore:getBattleMgr()
	self._showMgr = self._battleMgr:getShowManager()
	self._map = self._battleMgr:getMap()
	local roleMgr = self._battleMgr:getRoleManager()
	--角色cid转换为战斗中的实例化id
	for k, dialogData in pairs(self._scriptData) do
		local battleRole = roleMgr:getRoleByCidNoCamp(dialogData.target)
		if battleRole then
			self._scriptData[k].target = battleRole.id
		end
		local battleRole = roleMgr:getRoleByCidNoCamp(dialogData.parameter2)
		if battleRole then
			self._scriptData[k].parameter2 = battleRole.id
		end
	end
end

--处理战中剧情脚本
function BattleStoryManager:setBattleDialogData()
	local initData = {}
	local needData = {}
	local roleIdList = {}
	local targetIdList = {}
	for _, v in pairs(self._scriptData) do
		if v.cutId == 0 then--初始化类型单独挑出
			table.insert(initData, v)
		else
			if not needData[v.cutId] then
				needData[v.cutId] = {}
			end
			table.insert(needData[v.cutId], v)
		end
		if v.target and not targetIdList[v.target] then
			targetIdList[v.target] = 1
		end
	end

	for id, _ in pairs(targetIdList) do
		table.insert(roleIdList, id)
	end

	self._scenarioData = needData

	--给已存在的战中角色赋位置值
	for idOrCid, value in pairs(self._showMgr.rolesMap) do
		local role = self._battleMgr:getRoleManager():getRole(idOrCid)
		self.roleBlockIdList[idOrCid] = role.block.id
	end

	--初始化剧情需要的角色
	for _, data in pairs(initData) do
		if data.actType == GE.BattleStoryAction.InitRole then
			--创建角色
			self:initCreatRole(data)
		end
	end

	--剧情UI界面
	UIMgr:popUI("BattleStoryPanel", {roleIdList = roleIdList})
end

------------------------------------------


---------------编辑器相关方法---------------
--编辑器模式初始化
function BattleStoryManager:initEditorMode()
	self._battleMgr = BattleCore:getBattleMgr()
	self._showMgr = self._battleMgr:getShowManager()

	self:initCreatMap(nil, function()
	    self._showMgr:loadPVRoot(function()
			--处理剧情脚本数据
			self:setBattleStoryData()
			LoadingMgr:SetLoadingOver(function()
				UIMgr:popUICover("BattleStoryEditorPanel",{storyName = GV.StoryEditorFileName})
			end, nil, "BattleStoryManager")
		end)
	end)
end

--鼠标控制逻辑
function BattleStoryManager:upDateMouseFunc()
	--编辑器模式才可使用点击逻辑
	if not self:getEditorMode() then
		return
	end
	
	--判空处理
	if not self._showMgr then
		return
	end
	local camera = self._showMgr.camera
	--左键长按
	if (Input.GetMouseButton(0)) then
		if (self._initialPosition and UnityEngine.Vector3.Distance(Input.mousePosition, self._initialPosition) > 30) then
			self._isDragging = true;
		end
		if (self._isDragging) then
			if (not self._lastMousePosition) then
				self._lastMousePosition = Input.mousePosition
			end
			self._showMgr:moveCamera(Input.mousePosition)
			self._lastMousePosition = Input.mousePosition
			return
		end
	end

	--左键点下
	if (Input.GetMouseButtonDown(0)) then
		if (self._battleMgr:isPointerOverUIObject()) then
			-- 检测到UI
			return
		end
		if self._isDragging then
			return
		end
		if UICommonUtils.Checkobj(self._selectAreaObj) then
			PoolMgr.Free(self._selectAreaObj)
			self._selectAreaObj = nil
		end

		if (camera) then
			self._initialPosition = Input.mousePosition
			local ray, hit = UnityEngine.Physics.Raycast(camera.main:ScreenPointToRay(Input.mousePosition), nil, 9999, LayerMask.GetMask("Square"))
			if (hit ~= nil) then
				local hitObj = hit.transform.gameObject
				local block = self._showMgr:getBlockByObj(hitObj)
				if not block then
					return
				end
				PoolMgr:Get(Config.PrefabPath.MoveArea, function (obj)
					obj.transform.localScale = Vector3.New(1, 1, 1)
					self._selectAreaObj = obj
					self._nowSelectBlock = self._showMgr:getBlockObj(block.id)
					BattleCore.ds("<color=#00FF0D>剧情编辑器 => 格子Cid ="..block.cid .."</color>")
					self._selectAreaObj.transform.position = self._nowSelectBlock.transform.position
					self._selectAreaObj:SetActive(true)
				end)
				self._isDragging = false
			end
		end
	end

	--左键抬起
	if (Input.GetMouseButtonUp(0)) then
		self._lastMousePosition = nil
		self._initialPosition = nil
		self._isDragging = false
		self._showMgr:clearLastMousePosition()
	end

	--右键按下
	if (Input.GetMouseButtonDown(1)) then
		if (self._battleMgr:isPointerOverUIObject()) then
			-- 检测到UI
			return
		end
		if (camera) then
			local ray, hit = UnityEngine.Physics.Raycast(camera.main:ScreenPointToRay(Input.mousePosition), nil, 9999, LayerMask.GetMask("Square"))
			if (hit ~= nil) then
				local hitObj = hit.transform.gameObject
				if hitObj == self._nowSelectBlock then
					local block = self._showMgr:getBlockByObj(hitObj)
					local BattleStoryEditorPanel = UIMgr:getUIData("BattleStoryEditorPanel")
    				if BattleStoryEditorPanel then
						BattleStoryEditorPanel.ui:showNewAction({block = block})
					end
				end
				--LuaLogger.ds("^^^^^^^^!!!^^^^^^^^", hitObj.name)
			end
		end

	end

	--视野缩放
	local zoomSpeed = 3
	local scroll = Input.GetAxis("Mouse ScrollWheel")
	self._showMgr:refreshViewDistance(scroll * zoomSpeed, false)

	--视野旋转
	local rotationSpeed = 10.0
	if (Input.GetMouseButtonDown(2)) then
		self._isRotating = true
		self._lastRotatingMousePosition = Input.mousePosition
	end

	if (Input.GetMouseButtonUp(2)) then
		self._isRotating = false
		self._lastRotatingMousePosition = nil
	end

	if (self._isRotating and self._lastRotatingMousePosition) then
		local delta = {x = Input.mousePosition.x - self._lastRotatingMousePosition.x, y = Input.mousePosition.y - self._lastRotatingMousePosition.y}
		self._showMgr:refreshViewRotat(delta.x * rotationSpeed * Time.deltaTime, true)
		self._lastRotatingMousePosition = Input.mousePosition
	end
end

--设置是否编辑器模式
function BattleStoryManager:setEditorMode(isEditorMode)
	self._isEditorMode = isEditorMode
end

--获取是否编辑器模式
function BattleStoryManager:getEditorMode()
	return self._isEditorMode
end

-------------------------------------------

--设置剧情完成后回调
function BattleStoryManager:setEndCallbackFunc(endCallback)
	self._endCallbackFunc = endCallback
end

--获取剧情完成后回调方法
function BattleStoryManager:getEndCallbackFunc()
	return self._endCallbackFunc
end

--设置当前剧情id
function BattleStoryManager:setNowStoryId(storyId)
	self._nowStoryId = storyId
end

--获取当前剧情id
function BattleStoryManager:getNowStoryId()
	return self._nowStoryId
end

--设置是否战中演出模式
function BattleStoryManager:setDialogMode(isBattleDialog)
	self._isBattleDialogMode = isBattleDialog
end

--获取是否战中演出模式
function BattleStoryManager:getDialogMode()
	return self._isBattleDialogMode
end

--设置正在自动说话的角色列表
function BattleStoryManager:setRoleSpeakAutoList(roleId, isAuto)
	self.roleSpeakAutoList[roleId] = isAuto
end

--隐藏使用过的气泡格子
function BattleStoryManager:hideShowBubbles(cutData)
	local bubblesObjList = {}
	local battleStoryPanel = UIMgr:getUIData("BattleStoryPanel")
	if battleStoryPanel then
		bubblesObjList = battleStoryPanel.ui.bubblesObjList
	end
	if not next(bubblesObjList) then
		return
	end
	local roleList = {}
	for _, actionData in pairs(cutData) do
		local roleId = actionData.target
		if actionData.actType == GE.BattleStoryAction.RoleSpeak then
			roleList[roleId] = true
		end
		if actionData.actType == GE.BattleStoryAction.RoleSpeakAuto then
			if not self.roleSpeakAutoList[roleId] then
				self:setRoleSpeakAutoList(roleId, true)
			end
		end
	end

	for cid, bubbleData in pairs(bubblesObjList) do
		if (not roleList[cid]) and (not self.roleSpeakAutoList[cid]) then
			if UICommonUtils.Checkobj(bubbleData.bubblesObj) then
				bubbleData.bubblesObj.canvasGroup.alpha = 0
			end
		end
	end
end

--判断多段剧情播放
function BattleStoryManager:checkAndDoNextArray()
	local storyConfig = Config.GetStoryArraryInfo(self._nowStoryId)
	self._storyArrayIndex = self._storyArrayIndex + 1
	if storyConfig.storyArrary[self._storyArrayIndex] then
		self._showMgr.battleRoot:GetComponent("DestroyWithCallback"):SetOnDesFunc(function()
			self:initStoryData()
		end)
		GameObject.Destroy(self._showMgr.battleRoot)
		self._battleMgr:clear()
		self:replay()
		return true
	else
		return false
	end
end

return BattleStoryManager