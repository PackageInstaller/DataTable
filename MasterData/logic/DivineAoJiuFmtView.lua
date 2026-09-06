-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuFmtView.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuFmtView", package.seeall)

local DivineAoJiuFmtView = class("DivineAoJiuFmtView", ViewComponent)

function DivineAoJiuFmtView:ctor()
	DivineAoJiuFmtView.super.ctor(self)
end

function DivineAoJiuFmtView:unbindEvents()
	DivineAoJiuFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnShow, self)

	for i, v in ipairs(self._blockItems) do
		GameUtil.rmClickHandler(v)
	end
end

function DivineAoJiuFmtView:bindEvents()
	DivineAoJiuFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)

	for i, v in ipairs(self._blockItems) do
		GameUtil.addClickHandler(v, self._onClickBlock, self)
	end
end

function DivineAoJiuFmtView:buildUI()
	DivineAoJiuFmtView.super.buildUI(self)

	self._btnShow = self:getGo("btnShow")
	self._txtDesc = self:getTxt("buffTips/txtDesc")
	self._blockItems = {}

	for i = 1, 9 do
		local posGo = self:getGo("blockItems/pos" .. i)

		table.insert(self._blockItems, posGo)
	end
end

function DivineAoJiuFmtView:onExit()
	DivineAoJiuFmtView.super.onExit(self)
end

function DivineAoJiuFmtView:onEnter()
	DivineAoJiuFmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineAoJiuClgSelectBuff, self._onSelectBuff, self)

	self._fmtMo = self:getFirstParam()

	self:_onClickShow()
	self:refreshView()
end

function DivineAoJiuFmtView:refreshView()
	local buffCfg = DivineAoJiuConfig.instance:getBuffCfg(self._fmtMo.activityId, self._fmtMo.selectBuffId)
	local buffTypeName = DivineAoJiuConfig.instance:getBuffName(self._fmtMo.activityId, buffCfg.buffType)

	self._txtDesc.text = langPara("%s：%s", buffTypeName, buffCfg.desc)

	local stageCfg = DivineAoJiuConfig.instance:getExtremeStageCfg(self._fmtMo.activityId, self._fmtMo.stageId)
	local supportPetPosCfgs = DivineAoJiuConfig.instance:getSupportPetPosCfg(stageCfg.systemPetPosPlan)

	for i, v in ipairs(self._blockItems) do
		GameUtil.SetActive(v, false)
	end

	for k, v in pairs(supportPetPosCfgs) do
		GameUtil.SetActive(self._blockItems[v.posId], true)
	end
end

function DivineAoJiuFmtView:_onClickShow()
	UIStateManager.instance:push(ViewName.DivineAoJiuSelectView, self._fmtMo)
end

function DivineAoJiuFmtView:_onSelectBuff(selectBuffId)
	self._fmtMo.selectBuffId = selectBuffId

	self:refreshView()
end

function DivineAoJiuFmtView:_onClickBlock()
	FloatWordMgr.instance:show(lang("不可更改小奥奇的位置哦"))
end

return DivineAoJiuFmtView
