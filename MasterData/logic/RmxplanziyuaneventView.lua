-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanziyuaneventView.lua

module("logic.extensions.richmanxplan.view.RmxplanziyuaneventView", package.seeall)

local RmxplanziyuaneventView = class("RmxplanziyuaneventView", ViewComponent)

function RmxplanziyuaneventView:ctor()
	RmxplanziyuaneventView.super.ctor(self)
end

function RmxplanziyuaneventView:unbindEvents()
	RmxplanziyuaneventView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function RmxplanziyuaneventView:bindEvents()
	RmxplanziyuaneventView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function RmxplanziyuaneventView:buildUI()
	RmxplanziyuaneventView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._itemGo = self:getGo("tablecell/item")
	self._buffGo = self:getGo("tablecell/buff")
	self._buffIconGo = self:getGo("tablecell/buff/ImgIcon")
	self._txtDesc = self:getTxt("txtDesc")
	self._goRole = self:getGo("role")
end

function RmxplanziyuaneventView:onExit()
	RmxplanziyuaneventView.super.onExit(self)
	MaterialMgr.resetAll(self._itemGo)
	uGuiUtil.clearImage(self._buffIconGo)
	uGuiUtil.clearImage(self._goRole)
end

function RmxplanziyuaneventView:onEnter()
	RmxplanziyuaneventView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._event = params[2]
	self._score = RichmanxplanModel.instance:getScore(self._activityId)
	self._params = GameUtil.jsonToTable(self._event.param)

	self:_updateUI()
	self:_setRole()
end

function RmxplanziyuaneventView:_onClickbtnSure()
	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false, self._event.param)
	self:close()
end

function RmxplanziyuaneventView:_updateUI()
	local prizeCfg = RichmanxplanConfig.instance:getPrizeItemCfg(self._activityId, self._event.eventId, self._params.prizeId)
	local isBuff = prizeCfg.type == RichmanxplanController.ShopItemType.Buff
	local isScore = prizeCfg.type == RichmanxplanController.ShopItemType.Score
	local desc = ""

	goutil.setActive(self._buffGo, isBuff or isScore)
	goutil.setActive(self._itemGo, not isBuff and not isScore)

	if prizeCfg.type == RichmanxplanController.ShopItemType.Item then
		local matType, matId, num = MaterialMgr.getMatParams(prizeCfg.param)

		MaterialMgr.setCellByCfg(prizeCfg.param, self._itemGo)

		desc = string.format("%sx%s", MaterialMgr.getMaterialsName(matType, matId), num)
	elseif prizeCfg.type == RichmanxplanController.ShopItemType.Buff then
		local buffCfg = RichmanxplanConfig.instance:getBuffCfg(self._activityId, checknumber(prizeCfg.param))

		uGuiUtil.setSpriteToImage(self._buffIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(buffCfg.iconRes))

		desc = string.format("%sx1", buffCfg.name)
	elseif prizeCfg.type == RichmanxplanController.ShopItemType.Score then
		uGuiUtil.setSpriteToImage(self._buffIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("com_icon_yidiechaopiao"))

		desc = string.format("积分x%s", prizeCfg.param)
	end

	self._txtDesc.text = string.format("你途经一处静谧之地，只见草丛里发着金色的光，你挖开一看，竟然是%s！", desc)
end

function RmxplanziyuaneventView:_setRole()
	local raceId = RichmanxplanConfig.instance:getPrizeEventCfg(self._activityId, self._event.eventId).raceId
	local modelCo = CharacterConfig.instance:getModelCo(raceId)

	uGuiUtil.setSpriteToImage(self._goRole, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

return RmxplanziyuaneventView
