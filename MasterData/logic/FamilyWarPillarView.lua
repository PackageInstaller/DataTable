-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarPillarView.lua

module("logic.extensions.newfamily.view.war.FamilyWarPillarView", package.seeall)

local FamilyWarPillarView = class("FamilyWarPillarView", TableViewComponent)

function FamilyWarPillarView:ctor()
	FamilyWarPillarView.super.ctor(self)

	self._curViewDatas = nil
	self._allTierInfos = nil
	self._sendInfoType = nil
end

function FamilyWarPillarView:bindEvents()
	FamilyWarPillarView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function FamilyWarPillarView:unbindEvents()
	FamilyWarPillarView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FamilyWarPillarView:onExit()
	FamilyWarPillarView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyWarMyPillarInfo, self._updataViewRankShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyPillarFormationInfo, self._openFamilyPillarFormation, self)
	uGuiUtil.clearImage(self._iconGo)

	self._allTierInfos = nil
	self._sendInfoType = nil
end

function FamilyWarPillarView:destroyUI()
	FamilyWarPillarView.super.destroyUI(self)

	self._curViewDatas = nil
end

function FamilyWarPillarView:buildUI()
	FamilyWarPillarView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._iconGo = self:getGo("iconGo")
	self._titleTxt = goutil.findChildTextComponent(self.mainGO, "titleTxt")
end

function FamilyWarPillarView:onEnter()
	FamilyWarPillarView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilyWarMyPillarInfo, self._updataViewRankShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilyPillarFormationInfo, self._openFamilyPillarFormation, self)

	self._curPlanId = checknumber(self:getFirstParam())
	self._allCount = checknumber(FamilyWarConfig.instance:getFamilyWarCommonParam("DIVINE_PILLAR_TIER_NUM"))

	local baseInfo = FamilyWarModel.instance:getFamilyWarBaseInfo()
	local index = 1

	if baseInfo and baseInfo.pillarInfos and #baseInfo.pillarInfos > 1 then
		for i = 1, #baseInfo.pillarInfos do
			if baseInfo.pillarInfos[i] and baseInfo.pillarInfos[i].familyId == checknumber(baseInfo.myFamilyId) then
				index = i

				break
			end
		end
	end

	local cfg = FamilyWarConfig.instance:getFamilyPillarInfoCfgs(index)

	if cfg then
		local path = string.format("ui/bigbg/familynesttower/%s.png", cfg.bigIcon or "board_llzz_10")

		uGuiUtil.setSpriteToImage(self._iconGo, uGuiUtil.SpriteType.BigBg, path)

		if cfg then
			self._titleTxt.text = cfg.name or "神柱之塔"
		end

		self:_updataViewRankShow()
		FamilyWarController.instance:csRequestFamilyBattleGetDivinePillarInfoReq()
	end
end

function FamilyWarPillarView:_updataViewRankShow(tierInfos)
	self._sendInfoType = nil
	self._allTierInfos = tierInfos or {}
	self._curViewDatas = {}

	if #self._allTierInfos >= self._allCount then
		for i = self._allCount, 1, -1 do
			table.insert(self._curViewDatas, self._allTierInfos[i])
		end
	end

	self._tableview:ReloadData()
end

function FamilyWarPillarView:_getPath()
	return {
		cellPath = "rightListGo/rankItem",
		viewPath = "rightListGo/rankListSR"
	}
end

function FamilyWarPillarView:_cellSize()
	return 940, 108
end

function FamilyWarPillarView:_updateCell(view, cell, data)
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local formaBtnGo = goutil.findChild(cell, "formaBtn")
	local replaceBtnGo = goutil.findChild(cell, "replaceBtn")

	GameUtil.asBtn(formaBtnGo):RemoveClickListener()
	GameUtil.asBtn(replaceBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(headGo)

	rankTxt.text = tostring(cell.data)

	if checknumber(data.userId) <= 0 then
		local pillarCfg = FamilyWarConfig.instance:getFamilyPillarLayersCfgs(self._curPlanId, cell.data)

		if pillarCfg then
			nameTxt.text = pillarCfg.name or "守阵怪"
		end

		powerTxt.text = pillarCfg and tostring(pillarCfg.masterZdl) or "10000"

		HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

		if pillarCfg then
			if not pillarCfg.headId then
				local headId = 1

				HeadItemController.instance:setHeadCell(headGo, headId, 1, 0)
				GameUtil.SetActive(formaBtnGo, false)
				GameUtil.SetActive(replaceBtnGo, false)

				return
			end
		end
	end

	GameUtil.SetActive(formaBtnGo, true)
	GameUtil.SetActive(replaceBtnGo, true)

	nameTxt.text = data.headInfo.userName
	powerTxt.text = tostring(data.zdl)

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)
	GameUtil.asBtn(formaBtnGo):AddClickListener(function()
		self._sendInfoType = 1

		FamilyWarController.instance:csRequestFamilyBattleViewDivinePillarTierFormationInfoReq(data.headInfo.userId)
	end, self)
	GameUtil.asBtn(replaceBtnGo):AddClickListener(function()
		self._sendInfoType = 2

		FamilyWarController.instance:csRequestFamilyBattleViewDivinePillarTierFormationInfoReq(data.headInfo.userId)
	end, self)
end

function FamilyWarPillarView:_openFamilyPillarFormation(info)
	self._sendInfoType = checknumber(self._sendInfoType)

	local index = 0

	for i = 1, #self._curViewDatas do
		if self._curViewDatas[i] and self._curViewDatas[i].headInfo.userId == info.targetUserId then
			index = i

			break
		end
	end

	if index <= 0 then
		return
	end

	if self._sendInfoType == 1 then
		UIStateManager.instance:push(ViewName.FamilyPillarFmt, info, self._curViewDatas[index].headInfo.userName)
	elseif self._sendInfoType == 2 then
		UIStateManager.instance:push(ViewName.FamilyWarReplace, {
			userInfo = info,
			tierInfos = self._allTierInfos,
			curTier = index
		})
	end

	self._sendInfoType = nil
end

return FamilyWarPillarView
