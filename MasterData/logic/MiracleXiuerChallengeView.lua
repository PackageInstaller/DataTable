-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclexiuer/view/MiracleXiuerChallengeView.lua

module("logic.extensions.miraclexiuer.view.MiracleXiuerChallengeView", package.seeall)

local MiracleXiuerChallengeView = class("MiracleXiuerChallengeView", ViewComponent)

function MiracleXiuerChallengeView:ctor()
	MiracleXiuerChallengeView.super.ctor(self)
end

function MiracleXiuerChallengeView:unbindEvents()
	MiracleXiuerChallengeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._passTip:RemoveClickListener()

	for i = 1, 4 do
		self._mission[i].btn:RemoveClickListener()
	end
end

function MiracleXiuerChallengeView:bindEvents()
	MiracleXiuerChallengeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._passTip:AddClickListener(self._onClickPassTip, self)

	for i = 1, 4 do
		self._mission[i].btn:AddClickListener(function()
			self:_onClickChallenge(i)
		end)
	end
end

function MiracleXiuerChallengeView:buildUI()
	MiracleXiuerChallengeView.super.buildUI(self)

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
end

function MiracleXiuerChallengeView:buildSymbol(path)
	if not GameUtil.isEmptyString(path) then
		local cell = {}

		cell.go = self:getGo("mission/" .. path)
		cell.change = cell.go:GetComponent("UIImageSpriteChange")
		cell.txtStage = goutil.findChildTextComponent(cell.go, "txtState")

		return cell
	end
end

function MiracleXiuerChallengeView:onExit()
	MiracleXiuerChallengeView.super.onExit(self)
	self:_onClickPassTip()

	for i = 1, 4 do
		for k = 1, 9 do
			MaterialMgr.resetAll(self._mission[i].formation[k])
		end
	end

	local mo = CynthiaModel.instance:getActMo(self._challengeId)

	mo.isPassLastTier = false
end

function MiracleXiuerChallengeView:onEnter()
	MiracleXiuerChallengeView.super.onEnter(self)

	self._challengeId = checknumber(self:getFirstParam())

	self:_onClickPassTip()
	self:_refreshView()
end

function MiracleXiuerChallengeView:_onClickPassTip()
	goutil.setActive(self._passTip.gameObject, false)
	removetimer(self._onClickPassTip, self)
end

function MiracleXiuerChallengeView:_onClickChallenge(id)
	if not CynthiaModel.instance:getIsTimeAbleToChallenge(self._challengeId) then
		TipsFacade.instance:openCommonTips(lang("每天早上9点到次日5点开放挑战！"))

		return
	end

	local mo = CynthiaModel.instance:getActMo(self._challengeId)
	local cfg = CynthiaConfig.instance:getStagesCfg(self._challengeId, mo.curTier, id)

	UIStateManager.instance:push(ViewName.CynthiaMissionView, cfg)
end

function MiracleXiuerChallengeView:_refreshView()
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
						::label_11_0::

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

function MiracleXiuerChallengeView:_onClickClose()
	self:close()
	UIStateManager.instance:push(ViewName.MiracleXiuerMainView)
end

return MiracleXiuerChallengeView
