-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/view/KingKaYaFmtExtisonView.lua

module("logic.extensions.kingisaacclg.view.KingKaYaFmtExtisonView", package.seeall)

local KingKaYaFmtExtisonView = class("KingKaYaFmtExtisonView", ViewComponent)

function KingKaYaFmtExtisonView:ctor()
	KingKaYaFmtExtisonView.super.ctor(self)

	self._yPos = 80
	self._xHide = 400
	self._xShow = -112
end

function KingKaYaFmtExtisonView:buildUI()
	KingKaYaFmtExtisonView.super.buildUI(self)

	self._btnHide = goutil.findChild(self.mainGO, "btnHide")
	self._btnArrow = goutil.findChild(self.mainGO, "moveNode/btnArrow")
	self._btnBuff = goutil.findChild(self.mainGO, "moveNode/btnBuff")
	self._moveNode = goutil.findChild(self.mainGO, "moveNode")
	self._arrowRectTrans = goutil.findChild(self.mainGO, "moveNode/btnArrow/arrowTran")
	self._fmtView = goutil.findChild(self.mainGO, "moveNode/fmtView")
	self._cond = goutil.findChild(self.mainGO, "cond")
	self._txtCond = goutil.findChildTextComponent(self.mainGO, "cond/txt")
	self._leftTagView = goutil.findChild(self.mainGO, "leftTagView")
	self._rightTagView = goutil.findChild(self.mainGO, "rightTagView")
	self._tagCellLists = {}

	for index, view in ipairs({
		self._leftTagView,
		self._rightTagView
	}) do
		local teamId = GameEnum.BattleTeamList[index]

		self._tagCellLists[teamId] = {}

		for posId = 1, view.transform.childCount do
			local cell = {}
			local go = view.transform:GetChild(posId - 1).gameObject

			cell._mainGo = go
			cell._icon = goutil.findChild(go, "icon")
			self._tagCellLists[teamId][posId] = cell
		end
	end
end

function KingKaYaFmtExtisonView:bindEvents()
	KingKaYaFmtExtisonView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnArrow, self._onClickArrow, self)
end

function KingKaYaFmtExtisonView:unbindEvents()
	KingKaYaFmtExtisonView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnArrow)
end

function KingKaYaFmtExtisonView:destroyUI()
	KingKaYaFmtExtisonView.super.destroyUI(self)
end

function KingKaYaFmtExtisonView:onEnter()
	KingKaYaFmtExtisonView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()

	local winScoreRequirements = self._customFmtMo:getWinScoreRequirements()

	self._selfPositionBuffs = self._customFmtMo:getSelfPositionBuffs()
	self._enemyPositionBuffs = self._customFmtMo:getEnemyPositionBuffs()
	self._creepsMasterId = self._customFmtMo:getCreepsMasterId()

	self.addGEvent(self, GlobalNotify.FormationChangeFinish, self._onUpdate, self)
	self:_initPopupState()

	if #winScoreRequirements > 0 then
		local condStr = "通关条件："

		for signId, score in ipairs(winScoreRequirements) do
			local signData = KingKaYaConfig.instance:getSignData(self._activityId, signId)

			condStr = signId < #winScoreRequirements and condStr .. string.format("%s≥<color=#f5e296>%s</color> ", signData.desc, score) or condStr .. string.format("%s≥<color=#f5e296>%s</color>", signData.desc, score)
		end

		self._txtCond.text = condStr

		GameUtil.SetActive(self._cond, true)
	else
		GameUtil.SetActive(self._cond, false)
	end

	self:_onUpdate()
end

function KingKaYaFmtExtisonView:onExit()
	KingKaYaFmtExtisonView.super.onExit(self)

	for battleTeam, tagCellList in pairs(self._tagCellLists) do
		for _, tagCell in pairs(tagCellList) do
			uGuiUtil.clearImage(tagCell._icon)
		end
	end

	local fmtView = self._fmtView

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local pet = goutil.findChild(go, "pet")
		local con = goutil.findChild(go, "pet/con")
		local iconSeatTag = goutil.findChild(go, "seatTag/icon")
		local markIcon = goutil.findChild(go, "markIcon")

		MaterialMgr.clearIcon(con)
		uGuiUtil.clearImage(iconSeatTag)
		uGuiUtil.clearImage(markIcon)
		GameUtil.rmClickHandler(pet)
	end
end

function KingKaYaFmtExtisonView:_onUpdate()
	local selfPositionBuffs = self._selfPositionBuffs
	local enmeyPositionBuffs = self._enemyPositionBuffs
	local creepsMasterId = self._creepsMasterId
	local enmeyCreepsCfg = KingKaYaConfig.instance:getCreepsCfg(creepsMasterId) or {}
	local enmeyPositions = {}

	for _, data in ipairs(enmeyCreepsCfg) do
		enmeyPositions[data.posId] = data.creepsId
	end

	local buffs = {}

	buffs[GameEnum.BattleTeam.Left] = selfPositionBuffs
	buffs[GameEnum.BattleTeam.Right] = enmeyPositionBuffs

	local positions = {}

	positions[GameEnum.BattleTeam.Left] = self._customFmtMo:getCurFormation():GetPositions()
	positions[GameEnum.BattleTeam.Right] = enmeyPositions

	for index, battleTeam in ipairs(GameEnum.BattleTeamList) do
		for posId = 1, 9 do
			local signId = checknumber(buffs[battleTeam][posId])
			local signData = KingKaYaConfig.instance:getSignData(self._activityId, signId)
			local petId = checknumber(positions[battleTeam][posId])
			local tagCell = self._tagCellLists[battleTeam][posId]

			GameUtil.SetActive(tagCell._mainGo, false)
			uGuiUtil.clearImage(tagCell._icon)

			if petId > 0 then
				GameUtil.SetActive(tagCell._mainGo, signData ~= nil)

				if signData then
					local spriteName = string.format("%s.png", signData.iconPath)

					uGuiUtil.setSpriteToImage(tagCell._icon, uGuiUtil.SpriteType.BigBg, spriteName)
				end
			end
		end
	end

	local fmtView = self._fmtView

	for posId = 1, fmtView.transform.childCount do
		local battleTeam = GameEnum.BattleTeam.Left
		local signId = checknumber(buffs[battleTeam][posId])
		local signData = KingKaYaConfig.instance:getSignData(self._activityId, signId)
		local petId = checknumber(positions[battleTeam][posId])
		local petMo = self._customFmtMo:getPetMoById(petId)
		local go = fmtView.transform:GetChild(posId - 1)
		local pet = goutil.findChild(go, "pet")
		local con = goutil.findChild(go, "pet/con")
		local seatTag = goutil.findChild(go, "seatTag")
		local txtSeatTag = goutil.findChildTextComponent(go, "seatTag/txt")
		local iconSeatTag = goutil.findChild(go, "seatTag/icon")
		local markIcon = goutil.findChild(go, "markIcon")

		GameUtil.SetActive(pet, false)
		GameUtil.SetActive(seatTag, false)
		GameUtil.SetActive(markIcon, false)
		MaterialMgr.clearIcon(con)
		MaterialMgr.clearIcon(markIcon)
		uGuiUtil.clearImage(iconSeatTag)

		if petMo then
			local skinId = petMo.curFaceId

			MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
			GameUtil.addClickHandler(pet, function()
				CommonTipsMgr.instance:showPetTips(petMo)
			end)
			GameUtil.SetActive(pet, true)

			if signData then
				txtSeatTag.text = signData.desc

				GameUtil.SetActive(seatTag, true)

				local spriteName = string.format("%s.png", signData.iconPath)

				uGuiUtil.setSpriteToImage(markIcon, uGuiUtil.SpriteType.BigBg, spriteName)
				GameUtil.SetActive(markIcon, true)
			end
		elseif signData then
			txtSeatTag.text = signData.desc

			local spriteName = string.format("%s.png", signData.iconPath)

			uGuiUtil.setSpriteToImage(iconSeatTag, uGuiUtil.SpriteType.BigBg, spriteName)
			GameUtil.SetActive(seatTag, true)
		end
	end
end

function KingKaYaFmtExtisonView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xShow, self._yPos, 0), Vector3.New(self._xHide, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function KingKaYaFmtExtisonView:_onClickArrow()
	if self._isPopupState then
		self._isPopupState = false

		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xShow, self._yPos, 0), Vector3.New(self._xHide, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	else
		self._isPopupState = true

		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xHide, self._yPos, 0), Vector3.New(self._xShow, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

function KingKaYaFmtExtisonView:_initPopupState()
	self._isPopupState = true

	Framework.TransformUtil.SetAnchoredPos(self._moveNode.transform, self._xShow, self._yPos)
	Framework.TransformUtil.SetLocalRotation(self._arrowRectTrans.transform, 0, 0, 0)
end

return KingKaYaFmtExtisonView
