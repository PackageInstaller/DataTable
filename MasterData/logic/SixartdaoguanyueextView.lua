-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanyueextView.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanyueextView", package.seeall)

local SixartdaoguanyueextView = class("SixartdaoguanyueextView", ViewComponent)

function SixartdaoguanyueextView:buildUI()
	SixartdaoguanyueextView.super.buildUI(self)

	self._recordPos = self:getGo("rightTagView"):GetComponent(typeof(TestRecordPos))
	self._rootTr = self:getGo("rightTagView").transform
	self._descGo = self:getGo("desc")
	self._txtDesc = self:getTxt("desc/txtDesc")
	self._txtDescBottom = self:getTxt("desc")
	self._cellMap = {}

	self:_buildType2Cell()
end

function SixartdaoguanyueextView:_buildType2Cell()
	self._type2CellGo = {}
	self._type2CellGo[SixartdaoguanController.ChallengeType.Music] = self:getGo("cellyue")
	self._type2CellGo[SixartdaoguanController.ChallengeType.Writing] = self:getGo("cellshu")

	for k, v in pairs(self._type2CellGo) do
		goutil.setActive(v, false)
	end
end

function SixartdaoguanyueextView:onExit()
	SixartdaoguanyueextView.super.onExit(self)

	for k, v in pairs(self._cellMap) do
		goutil.destroy(v)
	end

	self._cellMap = {}
end

function SixartdaoguanyueextView:onEnter()
	SixartdaoguanyueextView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._challengeId = self._fmtMo._challengeId
	self._activityId = self._fmtMo._activityId
	self._stageId = self._fmtMo._stageId

	self:_updateUI()
end

function SixartdaoguanyueextView:_buildCells()
	local cellGo = self._type2CellGo[self._fmtMo._challengeId]

	for i = 1, 9 do
		if not self._cellMap[i] then
			local cell = goutil.cloneAndSetParent(cellGo, self._rootTr)

			goutil.setActive(cell, true)

			self._cellMap[i] = cell
		end
	end

	self._recordPos:LoadPlan(0)
end

function SixartdaoguanyueextView:_updateUI()
	self:_buildCells()
	self:_updatePosTag()
	self:_updateDesc()
end

function SixartdaoguanyueextView:_updatePosTag()
	local stageCfg = SixartdaoguanConfig.instance:getStageCfg(self._activityId, self._challengeId, self._stageId)
	local creepsCfgs = SixartdaoguanConfig.instance:getCreepsCfgs(stageCfg.creepsMasterId)

	for k, v in pairs(self._cellMap) do
		GameUtil.SetActive(v, false)
	end

	for i, v in ipairs(creepsCfgs) do
		local posId = v.posId
		local go = self._cellMap[posId]

		if go then
			if self._challengeId == SixartdaoguanController.ChallengeType.Music then
				self:_updateMusicCell(go, v.paramStr)
			elseif self._challengeId == SixartdaoguanController.ChallengeType.Writing then
				self:_updateWritingCell(go, v.paramStr)
			end
		end
	end
end

function SixartdaoguanyueextView:_updateDesc()
	local isShowDesc = true
	local destStr = ""
	local stageCfg = SixartdaoguanConfig.instance:getStageCfg(self._activityId, self._challengeId, self._stageId)

	if self._challengeId == SixartdaoguanController.ChallengeType.Numbers then
		destStr = stageCfg.shuParamStr
	elseif self._challengeId == SixartdaoguanController.ChallengeType.Writing then
		local creepsCfgs = SixartdaoguanConfig.instance:getCreepsCfgs(stageCfg.creepsMasterId)
		local raceId2Word = {}
		local strList = {}

		for i, v in pairs(creepsCfgs) do
			raceId2Word[v.raceId] = v.paramStr
		end

		for i, v in ipairs(stageCfg.killRaceIds) do
			table.insert(strList, raceId2Word[v])
		end

		destStr = string.format("以此顺序击败敌阵精灵：%s", table.concat(strList, ""))
	else
		isShowDesc = false
	end

	self._txtDescBottom.text = destStr
	self._txtDesc.text = destStr

	goutil.setActive(self._descGo, isShowDesc)
end

function SixartdaoguanyueextView:_updateMusicCell(go, paramStr)
	if not string.nilorempty(paramStr) then
		GameUtil.SetActive(go, true)

		local txtNum = goutil.findChildTextComponent(go, "root/txtNum")

		txtNum.text = paramStr
	end
end

function SixartdaoguanyueextView:_updateWritingCell(go, paramStr)
	if not string.nilorempty(paramStr) then
		GameUtil.SetActive(go, true)

		local txtNum = goutil.findChildTextComponent(go, "root/txtNum")

		txtNum.text = paramStr
	end
end

return SixartdaoguanyueextView
