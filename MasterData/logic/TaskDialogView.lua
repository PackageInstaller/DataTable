-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskDialogView.lua

module("logic.extensions.task.view.TaskDialogView", package.seeall)

local TaskDialogView = class("TaskDialogView", ViewComponent)

function TaskDialogView:buildUI()
	self:_buildCloseTips()
	self:_buildSureTips()
	self:_buildCommonTips()
	self:_buildModelTips()
end

function TaskDialogView:_buildCloseTips()
	self._closeTips = self:getGo("closeTips")
	self._closeTipsCtx = goutil.findChild(self._closeTips, "Content"):GetComponent("Text")
	self._closeTipsBtn = Framework.ButtonAdapter.GetFrom(self._closeTips, "Button")
end

function TaskDialogView:_buildSureTips()
	self._sureTips = self:getGo("sureTips")
	self._sureTipsCtx = goutil.findChild(self._sureTips, "Content"):GetComponent("Text")
	self._sureTipsBtn = Framework.ButtonAdapter.GetFrom(self._sureTips, "Button")
end

function TaskDialogView:_buildCommonTips()
	self._commonTips = self:getGo("commonTips")
	self._commonTipsCtx = goutil.findChild(self._commonTips, "Content"):GetComponent("Text")
	self._commonTipsSure = Framework.ButtonAdapter.GetFrom(self._commonTips, "Sure")
	self._commonTipsClose = Framework.ButtonAdapter.GetFrom(self._commonTips, "Close")
end

function TaskDialogView:_buildModelTips()
	self._model = self:getGo("model")

	local leftBottom = self:getGo("model/LB")
	local rightTop = self:getGo("model/RT")
	local camera = self:getGo("model/Camera"):GetComponent("Camera")
	local uiCameraGO = GlobalController.instance.uiCameraGO

	self._modelCamera = UIModelCamera.New(camera, uiCameraGO, leftBottom, rightTop)
	self._modelParent = self:getGo("model/Camera/Parent").transform
	self._modelCtx = self:getGo("model/Text"):GetComponent("Text")
end

function TaskDialogView:destroyUI()
	self._closeTips = nil
	self._closeTipsCtx = nil
	self._closeTipsBtn = nil
	self._sureTips = nil
	self._sureTipsCtx = nil
	self._sureTipsBtn = nil
	self._model = nil
	self._modelCamera = nil
	self._modelParent = nil
	self._commonTips = nil
	self._commonTipsCtx = nil
	self._commonTipsSure = nil
	self._commonTipsClose = nil
	self._dialogParams = nil
end

function TaskDialogView:bindEvents()
	self._closeTipsBtn:AddClickListener(self._onclickCloseButton, self)
	self._commonTipsClose:AddClickListener(self._onclickCloseButton, self)
	self._commonTipsSure:AddClickListener(self._onClickSureButton, self)
	self._sureTipsBtn:AddClickListener(self._onClickSureButton, self)
end

function TaskDialogView:unbindEvents()
	self._closeTipsBtn:RemoveClickListener()
	self._commonTipsClose:RemoveClickListener()
	self._commonTipsSure:RemoveClickListener()
	self._sureTipsBtn:RemoveClickListener()
end

function TaskDialogView:onEnter()
	self._dialogParams = self._viewPresentor._openParam[1]

	self:_handleAction()
end

function TaskDialogView:onExit()
	self._dialogParams = nil
end

function TaskDialogView:onExitFinished()
	self._modelCamera:onDeactive()
	self:_clearCacheGo()
	GameUtil.unloadMultiResLoaderResource(self._resLoader)

	self._resLoader = nil
	self._resPath = nil
end

function TaskDialogView:_handleAction()
	local params = self._dialogParams
	local dialog = params.dialog

	if dialog == TaskConst.DIALOG_CLOSE then
		self:_onDialogClose()
	elseif dialog == TaskConst.DIALOG_SURE then
		self:_onDialogSure()
	elseif dialog == TaskConst.DIALOG_COMMON then
		self:_onDialogCommon()
	elseif dialog == TaskConst.DIALOG_MODEL then
		self:_onDialogModel()
	end
end

function TaskDialogView:_getContent()
	return (TaskConfig.instance:getContentText(self._dialogParams.content))
end

function TaskDialogView:_onPerformed()
	self._closeTips:SetActive(true)
	self._sureTips:SetActive(false)
	self._commonTips:SetActive(false)
	self._model:SetActive(false)

	self._closeTipsCtx.text = "<color=#000000>" .. self:_getContent() .. "</color>"
end

function TaskDialogView:_onDialogClose()
	self._closeTips:SetActive(true)
	self._sureTips:SetActive(false)
	self._commonTips:SetActive(false)
	self._model:SetActive(false)

	self._closeTipsCtx.text = "<color=#000000>" .. self:_getContent() .. "</color>"
end

function TaskDialogView:_onDialogSure()
	self._closeTips:SetActive(false)
	self._sureTips:SetActive(true)
	self._commonTips:SetActive(false)
	self._model:SetActive(false)

	self._sureTipsCtx.text = "<color=#000000>" .. self:_getContent() .. "</color>"
end

function TaskDialogView:_onDialogCommon()
	self._closeTips:SetActive(false)
	self._sureTips:SetActive(false)
	self._commonTips:SetActive(true)
	self._model:SetActive(false)

	self._commonTipsCtx.text = "<color=#000000>" .. self:_getContent() .. "</color>"
end

function TaskDialogView:_onDialogModel()
	self._closeTips:SetActive(false)
	self._sureTips:SetActive(false)
	self._commonTips:SetActive(false)
	self._model:SetActive(true)

	self._modelCtx.text = "<color=#000000>" .. self:_getContent() .. "</color>"

	self._modelCamera:onActive()
	self._modelCamera:Apply()
	self:_showCharactor()
end

function TaskDialogView:_showCharactor()
	self._resLoader = MultiResLoader.New()

	local modelId = self._dialogParams.modelId
	local modelData = CharacterConfig.instance:getModelCo(modelId)
	local resPath = GameUrl.getSpineUrl(modelData.resName)

	self._resPath = resPath

	self._resLoader:addResPath(resPath)
	self._resLoader:load(self._onModelResourcesLoaded, nil, self)
end

function TaskDialogView:_getResInstance(path)
	local res = self._resLoader:getResource(path)

	if res then
		local prefab = res:GetMainAsset()

		if prefab then
			return goutil.clone(prefab)
		end
	end

	return nil
end

function TaskDialogView:_onModelResourcesLoaded(loader)
	local skeletonGO = self:_getResInstance(self._resPath)
	local billboard = skeletonGO:GetComponent("Billboard")

	if billboard then
		billboard.enabled = false
	end

	self._cacheGO = skeletonGO
	skeletonGO.layer = Framework.LayerUtil.NameToLayer("Unit")

	self:_setObject(skeletonGO)
end

function TaskDialogView:_setObject(skeletonGO)
	skeletonGO.transform:SetParent(self._modelParent)

	if not self._dialogParams.scale then
		local x, y, z, scale = self._dialogParams.x or 0, self._dialogParams.y or 0, self._dialogParams.z or 0, 1

		Framework.TransformUtil.SetLocalPos(skeletonGO.transform, x, y, z)
		Framework.TransformUtil.SetLocalScale(skeletonGO.transform, scale, scale, scale)

		self._skeletonAnimation = skeletonGO:GetComponent(UnitCompSpine.SkeletonAnimationType)

		self._skeletonAnimation:Initialize(false)

		self._skeletonAnimation = skeletonGO:GetComponent(UnitCompSpine.SkeletonAnimationType)
		self._skeletonAnimation.Skeleton.FlipX = false
		self._skeletonAnimation.loop = true
		self._skeletonAnimation.AnimationName = "idle"
	end
end

function TaskDialogView:_clearCacheGo()
	if self._cacheGO ~= nil then
		goutil.destroy(self._cacheGO, true)
	end

	self._cacheGO = nil

	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)
		self._resLoader:clear()
	end

	self._skeletonAnimation = nil
end

function TaskDialogView:_onClickSureButton()
	self:close()
	self:localNotify(TaskConst.ON_TASK_DIALOG_SURE)
end

function TaskDialogView:_onclickCloseButton()
	self:close()
	self:localNotify(TaskConst.ON_TASK_DIALOG_CANCEL)
end

return TaskDialogView
