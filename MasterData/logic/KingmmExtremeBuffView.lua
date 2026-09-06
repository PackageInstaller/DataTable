-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmExtremeBuffView.lua

module("logic.extensions.kingmengmeng.view.KingmmExtremeBuffView", package.seeall)

local KingmmExtremeBuffView = class("KingmmExtremeBuffView", ViewComponent)

function KingmmExtremeBuffView:ctor()
	KingmmExtremeBuffView.super.ctor(self)
end

function KingmmExtremeBuffView:buildUI()
	KingmmExtremeBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._txtDesc = self:getTxt("txtDesc")
	self._cellGo = self:getGo("cell")
	self.scrollerGo = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.scrollerGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function KingmmExtremeBuffView:bindEvents()
	KingmmExtremeBuffView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function KingmmExtremeBuffView:unbindEvents()
	KingmmExtremeBuffView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function KingmmExtremeBuffView:onEnter()
	KingmmExtremeBuffView.super.onEnter(self)

	local param = self:getOpenParam()

	self._activityId = param[1]
	self._challengeType = param[2]
	self._txtTitle.text = KingmmController.instance:getChallengeBuffTitle(self._challengeType)
	self._txtDesc.text = KingmmController.instance:getChallengeBuffDesc(self._challengeType)

	if self._challengeType == KingmmModel.ElementChallenge then
		local var_5_0 = KingmmConfig.instance:getElementCfgList(self._activityId)

		if not var_5_0 then
			var_5_0 = KingmmConfig.instance:getGuardCfgList(self._activityId)

			local list = var_5_0

			self.scrollList:reloadData(list)
		end
	end
end

function KingmmExtremeBuffView:onExit()
	KingmmExtremeBuffView.super.onExit(self)
end

function KingmmExtremeBuffView:_updateCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local getGo = goutil.findChild(cell, "get")
	local txtGet = goutil.findChildTextComponent(cell, "get/txt")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")

	txtName.text = data.buffName
	txtDesc.text = data.buffDesc

	local isPass

	if self._challengeType == KingmmModel.ElementChallenge then
		isPass = KingmmModel.instance:isPassElementStage(data.stageId)
		txtGet.text = "已获得"

		GameUtil.SetGray(icon, not isPass)
	else
		isPass = KingmmModel.instance:isPassGuardStage(data.stageId)
		txtGet.text = "已失效"

		GameUtil.SetGray(icon, isPass)
	end

	local isPassBoss = KingmmModel.instance:isPassBoss()

	goutil.setActive(getGo, isPass)
	goutil.setActive(btn.gameObject, not isPass and not isPassBoss)
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(data.buffIcon))
	btn:AddClickListener(function()
		if not KingmmModel.instance:isPassBoss() then
			UIStateManager.instance:push(ViewName.KingmmLevelView, self._activityId, self._challengeType, data.stageId)
			self:close()
		else
			FloatWordMgr.instance:show("已通关")
		end
	end)
end

function KingmmExtremeBuffView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

return KingmmExtremeBuffView
