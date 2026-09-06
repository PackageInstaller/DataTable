-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/view/PetrelationView.lua

module("logic.extensions.petrelation.view.PetrelationView", package.seeall)

local PetrelationView = class("PetrelationView", ViewComponent)
local Input = UnityEngine.Input

function PetrelationView:buildUI()
	PetrelationView.super.buildUI(self)

	self._btnTips = self:getGo("effMask/sumAttribute/btnTips")
	self._btnTipsRoot = self:getGo("effMask/sumAttribute/btnTips/root")
	self._closeBtn = self:getBtn("effMask/closeBtn")
	self._bg = goutil.findChildComponent(self.mainGO, "bg", "ScrollRect")
	self._content = self:getGo("bg/Viewport/Content")
	self._baseMask = self:getGo("bg/baseMask")
	self._baseLine = goutil.findChildComponent(self._baseMask, "baseLine", "LineGraphic")
	self._baseBgLine = goutil.findChildComponent(self._baseMask, "baseBgLine", "LineGraphic")
	self._secondLine = goutil.findChildComponent(self._bg.gameObject, "secondLine", "LineGraphic")
	self._secondBgLine = goutil.findChildComponent(self._bg.gameObject, "secondBgLine", "LineGraphic")
	self._relationName = goutil.findChild(self._content, "relationName")
	self._recoveryBtn = Framework.ButtonAdapter.GetFrom(self._bg.gameObject, "recoveryBtn")
	self._pets = goutil.findChild(self._bg.gameObject, "pets")
	self._cell = goutil.findChild(self._content, "cell")
	self._tag = goutil.findChild(self._pets, "tag")
	self._title = self:getGo("title")
	self._scaleSlider = self:getSlider("scaleSlider")
	self._sliderMax = goutil.findChildTextComponent(self.mainGO, "scaleSlider/maxScale")
	self._sliderMin = goutil.findChildTextComponent(self.mainGO, "scaleSlider/minScale")
	self._sliderScale = goutil.findChildTextComponent(self.mainGO, "scaleSlider/scale")
	self._txtLife = goutil.findChildTextComponent(self.mainGO, "effMask/sumAttribute/life/txtNum")
	self._txtAttack = goutil.findChildTextComponent(self.mainGO, "effMask/sumAttribute/attack/txtNum")
	self._txtDefend = goutil.findChildTextComponent(self.mainGO, "effMask/sumAttribute/defend/txtNum")
	self._txtMagic = goutil.findChildTextComponent(self.mainGO, "effMask/sumAttribute/magic/txtNum")
	self._petbookBtn = self:getBtn("effMask/petbookBtn")
	self._petbookRed = self:getGo("effMask/petbookBtn/red")
	self._teamCell = self:getGo("effMask/teamCell")
	self._teamViewGo = self:getGo("effMask/teamView")
	self._teamView = ScrollerList.create(self._teamViewGo, self._teamCell, GameUtil.handler(self._updateTeamCell, self))
	self._typeView = self:getGo("effMask/typeView")
	self._typeBtns = {}
	self._typeRed = {}

	for i = 1, self._typeView.transform.childCount do
		self._typeBtns[i] = self:getBtn("effMask/typeView/" .. i)
		self._typeRed[i] = self:getGo("effMask/typeView/" .. i .. "/red")
	end

	self._switchBtn = self:getBtn("effMask/switchBtn")
	self._switchOn = self:getGo("effMask/switchBtn/on")
	self._switchOff = self:getGo("effMask/switchBtn/off")

	GameUtil.SetActive(self._petbookBtn, false)
end

function PetrelationView:bindEvents()
	PetrelationView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._petbookBtn:AddClickListener(function()
		if self._finishHeadItemRefreshFlag then
			FuncOpenController.instance:openFunc(102)
		end
	end)
	self._scaleSlider:AddOnValueChanged(self._slideChange, self)
	self._recoveryBtn:AddClickListener(self._recovery, self)

	for i, btn in ipairs(self._typeBtns) do
		btn:AddClickListener(function()
			self:_onClickTypeBtn(i)
		end)
	end

	self._switchBtn:AddClickListener(self._onClickSwitch, self)
	self._scaleSlider:AddOnValueChanged(self._slideChange, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickBtnTips, self)
end

function PetrelationView:unbindEvents()
	PetrelationView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._petbookBtn:RemoveClickListener()
	self._scaleSlider:RemoveOnValueChanged()
	self._recoveryBtn:RemoveClickListener()

	for i, btn in ipairs(self._typeBtns) do
		btn:RemoveClickListener()
	end

	self._switchBtn:RemoveClickListener()
	self._scaleSlider:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnTips)
end

function PetrelationView:onEnter()
	PetrelationView.super.onEnter(self)

	self._finishHeadItemRefreshFlag = false

	HeadItemController.instance:sendGetInfo(GameUtil.handler(self._finishHeadItemRefresh, self))

	self._onExitFlag = false

	if not HandbookController.instance:getIsDataInit() then
		HandbookController.instance:checkDataAndCall(function()
			if self._onExitFlag then
				return
			end

			self:onEnter()
		end)

		return
	end

	goutil.setActive(self._recoveryBtn.gameObject, false)

	self._type = PetRelationModel.instance:getViewType() or self:getFirstParam() or 2

	PetRelationModel.instance:setViewType()

	self._showPetAnimParam = {
		index = 1,
		rad = -2500
	}
	self._contentScale = tonumber(PetRelationConfig.instance:getCommonValue("DEFAULT_SCALE"))
	self._contentMaxScale = tonumber(PetRelationConfig.instance:getCommonValue("MAX_SCALE"))
	self._contentMinScale = tonumber(PetRelationConfig.instance:getCommonValue("MIN_SCALE"))
	self._baseLineMat = self._baseLine.material

	self._baseLineMat:SetFloat("_MaskCenter", 0)

	self._teamEff = {}

	self:drawBaseLine()

	for i, btn in ipairs(self._typeBtns) do
		goutil.setActive(goutil.findChild(btn, "select"), i == self._type - 1)
	end

	local diffScale = self._contentMaxScale - self._contentMinScale

	goutil.setActive(self._scaleSlider.gameObject, Framework.OSDef.isEditor)
	self._scaleSlider:SetValue((self._contentScale - self._contentMinScale) / diffScale)

	self._sliderMax.text = self._contentMaxScale
	self._sliderMin.text = self._contentMinScale
	self._sliderScale.text = self._contentMinScale + self._scaleSlider:GetValue() * diffScale

	GameUtil.setLocalScale(self._content, self._contentScale, self._contentScale, 1)

	self._oldPosition1 = Vector2.New()
	self._oldPosition2 = Vector2.New()
	self._touchScaleFlag = true

	local lifeSum, attackSum, defendSum, magicSum = HandbookController.instance:calculateSumAttr()
	local fixLifeSum, fixAttackSum, fixDefendSum, fixMagicSum = HandbookController.instance:calculateSumFixAttr()

	self._txtLife.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", lifeSum, fixLifeSum)
	self._txtAttack.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", attackSum, fixAttackSum)
	self._txtDefend.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", defendSum, fixDefendSum)
	self._txtMagic.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", magicSum, fixMagicSum)

	local effPath = "fx_ui_beijingxingchen/fx_ui_xingchen.prefab"

	self._bgEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, function(finishHandler, eff)
		eff.effGo.transform:SetParent(self._bg.gameObject.transform)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	UpdateBeat:Add(self._twoTouchScale, self)
	RedPointController.instance:regRedPoint(self._petbookRed, 67)

	for i, red in ipairs(self._typeRed) do
		goutil.setActive(red, PetRelationController.instance:haveCanActivePet(i + 1))
	end

	UpdateBeat:Add(self._setLineSeat, self)
end

function PetrelationView:_setLineSeat()
	local x, y = Framework.TransformUtil.GetAnchoredPos(self._content.transform, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(self._baseMask.transform, x, y)
	Framework.TransformUtil.SetAnchoredPos(self._secondBgLine.transform, x, y)
	Framework.TransformUtil.SetAnchoredPos(self._secondLine.transform, x, y)
	Framework.TransformUtil.SetAnchoredPos(self._pets.transform, x, y)
end

function PetrelationView:onExit()
	PetrelationView.super.onExit(self)

	self._onExitFlag = true

	UpdateBeat:Remove(self._twoTouchScale, self)
	UpdateBeat:Remove(self._setLineSeat, self)
	FixedUpdateBeat:Remove(self._showPetAnimation, self)
	FixedUpdateBeat:Remove(self._clearPetAnimation, self)
	FixedUpdateBeat:Remove(self._transition, self)
	self._baseLine:ClearVertices()

	self._baseLine.enabled = true

	self._baseBgLine:ClearVertices()

	self._baseBgLine.enabled = true

	self._secondLine:ClearVertices()
	self._secondBgLine:ClearVertices()

	if self._petSeat and self._petSeat.pointerArray then
		for i, v in ipairs(self._petSeat.pointerArray) do
			if v.cell then
				GameUtil.setImgJianying(goutil.findChild(v.cell, "pet/head"), false)
				uGuiUtil.clearImage(goutil.findChild(v.cell, "pet"))
				goutil.destroy(v.cell)

				v.cell = nil
			end

			if v.eff then
				UIEffectManager.instance:stopEffect(v.eff)
			end
		end
	end

	if self._teamEff then
		for k, eff in ipairs(self._teamEff) do
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	if self._params then
		for i, v in ipairs(self._params.linkInfo) do
			if v.cell then
				goutil.destroy(v.cell)
			end
		end
	end

	for i = self._secondBgLine.transform.childCount - 1, 0, -1 do
		goutil.destroy(self._secondBgLine.transform:GetChild(i).gameObject)
	end

	goutil.setActive(self._title, true)

	self._bg.enabled = true
	self._touchScaleFlag = true

	self._closeBtn:RemoveClickListener()
	self._closeBtn:AddClickListener(self.close, self)
	UIEffectManager.instance:stopEffect(self._bgEff)
	RedPointController.instance:unregRedPoint(self._petbookRed)
	self._teamView:dispose()
	self:showTabAt(self._btnTipsRoot, "")
end

function PetrelationView:drawBaseLine()
	local bool = self._type ~= 1

	goutil.setActive(self._switchOn, bool)
	goutil.setActive(self._switchOff, not bool)
	goutil.setActive(self._teamViewGo, bool)
	goutil.setActive(self._typeView, bool)

	self._petSeat = PetRelationModel.instance:getPetSeat(self._type)
	self._canActiveIds = {}

	self:initSeat()
	table.sort(self._showPetAnimParam, function(a, b)
		return a.distance < b.distance
	end)

	self._showPetAnimParam.length = #self._showPetAnimParam

	local contentWidth, contentHeight = PetRelationModel.instance:getMaxWidthAndHeight(self._type)

	self._showPetAnimParam.radMax = math.max(contentWidth, contentHeight)

	GameUtil.setWidth(self._content, contentWidth)
	GameUtil.setHeight(self._content, contentHeight)

	if #self._canActiveIds > 0 then
		math.randomseed(os.time())

		local vector = GameUtil.getAnchoredPos(self._petSeat[self._canActiveIds[math.random(#self._canActiveIds)]].cell)
		local centerMove = Vector2.New(-1 * vector.x * self._contentScale, -1 * vector.y * self._contentScale)

		GameUtil.setAnchoredPos(self._content, centerMove.x, centerMove.y)
	elseif self._petSeat.User then
		local vector = GameUtil.getAnchoredPos(self._petSeat.User.cell)
		local centerMove = Vector2.New(-1 * vector.x * self._contentScale, -1 * vector.y * self._contentScale)

		GameUtil.setAnchoredPos(self._content, centerMove.x, centerMove.y)
	else
		GameUtil.setAnchoredPos(self._content, 0, 0)
	end

	self:_animationLock(true)
	FixedUpdateBeat:Add(self._showPetAnimation, self)

	local teamIds = PetRelationConfig.instance:getPosterByType(self._type) or {}
	local teamInfos = {}

	for i, teamId in ipairs(teamIds) do
		table.insert(teamInfos, HandbookModel.instance:getPosterDataByTeamId(teamId))
	end

	self._teamView:reloadData(teamInfos)
	self:drawFrame()
end

function PetrelationView:initSeat()
	for i, v in ipairs(self._petSeat.pointerArray) do
		local cell = goutil.cloneAndSetParent(self._cell, self._pets.transform, "pet_" .. v.raceId)

		goutil.setActive(cell, true)

		v.cell = cell

		table.insert(self._showPetAnimParam, {
			distance = v.distance,
			animation = cell:GetComponent("Animation")
		})
		GameUtil.setAnchoredPos(cell, v.position.x, v.position.y)
		GameUtil.setLocalScale(goutil.findChild(cell, "pet"), v.scale, v.scale, 1)
		GameUtil.setLocalScale(cell, 0, 0, 0)

		local petCo = CharacterConfig.instance:getPetCo(PetSkinConfig.instance:getPetSkinRaceId(v.raceId))
		local nameText = goutil.findChildTextComponent(cell, "pet/name")

		if petCo then
			local modelCo = CharacterConfig.instance:getModelCo(tonumber(v.raceId))
			local petBg = goutil.findChildComponent(cell, "pet", "UIImageSpriteChange")
			local nameColor = goutil.findChildComponent(cell, "pet/name", "UITextColorChange")

			uGuiUtil.setSpriteToImage(goutil.findChild(cell, "pet/head"), uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

			local raceId = PetSkinConfig.instance:getPetSkinRaceId(v.raceId)

			if HandbookModel.instance:isHasPet(raceId) then
				local eff

				if HandbookController.instance:getIfCanActive(raceId) then
					petBg:SetState(1)
					nameColor:SetState(1)

					eff = "fx_ui_jinglingjihuo/fx_ui_kejihuo.prefab"

					local headGo = goutil.findChild(cell, "pet/head")

					uGuiUtil.setGoGrayState(headGo, true)
					GameUtil.setImgJianying(headGo, true, 31, 35, 41)
					table.insert(self._canActiveIds, v.raceId)
				else
					petBg:SetState(0)
					nameColor:SetState(0)

					eff = "fx_ui_jinglingjihuo/fx_ui_yijihuo.prefab"
				end

				v.eff = UIEffectManager.instance:playEffect(self, eff, nil, 0, 0, true, nil, nil, function(finishHandler, eff)
					if goutil.isNil(cell) then
						return
					end

					eff.effGo.transform:SetParent(cell.transform)
					Framework.TransformUtil.SetLocalScale(eff.effGo.transform, v.scale, v.scale, v.scale)
					Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
				end)
			else
				petBg:SetState(1)
				nameColor:SetState(1)

				local headGo = goutil.findChild(cell, "pet/head")

				uGuiUtil.setGoGrayState(headGo, true)
				GameUtil.setImgJianying(headGo, true, 31, 35, 41)
			end

			nameText.text = PetSkinConfig.instance:getPetSkinName(v.raceId)
		elseif v.raceId == "User" then
			local petBg = goutil.findChildComponent(cell, "pet", "UIImageSpriteChange")

			petBg:SetState(0)

			local headId = RoleModel.instance:getHeadIconId()

			if headId == 1 then
				uGuiUtil.setSpriteToImage(goutil.findChild(cell, "pet/head"), uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("headicon", "com_player_b2_"))
			else
				uGuiUtil.setSpriteToImage(goutil.findChild(cell, "pet/head"), uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("headicon", "com_player_g2_"))
			end

			nameText.text = RoleModel.instance:getUserName()

			nameText.transform:SetAsLastSibling()
			goutil.setActive(cell, false)
		end

		for i = 2, #v.linkPetId do
			local lineInfo = PetRelationModel.instance:getLineInfo(v.raceId, v.linkPetId[i])

			if lineInfo and self._petSeat[v.linkPetId[i]] then
				local thickness = tonumber(lineInfo.thickness)
				local linkPos = self._petSeat[v.linkPetId[i]].position

				self._baseLine:AddVertices(v.position, linkPos, lineInfo.color, thickness)
				self._baseBgLine:AddVertices(v.position, linkPos, lineInfo.color, thickness / 3)
			end
		end

		if HandbookModel.instance:isHasPet(v.raceId) and HandbookController.instance:getIfCanActive(v.raceId) then
			goutil.setActive(goutil.findChild(cell, "canActive"), true)
			Framework.ButtonAdapter.Get(cell):AddClickListener(function()
				PetRelationModel.instance:setViewType(self._type)
				PetbookController.instance:openPetinfoView(PetSkinConfig.instance:getPetSkinRaceId(v.raceId))
			end)
		else
			goutil.setActive(goutil.findChild(cell, "canActive"), false)
			Framework.ButtonAdapter.Get(cell):AddClickListener(function()
				self:_onClickPet(v.raceId)
			end)
		end
	end
end

function PetrelationView:drawFrame()
	for i, v in ipairs(self._petSeat.pointerArray) do
		v.frameStaus = false

		goutil.setActive(goutil.findChild(v.cell, "frame"), v.frameStaus)
	end
end

function PetrelationView:_animationLock(lock)
	self._animationFlag = lock

	for i, btn in ipairs(self._typeBtns) do
		uGuiUtil.setImageGrayStateRecursive(btn.gameObject, lock)
	end

	uGuiUtil.setImageGrayStateRecursive(self._switchBtn.gameObject, lock)
end

function PetrelationView:_slideChange()
	local vector = GameUtil.getAnchoredPos(self._content) / self._contentScale
	local diffScale = self._contentMaxScale - self._contentMinScale

	self._contentScale = self._contentMinScale + self._scaleSlider:GetValue() * diffScale
	self._sliderScale.text = self._contentScale
	vector = vector * self._contentScale

	GameUtil.setLocalScale(self._content, self._contentScale, self._contentScale, 1)
	GameUtil.setAnchoredPos(self._content, vector.x, vector.y)
	self:_updateScaleByContent()
	self:_setLineSeat()
end

function PetrelationView:_twoTouchScale()
	if not self._touchScaleFlag then
		return
	end

	if Input.touchCount > 1 and (Input.GetTouch(0).phase == UnityEngine.TouchPhase.Moved or Input.GetTouch(1).phase == UnityEngine.TouchPhase.Moved) then
		local tempPosition1 = Input.GetTouch(0).position
		local tempPosition2 = Input.GetTouch(1).position
		local vector = GameUtil.getAnchoredPos(self._content) / self._contentScale

		self._contentScale = self:_isEnlarge(self._oldPosition1, self._oldPosition2, tempPosition1, tempPosition2) and math.min(self._contentScale + 0.02, self._contentMaxScale) or math.max(self._contentScale - 0.02, self._contentMinScale)
		vector = vector * self._contentScale

		GameUtil.setLocalScale(self._content, self._contentScale, self._contentScale, 1)
		GameUtil.setAnchoredPos(self._content, vector.x, vector.y)
		self:_updateScaleByContent()
		self:_setLineSeat()

		self._oldPosition1 = tempPosition1
		self._oldPosition2 = tempPosition2
	end
end

function PetrelationView:_isEnlarge(oP1, oP2, nP1, nP2)
	return GameUtil.getVector2Distance(oP1, oP2) < GameUtil.getVector2Distance(nP1, nP2)
end

function PetrelationView:_updateScaleByContent()
	local x, y, z = Framework.TransformUtil.GetLocalScale(self._content.transform, 0, 0, 0)

	Framework.TransformUtil.SetLocalScale(self._baseMask.transform, x, y, z)
	Framework.TransformUtil.SetLocalScale(self._secondBgLine.transform, x, y, z)
	Framework.TransformUtil.SetLocalScale(self._secondLine.transform, x, y, z)
	Framework.TransformUtil.SetLocalScale(self._pets.transform, x, y, z)
end

function PetrelationView:_showPetAnimation()
	if self._onExitFlag then
		return
	end

	self._showPetAnimParam.rad = self._showPetAnimParam.rad + 100

	local rad = math.max(self._showPetAnimParam.rad, 0)

	GameUtil.setWidth(self._baseMask, rad)
	GameUtil.setHeight(self._baseMask, rad)

	local index = self._showPetAnimParam.index

	if rad <= self._showPetAnimParam.radMax then
		while index <= self._showPetAnimParam.length and self._showPetAnimParam[index].distance < (self._showPetAnimParam.rad + 2500) / 2 do
			self._showPetAnimParam[index].animation:Play()

			index = index + 1
			self._showPetAnimParam.index = index
		end

		local percent = rad / self._showPetAnimParam.radMax

		self._baseLineMat:SetFloat("_MaskCenter", percent)

		local x, y, z = Framework.TransformUtil.GetAnchoredPos(self._teamViewGo.transform, 0, 0)

		GameUtil.setAnchoredPos(self._teamViewGo, x, 56.5 + 600 * (1 - percent))
	else
		FixedUpdateBeat:Remove(self._showPetAnimation, self)
		self._baseLineMat:SetFloat("_MaskCenter", 1)

		local x, y, z = Framework.TransformUtil.GetAnchoredPos(self._teamViewGo.transform, 0, 0)

		GameUtil.setAnchoredPos(self._teamViewGo, x, 56.5)
		self:_animationLock(false)
	end
end

function PetrelationView:_clearPetAnimation()
	if self._onExitFlag then
		return
	end

	self._clearPetAnimParam.rad = self._clearPetAnimParam.rad - 100

	local rad = self._clearPetAnimParam.rad

	GameUtil.setWidth(self._baseMask, rad)
	GameUtil.setHeight(self._baseMask, rad)

	local index = 1

	if rad > 0 then
		while index <= self._clearPetAnimParam.length and self._clearPetAnimParam[index].distance > rad / 2 do
			self._clearPetAnimParam[index].animation:Play("petExit")

			index = index + 1
			self._clearPetAnimParam.index = index
		end

		local percent = rad / self._showPetAnimParam.radMax

		self._baseLineMat:SetFloat("_MaskCenter", percent)

		local x, y = Framework.TransformUtil.GetAnchoredPos(self._teamViewGo.transform, 0, 0)

		GameUtil.setAnchoredPos(self._teamViewGo, x, 56.5 + 600 * (1 - percent))
	else
		self._baseLineMat:SetFloat("_MaskCenter", 0)

		local x, y = Framework.TransformUtil.GetAnchoredPos(self._teamViewGo.transform, 0, 0)

		GameUtil.setAnchoredPos(self._teamViewGo, x, 656.5)

		if self._clearPetAnimParam[1] and self._clearPetAnimParam[1].animation.isPlaying then
			return
		end

		FixedUpdateBeat:Remove(self._clearPetAnimation, self)
		self._baseLine:ClearVertices()
		self._baseBgLine:ClearVertices()

		for i, v in ipairs(self._petSeat.pointerArray) do
			if v.cell then
				GameUtil.setImgJianying(goutil.findChild(v.cell, "pet/head"), false)
				uGuiUtil.clearImage(goutil.findChild(v.cell, "pet"))
				goutil.destroy(v.cell)

				v.cell = nil
			end
		end

		self._showPetAnimParam = {
			index = 1,
			rad = -2500
		}

		self:drawBaseLine()
	end
end

function PetrelationView:_loadLinkInfo(raceId)
	local linkInfo = {
		left = {},
		right = {},
		temp = {}
	}

	for i, v in ipairs(self._petSeat[raceId].linkPetId) do
		if self._petSeat[v] then
			local clone = goutil.cloneAndSetParent(self._petSeat[v].cell, self._secondLine.gameObject.transform)

			goutil.setActive(clone, true)
			Framework.ButtonAdapter.Get(clone):RemoveClickListener()

			local scaleSpeed = (self._params.standardScale - self._petSeat[v].scale) / (10 * self._petSeat[v].scale)

			if i > 1 then
				if self._petSeat[raceId].x > self._petSeat[v].x then
					table.insert(linkInfo.left, {
						cell = clone,
						raceId = v,
						scaleSpeed = scaleSpeed
					})

					linkInfo[#linkInfo + 1] = linkInfo.left[#linkInfo.left]
				elseif self._petSeat[raceId].x < self._petSeat[v].x then
					table.insert(linkInfo.right, {
						cell = clone,
						raceId = v,
						scaleSpeed = scaleSpeed
					})

					linkInfo[#linkInfo + 1] = linkInfo.right[#linkInfo.right]
				else
					table.insert(linkInfo.temp, {
						cell = clone,
						raceId = v,
						scaleSpeed = scaleSpeed
					})
				end
			else
				table.insert(linkInfo, {
					cell = clone,
					raceId = v,
					scaleSpeed = scaleSpeed
				})
			end
		end
	end

	for i, v in ipairs(linkInfo.temp) do
		if #linkInfo.left > #linkInfo.right then
			table.insert(linkInfo.right, v)

			linkInfo[#linkInfo + 1] = linkInfo.right[#linkInfo.right]
		else
			table.insert(linkInfo.left, v)

			linkInfo[#linkInfo + 1] = linkInfo.left[#linkInfo.left]
		end
	end

	linkInfo.temp = GameUtil.getAnchoredPos(linkInfo[1].cell)

	table.sort(linkInfo.left, function(a, b)
		return GameUtil.getAnchoredPos(a.cell).y < GameUtil.getAnchoredPos(b.cell).y
	end)
	table.sort(linkInfo.right, function(a, b)
		return GameUtil.getAnchoredPos(a.cell).y < GameUtil.getAnchoredPos(b.cell).y
	end)

	local num = #linkInfo.left
	local angle = math.pi * 5 / 6 / (num + 1)

	for i, info in ipairs(linkInfo.left) do
		local tempAngle = angle * i - math.pi * 5 / 12
		local tempVector = Vector2.New(-400 * math.cos(tempAngle), 400 * math.sin(tempAngle))

		info.position = tempVector / self._contentScale + linkInfo.temp
		info.moveVec = (info.position - GameUtil.getAnchoredPos(info.cell)) / 10
	end

	num = #linkInfo.right
	angle = math.pi * 5 / 6 / (#linkInfo.right + 1)

	for i, info in ipairs(linkInfo.right) do
		local tempAngle = angle * i - math.pi * 5 / 12
		local tempVector = Vector2.New(400 * math.cos(tempAngle), 400 * math.sin(tempAngle))

		info.position = tempVector / self._contentScale + linkInfo.temp
		info.moveVec = (info.position - GameUtil.getAnchoredPos(info.cell)) / 10
	end

	return linkInfo
end

function PetrelationView:_onClickPet(raceId)
	if self._animationFlag then
		return
	end

	goutil.setActive(self._recoveryBtn.gameObject, true)

	self._touchScaleFlag = false

	self:_setBgActive(false)

	for i, v in ipairs(self._petSeat.pointerArray) do
		goutil.setActive(goutil.findChild(v.cell, "frame"), false)
		goutil.setActive(v.cell, false)
	end

	local petCell = self._petSeat[raceId].cell
	local x, y, z = Framework.TransformUtil.GetAnchoredPos(petCell.transform, 0, 0)

	self._params = {
		selectRaceId = raceId,
		centerMove = Vector2.New(-1 * x * self._contentScale, -1 * y * self._contentScale)
	}
	self._params.moveVec = (self._params.centerMove - GameUtil.getAnchoredPos(self._content)) / 10
	self._params.moveSp = Vector2.Magnitude(self._params.moveVec)
	self._params.standardScale = 1.8 / self._contentScale
	self._params.linkInfo = self:_loadLinkInfo(raceId)
	self._transitionFlag = 1

	FixedUpdateBeat:Add(self._transition, self)
	self._closeBtn:RemoveClickListener()
	self._closeBtn:AddClickListener(self._recovery, self)
end

function PetrelationView:_onClickSwitchPet(raceId)
	local petCell = self._petSeat[raceId].cell
	local x, y, z = Framework.TransformUtil.GetAnchoredPos(petCell.transform, 0, 0)

	for i = self._secondBgLine.transform.childCount - 1, 0, -1 do
		goutil.destroy(self._secondBgLine.transform:GetChild(i).gameObject)
	end

	self._params.selectRaceId = raceId
	self._params.centerMove = Vector2.New(-1 * x * self._contentScale, -1 * y * self._contentScale)
	self._params.moveVec = (self._params.centerMove - GameUtil.getAnchoredPos(self._content)) / 10
	self._params.moveSp = Vector2.Magnitude(self._params.moveVec)
	self._params.standardScale = 1.8 / self._contentScale

	goutil.setActive(goutil.findChild(self._params.linkInfo[1].cell, "pet/frame"), false)
	goutil.setActive(goutil.findChild(self._params.linkInfo[1].cell, "pet/detailsBtn"), false)

	local linkInfo = self:_loadLinkInfo(raceId)

	for i, oldInfo in ipairs(self._params.linkInfo) do
		for j, newInfo in ipairs(linkInfo) do
			if oldInfo.raceId == newInfo.raceId then
				if newInfo.cell ~= oldInfo.cell then
					goutil.destroy(newInfo.cell)
				end

				newInfo.cell = oldInfo.cell
				newInfo.scaleSpeed = 0

				if newInfo.raceId == raceId then
					newInfo.position = GameUtil.getAnchoredPos(petCell)
				end

				newInfo.moveVec = (newInfo.position - GameUtil.getAnchoredPos(newInfo.cell)) / 10
				oldInfo.retainFlag = true
			end
		end

		local switchBtn = goutil.findChild(oldInfo.cell, "pet/switchBtn")

		Framework.ButtonAdapter.Get(switchBtn):RemoveClickListener()
		goutil.setActive(switchBtn, false)

		if not oldInfo.retainFlag then
			goutil.destroy(oldInfo.cell)
		end
	end

	linkInfo[1].moveSpeed = Vector2.Magnitude(linkInfo[1].moveVec)
	self._params.linkInfo = linkInfo

	self._secondLine:ClearVertices()
	self._secondBgLine:ClearVertices()

	self._switchFlag = 1

	FixedUpdateBeat:Add(self._switch, self)
end

function PetrelationView:_onClickTypeBtn(index)
	if self._animationFlag then
		return
	end

	self._clearPetAnimParam = {
		length = self._showPetAnimParam.length,
		radMax = self._showPetAnimParam.radMax
	}
	self._clearPetAnimParam.rad = self._showPetAnimParam.rad

	for i, value in ipairs(self._showPetAnimParam) do
		table.insert(self._clearPetAnimParam, value)
	end

	table.sort(self._clearPetAnimParam, function(a, b)
		return a.distance > b.distance
	end)

	self._type = index + 1

	for i, btn in ipairs(self._typeBtns) do
		goutil.setActive(goutil.findChild(btn, "select"), i == index)
	end

	self:_animationLock(true)
	FixedUpdateBeat:Add(self._clearPetAnimation, self)
end

function PetrelationView:_onClickSwitch()
	if self._type == 1 then
		self:_onClickTypeBtn(1)
	else
		self:_onClickTypeBtn(0)
	end
end

function PetrelationView:_secondAnimationEnd()
	for i, info in ipairs(self._params.linkInfo) do
		if i > 1 then
			local switchBtn = goutil.findChild(info.cell, "pet/switchBtn")

			switchBtn.transform:SetAsLastSibling()
			Framework.ButtonAdapter.Get(switchBtn):AddClickListener(function()
				self:_onClickSwitchPet(info.raceId)
			end)
			goutil.setActive(switchBtn, true)
			GameUtil.setAnchoredPos(info.cell, info.position.x, info.position.y)
		end
	end

	if self._params.linkInfo[1].raceId ~= "User" then
		local detailsBtn = goutil.findChild(self._params.linkInfo[1].cell, "pet/detailsBtn")

		if PetbookModel.instance:PetBookHave(PetSkinConfig.instance:getPetSkinRaceId(self._params.linkInfo[1].raceId)) then
			goutil.setActive(detailsBtn, true)
			Framework.ButtonAdapter.Get(detailsBtn):AddClickListener(function()
				if self._finishHeadItemRefreshFlag then
					self:_recovery()
					PetbookController.instance:openPetinfoView(PetSkinConfig.instance:getPetSkinRaceId(self._params.linkInfo[1].raceId))
				end
			end)
		end
	end

	for i, info in ipairs(self._params.linkInfo.left) do
		local line = PetRelationModel.instance:getLineInfo(self._params.selectRaceId, info.raceId)
		local relationName = PetRelationModel.instance:getRelationName(self._params.selectRaceId, info.raceId)

		self:_createSecondLine(self._params.linkInfo.temp, info.position, line.color, 12, relationName)
		self._secondLine:AddVertices(info.position, info.position + Vector2.New(-900, 0), line.color, 12)
		self._secondBgLine:AddVertices(info.position, info.position + Vector2.New(-900, 0), line.color, 4)
	end

	for i, info in ipairs(self._params.linkInfo.right) do
		local line = PetRelationModel.instance:getLineInfo(self._params.selectRaceId, info.raceId)
		local relationName = PetRelationModel.instance:getRelationName(self._params.selectRaceId, info.raceId)

		self:_createSecondLine(self._params.linkInfo.temp, info.position, line.color, 12, relationName)
		self._secondLine:AddVertices(info.position, info.position + Vector2.New(900, 0), line.color, 12)
		self._secondBgLine:AddVertices(info.position, info.position + Vector2.New(900, 0), line.color, 4)
	end
end

function PetrelationView:_createSecondLine(firstPos, secondPos, color, thickness, name)
	self._secondLine:AddVertices(firstPos, secondPos, color, thickness)
	self._secondBgLine:AddVertices(firstPos, secondPos, color, thickness / 3)

	local nameGo = goutil.cloneAndSetParent(self._relationName, self._secondBgLine.transform)
	local nameText = nameGo:GetComponent(goutil.Type_UIText)

	if name ~= "0" then
		nameText.text = name
	end

	Game.TextUtil.SetColorRGBA(nameText, color.r, color.g, color.b, color.a)
	goutil.setActive(nameGo, true)

	local pos = (firstPos + secondPos) / 2

	GameUtil.setAnchoredPos(nameGo, pos.x, pos.y + 40)

	local vector = firstPos - secondPos

	if vector.x < 0 then
		vector = -1 * vector
	end

	if vector.y >= 0 then
		Framework.TransformUtil.SetLocalRotation(nameGo.transform, 0, 0, Vector2.Angle(Vector2.right, vector))
	else
		Framework.TransformUtil.SetLocalRotation(nameGo.transform, 0, 0, -1 * Vector2.Angle(Vector2.right, vector))
	end
end

function PetrelationView:_transition()
	if self._onExitFlag then
		return
	end

	if self._transitionFlag == 1 then
		local distance = GameUtil.getVector2Distance(GameUtil.getAnchoredPos(self._content), self._params.centerMove)

		if distance > self._params.moveSp and distance > 0.1 then
			local x, y, z = Framework.TransformUtil.GetAnchoredPos(self._content.transform, 0, 0)

			GameUtil.setAnchoredPos(self._content, x + self._params.moveVec.x, y + self._params.moveVec.y)
		else
			GameUtil.setAnchoredPos(self._content, self._params.centerMove.x, self._params.centerMove.y)

			self._transitionFlag = self._transitionFlag + 1
		end

		self._times = 0
	elseif self._transitionFlag == 2 then
		if self._times < 10 then
			for i, info in ipairs(self._params.linkInfo) do
				local scale = GameUtil.getLocalScale(info.cell).x

				GameUtil.setLocalScale(info.cell, scale + info.scaleSpeed, scale + info.scaleSpeed, 1)

				if info.moveVec then
					local x, y, z = Framework.TransformUtil.GetAnchoredPos(info.cell.transform, 0, 0)

					GameUtil.setAnchoredPos(info.cell, x + info.moveVec.x, y + info.moveVec.y)
				end
			end

			self._times = self._times + 1
		else
			self:_secondAnimationEnd()

			self._transitionFlag = self._transitionFlag + 1
		end
	else
		FixedUpdateBeat:Remove(self._transition, self)
	end
end

function PetrelationView:_switch()
	if self._switchFlag == 1 then
		if GameUtil.getVector2Distance(GameUtil.getAnchoredPos(self._content), self._params.centerMove) > self._params.moveSp then
			local vector = GameUtil.getAnchoredPos(self._content) + self._params.moveVec

			GameUtil.setAnchoredPos(self._content, vector.x, vector.y)

			for i, info in ipairs(self._params.linkInfo) do
				local scale = GameUtil.getLocalScale(info.cell).x

				GameUtil.setLocalScale(info.cell, scale + info.scaleSpeed, scale + info.scaleSpeed, 1)

				if info.moveVec then
					local x, y, z = Framework.TransformUtil.GetAnchoredPos(info.cell.transform, 0, 0)

					GameUtil.setAnchoredPos(info.cell, x + info.moveVec.x, y + info.moveVec.y)
				end
			end
		else
			GameUtil.setAnchoredPos(self._content, self._params.centerMove.x, self._params.centerMove.y)

			self._switchFlag = self._switchFlag + 1

			GameUtil.setAnchoredPos(self._params.linkInfo[1].cell, self._params.linkInfo[1].position.x, self._params.linkInfo[1].position.y)
			self:_secondAnimationEnd()

			self._switchFlag = self._switchFlag + 1
		end
	else
		FixedUpdateBeat:Remove(self._switch, self)
	end
end

function PetrelationView:_recovery()
	FixedUpdateBeat:Remove(self._transition, self)
	FixedUpdateBeat:Remove(self._switch, self)
	self._secondLine:ClearVertices()
	self._secondBgLine:ClearVertices()

	for i = self._secondBgLine.transform.childCount - 1, 0, -1 do
		goutil.destroy(self._secondBgLine.transform:GetChild(i).gameObject)
	end

	local petCell = self._petSeat[self._params.selectRaceId].cell
	local x, y, z = Framework.TransformUtil.GetAnchoredPos(petCell.transform, 0, 0)

	GameUtil.setAnchoredPos(self._content, -1 * x * self._contentScale, -1 * y * self._contentScale)

	for i, v in ipairs(self._petSeat.pointerArray) do
		goutil.setActive(v.cell, true)
		goutil.setActive(goutil.findChild(v.cell, "frame"), v.frameStaus)
	end

	for i = self._secondLine.transform.childCount - 1, 0, -1 do
		goutil.destroy(self._secondLine.transform:GetChild(i).gameObject)
	end

	self:_setBgActive(true)

	self._touchScaleFlag = true

	goutil.setActive(self._recoveryBtn.gameObject, false)
	self._closeBtn:RemoveClickListener()
	self._closeBtn:AddClickListener(self.close, self)
end

function PetrelationView:_setBgActive(flag)
	self._bg.enabled = flag

	goutil.setActive(self._title, flag)

	self._baseLine.enabled = flag
	self._baseBgLine.enabled = flag

	goutil.setActive(self._btnBg, flag)
	goutil.setActive(self._switchBtn.gameObject, flag)
	goutil.setActive(self._typeView, flag)
	goutil.setActive(self._teamViewGo, flag)
end

function PetrelationView:_updateTeamCell(view, cell, data, tag)
	local cfg = data.cfg

	uGuiUtil.setSpriteToImage(cell.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("petrelation/" .. cfg.btnIcon))
	Framework.ButtonAdapter.Get(cell.gameObject):AddClickListener(function()
		PetRelationModel.instance:setViewType(self._type)
		UIStateManager.instance:push(ViewName.PetpostershowView, data.cfg.teamId)
	end)

	local info = data.info

	if info and info.petListHasGain then
		goutil.findChildTextComponent(cell.gameObject, "txtNum").text = #info.petListHasGain or 0
	end

	if cfg.needRaceIds then
		goutil.findChildTextComponent(cell.gameObject, "txtTotal").text = #cfg.needRaceIds or 1
	end

	if HandbookModel.instance:getIsPosterShowRedPointByTeamId(data.cfg.teamId) then
		goutil.setActive(goutil.findChild(cell.gameObject, "red/icon"), true)

		if self._teamEff[cell] then
			return
		end

		local eff = "common/fx_ui_kuang2_common.prefab"

		self._teamEff[cell] = UIEffectManager.instance:playEffect(self, eff, nil, 0, 0, true, nil, nil, function(finishHandler, eff)
			eff.effGo.transform:SetParent(goutil.findChild(cell.gameObject, "red").transform)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
			eff:setScrollRectClipping(self._teamViewGo:GetComponent(typeof(UnityEngine.UI.ScrollRect)))
		end)
	else
		goutil.setActive(goutil.findChild(cell.gameObject, "red/icon"), false)

		if self._teamEff[cell] then
			UIEffectManager.instance:stopEffect(self._teamEff[cell])

			self._teamEff[cell] = nil
		end
	end
end

function PetrelationView:_finishHeadItemRefresh()
	self._finishHeadItemRefreshFlag = true
end

function PetrelationView:_onClickBtnTips()
	local viewName, dataList = HandbookController.instance:getPopWinPetRelationTipsViewAndDataList()

	self:showTabAt(self._btnTipsRoot, viewName, dataList)
end

return PetrelationView
