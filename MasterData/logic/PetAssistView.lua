-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/view/PetAssistView.lua

module("logic.extensions.petassist.view.PetAssistView", package.seeall)

local PetAssistView = class("PetAssistView", ViewComponent)

function PetAssistView:ctor()
	PetAssistView.super.ctor(self)

	self.itemGoList = nil
	self.allEffList = nil
end

function PetAssistView:buildUI()
	PetAssistView.super.buildUI(self)

	self.viewCloseBtn = self:getBtn("viewCloseBtn")
	self.tipsBtn = self:getBtn("tipsBtn")
	self.powerTxt = self:getGo("powerShowGo/powerTxt"):GetComponent(ComponentType.UIImgNumeralText)
	self._btnOntKey = self:getGo("btnOntKey")
	self._effectCon = self:getGo("effectCon")
	self._btnOntKeyEquip = self:getGo("btnOntKeyEquip")
	self._oneKeyPointRedGo = self:getGo("btnOntKeyEquip/pointRedGo")

	local middleInfoTran = self:getGo("middleInfoTran").transform

	self.itemGoList = {}

	for i = 1, middleInfoTran.childCount do
		local go = middleInfoTran:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")
		local index = tonumber(names[2])

		self.itemGoList[index] = {}
		self.itemGoList[index].itemGo = go
		self.itemGoList[index].nameTxt = goutil.findChildTextComponent(go, "nameTxt")
		self.itemGoList[index].pointRedGo = goutil.findChild(go, "pointRedGo")
		self.itemGoList[index].levelTxt = goutil.findChildTextComponent(go, "levelTxt")
		self.itemGoList[index].nameTxt.text = ""
		self.itemGoList[index].levelTxt.text = ""

		self.itemGoList[index].pointRedGo:SetActive(false)
		GameUtil.asBtn(go):AddClickListener(function()
			UIStateManager.instance:push(ViewName.PetTeams, index)
		end, self)
	end
end

function PetAssistView:bindEvents()
	PetAssistView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.tipsBtn:AddClickListener(function()
		UIStateManager.instance:open(ViewName.RulesView, "petassist")
	end, self)
	GameUtil.addClickHandler(self._btnOntKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnOntKeyEquip, self._onClickOneKeyEquip, self)
end

function PetAssistView:unbindEvents()
	PetAssistView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.tipsBtn:RemoveClickListener()

	for _, item in pairs(self.itemGoList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end

	GameUtil.rmClickHandler(self._btnOntKey)
	GameUtil.rmClickHandler(self._btnOntKeyEquip)
end

function PetAssistView:onExit()
	PetAssistView.super.onExit(self)
end

function PetAssistView:destroyUI()
	PetAssistView.super.destroyUI(self)

	self.itemGoList = nil

	for _, eff in pairs(self.allEffList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self.allEffList = nil

	if self.qifenEff1 then
		UIEffectManager.instance:stopEffect(self.qifenEff1)

		self.qifenEff1 = nil
	end

	if self.qifenEff2 then
		UIEffectManager.instance:stopEffect(self.qifenEff2)

		self.qifenEff2 = nil
	end
end

function PetAssistView:onEnter()
	PetAssistView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AssistOneClickUpgradeTeamRes, self._PM_AssistOneClickUpgradeTeamRes, self)
	self.addGEvent(self, GlobalNotify.PM_AssistOneClickDeployRes, self._PM_AssistOneClickDeployRes, self)

	self.allEffList = {}

	self:_refreshTeamInfo()

	local effPath = "fx_ui_jinglingzhuzhen/%s.prefab"

	self.qifenEff1 = UIEffectManager.instance:playEffect(self, string.format(effPath, "fx_ui_jinglingzhuzhen_fenwei"), self._effectCon, 0, 0, true, nil, nil, nil, self)

	self.qifenEff1:setParent(self._effectCon.transform)
	self.qifenEff1:setLocalPos(0, 0, 0)
	self.qifenEff1:setScale(1)

	self.qifenEff2 = UIEffectManager.instance:playEffect(self, string.format(effPath, "fx_ui_jinglingzhuzhen_zhongxin"), self._effectCon, 0, 0, true, nil, nil, nil, self)

	self.qifenEff2:setParent(self._effectCon.transform)
	self.qifenEff2:setLocalPos(48, -34, 0)
	self.qifenEff2:setScale(1)
end

function PetAssistView:_refreshTeamInfo()
	local effPathList = {
		"fx_ui_jinglingzhuzhen_cao",
		"fx_ui_jinglingzhuzhen_shui",
		"fx_ui_jinglingzhuzhen_huo",
		"fx_ui_jinglingzhuzhen_guang",
		"fx_ui_jinglingzhuzhen_an",
		"fx_ui_jinglingzhuzhen_kong",
		"fx_ui_jinglingzhuzhen_chuang"
	}
	local teamInfos = PetAssistModel.instance:GetMainAllTeamInfo()
	local effPath = "fx_ui_jinglingzhuzhen/%s.prefab"

	for index, item in pairs(self.itemGoList) do
		if item and item.itemGo and teamInfos[index] then
			item.levelTxt.text = "Lv." .. teamInfos[index].teamLevel

			local isRed = PetAssistModel.instance:IsTeamShowRedpoint(index)

			isRed = isRed or PetAssistModel.instance:IsCanTeamUpgrade(index)

			item.pointRedGo:SetActive(isRed)

			if self.allEffList[index] == nil then
				self.allEffList[index] = UIEffectManager.instance:playEffect(self, string.format(effPath, effPathList[index]), item.itemGo, 0, 0, true, nil, nil, nil, self)

				self.allEffList[index]:setParent(item.itemGo.transform)
				self.allEffList[index]:setLocalPos(0, 0, 0)
				self.allEffList[index]:setScale(1)
			end
		end
	end

	local power = PetAssistModel.instance:GetTotalPowerCount()

	self.powerTxt:SetNum(power)

	local isCanOneKeyEquip = false

	for i = 1, 7 do
		if PetAssistModel.instance:IsTeamShowRedpoint(i) then
			isCanOneKeyEquip = true

			break
		end
	end

	GameUtil.SetActive(self._oneKeyPointRedGo, isCanOneKeyEquip)
end

function PetAssistView:_onClickOneKey()
	AssistAgent.instance:sendPM_AssistOneClickUpgradeTeamReq()
end

function PetAssistView:_onClickOneKeyEquip()
	local canEquip = false

	for i = 1, 7 do
		if PetAssistModel.instance:IsTeamShowRedpoint(i) then
			canEquip = true

			break
		end
	end

	if canEquip then
		AssistAgent.instance:sendPM_AssistOneClickDeployReq()
	end
end

function PetAssistView:_PM_AssistOneClickUpgradeTeamRes(hasChange)
	if hasChange == true then
		self:_refreshTeamInfo()
	else
		FloatWordMgr.instance:show(lang("无可用升级"))
	end
end

function PetAssistView:_PM_AssistOneClickDeployRes()
	self:_refreshTeamInfo()
	FloatWordMgr.instance:show(lang("一键上阵成功"))
end

return PetAssistView
