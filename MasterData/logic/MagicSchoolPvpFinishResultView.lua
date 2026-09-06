-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpFinishResultView.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpFinishResultView", package.seeall)

local MagicSchoolPvpFinishResultView = class("MagicSchoolPvpFinishResultView", ViewComponent)

function MagicSchoolPvpFinishResultView:buildUI()
	MagicSchoolPvpFinishResultView.super.buildUI(self)

	self._txtTips = self:getTxt("txtTips")
	self._titleNum = self:getGo("titleNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._tagResult = self:getGo("tagResult")
	self._txtTagResult = self:getTxt("tagResult/txt")
	self._btnVideo = self:getGo("btnVideo")

	local leftTeam = self:getGo("leftTeam")
	local rightTeam = self:getGo("rightTeam")
	local teamGos = {
		leftTeam,
		rightTeam
	}

	self._teamCells = {}

	for _, campId in ipairs(MagicSchoolPvPEnum.CampIdList) do
		self._teamCells[campId] = {}

		local cell = self._teamCells[campId]
		local mainGo = teamGos[campId]

		cell._mainGo = mainGo
		cell._damageGo = goutil.findChild(mainGo, "descView/damage")
		cell._txtValueDamage = goutil.findChildTextComponent(mainGo, "descView/damage/txtValue")
		cell._targetGo = goutil.findChild(mainGo, "descView/target")
		cell._txtValueTarget = goutil.findChildTextComponent(mainGo, "descView/target/txtValue")
		cell._tagFinishTarget = goutil.findChild(mainGo, "descView/target/tagFinish")
		cell._buffGo = goutil.findChild(mainGo, "descView/buff")

		local buffView = goutil.findChild(mainGo, "descView/buff/buffView")

		cell._buffCells = {}

		for idx = 1, buffView.transform.childCount do
			local buffGo = buffView.transform:GetChild(idx - 1).gameObject
			local buffCell = {}

			buffCell._mainGo = buffGo
			buffCell._mask = goutil.findChild(buffGo, "mask")
			buffCell._icon = goutil.findChild(buffGo, "mask/icon")
			buffCell._txtName = goutil.findChildTextComponent(buffGo, "txtName")
			cell._buffCells[idx] = buffCell
		end

		local playerView = goutil.findChild(mainGo, "playerView")

		cell._playerCells = {}

		for idx = 1, playerView.transform.childCount do
			local playerGo = playerView.transform:GetChild(idx - 1).gameObject
			local playerCell = {}

			playerCell._mainGo = playerGo
			playerCell._headCon = goutil.findChild(playerGo, "headCon")
			playerCell._tagMe = goutil.findChild(playerGo, "tagMe")
			playerCell._txtName = goutil.findChildTextComponent(playerGo, "txtName")
			cell._playerCells[idx] = playerCell
		end
	end
end

function MagicSchoolPvpFinishResultView:bindEvents()
	MagicSchoolPvpFinishResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnVideo, self._onClickbtnVideo, self)
end

function MagicSchoolPvpFinishResultView:unbindEvents()
	MagicSchoolPvpFinishResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnVideo)
end

function MagicSchoolPvpFinishResultView:onEnter()
	MagicSchoolPvpFinishResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = MagicSchoolPvPController.instance:getSubMo(self._activityId)
	self._myCampId = self._subMo:getCampId()
	self._gameEndRes = self._subMo:getGameEndRes()

	if self._gameEndRes == nil or self._gameEndRes.state < 0 then
		printError(string.format("结算错误gameEndRes is nil or state <= 0, msg:%s, state = %s", self._gameEndRes ~= nil, (self._gameEndRes or nil) and (self._gameEndRes.state or 0)))
		self:close()

		return
	end

	self._teamResults = {}

	for _, v in ipairs(self._gameEndRes.teamResults) do
		self._teamResults[v.campId] = v
	end

	self:_onUpdate()

	self._autoCloseTime = 8
	self._startRealTime = ServerTime.now()

	settimer(0.33, self._onTicking, self, true)
	self:_onTicking()
end

function MagicSchoolPvpFinishResultView:onExit()
	MagicSchoolPvpFinishResultView.super.onExit(self)
	removetimer(self._onTicking, self)

	for _, teamCell in pairs(self._teamCells) do
		for _, playerCell in pairs(teamCell._playerCells) do
			HeadItemController.instance:resetHeadCell(playerCell._headCon)
		end

		for _, buffCell in pairs(teamCell._buffCells) do
			uGuiUtil.clearImage(buffCell._icon)
			GameUtil.rmClickHandler(buffCell._mask)
		end
	end
end

function MagicSchoolPvpFinishResultView:_onTicking()
	local offsetTime = ServerTime.now() - self._startRealTime
	local leftTime = self._autoCloseTime - offsetTime

	if leftTime <= 0 then
		removetimer(self._onTicking, self)
		self:close()

		return
	end

	self._txtTips.text = string.format("剩余时间：%d", math.ceil(leftTime))
end

function MagicSchoolPvpFinishResultView:_onUpdate()
	local teamResults = {}

	for i, v in ipairs(self._gameEndRes.teamResults) do
		teamResults[v.campId] = v
	end

	for _, campId in ipairs(MagicSchoolPvPEnum.CampIdList) do
		local teamCell = self._teamCells[campId]
		local result = teamResults and teamResults[campId]

		if result then
			if not result.buffIds then
				local buffIds = {}

				if result then
					if not result.damages then
						local damages = {}
						local damageStr = ""

						for i, v in ipairs(damages) do
							damageStr = i > 1 and damageStr .. string.format("+%s", MmUtil.formatNumber(v.damage, MmUtil.Units_OnlyWB, 0)) or damageStr .. string.format("%s", MmUtil.formatNumber(v.damage, MmUtil.Units_OnlyWB, 0))
						end

						teamCell._txtValueDamage.text = damageStr

						for idx, playerCell in ipairs(teamCell._playerCells) do
							local playerMo = self._subMo:getTeamPlayer(campId, idx)

							GameUtil.SetActive(playerCell._mainGo, playerMo ~= nil)

							if playerMo then
								local headInfo = playerMo.headInfo
								local userId = headInfo.userId

								playerCell._txtName.text = headInfo.userName

								HeadItemController.instance:setHeadCellByInfo(playerCell._headCon, headInfo, false)
								GameUtil.SetActive(playerCell._tagMe, userId == RoleModel.instance:getUserId())
							else
								playerCell._txtName.text = "--"

								HeadItemController.instance:resetHeadCell(playerCell._headCon)
							end
						end

						for idx, buffCell in ipairs(teamCell._buffCells) do
							local buffId = buffIds[idx]

							if buffId and buffId > 0 then
								local buffData = MagicSchoolConfig.instance:getBuffCfgData(self._activityId, campId, buffId)
								local iconUrl = string.format("ui/icon/%s.png", buffData.iconUrl)

								uGuiUtil.setSpriteToImage(buffCell._icon, uGuiUtil.SpriteType.BigBg, iconUrl)

								buffCell._txtName.text = buffData.name

								GameUtil.SetActive(buffCell._mainGo, true)
								GameUtil.addClickHandler(buffCell._mask, function()
									MagicSchoolPvPController.instance:openBuffTipsView(self._activityId, campId, buffId, buffCell._mainGo)
								end)
							else
								uGuiUtil.clearImage(buffCell._icon)

								buffCell._txtName.text = "--"

								GameUtil.SetActive(buffCell._mainGo, false)
								GameUtil.rmClickHandler(buffCell._mask)
							end
						end
					end
				end
			end
		end
	end

	local totalDamages = {}

	for _, campId in ipairs(MagicSchoolPvPEnum.CampIdList) do
		local result = teamResults and teamResults[campId]

		if result then
			if not result.damages then
				local damages = {}

				totalDamages[campId] = 0

				for _, v in ipairs(damages) do
					totalDamages[campId] = totalDamages[campId] + v.damage
				end
			end
		end
	end

	local isWin = totalDamages[MagicSchoolPvPEnum.CampId_Black] >= totalDamages[MagicSchoolPvPEnum.CampId_White]

	GameUtil.setUIGroupIdx(self._tagResult, isWin and 0 or 1)

	self._txtTagResult.text = isWin and "黑魔法阵营   胜利" or "白魔法阵营   胜利"
end

function MagicSchoolPvpFinishResultView:_onClickbtnVideo()
	local teamResult = self._teamResults[self._myCampId]

	if teamResult and #teamResult.battleResult > 0 then
		UIJumper.instance:saveCurStack()
		BattleController.instance:viewUserFightMonsterBtlResultWithList(teamResult.battleResult)
	else
		FloatWordMgr.instance:show("没有战斗录像可播放")
	end
end

return MagicSchoolPvpFinishResultView
