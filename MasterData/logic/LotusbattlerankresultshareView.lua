-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlerankresultshareView.lua

module("logic.extensions.lotusbattle.view.LotusbattlerankresultshareView", package.seeall)

local LotusbattlerankresultshareView = class("LotusbattlerankresultshareView", ViewComponent)

function LotusbattlerankresultshareView:ctor()
	LotusbattlerankresultshareView.super.ctor(self)
end

function LotusbattlerankresultshareView:unbindEvents()
	LotusbattlerankresultshareView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnGoto:RemoveClickListener()
end

function LotusbattlerankresultshareView:bindEvents()
	LotusbattlerankresultshareView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnGoto:AddClickListener(self._onClickbtnGoto, self)
end

function LotusbattlerankresultshareView:buildUI()
	LotusbattlerankresultshareView.super.buildUI(self)

	self._txtKill = self:getTxt("txtKill")
	self._txtScore = self:getTxt("txtScore")
	self._pettableviewGo = self:getGo("pettableview")
	self._bufftablecellGo = self:getGo("bufftablecell")
	self._bufftableviewGo = self:getGo("bufftableview")
	self._pettablecellGo = self:getGo("pettablecell")
	self._btnClose = self:getBtn("btnClose")
	self._btnGoto = self:getBtn("btnGoto")
	self._rankNum = self:getGo("rank/rankNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._imgNum = self:getGo("rank/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._buffscrollerList = ScrollerList.create(self._bufftableviewGo, self._bufftablecellGo, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._petscrollerList = ScrollerList.create(self._pettableviewGo, self._pettablecellGo, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._btnShareGo = self:getGo("btnShare")
	self._effectGo = self:getGo("effect")
	self._imgTitleChange = self:getGo("imgTitle"):GetComponent(ComponentType.UIImageSpriteChange)
	self._playerGo = self:getGo("player")
	self._headGo = self:getGo("player/head")
	self._txtArea = self:getTxt("player/txtArea")
	self._txtName = self:getTxt("player/name/txtName")

	goutil.setActive(self._btnShareGo, false)
end

function LotusbattlerankresultshareView:onExit()
	LotusbattlerankresultshareView.super.onExit(self)
	self._petscrollerList:dispose()
	self._buffscrollerList:dispose()

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	HeadItemController.instance:resetHeadCell(self._headGo)
end

function LotusbattlerankresultshareView:onEnter()
	LotusbattlerankresultshareView.super.onEnter(self)

	self._chatMo = self:getFirstParam()

	self:_updateUI()
	self:_setEffect()
end

function LotusbattlerankresultshareView:_onClickbtnClose()
	self:close()
end

function LotusbattlerankresultshareView:_onClickbtnGoto()
	local str = LotusbattleConfig.instance:getCommonValue("shareJumpTo")

	GotoMgr.gotoByString(str)
end

function LotusbattlerankresultshareView:_updateUI()
	self:_setBuff()
	self:_setPets()
	self:_setRank()
	self:_setHead()
end

function LotusbattlerankresultshareView:_setBuff()
	local str = self._chatMo:getParam("buffIds", false)
	local buffPlanId = self._chatMo:getParam("buffPlanId", true)
	local buffIds = string.split(str, "#") or 1
	local buffCfgs = {}

	for i, buffId in ipairs(buffIds) do
		buffId = checknumber(buffId)

		if buffId > 0 then
			local buffCfg = LotusbattleConfig.instance:getBuffCfg(buffPlanId, buffId)

			table.insert(buffCfgs, buffCfg)
		end
	end

	self._buffscrollerList:reloadData(buffCfgs)
end

function LotusbattlerankresultshareView:_setPets()
	local str = self._chatMo:getParam("creepsIds", false)
	local creepsIds = string.split(str, "#")
	local creepsCfgs = {}
	local temp = self:_getCreepsCfgs(creepsIds)

	table.insertto(creepsCfgs, temp)
	self._petscrollerList:reloadData(creepsCfgs)
end

function LotusbattlerankresultshareView:_updateBuffCell(view, cell, buffCfg, tag)
	local btnIcon = Framework.ButtonAdapter.Get(cell.gameObject)

	uGuiUtil.clearImage(btnIcon.gameObject)

	local spriteName = GameUrl.getExpEventUrl(buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(btnIcon.gameObject, nil, spriteName)
	btnIcon:AddClickListener(function()
		local data = LotusbattleConfig.instance:getBuffTipSimpleData(buffCfg.buffPlanId, buffCfg.buffId)

		CommonTipsMgr.instance:openBuffTipView(data, cell.gameObject)
	end)
end

function LotusbattlerankresultshareView:_clearBuffCell(cell)
	uGuiUtil.clearImage(cell.gameObject)
end

function LotusbattlerankresultshareView:_updatePetCell(view, cell, creepsCfg, tag)
	local petMo = LotusbattleModel.instance:getPetMoByCreepsId(creepsCfg.creepsId)
	local proxy = MaterialMgr.setCellByMo(petMo, cell.gameObject)

	proxy.binder:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(petMo)
	end)
end

function LotusbattlerankresultshareView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function LotusbattlerankresultshareView:_setRank()
	local rank = self._chatMo:getParam("rank")
	local score = self._chatMo:getParam("score")
	local killNum = self._chatMo:getParam("killNum")
	local memberNum = self._chatMo:getParam("memberNum")
	local rankPlanId = self._chatMo:getParam("rankPlanId")

	self._txtKill.text = string.format("淘汰人数：<color=#fdffd1>%s</color>", killNum)
	self._txtScore.text = score

	self._rankNum:SetNum(rank)
	self._imgNum:SetNum(memberNum)

	local title = LotusbattleConfig.instance:getRankTitleImgNameByRank(rankPlanId, rank)

	self._imgTitleChange:ChangeSprite(title)
end

function LotusbattlerankresultshareView:_getCreepsCfgs(creepsIds)
	local list = {}

	for i, creepsId in ipairs(creepsIds) do
		creepsId = checknumber(creepsId)

		local cfg = LotusbattleConfig.instance:getCreepsCfg(creepsId)

		table.insert(list, cfg)
	end

	return list
end

function LotusbattlerankresultshareView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_jiesuanjiemian.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function LotusbattlerankresultshareView:_setHead()
	goutil.setActive(self._playerGo, false)
end

return LotusbattlerankresultshareView
