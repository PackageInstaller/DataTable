-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/view/DivinewatertianyanprotocolView.lua

module("logic.extensions.divinewatertianyan.view.DivinewatertianyanprotocolView", package.seeall)

local DivinewatertianyanprotocolView = class("DivinewatertianyanprotocolView", ViewComponent)

function DivinewatertianyanprotocolView:ctor()
	DivinewatertianyanprotocolView.super.ctor(self)
end

function DivinewatertianyanprotocolView:unbindEvents()
	DivinewatertianyanprotocolView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnUnlock:RemoveClickListener()
end

function DivinewatertianyanprotocolView:bindEvents()
	DivinewatertianyanprotocolView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnUnlock:AddClickListener(self._onClickbtnUnlock, self)
end

function DivinewatertianyanprotocolView:buildUI()
	DivinewatertianyanprotocolView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnUnlock = self:getBtn("btnUnlock")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._unlockcomGo = self:getGo("unlockcom")
	self._txtHasNum = self:getTxt("unlockcom/txtHasNum")
	self._txtUseNum = self:getTxt("unlockcom/txtUseNum")
	self._txtDesc = self:getTxt("txtDesc")
end

function DivinewatertianyanprotocolView:onExit()
	DivinewatertianyanprotocolView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivinewatertianyanprotocolView:onEnter()
	DivinewatertianyanprotocolView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineWaterTianYanClgUnlockBuffRes, self._onUnlockRes, self)

	self._activityId = self:getFirstParam()
	self._buffCfgs = DivinewatertianyanConfig.instance:getBuffCfgs(self._activityId)

	self._scrollerList:reloadData(self._buffCfgs)
	self:_onClickTabCell(self._buffCfgs[1])
end

function DivinewatertianyanprotocolView:_onClickbtnClose()
	self:close()
end

function DivinewatertianyanprotocolView:_onClickbtnUnlock()
	local buffCfg = DivinewatertianyanConfig.instance:getBuffCfg(self._activityId, self._curBuffId)
	local has = DivinewatertianyanModel.instance:getFireNum(self._activityId)

	if has < buffCfg.costFire then
		FloatWordMgr.instance:show("消耗材料不足")

		return
	end

	DivineWaterTianYanClgAgent.instance:sendPM_DivineWaterTianYanClgUnlockBuffReq(self._activityId, self._curBuffId)
end

function DivinewatertianyanprotocolView:_updateCell(view, cell, data, tag)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local iconGo = goutil.findChild(cell.gameObject, "mask/icon")
	local isUnlock = DivinewatertianyanModel.instance:isBuffUnlock(self._activityId, data.buffId)

	goutil.setActive(goSelect, self._curBuffId == data.buffId)
	btn:AddClickListener(GameUtil.handler(self._onClickTabCell, self, data))
	uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, string.format("%s.png", data.iconRes))
	GameUtil.SetGray(iconGo, not isUnlock)
end

function DivinewatertianyanprotocolView:_onClickTabCell(cfg)
	self._curBuffId = cfg.buffId

	self._scrollerList:refresh()
	self:_updateRight()
end

function DivinewatertianyanprotocolView:_clearCell(cell)
	return
end

function DivinewatertianyanprotocolView:_updateRight()
	local buffCfg = DivinewatertianyanConfig.instance:getBuffCfg(self._activityId, self._curBuffId)
	local isUnlock = DivinewatertianyanModel.instance:isBuffUnlock(self._activityId, self._curBuffId)

	goutil.setActive(self._btnUnlock.gameObject, not isUnlock)
	goutil.setActive(self._unlockcomGo, not isUnlock)

	self._txtDesc.text = buffCfg.desc
	self._txtHasNum.text = DivinewatertianyanModel.instance:getFireNum(self._activityId)
	self._txtUseNum.text = buffCfg.costFire
end

function DivinewatertianyanprotocolView:_onUnlockRes()
	self._scrollerList:refresh()
	self:_updateRight()
end

return DivinewatertianyanprotocolView
