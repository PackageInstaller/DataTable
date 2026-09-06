-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsGameTestView.lua

module("logic.extensions.goddessglory.view.GuessPetsGameTestView", package.seeall)

local GuessPetsGameTestView = class("GuessPetsGameTestView", ViewComponent)

function GuessPetsGameTestView:buildUI()
	GuessPetsGameTestView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnNextQuestion = self:getBtn("btnNextQuestion")
	self._btnPreQuestion = self:getBtn("btnPreQuestion")
	self._txtZonelNum = self:getTxt("txtZonelNum")
	self._txtTotalNum = self:getTxt("txtTotalNum")
	self._txtAnswer = self:getTxt("txtAnswer")
	self._petNode = self:getGo("pet")
	self._petImage = self:getGo("pet/image"):GetComponent(ComponentType.RawImage)
	self._btnNextZone = Framework.UIClickTrigger.Get(self:getGo("pet/image"))
	self._modelCamera = self:getGo("ModelCamera"):GetComponent(typeof(UnityEngine.Camera))
end

function GuessPetsGameTestView:bindEvents()
	GuessPetsGameTestView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnNextQuestion:AddClickListener(self._onClickNextQuestion, self)
	self._btnPreQuestion:AddClickListener(self._onClickPreQuestion, self)
	self._btnNextZone:AddClickListener(self._onClickNextZone, self)
end

function GuessPetsGameTestView:unbindEvents()
	GuessPetsGameTestView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnPreQuestion:RemoveClickListener()
	self._btnNextQuestion:RemoveClickListener()
	self._btnNextZone:RemoveClickListener()
end

function GuessPetsGameTestView:onEnter()
	GuessPetsGameTestView.super.onEnter(self)
	self._modelCamera.transform:SetParent(nil, false)
	Framework.TransformUtil.SetPos(self._modelCamera.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self._modelCamera.transform, 1, 1, 1)

	self._rendererTex = UnityEngine.RenderTexture.GetTemporary(512, 512)
	self._modelCamera.targetTexture = self._rendererTex
	self._petImage.texture = self._rendererTex
	self._questions = GuessPetConfig.instance:getAllQuestionCos()
	self._currQuestionIndex = 0
	self._currZoneIndex = 0

	self:_startNextQuestion()
end

function GuessPetsGameTestView:onExit()
	self._currShowingQuestion = nil
	self._curModelGo = nil
	self._questions = nil
	self._currQuestionIndex = nil
	self._currZoneIndex = nil

	self:_clearModels()
end

function GuessPetsGameTestView:_startNextQuestion()
	self:_startQuestion(self._currQuestionIndex + 1)
end

function GuessPetsGameTestView:_startQuestion(index)
	if index > #self._questions then
		index = 1
	elseif index < 1 then
		index = #self._questions
	end

	self._currQuestionIndex = index
	self._currZoneIndex = 0

	local questionCo = self._questions[self._currQuestionIndex]
	local resPath = GuessPetModel.instance:getQuestionResPath(questionCo.raceId)

	if not self:_isQuestionResourceLoaded(resPath) then
		self:_loadQuestionResource(resPath)
	else
		self:_startNextZone()
	end

	self._txtTotalNum.text = string.format("第%s/%s题", self._currQuestionIndex, #self._questions)
	self._txtAnswer.text = questionCo.name
end

function GuessPetsGameTestView:_startNextZone()
	self._currZoneIndex = self._currZoneIndex + 1

	if self._currZoneIndex > 5 then
		self._currZoneIndex = 1
	end

	self._txtZonelNum.text = self._currZoneIndex .. "/5"

	self:_buildPicture()
end

function GuessPetsGameTestView:_clearCameraRenderTexture()
	self._modelCamera.targetTexture = nil
	self._petImage.texture = nil

	if self._rendererTex then
		UnityEngine.RenderTexture.ReleaseTemporary(self._rendererTex)

		self._rendererTex = nil
	end

	self._modelCamera.transform:SetParent(self.mainGO.transform, false)
end

function GuessPetsGameTestView:_clearModels()
	if self._currLoadedRes then
		for k, v in pairs(self._currLoadedRes) do
			v:Release()
		end

		self._currLoadedRes = nil
	end

	if self._curCacheModels then
		for k, v in pairs(self._curCacheModels) do
			goutil.destroy(v)
		end

		self._curCacheModels = nil
	end

	self:_stopLoadingRes()
end

function GuessPetsGameTestView:_isQuestionResourceLoaded(resPath)
	if not self._currLoadedRes then
		return false
	end

	return self._currLoadedRes[resPath] ~= nil
end

function GuessPetsGameTestView:_stopLoadingRes()
	if self._curLoadingRes then
		removeresl(self._curLoadingRes, self._onResLoaded, self)

		self._curLoadingRes = nil
	end
end

function GuessPetsGameTestView:_loadQuestionResource(resPath)
	if self._curLoadingRes == resPath then
		return
	end

	self:_stopLoadingRes()

	self._curLoadingRes = resPath

	getres(resPath, self._onResLoaded, self)
end

function GuessPetsGameTestView:_onResLoaded(res)
	local resPath = res.ResPath

	if resPath ~= self._curLoadingRes then
		return
	end

	self._curLoadingRes = nil

	res:Retain()

	self._currLoadedRes = self._currLoadedRes or {}
	self._currLoadedRes[resPath] = res

	self:_startNextZone()
end

function GuessPetsGameTestView:_getModelGameObject(resPath)
	self._curCacheModels = self._curCacheModels or {}

	local go = self._curCacheModels[resPath]

	if not go then
		local res = self._currLoadedRes[resPath]

		if res then
			local mainAsset = res:GetMainAsset()

			if mainAsset then
				go = goutil.clone(mainAsset)
			end
		end
	end

	if go then
		self._curCacheModels[resPath] = go
	end

	return go
end

function GuessPetsGameTestView:_buildPicture()
	local questionCo = self._questions[self._currQuestionIndex]
	local resPath = GuessPetModel.instance:getQuestionResPath(questionCo.raceId)
	local go = self:_getModelGameObject(resPath)

	for k, v in pairs(self._curCacheModels) do
		v:SetActive(k == resPath)
	end

	self._curModelGo = go

	if not self._curModelGo then
		return
	end

	local showRect = self:_getModelShowRect(go)

	go.transform:SetParent(self._modelCamera.transform, false)
	Framework.TransformUtil.SetLocalPos(go.transform, -showRect.x, -showRect.y, 5)

	go.layer = SceneLayer.UI3DEx_Value
	self._modelCamera.orthographicSize = showRect.height * 0.5

	local skeletonAnimation = go:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

	skeletonAnimation.AnimationName = "idle"

	skeletonAnimation:Update(0)
	skeletonAnimation:LateUpdate()

	skeletonAnimation.timeScale = 0
end

function GuessPetsGameTestView:_getModelShowRect(go)
	local questionCo = self._questions[self._currQuestionIndex]
	local centerX = 0
	local centerY = 0
	local width = 0
	local height = 0

	if not questionCo.boxCollider or #questionCo.boxCollider == 0 then
		local boxCollider = go:GetComponent(ComponentType.BoxCollider)
		local center = boxCollider.center
		local size = boxCollider.size

		centerX = center.x
		centerY = center.y
		width = size.x
		height = size.y
	else
		centerX = questionCo.boxCollider[1]
		centerY = questionCo.boxCollider[2]
		width = questionCo.boxCollider[3]
		height = questionCo.boxCollider[4]
	end

	local widthDelta = width / 3
	local heightDelta = height / 3
	local showRect = {}

	if self._currZoneIndex == 1 then
		showRect.x = centerX
		showRect.y = centerY + heightDelta
	elseif self._currZoneIndex == 2 then
		showRect.x = centerX - widthDelta
		showRect.y = centerY
	elseif self._currZoneIndex == 3 then
		showRect.x = centerX
		showRect.y = centerY
	elseif self._currZoneIndex == 4 then
		showRect.x = centerX + widthDelta
		showRect.y = centerY
	else
		showRect.x = centerX
		showRect.y = centerY - heightDelta
	end

	showRect.width = widthDelta
	showRect.height = heightDelta

	return showRect
end

function GuessPetsGameTestView:_onClickClose()
	self:close()
end

function GuessPetsGameTestView:_onClickNextQuestion()
	self:_startQuestion(self._currQuestionIndex + 1)
end

function GuessPetsGameTestView:_onClickPreQuestion()
	self:_startQuestion(self._currQuestionIndex - 1)
end

function GuessPetsGameTestView:_onClickNextZone()
	local questionCo = self._questions[self._currQuestionIndex]
	local resPath = GuessPetModel.instance:getQuestionResPath(questionCo.raceId)

	if self:_isQuestionResourceLoaded(resPath) then
		self:_startNextZone()
	end
end

return GuessPetsGameTestView
