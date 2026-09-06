-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/view/DivineMiZongClgFmtBuffView.lua

module("logic.extensions.divinemizongclg.view.DivineMiZongClgFmtBuffView", package.seeall)

local DivineMiZongClgFmtBuffView = class("DivineMiZongClgFmtBuffView", ViewComponent)

function DivineMiZongClgFmtBuffView:ctor()
	DivineMiZongClgFmtBuffView.super.ctor(self)
end

function DivineMiZongClgFmtBuffView:buildUI()
	DivineMiZongClgFmtBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")

	local buffScrView = self:getGo("infoCol/buffScrView")
	local buffScrCell = self:getGo("infoCol/buffScrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._txtRule = self:getTxt("infoCol/txtRule")
	self._tagEmpty = self:getGo("fmtCol/tagEmpty")
	self._fmtView = self:getGo("fmtCol/fmtView")
	self._fmtCell = self:getGo("fmtCol/fmtCell")

	GameUtil.SetActive(self._fmtCell, false)
end

function DivineMiZongClgFmtBuffView:bindEvents()
	DivineMiZongClgFmtBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DivineMiZongClgFmtBuffView:unbindEvents()
	DivineMiZongClgFmtBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineMiZongClgFmtBuffView:onEnter()
	DivineMiZongClgFmtBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fmtMo = params[1]
	self._activityId = self._fmtMo:getActivityId()
	self._clgMo = DivineMiZongClgController.instance:getClgMo(self._activityId)
	self._centerPetId = self._fmtMo:getCenterPetId()

	self:_onUpdate()
end

function DivineMiZongClgFmtBuffView:onExit()
	DivineMiZongClgFmtBuffView.super.onExit(self)
	self:_onClearFmtColUI()
	self:_onClearBuffColUI()
end

function DivineMiZongClgFmtBuffView:_onUpdate()
	self:_onUpdateBuffColUI()
	self:_onUpdateFmtColUI()
	GameUtil.SetGray(self._btnSure, self._centerPetId <= 0)
end

function DivineMiZongClgFmtBuffView:_onUpdateFmtColUI()
	local formation = self._fmtMo:getCurFormation()
	local centerPosId = formation:GetPetPosition(self._centerPetId) or 0
	local nbrPosIds = DivineMiZongClgEnum.GetNbrPosIds(centerPosId, GameEnum.BattleTeam.Left)
	local childCount = self._fmtView.transform.childCount
	local isHaveSpecialPet = false

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._fmtView.transform:GetChild(posId - 1).gameObject or goutil.cloneAndSetParent(self._fmtCell, self._fmtView.transform, self._fmtCell.name .. posId)

		GameUtil.SetActive(mainGo, true)

		local petId = checknumber(formation:GetPosition(posId))
		local petMo = petId > 0 and formation:_getPet(petId)
		local raceId = petMo and petMo:getDefineId() or 0
		local isCenter = posId == centerPosId
		local isNbr = table.indexof(nbrPosIds, posId) ~= false
		local isSpecialPet = DivineMiZongClgController.instance:isSpecialPet(self._activityId, raceId)

		isHaveSpecialPet = isHaveSpecialPet or isSpecialPet

		local icon = goutil.findChild(mainGo, "mask/icon")
		local tagEmpty = goutil.findChild(mainGo, "mask/tagEmpty")
		local buffTagCenter = goutil.findChild(mainGo, "buffTagCenter")
		local buffTagNbr = goutil.findChild(mainGo, "buffTagNbr")

		GameUtil.SetActive(tagEmpty, not isSpecialPet)
		GameUtil.SetActive(buffTagCenter, isCenter)
		GameUtil.SetActive(buffTagNbr, isNbr)

		if petMo then
			if not petMo.curFaceId then
				local skinId = 0

				if skinId > 0 then
					MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)
				else
					MaterialMgr.clearIcon(icon)
				end

				GameUtil.addClickHandler(mainGo, function()
					if petMo == nil then
						return
					end

					if not isSpecialPet then
						FloatWordMgr.instance:show("非可选承伤位")

						return
					end

					self._centerPetId = self._centerPetId == petId and 0 or petId

					self:_onUpdate()
				end, self)
			end
		end
	end

	GameUtil.SetActive(self._tagEmpty, not isHaveSpecialPet)
end

function DivineMiZongClgFmtBuffView:_onClearFmtColUI()
	local childCount = self._fmtView.transform.childCount

	for idx = 1, childCount do
		local mainGo = self._fmtView.transform:GetChild(idx - 1).gameObject
		local icon = goutil.findChild(mainGo, "mask/icon")

		MaterialMgr.clearIcon(icon)
		GameUtil.rmClickHandler(mainGo)
	end
end

function DivineMiZongClgFmtBuffView:_onUpdateBuffColUI()
	local buffDataList = {}
	local cfgs = DivineMiZongClgConfig.instance:getBuffCfgs(self._activityId) or {}

	for buffType, cfg in ipairs(cfgs) do
		local level = self._clgMo:getBuffLevel(buffType)

		if level > 0 then
			local data = DivineMiZongClgConfig.instance:getBuffData(self._activityId, buffType, level)

			if data then
				table.insert(buffDataList, data)
			end
		end
	end

	self._buffScrollerList:reloadData(buffDataList)
end

function DivineMiZongClgFmtBuffView:_onClearBuffColUI()
	self._buffScrollerList:dispose()
end

function DivineMiZongClgFmtBuffView:_updateBuffCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = data.buffDesc
end

function DivineMiZongClgFmtBuffView:_clearBuffCell(cell)
	return
end

function DivineMiZongClgFmtBuffView:_onClickBtnCancel()
	self:close()
end

function DivineMiZongClgFmtBuffView:_onClickBtnSure()
	if self._centerPetId <= 0 then
		FloatWordMgr.instance:show("未选择承伤位")

		return
	end

	self._centerPetId = self._fmtMo:setCenterPetId(self._centerPetId)

	self:close()
end

return DivineMiZongClgFmtBuffView
