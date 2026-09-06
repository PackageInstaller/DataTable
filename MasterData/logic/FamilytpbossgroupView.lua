-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpbossgroupView.lua

module("logic.extensions.familyteamplay.view.FamilytpbossgroupView", package.seeall)

local FamilytpbossgroupView = class("FamilytpbossgroupView", ViewComponent)

function FamilytpbossgroupView:ctor()
	FamilytpbossgroupView.super.ctor(self)

	self._itemParentList = nil
	self._playItemList = nil
	self._roleModelList = nil
	self._openType = nil
end

function FamilytpbossgroupView:buildUI()
	FamilytpbossgroupView.super.buildUI(self)

	self._bgImaGo = self:getGo("bgIma")
	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._mapImaTran = self:getGo("mapImaTran").transform
	self._itemParentList = {}

	for i = 1, self._mapImaTran.childCount do
		self._itemParentList[i] = self._mapImaTran:GetChild(i - 1).gameObject
	end

	self._playItem = self:getGo("playItem")
	self._leftBtn = self:getBtn("leftBtn")
	self._rightBtn = self:getBtn("rightBtn")
	self._tipsTxt = goutil.findChildTextComponent(self.mainGO, "tipsTxt")
	self._colorEggBtn = self:getBtn("colorEggBtn")
	self._commonBtn = self:getBtn("commonBtn")
	self._seasonBtn = self:getBtn("seasonBtn")
	self._commonGrp = self._commonBtn.gameObject:GetComponent("UIChangeGroup")
	self._seasonGrp = self._seasonBtn.gameObject:GetComponent("UIChangeGroup")
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "descGo/descTxt")

	GameUtil.SetActive(self._playItem, false)
end

function FamilytpbossgroupView:bindEvents()
	FamilytpbossgroupView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		FamilyteamplayModel.instance:setViewOpenTeamPlayType(self._openType)
		self:close()
	end, self)
	self._tipsBtn:AddClickListener(function()
		TipsFacade.instance:openRulesView("familyteamplay2")
	end, self)
	self._leftBtn:AddClickListener(function()
		self:_onClickLeftOrRightBtn(true)
	end, self)
	self._rightBtn:AddClickListener(function()
		self:_onClickLeftOrRightBtn(false)
	end, self)
	self._colorEggBtn:AddClickListener(self._onClickColorEggBtn, self)
	self._commonBtn:AddClickListener(function()
		self:_onClickCommOrSeasBtn(FamilyteamplayController.teamPlayType.Common)
	end, self)
	self._seasonBtn:AddClickListener(function()
		self:_onClickCommOrSeasBtn(FamilyteamplayController.teamPlayType.Season)
	end, self)
end

function FamilytpbossgroupView:unbindEvents()
	FamilytpbossgroupView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
	self._colorEggBtn:RemoveClickListener()
	self._commonBtn:RemoveClickListener()
	self._seasonBtn:RemoveClickListener()

	for _, item in pairs(self._playItemList or {}) do
		if item then
			if item.commItemGo then
				GameUtil.asBtn(item.commItemGo):RemoveClickListener()
			end

			if item.seasItemGo then
				GameUtil.asBtn(item.seasItemGo):RemoveClickListener()
			end
		end
	end
end

function FamilytpbossgroupView:onExit()
	FamilytpbossgroupView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTeamPlayProgressInfo, self._updataGetTeamPlayProgressInfo, self)

	for _, loader in pairs(self._roleModelList or {}) do
		if loader then
			RoleObjectPool.instance:removeRole(loader)
		end
	end

	self._roleModelList = nil

	for _, item in pairs(self._playItemList or {}) do
		if item and item.commPetIconGo then
			MaterialMgr.resetAll(item.commPetIconGo)
		end
	end
end

function FamilytpbossgroupView:destroyUI()
	FamilytpbossgroupView.super.destroyUI(self)
	uGuiUtil.clearImage(self._bgImaGo)
	uGuiUtil.clearImage(self._mapImaTran.gameObject)

	for _, item in pairs(self._playItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._playItemList = nil
	self._itemParentList = nil
end

function FamilytpbossgroupView:onEnter()
	FamilytpbossgroupView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTeamPlayProgressInfo, self._updataGetTeamPlayProgressInfo, self)

	self._openType = FamilyteamplayModel.instance:getViewOpenTeamPlayType()

	if self:getFirstParam() then
		self._openType = self:getFirstParam()
	end

	local index = FamilyModel.instance:getMyRole()

	self._isChief = index == 0 or index == 1
	self._descTxt.text = lang("通关围剿模式后由族长开启")

	self:_initAllPlayItems()
	self:_updataGetTeamPlayProgressInfo(self._openType)
	FamilyteamplayController.instance:csSendGetTeamPlayProgressInfoReq()
end

function FamilytpbossgroupView:_initAllPlayItems()
	self._playItemList = self._playItemList or {}

	for i = 1, #self._itemParentList do
		if self._playItemList[i] == nil or self._playItemList[i].itemGo == nil then
			self._playItemList[i] = {}

			local go = UnityEngine.GameObject.Instantiate(self._playItem, self._itemParentList[i].transform)

			go:SetActive(true)

			self._playItemList[i].itemGo = go
			self._playItemList[i].itemGrp = go:GetComponent("UIChangeGroup")
			self._playItemList[i].commItemGo = goutil.findChild(go, "commItem")
			self._playItemList[i].commPetIconGo = goutil.findChild(go, "commItem/commPetIcon")
			self._playItemList[i].commLockGo = goutil.findChild(go, "commItem/commLockGo")
			self._playItemList[i].seasItemGo = goutil.findChild(go, "seasItem")
			self._playItemList[i].seasPetGo = goutil.findChild(go, "seasItem/petGo")
			self._playItemList[i].seasLockGo = goutil.findChild(go, "seasItem/seasLockGo")
			self._playItemList[i].passedGo = goutil.findChild(go, "passedGo")
			self._playItemList[i].bloodTxt = goutil.findChildTextComponent(go, "bloodTxt")
			self._playItemList[i].levelTxt = goutil.findChildTextComponent(go, "levelGo/levelTxt")
			self._playItemList[i].starTxt = goutil.findChildTextComponent(go, "levelGo/starTxt")
			self._playItemList[i].attrIma = goutil.findChild(go, "levelGo/attrIma")

			Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
		else
			GameUtil.asBtn(self._playItemList[i].commItemGo):RemoveClickListener()
			GameUtil.asBtn(self._playItemList[i].seasItemGo):RemoveClickListener()
			MaterialMgr.resetAll(self._playItemList[i].commPetIconGo)
		end
	end
end

function FamilytpbossgroupView:_updataGetTeamPlayProgressInfo(tpType)
	tpType = tpType or self._openType
	self.roleModelList = self.roleModelList or {}

	self:_onClickCommOrSeasBtn(tpType, true)
end

function FamilytpbossgroupView:_onClickCommOrSeasBtn(tpType, isForce)
	if self._openType == tpType and not isForce then
		return
	end

	local bossCfgs

	self._baseInfo = FamilyteamplayModel.instance:getBaseProgressInfo()

	local info = self._baseInfo.progressInfo[tpType]
	local path = "ui/bigbg/familytpboss/%s.png"
	local isHas = FamilyteamplayModel.instance:isHaveAvailableGames()

	GameUtil.SetActive(self._colorEggBtn, isHas)

	if isHas and checknumber(self._baseInfo.newSmallGameId) > 0 then
		self:_onClickColorEggBtn()
	end

	if tpType == FamilyteamplayController.teamPlayType.Common then
		if checknumber(info.realBossId) <= 0 then
			return
		end

		self._passBossId = info.curBossId
		self._currGroupIndex = 1
		self._bossCfgsByGroup = {}
		self._groupOpenTime = {}
		bossCfgs = FamilyteamplayConfig.instance:getPeriodIdBossCfgs(self._baseInfo.periodId)

		for i, v in ipairs(bossCfgs) do
			self._bossCfgsByGroup[v.group] = self._bossCfgsByGroup[v.group] or {}

			table.insert(self._bossCfgsByGroup[v.group], v)

			if info.realBossId == v.bossId then
				self._currGroupIndex = v.group
			end
		end

		uGuiUtil.setSpriteToImage(self._mapImaTran.gameObject, uGuiUtil.SpriteType.BigBg, string.format(path, "board_jztb_08"))

		path = string.format(path, "jiazu_mw_bg01")
	elseif tpType == FamilyteamplayController.teamPlayType.Season then
		if checknumber(self._baseInfo.curZoneId) <= 0 then
			if self._isChief then
				FamilyteamplayController.instance:csSendGetFamilyZoneInfoReq(self._baseInfo.periodId)
			else
				FloatWordMgr.instance:show("家族尚未报名，请报名后参加！")
			end

			return
		elseif not FamilyteamplayModel.instance:isAllStagePass(FamilyteamplayController.teamPlayType.Common) then
			FloatWordMgr.instance:show("当前已经选择战区，完成围剿模式14关后可进入！")

			return
		end

		if checknumber(info.realBossId) <= 0 then
			return
		end

		self._passBossId = info.curBossId
		self._currGroupIndex = 1
		self._bossCfgsByGroup = {}
		self._groupOpenTime = {}
		bossCfgs = FamilyteamplayConfig.instance:getAllBossSeasonCfgs(self._baseInfo.periodId, self._baseInfo.curZoneId)

		for i, v in ipairs(bossCfgs) do
			self._bossCfgsByGroup[1] = self._bossCfgsByGroup[1] or {}

			table.insert(self._bossCfgsByGroup[1], v)
		end

		local cfg = FamilyteamplayConfig.instance:getBossWarZoneCfg(self._baseInfo.curZoneId)

		uGuiUtil.setSpriteToImage(self._mapImaTran.gameObject, uGuiUtil.SpriteType.BigBg, string.format(path, cfg.typeIcon))

		path = string.format(path, cfg.bgIcon)
	end

	uGuiUtil.setSpriteToImage(self._bgImaGo, uGuiUtil.SpriteType.BigBg, path)

	self._openType = tpType

	if self._openType == FamilyteamplayController.teamPlayType.Common then
		self._seasonGrp:SetState(0)
		self._commonGrp:SetState(1)
	elseif self._openType == FamilyteamplayController.teamPlayType.Season then
		self._commonGrp:SetState(0)
		self._seasonGrp:SetState(1)
	end

	self._MaxGroupIndex = #self._bossCfgsByGroup

	local periodOpenTime = FamilyteamplayConfig.instance:getPeriodOpenTime(self._baseInfo.periodId)

	for i, list in ipairs(self._bossCfgsByGroup) do
		self._groupOpenTime[i] = list[1].relativeOpenDay * 86400 + periodOpenTime
	end

	self:_updataChoiseGroupData()

	if tpType == FamilyteamplayController.teamPlayType.Common then
		self:_preCalNextData()
	else
		self._tipsTxt.text = ""
	end
end

function FamilytpbossgroupView:_onClickLeftOrRightBtn(isLeft)
	if self._baseInfo.periodId <= 0 then
		FloatWordMgr.instance:show("请稍后")

		return
	end

	if isLeft then
		if self._currGroupIndex <= 1 then
			return
		end

		self._currGroupIndex = self._currGroupIndex - 1
	else
		if self._currGroupIndex >= self._MaxGroupIndex then
			return
		end

		local nextGroupIndex = self._currGroupIndex + 1
		local nextGroupOpenTime = self._groupOpenTime[nextGroupIndex]

		if nextGroupOpenTime > ServerTime.nowServerLook() then
			local date = GameUtil.time2date(nextGroupOpenTime)

			FloatWordMgr.instance:show(string.format("下一组开启时间%s年%s月%s日%s时", date.year, date.month, date.day, date.hour))

			return
		end

		self._currGroupIndex = nextGroupIndex
	end

	self:_updataChoiseGroupData()
end

function FamilytpbossgroupView:_setLeftOrRightBtnShow()
	if self._MaxGroupIndex < 2 then
		GameUtil.SetActive(self._leftBtn, false)
		GameUtil.SetActive(self._rightBtn, false)

		return
	end

	GameUtil.SetActive(self._leftBtn, self._currGroupIndex > 1)
	GameUtil.SetActive(self._rightBtn, self._currGroupIndex < self._MaxGroupIndex)
end

function FamilytpbossgroupView:_onClickColorEggBtn()
	if self._baseInfo.periodId <= 0 then
		FloatWordMgr.instance:show("请稍后")

		return
	end

	if not FamilyteamplayModel.instance:isHaveAvailableGames() then
		FloatWordMgr.instance:show("暂无限时彩蛋")
		GameUtil.SetActive(self._colorEggBtn, false)
	else
		UIStateManager.instance:push(ViewName.FamilytpsmallgameView, self._colorEggBtn.gameObject.transform.position)
	end
end

function FamilytpbossgroupView:_updataChoiseGroupData()
	self:_setLeftOrRightBtnShow()

	self._curViewDatas = self._bossCfgsByGroup[self._currGroupIndex]

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		printError("sr---家族围剿2.0优化  FamilytpbossgroupView:_updataChoiseGroupData()     为毛是空的！")

		return
	end

	self._isAllPass = FamilyteamplayModel.instance:isAllStagePass(self._openType)
	self._stateIndex = 0

	if self._openType == FamilyteamplayController.teamPlayType.Season then
		local attr = FamilyteamplayConfig.instance:getBossWarZoneAttribute(self._baseInfo.curZoneId)

		if not string.nilorempty(attr) then
			self._stateIndex = GameEnum.Races[attr]
		end
	end

	for i = 1, #self._curViewDatas do
		if self._playItemList[i] and self._playItemList[i].itemGo then
			self:_updateCell(self._playItemList[i], self._curViewDatas[i])
		end
	end
end

function FamilytpbossgroupView:_updateCell(item, data)
	if item == nil or item.itemGo == nil or data == nil then
		return
	end

	GameUtil.asBtn(item.commItemGo):RemoveClickListener()
	GameUtil.asBtn(item.seasItemGo):RemoveClickListener()
	MaterialMgr.resetAll(item.commPetIconGo)

	local info = self._baseInfo.progressInfo[self._openType]

	if info == nil or info.realBossId == nil then
		return
	end

	item.itemGrp:SetState(self._stateIndex)
	goutil.setActive(item.attrIma, self._openType == FamilyteamplayController.teamPlayType.Season)
	GameUtil.setUIImageSpriteIdx(item.attrIma, math.max(0, self._stateIndex - 1))

	if self._openType == FamilyteamplayController.teamPlayType.Common then
		GameUtil.SetActive(item.seasItemGo, false)
		GameUtil.SetActive(item.commItemGo, true)
		GameUtil.asBtn(item.commItemGo):AddClickListener(function()
			if self._isAllPass then
				FloatWordMgr.instance:show("此关卡已通关！")

				return
			end

			if data.bossId < self._passBossId then
				FloatWordMgr.instance:show("此关卡已通关！")

				return
			end

			if data.bossId > self._passBossId then
				FloatWordMgr.instance:show("此关卡未解锁！")

				return
			end

			FamilyteamplayModel.instance:setViewOpenTeamPlayType(self._openType)
			UIStateManager.instance:push(ViewName.FamilytpmainView, self._openType, self._baseInfo.periodId, self._passBossId)
		end, self)
		goutil.setActive(item.commLockGo, data.bossId > checknumber(info.realBossId))
		MaterialMgr.setIcon(item.commPetIconGo, MatType.Pet, data.raceId)
	elseif self._openType == FamilyteamplayController.teamPlayType.Season then
		GameUtil.SetActive(item.commItemGo, false)
		GameUtil.SetActive(item.seasItemGo, true)
		GameUtil.asBtn(item.seasItemGo):AddClickListener(function()
			if self._isAllPass then
				FloatWordMgr.instance:show("此关卡已通关！")

				return
			end

			if data.bossId < self._passBossId then
				FloatWordMgr.instance:show("此关卡已通关！")

				return
			end

			if data.bossId > self._passBossId then
				FloatWordMgr.instance:show("此关卡未解锁！")

				return
			end

			FamilyteamplayModel.instance:setViewOpenTeamPlayType(self._openType)
			UIStateManager.instance:push(ViewName.FamilytpmainView, self._openType, self._baseInfo.periodId, self._passBossId, self._baseInfo.curZoneId)
		end, self)
		goutil.setActive(item.seasLockGo, data.bossId > checknumber(info.realBossId))

		self.roleModelList[data.raceId] = self:_showSeasonRoleModel(data.raceId, item.seasPetGo)
	end

	if self._isAllPass then
		goutil.setActive(item.passedGo, true)
	else
		goutil.setActive(item.passedGo, data.bossId < self._passBossId)
	end

	item.levelTxt.text = "第" .. data.bossId .. "关"
	item.starTxt.text = data.hardStar

	if not self._isAllPass and data.bossId == checknumber(info.realBossId) and checknumber(info.totalHp) > 0 then
		local hpRatio = checknumber(info.leftHp) / checknumber(info.totalHp)

		if hpRatio <= 0 then
			goutil.setActive(passedGo, true)

			item.bloodTxt.text = ""
		else
			local ratio2 = math.ceil(hpRatio * 100)

			if ratio2 >= 100 and hpRatio < 1 then
				ratio2 = 99
			end

			item.bloodTxt.text = "血量：" .. ratio2 .. "%"
		end
	else
		item.bloodTxt.text = ""
	end
end

function FamilytpbossgroupView:_showSeasonRoleModel(raceId, modelGo, isGray)
	if checknumber(raceId) <= 0 or modelGo == nil then
		return
	end

	local petCfg = CharacterConfig.instance:getPetCo(raceId)

	if petCfg == nil then
		printError("sr---家族围剿  FamilytpbossgroupView:_showSeasonRoleModel()    精灵配置为空 = " .. raceId)

		return
	end

	local loader

	if self._roleModelList and self._roleModelList[raceId] then
		loader = self._roleModelList[raceId]
	end

	local offset = CharactorFacade.instance:getFamilySeasonUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 0.2

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = checknumber(offset[3])
	end

	loader = loader and RoleObjectPool.instance:removeRole(loader)
	loader = RoleObjectPool.instance:addRoleToParent(loader, petCfg.faceIds, modelGo, scale, function(go)
		return
	end, nil, x, y)

	return loader
end

function FamilytpbossgroupView:_preCalNextData()
	if self._MaxGroupIndex <= 1 then
		self._tipsTxt.text = ""

		return
	end

	local realBossId = self._baseInfo.progressInfo[self._openType].realBossId
	local bcfg = FamilyteamplayConfig.instance:getBossCfg(self._baseInfo.periodId, realBossId + 1)

	if not bcfg then
		local otime = FamilyteamplayConfig.instance:getPeriodOpenTime(self._baseInfo.periodId + 1)

		if otime > 0 then
			local date = GameUtil.time2date(otime)

			self._tipsTxt.text = string.format("下一期开启时间%s年%s月%s日%s时", date.year, date.month, date.day, date.hour)
		else
			self._tipsTxt.text = ""
		end
	else
		local nextGroupOpenTime = self._groupOpenTime[(self._currGroupIndex < self._MaxGroupIndex or nil) and self._currGroupIndex + 1]
		local nextGroupLock = nextGroupOpenTime > ServerTime.nowServerLook()

		if nextGroupLock then
			local date = GameUtil.time2date(nextGroupOpenTime)

			self._tipsTxt.text = string.format("下一组开启时间%s年%s月%s日%s时", date.year, date.month, date.day, date.hour)
		else
			self._tipsTxt.text = "关卡已开始"
		end

		GameUtil.SetGray(self._rightBtn, nextGroupLock)
	end
end

return FamilytpbossgroupView
