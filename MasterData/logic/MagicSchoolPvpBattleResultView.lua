-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpBattleResultView.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpBattleResultView", package.seeall)

local MagicSchoolPvpBattleResultView = class("MagicSchoolPvpBattleResultView", ViewComponent)

function MagicSchoolPvpBattleResultView:buildUI()
	MagicSchoolPvpBattleResultView.super.buildUI(self)

	self._txtTips = self:getTxt("txtTips")
	self._titleNum = self:getGo("titleNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._tagResult = self:getGo("tagResult")
	self._txtTagResult = self:getTxt("tagResult/txt")

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
		cell._headCon = goutil.findChild(mainGo, "headCon")
		cell._txtName = goutil.findChildTextComponent(mainGo, "txtName")
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
	end
end

function MagicSchoolPvpBattleResultView:bindEvents()
	MagicSchoolPvpBattleResultView.super.bindEvents(self)
end

function MagicSchoolPvpBattleResultView:unbindEvents()
	MagicSchoolPvpBattleResultView.super.unbindEvents(self)
end

function MagicSchoolPvpBattleResultView:onEnter()
	MagicSchoolPvpBattleResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._bossId = checknumber(params[2])
	self._subMo = MagicSchoolPvPController.instance:getSubMo(self._activityId)

	self:_onUpdate()

	self._autoCloseTime = 5
	self._startRealTime = ServerTime.now()

	settimer(0.33, self._onTicking, self, true)
	self:_onTicking()
end

function MagicSchoolPvpBattleResultView:onExit()
	MagicSchoolPvpBattleResultView.super.onExit(self)
	removetimer(self._onTicking, self)

	for _, teamCell in pairs(self._teamCells) do
		HeadItemController.instance:resetHeadCell(teamCell._headCon)

		for _, cell in pairs(teamCell._buffCells) do
			uGuiUtil.clearImage(cell._icon)
			GameUtil.rmClickHandler(cell._mask)
		end
	end

	UIStateManager.instance:push(ViewName.MagicSchoolPvpBuffView, self._activityId)
end

function MagicSchoolPvpBattleResultView:_onTicking()
	local offsetTime = ServerTime.now() - self._startRealTime
	local leftTime = self._autoCloseTime - offsetTime

	if leftTime <= 0 then
		removetimer(self._onTicking, self)
		self:close()

		return
	end

	self._txtTips.text = string.format("剩余时间：%d", math.ceil(leftTime))
end

function MagicSchoolPvpBattleResultView:_onUpdate()
	self._titleNum:SetNum(self._bossId)

	local batMsg = self._subMo:getBattleMsg(self._bossId)
	local damageA = self._subMo:getDamageInRounds(self._bossId, MagicSchoolPvPEnum.CampId_Black)
	local damageB = self._subMo:getDamageInRounds(self._bossId, MagicSchoolPvPEnum.CampId_White)
	local isWin = damageB <= damageA

	GameUtil.setUIGroupIdx(self._tagResult, isWin and 0 or 1)

	self._txtTagResult.text = isWin and "黑魔法阵营   胜利" or "白魔法阵营   胜利"

	for _, campId in ipairs(MagicSchoolPvPEnum.CampIdList) do
		local teamCell = self._teamCells[campId]
		local playerMo = self._subMo:getTeamPlayer(campId, self._bossId)
		local damage = self._subMo:getDamageInRounds(self._bossId, campId)
		local userName = playerMo and playerMo.headInfo.userName
		local headInfo = playerMo and playerMo.headInfo
		local isMyCamp = campId == self._subMo:getCampId()

		if playerMo == nil then
			printError(string.format("错误- playerMo is nil-> activityId:%s, bossId:%s, campId:%s,", self._activityId, self._bossId, campId))
		end

		teamCell._txtName.text = userName
		teamCell._txtValueDamage.text = MmUtil.formatNumber(damage, MmUtil.Units_OnlyWB, 0)

		if headInfo then
			HeadItemController.instance:setHeadCellByInfo(teamCell._headCon, headInfo, false)
		else
			HeadItemController.instance:resetHeadCell(teamCell._headCon)
		end

		GameUtil.SetActive(teamCell._buffGo, true)

		local buffList = {}

		if isMyCamp then
			table.insertto(buffList, batMsg.selectedBuffIds)
		else
			table.insertto(buffList, batMsg.opSelectedBuffIds)
		end

		for idx, buffCell in ipairs(teamCell._buffCells) do
			local buffId = buffList[idx]

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

		GameUtil.SetActive(teamCell._targetGo, isMyCamp)

		if isMyCamp then
			local bossData = MagicSchoolPvpConfig.instance:getBossData(self._activityId, self._bossId)

			teamCell._txtValueTarget.text = bossData.resultTargetDesc

			if batMsg then
				GameUtil.setUIImageSpriteIdx(teamCell._tagFinishTarget, batMsg.finishBuffTarget and 0 or 1)
			else
				GameUtil.setUIImageSpriteIdx(teamCell._tagFinishTarget, 1)
			end
		end
	end
end

return MagicSchoolPvpBattleResultView
