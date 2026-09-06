-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/TwoFormsBaseView.lua

module("logic.extensions.seniorarena.view.TwoFormsBaseView", package.seeall)

local TwoFormsBaseView = class("TwoFormsBaseView", ViewComponent)

function TwoFormsBaseView:unbindEvents()
	TwoFormsBaseView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function TwoFormsBaseView:bindEvents()
	TwoFormsBaseView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function TwoFormsBaseView:buildUI()
	TwoFormsBaseView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._players = self:getGo("players")
	self._twoForms = self:getGo("twoForms")
end

function TwoFormsBaseView:onExit()
	TwoFormsBaseView.super.onExit(self)

	for _, v in ipairs(self._pointHeads) do
		MaterialMgr.resetAll(v)
	end

	self._pointHeads = nil
end

function TwoFormsBaseView:onEnter()
	TwoFormsBaseView.super.onEnter(self)

	local params = self:getOpenParam()

	self._pointHeads = {}

	GameUtil.updateCells(self._players, {
		params[1],
		params[2]
	}, self._updateOnePlayer, self)
	GameUtil.updateCells(self._twoForms, params[3], self._updateOneForms, self, true)
end

function TwoFormsBaseView:_updateOnePlayer(cell, data)
	local pointHead = goutil.findChild(cell, "pointHead")
	local txtUserName = goutil.findChildTextComponent(cell, "txtUserName")

	if data.isMyInfo then
		HeadItemController.instance:setMyHeadCell(pointHead)

		txtUserName.text = data.userName
	elseif not data.headInfo then
		local headInfo = data.opHeadInfo

		HeadItemController.instance:setHeadCellByInfo(pointHead, headInfo)

		txtUserName.text = headInfo.userName
	end

	table.insert(self._pointHeads, pointHead)
end

function TwoFormsBaseView:_updateOneForms(cell, data)
	local leftForm = goutil.findChild(cell, "leftForm")
	local rightForm = goutil.findChild(cell, "rightForm")

	self._isLeft = true

	self:_updateOneForm(leftForm, data.formId, data.challengePets, data.isChallengerWin, data.challengeZdl)

	self._isLeft = false

	self:_updateOneForm(rightForm, data.formId, data.beChallengePets, not data.isChallengerWin, data.beChallengeZdl)
end

function TwoFormsBaseView:_updateOneForm(cell, formId, petDatas, isWin, power)
	local txtTotalForce = goutil.findChildTextComponent(cell, "txtTotalForce")
	local txtTeam = goutil.findChildTextComponent(cell, "txtTeam")
	local pets = goutil.findChild(cell, "formations")
	local txtWin = goutil.findChild(cell, "txtWin")
	local txtFail = goutil.findChild(cell, "txtFail")

	goutil.setActive(txtWin, isWin)
	goutil.setActive(txtFail, not isWin)

	txtTeam.text = "队伍" .. formId
	txtTotalForce.text = power

	GameUtil.updateCells(pets, petDatas, self._updateOnePet, self)
end

function TwoFormsBaseView:_updateOnePet(cell, data)
	local txtForce = goutil.findChildTextComponent(cell, "force/txtForce")
	local pointPet = goutil.findChild(cell, "pointPet")

	MaterialMgr.resetAll(pointPet)

	txtForce.text = "0"

	if data then
		local proxy = data.petMo and MaterialMgr.setCellByData(MatType.Pet, data.petMo, pointPet) or MaterialMgr.setCell(MatType.Pet, data.raceId, pointPet)

		table.insert(self._pointHeads, pointPet)

		if proxy then
			proxy.binder:setClickCallBack(function()
				if data.petMo then
					CommonTipsMgr.instance:showPetTips(data.petMo)
				else
					CommonTipsMgr.instance:showPetTips(data)
				end
			end)
			proxy.binder:setLvl(data.level)

			local awakenLv = checknumber(data.awakeLevel)

			if awakenLv == 0 then
				awakenLv = checknumber(data.awakenLevel)
			end

			proxy.binder:setStars(awakenLv)
			proxy.binder:setIconDirection(self._isLeft)
		end
	end
end

return TwoFormsBaseView
