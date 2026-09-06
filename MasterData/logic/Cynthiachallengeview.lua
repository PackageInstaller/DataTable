-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/Cynthiachallengeview.lua

module("logic.extensions.timelimitedchallenge.view.Cynthia.Cynthiachallengeview", package.seeall)

local Cynthiachallengeview = class("Cynthiachallengeview", ViewComponent)

function Cynthiachallengeview:unbindEvents()
	Cynthiachallengeview.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._passTip:RemoveClickListener()
	self._btnBuff:RemoveClickListener()

	for i = 1, 4 do
		self._mission[i].btn:RemoveClickListener()
	end
end

function Cynthiachallengeview:bindEvents()
	Cynthiachallengeview.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._passTip:AddClickListener(self._onClickPassTip, self)
	self._btnBuff:AddClickListener(self._onClickUpBuff, self)

	for i = 1, 4 do
		self._mission[i].btn:AddClickListener(function()
			self:_onClickChallenge(i)
		end)
	end
end

function Cynthiachallengeview:onExit()
	Cynthiachallengeview.super.onExit(self)
	self:_onClickPassTip()

	for i = 1, 4 do
		for k = 1, 9 do
			MaterialMgr.resetAll(self._mission[i].formation[k])
		end
	end

	local mo = CynthiaModel.instance:getActMo(self._challengeId)

	mo.isPassLastTier = false

	GlobalDispatcher:removeListener(GlobalNotify.PM_CynthiaGetInfoRes, self._refreshBuff, self)
end

function Cynthiachallengeview:buildUI()
	Cynthiachallengeview.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtProgress = self:getTxt("progress/txtProgress")
	self._mission = {}

	for i = 1, 4 do
		local mission = {}

		mission.go = self:getGo("mission/mission_" .. i)
		mission.txtPetNum = goutil.findChildTextComponent(mission.go, "petNum/txtPetNum")
		mission.btn = GameUtil.asBtn(goutil.findChild(mission.go, "btnChallenge/btn"))
		mission.formation = {}

		for k = 1, 9 do
			mission.formation[k] = goutil.findChild(mission.go, "btnChallenge/formation/cell_" .. k .. "/con")
		end

		mission.pass = goutil.findChild(mission.go, "pass")
		self._mission[i] = mission
	end

	self._symbolL = self:buildSymbol("symbolL")
	self._symbolM = self:buildSymbol("symbolM")
	self._symbolR = self:buildSymbol("symbolR")
	self._passTip = self:getBtn("passTip")
	self._btnBuff = self:getBtn("btnBuff")
	self._txtBuffLv = self:getTxt("btnBuff/txtLv")
	self._redPoint = self:getGo("btnBuff/redPoint")
end

function Cynthiachallengeview:buildSymbol(path)
	if not GameUtil.isEmptyString(path) then
		local cell = {}

		cell.go = self:getGo("mission/" .. path)
		cell.change = cell.go:GetComponent("UIImageSpriteChange")
		cell.txtStage = goutil.findChildTextComponent(cell.go, "txtState")

		return cell
	end
end

function Cynthiachallengeview:onEnter()
	Cynthiachallengeview.super.onEnter(self)

	self._challengeId = checknumber(self:getFirstParam())

	self:_onClickPassTip()
	self:_refreshView()
	self:_refreshBuff()
	GlobalDispatcher:addListener(GlobalNotify.PM_CynthiaGetInfoRes, self._refreshBuff, self)
	GameUtil.doCallbackWhenFirst("CynthiaChallengeView_20210902", function()
		self:_onClickTip()
	end)
	self.addGEvent(self, GlobalNotify.PM_CynthiaBuffUpRes, self._handleUpBuff, self)
end

function Cynthiachallengeview:_onClickTip()
	ViewMgr.instance:open(ViewName.RulesView, "cynthiachallenge1")
end

function Cynthiachallengeview:_onClickPassTip()
	goutil.setActive(self._passTip.gameObject, false)
	removetimer(self._onClickPassTip, self)
end

function Cynthiachallengeview:_onClickChallenge(id)
	if not CynthiaModel.instance:getIsTimeAbleToChallenge(self._challengeId) then
		TipsFacade.instance:openCommonTips(lang("每天早上9点到次日5点开放挑战！"))

		return
	end

	local mo = CynthiaModel.instance:getActMo(self._challengeId)
	local cfg = CynthiaConfig.instance:getStagesCfg(self._challengeId, mo.curTier, id)

	UIStateManager.instance:push(ViewName.CynthiaMissionView, cfg)
end

function Cynthiachallengeview:_refreshView()
	local mo = CynthiaModel.instance:getActMo(self._challengeId)

	if mo.isPassLastTier then
		goutil.setActive(self._passTip.gameObject, true)
		CynthiaModel.instance:resetPassState(mo)
		settimer(5, self._onClickPassTip, self, false)
	end

	for i = 1, 4 do
		for k = 1, 9 do
			MaterialMgr.resetAll(self._mission[i].formation[k])
			goutil.setActive(self._mission[i].formation[k], false)
		end
	end

	local curTier = mo.curTier

	if not mo.stageInfos then
		local curStageInfos = {}
		local alivePetLimit = checkint(CynthiaConfig.instance:getCommonValue(self._challengeId, "passMinAlive"))
		local cfgs = CynthiaConfig.instance:getTierCfgs(self._challengeId)

		self._txtProgress.text = langPara("挑战进度：%s/%s", curTier, #cfgs)

		if not cfgs[curTier] then
			local showCfgs = {}

			for i = 1, 4 do
				if showCfgs[i] then
					local creepId = showCfgs[i].creepsMasterId

					if creepId then
						::label_12_0::

						local creepCfgs = CynthiaConfig.instance:getCreepsCfg(creepId)

						if creepCfgs then
							for _, v in ipairs(creepCfgs) do
								goutil.setActive(self._mission[i].formation[v.posId], true)

								local petStr = string.format("%s:%s:%s:1", MatType.Pet, v.raceId, v.lv)

								MaterialMgr.setCellByCfg(petStr, self._mission[i].formation[v.posId])
							end
						end

						goutil.setActive(self._mission[i].pass, alivePetLimit <= curStageInfos[i].alivePets)

						self._mission[i].txtPetNum.text = langPara("存活精灵：%s只", curStageInfos[i].alivePets)
					end
				end
			end

			if alivePetLimit <= curStageInfos[1].alivePets and alivePetLimit <= curStageInfos[2].alivePets and curStageInfos[1].alivePets > curStageInfos[2].alivePets then
				self._symbolL.change:SetState(0)

				self._symbolL.txtStage.text = lang("已达成")
			else
				self._symbolL.change:SetState(1)

				self._symbolL.txtStage.text = lang("未达成")
			end

			if alivePetLimit <= curStageInfos[2].alivePets and alivePetLimit <= curStageInfos[3].alivePets and curStageInfos[2].alivePets == curStageInfos[3].alivePets then
				self._symbolM.change:SetState(0)

				self._symbolM.txtStage.text = lang("已达成")
			else
				self._symbolM.change:SetState(1)

				self._symbolM.txtStage.text = lang("未达成")
			end

			if alivePetLimit <= curStageInfos[3].alivePets and alivePetLimit <= curStageInfos[4].alivePets and curStageInfos[3].alivePets < curStageInfos[4].alivePets then
				self._symbolR.change:SetState(0)

				self._symbolR.txtStage.text = lang("已达成")
			else
				self._symbolR.change:SetState(1)

				self._symbolR.txtStage.text = lang("未达成")
			end
		end
	end
end

function Cynthiachallengeview:_refreshBuff()
	local mo = CynthiaModel.instance:getActMo(self._challengeId)
	local curLv = mo.buffLv
	local isUpToday = mo.isUpToday

	self._txtBuffLv.text = "LV" .. curLv

	local nextLvCfg = CynthiaConfig.instance:getBuffCfg(self._challengeId, curLv + 1)

	goutil.setActive(self._redPoint, not isUpToday and nextLvCfg)
end

function Cynthiachallengeview:_onClickUpBuff()
	local mo = CynthiaModel.instance:getActMo(self._challengeId)
	local curLv = mo.buffLv
	local isUpToday = mo.isUpToday
	local nextLvCfg = CynthiaConfig.instance:getBuffCfg(self._challengeId, curLv + 1)

	if not nextLvCfg then
		TipsFacade.instance:openCommonTips(langPara("已满级"))

		return
	end

	if not isUpToday then
		CynthiaChallengeAgent.instance:sendPM_CynthiaChallengeUpgradeReq(self._challengeId)
	else
		UIStateManager.instance:push(ViewName.CynthiabuffView, self._challengeId)
	end
end

function Cynthiachallengeview:_handleUpBuff()
	local mo = CynthiaModel.instance:getActMo(self._challengeId)
	local curLv = mo.buffLv

	TipsFacade.instance:openCommonTips(langPara("辛西娅祝福升级至LV%s！", curLv))
	self:_refreshBuff()
end

function Cynthiachallengeview:_onClickClose()
	self:close()
	UIStateManager.instance:push(ViewName.CynthiamainView)
end

return Cynthiachallengeview
