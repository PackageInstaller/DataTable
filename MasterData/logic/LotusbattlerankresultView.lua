-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlerankresultView.lua

module("logic.extensions.lotusbattle.view.LotusbattlerankresultView", package.seeall)

local LotusbattlerankresultView = class("LotusbattlerankresultView", ViewComponent)

function LotusbattlerankresultView:ctor()
	LotusbattlerankresultView.super.ctor(self)
end

function LotusbattlerankresultView:unbindEvents()
	LotusbattlerankresultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnShare:RemoveClickListener()
end

function LotusbattlerankresultView:bindEvents()
	LotusbattlerankresultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnShare:AddClickListener(self._onClickbtnShare, self)
end

function LotusbattlerankresultView:buildUI()
	LotusbattlerankresultView.super.buildUI(self)

	self._txtKill = self:getTxt("txtKill")
	self._txtScore = self:getTxt("txtScore")
	self._pettableviewGo = self:getGo("pettableview")
	self._bufftablecellGo = self:getGo("bufftablecell")
	self._bufftableviewGo = self:getGo("bufftableview")
	self._pettablecellGo = self:getGo("pettablecell")
	self._btnClose = self:getBtn("btnClose")
	self._btnShare = self:getBtn("btnShare")
	self._rankNum = self:getGo("rank/rankNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._imgNum = self:getGo("rank/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._buffscrollerList = ScrollerList.create(self._bufftableviewGo, self._bufftablecellGo, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._petscrollerList = ScrollerList.create(self._pettableviewGo, self._pettablecellGo, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._headGo = self:getGo("player/head")
	self._txtArea = self:getTxt("player/txtArea")
	self._txtName = self:getTxt("player/name/txtName")
	self._btnGotoGo = self:getGo("btnGoto")
	self._effectGo = self:getGo("effect")
	self._imgTitleChange = self:getGo("imgTitle"):GetComponent(ComponentType.UIImageSpriteChange)

	goutil.setActive(self._btnGotoGo, false)
end

function LotusbattlerankresultView:onExit()
	LotusbattlerankresultView.super.onExit(self)
	self._petscrollerList:dispose()
	self._buffscrollerList:dispose()

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	HeadItemController.instance:resetHeadCell(self._headGo)
	LotusbattleController.instance:resetData()
end

function LotusbattlerankresultView:onEnter()
	LotusbattlerankresultView.super.onEnter(self)

	self._activityId = LotusbattleModel.instance:getActivityId()
	self._modelId = LotusbattleModel.instance:getTopWinModelId()
	self._modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, self._modelId)

	self:_updateUI()
	self:_setEffect()
end

function LotusbattlerankresultView:_onClickbtnClose()
	LotusbattleController.instance:resetData()

	if not SceneMgr.instance.isGogingToEnterBattleScene then
		UIStateManager.instance:clear(true)
		LotusbattleController.instance:openView()
	else
		BattleFacade.instance:endBattle()
	end
end

function LotusbattlerankresultView:_realClose()
	return
end

function LotusbattlerankresultView:_onClickbtnShare()
	local shareData = {
		rank = LotusbattleModel.instance:getTopWinRank(),
		memberNum = self._modelCfg.memberNum,
		creepsIds = table.concat(LotusbattleModel.instance:getTopWinCreepsIds(), "#"),
		buffIds = table.concat(LotusbattleModel.instance:getTopWinBuffIds(), "#"),
		score = LotusbattleModel.instance:getTopWinScore(),
		killNum = LotusbattleModel.instance:getTopWinKillNum(),
		buffPlanId = self._modelCfg.buffPlanId,
		rankPlanId = self._modelCfg.rankPlanId
	}

	UIStateManager.instance:open(ViewName.Share, GameEnum.ShareType.LotusBattle, shareData)
end

function LotusbattlerankresultView:_updateUI()
	self:_setBuff()
	self:_setPets()
	self:_setRank()
	self:_setMyHead()
end

function LotusbattlerankresultView:_setBuff()
	local buffIds = LotusbattleModel.instance:getTopWinBuffIds()
	local buffCfgs = {}

	for i, buffId in ipairs(buffIds) do
		local buffCfg = LotusbattleConfig.instance:getBuffCfg(self._modelCfg.buffPlanId, buffId)

		table.insert(buffCfgs, buffCfg)
	end

	self._buffscrollerList:reloadData(buffCfgs)
end

function LotusbattlerankresultView:_setPets()
	local creepsIds = LotusbattleModel.instance:getTopWinCreepsIds()
	local bagCreepIds = LotusbattleModel.instance:getTopWinPackageCreepsIds()
	local creepsCfgs = {}
	local temp = self:_getCreepsCfgs(creepsIds)

	table.insertto(creepsCfgs, temp)

	local temp = self:_getCreepsCfgs(bagCreepIds)

	table.insertto(creepsCfgs, temp)
	self._petscrollerList:reloadData(creepsCfgs)
end

function LotusbattlerankresultView:_updateBuffCell(view, cell, buffCfg, tag)
	local btnIcon = Framework.ButtonAdapter.Get(cell.gameObject)

	uGuiUtil.clearImage(btnIcon.gameObject)

	local spriteName = GameUrl.getExpEventUrl(buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(btnIcon.gameObject, nil, spriteName)
	btnIcon:AddClickListener(function()
		local data = LotusbattleConfig.instance:getBuffTipSimpleData(buffCfg.buffPlanId, buffCfg.buffId)

		CommonTipsMgr.instance:openBuffTipView(data, cell.gameObject)
	end)
end

function LotusbattlerankresultView:_clearBuffCell(cell)
	uGuiUtil.clearImage(cell.gameObject)
end

function LotusbattlerankresultView:_updatePetCell(view, cell, creepsCfg, tag)
	local petMo = LotusbattleModel.instance:getPetMoByCreepsId(creepsCfg.creepsId)
	local proxy = MaterialMgr.setCellByMo(petMo, cell.gameObject)

	proxy.binder:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(petMo)
	end)
end

function LotusbattlerankresultView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function LotusbattlerankresultView:_setRank()
	local rank = LotusbattleModel.instance:getTopWinRank()
	local score = LotusbattleModel.instance:getTopWinScore()
	local killNum = LotusbattleModel.instance:getTopWinKillNum()
	local memberNum = self._modelCfg.memberNum

	self._txtKill.text = string.format("淘汰人数：<color=#fdffd1>%s</color>", killNum)
	self._txtScore.text = score

	self._rankNum:SetNum(rank)
	self._imgNum:SetNum(memberNum)

	local title = LotusbattleConfig.instance:getRankTitleImgNameByRank(self._modelCfg.rankPlanId, rank)

	self._imgTitleChange:ChangeSprite(title)
end

function LotusbattlerankresultView:_getCreepsCfgs(creepsIds)
	local list = {}

	for i, creepsId in ipairs(creepsIds) do
		local cfg = LotusbattleConfig.instance:getCreepsCfg(creepsId)

		table.insert(list, cfg)
	end

	return list
end

function LotusbattlerankresultView:_setMyHead()
	HeadItemController.instance:setMyHeadCell(self._headGo)

	self._txtName.text = RoleModel.instance:getUserName()
	self._txtArea.text = RoleModel.instance:getAreaName()
end

function LotusbattlerankresultView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_jiesuanjiemian.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

return LotusbattlerankresultView
