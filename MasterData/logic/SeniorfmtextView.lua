-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorfmtextView.lua

module("logic.extensions.seniorarena.view.SeniorfmtextView", package.seeall)

local SeniorfmtextView = class("SeniorfmtextView", ViewComponent)

function SeniorfmtextView:ctor()
	SeniorfmtextView.super.ctor(self)
end

function SeniorfmtextView:unbindEvents()
	SeniorfmtextView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnAllForms)
end

function SeniorfmtextView:bindEvents()
	SeniorfmtextView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnAllForms, self._onClickAllForms, self)
end

function SeniorfmtextView:buildUI()
	SeniorfmtextView.super.buildUI(self)

	self._btnAllForms = self:getGo("btnAllForms")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
end

function SeniorfmtextView:onExit()
	SeniorfmtextView.super.onExit(self)
	removetimer(self._onTickRefreshTime, self)
end

function SeniorfmtextView:onEnter()
	SeniorfmtextView.super.onEnter(self)

	self.customFmtMo = self:getFirstParam()

	self:_onTickRefreshTime()
	settimer(1, self._onTickRefreshTime, self, true)
	self.addGEvent(self, GlobalNotify.SeniorCacheFormsChanged, self._updateMyForms, self)
end

function SeniorfmtextView:_onTickRefreshTime()
	local leftTime = math.ceil(SeniorArenaModel.instance:getNextRefreshTime() - ServerTime.now())

	leftTime = math.max(leftTime, 0)

	if leftTime > 0 then
		local min = math.floor(leftTime / 60)
		local sec = leftTime - min * 60

		self._txtLeftTime.text = string.format("倒计时：%02d：%02d", min, sec)
	else
		FloatWordMgr.instance:show("挑战目标已过期")
		UIStateManager.instance:popByName(ViewName.SeniorAllFormsView)
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
	end
end

function SeniorfmtextView:_updateMyForms(list)
	if self.customFmtMo then
		local oldlist = self.customFmtMo:getChangeIndexList()
		local newList = {}

		for k, v in ipairs(list) do
			table.insert(newList, oldlist[v])
		end

		self.customFmtMo:updateChangeIndexList(newList)
		self.customFmtMo:jumpToTabIndex(self.customFmtMo:getCurFormTab())
	end
end

function SeniorfmtextView:_onClickAllForms()
	local leftPlayerInfo = SeniorArenaController.instance:getMyPlayerInfo()
	local rightPlayerInfo = SeniorArenaController.instance:getCurOpponentInfo()
	local leftFormMos = self:getMyCacheFormMos()
	local rightFormMos = SeniorArenaController.instance:getCurOpponentFormMos()

	UIStateManager.instance:open(ViewName.SeniorAllFormsView, leftPlayerInfo, rightPlayerInfo, leftFormMos, rightFormMos)
end

function SeniorfmtextView:getMyCacheFormMos()
	local formMos = {}

	if self.customFmtMo then
		local list = self.customFmtMo:getChangeIndexList()
		local forms = SeniorArenaModel.instance:getMyAttackFormMos()

		for i, v in ipairs(list) do
			local playerFormMo = PlayerFormMo.New()

			playerFormMo._isMe = true
			playerFormMo._formId = i

			local form = forms[v]

			if form then
				playerFormMo._formId = checknumber(form._formId)
				playerFormMo._curForm = form._curForm
			end

			local fmtMo = self.customFmtMo:_getRealFormation(v)

			if fmtMo then
				playerFormMo._curForm = FormationFacade.createFormPb(nil, fmtMo)
			end

			playerFormMo:_calcuTotalPower()

			formMos[i] = playerFormMo
		end
	end

	return formMos
end

return SeniorfmtextView
