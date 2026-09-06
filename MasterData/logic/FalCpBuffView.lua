-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalCpBuffView.lua

module("logic.extensions.landlords.view.FalCpBuffView", package.seeall)

local FalCpBuffView = class("FalCpBuffView", ViewComponent)

function FalCpBuffView:buildUI()
	FalCpBuffView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._empty = goutil.findChild(self.mainGO, "cpCol/empty")
	self._cpScrollerview = goutil.findChild(self.mainGO, "cpCol/cpScrollerview")
	self._cpScrollercell = goutil.findChild(self.mainGO, "cpCol/cpScrollercell")
	self._cpScrollList = ScrollerList.create(self._cpScrollerview, self._cpScrollercell, GameUtil.handler(self._updateCpCell, self), GameUtil.handler(self._clearCpCell, self))
end

function FalCpBuffView:bindEvents()
	FalCpBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FalCpBuffView:unbindEvents()
	FalCpBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FalCpBuffView:onEnter()
	FalCpBuffView.super.onEnter(self)

	self._activityId = FightAgainstLandlordsController.instance:getActivityId()

	self:_onUpdateCpColUI()
end

function FalCpBuffView:onExit()
	FalCpBuffView.super.onExit(self)
	self:_onClearCpColUI()
end

function FalCpBuffView:_onUpdateCpColUI()
	local cpCfg = FightAgainstLandlordsConfig.instance:getFalCpCfg(self._activityId)

	self._cpScrollList:reloadData(cpCfg)
	GameUtil.SetActive(self._empty, #cpCfg == 0)
end

function FalCpBuffView:_onClearCpColUI()
	self._cpScrollList:dispose()
end

function FalCpBuffView:_updateCpCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local imgAixin = goutil.findChild(mainGo, "aixin/img")
	local pet_1 = goutil.findChild(mainGo, "pet/pet_1")
	local pet_2 = goutil.findChild(mainGo, "pet/pet_2")
	local txtTip = goutil.findChildTextComponent(mainGo, "txtTip")
	local buffTips = ""

	for idx, buffId in ipairs(data.buffIds) do
		buffData = FightAgainstLandlordsConfig.instance:getFalBuffData(self._activityId, buffId)
		buffTips = idx < #data.buffIds and buffTips .. buffData.desc .. "\n" or buffTips .. buffData.desc
	end

	txtTip.text = buffTips

	for idx, go in ipairs({
		pet_1,
		pet_2
	}) do
		local creepsId = checknumber(data.creepsIds[idx])

		if creepsId > 0 then
			local petMo = FightAgainstLandlordsModel.instance:getPetMoAsFal(creepsId)

			if petMo then
				local skinId = petMo.curFaceId
				local proxy = MaterialMgr.setCell(MatType.Pet, skinId, go)

				if proxy then
					proxy.binder:setClickCallBack(function()
						CommonTipsMgr.instance:showPetTips(petMo)
					end)
				end
			else
				MaterialMgr.resetAll(go)
			end
		else
			MaterialMgr.resetAll(go)
		end
	end

	local comp = imgAixin:GetComponent("Image")

	if comp then
		comp.color = FightAgainstLandlordsController.instance:getColorByCpId(self._activityId, data.cpId)
	end
end

function FalCpBuffView:_clearCpCell(cell)
	local mainGo = cell.gameObject
	local pet_1 = goutil.findChild(mainGo, "pet/pet_1")
	local pet_2 = goutil.findChild(mainGo, "pet/pet_2")

	for idx, go in ipairs({
		pet_1,
		pet_2
	}) do
		MaterialMgr.resetAll(go)
	end
end

return FalCpBuffView
