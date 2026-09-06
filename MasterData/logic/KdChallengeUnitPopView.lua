-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/KdChallengeUnitPopView.lua

module("logic.extensions.kingdragonchallenge.view.KdChallengeUnitPopView", package.seeall)

local KdChallengeUnitPopView = class("KdChallengeUnitPopView", ViewComponent)

function KdChallengeUnitPopView:buildUI()
	KdChallengeUnitPopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
	self._itemCol = goutil.findChild(self.mainGO, "itemCol")
	self._itemView = goutil.findChild(self.mainGO, "itemCol/itemView")
	self._itemCell = goutil.findChild(self.mainGO, "itemCol/itemCell")

	GameUtil.SetActive(self._itemCell, false)
end

function KdChallengeUnitPopView:bindEvents()
	KdChallengeUnitPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function KdChallengeUnitPopView:unbindEvents()
	KdChallengeUnitPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function KdChallengeUnitPopView:onEnter()
	KdChallengeUnitPopView.super.onEnter(self)

	self._challengeId = KdChallengeModel.instance:getCurChallengeId()

	self:_onSetUI()
	self:_onUpdate()
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeResultConfirmRes, self._handleConfirmRes, self)
end

function KdChallengeUnitPopView:onExit()
	KdChallengeUnitPopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeResultConfirmRes, self._handleConfirmRes, self)
	self:_onClearItemCol()
end

function KdChallengeUnitPopView:_handleConfirmRes()
	self:close()
end

function KdChallengeUnitPopView:_onSetUI()
	return
end

function KdChallengeUnitPopView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KdChallengeUnitPopView:_onUpdateData()
	self:_onUpdateItemColData()
end

function KdChallengeUnitPopView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateItemColUI()
end

function KdChallengeUnitPopView:_onUpdatePlaneUI()
	local unitId = KdChallengeModel.instance:getUnitIdAsUnitBattleEnd()
	local unitData = KdChallengeConfig.instance:getKdUnitDataByCId(self._challengeId, unitId)

	self._txtTip.text = string.format("恭喜成功击破%s，当前精灵存活情况如下", (unitData or nil) and (unitData.partName or ""))
end

function KdChallengeUnitPopView:_onUpdateItemColData()
	local infoList = {}
	local customFmtMo = KdChallengeModel.instance:getCustomFmtMoAsKd(GameEnum.KingDragonType.Unit)
	local hpInfoList = KdChallengeModel.instance:getPetHpInfoListAsUnitBattleEnd()

	if customFmtMo and hpInfoList then
		for _, hpInfo in ipairs(hpInfoList) do
			local info = {
				petId = hpInfo.id,
				hpRatio = hpInfo.hpRatio,
				petMo = customFmtMo:getPetMoById(hpInfo.id)
			}

			table.insert(infoList, info)
		end
	end

	self._itemInfoList = infoList
end

function KdChallengeUnitPopView:_onUpdateItemColUI()
	local parentTran = self._itemView.transform
	local children = GameUtil.getChildren(parentTran)

	for index, info in ipairs(self._itemInfoList) do
		if not children[index] then
			local mainGo = goutil.cloneAndSetParent(self._itemCell, parentTran)

			self:_updateItemCell(children[index], info)
		end
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #self._itemInfoList)
	end
end

function KdChallengeUnitPopView:_onClearItemCol()
	local parentTran = self._itemView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in ipairs(children) do
		local item = goutil.findChild(mainGo, "item")

		MaterialMgr.resetAll(item)
	end
end

function KdChallengeUnitPopView:_updateItemCell(mainGo, info)
	local petMo = info.petMo
	local hpRatio = info.hpRatio
	local item = goutil.findChild(mainGo, "item")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")

	mainGo.name = "partCell_" .. petMo.curFaceId

	MaterialMgr.setCell(MatType.Pet, petMo.curFaceId, item)

	local str = ""

	if hpRatio == 0 then
		str = "<color=#FF4300FF>0%</color>"
	else
		local value = hpRatio / 100

		str = string.format("%d", math.max(1, value)) .. "%"
	end

	txtNum.text = str
end

function KdChallengeUnitPopView:_onClickBtnSure()
	KdChallengeController.instance:sendPM_TQKingDragonResultConfirmReq(self._challengeId, GameEnum.KingDragonType.Unit)
end

return KdChallengeUnitPopView
