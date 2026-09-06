-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/lookfmt/LookOverFmtBaseView.lua

module("logic.extensions.peaktournament.view.common.lookfmt.LookOverFmtBaseView", package.seeall)

local LookOverFmtBaseView = class("LookOverFmtBaseView", ViewComponent)
local realPos_left = {
	7,
	8,
	9,
	4,
	5,
	6,
	1,
	2,
	3
}
local realPos_right = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9
}

function LookOverFmtBaseView:buildUI()
	LookOverFmtBaseView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnFmt = goutil.findChild(self.mainGO, "btnFmt")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
end

function LookOverFmtBaseView:bindEvents()
	LookOverFmtBaseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
end

function LookOverFmtBaseView:unbindEvents()
	LookOverFmtBaseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnFmt)
end

function LookOverFmtBaseView:onEnter()
	LookOverFmtBaseView.super.onEnter(self)
	self:_onUpdata()
	self:_onUpdateUI()
end

function LookOverFmtBaseView:onExit()
	LookOverFmtBaseView.super.onExit(self)
	self:_onClearUI()
end

function LookOverFmtBaseView:_getFmtCount()
	return 1
end

function LookOverFmtBaseView:_getFmtZdl(fmtIdx)
	return 0
end

function LookOverFmtBaseView:_getFmtName(fmtIdx)
	return "守阵"
end

function LookOverFmtBaseView:_getPetSkinId(fmtIdx, posId)
	return 0
end

function LookOverFmtBaseView:_getPetRaceId(fmtIdx, posId)
	return 0
end

function LookOverFmtBaseView:_getPetLevel(fmtIdx, posId)
	return 0
end

function LookOverFmtBaseView:_getPetAwakenLv(fmtIdx, posId)
	return 0
end

function LookOverFmtBaseView:_isNeedClickShowPetTips()
	return true
end

function LookOverFmtBaseView:_isLeftFmt()
	return true
end

function LookOverFmtBaseView:_onUpdata()
	return
end

function LookOverFmtBaseView:_onUpdateUI()
	self:_onUpdateFmtColUI()
end

function LookOverFmtBaseView:_onClearUI()
	self:_onClearFmtColUI()
end

function LookOverFmtBaseView:_onUpdateFmtColUI()
	local fmtView = goutil.findChild(self.mainGO, "fmtCol/fmtView")
	local fmtCell = goutil.findChild(self.mainGO, "fmtCol/fmtCell")

	GameUtil.SetActive(fmtCell, false)

	local fmtCellGoList = GameUtil.getChildren(fmtView)
	local fmtTotalCount = self:_getFmtCount()

	for fmtIdx = 1, fmtTotalCount do
		local fmtCellGo = fmtCellGoList[fmtIdx]

		if fmtCellGo == nil then
			fmtCellGo = goutil.cloneAndSetParent(fmtCell, fmtView.transform, fmtCell.name)
		end

		local txtFmtZdl = goutil.findChildTextComponent(fmtCellGo, "txtFmtZdl")
		local txtFmtName = goutil.findChildTextComponent(fmtCellGo, "txtFmtName")
		local petView = goutil.findChild(fmtCellGo, "petView")

		txtFmtZdl.text = self:_getFmtZdl(fmtIdx)
		txtFmtName.text = self:_getFmtName(fmtIdx)

		for posId = 1, petView.transform.childCount do
			local petCellGo = petView.transform:GetChild(posId - 1)
			local icon = goutil.findChild(petCellGo, "icon")
			local realPosId = 0

			realPosId = self:_isLeftFmt() and realPos_left[posId] or realPos_right[posId]

			MaterialMgr.resetAll(icon)

			local skinId = self:_getPetSkinId(fmtIdx, realPosId)

			if skinId > 0 then
				local proxy = MaterialMgr.setCell(MatType.Pet, skinId, icon)

				if proxy then
					local func

					if self:_isNeedClickShowPetTips() then
						local raceId = self:_getPetRaceId(fmtIdx, realPosId)
						local level = self:_getPetLevel(fmtIdx, realPosId)
						local awakenLv = self:_getPetAwakenLv(fmtIdx, realPosId)
						local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)

						function func()
							CommonTipsMgr.instance:showPetTips(tmpMo, true)
						end
					end

					proxy.binder:setClickCallBack(func)
				end
			end
		end
	end

	for fmtIdx = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(fmtIdx - 1)

		GameUtil.SetActive(fmtCellGo, fmtIdx <= fmtTotalCount)
	end
end

function LookOverFmtBaseView:_onClearFmtColUI()
	local fmtView = goutil.findChild(self.mainGO, "fmtCol/fmtView")

	for fmtIdx = 1, fmtView.transform.childCount do
		local fmtCellGo = fmtView.transform:GetChild(fmtIdx - 1)
		local petView = goutil.findChild(fmtCellGo, "petView")

		for posId = 1, petView.transform.childCount do
			local petCellGo = petView.transform:GetChild(posId - 1)
			local icon = goutil.findChild(petCellGo, "icon")

			MaterialMgr.resetAll(icon)
		end
	end
end

function LookOverFmtBaseView:_onClickBtnClose()
	self:close()
end

function LookOverFmtBaseView:_onClickBtnSure()
	return
end

function LookOverFmtBaseView:_onClickBtnCancel()
	self:close()
end

function LookOverFmtBaseView:_onClickBtnFmt()
	return
end

return LookOverFmtBaseView
