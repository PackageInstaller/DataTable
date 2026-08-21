-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/player/view/playercreate/PlayerCreatePlotView.lua

module("logic.extensions.player.view.playercreate.PlayerCreatePlotView", package.seeall)

local M = class("PlayerCreatePlotView", ViewComponent)
local NameState2Color = CommEnum.PlayerNameState2Color
local NameState = CommEnum.PlayerNameCreateState
local Data2Img = {
	3,
	2,
	1,
	6,
	5,
	4
}
local Mask3DData = {
	[0] = {
		name = "2301000",
		position = Vector3.New(-0.3, 0.3, 0.3),
		path = GameUrl.getMianjuUrl("2301000")
	},
	{
		name = "2301001",
		position = Vector3.New(-0.3, 0.3, 0.3),
		path = GameUrl.getMianjuUrl("2301001")
	},
	{
		name = "2301002",
		position = Vector3.New(-0.4, 0, 0.3),
		path = GameUrl.getMianjuUrl("2301002")
	},
	{
		name = "2301003",
		position = Vector3.New(-0.3, -0.3, 0.3),
		path = GameUrl.getMianjuUrl("2301003")
	},
	{
		name = "2301004",
		position = Vector3.New(0, 0.3, 0.3),
		path = GameUrl.getMianjuUrl("2301004")
	},
	{
		name = "2301005",
		position = Vector3.New(0, 0, 0.15),
		path = GameUrl.getMianjuUrl("2301005")
	},
	{
		name = "2301006",
		position = Vector3.New(0, -0.3, 0.3),
		path = GameUrl.getMianjuUrl("2301006")
	},
	{
		name = "2301007",
		position = Vector3.New(0.3, 0.3, 0.3),
		path = GameUrl.getMianjuUrl("2301007")
	},
	{
		name = "2301008",
		position = Vector3.New(0.4, 0, 0.3),
		path = GameUrl.getMianjuUrl("2301008")
	},
	{
		name = "2301009",
		position = Vector3.New(0.3, -0.3, 0.3),
		path = GameUrl.getMianjuUrl("2301009")
	}
}

function M:ctor(...)
	M.super.ctor(self, ...)

	self._plotCoList = false
	self._firstPeriod = true
	self._choice1 = 0
	self._choice2 = 0
	self._currStep = 1
	self._createInfo = false
	self._currType = 1
	self._isPlayAnim = false
	self._initPos = Vector3.New(0, 0, 0)
	self._targetPos = Vector3.New(0, 0, 0)
	self._selectId = 0
	self._curAnswerIndex = 0
	self._isNamePanel = false
	self._meshRenderList = false
	self._maskGoList = false
end

function M:buildUI()
	self._dialogGo = self:getGo("player_create_view_198015833")
	self._btnNext = UIComponentType.ButtonAdapter(self:getGo("player_create_view_1934268265"))
	self._txtContent = goutil.findChildComponent(self.mainGO, "objDialog/txtContent", UIComponentType.TextMeshProUGUI)
	self._txtContentCanvas = self._txtContent.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._choicePanelGo = self:getGo("player_create_view_97559151")
	self._txtChoice1 = self:getText("player_create_view_89219493")
	self._txtChoice2 = self:getText("player_create_view_2099587849")
	self._txtChoice3 = self:getText("player_create_view_1638258116")
	self._txtChoice4 = self:getText("player_create_view_582298840")
	self._btnChoice1 = UIComponentType.ButtonAdapter(self:getGo("player_create_view_1773817772"))
	self._btnChoice2 = UIComponentType.ButtonAdapter(self:getGo("player_create_view_607084367"))
	self._btnChoice3 = UIComponentType.ButtonAdapter(self:getGo("player_create_view_1219539586"))
	self._btnChoice4 = UIComponentType.ButtonAdapter(self:getGo("player_create_view_1867306590"))
	self._surePanelGo = self:getGo("player_create_view_431997992")
	self._maskGroup3DGo = self:getGo("player_create_view_-582577484")
	self._txtName = self:getText("player_create_view_448448358")
	self._txtInfo = self:getText("player_create_view_653897783")
	self._txtBottomInfo = self:getText("player_create_view_219117897")
	self._btnSure = UIComponentType.ButtonAdapter(self:getGo("0&btn_middle_-31477526"))
	self._imgDimensionCur = self:getGo("player_create_view_-998860835"):GetComponent("UIPolygon")
	self._txtSixLevel = {
		self:getText("player_create_view_-1581714092"),
		self:getText("player_create_view_659784772"),
		self:getText("player_create_view_732013448"),
		self:getText("player_create_view_799342297"),
		self:getText("player_create_view_2140988891"),
		self:getText("player_create_view_1376343932")
	}
	self._maskGo = self:getGo("player_create_view_1147291296")
	self._targetPos.x = self._maskGo.transform.localPosition.x
	self._targetPos.y = self._maskGo.transform.localPosition.y
	self._targetPos.z = self._maskGo.transform.localPosition.z
	self._btnMaskGos = {}

	for i = 1, self._maskGroup3DGo.transform.childCount do
		local childGo = goutil.findChild(self._maskGroup3DGo, "btnMask" .. i)
		local maskClick = Astral.UIClickTrigger.Get(goutil.findChild(childGo, "btn"))

		maskClick:AddClickListener(function()
			return self:_onClickMask(i)
		end, self)
		table.insert(self._btnMaskGos, childGo)
	end

	self._normalScale = self._btnMaskGos[1].transform.localScale
	self._selectScale = self._btnMaskGos[5].transform.localScale
	self._namePanelGo = self:getGo("player_create_view_980075520")
	self._guanBiaoGo = self:getGo("player_create_view_1317854118")
	self._btnPre = UIComponentType.ButtonAdapter(self:getGo("player_create_view_1060160887"))
	self._btnDone = UIComponentType.ButtonAdapter(self:getGo("1&btn_middle_-31477526"))
	self._txtNameUp = self:getText("player_create_view_790624073")
	self._txtNickName = self:getText("player_create_view_130841319")
	self._inputName = Astral.InputFieldAdapter.Get(self:getGo("player_create_view_195691942"))
	self._inputNameRect = self:getRectTransform("player_create_view_195691942")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._matLoader = SingleResLoader.New()

	self._matLoader:load("shared/materials/comm/photoadditive_create.mat", self._onMatLoaded, self)
end

function M:destroyUI()
	self._mainMask3D = nil

	for i, v in ipairs(self._photoEffects) do
		v = nil
	end

	self._guiAnimation = nil
end

function M:bindEvents()
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnPre:AddClickListener(self._onClickPre, self)
	self._btnDone:AddClickListener(self._onClickDone, self)
	self._btnChoice1:AddClickListener(self._onClickChoice1, self)
	self._btnChoice2:AddClickListener(self._onClickChoice2, self)
	self._btnChoice3:AddClickListener(self._onClickChoice3, self)
	self._btnChoice4:AddClickListener(self._onClickChoice4, self)
	self._inputName:AddOnValueChanged(self._onNameChange, self)
	self._inputName:AddOnEndEdit(self._onNameEditEnd, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_CREATED, self._onCreatedPlayer, self)
end

function M:unbindEvents()
	for i, v in ipairs(self._btnMaskGos) do
		local maskClick = Astral.UIClickTrigger.Get(goutil.findChild(v, "btn"))

		maskClick:RemoveClickListener()
	end

	self._btnNext:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnPre:RemoveClickListener()
	self._btnDone:RemoveClickListener()
	self._btnChoice1:RemoveClickListener()
	self._btnChoice2:RemoveClickListener()
	self._btnChoice3:RemoveClickListener()
	self._btnChoice4:RemoveClickListener()
	self._inputName:RemoveOnValueChanged()
	self._inputName:RemoveOnEndEdit()
	GlobalDispatcher:removeEventListener(EventType.PLAYER_CREATED, self._onCreatedPlayer, self)
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.INPUT_POINTER_PRESSED, self._getClickPos, self)

	self._photoEffects = {}
	self._meshRenderList = {}
	self._maskGoList = {}
	self._plotCoList = PlayerConfig.instance:getCreatePlot()

	self:_setContent()
	self:_loadMask3D_One()
	PlayerCreateModel.instance:recordEnterTime()
end

function M:onEnterFinished()
	return
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.INPUT_POINTER_PRESSED, self._getClickPos, self)

	self._choice1 = 0
	self._choice2 = 0
	self._isNamePanel = false
end

function M:onExitFinished()
	self._plotCoList = false
	self._currStep = 1
	self._firstPeriod = true
	self._createInfo = false
	self._currType = 1
	self._isPlayAnim = false
	self._curAnswerIndex = 0

	self._mainMask3D:clear()

	self._meshRenderList = false
	self._maskGoList = false
	self._diWenList = false

	for i, v in ipairs(self._photoEffects) do
		v:clear()
	end

	for i, v in ipairs(self._btnMaskGos) do
		local canvasGroup = v:GetComponent(ComponentType.CanvasGroup)

		canvasGroup.alpha = 0
	end

	self._matLoader:clear()
	removetimer(self._printWord, self)

	local selectGo = self._btnMaskGos[self._selectId]

	if selectGo then
		Astral.TransformUtil.SetLocalPos(selectGo.transform, self._initPos.x, self._initPos.y, self._initPos.z)
	end

	self._selectId = 0

	Astral.TransformUtil.SetLocalPos(self._maskGo.transform, self._targetPos.x, self._targetPos.y, self._targetPos.z)
	PlayerCreateController.instance:dispatchCreateClosedEvent()
end

function M:_resetAnimPlayState()
	self._isPlayAnim = false
end

function M:_playAnimation(aniName)
	if aniName then
		self._isPlayAnim = true

		settimer(1.3, self._resetAnimPlayState, self, false)
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName(aniName)

		return
	end

	local aniNamePlay = ""
	local length = #self._plotCoList
	local plotCo = self._plotCoList[self._currStep]

	if length < self._currStep then
		aniNamePlay = "close_objchoice"

		settimer(1, function()
			goutil.setActive(self._choicePanelGo, false)
			self._guiAnimation:StopTimelineAni()
			self._guiAnimation:PlayAniByName("open_objInfo")
		end, self, false)
	else
		if plotCo.type == 1 then
			if self._currType ~= plotCo.type then
				aniNamePlay = "close_objchoice_01"

				settimer(0.25, function()
					goutil.setActive(self._choicePanelGo, false)
				end, self, false)
			end
		else
			if self._currType ~= plotCo.type then
				-- block empty
			end

			settimer(0.25, function()
				goutil.setActive(self._choicePanelGo, true)
				self._guiAnimation:StopTimelineAni()
				self._guiAnimation:PlayAniByName("open_objchoice")
			end, self, false)
		end

		self._currType = plotCo.type
	end

	if aniNamePlay ~= "" then
		self._isPlayAnim = true

		settimer(1.3, self._resetAnimPlayState, self, false)
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName(aniNamePlay)
	end
end

function M:_setContent()
	if not self._plotCoList then
		return
	end

	local length = #self._plotCoList

	goutil.setActive(self._namePanelGo, false)
	goutil.setActive(self._surePanelGo, length < self._currStep)
	goutil.setActive(self._btnNext.gameObject, length >= self._currStep)
	goutil.setActive(self._dialogGo, length >= self._currStep)
	settimer(1, function()
		goutil.setActive(self._maskGo, self._currStep <= length)
	end, self, false)

	if length < self._currStep then
		local createInfo = PlayerConfig.instance:getCreateInfoByAnswer(self._choice1, self._choice2)

		self._txtName.text = createInfo.name
		self._txtInfo.text = createInfo.desc

		ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)
		self:_loadMask3D_Nine()
		settimer(0.9, function()
			ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
			self:_onClickMask(createInfo.id, false)
			self:_showMaskAnim(true)
		end, self, false)
		self:_moveSelect(false, createInfo.id, true)
	else
		local plotCo = self._plotCoList[self._currStep]

		if plotCo.type == 1 then
			self._txtContent.text = plotCo.desc
			self._txtContentCanvas.alpha = 0
			self._showCount = 0

			settimer(0.1, self._printWord, self, true)
		else
			self._txtChoice1.text = plotCo.choice1
			self._txtChoice2.text = plotCo.choice2
			self._txtChoice3.text = plotCo.choice3
			self._txtChoice4.text = plotCo.choice4
		end

		self._firstPeriod = plotCo.period == 1

		goutil.setActive(self._btnNext.gameObject, plotCo.type ~= 2)
	end

	self._txtBottomInfo.text = lang("tip_player_create_des1")
	self._txtNameUp.text = lang("tip_player_create_des2")

	self:_playAnimation()
end

function M:_setSixValueWithAni()
	local sixValue = {}

	for i = 1, #self._createInfo.attributes do
		local attribute = self._createInfo.attributes[i]
		local pos = Data2Img[i]

		sixValue[pos] = attribute / 6
		self._txtSixLevel[i].text = CommEnum.D6Attr2Name[pos] .. attribute
	end

	for i = 1, #sixValue do
		local index = i - 1
		local lastValue = lastValueSet or self._imgDimensionCur:GetPolygonValue(index) or 0
		local nowValue = sixValue[i]

		self:_setOneValueTween(index, lastValue, nowValue)
	end
end

function M:_setOneValueTween(index, startValue, endValue)
	DoTweenUtil.ToWithEase(startValue, endValue, 0.3, DG.Tweening.Ease.InCubic, function(value)
		self._imgDimensionCur:InitPolygon(index, value)
	end)
end

function M:_printWord()
	self._txtContentCanvas.alpha = 1

	local maxPrintCount = self._txtContent.textInfo.characterCount

	self._showCount = self._showCount + 1
	self._txtContent.maxVisibleCharacters = self._showCount

	if maxPrintCount < self._showCount then
		removetimer(self._printWord, self)
	end
end

function M:_onClickNext()
	if self._isPlayAnim then
		return
	end

	self._currStep = self._currStep + 1

	self:_setContent()
end

function M:_onClickSure()
	self._isNamePanel = true

	self:_playAnimation("close_objInfo")
	settimer(0.3, function()
		goutil.setActive(self._namePanelGo, true)

		if not goutil.isNil(self.mainGO) and self._guiAnimation then
			self._guiAnimation:PlayAniByName("open_objName")
		end
	end, self, false)
	goutil.setActive(self._guanBiaoGo, true)
	self:_showMaskAnim(false)

	local selectGo = self._btnMaskGos[self._selectId]

	self._initPos.x = selectGo.transform.localPosition.x
	self._initPos.y = selectGo.transform.localPosition.y
	self._initPos.z = selectGo.transform.localPosition.z

	self:_moveSelect(true, self._selectId)
	PlayerCreateModel.instance:recordSelectAttr()
end

function M:_onClickPre()
	self._isNamePanel = false

	self:_playAnimation("close_objName")
	settimer(0.2, function()
		goutil.setActive(self._namePanelGo, false)
		self._guiAnimation:PlayAniByName("open_objInfo")
	end, self, false)
	goutil.setActive(self._guanBiaoGo, false)
	self:_showMaskAnim(true)
	self:_moveSelect(false, self._selectId)
end

function M:_onClickDone()
	local name = self._txtNickName.text

	if string.nilorempty(name) then
		name = PlayerCreateModel.instance:getDefaultName()
	end

	local maxCount = PlayerCreateController.instance:getNameCountLimit()

	if maxCount < StringUtil.getStringLength(name) then
		FloatWordMgr.instance:show(lang("tip_name_too_long"))

		return
	end

	PlayerAgent.instance:sendFinishCreatePlayerRequest(name, self._createInfo.id)
	PlayerCreateModel.instance:recordTmpId(self._createInfo.id)
	PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId(), true)
end

function M:_afterChoice()
	if not self._diWenList then
		self._diWenList = {
			self._maskDi1,
			self._maskDi2,
			self._maskDi3
		}
	end

	local materialSetter

	for i, v in ipairs(self._diWenList) do
		if self._choice2 <= 0 then
			goutil.setActive(v, self._choice1 == i)

			materialSetter = MaterialSetter.Get(v)

			materialSetter:SetFloat(ShaderConstants.ID_Alpha, 0)
			self:_diWenAnimation(v)
		else
			self:_setSecondDiWen(v)
		end
	end

	goutil.setActive(self._btnNext.gameObject, true)

	self._curAnswerIndex = self._curAnswerIndex + 1

	PlayerCreateModel.instance:recordAnswer(self._curAnswerIndex)
	self:_onClickNext()
end

function M:_setSecondDiWen(firstDiWenGo)
	if not goutil.isNil(firstDiWenGo) and firstDiWenGo.activeSelf then
		for i = 1, 3 do
			local child = goutil.findChild(firstDiWenGo, "" .. i)

			goutil.setActive(child, self._choice2 == i)

			local materialSetter = MaterialSetter.Get(child)

			materialSetter:SetFloat(ShaderConstants.ID_Alpha, 0)
			self:_diWenAnimation(child)
		end
	end
end

function M:_diWenAnimation(targetGo)
	if not goutil.isNil(targetGo) and targetGo.activeSelf then
		local meshRenderGo = targetGo

		if meshRenderGo then
			local materialSetter = MaterialSetter.Get(meshRenderGo)

			materialSetter:DOFloat(ShaderConstants.ID_Alpha, 0, 1, 2)
		end
	end
end

function M:_onClickChoice1()
	if self._firstPeriod then
		self._choice1 = 1
	else
		self._choice2 = 1
	end

	self:_afterChoice()
end

function M:_onClickChoice2()
	if self._firstPeriod then
		self._choice1 = 2
	else
		self._choice2 = 2
	end

	self:_afterChoice()
end

function M:_onClickChoice3()
	if self._firstPeriod then
		self._choice1 = 3
	else
		self._choice2 = 3
	end

	self:_afterChoice()
end

function M:_onClickChoice4()
	local num = math.random(1, 3)

	if self._firstPeriod then
		self._choice1 = num
	else
		self._choice2 = num
	end

	self:_afterChoice()
end

function M:_onClickMask(index, isChangeAlpha)
	if self._isNamePanel or self._namePanelGo.activeSelf then
		return
	end

	self._selectId = index
	self._createInfo = PlayerConfig.instance:getCreateInfo(index)
	self._txtName.text = self._createInfo.name
	self._txtInfo.text = self._createInfo.desc

	for i, v in ipairs(self._btnMaskGos) do
		local canvasGroup = v:GetComponent(ComponentType.CanvasGroup)

		if i == index then
			if isChangeAlpha == nil then
				canvasGroup:DOKill(false)

				canvasGroup.alpha = 1
			end

			self:_setMeshRenderMatColor(Mask3DData[i].name, true)
			v.transform:DOScale(self._selectScale, 0.5):SetEase(DG.Tweening.Ease.OutCubic)
		else
			if isChangeAlpha == nil then
				canvasGroup:DOKill(false)

				canvasGroup.alpha = 0.5
			end

			self:_setMeshRenderMatColor(Mask3DData[i].name, false)
			v.transform:DOScale(self._normalScale, 0.5):SetEase(DG.Tweening.Ease.OutCubic)
		end
	end

	self:_setSixValueWithAni()
end

function M:_showMaskAnim(isShow)
	local num = 0

	if isShow then
		num = 0.5
	end

	for i, v in ipairs(self._btnMaskGos) do
		local canvasGroup = v:GetComponent(ComponentType.CanvasGroup)

		canvasGroup:DOKill(false)

		if not isShow then
			if self._selectId ~= i then
				canvasGroup:DOFade(num, 0.5):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
			end
		elseif self._selectId ~= i then
			canvasGroup:DOFade(num, 2.5):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		else
			canvasGroup:DOFade(1, 1.5):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		end
	end
end

function M:_moveSelect(isShow, selectId, isMoveMain)
	local selectGo = self._btnMaskGos[selectId]
	local target = selectGo.transform.localPosition

	target.x = target.x + self._maskGroup3DGo.transform.localPosition.x

	local ease = DG.Tweening.Ease.InCubic

	if isMoveMain then
		self._maskGo.transform:DOLocalMove(target, 1):SetEase(ease):SetAutoKill(true)
		settimer(1, function()
			goutil.setActive(self._maskGo, false)
		end, self, false)

		return
	end

	target = self._maskGo.transform.localPosition
	target.x = self._targetPos.x - self._maskGroup3DGo.transform.localPosition.x
	target.y = self._targetPos.y
	target.z = self._targetPos.z
	ease = DG.Tweening.Ease.InOutBack

	if isShow then
		selectGo.transform:DOLocalMove(target, 1):SetEase(ease):SetAutoKill(true)
	else
		selectGo.transform:DOLocalMove(self._initPos, 1):SetEase(ease):SetAutoKill(true)
	end
end

function M:_onNameChange(nickName)
	if string.nilorempty(nickName) then
		return
	end

	local maxCount = PlayerCreateController.instance:getNameCountLimit()
	local limitCount = StringUtil.getCharacterLimit(nickName, maxCount)
	local curLen = StringUtil.getStringLength(nickName)

	if curLen == 13 then
		self._recordName = nickName
	end

	if curLen > 14 then
		self._inputName:SetText(self._recordName or nickName)
	end

	self._inputName:SetCharacterLimit(limitCount)

	if PlayerCreateModel.instance:getNameEditState() ~= NameState.Normal then
		TextUtils.SetColor(self._txtName, NameState2Color[NameState.Normal])
	end

	goutil.setActive(self._guanBiaoGo, false)
end

function M:_onNameEditEnd()
	local editName, state = PlayerCreateController.instance:checkNameState(self._inputName:GetText())

	PlayerCreateModel.instance:setNickName(editName)

	if state == NameState.Normal then
		print("=====name normal======")
	else
		PlayerCreateModel.instance:setNameEditState(state)
	end

	if string.nilorempty(self._inputName:GetText()) or self._inputName:GetText() == "" then
		goutil.setActive(self._guanBiaoGo, true)
	else
		goutil.setActive(self._guanBiaoGo, false)
	end
end

function M:_loadMask3D_One()
	self._mainMask3D = PhotoEffect.Get(self._maskGo)

	self._mainMask3D:clear()
	self._mainMask3D:setEffectLoadedCallback(self._loadMaskDone, self)
	self._mainMask3D:showEffects(Mask3DData[0].path)
end

function M:_loadMask3D_Nine()
	self._photoEffects = {}

	for i = 1, self._maskGroup3DGo.transform.childCount do
		local childGo = goutil.findChild(self._maskGroup3DGo, "btnMask" .. i)
		local photoeffect = PhotoEffect.Get(childGo)

		photoeffect:clear()
		photoeffect:setEffectLoadedCallback(self._loadMaskDone, self)
		photoeffect:showEffects(Mask3DData[i].path)
		photoeffect:setCameraTag(SceneTag.RTCamera)
		table.insert(self._photoEffects, photoeffect)
	end
end

function M:_loadMaskDone(inst, res)
	table.insert(self._maskGoList, inst)

	self._maskDi1 = goutil.findChild(inst, "ef/01")
	self._maskDi2 = goutil.findChild(inst, "ef/02")
	self._maskDi3 = goutil.findChild(inst, "ef/03")

	local meshRenderGo = goutil.findChild(inst, "diwen")

	table.insert(self._meshRenderList, meshRenderGo)
	goutil.setActive(self._maskDi1, false)
	goutil.setActive(self._maskDi2, false)
	goutil.setActive(self._maskDi3, false)

	if self._material then
		self._mainMask3D:setMaterial(self._material)
	end

	if self._photoEffects then
		for i, v in ipairs(self._photoEffects) do
			if self._material then
				v:setMaterial(self._material)
			end
		end
	end

	if #self._photoEffects == #Mask3DData then
		local createInfo = PlayerConfig.instance:getCreateInfoByAnswer(self._choice1, self._choice2)

		self:_onClickMask(createInfo.id, false)
	end
end

function M:_onMatLoaded(resource)
	local resource = self._matLoader:getResource()

	if resource then
		self._material = resource:GetMainAsset()
	end
end

function M:_setMeshRenderLayer(name, isOutline)
	local meshRenderGo

	for i, v in ipairs(self._meshRenderList) do
		local nameStr = v.transform.parent.gameObject.name

		if string.find(nameStr, name) then
			meshRenderGo = v
		end
	end

	if meshRenderGo then
		SpaceX.RendererFeatureUtils.ToggleRenderingLayerMask(isOutline, meshRenderGo, RenderingLayerMask.Layer20)
	end
end

function M:_setMeshRenderMatColor(name, isSelected)
	local meshRenderGo

	for i, v in ipairs(self._meshRenderList) do
		if not goutil.isNil(v) then
			local nameStr = v.transform.parent.gameObject.name

			if string.find(nameStr, name) then
				meshRenderGo = v
			end
		end
	end

	if meshRenderGo then
		local colorStr = isSelected and "#FFFFFF" or "#595959"
		local materialSetter = MaterialSetter.Get(meshRenderGo)

		materialSetter:SetColor(ShaderConstants.ID_MainColorID, colorStr)
	end
end

function M:_onCreatedPlayer()
	self._guiAnimation:StopTimelineAni()
	self:back()
	self:_closeAction()
end

function M:_closeAction()
	local name = Mask3DData[self._selectId].name
	local maskGo

	for i, v in ipairs(self._maskGoList) do
		if string.find(v.name, name) then
			maskGo = v
		end
	end

	if not maskGo then
		return
	end

	local tweenAnim = maskGo:GetComponent("AutoTweenAnim_ForArtist")

	tweenAnim.enabled = false

	maskGo.transform:DORotate(Vector3.New(0, 180, 0), 0.2, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	maskGo.transform:DOLocalMoveZ(0.37, 0.8):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	maskGo.transform:DOScale(Vector3.New(1.8, 1.8, 1), 0.8):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

	local maskRawGo = self._btnMaskGos[self._selectId]

	maskRawGo.transform:DOScale(1.5, 0.8):SetEase(DG.Tweening.Ease.Linear)
end

function M:_getClickPos(_, position)
	if not self._inputNameRect.gameObject.activeInHierarchy then
		return
	end

	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	local mousePosition = MainPlayerInputFacade.instance:getScreenPosition()
	local isClickInputRect = RectTransformUtils.RectangleContainsScreenPoint(self._inputNameRect, mousePosition.x, mousePosition.y, uiCamera)
	local targetX, targetY = RectTransformUtils.ScreenPointToLocalPointInRectangle(self._inputNameRect, mousePosition.x, mousePosition.y, uiCamera, 0, 0)
	local content = self._inputName:GetText()

	goutil.setActive(self._guanBiaoGo, not isClickInputRect and content == "")

	if isClickInputRect and content == "" then
		self._inputName:SetText(lang("tip_role_default_name"))
	end
end

return M
