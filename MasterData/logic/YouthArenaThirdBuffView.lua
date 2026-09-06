-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdBuffView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdBuffView", package.seeall)

local YouthArenaThirdBuffView = class("YouthArenaThirdBuffView", ViewComponent)

function YouthArenaThirdBuffView:ctor()
	YouthArenaThirdBuffView.super.ctor(self)
end

function YouthArenaThirdBuffView:buildUI()
	YouthArenaThirdBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._buffScrollerList = ScrollerList.create(self:getGo("buffCol/scrView"), self:getGo("buffCol/scrCell"), GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function YouthArenaThirdBuffView:bindEvents()
	YouthArenaThirdBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function YouthArenaThirdBuffView:unbindEvents()
	YouthArenaThirdBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function YouthArenaThirdBuffView:onEnter()
	YouthArenaThirdBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._buffPlanId = checknumber(params[1])

	self:_refreshBuffList()
end

function YouthArenaThirdBuffView:onExit()
	YouthArenaThirdBuffView.super.onExit(self)

	if self._buffScrollerList then
		self._buffScrollerList:dispose()
	end
end

function YouthArenaThirdBuffView:_refreshBuffList()
	local list = YouthArenaThirdConfig.instance:getBuffPlanDatas(self._buffPlanId) or {}

	self._buffScrollerList:reloadData(list)
end

function YouthArenaThirdBuffView:_updateBuffCell(view, cell, data, tag)
	if not cell.gameObject then
		local go = cell
		local item = goutil.findChild(go, "item")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
		local raceId = checknumber(data.raceId)

		MaterialMgr.resetAll(item)

		if raceId > 0 then
			local mat = string.format("%s:%s:1", MatType.Pet, raceId)

			MaterialMgr.setCellByCfg(mat, item)
		end

		txtName.text = self:_getPetName(raceId)
		txtDesc.text = data.desc
	end
end

function YouthArenaThirdBuffView:_clearBuffCell(cell)
	if not cell.gameObject then
		local go = cell
		local item = goutil.findChild(go, "item")

		MaterialMgr.resetAll(item)
	end
end

function YouthArenaThirdBuffView:_getPetName(raceId)
	local cfg = MaterialMgr.getMatCfg(MatType.Pet, raceId)

	return (cfg or nil) and (cfg.name or "")
end

return YouthArenaThirdBuffView
