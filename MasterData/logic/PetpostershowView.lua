-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petposter/view/PetpostershowView.lua

module("logic.extensions.petposter.view.PetpostershowView", package.seeall)

local PetpostershowView = class("PetpostershowView", ViewComponent)

function PetpostershowView:ctor()
	PetpostershowView.super.ctor(self)

	self._showIndex = 1
end

function PetpostershowView:buildUI()
	PetpostershowView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTurnRight = self:getBtn("btnTurnRight")
	self._btnTurnLeft = self:getBtn("btnTurnLeft")
	self._btnGainTeamPrize = self:getBtn("gainPrize/btn")
	self._goBtn = self:getGo("gainPrize/btn")
	self._effPos = self:getGo("gainPrize/conCell/eff")
	self._conCell = self:getGo("gainPrize/conCell")
	self._dot = self:getGo("gainPrize/dot")
	self._mark = self:getGo("gainPrize/mark")
	self._gainPrize = self:getGo("gainPrize")
	self._txtTitle = self:getTxt("txtTitle")
	self._shareBtn = self:getBtn("shareBtn")
	self._red1 = self:getGo("btnTurnRight/red")
	self._red2 = self:getGo("btnTurnLeft/red")
end

function PetpostershowView:bindEvents()
	PetpostershowView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTurnLeft:AddClickListener(function()
		self:_updateViewByTeamId(self._showIndex - 1)
	end, self)
	self._btnTurnRight:AddClickListener(function()
		self:_updateViewByTeamId(self._showIndex + 1)
	end, self)
	self._btnGainTeamPrize:AddClickListener(self._onClickBtnGainTeamPrize, self)
	self._shareBtn:AddClickListener(function()
		ShareController.instance:share(1, {
			self._shareBtn.gameObject
		}, nil, 200320)
	end)
end

function PetpostershowView:unbindEvents()
	PetpostershowView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTurnLeft:RemoveClickListener()
	self._btnTurnRight:RemoveClickListener()
	self._btnGainTeamPrize:RemoveClickListener()
	self._shareBtn:RemoveClickListener()
end

function PetpostershowView:destroyUI()
	PetpostershowView.super.destroyUI(self)
end

function PetpostershowView:onEnter()
	PetpostershowView.super.onEnter(self)
	PetbookModel.instance:setLoginFirst(true)

	local effPath = "fx_ui_tujianshouji/fx_ui_tujianshouji_shan.prefab"

	self._clickEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(self.mainGO.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
	end)
	effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	self._clickPirzeEff = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", self._effPos, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(self._effPos.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		eff:setClipping(self._effPos:GetComponent(goutil.Type_RectTransform))
		self:_updateClickEffState(eff)
	end)

	local curDataList = HandbookModel.instance:getPosterDataList() or {}

	self._dataList = {}

	for _, v in pairs(curDataList) do
		table.insert(self._dataList, v)
	end

	table.sort(self._dataList, function(a, b)
		return a.cfg.teamId < b.cfg.teamId
	end)

	local showTeamId = self:getFirstParam()

	for i = 1, #self._dataList do
		if showTeamId == self._dataList[i].cfg.teamId then
			self._showIndex = i

			break
		end
	end

	local prize = ShareController.instance.activeByTimes(1, goutil.findChild(self._shareBtn.gameObject, "bubble"))

	self._shareProxy = MaterialMgr.setCellByCfg(prize, goutil.findChild(self._shareBtn.gameObject, "bubble/reward"))
	self._showIndex = self._showIndex or 1

	self:_updateViewByTeamId(self._showIndex)
end

function PetpostershowView:onEnterFinished()
	PetpostershowView.super.onEnterFinished(self)
end

function PetpostershowView:onExit()
	PetpostershowView.super.onExit(self)
	MaterialMgr.resetAll(self._conCell)
	UIEffectManager.instance:stopEffect(self._clickEff)
	UIEffectManager.instance:stopEffect(self._clickPirzeEff)
	self:_resetViewRes()

	self._imgResAll = nil
	self._btnAll = nil

	MaterialMgr.resetAll(self._shareProxy)
end

function PetpostershowView:onExitFinished()
	PetpostershowView.super.onExitFinished(self)
end

function PetpostershowView:_updateClickEffState(eff)
	if not self._curShowData then
		eff:setActive(false)

		return
	end

	if #self._curShowData.info.petListHasGain >= #self._curShowData.cfg.needRaceIds and #self._curShowData.info.petListHasGain ~= 0 and not self._curShowData.info.isGainTeamPrize then
		eff:setActive(true)
	else
		eff:setActive(false)
	end
end

function PetpostershowView:_updateViewByTeamId(showIndex)
	self._clickEff:setActive(false)
	self._clickPirzeEff:setActive(false)

	if self._imgResAll then
		self._imgResBefore = {}

		for _, go in ipairs(self._imgResAll) do
			table.insert(self._imgResBefore, go)
		end

		self._imgResAll = {}
	end

	if self._btnAll then
		self._btnBefore = {}

		for _, go in ipairs(self._btnAll) do
			table.insert(self._btnBefore, go)
		end

		self._btnAll = {}
	end

	if showIndex > #self._dataList then
		showIndex = 1
	end

	if showIndex < 1 then
		showIndex = #self._dataList
	end

	self._showIndex = showIndex
	self._curShowData = self._dataList[self._showIndex]
	self._txtTitle.text = self._curShowData.cfg.teamName

	local teamId = self._curShowData.cfg.teamId

	if not self._curShowData.cfg.needRaceIds then
		local petTotal = {}

		if not self._curShowData.info.petListHasGain then
			local petHasGain = {}

			if not self._curShowData.hasCollect then
				local petHasCollect = {}

				MaterialMgr.resetAll(self._conCell)
				MaterialMgr.setCellByCfg(self._curShowData.cfg.prize, self._conCell)

				if #self._curShowData.info.petListHasGain >= #petTotal and #self._curShowData.info.petListHasGain ~= 0 and not self._curShowData.info.isGainTeamPrize then
					self._clickPirzeEff:setActive(true)
				else
					self._clickPirzeEff:setActive(false)
				end

				goutil.setActive(self._gainPrize, not self._curShowData.info.isGainTeamPrize)

				local go = self:getGo("team" .. teamId)

				if go then
					GameUtil.SetActive(go, true)

					local bg = goutil.findChild(go, "bg")
					local con = goutil.findChild(go, "con")
					local top = goutil.findChild(go, "top")

					self:_changeImg(bg, self._curShowData.cfg.posterBg)
					self:_changeImg(top, self._curShowData.cfg.posterLogo)

					for i = 1, #petTotal do
						local petId = petTotal[i]
						local petImg = goutil.findChild(con, "img_" .. petId)

						if petImg then
							local isHasGain = table.indexof(petHasGain, petTotal[i])
							local isHasCollect = table.indexof(petHasCollect, petTotal[i])
							local resId = petId * 100 + teamId
							local resCfg = HandbookConfig.instance:getPetPosterResCfgById(resId)

							if resCfg then
								self:_changeImg(petImg, resCfg.resPath)
							end

							GameUtil.SetGray(petImg, not isHasGain)

							if isHasCollect and not isHasGain then
								self:_dealBtn(petImg, petId, teamId)
							end
						end
					end
				end

				local isShowRed = HandbookModel.instance:getIsPosterShowRedPointWithoutTeamId(teamId)

				goutil.setActive(self._red1, isShowRed)
				goutil.setActive(self._red2, isShowRed)
				self:_resetViewRes()
			end
		end
	end
end

function PetpostershowView:_dealBtn(go, petId, teamId)
	if not go then
		return
	end

	local goBtn = goutil.findChild(go, "btn")

	if goBtn then
		local effPath = "fx_ui_tujianshouji/fx_ui_tujianshouji_tubiao.prefab"

		self._effs = self._effs or {}
		self._effs[go] = UIEffectManager.instance:playEffect(self, effPath, goBtn, 0, 0, true, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(goBtn.transform)
			GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		end)

		GameUtil.rmClickHandler(goBtn)
		GameUtil.addClickHandler(goBtn, function()
			self:_onClickGainPetPrize(go, petId, teamId)
		end, self)

		self._btnAll = self._btnAll or {}

		table.insert(self._btnAll, go)
	end
end

function PetpostershowView:resetBtn(go)
	if not go then
		return
	end

	local goBtn = goutil.findChild(go, "btn")

	if goBtn then
		GameUtil.rmClickHandler(goBtn)

		if self._effs and self._effs[go] then
			UIEffectManager.instance:stopEffect(self._effs[go])

			self._effs[go] = nil
		end
	end
end

function PetpostershowView:_onClickGainPetPrize(go, petId, teamId)
	if table.indexof(self._curShowData.info.petListHasGain, petId) then
		GameUtil.SetGray(go, false)
		self:resetBtn(go)

		return
	end

	PetManualAgent.instance:sendGainPetManualPetPrizeReq(teamId, petId, function(msg)
		local btnGo = goutil.findChild(go, "btn")

		self._clickEff:setActive(false)
		self._clickEff:setParent(btnGo.transform)
		GameUtil.setLocalPos(self._clickEff.effGo.transform, 0, 0, 0)
		self._clickEff:setActive(true)
		HandbookModel.instance:getPosterPetPrize(teamId, petId)

		if #self._curShowData.info.petListHasGain >= #self._curShowData.cfg.needRaceIds then
			self._clickPirzeEff:setActive(true)
		else
			self._clickPirzeEff:setActive(false)
		end

		GameUtil.SetGray(go, false)
		self:resetBtn(go)
	end)
end

function PetpostershowView:_changeImg(go, resStr)
	if not go then
		return
	end

	uGuiUtil.clearImage(go)

	if not string.nilorempty(resStr) then
		uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, GameUrl.getPetPosterBigbgPngUrl(resStr), function()
			go:GetComponent("Image"):SetNativeSize()

			go:GetComponent("Image").raycastTarget = false
		end)

		self._imgResAll = self._imgResAll or {}

		table.insert(self._imgResAll, go)
	end
end

function PetpostershowView:_resetViewRes()
	if self._imgResBefore then
		for _, res in ipairs(self._imgResBefore) do
			if res then
				uGuiUtil.clearImage(res)
			end
		end

		self._imgResBefore = nil
	end

	if self._btnBefore then
		for _, go in ipairs(self._btnBefore) do
			if go then
				self:resetBtn(go)
			end
		end

		self._btnBefore = nil
	end

	if self._teamIdBefore then
		local teamGo = self:getGo("team" .. self._teamIdBefore)

		if teamGo then
			GameUtil.SetActive(teamGo, false)
		end
	end

	self._teamIdBefore = self._curShowData.cfg.teamId
	teamGo = self:getGo("team" .. self._teamIdBefore)

	if teamGo then
		GameUtil.SetActive(teamGo, true)
	end
end

function PetpostershowView:_onClickBtnGainTeamPrize()
	local teamId = self._curShowData.cfg.teamId

	if self._curShowData.info.isGainTeamPrize then
		FloatWordMgr.instance:show(lang("已领取奖励"))
		self._clickPirzeEff:setActive(false)
		goutil.setActive(self._gainPrize, false)

		return
	end

	if #self._curShowData.info.petListHasGain ~= #self._curShowData.hasCollect then
		FloatWordMgr.instance:show(lang("暂未收集齐该团队的精灵"))
		self._clickPirzeEff:setActive(false)

		return
	end

	PetManualAgent.instance:sendGainPetManualTeamPrizeReq(teamId, function(msg)
		self._curShowData.info.isGainTeamPrize = true

		HandbookModel.instance:getPosterTeamPetPrize(teamId)
		self._clickPirzeEff:setActive(false)
		goutil.setActive(self._gainPrize, false)
	end)
end

return PetpostershowView
