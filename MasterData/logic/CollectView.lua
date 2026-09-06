-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/CollectView.lua

module("logic.extensions.task.view.CollectView", package.seeall)

local CollectView = class("CollectView", ViewComponent)
local defaultCollectTime = 1
local taskIcons = {
	[TaskConst.USER_OP_COMMON] = "icon_taskop_common.png",
	[TaskConst.USER_OP_COLLECT] = "icon_taskop_collect.png",
	[TaskConst.USER_OP_SCAN] = "icon_taskop_scan.png",
	[TaskConst.USER_OP_UNLOCK] = "icon_taskop_unlocking.png",
	[TaskConst.USER_OP_PICK] = "icon_taskop_pick.png",
	[TaskConst.USER_OP_CUTTING] = "icon_taskop_cutting.png",
	[TaskConst.USER_OP_GREET] = "icon_taskop_greet.png"
}
local taskText = {
	[TaskConst.USER_OP_COMMON] = "正在操作",
	[TaskConst.USER_OP_COLLECT] = "正在采集",
	[TaskConst.USER_OP_SCAN] = "正在扫描",
	[TaskConst.USER_OP_UNLOCK] = "正在解锁",
	[TaskConst.USER_OP_PICK] = "正在采摘",
	[TaskConst.USER_OP_CUTTING] = "正在砍伐",
	[TaskConst.USER_OP_GREET] = "正在行礼"
}
local animNames = {
	[TaskConst.USER_OP_UNLOCK] = MainPlayerAnimState.Unlock,
	[TaskConst.USER_OP_CUTTING] = MainPlayerAnimState.Chop,
	[TaskConst.USER_OP_GREET] = MainPlayerAnimState.Salute,
	[TaskConst.USER_OP_PICK] = MainPlayerAnimState.Pick
}
local animsMoreAnims = {
	[TaskConst.USER_OP_CUTTING] = {
		hag = "30001_xunbao_gaotou",
		start = "chop01",
		fixedTime = 2.8,
		loopTime = 2,
		lopping = "chop02"
	}
}
local needListenedAnims = {
	[TaskConst.USER_OP_UNLOCK] = MainPlayerAnimState.Unlock,
	[TaskConst.USER_OP_GREET] = MainPlayerAnimState.Salute,
	[TaskConst.USER_OP_CUTTING] = MainPlayerAnimState.Chop,
	[TaskConst.USER_OP_PICK] = MainPlayerAnimState.Pick
}

function CollectView:buildUI()
	self._canvasGroup = self.mainGO:GetComponent(ComponentType.CanvasGroup)
	self._collectingNode = self:getGo("Collecting")
	self._collectType = self:getGo("CollectType")
	self._collectIcon = Framework.ImageBigBG.GetFrom(self._collectType, "Icon")
	self._collectIconBtn = Framework.ButtonAdapter.Get(self._collectIcon.gameObject)
	self._slider = Framework.SliderAdapter.GetFrom(self.mainGO, "Collecting/Slider")
	self._taskOpName = self:getTxt("Collecting/Text")

	self._slider:SetValue(0)
end

function CollectView:bindEvents()
	self._collectIconBtn:AddClickListener(self._onClickStartCollect, self)
end

function CollectView:unbindEvents()
	self._collectIconBtn:RemoveClickListener()
end

function CollectView:onEnter()
	self._taskTarget = self._viewPresentor._openParam[1]
	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	self._mainPlayer.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)

	self._collectTime = defaultCollectTime
	self._isCollecting = nil
	self._canvasGroup.alpha = 0

	self._collectType:SetActive(true)
	self._collectingNode:SetActive(false)

	if self._taskTarget then
		if not self._taskTarget.target.actionType then
			local opType = self._viewPresentor._openParam[2]

			self._opType = opType
			self._taskOpName.text = taskText[opType]

			self._collectIcon:SetImage("ui/icon/task/" .. taskIcons[opType], self._onIconLoadedFinished, self)
			self:_preLoadAnimModel()
			GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
			GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
		end
	end
end

function CollectView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClosed, self)

	self._taskTarget = nil
	self._collectTime = nil
	self._currVal = nil
	self._isCollecting = nil
	self._opType = nil
	self._preparesAnimTime = nil
	self._waitingStartCollecting = nil

	self._collectIcon:ClearImage()
	self:_clearAnimModel()
	removetimer(self._tickCollecting, self)
	self._mainPlayer.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)

	self._mainPlayer = nil
end

function CollectView:_onIconLoadedFinished()
	self._taskIconLoaded = true

	self:_startShowCollectView()
end

function CollectView:_startShowCollectView()
	if self._taskIconLoaded and self._animModelLoaded then
		self._canvasGroup.alpha = 1
	end
end

function CollectView:_preLoadAnimModel()
	if animsMoreAnims[self._opType] and animsMoreAnims[self._opType].hag then
		self._resModelPath = GameUrl.getSpineUrl(animsMoreAnims[self._opType].hag)

		getres(self._resModelPath, self._onAnimModelLoaded, self, ResType.AssetBundle, true)
	else
		self._animModelLoaded = true

		self:_startShowCollectView()
	end
end

function CollectView:_clearAnimModel()
	if self._resModelPath then
		removeresl(self._resModelPath, self._onAnimModelLoaded, self)

		self._resModelPath = nil
	end

	if self._animModelGo then
		goutil.destroy(self._animModelGo)

		self._animModelGo = nil
	end

	if self._animModelRes then
		self._animModelRes:Release()

		self._animModelRes = nil
	end
end

function CollectView:_onAnimModelLoaded(res)
	local resPath = self._resModelPath

	if not resPath or res.ResPath ~= resPath then
		return
	end

	if res and res.IsSuccess then
		self._animModelRes = res

		self._animModelRes:Retain()

		self._animModelGo = goutil.clone(res:GetMainAsset())

		goutil.setActive(self._animModelGo, false)
		Framework.GameObjectUtil.SetLayerRecursively(self._animModelGo, SceneLayer.MainPlayer_Value)

		self._animModelLoaded = true

		self:_startShowCollectView()
	end
end

function CollectView:_startCollecting()
	self._isCollecting = true

	if not animNames[self._opType] then
		self._mainPlayer.spine:play(animNames[self._opType])
		self:_mainPlayerPlayAni()

		if animsMoreAnims[self._opType] then
			local animator = self._mainPlayer.spine:getAnimator()

			self._preparesAnimTime = AnimatorHash.getAnimLength(animator, animsMoreAnims[self._opType].start)
		else
			self:_startCollectNode()
		end
	end
end

function CollectView:_startCollectNode()
	self._preparesAnimTime = 0

	self._collectingNode:SetActive(true)

	self._currVal = 0

	self:_calculateAnimTime()
	self._slider:SetValue(0)
end

function CollectView:_calculateAnimTime()
	if not animNames[self._opType] then
		if needListenedAnims[self._opType] then
			if animsMoreAnims[self._opType] and animsMoreAnims[self._opType].fixedTime then
				self._collectTime = animsMoreAnims[self._opType].fixedTime
			else
				local animator = self._mainPlayer.spine:getAnimator()

				self._collectTime = AnimatorHash.getAnimLength(animator, needListenedAnims[self._opType])

				if animsMoreAnims[self._opType] then
					self._collectTime = self._collectTime * (animsMoreAnims[self._opType].loopTime or 1)
				end
			end
		else
			self._collectTime = defaultCollectTime
		end
	end
end

function CollectView:_mainPlayerPlayAni()
	local mainPlayer = self._mainPlayer

	if mainPlayer.spine ~= nil and self._animModelGo ~= nil then
		local parent = mainPlayer.spine:getHandPoint(UnitConst.playerAvatorRightHandPointPath).transform

		self._animModelGo.transform:SetParent(parent)
		Framework.TransformUtil.SetLocalRotation(self._animModelGo.transform, 90, 0, 0)
		Framework.TransformUtil.SetLocalPos(self._animModelGo.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(self._animModelGo.transform, 1, 1, 1)
		goutil.setActive(self._animModelGo, true)
	end
end

function CollectView:_breakCollecting()
	self._waitingStartCollecting = nil
	self._isCollecting = nil

	SceneMainPlayer.instance:updateVariablesView()
	self:localNotify(TaskConst.ON_TASK_COLLECT_BREAK)
end

function CollectView:_finishCollecting()
	self._waitingStartCollecting = nil
	self._isCollecting = nil

	SceneMainPlayer.instance:updateVariablesView()
	self._mainPlayer.spine:play(MainPlayerAnimState.Idle)
	self:localNotify(TaskConst.ON_TASK_COLLECT_FINISH)
	self:close()
end

function CollectView:_tickCollecting()
	if self._waitingStartCollecting then
		if not self._mainPlayer.actions:isRunningAction() then
			self:_startCollecting()

			self._waitingStartCollecting = nil
		end

		self:_tickCheckingBreak()

		return
	end

	if not self._isCollecting then
		return
	end

	local deltaTime = UnityEngine.Time.deltaTime

	if self._preparesAnimTime and self._preparesAnimTime > 0 then
		self._preparesAnimTime = self._preparesAnimTime - deltaTime

		if self._preparesAnimTime <= 0 then
			self:_startCollectNode()
		end

		return
	end

	if self._currVal >= self._collectTime then
		self:_finishCollecting()

		return
	end

	self._currVal = self._currVal + deltaTime

	if self._currVal > self._collectTime then
		self._currVal = self._collectTime
	end

	self._slider:SetValue(self._currVal / self._collectTime)
end

function CollectView:_tickCheckingBreak()
	if self._taskTarget then
		local collectNpc = self._taskTarget:getCollectNpcId()

		if collectNpc and collectNpc > 0 then
			local scene = SceneMgr.instance:getCurScene()
			local unitNpc = scene.unitFactory:getUnit(UnitTag.Npc, npcId)

			if not unitNpc then
				self:_breakCollecting()
			elseif not unitNpc:isAround(self._mainPlayer) then
				self:_breakCollecting()
			end

			return
		end

		local tSceneId = self._taskTarget:getSceneId()
		local tTriggerId = self._taskTarget:getTriggerId() or 0

		if tSceneId and tSceneId ~= 0 and tTriggerId and tTriggerId ~= 0 and self._mainPlayer.triggerId ~= tTriggerId then
			self:_breakCollecting()
		end
	end
end

function CollectView:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	if self._isCollecting then
		self._waitingStartCollecting = nil

		self:_breakCollecting()
	end
end

function CollectView:_onClickStartCollect()
	self._collectType:SetActive(false)

	self._waitingStartCollecting = nil
	self._isCollecting = nil

	removetimer(self._tickCollecting, self)
	settimer(0, self._tickCollecting, self, true)

	if not self._mainPlayer.actions:isRunningAction() then
		self:_startCollecting()
	else
		self._waitingStartCollecting = true
	end
end

function CollectView:_onViewClosed(view)
	if self:_is3DCameraBgView(view) then
		self.mainGO:SetActive(true)
	end
end

function CollectView:_onViewOpened(view)
	if self:_is3DCameraBgView(view) then
		self.mainGO:SetActive(false)
	end
end

function CollectView:_is3DCameraBgView(view)
	if ViewName.ArenaMainView == view.viewName or ViewName.MyCardView == view.viewName or ViewName.OtherCardView == view.viewName or ViewName.MountView == view.viewName or ViewName.AoCoreView == view.viewName or ViewName.QiCoreView == view.viewName then
		return true
	end
end

return CollectView
