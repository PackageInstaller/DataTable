-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/character/facade/CharacterCutFacade.lua

module("logic.extensions.character.facade.CharacterCutFacade", package.seeall)

local M = class("CharacterCutFacade")

function M:showRoleClip(clipType, modelCode, strArray, numArray, modelCode2)
	self._clipType = clipType
	self._modelCode = modelCode
	self._viewUrl = "ui/views/" .. strArray[0]
	self._nodePath = strArray[1]
	self._centerPath = strArray[2]
	self._posX = numArray[0]
	self._posY = numArray[1]
	self._posZ = numArray[2]
	self._rotaX = numArray[3]
	self._rotaY = numArray[4]
	self._rotaZ = numArray[5]
	self._scaleX = numArray[6]
	self._scaleY = numArray[7]
	self._posX2 = numArray[8]
	self._posY2 = numArray[9]
	self._posZ2 = numArray[10]
	self._rotaX2 = numArray[11]
	self._rotaY2 = numArray[12]
	self._rotaZ2 = numArray[13]
	self._scaleX2 = numArray[14]
	self._scaleY2 = numArray[15]
	self._modelCode2 = modelCode2

	self:startShow()
end

function M:startShow()
	if not self._viewLoader then
		self._viewLoader = SingleResLoader.New()
	end

	if self._viewLoader:isSameResource(self._viewUrl) then
		self:_showRole()
	else
		self._viewLoader:load(self._viewUrl, self._onViewResLoaded, self)
	end
end

function M:_onViewResLoaded()
	if self._photoUnit then
		self._photoUnit:clear()
	end

	if self._photoModel then
		self._photoModel:clear()
	end

	self._photoUnit = nil
	self._photoModel = nil
	self._goInstView = self._viewLoader:getResInstance()

	local rootGO = UnityEngine.GameObject.Find("UIROOT/NOTIFY")

	goutil.clearChildren(rootGO)
	goutil.addChildToParent(self._goInstView, rootGO)
	self:_showRole()
end

function M:_showRole()
	self._goRole = goutil.findChild(self._goInstView, self._nodePath)

	if self._clipType == 1 then
		self:_showImageRole()
	elseif self._clipType == 2 then
		self:_showSpineRole()
	elseif self._clipType == 3 then
		self:_showModelRole()
	elseif self._clipType == 4 then
		self:_showModelRole(true)
	end
end

function M:_showImageRole()
	local CO = CutImageConfig.instance:getClipCO(self._modelCode)
	local width, height = CO:getWholeImgSize()
	local imgGo = self._goRole
	local parentGo = imgGo.transform.parent.gameObject
	local cutCenterGo = goutil.findChild(parentGo, "cardcutcenter")

	goutil.setHeight(imgGo.transform, goutil.getHeight(parentGo.transform))
	goutil.setWidth(imgGo.transform, goutil.getWidth(parentGo.transform))
	RectTransformUtils.SetAnchoredPosition(imgGo.transform, 0, 0)
	RectTransformUtils.SetScale(imgGo.transform, 1, 1, 1)

	local preScaleX = cutCenterGo.transform.localScale.x
	local preScaleY = cutCenterGo.transform.localScale.y
	local rectX = (-cutCenterGo.transform.anchoredPosition.x / preScaleX + (self._posX + 0.5 * width)) / self._scaleX
	local rectY = (-cutCenterGo.transform.anchoredPosition.y / preScaleY + self._posY) / self._scaleY
	local rectWidth = goutil.getWidth(imgGo.transform) / preScaleX / self._scaleX
	local rectHeight = goutil.getHeight(imgGo.transform) / preScaleY / self._scaleY
	local comp = SpaceX.ImageBigBGCut.Get(imgGo)
	local modelCO = ModelConfig.instance:getModelConfig(self._modelCode)

	if not string.nilorempty(modelCO.wholeIconName) then
		local imgUrl = string.format("ui/dynicon/character/%s.png", modelCO.wholeIconName)

		comp:SetCutInfo(rectX, rectY, rectWidth, rectHeight, preScaleX, preScaleY)
		comp:SetImage(imgUrl, handler, handlerObj)
	else
		printError("模型表，静态图片为空")
	end
end

function M:_showSpineRole()
	local imgRole = self._goRole:GetComponent(UIComponentType.RawImage)

	if imgRole then
		imgRole.material = nil
	end

	local photo = PhotoBlurEffect.Get(self._goRole)

	self._photoUnit = photo

	local centerGO = goutil.findChild(self._goInstView, self._centerPath)
	local trs = centerGO.transform
	local cutCenterPos = {
		trs.anchoredPosition.x,
		trs.anchoredPosition.y,
		trs.localScale.x,
		trs.localScale.y
	}
	local go = photo._unit.go

	Astral.TransformUtil.SetLocalScale(go.transform, self._scaleX * cutCenterPos[3], self._scaleY * cutCenterPos[4], 1)
	Astral.TransformUtil.SetLocalPos(go.transform, cutCenterPos[1] - self._posX * cutCenterPos[3], cutCenterPos[2] - self._posY * cutCenterPos[4], 0)
	photo:showUnitLiveWholeByID(self._modelCode)
	photo:setCameraRotation(0, 0, 0)
	photo:setCameraPosition(0, 0, -11)
end

function M:_showModelRole(isDouble)
	self._photoModel = Astral.LuaComponentContainer.Add(self._goRole, PhotoMultiModel)

	self._photoModel:clear()
	self._photoModel:setDefaultAnim(UnitAnimState.Idle2)
	self._photoModel:setLightCode(8)
	self._photoModel:setModelsLoadedCallback(self._onModelsLoaded, self)

	local posInfo = {
		self._posX,
		self._posY,
		self._posZ,
		self._rotaX,
		self._rotaY,
		self._rotaZ,
		self._scaleX
	}
	local infoList, resList

	if isDouble then
		local posInfo2 = {
			self._posX2,
			self._posY2,
			self._posZ2,
			self._rotaX2,
			self._rotaY2,
			self._rotaZ2,
			self._scaleX2
		}

		infoList = {
			posInfo,
			posInfo2
		}
	else
		infoList = {
			posInfo
		}
	end

	self._photoModel:setContainerPosInfos(infoList)

	local modelCO = ModelConfig.instance:getModelConfig(self._modelCode)

	if isDouble then
		local modelCO2 = ModelConfig.instance:getModelConfig(self._modelCode2)

		resList = {
			GameUrl.getHighMeshModelUrl(modelCO.resName),
			GameUrl.getHighMeshModelUrl(modelCO2.resName)
		}
	else
		resList = {
			GameUrl.getHighMeshModelUrl(modelCO.resName)
		}
	end

	self._photoModel:showModels(resList)
end

function M:_onModelsLoaded()
	self._photoModel:showUIReflection()
	self._photoModel:setCameraCullingMask(Astral.LayerUtil.GetLayerMask(SceneLayer.UI3D, SceneLayer.Unit))
	self._photoModel:setCameraTag(SceneTag.RendererFeatureCamera)
end

M.instance = M.New()

return M
