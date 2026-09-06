-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/powersurge/PowerSurgeView.lua

module("logic.extensions.bonus.view.powersurge.PowerSurgeView", package.seeall)

local PowerSurgeView = class("PowerSurgeView", TableViewComponent)

function PowerSurgeView:ctor()
	PowerSurgeView.super.ctor(self)

	self._curViewDatas = nil
end

function PowerSurgeView:bindEvents()
	PowerSurgeView.super.bindEvents(self)
	self._rankBtn:AddClickListener(self._gotoRankView, self)
end

function PowerSurgeView:unbindEvents()
	PowerSurgeView.super.unbindEvents(self)
	self._rankBtn:RemoveClickListener()
end

function PowerSurgeView:onExit()
	PowerSurgeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataPowerSurgeInfo, self._updataViewRankShow, self)
	LightMgr.instance:setUseModelLight(false)
	WaitingView.instance:hide(self)
	removetimer(self._closeWatingView, self)
	self._modelCam.transform:SetParent(self.mainGO.transform)
	GlobalModel.instance:visibleSceneHUDs(true)
	LightMgr.instance:setLightForNormalScene()

	if self._roleAvatar then
		self._roleAvatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._roleAvatar)

		self._roleAvatar = nil
	end
end

function PowerSurgeView:destroyUI()
	PowerSurgeView.super.destroyUI(self)

	self._curViewDatas = nil
end

function PowerSurgeView:_closeWatingView()
	removetimer(self._closeWatingView, self)
	WaitingView.instance:hide(self)
end

function PowerSurgeView:buildUI()
	PowerSurgeView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._modelBG = goutil.findChild(self._modelCam, "viewBgIma")
	self._roleModelGo = goutil.findChild(self._modelCam, "roleModelGo")
	self._rankBtn = self:getBtn("rankBtn")
	self._nameTxt = self:getTxt("nLevelGo/nameGo/nameTxt")
	self._powerTxt = self:getTxt("nLevelGo/nameGo/power/powerTxt")
	self._startZdlTxt = self:getTxt("startZdl")
	self._headGo = self:getGo("nLevelGo/nameGo/headGo")
	self._power = self:getGo("nLevelGo/nameGo/power")
end

function PowerSurgeView:onEnter()
	PowerSurgeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataPowerSurgeInfo, self._updataViewRankShow, self)

	self._actCfg = PowerSurgeConfig.instance:getOpenActivityCfg()

	if self._actCfg == nil then
		self:close()

		return
	end

	LightMgr.instance:setUseModelLight(true)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	WaitingView.instance:show(nil, self)
	settimer(0.3, self._closeWatingView, self, false)
	GlobalModel.instance:visibleSceneHUDs(false)
	self._modelCam.transform:SetParent(nil)
	self:_updataViewRankShow(nil)
	ZdlRampageAgent.instance:sendPM_GetZdlRampageCompetitionReq(self._actCfg.activityId)
end

function PowerSurgeView:_updataViewRankShow(info)
	if info == nil or info.curPrizePlanId == nil then
		return
	end

	local prizeList = PowerSurgeConfig.instance:getPowerSurgePrizeCfgs(info.curPrizePlanId) or {}

	self._curViewDatas = {}

	local myPower = RoleModel.instance:getMaxPower()

	self._startPower = info.startZdl
	self._startZdlTxt.text = "个人初始战力：" .. self._startPower

	for _, cfg in pairs(prizeList or {}) do
		if cfg and not string.nilorempty(cfg.prize) then
			local data = {}

			data.cfg = cfg
			data.sort = 2

			if info.gainPrizeIds and table.indexof(info.gainPrizeIds, cfg.id) then
				data.sort = 3
			elseif info.info and myPower >= cfg.zdl then
				data.sort = 1
			end

			table.insert(self._curViewDatas, data)
		end
	end

	if self._curViewDatas and #self._curViewDatas > 1 then
		table.sort(self._curViewDatas, function(a, b)
			if a.sort == b.sort then
				return a.cfg.id < b.cfg.id
			end

			return a.sort < b.sort
		end)
	end

	self._tableview:ReloadData()

	if info.info == nil then
		return
	end

	self._nameTxt.text = info.info.userName
	self._powerTxt.text = info.info.zdl

	if self._roleAvatar == nil then
		self._roleAvatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)
		self._roleAvatar.useType = AvatarUseType.UI

		self._roleAvatar:setParent(self._roleModelGo.transform)
		self._roleAvatar:setLayer(SceneLayer.UI3D_Value)
		self._roleAvatar:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
	end

	local avatarMo = DressModel.instance:getAvatarMoByGrCosAndMount(info.info.gender, info.info.clothes)

	self._roleAvatar:updateByMo(avatarMo)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._power.transform)
end

function PowerSurgeView:_getPath()
	return {
		cellPath = "cellItem",
		viewPath = "cellListSR"
	}
end

function PowerSurgeView:_cellSize()
	return 664, 114
end

function PowerSurgeView:_updateCell(view, cell, data)
	local openGo = goutil.findChild(cell, "openGo")
	local openTxt = goutil.findChildTextComponent(openGo, "openTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local goodsList = {
		goutil.findChild(cell, "goodsGo_1"),
		goutil.findChild(cell, "goodsGo_2"),
		goutil.findChild(cell, "goodsGo_3"),
		goutil.findChild(cell, "goodsGo_4")
	}
	local finishGo = goutil.findChild(cell, "finishGo")
	local clickBtnGo = goutil.findChild(cell, "clickBtn")
	local clickBtnGrp = clickBtnGo:GetComponent("UIChangeGroup")
	local btnTxt = goutil.findChildTextComponent(clickBtnGo, "btnTxt")

	for _, item in pairs(goodsList) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	GameUtil.asBtn(clickBtnGo):RemoveClickListener()
	GameUtil.SetActive(finishGo, false)

	local isOpen, m, d = self:_isOpenByOpenTime(data.cfg.openTime)

	if isOpen then
		openTxt.text = ""

		GameUtil.SetActive(openGo, false)
		uGuiUtil.setImageGrayState(clickBtnGo, false)
		uGuiUtil.setTextGrayState(btnTxt.gameObject, false)
	else
		GameUtil.SetActive(openGo, true)

		openTxt.text = string.format("%s.%s开启", m, d)

		uGuiUtil.setImageGrayState(clickBtnGo, true)
		uGuiUtil.setTextGrayState(btnTxt.gameObject, true)
	end

	descTxt.text = langPara("个人战力达到 <color=#CF7D0DFF>%s</color>", data.cfg.zdl)

	local prizeListCom = goutil.findChild(cell, "goodlist/Viewport/Content")

	MaterialMgr.resetAll(prizeListCom)

	local list = string.split(data.cfg.prize, "#")
	local proxyList = MaterialMgr.setCellListByCfg(data.cfg.prize, prizeListCom)

	for _, proxy in ipairs(proxyList) do
		proxy.binder:setEffStatus(false)
	end

	GameUtil.setAnchoredPos(prizeListCom, 45, 0)

	if data.sort == 3 then
		GameUtil.SetActive(clickBtnGo, false)
		GameUtil.SetActive(finishGo, true)

		return
	end

	GameUtil.SetActive(clickBtnGo, true)

	if data.sort == 1 and isOpen then
		clickBtnGrp:SetState(1)

		btnTxt.text = "领取"
	else
		clickBtnGrp:SetState(0)

		btnTxt.text = "变强"
	end

	GameUtil.asBtn(clickBtnGo):AddClickListener(function()
		if not isOpen then
			FloatWordMgr.instance:show(string.format("%s.%s开启", m, d))

			return
		end

		if data.sort == 1 then
			ZdlRampageAgent.instance:sendPM_ZdlRampageCompetitionGainPrizeReq(self._actCfg.activityId, data.cfg.id)

			return
		end

		GotoMgr.gotoByString("func#26")
	end, self)
end

function PowerSurgeView:_isOpenByOpenTime(day)
	if checknumber(day) <= 0 then
		return true, nil, nil
	end

	local startTime = GameUtil.string2time(self._actCfg.startTime)
	local tempTime = startTime + day * 86400

	if tempTime <= ServerTime.now() then
		return true, nil, nil
	end

	local tempData = GameUtil.time2date(tempTime)

	return false, tempData.month, tempData.day
end

function PowerSurgeView:_onAvatarLoaded(avatar)
	return
end

function PowerSurgeView:_changePlayerNakeMat(avatar)
	for k, v in pairs(avatar.avatarmo:getOwnNakeParts()) do
		local nakeparts = avatar:getBoneByName(AvatarNakePartTypeName[v])

		if nakeparts then
			local skinedMeshRenderer = nakeparts:GetComponent(ComponentType.SkinnedMeshRenderer)

			if skinedMeshRenderer and skinedMeshRenderer.material then
				skinedMeshRenderer.material:SetFloat("_worldLight", 0)
			end
		end
	end
end

function PowerSurgeView:_changePlayerFaceMat(avatar)
	local faceObje = avatar:getBoneByName(avatar and avatar.avatarmo and avatar.avatarmo.skeleton and avatar.avatarmo.skeleton == 2 and AnimatorHash.maleBlendShapeName or AnimatorHash.femaleBlendShapeName)

	if faceObje then
		local skinedMeshRenderer = faceObje:GetComponent(ComponentType.SkinnedMeshRenderer)

		if skinedMeshRenderer and skinedMeshRenderer.material then
			skinedMeshRenderer.material:SetFloat("_worldLight", 0)
		end
	end
end

function PowerSurgeView:_changePlayerHairMat(avatar)
	if avatar then
		::label_19_0::

		local var_19_0 = avatar.pendantsCtrl

		if avatar.pendantsCtrl then
			local _pendants = avatar.pendantsCtrl._pendants

			if not _pendants then
				return
			end

			local hair = _pendants[AvatarPendantType.Hair]

			if not hair then
				return
			end

			local hairGo = hair:getGameObject()

			if not hairGo then
				return
			end

			local hairGoRender = hairGo:GetComponentsInChildren(ComponentType.SkinnedMeshRenderer)

			if not hairGoRender then
				return
			end

			for i = 0, hairGoRender.Length - 1 do
				if hairGoRender[i] and hairGoRender[i].material then
					hairGoRender[i].material:SetFloat("_worldLight", 0)
				end
			end
		end
	end
end

function PowerSurgeView:_gotoRankView()
	if not self._actCfg then
		return
	end

	local actId = self._actCfg.activityId
	local zoneId = PowerSurgeConfig.instance:getRankZoneId(actId, self._startPower)

	UIStateManager.instance:push(ViewName.PowerSurgeRank, 1, zoneId)
end

return PowerSurgeView
